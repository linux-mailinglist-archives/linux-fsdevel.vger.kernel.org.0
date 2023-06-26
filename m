Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72FDE73E823
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jun 2023 20:23:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231970AbjFZSXZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Jun 2023 14:23:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231882AbjFZSXR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Jun 2023 14:23:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E5A9211C
        for <linux-fsdevel@vger.kernel.org>; Mon, 26 Jun 2023 11:22:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E460D60F6B
        for <linux-fsdevel@vger.kernel.org>; Mon, 26 Jun 2023 18:21:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF055C433C8;
        Mon, 26 Jun 2023 18:21:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687803702;
        bh=UKT1qjbXJ/095r7Q3G5RGYYkec8CgNh7aC+yZ74QvAA=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=kmbTkXAgmmFnlq2CWE/KuYZ1krx1nS+2xlTwHd0NOLh2Cxy2pqIlzyZ8LKTdXD6Ef
         ZU9IAnn/DvWiEqy484ycq0/Ao9w+/2bzgOtaV7+WTc7RygG0wwYDABenSmCxm8Sse+
         eoAHZp6LEll+IcjSRWGESKr6bBK5/VmMnKdmmVo3nlNEpg3im7bymnpeyQgeDVuVW6
         Ss7k47Kw5BNwQx3LRWv67kMo0AEhNstkaccwx4zk0CYQg3Sen+oMvfQSzkQlin3czV
         Eoq//d2TEGDkA1yP7iTcR/SMH5GmtLmU2lOS6wIgypyzu3n6NMvMa6NZjEP1y6D5dP
         pzBW0cZnIAQsQ==
Subject: [PATCH v4 3/3] shmem: stable directory offsets
From:   Chuck Lever <cel@kernel.org>
To:     viro@zeniv.linux.org.uk, brauner@kernel.org, hughd@google.com,
        akpm@linux-foundation.org
Cc:     Chuck Lever <chuck.lever@oracle.com>, jlayton@redhat.com,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Date:   Mon, 26 Jun 2023 14:21:40 -0400
Message-ID: <168780370085.2142.4461798321197359310.stgit@manet.1015granger.net>
In-Reply-To: <168780354647.2142.537463116658872680.stgit@manet.1015granger.net>
References: <168780354647.2142.537463116658872680.stgit@manet.1015granger.net>
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
 mm/shmem.c |   54 +++++++++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 47 insertions(+), 7 deletions(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index 721f9fd064aa..89012f3583b1 100644
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
@@ -2950,7 +2951,10 @@ shmem_mknod(struct mnt_idmap *idmap, struct inode *dir,
 		if (error && error != -EOPNOTSUPP)
 			goto out_iput;
 
-		error = 0;
+		error = stable_offset_add(dir, dentry);
+		if (error)
+			goto out_iput;
+
 		dir->i_size += BOGO_DIRENT_SIZE;
 		dir->i_ctime = dir->i_mtime = current_time(dir);
 		inode_inc_iversion(dir);
@@ -3027,6 +3031,13 @@ static int shmem_link(struct dentry *old_dentry, struct inode *dir, struct dentr
 			goto out;
 	}
 
+	ret = stable_offset_add(dir, dentry);
+	if (ret) {
+		if (inode->i_nlink)
+			shmem_free_inode(inode->i_sb);
+		goto out;
+	}
+
 	dir->i_size += BOGO_DIRENT_SIZE;
 	inode->i_ctime = dir->i_ctime = dir->i_mtime = current_time(inode);
 	inode_inc_iversion(dir);
@@ -3045,6 +3056,8 @@ static int shmem_unlink(struct inode *dir, struct dentry *dentry)
 	if (inode->i_nlink > 1 && !S_ISDIR(inode->i_mode))
 		shmem_free_inode(inode->i_sb);
 
+	stable_offset_remove(dir, dentry);
+
 	dir->i_size -= BOGO_DIRENT_SIZE;
 	inode->i_ctime = dir->i_ctime = dir->i_mtime = current_time(inode);
 	inode_inc_iversion(dir);
@@ -3103,24 +3116,41 @@ static int shmem_rename2(struct mnt_idmap *idmap,
 {
 	struct inode *inode = d_inode(old_dentry);
 	int they_are_dirs = S_ISDIR(inode->i_mode);
+	int error;
 
 	if (flags & ~(RENAME_NOREPLACE | RENAME_EXCHANGE | RENAME_WHITEOUT))
 		return -EINVAL;
 
-	if (flags & RENAME_EXCHANGE)
+	if (flags & RENAME_EXCHANGE) {
+		error = stable_offset_add(new_dir, old_dentry);
+		if (error)
+			return error;
+		error = stable_offset_add(old_dir, new_dentry);
+		if (error) {
+			stable_offset_remove(new_dir, old_dentry);
+			return error;
+		}
+		stable_offset_remove(old_dir, old_dentry);
+		stable_offset_remove(new_dir, new_dentry);
+
+		/* Always returns zero */
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
@@ -3164,19 +3194,23 @@ static int shmem_symlink(struct mnt_idmap *idmap, struct inode *dir,
 	if (error && error != -EOPNOTSUPP)
 		goto out_iput;
 
+	error = stable_offset_add(dir, dentry);
+	if (error)
+		goto out_iput;
+
 	inode->i_size = len-1;
 	if (len <= SHORT_SYMLINK_LEN) {
 		inode->i_link = kmemdup(symname, len, GFP_KERNEL);
 		if (!inode->i_link) {
 			error = -ENOMEM;
-			goto out_iput;
+			goto out_remove_offset;
 		}
 		inode->i_op = &shmem_short_symlink_operations;
 	} else {
 		inode_nohighmem(inode);
 		error = shmem_get_folio(inode, 0, &folio, SGP_WRITE);
 		if (error)
-			goto out_iput;
+			goto out_remove_offset;
 		inode->i_mapping->a_ops = &shmem_aops;
 		inode->i_op = &shmem_symlink_inode_operations;
 		memcpy(folio_address(folio), symname, len);
@@ -3185,12 +3219,16 @@ static int shmem_symlink(struct mnt_idmap *idmap, struct inode *dir,
 		folio_unlock(folio);
 		folio_put(folio);
 	}
+
 	dir->i_size += BOGO_DIRENT_SIZE;
 	dir->i_ctime = dir->i_mtime = current_time(dir);
 	inode_inc_iversion(dir);
 	d_instantiate(dentry, inode);
 	dget(dentry);
 	return 0;
+
+out_remove_offset:
+	stable_offset_remove(dir, dentry);
 out_iput:
 	iput(inode);
 	return error;
@@ -3920,6 +3958,8 @@ static void shmem_destroy_inode(struct inode *inode)
 {
 	if (S_ISREG(inode->i_mode))
 		mpol_free_shared_policy(&SHMEM_I(inode)->policy);
+	if (S_ISDIR(inode->i_mode))
+		stable_offset_destroy(inode);
 }
 
 static void shmem_init_inode(void *foo)


