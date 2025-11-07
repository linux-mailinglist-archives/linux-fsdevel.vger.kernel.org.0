Return-Path: <linux-fsdevel+bounces-67401-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 93B7CC3E34D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 07 Nov 2025 03:07:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E6BA1889D1E
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Nov 2025 02:08:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA61F2DF3E7;
	Fri,  7 Nov 2025 02:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="FdDcFUQp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59D7E2E228D
	for <linux-fsdevel@vger.kernel.org>; Fri,  7 Nov 2025 02:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762481252; cv=none; b=pVNXO+Q448ZSRXCo4cJqgqqUjC9xVRcHwYtWcnqNQ/NA+tR+ud4AsERTVRBrXex5wxwuuyfTZjgPg9yocd3qUn5kzXCVCwx8pN++Hiq7l1cnFiFIB0ZbrOXhcUCJ2voFSzTubMmWZBPBFF14rKG/boZIYO2AZMkHqA+8l6pDZsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762481252; c=relaxed/simple;
	bh=UIab7wtwL7MJOqUh9OsFCLgRkvtJ87T6L6S86OEG8/0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rXWVAw7EDr4d4c1NFzoWZWH+pMo/tTqESqJJvakxlCgXYdhbH3Hptch4U0umIQ8cu9HrpSPBTMlbtjOnnQrErtlUWIUSLFllH0LEYS7e7jaU9tW1ZWZodw4hSfsblbiJZ0zdqH7YEsbgkJ5k3UIrHZTFxs4LGaOE5pAA88y0mqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=FdDcFUQp; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-b550eff972eso152065a12.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 06 Nov 2025 18:07:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1762481249; x=1763086049; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QuX17fCzmjSlKD2oTV0BAVWCX3GMVQ03UEsOj2aXO/w=;
        b=FdDcFUQpsQGrRs9SYQctX6rOgF3sJar5Sa3J/Z1NyX9Kcrd6r8qDuhYdT5+d+fJI2w
         UZSaA4F0AraXyZQXLVh+QxtFSL0cHWr7nTQvbWrT/DSykZBgijRu7Vg14/lcO2zcREUY
         VYIo+gxoNkhfP4PfAvkr0acMP4HukdlXehlPpoJiIEBQoyeV39+8eYrhvkc8FvrFhtj1
         vn7HYjP3kVBaEAlL31mNTqJt76AJ7+IgXJ+J6G1aoabe//Cw1+pkZbGTedDRenPRrMeK
         NqVK8nF/Pca8gNMqDS/ODyhjXFMq7w6hKjZOPXzw0TGyI0+CF0N/PDO/YirWWGKcWYlQ
         ZIzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762481249; x=1763086049;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QuX17fCzmjSlKD2oTV0BAVWCX3GMVQ03UEsOj2aXO/w=;
        b=kDoUZwFccWAjjlZI58xDfA/jaED/oADe/zqRY7fS3ny6+m+W9UCdA9YYgearooskNS
         WtVzTi5YoveXNNs2mEd7HasmshrF7HB9VKhecJHv3Kf+pRQkhMC4MjSXhVYvoE5jjiVi
         0rzQKlLlJLVp7EpvouUQ1x+bRee0lmBHgkEikniaVWbqiv9WPCLOq5TseNj4thgkrJ7U
         2cshV6w39bCYiz/OQrTmNW0ffZeUf8p+glYAwmbFO2Y6TNJJIHKBeqfMqdTKEwa3DRPf
         PpwVhiX0kyIFRuBaRjOp6ySOuPeYltADlQ+Y07KmIscZw/XhDTnNoeXPHuC5W1qOZO7y
         xjyg==
X-Forwarded-Encrypted: i=1; AJvYcCWXeY42bxMerYPLvcrmojTMOSmwtbe+zRhAf8a8yfel1MNEDgJrAqysD0pRi/Ed9wbNVCUGBTPafBm7ainH@vger.kernel.org
X-Gm-Message-State: AOJu0YyZ3V7WN7aeXMYIqxVpo9rdKzzbVTegwwQwvfJJQTKPPXuaM9jt
	yCIo11XXKv5G+zU9qnGbiz2lXma8KIQjGn8lMQ/ZLbDHGyT45YhRLSiG/c6gpurSS7k=
