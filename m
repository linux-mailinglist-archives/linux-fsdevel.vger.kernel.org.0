Return-Path: <linux-fsdevel+bounces-61520-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23C9FB5898B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 02:32:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5649D3B4D29
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 00:32:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BA293597C;
	Tue, 16 Sep 2025 00:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sdpzYW3F"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6D8DD528;
	Tue, 16 Sep 2025 00:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757982683; cv=none; b=bHiM6/dLo8+SXApQVJpM/wZrJoRtztcftxyHwR6rNUzRicSzSbsxcWYyPSPYhVDGqGGy9MuFBgZ6sjmvTYotqw8ogaRVM+nZ6KZeqEPGmKrh+b1q8e49tUG4/0/xhFy3OnaVQm01dOPLoxp3+n/iiWxJIqb4NunRzQ0ZPFP5A74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757982683; c=relaxed/simple;
	bh=kY/xrfDZAW9kHxqXxZhzt+33kZtjEe41FS3S3KN5I+o=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=U9Xk2Z/78veGGd6yPo9Gyy8awX42hVUabMViZ/D0MIVVfC7u/yqi9DfgCAkel2s4ndalge20nmviH1QtDUQ+ldxQcCADYStq/5KTd6wRuwNI+U6uzXft++Iu6HZuiV20dvYQx4PEEy+jQSBRDwjWCWgCufvuyRbSohunALheTIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sdpzYW3F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A6CFC4CEF1;
	Tue, 16 Sep 2025 00:31:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757982682;
	bh=kY/xrfDZAW9kHxqXxZhzt+33kZtjEe41FS3S3KN5I+o=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=sdpzYW3FUxlcDulBKw4qI4NOipbQs6OievTq+As48L7kV++HPwgrgXzMZYEwVWBOW
	 Gitz9Ti204M+b/1Czpuy5onD0bfiS0x0689a7szLYs8rPnGiCBQgQVVOUskpnvbKVU
	 UqUZgsP/X0xZgUeSKwVfzUS5xM5BB+5MXbOSsTFW7CgB3gmpQ5V8ULkXtez3/32be+
	 yuXOKBJxYOfyM6WWIJuxzKTx2MWKyvEhL72WqIOA90oChsDZLkTN2hxn3j1zt9yWmh
	 AmZ23qVfis30gZwcJzFA2dBp95XINfPHJkVymKCvEARAhtiQ/MfxT3ESBtfcnzvsMP
	 gbsuRVafn4RtQ==
Date: Mon, 15 Sep 2025 17:31:21 -0700
Subject: [PATCH 13/28] fuse_trace: implement direct IO with iomap
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, miklos@szeredi.hu
Cc: bernd@bsbernd.com, linux-xfs@vger.kernel.org, John@groves.net,
 linux-fsdevel@vger.kernel.org, neal@gompa.dev, joannelkoong@gmail.com
Message-ID: <175798151545.382724.1291001244189651503.stgit@frogsfrogsfrogs>
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
 fs/fuse/fuse_trace.h |  144 ++++++++++++++++++++++++++++++++++++++++++++++++++
 fs/fuse/file_iomap.c |   13 +++++
 2 files changed, 157 insertions(+)


diff --git a/fs/fuse/fuse_trace.h b/fs/fuse/fuse_trace.h
index 4fe51be0e65bdc..434d38ce89c428 100644
--- a/fs/fuse/fuse_trace.h
+++ b/fs/fuse/fuse_trace.h
@@ -60,6 +60,7 @@
 	EM( FUSE_STATX,			"FUSE_STATX")		\
 	EM( FUSE_IOMAP_BEGIN,		"FUSE_IOMAP_BEGIN")	\
 	EM( FUSE_IOMAP_END,		"FUSE_IOMAP_END")	\
