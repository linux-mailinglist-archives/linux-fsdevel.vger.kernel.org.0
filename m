Return-Path: <linux-fsdevel+bounces-17785-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 26AA48B22CA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Apr 2024 15:30:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A57F1C21985
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Apr 2024 13:30:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67D9814A62B;
	Thu, 25 Apr 2024 13:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sbv6z1kR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16FE6149C5E;
	Thu, 25 Apr 2024 13:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714051771; cv=none; b=IgzavEUF3eTFnrpUX5JLBRsrMl1MuvMhXTf0a6DGPOjmQJMnKQHlv/LIfoebnVWj46LfVAH84HZRL75J4+ruFEbAZuKMiDQSOTw4o3wA4bq14LF9XPCFD4okikhyqRzFCyYbi95oLKliV6My9Ey8jVpI3lNcQojA0ZR9Ho3XWDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714051771; c=relaxed/simple;
	bh=mXwhomWyRGbw6y94ChOUxJcx7nd/wj3RuraEiiLl0WQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kEjGKrBotMB6xpGgAQpNx0ICmQ65vkF/1JNI8PYscSALSzqsFoffXP51fNA+QOhSbW1BVvKFqD/E54AD76ipYdtdUhJYGAY5bflLLWtzVH7UGH0QQOxGJ4YZVuNmIQ92/9piV4YL0h9NUD/IMxaaWEms1i0XcjGXIA+PRdr5ZQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sbv6z1kR; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-6f043f9e6d7so1044409b3a.3;
        Thu, 25 Apr 2024 06:29:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714051768; x=1714656568; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QRED1FXDeH08jKI4Y85H1+m9zHcF9yp/Q4DUuv7pi/8=;
        b=Sbv6z1kR5nZpnFP5sCwuN36E6Ct1UmgXrQNAo5HokBABhq8IfDToZUIZmL9gbw12Vy
         9MbLKNAOUydfFj3iVMQ5oa894fJ4adL4lDTa+bkcKU/Jq7ww9u1m+ZBfa0LUF5qmcwjj
         nGMtv/+D0DIi6KGUJPcCXEClSqWxTUgGDbHAGIQG1bQ3FAcdyVeR2Nh5BOIAHwLSgrNi
         HJMZ9n79TFCHOc9NkkcwxtRG7Oeg7wqOmgf0ah3edMDiGQ/9R2+Mc/aoNKgOvvS/45yj
         Zu79iYnm0qK9OAPYJhMgAsLae6DPPD9yTCfGy6GS7QqmGfSJmWqwx6g36cpOvEnLvP3P
         frfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714051768; x=1714656568;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QRED1FXDeH08jKI4Y85H1+m9zHcF9yp/Q4DUuv7pi/8=;
        b=ES6uAIy0g6gNXERMGG0uUNZm2wD+/2jhVa8reT82A021GZu7+q4E96MDRecLpjTGfc
         B8zEZQtStL9zQMHlkR7MAoRn2WUVyOGZI/B6MQSQiGpiJsUOg8M4QnPAzmaR5kZiZOjV
         vKLIbidnzidgXlm8Ih1AQMErmINP+wjVTI9CwsbnUj+4fwJY666PoPHkOI3Bx5+RG8TL
         ZdWDWvZ9PqVHOiRbsAwcnBs4QRb9ZpCL97cTifvQlr6kuMNBGFSGmSbnmKrhLrWkwpff
         Cdt8vceBlfBdaOt8r25mLorMYth/i8Zq5Fc8WjHYxoOQQNuJu1+W0Ya/QEWoXdxFrmSs
         HYtw==
X-Forwarded-Encrypted: i=1; AJvYcCX4VI7uG3EqO3BCxWHjgwbv5qzcdDHH2UGGnrsBUwTlwrPFbDWvSZKUyTYVVQGRKfSlEDrQkwBg9vmjDw4IFR+YSvLJtU6VgUMO
X-Gm-Message-State: AOJu0YyjPUXIYAAW1T4kA8Hu8UVc0NPted2azA9VLFoRD3yInEcxB9zb
	ETUlTJ0A9en1E0nHFqMWGj+Zh08aLlqk+jfgits+LmtXKuVNCP1llQ02q1+Z
