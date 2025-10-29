Return-Path: <linux-fsdevel+bounces-66015-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1D0AC17A1B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 01:48:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6E7F3AAD50
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 00:48:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC38F2D3EE4;
	Wed, 29 Oct 2025 00:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hcwl9Ztt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 516771DE8B5;
	Wed, 29 Oct 2025 00:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761698901; cv=none; b=D0p/NEOEjt385zEvhDVxrHuMJGBqUFPlQTJys3dTQl0EGkcsP6n/5SeOy9anvtliWNk4d5u0+fXaVU0JHlM2lMWqVLeqzp1nlkaMSDujlUU88Lwk9JkoPie/wxySCCDEGocFFv15eDKB0IvSC35QG+YbI5V8Rp6w4RUe1+zU9zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761698901; c=relaxed/simple;
	bh=sLzc+NqgXmnc/h87uYVL1WgSKZglxwQB/zAhS8HPX0k=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hk2UC7z6x10w8NVCsXnQhEIL/akYizcimsL+YetNYgabVsuudeIldfZdgRoWnYP0l0QTMAF8CV8e9TyoSJMf4leK2c6dp99FqhHhZ08XukcHJYLAK7+GqNIgCoXlymTZHZTgMq1SU/zLrbovCHWyIrrRqjlElK6PjEJZpWpocZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hcwl9Ztt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28ACAC4CEE7;
	Wed, 29 Oct 2025 00:48:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761698901;
	bh=sLzc+NqgXmnc/h87uYVL1WgSKZglxwQB/zAhS8HPX0k=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=hcwl9ZttPIVvIA29sjAB3Xfl/aZfggIM0eRnBA++eJYPwMUfwhJF8ISKHtZaRDJCZ
	 UH4jdQ9qscwqfTUWO8fG6vIUSusmgIc9WE/cmyjE8E7sxIJn2x279VBGYfHszUNoXC
	 OKU9d2I4e+0MyfL+yVoUmF796aI+L8CUL0S3OexeDljARZvOLif+Rn+udLpdhlknZe
	 f7cj/mwPQMl+VEAAUCtAfoAoZbjoxtraixu3s2Q9gEqY8HGOvf+2eljs7uYZek+p3n
	 AzkcCx0ByGwz6NV4YmjgrujzGMFAbGFgs2NehNVV2ENEp8u28ec0K5TeoCLB3ETExi
	 iQdUIHrmaFHmw==
Date: Tue, 28 Oct 2025 17:48:20 -0700
Subject: [PATCH 13/31] fuse_trace: implement direct IO with iomap
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, miklos@szeredi.hu
Cc: joannelkoong@gmail.com, bernd@bsbernd.com, neal@gompa.dev,
 linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org
Message-ID: <176169810634.1424854.13084435884326863405.stgit@frogsfrogsfrogs>
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

Add tracepoints for the previous patch.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/fuse/fuse_trace.h |  144 ++++++++++++++++++++++++++++++++++++++++++++++++++
 fs/fuse/file_iomap.c |   13 +++++
 2 files changed, 157 insertions(+)


diff --git a/fs/fuse/fuse_trace.h b/fs/fuse/fuse_trace.h
index 730ab8bce44450..bd88c46b447997 100644
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
@@ -484,6 +496,65 @@ TRACE_EVENT(fuse_iomap_end_error,
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
@@ -578,6 +649,79 @@ TRACE_EVENT(fuse_iomap_lseek,
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
index 4db2acd8bc9925..094a07dd0ddfc9 100644
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
@@ -909,6 +913,8 @@ ssize_t fuse_iomap_direct_read(struct kiocb *iocb, struct iov_iter *to)
 
 	ASSERT(fuse_inode_has_iomap(inode));
 
+	trace_fuse_iomap_direct_read(iocb, to);
+
 	if (!iov_iter_count(to))
 		return 0; /* skip atime */
 
@@ -920,6 +926,7 @@ ssize_t fuse_iomap_direct_read(struct kiocb *iocb, struct iov_iter *to)
 	ret = iomap_dio_rw(iocb, to, &fuse_iomap_ops, NULL, 0, NULL, 0);
 	inode_unlock_shared(inode);
 
+	trace_fuse_iomap_direct_read_end(iocb, to, ret);
 	return ret;
 }
 
@@ -936,6 +943,9 @@ static int fuse_iomap_dio_write_end_io(struct kiocb *iocb, ssize_t written,
 
 	ASSERT(fuse_inode_has_iomap(inode));
 
+	trace_fuse_iomap_dio_write_end_io(inode, iocb->ki_pos, written, error,
+					  dioflags);
+
 	if (dioflags & IOMAP_DIO_COW)
 		ioendflags |= FUSE_IOMAP_IOEND_SHARED;
 	if (dioflags & IOMAP_DIO_UNWRITTEN)
@@ -967,6 +977,8 @@ ssize_t fuse_iomap_direct_write(struct kiocb *iocb, struct iov_iter *from)
 
 	ASSERT(fuse_inode_has_iomap(inode));
 
+	trace_fuse_iomap_direct_write(iocb, from);
+
 	if (!count)
 		return 0;
 
@@ -1003,5 +1015,6 @@ ssize_t fuse_iomap_direct_write(struct kiocb *iocb, struct iov_iter *from)
 out_unlock:
 	inode_unlock(inode);
 out_dsync:
+	trace_fuse_iomap_direct_write_end(iocb, from, ret);
 	return ret;
 }


