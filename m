Return-Path: <linux-fsdevel+bounces-27523-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E79D8961E03
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Aug 2024 07:12:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2541C1C20F36
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Aug 2024 05:12:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19B3415278E;
	Wed, 28 Aug 2024 05:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="H7UJd+pd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33DFE14B08A;
	Wed, 28 Aug 2024 05:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724821928; cv=none; b=kdKbi2wVvpZjZL6JchICT/20bsKzrkXRW+t7b302NehXAMqz+91C/X65SwAImUNnc1DRqPTBjwYYQ1qYP/Qval0T3omWjvcM3EDJOfraQrAl+uWx/AZ8CvI3b7oHkHz4b455txxgJAroFr9n0O8+0U9qgxrbIS4rFfwyTsVKrD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724821928; c=relaxed/simple;
	bh=bAZfN1k7k/+1mdDLaJSA7/srGf66PBAw+ZdRrsdTldU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=shKfs6Ab0597YysEZ5fIxWV0G5UFwudLGfYpvJlbpy65lRuwjm4v1jAFoaFBd0i3KZRF/cHU0lnJlEcpD/PsYA1kM8r3oo6eXw57iw9eQ7KkfKnpe9IOPDscz5mAyzG7itHBBTWwDilHPjujzYkQGj8D1yHZWeZfKsGiIcVV2sE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=H7UJd+pd; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=pHxqFYikJnUNrKoVzAQJtyadD00JY6fqRR9A5v/BpGI=; b=H7UJd+pdO0mwUBtPTCj+PgQV6y
	MwFAEbb8Iu07wrsRvZN69CeJREG6SK+jsSq/B33S8Oy6vahEQ+HxueUa4DadWHZkCDyJ9pl8XZy8s
	X65oLEp2RCC4ILOwNgX60jKuFtzVoHO1uUlMAWPI6/IcG3gRcY1+8ezEvFiotID9E1ubH/0Vbr2xO
	VUe20tmeZNGF/3AQsBDkr4rGw+wW86VAdiLhO/szbJIqcio33e5RWTcvnjshhTo6OqZ9qoPvU9a0v
	lueyyJpztsiZU8hthyxYlOAr4S+U2Of9zZSw5iF58N3MahNCIdlr2g4K9SHNHd29mxogTdrR1E01N
	Dyp58KYw==;
Received: from ppp-2-84-49-240.home.otenet.gr ([2.84.49.240] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sjAyS-0000000DsG3-1Xe7;
	Wed, 28 Aug 2024 05:12:05 +0000
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
	linux-xfs@vger.kernel.org
Subject: [PATCH 2/3] fs: add STATX_DIO_READ_ALIGN
Date: Wed, 28 Aug 2024 08:11:02 +0300
Message-ID: <20240828051149.1897291-3-hch@lst.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240828051149.1897291-1-hch@lst.de>
References: <20240828051149.1897291-1-hch@lst.de>
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
---
 fs/stat.c                 | 1 +
 include/linux/stat.h      | 1 +
 include/uapi/linux/stat.h | 4 +++-
 3 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/fs/stat.c b/fs/stat.c
index 89ce1be563108c..044e7ad9f3abc2 100644
--- a/fs/stat.c
+++ b/fs/stat.c
@@ -700,6 +700,7 @@ cp_statx(const struct kstat *stat, struct statx __user *buffer)
 	tmp.stx_mnt_id = stat->mnt_id;
 	tmp.stx_dio_mem_align = stat->dio_mem_align;
 	tmp.stx_dio_offset_align = stat->dio_offset_align;
+	tmp.stx_dio_read_offset_align = stat->dio_read_offset_align;
 	tmp.stx_subvol = stat->subvol;
 	tmp.stx_atomic_write_unit_min = stat->atomic_write_unit_min;
 	tmp.stx_atomic_write_unit_max = stat->atomic_write_unit_max;
diff --git a/include/linux/stat.h b/include/linux/stat.h
index 3d900c86981c5b..9d8382e23a9c69 100644
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
index 8b35d7d511a287..f78ee3670dd5d7 100644
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
2.43.0


