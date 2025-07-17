Return-Path: <linux-fsdevel+bounces-55356-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81634B0982A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Jul 2025 01:37:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 398DA3A8912
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Jul 2025 23:36:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62BCB23FC4C;
	Thu, 17 Jul 2025 23:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="shVqtdSl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C29E4233D85
	for <linux-fsdevel@vger.kernel.org>; Thu, 17 Jul 2025 23:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752795437; cv=none; b=cFTqejhNhBmpe4pzoy9tFheLgALgtQICsWeKfBuyJnxF4h0zhm/wIYKatxPSAmuN4k4hzXtoQIHyHjzoDgkGVOgjUtYZsdWr5+iN02sB40rxDcYYHAOpVKsaE7DJmijDC2ExYIqDMswan6kNMQ4gyw9HVk1NHTbRAA9xU5DdxKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752795437; c=relaxed/simple;
	bh=Uf8jZhpJTPWty5ls9BxiP71WyE6i5XMaqRSDYNKq5VM=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=e65uO7numeM4abk/w0jOJjDyjTtaATF88W4fQyaY86o9uyDLxF6mtc0z3UhMP34tEX8/FGWf94Q1397rNzpQikzYCVozw+ecBspEETlReWR8GV/ZEJJlZhfAQ8iCS0+aje2W4HmixxYi+Qs+AkYPAoxQIjnrp18YK8DBZrU/L+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=shVqtdSl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F8E1C4CEE3;
	Thu, 17 Jul 2025 23:37:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752795437;
	bh=Uf8jZhpJTPWty5ls9BxiP71WyE6i5XMaqRSDYNKq5VM=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=shVqtdSluNr+Ct5npp64jRT26VzqntiTqlAXEeknMJGypd6X9rWfsUE5fdCID47WX
	 EM69xNwgcXZ2jgbGxbT7TDHtteTZubh98gnHVbe6KER3OsWIvNfosg3fxPt8b0UuZO
	 ycgKzHNkioDUN+3XhhCfUC/sMDtz4y59fZPTrN9Kz8T2RivA3wgezl7odGz8zaXwpA
	 0T6u37+fJnNzHE2a3bPlD4kJSM2ASlWneHw72dt0D3RQ3Q/rVO5XqUri2gAPlJRWzm
	 mtjfwW40PNjj0bRy82zogtgZXq64d+g1DQ0NBpuXM3GLAXeILpfT7ck4IptkXDF0Dq
	 cnTQQ3I+lAOHg==
Date: Thu, 17 Jul 2025 16:37:16 -0700
Subject: [PATCH 11/14] libfuse: allow discovery of the kernel's iomap
 capabilities
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, bschubert@ddn.com
Cc: John@groves.net, joannelkoong@gmail.com, linux-fsdevel@vger.kernel.org,
 bernd@bsbernd.com, neal@gompa.dev, miklos@szeredi.hu
Message-ID: <175279459929.714161.14726934153216245300.stgit@frogsfrogsfrogs>
In-Reply-To: <175279459673.714161.10658209239262310420.stgit@frogsfrogsfrogs>
References: <175279459673.714161.10658209239262310420.stgit@frogsfrogsfrogs>
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
index 17ab74255cbf33..7a1226d6bc2c0a 100644
--- a/include/fuse_kernel.h
+++ b/include/fuse_kernel.h
@@ -1142,6 +1142,17 @@ struct fuse_backing_map {
 	uint64_t	padding;
 };
 
+/* basic reporting functionality */
+#define FUSE_IOMAP_SUPPORT_BASICS	(1ULL << 0)
+/* fuse driver can do direct io */
+#define FUSE_IOMAP_SUPPORT_DIRECTIO	(1ULL << 1)
+/* fuse driver can do buffered io */
+#define FUSE_IOMAP_SUPPORT_FILEIO	(1ULL << 2)
+struct fuse_iomap_support {
+	uint64_t	flags;
+	uint64_t	padding;
+};
+
 /* Device ioctls: */
 #define FUSE_DEV_IOC_MAGIC		229
 #define FUSE_DEV_IOC_CLONE		_IOR(FUSE_DEV_IOC_MAGIC, 0, uint32_t)
@@ -1150,6 +1161,8 @@ struct fuse_backing_map {
 #define FUSE_DEV_IOC_BACKING_CLOSE	_IOW(FUSE_DEV_IOC_MAGIC, 2, uint32_t)
 #define FUSE_DEV_IOC_IOMAP_DEV_ADD	_IOW(FUSE_DEV_IOC_MAGIC, 3, \
 					     struct fuse_backing_map)
+#define FUSE_DEV_IOC_IOMAP_SUPPORT	_IOR(FUSE_DEV_IOC_MAGIC, 4, \
+					     struct fuse_iomap_support)
 
 struct fuse_lseek_in {
 	uint64_t	fh;
diff --git a/include/fuse_lowlevel.h b/include/fuse_lowlevel.h
index 07748abcf079cf..a529a112998d6e 100644
--- a/include/fuse_lowlevel.h
+++ b/include/fuse_lowlevel.h
@@ -2503,6 +2503,11 @@ int fuse_session_receive_buf(struct fuse_session *se, struct fuse_buf *buf);
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
index d354b947a4fb6b..0c7d5cc99945ee 100644
--- a/lib/fuse_lowlevel.c
+++ b/lib/fuse_lowlevel.c
@@ -4490,3 +4490,31 @@ int fuse_session_exited(struct fuse_session *se)
 
 	return exited ? 1 : 0;
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
+	if (ios.flags & FUSE_IOMAP_SUPPORT_FILEIO)
+		ret |= FUSE_CAP_IOMAP_FILEIO;
+
+out_close:
+	close(fd);
+	return ret;
+}
diff --git a/lib/fuse_versionscript b/lib/fuse_versionscript
index 9207145624ba83..606fdc6127462e 100644
--- a/lib/fuse_versionscript
+++ b/lib/fuse_versionscript
@@ -219,6 +219,7 @@ FUSE_3.18 {
 		fuse_reply_create_iflags;
 		fuse_reply_entry_iflags;
 		fuse_add_direntry_plus_iflags;
+		fuse_discover_iomap;
 } FUSE_3.17;
 
 # Local Variables:


