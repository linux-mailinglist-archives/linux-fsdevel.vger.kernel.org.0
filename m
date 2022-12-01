Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 563E463E6B3
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Dec 2022 01:52:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229610AbiLAAwV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 30 Nov 2022 19:52:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbiLAAwU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 30 Nov 2022 19:52:20 -0500
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3F2169324
        for <linux-fsdevel@vger.kernel.org>; Wed, 30 Nov 2022 16:52:18 -0800 (PST)
Received: by mail-pf1-x434.google.com with SMTP id r7so370072pfl.11
        for <linux-fsdevel@vger.kernel.org>; Wed, 30 Nov 2022 16:52:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SYKYdxyKPtZTuclEa/DlBvagxLBIJj6S+cE59VjlIW4=;
        b=EdOXDSlaMLmGfZfVvKqM/WCE1lzER3Nbdcab6XA2yfly3+D+dyWiRaSCAiXKTGqhaw
         j50t2DyiwR4Ka9Z+eS0Kidvaa9rsWjES1/BfUL0MawrEkgZVOacn+hVIfW7PuNHMM5/d
         eWL34IQcRbZEZ/HMbpnjYVAyNSdGs+6Vbh5FhEMXCga1dp18sunnmlPxuFkcGgockm9B
         S3MzALAClyXv6FyGgUge0ODGLrMXJVYNqPJETM+OU8EuOl/3++tUDKx9JZPN7OyROH3x
         vBZDKhkD/w9uCUmIaCNpMkYQ2nfAiQxs54C+Ilwfj9VrP6LRZnmhAaTzCUq+BV02A/C6
         K/IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SYKYdxyKPtZTuclEa/DlBvagxLBIJj6S+cE59VjlIW4=;
        b=t9PWY5FtHlnFGPvTn3OwG/YoMdkbegONVyBAYb41uVGvWqNjxmtUHxxzSGS8f3xb4h
         nNpcMbDgDPrupolBZxzA7aMCrqvPfUMSfhubMZzffRrkJFDyvXXs8uG33gSqNurT125d
         Un8ZwrIibp7SF/Jm3HCXdCngQ74r7WYX6qlRljDGAq8MhIEFMnzqFnBg4XPqR574l4Tp
         I6U4ThThJPePhqh2one7GLgjEY5FozEJrHqfIonGG+5H+mhzE2mcQ/w4NtoJoNucAO1m
         YSc5UDnDqWMWSRW6Sk6hReGcD+49ilNjHkBtyDW9lcOFQCjbCK7zSL67xTLfxquecb5P
         nmzA==
X-Gm-Message-State: ANoB5pkPAbY7SSRoSaroVrrgqJF+an4JDJGoPt+6ivIM7ZpY37b+iGTh
        sUWIMFU6dO5DbB87gQjJHJk9CqGG4Pkxeg==
X-Google-Smtp-Source: AA0mqf4O/QT60/7hyCo7rh/KmIHdvsC/6Adn7BSyljx6Ci6c/z3NzIAWHuJG4Zx/1Uw6YGSfm1Ev6A==
X-Received: by 2002:a63:d34e:0:b0:477:650a:705c with SMTP id u14-20020a63d34e000000b00477650a705cmr37659008pgi.588.1669855938239;
        Wed, 30 Nov 2022 16:52:18 -0800 (PST)
Received: from dread.disaster.area (pa49-186-65-106.pa.vic.optusnet.com.au. [49.186.65.106])
        by smtp.gmail.com with ESMTPSA id 3-20020a631543000000b0044ed37dbca8sm1504054pgv.2.2022.11.30.16.52.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Nov 2022 16:52:17 -0800 (PST)
Received: from [192.168.253.23] (helo=devoid.disaster.area)
        by dread.disaster.area with esmtp (Exim 4.92.3)
        (envelope-from <dave@fromorbit.com>)
        id 1p0XoE-0031ny-Bx; Thu, 01 Dec 2022 11:52:14 +1100
