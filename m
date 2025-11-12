Return-Path: <linux-fsdevel+bounces-68048-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53E04C51E0B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Nov 2025 12:17:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D7FA4221F3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Nov 2025 11:08:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47E1B30FC3D;
	Wed, 12 Nov 2025 11:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="hdaGaeA9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF47E30E0D3;
	Wed, 12 Nov 2025 11:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762945651; cv=none; b=KOCDejXo1X+FRtYPKPYdE5ET0HoQBtvyr4Tmhw6CSorH5U4bI8H9jB7Mk96hUynqI0QVV+RkEQeoaXFAcl40n+37D/mrbx/+H4JFrnUAzvE4SicVkC6Wr0g26i1S5v+3XntN2xIgqSc4jemWnFy4uUJD4GcEvAVG1MKvVDC5Ad4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762945651; c=relaxed/simple;
	bh=HuBylNmXprk+5AT+RGf/JL2WhkvqEme6UgO4B6JJ0bg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dLfYJ7Ac55+szW/hTmfxU1iKklKVZqNk4h148qAB/CD6nbXj+Qm4jgBwVo5TNmpJk+670/dzEUZ8uBGVHdrKcIfg5zSw4CC/J2nFbCSZVn9QrUlRuirkuEYiNCPAMssF+xQ5KbyNHCvz936cEVy9tZQ2a8T1Xh2QOt/F+R7+Mos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=hdaGaeA9; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AC1H5ZP006228;
	Wed, 12 Nov 2025 11:07:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=JJFr4keXRYU2BQ2OG
	girGNGca9qGjwsLa/SbnM3D8iw=; b=hdaGaeA9BldZ8pKKwfDsXLBrZoO1PaP/P
	IOeuwCb9cfxZHgOr+Qqt9w1uN/9W6GBdyr99dYcZAirZkz/sQrQj7A2cPDpsoOEi
	c2LHXZdznXCWyQjBI/WEt4boKQuoghxSBSfO+QjY7ddEInPq2CyR4/tXdb3qajbW
	XX8p/ur/tfAWoXS93Gg9uPgTrItikzIrKcS5Wv/XzKHAUz9rboOkfIArFQEck2dj
	IOFz3Tt+WkABOdm7rYV5Vo+O37yPS5LoeKhG05r7RwikguIMFkEL4v+Fyma1C4B8
	tj1iAF1gA4MuX9cpYZJdOWCb39rWIauGUedSZa/84qENQllsHK+wg==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4a9wc7a4sc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Nov 2025 11:07:07 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5ACB77Zv006058;
	Wed, 12 Nov 2025 11:07:07 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4a9wc7a4s8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Nov 2025 11:07:07 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5AC9pwaY028880;
	Wed, 12 Nov 2025 11:07:06 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4aag6sfwtj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Nov 2025 11:07:06 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5ACB749A14942606
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Nov 2025 11:07:04 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9609A2004F;
	Wed, 12 Nov 2025 11:07:03 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CD17220040;
	Wed, 12 Nov 2025 11:06:58 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.124.210.190])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 12 Nov 2025 11:06:58 +0000 (GMT)
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: Christian Brauner <brauner@kernel.org>, djwong@kernel.org,
        ritesh.list@gmail.com, john.g.garry@oracle.com, tytso@mit.edu,
        willy@infradead.org, dchinner@redhat.com, hch@lst.de
Cc: linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, jack@suse.cz, nilay@linux.ibm.com,
        martin.petersen@oracle.com, rostedt@goodmis.org, axboe@kernel.dk,
        linux-block@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: [RFC PATCH 4/8] iomap: buffered atomic write support
