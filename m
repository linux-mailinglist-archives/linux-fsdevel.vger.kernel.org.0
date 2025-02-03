Return-Path: <linux-fsdevel+bounces-40585-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34595A25629
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Feb 2025 10:44:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 02A84166FED
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Feb 2025 09:44:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA98220124E;
	Mon,  3 Feb 2025 09:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="4Ljqzspb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DE8B1FFC5F;
	Mon,  3 Feb 2025 09:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738575827; cv=none; b=ExeEMWq82VXU3m42rBPLiNlfHyFgKnnm2IeMB7qLsBvVpDBT/4gopVx5og5gtgDXOkEvxSPRHZwnaD2mvIL94O6CqbgY1sZtBo9bnyE281K2eC5fZuFmqa1Op8A5idaFhadPZSWHvyuZt8t8E/FYZj7RPWxoQ9ANE3sVDJ5D4yI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738575827; c=relaxed/simple;
	bh=dCXeVt8dRfbqbGCPB6sMufQYJnUBcCFfMLj5eq+b8vk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gqCm3qeDWd3nBfgp8VCI/sTD68N/y1a05QszJdh+64p3rCRlvyKUP7SbaHAdUU1xrvGOEQ6FJbGTADSOXYcv0FWdxYejZCG+VcviRjAhJSMNtNzLoDa4r+dSC/Ml7KSn0w1YO9iZxMBe+RS0WkfhsMV5kxvl6N+x4zvIJSZXi50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=4Ljqzspb; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=8sfW3RXcNW2wYU3qaS4CmyxX4fJw7263JCYLxDjNqIM=; b=4LjqzspbiHr0LX8gKdzlN7Mo7a
	zH/Ibi9sX70MS7OzjAWWcWtB9xsn0sWWZbi+8SGPIdDDOWrUaIBdoHUnZZPWQLFyHu7ykiai9DSli
	XDUDR2l+TqLmxWf/9fMe/APmYpXSNtY1ZwFlGzv0BrfV3WWLFq/00Z/FZ/pdqpYzMMZ5+5oxFUvN8
	sHt4JSK1jN82koHs1aLfwXIvKpdLUNwDZsXuXHLIXfp0Nn2ABjXp4K62BtalUURngdQs01Mu4zwx4
	i5AbIRVEXybAOLbwu25E+hUtXX7e4gBiUqenJOk1Wb+0EZjkaUXi7lze3t2xI/IVEzFO6Y43N89Vs
	IGzyVxpQ==;
Received: from 2a02-8389-2341-5b80-b79f-eb9e-0b40-3aae.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:b79f:eb9e:b40:3aae] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1teszY-0000000F1kl-34oe;
	Mon, 03 Feb 2025 09:43:45 +0000
From: Christoph Hellwig <hch@lst.de>
To: Kanchan Joshi <joshi.k@samsung.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>
Cc: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
	Qu Wenruo <wqu@suse.com>,
	Goldwyn Rodrigues <rgoldwyn@suse.com>,
	linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org
Subject: [PATCH 7/7] xfs: implement block-metadata based data checksums
Date: Mon,  3 Feb 2025 10:43:11 +0100
Message-ID: <20250203094322.1809766-8-hch@lst.de>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250203094322.1809766-1-hch@lst.de>
References: <20250203094322.1809766-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

This is a quick hack to demonstrate how data checksumming can be
implemented when it can be stored in the out of line metadata for each
logical block.  It builds on top of the previous PI infrastructure
and instead of generating/verifying protection information it simply
generates and verifies a crc32c checksum and stores it in the non-PI
metadata.  It misses a feature bit in the superblock, checking that
enough size is available in the metadata and many other things.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/xfs/xfs_data_csum.c | 79 ++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 76 insertions(+), 3 deletions(-)

diff --git a/fs/xfs/xfs_data_csum.c b/fs/xfs/xfs_data_csum.c
index d9d3620654b1..862388803398 100644
--- a/fs/xfs/xfs_data_csum.c
+++ b/fs/xfs/xfs_data_csum.c
@@ -14,6 +14,73 @@
 #include <linux/blk-integrity.h>
 #include <linux/bio-integrity.h>
 
+static inline void *xfs_csum_buf(struct bio *bio)
+{
+	return bvec_virt(bio_integrity(bio)->bip_vec);
+}
+
+static inline __le32
+xfs_data_csum(
+	void			*data,
+	unsigned int		len)
+{
+	return xfs_end_cksum(crc32c(XFS_CRC_SEED, data, len));
+}
+
+static void
+__xfs_data_csum_generate(
+	struct bio		*bio)
+{
+	unsigned int		ssize = bdev_logical_block_size(bio->bi_bdev);
+	__le32			*csum_buf = xfs_csum_buf(bio);
+	struct bvec_iter_all	iter;
+	struct bio_vec		*bv;
+	int			c = 0;
+
+	bio_for_each_segment_all(bv, bio, iter) {
+		void		*p;
+		unsigned int	off;
+
+		p = bvec_kmap_local(bv);
+		for (off = 0; off < bv->bv_len; off += ssize)
+			csum_buf[c++] = xfs_data_csum(p + off, ssize);
+		kunmap_local(p);
+	}
+}
+
+static int
+__xfs_data_csum_verify(
+	struct bio		*bio,
+	struct xfs_inode	*ip,
+	xfs_off_t		file_offset)
+{
+	unsigned int		ssize = bdev_logical_block_size(bio->bi_bdev);
+	__le32			*csum_buf = xfs_csum_buf(bio);
+	int			c = 0;
+	struct bvec_iter_all	iter;
+	struct bio_vec		*bv;
+
+	bio_for_each_segment_all(bv, bio, iter) {
+		void		*p;
+		unsigned int	off;
+
+		p = bvec_kmap_local(bv);
+		for (off = 0; off < bv->bv_len; off += ssize) {
+			if (xfs_data_csum(p + off, ssize) != csum_buf[c++]) {
+				kunmap_local(p);
+				xfs_warn(ip->i_mount,
+"checksum mismatch at inode 0x%llx offset %lld",
+					ip->i_ino, file_offset);
+				return -EFSBADCRC;
+			}
+			file_offset += ssize;
+		}
+		kunmap_local(p);
+	}
+
+	return 0;
+}
+
 void *
 xfs_data_csum_alloc(
 	struct bio		*bio)
@@ -53,11 +120,14 @@ xfs_data_csum_generate(
 {
 	struct blk_integrity	*bi = blk_get_integrity(bio->bi_bdev->bd_disk);
 
-	if (!bi || !bi->csum_type)
+	if (!bi)
 		return;
 
 	xfs_data_csum_alloc(bio);
-	blk_integrity_generate(bio);
+	if (!bi->csum_type)
+		__xfs_data_csum_generate(bio);
+	else
+		blk_integrity_generate(bio);
 }
 
 int
@@ -67,7 +137,10 @@ xfs_data_csum_verify(
 	struct bio		*bio = &ioend->io_bio;
 	struct blk_integrity	*bi = blk_get_integrity(bio->bi_bdev->bd_disk);
 
-	if (!bi || !bi->csum_type)
+	if (!bi)
 		return 0;
+	if (!bi->csum_type)
+		return __xfs_data_csum_verify(&ioend->io_bio,
+				XFS_I(ioend->io_inode), ioend->io_offset);
 	return blk_integrity_verify_all(bio, ioend->io_sector);
 }
-- 
2.45.2