X-Gm-Gg: ASbGncuGoPJZC7GTHP2LHxAcxJCqUjQTJh0ie0fwqtU5oEqVrTMQgZCvwA4zbV/ZBmG
	8RzyZc2iYzj/E/bvNDGA5PRFlTdC/Xfkov1fUE33o7HGvE1xrloMfW2AAUl6dO9m+QSL2S1Hshz
	xMeKs0z4Sudlbsnzu9DEoiLTqKSA74sdOv/hkyunuktZ2wmC226kB67MHv3JKGDWiA3ShFXwfKJ
	lc679WZgJgwUz0r6buYo1xR0OnznNeHSTPQvsgMoUP71nhnnsVIH6RYx/Rt6iNOxjspM9NikTGd
	DVwE63HU91liSh0fgtOykhbuH333Yzcv3bbYCK6sft1J37mgWMAwWpNE4NCt5Awub/56Fx3SbvS
	iUs5ZWYT36X5CkH0hhmTfwZuaKwnUxzZTp9917gCnaxpLiomoKnWj4tVNrP4Rj5jlGMz8t7vISf
	OVz0RMy2vEb34cKvfr
X-Google-Smtp-Source: AGHT+IHXmZOcta8jUuxDACQrWTlF7AFvsAayeKJwmvo20B5+lL1aR+s8qHZVmeDX1E1ADNkEK+YkjQ==
X-Received: by 2002:a17:903:1a85:b0:295:94e1:91da with SMTP id d9443c01a7336-297c04601efmr20299015ad.33.1762481248360;
        Thu, 06 Nov 2025 18:07:28 -0800 (PST)
