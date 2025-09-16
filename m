Return-Path: <linux-fsdevel+bounces-61522-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D0ED8B58990
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 02:32:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E65CD3B9925
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 00:32:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97A4E1AAE28;
	Tue, 16 Sep 2025 00:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C2hXuFnM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDB3135950;
	Tue, 16 Sep 2025 00:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757982714; cv=none; b=fVpEJ5oE4DbHvdSbSttrYCReMFSttOhrlCjYItbI9O7eVKuzFMfKdJPKBWKRg39sTaXjAF6mCetkxlCVxZPrGy0G6XX8YHYMcCPgrxGWFgoXW93ViEPsOKLGSc0CM16fbcId72ATTPmwOPsLHR1VSEPORaOMksVZPElC8y9dTgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757982714; c=relaxed/simple;
	bh=dsEoOPVpXSRuxFaKAuGKihEVePqzdjR4dRZdoAOvtXA=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Xa4h6jYoBZiaz8g1/IvkyWgiVO8lSgcqLoBDd1o6h5zqP/bYN2zOTTF9YwRZ+yTlO4oTgcDoPRmfG2d5NSMtisqOs6HoKvo2bIgFdIMq8RDPIBErbskBgS3yrb4mdfQudD5RVqrx7no+tVCF94X1goeAwjhEsKeb06SUJejgsvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C2hXuFnM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 987FBC4CEF1;
	Tue, 16 Sep 2025 00:31:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757982713;
	bh=dsEoOPVpXSRuxFaKAuGKihEVePqzdjR4dRZdoAOvtXA=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=C2hXuFnMFtLA7DFQE8zBPQKtpD2Pk9u6NPlAtHFuRjjMl1PCU0Uk6pMyC3rCmAspv
	 kDNpZ95LpUGkzzek7Zr9CIZDn/ixM0nPvAyTVDzqOsKf0epcMpUEWgi8L1xDNVhkyJ
	 OQt18AK38E4OqDt0Ku2yJC8M/yFijXN2Nn89BB/GBK5+Awrz2EHsrchr0avnApIj5J
	 Ny3RlPPvC8jgvubEHhJCZ1IUNnNeHuK+lSupBsZIXpJyg8ftxWj90cpmW6/7uPszoh
	 i5IrEINEbvnie4sfiBiOT1a447s7HEoZS1Qlc5Pfxx3e0GiSSL+8guXXiysMNzK/Zh
	 75vXCM53sZDlw==
Date: Mon, 15 Sep 2025 17:31:53 -0700
Subject: [PATCH 15/28] fuse_trace: implement buffered IO with iomap
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, miklos@szeredi.hu
Cc: bernd@bsbernd.com, linux-xfs@vger.kernel.org, John@groves.net,
 linux-fsdevel@vger.kernel.org, neal@gompa.dev, joannelkoong@gmail.com
Message-ID: <175798151588.382724.12106766652431369699.stgit@frogsfrogsfrogs>
In-Reply-To: <175798151087.382724.2707973706304359333.stgit@frogsfrogsfrogs>
References: <175798151087.382724.2707973706304359333.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

Add tracepoints for the previous patch.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/fuse/fuse_trace.h |  252 ++++++++++++++++++++++++++++++++++++++++++++++++++
 fs/fuse/file_iomap.c |   40 ++++++++
 2 files changed, 288 insertions(+), 4 deletions(-)


diff --git a/fs/fuse/fuse_trace.h b/fs/fuse/fuse_trace.h
index 434d38ce89c428..e69ad48b14066b 100644
--- a/fs/fuse/fuse_trace.h
+++ b/fs/fuse/fuse_trace.h
@@ -224,6 +224,9 @@ DEFINE_FUSE_BACKING_EVENT(fuse_backing_close);
 #endif /* CONFIG_FUSE_BACKING */
 
 #if IS_ENABLED(CONFIG_FUSE_IOMAP)
+struct iomap_writepage_ctx;
+struct iomap_ioend;
+
 /* tracepoint boilerplate so we don't have to keep doing this */
 #define FUSE_IOMAP_OPFLAGS_FIELD \
 		__field(unsigned,		opflags)