X-Google-Smtp-Source: AGHT+IE842vOw+suDWOfmSI5f9x78evzQ+L8isXlOhD7js0Dp8z+R/MmRtyCTAHPH/QacsH85G29vg==
X-Received: by 2002:a05:6a00:a93:b0:6e6:843f:1d05 with SMTP id b19-20020a056a000a9300b006e6843f1d05mr7305784pfl.25.1714051768374;
        Thu, 25 Apr 2024 06:29:28 -0700 (PDT)
Received: from dw-tp.in.ibm.com ([129.41.58.7])
        by smtp.gmail.com with ESMTPSA id s15-20020a62e70f000000b006f260fb17e5sm9764518pfh.141.2024.04.25.06.29.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Apr 2024 06:29:27 -0700 (PDT)
From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To: linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org,
	Matthew Wilcox <willy@infradead.org>,
	"Darrick J . Wong" <djwong@kernel.org>,
	Ojaswin Mujoo <ojaswin@linux.ibm.com>,
	Ritesh Harjani <ritesh.list@gmail.com>,
	Jan Kara <jack@suse.cz>
Subject: [RFCv3 7/7] iomap: Optimize data access patterns for filesystems with indirect mappings
Date: Thu, 25 Apr 2024 18:58:51 +0530
Message-ID: <4e2752e99f55469c4eb5f2fe83e816d529110192.1714046808.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1714046808.git.ritesh.list@gmail.com>
References: <cover.1714046808.git.ritesh.list@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch optimizes the data access patterns for filesystems with
indirect block mapping by implementing BH_Boundary handling within
iomap.

Currently the bios for reads within iomap are only submitted at
2 places -
1. If we cannot merge the new req. with previous bio, only then we
   submit the previous bio.
2. Submit the bio at the end of the entire read processing.

This means for filesystems with indirect block mapping, we call into
->iomap_begin() again w/o submitting the previous bios. That causes
unoptimized data access patterns for blocks which are of BH_Boundary type.

For e.g. consider the file mapping
logical block(4k) 		physical block(4k)
0-11 				1000-1011
12-15 				1013-1016

In above physical block 1012 is an indirect metadata block which has the
mapping information for next set of indirect blocks (1013-1016).
With iomap buffered reads for reading 1st 16 logical blocks of a file
(0-15), we get below I/O pattern
	- submit a bio for 1012
	- complete the bio for 1012
	- submit a bio for 1000-1011
	- submit a bio for 1013-1016
	- complete the bios for 1000-1011
	- complete the bios for 1013-1016

So as we can see, above is an non-optimal I/O access pattern and also we
get 3 bio completions instead of 2.

This patch changes this behavior by doing submit_bio() if there are any
bios already processed, before calling ->iomap_begin() again.
That means if there are any blocks which are already processed, gets
submitted for I/O earlier and then within ->iomap_begin(), if we get a
request for reading an indirect metadata block, then block layer can merge
those bios with the already submitted read request to reduce the no. of bio
completions.

