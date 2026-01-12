Return-Path: <linux-fsdevel+bounces-73263-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id BFAA1D136FC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jan 2026 16:05:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2582630319F8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jan 2026 14:52:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26D1E2DCBF7;
	Mon, 12 Jan 2026 14:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d6ydY7io";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="cUuTjDjD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 180072DB7AE
	for <linux-fsdevel@vger.kernel.org>; Mon, 12 Jan 2026 14:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768229547; cv=none; b=IeFRHjZ8R1kWMIsCHKqxXzkZxqVa1csNhOD05RhHW+yPLbF+Aj7GmS+30d+NkSbLDW7lygyDOd6M1SGXQhq1wFiLbYYRGo43wL5GI7Ulm+Odnid+yqO6TjqXNpxXfzfIRETIw6WZp/Zxp6ZcnsXShKSluiPlxwJx85H1ZvSK8l8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768229547; c=relaxed/simple;
	bh=OQm+dEOLwCOaBZFuA5nZqimBMgAHXvnADpLM7rK/i+I=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BRoetULUK6wmbndXenzXGIR2m5vFwvXI8sNwyoJtAaVQB+N8Eace+hUNujZ1qkdmFU0bPXi8XCWdWT8fQDtkjmbTHFpgHojOYocHAh5mnT02sBZcbGDZrpzktqmFC1b6fq/Qpib36Hm4GcvNl03+1v/djhWLWwYnApTlvExiQ9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=d6ydY7io; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=cUuTjDjD; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768229545;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TWmDG1ER0LR9GL8XgLI8QAK75PZeybk5fg0A4H3Djn4=;
	b=d6ydY7ioS7eFKErdyMQDbS0BOhwSCuFiFbjCt+MkRMkVKrVLNnz5llucB0xzb8iwIiuf/t
	AuQ6q0kk5BeEuIDhVdz5ITG23ZrHZC4xNNNhotT7SjCX6PdzAYYBMxjQEhUBsE+en55pTU
	6C1KUZVawGo/Pt93BAhpKirCfH4IqHc=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-312-Uihh0Do_M-uILYnj9ikOMA-1; Mon, 12 Jan 2026 09:52:23 -0500
X-MC-Unique: Uihh0Do_M-uILYnj9ikOMA-1
X-Mimecast-MFC-AGG-ID: Uihh0Do_M-uILYnj9ikOMA_1768229543
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-b872c97a2a2so88331266b.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 12 Jan 2026 06:52:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1768229542; x=1768834342; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TWmDG1ER0LR9GL8XgLI8QAK75PZeybk5fg0A4H3Djn4=;
        b=cUuTjDjDa2wYTssWvTwLwcV8QGbyuHqu6DzXRIPMz+vuvQ/w0GqFymxNmW58ZXVf3+
         HvD03z0L6Xwkgd5nHH3ScotKgyo9ofB3xu3kWBW5vxPnV3VEn/d4iOHQgnWBSQej1UqW
         RpEQtrUbF8BZtNHpAwid0ezlIWX0YkxjbiXSymX1GwhCNgnGToz/iD4M8e1KDwykoF2X
         kE9YpG7tD36hVwgJXtbk2TB7N8R51DcqhlM5aNtuj3YlRfRoQWnAISJAmOHby76HcVGx
         aKsp7CUh1bxmuorWLfW5bR27Gnh6Gjaj6IMiCez9WNlkVO2ud/+r041X72F9/s82CQMP
         gT9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768229542; x=1768834342;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TWmDG1ER0LR9GL8XgLI8QAK75PZeybk5fg0A4H3Djn4=;
        b=aZ1BPUZJgwmsiRIldfBUJxfD05rOjW3RnYyshmf80iAVpF5L/wdvH9W7ENRHQ86SHt
         Ha6XiKTyWybl3nIMKsuwdxSSFMZX0aZpv8jrVxlHVDFvfOAPU46MnVVCVeOPQNqpWsHD
         zbA1jkBwcRhKmtcZyd9rbMWOsMIAm3tP80gtHAh0LPvMsFVHkzZfrtp7+33OkCIQrzjZ
         VFskzbVXHEEaXg82ygp0poRyAXoSPUvlYXJjg2+T1U+abIbfxndZEKFe043/T6L6yyvK
         9SGsvTXae09iNQbowbEzX9YljqmOl9XVT9XrdmQoBNDTM87Yeed83nmHWK9WmWc0I7Ca
         37Sg==
