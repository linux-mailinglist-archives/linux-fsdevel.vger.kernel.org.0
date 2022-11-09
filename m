Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AB85623238
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Nov 2022 19:16:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230322AbiKISQ4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Nov 2022 13:16:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230310AbiKISQy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Nov 2022 13:16:54 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79DA7275FC;
        Wed,  9 Nov 2022 10:16:53 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1520E61C30;
        Wed,  9 Nov 2022 18:16:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CE14C433C1;
        Wed,  9 Nov 2022 18:16:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668017812;
        bh=vPHASFAfLPwH3bu1VmaJv+fh3XG0HOIPnnfII6iIUcg=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=ebAl3s8QPwfWtoDdVw/y7g0otH5Qi9LoLmXb3sdaQLzKjZaiUcbf8QhfT6x4slrJC
         kLWvX5bWwFwHpX0i2uewVSEC+7grK1LZCi8/Xi2+C239LjG7L7n0fUpLAVSLUyGGi0
         YVKmTijAxMp+bBQEEvH4QQ4tck84wpHI1FRiOertGj8ujRrwuIvJ4q6DyGA16A4EnT
         mSljCNQ68RIU4XMVfByI9Nn6blmyqaqJ4d9IssUw90dydaFrSfPVVMoq2w7NgePhrd
         r4mIgeM7+spFF2m8Ciay5w1tlbcr539k83Ttpbj2tCm/J4YYUU6ZRZt1C5x9Hwiepc
         zyRkLTcrf3VsQ==
Subject: [PATCH 12/14] xfs: validate COW fork sequence counters during
 buffered writes
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     djwong@kernel.org
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        david@fromorbit.com, hch@infradead.org
Date:   Wed, 09 Nov 2022 10:16:52 -0800
Message-ID: <166801781202.3992140.14867094485108244588.stgit@magnolia>
In-Reply-To: <166801774453.3992140.241667783932550826.stgit@magnolia>
References: <166801774453.3992140.241667783932550826.stgit@magnolia>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Darrick J. Wong <djwong@kernel.org>

In the previous patch, we transformed the iomap revalidation code to use
an explicit context object where data and cow fork sequence counters are
tracked explicitly.  The existing validation function only validated the
data fork sequence counter, so now let's make it validate both.

I /think/ this isn't actually necessary here because we're writing to
the page cache, and the page state does not track or care about cow
status.  However, this question came up when Dave and I were chatting
about this patchset on IRC, so here it is for formal consideration.

Signed-off-by: Darrick J. Wong <djwong@kernel.org>
---
 fs/xfs/xfs_iomap.c |    3 +++
 1 file changed, 3 insertions(+)


diff --git a/fs/xfs/xfs_iomap.c b/fs/xfs/xfs_iomap.c
index c3c23524a3d2..5e746df2c63f 100644
--- a/fs/xfs/xfs_iomap.c
+++ b/fs/xfs/xfs_iomap.c
@@ -1370,6 +1370,9 @@ xfs_buffered_write_iomap_valid(
 
 	if (ibc->data_seq != READ_ONCE(ip->i_df.if_seq))
 		return false;
+	if (ibc->has_cow_seq &&
+	    ibc->cow_seq != READ_ONCE(ip->i_cowfp->if_seq))
+		return false;
 	return true;
 }
 

