Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D16FB6F88B2
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 May 2023 20:38:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232549AbjEESi7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 5 May 2023 14:38:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231730AbjEESi6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 5 May 2023 14:38:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3DFA1AEC7
        for <linux-fsdevel@vger.kernel.org>; Fri,  5 May 2023 11:38:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 39B23612BE
        for <linux-fsdevel@vger.kernel.org>; Fri,  5 May 2023 18:38:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52D2CC433D2;
        Fri,  5 May 2023 18:38:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683311932;
        bh=GdYSw9VqwgRlrzzZxLV54oL4HgWvYTGiC5taW2D05e4=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=S5ckk9kNu4j8HtDaVVdpiGd1KC24StnFNfUHVuiFfWD9VF772y37rx3nLD+oMGlJ9
         j2dBjbFeYWt1PVlrjmshhNvwT74Y2oRVcdYurRfNqE43XwjnDrMhG4sQVSPusr+L8r
         dIEpBf3drtu24asv25kJtiu+xZVkggs1w/rzlh59cC59eNFTRvsIImz0CfgvlcPIti
         c6dySzJvl6L/p7jtXuE8lA5XhMXnqS+AAGo2TXglx1Jg5NTHeSZ0VeNMRD7FVayb8Y
         T0JLJmZxDf0gIfocYIMvu4deO2SEQcXi34r73yT0KWIqmuVXQiJ+xq3fBbT0Ihbm7V
         JlnDKpugrC2qg==
Subject: [PATCH v2 2/5] shmem: Add dir_operations specific to tmpfs
From:   Chuck Lever <cel@kernel.org>
To:     hughd@google.com, akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Date:   Fri, 05 May 2023 14:38:41 -0400
Message-ID: <168331191128.20728.16486149742123519972.stgit@oracle-102.nfsv4bat.org>
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

Copy the simple directory operations out of fs/libfs.c to create a
set of dir_operations specific to tmpfs. These will be modified by
a subsequent patch to replace the cursor-based directory entry
offset mechanism.

No behavior change is expected.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 mm/shmem.c |  143 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 142 insertions(+), 1 deletion(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index 721f9fd064aa..e48a0947bcaf 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -235,6 +235,7 @@ static const struct super_operations shmem_ops;
 const struct address_space_operations shmem_aops;
 static const struct file_operations shmem_file_operations;
 static const struct inode_operations shmem_inode_operations;
+static const struct file_operations shmem_dir_operations;
 static const struct inode_operations shmem_dir_inode_operations;
 static const struct inode_operations shmem_special_inode_operations;
 static const struct vm_operations_struct shmem_vm_ops;
@@ -2410,7 +2411,7 @@ static struct inode *shmem_get_inode(struct mnt_idmap *idmap, struct super_block
 			/* Some things misbehave if size == 0 on a directory */
 			inode->i_size = 2 * BOGO_DIRENT_SIZE;
 			inode->i_op = &shmem_dir_inode_operations;
-			inode->i_fop = &simple_dir_operations;
+			inode->i_fop = &shmem_dir_operations;
 			break;
 		case S_IFLNK:
 			/*
@@ -3235,6 +3236,137 @@ static const char *shmem_get_link(struct dentry *dentry,
 	return folio_address(folio);
 }
 
+static struct dentry *scan_positives(struct dentry *cursor,
+					struct list_head *p,
+					loff_t count,
+					struct dentry *last)
+{
+	struct dentry *dentry = cursor->d_parent, *found = NULL;
+
+	spin_lock(&dentry->d_lock);
+	while ((p = p->next) != &dentry->d_subdirs) {
+		struct dentry *d = list_entry(p, struct dentry, d_child);
+		// we must at least skip cursors, to avoid livelocks
+		if (d->d_flags & DCACHE_DENTRY_CURSOR)
+			continue;
+		if (simple_positive(d) && !--count) {
+			spin_lock_nested(&d->d_lock, DENTRY_D_LOCK_NESTED);
+			if (simple_positive(d))
+				found = dget_dlock(d);
+			spin_unlock(&d->d_lock);
+			if (likely(found))
+				break;
+			count = 1;
+		}
+		if (need_resched()) {
+			list_move(&cursor->d_child, p);
+			p = &cursor->d_child;
+			spin_unlock(&dentry->d_lock);
+			cond_resched();
+			spin_lock(&dentry->d_lock);
+		}
+	}
+	spin_unlock(&dentry->d_lock);
+	dput(last);
+	return found;
+}
+
+static loff_t shmem_dir_llseek(struct file *file, loff_t offset, int whence)
+{
+	struct dentry *dentry = file->f_path.dentry;
+	switch (whence) {
+		case 1:
+			offset += file->f_pos;
+			fallthrough;
+		case 0:
+			if (offset >= 0)
+				break;
+			fallthrough;
+		default:
+			return -EINVAL;
+	}
+	if (offset != file->f_pos) {
+		struct dentry *cursor = file->private_data;
+		struct dentry *to = NULL;
+
+		inode_lock_shared(dentry->d_inode);
+
+		if (offset > 2)
+			to = scan_positives(cursor, &dentry->d_subdirs,
+					    offset - 2, NULL);
+		spin_lock(&dentry->d_lock);
+		if (to)
+			list_move(&cursor->d_child, &to->d_child);
+		else
+			list_del_init(&cursor->d_child);
+		spin_unlock(&dentry->d_lock);
+		dput(to);
+
+		file->f_pos = offset;
+
+		inode_unlock_shared(dentry->d_inode);
+	}
+	return offset;
+}
+
+/**
+ * shmem_readdir - Emit entries starting at offset @ctx->pos
+ * @file: an open directory to iterate over
+ * @ctx: directory iteration context
+ *
+ * Caller must hold @file's i_rwsem to prevent insertion or removal of
+ * entries during this call.
+ *
+ * On entry, @ctx->pos contains an offset that represents the first entry
+ * to be read from the directory.
+ *
+ * The operation continues until there are no more entries to read, or
+ * until the ctx->actor indicates there is no more space in the caller's
+ * output buffer.
+ *
+ * On return, @ctx->pos contains an offset that will read the next entry
+ * in this directory when shmem_readdir() is called again with @ctx.
+ *
+ * Return values:
+ *   %0 - Complete
+ */
+static int shmem_readdir(struct file *file, struct dir_context *ctx)
+{
+	struct dentry *dentry = file->f_path.dentry;
+	struct dentry *cursor = file->private_data;
+	struct list_head *anchor = &dentry->d_subdirs;
+	struct dentry *next = NULL;
+	struct list_head *p;
+
+	if (!dir_emit_dots(file, ctx))
+		return 0;
+
+	if (ctx->pos == 2)
+		p = anchor;
+	else if (!list_empty(&cursor->d_child))
+		p = &cursor->d_child;
+	else
+		return 0;
+
+	while ((next = scan_positives(cursor, p, 1, next)) != NULL) {
+		if (!dir_emit(ctx, next->d_name.name, next->d_name.len,
+			      d_inode(next)->i_ino,
+			      fs_umode_to_dtype(d_inode(next)->i_mode)))
+			break;
+		ctx->pos++;
+		p = &next->d_child;
+	}
+	spin_lock(&dentry->d_lock);
+	if (next)
+		list_move_tail(&cursor->d_child, &next->d_child);
+	else
+		list_del_init(&cursor->d_child);
+	spin_unlock(&dentry->d_lock);
+	dput(next);
+
+	return 0;
+}
+
 #ifdef CONFIG_TMPFS_XATTR
 
 static int shmem_fileattr_get(struct dentry *dentry, struct fileattr *fa)
@@ -3987,6 +4119,15 @@ static const struct inode_operations shmem_inode_operations = {
 #endif
 };
 
+static const struct file_operations shmem_dir_operations = {
+#ifdef CONFIG_TMPFS
+	.llseek		= shmem_dir_llseek,
+	.iterate_shared	= shmem_readdir,
+#endif
+	.read		= generic_read_dir,
+	.fsync		= noop_fsync,
+};
+
 static const struct inode_operations shmem_dir_inode_operations = {
 #ifdef CONFIG_TMPFS
 	.getattr	= shmem_getattr,