X-Forwarded-Encrypted: i=1; AJvYcCU0ErOltCez0jFlNqF5hEFHGfgkrQRWQfQrqFX/uqIOUffU3WUCLG/D0lHWfWANL1Jbe17QGBP7NHikfMKc@vger.kernel.org
X-Gm-Message-State: AOJu0YxBITxuY8yF3RMx1Od8yQwFT9r8YxaktdpO0yMGYG/OJBLnDzFv
	j5tOuDpLQDREe4n+W03K0lWkbSICjTigPuJ4LK7XxLfr8kI6/gCnN9nbkW/YFJGhGf4yxpDWdF0
	zVwoB6fE/4bRS/h/v6pPIsY64fFHBae8vVl29cDWWzAoC+DRqCn4PxWf3te0n12XuRw==
X-Gm-Gg: AY/fxX6xu6Q0jO7Feh+XstbnH8lkve95rf/+GjZzLBsBxbK0Jk1ynZqox19eos+nB2l
	vUqb8KYZ3QXaUfKBm7nf0I+9WeJxJCcRwomU9bVQNpj8gA9alosVuxbVVBi36SHoo6rdmajgtAw
	1fw+OsZzifjUVfDeqpMOzW3SGRkPlsERsqTYjct7jgUfV9WFd6L/nDsC3GZcPb8FL+oahhxdfI1
	mtpIti4n1gonQ6W7C9yRhPslnXuUUlG2dEVIa3qOiG/bBYb79ny5x2jcFH9jZVMb4EZjUV9yRrk
	Pr05/PIw5lFpx2k5b03Xye9A4MnwQJqx2RbWdrm9Hne+fQPVhVu6uycDYOER4sAWHoroWFk/y4s
	=
X-Received: by 2002:a17:906:d555:b0:b87:2b1a:3c55 with SMTP id a640c23a62f3a-b872b1a53a4mr156462166b.39.1768229542437;
        Mon, 12 Jan 2026 06:52:22 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE+oCOD/RpTBmpg2mx41ExTgddYDgK7ppumJ3iw+DJn3a4n5UKSc4vFU0Z75/VqHP7AW9QvSQ==
X-Received: by 2002:a17:906:d555:b0:b87:2b1a:3c55 with SMTP id a640c23a62f3a-b872b1a53a4mr156458566b.39.1768229541846;
        Mon, 12 Jan 2026 06:52:21 -0800 (PST)
Received: from thinky ([217.30.74.39])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b842a4d1c61sm1897888566b.35.2026.01.12.06.52.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jan 2026 06:52:21 -0800 (PST)
From: Andrey Albershteyn <aalbersh@redhat.com>
X-Google-Original-From: Andrey Albershteyn <aalbersh@kernel.org>
Date: Mon, 12 Jan 2026 15:52:20 +0100
To: fsverity@lists.linux.dev, linux-xfs@vger.kernel.org, 
	ebiggers@kernel.org, linux-fsdevel@vger.kernel.org, aalbersh@kernel.org, 
	aalbersh@redhat.com, djwong@kernel.org
Cc: djwong@kernel.org, david@fromorbit.com, hch@lst.de
Subject: [PATCH v2 21/22] xfs: add fsverity traces
Message-ID: <xvaenghd6d7rd5gnfbfm7zmp5dd4uqa2wchdxcfpxpp2cevp7i@a27fi4opexrk>
References: <cover.1768229271.patch-series@thinky>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1768229271.patch-series@thinky>

Even though fsverity has traces, debugging issues with varying block
sizes could be a bit less transparent without read/write traces.

Signed-off-by: Andrey Albershteyn <aalbersh@kernel.org>
---
 fs/xfs/xfs_fsverity.c |  8 ++++++++
 fs/xfs/xfs_trace.h    | 46 ++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 54 insertions(+), 0 deletions(-)

diff --git a/fs/xfs/xfs_fsverity.c b/fs/xfs/xfs_fsverity.c
index f53a404578..06eac2561b 100644
--- a/fs/xfs/xfs_fsverity.c
+++ b/fs/xfs/xfs_fsverity.c
@@ -102,6 +102,8 @@
 	uint32_t		blocksize = i_blocksize(VFS_I(ip));
 	xfs_fileoff_t		last_block;
 
