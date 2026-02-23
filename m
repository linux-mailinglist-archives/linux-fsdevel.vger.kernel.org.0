Return-Path: <linux-fsdevel+bounces-78064-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id COpREUXfnGl/LwQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78064-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 00:14:13 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B9ABA17F0B2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 00:14:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0515F30729F4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 23:13:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8999D37E316;
	Mon, 23 Feb 2026 23:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NAxVwvmz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 136FD37E2FF;
	Mon, 23 Feb 2026 23:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771888388; cv=none; b=o+yF9FkfB0rJUbqL+SpHetT1P0MlBMx3LKA7cP+NKli/B1O3MlGxAn0WV/PpfGo+5m41uBEop6hBUtpeW+jGhTkSEBQNrAJjm9RyBafCfhYkJ1r51wbM+IIjI9NCze/1AhybLfyRl+VQHhIZWR+yMnufBBEibuDtA9seVW7dOGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771888388; c=relaxed/simple;
	bh=+xUqvfpkOP9orpASKEHpyNm/CpdnGqliE+Ox6nwTQjA=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tG0v4LrHLfb8FA3uTugGP+Fsdfpba8RaAVQDcErnydDBJ1BqSZgw2yDNZdic7kdQcyR4niQTzJjOOdVj64KbpGh5mSXyh56mBYBk4/LaweInhdpL+8UjBBL+/B2BhOHXTWfncMXBPq0ZQXCsJOyJnbw/KgvNlvS0wV3WTca/mh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NAxVwvmz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C966C116C6;
	Mon, 23 Feb 2026 23:13:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771888387;
	bh=+xUqvfpkOP9orpASKEHpyNm/CpdnGqliE+Ox6nwTQjA=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=NAxVwvmzgSvnPJrQ9dd/VGdCenfHKtHE2bx3I49b0qtMgF6/jXoSkd0qtks8gxAlq
	 tWl236m/W/XzNzOhpiYp2iJ61iFFw/qu5eZpciq/hFWLe0cKwIkh5G36X0InPK8zp8
	 DragHiySXyEudjOzF+Zd4A907ExwdkCRMk2qcPGQDFU6itgu1YGvSdCfWEN5n/Jmgx
	 1AEw3+eQf3LxGS6WNzDNwERScdKvaFIoRfyf8s1Qwpbbp0T8k6n3qE/gI2u1VfkUxP
	 AwpwoXNyIATT1FG+61FwWDOMoVgVAmzcAuFXCkA/Fn04yQg5suv+tuuxKWjjKIY4CH
	 qbN65+pWPD4+A==
Date: Mon, 23 Feb 2026 15:13:07 -0800
Subject: [PATCH 17/33] fuse_trace: implement buffered IO with iomap
From: "Darrick J. Wong" <djwong@kernel.org>
To: miklos@szeredi.hu, djwong@kernel.org
Cc: joannelkoong@gmail.com, bpf@vger.kernel.org, bernd@bsbernd.com,
 neal@gompa.dev, linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org
Message-ID: <177188734610.3935739.5970144792310702064.stgit@frogsfrogsfrogs>
In-Reply-To: <177188734044.3935739.1368557343243072212.stgit@frogsfrogsfrogs>
References: <177188734044.3935739.1368557343243072212.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,bsbernd.com,gompa.dev];
	TAGGED_FROM(0.00)[bounces-78064-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MIME_TRACE(0.00)[0:+];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[djwong@kernel.org,linux-fsdevel@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B9ABA17F0B2
X-Rspamd-Action: no action

From: Darrick J. Wong <djwong@kernel.org>

Add tracepoints for the previous patch.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/fuse/fuse_trace.h |  227 ++++++++++++++++++++++++++++++++++++++++++++++++++
 fs/fuse/dev.c        |   10 ++
 fs/fuse/fuse_iomap.c |   40 ++++++++-
 3 files changed, 273 insertions(+), 4 deletions(-)


diff --git a/fs/fuse/fuse_trace.h b/fs/fuse/fuse_trace.h
index a8337f5ddcf011..c832fb9012d983 100644
--- a/fs/fuse/fuse_trace.h
+++ b/fs/fuse/fuse_trace.h
@@ -227,6 +227,9 @@ DEFINE_FUSE_BACKING_EVENT(fuse_backing_close);
 #endif /* CONFIG_FUSE_BACKING */
 
 #if IS_ENABLED(CONFIG_FUSE_IOMAP)
+struct iomap_writepage_ctx;
+struct iomap_ioend;
+
 /* tracepoint boilerplate so we don't have to keep doing this */
 #define FUSE_IOMAP_OPFLAGS_FIELD \
 		__field(unsigned,		opflags)
@@ -294,7 +297,8 @@ DEFINE_FUSE_BACKING_EVENT(fuse_backing_close);
 	{ FUSE_IOMAP_OP_UNSHARE,		"unshare" }, \
 	{ FUSE_IOMAP_OP_DAX,			"fsdax" }, \
 	{ FUSE_IOMAP_OP_ATOMIC,			"atomic" }, \
-	{ FUSE_IOMAP_OP_DONTCACHE,		"dontcache" }
+	{ FUSE_IOMAP_OP_DONTCACHE,		"dontcache" }, \
+	{ FUSE_IOMAP_OP_WRITEBACK,		"writeback" }
 
 #define FUSE_IOMAP_TYPE_STRINGS \
 	{ FUSE_IOMAP_TYPE_PURE_OVERWRITE,	"overwrite" }, \
@@ -309,7 +313,8 @@ DEFINE_FUSE_BACKING_EVENT(fuse_backing_close);
 	{ FUSE_IOMAP_IOEND_UNWRITTEN,		"unwritten" }, \
 	{ FUSE_IOMAP_IOEND_BOUNDARY,		"boundary" }, \
 	{ FUSE_IOMAP_IOEND_DIRECT,		"direct" }, \
-	{ FUSE_IOMAP_IOEND_APPEND,		"append" }
+	{ FUSE_IOMAP_IOEND_APPEND,		"append" }, \
+	{ FUSE_IOMAP_IOEND_WRITEBACK,		"writeback" }
 
 #define IOMAP_DIOEND_STRINGS \
 	{ IOMAP_DIO_UNWRITTEN,			"unwritten" }, \
@@ -334,6 +339,12 @@ TRACE_DEFINE_ENUM(FUSE_I_IOMAP);
 	{ 1 << FUSE_I_EXCLUSIVE,		"excl" }, \
 	{ 1 << FUSE_I_IOMAP,			"iomap" }
 
+#define IOMAP_IOEND_STRINGS \
+	{ IOMAP_IOEND_SHARED,			"shared" }, \
+	{ IOMAP_IOEND_UNWRITTEN,		"unwritten" }, \
+	{ IOMAP_IOEND_BOUNDARY,			"boundary" }, \
+	{ IOMAP_IOEND_DIRECT,			"direct" }
+
 DECLARE_EVENT_CLASS(fuse_iomap_check_class,
 	TP_PROTO(const char *func, int line, const char *condition),
 
@@ -683,6 +694,9 @@ DEFINE_EVENT(fuse_iomap_file_io_class, name,		\
 	TP_ARGS(iocb, iter))
 DEFINE_FUSE_IOMAP_FILE_IO_EVENT(fuse_iomap_direct_read);
 DEFINE_FUSE_IOMAP_FILE_IO_EVENT(fuse_iomap_direct_write);
+DEFINE_FUSE_IOMAP_FILE_IO_EVENT(fuse_iomap_buffered_read);
+DEFINE_FUSE_IOMAP_FILE_IO_EVENT(fuse_iomap_buffered_write);
+DEFINE_FUSE_IOMAP_FILE_IO_EVENT(fuse_iomap_write_zero_eof);
 
 DECLARE_EVENT_CLASS(fuse_iomap_file_ioend_class,
 	TP_PROTO(const struct kiocb *iocb, const struct iov_iter *iter,
@@ -709,6 +723,8 @@ DEFINE_EVENT(fuse_iomap_file_ioend_class, name,		\
 	TP_ARGS(iocb, iter, ret))
 DEFINE_FUSE_IOMAP_FILE_IOEND_EVENT(fuse_iomap_direct_read_end);
 DEFINE_FUSE_IOMAP_FILE_IOEND_EVENT(fuse_iomap_direct_write_end);
+DEFINE_FUSE_IOMAP_FILE_IOEND_EVENT(fuse_iomap_buffered_read_end);
+DEFINE_FUSE_IOMAP_FILE_IOEND_EVENT(fuse_iomap_buffered_write_end);
 
 TRACE_EVENT(fuse_iomap_dio_write_end_io,
 	TP_PROTO(const struct inode *inode, loff_t pos, ssize_t written,
@@ -781,7 +797,214 @@ DEFINE_EVENT(fuse_iomap_file_range_class, name,         \
         TP_PROTO(const struct inode *inode, loff_t offset, loff_t length), \
         TP_ARGS(inode, offset, length))
 DEFINE_FUSE_IOMAP_FILE_RANGE_EVENT(fuse_iomap_setsize_finish);
+DEFINE_FUSE_IOMAP_FILE_RANGE_EVENT(fuse_iomap_truncate_up);
+DEFINE_FUSE_IOMAP_FILE_RANGE_EVENT(fuse_iomap_truncate_down);
+DEFINE_FUSE_IOMAP_FILE_RANGE_EVENT(fuse_iomap_punch_range);
+DEFINE_FUSE_IOMAP_FILE_RANGE_EVENT(fuse_iomap_flush_unmap_range);
 
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
diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index a3d762fd4d9a86..c5593f35dcb675 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -9,6 +9,7 @@
 #include "dev_uring_i.h"
 #include "fuse_i.h"
 #include "fuse_dev_i.h"
+#include "fuse_iomap.h"
 
 #include <linux/init.h>
 #include <linux/module.h>
@@ -1790,6 +1791,12 @@ static int fuse_notify_store(struct fuse_conn *fc, unsigned int size,
 	if (!inode)
 		goto out_up_killsb;
 
+	/* no backchannels for messing with the pagecache */
+	if (fuse_inode_has_iomap(inode)) {
+		err = -EOPNOTSUPP;
+		goto out_iput;
+	}
+
 	mapping = inode->i_mapping;
 	index = outarg.offset >> PAGE_SHIFT;
 	offset = outarg.offset & ~PAGE_MASK;
@@ -1874,6 +1881,9 @@ static int fuse_retrieve(struct fuse_mount *fm, struct inode *inode,
 	struct fuse_args_pages *ap;
 	struct fuse_args *args;
 
+	if (fuse_inode_has_iomap(inode))
+		return -EOPNOTSUPP;
+
 	offset = outarg->offset & ~PAGE_MASK;
 	file_size = i_size_read(inode);
 
diff --git a/fs/fuse/fuse_iomap.c b/fs/fuse/fuse_iomap.c
index 2097a83af833d5..b7c459acd0c93b 100644
--- a/fs/fuse/fuse_iomap.c
+++ b/fs/fuse/fuse_iomap.c
@@ -1038,6 +1038,8 @@ fuse_iomap_write_zero_eof(
 		return 1;
 	}
 
+	trace_fuse_iomap_write_zero_eof(iocb, from);
+
 	filemap_invalidate_lock(mapping);
 	error = fuse_iomap_zero_range(inode, isize, iocb->ki_pos - isize, NULL);
 	filemap_invalidate_unlock(mapping);
@@ -1164,6 +1166,8 @@ static void fuse_iomap_end_ioend(struct iomap_ioend *ioend)
 	if (!error && fuse_is_bad(inode))
 		error = -EIO;
 
+	trace_fuse_iomap_end_ioend(ioend);
+
 	if (ioend->io_flags & IOMAP_IOEND_SHARED)
 		ioendflags |= FUSE_IOMAP_IOEND_SHARED;
 	if (ioend->io_flags & IOMAP_IOEND_UNWRITTEN)
@@ -1272,6 +1276,8 @@ static void fuse_iomap_discard_folio(struct folio *folio, loff_t pos, int error)
 
 	ASSERT(fuse_inode_has_iomap(inode));
 
+	trace_fuse_iomap_discard_folio(inode, pos, folio_size(folio));
+
 	printk_ratelimited(KERN_ERR
 		"page discard on page %px, inode 0x%llx, pos %llu.",
 			folio, fi->orig_ino, pos);
@@ -1296,6 +1302,8 @@ static ssize_t fuse_iomap_writeback_range(struct iomap_writepage_ctx *wpc,
 
 	ASSERT(fuse_inode_has_iomap(inode));
 
+	trace_fuse_iomap_writeback_range(inode, offset, len, end_pos);
+
 	if (!fuse_iomap_revalidate_writeback(wpc, offset)) {
 		ret = fuse_iomap_begin(inode, offset, len,
 				       FUSE_IOMAP_OP_WRITEBACK,
@@ -1333,6 +1341,8 @@ static int fuse_iomap_writeback_submit(struct iomap_writepage_ctx *wpc,
 
 	ASSERT(fuse_inode_has_iomap(ioend->io_inode));
 
+	trace_fuse_iomap_writeback_submit(wpc, error);
+
 	/* always call our ioend function, even if we cancel the bio */
 	ioend->io_bio.bi_end_io = fuse_iomap_end_bio;
 	return iomap_ioend_writeback_submit(wpc, error);
@@ -1356,6 +1366,8 @@ static int fuse_iomap_writepages(struct address_space *mapping,
 
 	ASSERT(fuse_inode_has_iomap(mapping->host));
 
+	trace_fuse_iomap_writepages(mapping->host, wbc);
+
 	return iomap_writepages(&wpc.ctx);
 }
 
@@ -1363,6 +1375,8 @@ static int fuse_iomap_read_folio(struct file *file, struct folio *folio)
 {
 	ASSERT(fuse_inode_has_iomap(file_inode(file)));
 
+	trace_fuse_iomap_read_folio(folio);
+
 	iomap_bio_read_folio(folio, &fuse_iomap_ops);
 	return 0;
 }
@@ -1371,6 +1385,8 @@ static void fuse_iomap_readahead(struct readahead_control *rac)
 {
 	ASSERT(fuse_inode_has_iomap(file_inode(rac->file)));
 
+	trace_fuse_iomap_readahead(rac);
+
 	iomap_bio_readahead(rac, &fuse_iomap_ops);
 }
 
@@ -1419,6 +1435,8 @@ static vm_fault_t fuse_iomap_page_mkwrite(struct vm_fault *vmf)
 
 	ASSERT(fuse_inode_has_iomap(inode));
 
+	trace_fuse_iomap_page_mkwrite(vmf);
+
 	sb_start_pagefault(inode->i_sb);
 	file_update_time(vmf->vma->vm_file);
 
@@ -1452,6 +1470,8 @@ static ssize_t fuse_iomap_buffered_read(struct kiocb *iocb, struct iov_iter *to)
 
 	ASSERT(fuse_inode_has_iomap(inode));
 
+	trace_fuse_iomap_buffered_read(iocb, to);
+
 	if (!iov_iter_count(to))
 		return 0; /* skip atime */
 
@@ -1463,6 +1483,7 @@ static ssize_t fuse_iomap_buffered_read(struct kiocb *iocb, struct iov_iter *to)
 		file_accessed(iocb->ki_filp);
 	inode_unlock_shared(inode);
 
+	trace_fuse_iomap_buffered_read_end(iocb, to, ret);
 	return ret;
 }
 
@@ -1476,6 +1497,8 @@ static ssize_t fuse_iomap_buffered_write(struct kiocb *iocb,
 
 	ASSERT(fuse_inode_has_iomap(inode));
 
+	trace_fuse_iomap_buffered_write(iocb, from);
+
 	if (!iov_iter_count(from))
 		return 0;
 
@@ -1504,6 +1527,7 @@ static ssize_t fuse_iomap_buffered_write(struct kiocb *iocb,
 		/* Handle various SYNC-type writes */
 		ret = generic_write_sync(iocb, ret);
 	}
+	trace_fuse_iomap_buffered_write_end(iocb, from, ret);
 	return ret;
 }
 
@@ -1622,11 +1646,17 @@ fuse_iomap_setsize_start(
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
 
@@ -1673,6 +1703,8 @@ int fuse_iomap_flush_unmap_range(struct inode *inode, loff_t pos,
 	start = round_down(pos, rounding);
 	end = round_up(endpos + 1, rounding) - 1;
 
+	trace_fuse_iomap_flush_unmap_range(inode, start, end + 1 - start);
+
 	error = filemap_write_and_wait_range(inode->i_mapping, start, end);
 	if (error)
 		return error;
@@ -1686,6 +1718,8 @@ static int fuse_iomap_punch_range(struct inode *inode, loff_t offset,
 	loff_t isize = i_size_read(inode);
 	int error;
 
+	trace_fuse_iomap_punch_range(inode, offset, length);
+
 	/*
 	 * Now that we've unmap all full blocks we'll have to zero out any
 	 * partial block at the beginning and/or end.  iomap_zero_range is
@@ -1729,6 +1763,8 @@ fuse_iomap_fallocate(
 
 	ASSERT(fuse_inode_has_iomap(inode));
 
+	trace_fuse_iomap_fallocate(inode, mode, offset, length, new_size);
+
 	/*
 	 * If we unmapped blocks from the file range, then we zero the
 	 * pagecache for those regions and push them to disk rather than make


