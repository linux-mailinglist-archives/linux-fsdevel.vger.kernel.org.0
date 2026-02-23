Return-Path: <linux-fsdevel+bounces-78129-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qK8cDm/jnGn4LwQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78129-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 00:31:59 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E2B3817F840
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 00:31:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 975763019C8B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 23:30:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E7B337F8CC;
	Mon, 23 Feb 2026 23:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JQRbArWP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9807937F8A4;
	Mon, 23 Feb 2026 23:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771889403; cv=none; b=gEYnxpsD1WWuT7Mv4OwrL/EcaIN6pK5WUqsMKbiLUS9BNd8p1kTtTjJknn5pMg/6jgTSw1HVURbCX5xy6WP/sAXrsm3dDDmkDF3LJ8fmmmZmKHU0Qwu45+C6Uz1Avkai3bEsbMrxr0RoGspTrXlz2WPKCxuONtCPArkL2zQsUqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771889403; c=relaxed/simple;
	bh=sx0XC5QfkkedIX9MLp2ps2VD6XQL2vu9TrTXZ4mhAgU=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RmkL7B0AtRHVWbx9P2WCuqryetKbMx9XC9ruvSF0S5UJi54x8uRIY1xCVYRI3cCje7R6AkZuxl3lUiMitnlGMt/dj3sdWg1OLWChyynDtoYvlkN45NlVnKZzpWw/YZzFTormz+ido5xhJM/QKHDmIX0LeJanRIDr9MfEiRklKzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JQRbArWP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 739B4C116C6;
	Mon, 23 Feb 2026 23:30:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771889403;
	bh=sx0XC5QfkkedIX9MLp2ps2VD6XQL2vu9TrTXZ4mhAgU=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=JQRbArWPELpMlqFAoLG+JlihNX+oXrMcadL0Z12y8mefVQV5UdgRVqb3zwn/Yr5zY
	 ZesHy8vYmxmAiUhx76nGLkQC+TBYxnUmqboyH5ciaU2vZDfNUJWnLIyorwfPCATUUm
	 7WV0Mi6da1i+A2fAIv8a0kxYe5rEfAHry49DOAdrMNxotU6bMOt3NYixMg2DEiw8+w
	 BXVbbQP2XnWhxD6nwKuv4UvB1QQPR5JC/pfxM5aD9jJPz5Jca4y/NiGUY4McCWZ6D4
	 HcDE5HNiaHzy3rvAICzuA78vLC7HOKr/ARWU3xoPcb4NktliQXDOOQ6+yO680D9rF4
	 r2hdg3YepxYhg==
Date: Mon, 23 Feb 2026 15:30:03 -0800
Subject: [PATCH 18/25] libfuse: add low level code to invalidate iomap block
 device ranges
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, bschubert@ddn.com
Cc: bernd@bsbernd.com, miklos@szeredi.hu, neal@gompa.dev,
 linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 bpf@vger.kernel.org, joannelkoong@gmail.com
Message-ID: <177188740256.3940670.7740651318167830863.stgit@frogsfrogsfrogs>
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
	TAGGED_FROM(0.00)[bounces-78129-lists,linux-fsdevel=lfdr.de];
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
X-Rspamd-Queue-Id: E2B3817F840
X-Rspamd-Action: no action

From: Darrick J. Wong <djwong@kernel.org>

Make it easier to invalidate the page cache for a block device that is
being used in conjunction with iomap.  This allows a fuse server to kill
all cached data for a block that is being freed, so that block reuse
doesn't result in file corruption.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 include/fuse_kernel.h   |   15 +++++++++++++++
 include/fuse_lowlevel.h |   15 +++++++++++++++
 lib/fuse_lowlevel.c     |   22 ++++++++++++++++++++++
 lib/fuse_versionscript  |    1 +
 4 files changed, 53 insertions(+)


diff --git a/include/fuse_kernel.h b/include/fuse_kernel.h
index 897d996a0ce60d..1e7c9d8082cf23 100644
--- a/include/fuse_kernel.h
+++ b/include/fuse_kernel.h
@@ -247,6 +247,7 @@
  *  - add FUSE_ATTR_EXCLUSIVE to enable exclusive mode for specific inodes
  *  - add FUSE_ATTR_IOMAP to enable iomap for specific inodes
  *  - add FUSE_IOMAP_CONFIG so the fuse server can configure more fs geometry
