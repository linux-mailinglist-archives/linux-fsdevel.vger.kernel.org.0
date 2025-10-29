Return-Path: <linux-fsdevel+bounces-66068-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94565C17B84
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 02:02:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C9F84045DA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 01:02:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB1E62D7DC2;
	Wed, 29 Oct 2025 01:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ueJY4bsb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30FCB1386C9;
	Wed, 29 Oct 2025 01:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761699731; cv=none; b=gEJMIZOJc+1Ykuu2SrwVo6r33ZKSvPme6JcYKfR6qiLPkT07UZwb/5tCbT8AhtyVnMKBfQzYB7acfTdZuaF23pOK/X+302N3ONu7iWHFJwF6t8ZI0a0nTpKJ92WiuCiajP8ycVVvg5Z9K4HdJocbtvLJQ9R14MjdmkoNGkLIFr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761699731; c=relaxed/simple;
	bh=YvtmKihhhzuflPnvtmhrUpjaoPV2A8sMjMPqi/M/qrc=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hPjJFd4w43RCEONKAWYeBw5hvPOnJ31IjJ5w4KwOwdmGf8/bqJ5MCF7iS2LVtvUOtbEVXty1v14qOjibAHmMvuWAg6V3q9csVKc7uM1jlMMKBg84nYKrs91QTUUWH7+O4gLpOQcjwgV6wWHBiHcowsVOp8EOr8ioKRCe/mqWjCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ueJY4bsb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01017C4CEE7;
	Wed, 29 Oct 2025 01:02:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761699731;
	bh=YvtmKihhhzuflPnvtmhrUpjaoPV2A8sMjMPqi/M/qrc=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=ueJY4bsba3bEdxISKuRFvozfsDs1Mz+C6zQMb96YtKr5Z+njrF/k9WrILYaNDJboO
	 KdjHaHMryuxYdX5fSQwrbtoaw/w2zll6rVa6BsqHp9KdEJiyWuatIekafLAFhpSH2J
	 waroepw6DxlsAIAuF/3yu5fi8ZR/nTWWaqR4ERovJq9xKSxF35f1na4B70F/wuFq8N
	 Onyw7YKuLq5VBkOXWaxXknvEimSWlhXUvJreBnbF/XG2UCV6arB9vMPIKZRR5NdonE
	 jB4a/U2mIuQNTF43mf1o9Tz0lbQTQc+Bzf53jBa4QX9Cp+OQxswi/cr/lTUHYKveUZ
	 oeF3cf3N5hSAw==
Date: Tue, 28 Oct 2025 18:02:10 -0700
Subject: [PATCH 11/22] libfuse: support direct I/O through iomap
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, bschubert@ddn.com
Cc: linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 bernd@bsbernd.com, miklos@szeredi.hu, joannelkoong@gmail.com, neal@gompa.dev
Message-ID: <176169813732.1427432.723555047424035008.stgit@frogsfrogsfrogs>
In-Reply-To: <176169813437.1427432.15345189583850708968.stgit@frogsfrogsfrogs>
References: <176169813437.1427432.15345189583850708968.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

Make it so that fuse servers can ask the kernel fuse driver to use iomap
to support direct IO.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 include/fuse_common.h |    2 ++
 include/fuse_kernel.h |    3 +++
 lib/fuse_lowlevel.c   |    2 ++
 3 files changed, 7 insertions(+)


diff --git a/include/fuse_common.h b/include/fuse_common.h
index faf0bc57bcdbe6..191d9749960992 100644
--- a/include/fuse_common.h
+++ b/include/fuse_common.h
@@ -1223,6 +1223,8 @@ static inline bool fuse_iomap_need_write_allocate(unsigned int opflags,
 
 /* enable fsdax */
 #define FUSE_IFLAG_DAX			(1U << 0)
+/* use iomap for this inode */
+#define FUSE_IFLAG_IOMAP		(1U << 1)
 
 /* ----------------------------------------------------------- *
  * Compatibility stuff					       *
diff --git a/include/fuse_kernel.h b/include/fuse_kernel.h
index 378019cc15cfd3..38aa03dce17e53 100644
--- a/include/fuse_kernel.h
+++ b/include/fuse_kernel.h
@@ -242,6 +242,7 @@
  *
  *  7.99
  *  - add FUSE_IOMAP and iomap_{begin,end,ioend} for regular file operations
+ *  - add FUSE_ATTR_IOMAP to enable iomap for specific inodes
  */
 
 #ifndef _LINUX_FUSE_H
@@ -582,9 +583,11 @@ struct fuse_file_lock {
  *
  * FUSE_ATTR_SUBMOUNT: Object is a submount root
  * FUSE_ATTR_DAX: Enable DAX for this file in per inode DAX mode
+ * FUSE_ATTR_IOMAP: Use iomap for this inode
  */
 #define FUSE_ATTR_SUBMOUNT      (1 << 0)
 #define FUSE_ATTR_DAX		(1 << 1)
+#define FUSE_ATTR_IOMAP		(1 << 2)
 
 /**
  * Open flags
diff --git a/lib/fuse_lowlevel.c b/lib/fuse_lowlevel.c
index 8f5ab2f8e059fd..e0d18844098971 100644
--- a/lib/fuse_lowlevel.c
+++ b/lib/fuse_lowlevel.c
@@ -125,6 +125,8 @@ static void convert_stat(const struct stat *stbuf, struct fuse_attr *attr,
 	attr->flags	= 0;
 	if (iflags & FUSE_IFLAG_DAX)
 		attr->flags |= FUSE_ATTR_DAX;
+	if (iflags & FUSE_IFLAG_IOMAP)
+		attr->flags |= FUSE_ATTR_IOMAP;
 }
 
 static void convert_attr(const struct fuse_setattr_in *attr, struct stat *stbuf)


