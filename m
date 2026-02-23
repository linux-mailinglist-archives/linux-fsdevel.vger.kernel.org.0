Return-Path: <linux-fsdevel+bounces-78126-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WIzEM9TinGnrLwQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78126-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 00:29:24 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 77CF917F71D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 00:29:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id CD8673027E37
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 23:29:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37CC937F8B9;
	Mon, 23 Feb 2026 23:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M4i9PdO0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B844F37C11F;
	Mon, 23 Feb 2026 23:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771889356; cv=none; b=DW9pSf7TuIUW3xx5ucZK3I3WyMG+lp8rfk4QL9sHrwmhcoiGsp6V4EpdFIH982MNzo+zrRVe/eADdxe1hsLlz26abv01hFUogh3HY83C7wTCeWGtqEz37ema9xKXiUB2l+LAL/4CbXuRbG4sxKf69637s10vXd1MnloN/6QzJRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771889356; c=relaxed/simple;
	bh=LiZeJqGJCWxS/mtHHpdYXPcj+vef5mYuCVV24phe+4M=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H9xlwT3GC3VwRpNOKD7YIuhwZsBGgVXY25BEcIQSb5SDBngHOMGbNiDnmejF7/cikYT0ULxO4ZV3wKrBXYnMGhsQYfSf3hADh0JKJRW3DhbUxJhW1o87hG9iiwB7d8uX7Q4c7Q5XyGL9nSZt65w/c/dgWkiNF72WlsfDeALF6P8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M4i9PdO0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96CD2C116C6;
	Mon, 23 Feb 2026 23:29:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771889356;
	bh=LiZeJqGJCWxS/mtHHpdYXPcj+vef5mYuCVV24phe+4M=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=M4i9PdO0zN3PI6BEuH714UIOxE6QhDdS6sLe1AxJAFYeijrtZf2NxqoKecwYhLDUn
	 YWhyHZrxSJ2K+X/y8amZWXcmTGhQmM9Gvt73PDf8FY0DaHda86MEvxyz9auuYnZYY3
	 JXF8TH5qfzZUPsKLxSZvFPxs3jdLbEy/NPCIRHEQ0sRDbEuUFQUZRxqNxmx0aGQpdO
	 Lc9qcf5oWr4s+HNOrJeg17ec4iJ7Ziifns1By02pvaGVIoeybSTe5SMt7ea7Vnw4hl
	 8pmBbxVP9MZS9Nu9m+JK9+hhZa0r6WhsaXWdORIvSA/QlWhwuFdrlgSsa2RXiNRpad
	 HP0upHnnB6qXA==
Date: Mon, 23 Feb 2026 15:29:16 -0800
Subject: [PATCH 15/25] libfuse: allow discovery of the kernel's iomap
 capabilities
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, bschubert@ddn.com
Cc: bernd@bsbernd.com, miklos@szeredi.hu, neal@gompa.dev,
 linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 bpf@vger.kernel.org, joannelkoong@gmail.com
Message-ID: <177188740203.3940670.1035105328969587298.stgit@frogsfrogsfrogs>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[bsbernd.com,szeredi.hu,gompa.dev,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-78126-lists,linux-fsdevel=lfdr.de];
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
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 77CF917F71D
X-Rspamd-Action: no action

From: Darrick J. Wong <djwong@kernel.org>

Create a library function so that we can discover the kernel's iomap
capabilities ahead of time.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 include/fuse_common.h   |    7 +++++++
 include/fuse_kernel.h   |    7 +++++++
 include/fuse_lowlevel.h |    9 +++++++++
 lib/fuse_lowlevel.c     |   19 +++++++++++++++++++
 lib/fuse_versionscript  |    1 +
 5 files changed, 43 insertions(+)


diff --git a/include/fuse_common.h b/include/fuse_common.h
index bece561ef3ec9c..cce263aa62f5d0 100644
--- a/include/fuse_common.h
+++ b/include/fuse_common.h
@@ -534,6 +534,13 @@ struct fuse_loop_config_v1 {
 
 #define FUSE_IOCTL_MAX_IOV	256
 
+/**
+ * iomap discovery flags
+ *
+ * FUSE_IOMAP_SUPPORT_FILEIO: basic file I/O functionality through iomap
+ */
+#define FUSE_IOMAP_SUPPORT_FILEIO	(1ULL << 0)
+
 /**
  * Connection information, passed to the ->init() method
  *
diff --git a/include/fuse_kernel.h b/include/fuse_kernel.h
index 6b1fcc44004dbf..95c6c179a4398a 100644
--- a/include/fuse_kernel.h
+++ b/include/fuse_kernel.h
@@ -1156,12 +1156,19 @@ struct fuse_backing_map {
 	uint64_t	padding;
 };
 
+struct fuse_iomap_support {
+	uint64_t	flags;
+	uint64_t	padding;
+};
+
 /* Device ioctls: */
 #define FUSE_DEV_IOC_MAGIC		229
 #define FUSE_DEV_IOC_CLONE		_IOR(FUSE_DEV_IOC_MAGIC, 0, uint32_t)
 #define FUSE_DEV_IOC_BACKING_OPEN	_IOW(FUSE_DEV_IOC_MAGIC, 1, \
 					     struct fuse_backing_map)
 #define FUSE_DEV_IOC_BACKING_CLOSE	_IOW(FUSE_DEV_IOC_MAGIC, 2, uint32_t)
+#define FUSE_DEV_IOC_IOMAP_SUPPORT	_IOR(FUSE_DEV_IOC_MAGIC, 99, \
+					     struct fuse_iomap_support)
 
 struct fuse_lseek_in {
 	uint64_t	fh;
diff --git a/include/fuse_lowlevel.h b/include/fuse_lowlevel.h
index c113c85067fb82..f31f250f13a965 100644
--- a/include/fuse_lowlevel.h
+++ b/include/fuse_lowlevel.h
@@ -2658,6 +2658,15 @@ bool fuse_req_is_uring(fuse_req_t req);
 int fuse_req_get_payload(fuse_req_t req, char **payload, size_t *payload_sz,
 			 void **mr);
 
+/**
+ * Discover the kernel's iomap capabilities.  Returns FUSE_CAP_IOMAP_* flags.
+ *
+ * @param fd open file descriptor to a fuse device, or -1 if you're running
+ *           in the same process that will call mount().
+ * @return FUSE_IOMAP_SUPPORT_* flags
+ */
+uint64_t fuse_lowlevel_discover_iomap(int fd);
+
 #ifdef __cplusplus
 }
 #endif
diff --git a/lib/fuse_lowlevel.c b/lib/fuse_lowlevel.c
index 23169c1946ce0b..4f3585f9a6841d 100644
--- a/lib/fuse_lowlevel.c
+++ b/lib/fuse_lowlevel.c
@@ -5073,3 +5073,22 @@ void fuse_session_stop_teardown_watchdog(void *data)
 	pthread_join(tt->thread_id, NULL);
 	fuse_tt_destruct(tt);
 }
+
+uint64_t fuse_lowlevel_discover_iomap(int fd)
+{
+	struct fuse_iomap_support ios = { };
+
+	if (fd >= 0) {
+		ioctl(fd, FUSE_DEV_IOC_IOMAP_SUPPORT, &ios);
+		return ios.flags;
+	}
+
+	fd = open("/dev/fuse", O_RDONLY | O_CLOEXEC);
+	if (fd < 0)
+		return 0;
+
+	ioctl(fd, FUSE_DEV_IOC_IOMAP_SUPPORT, &ios);
+	close(fd);
+
+	return ios.flags;
+}
diff --git a/lib/fuse_versionscript b/lib/fuse_versionscript
index 67c3bd614c44fc..f16698f3c4dbfa 100644
--- a/lib/fuse_versionscript
+++ b/lib/fuse_versionscript
@@ -244,6 +244,7 @@ FUSE_3.99 {
 		fuse_add_direntry_plus_iflags;
 		fuse_fs_can_enable_iomap;
 		fuse_fs_can_enable_iomapx;
+		fuse_lowlevel_discover_iomap;
 } FUSE_3.19;
 
 # Local Variables:


