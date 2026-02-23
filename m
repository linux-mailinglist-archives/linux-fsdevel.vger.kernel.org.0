Return-Path: <linux-fsdevel+bounces-78076-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iEozMcTfnGnCLwQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78076-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 00:16:20 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C3FE17F149
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 00:16:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 44B06303123B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 23:16:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E95FB37F725;
	Mon, 23 Feb 2026 23:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jhMaCHFU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7546237D10B;
	Mon, 23 Feb 2026 23:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771888575; cv=none; b=ATQeja77thTeI6oBHZGc4KNDtL9ZE6Maf+JTR61+I/GMgWqHTZunvNVbkqlMwk1vGJfxdFvnDXuC4iqcnDA+/Exr8vUG2OknuIjqSin/Stw8PdO8X13Fy9pZhToqdcaDs6V451NJLjk7SFgonMapwAHeUOuMIzcxFEjUZttHNB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771888575; c=relaxed/simple;
	bh=ANHpTZ5ju0DeHbecwV8PRkCBorOYWj+nv6X+1q+Gtfs=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PQaOEWAyyJvDSDUi4L2FHzI1Fr3Z81Gz2WzQofLtBim+j6pYaU7zZ1wUzSKjdOJYjWtXc1XNlJOrFt4VoezUfc5N6FCaJhy1Tp87fvx11IKr62xLYVyvT03r83s/LMW75fU3Ug0/mHfYbi34H1ombkhyjlmYPxVM3j+M+UbMOy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jhMaCHFU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F9F6C116C6;
	Mon, 23 Feb 2026 23:16:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771888575;
	bh=ANHpTZ5ju0DeHbecwV8PRkCBorOYWj+nv6X+1q+Gtfs=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=jhMaCHFU5Ito3k6U6ysvattfrFHJ0aPidKf8oOYHdZnGE60rcIxlmLw3+PChrMiS0
	 14H9Ve86euRibKLFzuzXCCK494dU+7AzNhIqkGDMw791Pldwg6XL3q8+yt5DFwSWjU
	 gWPHCADCCKS+uUXcfXDBcPxalHXD7gaLZ/Llykzov6KhMdgup5T4rwLGLZuqfrVfg+
	 jdBx6S92aI02YrbrEERwyUdaRWf2x+bu2yiL7Qt0IJz8drDNuwohBMVR/DGOQWkS6H
	 XNEsI13GM5BBC0U29kZR07+/PizovELuBvJuyKt5N0sg/FyXRsnPfp80XWyDAlHFf6
	 EKD7sZFPs9b+A==
Date: Mon, 23 Feb 2026 15:16:14 -0800
Subject: [PATCH 29/33] fuse: support atomic writes with iomap
From: "Darrick J. Wong" <djwong@kernel.org>
To: miklos@szeredi.hu, djwong@kernel.org
Cc: joannelkoong@gmail.com, bpf@vger.kernel.org, bernd@bsbernd.com,
 neal@gompa.dev, linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org
Message-ID: <177188734865.3935739.5549380606123677673.stgit@frogsfrogsfrogs>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,bsbernd.com,gompa.dev];
	TAGGED_FROM(0.00)[bounces-78076-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[djwong@kernel.org,linux-fsdevel@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6C3FE17F149
X-Rspamd-Action: no action

From: Darrick J. Wong <djwong@kernel.org>

Enable untorn writes of up to a single fsblock, if iomap is enabled.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/fuse/fuse_i.h          |    2 ++
 fs/fuse/fuse_iomap.h      |    7 +++++++
 include/uapi/linux/fuse.h |    5 +++++
 fs/fuse/fuse_iomap.c      |   45 ++++++++++++++++++++++++++++++++++++++++++++-
 4 files changed, 58 insertions(+), 1 deletion(-)


diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index 153aa441a78320..f96c69c755bd9b 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -276,6 +276,8 @@ enum {
 	FUSE_I_EXCLUSIVE,
 	/* Use iomap for this inode */
 	FUSE_I_IOMAP,
+	/* Enable untorn writes */
+	FUSE_I_ATOMIC,
 };
 
 struct fuse_conn;
diff --git a/fs/fuse/fuse_iomap.h b/fs/fuse/fuse_iomap.h
index d4a4d9f0313edf..1d9d39383ca9b2 100644
--- a/fs/fuse/fuse_iomap.h
+++ b/fs/fuse/fuse_iomap.h
@@ -35,6 +35,13 @@ static inline bool fuse_inode_has_iomap(const struct inode *inode)
 	return test_bit(FUSE_I_IOMAP, &fi->state);
 }
 
+static inline bool fuse_inode_has_atomic(const struct inode *inode)
+{
+	const struct fuse_inode *fi = get_fuse_inode(inode);
+
+	return test_bit(FUSE_I_ATOMIC, &fi->state);
+}
+
 int fuse_iomap_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
 		      u64 start, u64 length);
 loff_t fuse_iomap_lseek(struct file *file, loff_t offset, int whence);
diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
index aa96b4cbdfa255..c454cea83083d3 100644
--- a/include/uapi/linux/fuse.h
+++ b/include/uapi/linux/fuse.h
@@ -248,6 +248,7 @@
  *  - add FUSE_ATTR_IOMAP to enable iomap for specific inodes
  *  - add FUSE_IOMAP_CONFIG so the fuse server can configure more fs geometry
  *  - add FUSE_NOTIFY_IOMAP_DEV_INVAL to invalidate iomap bdev ranges
+ *  - add FUSE_ATTR_ATOMIC for single-fsblock atomic write support
  */
 
 #ifndef _LINUX_FUSE_H
@@ -604,11 +605,13 @@ struct fuse_file_lock {
  * FUSE_ATTR_EXCLUSIVE: This file can only be modified by this mount, so the
  * kernel can use cached attributes more aggressively (e.g. ACL inheritance)
  * FUSE_ATTR_IOMAP: Use iomap for this inode
+ * FUSE_ATTR_ATOMIC: Enable untorn writes
  */
 #define FUSE_ATTR_SUBMOUNT      (1 << 0)
 #define FUSE_ATTR_DAX		(1 << 1)
 #define FUSE_ATTR_EXCLUSIVE	(1 << 2)
 #define FUSE_ATTR_IOMAP		(1 << 3)
+#define FUSE_ATTR_ATOMIC	(1 << 4)
 
 /**
  * Open flags
@@ -1176,6 +1179,8 @@ struct fuse_backing_map {
 
 /* basic file I/O functionality through iomap */
 #define FUSE_IOMAP_SUPPORT_FILEIO	(1ULL << 0)
+/* untorn writes through iomap */
+#define FUSE_IOMAP_SUPPORT_ATOMIC	(1ULL << 1)
 struct fuse_iomap_support {
 	uint64_t	flags;
 	uint64_t	padding;
diff --git a/fs/fuse/fuse_iomap.c b/fs/fuse/fuse_iomap.c
index 6230819d0962a2..84bc8bbd2eeb85 100644
--- a/fs/fuse/fuse_iomap.c
+++ b/fs/fuse/fuse_iomap.c
@@ -1109,6 +1109,20 @@ static inline void fuse_inode_clear_iomap(struct inode *inode)
 	clear_bit(FUSE_I_IOMAP, &fi->state);
 }
 
+static inline void fuse_inode_set_atomic(struct inode *inode)
+{
+	struct fuse_inode *fi = get_fuse_inode(inode);
+
+	set_bit(FUSE_I_ATOMIC, &fi->state);
+}
+
+static inline void fuse_inode_clear_atomic(struct inode *inode)
+{
+	struct fuse_inode *fi = get_fuse_inode(inode);
+
+	clear_bit(FUSE_I_ATOMIC, &fi->state);
+}
+
 void fuse_iomap_init_inode(struct inode *inode, struct fuse_attr *attr)
 {
 	ASSERT(get_fuse_conn(inode)->iomap);
@@ -1135,6 +1149,8 @@ void fuse_iomap_init_inode(struct inode *inode, struct fuse_attr *attr)
 	}
 
 	fuse_inode_set_iomap(inode);
+	if (attr->flags & FUSE_ATTR_ATOMIC)
+		fuse_inode_set_atomic(inode);
 
 	trace_fuse_iomap_init_inode(inode);
 }
@@ -1145,6 +1161,7 @@ void fuse_iomap_evict_inode(struct inode *inode)
 
 	trace_fuse_iomap_evict_inode(inode);
 
+	fuse_inode_clear_atomic(inode);
 	fuse_inode_clear_iomap(inode);
 }
 
@@ -1222,6 +1239,8 @@ void fuse_iomap_open(struct inode *inode, struct file *file)
 	ASSERT(fuse_inode_has_iomap(inode));
 
 	file->f_mode |= FMODE_NOWAIT | FMODE_CAN_ODIRECT;
+	if (fuse_inode_has_atomic(inode))
+		file->f_mode |= FMODE_CAN_ATOMIC_WRITE;
 }
 
 int fuse_iomap_finish_open(const struct fuse_file *ff,
@@ -1433,6 +1452,17 @@ fuse_iomap_write_checks(
 	return kiocb_modified(iocb);
 }
 
+static inline ssize_t fuse_iomap_atomic_write_valid(struct kiocb *iocb,
+						    struct iov_iter *from)
+{
+	struct inode *inode = file_inode(iocb->ki_filp);
+
+	if (iov_iter_count(from) != i_blocksize(inode))
+		return -EINVAL;
+
+	return generic_atomic_write_valid(iocb, from);
+}
+
 static ssize_t fuse_iomap_direct_write(struct kiocb *iocb,
 				       struct iov_iter *from)
 {
@@ -1447,6 +1477,12 @@ static ssize_t fuse_iomap_direct_write(struct kiocb *iocb,
 	if (!count)
 		return 0;
 
+	if (iocb->ki_flags & IOCB_ATOMIC) {
+		ret = fuse_iomap_atomic_write_valid(iocb, from);
+		if (ret)
+			return ret;
+	}
+
 	/*
 	 * Unaligned direct writes require zeroing of unwritten head and tail
 	 * blocks.  Extending writes require zeroing of post-EOF tail blocks.
@@ -1873,6 +1909,12 @@ static ssize_t fuse_iomap_buffered_write(struct kiocb *iocb,
 	if (!iov_iter_count(from))
 		return 0;
 
+	if (iocb->ki_flags & IOCB_ATOMIC) {
+		ret = fuse_iomap_atomic_write_valid(iocb, from);
+		if (ret)
+			return ret;
+	}
+
 	ret = fuse_iomap_ilock_iocb(iocb, EXCL);
 	if (ret)
 		return ret;
@@ -2169,7 +2211,8 @@ int fuse_dev_ioctl_iomap_support(struct file *file,
 	struct fuse_iomap_support ios = { };
 
 	if (fuse_iomap_enabled())
-		ios.flags = FUSE_IOMAP_SUPPORT_FILEIO;
+		ios.flags = FUSE_IOMAP_SUPPORT_FILEIO |
+			    FUSE_IOMAP_SUPPORT_ATOMIC;
 
 	if (copy_to_user(argp, &ios, sizeof(ios)))
 		return -EFAULT;


