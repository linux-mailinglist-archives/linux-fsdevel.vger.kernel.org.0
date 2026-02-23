Return-Path: <linux-fsdevel+bounces-78119-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QFDzJozinGnCLwQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78119-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 00:28:12 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 54CBC17F697
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 00:28:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D005C30A4174
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 23:27:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 127F137F8C9;
	Mon, 23 Feb 2026 23:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h/gAjqc2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9017D37F8A2;
	Mon, 23 Feb 2026 23:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771889247; cv=none; b=dAu13eMQQM4IXXVAZJMBuHwlEyfeJ+sYmLQp5FmBbhLP/PLv80wTdS2BWqhXzwHe3EqRHsO7fAz8eYJj1RBP5dYfTb9U7CAM6Czos2B6qtxwBs3f90+NPjcBhkG1IrlBt7BVuMK8FV9C+zr/FKiudgB1BE7vdD1CC9d5F+BkE6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771889247; c=relaxed/simple;
	bh=ZCLTjCW/Fr9gzwRaV7OmjQ6wJ9IWIzuEVa8F4jfEvJU=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BSfKnIno+wBr+4T2Z+EgQuhTjzlPOVicdCZuiEgGO8YrMkaFxs3o1h1iAzm7QkLlHlPggI+ZrhsPi/FnJe2ma4SeTiv2Bf5EyVCKMsROVp/XijexNtoW3rP6aTrLhJjj5xO9XUSJ7O73cJH+I8NORQJ2KTkjjAqCnb6Zn+Q5SOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h/gAjqc2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32FF5C116C6;
	Mon, 23 Feb 2026 23:27:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771889247;
	bh=ZCLTjCW/Fr9gzwRaV7OmjQ6wJ9IWIzuEVa8F4jfEvJU=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=h/gAjqc2gEkUFvV3ln00u9B9YL8f0inIZYP9dBr7r/QrJaxg8iQ9bnC1+VpHWzC3+
	 f6q7Oux5tSRMHe6Y5kScvbV6IojtzSXZBhvf+QxoQJrqHjyserdEMZs+DsBbXDM91w
	 uaLFiaBTu5dnDWG+0atI/TYJ3Jt+b8ccWWbUKBytHLTgQQ6Md3YQg2z0HIHxW2hL4Y
	 Pyie5zxYXBUNaK+YFO5gxDwSVUcVYgPO/GORviyzulRcuF2LwvHjyMLFDY0Hr04D3+
	 z/CTdVWK2Bv5kqE7hASYT8AHwQrzWjY0/AI102Se4+NF9gVjQupKCDTCe9ZuTThrho
	 Pvs2tC97l91GA==
Date: Mon, 23 Feb 2026 15:27:26 -0800
Subject: [PATCH 08/25] libfuse: add iomap ioend low level handler
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, bschubert@ddn.com
Cc: bernd@bsbernd.com, miklos@szeredi.hu, neal@gompa.dev,
 linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 bpf@vger.kernel.org, joannelkoong@gmail.com
Message-ID: <177188740079.3940670.2122541165446522370.stgit@frogsfrogsfrogs>
In-Reply-To: <177188739839.3940670.15233996351019069073.stgit@frogsfrogsfrogs>
References: <177188739839.3940670.15233996351019069073.stgit@frogsfrogsfrogs>
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
	FREEMAIL_CC(0.00)[bsbernd.com,szeredi.hu,gompa.dev,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-78119-lists,linux-fsdevel=lfdr.de];
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
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 54CBC17F697
X-Rspamd-Action: no action

From: Darrick J. Wong <djwong@kernel.org>

Teach the low level library about the iomap ioend handler, which gets
called by the kernel when we finish a file write that isn't a pure
overwrite operation.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 include/fuse_common.h   |   13 +++++++++++++
 include/fuse_kernel.h   |   16 ++++++++++++++++
 include/fuse_lowlevel.h |   34 ++++++++++++++++++++++++++++++++++
 lib/fuse_lowlevel.c     |   32 ++++++++++++++++++++++++++++++++
 lib/fuse_versionscript  |    1 +
 5 files changed, 96 insertions(+)


diff --git a/include/fuse_common.h b/include/fuse_common.h
index 58726ce43b1014..013e74a0e9eefe 100644
--- a/include/fuse_common.h
+++ b/include/fuse_common.h
@@ -1208,6 +1208,19 @@ static inline bool fuse_iomap_need_write_allocate(unsigned int opflags,
 		!(opflags & FUSE_IOMAP_OP_ZERO);
 }
 
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
+/* is pagecache writeback */
+#define FUSE_IOMAP_IOEND_WRITEBACK	(1U << 5)
+
 /* ----------------------------------------------------------- *
  * Compatibility stuff					       *
  * ----------------------------------------------------------- */