Now, for bs < ps or for large folios, this patch requires proper handling
of "ifs->read_bytes_pending". In that we first set ifs->read_bytes_pending
to folio_size. Then handle all the cases where we need to subtract
ifs->read_bytes_pending either during the submission side
(if we don't need to submit any I/O - for e.g. for uptodate sub blocks),
or during an I/O error, or at the completion of an I/O.

Here is the ftrace output of iomap and block layer with ext2 iomap
conversion patches -

root# filefrag -b512 -v /mnt1/test/f1
Filesystem type is: ef53
Filesystem cylinder groups approximately 32
File size of /mnt1/test/f1 is 65536 (128 blocks of 512 bytes)
 ext:     logical_offset:        physical_offset: length:   expected: flags:
   0:        0..      95:      98304..     98399:     96:             merged
   1:       96..     127:      98408..     98439:     32:      98400: last,merged,eof
/mnt1/test/f1: 2 extents found

root# #This reads 4 blocks starting from lblk 10, 11, 12, 13
root# xfs_io -c "pread -b$((4*4096)) $((10*4096)) $((4*4096))" /mnt1/test/f1

w/o this patch - (indirect block is submitted before and does not get merged, resulting in 3 bios completion)
      xfs_io-907     [002] .....   185.608791: iomap_readahead: dev 8:16 ino 0xc nr_pages 4
      xfs_io-907     [002] .....   185.608819: iomap_iter: dev 8:16 ino 0xc pos 0xa000 length 0x4000 processed 0 flags  (0x0) ops 0xffffffff82242160 caller iomap_readahead+0x9d/0x2c0
      xfs_io-907     [002] .....   185.608823: iomap_iter_dstmap: dev 8:16 ino 0xc bdev 8:16 addr 0x300a000 offset 0xa000 length 0x2000 type MAPPED flags MERGED
      xfs_io-907     [002] .....   185.608831: iomap_iter: dev 8:16 ino 0xc pos 0xa000 length 0x2000 processed 8192 flags  (0x0) ops 0xffffffff82242160 caller iomap_readahead+0x1e1/0x2c0
      xfs_io-907     [002] .....   185.608859: block_bio_queue: 8,16 R 98400 + 8 [xfs_io]
      xfs_io-907     [002] .....   185.608865: block_getrq: 8,16 R 98400 + 8 [xfs_io]
      xfs_io-907     [002] .....   185.608867: block_io_start: 8,16 R 4096 () 98400 + 8 [xfs_io]
      xfs_io-907     [002] .....   185.608869: block_plug: [xfs_io]
      xfs_io-907     [002] .....   185.608872: block_unplug: [xfs_io] 1
      xfs_io-907     [002] .....   185.608874: block_rq_insert: 8,16 R 4096 () 98400 + 8 [xfs_io]
kworker/2:1H-198     [002] .....   185.608908: block_rq_issue: 8,16 R 4096 () 98400 + 8 [kworker/2:1H]
      <idle>-0       [002] d.h2.   185.609579: block_rq_complete: 8,16 R () 98400 + 8 [0]
      <idle>-0       [002] dNh2.   185.609631: block_io_done: 8,16 R 0 () 98400 + 0 [swapper/2]
      xfs_io-907     [002] .....   185.609694: iomap_iter_dstmap: dev 8:16 ino 0xc bdev 8:16 addr 0x300d000 offset 0xc000 length 0x2000 type MAPPED flags MERGED
      xfs_io-907     [002] .....   185.609704: block_bio_queue: 8,16 RA 98384 + 16 [xfs_io]
      xfs_io-907     [002] .....   185.609718: block_getrq: 8,16 RA 98384 + 16 [xfs_io]
      xfs_io-907     [002] .....   185.609721: block_io_start: 8,16 RA 8192 () 98384 + 16 [xfs_io]
      xfs_io-907     [002] .....   185.609726: block_plug: [xfs_io]
      xfs_io-907     [002] .....   185.609735: iomap_iter: dev 8:16 ino 0xc pos 0xc000 length 0x2000 processed 8192 flags  (0x0) ops 0xffffffff82242160 caller iomap_readahead+0x1e1/0x2c0
      xfs_io-907     [002] .....   185.609736: block_bio_queue: 8,16 RA 98408 + 16 [xfs_io]
      xfs_io-907     [002] .....   185.609740: block_getrq: 8,16 RA 98408 + 16 [xfs_io]
      xfs_io-907     [002] .....   185.609741: block_io_start: 8,16 RA 8192 () 98408 + 16 [xfs_io]
      xfs_io-907     [002] .....   185.609756: block_rq_issue: 8,16 RA 8192 () 98408 + 16 [xfs_io]
      xfs_io-907     [002] .....   185.609769: block_rq_issue: 8,16 RA 8192 () 98384 + 16 [xfs_io]
      <idle>-0       [002] d.H2.   185.610280: block_rq_complete: 8,16 RA () 98408 + 16 [0]
      <idle>-0       [002] d.H2.   185.610289: block_io_done: 8,16 RA 0 () 98408 + 0 [swapper/2]
      <idle>-0       [002] d.H2.   185.610292: block_rq_complete: 8,16 RA () 98384 + 16 [0]
      <idle>-0       [002] dNH2.   185.610301: block_io_done: 8,16 RA 0 () 98384 + 0 [swapper/2]

v/s with the patch - (optimzed I/O access pattern and bio gets merged resulting in only 2 bios completion)
      xfs_io-944     [005] .....    99.926187: iomap_readahead: dev 8:16 ino 0xc nr_pages 4
      xfs_io-944     [005] .....    99.926208: iomap_iter: dev 8:16 ino 0xc pos 0xa000 length 0x4000 processed 0 flags  (0x0) ops 0xffffffff82242160 caller iomap_readahead+0x9d/0x2c0
      xfs_io-944     [005] .....    99.926211: iomap_iter_dstmap: dev 8:16 ino 0xc bdev 8:16 addr 0x300a000 offset 0xa000 length 0x2000 type MAPPED flags MERGED
      xfs_io-944     [005] .....    99.926222: block_bio_queue: 8,16 RA 98384 + 16 [xfs_io]
      xfs_io-944     [005] .....    99.926232: block_getrq: 8,16 RA 98384 + 16 [xfs_io]
      xfs_io-944     [005] .....    99.926233: block_io_start: 8,16 RA 8192 () 98384 + 16 [xfs_io]
      xfs_io-944     [005] .....    99.926234: block_plug: [xfs_io]
      xfs_io-944     [005] .....    99.926235: iomap_iter: dev 8:16 ino 0xc pos 0xa000 length 0x2000 processed 8192 flags  (0x0) ops 0xffffffff82242160 caller iomap_readahead+0x1f9/0x2c0
      xfs_io-944     [005] .....    99.926261: block_bio_queue: 8,16 R 98400 + 8 [xfs_io]
      xfs_io-944     [005] .....    99.926266: block_bio_backmerge: 8,16 R 98400 + 8 [xfs_io]
      xfs_io-944     [005] .....    99.926271: block_unplug: [xfs_io] 1
      xfs_io-944     [005] .....    99.926272: block_rq_insert: 8,16 RA 12288 () 98384 + 24 [xfs_io]
kworker/5:1H-234     [005] .....    99.926314: block_rq_issue: 8,16 RA 12288 () 98384 + 24 [kworker/5:1H]
      <idle>-0       [005] d.h2.    99.926905: block_rq_complete: 8,16 RA () 98384 + 24 [0]
      <idle>-0       [005] dNh2.    99.926931: block_io_done: 8,16 RA 0 () 98384 + 0 [swapper/5]
      xfs_io-944     [005] .....    99.926971: iomap_iter_dstmap: dev 8:16 ino 0xc bdev 8:16 addr 0x300d000 offset 0xc000 length 0x2000 type MAPPED flags MERGED
      xfs_io-944     [005] .....    99.926981: block_bio_queue: 8,16 RA 98408 + 16 [xfs_io]
      xfs_io-944     [005] .....    99.926989: block_getrq: 8,16 RA 98408 + 16 [xfs_io]
      xfs_io-944     [005] .....    99.926989: block_io_start: 8,16 RA 8192 () 98408 + 16 [xfs_io]
      xfs_io-944     [005] .....    99.926991: block_plug: [xfs_io]
      xfs_io-944     [005] .....    99.926993: iomap_iter: dev 8:16 ino 0xc pos 0xc000 length 0x2000 processed 8192 flags  (0x0) ops 0xffffffff82242160 caller iomap_readahead+0x1f9/0x2c0
      xfs_io-944     [005] .....    99.927001: block_rq_issue: 8,16 RA 8192 () 98408 + 16 [xfs_io]
      <idle>-0       [005] d.h2.    99.927397: block_rq_complete: 8,16 RA () 98408 + 16 [0]
      <idle>-0       [005] dNh2.    99.927414: block_io_done: 8,16 RA 0 () 98408 + 0 [swapper/5]

Suggested-by: Matthew Wilcox <willy@infradead.org>
Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
cc: Ojaswin Mujoo <ojaswin@linux.ibm.com>
---
 fs/iomap/buffered-io.c | 112 +++++++++++++++++++++++++++++++----------
 1 file changed, 85 insertions(+), 27 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 0a4269095ae2..a1d50086a3f5 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -30,7 +30,7 @@ typedef int (*iomap_punch_t)(struct inode *inode, loff_t offset, loff_t length);
  */
 struct iomap_folio_state {
 	spinlock_t		state_lock;
-	unsigned int		read_bytes_pending;
+	size_t			read_bytes_pending;
 	atomic_t		write_bytes_pending;

 	/*
@@ -380,6 +380,7 @@ static loff_t iomap_readpage_iter(const struct iomap_iter *iter,
 	loff_t orig_pos = pos;
 	size_t poff, plen;
 	sector_t sector;
+	bool rbp_finished = false;

 	if (iomap->type == IOMAP_INLINE)
 		return iomap_read_inline_data(iter, folio);
@@ -387,21 +388,39 @@ static loff_t iomap_readpage_iter(const struct iomap_iter *iter,
 	/* zero post-eof blocks as the page may be mapped */
 	ifs = ifs_alloc(iter->inode, folio, iter->flags);
 	iomap_adjust_read_range(iter->inode, folio, &pos, length, &poff, &plen);
+
+	if (ifs) {
+		loff_t to_read = min_t(loff_t, iter->len - offset,
+			folio_size(folio) - offset_in_folio(folio, orig_pos));
+		size_t padjust;
+
+		spin_lock_irq(&ifs->state_lock);
+		if (!ifs->read_bytes_pending)
+			ifs->read_bytes_pending = to_read;
+		padjust = pos - orig_pos;
+		ifs->read_bytes_pending -= padjust;
+		if (!ifs->read_bytes_pending)
+			rbp_finished = true;
+		spin_unlock_irq(&ifs->state_lock);
+	}
+
 	if (plen == 0)
 		goto done;

 	if (iomap_block_needs_zeroing(iter, pos)) {
+		if (ifs) {
+			spin_lock_irq(&ifs->state_lock);
+			ifs->read_bytes_pending -= plen;
+			if (!ifs->read_bytes_pending)
+				rbp_finished = true;
+			spin_unlock_irq(&ifs->state_lock);
+		}
 		folio_zero_range(folio, poff, plen);
 		iomap_set_range_uptodate(folio, poff, plen);
 		goto done;
 	}

 	ctx->cur_folio_in_bio = true;
-	if (ifs) {
-		spin_lock_irq(&ifs->state_lock);
-		ifs->read_bytes_pending += plen;
-		spin_unlock_irq(&ifs->state_lock);
-	}

 	sector = iomap_sector(iomap, pos);
 	if (!ctx->bio ||
@@ -435,6 +454,14 @@ static loff_t iomap_readpage_iter(const struct iomap_iter *iter,
 	}

 done:
+	/*
+	 * If there is no bio prepared and if rbp is finished and
+	 * this was the last offset within this folio then mark
+	 * cur_folio_in_bio to false.
+	 */
+	if (!ctx->bio && rbp_finished &&
+			offset_in_folio(folio, pos + plen) == 0)
+		ctx->cur_folio_in_bio = false;
 	/*
 	 * Move the caller beyond our range so that it keeps making progress.
 	 * For that, we have to include any leading non-uptodate ranges, but
@@ -459,9 +486,43 @@ static loff_t iomap_read_folio_iter(const struct iomap_iter *iter,
 			return ret;
 	}

+	if (ctx->bio) {
+		submit_bio(ctx->bio);
+		WARN_ON_ONCE(!ctx->cur_folio_in_bio);
+		ctx->bio = NULL;
+	}
+	if (offset_in_folio(folio, iter->pos + done) == 0 &&
+			!ctx->cur_folio_in_bio) {
+		folio_unlock(ctx->cur_folio);
+	}
+
 	return done;
 }

+static void iomap_handle_read_error(struct iomap_readpage_ctx *ctx,
+		struct iomap_iter *iter)
+{
+	struct folio *folio = ctx->cur_folio;
+	struct iomap_folio_state *ifs;
+	unsigned long flags;
+	bool rbp_finished = false;
+	size_t rbp_adjust = folio_size(folio) - offset_in_folio(folio,
+				iter->pos);
+	ifs = folio->private;
+	if (!ifs || !ifs->read_bytes_pending)
+		goto unlock;
+
+	spin_lock_irqsave(&ifs->state_lock, flags);
+	ifs->read_bytes_pending -= rbp_adjust;
+	if (!ifs->read_bytes_pending)
+		rbp_finished = true;
+	spin_unlock_irqrestore(&ifs->state_lock, flags);
+
+unlock:
+	if (rbp_finished || !ctx->cur_folio_in_bio)
+		folio_unlock(folio);
+}
+
 int iomap_read_folio(struct folio *folio, const struct iomap_ops *ops)
 {
 	struct iomap_iter iter = {
@@ -479,15 +540,9 @@ int iomap_read_folio(struct folio *folio, const struct iomap_ops *ops)
 	while ((ret = iomap_iter(&iter, ops)) > 0)
 		iter.processed = iomap_read_folio_iter(&iter, &ctx);

-	if (ret < 0)
+	if (ret < 0) {
 		folio_set_error(folio);
-
-	if (ctx.bio) {
-		submit_bio(ctx.bio);
-		WARN_ON_ONCE(!ctx.cur_folio_in_bio);
-	} else {
-		WARN_ON_ONCE(ctx.cur_folio_in_bio);
-		folio_unlock(folio);
+		iomap_handle_read_error(&ctx, &iter);
 	}

 	/*
@@ -506,12 +561,6 @@ static loff_t iomap_readahead_iter(const struct iomap_iter *iter,
 	loff_t done, ret;

 	for (done = 0; done < length; done += ret) {
-		if (ctx->cur_folio &&
-		    offset_in_folio(ctx->cur_folio, iter->pos + done) == 0) {
-			if (!ctx->cur_folio_in_bio)
-				folio_unlock(ctx->cur_folio);
-			ctx->cur_folio = NULL;
-		}
 		if (!ctx->cur_folio) {
 			ctx->cur_folio = readahead_folio(ctx->rac);
 			ctx->cur_folio_in_bio = false;
@@ -519,6 +568,17 @@ static loff_t iomap_readahead_iter(const struct iomap_iter *iter,
 		ret = iomap_readpage_iter(iter, ctx, done);
 		if (ret <= 0)
 			return ret;
+		if (ctx->cur_folio && offset_in_folio(ctx->cur_folio,
+					iter->pos + done + ret) == 0) {
+			if (!ctx->cur_folio_in_bio)
+				folio_unlock(ctx->cur_folio);
+			ctx->cur_folio = NULL;
+		}
+	}
+
+	if (ctx->bio) {
+		submit_bio(ctx->bio);
+		ctx->bio = NULL;
 	}

 	return done;
@@ -549,18 +609,16 @@ void iomap_readahead(struct readahead_control *rac, const struct iomap_ops *ops)
 	struct iomap_readpage_ctx ctx = {
 		.rac	= rac,
 	};
+	int ret = 0;

 	trace_iomap_readahead(rac->mapping->host, readahead_count(rac));

-	while (iomap_iter(&iter, ops) > 0)
+	while ((ret = iomap_iter(&iter, ops)) > 0)
 		iter.processed = iomap_readahead_iter(&iter, &ctx);

-	if (ctx.bio)
-		submit_bio(ctx.bio);
-	if (ctx.cur_folio) {
-		if (!ctx.cur_folio_in_bio)
-			folio_unlock(ctx.cur_folio);
-	}
+	if (ret < 0 && ctx.cur_folio)
+		iomap_handle_read_error(&ctx, &iter);
+
 }
 EXPORT_SYMBOL_GPL(iomap_readahead);

--
2.44.0


