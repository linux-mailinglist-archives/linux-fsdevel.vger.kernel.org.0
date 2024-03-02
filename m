Return-Path: <linux-fsdevel+bounces-13353-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E1CED86EF35
	for <lists+linux-fsdevel@lfdr.de>; Sat,  2 Mar 2024 08:43:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D6AB1F23458
	for <lists+linux-fsdevel@lfdr.de>; Sat,  2 Mar 2024 07:43:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 399CF1799A;
	Sat,  2 Mar 2024 07:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E6H0RfJz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D5611775E;
	Sat,  2 Mar 2024 07:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709365359; cv=none; b=pUH2jlgW5UeS6RIOPK6xH4UzchilKN9O1JAC6bZkKQpy0FlhNc1fktQcZpw/v5hIQuRBiESARORqNwWtay5CoWMPQ2hLJ6olvvir3Tfs94q2udXK7ZdZIYZlKvlBWSNvTim1hRarkDlEcH288ZjyTBGVB4yJvXfiwegdkGS4gbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709365359; c=relaxed/simple;
	bh=4+Rh2VnQPFyNWCv+BvIaDZG8kx9KbVijZEmof738DIA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y7KuabuiRUbhV4Gu01Fiiao/SJO1An9GF1YBuyoLq+ZCuj4P6V+zIAN+zVcPzNuIHQn0DaVyacR8ooez/x1CJPmAFjvbGSmOh03t35lksgX5KuqItAfs8v0+1JsXAVJf3WQ0l+tArW0XWWD2duvjVxUzlknJVshw2AvpmNtHHkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E6H0RfJz; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-6e5b1c6daa3so1556619b3a.1;
        Fri, 01 Mar 2024 23:42:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709365356; x=1709970156; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eHsu0u63wjbZemZD2jGi9jSrqASniu0uOU6naDIntW0=;
        b=E6H0RfJzCwRAxifxnDBylksjLZOrgrPMXBr1/OxK4KvkHAlaJwj7UvaXKkhJ9V7oXe
         VyACnY/6Hzzj3NEiOttA3yiRC0q4YtOjqG7C3Vg2Jhw+bi7mH/a/K+4lrfQ+kp6mlGXh
         piKTllWS6wlzG9JZ7kGrgpnFUwKC3BVCWD6c39PFMBSw79K9NhgW4mdk3akh1vl5pHn6
         AZev0dkHTga/wOPyuqLUqryBt8QryxjWmF42YSW1IeWFUMp2vjJiJ9Hzjj4ZcRRtZOg/
         k0L5MkpMP8IDFbuK7IYAfrslZSLlqigz7bEw6/1Cc/17H88o6R3UTV+CKIq59NqNxcSQ
         NUNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709365356; x=1709970156;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eHsu0u63wjbZemZD2jGi9jSrqASniu0uOU6naDIntW0=;
        b=gOw7BDH1VDKOkXIXiHthdujnfe6ffYb9iMH6TMUV9v8vyLdighZH1YIV0aD8Xsx88t
         h9wNotTrpNWbgpgw2GRStvIoZON8RtlPh29tFr+VhQ6vjFKUrX3E2hrbhipeofLxmZbb
         rSmVPaBAS8OxKefPwbnUNrmOTIdeM5mTftRbsiJY5tseFHTfs37eV3HzUcjSxRiCfS+A
         EeKpSA5+80o/6v9VOCAj+WEZOGf1zh4nPDFLgNTfpbNSX2Vj19+tcKsbP2wNFDWJEccC
         y7Bv6LK/MtES/v8nP1U2DKCsQ7UkK/uUEXlzjfh9y1yVBVAWD0kPBxPu5fIzoyFZIz8+
         A6pA==
X-Forwarded-Encrypted: i=1; AJvYcCVJF/d0lpnee+U4fxva78/CXkgzr8YoF4fGtm7WiRa0S/3u/zXVYGGShrMOd10BI1ClDFHHx6YgaiRAi7lvUUD9DQ5nJrTYsTWbYRoYDBrtEeL4MiXWv6sNc3Eg3Lo4OTUTeA1n54wCoQ==
X-Gm-Message-State: AOJu0YxB09+tyGZJgpJmVO6N1XFsj8dzmnZUGQfs9ZpIphjC13ooCZop
	XBZ4rWL2mkRZJiFiXL/laorKNM+OvdVJ571NoZJFLcvprMqntdaH08OnPQgd
X-Google-Smtp-Source: AGHT+IFkeFoOHaVJfbLC2PxqAidQfWklji6Sr2BMb/SKrF2mw/gPhtET8LcXvlUgozMIcAte7+1aoQ==
X-Received: by 2002:a05:6a00:2d02:b0:6e5:9031:9885 with SMTP id fa2-20020a056a002d0200b006e590319885mr5511519pfb.23.1709365356352;
        Fri, 01 Mar 2024 23:42:36 -0800 (PST)
Received: from dw-tp.. ([49.205.218.89])
        by smtp.gmail.com with ESMTPSA id x11-20020aa784cb000000b006e45c5d7720sm4138206pfn.93.2024.03.01.23.42.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Mar 2024 23:42:35 -0800 (PST)
From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To: linux-fsdevel@vger.kernel.org,
	linux-ext4@vger.kernel.org
Cc: Ojaswin Mujoo <ojaswin@linux.ibm.com>,
	Jan Kara <jack@suse.cz>,
	Theodore Ts'o <tytso@mit.edu>,
	Matthew Wilcox <willy@infradead.org>,
	"Darrick J . Wong" <djwong@kernel.org>,
	Luis Chamberlain <mcgrof@kernel.org>,
	John Garry <john.g.garry@oracle.com>,
	linux-kernel@vger.kernel.org,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: [RFC 3/8] iomap: Add atomic write support for direct-io
Date: Sat,  2 Mar 2024 13:12:00 +0530
Message-ID: <6a09654d152d3d1a07636174f5abcfce9948c20c.1709361537.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <555cc3e262efa77ee5648196362f415a1efc018d.1709361537.git.ritesh.list@gmail.com>
References: <555cc3e262efa77ee5648196362f415a1efc018d.1709361537.git.ritesh.list@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This adds direct-io atomic writes support in iomap. This adds -
1. IOMAP_ATOMIC flag for iomap iter.
2. Sets REQ_ATOMIC to bio opflags.
3. Adds necessary checks in iomap_dio code to ensure a single bio is
   submitted for an atomic write request. (since we only support ubuf
   type iocb). Otherwise return an error EIO.
4. Adds a common helper routine iomap_dio_check_atomic(). It helps in
   verifying mapped length and start/end physical offset against the hw
   device constraints for supporting atomic writes.

This patch is based on a patch from John Garry <john.g.garry@oracle.com>
which adds such support of DIO atomic writes to iomap.

Co-developed-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 fs/iomap/direct-io.c  | 75 +++++++++++++++++++++++++++++++++++++++++--
 fs/iomap/trace.h      |  3 +-
 include/linux/iomap.h |  1 +
 3 files changed, 75 insertions(+), 4 deletions(-)

diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
index bcd3f8cf5ea4..b4548acb74e7 100644
--- a/fs/iomap/direct-io.c
+++ b/fs/iomap/direct-io.c
@@ -256,7 +256,7 @@ static void iomap_dio_zero(const struct iomap_iter *iter, struct iomap_dio *dio,
  * clearing the WRITE_THROUGH flag in the dio request.
  */
 static inline blk_opf_t iomap_dio_bio_opflags(struct iomap_dio *dio,
-		const struct iomap *iomap, bool use_fua)
+		const struct iomap *iomap, bool use_fua, bool atomic_write)
 {
 	blk_opf_t opflags = REQ_SYNC | REQ_IDLE;
 
@@ -269,6 +269,9 @@ static inline blk_opf_t iomap_dio_bio_opflags(struct iomap_dio *dio,
 	else
 		dio->flags &= ~IOMAP_DIO_WRITE_THROUGH;
 
+	if (atomic_write)
+		opflags |= REQ_ATOMIC;
+
 	return opflags;
 }
 
@@ -279,11 +282,12 @@ static loff_t iomap_dio_bio_iter(const struct iomap_iter *iter,
 	struct inode *inode = iter->inode;
 	unsigned int fs_block_size = i_blocksize(inode), pad;
 	loff_t length = iomap_length(iter);
+	const size_t orig_len = iter->len;
 	loff_t pos = iter->pos;
 	blk_opf_t bio_opf;
 	struct bio *bio;
 	bool need_zeroout = false;
-	bool use_fua = false;
+	bool use_fua = false, atomic_write = iter->flags & IOMAP_ATOMIC;
 	int nr_pages, ret = 0;
 	size_t copied = 0;
 	size_t orig_count;
@@ -356,6 +360,11 @@ static loff_t iomap_dio_bio_iter(const struct iomap_iter *iter,
 	if (need_zeroout) {
 		/* zero out from the start of the block to the write offset */
 		pad = pos & (fs_block_size - 1);
+		if (unlikely(pad && atomic_write)) {
+			WARN_ON_ONCE("pos not atomic write aligned\n");
+			ret = -EINVAL;
+			goto out;
+		}
 		if (pad)
 			iomap_dio_zero(iter, dio, pos - pad, pad);
 	}
@@ -365,7 +374,7 @@ static loff_t iomap_dio_bio_iter(const struct iomap_iter *iter,
 	 * can set up the page vector appropriately for a ZONE_APPEND
 	 * operation.
 	 */
-	bio_opf = iomap_dio_bio_opflags(dio, iomap, use_fua);
+	bio_opf = iomap_dio_bio_opflags(dio, iomap, use_fua, atomic_write);
 
 	nr_pages = bio_iov_vecs_to_alloc(dio->submit.iter, BIO_MAX_VECS);
 	do {
@@ -397,6 +406,14 @@ static loff_t iomap_dio_bio_iter(const struct iomap_iter *iter,
 		}
 
 		n = bio->bi_iter.bi_size;
+
+		/* This bio should have covered the complete length */
+		if (unlikely(atomic_write && n != orig_len)) {
+			WARN_ON_ONCE(1);
+			ret = -EINVAL;
+			bio_put(bio);
+			goto out;
+		}
 		if (dio->flags & IOMAP_DIO_WRITE) {
 			task_io_account_write(n);
 		} else {
@@ -429,6 +446,8 @@ static loff_t iomap_dio_bio_iter(const struct iomap_iter *iter,
 	    ((dio->flags & IOMAP_DIO_WRITE) && pos >= i_size_read(inode))) {
 		/* zero out from the end of the write to the end of the block */
 		pad = pos & (fs_block_size - 1);
+		/* This should never happen */
+		WARN_ON_ONCE(unlikely(pad && atomic_write));
 		if (pad)
 			iomap_dio_zero(iter, dio, pos, fs_block_size - pad);
 	}
@@ -516,6 +535,44 @@ static loff_t iomap_dio_iter(const struct iomap_iter *iter,
 	}
 }
 
+/*
+ * iomap_dio_check_atomic:	DIO Atomic checks before calling bio submission.
+ * @iter:			iomap iterator
+ * This function is called after filesystem block mapping and before bio
+ * formation/submission. This is the right place to verify hw device/block
+ * layer constraints to be followed for doing atomic writes. Hence do those
+ * common checks here.
+ */
+static bool iomap_dio_check_atomic(struct iomap_iter *iter)
+{
+	struct block_device *bdev = iter->iomap.bdev;
+	unsigned long long map_len = iomap_length(iter);
+	unsigned long long start = iomap_sector(&iter->iomap, iter->pos)
+						<< SECTOR_SHIFT;
+	unsigned long long end = start + map_len - 1;
+	unsigned int awu_min =
+			queue_atomic_write_unit_min_bytes(bdev->bd_queue);
+	unsigned int awu_max =
+			queue_atomic_write_unit_max_bytes(bdev->bd_queue);
+	unsigned long boundary =
+			queue_atomic_write_boundary_bytes(bdev->bd_queue);
+	unsigned long mask = ~(boundary - 1);
+
+
+	/* map_len should be same as user specified iter->len */
+	if (map_len < iter->len)
+		return false;
+	/* start should be aligned to block device min atomic unit alignment */
+	if (!IS_ALIGNED(start, awu_min))
+		return false;
+	/* If top bits doesn't match, means atomic unit boundary is crossed */
+	if (boundary && ((start | mask) != (end | mask)))
+		return false;
+
+	return true;
+}
+
+
 /*
  * iomap_dio_rw() always completes O_[D]SYNC writes regardless of whether the IO
  * is being issued as AIO or not.  This allows us to optimise pure data writes
@@ -554,12 +611,16 @@ __iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
 	struct blk_plug plug;
 	struct iomap_dio *dio;
 	loff_t ret = 0;
+	bool atomic_write = iocb->ki_flags & IOCB_ATOMIC;
 
 	trace_iomap_dio_rw_begin(iocb, iter, dio_flags, done_before);
 
 	if (!iomi.len)
 		return NULL;
 
+	if (atomic_write && !iter_is_ubuf(iter))
+		return ERR_PTR(-EINVAL);
+
 	dio = kmalloc(sizeof(*dio), GFP_KERNEL);
 	if (!dio)
 		return ERR_PTR(-ENOMEM);
@@ -605,6 +666,9 @@ __iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
 		if (iocb->ki_flags & IOCB_DIO_CALLER_COMP)
 			dio->flags |= IOMAP_DIO_CALLER_COMP;
 
+		if (atomic_write)
+			iomi.flags |= IOMAP_ATOMIC;
+
 		if (dio_flags & IOMAP_DIO_OVERWRITE_ONLY) {
 			ret = -EAGAIN;
 			if (iomi.pos >= dio->i_size ||
@@ -656,6 +720,11 @@ __iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
 
 	blk_start_plug(&plug);
 	while ((ret = iomap_iter(&iomi, ops)) > 0) {
+		if (atomic_write && !iomap_dio_check_atomic(&iomi)) {
+			ret = -EIO;
+			break;
+		}
+
 		iomi.processed = iomap_dio_iter(&iomi, dio);
 
 		/*
diff --git a/fs/iomap/trace.h b/fs/iomap/trace.h
index c16fd55f5595..c95576420bca 100644
--- a/fs/iomap/trace.h
+++ b/fs/iomap/trace.h
@@ -98,7 +98,8 @@ DEFINE_RANGE_EVENT(iomap_dio_rw_queued);
 	{ IOMAP_REPORT,		"REPORT" }, \
 	{ IOMAP_FAULT,		"FAULT" }, \
 	{ IOMAP_DIRECT,		"DIRECT" }, \
-	{ IOMAP_NOWAIT,		"NOWAIT" }
+	{ IOMAP_NOWAIT,		"NOWAIT" }, \
+	{ IOMAP_ATOMIC,		"ATOMIC" }
 
 #define IOMAP_F_FLAGS_STRINGS \
 	{ IOMAP_F_NEW,		"NEW" }, \
diff --git a/include/linux/iomap.h b/include/linux/iomap.h
index 96dd0acbba44..9eac704a0d6f 100644
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@ -178,6 +178,7 @@ struct iomap_folio_ops {
 #else
 #define IOMAP_DAX		0
 #endif /* CONFIG_FS_DAX */
+#define IOMAP_ATOMIC		(1 << 9)
 
 struct iomap_ops {
 	/*
-- 
2.43.0


