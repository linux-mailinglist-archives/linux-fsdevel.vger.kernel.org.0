Return-Path: <linux-fsdevel+bounces-67046-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BE7FC338DB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 05 Nov 2025 01:55:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9A3FE4F1080
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Nov 2025 00:54:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21E0E23EAA5;
	Wed,  5 Nov 2025 00:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NTb4qscb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B68F23D7C3;
	Wed,  5 Nov 2025 00:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762304065; cv=none; b=oQGZtLQCzAddCo4SoeQxcPVIhpS/8AFu25RQ6rZLepb55h8Nqfi7gw20k1wr+C1hld/lZvg0kv6gtPEvw1EuKguYCVsKCUv2nYgpvtxUDfAKvD08e/XzpTj3HgfSFOjHIW60IxrCpsPhi+nowVeVfHOfUcfF93nAZc3VZwrkwD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762304065; c=relaxed/simple;
	bh=PZgX5ioJ+1waD9hZmJzo5/1WymVIlLaWlcfLwdyvOJw=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fCmSHI2FY95olnXyjxROH+MuCMaxpAnajhZnc13y/Vhv5yLr6vxNS+fQR3oSMqKysaJ6Byp8i81PnM0rB9t+UiWhF+CQMk9VGcvPQyiiK5DESQiWxY43PSYVOdwkkrMOyYpplRD5CaaKvVsFJg76CuivngOYqSEkjq5Aya8eRBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NTb4qscb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 541A0C4CEF7;
	Wed,  5 Nov 2025 00:54:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762304065;
	bh=PZgX5ioJ+1waD9hZmJzo5/1WymVIlLaWlcfLwdyvOJw=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=NTb4qscbJWA8K1AasLTdKvFTmgdaJKOFPk2XBqkC7kk+CCFds5y2FT00po3ZRSetA
	 8sfuqN9NgI83fFGTKKIBx5PVHDK4JBCi3moOhyCa6eOY+2YaFeD8Pifg9F6AorI2qR
	 R4AVOBwfkgisUwsQhL0JJyE5lWEoGkkuqFK86rN1HSk26/mH0+Kv7smBkB3dHJsIGN
	 kLr0ImdcliAHNtlPQulHhyd0q9400IIrC0AGJ6XE7v3DjkOkQDPueczv3u4YI7wQZ5
	 WeMy7D+X9C+/IfU1ZH/F5vvDj3sShwOPds++vTlv1hHstuVoqaZRRknmSMPoOmr81n
	 IbLqUhbezzEcA==
Date: Tue, 04 Nov 2025 16:54:24 -0800
Subject: [PATCH 1/6] iomap: report file IO errors to fsnotify
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, cem@kernel.org
Cc: hch@lst.de, linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
 hch@lst.de, amir73il@gmail.com, jack@suse.cz, gabriel@krisman.be
Message-ID: <176230366453.1647991.17002688390201603817.stgit@frogsfrogsfrogs>
In-Reply-To: <176230366393.1647991.7608961849841103569.stgit@frogsfrogsfrogs>
References: <176230366393.1647991.7608961849841103569.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

Create a generic hook for iomap filesystems to report IO errors to
fsnotify and in-kernel subsystems that want to know about such things.

Suggested-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 include/linux/fs.h     |   64 ++++++++++++++++++++++++++++++++++++++++++++++++
 fs/iomap/buffered-io.c |    6 +++++
 fs/iomap/direct-io.c   |    5 ++++
 fs/super.c             |   53 ++++++++++++++++++++++++++++++++++++++++
 4 files changed, 128 insertions(+)


diff --git a/include/linux/fs.h b/include/linux/fs.h
index 5e4b3a4b24823f..1cb3965db3275c 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -80,6 +80,7 @@ struct fs_context;
 struct fs_parameter_spec;
 struct file_kattr;
 struct iomap_ops;
+struct notifier_head;
 
 extern void __init inode_init(void);
 extern void __init inode_init_early(void);
@@ -1587,6 +1588,7 @@ struct super_block {
 
 	spinlock_t		s_inode_wblist_lock;
 	struct list_head	s_inodes_wb;	/* writeback inodes */
+	struct blocking_notifier_head	s_error_notifier;
 } __randomize_layout;
 
 static inline struct user_namespace *i_user_ns(const struct inode *inode)
@@ -4069,4 +4071,66 @@ static inline bool extensible_ioctl_valid(unsigned int cmd_a,
 	return true;
 }
 
