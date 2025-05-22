Return-Path: <linux-fsdevel+bounces-49625-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5740FAC0103
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 May 2025 02:07:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 14A1E172468
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 May 2025 00:07:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 216E42F4A;
	Thu, 22 May 2025 00:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SnjVBhH6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 839F928F1
	for <linux-fsdevel@vger.kernel.org>; Thu, 22 May 2025 00:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747872445; cv=none; b=R3r8AqC438hdUKf3Csqn+4xZjl7THOMBSRGnsCCh9bJwv+w5K7/P+mHpcCk3mxb94Qq9d1SYJ4RKc+sgEdW1uZ1SOSLaoXvodQtMIH/MdARDzKh+Lqw/N0kn39NA1uIroJ2BEUAUHZ1cNRKhTiOptzveztlUOZYsM5hxR9hMyfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747872445; c=relaxed/simple;
	bh=e3+ThxZwdd609T7reldIwjYYIhldUBdC3O2awkME/vQ=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=l6wA+lMinYwlDBvz8dPCoOllCnvZ8caVb8isFa9DkRRSZywg76C7Fn1Lzm8iTw8WgV54aOGb990JoBcpPagAvE0b1fx6tWd0a/8rTN7ljR3GPVNjVJGdYSGOFAmFDcbjZBMQW184ZuNYMvEdLRhSHWODOXY2VbLirk4FLPIIyXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SnjVBhH6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4919CC4CEE4;
	Thu, 22 May 2025 00:07:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747872445;
	bh=e3+ThxZwdd609T7reldIwjYYIhldUBdC3O2awkME/vQ=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=SnjVBhH6prUhcvMvxfBfp7vBIkgmFJOLFripJ+u3nHfBcZaa/d4gWbWxPH4D77o9f
	 6ODiphd9bsjf5g/J2OkRmRYex8dGNCrZ8e/bandvurQB4bBIw+sarOeGRzIP1i1XpJ
	 /j+Iw2Uo//9s8FhBCrXrZYYhwkuckwbxWGmtabcjvTCyhXGHDIJvbOuNjf5EeXuLHS
	 D7TtTq583WX52zNAB3mW7jq+EoGEFX5Y3OZu9wb6jq1aVJIxgcYOT7/EakalVJY5rI
	 p4uXQD/UE7pE3sFzmfvtrobQMVGpBDqhw40SN889eV11ckZAZ7kPgEb7A/GfxswSAZ
	 6iNKpeYqxkClw==
Date: Wed, 21 May 2025 17:07:24 -0700
Subject: [PATCH 8/8] libfuse: allow discovery of the kernel's iomap
 capabilities
From: "Darrick J. Wong" <djwong@kernel.org>
To: bschubert@ddn.com, djwong@kernel.org
Cc: linux-fsdevel@vger.kernel.org, bernd@bsbernd.com, John@groves.net,
 joannelkoong@gmail.com, miklos@szeredi.hu
Message-ID: <174787196501.1483718.7405211872615895098.stgit@frogsfrogsfrogs>
In-Reply-To: <174787196326.1483718.13513023339006584229.stgit@frogsfrogsfrogs>
References: <174787196326.1483718.13513023339006584229.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

Create a library function so that we can discover the kernel's iomap
capabilities ahead of time.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 include/fuse_kernel.h   |   13 +++++++++++++
 include/fuse_lowlevel.h |    5 +++++
 lib/fuse_lowlevel.c     |   28 ++++++++++++++++++++++++++++
 lib/fuse_versionscript  |    1 +
 4 files changed, 47 insertions(+)


diff --git a/include/fuse_kernel.h b/include/fuse_kernel.h
index 93ecb98a0bc20f..71077eb9f49fef 100644
--- a/include/fuse_kernel.h
+++ b/include/fuse_kernel.h
@@ -1129,12 +1129,25 @@ struct fuse_backing_map {
 	uint64_t	padding;
 };
 
+/* basic reporting functionality */
+#define FUSE_IOMAP_SUPPORT_BASICS	(1ULL << 0)
+/* fuse driver can do direct io */
+#define FUSE_IOMAP_SUPPORT_DIRECTIO	(1ULL << 1)
+/* fuse driver can do buffered io */
+#define FUSE_IOMAP_SUPPORT_PAGECACHE	(1ULL << 2)
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
+#define FUSE_DEV_IOC_IOMAP_SUPPORT	_IOR(FUSE_DEV_IOC_MAGIC, 3, \
+					     struct fuse_iomap_support)
 
 struct fuse_lseek_in {
 	uint64_t	fh;
diff --git a/include/fuse_lowlevel.h b/include/fuse_lowlevel.h
index eb457007a72cbc..a74d287f9012e9 100644
--- a/include/fuse_lowlevel.h
+++ b/include/fuse_lowlevel.h
@@ -2410,6 +2410,11 @@ int fuse_session_receive_buf(struct fuse_session *se, struct fuse_buf *buf);
  */
 bool fuse_req_is_uring(fuse_req_t req);
 
+/**
+ * Discover the kernel's iomap capabilities.  Returns FUSE_CAP_IOMAP_* flags.
+ */
+uint64_t fuse_discover_iomap(void);
+
 #ifdef __cplusplus
 }
 #endif
diff --git a/lib/fuse_lowlevel.c b/lib/fuse_lowlevel.c
index fd12daf509cebf..9779e6ea7cc8ac 100644
--- a/lib/fuse_lowlevel.c
+++ b/lib/fuse_lowlevel.c
@@ -4341,3 +4341,31 @@ int fuse_session_exited(struct fuse_session *se)
 {
 	return se->exited;
 }
+
+uint64_t fuse_discover_iomap(void)
+{
+	struct fuse_iomap_support ios;
+	uint64_t ret = 0;
+	int fd;
+
+	fd = open("/dev/fuse", O_RDONLY | O_CLOEXEC);
+	if (fd < 0)
+		return 0;
+
+	ret = ioctl(fd, FUSE_DEV_IOC_IOMAP_SUPPORT, &ios);
+	if (ret) {
+		ret = 0;
+		goto out_close;
+	}
+
+	if (ios.flags & FUSE_IOMAP_SUPPORT_BASICS)
+		ret |= FUSE_CAP_IOMAP;
+	if (ios.flags & FUSE_IOMAP_SUPPORT_DIRECTIO)
+		ret |= FUSE_CAP_IOMAP_DIRECTIO;
+	if (ios.flags & FUSE_IOMAP_SUPPORT_PAGECACHE)
+		ret |= FUSE_CAP_IOMAP_PAGECACHE;
+
+out_close:
+	close(fd);
+	return ret;
+}
diff --git a/lib/fuse_versionscript b/lib/fuse_versionscript
index 5c04e204adba33..210527ce9dd283 100644
--- a/lib/fuse_versionscript
+++ b/lib/fuse_versionscript
@@ -206,6 +206,7 @@ FUSE_3.18 {
 	global:
 		fuse_req_is_uring;
 		fuse_lowlevel_notify_iomap_add_device;
+		fuse_discover_iomap;
 } FUSE_3.17;
 
 # Local Variables:


