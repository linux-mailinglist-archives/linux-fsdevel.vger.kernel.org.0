Return-Path: <linux-fsdevel+bounces-61578-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A1416B589FA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 02:46:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4AEFA3A56C3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 00:46:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE8FF72614;
	Tue, 16 Sep 2025 00:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ICszTb8p"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59C1D1CD2C
	for <linux-fsdevel@vger.kernel.org>; Tue, 16 Sep 2025 00:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757983590; cv=none; b=dhjZeOyCNlr7nYyIEIe12gx3C8nMPuOs7KiwOp8e7ggkX94gDLtd1vkAJj3JjRngQjUNZ9r816L3shld6atHt5nZbTcU5vllQqc1TCWqcmGrbUXXR3Nu1aVV+wW/PmGRZ7asHnkhobpYAZQw8nYQ5PnHyVdgQ2Cy4z2/EmYJJkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757983590; c=relaxed/simple;
	bh=4fm1akva71O9hh+m/LA2NwH6ydARIWwrFix3gNxy7dI=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=F/zOzuZlcAK0JvNS0Mq0nOPPsWiT+NuFYNNlwreJ+IwEgdGIQdRzQe+bb6ED45BmwyE/i42/Hp3f+FhCglSCsw2tjpGAgioYxxQKi5GHvXacPk7DKKFQj+DvbIthSzb82BQbMMY/MDzp4phjUl6I7CFDURRqIpEirY2N5yfrWHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ICszTb8p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD437C4CEF1;
	Tue, 16 Sep 2025 00:46:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757983588;
	bh=4fm1akva71O9hh+m/LA2NwH6ydARIWwrFix3gNxy7dI=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=ICszTb8pohS5xXKnjWtyvi2+FsdXohmMpe9Cw6ddkwD5pMmEM44mnVpTDHH+oaiXH
	 iydRaJcQlET0q3yczmrHQIk2G1qsTj5WZOU9IYrpa+cCbmwzdYVmAF+VECi3Pi1J3v
	 1eln2zgd6HqFADZ1FkYgT8RVm8pZojq3lRU/+YaJej8SBXkEVf3qluV8KxOQm+E72i
	 61trph5sl6E6paLvggLkbCttTNXbZukf/QJEcIfowxP06BVj+EqkMwji2PsEIFTPbp
	 T9267CbPOZr6KUOOV6+uSVHY8yEgr/CApfs4wX0XznmR3cQxxlBmN1Kxsr24ns3hL/
	 gjR76dF7G+iag==
Date: Mon, 15 Sep 2025 17:46:28 -0700
Subject: [PATCH 18/18] libfuse: add atomic write support
From: "Darrick J. Wong" <djwong@kernel.org>
To: bschubert@ddn.com, djwong@kernel.org
Cc: John@groves.net, neal@gompa.dev, bernd@bsbernd.com,
 linux-fsdevel@vger.kernel.org, miklos@szeredi.hu, joannelkoong@gmail.com
Message-ID: <175798154833.386924.13314800733368747845.stgit@frogsfrogsfrogs>
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

Add the single flag that we need to turn on atomic write support in
fuse.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 include/fuse_common.h |    4 ++++
 include/fuse_kernel.h |    3 +++
 lib/fuse_lowlevel.c   |    2 ++
 3 files changed, 9 insertions(+)


diff --git a/include/fuse_common.h b/include/fuse_common.h
index 59b79b44a36e8d..eb08320bc8863f 100644
--- a/include/fuse_common.h
+++ b/include/fuse_common.h
@@ -540,6 +540,8 @@ struct fuse_loop_config_v1 {
  * FUSE_IOMAP_SUPPORT_FILEIO: basic file I/O functionality through iomap
  */
 #define FUSE_IOMAP_SUPPORT_FILEIO	(1ULL << 0)
+/* untorn writes through iomap */
+#define FUSE_IOMAP_SUPPORT_ATOMIC	(1ULL << 1)
 
 /**
  * Connection information, passed to the ->init() method
@@ -1232,6 +1234,8 @@ static inline bool fuse_iomap_need_write_allocate(unsigned int opflags,
 #define FUSE_IFLAG_DAX			(1U << 0)
 /* use iomap for this inode */
 #define FUSE_IFLAG_IOMAP		(1U << 1)
+/* enable untorn writes */
+#define FUSE_IFLAG_ATOMIC		(1U << 2)
 
 /* Which fields are set in fuse_iomap_config_out? */
 #define FUSE_IOMAP_CONFIG_SID		(1 << 0ULL)
diff --git a/include/fuse_kernel.h b/include/fuse_kernel.h
index 861c3d449db788..ed41792f94cf4f 100644
--- a/include/fuse_kernel.h
+++ b/include/fuse_kernel.h
@@ -241,6 +241,7 @@
  *  - add FUSE_ATTR_IOMAP to enable iomap for specific inodes
  *  - add FUSE_IOMAP_CONFIG so the fuse server can configure more fs geometry
  *  - add FUSE_NOTIFY_IOMAP_DEV_INVAL to invalidate iomap bdev ranges
+ *  - add FUSE_ATTR_ATOMIC for single-fsblock atomic write support
  */
 
 #ifndef _LINUX_FUSE_H
@@ -582,10 +583,12 @@ struct fuse_file_lock {
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
index 166bd82eca463b..6108b1862a7eb8 100644
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