+enum fs_error_type {
+	/* pagecache reads and writes */
+	FSERR_READAHEAD,
+	FSERR_WRITEBACK,
+
+	/* directio read and writes */
+	FSERR_DIO_READ,
+	FSERR_DIO_WRITE,
+
+	/* media error */
+	FSERR_DATA_LOST,
+
+	/* filesystem metadata */
+	FSERR_METADATA,
+};
+
+struct fs_error {
+	struct work_struct work;
+	struct super_block *sb;
+	struct inode *inode;
+	loff_t pos;
+	u64 len;
+	enum fs_error_type type;
+	int error;
+};
+
+struct fs_error_hook {
+	struct notifier_block nb;
+};
+
+static inline int sb_hook_error(struct super_block *sb,
+				struct fs_error_hook *h)
+{
+	return blocking_notifier_chain_register(&sb->s_error_notifier, &h->nb);
+}
+
+static inline void sb_unhook_error(struct super_block *sb,
+				   struct fs_error_hook *h)
+{
+	blocking_notifier_chain_unregister(&sb->s_error_notifier, &h->nb);
+}
+
+static inline void sb_init_error_hook(struct fs_error_hook *h, notifier_fn_t fn)
+{
+	h->nb.notifier_call = fn;
+	h->nb.priority = 0;
+}
+
+void __sb_error(struct super_block *sb, struct inode *inode,
+		enum fs_error_type type, loff_t pos, u64 len, int error);
+
+static inline void sb_error(struct super_block *sb, int error)
+{
+	__sb_error(sb, NULL, FSERR_METADATA, 0, 0, error);
+}
+
+static inline void inode_error(struct inode *inode, enum fs_error_type type,
+			       loff_t pos, u64 len, int error)
+{
+	__sb_error(inode->i_sb, inode, type, pos, len, error);
+}
+
 #endif /* _LINUX_FS_H */
diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 8dd5421cb910b5..dc19311fe1c6c0 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -291,6 +291,12 @@ static inline bool iomap_block_needs_zeroing(const struct iomap_iter *iter,
 inline void iomap_mapping_ioerror(struct address_space *mapping, int direction,
 		loff_t pos, u64 len, int error)
 {
+	struct inode *inode = mapping->host;
+
+	inode_error(inode,
+		    direction == READ ? FSERR_READAHEAD : FSERR_WRITEBACK,
+		    pos, len, error);
+
 	if (mapping && mapping->a_ops->ioerror)
 		mapping->a_ops->ioerror(mapping, direction, pos, len,
 				error);
diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
index 1512d8dbb0d2e7..9f6ce0d9c531bb 100644
--- a/fs/iomap/direct-io.c
+++ b/fs/iomap/direct-io.c
@@ -95,6 +95,11 @@ ssize_t iomap_dio_complete(struct iomap_dio *dio)
 
 	if (dops && dops->end_io)
 		ret = dops->end_io(iocb, dio->size, ret, dio->flags);
+	if (dio->error)
+		inode_error(file_inode(iocb->ki_filp),
+			    (dio->flags & IOMAP_DIO_WRITE) ? FSERR_DIO_WRITE :
+							     FSERR_DIO_READ,
+			    offset, dio->size, dio->error);
 	if (dio->error && dops && dops->ioerror)
 		dops->ioerror(file_inode(iocb->ki_filp),
 				(dio->flags & IOMAP_DIO_WRITE) ? WRITE : READ,
diff --git a/fs/super.c b/fs/super.c
index 5bab94fb7e0358..f6d38e4b3d76b2 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -363,6 +363,7 @@ static struct super_block *alloc_super(struct file_system_type *type, int flags,
 	spin_lock_init(&s->s_inode_list_lock);
 	INIT_LIST_HEAD(&s->s_inodes_wb);
 	spin_lock_init(&s->s_inode_wblist_lock);
+	BLOCKING_INIT_NOTIFIER_HEAD(&s->s_error_notifier);
 
 	s->s_count = 1;
 	atomic_set(&s->s_active, 1);
@@ -2267,3 +2268,55 @@ int sb_init_dio_done_wq(struct super_block *sb)
 	return 0;
 }
 EXPORT_SYMBOL_GPL(sb_init_dio_done_wq);
+
+static void handle_sb_error(struct work_struct *work)
+{
+	struct fs_error *fserr = container_of(work, struct fs_error, work);
+
+	fsnotify_sb_error(fserr->sb, fserr->inode, fserr->error);
+	blocking_notifier_call_chain(&fserr->sb->s_error_notifier, fserr->type,
+				     fserr);
+	iput(fserr->inode);
+	kfree(fserr);
+}
+
+/**
+ * Report a filesystem error.  The actual work is deferred to a workqueue so
+ * that we're always in process context and to avoid blowing out the caller's
+ * stack.
+ *
+ * @sb Filesystem superblock
+ * @inode Inode within filesystem, if applicable
+ * @type Type of error
+ * @pos Start of file range affected, if applicable
+ * @len Length of file range affected, if applicable
+ * @error Error encountered.
+ */
+void __sb_error(struct super_block *sb, struct inode *inode,
+		enum fs_error_type type, loff_t pos, u64 len, int error)
+{
+	struct fs_error *fserr = kzalloc(sizeof(struct fs_error), GFP_ATOMIC);
+
+	if (!fserr) {
+		printk(KERN_ERR
+ "lost fs error report for ino %lu type %u pos 0x%llx len 0x%llx error %d",
+				inode ? inode->i_ino : 0, type,
+				pos, len, error);
+		return;
+	}
+
+	if (inode) {
+		fserr->sb = inode->i_sb;
+		fserr->inode = igrab(inode);
+	} else {
+		fserr->sb = sb;
+	}
+	fserr->type = type;
+	fserr->pos = pos;
+	fserr->len = len;
+	fserr->error = error;
+	INIT_WORK(&fserr->work, handle_sb_error);
+
+	schedule_work(&fserr->work);
+}
+EXPORT_SYMBOL_GPL(__sb_error);


