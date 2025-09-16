Return-Path: <linux-fsdevel+bounces-61573-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D897B589F4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 02:45:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB01416F9C6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 00:45:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02FDC1CDFD5;
	Tue, 16 Sep 2025 00:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V9tGLFTj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C8301A2545
	for <linux-fsdevel@vger.kernel.org>; Tue, 16 Sep 2025 00:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757983511; cv=none; b=fRlW+tpAeAh0hFBtpxE2/tlDa9WQhKonv53i3af1YT2CJ/AiYZjHvlqji/x72PSp+tbNBom2k6SKiIGZ9ROQDUY8TX/H2P5CzhhdfwnwiRSwmrcS+RVnOeM5ScNE//lkhysuBDzq9uTuSNPnESplFN66Tp7wsdz5mzgzJlLo6eA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757983511; c=relaxed/simple;
	bh=+7j+21muiAnLim5xb/yXDNSmF2352GXUGUr0MIwcvL8=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=K4AXp0MBJQ4c0Dqm2bjR1GSlAGjGO4i4fCPP4lNzbYEiPm1HvLDBXApRIqPVG/AJjm0JVGxtoEeiAQi02noQ3mVu7B+6/0rYmxhcPgzQ2sckJBgXZrqRQLaUVZYg0wc2eMSbbi7F3pQqbJPKmTynucBvzzal62Hcl2SuOOz7DSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V9tGLFTj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE835C4CEF1;
	Tue, 16 Sep 2025 00:45:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757983510;
	bh=+7j+21muiAnLim5xb/yXDNSmF2352GXUGUr0MIwcvL8=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=V9tGLFTjnguAyz6CHG80HCmbiZ4/2bI2vbPdBn7WlDxMV3aGS5RL0fPbCqPM5Agh4
	 6MYQNyHqrYr9hJWsHzPPwpbaOUCLYcbE6Hl10fvnfuMe0RJM8VmL4TssT0vSy0/+kp
	 eroDbxlUC4DRLmyX5hncMki34GQ+4vavyb0/uW7UFchQezO22W3YLSumHbF+0ZTk7c
	 CeKZ4ueWkTVEwzyEqdvsar6btMdo11wyL7/odfcY+tGjrW/jKNICS2ib4OgnkWiDOX
	 CnBQT5rXw1cTlTi1lWNW5Yur+IdzHBDGQ4o0DScUZCMPrH884yDqFSP7UIfWZR4lek
	 kQEiryH+LGMsg==
Date: Mon, 15 Sep 2025 17:45:10 -0700
Subject: [PATCH 13/18] libfuse: allow discovery of the kernel's iomap
 capabilities
From: "Darrick J. Wong" <djwong@kernel.org>
To: bschubert@ddn.com, djwong@kernel.org
Cc: John@groves.net, neal@gompa.dev, bernd@bsbernd.com,
 linux-fsdevel@vger.kernel.org, miklos@szeredi.hu, joannelkoong@gmail.com
Message-ID: <175798154744.386924.13648321328452394224.stgit@frogsfrogsfrogs>
In-Reply-To: <175798154438.386924.8786074960979860206.stgit@frogsfrogsfrogs>
References: <175798154438.386924.8786074960979860206.stgit@frogsfrogsfrogs>
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
 include/fuse_common.h   |    7 +++++++
 include/fuse_kernel.h   |    7 +++++++
 include/fuse_lowlevel.h |   10 ++++++++++
 lib/fuse_lowlevel.c     |   19 +++++++++++++++++++
 lib/fuse_versionscript  |    1 +
 5 files changed, 44 insertions(+)


diff --git a/include/fuse_common.h b/include/fuse_common.h
index 191d9749960992..86ae8894d81dbb 100644
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
index 48db6ba118a47c..ea4243d09db53f 100644
--- a/include/fuse_kernel.h
+++ b/include/fuse_kernel.h
@@ -1139,12 +1139,19 @@ struct fuse_backing_map {
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
index dfe28d33d8d0b8..a4117efdee6dea 100644
--- a/include/fuse_lowlevel.h
+++ b/include/fuse_lowlevel.h
@@ -2574,6 +2574,16 @@ bool fuse_req_is_uring(fuse_req_t req);
 int fuse_req_get_payload(fuse_req_t req, char **payload, size_t *payload_sz,
 			 void **mr);
 
+
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
index 8654ca263b374d..a20f7fe3752ac5 100644
--- a/lib/fuse_lowlevel.c
+++ b/lib/fuse_lowlevel.c
@@ -4618,3 +4618,22 @@ int fuse_session_exited(struct fuse_session *se)
 
 	return exited ? 1 : 0;
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
index 25a3e04c6c5ec7..704e8c2908ec4b 100644
--- a/lib/fuse_versionscript
+++ b/lib/fuse_versionscript
@@ -232,6 +232,7 @@ FUSE_3.99 {
 		fuse_add_direntry_plus_iflags;
 		fuse_fs_can_enable_iomap;
 		fuse_fs_can_enable_iomapx;
+		fuse_lowlevel_discover_iomap;
 } FUSE_3.18;
 
 # Local Variables:


