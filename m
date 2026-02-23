Return-Path: <linux-fsdevel+bounces-78117-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YHwWMF7inGnrLwQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78117-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 00:27:26 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7843917F626
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 00:27:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6558C309D091
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 23:27:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE24437F8A6;
	Mon, 23 Feb 2026 23:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="no0pMFcg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 587A7372B45;
	Mon, 23 Feb 2026 23:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771889216; cv=none; b=JXft4kaE0lmu5lVif0btrvqEHiu8zLK3cU1hIfDNpp6re60OY/Hx0XVtvb+LaHYpGYlEVu8MsShryVKSHR7PQWWDnLmifuZIjPjaWbUJ1LrOED4jkXiURrkc5FAg5XUcdx5NoU7r2xewQivnw2rdJ207JoPYlsLRxJ8GIppayy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771889216; c=relaxed/simple;
	bh=5dETlXJy6UZ/x+Pg6QMfBjIEtq3RxzNKUoSJ+BJ2VJM=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kunHFfNx8osv+uBUNaiiea7p2mku5gqw38T7Nw7xlXdFtUo+tYvQ28kQoV7i+Wy2QazW+KFK68ES9/obUcSoaIcV2ukgWYmspQyhz6jl+kcWp5blZe/sS/xvkazZoH1gI9s+EZTSnm6GDXL1lOm7rfUXA/nlfxu6r44amtECc+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=no0pMFcg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B29DC116C6;
	Mon, 23 Feb 2026 23:26:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771889216;
	bh=5dETlXJy6UZ/x+Pg6QMfBjIEtq3RxzNKUoSJ+BJ2VJM=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=no0pMFcgE6z+J++rH3yFtUE12qf7Irh+vPJ8rG4q3ndfRhkX0k+Ne4uzKrost4LPN
	 OZ+naUrm2GJvgN/65UUXR3yz8Nr1VZ8SOo/m72S8ORyn8qUbxZ8XVaQGEbSRZ7JRVe
	 qgiCCflOSUhY8YgD2lA5jJHejh0oV81vKfiDRfEbVx+KPm/Xw7GWgTbhCYjtTrAXDE
	 iVqeW85xmQNeqchljepu6fHKta9rxAnhnSoPSUHtTXiMtQDq2tBU8IKSWNPDQ7NONN
	 cp4tmoGJOKT3QlwgBcNyp9duG+Qr4LqEKI8m7T9tMK41+sC4kqynr+XHQ9gMf916Lp
	 lyzRvacX+Ut9Q==
Date: Mon, 23 Feb 2026 15:26:55 -0800
Subject: [PATCH 06/25] libfuse: add a lowlevel notification to add a new
 device to iomap
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, bschubert@ddn.com
Cc: bernd@bsbernd.com, miklos@szeredi.hu, neal@gompa.dev,
 linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 bpf@vger.kernel.org, joannelkoong@gmail.com
Message-ID: <177188740044.3940670.14978460881448214351.stgit@frogsfrogsfrogs>
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
	TAGGED_FROM(0.00)[bounces-78117-lists,linux-fsdevel=lfdr.de];
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
X-Rspamd-Queue-Id: 7843917F626
X-Rspamd-Action: no action

From: Darrick J. Wong <djwong@kernel.org>

Plumb in the pieces needed to attach block devices to a fuse+iomap mount
for use with iomap operations.  This enables us to have filesystems
where the metadata could live somewhere else, but the actual file IO
goes to locally attached storage.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 include/fuse_kernel.h   |    7 +++++++
 include/fuse_lowlevel.h |   30 +++++++++++++++++++++++++++++
 lib/fuse_lowlevel.c     |   49 +++++++++++++++++++++++++++++++++++++++++++++++
 lib/fuse_versionscript  |    2 ++
 4 files changed, 88 insertions(+)


diff --git a/include/fuse_kernel.h b/include/fuse_kernel.h
index b3750bb6275620..e69f9675c4b57d 100644
--- a/include/fuse_kernel.h
+++ b/include/fuse_kernel.h
@@ -1135,6 +1135,13 @@ struct fuse_notify_prune_out {
 	uint64_t	spare;
 };
 
