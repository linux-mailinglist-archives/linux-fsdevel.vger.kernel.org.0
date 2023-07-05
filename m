Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B642A748D3D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Jul 2023 21:08:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233828AbjGETIp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 Jul 2023 15:08:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234086AbjGETIW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 Jul 2023 15:08:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E65223591;
        Wed,  5 Jul 2023 12:05:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C67A361716;
        Wed,  5 Jul 2023 19:05:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F744C433AB;
        Wed,  5 Jul 2023 19:05:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688583904;
        bh=ifQJh4jOsX9nRxd1w3rU+11KRMag4uZ1uNcUhaA+ULE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FtD0O7vh5P298dVoEO5SI2NfLIiPjUCyawf2QO+XuFPr5YBjUOyi1Sg79Peq9eBZe
         +Gmsr9dM3ouQLawjDc7DjuuOHi1O4w1wgS0uyT/4C17AEiRiXbjCMdRsx+oSH+vmhG
         hsHXswRP60+LI0y+XsFtVAIlB/QBNFjRnQAyM7VHY7ckT3C0zUt4NsVgKVuqmWjd32
         1y7CQzIhZbX9zbJiZn4Lk+1/cBLyXdIPBn80P8m+S3keY+e9IrFsLppiLUmBLMClQA
         GR40UeMDOVxVQ/eW7zgfVoLlO1Uuue4w9VY4DcZwO+oohFQl1FEC65AAHuvqY2n+/d
         Bv5HgackTJ8eA==
From:   Jeff Layton <jlayton@kernel.org>
To:     Christian Brauner <brauner@kernel.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Amir Goldstein <amir73il@gmail.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-unionfs@vger.kernel.org
Subject: [PATCH v2 66/92] overlayfs: convert to ctime accessor functions
Date:   Wed,  5 Jul 2023 15:01:31 -0400
Message-ID: <20230705190309.579783-64-jlayton@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230705190309.579783-1-jlayton@kernel.org>
References: <20230705185755.579053-1-jlayton@kernel.org>
 <20230705190309.579783-1-jlayton@kernel.org>
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

In later patches, we're going to change how the inode's ctime field is
used. Switch to using accessor functions instead of raw accesses of
inode->i_ctime.

Reviewed-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/overlayfs/file.c | 7 +++++--
 fs/overlayfs/util.c | 2 +-
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/fs/overlayfs/file.c b/fs/overlayfs/file.c
index 21245b00722a..7acd3e3fe790 100644
--- a/fs/overlayfs/file.c
+++ b/fs/overlayfs/file.c
@@ -239,6 +239,7 @@ static loff_t ovl_llseek(struct file *file, loff_t offset, int whence)
 static void ovl_file_accessed(struct file *file)
 {
 	struct inode *inode, *upperinode;
+	struct timespec64 ctime, uctime;
 
 	if (file->f_flags & O_NOATIME)
 		return;
@@ -249,10 +250,12 @@ static void ovl_file_accessed(struct file *file)
 	if (!upperinode)
 		return;
 
+	ctime = inode_get_ctime(inode);
+	uctime = inode_get_ctime(upperinode);
 	if ((!timespec64_equal(&inode->i_mtime, &upperinode->i_mtime) ||
-	     !timespec64_equal(&inode->i_ctime, &upperinode->i_ctime))) {
+	     !timespec64_equal(&ctime, &uctime))) {
 		inode->i_mtime = upperinode->i_mtime;
-		inode->i_ctime = upperinode->i_ctime;
+		inode_set_ctime_to_ts(inode, inode_get_ctime(upperinode));
 	}
 
 	touch_atime(&file->f_path);
diff --git a/fs/overlayfs/util.c b/fs/overlayfs/util.c
index 7ef9e13c404a..c210b5d496a8 100644
--- a/fs/overlayfs/util.c
+++ b/fs/overlayfs/util.c
@@ -1202,6 +1202,6 @@ void ovl_copyattr(struct inode *inode)
 	inode->i_mode = realinode->i_mode;
 	inode->i_atime = realinode->i_atime;
 	inode->i_mtime = realinode->i_mtime;
-	inode->i_ctime = realinode->i_ctime;
+	inode_set_ctime_to_ts(inode, inode_get_ctime(realinode));
 	i_size_write(inode, i_size_read(realinode));
 }
-- 
2.41.0

