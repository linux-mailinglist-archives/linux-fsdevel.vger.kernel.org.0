Return-Path: <linux-fsdevel+bounces-61200-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 26904B55E27
	for <lists+linux-fsdevel@lfdr.de>; Sat, 13 Sep 2025 05:38:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C4E245A6B1E
	for <lists+linux-fsdevel@lfdr.de>; Sat, 13 Sep 2025 03:38:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54B311F874C;
	Sat, 13 Sep 2025 03:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MXX+SM89"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34B711F419B
	for <linux-fsdevel@vger.kernel.org>; Sat, 13 Sep 2025 03:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757734658; cv=none; b=qDwaNFCQiyArFbw7imHxxQ3q2O5Y4lvjU5C1gIth0IsLlwhzlLCush/8xl0ehq7L1RCquuewIplYQkAsW0eT9+W+c85IWkVgLXJGQLonlSKlgnB+cnEbhQ5l30CU+wzOX5fw2FQ4FGzL4d4dSZ9/vL7Ll99YV23Cs9wrPDsxncw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757734658; c=relaxed/simple;
	bh=oxoLeYkcBF241PpwFv0BAx+rwkzBjJ2c1sGVHg2zOuY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FmC1gIekZpOJjq6EKj9gqghE1YB85B4T70uPXvYczZakq54XqA46ZLf7L6FlufVG75Pu9qiDE3i6RuE/n0I7DvS42B5iqDL0RljgHGfGaE8bzVD28+gMoiULDynzfjPC8y1Zn8OImR/QQSz7yu00nVwpv8EfLvuOalCzrDEqMoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MXX+SM89; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-251fc032d1fso27242835ad.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 12 Sep 2025 20:37:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757734656; x=1758339456; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dfcXJBZLCmfYyA3YbUkaDw3XHxbE6UhRnVQlKyLTp6Q=;
        b=MXX+SM89/q5fvlIEbup8ihwJxEILb2Dg2u8AE70nb7yrUp2R2bXRRCosZFQb9nLW6C
         csdWZPuPyy7DY/+0r9b3RQg8BYGhJj8YHnAvOJTZsNzYtENrA3Utsahl+O3St905nXwX
         eCvNvqOoDKz7cD+pOukBPM0neDLI4T5/jRlVXrgEF+pdoQ8LWNndoihtvgLBUKIUuoHA
         Yr1qjRX3Z9SIpVnNntjDAiT/KgHEGmxvlUzQzIwzp3uJLW1IJA6J09caqF0W5VfoAfwG
         DHgfji4tD/Ngbs9k8oQr/zrT3M8kz1rmY9Udvs+xFp0b8qIXw/R/cG/Er/KuJk3lB4Ie
         wiJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757734656; x=1758339456;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dfcXJBZLCmfYyA3YbUkaDw3XHxbE6UhRnVQlKyLTp6Q=;
        b=J6FtzihQ6iPJFd1VNr1vvdgDvYA1pyYHaWPJARZuCK0NmNEk9nitCsvQw/VkzOoOG4
         aCd7PuUzIrIq41Lki06U4BNUaTEbbG4vLn3wnaUoljlqDwnj5F2u91LD0PcMKnwN6WD5
         j/Cdc6he6wngFfUsioNHyybwzSUSSMJLpyAsgfcdzOX7oMGp6qDKqKSqXHT+JinXPtTV
         FC9VhqGC3lCuC9WWOha+WDbuWvYG4lWPkfO1UJaeDhqDXC+HY8G9OCi6skW66RNI1Qq8
         K0jShLYjxovre8pmmpOFo/DSYL87XdvNuyQlTW9qQjCmTP+fZYJ1yQ1PMLjUwPiBPT9Z
         83PA==
