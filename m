Return-Path: <linux-fsdevel+bounces-13536-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DFCA870A56
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Mar 2024 20:14:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 720711C21C37
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Mar 2024 19:14:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D28817C094;
	Mon,  4 Mar 2024 19:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JHvG5WmN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 600997C085
	for <linux-fsdevel@vger.kernel.org>; Mon,  4 Mar 2024 19:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709579551; cv=none; b=L+qEPkfcTlLocsi9+yHsCEgOjam56vI8H1QxupkrWtoMWn1ftNjLg/MLRs5SMxw5lco3W9ZI73BgRPjCIH0Cld5EYrHU/L5nsAkViifyNYvzyl+cET6EWk4ZJt47hPFFQXHoh03HD1T8QYSUe7gUJXTqbzzD8zh4WN3OHTaULFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709579551; c=relaxed/simple;
	bh=Tz47sSqAAO/Ffyy1uy8RshNmMIkvlbkyB5AdA/WTz+M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aISdCqaqt4s84vCusYkdf/KgK9gtrmGvf2dCUnBnM11xJqVPQOyADN1tjWjz8bJpIU7iZS3OuC4Osy9Z839HIOjg5UO+s7tpboU9Ys9ddsigFKxhTVM5R86sX398j08c93GP36fjnj01zzYusCBcko8xskFYtd2v5djydJTUD7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JHvG5WmN; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709579547;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4MfVHdc6EW417j4NiszFN0p6hApvm4FnbcGOt5t4/Is=;
	b=JHvG5WmNg+K7IiKJ8rWPn0KVAWIPXdD6gpJwgqhBJVs/1Ntgmunny5GkHlgWZFgTAf7wgN
	DZraBKIufChnvjCQyDxXcGFiYokLf8byy+Rva/FFDCJGM9qosbm/bU5V+z9/Sv9nc2Raxs
	5dbiFpW6763RMZIAurqOerDwtboCq5M=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-81-ReE7Y1hrN0yiH6wPawCxSQ-1; Mon, 04 Mar 2024 14:12:26 -0500
X-MC-Unique: ReE7Y1hrN0yiH6wPawCxSQ-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-a3fcf5b93faso329131166b.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 04 Mar 2024 11:12:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709579545; x=1710184345;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4MfVHdc6EW417j4NiszFN0p6hApvm4FnbcGOt5t4/Is=;
        b=IcT7AQ8LR/uIagPBp4UgCQ9p7CQhwxX9mE2Tm0qXVV0W/mjBtRzCAsufxAVBuWVIW7
         XVfecyHzAJiED3YyThkiYaXxfi+Eds6wKBPJQ+jyJ9iXo+cNh8VcQ6ZrXRfouu4E04wt
         0rftCORnY+IDU2Z8Z98RYgB9VMkdjK4toKAENSXG333E20xvzleVRfBaZ8rbK2p73RiO
         J6ESFajwnz1RP85Nb4AD1zE04zRd/O/WIYdP+pOlfOAHzsg3wea/Q3BIyrLwQLT56VnE
         prs5a3ZTQtu/3fsslb4712bKaHtzFf47lq4TxDzvsHfJpTRKPX3Cp9Y7YAMxleshHFVC
         i9aw==
X-Forwarded-Encrypted: i=1; AJvYcCUOZjrqcbMhcWWbXSFY8lCdaz6qx3dLpXUvRTIcsGOKvQwJHKH99XvKBcxBSV68ATmHUta5UZ3MFZJAxxPtxvCF1qdVDg9MT3jtZF6iaA==
X-Gm-Message-State: AOJu0YxArCYS5P1nd2P9/gQ+yjaHo2BlfD4eKgZNpj/rZYcLzPL87A5V
	P8CPJAGn6g87zwB2U4NohtIimpSLLbUJzJs7pHms0nYqUVjuFUTewNxmU6cTngVUQ8Jyv/WksDC
	VwXe3q5MI8ew6ZNaP2mbty4Cvkg94U51/YGtz03NFKQ9Fi5A3TlGDQK0Wywp/kg==
X-Received: by 2002:a17:906:c49:b0:a3f:173a:224c with SMTP id t9-20020a1709060c4900b00a3f173a224cmr6051471ejf.51.1709579545043;
        Mon, 04 Mar 2024 11:12:25 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE2wJQBUPkaSNJnpTE0mFEg++asVSTup2Ot7QfTxewXevpxdm3AJlsdXSnS/6gxCSfey91SdA==
