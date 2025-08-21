Return-Path: <linux-fsdevel+bounces-58496-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E52E4B2EA03
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 03:06:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A16333BB745
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 01:06:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BE801F418D;
	Thu, 21 Aug 2025 01:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gJokL1OH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CEC21A9F9F
	for <linux-fsdevel@vger.kernel.org>; Thu, 21 Aug 2025 01:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755738410; cv=none; b=IxD0PMKvESwe4DqJ7gNoqzQRHTzhK5X5xbnlLVNQFQDha73aN7zQy9+orwQye/xJ29M7Fzwtobir+/oJF/WXeS3v7k6X6ufB5uEQr2Bt0POHSb0W0Ertc/Z4M4wEVFFdTRQiTsPbS9Czwnif4vnBZfhG5k7WZkMX+p3IlrhSSdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755738410; c=relaxed/simple;
	bh=A+KD23xHSvAfemVX5KO9PnMbkdUJBNx8s1sH+LBnmlk=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=POBIo2mu0RxiT59AFS4XbfrhjwcLv579xBz8fNI1W8rkEt4HAlfRrTJ8MZ4u4OGtw7Z5QiKIakJXMiaF6Fk64hQSUUBPIXSWEh3uFISgk/DIq6oCq9bnxCKTpjm4YMlzARgtTp7WX8rnco8faJwhKSwGXdwctSyKNBbAZrND+uM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gJokL1OH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AED0C4CEE7;
	Thu, 21 Aug 2025 01:06:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755738410;
	bh=A+KD23xHSvAfemVX5KO9PnMbkdUJBNx8s1sH+LBnmlk=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=gJokL1OHksNlVJ+C+IT4z9eUWdsh8LUL5Wp/t8x+UgFDG9vRdd65fuA+37Oi+eldI
	 U6uTbMEUdLZN15wFvFpQsimnaljoQIeBDI/mW/imaN2YJydgouS53YFt4u1IWbm3y1
	 z9Un3DI/mLUjnbkzSSb4ujMB25qOFzYEhuKMsnWaRsD8O2VeS1POt1IeN33RLhppVY
	 VftHk0ehVRSzXM6KjW5AfbNAO2slih65gkvm39R5UKsqJo66Vn/rkBRMhDfd2v+hgd
	 LdZR4JnBmw2u5kvz+16Kb0FTWs87E4lgeBoZ54sOY9j6axzuCQVq1WmZljGtPDi/fw
	 +80Hfe2efUVuw==
Date: Wed, 20 Aug 2025 18:06:49 -0700
Subject: [PATCH 21/21] libfuse: add atomic write support
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, bschubert@ddn.com
Cc: John@groves.net, joannelkoong@gmail.com, bernd@bsbernd.com,
 linux-fsdevel@vger.kernel.org, miklos@szeredi.hu, neal@gompa.dev
Message-ID: <175573711678.19163.12173964772299198733.stgit@frogsfrogsfrogs>
In-Reply-To: <175573711192.19163.9486664721161324503.stgit@frogsfrogsfrogs>
References: <175573711192.19163.9486664721161324503.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

Add the single flag that we need to turn on atomic write support in
fuse.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 include/fuse_common.h |    4 ++++
 include/fuse_kernel.h |    3 +++
 lib/fuse_lowlevel.c   |    2 ++
 3 files changed, 9 insertions(+)


diff --git a/include/fuse_common.h b/include/fuse_common.h
index 8e585cc7483643..19770262c4b518 100644
--- a/include/fuse_common.h
+++ b/include/fuse_common.h
@@ -548,6 +548,8 @@ struct fuse_loop_config_v1 {
  * FUSE_IOMAP_SUPPORT_FILEIO: basic file I/O functionality through iomap
  */
 #define FUSE_IOMAP_SUPPORT_FILEIO	(1ULL << 0)
+/* untorn writes through iomap */
+#define FUSE_IOMAP_SUPPORT_ATOMIC	(1ULL << 1)
 
 /**
  * Connection information, passed to the ->init() method
@@ -1237,6 +1239,8 @@ static inline bool fuse_iomap_need_write_allocate(unsigned int opflags,
 #define FUSE_IFLAG_DAX			(1U << 0)
 /* use iomap for this inode */
 #define FUSE_IFLAG_IOMAP		(1U << 1)
+/* enable untorn writes */
+#define FUSE_IFLAG_ATOMIC		(1U << 2)
 
 /* Which fields are set in fuse_iomap_config_out? */
 #define FUSE_IOMAP_CONFIG_SID		(1 << 0ULL)
diff --git a/include/fuse_kernel.h b/include/fuse_kernel.h
index 1470b59d742165..fcf02c9371ba3a 100644
--- a/include/fuse_kernel.h
+++ b/include/fuse_kernel.h
@@ -242,6 +242,7 @@
  *  - add FUSE_ATTR_IOMAP to enable iomap for specific inodes
  *  - add FUSE_IOMAP_CONFIG so the fuse server can configure more fs geometry
  *  - add FUSE_NOTIFY_IOMAP_DEV_INVAL to invalidate iomap bdev ranges
+ *  - add FUSE_ATTR_ATOMIC for single-fsblock atomic write support
  */
 
 #ifndef _LINUX_FUSE_H
@@ -584,10 +585,12 @@ struct fuse_file_lock {
  * FUSE_ATTR_SUBMOUNT: Object is a submount root
  * FUSE_ATTR_DAX: Enable DAX for this file in per inode DAX mode
  * FUSE_ATTR_IOMAP: Use iomap for this inode
+ * FUSE_ATTR_ATOMIC: Enable untorn writes
  */
 #define FUSE_ATTR_SUBMOUNT      (1 << 0)
 #define FUSE_ATTR_DAX		(1 << 1)
 #define FUSE_ATTR_IOMAP		(1 << 2)
+#define FUSE_ATTR_ATOMIC	(1 << 3)
 
 /**
  * Open flags
diff --git a/lib/fuse_lowlevel.c b/lib/fuse_lowlevel.c
index f730a7fd4ead09..ee73de4a8950be 100644
--- a/lib/fuse_lowlevel.c
+++ b/lib/fuse_lowlevel.c
@@ -126,6 +126,8 @@ static void convert_stat(const struct stat *stbuf, struct fuse_attr *attr,
 		attr->flags |= FUSE_ATTR_DAX;
 	if (iflags & FUSE_IFLAG_IOMAP)
 		attr->flags |= FUSE_ATTR_IOMAP;
+	if (iflags & FUSE_IFLAG_ATOMIC)
+		attr->flags |= FUSE_ATTR_ATOMIC;
 }
 
 static void convert_attr(const struct fuse_setattr_in *attr, struct stat *stbuf)


