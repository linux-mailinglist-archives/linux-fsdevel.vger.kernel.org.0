Return-Path: <linux-fsdevel+bounces-78140-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AFSGERXknGlNMAQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78140-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 00:34:45 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E60D217F98E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 00:34:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 25CC030A6DC6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 23:32:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0899537F8CD;
	Mon, 23 Feb 2026 23:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iZv2RJie"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86F3837F72C;
	Mon, 23 Feb 2026 23:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771889575; cv=none; b=l8/D26/PsaBv6FQcSV8U+dLPZxhRiNmZo2Y7OnaSTDZHTsnrW6M8DqDlAfqrsmQ4R2jbskQp30/TyDhVGzIEKZe3xO/vPWVK4rvSUILmB6UNGRvybZI/h6ueGP0uo0A0dnm0Ujy6JdkDmceKrq0ikbFa/pS6SoSxqIaG0u2JfjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771889575; c=relaxed/simple;
	bh=tBNNQv7FCZ8lsT0sl+9DZEWCwA6VuBWE6s3qAAOn3cE=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=l9jA/+8OfpIT5IofBTAcc+x2tuSCNwtzB9zlkryOSoe6hGPnfxiY+jGm4QoHqUr4Tbksz2mzWtFEg4ApStt+2i+01YfwIDBcpqjlcnwbIgX3KJ5Ih2lC2/3P3Xj/d2YZkfPVFwPVPHgkHOZehbLLlMGTyCbDE/MJ50O/yn6rXo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iZv2RJie; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36EC6C116C6;
	Mon, 23 Feb 2026 23:32:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771889575;
	bh=tBNNQv7FCZ8lsT0sl+9DZEWCwA6VuBWE6s3qAAOn3cE=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=iZv2RJieIzxgYXbnSaTYrsdRAWxzaVM0PreMNZ5QUYbzFtEYHCIxFUI8jG5/4Y+UQ
	 YRqmB7vPFq53kIidFvNBV37DC6zQtYn3RMDtyQiVB26OLXbucQL73Ug+PcU+7iEu4Q
	 vI4N8H0VwdKp9VVYWqsJPe9hNZCHtuK5FAeX8qRxtEkVAVPukmigBpoX4t3qZKYyye
	 5ABuhUdseA4twpNUW+Jr1t8Tk50ZaXD7KB4jq9OizuRRUiBM5+art3zsA2+BcI/5SB
	 Zub+f6YM/miz4lwyVaebhnYVjtRqG5JkQZR67pChkNakMB4sWzJ0V4PQfK17PGBxK6
	 O7ieynEjsGB1Q==
Date: Mon, 23 Feb 2026 15:32:54 -0800
Subject: [PATCH 1/5] libfuse: enable iomap cache management for lowlevel fuse
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, bschubert@ddn.com
Cc: bernd@bsbernd.com, miklos@szeredi.hu, neal@gompa.dev,
 linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 bpf@vger.kernel.org, joannelkoong@gmail.com
Message-ID: <177188741036.3941876.9471947691953260853.stgit@frogsfrogsfrogs>
In-Reply-To: <177188741001.3941876.16023909374412521929.stgit@frogsfrogsfrogs>
References: <177188741001.3941876.16023909374412521929.stgit@frogsfrogsfrogs>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[bsbernd.com,szeredi.hu,gompa.dev,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-78140-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[djwong@kernel.org,linux-fsdevel@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E60D217F98E
X-Rspamd-Action: no action

From: Darrick J. Wong <djwong@kernel.org>

Add the library methods so that fuse servers can manage an in-kernel
iomap cache.  This enables better performance on small IOs and is
required if the filesystem needs synchronization between pagecache
writes and writeback.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 include/fuse_common.h   |   12 +++++++
 include/fuse_kernel.h   |   27 ++++++++++++++++
 include/fuse_lowlevel.h |   41 +++++++++++++++++++++++++
 lib/fuse_lowlevel.c     |   77 +++++++++++++++++++++++++++++++++++++++++++++++
 lib/fuse_versionscript  |    2 +
 5 files changed, 159 insertions(+)


diff --git a/include/fuse_common.h b/include/fuse_common.h
index d1bd783cd667c7..313f78c9cb6632 100644
--- a/include/fuse_common.h
+++ b/include/fuse_common.h
@@ -1158,6 +1158,10 @@ int fuse_convert_to_conn_want_ext(struct fuse_conn_info *conn);
 
 /* fuse-specific mapping type indicating that writes use the read mapping */
 #define FUSE_IOMAP_TYPE_PURE_OVERWRITE	(255)
+/* fuse-specific mapping type saying the server has populated the cache */
+#define FUSE_IOMAP_TYPE_RETRY_CACHE	(254)
+/* do not upsert this mapping */
+#define FUSE_IOMAP_TYPE_NOCACHE		(253)
 
 #define FUSE_IOMAP_DEV_NULL		(0U)	/* null device cookie */
 
@@ -1281,6 +1285,14 @@ struct fuse_iomap_config{
 	int64_t s_maxbytes;	/* max file size */
 };
 
+/* invalidate to end of file */
+#define FUSE_IOMAP_INVAL_TO_EOF		(~0ULL)
+
+struct fuse_file_range {
+	uint64_t offset;	/* file offset to invalidate, bytes */
+	uint64_t length;	/* length to invalidate, bytes */
+};
+
 /* ----------------------------------------------------------- *
  * Compatibility stuff					       *
  * ----------------------------------------------------------- */
diff --git a/include/fuse_kernel.h b/include/fuse_kernel.h
index bee825a6d17ad5..f2a1e187aea3a1 100644
--- a/include/fuse_kernel.h
+++ b/include/fuse_kernel.h
@@ -251,6 +251,8 @@
  *  - add FUSE_ATTR_ATOMIC for single-fsblock atomic write support
  *  - add FUSE_ATTR_{SYNC,IMMUTABLE,APPEND} for VFS enforcement of file
  *    attributes
+ *  - add FUSE_NOTIFY_IOMAP_{UPSERT,INVAL}_MAPPINGS so fuse servers can cache
+ *    file range mappings in the kernel for iomap
  */
 
 #ifndef _LINUX_FUSE_H
@@ -718,6 +720,8 @@ enum fuse_notify_code {
 	FUSE_NOTIFY_INC_EPOCH = 8,
 	FUSE_NOTIFY_PRUNE = 9,
 	FUSE_NOTIFY_IOMAP_DEV_INVAL = 99,
+	FUSE_NOTIFY_IOMAP_UPSERT_MAPPINGS = 100,
+	FUSE_NOTIFY_IOMAP_INVAL_MAPPINGS = 101,
 };
 
 /* The read buffer is required to be at least 8k, but may be much larger */
@@ -1460,4 +1464,27 @@ struct fuse_iomap_dev_inval_out {
 	struct fuse_range range;
 };
 
+struct fuse_iomap_inval_mappings_out {
+	uint64_t nodeid;	/* Inode ID */
+	uint64_t attr_ino;	/* matches fuse_attr:ino */
+
+	/*
+	 * Range of read and mappings to invalidate.  Zero length means ignore
+	 * the range; and FUSE_IOMAP_INVAL_TO_EOF can be used for length.
+	 */
+	struct fuse_range read;
+	struct fuse_range write;
+};
+
+struct fuse_iomap_upsert_mappings_out {
+	uint64_t nodeid;	/* Inode ID */
+	uint64_t attr_ino;	/* matches fuse_attr:ino */
+
+	/* read file data from here */
+	struct fuse_iomap_io	read;
+
+	/* write file data to here, if applicable */
+	struct fuse_iomap_io	write;
+};
+
 #endif /* _LINUX_FUSE_H */
diff --git a/include/fuse_lowlevel.h b/include/fuse_lowlevel.h
index 0d7577718490ba..67fdde0a5f49d9 100644
--- a/include/fuse_lowlevel.h
+++ b/include/fuse_lowlevel.h
@@ -2258,6 +2258,47 @@ int fuse_lowlevel_iomap_device_remove(struct fuse_session *se, int device_id);
 int fuse_lowlevel_iomap_device_invalidate(struct fuse_session *se, int dev,
 					  off_t offset, off_t length);
 
+/*
+ * Upsert some file mapping information into the kernel.  This is necessary
+ * for filesystems that require coordination of mapping state changes between
+ * buffered writes and writeback, and desirable for better performance
+ * elsewhere.
+ *
+ * Added in FUSE protocol version 7.99. If the kernel does not support
+ * this (or a newer) version, the function will return -ENOSYS and do
+ * nothing.
+ *
+ * @param se the session object
+ * @param nodeid the inode number
+ * @param attr_ino inode number as told by fuse_attr::ino
+ * @param read mapping information for file reads
+ * @param write mapping information for file writes
+ * @return zero for success, -errno for failure
+ */
+int fuse_lowlevel_iomap_upsert_mappings(struct fuse_session *se,
+					fuse_ino_t nodeid, uint64_t attr_ino,
+					const struct fuse_file_iomap *read,
+					const struct fuse_file_iomap *write);
+
+/**
+ * Invalidate some file mapping information in the kernel.
+ *
+ * Added in FUSE protocol version 7.99. If the kernel does not support
+ * this (or a newer) version, the function will return -ENOSYS and do
+ * nothing.
+ *
+ * @param se the session object
+ * @param nodeid the inode number
+ * @param attr_ino inode number as told by fuse_attr::ino
+ * @param read read mapping range to invalidate
+ * @param write write mapping range to invalidate
+ * @return zero for success, -errno for failure
+ */
+int fuse_lowlevel_iomap_inval_mappings(struct fuse_session *se,
+				       fuse_ino_t nodeid, uint64_t attr_ino,
+				       const struct fuse_file_range *read,
+				       const struct fuse_file_range *write);
+
 /* ----------------------------------------------------------- *
  * Utility functions					       *
  * ----------------------------------------------------------- */
diff --git a/lib/fuse_lowlevel.c b/lib/fuse_lowlevel.c
index 7b501e2f3ef047..ea6aba18619458 100644
--- a/lib/fuse_lowlevel.c
+++ b/lib/fuse_lowlevel.c
@@ -3768,6 +3768,83 @@ int fuse_lowlevel_iomap_device_invalidate(struct fuse_session *se, int dev,
 	return send_notify_iov(se, FUSE_NOTIFY_IOMAP_DEV_INVAL, iov, 2);
 }
 
+int fuse_lowlevel_iomap_upsert_mappings(struct fuse_session *se,
+					fuse_ino_t nodeid, uint64_t attr_ino,
+					const struct fuse_file_iomap *read,
+					const struct fuse_file_iomap *write)
+{
+	struct fuse_iomap_upsert_mappings_out outarg = {
+		.nodeid		= nodeid,
+		.attr_ino	= attr_ino,
+		.read		= {
+			.type	= FUSE_IOMAP_TYPE_NOCACHE,
+		},
+		.write		= {
+			.type	= FUSE_IOMAP_TYPE_NOCACHE,
+		}
+	};
+	struct iovec iov[2];
+
+	if (!se)
+		return -EINVAL;
+
+	if (se->conn.proto_minor < 99)
+		return -ENOSYS;
+
+	if (!read && !write)
+		return 0;
+
+	if (read)
+		fuse_iomap_to_kernel(&outarg.read, read);
+
+	if (write)
+		fuse_iomap_to_kernel(&outarg.write, write);
+
+	iov[1].iov_base = &outarg;
+	iov[1].iov_len = sizeof(outarg);
+
+	return send_notify_iov(se, FUSE_NOTIFY_IOMAP_UPSERT_MAPPINGS, iov, 2);
+}
+
+static inline void
+fuse_iomap_range_to_kernel(struct fuse_range *range,
+			   const struct fuse_file_range *firange)
+{
+	range->offset = firange->offset;
+	range->length = firange->length;
+}
+
+int fuse_lowlevel_iomap_inval_mappings(struct fuse_session *se,
+				       fuse_ino_t nodeid, uint64_t attr_ino,
+				       const struct fuse_file_range *read,
+				       const struct fuse_file_range *write)
+{
+	struct fuse_iomap_inval_mappings_out outarg = {
+		.nodeid		= nodeid,
+		.attr_ino	= attr_ino,
+	};
+	struct iovec iov[2];
+
+	if (!se)
+		return -EINVAL;
+
+	if (se->conn.proto_minor < 99)
+		return -ENOSYS;
+
+	if (!read && !write)
+		return 0;
+
+	if (read)
+		fuse_iomap_range_to_kernel(&outarg.read, read);
+	if (write)
+		fuse_iomap_range_to_kernel(&outarg.write, write);
+
+	iov[1].iov_base = &outarg;
+	iov[1].iov_len = sizeof(outarg);
+
+	return send_notify_iov(se, FUSE_NOTIFY_IOMAP_INVAL_MAPPINGS, iov, 2);
+}
+
 struct fuse_retrieve_req {
 	struct fuse_notify_req nreq;
 	void *cookie;
diff --git a/lib/fuse_versionscript b/lib/fuse_versionscript
index f459d06c2f3377..ed388f8ebdb558 100644
--- a/lib/fuse_versionscript
+++ b/lib/fuse_versionscript
@@ -250,6 +250,8 @@ FUSE_3.99 {
 		fuse_fs_iomap_device_invalidate;
 		fuse_lowlevel_disable_fsreclaim;
 		fuse_loopdev_setup;
+		fuse_lowlevel_iomap_upsert_mappings;
+		fuse_lowlevel_iomap_inval_mappings;
 } FUSE_3.19;
 
 # Local Variables:


