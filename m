Return-Path: <linux-fsdevel+bounces-68052-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7421EC51E5F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Nov 2025 12:20:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 003B13BF61D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Nov 2025 11:11:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 941333115AF;
	Wed, 12 Nov 2025 11:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ft1H6IdC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F011C223339;
	Wed, 12 Nov 2025 11:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762945795; cv=none; b=ecmiTv5MjObgYN7Jc5or6XnaeJUbUA2nTLujNiCO0u5bNUGZR0ddsu3mXWgulvLZPSGJoP7sIvUIzxqRIJB7TXfDFfdD8yP7iub92bzbSIf6IOqFL+Sx+qgByNvpg2WO3AGlfWgmX/Q90H6BQDaIDd9Re84my8OhC98J/TvLbqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762945795; c=relaxed/simple;
	bh=ze9JsHUSaVuZE/v3m1E2642h1kj/aSqb2oZegmCG9Kg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dpYQsApnBex/36zm50oaA/xVZ3KOLW+4VQ7vvA/Tdt8HK39Cz8wlx1wtIoiHv92Ks4Wk0k+Dlm7QrBbP6Fk+khwzjTpne7x/Znqkm1PEFPtPhBxs6+VohRBHFS50bx+eW2MNL/wLU4TQZCFm6ilsdY6HsMjbeGbbxrjA2LProsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ft1H6IdC; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AC6r5H3016772;
	Wed, 12 Nov 2025 11:07:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=bsAaJzZ3vua7fqMSK
	QG3rRqEw9wiAuwDBo4+b/ze2yw=; b=ft1H6IdCKTjrSgAv2uyWMcYt1Qr1ODSVU
	KzOXKraGHsVey+i+h0nZYMMDbM7lS2xOsJf7i9TjknnbRHMU/dz0Shc29DMAi6xz
	N0zZfKGoPYKZgfO596fxbSagBP8lZkB2UgktpPOD+jPoF8463aQ4jhHY+vjkBt+8
	Jnf+RpXgf8ZixrlSadBaWqAA8Gb1VlXrR7uBN9ZlO/wYM7+6VQeozo9dXEjIR8b3
	4YQyRQ2F/NtZNa+7L2gjhvyPHAPHdGdxW9byewwAyJ+DZgBdjWTWoAlNODCRGvgV
	Eaut8nDMMUMn+9uOhngse9HC/m/Z62yNu/REz+KRZ4STuGyjG6Ong==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4aa5cj8u95-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Nov 2025 11:07:24 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5ACB7NE0030193;
	Wed, 12 Nov 2025 11:07:23 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4aa5cj8u92-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Nov 2025 11:07:23 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5AC9lOPh028939;
	Wed, 12 Nov 2025 11:07:22 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4aag6sfwuu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Nov 2025 11:07:22 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5ACB7KKU38666618
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Nov 2025 11:07:20 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9635B20040;
	Wed, 12 Nov 2025 11:07:20 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1A7D62004B;
	Wed, 12 Nov 2025 11:07:16 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.124.210.190])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 12 Nov 2025 11:07:15 +0000 (GMT)
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: Christian Brauner <brauner@kernel.org>, djwong@kernel.org,
        ritesh.list@gmail.com, john.g.garry@oracle.com, tytso@mit.edu,
        willy@infradead.org, dchinner@redhat.com, hch@lst.de
Cc: linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, jack@suse.cz, nilay@linux.ibm.com,
        martin.petersen@oracle.com, rostedt@goodmis.org, axboe@kernel.dk,
        linux-block@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: [RFC PATCH 7/8] iomap: Add bs<ps buffered atomic writes support
