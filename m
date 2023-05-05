Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69A3F6F88BC
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 May 2023 20:40:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232769AbjEESkL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 5 May 2023 14:40:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232343AbjEESkJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 5 May 2023 14:40:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AEB01F4AE
        for <linux-fsdevel@vger.kernel.org>; Fri,  5 May 2023 11:40:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8CE3B60BCB
        for <linux-fsdevel@vger.kernel.org>; Fri,  5 May 2023 18:40:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A70C3C433EF;
        Fri,  5 May 2023 18:40:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683312005;
        bh=SxhrYvcxhBjeUt8wmGy6c2Qtho8JPzWD7lX0SBS7apY=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=mouuZBzrIkQ6xcAezlwBJgPALP+OH2G9vzy+PPWkCeIHjifkNX0zVIC8yHs3VjOqj
         JYE7jH6esduFWqv5z6AvKMpl5MHU9+Jjqw+Qi3+CJ9UtpifI5UxyZ3fRwP7p42uhZB
         VZlyIgC71LQUxDsw3B9TaVEv502XPp+PjmFQC4iCymkLJhP6ZdcMbSOSRlD8M1KHpO
         63LUnlKzYEuyDVS5PZZR1CEP8XJoVpBFecy53JVtco0GAAPQV++9zuR7Mg1LfxHACF
         j3b1t/LCV+FxSZMJrl3t++4AoqTuYakM57b2bBdGV3FcbZzudb6ZnIWp7eNjia3lft
         BnFE+YPTSkKlQ==
Subject: [PATCH v2 5/5] shmem: stable directory cookies
From:   Chuck Lever <cel@kernel.org>
To:     hughd@google.com, akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Date:   Fri, 05 May 2023 14:39:53 -0400
Message-ID: <168331199103.20728.3630197424738006199.stgit@oracle-102.nfsv4bat.org>
In-Reply-To: <168331111400.20728.2327812215536431362.stgit@oracle-102.nfsv4bat.org>
References: <168331111400.20728.2327812215536431362.stgit@oracle-102.nfsv4bat.org>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Chuck Lever <chuck.lever@oracle.com>

The current cursor-based directory cookie mechanism doesn't work
when a tmpfs filesystem is exported via NFS. This is because NFS
clients do not open directories. Each server-side READDIR operation
has to open the directory, read it, then close it. The cursor state
for that directory, being associated strictly with the opened
struct file, is discarded after each READDIR operation.

Directory cookies are cached not only by NFS clients, but also by
user space libraries on those clients. Essentially there is no way
to invalidate those caches when directory offsets have changed on
an NFS server after the offset-to-dentry mapping changes. Thus the
whole application stack depends on unchanging directory cookies.

The solution we've come up with is to make the directory cookie for
each file in a tmpfs filesystem stable for the life of the directory
entry it represents.

Add a per-directory xarray. shmem_readdir() uses this to map each
directory offset (an loff_t integer) to the memory address of a
struct dentry.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 mm/shmem.c |  202 +++++++++++++++++++++++++++++++-----------------------------
 1 file changed, 106 insertions(+), 96 deletions(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index 733b98ca8517..35eb2f1368dd 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -2939,6 +2939,55 @@ static struct xarray *shmem_doff_map(struct inode *dir)
 	return &SHMEM_I(dir)->doff_map;
 }
 
+static int shmem_doff_add(struct inode *dir, struct dentry *dentry)
+{
+	struct shmem_inode_info *info = SHMEM_I(dir);
+	struct xa_limit limit = XA_LIMIT(2, U32_MAX);
+	u32 offset;
+	int ret;
+
+	if (dentry->d_fsdata)
+		return -EBUSY;
+
+	offset = 0;
+	ret = xa_alloc_cyclic(shmem_doff_map(dir), &offset, dentry, limit,
+			      &info->next_doff, GFP_KERNEL);
+	if (ret < 0)
+		return ret;
+
+	dentry->d_fsdata = (void *)(unsigned long)offset;
+	return 0;
+}
+
+static struct dentry *shmem_doff_find_after(struct dentry *dir,
+					    unsigned long *offset)
+{
+	struct xarray *xa = shmem_doff_map(d_inode(dir));
+	struct dentry *d, *found = NULL;
+
+	spin_lock(&dir->d_lock);
+	d = xa_find_after(xa, offset, ULONG_MAX, XA_PRESENT);
+	if (d) {
+		spin_lock_nested(&d->d_lock, DENTRY_D_LOCK_NESTED);
+		if (simple_positive(d))
+			found = dget_dlock(d);
+		spin_unlock(&d->d_lock);
+	}
+	spin_unlock(&dir->d_lock);
+	return found;
+}
+
+static void shmem_doff_remove(struct inode *dir, struct dentry *dentry)
+{
+	u32 offset = (u32)(unsigned long)dentry->d_fsdata;
+
+	if (!offset)
+		return;
+
+	xa_erase(shmem_doff_map(dir), offset);
+	dentry->d_fsdata = NULL;
+}
+
 /*
  * During fs teardown (eg. umount), a directory's doff_map might still
  * contain entries. xa_destroy() cleans out anything that remains.
@@ -2971,6 +3020,10 @@ shmem_mknod(struct mnt_idmap *idmap, struct inode *dir,
 		if (error && error != -EOPNOTSUPP)
 			goto out_iput;
 
+		error = shmem_doff_add(dir, dentry);
+		if (error)
+			goto out_iput;
+
 		error = 0;
 		dir->i_size += BOGO_DIRENT_SIZE;
 		dir->i_ctime = dir->i_mtime = current_time(dir);
@@ -3048,6 +3101,10 @@ static int shmem_link(struct dentry *old_dentry, struct inode *dir, struct dentr
 			goto out;
 	}
 
+	ret = shmem_doff_add(dir, dentry);
+	if (ret)
+		goto out;
+
 	dir->i_size += BOGO_DIRENT_SIZE;
 	inode->i_ctime = dir->i_ctime = dir->i_mtime = current_time(inode);
 	inode_inc_iversion(dir);
@@ -3066,6 +3123,8 @@ static int shmem_unlink(struct inode *dir, struct dentry *dentry)
 	if (inode->i_nlink > 1 && !S_ISDIR(inode->i_mode))
 		shmem_free_inode(inode->i_sb);
 
+	shmem_doff_remove(dir, dentry);
+
 	dir->i_size -= BOGO_DIRENT_SIZE;
 	inode->i_ctime = dir->i_ctime = dir->i_mtime = current_time(inode);
 	inode_inc_iversion(dir);
@@ -3124,24 +3183,37 @@ static int shmem_rename2(struct mnt_idmap *idmap,
 {
 	struct inode *inode = d_inode(old_dentry);
 	int they_are_dirs = S_ISDIR(inode->i_mode);
+	int error;
 
 	if (flags & ~(RENAME_NOREPLACE | RENAME_EXCHANGE | RENAME_WHITEOUT))
 		return -EINVAL;
 
-	if (flags & RENAME_EXCHANGE)
+	if (flags & RENAME_EXCHANGE) {
+		shmem_doff_remove(old_dir, old_dentry);
+		shmem_doff_remove(new_dir, new_dentry);
+		error = shmem_doff_add(new_dir, old_dentry);
+		if (error)
+			return error;
+		error = shmem_doff_add(old_dir, new_dentry);
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
 
+	shmem_doff_remove(old_dir, old_dentry);
+	error = shmem_doff_add(new_dir, old_dentry);
+	if (error)
+		return error;
+
 	if (d_really_is_positive(new_dentry)) {
 		(void) shmem_unlink(new_dir, new_dentry);
 		if (they_are_dirs) {
@@ -3206,6 +3278,11 @@ static int shmem_symlink(struct mnt_idmap *idmap, struct inode *dir,
 		folio_unlock(folio);
 		folio_put(folio);
 	}
+
+	error = shmem_doff_add(dir, dentry);
+	if (error)
+		goto out_iput;
+
 	dir->i_size += BOGO_DIRENT_SIZE;
 	dir->i_ctime = dir->i_mtime = current_time(dir);
 	inode_inc_iversion(dir);
@@ -3256,77 +3333,20 @@ static const char *shmem_get_link(struct dentry *dentry,
 	return folio_address(folio);
 }
 
-static struct dentry *scan_positives(struct dentry *cursor,
-					struct list_head *p,
-					loff_t count,
-					struct dentry *last)
-{
-	struct dentry *dentry = cursor->d_parent, *found = NULL;
-
-	spin_lock(&dentry->d_lock);
-	while ((p = p->next) != &dentry->d_subdirs) {
-		struct dentry *d = list_entry(p, struct dentry, d_child);
-		// we must at least skip cursors, to avoid livelocks
-		if (d->d_flags & DCACHE_DENTRY_CURSOR)
-			continue;
-		if (simple_positive(d) && !--count) {
-			spin_lock_nested(&d->d_lock, DENTRY_D_LOCK_NESTED);
-			if (simple_positive(d))
-				found = dget_dlock(d);
-			spin_unlock(&d->d_lock);
-			if (likely(found))
-				break;
-			count = 1;
-		}
-		if (need_resched()) {
-			list_move(&cursor->d_child, p);
-			p = &cursor->d_child;
-			spin_unlock(&dentry->d_lock);
-			cond_resched();
-			spin_lock(&dentry->d_lock);
-		}
-	}
-	spin_unlock(&dentry->d_lock);
-	dput(last);
-	return found;
-}
-
 static loff_t shmem_dir_llseek(struct file *file, loff_t offset, int whence)
 {
-	struct dentry *dentry = file->f_path.dentry;
 	switch (whence) {
-		case 1:
-			offset += file->f_pos;
-			fallthrough;
-		case 0:
-			if (offset >= 0)
-				break;
-			fallthrough;
-		default:
-			return -EINVAL;
-	}
-	if (offset != file->f_pos) {
-		struct dentry *cursor = file->private_data;
-		struct dentry *to = NULL;
-
-		inode_lock_shared(dentry->d_inode);
-
-		if (offset > 2)
-			to = scan_positives(cursor, &dentry->d_subdirs,
-					    offset - 2, NULL);
-		spin_lock(&dentry->d_lock);
-		if (to)
-			list_move(&cursor->d_child, &to->d_child);
-		else
-			list_del_init(&cursor->d_child);
-		spin_unlock(&dentry->d_lock);
-		dput(to);
-
-		file->f_pos = offset;
-
-		inode_unlock_shared(dentry->d_inode);
+	case SEEK_CUR:
+		offset += file->f_pos;
+		fallthrough;
+	case SEEK_SET:
+		if (offset >= 0)
+			break;
+		fallthrough;
+	default:
+		return -EINVAL;
 	}
-	return offset;
+	return vfs_setpos(file, offset, U32_MAX);
 }
 
 static bool shmem_dir_emit(struct dir_context *ctx, struct dentry *dentry)
@@ -3334,7 +3354,7 @@ static bool shmem_dir_emit(struct dir_context *ctx, struct dentry *dentry)
 	struct inode *inode = d_inode(dentry);
 
 	return ctx->actor(ctx, dentry->d_name.name, dentry->d_name.len,
-			  ctx->pos, inode->i_ino,
+			  (loff_t)dentry->d_fsdata, inode->i_ino,
 			  fs_umode_to_dtype(inode->i_mode));
 }
 
@@ -3361,36 +3381,26 @@ static bool shmem_dir_emit(struct dir_context *ctx, struct dentry *dentry)
  */
 static int shmem_readdir(struct file *file, struct dir_context *ctx)
 {
-	struct dentry *dentry = file->f_path.dentry;
-	struct dentry *cursor = file->private_data;
-	struct list_head *anchor = &dentry->d_subdirs;
-	struct dentry *next = NULL;
-	struct list_head *p;
-
-	if (!dir_emit_dots(file, ctx))
-		return 0;
+	struct dentry *dentry, *dir = file->f_path.dentry;
+	unsigned long offset;
 
-	if (ctx->pos == 2)
-		p = anchor;
-	else if (!list_empty(&cursor->d_child))
-		p = &cursor->d_child;
-	else
-		return 0;
+	lockdep_assert_held(&d_inode(dir)->i_rwsem);
 
-	while ((next = scan_positives(cursor, p, 1, next)) != NULL) {
-		if (!shmem_dir_emit(ctx, dentry))
+	if (!dir_emit_dots(file, ctx))
+		goto out;
+	for (offset = ctx->pos - 1; offset < ULONG_MAX - 1;) {
+		dentry = shmem_doff_find_after(dir, &offset);
+		if (!dentry)
 			break;
-		ctx->pos++;
-		p = &next->d_child;
+		if (!shmem_dir_emit(ctx, dentry)) {
+			dput(dentry);
+			break;
+		}
+		ctx->pos = offset + 1;
+		dput(dentry);
 	}
-	spin_lock(&dentry->d_lock);
-	if (next)
-		list_move_tail(&cursor->d_child, &next->d_child);
-	else
-		list_del_init(&cursor->d_child);
-	spin_unlock(&dentry->d_lock);
-	dput(next);
 
+out:
 	return 0;
 }
 


