Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAA6E748CC4
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Jul 2023 21:03:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233554AbjGETDs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 Jul 2023 15:03:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233484AbjGETD3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 Jul 2023 15:03:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 000C419A9;
        Wed,  5 Jul 2023 12:03:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D3F20616F9;
        Wed,  5 Jul 2023 19:03:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94634C433C8;
        Wed,  5 Jul 2023 19:03:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688583802;
        bh=xf8Hi6LLQ8Uft364NbD0ve0c8ZqVR4Xzt1FbU/Spvec=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YeMu90xYX+J/DSpr4IEpPdjE0VhxjToh+dxnB6lIUKKzFPcDwLtfLqKprheME36Au
         GwtAsEj1J48EJ+u7bhE8nllzBjY6eaN33Z7CFu7g9eBJBejJ9bJayxiBj/WF4aqxR1
         ev8b72N50v378o9db6zZTHiX/IHmwUKC2RbwSvs+YbfDWVAWa+2HfqyyLEdQE8H6hH
         sLvE6sIM7+NfFVYFnqbPdsVR3GGg6Nd+De74SfHuZRvzgUXYOA3NicY4g1GrO+AubB
         x9RH15V52pkaLIQ5VhK+BEDjWAP0FZpk8dpHisGouC+BG+MA2V60Iplhx1Vt2GRlgB
         4+1tVVOQCzaRA==
From:   Jeff Layton <jlayton@kernel.org>
To:     Christian Brauner <brauner@kernel.org>,
        Richard Weinberger <richard@nod.at>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org
Subject: [PATCH v2 10/92] ubifs: convert to simple_rename_timestamp
Date:   Wed,  5 Jul 2023 15:00:35 -0400
Message-ID: <20230705190309.579783-8-jlayton@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230705190309.579783-1-jlayton@kernel.org>
References: <20230705185755.579053-1-jlayton@kernel.org>
 <20230705190309.579783-1-jlayton@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

A rename potentially involves updating 4 different inode timestamps.
Convert to the new simple_rename_timestamp helper function.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/ubifs/dir.c | 15 +++------------
 1 file changed, 3 insertions(+), 12 deletions(-)

diff --git a/fs/ubifs/dir.c b/fs/ubifs/dir.c
index ef0499edc248..7ec25310bd8a 100644
--- a/fs/ubifs/dir.c
+++ b/fs/ubifs/dir.c
@@ -1414,8 +1414,7 @@ static int do_rename(struct inode *old_dir, struct dentry *old_dentry,
 	 * Like most other Unix systems, set the @i_ctime for inodes on a
 	 * rename.
 	 */
-	time = current_time(old_dir);
-	old_inode->i_ctime = time;
+	simple_rename_timestamp(old_dir, old_dentry, new_dir, new_dentry);
 
 	/* We must adjust parent link count when renaming directories */
 	if (is_dir) {
@@ -1444,13 +1443,11 @@ static int do_rename(struct inode *old_dir, struct dentry *old_dentry,
 
 	old_dir->i_size -= old_sz;
 	ubifs_inode(old_dir)->ui_size = old_dir->i_size;
-	old_dir->i_mtime = old_dir->i_ctime = time;
-	new_dir->i_mtime = new_dir->i_ctime = time;
 
 	/*
 	 * And finally, if we unlinked a direntry which happened to have the
 	 * same name as the moved direntry, we have to decrement @i_nlink of
-	 * the unlinked inode and change its ctime.
+	 * the unlinked inode.
 	 */
 	if (unlink) {
 		/*
@@ -1462,7 +1459,6 @@ static int do_rename(struct inode *old_dir, struct dentry *old_dentry,
 			clear_nlink(new_inode);
 		else
 			drop_nlink(new_inode);
-		new_inode->i_ctime = time;
 	} else {
 		new_dir->i_size += new_sz;
 		ubifs_inode(new_dir)->ui_size = new_dir->i_size;
@@ -1557,7 +1553,6 @@ static int ubifs_xrename(struct inode *old_dir, struct dentry *old_dentry,
 	int sync = IS_DIRSYNC(old_dir) || IS_DIRSYNC(new_dir);
 	struct inode *fst_inode = d_inode(old_dentry);
 	struct inode *snd_inode = d_inode(new_dentry);
-	struct timespec64 time;
 	int err;
 	struct fscrypt_name fst_nm, snd_nm;
 
@@ -1588,11 +1583,7 @@ static int ubifs_xrename(struct inode *old_dir, struct dentry *old_dentry,
 
 	lock_4_inodes(old_dir, new_dir, NULL, NULL);
 
-	time = current_time(old_dir);
-	fst_inode->i_ctime = time;
-	snd_inode->i_ctime = time;
-	old_dir->i_mtime = old_dir->i_ctime = time;
-	new_dir->i_mtime = new_dir->i_ctime = time;
+	simple_rename_timestamp(old_dir, old_dentry, new_dir, new_dentry);
 
 	if (old_dir != new_dir) {
 		if (S_ISDIR(fst_inode->i_mode) && !S_ISDIR(snd_inode->i_mode)) {
-- 
2.41.0