Date: Wed, 12 Nov 2025 16:36:10 +0530
Message-ID: <8a836debf47e9bcbf42aeaaa93fd67be18f1768a.1762945505.git.ojaswin@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=Ss+dKfO0 c=1 sm=1 tr=0 ts=69146a6c cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=pGLkceISAAAA:8 a=VnNF1IyMAAAA:8
 a=25xlhPYPnclPhp86LCAA:9 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA4MDA5NSBTYWx0ZWRfX3rFQ8pJuLs29
 jLf5ByegZBHUkX+w8XbkxOOl7++SvznGlgHyGtstC8BVmF9m2mHNvDf/LTwhdocDp40ozfRTqU7
 UtbTGv7a1j12j03JVnBdT75uyxCv99tpBbUc2/G/lbnDEb2dCSo/IQvjtQuBxTs2hPtA4Vi05T0
 4G2XVylSJZtaWwy1IqpQInZJfOMJkoYxwcn3aGlF5nVsLkcBSd9+p7x9GeqajnvNfo6GnXYXD55
 S6cCmlp09R2CZL/PuIilDQYcuIa4rVglz47BjB+SimQ9weKFvdJARUVuUUo4QonnoCDNp3vY1oy
 fgrgoHvjFAqp8yDfS1KgbjQele+Mlrx7g+tqrjrOSNg59szt4k2OWjx5tZWSeGXJQ0wNl/bbP/v
 KXGCppRHTj0k50hmULqLd9FJHF9Xhg==
X-Proofpoint-GUID: QmcSEpiTEmEqJrMbbU2YOwO9U_ioD-Bk
X-Proofpoint-ORIG-GUID: PLXcJglFIgT8Vty1Y9Nq9jokJ9oNFSGO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-12_03,2025-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 impostorscore=0 bulkscore=0 phishscore=0
 lowpriorityscore=0 adultscore=0 priorityscore=1501 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2511080095

Lift bs == ps restriction for RWF_ATOMIC buffered writes by adding
sub-page support. This is done by adding 2 more bitmaps in folio -> ifs.

One bitmap tracks which blocks marks a start of atomic write and the
other tracks which marks the end. For single block atomic write, both
start and end would be marked on the same block, but the design is kept
as such so we can easily extend to multi block later.

With the help of the 2 bitmaps, we are able to determine which blocks
needs to go atomically together during writeback. This prevents the
issue where write amplification could cause an RWF_ATOMIC write which is
bigger than supported by the underlying device.

As with bs == ps support, if there is a non atomic write that overlaps
an atomic marked block, we will clear the atomic state of that block
in ifs. Similarly, if the folio is mmapd and written to, we will clear
atomic bit from all blocks in the folio.

To illustrate some examples:

A = Dirty, atomic block
D = Dirty, non-atomic block
Let pagesize = 4k, blocksize = 1k

1)
- Initial state of blocks in folio: A A D D
- Non atomic write from block 0 to 3
- New state: D D D D

2)
- Initial state of blocks in folio: A A A A
- Non atomic write from block 1 to 2
- New state: A D D A

3)
- Initial state of blocks in folio: A A _ _
- mmap write to anyblock in folio
- New state: D D D D

Suggested-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
---
 fs/iomap/buffered-io.c     | 207 ++++++++++++++++++++++++++++++++++---
 fs/iomap/ioend.c           |   9 +-
 fs/iomap/trace.h           |  12 ++-
 fs/read_write.c            |  22 ----
 include/linux/iomap.h      |   1 +
 include/linux/page-flags.h |   2 +-
 6 files changed, 207 insertions(+), 46 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index e7dbe9bcb439..d86859728e3b 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -26,6 +26,10 @@ struct iomap_folio_state {
 	 * Each block has two bits in this bitmap:
 	 * Bits [0..blocks_per_folio) has the uptodate status.
 	 * Bits [b_p_f...(2*b_p_f))   has the dirty status.
+	 * Bits [2*b_p_f..3*b_p_f)    has whether block marks the
+	 *			      start of an RWF_ATOMIC write
+	 * Bits [3*b_p_f..4*b_p_f)    has whether block marks the
+	 *			      end of an RWF_ATOMIC write
 	 */
 	unsigned long		state[];
 };
@@ -76,6 +80,25 @@ static void iomap_set_range_uptodate(struct folio *folio, size_t off,
 		folio_mark_uptodate(folio);
 }
 
+static inline bool ifs_block_is_atomic_start(struct folio *folio,
+				      struct iomap_folio_state *ifs, int block)
+{
+	struct inode *inode = folio->mapping->host;
+	unsigned int blks_per_folio = i_blocks_per_folio(inode, folio);
+
+	return test_bit(block + (blks_per_folio * 2), ifs->state);
+}
+
+static inline bool ifs_block_is_atomic_end(struct folio *folio,
+					     struct iomap_folio_state *ifs,
+					     int block)
+{
+	struct inode *inode = folio->mapping->host;
+	unsigned int blks_per_folio = i_blocks_per_folio(inode, folio);
+
+	return test_bit(block + (blks_per_folio * 3), ifs->state);
+}
+
 static inline bool ifs_block_is_dirty(struct folio *folio,
 		struct iomap_folio_state *ifs, int block)
 {
@@ -85,17 +108,42 @@ static inline bool ifs_block_is_dirty(struct folio *folio,
 	return test_bit(block + blks_per_folio, ifs->state);
 }
 
+/*
+ * Returns false if the folio has atleast 1 atomic block, else true
+ */
+static inline bool ifs_is_fully_non_atomic(struct folio *folio,
+					   struct iomap_folio_state *ifs)
+{
+	struct inode *inode = folio->mapping->host;
+	unsigned int blks_per_folio = i_blocks_per_folio(inode, folio);
+
+	for (int i = 0; i < blks_per_folio; i++) {
+		if (ifs_block_is_atomic_start(folio, ifs, i))
+			return false;
+	}
+
+	return true;
+}
+
 static unsigned ifs_find_dirty_range(struct folio *folio,
-		struct iomap_folio_state *ifs, u64 *range_start, u64 range_end)
+				     struct iomap_folio_state *ifs,
+				     u64 *range_start, u64 range_end,
+				     bool *is_atomic_range)
 {
 	struct inode *inode = folio->mapping->host;
+	unsigned folio_nblks = i_blocks_per_folio(inode, folio);
 	unsigned start_blk =
 		offset_in_folio(folio, *range_start) >> inode->i_blkbits;
 	unsigned end_blk = min_not_zero(
 		offset_in_folio(folio, range_end) >> inode->i_blkbits,
-		i_blocks_per_folio(inode, folio));
+		folio_nblks);
 	unsigned nblks = 1;
+	bool is_atomic_folio = folio_test_atomic(folio);
 
+	/*
+	 * We need to be careful in not clubbing together atomic write ranges
+	 * with other dirty blocks
+	 */
 	while (!ifs_block_is_dirty(folio, ifs, start_blk))
 		if (++start_blk == end_blk)
 			return 0;
@@ -106,12 +154,62 @@ static unsigned ifs_find_dirty_range(struct folio *folio,
 		nblks++;
 	}
 
