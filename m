Return-Path: <linux-fsdevel+bounces-68049-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FE65C51E6E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Nov 2025 12:20:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 53E1A4FA47F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Nov 2025 11:09:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E16093126A1;
	Wed, 12 Nov 2025 11:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="rdUaptTB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 741433101DC;
	Wed, 12 Nov 2025 11:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762945657; cv=none; b=ZS7411Ius4USm7yQBo5JRB/+nk8aCih31V6R93TxxHT9B0JYpD9Ww7+B6KjEo4sMPzOWcgXIGVP3TQuix6R7i97j65w7l/P800iiL5OvqMXeKw1rjxuwpY83UwoN0tTSFcFFWBmecsumAmizJVf9hbgjYDUEHzWS79nNK6hwyJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762945657; c=relaxed/simple;
	bh=R2bzbLbXmmS/L6Gh9leejSTadCTX3HQn0kZdy5GqfmY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fGJ0PFHpuYykymsXfa+Qe3bA0hparReFT2HgiQOcKiRz47sL8t9bnanxdcDCGaQJk7zONvpffqJqOUkdVjnZEz4FzSmiFVSDdL8rtAMEk39MhpjYhkEOWPN14Ema8Bz4ri9aUqcNqhszD86Kn3je58csJjQHxpKBtktwz6EnrOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=rdUaptTB; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AC0G5wA002861;
	Wed, 12 Nov 2025 11:07:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=EVZQc7qmgA5wJPVG+
	Bj3uDtqtTwQveu8wh6J4oOIWpA=; b=rdUaptTBlliAo634fAM/R3w23qCzxijTF
	Ea+9sQj/jy4hBhqMIeH6Lp84abQ3k5HEyjjCoXzhyWq1Pc2jmM+CKwgR/LwI/09K
	uzTOe8QayPuEKjdE4fD8x0yaMJItHJJvfpP8Yb4eMEdKXuMRSiQNvXtA4lZSA/FO
	BpbiFLczD3MoYjh+/SESCSOT3fBgOZNQKRbnCVSjDSpsuVKQ/j/32hGKJxTzBInB
	/WT7tT9sxrDoFW27xrK63Eesw4BiSpWO/u0rWuSqS6s/X8BwbLLecpvyJ3L22C2s
	Sm99GML69A6eKF4QgFLs7jrkty7GO1MSRXLb0EyLcpxzpl+X5UXTQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4aa3m87y3a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Nov 2025 11:07:13 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5ACAsEBn031942;
	Wed, 12 Nov 2025 11:07:12 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4aa3m87y35-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Nov 2025 11:07:12 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5AC9imJi008197;
	Wed, 12 Nov 2025 11:07:12 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4aah6myrcn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Nov 2025 11:07:11 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5ACB7ALe15991066
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Nov 2025 11:07:10 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E210C20043;
	Wed, 12 Nov 2025 11:07:09 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0659B20040;
	Wed, 12 Nov 2025 11:07:04 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.124.210.190])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 12 Nov 2025 11:07:03 +0000 (GMT)
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: Christian Brauner <brauner@kernel.org>, djwong@kernel.org,
        ritesh.list@gmail.com, john.g.garry@oracle.com, tytso@mit.edu,
        willy@infradead.org, dchinner@redhat.com, hch@lst.de
Cc: linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, jack@suse.cz, nilay@linux.ibm.com,
        martin.petersen@oracle.com, rostedt@goodmis.org, axboe@kernel.dk,
        linux-block@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: [RFC PATCH 5/8] iomap: pin pages for RWF_ATOMIC buffered write
Date: Wed, 12 Nov 2025 16:36:08 +0530
Message-ID: <e457da0bf10c9ac5db84bfd21f12275ca2414bc6.1762945505.git.ojaswin@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=MtZfKmae c=1 sm=1 tr=0 ts=69146a61 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VnNF1IyMAAAA:8
 a=WNJbaA9oiIIJLtcfmx8A:9 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-GUID: FAM-rncxNJ-mpYkmvRm7V1ZZTPdubWGU
X-Proofpoint-ORIG-GUID: qXWHihwQ9a3vmRb4XXCAE2VgMmyhm4ms
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA4MDA3OSBTYWx0ZWRfX+WRaeh1uDxeb
 lvkABinf8Lb8H6mcI7vr4Ozn0wnY6ljzKG5irmKxBiXzor8yUNGOVF+tJ8PZGf2Lf3H6IJKvU5u
 spQe+QYlXAFwTt5w9D/kogAN/oCE9yo+cHjGWzvRTN2vx0QCttyVdTAb9Jiq7sibDp8/m9X266p
 0APhKcd8LY1Z6gucORb0MWIQI8flR1UYaEkMaueZuv6rzAVPQ384uvzQYW87riwCmiCyyTp+rBp
 JiPww8wjh/lPZC6kelKOP6/qVBY5r/XWqGv9V5w/zOlw12iuiH1d+jno8gNGQvkLcfaQ+9/cOYF
 CSeAHWrzXljQ31SyM6b40KjhOjxjNOWTktDebnqwC1g31WlmeRnnsMu9tPD+GT8mWWzlwjPHTQA
 yvIsuezvumfv34T8shtMUvsusmvTeQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-12_03,2025-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 priorityscore=1501 bulkscore=0 impostorscore=0
 suspectscore=0 lowpriorityscore=0 clxscore=1015 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2511080079

