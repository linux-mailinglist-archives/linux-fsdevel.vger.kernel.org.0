Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A6E5724400
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Jun 2023 15:12:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238219AbjFFNMN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 6 Jun 2023 09:12:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238218AbjFFNLa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 6 Jun 2023 09:11:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13ED619B0
        for <linux-fsdevel@vger.kernel.org>; Tue,  6 Jun 2023 06:11:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9A4FE632F2
        for <linux-fsdevel@vger.kernel.org>; Tue,  6 Jun 2023 13:11:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87F2CC433EF;
        Tue,  6 Jun 2023 13:11:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686057074;
        bh=6mcDEGVH/bp+XCWnQNtci6/kkB4yuXmtJpIKrxsKmgg=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=M8uKZeRSre9ajHhZda1DdL9UHKymOjtrNfi57g8Pjq3O8UmBbWbvqmoyi4ykg4VZ+
         CxrUspHLdpj/8uJz+oISmI52Zn4K7q25KI9oS8r/PqL+uUl748l7ZhS8wXvRYj6lI5
         7cjBsiDhyl85QTDEW3NWxwS9twTPiGgxBqNT0FADtTQDV0UsdGmBMKx8l/cgad8/fr
         pekKwylC3lTkOzCx/n5VgqKV+YubQU7me1KX7zaDrsBYfTBTXbFxxXkyGqnz8HCspL
         pw/Gf8lHVn0AOIP61MPBd9CG32sWLpUsbnHZROzHVnkt0uwgvQT02uSAlG46zQbj2C
         1iSs0j02t9LTQ==
Subject: [PATCH v3 3/3] shmem: stable directory offsets
From:   Chuck Lever <cel@kernel.org>
To:     viro@zeniv.linux.org.uk, brauner@kernel.org, hughd@google.com,
        akpm@linux-foundation.org
Cc:     Chuck Lever <chuck.lever@oracle.com>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org
Date:   Tue, 06 Jun 2023 09:11:12 -0400
Message-ID: <168605707262.32244.4794425063054676856.stgit@manet.1015granger.net>
In-Reply-To: <168605676256.32244.6158641147817585524.stgit@manet.1015granger.net>
References: <168605676256.32244.6158641147817585524.stgit@manet.1015granger.net>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Chuck Lever <chuck.lever@oracle.com>

The current cursor-based directory offset mechanism doesn't work
when a tmpfs filesystem is exported via NFS. This is because NFS
clients do not open directories. Each server-side READDIR operation
has to open the directory, read it, then close it. The cursor state
for that directory, being associated strictly with the opened
struct file, is thus discarded after each NFS READDIR operation.

Directory offsets are cached not only by NFS clients, but also by
user space libraries on those clients. Essentially there is no way
to invalidate those caches when directory offsets have changed on
an NFS server after the offset-to-dentry mapping changes. Thus the
whole application stack depends on unchanging directory offsets.

The solution we've come up with is to make the directory offset for
each file in a tmpfs filesystem stable for the life of the directory
entry it represents.

shmem_readdir() and shmem_dir_llseek() now use an xarray to map each
directory offset (an loff_t integer) to the memory address of a
struct dentry.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 mm/shmem.c |   39 +++++++++++++++++++++++++++++++++++----
 1 file changed, 35 insertions(+), 4 deletions(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index 721f9fd064aa..fd9571056181 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -2410,7 +2410,8 @@ static struct inode *shmem_get_inode(struct mnt_idmap *idmap, struct super_block
 			/* Some things misbehave if size == 0 on a directory */
 			inode->i_size = 2 * BOGO_DIRENT_SIZE;
 			inode->i_op = &shmem_dir_inode_operations;
-			inode->i_fop = &simple_dir_operations;
+			inode->i_fop = &stable_dir_operations;
+			stable_offset_init(inode);
 			break;
 		case S_IFLNK:
 			/*
@@ -2950,6 +2951,10 @@ shmem_mknod(struct mnt_idmap *idmap, struct inode *dir,
 		if (error && error != -EOPNOTSUPP)
 			goto out_iput;
 
+		error = stable_offset_add(dir, dentry);
+		if (error)
+			goto out_iput;
+
 		error = 0;
 		dir->i_size += BOGO_DIRENT_SIZE;
 		dir->i_ctime = dir->i_mtime = current_time(dir);
@@ -3027,6 +3032,10 @@ static int shmem_link(struct dentry *old_dentry, struct inode *dir, struct dentr
 			goto out;
 	}
 
+	ret = stable_offset_add(dir, dentry);
+	if (ret)
+		goto out;
+
 	dir->i_size += BOGO_DIRENT_SIZE;
 	inode->i_ctime = dir->i_ctime = dir->i_mtime = current_time(inode);
 	inode_inc_iversion(dir);
@@ -3045,6 +3054,8 @@ static int shmem_unlink(struct inode *dir, struct dentry *dentry)
 	if (inode->i_nlink > 1 && !S_ISDIR(inode->i_mode))
 		shmem_free_inode(inode->i_sb);
 
+	stable_offset_remove(dir, dentry);
+
 	dir->i_size -= BOGO_DIRENT_SIZE;
 	inode->i_ctime = dir->i_ctime = dir->i_mtime = current_time(inode);
 	inode_inc_iversion(dir);
@@ -3103,24 +3114,37 @@ static int shmem_rename2(struct mnt_idmap *idmap,
 {
 	struct inode *inode = d_inode(old_dentry);
 	int they_are_dirs = S_ISDIR(inode->i_mode);
+	int error;
 
 	if (flags & ~(RENAME_NOREPLACE | RENAME_EXCHANGE | RENAME_WHITEOUT))
 		return -EINVAL;
 
-	if (flags & RENAME_EXCHANGE)
+	if (flags & RENAME_EXCHANGE) {
+		stable_offset_remove(old_dir, old_dentry);
+		stable_offset_remove(new_dir, new_dentry);
+		error = stable_offset_add(new_dir, old_dentry);
+		if (error)
+			return error;
+		error = stable_offset_add(old_dir, new_dentry);
+		if (error)
+			return error;
 		return simple_rename_exchange(old_dir, old_dentry, new_dir, new_dentry);
+	}
 
 	if (!simple_empty(new_dentry))
 		return -ENOTEMPTY;
 
 	if (flags & RENAME_WHITEOUT) {
-		int error;
-
 		error = shmem_whiteout(idmap, old_dir, old_dentry);
 		if (error)
 			return error;
 	}
 
+	stable_offset_remove(old_dir, old_dentry);
+	error = stable_offset_add(new_dir, old_dentry);
+	if (error)
+		return error;
+
 	if (d_really_is_positive(new_dentry)) {
 		(void) shmem_unlink(new_dir, new_dentry);
 		if (they_are_dirs) {
@@ -3185,6 +3209,11 @@ static int shmem_symlink(struct mnt_idmap *idmap, struct inode *dir,
 		folio_unlock(folio);
 		folio_put(folio);
 	}
+
+	error = stable_offset_add(dir, dentry);
+	if (error)
+		goto out_iput;
+
 	dir->i_size += BOGO_DIRENT_SIZE;
 	dir->i_ctime = dir->i_mtime = current_time(dir);
 	inode_inc_iversion(dir);
@@ -3920,6 +3949,8 @@ static void shmem_destroy_inode(struct inode *inode)
 {
 	if (S_ISREG(inode->i_mode))
 		mpol_free_shared_policy(&SHMEM_I(inode)->policy);
+	if (S_ISDIR(inode->i_mode))
+		stable_offset_destroy(inode);
 }
 
 static void shmem_init_inode(void *foo)