diff --git a/include/fuse_kernel.h b/include/fuse_kernel.h
index e69f9675c4b57d..732085a1b900b0 100644
--- a/include/fuse_kernel.h
+++ b/include/fuse_kernel.h
@@ -670,6 +670,7 @@ enum fuse_opcode {
 	FUSE_STATX		= 52,
 	FUSE_COPY_FILE_RANGE_64	= 53,
 
+	FUSE_IOMAP_IOEND	= 4093,
 	FUSE_IOMAP_BEGIN	= 4094,
 	FUSE_IOMAP_END		= 4095,
 
@@ -1360,4 +1361,19 @@ struct fuse_iomap_end_in {
 	struct fuse_iomap_io	map;
 };
 
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
diff --git a/include/fuse_lowlevel.h b/include/fuse_lowlevel.h
index 7f9a56b0a7eda1..a8e845ba796937 100644
--- a/include/fuse_lowlevel.h
+++ b/include/fuse_lowlevel.h
@@ -1394,6 +1394,28 @@ struct fuse_lowlevel_ops {
 	void (*iomap_end) (fuse_req_t req, fuse_ino_t nodeid, uint64_t attr_ino,
 			   off_t pos, uint64_t count, uint32_t opflags,
 			   ssize_t written, const struct fuse_file_iomap *iomap);
+
+	/**
+	 * Complete an iomap IO operation
+	 *
+	 * Valid replies:
+	 *   fuse_reply_ioend
+	 *   fuse_reply_err
+	 *
+	 * @param req request handle
+	 * @param nodeid the inode number
+	 * @param attr_ino inode number as told by fuse_attr::ino
+	 * @param pos position in file, in bytes
+	 * @param written number of bytes processed, or a negative errno
+	 * @param flags mask of FUSE_IOMAP_IOEND_ flags specifying operation
+	 * @param error errno code of what went wrong
+	 * @param dev device cookie of new address
+	 * @param new_addr disk address of new mapping, in bytes
+	 */
+	void (*iomap_ioend) (fuse_req_t req, fuse_ino_t nodeid,
+			     uint64_t attr_ino, off_t pos, uint64_t written,
+			     uint32_t ioendflags, int error, uint32_t dev,
+			     uint64_t new_addr);
 };
 
 /**
@@ -1810,6 +1832,18 @@ void fuse_iomap_pure_overwrite(struct fuse_file_iomap *write,
 int fuse_reply_iomap_begin(fuse_req_t req, const struct fuse_file_iomap *read,
 			   const struct fuse_file_iomap *write);
 
+/**
+ * Reply to an ioend with the new ondisk size
+ *
+ * Possible requests:
+ *   iomap_ioend
+ *
+ * @param req request handle
+ * @param newsize new ondisk file size
+ * @return zero for success, -errno for failure to send reply
+ */
+int fuse_reply_iomap_ioend(fuse_req_t req, off_t newsize);
+
 /* ----------------------------------------------------------- *
  * Notification						       *
  * ----------------------------------------------------------- */
diff --git a/lib/fuse_lowlevel.c b/lib/fuse_lowlevel.c
index cf97ed8b471c49..45d5965caf7b7f 100644
--- a/lib/fuse_lowlevel.c
+++ b/lib/fuse_lowlevel.c
@@ -2767,6 +2767,36 @@ static void do_iomap_end(fuse_req_t req, const fuse_ino_t nodeid,
 	_do_iomap_end(req, nodeid, inarg, NULL);
 }
 
+int fuse_reply_iomap_ioend(fuse_req_t req, off_t newsize)
+{
+	struct fuse_iomap_ioend_out arg = {
+		.newsize = newsize,
+	};
+
+	return send_reply_ok(req, &arg, sizeof(arg));
+}
+
+static void _do_iomap_ioend(fuse_req_t req, const fuse_ino_t nodeid,
+			    const void *op_in, const void *in_payload)
+{
+	const struct fuse_iomap_ioend_in *arg = op_in;
+	(void)in_payload;
+	(void)nodeid;
+
+	if (req->se->op.iomap_ioend)
+		req->se->op.iomap_ioend(req, nodeid, arg->attr_ino, arg->pos,
+					arg->written, arg->flags, arg->error,
+					arg->dev, arg->new_addr);
+	else
+		fuse_reply_err(req, ENOSYS);
+}
+
+static void do_iomap_ioend(fuse_req_t req, const fuse_ino_t nodeid,
+			   const void *inarg)
+{
+	_do_iomap_ioend(req, nodeid, inarg, NULL);
+}
+
 static bool want_flags_valid(uint64_t capable, uint64_t want)
 {
 	uint64_t unknown_flags = want & (~capable);
@@ -3755,6 +3785,7 @@ static struct {
 	[FUSE_STATX]	   = { do_statx,       "STATX"	     },
 	[FUSE_IOMAP_BEGIN] = { do_iomap_begin,	"IOMAP_BEGIN" },
 	[FUSE_IOMAP_END]   = { do_iomap_end,	"IOMAP_END" },
+	[FUSE_IOMAP_IOEND] = { do_iomap_ioend,	"IOMAP_IOEND" },
 	[CUSE_INIT]	   = { cuse_lowlevel_init, "CUSE_INIT"   },
 };
 
@@ -3814,6 +3845,7 @@ static struct {
 	[FUSE_STATX]		= { _do_statx,		"STATX" },
 	[FUSE_IOMAP_BEGIN]	= { _do_iomap_begin,	"IOMAP_BEGIN" },
 	[FUSE_IOMAP_END]	= { _do_iomap_end,	"IOMAP_END" },
+	[FUSE_IOMAP_IOEND]	= { _do_iomap_ioend,	"IOMAP_IOEND" },
 	[CUSE_INIT]		= { _cuse_lowlevel_init, "CUSE_INIT" },
 };
 
diff --git a/lib/fuse_versionscript b/lib/fuse_versionscript
index 5c4a7dc53b33f3..a018600d26ba4d 100644
--- a/lib/fuse_versionscript
+++ b/lib/fuse_versionscript
@@ -233,6 +233,7 @@ FUSE_3.99 {
 	global:
 		fuse_iomap_pure_overwrite;
 		fuse_reply_iomap_begin;
+		fuse_reply_iomap_ioend;
 		fuse_lowlevel_iomap_device_add;
 		fuse_lowlevel_iomap_device_remove;
 		fuse_fs_iomap_device_add;


