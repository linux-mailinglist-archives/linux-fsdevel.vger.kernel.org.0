Return-Path: <linux-fsdevel+bounces-38719-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CFE3AA0700E
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Jan 2025 09:31:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0EF05167F2A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Jan 2025 08:31:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2586E214A97;
	Thu,  9 Jan 2025 08:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="UG8wFP16"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3744321516E;
	Thu,  9 Jan 2025 08:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736411484; cv=none; b=nCqVE3RGspRegW3xx/7eu56m0ZGhtPqE69A/TgMKMFwOxAY1CkmbmCrjNiCiKyf8a6T3gf02dtcrigZAt0Kje32YZ+IhB/mJTa+WGr5HIwkrWjH1HK4Yg/w4mh1PGxeym46ouarBg9AeO1v+jDOlj9YgYqLfWitlevmHDP8WA14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736411484; c=relaxed/simple;
	bh=J1th+OKo7sRPtNTG8nj+slROf3VAUfwKZ+9GM+fOzfw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G5iW+8ZuIwFSuQodS4VORVWxYfc0beDyziNyqvcKQE28pHeas+srZqKTQy/BU12fzyF88h0ERzfIaYnT2oaMjSHChOE9hSjOJzIlnFVpI7PZX68J+YO3wUh3BJduhuGMMaV0Se+idxDcXt2UHz+kDB45/E2mgOaDRwMctAnNkhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=UG8wFP16; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=DemRIt2kJHLIwla+rtZxPfLIk3nzA6zNIJ+EIn00WYg=; b=UG8wFP16J1Jv6p/rroGzY95OI/
	e4XR+d8nkeYpS/TzoryfAwVOZtrtrMBRGiGHs8FJkjs+UfwbP55WVjxOvLkPq9EMYByZZiQVkhjjx
	h8t2bnQzwBON3g2mz/DnZk4pEP2V201rsOLYVbcMJCOY0rCztAZHk/0gdsv2XfbsltFCn1oFqhBNh
	zTZYhAUgIf+yez0zeVK9wz+TumZioPkCRcwhw67caaBa0zupgoT7xIR+/GmRf/qnbJYt7IUiEygQA
	4IZe9L4FZQdfxBRnos+/bC1bGNLGeyty8ZjQwY/vyAvI7+5zVY1qjo/LcZ41+1i+36lQPV/+hxFCO
	W0S0uWqg==;
Received: from 2a02-8389-2341-5b80-ddeb-cdec-70b9-e2f0.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:ddeb:cdec:70b9:e2f0] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tVnwm-0000000BBdq-2NaJ;
	Thu, 09 Jan 2025 08:31:21 +0000
From: Christoph Hellwig <hch@lst.de>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>,
	Chandan Babu R <chandan.babu@oracle.com>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Hongbo Li <lihongbo22@huawei.com>,
	Ryusuke Konishi <konishi.ryusuke@gmail.com>,
	linux-nilfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	John Garry <john.g.garry@oracle.com>
Subject: [PATCH 2/5] fs: add STATX_DIO_READ_ALIGN
Date: Thu,  9 Jan 2025 09:31:02 +0100
Message-ID: <20250109083109.1441561-3-hch@lst.de>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250109083109.1441561-1-hch@lst.de>
References: <20250109083109.1441561-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Add a separate dio read align field, as many out of place write
file systems can easily do reads aligned to the device sector size,
but require bigger alignment for writes.

This is usually papered over by falling back to buffered I/O for smaller
writes and doing read-modify-write cycles, but performance for this
sucks, so applications benefit from knowing the actual write alignment.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: John Garry <john.g.garry@oracle.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
---
 fs/stat.c                 | 1 +
 include/linux/stat.h      | 1 +
 include/uapi/linux/stat.h | 4 +++-
 3 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/fs/stat.c b/fs/stat.c
index 0870e969a8a0..2c0e111a098a 100644
--- a/fs/stat.c
+++ b/fs/stat.c
@@ -725,6 +725,7 @@ cp_statx(const struct kstat *stat, struct statx __user *buffer)
 	tmp.stx_mnt_id = stat->mnt_id;
 	tmp.stx_dio_mem_align = stat->dio_mem_align;
 	tmp.stx_dio_offset_align = stat->dio_offset_align;
+	tmp.stx_dio_read_offset_align = stat->dio_read_offset_align;
 	tmp.stx_subvol = stat->subvol;
 	tmp.stx_atomic_write_unit_min = stat->atomic_write_unit_min;
 	tmp.stx_atomic_write_unit_max = stat->atomic_write_unit_max;
diff --git a/include/linux/stat.h b/include/linux/stat.h
index 3d900c86981c..9d8382e23a9c 100644
--- a/include/linux/stat.h
+++ b/include/linux/stat.h
@@ -52,6 +52,7 @@ struct kstat {
 	u64		mnt_id;
 	u32		dio_mem_align;
 	u32		dio_offset_align;
+	u32		dio_read_offset_align;
 	u64		change_cookie;
 	u64		subvol;
 	u32		atomic_write_unit_min;
diff --git a/include/uapi/linux/stat.h b/include/uapi/linux/stat.h
index 8b35d7d511a2..f78ee3670dd5 100644
--- a/include/uapi/linux/stat.h
+++ b/include/uapi/linux/stat.h
@@ -179,7 +179,8 @@ struct statx {
 	/* Max atomic write segment count */
 	__u32   stx_atomic_write_segments_max;
 
-	__u32   __spare1[1];
+	/* File offset alignment for direct I/O reads */
+	__u32	stx_dio_read_offset_align;
 
 	/* 0xb8 */
 	__u64	__spare3[9];	/* Spare space for future expansion */
@@ -213,6 +214,7 @@ struct statx {
 #define STATX_MNT_ID_UNIQUE	0x00004000U	/* Want/got extended stx_mount_id */
 #define STATX_SUBVOL		0x00008000U	/* Want/got stx_subvol */
 #define STATX_WRITE_ATOMIC	0x00010000U	/* Want/got atomic_write_* fields */
+#define STATX_DIO_READ_ALIGN	0x00020000U	/* Want/got dio read alignment info */
 
 #define STATX__RESERVED		0x80000000U	/* Reserved for future struct statx expansion */
 
-- 
2.45.2


