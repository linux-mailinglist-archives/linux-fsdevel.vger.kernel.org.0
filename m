Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 694754F4D79
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Apr 2022 03:28:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1581656AbiDEXkU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 5 Apr 2022 19:40:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1573600AbiDETXV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 5 Apr 2022 15:23:21 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C0ED50E37;
        Tue,  5 Apr 2022 12:21:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1E282B81F6B;
        Tue,  5 Apr 2022 19:21:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 215F3C385A3;
        Tue,  5 Apr 2022 19:21:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649186479;
        bh=+2Vkh7etWPpq3ECuOQUyhhfQFepRWAk8lFgAlse9LJs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PYEUv2DlDfZZodloCX6EfAoA5aOT1NjpSCd8by9nr3AoYfa/qqd2jWJy7MvrgisjA
         e0iX+toF52FPTgwjRUm6M08XzAL5//L+htGwTBqeEeu4Tgb8i/GxYV4F+32iftBGnk
         lMLl+5HM7kTcU85qP5jbqIxAmyrefEOiOjfAWWT+/ZW0GKr8lL1SYpbT1Jbr+oRdxN
         6lUvuaR/gDyfZqQLDgk/0HHlrJv/rYF0OhbAsuCywUnIGGh+TU9Koq3zGzXEUJsH8j
         o3eBR8LmDhH4rGh7NRhlRfEmXcN1hzVAsjAXHHNIlmc0akk1cHgZGsWBRAoZA2mOFZ
         NH361eFDpuA9g==
From:   Jeff Layton <jlayton@kernel.org>
To:     idryomov@gmail.com, xiubli@redhat.com
Cc:     ceph-devel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-fscrypt@vger.kernel.org, linux-kernel@vger.kernel.org,
        lhenriques@suse.de
Subject: [PATCH v13 52/59] ceph: don't use special DIO path for encrypted inodes
Date:   Tue,  5 Apr 2022 15:20:23 -0400
Message-Id: <20220405192030.178326-53-jlayton@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220405192030.178326-1-jlayton@kernel.org>
References: <20220405192030.178326-1-jlayton@kernel.org>
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

Eventually I want to merge the synchronous and direct read codepaths,
possibly via new netfs infrastructure. For now, the direct path is not
crypto-enabled, so use the sync read/write paths instead.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/ceph/file.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/ceph/file.c b/fs/ceph/file.c
index f9e775d6cdf0..41b97d32dfcf 100644
--- a/fs/ceph/file.c
+++ b/fs/ceph/file.c
@@ -1709,7 +1709,9 @@ static ssize_t ceph_read_iter(struct kiocb *iocb, struct iov_iter *to)
 		     ceph_cap_string(got));
 
 		if (ci->i_inline_version == CEPH_INLINE_NONE) {
-			if (!retry_op && (iocb->ki_flags & IOCB_DIRECT)) {
+			if (!retry_op &&
+			    (iocb->ki_flags & IOCB_DIRECT) &&
+			    !IS_ENCRYPTED(inode)) {
 				ret = ceph_direct_read_write(iocb, to,
 							     NULL, NULL);
 				if (ret >= 0 && ret < len)
@@ -1935,7 +1937,7 @@ static ssize_t ceph_write_iter(struct kiocb *iocb, struct iov_iter *from)
 
 		/* we might need to revert back to that point */
 		data = *from;
-		if (iocb->ki_flags & IOCB_DIRECT)
+		if ((iocb->ki_flags & IOCB_DIRECT) && !IS_ENCRYPTED(inode))
 			written = ceph_direct_read_write(iocb, &data, snapc,
 							 &prealloc_cf);
 		else
-- 
2.35.1

