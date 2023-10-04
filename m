Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3388A7B8D0C
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Oct 2023 21:21:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244996AbjJDTA6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Oct 2023 15:00:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244936AbjJDS7D (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Oct 2023 14:59:03 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E762610C6;
        Wed,  4 Oct 2023 11:55:17 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04C18C433CC;
        Wed,  4 Oct 2023 18:55:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696445717;
        bh=78x5FOKJ4pJ0GRw5ASlWg2VLmVN1uACyyEUJyyEHhFs=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=Ismg/J/W8acoWAloIwD82D6YteudQRf4/7EhDQ4uEWHSKRwD4FipLrvKsh6j3jLMc
         Ycgn3Sd2pdb1/LCLz+2Cqv9DE2eLWZgNklc6j90ZYhLP7zy7t6lvt02CMOSSuJtTcE
         3XKTbix/LUmHjfBbn9NUG/6D2JFcBXk2pPgf0KX0uEs4X4HMgGRnUkF5H8DpN9wIKN
         98mS3ERLgq7XN6LDG8VVtpqZbslfitcjKo/JjzIlRauBm1iBLXPvRTxQ2iEy8zM+aP
         eSszRaUhnanJMRDs7E9koFxiRdvzowWxcoy8vFFg0T8BmP6/gJ2bQ9mYqt2SMNlhOa
         UJZ7niAeAhduQ==
From:   Jeff Layton <jlayton@kernel.org>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 76/89] vboxsf: convert to new timestamp accessors
Date:   Wed,  4 Oct 2023 14:53:01 -0400
Message-ID: <20231004185347.80880-74-jlayton@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231004185347.80880-1-jlayton@kernel.org>
References: <20231004185221.80802-1-jlayton@kernel.org>
 <20231004185347.80880-1-jlayton@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Convert to using the new inode timestamp accessor functions.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/vboxsf/utils.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/fs/vboxsf/utils.c b/fs/vboxsf/utils.c
index 83f20dd15522..72ac9320e6a3 100644
--- a/fs/vboxsf/utils.c
+++ b/fs/vboxsf/utils.c
@@ -126,12 +126,12 @@ int vboxsf_init_inode(struct vboxsf_sbi *sbi, struct inode *inode,
 	do_div(allocated, 512);
 	inode->i_blocks = allocated;
 
-	inode->i_atime = ns_to_timespec64(
-				 info->access_time.ns_relative_to_unix_epoch);
+	inode_set_atime_to_ts(inode,
+			      ns_to_timespec64(info->access_time.ns_relative_to_unix_epoch));
 	inode_set_ctime_to_ts(inode,
 			      ns_to_timespec64(info->change_time.ns_relative_to_unix_epoch));
-	inode->i_mtime = ns_to_timespec64(
-			   info->modification_time.ns_relative_to_unix_epoch);
+	inode_set_mtime_to_ts(inode,
+			      ns_to_timespec64(info->modification_time.ns_relative_to_unix_epoch));
 	return 0;
 }
 
@@ -194,7 +194,7 @@ int vboxsf_inode_revalidate(struct dentry *dentry)
 	struct vboxsf_sbi *sbi;
 	struct vboxsf_inode *sf_i;
 	struct shfl_fsobjinfo info;
-	struct timespec64 prev_mtime;
+	struct timespec64 mtime, prev_mtime;
 	struct inode *inode;
 	int err;
 
@@ -202,7 +202,7 @@ int vboxsf_inode_revalidate(struct dentry *dentry)
 		return -EINVAL;
 
 	inode = d_inode(dentry);
-	prev_mtime = inode->i_mtime;
+	prev_mtime = inode_get_mtime(inode);
 	sf_i = VBOXSF_I(inode);
 	sbi = VBOXSF_SBI(dentry->d_sb);
 	if (!sf_i->force_restat) {
@@ -225,7 +225,8 @@ int vboxsf_inode_revalidate(struct dentry *dentry)
 	 * page-cache for it.  Note this also gets triggered by our own writes,
 	 * this is unavoidable.
 	 */
-	if (timespec64_compare(&inode->i_mtime, &prev_mtime) > 0)
+	mtime = inode_get_mtime(inode);
+	if (timespec64_compare(&mtime, &prev_mtime) > 0)
 		invalidate_inode_pages2(inode->i_mapping);
 
 	return 0;
-- 
2.41.0

