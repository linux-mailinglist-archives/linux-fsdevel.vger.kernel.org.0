Return-Path: <linux-fsdevel+bounces-66027-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C4D6C17A6F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 01:51:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 16E4E4FA930
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 00:51:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F29692D6619;
	Wed, 29 Oct 2025 00:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="azHGQadF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58B4C33993;
	Wed, 29 Oct 2025 00:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761699089; cv=none; b=ZrF9rFymqRHmcJn7Jz7CLNGbe1bswQWCfJ70P/bG2RX5wrD15/Z5c0mpsLw2jtsHyQNo8R/Ddv7lKWbSonzdzB6Pnin1VdAD6PrpKiFgKgXLvNM0hnjwrsiobg2UT8Q/NGo9Ceooh2y90WRHH+nDN1TcIzIhdn1EYAsMGrwnwr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761699089; c=relaxed/simple;
	bh=VDS3Dn8+f7tkcLB3X3oQyB2luUZHUXm82elZTdu/q64=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cqdj1SlUZHYQigN/twtQxCK3sMEfR3iG8ew8zOGVRuyIWEY/TGFHwdgwCKjenDyhtD/b3tf2AsdwlgDBQD3Xoafdyh8bM0IY3GbqZW7xY6nXPwG94gW91vZG7T71OAJA8StVUwmqEvBtR8BtFJbe9Uyz45/MNv0FkCypPgx6XZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=azHGQadF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2888C4CEE7;
	Wed, 29 Oct 2025 00:51:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761699088;
	bh=VDS3Dn8+f7tkcLB3X3oQyB2luUZHUXm82elZTdu/q64=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=azHGQadFHnGvJs00UvQ7w0h8cKRAvwZsjiRRaYiY2R7rXsB8n95V6vFVSLM1T9aEw
	 WcvneQtQkIK70zfKfCLa72rJEQzK06REJ2gn+W1AiL0KlnHuvZ634HOTqSTU1R0zY0
	 0NkLStqRHq7ubcuutV1QZy7G+I4Wx7/I9PMAw6UHUl0hjkZOCtjPkxQSNwVqsOCeUs
	 /5GttbtEJN1OW+9Ev99DVsrr/7xrzuyfpL5oklRVIqw/hA7F9YYiyeoQW2V2LvTYm0
	 miPXyOgjCS+TsFlH854P8w9HcmR+hWajlyvhtQvLBGrTLty2gwAXP24RZMDyWe+28G
	 cEUJQhOlRTQdQ==
Date: Tue, 28 Oct 2025 17:51:28 -0700
Subject: [PATCH 25/31] fuse_trace: implement inline data file IO via iomap
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, miklos@szeredi.hu
Cc: joannelkoong@gmail.com, bernd@bsbernd.com, neal@gompa.dev,
 linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org
Message-ID: <176169810895.1424854.5739312981313566754.stgit@frogsfrogsfrogs>
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
 fs/fuse/fuse_trace.h |   45 +++++++++++++++++++++++++++++++++++++++++++++
 fs/fuse/file_iomap.c |    7 +++++++
 2 files changed, 52 insertions(+)


diff --git a/fs/fuse/fuse_trace.h b/fs/fuse/fuse_trace.h
index 67b9bd8ea52b79..9852a78eda26d3 100644
--- a/fs/fuse/fuse_trace.h
+++ b/fs/fuse/fuse_trace.h
@@ -227,6 +227,7 @@ DEFINE_FUSE_BACKING_EVENT(fuse_backing_close);
 #if IS_ENABLED(CONFIG_FUSE_IOMAP)
 struct iomap_writepage_ctx;
 struct iomap_ioend;
+struct iomap;
 
 /* tracepoint boilerplate so we don't have to keep doing this */
 #define FUSE_IOMAP_OPFLAGS_FIELD \
@@ -1044,6 +1045,50 @@ TRACE_EVENT(fuse_iomap_dev_inval,
 		  __entry->offset,
 		  __entry->length)
 );
+
+DECLARE_EVENT_CLASS(fuse_iomap_inline_class,
+	TP_PROTO(const struct inode *inode, loff_t pos, uint64_t count,
+		 const struct iomap *map),
+	TP_ARGS(inode, pos, count, map),
+
+	TP_STRUCT__entry(
+		FUSE_IO_RANGE_FIELDS()
+		FUSE_IOMAP_MAP_FIELDS(map)
+		__field(bool,			has_buf)
+		__field(uint64_t,		validity_cookie)
+	),
+
+	TP_fast_assign(
+		FUSE_INODE_ASSIGN(inode, fi, fm);
+		__entry->offset		=	pos;
+		__entry->length		=	count;
+
+		__entry->mapdev		=	FUSE_IOMAP_DEV_NULL;
+		__entry->mapaddr	=	map->addr;
+		__entry->mapoffset	=	map->offset;
+		__entry->maplength	=	map->length;
+		__entry->maptype	=	map->type;
+		__entry->mapflags	=	map->flags;
+
+		__entry->has_buf	=	map->inline_data != NULL;
+		__entry->validity_cookie=	map->validity_cookie;
+	),
+
+	TP_printk(FUSE_IO_RANGE_FMT() FUSE_IOMAP_MAP_FMT() " has_buf? %d cookie 0x%llx",
+		  FUSE_IO_RANGE_PRINTK_ARGS(),
+		  FUSE_IOMAP_MAP_PRINTK_ARGS(map),
+		  __entry->has_buf,
+		  __entry->validity_cookie)
+);
+#define DEFINE_FUSE_IOMAP_INLINE_EVENT(name)	\
+DEFINE_EVENT(fuse_iomap_inline_class, name,	\
+	TP_PROTO(const struct inode *inode, loff_t pos, uint64_t count, \
+		 const struct iomap *map), \
+	TP_ARGS(inode, pos, count, map))
+DEFINE_FUSE_IOMAP_INLINE_EVENT(fuse_iomap_inline_read);
+DEFINE_FUSE_IOMAP_INLINE_EVENT(fuse_iomap_inline_write);
+DEFINE_FUSE_IOMAP_INLINE_EVENT(fuse_iomap_set_inline_iomap);
+DEFINE_FUSE_IOMAP_INLINE_EVENT(fuse_iomap_set_inline_srcmap);
 #endif /* CONFIG_FUSE_IOMAP */
 
 #endif /* _TRACE_FUSE_H */
diff --git a/fs/fuse/file_iomap.c b/fs/fuse/file_iomap.c
index c921d4db7a7f92..06d1834e43f698 100644
--- a/fs/fuse/file_iomap.c
+++ b/fs/fuse/file_iomap.c
@@ -452,6 +452,8 @@ static int fuse_iomap_inline_read(struct inode *inode, loff_t pos,
 	if (BAD_DATA(!iomap_inline_data_valid(iomap)))
 		return -EFSCORRUPTED;
 
+	trace_fuse_iomap_inline_read(inode, pos, count, iomap);
+
 	args.opcode = FUSE_READ;
 	args.nodeid = fi->nodeid;
 	args.in_numargs = 1;
@@ -497,6 +499,8 @@ static int fuse_iomap_inline_write(struct inode *inode, loff_t pos,
 	if (BAD_DATA(!iomap_inline_data_valid(iomap)))
 		return -EFSCORRUPTED;
 
+	trace_fuse_iomap_inline_write(inode, pos, count, iomap);
+
 	args.opcode = FUSE_WRITE;
 	args.nodeid = fi->nodeid;
 	args.in_numargs = 2;
@@ -558,6 +562,9 @@ static int fuse_iomap_set_inline(struct inode *inode, unsigned opflags,
 			return err;
 	}
 
+	trace_fuse_iomap_set_inline_iomap(inode, pos, count, iomap);
+	trace_fuse_iomap_set_inline_srcmap(inode, pos, count, srcmap);
+
 	return 0;
 }
 