@@ -291,7 +294,8 @@ DEFINE_FUSE_BACKING_EVENT(fuse_backing_close);
 	{ FUSE_IOMAP_OP_UNSHARE,		"unshare" }, \
 	{ FUSE_IOMAP_OP_DAX,			"fsdax" }, \
 	{ FUSE_IOMAP_OP_ATOMIC,			"atomic" }, \
-	{ FUSE_IOMAP_OP_DONTCACHE,		"dontcache" }
+	{ FUSE_IOMAP_OP_DONTCACHE,		"dontcache" }, \
+	{ FUSE_IOMAP_OP_WRITEBACK,		"writeback" }
 
 #define FUSE_IOMAP_TYPE_STRINGS \
 	{ FUSE_IOMAP_TYPE_PURE_OVERWRITE,	"overwrite" }, \
@@ -306,7 +310,8 @@ DEFINE_FUSE_BACKING_EVENT(fuse_backing_close);
 	{ FUSE_IOMAP_IOEND_UNWRITTEN,		"unwritten" }, \
 	{ FUSE_IOMAP_IOEND_BOUNDARY,		"boundary" }, \
 	{ FUSE_IOMAP_IOEND_DIRECT,		"direct" }, \
-	{ FUSE_IOMAP_IOEND_APPEND,		"append" }
+	{ FUSE_IOMAP_IOEND_APPEND,		"append" }, \
+	{ FUSE_IOMAP_IOEND_WRITEBACK,		"writeback" }
 
 #define IOMAP_DIOEND_STRINGS \
 	{ IOMAP_DIO_UNWRITTEN,			"unwritten" }, \
@@ -329,6 +334,12 @@ TRACE_DEFINE_ENUM(FUSE_I_IOMAP);
 	{ 1 << FUSE_I_CACHE_IO_MODE,		"cacheio" }, \
 	{ 1 << FUSE_I_IOMAP,			"iomap" }
 
+#define IOMAP_IOEND_STRINGS \
+	{ IOMAP_IOEND_SHARED,			"shared" }, \
+	{ IOMAP_IOEND_UNWRITTEN,		"unwritten" }, \
+	{ IOMAP_IOEND_BOUNDARY,			"boundary" }, \
+	{ IOMAP_IOEND_DIRECT,			"direct" }
+
 DECLARE_EVENT_CLASS(fuse_iomap_check_class,
 	TP_PROTO(const char *func, int line, const char *condition),
 
@@ -668,6 +679,9 @@ DEFINE_EVENT(fuse_iomap_file_io_class, name,		\
 	TP_ARGS(iocb, iter))
 DEFINE_FUSE_IOMAP_FILE_IO_EVENT(fuse_iomap_direct_read);
 DEFINE_FUSE_IOMAP_FILE_IO_EVENT(fuse_iomap_direct_write);
+DEFINE_FUSE_IOMAP_FILE_IO_EVENT(fuse_iomap_buffered_read);
+DEFINE_FUSE_IOMAP_FILE_IO_EVENT(fuse_iomap_buffered_write);
+DEFINE_FUSE_IOMAP_FILE_IO_EVENT(fuse_iomap_write_zero_eof);
 
 DECLARE_EVENT_CLASS(fuse_iomap_file_ioend_class,
 	TP_PROTO(const struct kiocb *iocb, const struct iov_iter *iter,
@@ -694,6 +708,8 @@ DEFINE_EVENT(fuse_iomap_file_ioend_class, name,		\
 	TP_ARGS(iocb, iter, ret))
 DEFINE_FUSE_IOMAP_FILE_IOEND_EVENT(fuse_iomap_direct_read_end);
 DEFINE_FUSE_IOMAP_FILE_IOEND_EVENT(fuse_iomap_direct_write_end);
+DEFINE_FUSE_IOMAP_FILE_IOEND_EVENT(fuse_iomap_buffered_read_end);
+DEFINE_FUSE_IOMAP_FILE_IOEND_EVENT(fuse_iomap_buffered_write_end);
 
 TRACE_EVENT(fuse_iomap_dio_write_end_io,
 	TP_PROTO(const struct inode *inode, loff_t pos, ssize_t written,
@@ -720,6 +736,238 @@ TRACE_EVENT(fuse_iomap_dio_write_end_io,
 		  __print_flags(__entry->dioendflags, "|", IOMAP_DIOEND_STRINGS),
 		  __entry->error)
 );
+
+TRACE_EVENT(fuse_iomap_end_ioend,
+	TP_PROTO(const struct iomap_ioend *ioend),
+
+	TP_ARGS(ioend),
+
+	TP_STRUCT__entry(
+		FUSE_IO_RANGE_FIELDS()
+		__field(unsigned int,		ioendflags)
+		__field(int,			error)
+	),
+
+	TP_fast_assign(
+		FUSE_INODE_ASSIGN(ioend->io_inode, fi, fm);
+		__entry->offset		=	ioend->io_offset;
+		__entry->length		=	ioend->io_size;
+		__entry->ioendflags	=	ioend->io_flags;
+		__entry->error		=	blk_status_to_errno(ioend->io_bio.bi_status);
+	),
+
+	TP_printk(FUSE_IO_RANGE_FMT() " ioendflags (%s) error %d",
+		  FUSE_IO_RANGE_PRINTK_ARGS(),
+		  __print_flags(__entry->ioendflags, "|", IOMAP_IOEND_STRINGS),
+		  __entry->error)
+);
+
+TRACE_EVENT(fuse_iomap_writeback_range,
+	TP_PROTO(const struct inode *inode, u64 offset, unsigned int count,
+		 u64 end_pos),
+
+	TP_ARGS(inode, offset, count, end_pos),
+
+	TP_STRUCT__entry(
+		FUSE_IO_RANGE_FIELDS()
+		__field(uint64_t,		end_pos)
+	),
+
+	TP_fast_assign(
+		FUSE_INODE_ASSIGN(inode, fi, fm);
+		__entry->offset		=	offset;
+		__entry->length		=	count;
+		__entry->end_pos	=	end_pos;
+	),
+
+	TP_printk(FUSE_IO_RANGE_FMT() " end_pos 0x%llx",
+		  FUSE_IO_RANGE_PRINTK_ARGS(),
+		  __entry->end_pos)
+);
+
+TRACE_EVENT(fuse_iomap_writeback_submit,
+	TP_PROTO(const struct iomap_writepage_ctx *wpc, int error),
+
+	TP_ARGS(wpc, error),
+
+	TP_STRUCT__entry(
+		FUSE_IO_RANGE_FIELDS()
+		__field(unsigned int,		nr_folios)
+		__field(uint64_t,		addr)
+		__field(int,			error)
+	),
+
+	TP_fast_assign(
+		FUSE_INODE_ASSIGN(wpc->inode, fi, fm);
+		__entry->nr_folios	=	wpc->nr_folios;
+		__entry->offset		=	wpc->iomap.offset;
+		__entry->length		=	wpc->iomap.length;
+		__entry->addr		=	wpc->iomap.addr << 9;
+		__entry->error		=	error;
+	),
+
+	TP_printk(FUSE_IO_RANGE_FMT() " addr 0x%llx nr_folios %u error %d",
+		  FUSE_IO_RANGE_PRINTK_ARGS(),
+		  __entry->addr,
+		  __entry->nr_folios,
+		  __entry->error)
+);
+
+TRACE_EVENT(fuse_iomap_discard_folio,
+	TP_PROTO(const struct inode *inode, loff_t offset, size_t count),
+
+	TP_ARGS(inode, offset, count),
+
+	TP_STRUCT__entry(
+		FUSE_IO_RANGE_FIELDS()
+	),
+
+	TP_fast_assign(
+		FUSE_INODE_ASSIGN(inode, fi, fm);
+		__entry->offset		=	offset;
+		__entry->length		=	count;
+	),
+
+	TP_printk(FUSE_IO_RANGE_FMT(),
+		  FUSE_IO_RANGE_PRINTK_ARGS())
+);
+
+TRACE_EVENT(fuse_iomap_writepages,
+	TP_PROTO(const struct inode *inode, const struct writeback_control *wbc),
+
+	TP_ARGS(inode, wbc),
+
+	TP_STRUCT__entry(
+		FUSE_IO_RANGE_FIELDS()
+		__field(long,			nr_to_write)
+		__field(bool,			sync_all)
+	),
+
+	TP_fast_assign(
+		FUSE_INODE_ASSIGN(inode, fi, fm);
+		__entry->offset		=	wbc->range_start;
+		__entry->length		=	wbc->range_end - wbc->range_start + 1;
+		__entry->nr_to_write	=	wbc->nr_to_write;
+		__entry->sync_all	=	wbc->sync_mode == WB_SYNC_ALL;
+	),
+
+	TP_printk(FUSE_IO_RANGE_FMT() " nr_folios %ld sync_all? %d",
+		  FUSE_IO_RANGE_PRINTK_ARGS(),
+		  __entry->nr_to_write,
+		  __entry->sync_all)
+);
+
+TRACE_EVENT(fuse_iomap_read_folio,
+	TP_PROTO(const struct folio *folio),
+
+	TP_ARGS(folio),
+
+	TP_STRUCT__entry(
+		FUSE_IO_RANGE_FIELDS()
+	),
+
+	TP_fast_assign(
+		FUSE_INODE_ASSIGN(folio->mapping->host, fi, fm);
+		__entry->offset		=	folio_pos(folio);
+		__entry->length		=	folio_size(folio);
+	),
+
+	TP_printk(FUSE_IO_RANGE_FMT(),
+		  FUSE_IO_RANGE_PRINTK_ARGS())
+);
+
+TRACE_EVENT(fuse_iomap_readahead,
+	TP_PROTO(const struct readahead_control *rac),
+
+	TP_ARGS(rac),
+
+	TP_STRUCT__entry(
+		FUSE_IO_RANGE_FIELDS()
+	),
+
+	TP_fast_assign(
+		struct readahead_control *mutrac = (struct readahead_control *)rac;
+		FUSE_INODE_ASSIGN(file_inode(rac->file), fi, fm);
+		__entry->offset		=	readahead_pos(mutrac);
+		__entry->length		=	readahead_length(mutrac);
+	),
+
+	TP_printk(FUSE_IO_RANGE_FMT(),
+		  FUSE_IO_RANGE_PRINTK_ARGS())
+);
+
+TRACE_EVENT(fuse_iomap_page_mkwrite,
+	TP_PROTO(const struct vm_fault *vmf),
+
+	TP_ARGS(vmf),
+
+	TP_STRUCT__entry(
+		FUSE_IO_RANGE_FIELDS()
+	),
+
+	TP_fast_assign(
+		struct folio *folio = page_folio(vmf->page);
+		FUSE_INODE_ASSIGN(file_inode(vmf->vma->vm_file), fi, fm);
+		__entry->offset		=	folio_pos(folio);
+		__entry->length		=	folio_size(folio);
+	),
+
+	TP_printk(FUSE_IO_RANGE_FMT(),
+		  FUSE_IO_RANGE_PRINTK_ARGS())
+);
+
+DECLARE_EVENT_CLASS(fuse_iomap_file_range_class,
+	TP_PROTO(const struct inode *inode, loff_t offset, loff_t length),
+
+	TP_ARGS(inode, offset, length),
+
+	TP_STRUCT__entry(
+		FUSE_IO_RANGE_FIELDS()
+	),
+
+	TP_fast_assign(
+		FUSE_INODE_ASSIGN(inode, fi, fm);
+		__entry->offset		=	offset;
+		__entry->length		=	length;
+	),
+
+	TP_printk(FUSE_IO_RANGE_FMT(),
+		  FUSE_IO_RANGE_PRINTK_ARGS())
+)
+#define DEFINE_FUSE_IOMAP_FILE_RANGE_EVENT(name)		\
+DEFINE_EVENT(fuse_iomap_file_range_class, name,		\
+	TP_PROTO(const struct inode *inode, loff_t offset, loff_t length), \
+	TP_ARGS(inode, offset, length))
+DEFINE_FUSE_IOMAP_FILE_RANGE_EVENT(fuse_iomap_truncate_up);
+DEFINE_FUSE_IOMAP_FILE_RANGE_EVENT(fuse_iomap_truncate_down);
+DEFINE_FUSE_IOMAP_FILE_RANGE_EVENT(fuse_iomap_punch_range);
+DEFINE_FUSE_IOMAP_FILE_RANGE_EVENT(fuse_iomap_setsize);
+DEFINE_FUSE_IOMAP_FILE_RANGE_EVENT(fuse_iomap_flush_unmap_range);
+
+TRACE_EVENT(fuse_iomap_fallocate,
+	TP_PROTO(const struct inode *inode, int mode, loff_t offset,
+		 loff_t length, loff_t newsize),
+	TP_ARGS(inode, mode, offset, length, newsize),
+
+	TP_STRUCT__entry(
+		FUSE_IO_RANGE_FIELDS()
+		__field(loff_t,			newsize)
+		__field(int,			mode)
+	),
+
+	TP_fast_assign(
+		FUSE_INODE_ASSIGN(inode, fi, fm);
+		__entry->offset		=	offset;
+		__entry->length		=	length;
+		__entry->mode		=	mode;
+		__entry->newsize	=	newsize;
+	),
+
+	TP_printk(FUSE_IO_RANGE_FMT() " mode 0x%x newsize 0x%llx",
+		  FUSE_IO_RANGE_PRINTK_ARGS(),
+		  __entry->mode,
+		  __entry->newsize)
+);
 #endif /* CONFIG_FUSE_IOMAP */
 
 #endif /* _TRACE_FUSE_H */
diff --git a/fs/fuse/file_iomap.c b/fs/fuse/file_iomap.c
index 64f851d04a009b..d771b1068fb912 100644
--- a/fs/fuse/file_iomap.c
+++ b/fs/fuse/file_iomap.c
@@ -1003,6 +1003,8 @@ fuse_iomap_write_zero_eof(
 		return 1;
 	}
 
+	trace_fuse_iomap_write_zero_eof(iocb, from);
+
 	filemap_invalidate_lock(mapping);
 	error = fuse_iomap_zero_range(inode, isize, iocb->ki_pos - isize, NULL);
 	filemap_invalidate_unlock(mapping);
@@ -1115,6 +1117,8 @@ static void fuse_iomap_end_ioend(struct iomap_ioend *ioend)
 	if (fuse_is_bad(inode))
 		return;
 
+	trace_fuse_iomap_end_ioend(ioend);
+
 	if (ioend->io_flags & IOMAP_IOEND_SHARED)
 		ioendflags |= FUSE_IOMAP_IOEND_SHARED;
 	if (ioend->io_flags & IOMAP_IOEND_UNWRITTEN)
@@ -1223,6 +1227,8 @@ static void fuse_iomap_discard_folio(struct folio *folio, loff_t pos, int error)
 
 	ASSERT(fuse_inode_has_iomap(inode));
 
+	trace_fuse_iomap_discard_folio(inode, pos, folio_size(folio));
+
 	printk_ratelimited(KERN_ERR
 		"page discard on page %px, inode 0x%llx, pos %llu.",
 			folio, fi->orig_ino, pos);
@@ -1246,6 +1252,8 @@ static ssize_t fuse_iomap_writeback_range(struct iomap_writepage_ctx *wpc,
 
 	ASSERT(fuse_inode_has_iomap(inode));
 
+	trace_fuse_iomap_writeback_range(inode, offset, len, end_pos);
+
 	if (!fuse_iomap_revalidate_writeback(wpc, offset)) {
 		ret = fuse_iomap_begin(inode, offset, len,
 				       FUSE_IOMAP_OP_WRITEBACK,
@@ -1283,6 +1291,8 @@ static int fuse_iomap_writeback_submit(struct iomap_writepage_ctx *wpc,
 
 	ASSERT(fuse_inode_has_iomap(ioend->io_inode));
 
+	trace_fuse_iomap_writeback_submit(wpc, error);
+
 	/* always call our ioend function, even if we cancel the bio */
 	ioend->io_bio.bi_end_io = fuse_iomap_end_bio;
 	return iomap_ioend_writeback_submit(wpc, error);
@@ -1306,6 +1316,8 @@ static int fuse_iomap_writepages(struct address_space *mapping,
 
 	ASSERT(fuse_inode_has_iomap(mapping->host));
 
+	trace_fuse_iomap_writepages(mapping->host, wbc);
+
 	return iomap_writepages(&wpc.ctx);
 }
 
@@ -1313,6 +1325,8 @@ static int fuse_iomap_read_folio(struct file *file, struct folio *folio)
 {
 	ASSERT(fuse_inode_has_iomap(file_inode(file)));
 
+	trace_fuse_iomap_read_folio(folio);
+
 	return iomap_read_folio(folio, &fuse_iomap_ops);
 }
 
@@ -1320,6 +1334,8 @@ static void fuse_iomap_readahead(struct readahead_control *rac)
 {
 	ASSERT(fuse_inode_has_iomap(file_inode(rac->file)));
 
+	trace_fuse_iomap_readahead(rac);
+
 	iomap_readahead(rac, &fuse_iomap_ops);
 }
 
@@ -1370,6 +1386,8 @@ static vm_fault_t fuse_iomap_page_mkwrite(struct vm_fault *vmf)
 
 	ASSERT(fuse_inode_has_iomap(inode));
 
+	trace_fuse_iomap_page_mkwrite(vmf);
+
 	sb_start_pagefault(inode->i_sb);
 	file_update_time(vmf->vma->vm_file);
 
@@ -1403,6 +1421,8 @@ ssize_t fuse_iomap_buffered_read(struct kiocb *iocb, struct iov_iter *to)
 
 	ASSERT(fuse_inode_has_iomap(inode));
 
+	trace_fuse_iomap_buffered_read(iocb, to);
+
 	if (!iov_iter_count(to))
 		return 0; /* skip atime */
 
@@ -1414,6 +1434,7 @@ ssize_t fuse_iomap_buffered_read(struct kiocb *iocb, struct iov_iter *to)
 	ret = generic_file_read_iter(iocb, to);
 	inode_unlock_shared(inode);
 
+	trace_fuse_iomap_buffered_read_end(iocb, to, ret);
 	return ret;
 }
 
@@ -1426,6 +1447,8 @@ ssize_t fuse_iomap_buffered_write(struct kiocb *iocb, struct iov_iter *from)
 
 	ASSERT(fuse_inode_has_iomap(inode));
 
+	trace_fuse_iomap_buffered_write(iocb, from);
+
 	if (!iov_iter_count(from))
 		return 0;
 
@@ -1454,6 +1477,7 @@ ssize_t fuse_iomap_buffered_write(struct kiocb *iocb, struct iov_iter *from)
 		/* Handle various SYNC-type writes */
 		ret = generic_write_sync(iocb, ret);
 	}
+	trace_fuse_iomap_buffered_write_end(iocb, from, ret);
 	return ret;
 }
 
@@ -1499,11 +1523,17 @@ fuse_iomap_setsize_start(
 	 * extension, or zeroing out the rest of the block on a downward
 	 * truncate.
 	 */
-	if (newsize > oldsize)
+	if (newsize > oldsize) {
+		trace_fuse_iomap_truncate_up(inode, oldsize, newsize - oldsize);
+
 		error = fuse_iomap_zero_range(inode, oldsize, newsize - oldsize,
 					      &did_zeroing);
-	else
+	} else {
+		trace_fuse_iomap_truncate_down(inode, newsize,
+					       oldsize - newsize);
+
 		error = fuse_iomap_truncate_page(inode, newsize, &did_zeroing);
+	}
 	if (error)
 		return error;
 
@@ -1550,6 +1580,8 @@ int fuse_iomap_flush_unmap_range(struct inode *inode, loff_t pos,
 	start = round_down(pos, rounding);
 	end = round_up(endpos + 1, rounding) - 1;
 
+	trace_fuse_iomap_flush_unmap_range(inode, start, end + 1 - start);
+
 	error = filemap_write_and_wait_range(inode->i_mapping, start, end);
 	if (error)
 		return error;
@@ -1563,6 +1595,8 @@ static int fuse_iomap_punch_range(struct inode *inode, loff_t offset,
 	loff_t isize = i_size_read(inode);
 	int error;
 
+	trace_fuse_iomap_punch_range(inode, offset, length);
+
 	/*
 	 * Now that we've unmap all full blocks we'll have to zero out any
 	 * partial block at the beginning and/or end.  iomap_zero_range is
@@ -1606,6 +1640,8 @@ fuse_iomap_fallocate(
 
 	ASSERT(fuse_inode_has_iomap(inode));
 
+	trace_fuse_iomap_fallocate(inode, mode, offset, length, new_size);
+
 	/*
 	 * If we unmapped blocks from the file range, then we zero the
 	 * pagecache for those regions and push them to disk rather than make


