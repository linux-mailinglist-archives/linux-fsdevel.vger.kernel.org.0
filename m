Return-Path: <linux-fsdevel+bounces-61571-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D66AB589F2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 02:44:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C2C083ACAB9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 00:44:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77EE61C4A2D;
	Tue, 16 Sep 2025 00:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DVrTyNka"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7EBB1BD9CE
	for <linux-fsdevel@vger.kernel.org>; Tue, 16 Sep 2025 00:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757983479; cv=none; b=DZNlB76jAqBKjqwlmY2gHgssBq7r1eUFAjzSvQJtpqFpGLcfdhxyf8adpctMJ1hE6GFoxV8YaEXTvVLwyI0RbdJ/Mso/yJVBYuR3tfJh27dHUgGBKKxZavZ9iT8sSIuuQZvBi6fxmWs3O3RLOfrK0NLkUZ8BIXDs0tS6migTT4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757983479; c=relaxed/simple;
	bh=Ta/IfMgI1vuttkGHDa0vA0Q482IFUdUavUAVtBd/PPM=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LP4bKx2kqWoqD77FafC8+0swGMWwwrpp7q0sp+1L2MhjkV6gjcIhDcq3eAl/1z/WLmGiikvlY5gEaDDeV6WKYPhnN8smHD9eMHA1LeufiyH1OMDEvHesrjvtKQUIicJX8qjU3nd5YAlUKkPqwXQptTU4OEXpJ5ceGQkqdLBzIME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DVrTyNka; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0CD5C4CEF1;
	Tue, 16 Sep 2025 00:44:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757983479;
	bh=Ta/IfMgI1vuttkGHDa0vA0Q482IFUdUavUAVtBd/PPM=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=DVrTyNkam+9rh5ZaBcKKn2eLEL/ZO5zox5yoTESBgq9wwGjWRtdEMHEfZsBhOibGN
	 hPi3TGLs3sJNlQ6e3YG1IBvVlNu4DJ+Djoq7TfPq9ozR2gQ+vDT0eVoTcjC/K28Vhv
	 m2C5XA9Qg8kBH5p90p7XWLZfbJhr8l/ODdAxcJV4DFgUEVpA5yEvh++6lIg/FoaaBj
	 PjWcAAtK1vaFZqy2KeBFLwonL0vgFmufrdfAKRGy/2a+KkHXO6jYrBYkkzzRSAQmsa
	 Obj1Jt68/1AmHUxHIdK+jjJSfJuUH5i1i+r38UgDy51Fv0W8Ip4o+Lhp+XW/a1qwcm
	 ycPdNumht9I9w==
Date: Mon, 15 Sep 2025 17:44:39 -0700
Subject: [PATCH 11/18] libfuse: support direct I/O through iomap
From: "Darrick J. Wong" <djwong@kernel.org>
To: bschubert@ddn.com, djwong@kernel.org
Cc: John@groves.net, neal@gompa.dev, bernd@bsbernd.com,
 linux-fsdevel@vger.kernel.org, miklos@szeredi.hu, joannelkoong@gmail.com
Message-ID: <175798154708.386924.2548480844070701851.stgit@frogsfrogsfrogs>
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
index b349ede09e494f..48db6ba118a47c 100644
--- a/include/fuse_kernel.h
+++ b/include/fuse_kernel.h
@@ -238,6 +238,7 @@
  *
  *  7.99
  *  - add FUSE_IOMAP and iomap_{begin,end,ioend} for regular file operations
+ *  - add FUSE_ATTR_IOMAP to enable iomap for specific inodes
  */
 
 #ifndef _LINUX_FUSE_H
@@ -578,9 +579,11 @@ struct fuse_file_lock {
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
index bddc161412f33e..8654ca263b374d 100644
--- a/lib/fuse_lowlevel.c
+++ b/lib/fuse_lowlevel.c
@@ -124,6 +124,8 @@ static void convert_stat(const struct stat *stbuf, struct fuse_attr *attr,
 	attr->flags	= 0;
 	if (iflags & FUSE_IFLAG_DAX)
 		attr->flags |= FUSE_ATTR_DAX;
+	if (iflags & FUSE_IFLAG_IOMAP)
+		attr->flags |= FUSE_ATTR_IOMAP;
 }
 
 static void convert_attr(const struct fuse_setattr_in *attr, struct stat *stbuf)