X-Forwarded-Encrypted: i=1; AJvYcCXDFvrdomy6i1f15GsEBgJgZMAfwgXbA2NWw72UJFL0obKA9DtzkbfNN1XM7yEsSrCSf7PJrRgZyAAw05I7@vger.kernel.org
X-Gm-Message-State: AOJu0YxM07AUrpntGiX8rmJlvxtjSdv+aLiJCtYzzHQNeGagtUJepjYC
	By3Oj6XTlg3D7CggBIdowC3tz1KCO3hAkRQ87g0fIb3Kd7DCONRT+IGr
X-Gm-Gg: ASbGncs/Oj4JgZKgpSazu+fwrt2+eg7OvPlPAxlUMzwLDYGOCgZP/Z8YeD3QJ82y2SK
	hwlBU697vx8Fd524heKSKOq0ooT+O9yshdznbHlDfkq2ZtUvZuwd0Kq5aQDamw9hpEOcLig5mdR
	SqsI1F951flygJ+HNb9i0V6OJAQMfqsj4vxagVaMSCycuv/EyTWG2UP0gQhyNSBmZzprJHlV6g5
	S+A7Cd22w6IcEZEX4TgRQjNZhbCLygUMJBDc1dB+B57pXRSbXtQMXaz8YF5hnPvYcl6Mb7z/IpO
	dn//rHzho2YJz569r3O2gvMffhXYIAdyl02uJI7d+heCUfY2DR+HYUcKuxFh/l5mjHoAmNsjfKU
	Lbn0EY7Ojse3KOiUZcyILbwLCObotBO6UOg==
X-Google-Smtp-Source: AGHT+IGMBnPdZGGHXedTN9wIo2T02B3lU73VKw9Kl9ZgQvq7+Z196AYaCvOiDVt6BXSPu9nMY+sLTg==
X-Received: by 2002:a17:902:db09:b0:24b:1d30:5b06 with SMTP id d9443c01a7336-25d243ef699mr61019425ad.15.1757734656466;
        Fri, 12 Sep 2025 20:37:36 -0700 (PDT)
Received: from VM-16-24-fedora.. ([43.153.32.141])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32dd98b439asm7150770a91.15.2025.09.12.20.37.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Sep 2025 20:37:36 -0700 (PDT)
From: alexjlzheng@gmail.com
X-Google-Original-From: alexjlzheng@tencent.com
To: hch@infradead.org,
	brauner@kernel.org
Cc: djwong@kernel.org,
	yi.zhang@huawei.com,
	linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jinliang Zheng <alexjlzheng@tencent.com>
Subject: [PATCH 4/4] iomap: don't abandon the whole copy when we have iomap_folio_state
Date: Sat, 13 Sep 2025 11:37:18 +0800
Message-ID: <20250913033718.2800561-5-alexjlzheng@tencent.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250913033718.2800561-1-alexjlzheng@tencent.com>
References: <20250913033718.2800561-1-alexjlzheng@tencent.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jinliang Zheng <alexjlzheng@tencent.com>

Currently, if a partial write occurs in a buffer write, the entire write will
be discarded. While this is an uncommon case, it's still a bit wasteful and
we can do better.

With iomap_folio_state, we can identify uptodate states at the block
level, and a read_folio reading can correctly handle partially
uptodate folios.

Therefore, when a partial write occurs, accept the block-aligned
partial write instead of rejecting the entire write.

For example, suppose a folio is 2MB, blocksize is 4kB, and the copied
bytes are 2MB-3kB.

Without this patchset, we'd need to recopy from the beginning of the
folio in the next iteration, which means 2MB-3kB of bytes is copy
duplicately.

 |<-------------------- 2MB -------------------->|
 +-------+-------+-------+-------+-------+-------+
 | block |  ...  | block | block |  ...  | block | folio
 +-------+-------+-------+-------+-------+-------+
 |<-4kB->|

 |<--------------- copied 2MB-3kB --------->|       first time copied
 |<-------- 1MB -------->|                          next time we need copy (chunk /= 2)
                         |<-------- 1MB -------->|  next next time we need copy.

 |<------ 2MB-3kB bytes duplicate copy ---->|