+#define FUSE_BACKING_TYPE_MASK		(0xFF)
+#define FUSE_BACKING_TYPE_PASSTHROUGH	(0)
+#define FUSE_BACKING_TYPE_IOMAP		(1)
+#define FUSE_BACKING_MAX_TYPE		(FUSE_BACKING_TYPE_IOMAP)
+
+#define FUSE_BACKING_FLAGS_ALL		(FUSE_BACKING_TYPE_MASK)
+
 struct fuse_backing_map {
 	int32_t		fd;
 	uint32_t	flags;
diff --git a/include/fuse_lowlevel.h b/include/fuse_lowlevel.h
index f01fb06d6737ba..7f9a56b0a7eda1 100644
--- a/include/fuse_lowlevel.h
+++ b/include/fuse_lowlevel.h
@@ -2034,6 +2034,36 @@ int fuse_lowlevel_notify_retrieve(struct fuse_session *se, fuse_ino_t ino,
 int fuse_lowlevel_notify_prune(struct fuse_session *se,
 			       fuse_ino_t *nodeids, uint32_t count);
 
+/*
+ * Attach an open file descriptor to a fuse+iomap mount.  Currently must be
+ * a block device.
+ *
+ * Added in FUSE protocol version 7.99. If the kernel does not support
+ * this (or a newer) version, the function will return -ENOSYS and do
+ * nothing.
+ *
+ * @param se the session object
+ * @param fd file descriptor of an open block device
+ * @param flags flags for the operation; none defined so far
+ * @return positive nonzero device id on success, or negative errno on failure
+ */
+int fuse_lowlevel_iomap_device_add(struct fuse_session *se, int fd,
+				   unsigned int flags);
+
+/**
+ * Detach an open file from a fuse+iomap mount.  Must be a device id returned
+ * by fuse_lowlevel_iomap_device_add.
+ *
+ * Added in FUSE protocol version 7.99. If the kernel does not support
+ * this (or a newer) version, the function will return -ENOSYS and do
+ * nothing.
+ *
+ * @param se the session object
+ * @param device_id device index as returned by fuse_lowlevel_iomap_device_add
+ * @return 0 on success, or negative errno on failure
+ */
+int fuse_lowlevel_iomap_device_remove(struct fuse_session *se, int device_id);
+
 /* ----------------------------------------------------------- *
  * Utility functions					       *
  * ----------------------------------------------------------- */
diff --git a/lib/fuse_lowlevel.c b/lib/fuse_lowlevel.c
index ccfae61390290b..cf97ed8b471c49 100644
--- a/lib/fuse_lowlevel.c
+++ b/lib/fuse_lowlevel.c
@@ -624,6 +624,55 @@ int fuse_passthrough_close(fuse_req_t req, int backing_id)
 	return ret;
 }
 
+int fuse_lowlevel_iomap_device_add(struct fuse_session *se, int fd,
+				   unsigned int flags)
+{
+	struct fuse_backing_map map = {
+		.fd = fd,
+		.flags = FUSE_BACKING_TYPE_IOMAP |
+			(flags & ~FUSE_BACKING_TYPE_MASK),
+	};
+	int ret;
+
+	if (!(se->conn.want_ext & FUSE_CAP_IOMAP))
+		return -ENOSYS;
+
+	ret = ioctl(se->fd, FUSE_DEV_IOC_BACKING_OPEN, &map);
+	if (ret == 0) {
+		/* not supposed to happen */
+		ret = -1;
+		errno = ERANGE;
+	}
+	if (ret < 0) {
+		int err = errno;
+
+		fuse_log(FUSE_LOG_ERR, "fuse: iomap_device_add: %s\n",
+			 strerror(err));
+		return -err;
+	}
+
+	return ret;
+}
+
+int fuse_lowlevel_iomap_device_remove(struct fuse_session *se, int device_id)
+{
+	int ret;
+
+	if (!(se->conn.want_ext & FUSE_CAP_IOMAP))
+		return -ENOSYS;
+
+	ret = ioctl(se->fd, FUSE_DEV_IOC_BACKING_CLOSE, &device_id);
+	if (ret < 0) {
+		int err = errno;
+
+		fuse_log(FUSE_LOG_ERR, "fuse: iomap_device_remove: %s\n",
+			 strerror(errno));
+		return -err;
+	}
+
+	return ret;
+}
+
 int fuse_reply_open(fuse_req_t req, const struct fuse_file_info *f)
 {
 	struct fuse_open_out arg;
diff --git a/lib/fuse_versionscript b/lib/fuse_versionscript
index e346ce29a7f7a3..bd9255f95d9948 100644
--- a/lib/fuse_versionscript
+++ b/lib/fuse_versionscript
@@ -233,6 +233,8 @@ FUSE_3.99 {
 	global:
 		fuse_iomap_pure_overwrite;
 		fuse_reply_iomap_begin;
+		fuse_lowlevel_iomap_device_add;
+		fuse_lowlevel_iomap_device_remove;
 } FUSE_3.19;
 
 # Local Variables:


