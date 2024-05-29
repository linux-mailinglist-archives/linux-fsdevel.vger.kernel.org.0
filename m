Return-Path: <linux-fsdevel+bounces-20387-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ABA68D2A30
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 May 2024 03:59:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0EFE01F2857D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 May 2024 01:59:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1C9E15ADB8;
	Wed, 29 May 2024 01:59:23 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F21715AAD3;
	Wed, 29 May 2024 01:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716947963; cv=none; b=oM6G1pfP3iSuyDc2xbEmJ4fUx0Qs04Hfhh/GJzp0X2vCnjobOsMcqACPRBdrMwlnfRLnT6FC/eRYusHCj4HbsbBRDyxl46IpYEmSjDvLyrkOfAxPmQL+GwF57+dyuDZ3Piiq69c7cNs7+HVNLTi3CY9qvQGK797Nc4nr8vN2Uo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716947963; c=relaxed/simple;
	bh=ZPd2UeBEpFRgj9By0wN9CnpgHq7DsoertVp62L+G5Cg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=q0KG0qT3zNogdpX7ZQ49+MXgnU7QJlE7lHnpn6pZvUZTaZKjfJ1vxPM17zEP4NpWo+VJ00+QW+1DnUZy42WksEgksgpe8GHP3gekJ/Nv+8M3zjmJ7fRJdImou8cu37WWR7O75bFe/lJHTmuNuKIjUGhUA3EbCSNYI+7J4lTI8Kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Vpsxq3LgKz4f3m8m;
	Wed, 29 May 2024 09:59:11 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 7DC4E1A0187;
	Wed, 29 May 2024 09:59:17 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP1 (Coremail) with SMTP id cCh0CgAn9g7wi1Zmr3XbNw--.12147S5;
	Wed, 29 May 2024 09:59:17 +0800 (CST)
From: Zhang Yi <yi.zhang@huaweicloud.com>
To: linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	djwong@kernel.org,
	hch@infradead.org,
	brauner@kernel.org,
	david@fromorbit.com,
	chandanbabu@kernel.org,
	jack@suse.cz,
	willy@infradead.org,
	yi.zhang@huawei.com,
	yi.zhang@huaweicloud.com,
	chengzhihao1@huawei.com,
	yukuai3@huawei.com
Subject: [RFC PATCH v4 1/8] iomap: zeroing needs to be pagecache aware
Date: Wed, 29 May 2024 17:51:59 +0800
Message-Id: <20240529095206.2568162-2-yi.zhang@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240529095206.2568162-1-yi.zhang@huaweicloud.com>
References: <20240529095206.2568162-1-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgAn9g7wi1Zmr3XbNw--.12147S5
X-Coremail-Antispam: 1UD129KBjvJXoWxtw4xGF48KrW7tw17Jr1rtFb_yoWxZry8pr
	y3KFsrCr4xJ3W7JFn3AFyjvr1Fk3s5AF47Cw13G3sav3Z5AF1rKF18Ga109rWUGFWrJr1a
	yr40y34j9rykAaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUmlb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M280x2IEY4vEnII2IxkI6r1a6r45M2
	8IrcIa0xkI8VA2jI8067AKxVWUGwA2048vs2IY020Ec7CjxVAFwI0_Gr0_Xr1l8cAvFVAK
	0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4
	x0Y4vE2Ix0cI8IcVCY1x0267AKxVWxJr0_GcWl84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2
	z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4
	xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE14v2
	6r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6I
	AqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l42xK82IYc2Ij64vIr41l4I8I3I0E
	4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGV
	WUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_
	Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rV
	WUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4U
	JbIYCTnIWIevJa73UjIFyTuYvjTRLmi_UUUUU
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

From: Dave Chinner <dchinner@redhat.com>

Unwritten extents can have page cache data over the range being
zeroed so we can't just skip them entirely. Fix this by checking for
an existing dirty folio over the unwritten range we are zeroing
and only performing zeroing if the folio is already dirty.

XXX: how do we detect a iomap containing a cow mapping over a hole
in iomap_zero_iter()? The XFS code implies this case also needs to
zero the page cache if there is data present, so trigger for page
cache lookup only in iomap_zero_iter() needs to handle this case as
well.

Before:

$ time sudo ./pwrite-trunc /mnt/scratch/foo 50000
path /mnt/scratch/foo, 50000 iters

real    0m14.103s
user    0m0.015s
sys     0m0.020s

$ sudo strace -c ./pwrite-trunc /mnt/scratch/foo 50000
path /mnt/scratch/foo, 50000 iters
% time     seconds  usecs/call     calls    errors syscall
------ ----------- ----------- --------- --------- ----------------
 85.90    0.847616          16     50000           ftruncate
 14.01    0.138229           2     50000           pwrite64
....

After:

$ time sudo ./pwrite-trunc /mnt/scratch/foo 50000
path /mnt/scratch/foo, 50000 iters

real    0m0.144s
user    0m0.021s
sys     0m0.012s

$ sudo strace -c ./pwrite-trunc /mnt/scratch/foo 50000
path /mnt/scratch/foo, 50000 iters
% time     seconds  usecs/call     calls    errors syscall
------ ----------- ----------- --------- --------- ----------------
 53.86    0.505964          10     50000           ftruncate
 46.12    0.433251           8     50000           pwrite64
....

Yup, we get back all the performance.

As for the "mmap write beyond EOF" data exposure aspect
documented here:

https://lore.kernel.org/linux-xfs/20221104182358.2007475-1-bfoster@redhat.com/

With this command:

$ sudo xfs_io -tfc "falloc 0 1k" -c "pwrite 0 1k" \
  -c "mmap 0 4k" -c "mwrite 3k 1k" -c "pwrite 32k 4k" \
  -c fsync -c "pread -v 3k 32" /mnt/scratch/foo

Before:

wrote 1024/1024 bytes at offset 0
1 KiB, 1 ops; 0.0000 sec (34.877 MiB/sec and 35714.2857 ops/sec)
wrote 4096/4096 bytes at offset 32768
4 KiB, 1 ops; 0.0000 sec (229.779 MiB/sec and 58823.5294 ops/sec)
00000c00:  58 58 58 58 58 58 58 58 58 58 58 58 58 58 58 58
XXXXXXXXXXXXXXXX
00000c10:  58 58 58 58 58 58 58 58 58 58 58 58 58 58 58 58
XXXXXXXXXXXXXXXX
read 32/32 bytes at offset 3072
32.000000 bytes, 1 ops; 0.0000 sec (568.182 KiB/sec and 18181.8182
   ops/sec

After:

wrote 1024/1024 bytes at offset 0
1 KiB, 1 ops; 0.0000 sec (40.690 MiB/sec and 41666.6667 ops/sec)
wrote 4096/4096 bytes at offset 32768
4 KiB, 1 ops; 0.0000 sec (150.240 MiB/sec and 38461.5385 ops/sec)
00000c00:  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
................
00000c10:  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
................
read 32/32 bytes at offset 3072
32.000000 bytes, 1 ops; 0.0000 sec (558.036 KiB/sec and 17857.1429
   ops/sec)

We see that this post-eof unwritten extent dirty page zeroing is
working correctly.

This has passed through most of fstests on a couple of test VMs
without issues at the moment, so I think this approach to fixing the
issue is going to be solid once we've worked out how to detect the
COW-hole mapping case.

Signed-off-by: Dave Chinner <dchinner@redhat.com>
---
 fs/iomap/buffered-io.c | 42 ++++++++++++++++++++++++++++++++++++++++--
 fs/xfs/xfs_iops.c      | 12 +-----------
 2 files changed, 41 insertions(+), 13 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 41c8f0c68ef5..a3a5d4eb7289 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -583,11 +583,23 @@ EXPORT_SYMBOL_GPL(iomap_is_partially_uptodate);
  *
  * Returns a locked reference to the folio at @pos, or an error pointer if the
  * folio could not be obtained.
+ *
+ * Note: when zeroing unwritten extents, we might have data in the page cache
+ * over an unwritten extent. In this case, we want to do a pure lookup on the
+ * page cache and not create a new folio as we don't need to perform zeroing on
+ * unwritten extents if there is no cached data over the given range.
  */
 struct folio *iomap_get_folio(struct iomap_iter *iter, loff_t pos, size_t len)
 {
 	fgf_t fgp = FGP_WRITEBEGIN | FGP_NOFS;
 
+	if (iter->flags & IOMAP_ZERO) {
+		const struct iomap *srcmap = iomap_iter_srcmap(iter);
+
+		if (srcmap->type == IOMAP_UNWRITTEN)
+			fgp &= ~FGP_CREAT;
+	}
+
 	if (iter->flags & IOMAP_NOWAIT)
 		fgp |= FGP_NOWAIT;
 	fgp |= fgf_set_order(len);
@@ -1388,7 +1400,7 @@ static loff_t iomap_zero_iter(struct iomap_iter *iter, bool *did_zero)
 	loff_t written = 0;
 
 	/* already zeroed?  we're done. */
-	if (srcmap->type == IOMAP_HOLE || srcmap->type == IOMAP_UNWRITTEN)
+	if (srcmap->type == IOMAP_HOLE)
 		return length;
 
 	do {
@@ -1399,8 +1411,22 @@ static loff_t iomap_zero_iter(struct iomap_iter *iter, bool *did_zero)
 		bool ret;
 
 		status = iomap_write_begin(iter, pos, bytes, &folio);
-		if (status)
+		if (status) {
+			if (status == -ENOENT) {
+				/*
+				 * Unwritten extents need to have page cache
+				 * lookups done to determine if they have data
+				 * over them that needs zeroing. If there is no
+				 * data, we'll get -ENOENT returned here, so we
+				 * can just skip over this index.
+				 */
+				WARN_ON_ONCE(srcmap->type != IOMAP_UNWRITTEN);
+				if (bytes > PAGE_SIZE - offset_in_page(pos))
+					bytes = PAGE_SIZE - offset_in_page(pos);
+				goto loop_continue;
+			}
 			return status;
+		}
 		if (iter->iomap.flags & IOMAP_F_STALE)
 			break;
 
@@ -1408,6 +1434,17 @@ static loff_t iomap_zero_iter(struct iomap_iter *iter, bool *did_zero)
 		if (bytes > folio_size(folio) - offset)
 			bytes = folio_size(folio) - offset;
 
+		/*
+		 * If the folio over an unwritten extent is clean (i.e. because
+		 * it has been read from), then it already contains zeros. Hence
+		 * we can just skip it.
+		 */
+		if (srcmap->type == IOMAP_UNWRITTEN &&
+		    !folio_test_dirty(folio)) {
+			folio_unlock(folio);
+			goto loop_continue;
+		}
+
 		folio_zero_range(folio, offset, bytes);
 		folio_mark_accessed(folio);
 
@@ -1416,6 +1453,7 @@ static loff_t iomap_zero_iter(struct iomap_iter *iter, bool *did_zero)
 		if (WARN_ON_ONCE(!ret))
 			return -EIO;
 
+loop_continue:
 		pos += bytes;
 		length -= bytes;
 		written += bytes;
diff --git a/fs/xfs/xfs_iops.c b/fs/xfs/xfs_iops.c
index ff222827e550..d44508930b67 100644
--- a/fs/xfs/xfs_iops.c
+++ b/fs/xfs/xfs_iops.c
@@ -861,17 +861,7 @@ xfs_setattr_size(
 		trace_xfs_zero_eof(ip, oldsize, newsize - oldsize);
 		error = xfs_zero_range(ip, oldsize, newsize - oldsize,
 				&did_zeroing);
-	} else {
-		/*
-		 * iomap won't detect a dirty page over an unwritten block (or a
-		 * cow block over a hole) and subsequently skips zeroing the
-		 * newly post-EOF portion of the page. Flush the new EOF to
-		 * convert the block before the pagecache truncate.
-		 */
-		error = filemap_write_and_wait_range(inode->i_mapping, newsize,
-						     newsize);
-		if (error)
-			return error;
+	} else if (newsize != oldsize) {
 		error = xfs_truncate_page(ip, newsize, &did_zeroing);
 	}
 
-- 
2.39.2