Date: Wed, 12 Nov 2025 16:36:07 +0530
Message-ID: <8229fb9bcd2504b80caf0e763b1984d7ee6178b0.1762945505.git.ojaswin@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1762945505.git.ojaswin@linux.ibm.com>
References: <cover.1762945505.git.ojaswin@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA4MDAxOCBTYWx0ZWRfX/EFQSS99HVuT
 vjXvGh6n+TI2CpvVloLf9Dt/q2EePju9VVIVE11xJPxBEprRFhkfRf9Mm/zduTxHjXMfSQ76bBB
 bxf2rG0JIBJsicSlPxn7zpGXTbqgA1I/o75kYFOWEOwByybE2zyY++1t+VNqWY8hoWrjAFGizQJ
 knZ7DDImDJPHKsGhOp+oqZp+J26IZmr9M9F5+OUxtkHV2p3rVQfvQp1DbYYDpZiWvVK6eh76YaX
 R9HhHGpbqM7Imeu0mEAXYq+FRpB1Miuky1OdFoER1eRNafyVJyyNf+BiyBfrf6CYvkIgVUmJwi5
 7oACn6C1nTrPJQuj+DdIt2FnZ2cY1gj3zlreSxLKlkMuOkU5eflEXWEpjlPB819Ok5XXaDGqGAk
 hkWXrQvAIuJUw9Gsj3LdXNJeJoVvWA==
X-Authority-Analysis: v=2.4 cv=GcEaXAXL c=1 sm=1 tr=0 ts=69146a5b cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8 a=VnNF1IyMAAAA:8
 a=dV1BHfAgKDRkxd7NJUoA:9 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-GUID: tIXMLBmZYTUoyOIrw_fe93mzLokeKu4D
X-Proofpoint-ORIG-GUID: caDOk5hfyFffsVCTQpLSUncy-bdl3obK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-12_03,2025-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 bulkscore=0 adultscore=0 impostorscore=0
 lowpriorityscore=0 clxscore=1015 spamscore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2511080018

Add special handling of PG_atomic flag to iomap buffered write path.

To flag an iomap iter for an atomic write, set IOMAP_ATOMIC. For a folio
associated with a write which has IOMAP_ATOMIC set, set PG_atomic.
Otherwise, when IOMAP_ATOMIC is unset, clear PG_atomic.

This means that for an "atomic" folio which has not been written back,
it loses it "atomicity". So if userspace issues a write with RWF_ATOMIC
set and another write with RWF_ATOMIC unset, that folio is not written back
atomically. For such a scenario to occur, it would be considered a userspace
usage error.

To ensure that a buffered atomic write is written back atomically when
the write syscall returns, RWF_SYNC or similar needs to be used (in
conjunction with RWF_ATOMIC).

Only a single BIO should ever be submitted for an atomic write. So
modify iomap_add_to_ioend() to ensure that we don't try to write back an
atomic folio as part of a larger mixed-atomicity BIO.

In iomap_alloc_ioend(), handle an atomic write by setting REQ_ATOMIC for
the allocated BIO. When a folio is written back, again clear PG_atomic,
as it is no longer required.

Currently, RWF_ATOMIC with buffered IO is limited to single block
size writes, and has 2 main restrictions:

1. Only blocksize == pagesize is supported
2. Writes where the user buffer is not aligned to PAGE_SIZE are not
   supported

For more details, refer to the comment in generic_atomic_write_valid()

Co-developed-by: John Garry <john.g.garry@oracle.com>
Signed-off-by: John Garry <john.g.garry@oracle.com>
Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
---
 fs/iomap/buffered-io.c | 48 ++++++++++++++++++++++++++++++++++++------
 fs/iomap/ioend.c       | 18 ++++++++++++----
 fs/read_write.c        | 34 ++++++++++++++++++++++++++++--
 include/linux/iomap.h  |  2 ++
 4 files changed, 89 insertions(+), 13 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index f099c086cbe8..947c76c2688a 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -850,11 +850,13 @@ static int iomap_write_begin(struct iomap_iter *iter,
 {
 	const struct iomap *srcmap = iomap_iter_srcmap(iter);
 	loff_t pos;
-	u64 len = min_t(u64, SIZE_MAX, iomap_length(iter));
+	u64 orig_len = min_t(u64, SIZE_MAX, iomap_length(iter));
+	u64 len;
 	struct folio *folio;
 	int status = 0;
+	bool is_atomic = iter->flags & IOMAP_ATOMIC;
 
-	len = min_not_zero(len, *plen);
+	len = min_not_zero(orig_len, *plen);
 	*foliop = NULL;
 	*plen = 0;
 
@@ -922,6 +924,11 @@ static int iomap_write_begin(struct iomap_iter *iter,
 	if (unlikely(status))
 		goto out_unlock;
 
+	if (is_atomic && (len != orig_len)) {
+		status = -EINVAL;
+		goto out_unlock;
+	}
+
 	*foliop = folio;
 	*plen = len;
 	return 0;
@@ -931,7 +938,7 @@ static int iomap_write_begin(struct iomap_iter *iter,
 	return status;
 }
 
-static bool __iomap_write_end(struct inode *inode, loff_t pos, size_t len,
+static bool __iomap_write_end(struct iomap_iter *iter, loff_t pos, size_t len,
 		size_t copied, struct folio *folio)
 {
 	flush_dcache_folio(folio);
@@ -951,7 +958,27 @@ static bool __iomap_write_end(struct inode *inode, loff_t pos, size_t len,
 		return false;
 	iomap_set_range_uptodate(folio, offset_in_folio(folio, pos), len);
 	iomap_set_range_dirty(folio, offset_in_folio(folio, pos), copied);
-	filemap_dirty_folio(inode->i_mapping, folio);
+	filemap_dirty_folio(iter->inode->i_mapping, folio);
+
+	/*
+	 * Policy: non atomic write over a previously atomic range makes the
+	 * range non-atomic. Handle this here.
+	 */
+	if (iter->flags & IOMAP_ATOMIC) {
+		if (copied < len) {
+			/*
+			 * A short atomic write is only okay as long as nothing
+			 * is written at all. If we have a partial write, there
+			 * is a bug in our code.
+			 */
+			WARN_ON_ONCE(copied != 0);
+
+			return false;
+		}
+		folio_set_atomic(folio);
+	} else
+		folio_clear_atomic(folio);
+
 	return true;
 }
 
@@ -997,7 +1024,7 @@ static bool iomap_write_end(struct iomap_iter *iter, size_t len, size_t copied,
 		return bh_written == copied;
 	}
 
-	return __iomap_write_end(iter->inode, pos, len, copied, folio);
+	return __iomap_write_end(iter, pos, len, copied, folio);
 }
 
 static int iomap_write_iter(struct iomap_iter *iter, struct iov_iter *i,
@@ -1124,6 +1151,8 @@ iomap_file_buffered_write(struct kiocb *iocb, struct iov_iter *i,
 		iter.flags |= IOMAP_NOWAIT;
 	if (iocb->ki_flags & IOCB_DONTCACHE)
 		iter.flags |= IOMAP_DONTCACHE;
+	if (iocb->ki_flags & IOCB_ATOMIC)
+		iter.flags |= IOMAP_ATOMIC;
 
 	while ((ret = iomap_iter(&iter, ops)) > 0)
 		iter.status = iomap_write_iter(&iter, i, write_ops);
@@ -1588,6 +1617,7 @@ static int iomap_folio_mkwrite_iter(struct iomap_iter *iter,
 	} else {
 		WARN_ON_ONCE(!folio_test_uptodate(folio));
 		folio_mark_dirty(folio);
+		folio_clear_atomic(folio);
 	}
 
 	return iomap_iter_advance(iter, length);
@@ -1642,8 +1672,10 @@ void iomap_finish_folio_write(struct inode *inode, struct folio *folio,
 	WARN_ON_ONCE(i_blocks_per_folio(inode, folio) > 1 && !ifs);
 	WARN_ON_ONCE(ifs && atomic_read(&ifs->write_bytes_pending) <= 0);
 
-	if (!ifs || atomic_sub_and_test(len, &ifs->write_bytes_pending))
+	if (!ifs || atomic_sub_and_test(len, &ifs->write_bytes_pending)) {
+		folio_clear_atomic(folio);
 		folio_end_writeback(folio);
+	}
 }
 EXPORT_SYMBOL_GPL(iomap_finish_folio_write);
 
@@ -1807,8 +1839,10 @@ int iomap_writeback_folio(struct iomap_writepage_ctx *wpc, struct folio *folio)
 		if (atomic_dec_and_test(&ifs->write_bytes_pending))
 			folio_end_writeback(folio);
 	} else {
-		if (!wb_pending)
+		if (!wb_pending) {
+			folio_clear_atomic(folio);
 			folio_end_writeback(folio);
+		}
 	}
 	mapping_set_error(inode->i_mapping, error);
 	return error;
diff --git a/fs/iomap/ioend.c b/fs/iomap/ioend.c
index b49fa75eab26..c129a695ceca 100644
--- a/fs/iomap/ioend.c
+++ b/fs/iomap/ioend.c
@@ -98,13 +98,17 @@ int iomap_ioend_writeback_submit(struct iomap_writepage_ctx *wpc, int error)
 EXPORT_SYMBOL_GPL(iomap_ioend_writeback_submit);
 
 static struct iomap_ioend *iomap_alloc_ioend(struct iomap_writepage_ctx *wpc,
-		loff_t pos, u16 ioend_flags)
+					     loff_t pos, u16 ioend_flags,
+					     bool atomic)
 {
 	struct bio *bio;
+	blk_opf_t opf = REQ_OP_WRITE | wbc_to_write_flags(wpc->wbc);
+
+	if (atomic)
+		opf |= REQ_ATOMIC;
 
 	bio = bio_alloc_bioset(wpc->iomap.bdev, BIO_MAX_VECS,
-			       REQ_OP_WRITE | wbc_to_write_flags(wpc->wbc),
-			       GFP_NOFS, &iomap_ioend_bioset);
+			       opf, GFP_NOFS, &iomap_ioend_bioset);
 	bio->bi_iter.bi_sector = iomap_sector(&wpc->iomap, pos);
 	bio->bi_write_hint = wpc->inode->i_write_hint;
 	wbc_init_bio(wpc->wbc, bio);
@@ -122,6 +126,9 @@ static bool iomap_can_add_to_ioend(struct iomap_writepage_ctx *wpc, loff_t pos,
 	if ((ioend_flags & IOMAP_IOEND_NOMERGE_FLAGS) !=
 	    (ioend->io_flags & IOMAP_IOEND_NOMERGE_FLAGS))
 		return false;
+	if ((ioend_flags & IOMAP_IOEND_ATOMIC) ||
+	    (ioend->io_flags & IOMAP_IOEND_ATOMIC))
+		return false;
 	if (pos != ioend->io_offset + ioend->io_size)
 		return false;
 	if (!(wpc->iomap.flags & IOMAP_F_ANON_WRITE) &&
@@ -156,6 +163,7 @@ ssize_t iomap_add_to_ioend(struct iomap_writepage_ctx *wpc, struct folio *folio,
 	unsigned int ioend_flags = 0;
 	unsigned int map_len = min_t(u64, dirty_len,
 		wpc->iomap.offset + wpc->iomap.length - pos);
+	bool is_atomic = folio_test_atomic(folio);
 	int error;
 
 	trace_iomap_add_to_ioend(wpc->inode, pos, dirty_len, &wpc->iomap);
@@ -180,6 +188,8 @@ ssize_t iomap_add_to_ioend(struct iomap_writepage_ctx *wpc, struct folio *folio,
 		ioend_flags |= IOMAP_IOEND_DONTCACHE;
 	if (pos == wpc->iomap.offset && (wpc->iomap.flags & IOMAP_F_BOUNDARY))
 		ioend_flags |= IOMAP_IOEND_BOUNDARY;
+	if (is_atomic)
+		ioend_flags |= IOMAP_IOEND_ATOMIC;
 
 	if (!ioend || !iomap_can_add_to_ioend(wpc, pos, ioend_flags)) {
 new_ioend:
@@ -188,7 +198,7 @@ ssize_t iomap_add_to_ioend(struct iomap_writepage_ctx *wpc, struct folio *folio,
 			if (error)
 				return error;
 		}
-		wpc->wb_ctx = ioend = iomap_alloc_ioend(wpc, pos, ioend_flags);
+		wpc->wb_ctx = ioend = iomap_alloc_ioend(wpc, pos, ioend_flags, is_atomic);
 	}
 
 	if (!bio_add_folio(&ioend->io_bio, folio, map_len, poff))
diff --git a/fs/read_write.c b/fs/read_write.c
index 833bae068770..37546aa40f0d 100644
--- a/fs/read_write.c
+++ b/fs/read_write.c
@@ -1802,6 +1802,8 @@ int generic_file_rw_checks(struct file *file_in, struct file *file_out)
 
 int generic_atomic_write_valid(struct kiocb *iocb, struct iov_iter *iter)
 {
+	struct super_block *sb = iocb->ki_filp->f_mapping->host->i_sb;
+
 	size_t len = iov_iter_count(iter);
 
 	if (!iter_is_ubuf(iter))
@@ -1813,8 +1815,36 @@ int generic_atomic_write_valid(struct kiocb *iocb, struct iov_iter *iter)
 	if (!IS_ALIGNED(iocb->ki_pos, len))
 		return -EINVAL;
 
-	if (!(iocb->ki_flags & IOCB_DIRECT))
-		return -EOPNOTSUPP;
+	if (!(iocb->ki_flags & IOCB_DIRECT)) {
+		/* Some restrictions to buferred IO */
+
+		/*
+		 * We only support block size == page size
+		 * right now. This is to avoid the following:
+		 * 1. 4kb block atomic write marks the complete 64kb folio as
+		 *    atomic.
+		 * 2. Other writes, dirty the whole 64kb folio.
+		 * 3. Writeback sees the whole folio dirty and atomic and tries
+		 *    to send a 64kb atomic write, which might exceed the
+		 *    allowed size and fail.
+		 *
+		 * Once we support sub-page atomic write tracking, we can remove
+		 * this restriction.
+		 */
+		if (sb->s_blocksize != PAGE_SIZE)
+			return -EOPNOTSUPP;
+
+		/*
+		 * If the user buffer of atomic write crosses page boundary,
+		 * there's a possibility of short write, example if 1 user page
+		 * could not be faulted or got reclaimed before the copy
+		 * operation. For now don't allow such a scenario by ensuring
+		 * user buffer is page aligned.
+		 */
+		if (!PAGE_ALIGNED(iov_iter_alignment(iter)))
+			return -EOPNOTSUPP;
+
+	}
 
 	return 0;
 }
diff --git a/include/linux/iomap.h b/include/linux/iomap.h
index 8b1ac08c7474..693f3e5ad03c 100644
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@ -390,6 +390,8 @@ sector_t iomap_bmap(struct address_space *mapping, sector_t bno,
 #define IOMAP_IOEND_DIRECT		(1U << 3)
 /* is DONTCACHE I/O */
 #define IOMAP_IOEND_DONTCACHE		(1U << 4)
+/* is atomic I/O. These are never merged */
+#define IOMAP_IOEND_ATOMIC		(1U << 5)
 
 /*
  * Flags that if set on either ioend prevent the merge of two ioends.
-- 
2.51.0


