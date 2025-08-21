Return-Path: <linux-fsdevel+bounces-58486-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 929BDB2E9F3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 03:04:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 899703B8D93
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 01:04:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AACF1F9A89;
	Thu, 21 Aug 2025 01:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iZDqS0Av"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC40B1A9FAD
	for <linux-fsdevel@vger.kernel.org>; Thu, 21 Aug 2025 01:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755738254; cv=none; b=ISnY8IkTEbJzOMMJsVHD9lekoKXOymNuV4cY42S6USQJbNUSQ0ht94KZm0YHgz1QgyyAtfw7o5CcgBtq/m8FSrwV+Bu6I+lcAtVlTr2sHgf2ZlAh9YhusoDAldHwA4nZXx+WqfFICC7rhD6C7D6n4gkA8+cnNd2adnlOWQxbB+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755738254; c=relaxed/simple;
	bh=YII6AO6vbj3FDCaji2S9p7dtBv3161AMyAGKVU/NwF0=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A79tp4Wh8aTdnKIW2xm3huXmON/bHnzwBCk7gE5s2klyCCPTfETcPDKNqmoJDYjpY/Vl3I7L1onxnCfleat/dloD3mSp9kqKisthyQUQPsWtcJlfUKNCgiLKp6YPUE31ApRiL5HDYYC2dOpdUyWFcaZ297Ugj9WmzYTK8nqUDEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iZDqS0Av; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A9F6C4CEE7;
	Thu, 21 Aug 2025 01:04:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755738254;
	bh=YII6AO6vbj3FDCaji2S9p7dtBv3161AMyAGKVU/NwF0=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=iZDqS0AvUXlVoslrv1/2iM41ZHkcUV4COMvqqvJTtWo5fJryGgffZr7wlu5Z4pmpp
	 qgKJXZ0tjcDKhg9BCGgB4u2+wY4ynFK4wrIYEjaiApaojZ78aCZMkc2pl/78nOtNWm
	 OHDpUvoJnEdwDCF7EYL3unY68AzxIsVAL/oCqXUPwfMth+nz72aezcMsZwhYfswC6a
	 zABRIbF1VC1xXtCzAUboiVcqC6QZuOJFXVlWf9tvMnHV464MGSxgwL9do89ZkipJo8
	 of1PEtyhms+y8GqJC/l4oXHo3E+TW2uj48w4WqtinIBb73ZVDkwO51cPv4gqR970z2
	 Xb7gHLlhwbBFA==
Date: Wed, 20 Aug 2025 18:04:13 -0700
Subject: [PATCH 11/21] libfuse: support direct I/O through iomap
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, bschubert@ddn.com
Cc: John@groves.net, joannelkoong@gmail.com, bernd@bsbernd.com,
 linux-fsdevel@vger.kernel.org, miklos@szeredi.hu, neal@gompa.dev
Message-ID: <175573711490.19163.10014187924957089405.stgit@frogsfrogsfrogs>
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

Make it so that fuse servers can ask the kernel fuse driver to use iomap
to support direct IO.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 include/fuse_common.h |    2 ++
 include/fuse_kernel.h |    7 +++++--
 lib/fuse_lowlevel.c   |    2 ++
 3 files changed, 9 insertions(+), 2 deletions(-)


diff --git a/include/fuse_common.h b/include/fuse_common.h
index 9181ec6cb5e5e9..6e8b2958373258 100644
--- a/include/fuse_common.h
+++ b/include/fuse_common.h
@@ -1228,6 +1228,8 @@ static inline bool fuse_iomap_need_write_allocate(unsigned int opflags,
 
 /* enable fsdax */
 #define FUSE_IFLAG_DAX			(1U << 0)
+/* use iomap for this inode */
+#define FUSE_IFLAG_IOMAP		(1U << 1)
 
 /* ----------------------------------------------------------- *
  * Compatibility stuff					       *
diff --git a/include/fuse_kernel.h b/include/fuse_kernel.h
index 849238c17baf5e..86c81871ca2b37 100644
--- a/include/fuse_kernel.h
+++ b/include/fuse_kernel.h
@@ -238,7 +238,8 @@
  *
  *  7.99
  *  - add FUSE_IOMAP and iomap_{begin,end,ioend} handlers for FIEMAP and
- *    SEEK_{DATA,HOLE}
+ *    SEEK_{DATA,HOLE}, and direct I/O
+ *  - add FUSE_ATTR_IOMAP to enable iomap for specific inodes
  */
 
 #ifndef _LINUX_FUSE_H
@@ -448,7 +449,7 @@ struct fuse_file_lock {
  * FUSE_REQUEST_TIMEOUT: kernel supports timing out requests.
  *			 init_out.request_timeout contains the timeout (in secs)
  * FUSE_IOMAP: Client supports iomap for FIEMAP and SEEK_{DATA,HOLE} file
- *	       operations.
+ *	       operations and direct I/O.
  */
 #define FUSE_ASYNC_READ		(1 << 0)
 #define FUSE_POSIX_LOCKS	(1 << 1)
@@ -580,9 +581,11 @@ struct fuse_file_lock {
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
index 04bc858f54d01f..6a96c0f62d5884 100644
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