Received: from dave by devoid.disaster.area with local (Exim 4.96)
        (envelope-from <dave@devoid.disaster.area>)
        id 1p0XoE-00G5ws-0v;
        Thu, 01 Dec 2022 11:52:14 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     linux-xfs@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org
Subject: [PATCH] [RFC] iomap: zeroing needs to be pagecache aware
Date:   Thu,  1 Dec 2022 11:52:14 +1100
Message-Id: <20221201005214.3836105-1-david@fromorbit.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

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
00000c00:  58 58 58 58 58 58 58 58 58 58 58 58 58 58 58 58  XXXXXXXXXXXXXXXX
00000c10:  58 58 58 58 58 58 58 58 58 58 58 58 58 58 58 58  XXXXXXXXXXXXXXXX
read 32/32 bytes at offset 3072
32.000000 bytes, 1 ops; 0.0000 sec (568.182 KiB/sec and 18181.8182 ops/sec

After:

wrote 1024/1024 bytes at offset 0
1 KiB, 1 ops; 0.0000 sec (40.690 MiB/sec and 41666.6667 ops/sec)
wrote 4096/4096 bytes at offset 32768
4 KiB, 1 ops; 0.0000 sec (150.240 MiB/sec and 38461.5385 ops/sec)
00000c00:  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
00000c10:  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
read 32/32 bytes at offset 3072
32.000000 bytes, 1 ops; 0.0000 sec (558.036 KiB/sec and 17857.1429 ops/sec)

We see that this post-eof unwritten extent dirty page zeroing is
working correctly.

This has passed through most of fstests on a couple of test VMs
without issues at the moment, so I think this approach to fixing the
issue is going to be solid once we've worked out how to detect the
COW-hole mapping case.

Signed-off-by: Dave Chinner <dchinner@redhat.com>
---
 fs/iomap/buffered-io.c | 50 +++++++++++++++++++++++++++++++++++-------
 fs/xfs/xfs_iops.c      | 12 +---------
 2 files changed, 43 insertions(+), 19 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 356193e44cf0..0969e4525507 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -585,14 +585,14 @@ static int iomap_write_begin_inline(const struct iomap_iter *iter,
 }
 
 static int iomap_write_begin(struct iomap_iter *iter, loff_t pos,
-		size_t len, struct folio **foliop)
+		size_t len, struct folio **foliop, unsigned fgp)
 {
 	const struct iomap_page_ops *page_ops = iter->iomap.page_ops;
 	const struct iomap *srcmap = iomap_iter_srcmap(iter);
 	struct folio *folio;
-	unsigned fgp = FGP_LOCK | FGP_WRITE | FGP_CREAT | FGP_STABLE | FGP_NOFS;
 	int status = 0;
 
+	fgp |= FGP_LOCK | FGP_WRITE | FGP_STABLE | FGP_NOFS;
 	if (iter->flags & IOMAP_NOWAIT)
 		fgp |= FGP_NOWAIT;
 
@@ -615,7 +615,12 @@ static int iomap_write_begin(struct iomap_iter *iter, loff_t pos,
 	folio = __filemap_get_folio(iter->inode->i_mapping, pos >> PAGE_SHIFT,
 			fgp, mapping_gfp_mask(iter->inode->i_mapping));
 	if (!folio) {
-		status = (iter->flags & IOMAP_NOWAIT) ? -EAGAIN : -ENOMEM;
+		if (!(fgp & FGP_CREAT))
+			status = -ENODATA;
+		else if (iter->flags & IOMAP_NOWAIT)
+			status = -EAGAIN;
+		else
+			status = -ENOMEM;
 		goto out_no_page;
 	}
 
@@ -791,7 +796,7 @@ static loff_t iomap_write_iter(struct iomap_iter *iter, struct iov_iter *i)
 			break;
 		}
 
-		status = iomap_write_begin(iter, pos, bytes, &folio);
+		status = iomap_write_begin(iter, pos, bytes, &folio, FGP_CREAT);
 		if (unlikely(status))
 			break;
 		if (iter->iomap.flags & IOMAP_F_STALE)
@@ -1101,7 +1106,7 @@ static loff_t iomap_unshare_iter(struct iomap_iter *iter)
 		unsigned long bytes = min_t(loff_t, PAGE_SIZE - offset, length);
 		struct folio *folio;
 
-		status = iomap_write_begin(iter, pos, bytes, &folio);
+		status = iomap_write_begin(iter, pos, bytes, &folio, FGP_CREAT);
 		if (unlikely(status))
 			return status;
 		if (iter->iomap.flags & IOMAP_F_STALE)
@@ -1147,10 +1152,14 @@ static loff_t iomap_zero_iter(struct iomap_iter *iter, bool *did_zero)
 	loff_t pos = iter->pos;
 	loff_t length = iomap_length(iter);
 	loff_t written = 0;
+	unsigned fgp = FGP_CREAT;
 
 	/* already zeroed?  we're done. */
-	if (srcmap->type == IOMAP_HOLE || srcmap->type == IOMAP_UNWRITTEN)
+	if (srcmap->type == IOMAP_HOLE)
 		return length;
+	/* only do page cache lookups over unwritten extents */
+	if (srcmap->type == IOMAP_UNWRITTEN)
+		fgp = 0;
 
 	do {
 		struct folio *folio;
@@ -1158,9 +1167,20 @@ static loff_t iomap_zero_iter(struct iomap_iter *iter, bool *did_zero)
 		size_t offset;
 		size_t bytes = min_t(u64, SIZE_MAX, length);
 
-		status = iomap_write_begin(iter, pos, bytes, &folio);
-		if (status)
+		status = iomap_write_begin(iter, pos, bytes, &folio, fgp);
+		if (status) {
+			if (status == -ENODATA) {
+				/*
+				 * No folio was found, so skip to the start of
+				 * the next potential entry in the page cache
+				 * and continue from there.
+				 */
+				if (bytes > PAGE_SIZE - offset_in_page(pos))
+					bytes = PAGE_SIZE - offset_in_page(pos);
+				goto loop_continue;
+			}
 			return status;
+		}
 		if (iter->iomap.flags & IOMAP_F_STALE)
 			break;
 
@@ -1168,6 +1188,19 @@ static loff_t iomap_zero_iter(struct iomap_iter *iter, bool *did_zero)
 		if (bytes > folio_size(folio) - offset)
 			bytes = folio_size(folio) - offset;
 
+		/*
+		 * If the folio over an unwritten extent is clean, then we
+		 * aren't going to touch the data in it at all. We don't want to
+		 * mark it dirty or change the uptodate state of data in the
+		 * page, so we just unlock it and skip to the next range over
+		 * the unwritten extent we need to check.
+		 */
+		if (srcmap->type == IOMAP_UNWRITTEN &&
+		    !folio_test_dirty(folio)) {
+			folio_unlock(folio);
+			goto loop_continue;
+		}
+
 		folio_zero_range(folio, offset, bytes);
 		folio_mark_accessed(folio);
 
@@ -1175,6 +1208,7 @@ static loff_t iomap_zero_iter(struct iomap_iter *iter, bool *did_zero)
 		if (WARN_ON_ONCE(bytes == 0))
 			return -EIO;
 
+loop_continue:
 		pos += bytes;
 		length -= bytes;
 		written += bytes;
diff --git a/fs/xfs/xfs_iops.c b/fs/xfs/xfs_iops.c
index 2e10e1c66ad6..d7c2f8c49f94 100644
--- a/fs/xfs/xfs_iops.c
+++ b/fs/xfs/xfs_iops.c
@@ -839,17 +839,7 @@ xfs_setattr_size(
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
2.38.1

