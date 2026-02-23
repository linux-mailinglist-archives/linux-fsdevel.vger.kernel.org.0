Return-Path: <linux-fsdevel+bounces-78061-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mL8+LQLfnGl/LwQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78061-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 00:13:06 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BD3C17F01C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 00:13:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E73BF3070FC3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 23:12:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DCAC37E2FF;
	Mon, 23 Feb 2026 23:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GqYlrgzk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC07037E2FD;
	Mon, 23 Feb 2026 23:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771888339; cv=none; b=ZdP7mJ2Wr1XR5j3hOOItkH8aIUdE8oDr3alYbCV1taKuxargsNtA2uPreIBk7BtnxX291feDz7WRbOiwO2Eu4u/TqtzkdBB8tkCMNH2+YiP0mCbsIasFiirJIuH3wJjC0yhLmUU5K0Vnw3qDoEsVcKbqGckxwSn4GHMVGnS1Bfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771888339; c=relaxed/simple;
	bh=Po2cyidEMBnTLmusH90mwvIrhKJrNCTURMilPGGsC34=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TBLeE3T/rdoswYFqfCWPLmGRDMcH7PiyIIkuGeYNRO9Ul2e6EH3mnst2pvXOzCHANAOrTgEY/4LU9dtdDftMQJQtGaaYUpPum17jM78OA3bYRF1i8inDRvewVZEsarmgZJm8yaDDRKNww6r8SOOsXux7wPOXf+xnLzqYD+YoW+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GqYlrgzk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55FDBC116C6;
	Mon, 23 Feb 2026 23:12:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771888339;
	bh=Po2cyidEMBnTLmusH90mwvIrhKJrNCTURMilPGGsC34=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=GqYlrgzk6NZjAMH3JxeqDtEyxtE4szwhRU9Iei4OCKxZ1GbGjoabU24MYgE+6WtGL
	 yLqHHBQNzKX69D6q/urZAKPFvdQrdJqOnuq4XKhjGoU2mMlkFu0gnVfkvKkEjqpngu
	 xkuvUZGdeQZqA+tVcGg4Z1NEpCpDRyIIWZzP+rStXrbTxGcsnKXY6Yxq6l1lrdWglN
	 4ZpCNXQtjxal3NtLyWuYAYyL7p/rUaFdZ7JbkZUxmm9eyu4delx5t1o/WsCDT7aC47
	 xf0qUqP6TmLPQwZEZ2xmGJulG7PzOyJ2kwbLzLAAClOz36xxue0DptV/HBc9a/9V01
	 jTlUiMSXWcazw==
Date: Mon, 23 Feb 2026 15:12:18 -0800
Subject: [PATCH 14/33] fuse: implement direct IO with iomap
From: "Darrick J. Wong" <djwong@kernel.org>
To: miklos@szeredi.hu, djwong@kernel.org
Cc: joannelkoong@gmail.com, bpf@vger.kernel.org, bernd@bsbernd.com,
 neal@gompa.dev, linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org
Message-ID: <177188734544.3935739.16352870779416290596.stgit@frogsfrogsfrogs>
In-Reply-To: <177188734044.3935739.1368557343243072212.stgit@frogsfrogsfrogs>
References: <177188734044.3935739.1368557343243072212.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,bsbernd.com,gompa.dev];
	TAGGED_FROM(0.00)[bounces-78061-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MIME_TRACE(0.00)[0:+];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[djwong@kernel.org,linux-fsdevel@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6BD3C17F01C
X-Rspamd-Action: no action

From: Darrick J. Wong <djwong@kernel.org>

Start implementing the fuse-iomap file I/O paths by adding direct I/O
support and all the signalling flags that come with it.  Buffered I/O
is much more complicated, so we leave that to a subsequent patch.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/fuse/fuse_i.h          |   20 +++
 fs/fuse/fuse_iomap.h      |   18 ++
 include/uapi/linux/fuse.h |   27 ++++
 fs/fuse/dir.c             |   13 ++
 fs/fuse/file.c            |   29 ++++
 fs/fuse/fuse_iomap.c      |  334 +++++++++++++++++++++++++++++++++++++++++++++
 fs/fuse/inode.c           |    3 
 fs/fuse/iomode.c          |    2 
 8 files changed, 440 insertions(+), 6 deletions(-)


diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index 011b252a437855..d1724bf8e87b93 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -188,6 +188,11 @@ struct fuse_inode {
 
 			/* waitq for direct-io completion */
 			wait_queue_head_t direct_io_waitq;
+
+#ifdef CONFIG_FUSE_IOMAP
+			/* file size as reported by fuse server */
+			loff_t i_disk_size;
+#endif
 		};
 
 		/* readdir cache (directory only) */
@@ -656,6 +661,16 @@ struct fuse_sync_bucket {
 	struct rcu_head rcu;
 };
 
+#ifdef CONFIG_FUSE_IOMAP
+struct fuse_iomap_conn {
+	/* fuse server doesn't implement iomap_end */
+	unsigned int no_end:1;
+
+	/* fuse server doesn't implement iomap_ioend */
+	unsigned int no_ioend:1;
+};
+#endif
+
 /**
  * A Fuse connection.
  *
@@ -1007,6 +1022,11 @@ struct fuse_conn {
 	struct idr backing_files_map;
 #endif
 
+#ifdef CONFIG_FUSE_IOMAP
+	/** iomap information */
+	struct fuse_iomap_conn iomap_conn;
+#endif
+
 #ifdef CONFIG_FUSE_IO_URING
 	/**  uring connection information*/
 	struct fuse_ring *ring;
diff --git a/fs/fuse/fuse_iomap.h b/fs/fuse/fuse_iomap.h
index 8ba30a496545f5..476e1b869d1906 100644
--- a/fs/fuse/fuse_iomap.h
+++ b/fs/fuse/fuse_iomap.h
@@ -38,6 +38,17 @@ int fuse_iomap_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
 		      u64 start, u64 length);
 loff_t fuse_iomap_lseek(struct file *file, loff_t offset, int whence);
 sector_t fuse_iomap_bmap(struct address_space *mapping, sector_t block);
+
+void fuse_iomap_open(struct inode *inode, struct file *file);
+int fuse_iomap_finish_open(const struct fuse_file *ff,
+			   const struct inode *inode);
+void fuse_iomap_open_truncate(struct inode *inode);
+
+void fuse_iomap_set_disk_size(struct fuse_inode *fi, loff_t newsize);
+int fuse_iomap_setsize_finish(struct inode *inode, loff_t newsize);
+
+ssize_t fuse_iomap_read_iter(struct kiocb *iocb, struct iov_iter *to);
+ssize_t fuse_iomap_write_iter(struct kiocb *iocb, struct iov_iter *from);
 #else
 # define fuse_iomap_enabled(...)		(false)
 # define fuse_has_iomap(...)			(false)
@@ -49,6 +60,13 @@ sector_t fuse_iomap_bmap(struct address_space *mapping, sector_t block);
 # define fuse_iomap_fiemap			NULL
 # define fuse_iomap_lseek(...)			(-ENOSYS)
 # define fuse_iomap_bmap(...)			(-ENOSYS)
+# define fuse_iomap_open(...)			((void)0)
+# define fuse_iomap_finish_open(...)		(-ENOSYS)
+# define fuse_iomap_open_truncate(...)		((void)0)
+# define fuse_iomap_set_disk_size(...)		((void)0)
+# define fuse_iomap_setsize_finish(...)		(-ENOSYS)
+# define fuse_iomap_read_iter(...)		(-ENOSYS)
+# define fuse_iomap_write_iter(...)		(-ENOSYS)
 #endif /* CONFIG_FUSE_IOMAP */
 
 #endif /* _FS_FUSE_IOMAP_H */
diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
index 88f76f4be749a7..543965b2f8fb37 100644
--- a/include/uapi/linux/fuse.h
+++ b/include/uapi/linux/fuse.h
@@ -677,6 +677,7 @@ enum fuse_opcode {
 	FUSE_STATX		= 52,
 	FUSE_COPY_FILE_RANGE_64	= 53,
 
+	FUSE_IOMAP_IOEND	= 4093,
 	FUSE_IOMAP_BEGIN	= 4094,
 	FUSE_IOMAP_END		= 4095,
 
@@ -1411,4 +1412,30 @@ struct fuse_iomap_end_in {
 	struct fuse_iomap_io	map;
 };
 
+/* out of place write extent */
+#define FUSE_IOMAP_IOEND_SHARED		(1U << 0)
+/* unwritten extent */
+#define FUSE_IOMAP_IOEND_UNWRITTEN	(1U << 1)
+/* don't merge into previous ioend */
+#define FUSE_IOMAP_IOEND_BOUNDARY	(1U << 2)
+/* is direct I/O */
+#define FUSE_IOMAP_IOEND_DIRECT		(1U << 3)
+/* is append ioend */
+#define FUSE_IOMAP_IOEND_APPEND		(1U << 4)
+
+struct fuse_iomap_ioend_in {
+	uint32_t flags;		/* FUSE_IOMAP_IOEND_* */
+	int32_t error;		/* negative errno or 0 */
+	uint64_t attr_ino;	/* matches fuse_attr:ino */
+	uint64_t pos;		/* file position, in bytes */
+	uint64_t new_addr;	/* disk offset of new mapping, in bytes */
+	uint64_t written;	/* bytes processed */
+	uint32_t dev;		/* device cookie */
+	uint32_t pad;		/* zero */
+};
+
+struct fuse_iomap_ioend_out {
+	uint64_t newsize;	/* new ondisk size */
+};
+
 #endif /* _LINUX_FUSE_H */
diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index e16facbde126ef..dcf5ccbc57c7be 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -907,6 +907,10 @@ static int fuse_create_open(struct mnt_idmap *idmap, struct inode *dir,
 		goto out_acl_release;
 
 	fuse_dir_changed(dir);
+
+	if (fuse_inode_has_iomap(inode))
+		fuse_iomap_open(inode, file);
+
 	err = generic_file_open(inode, file);
 	if (!err) {
 		file->private_data = ff;
@@ -1948,6 +1952,9 @@ static int fuse_dir_open(struct inode *inode, struct file *file)
 	if (fuse_is_bad(inode))
 		return -EIO;
 
+	if (fuse_inode_has_iomap(inode))
+		fuse_iomap_open(inode, file);
+
 	err = generic_file_open(inode, file);
 	if (err)
 		return err;
@@ -2308,6 +2315,12 @@ int fuse_do_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
 		goto error;
 	}
 
+	if (is_iomap && is_truncate) {
+		err = fuse_iomap_setsize_finish(inode, outarg.attr.size);
+		if (err)
+			goto error;
+	}
+
 	spin_lock(&fi->lock);
 	/* the kernel maintains i_mtime locally */
 	if (trust_local_cmtime) {
diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index e81571aaef15fe..ae320026f0648f 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -216,7 +216,10 @@ int fuse_finish_open(struct inode *inode, struct file *file)
 	struct fuse_conn *fc = get_fuse_conn(inode);
 	int err;
 
-	err = fuse_file_io_open(file, inode);
+	if (fuse_inode_has_iomap(inode))
+		err = fuse_iomap_finish_open(ff, inode);
+	else
+		err = fuse_file_io_open(file, inode);
 	if (err)
 		return err;
 
@@ -259,6 +262,9 @@ static int fuse_open(struct inode *inode, struct file *file)
 	if (fuse_is_bad(inode))
 		return -EIO;
 
+	if (is_iomap)
+		fuse_iomap_open(inode, file);
+
 	err = generic_file_open(inode, file);
 	if (err)
 		return err;
@@ -289,9 +295,11 @@ static int fuse_open(struct inode *inode, struct file *file)
 	if ((is_wb_truncate || dax_truncate) && !is_iomap)
 		fuse_release_nowrite(inode);
 	if (!err) {
-		if (is_truncate)
+		if (is_truncate) {
 			truncate_pagecache(inode, 0);
-		else if (!(ff->open_flags & FOPEN_KEEP_CACHE))
+			if (is_iomap)
+				fuse_iomap_open_truncate(inode);
+		} else if (!(ff->open_flags & FOPEN_KEEP_CACHE))
 			invalidate_inode_pages2(inode->i_mapping);
 	}
 	if (dax_truncate)
@@ -1822,6 +1830,9 @@ static ssize_t fuse_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
 	if (fuse_is_bad(inode))
 		return -EIO;
 
+	if (fuse_inode_has_iomap(inode))
+		return fuse_iomap_read_iter(iocb, to);
+
 	if (FUSE_IS_DAX(inode))
 		return fuse_dax_read_iter(iocb, to);
 
@@ -1843,6 +1854,9 @@ static ssize_t fuse_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
 	if (fuse_is_bad(inode))
 		return -EIO;
 
+	if (fuse_inode_has_iomap(inode))
+		return fuse_iomap_write_iter(iocb, from);
+
 	if (FUSE_IS_DAX(inode))
 		return fuse_dax_write_iter(iocb, from);
 
@@ -2955,7 +2969,9 @@ static long fuse_file_fallocate(struct file *file, int mode, loff_t offset,
 		.length = length,
 		.mode = mode
 	};
+	loff_t newsize = 0;
 	int err;
+	const bool is_iomap = fuse_inode_has_iomap(inode);
 	bool block_faults = FUSE_IS_DAX(inode) &&
 		(!(mode & FALLOC_FL_KEEP_SIZE) ||
 		 (mode & (FALLOC_FL_PUNCH_HOLE | FALLOC_FL_ZERO_RANGE)));
@@ -2988,6 +3004,7 @@ static long fuse_file_fallocate(struct file *file, int mode, loff_t offset,
 		err = inode_newsize_ok(inode, offset + length);
 		if (err)
 			goto out;
+		newsize = offset + length;
 	}
 
 	err = file_modified(file);
@@ -3012,6 +3029,12 @@ static long fuse_file_fallocate(struct file *file, int mode, loff_t offset,
 
 	/* we could have extended the file */
 	if (!(mode & FALLOC_FL_KEEP_SIZE)) {
+		if (is_iomap && newsize > 0) {
+			err = fuse_iomap_setsize_finish(inode, newsize);
+			if (err)
+				goto out;
+		}
+
 		if (fuse_write_update_attr(inode, offset + length, length))
 			file_update_time(file);
 	}
diff --git a/fs/fuse/fuse_iomap.c b/fs/fuse/fuse_iomap.c
index be922888ae9e8a..4816e26a1ac76b 100644
--- a/fs/fuse/fuse_iomap.c
+++ b/fs/fuse/fuse_iomap.c
@@ -476,10 +476,15 @@ static int fuse_iomap_begin(struct inode *inode, loff_t pos, loff_t count,
 }
 
 /* Decide if we send FUSE_IOMAP_END to the fuse server */
-static bool fuse_should_send_iomap_end(const struct iomap *iomap,
+static bool fuse_should_send_iomap_end(const struct fuse_mount *fm,
+				       const struct iomap *iomap,
 				       unsigned int opflags, loff_t count,
 				       ssize_t written)
 {
+	/* Not implemented on fuse server */
+	if (fm->fc->iomap_conn.no_end)
+		return false;
+
 	/* fuse server demanded an iomap_end call. */
 	if (iomap->flags & FUSE_IOMAP_F_WANT_IOMAP_END)
 		return true;
@@ -504,7 +509,7 @@ static int fuse_iomap_end(struct inode *inode, loff_t pos, loff_t count,
 	struct fuse_mount *fm = get_fuse_mount(inode);
 	int err;
 
-	if (fuse_should_send_iomap_end(iomap, opflags, count, written)) {
+	if (fuse_should_send_iomap_end(fm, iomap, opflags, count, written)) {
 		struct fuse_iomap_end_in inarg = {
 			.opflags = fuse_iomap_op_to_server(opflags),
 			.attr_ino = fi->orig_ino,
@@ -529,6 +534,7 @@ static int fuse_iomap_end(struct inode *inode, loff_t pos, loff_t count,
 			 * libfuse returns ENOSYS for servers that don't
 			 * implement iomap_end
 			 */
+			fm->fc->iomap_conn.no_end = 1;
 			err = 0;
 		}
 		if (err) {
@@ -545,6 +551,122 @@ static const struct iomap_ops fuse_iomap_ops = {
 	.iomap_end		= fuse_iomap_end,
 };
 
+static inline bool
+fuse_should_send_iomap_ioend(const struct fuse_mount *fm,
+			     const struct fuse_iomap_ioend_in *inarg)
+{
+	/* Not implemented on fuse server */
+	if (fm->fc->iomap_conn.no_ioend)
+		return false;
+
+	/* Always send an ioend for errors. */
+	if (inarg->error)
+		return true;
+
+	/* Send an ioend if we performed an IO involving metadata changes. */
+	return inarg->written > 0 &&
+	       (inarg->flags & (FUSE_IOMAP_IOEND_SHARED |
+				FUSE_IOMAP_IOEND_UNWRITTEN |
+				FUSE_IOMAP_IOEND_APPEND));
+}
+
+int
+fuse_iomap_setsize_finish(
+	struct inode		*inode,
+	loff_t			newsize)
+{
+	struct fuse_inode *fi = get_fuse_inode(inode);
+
+	ASSERT(fuse_inode_has_iomap(inode));
+
+	fi->i_disk_size = newsize;
+	return 0;
+}
+
+/*
+ * Fast and loose check if this write could update the on-disk inode size.
+ */
+static inline bool fuse_ioend_is_append(const struct fuse_inode *fi,
+					loff_t pos, size_t written)
+{
+	return pos + written > fi->i_disk_size;
+}
+
+static int fuse_iomap_ioend(struct inode *inode, loff_t pos, size_t written,
+			    int error, unsigned ioendflags,
+			    struct block_device *bdev, sector_t new_addr)
+{
+	struct fuse_inode *fi = get_fuse_inode(inode);
+	struct fuse_mount *fm = get_fuse_mount(inode);
+	struct fuse_iomap_ioend_in inarg = {
+		.flags = ioendflags,
+		.error = error,
+		.attr_ino = fi->orig_ino,
+		.pos = pos,
+		.written = written,
+		.dev = fuse_iomap_find_backing_id(fm->fc, bdev),
+		.new_addr = new_addr,
+	};
+	struct fuse_iomap_ioend_out outarg = {
+		.newsize = max_t(loff_t, fi->i_disk_size, pos + written),
+	};
+
+	if (fuse_ioend_is_append(fi, pos, written))
+		inarg.flags |= FUSE_IOMAP_IOEND_APPEND;
+
+	if (fuse_should_send_iomap_ioend(fm, &inarg)) {
+		FUSE_ARGS(args);
+		int iomap_error;
+
+		args.opcode = FUSE_IOMAP_IOEND;
+		args.nodeid = get_node_id(inode);
+		args.in_numargs = 1;
+		args.in_args[0].size = sizeof(inarg);
+		args.in_args[0].value = &inarg;
+		args.out_numargs = 1;
+		args.out_args[0].size = sizeof(outarg);
+		args.out_args[0].value = &outarg;
+		iomap_error = fuse_simple_request(fm, &args);
+		switch (iomap_error) {
+		case -ENOSYS:
+			/*
+			 * fuse servers can return ENOSYS if ioend processing
+			 * is never needed for this filesystem.  Don't pass
+			 * that up to iomap.
+			 */
+			fm->fc->iomap_conn.no_ioend = 1;
+			break;
+		case 0:
+			break;
+		default:
+			/*
+			 * If the write IO failed, return the failure code to
+			 * the caller no matter what happens with the ioend.
+			 * If the write IO succeeded but the ioend did not,
+			 * pass the new error up to the caller.
+			 */
+			if (!error)
+				error = iomap_error;
+			break;
+		}
+	}
+
+	/*
+	 * Pass whatever error iomap gave us (or any new errors since then)
+	 * back to iomap.
+	 */
+	if (error)
+		return error;
+
+	/*
+	 * If there weren't any ioend errors, update the incore isize, which
+	 * confusingly takes the new i_size as "pos".
+	 */
+	fi->i_disk_size = outarg.newsize;
+	fuse_write_update_attr(inode, pos + written, written);
+	return 0;
+}
+
 static int fuse_iomap_may_admin(struct fuse_conn *fc, unsigned int flags)
 {
 	if (!fc->iomap)
@@ -739,3 +861,211 @@ loff_t fuse_iomap_lseek(struct file *file, loff_t offset, int whence)
 		return offset;
 	return vfs_setpos(file, offset, inode->i_sb->s_maxbytes);
 }
+
+void fuse_iomap_open(struct inode *inode, struct file *file)
+{
+	ASSERT(fuse_inode_has_iomap(inode));
+
+	file->f_mode |= FMODE_NOWAIT | FMODE_CAN_ODIRECT;
+}
+
+int fuse_iomap_finish_open(const struct fuse_file *ff,
+			   const struct inode *inode)
+{
+	ASSERT(fuse_inode_has_iomap(inode));
+
+	/* no weird modes, iomap only handles seekable regular files */
+	if (ff->open_flags & (FOPEN_PASSTHROUGH |
+			      FOPEN_STREAM |
+			      FOPEN_NONSEEKABLE))
+		return -EINVAL;
+
+	return 0;
+}
+
+enum fuse_ilock_type {
+	SHARED,
+	EXCL,
+};
+
+static int fuse_iomap_ilock_iocb(const struct kiocb *iocb,
+				 enum fuse_ilock_type type)
+{
+	struct inode *inode = file_inode(iocb->ki_filp);
+
+	if (iocb->ki_flags & IOCB_NOWAIT) {
+		switch (type) {
+		case SHARED:
+			return inode_trylock_shared(inode) ? 0 : -EAGAIN;
+		case EXCL:
+			return inode_trylock(inode) ? 0 : -EAGAIN;
+		default:
+			ASSERT(0);
+			return -EIO;
+		}
+
+		/* shut up gcc */
+		return 0;
+	}
+
+	switch (type) {
+	case SHARED:
+		inode_lock_shared(inode);
+		break;
+	case EXCL:
+		inode_lock(inode);
+		break;
+	default:
+		ASSERT(0);
+		return -EIO;
+	}
+
+	return 0;
+}
+
+static ssize_t fuse_iomap_direct_read(struct kiocb *iocb, struct iov_iter *to)
+{
+	struct inode *inode = file_inode(iocb->ki_filp);
+	ssize_t ret;
+
+	if (!iov_iter_count(to))
+		return 0; /* skip atime */
+
+	ret = fuse_iomap_ilock_iocb(iocb, SHARED);
+	if (ret)
+		return ret;
+	ret = iomap_dio_rw(iocb, to, &fuse_iomap_ops, NULL, 0, NULL, 0);
+	if (ret > 0)
+		file_accessed(iocb->ki_filp);
+	inode_unlock_shared(inode);
+
+	return ret;
+}
+
+static int fuse_iomap_dio_write_end_io(struct kiocb *iocb, ssize_t written,
+				       int error, unsigned dioflags)
+{
+	struct inode *inode = file_inode(iocb->ki_filp);
+	unsigned int ioendflags = FUSE_IOMAP_IOEND_DIRECT;
+
+	if (fuse_is_bad(inode))
+		return -EIO;
+
+	ASSERT(fuse_inode_has_iomap(inode));
+
+	if (dioflags & IOMAP_DIO_COW)
+		ioendflags |= FUSE_IOMAP_IOEND_SHARED;
+	if (dioflags & IOMAP_DIO_UNWRITTEN)
+		ioendflags |= FUSE_IOMAP_IOEND_UNWRITTEN;
+
+	return fuse_iomap_ioend(inode, iocb->ki_pos, written, error,
+				ioendflags, NULL, FUSE_IOMAP_NULL_ADDR);
+}
+
+static const struct iomap_dio_ops fuse_iomap_dio_write_ops = {
+	.end_io		= fuse_iomap_dio_write_end_io,
+};
+
+static ssize_t
+fuse_iomap_write_checks(
+	struct kiocb		*iocb,
+	struct iov_iter		*from)
+{
+	ssize_t			error;
+
+	error = generic_write_checks(iocb, from);
+	if (error <= 0)
+		return error;
+
+	return kiocb_modified(iocb);
+}
+
+static ssize_t fuse_iomap_direct_write(struct kiocb *iocb,
+				       struct iov_iter *from)
+{
+	struct inode *inode = file_inode(iocb->ki_filp);
+	loff_t blockmask = i_blocksize(inode) - 1;
+	size_t count = iov_iter_count(from);
+	unsigned int flags = IOMAP_DIO_COMP_WORK;
+	ssize_t ret;
+
+	if (!count)
+		return 0;
+
+	/*
+	 * Unaligned direct writes require zeroing of unwritten head and tail
+	 * blocks.  Extending writes require zeroing of post-EOF tail blocks.
+	 * The zeroing writes must complete before we return the direct write
+	 * to userspace.  Don't even bother trying the fast path.
+	 */
+	if ((iocb->ki_pos | count) & blockmask)
+		flags |= IOMAP_DIO_FORCE_WAIT;
+
+	ret = fuse_iomap_ilock_iocb(iocb, EXCL);
+	if (ret)
+		goto out_dsync;
+
+	ret = fuse_iomap_write_checks(iocb, from);
+	if (ret)
+		goto out_unlock;
+
+	/*
+	 * If we are doing exclusive unaligned I/O, this must be the only I/O
+	 * in-flight.  Otherwise we risk data corruption due to unwritten
+	 * extent conversions from the AIO end_io handler.  Wait for all other
+	 * I/O to drain first.
+	 */
+	if (flags & IOMAP_DIO_FORCE_WAIT)
+		inode_dio_wait(inode);
+
+	ret = iomap_dio_rw(iocb, from, &fuse_iomap_ops,
+			   &fuse_iomap_dio_write_ops, flags, NULL, 0);
+out_unlock:
+	inode_unlock(inode);
+out_dsync:
+	return ret;
+}
+
+void fuse_iomap_set_disk_size(struct fuse_inode *fi, loff_t newsize)
+{
+	if (fuse_inode_has_iomap(&fi->inode))
+		fi->i_disk_size = newsize;
+}
+
+void fuse_iomap_open_truncate(struct inode *inode)
+{
+	struct fuse_inode *fi = get_fuse_inode(inode);
+
+	ASSERT(fuse_inode_has_iomap(inode));
+
+	fi->i_disk_size = 0;
+}
+
+static inline bool fuse_iomap_force_directio(const struct kiocb *iocb)
+{
+	struct fuse_file *ff = iocb->ki_filp->private_data;
+
+	return ff->open_flags & FOPEN_DIRECT_IO;
+}
+
+ssize_t fuse_iomap_read_iter(struct kiocb *iocb, struct iov_iter *to)
+{
+	const bool force_directio = fuse_iomap_force_directio(iocb);
+
+	ASSERT(fuse_inode_has_iomap(file_inode(iocb->ki_filp)));
+
+	if ((iocb->ki_flags & IOCB_DIRECT) || force_directio)
+		return fuse_iomap_direct_read(iocb, to);
+	return -EIO;
+}
+
+ssize_t fuse_iomap_write_iter(struct kiocb *iocb, struct iov_iter *from)
+{
+	const bool force_directio = fuse_iomap_force_directio(iocb);
+
+	ASSERT(fuse_inode_has_iomap(file_inode(iocb->ki_filp)));
+
+	if ((iocb->ki_flags & IOCB_DIRECT) || force_directio)
+		return fuse_iomap_direct_write(iocb, from);
+	return -EIO;
+}
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index fae33371c33da6..039a780749da30 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -303,6 +303,8 @@ void fuse_change_attributes_common(struct inode *inode, struct fuse_attr *attr,
 	else
 		fi->cached_i_blkbits = inode->i_sb->s_blocksize_bits;
 
+	fuse_iomap_set_disk_size(fi, attr->size);
+
 	/*
 	 * Don't set the sticky bit in i_mode, unless we want the VFS
 	 * to check permissions.  This prevents failures due to the
@@ -352,6 +354,7 @@ static void fuse_change_attributes_i(struct inode *inode, struct fuse_attr *attr
 	 * inode.
 	 */
 	cache_mask = fuse_get_cache_mask(inode);
+	fuse_iomap_set_disk_size(fi, attr->size);
 	if (cache_mask & STATX_SIZE)
 		attr->size = i_size_read(inode);
 
diff --git a/fs/fuse/iomode.c b/fs/fuse/iomode.c
index 9be9ae3520003e..ed666b39cf8af4 100644
--- a/fs/fuse/iomode.c
+++ b/fs/fuse/iomode.c
@@ -204,7 +204,7 @@ int fuse_file_io_open(struct file *file, struct inode *inode)
 	 * io modes are not relevant with DAX and with server that does not
 	 * implement open.
 	 */
-	if (fuse_inode_has_iomap(inode) || FUSE_IS_DAX(inode) || !ff->args)
+	if (FUSE_IS_DAX(inode) || !ff->args)
 		return 0;
 
 	/*