Received: from localhost.localdomain ([2408:8740:c4ff:1::4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2965096825esm43129885ad.3.2025.11.06.18.07.17
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 06 Nov 2025 18:07:28 -0800 (PST)
From: Fengnan Chang <changfengnan@bytedance.com>
To: axboe@kernel.dk,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz,
	asml.silence@gmail.com,
	willy@infradead.org,
	djwong@kernel.org,
	hch@infradead.org,
	ritesh.list@gmail.com,
	linux-fsdevel@vger.kernel.org,
	io-uring@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	linux-ext4@vger.kernel.org,
	linux-block@vger.kernel.org,
	ming.lei@redhat.com,
	linux-nvme@lists.infradead.org
Cc: Fengnan Chang <changfengnan@bytedance.com>
Subject: [PATCH v2 2/2] block: enable per-cpu bio cache by default
Date: Fri,  7 Nov 2025 10:05:57 +0800
Message-Id: <20251107020557.10097-3-changfengnan@bytedance.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20251107020557.10097-1-changfengnan@bytedance.com>
References: <20251107020557.10097-1-changfengnan@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since after commit 12e4e8c7ab59 ("io_uring/rw: enable bio caches for
IRQ rw"), bio_put is safe for task and irq context, bio_alloc_bioset is
safe for task context and no one calls in irq context, so we can enable
per cpu bio cache by default.

Benchmarked with t/io_uring and ext4+nvme:
taskset -c 6 /root/fio/t/io_uring  -p0 -d128 -b4096 -s1 -c1 -F1 -B1 -R1
-X1 -n1 -P1  /mnt/testfile
base IOPS is 562K, patch IOPS is 574K. The CPU usage of bio_alloc_bioset
decrease from 1.42% to 1.22%.

The worst case is allocate bio in CPU A but free in CPU B, still use
t/io_uring and ext4+nvme:
base IOPS is 648K, patch IOPS is 647K.

Also use fio test ext4/xfs with libaio/sync/io_uring on null_blk and
nvme, no obvious performance regression.

Signed-off-by: Fengnan Chang <changfengnan@bytedance.com>
---
 block/bio.c        | 26 ++++++++++++--------------
 block/fops.c       |  4 ----
 include/linux/fs.h |  3 ---
 io_uring/rw.c      |  1 -
 4 files changed, 12 insertions(+), 22 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index b3a79285c278..64a1599a5930 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -516,20 +516,18 @@ struct bio *bio_alloc_bioset(struct block_device *bdev, unsigned short nr_vecs,
 	if (WARN_ON_ONCE(!mempool_initialized(&bs->bvec_pool) && nr_vecs > 0))
 		return NULL;
 
-	if (opf & REQ_ALLOC_CACHE) {
-		if (bs->cache && nr_vecs <= BIO_INLINE_VECS) {
-			bio = bio_alloc_percpu_cache(bdev, nr_vecs, opf,
-						     gfp_mask, bs);
-			if (bio)
-				return bio;
-			/*
-			 * No cached bio available, bio returned below marked with
-			 * REQ_ALLOC_CACHE to particpate in per-cpu alloc cache.
-			 */
-		} else {
-			opf &= ~REQ_ALLOC_CACHE;
-		}
-	}
+	if (bs->cache && nr_vecs <= BIO_INLINE_VECS) {
+		opf |= REQ_ALLOC_CACHE;
+		bio = bio_alloc_percpu_cache(bdev, nr_vecs, opf,
+					     gfp_mask, bs);
+		if (bio)
+			return bio;
+		/*
+		 * No cached bio available, bio returned below marked with
+		 * REQ_ALLOC_CACHE to participate in per-cpu alloc cache.
+		 */
+	} else
+		opf &= ~REQ_ALLOC_CACHE;
 
 	/*
 	 * submit_bio_noacct() converts recursion to iteration; this means if
diff --git a/block/fops.c b/block/fops.c
index 5e3db9fead77..7ef2848244b1 100644
--- a/block/fops.c
+++ b/block/fops.c
@@ -184,8 +184,6 @@ static ssize_t __blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter,
 	loff_t pos = iocb->ki_pos;
 	int ret = 0;
 
-	if (iocb->ki_flags & IOCB_ALLOC_CACHE)
-		opf |= REQ_ALLOC_CACHE;
 	bio = bio_alloc_bioset(bdev, nr_pages, opf, GFP_KERNEL,
 			       &blkdev_dio_pool);
 	dio = container_of(bio, struct blkdev_dio, bio);
@@ -333,8 +331,6 @@ static ssize_t __blkdev_direct_IO_async(struct kiocb *iocb,
 	loff_t pos = iocb->ki_pos;
 	int ret = 0;
 
-	if (iocb->ki_flags & IOCB_ALLOC_CACHE)
-		opf |= REQ_ALLOC_CACHE;
 	bio = bio_alloc_bioset(bdev, nr_pages, opf, GFP_KERNEL,
 			       &blkdev_dio_pool);
 	dio = container_of(bio, struct blkdev_dio, bio);
diff --git a/include/linux/fs.h b/include/linux/fs.h
index c895146c1444..1be899ac8b5a 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -365,8 +365,6 @@ struct readahead_control;
 /* iocb->ki_waitq is valid */
 #define IOCB_WAITQ		(1 << 19)
 #define IOCB_NOIO		(1 << 20)
-/* can use bio alloc cache */
-#define IOCB_ALLOC_CACHE	(1 << 21)
 /*
  * IOCB_DIO_CALLER_COMP can be set by the iocb owner, to indicate that the
  * iocb completion can be passed back to the owner for execution from a safe
@@ -399,7 +397,6 @@ struct readahead_control;
 	{ IOCB_WRITE,		"WRITE" }, \
 	{ IOCB_WAITQ,		"WAITQ" }, \
 	{ IOCB_NOIO,		"NOIO" }, \
-	{ IOCB_ALLOC_CACHE,	"ALLOC_CACHE" }, \
 	{ IOCB_DIO_CALLER_COMP,	"CALLER_COMP" }, \
 	{ IOCB_AIO_RW,		"AIO_RW" }, \
 	{ IOCB_HAS_METADATA,	"AIO_HAS_METADATA" }
diff --git a/io_uring/rw.c b/io_uring/rw.c
index 5b2241a5813c..c0c59eb358a8 100644
--- a/io_uring/rw.c
+++ b/io_uring/rw.c
@@ -862,7 +862,6 @@ static int io_rw_init_file(struct io_kiocb *req, fmode_t mode, int rw_type)
 	ret = kiocb_set_rw_flags(kiocb, rw->flags, rw_type);
 	if (unlikely(ret))
 		return ret;
-	kiocb->ki_flags |= IOCB_ALLOC_CACHE;
 
 	/*
 	 * If the file is marked O_NONBLOCK, still allow retry for it if it
-- 
2.39.5 (Apple Git-154)