Currently, if the user buffer crosses a page boundary (even if it is a
single block write), we can end up with the following scenario:

1. We prefault the 2 user pages in iomap_write_iter.
2. Due to memory pressure, 1 page is reclaimed.
3. copy_folio_from_iter_atomic() ends up doing a short copy

This is unacceptable for RWF_ATOMIC writes since at this point our folio
is already dirty and we will be unable to recover the old data to
guarantee the atomic semantics.

Get past this issue by taking inspiration from the direct IO code and
performaing the following steps for RWF_ATOMIC:

 1. Pin all the user pages. This pins the physical page but the user
    space mapping can still be unmapped by reclaim code, which can still
    cause a short write in copy_folio_from_iter_atomic().
 2. To get past the user mapping getting unmapped, don't use the user
    iter anymore but rather create a bvec out of the pinned pages. This
    way we area safe from unmapping since we use the kernel's mapping
    directly. Having a bvec also allows us directly reuse
    copy_folio_from_iter_atomic().

This ensures we should never see a short write since we prefault and pin
the pages in case of RWF_ATOMIC

Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
---
 fs/iomap/buffered-io.c | 154 +++++++++++++++++++++++++++++++++++++----
 fs/read_write.c        |  11 ---
 2 files changed, 140 insertions(+), 25 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 947c76c2688a..e7dbe9bcb439 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -1027,6 +1027,73 @@ static bool iomap_write_end(struct iomap_iter *iter, size_t len, size_t copied,
 	return __iomap_write_end(iter, pos, len, copied, folio);
 }
 