+ *  - add FUSE_NOTIFY_IOMAP_DEV_INVAL to invalidate iomap bdev ranges
  */
 
 #ifndef _LINUX_FUSE_H
@@ -701,6 +702,7 @@ enum fuse_notify_code {
 	FUSE_NOTIFY_RESEND = 7,
 	FUSE_NOTIFY_INC_EPOCH = 8,
 	FUSE_NOTIFY_PRUNE = 9,
+	FUSE_NOTIFY_IOMAP_DEV_INVAL = 99,
 };
 
 /* The read buffer is required to be at least 8k, but may be much larger */
@@ -1421,4 +1423,17 @@ struct fuse_iomap_config_out {
 	int64_t s_maxbytes;	/* max file size */
 };
 
+struct fuse_range {
+	uint64_t offset;
+	uint64_t length;
+};
+
+struct fuse_iomap_dev_inval_out {
+	uint32_t dev;		/* device cookie */
+	uint32_t reserved;	/* zero */
+
+	/* range of bdev pagecache to invalidate, in bytes */
+	struct fuse_range range;
+};
+
 #endif /* _LINUX_FUSE_H */
diff --git a/include/fuse_lowlevel.h b/include/fuse_lowlevel.h
index a00b6d5a7fa0b6..95429ac096a82c 100644
--- a/include/fuse_lowlevel.h
+++ b/include/fuse_lowlevel.h
@@ -2208,6 +2208,21 @@ int fuse_lowlevel_iomap_device_add(struct fuse_session *se, int fd,
  */
 int fuse_lowlevel_iomap_device_remove(struct fuse_session *se, int device_id);
 
+/*
+ * Invalidate the page cache of a block device opened for use with iomap.
+ *
+ * Added in FUSE protocol version 7.99. If the kernel does not support
+ * this (or a newer) version, the function will return -ENOSYS and do
+ * nothing.
+ *
+ * @param se the session object
+ * @param dev device cookie returned by fuse_lowlevel_iomap_add_device
+ * @param offset start of the range to invalidate, in bytes
+ * @return length length of the range to invalidate, in bytes
+ */
+int fuse_lowlevel_iomap_device_invalidate(struct fuse_session *se, int dev,
+					  off_t offset, off_t length);
+
 /* ----------------------------------------------------------- *
  * Utility functions					       *
  * ----------------------------------------------------------- */
diff --git a/lib/fuse_lowlevel.c b/lib/fuse_lowlevel.c
index 19f292c0cb8ee3..89e26f207addbf 100644
--- a/lib/fuse_lowlevel.c
+++ b/lib/fuse_lowlevel.c
@@ -3684,6 +3684,28 @@ int fuse_lowlevel_notify_store(struct fuse_session *se, fuse_ino_t ino,
 	return res;
 }
 
+int fuse_lowlevel_iomap_device_invalidate(struct fuse_session *se, int dev,
+					  off_t offset, off_t length)
+{
+	struct fuse_iomap_dev_inval_out arg = {
+		.dev = dev,
+		.range.offset = offset,
+		.range.length = length,
+	};
+	struct iovec iov[2];
+
+	if (!se)
+		return -EINVAL;
+
+	if (!(se->conn.want_ext & FUSE_CAP_IOMAP))
+		return -ENOSYS;
+
+	iov[1].iov_base = &arg;
+	iov[1].iov_len = sizeof(arg);
+
+	return send_notify_iov(se, FUSE_NOTIFY_IOMAP_DEV_INVAL, iov, 2);
+}
+
 struct fuse_retrieve_req {
 	struct fuse_notify_req nreq;
 	void *cookie;
diff --git a/lib/fuse_versionscript b/lib/fuse_versionscript
index 14c59928ca9f00..56edd16862ca30 100644
--- a/lib/fuse_versionscript
+++ b/lib/fuse_versionscript
@@ -246,6 +246,7 @@ FUSE_3.99 {
 		fuse_fs_can_enable_iomapx;
 		fuse_lowlevel_discover_iomap;
 		fuse_reply_iomap_config;
+		fuse_lowlevel_iomap_device_invalidate;
 } FUSE_3.19;
 
 # Local Variables:


