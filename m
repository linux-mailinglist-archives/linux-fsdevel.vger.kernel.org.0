Return-Path: <linux-fsdevel+bounces-11157-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 228F4851A77
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Feb 2024 18:01:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A1FCF1F2548A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Feb 2024 17:01:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 908953FB19;
	Mon, 12 Feb 2024 17:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M/R/ehJK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C6903FB01
	for <linux-fsdevel@vger.kernel.org>; Mon, 12 Feb 2024 17:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707757219; cv=none; b=hpWlXJQ8m3f4a1ea73CyONuRjqpH6Hb6OH9M8tKYBaaa/y0rcnbFHs08IZ163qSsbFH0EHatQJYgjlq1kkn7PliOA3aayB1qtj09ZZiUoNHU9lkEEcHTu0yZoGw4Iep9cBdXvnLU5FvkTvRPZpZqMKrhZQvyHdCkQkQamMlLTkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707757219; c=relaxed/simple;
	bh=wNIW/W+YCPZOMVmYt21a2Fgepob4iaeWS1zUwwO+tX4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ceo2UGPl6NSSpcwyN2dyqsEMwCozt6Gx0hfJqCEfNkqL0f5Gf2czs/jLQ4RTE5ednxdXUb1ji/FkacFC++//VXJCD04tLXYTA03Tk48wah71+fg+kv1ie4l089PzG64vymG6KpEAfITYWP+HXz7R2h5w2K+b7fi+MdVbCSXjvB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=M/R/ehJK; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707757216;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HjNaCcVPbGjsbiOXI+W7wF6VbX0l3c5qvi60YHzKwuo=;
	b=M/R/ehJK8nxtReQD9bRw5NRJ4PcNYgu9YEUk3ge6TVdiS809Chh7vbWdDmRaMVlr4qUXj2
	SBTCBVXj7vUbVsPue8+sk51Fx2n8X3Oqe+b1A9DbTa2NsXbR3mYIuY3UIXwIL8i4wMWVjN
	+xiAbyH09mMWQZWu+vSyaxbpqabCXws=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-646-LZPcPAfQMOuB34EpMkgH3g-1; Mon, 12 Feb 2024 12:00:14 -0500
X-MC-Unique: LZPcPAfQMOuB34EpMkgH3g-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-a3c3f477eb7so87619766b.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 12 Feb 2024 09:00:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707757213; x=1708362013;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HjNaCcVPbGjsbiOXI+W7wF6VbX0l3c5qvi60YHzKwuo=;
        b=QKvQLMcFev9KYBtS4FMCONxz/sJt9/EBpZ4CAsiKpBwt1CzBieaV7T++zRj/3DQNKL
         IO+JG2Z2CqEMuS7VhoOYdUSF9nOymamkFRWgYGjxJGc7NcvS3KHQE0lDVdUUgRzlk9Bo
         qmxeKg5WScSKJoN8Y1sGyUqpfXrhIvKC487EX+4bcP7gEgn7CpPL6nR4Rt/CJjZyKPAt
         WkuMwpmi8W2ARMUzf4P8aFNM0DZxlDOzQYJpmhV/fkT+1LP6GoF5qTPbu3Ya6mh+KuZl
         E+kkiyC5c1+LTXL2viaMiRtRup6FlRdPP4jCweN792n01ga58trEk6Ea4q5yi26LncgX
         aaiQ==
X-Gm-Message-State: AOJu0YxUsNU3Cau6J4xA/ypQZALvH59HhR5vUXFGzB7oxOIHEZl8sw8D
	C/9gIDGqF2guFWEtQnHE/cHUYwv0x0mh7NyCu1cnk56paxmeA2H02bHJH1ewRjvI3pLbhVpgJ/O
	RLIdmUDwNK+gB516wnwM2xKMeXGpui1ehim8zrSt6oqE/nUAYiARLtUdrdDOYh2ZDiAXwdQ==
X-Received: by 2002:a05:6402:340f:b0:560:c70f:9a0a with SMTP id k15-20020a056402340f00b00560c70f9a0amr5749015edc.1.1707757213606;
        Mon, 12 Feb 2024 09:00:13 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGaVyoDnUYHyjbhnfm0ylTX+NNCK45Hn8iWWe9/m395Kzs+0F05MXh/leILB7t1EK6GC5zbnw==
X-Received: by 2002:a05:6402:340f:b0:560:c70f:9a0a with SMTP id k15-20020a056402340f00b00560c70f9a0amr5748998edc.1.1707757213387;
        Mon, 12 Feb 2024 09:00:13 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVD8cj7TfTbKAJSOPfBbwNerkXbl4qtSTAJv587exJ1YNV30AX02UMtG7ezAhc0pcs6K0RJBtgByE/mknC7NxOtxFgDDxrlHdwvGmnwdtFpmutdySih3hgtJgKqHfd29qFzB3ut117WfLVCqLzImoBR+sXvwPO35RCReUKQfwL+nIsWpvz2UyFPLgBQ1A6Qz3nHw6tL3Hqqg9AN2rjL3RVO942AtvHYHzGP
Received: from thinky.redhat.com ([109.183.6.197])
        by smtp.gmail.com with ESMTPSA id 14-20020a0564021f4e00b0056176e95a88sm2620261edz.32.2024.02.12.09.00.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Feb 2024 09:00:12 -0800 (PST)
From: Andrey Albershteyn <aalbersh@redhat.com>
To: fsverity@lists.linux.dev,
	linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	chandan.babu@oracle.com,
	djwong@kernel.org,
	ebiggers@kernel.org
Cc: Andrey Albershteyn <aalbersh@redhat.com>
Subject: [PATCH v4 16/25] xfs: add XBF_DOUBLE_ALLOC to increase size of the buffer
Date: Mon, 12 Feb 2024 17:58:13 +0100
Message-Id: <20240212165821.1901300-17-aalbersh@redhat.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240212165821.1901300-1-aalbersh@redhat.com>
References: <20240212165821.1901300-1-aalbersh@redhat.com>
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
index 5762135dc2a6..1d32041412cc 100644
--- a/fs/xfs/libxfs/xfs_attr_remote.c
+++ b/fs/xfs/libxfs/xfs_attr_remote.c
@@ -392,12 +392,22 @@ xfs_attr_rmtval_get(
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
@@ -417,10 +427,21 @@ xfs_attr_rmtval_get(
 			dblkno = XFS_FSB_TO_DADDR(mp, map[i].br_startblock);
 			dblkcnt = XFS_FSB_TO_BB(mp, map[i].br_blockcount);
 			error = xfs_buf_read(mp->m_ddev_targp, dblkno, dblkcnt,
-					0, &bp, &xfs_attr3_rmt_buf_ops);
+					flags, &bp, &xfs_attr3_rmt_buf_ops);
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
 			error = xfs_attr_rmtval_copyout(mp, bp, args->dp->i_ino,
 							&offset, &valuelen,
 							&dst);
@@ -521,7 +542,8 @@ xfs_attr_rmtval_set_value(
 		dblkno = XFS_FSB_TO_DADDR(mp, map.br_startblock),
 		dblkcnt = XFS_FSB_TO_BB(mp, map.br_blockcount);
 
-		error = xfs_buf_get(mp->m_ddev_targp, dblkno, dblkcnt, 0, &bp);
+		error = xfs_buf_get(mp->m_ddev_targp, dblkno, dblkcnt,
+				XBF_DOUBLE_ALLOC, &bp);
 		if (error)
 			return error;
 		bp->b_ops = &xfs_attr3_rmt_buf_ops;
diff --git a/fs/xfs/xfs_buf.c b/fs/xfs/xfs_buf.c
index 8e5bd50d29fe..2645e64f2439 100644
--- a/fs/xfs/xfs_buf.c
+++ b/fs/xfs/xfs_buf.c
@@ -328,6 +328,9 @@ xfs_buf_alloc_kmem(
 	xfs_km_flags_t	kmflag_mask = KM_NOFS;
 	size_t		size = BBTOB(bp->b_length);
 
+	if (flags & XBF_DOUBLE_ALLOC)
+		size *= 2;
+
 	/* Assure zeroed buffer for non-read cases. */
 	if (!(flags & XBF_READ))
 		kmflag_mask |= KM_ZERO;
@@ -358,6 +361,7 @@ xfs_buf_alloc_pages(
 {
 	gfp_t		gfp_mask = __GFP_NOWARN;
 	long		filled = 0;
+	int		mul = (bp->b_flags & XBF_DOUBLE_ALLOC) ? 2 : 1;
 
 	if (flags & XBF_READ_AHEAD)
 		gfp_mask |= __GFP_NORETRY;
@@ -365,7 +369,7 @@ xfs_buf_alloc_pages(
 		gfp_mask |= GFP_NOFS;
 
 	/* Make sure that we have a page list */
-	bp->b_page_count = DIV_ROUND_UP(BBTOB(bp->b_length), PAGE_SIZE);
+	bp->b_page_count = DIV_ROUND_UP(BBTOB(bp->b_length*mul), PAGE_SIZE);
 	if (bp->b_page_count <= XB_PAGES) {
 		bp->b_pages = bp->b_page_array;
 	} else {
diff --git a/fs/xfs/xfs_buf.h b/fs/xfs/xfs_buf.h
index 80566ee444f8..8ca8760c401e 100644
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