+/*
+ * Prepare an atomic write by pinning its pages and creating a ITER_BVEC out of
+ * them. This function also advances the original iter. Incase we encounter any
+ * error later, we revert the progress.
+ */
+static int iomap_atomic_write_prep(struct iov_iter *i,
+				   struct iov_iter *atomic_iter,
+				   struct bio_vec **atomic_bvecs,
+				   struct page ***pages)
+{
+	size_t pg_off;
+	int bytes_pinned = 0;
+	int k = 0;
+	int len, total_len = 0, off;
+	int pinned_pgs = 0;
+	struct bio_vec *tmp_bvecs;
+
+	bytes_pinned = iov_iter_extract_pages(i, pages, iov_iter_count(i),
+					      UINT_MAX, 0, &pg_off);
+	/*
+	 * iov_iter_extract_pages advances the iter but we didn't
+	 * do any work yet, so revert.
+	 */
+	iov_iter_revert(i, bytes_pinned);
+
+	pinned_pgs = DIV_ROUND_UP(pg_off + bytes_pinned, PAGE_SIZE);
+
+	tmp_bvecs = kcalloc(pinned_pgs, sizeof(struct bio_vec), GFP_KERNEL);
+
+	if (unlikely(!tmp_bvecs))
+		return -ENOMEM;
+
+	for (struct page *p; k < pinned_pgs && iov_iter_count(i); k++) {
+		p = (*pages)[k];
+		off = (unsigned long)((char *)i->ubuf + i->iov_offset) %
+		      PAGE_SIZE;
+		len = min(PAGE_SIZE - off, iov_iter_count(i));
+		bvec_set_page(&tmp_bvecs[k], p, len, off);
+		iov_iter_advance(i, len);
+		total_len += len;
+	}
+
+	iov_iter_bvec(atomic_iter, ITER_SOURCE, tmp_bvecs, k, total_len);
+
+	*atomic_bvecs = tmp_bvecs;
+	return pinned_pgs;
+}
+
+static void iomap_atomic_write_cleanup(struct page ***pages, int *pinned_pgs,
+				       struct bio_vec **atomic_bvecs)
+{
+	if (*pinned_pgs) {
+		unpin_user_pages(*pages, *pinned_pgs);
+		*pinned_pgs = 0;
+	}
+
+	if (*pages) {
+		kfree(*pages);
+		*pages = NULL;
+	}
+
+	if (*atomic_bvecs) {
+		kfree(*atomic_bvecs);
+		*atomic_bvecs = NULL;
+	}
+}
+
 static int iomap_write_iter(struct iomap_iter *iter, struct iov_iter *i,
 		const struct iomap_write_ops *write_ops)
 {
@@ -1035,6 +1102,11 @@ static int iomap_write_iter(struct iomap_iter *iter, struct iov_iter *i,
 	struct address_space *mapping = iter->inode->i_mapping;
 	size_t chunk = mapping_max_folio_size(mapping);
 	unsigned int bdp_flags = (iter->flags & IOMAP_NOWAIT) ? BDP_ASYNC : 0;
+	bool is_atomic = iter->flags & IOMAP_ATOMIC;
+	struct page **pages = NULL;
+	int pinned_pgs;
+	struct iov_iter atomic_iter = {0};
+	struct bio_vec *atomic_bvecs = NULL;
 
 	do {
 		struct folio *folio;
@@ -1057,19 +1129,52 @@ static int iomap_write_iter(struct iomap_iter *iter, struct iov_iter *i,
 		if (bytes > iomap_length(iter))
 			bytes = iomap_length(iter);
 
-		/*
-		 * Bring in the user page that we'll copy from _first_.
-		 * Otherwise there's a nasty deadlock on copying from the
-		 * same page as we're writing to, without it being marked
-		 * up-to-date.
-		 *
-		 * For async buffered writes the assumption is that the user
-		 * page has already been faulted in. This can be optimized by
-		 * faulting the user page.
-		 */
-		if (unlikely(fault_in_iov_iter_readable(i, bytes) == bytes)) {
-			status = -EFAULT;
-			break;
+		if (is_atomic) {
+			/*
+			 * If the user pages get reclaimed or unmapped, we could
+			 * end up faulting and doing a short copy in
+			 * copy_folio_from_iter_atomic(), which is undesirable
+			 * for RWF_ATOMIC. Hence:
+			 *
+			 * 1. Pin the pages to protect against reclaim
+			 *
+			 * 2. Iter's user page can still get unmapped from user
+			 *    page table leading to short copy. Protect against
+			 *    this by instead using an ITER_BVEC created out of
+			 *    the pinned pages.
+			 */
+
+			pinned_pgs = iomap_atomic_write_prep(i, &atomic_iter, &atomic_bvecs,
+							     &pages);
+			if (unlikely(pinned_pgs <= 0)) {
+				status = pinned_pgs;
+				break;
+			}
+
+			if (pinned_pgs << PAGE_SHIFT < bytes) {
+				WARN_RATELIMIT(
+					true,
+					"Couldn't pin bytes for atomic write: pinned: %d, needed: %lld",
+					pinned_pgs << PAGE_SHIFT, bytes);
+				status = -EFAULT;
+				break;
+			}
+
+		} else {
+			/*
+			 * Bring in the user page that we'll copy from _first_.
+			 * Otherwise there's a nasty deadlock on copying from the
+			 * same page as we're writing to, without it being marked
+			 * up-to-date.
+			 *
+			 * For async buffered writes the assumption is that the user
+			 * page has already been faulted in. This can be optimized by
+			 * faulting the user page.
+			 */
+			if (unlikely(fault_in_iov_iter_readable(i, bytes) == bytes)) {
+				status = -EFAULT;
+				break;
+			}
 		}
 
 		status = iomap_write_begin(iter, write_ops, &folio, &offset,
@@ -1086,9 +1191,27 @@ static int iomap_write_iter(struct iomap_iter *iter, struct iov_iter *i,
 		if (mapping_writably_mapped(mapping))
 			flush_dcache_folio(folio);
 
-		copied = copy_folio_from_iter_atomic(folio, offset, bytes, i);
+		copied = copy_folio_from_iter_atomic(
+			folio, offset, bytes, is_atomic ? &atomic_iter : i);
 		written = iomap_write_end(iter, bytes, copied, folio) ?
 			  copied : 0;
+		if (is_atomic) {
+			if (written != bytes) {
+				/*
+				 * short copy so revert the iter accordingly.
+				 * This should never happen ideally
+				 */
+				WARN_RATELIMIT(
+					1,
+					"Short atomic write: bytes_pinned:%d bytes:%lld written:%lld\n",
+					pinned_pgs << PAGE_SHIFT, bytes,
+					written);
+				iov_iter_revert(i,
+						iov_iter_count(&atomic_iter));
+			}
+			iomap_atomic_write_cleanup(&pages, &pinned_pgs,
+						   &atomic_bvecs);
+		}
 
 		/*
 		 * Update the in-memory inode size after copying the data into
@@ -1130,6 +1253,9 @@ static int iomap_write_iter(struct iomap_iter *iter, struct iov_iter *i,
 		}
 	} while (iov_iter_count(i) && iomap_length(iter));
 
+	if (is_atomic)
+		iomap_atomic_write_cleanup(&pages, &pinned_pgs, &atomic_bvecs);
+
 	return total_written ? 0 : status;
 }
 
diff --git a/fs/read_write.c b/fs/read_write.c
index 37546aa40f0d..7e064561cc4b 100644
--- a/fs/read_write.c
+++ b/fs/read_write.c
@@ -1833,17 +1833,6 @@ int generic_atomic_write_valid(struct kiocb *iocb, struct iov_iter *iter)
 		 */
 		if (sb->s_blocksize != PAGE_SIZE)
 			return -EOPNOTSUPP;
-
-		/*
-		 * If the user buffer of atomic write crosses page boundary,
-		 * there's a possibility of short write, example if 1 user page
-		 * could not be faulted or got reclaimed before the copy
-		 * operation. For now don't allow such a scenario by ensuring
-		 * user buffer is page aligned.
-		 */
-		if (!PAGE_ALIGNED(iov_iter_alignment(iter)))
-			return -EOPNOTSUPP;
-
 	}
 
 	return 0;
-- 
2.51.0