+	EM( FUSE_IOMAP_IOEND,		"FUSE_IOMAP_IOEND")	\
 	EMe(CUSE_INIT,			"CUSE_INIT")
 
 /*
@@ -300,6 +301,17 @@ DEFINE_FUSE_BACKING_EVENT(fuse_backing_close);
 	{ FUSE_IOMAP_TYPE_UNWRITTEN,		"unwritten" }, \
 	{ FUSE_IOMAP_TYPE_INLINE,		"inline" }
 
+#define FUSE_IOMAP_IOEND_STRINGS \
+	{ FUSE_IOMAP_IOEND_SHARED,		"shared" }, \
+	{ FUSE_IOMAP_IOEND_UNWRITTEN,		"unwritten" }, \
+	{ FUSE_IOMAP_IOEND_BOUNDARY,		"boundary" }, \
+	{ FUSE_IOMAP_IOEND_DIRECT,		"direct" }, \
+	{ FUSE_IOMAP_IOEND_APPEND,		"append" }
+
+#define IOMAP_DIOEND_STRINGS \
+	{ IOMAP_DIO_UNWRITTEN,			"unwritten" }, \
+	{ IOMAP_DIO_COW,			"cow" }
+
 TRACE_DEFINE_ENUM(FUSE_I_ADVISE_RDPLUS);
 TRACE_DEFINE_ENUM(FUSE_I_INIT_RDPLUS);
 TRACE_DEFINE_ENUM(FUSE_I_SIZE_UNSTABLE);
@@ -482,6 +494,65 @@ TRACE_EVENT(fuse_iomap_end_error,
 		  __entry->error)
 );
 
+TRACE_EVENT(fuse_iomap_ioend,
+	TP_PROTO(const struct inode *inode,
+		 const struct fuse_iomap_ioend_in *inarg),
+
+	TP_ARGS(inode, inarg),
+
+	TP_STRUCT__entry(
+		FUSE_IO_RANGE_FIELDS()
+		__field(unsigned,		ioendflags)
+		__field(int,			error)
+		__field(uint64_t,		new_addr)
+	),
+
+	TP_fast_assign(
+		FUSE_INODE_ASSIGN(inode, fi, fm);
+		__entry->offset		=	inarg->pos;
+		__entry->length		=	inarg->written;
+		__entry->ioendflags	=	inarg->ioendflags;
+		__entry->error		=	inarg->error;
+		__entry->new_addr	=	inarg->new_addr;
+	),
+
+	TP_printk(FUSE_IO_RANGE_FMT() " ioendflags (%s) error %d new_addr 0x%llx",
+		  FUSE_IO_RANGE_PRINTK_ARGS(),
+		  __print_flags(__entry->ioendflags, "|", FUSE_IOMAP_IOEND_STRINGS),
+		  __entry->error,
+		  __entry->new_addr)
+);
+
+TRACE_EVENT(fuse_iomap_ioend_error,
+	TP_PROTO(const struct inode *inode,
+		 const struct fuse_iomap_ioend_in *inarg,
+		 int error),
+
+	TP_ARGS(inode, inarg, error),
+
+	TP_STRUCT__entry(
+		FUSE_IO_RANGE_FIELDS()
+		__field(unsigned,		ioendflags)
+		__field(int,			error)
+		__field(uint64_t,		new_addr)
+	),
+
+	TP_fast_assign(
+		FUSE_INODE_ASSIGN(inode, fi, fm);
+		__entry->offset		=	inarg->pos;
+		__entry->length		=	inarg->written;
+		__entry->ioendflags	=	inarg->ioendflags;
+		__entry->error		=	error;
+		__entry->new_addr	=	inarg->new_addr;
+	),
+
+	TP_printk(FUSE_IO_RANGE_FMT() " ioendflags (%s) error %d new_addr 0x%llx",
+		  FUSE_IO_RANGE_PRINTK_ARGS(),
+		  __print_flags(__entry->ioendflags, "|", FUSE_IOMAP_IOEND_STRINGS),
+		  __entry->error,
+		  __entry->new_addr)
+);
+
 TRACE_EVENT(fuse_iomap_dev_add,
 	TP_PROTO(const struct fuse_conn *fc,
 		 const struct fuse_backing_map *map),
@@ -576,6 +647,79 @@ TRACE_EVENT(fuse_iomap_lseek,
 		  __entry->offset,
 		  __entry->whence)
 );
+
+DECLARE_EVENT_CLASS(fuse_iomap_file_io_class,
+	TP_PROTO(const struct kiocb *iocb, const struct iov_iter *iter),
+	TP_ARGS(iocb, iter),
+	TP_STRUCT__entry(
+		FUSE_IO_RANGE_FIELDS()
+	),
+	TP_fast_assign(
+		FUSE_INODE_ASSIGN(file_inode(iocb->ki_filp), fi, fm);
+		__entry->offset		=	iocb->ki_pos;
+		__entry->length		=	iov_iter_count(iter);
+	),
+	TP_printk(FUSE_IO_RANGE_FMT(),
+		  FUSE_IO_RANGE_PRINTK_ARGS())
+)
+#define DEFINE_FUSE_IOMAP_FILE_IO_EVENT(name)		\
+DEFINE_EVENT(fuse_iomap_file_io_class, name,		\
+	TP_PROTO(const struct kiocb *iocb, const struct iov_iter *iter), \
+	TP_ARGS(iocb, iter))
+DEFINE_FUSE_IOMAP_FILE_IO_EVENT(fuse_iomap_direct_read);
+DEFINE_FUSE_IOMAP_FILE_IO_EVENT(fuse_iomap_direct_write);
+
+DECLARE_EVENT_CLASS(fuse_iomap_file_ioend_class,
+	TP_PROTO(const struct kiocb *iocb, const struct iov_iter *iter,
+		 ssize_t ret),
+	TP_ARGS(iocb, iter, ret),
+	TP_STRUCT__entry(
+		FUSE_IO_RANGE_FIELDS()
+		__field(ssize_t,		ret)
+	),
+	TP_fast_assign(
+		FUSE_INODE_ASSIGN(file_inode(iocb->ki_filp), fi, fm);
+		__entry->offset		=	iocb->ki_pos;
+		__entry->length		=	iov_iter_count(iter);
+		__entry->ret		=	ret;
+	),
+	TP_printk(FUSE_IO_RANGE_FMT() " ret 0x%zx",
+		  FUSE_IO_RANGE_PRINTK_ARGS(),
+		  __entry->ret)
+)
+#define DEFINE_FUSE_IOMAP_FILE_IOEND_EVENT(name)	\
+DEFINE_EVENT(fuse_iomap_file_ioend_class, name,		\
+	TP_PROTO(const struct kiocb *iocb, const struct iov_iter *iter, \
+		 ssize_t ret), \
+	TP_ARGS(iocb, iter, ret))
+DEFINE_FUSE_IOMAP_FILE_IOEND_EVENT(fuse_iomap_direct_read_end);
+DEFINE_FUSE_IOMAP_FILE_IOEND_EVENT(fuse_iomap_direct_write_end);
+
+TRACE_EVENT(fuse_iomap_dio_write_end_io,
+	TP_PROTO(const struct inode *inode, loff_t pos, ssize_t written,
+		 int error, unsigned flags),
+
+	TP_ARGS(inode, pos, written, error, flags),
+
+	TP_STRUCT__entry(
+		FUSE_IO_RANGE_FIELDS()
+		__field(unsigned,		dioendflags)
+		__field(int,			error)
+	),
+
+	TP_fast_assign(
+		FUSE_INODE_ASSIGN(inode, fi, fm);
+		__entry->offset		=	pos;
+		__entry->length		=	written;
+		__entry->dioendflags	=	flags;
+		__entry->error		=	error;
+	),
+
+	TP_printk(FUSE_IO_RANGE_FMT() " dioendflags (%s) error %d",
+		  FUSE_IO_RANGE_PRINTK_ARGS(),
+		  __print_flags(__entry->dioendflags, "|", IOMAP_DIOEND_STRINGS),
+		  __entry->error)
+);
 #endif /* CONFIG_FUSE_IOMAP */
 
 #endif /* _TRACE_FUSE_H */
diff --git a/fs/fuse/file_iomap.c b/fs/fuse/file_iomap.c
index 84eb1fe4fcde49..54e09f60980ef1 100644
--- a/fs/fuse/file_iomap.c
+++ b/fs/fuse/file_iomap.c
@@ -618,6 +618,8 @@ static int fuse_iomap_ioend(struct inode *inode, loff_t pos, size_t written,
 	if (fuse_ioend_is_append(fi, pos, written))
 		inarg.ioendflags |= FUSE_IOMAP_IOEND_APPEND;
 
+	trace_fuse_iomap_ioend(inode, &inarg);
+
 	if (fuse_should_send_iomap_ioend(fm, &inarg)) {
 		FUSE_ARGS(args);
 		int err;
@@ -640,6 +642,8 @@ static int fuse_iomap_ioend(struct inode *inode, loff_t pos, size_t written,
 		case 0:
 			break;
 		default:
+			trace_fuse_iomap_ioend_error(inode, &inarg, err);
+
 			/*
 			 * If the write IO failed, return the failure code to
 			 * the caller no matter what happens with the ioend.
@@ -888,6 +892,8 @@ ssize_t fuse_iomap_direct_read(struct kiocb *iocb, struct iov_iter *to)
 
 	ASSERT(fuse_inode_has_iomap(inode));
 
+	trace_fuse_iomap_direct_read(iocb, to);
+
 	if (!iov_iter_count(to))
 		return 0; /* skip atime */
 
@@ -899,6 +905,7 @@ ssize_t fuse_iomap_direct_read(struct kiocb *iocb, struct iov_iter *to)
 	ret = iomap_dio_rw(iocb, to, &fuse_iomap_ops, NULL, 0, NULL, 0);
 	inode_unlock_shared(inode);
 
+	trace_fuse_iomap_direct_read_end(iocb, to, ret);
 	return ret;
 }
 
@@ -915,6 +922,9 @@ static int fuse_iomap_dio_write_end_io(struct kiocb *iocb, ssize_t written,
 
 	ASSERT(fuse_inode_has_iomap(inode));
 
+	trace_fuse_iomap_dio_write_end_io(inode, iocb->ki_pos, written, error,
+					  dioflags);
+
 	if (dioflags & IOMAP_DIO_COW)
 		ioendflags |= FUSE_IOMAP_IOEND_SHARED;
 	if (dioflags & IOMAP_DIO_UNWRITTEN)
@@ -946,6 +956,8 @@ ssize_t fuse_iomap_direct_write(struct kiocb *iocb, struct iov_iter *from)
 
 	ASSERT(fuse_inode_has_iomap(inode));
 
+	trace_fuse_iomap_direct_write(iocb, from);
+
 	if (!count)
 		return 0;
 
@@ -982,5 +994,6 @@ ssize_t fuse_iomap_direct_write(struct kiocb *iocb, struct iov_iter *from)
 out_unlock:
 	inode_unlock(inode);
 out_dsync:
+	trace_fuse_iomap_direct_write_end(iocb, from, ret);
 	return ret;
 }