With this patchset, we can accept 2MB-4kB of bytes, which is block-aligned.
This means we only need to process the remaining 4kB in the next iteration,
which means there's only 1kB we need to copy duplicately.

 |<-------------------- 2MB -------------------->|
 +-------+-------+-------+-------+-------+-------+
 | block |  ...  | block | block |  ...  | block | folio
 +-------+-------+-------+-------+-------+-------+
 |<-4kB->|

 |<--------------- copied 2MB-3kB --------->|       first time copied
                                         |<-4kB->|  next time we need copy

                                         |<>|
                              only 1kB bytes duplicate copy

Although partial writes are inherently a relatively unusual situation and do
not account for a large proportion of performance testing, the optimization
here still makes sense in large-scale data centers.

Signed-off-by: Jinliang Zheng <alexjlzheng@tencent.com>
---
 fs/iomap/buffered-io.c | 44 +++++++++++++++++++++++++++++++++---------
 1 file changed, 35 insertions(+), 9 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 7b9193f8243a..0952a3debe11 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -873,6 +873,25 @@ static int iomap_write_begin(struct iomap_iter *iter,
 	return status;
 }
 
+static int iomap_trim_tail_partial(struct inode *inode, loff_t pos,
+		size_t copied, struct folio *folio)
+{
+	struct iomap_folio_state *ifs = folio->private;
+	unsigned block_size, last_blk, last_blk_bytes;
+
+	if (!ifs || !copied)
+		return 0;
+
+	block_size = 1 << inode->i_blkbits;
+	last_blk = offset_in_folio(folio, pos + copied - 1) >> inode->i_blkbits;
+	last_blk_bytes = (pos + copied) & (block_size - 1);
+
+	if (!ifs_block_is_uptodate(ifs, last_blk))
+		copied -= min(copied, last_blk_bytes);
+
+	return copied;
+}
+
 static int __iomap_write_end(struct inode *inode, loff_t pos, size_t len,
 		size_t copied, struct folio *folio)
 {
@@ -881,17 +900,24 @@ static int __iomap_write_end(struct inode *inode, loff_t pos, size_t len,
 	/*
 	 * The blocks that were entirely written will now be uptodate, so we
 	 * don't have to worry about a read_folio reading them and overwriting a
-	 * partial write.  However, if we've encountered a short write and only
-	 * partially written into a block, it will not be marked uptodate, so a
-	 * read_folio might come in and destroy our partial write.
+	 * partial write.
 	 *
-	 * Do the simplest thing and just treat any short write to a
-	 * non-uptodate page as a zero-length write, and force the caller to
-	 * redo the whole thing.
+	 * However, if we've encountered a short write and only partially
+	 * written into a block, we must discard the short-written _tail_ block
+	 * and not mark it uptodate in the ifs, to ensure a read_folio reading
+	 * can handle it correctly via iomap_adjust_read_range(). It's safe to
+	 * keep the non-tail block writes because we know that for a non-tail
+	 * block:
+	 * - is either fully written, since copy_from_user() is sequential
+	 * - or is a partially written head block that has already been read in
+	 *   and marked uptodate in the ifs by iomap_write_begin().
 	 */
-	if (unlikely(copied < len && !folio_test_uptodate(folio)))
-		return 0;
-	iomap_set_range_uptodate(folio, offset_in_folio(folio, pos), len);
+	if (unlikely(copied < len && !folio_test_uptodate(folio))) {
+		copied = iomap_trim_tail_partial(inode, pos, copied, folio);
+		if (!copied)
+			return 0;
+	}
+	iomap_set_range_uptodate(folio, offset_in_folio(folio, pos), copied);
 	iomap_set_range_dirty(folio, offset_in_folio(folio, pos), copied);
 	filemap_dirty_folio(inode->i_mapping, folio);
 	return copied;
-- 
2.49.0