+	trace_xfs_fsverity_get_descriptor(ip);
+
 	ASSERT(inode->i_flags & S_VERITY);
 	error = xfs_bmap_last_extent(NULL, ip, XFS_DATA_FORK, &rec, &is_empty);
 	if (error)
@@ -330,6 +332,8 @@
 	pgoff_t			offset =
 			index | (XFS_FSVERITY_REGION_START >> PAGE_SHIFT);
 
+	trace_xfs_fsverity_read_merkle(XFS_I(inode), offset, PAGE_SIZE);
+
 	folio = __filemap_get_folio(inode->i_mapping, offset, FGP_ACCESSED, 0);
 	if (IS_ERR(folio) || !folio_test_uptodate(folio)) {
 		DEFINE_READAHEAD(ractl, NULL, NULL, inode->i_mapping, offset);
@@ -358,6 +362,8 @@
 	struct xfs_inode	*ip = XFS_I(inode);
 	loff_t			position = pos | XFS_FSVERITY_REGION_START;
 
+	trace_xfs_fsverity_write_merkle(XFS_I(inode), pos, size);
+
 	if (position + size > inode->i_sb->s_maxbytes)
 		return -EFBIG;
 
@@ -370,6 +376,8 @@
 	loff_t			pos,
 	size_t			len)
 {
+	trace_xfs_fsverity_file_corrupt(XFS_I(inode), pos, len);
+
 	xfs_inode_mark_sick(XFS_I(inode), XFS_SICK_INO_DATA);
 }
 
diff --git a/fs/xfs/xfs_trace.h b/fs/xfs/xfs_trace.h
index f70afbf3cb..1ce4e10b6b 100644
--- a/fs/xfs/xfs_trace.h
+++ b/fs/xfs/xfs_trace.h
@@ -5906,6 +5906,52 @@
 DEFINE_FREEBLOCKS_RESV_EVENT(xfs_freecounter_reserved);
 DEFINE_FREEBLOCKS_RESV_EVENT(xfs_freecounter_enospc);
 
+TRACE_EVENT(xfs_fsverity_get_descriptor,
+	TP_PROTO(struct xfs_inode *ip),
+	TP_ARGS(ip),
+	TP_STRUCT__entry(
+		__field(dev_t, dev)
+		__field(xfs_ino_t, ino)
+	),
+	TP_fast_assign(
+		__entry->dev = VFS_I(ip)->i_sb->s_dev;
+		__entry->ino = ip->i_ino;
+	),
+	TP_printk("dev %d:%d ino 0x%llx",
+		  MAJOR(__entry->dev), MINOR(__entry->dev),
+		  __entry->ino)
+);
+
+DECLARE_EVENT_CLASS(xfs_fsverity_class,
+	TP_PROTO(struct xfs_inode *ip, u64 pos, unsigned int length),
+	TP_ARGS(ip, pos, length),
+	TP_STRUCT__entry(
+		__field(dev_t, dev)
+		__field(xfs_ino_t, ino)
+		__field(u64, pos)
+		__field(unsigned int, length)
+	),
+	TP_fast_assign(
+		__entry->dev = VFS_I(ip)->i_sb->s_dev;
+		__entry->ino = ip->i_ino;
+		__entry->pos = pos;
+		__entry->length = length;
+	),
+	TP_printk("dev %d:%d ino 0x%llx pos %llx length %x",
+		  MAJOR(__entry->dev), MINOR(__entry->dev),
+		  __entry->ino,
+		  __entry->pos,
+		  __entry->length)
+)
+
+#define DEFINE_FSVERITY_EVENT(name) \
+DEFINE_EVENT(xfs_fsverity_class, name, \
+	TP_PROTO(struct xfs_inode *ip, u64 pos, unsigned int length), \
+	TP_ARGS(ip, pos, length))
+DEFINE_FSVERITY_EVENT(xfs_fsverity_read_merkle);
+DEFINE_FSVERITY_EVENT(xfs_fsverity_write_merkle);
+DEFINE_FSVERITY_EVENT(xfs_fsverity_file_corrupt);
+
 #endif /* _TRACE_XFS_H */
 
 #undef TRACE_INCLUDE_PATH

-- 
- Andrey


