Return-Path: <linux-fsdevel+bounces-66032-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D1E39C17A8D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 01:53:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3DBD51897930
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 00:53:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11C842D6E52;
	Wed, 29 Oct 2025 00:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jCXclfZ/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68D6F3BBF0;
	Wed, 29 Oct 2025 00:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761699167; cv=none; b=QIEVVGuFuTZITxFVf8zQlyYSmVS+36D04m+UCv//IO+OU67XK36r5CkE3L93XkJSyUNK0BQuRJWl5a2xQdfNymEMCwfr6rGmKhJboD2m3HNoclGGHxwpyLVovX5bz290Ovo9Y/VYm3x1KgoF/8GgwEVIMIBQFUTPMn2LU5kZ4bM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761699167; c=relaxed/simple;
	bh=etDL2QRplev4HNdnCG6wApWsqGk5BWsgbv1Icp2HGlE=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=vE3izf9U8OI+RjJ+I0dKK+UOhbazWENJUI/QFXfu2s6/CES0NvCT/1p3pEuPyvoUNMysDC1jqxqPcCGRE89kJmcbGrg2vSxyWffRJMcON1PJJQ5nCOKM5YW9FqzRSaM8Q1OEX2LTA7xbCEVzVd3SzS3r7iHz3MzksWmQNUhmniA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jCXclfZ/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0923AC4CEE7;
	Wed, 29 Oct 2025 00:52:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761699167;
	bh=etDL2QRplev4HNdnCG6wApWsqGk5BWsgbv1Icp2HGlE=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=jCXclfZ/tYAYQ9QcnwGhWQLCetpzGVDOGwYAjsKvE4kytCv7eZ38KlWFpdOtFmhNL
	 W/ghz1QeKXBlMYggI+jQiC9khe5v1cutazQXpkf3RNB1/og1qbOlXYJcxo8qXXQ6yj
	 Fq9eHw8nMxhDZ1ysOxW99ERdt654CPFuiMmjvzmhivhU27nLr//4hrbDtikU7o3/bk
	 cTNRV4KbQOJgc2Fmq/D5+XAYdjMikeH9aK5qpOdxNmd4bXCsahZI/OHucJ9VvDg2AD
	 41d+qpm/BQFvu1bVid6J3fdaDnifsq+w5Px4+XAJE/CX4/JVmat6Ynp0y0SjqUYjgW
	 D7PjmIT0bbvZA==
Date: Tue, 28 Oct 2025 17:52:46 -0700
Subject: [PATCH 30/31] fuse: enable swapfile activation on iomap
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, miklos@szeredi.hu
Cc: joannelkoong@gmail.com, bernd@bsbernd.com, neal@gompa.dev,
 linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org
Message-ID: <176169811001.1424854.7988498563260897778.stgit@frogsfrogsfrogs>
In-Reply-To: <176169810144.1424854.11439355400009006946.stgit@frogsfrogsfrogs>
References: <176169810144.1424854.11439355400009006946.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

It turns out that fuse supports swapfile activation, so let's enable
that.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/fuse/fuse_trace.h      |    1 +
 include/uapi/linux/fuse.h |    5 +++++
 fs/fuse/file_iomap.c      |   50 ++++++++++++++++++++++++++++++++++++++++++++-
 3 files changed, 55 insertions(+), 1 deletion(-)


diff --git a/fs/fuse/fuse_trace.h b/fs/fuse/fuse_trace.h
index ecfb988f86224b..c425c56f71d4af 100644
--- a/fs/fuse/fuse_trace.h
+++ b/fs/fuse/fuse_trace.h
@@ -297,6 +297,7 @@ struct iomap;
 	{ FUSE_IOMAP_OP_DAX,			"fsdax" }, \
 	{ FUSE_IOMAP_OP_ATOMIC,			"atomic" }, \
 	{ FUSE_IOMAP_OP_DONTCACHE,		"dontcache" }, \
+	{ FUSE_IOMAP_OP_SWAPFILE,		"swapfile" }, \
 	{ FUSE_IOMAP_OP_WRITEBACK,		"writeback" }
 
 #define FUSE_IOMAP_TYPE_STRINGS \
diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
index 99ad2367d1dc20..41e88f1089f1b9 100644
--- a/include/uapi/linux/fuse.h
+++ b/include/uapi/linux/fuse.h
@@ -1400,6 +1400,9 @@ struct fuse_uring_cmd_req {
 #define FUSE_IOMAP_OP_ATOMIC		(1U << 9)
 #define FUSE_IOMAP_OP_DONTCACHE		(1U << 10)
 
+/* swapfile config operation */
+#define FUSE_IOMAP_OP_SWAPFILE		(1U << 30)
+
 /* pagecache writeback operation */
 #define FUSE_IOMAP_OP_WRITEBACK		(1U << 31)
 
@@ -1454,6 +1457,8 @@ struct fuse_iomap_end_in {
 #define FUSE_IOMAP_IOEND_APPEND		(1U << 4)
 /* is pagecache writeback */
 #define FUSE_IOMAP_IOEND_WRITEBACK	(1U << 5)
+/* swapfile deactivation */
+#define FUSE_IOMAP_IOEND_SWAPOFF	(1U << 6)
 
 struct fuse_iomap_ioend_in {
 	uint32_t ioendflags;	/* FUSE_IOMAP_IOEND_* */
diff --git a/fs/fuse/file_iomap.c b/fs/fuse/file_iomap.c
index 9dab06c05eee28..f7459a0c138c12 100644
--- a/fs/fuse/file_iomap.c
+++ b/fs/fuse/file_iomap.c
@@ -8,6 +8,7 @@
 #include <linux/pagemap.h>
 #include <linux/falloc.h>
 #include <linux/fadvise.h>
+#include <linux/swap.h>
 #include "fuse_i.h"
 #include "fuse_trace.h"
 #include "iomap_i.h"
@@ -238,13 +239,16 @@ static inline uint16_t fuse_iomap_flags_from_server(uint16_t fuse_f_flags)
 #undef YMAP
 #undef XMAP
 
+#define FUSE_IOMAP_PRIVATE_OPS	(FUSE_IOMAP_OP_WRITEBACK | \
+				 FUSE_IOMAP_OP_SWAPFILE)
+
 /* Convert IOMAP_* operation flags to FUSE_IOMAP_OP_* */
 #define XMAP(word) \
 	if (iomap_op_flags & IOMAP_##word) \
 		ret |= FUSE_IOMAP_OP_##word
 static inline uint32_t fuse_iomap_op_to_server(unsigned iomap_op_flags)
 {
-	uint32_t ret = iomap_op_flags & FUSE_IOMAP_OP_WRITEBACK;
+	uint32_t ret = iomap_op_flags & FUSE_IOMAP_PRIVATE_OPS;
 
 	XMAP(WRITE);
 	XMAP(ZERO);
@@ -768,6 +772,13 @@ fuse_should_send_iomap_ioend(const struct fuse_mount *fm,
 	if (inarg->error)
 		return true;
 
+	/*
+	 * Always send an ioend for swapoff to let the fuse server know the
+	 * long term layout "lease" is over.
+	 */
+	if (inarg->ioendflags & FUSE_IOMAP_IOEND_SWAPOFF)
+		return true;
+
 	/* Send an ioend if we performed an IO involving metadata changes. */
 	return inarg->written > 0 &&
 	       (inarg->ioendflags & (FUSE_IOMAP_IOEND_SHARED |
@@ -1766,6 +1777,41 @@ static void fuse_iomap_readahead(struct readahead_control *rac)
 	iomap_readahead(rac, &fuse_iomap_ops);
 }
 
+static int fuse_iomap_swapfile_begin(struct inode *inode, loff_t pos,
+				     loff_t count, unsigned opflags,
+				     struct iomap *iomap, struct iomap *srcmap)
+{
+	return fuse_iomap_begin(inode, pos, count,
+				FUSE_IOMAP_OP_SWAPFILE | opflags, iomap,
+				srcmap);
+}
+
+static const struct iomap_ops fuse_iomap_swapfile_ops = {
+	.iomap_begin		= fuse_iomap_swapfile_begin,
+};
+
+static int fuse_iomap_swap_activate(struct swap_info_struct *sis,
+				    struct file *swap_file, sector_t *span)
+{
+	int ret;
+
+	/* obtain the block device from the header iomapping */
+	sis->bdev = NULL;
+	ret = iomap_swapfile_activate(sis, swap_file, span,
+				      &fuse_iomap_swapfile_ops);
+	if (ret)
+		fuse_iomap_ioend(file_inode(swap_file), 0, 0, ret,
+				 FUSE_IOMAP_IOEND_SWAPOFF,
+				 FUSE_IOMAP_NULL_ADDR);
+	return ret;
+}
+
+static void fuse_iomap_swap_deactivate(struct file *file)
+{
+	fuse_iomap_ioend(file_inode(file), 0, 0, 0, FUSE_IOMAP_IOEND_SWAPOFF,
+			 FUSE_IOMAP_NULL_ADDR);
+}
+
 static const struct address_space_operations fuse_iomap_aops = {
 	.read_folio		= fuse_iomap_read_folio,
 	.readahead		= fuse_iomap_readahead,
@@ -1776,6 +1822,8 @@ static const struct address_space_operations fuse_iomap_aops = {
 	.migrate_folio		= filemap_migrate_folio,
 	.is_partially_uptodate  = iomap_is_partially_uptodate,
 	.error_remove_folio	= generic_error_remove_folio,
+	.swap_activate		= fuse_iomap_swap_activate,
+	.swap_deactivate	= fuse_iomap_swap_deactivate,
 
 	/* These aren't pagecache operations per se */
 	.bmap			= fuse_bmap,