+	*is_atomic_range = false;
+
+	if (is_atomic_folio) {
+		unsigned int first_atomic;
+		unsigned int last = start_blk + nblks;
+		/*
+		 * We now have the dirty range, however if the range has any
+		 * RWF_ATOMIC blocks, we need to make sure to not club them with
+		 * other dirty blocks.
+		 */
+		first_atomic = start_blk;
+		while (!ifs_block_is_atomic_start(folio, ifs, first_atomic)) {
+			if (++first_atomic == start_blk + nblks)
+				break;
+		}
+
+		if (first_atomic != start_blk + nblks) {
+			/* RWF_ATOMIC blocks found in dirty range */
+			if (first_atomic == start_blk) {
+				/*
+				 * range start is RWF_ATOMIC. Return only the
+				 * atomic range.
+				 */
+				nblks = 0;
+				while (first_atomic + nblks < last) {
+					if (ifs_block_is_atomic_end(
+						    folio, ifs,
+						    first_atomic + nblks++))
+						break;
+				}
+
+				if (first_atomic + nblks > last)
+					/*
+					 * RWF_ATOMIC range should
+					 * always be contained in the
+					 * dirty range
+					 */
+					WARN_ON(true);
+
+				*is_atomic_range = true;
+			} else {
+				/*
+				 * RWF_ATOMIC range is in middle of dirty range. Return only
+				 * the starting non-RWF_ATOMIC range
+				 */
+				nblks = first_atomic - start_blk;
+			}
+		}
+	}
+
 	*range_start = folio_pos(folio) + (start_blk << inode->i_blkbits);
 	return nblks << inode->i_blkbits;
 }
 
 static unsigned iomap_find_dirty_range(struct folio *folio, u64 *range_start,
-		u64 range_end)
+		u64 range_end, bool *is_atomic_range)
 {
 	struct iomap_folio_state *ifs = folio->private;
 
@@ -119,10 +217,33 @@ static unsigned iomap_find_dirty_range(struct folio *folio, u64 *range_start,
 		return 0;
 
 	if (ifs)
-		return ifs_find_dirty_range(folio, ifs, range_start, range_end);
+		return ifs_find_dirty_range(folio, ifs, range_start, range_end,
+					    is_atomic_range);
+
+	if (folio_test_atomic(folio))
+		*is_atomic_range = true;
+
 	return range_end - *range_start;
 }
 
+static bool ifs_clear_range_atomic(struct folio *folio,
+		struct iomap_folio_state *ifs, size_t off, size_t len)
+{
+	struct inode *inode = folio->mapping->host;
+	unsigned int blks_per_folio = i_blocks_per_folio(inode, folio);
+	unsigned int first_blk = (off >> inode->i_blkbits);
+	unsigned int last_blk = (off + len - 1) >> inode->i_blkbits;
+	unsigned int nr_blks = last_blk - first_blk + 1;
+	unsigned long flags;
+
+	spin_lock_irqsave(&ifs->state_lock, flags);
+	bitmap_clear(ifs->state, first_blk + (blks_per_folio * 2), nr_blks);
+	bitmap_clear(ifs->state, last_blk + (blks_per_folio * 3), nr_blks);
+	spin_unlock_irqrestore(&ifs->state_lock, flags);
+
+	return ifs_is_fully_non_atomic(folio, ifs);
+}
+
 static void ifs_clear_range_dirty(struct folio *folio,
 		struct iomap_folio_state *ifs, size_t off, size_t len)
 {
@@ -138,6 +259,18 @@ static void ifs_clear_range_dirty(struct folio *folio,
 	spin_unlock_irqrestore(&ifs->state_lock, flags);
 }
 
+static void iomap_clear_range_atomic(struct folio *folio, size_t off, size_t len)
+{
+	struct iomap_folio_state *ifs = folio->private;
+	bool fully_non_atomic = true;
+
+	if (ifs)
+		fully_non_atomic = ifs_clear_range_atomic(folio, ifs, off, len);
+
+	if (fully_non_atomic)
+		folio_clear_atomic(folio);
+}
+
 static void iomap_clear_range_dirty(struct folio *folio, size_t off, size_t len)
 {
 	struct iomap_folio_state *ifs = folio->private;
@@ -146,8 +279,34 @@ static void iomap_clear_range_dirty(struct folio *folio, size_t off, size_t len)
 		ifs_clear_range_dirty(folio, ifs, off, len);
 }
 
-static void ifs_set_range_dirty(struct folio *folio,
+static void ifs_set_range_atomic(struct folio *folio,
 		struct iomap_folio_state *ifs, size_t off, size_t len)
+{
+	struct inode *inode = folio->mapping->host;
+	unsigned int blks_per_folio = i_blocks_per_folio(inode, folio);
+	unsigned int first_blk = (off >> inode->i_blkbits);
+	unsigned int last_blk = (off + len - 1) >> inode->i_blkbits;
+	unsigned long flags;
+
+	spin_lock_irqsave(&ifs->state_lock, flags);
+	bitmap_set(ifs->state, first_blk + (blks_per_folio * 2), 1);
+	bitmap_set(ifs->state, last_blk + (blks_per_folio * 3), 1);
+	spin_unlock_irqrestore(&ifs->state_lock, flags);
+}
+
+static void iomap_set_range_atomic(struct folio *folio, size_t off, size_t len)
+{
+	struct iomap_folio_state *ifs = folio->private;
+
+	if (ifs)
+		ifs_set_range_atomic(folio, ifs, off, len);
+
+	folio_set_atomic(folio);
+}
+
+static void ifs_set_range_dirty(struct folio *folio,
+				struct iomap_folio_state *ifs, size_t off,
+				size_t len)
 {
 	struct inode *inode = folio->mapping->host;
 	unsigned int blks_per_folio = i_blocks_per_folio(inode, folio);
@@ -190,8 +349,12 @@ static struct iomap_folio_state *ifs_alloc(struct inode *inode,
 	 * The first state tracks per-block uptodate and the
 	 * second tracks per-block dirty state.
 	 */
+
+	/*
+	 * TODO: How can we only selectively allocate atomic bitmaps for ifs?
+	 */
 	ifs = kzalloc(struct_size(ifs, state,
-		      BITS_TO_LONGS(2 * nr_blocks)), gfp);
+		      BITS_TO_LONGS(4 * nr_blocks)), gfp);
 	if (!ifs)
 		return ifs;
 
@@ -941,6 +1104,8 @@ static int iomap_write_begin(struct iomap_iter *iter,
 static bool __iomap_write_end(struct iomap_iter *iter, loff_t pos, size_t len,
 		size_t copied, struct folio *folio)
 {
+	struct inode *inode = iter->inode;
+
 	flush_dcache_folio(folio);
 
 	/*
@@ -975,9 +1140,12 @@ static bool __iomap_write_end(struct iomap_iter *iter, loff_t pos, size_t len,
 
 			return false;
 		}
-		folio_set_atomic(folio);
-	} else
-		folio_clear_atomic(folio);
+		iomap_set_range_atomic(folio, offset_in_folio(folio, pos), len);
+	} else {
+		if (folio_test_atomic(folio))
+			iomap_clear_range_atomic(
+				folio, offset_in_folio(folio, pos), len);
+	}
 
 	return true;
 }
@@ -1208,7 +1376,11 @@ static int iomap_write_iter(struct iomap_iter *iter, struct iov_iter *i,
 					written);
 				iov_iter_revert(i,
 						iov_iter_count(&atomic_iter));
-			}
+			} else
+				iomap_set_range_atomic(
+					folio, offset_in_folio(folio, pos),
+					written);
+
 			iomap_atomic_write_cleanup(&pages, &pinned_pgs,
 						   &atomic_bvecs);
 		}
@@ -1743,7 +1915,7 @@ static int iomap_folio_mkwrite_iter(struct iomap_iter *iter,
 	} else {
 		WARN_ON_ONCE(!folio_test_uptodate(folio));
 		folio_mark_dirty(folio);
-		folio_clear_atomic(folio);
+		iomap_clear_range_atomic(folio, 0, folio_size(folio));
 	}
 
 	return iomap_iter_advance(iter, length);
@@ -1799,7 +1971,7 @@ void iomap_finish_folio_write(struct inode *inode, struct folio *folio,
 	WARN_ON_ONCE(ifs && atomic_read(&ifs->write_bytes_pending) <= 0);
 
 	if (!ifs || atomic_sub_and_test(len, &ifs->write_bytes_pending)) {
-		folio_clear_atomic(folio);
+		iomap_clear_range_atomic(folio, 0, folio_size(folio));
 		folio_end_writeback(folio);
 	}
 }
@@ -1914,6 +2086,8 @@ int iomap_writeback_folio(struct iomap_writepage_ctx *wpc, struct folio *folio)
 		if (!ifs) {
 			ifs = ifs_alloc(inode, folio, 0);
 			iomap_set_range_dirty(folio, 0, end_pos - pos);
+			if (folio_test_atomic(folio))
+				iomap_set_range_atomic(folio, 0, end_pos - pos);
 		}
 
 		/*
@@ -1936,7 +2110,8 @@ int iomap_writeback_folio(struct iomap_writepage_ctx *wpc, struct folio *folio)
 	 * Walk through the folio to find dirty areas to write back.
 	 */
 	end_aligned = round_up(end_pos, i_blocksize(inode));
-	while ((rlen = iomap_find_dirty_range(folio, &pos, end_aligned))) {
+	while ((rlen = iomap_find_dirty_range(folio, &pos, end_aligned,
+					      &wpc->is_atomic_range))) {
 		error = iomap_writeback_range(wpc, folio, pos, rlen, end_pos,
 				&wb_pending);
 		if (error)
@@ -1962,11 +2137,13 @@ int iomap_writeback_folio(struct iomap_writepage_ctx *wpc, struct folio *folio)
 	 * bit ourselves right after unlocking the page.
 	 */
 	if (ifs) {
-		if (atomic_dec_and_test(&ifs->write_bytes_pending))
+		if (atomic_dec_and_test(&ifs->write_bytes_pending)) {
+			iomap_clear_range_atomic(folio, 0, folio_size(folio));
 			folio_end_writeback(folio);
+		}
 	} else {
 		if (!wb_pending) {
-			folio_clear_atomic(folio);
+			iomap_clear_range_atomic(folio, 0, folio_size(folio));
 			folio_end_writeback(folio);
 		}
 	}
diff --git a/fs/iomap/ioend.c b/fs/iomap/ioend.c
index c129a695ceca..678c052c6443 100644
--- a/fs/iomap/ioend.c
+++ b/fs/iomap/ioend.c
@@ -163,10 +163,10 @@ ssize_t iomap_add_to_ioend(struct iomap_writepage_ctx *wpc, struct folio *folio,
 	unsigned int ioend_flags = 0;
 	unsigned int map_len = min_t(u64, dirty_len,
 		wpc->iomap.offset + wpc->iomap.length - pos);
-	bool is_atomic = folio_test_atomic(folio);
 	int error;
 
-	trace_iomap_add_to_ioend(wpc->inode, pos, dirty_len, &wpc->iomap);
+	trace_iomap_add_to_ioend(wpc->inode, pos, dirty_len, &wpc->iomap,
+				 wpc->is_atomic_range);
 
 	WARN_ON_ONCE(!folio->private && map_len < dirty_len);
 
@@ -188,7 +188,7 @@ ssize_t iomap_add_to_ioend(struct iomap_writepage_ctx *wpc, struct folio *folio,
 		ioend_flags |= IOMAP_IOEND_DONTCACHE;
 	if (pos == wpc->iomap.offset && (wpc->iomap.flags & IOMAP_F_BOUNDARY))
 		ioend_flags |= IOMAP_IOEND_BOUNDARY;
-	if (is_atomic)
+	if (wpc->is_atomic_range)
 		ioend_flags |= IOMAP_IOEND_ATOMIC;
 
 	if (!ioend || !iomap_can_add_to_ioend(wpc, pos, ioend_flags)) {
@@ -198,7 +198,8 @@ ssize_t iomap_add_to_ioend(struct iomap_writepage_ctx *wpc, struct folio *folio,
 			if (error)
 				return error;
 		}
-		wpc->wb_ctx = ioend = iomap_alloc_ioend(wpc, pos, ioend_flags, is_atomic);
+		wpc->wb_ctx = ioend = iomap_alloc_ioend(wpc, pos, ioend_flags,
+							wpc->is_atomic_range);
 	}
 
 	if (!bio_add_folio(&ioend->io_bio, folio, map_len, poff))
diff --git a/fs/iomap/trace.h b/fs/iomap/trace.h
index a61c1dae4742..14ad280c03fe 100644
--- a/fs/iomap/trace.h
+++ b/fs/iomap/trace.h
@@ -172,8 +172,8 @@ DEFINE_IOMAP_EVENT(iomap_iter_srcmap);
 
 TRACE_EVENT(iomap_add_to_ioend,
 	TP_PROTO(struct inode *inode, u64 pos, unsigned int dirty_len,
-		 struct iomap *iomap),
-	TP_ARGS(inode, pos, dirty_len, iomap),
+		 struct iomap *iomap, bool is_atomic),
+	TP_ARGS(inode, pos, dirty_len, iomap, is_atomic),
 	TP_STRUCT__entry(
 		__field(dev_t, dev)
 		__field(u64, ino)
@@ -185,6 +185,7 @@ TRACE_EVENT(iomap_add_to_ioend,
 		__field(u16, type)
 		__field(u16, flags)
 		__field(dev_t, bdev)
+		__field(bool, is_atomic)
 	),
 	TP_fast_assign(
 		__entry->dev = inode->i_sb->s_dev;
@@ -197,9 +198,11 @@ TRACE_EVENT(iomap_add_to_ioend,
 		__entry->type = iomap->type;
 		__entry->flags = iomap->flags;
 		__entry->bdev = iomap->bdev ? iomap->bdev->bd_dev : 0;
+		__entry->is_atomic = is_atomic;
 	),
 	TP_printk("dev %d:%d ino 0x%llx bdev %d:%d pos 0x%llx dirty len 0x%llx "
-		  "addr 0x%llx offset 0x%llx length 0x%llx type %s (0x%x) flags %s (0x%x)",
+		  "addr 0x%llx offset 0x%llx length 0x%llx type %s (0x%x) flags %s (0x%x) "
+		  "is_atomic=%d",
 		  MAJOR(__entry->dev), MINOR(__entry->dev),
 		  __entry->ino,
 		  MAJOR(__entry->bdev), MINOR(__entry->bdev),
@@ -211,7 +214,8 @@ TRACE_EVENT(iomap_add_to_ioend,
 		  __print_symbolic(__entry->type, IOMAP_TYPE_STRINGS),
 		  __entry->type,
 		  __print_flags(__entry->flags, "|", IOMAP_F_FLAGS_STRINGS),
-		  __entry->flags)
+		  __entry->flags,
+		  __entry->is_atomic)
 );
 
 TRACE_EVENT(iomap_iter,
diff --git a/fs/read_write.c b/fs/read_write.c
index 7e064561cc4b..ab5d8e17d86d 100644
--- a/fs/read_write.c
+++ b/fs/read_write.c
@@ -1802,8 +1802,6 @@ int generic_file_rw_checks(struct file *file_in, struct file *file_out)
 
 int generic_atomic_write_valid(struct kiocb *iocb, struct iov_iter *iter)
 {
-	struct super_block *sb = iocb->ki_filp->f_mapping->host->i_sb;
-
 	size_t len = iov_iter_count(iter);
 
 	if (!iter_is_ubuf(iter))
@@ -1815,26 +1813,6 @@ int generic_atomic_write_valid(struct kiocb *iocb, struct iov_iter *iter)
 	if (!IS_ALIGNED(iocb->ki_pos, len))
 		return -EINVAL;
 
-	if (!(iocb->ki_flags & IOCB_DIRECT)) {
-		/* Some restrictions to buferred IO */
-
-		/*
-		 * We only support block size == page size
-		 * right now. This is to avoid the following:
-		 * 1. 4kb block atomic write marks the complete 64kb folio as
-		 *    atomic.
-		 * 2. Other writes, dirty the whole 64kb folio.
-		 * 3. Writeback sees the whole folio dirty and atomic and tries
-		 *    to send a 64kb atomic write, which might exceed the
-		 *    allowed size and fail.
-		 *
-		 * Once we support sub-page atomic write tracking, we can remove
-		 * this restriction.
-		 */
-		if (sb->s_blocksize != PAGE_SIZE)
-			return -EOPNOTSUPP;
-	}
-
 	return 0;
 }
 EXPORT_SYMBOL_GPL(generic_atomic_write_valid);
diff --git a/include/linux/iomap.h b/include/linux/iomap.h
index 693f3e5ad03c..033e0ba49f85 100644
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@ -460,6 +460,7 @@ struct iomap_writepage_ctx {
 	const struct iomap_writeback_ops *ops;
 	u32			nr_folios;	/* folios added to the ioend */
 	void			*wb_ctx;	/* pending writeback context */
+	bool			is_atomic_range;
 };
 
 struct iomap_ioend *iomap_init_ioend(struct inode *inode, struct bio *bio,
diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
index bdce0f58a77a..542e7db6b21b 100644
--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -111,7 +111,7 @@ enum pageflags {
 	PG_swapbacked,		/* Page is backed by RAM/swap */
 	PG_unevictable,		/* Page is "unevictable"  */
 	PG_dropbehind,		/* drop pages on IO completion */
-	PG_atomic,		/* Page is marked atomic for buffered atomic writes */
+	PG_atomic,		/* Atlease 1 block in page is marked atomic for buffered atomic writes */
 #ifdef CONFIG_MMU
 	PG_mlocked,		/* Page is vma mlocked */
 #endif
-- 
2.51.0


