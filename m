Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94D9B4EDD87
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Mar 2022 17:41:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238867AbiCaPhC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 31 Mar 2022 11:37:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238885AbiCaPgH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 31 Mar 2022 11:36:07 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1AA7228D39;
        Thu, 31 Mar 2022 08:32:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 974AEB8217C;
        Thu, 31 Mar 2022 15:32:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5F8BC340ED;
        Thu, 31 Mar 2022 15:32:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648740733;
        bh=ENxOQqURgaLvkWs38x2jQ5s9Wkc8NFtAownD+hFoc7U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ey3B04DKB6bB06WiuJi1iesQ7Kb9aoqmxUYv+fomXKpqota1dcsytbmsy/1T9Mi2j
         vS+ixKypH+tOP1uac5SL6x87A2NRUo7Wam+R9D0MXDHKI1WOgPEzd5gmT5PLg2Rh4i
         t7K/NebC+juTFdoxe3uUxEQyTOPDwNse6y4rFk7paqjn3Kvo+tycRYftxCd5iDe5dW
         GD+lSwGMakMKCZ0JMTRFZ/t5XmU6T3g+aDDC7VP+KAtJreUhBWIIWjmXeXlAeWyqY3
         +m71GlW5brlNd/nZJsUhwUbqtSPTAvTdnLQ8mIcwg/+4cHdfvWQ9FSJ2pHtngyD/rq
         RAOvjDDULnACw==
From:   Jeff Layton <jlayton@kernel.org>
To:     ceph-devel@vger.kernel.org
Cc:     xiubli@redhat.com, idryomov@gmail.com, lhenriques@suse.de,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v12 45/54] ceph: disable fallocate for encrypted inodes
Date:   Thu, 31 Mar 2022 11:31:21 -0400
Message-Id: <20220331153130.41287-46-jlayton@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220331153130.41287-1-jlayton@kernel.org>
References: <20220331153130.41287-1-jlayton@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

...hopefully, just for now.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/ceph/file.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/ceph/file.c b/fs/ceph/file.c
index b3a5333c0a44..d8dfb8de4219 100644
--- a/fs/ceph/file.c
+++ b/fs/ceph/file.c
@@ -2209,6 +2209,9 @@ static long ceph_fallocate(struct file *file, int mode,
 	if (!S_ISREG(inode->i_mode))
 		return -EOPNOTSUPP;
 
+	if (IS_ENCRYPTED(inode))
+		return -EOPNOTSUPP;
+
 	prealloc_cf = ceph_alloc_cap_flush();
 	if (!prealloc_cf)
 		return -ENOMEM;
-- 
2.35.1