X-Received: by 2002:a17:906:c49:b0:a3f:173a:224c with SMTP id t9-20020a1709060c4900b00a3f173a224cmr6051457ejf.51.1709579544519;
        Mon, 04 Mar 2024 11:12:24 -0800 (PST)
Received: from thinky.redhat.com ([109.183.6.197])
        by smtp.gmail.com with ESMTPSA id a11-20020a1709064a4b00b00a44a04aa3cfsm3783319ejv.225.2024.03.04.11.12.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Mar 2024 11:12:24 -0800 (PST)
From: Andrey Albershteyn <aalbersh@redhat.com>
To: fsverity@lists.linux.dev,
	linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	chandan.babu@oracle.com,
	djwong@kernel.org,
	ebiggers@kernel.org
Cc: Andrey Albershteyn <aalbersh@redhat.com>
Subject: [PATCH v5 15/24] xfs: add XBF_DOUBLE_ALLOC to increase size of the buffer
Date: Mon,  4 Mar 2024 20:10:38 +0100
Message-ID: <20240304191046.157464-17-aalbersh@redhat.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240304191046.157464-2-aalbersh@redhat.com>
References: <20240304191046.157464-2-aalbersh@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For fs-verity integration, XFS needs to supply kaddr'es of Merkle
tree blocks to fs-verity core and track which blocks are already
verified. One way to track verified status is to set xfs_buf flag
(previously added XBF_VERITY_SEEN). When xfs_buf is evicted from
memory we loose verified status. Otherwise, fs-verity hits the
xfs_buf which is still in cache and contains already verified blocks.

However, the leaf blocks which are read to the xfs_buf contains leaf
headers. xfs_attr_get() allocates new pages and copies out the data
without header. Those newly allocated pages with extended attribute
data are not attached to the buffer anymore.

Add new XBF_DOUBLE_ALLOC which makes xfs_buf allocates x2 memory for
the buffer. Additional memory will be used for a copy of the
attribute data but without any headers. Also, make
xfs_attr_rmtval_get() to copy data to the buffer itself if XFS asked
for fs-verity block.

Signed-off-by: Andrey Albershteyn <aalbersh@redhat.com>
---
 fs/xfs/libxfs/xfs_attr_remote.c | 26 ++++++++++++++++++++++++--
 fs/xfs/xfs_buf.c                |  6 +++++-
 fs/xfs/xfs_buf.h                |  2 ++
 3 files changed, 31 insertions(+), 3 deletions(-)

diff --git a/fs/xfs/libxfs/xfs_attr_remote.c b/fs/xfs/libxfs/xfs_attr_remote.c
index f15350e99d66..f1b7842da809 100644
--- a/fs/xfs/libxfs/xfs_attr_remote.c
+++ b/fs/xfs/libxfs/xfs_attr_remote.c
@@ -395,12 +395,22 @@ xfs_attr_rmtval_get(
 	int			blkcnt = args->rmtblkcnt;
 	int			i;
 	int			offset = 0;
+	int			flags = 0;
+	void			*addr;
 
 	trace_xfs_attr_rmtval_get(args);
 
 	ASSERT(args->valuelen != 0);
 	ASSERT(args->rmtvaluelen == args->valuelen);
 
+	/*
+	 * We also check for _OP_BUFFER as we want to trigger on
+	 * verity blocks only, not on verity_descriptor
+	 */
+	if (args->attr_filter & XFS_ATTR_VERITY &&
+			args->op_flags & XFS_DA_OP_BUFFER)
+		flags = XBF_DOUBLE_ALLOC;
+
 	valuelen = args->rmtvaluelen;
 	while (valuelen > 0) {
 		nmap = ATTR_RMTVALUE_MAPSIZE;
@@ -420,12 +430,23 @@ xfs_attr_rmtval_get(
 			dblkno = XFS_FSB_TO_DADDR(mp, map[i].br_startblock);
 			dblkcnt = XFS_FSB_TO_BB(mp, map[i].br_blockcount);
 			error = xfs_buf_read(mp->m_ddev_targp, dblkno, dblkcnt,
-					0, &bp, &xfs_attr3_rmt_buf_ops);
+					flags, &bp, &xfs_attr3_rmt_buf_ops);
 			if (xfs_metadata_is_sick(error))
 				xfs_dirattr_mark_sick(args->dp, XFS_ATTR_FORK);
 			if (error)
 				return error;
 
+			/*
+			 * For fs-verity we allocated more space. That space is
+			 * filled with the same xattr data but without leaf
+			 * headers. Point args->value to that data
+			 */
+			if (flags & XBF_DOUBLE_ALLOC) {
+				addr = xfs_buf_offset(bp, BBTOB(bp->b_length));
+				args->value = addr;
+				dst = addr;
+			}
+
 			error = xfs_attr_rmtval_copyout(mp, bp, args->dp,
 							&offset, &valuelen,
 							&dst);
@@ -526,7 +547,8 @@ xfs_attr_rmtval_set_value(
 		dblkno = XFS_FSB_TO_DADDR(mp, map.br_startblock),
 		dblkcnt = XFS_FSB_TO_BB(mp, map.br_blockcount);
 
-		error = xfs_buf_get(mp->m_ddev_targp, dblkno, dblkcnt, 0, &bp);
+		error = xfs_buf_get(mp->m_ddev_targp, dblkno, dblkcnt,
+				XBF_DOUBLE_ALLOC, &bp);
 		if (error)
 			return error;
 		bp->b_ops = &xfs_attr3_rmt_buf_ops;
diff --git a/fs/xfs/xfs_buf.c b/fs/xfs/xfs_buf.c
index 7fc26e64368d..d8a478bda865 100644
--- a/fs/xfs/xfs_buf.c
+++ b/fs/xfs/xfs_buf.c
@@ -337,6 +337,9 @@ xfs_buf_alloc_kmem(
 	gfp_t		gfp_mask = GFP_KERNEL | __GFP_NOLOCKDEP | __GFP_NOFAIL;
 	size_t		size = BBTOB(bp->b_length);
 
+	if (flags & XBF_DOUBLE_ALLOC)
+		size *= 2;
+
 	/* Assure zeroed buffer for non-read cases. */
 	if (!(flags & XBF_READ))
 		gfp_mask |= __GFP_ZERO;
@@ -367,12 +370,13 @@ xfs_buf_alloc_pages(
 {
 	gfp_t		gfp_mask = GFP_KERNEL | __GFP_NOLOCKDEP | __GFP_NOWARN;
 	long		filled = 0;
+	int		mul = (bp->b_flags & XBF_DOUBLE_ALLOC) ? 2 : 1;
 
 	if (flags & XBF_READ_AHEAD)
 		gfp_mask |= __GFP_NORETRY;
 
 	/* Make sure that we have a page list */
-	bp->b_page_count = DIV_ROUND_UP(BBTOB(bp->b_length), PAGE_SIZE);
+	bp->b_page_count = DIV_ROUND_UP(BBTOB(bp->b_length*mul), PAGE_SIZE);
 	if (bp->b_page_count <= XB_PAGES) {
 		bp->b_pages = bp->b_page_array;
 	} else {
diff --git a/fs/xfs/xfs_buf.h b/fs/xfs/xfs_buf.h
index b5c58287c663..60b7d58d5da1 100644
--- a/fs/xfs/xfs_buf.h
+++ b/fs/xfs/xfs_buf.h
@@ -33,6 +33,7 @@ struct xfs_buf;
 #define XBF_STALE		(1u << 6) /* buffer has been staled, do not find it */
 #define XBF_WRITE_FAIL		(1u << 7) /* async writes have failed on this buffer */
 #define XBF_VERITY_SEEN		(1u << 8) /* buffer was processed by fs-verity */
+#define XBF_DOUBLE_ALLOC	(1u << 9) /* double allocated space */
 
 /* buffer type flags for write callbacks */
 #define _XBF_INODES	 (1u << 16)/* inode buffer */
@@ -67,6 +68,7 @@ typedef unsigned int xfs_buf_flags_t;
 	{ XBF_STALE,		"STALE" }, \
 	{ XBF_WRITE_FAIL,	"WRITE_FAIL" }, \
 	{ XBF_VERITY_SEEN,	"VERITY_SEEN" }, \
+	{ XBF_DOUBLE_ALLOC,	"DOUBLE_ALLOC" }, \
 	{ _XBF_INODES,		"INODES" }, \
 	{ _XBF_DQUOTS,		"DQUOTS" }, \
 	{ _XBF_LOGRECOVERY,	"LOG_RECOVERY" }, \
-- 
2.42.0


