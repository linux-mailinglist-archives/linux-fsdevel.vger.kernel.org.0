Return-Path: <linux-fsdevel+bounces-57228-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FF78B1F99C
	for <lists+linux-fsdevel@lfdr.de>; Sun, 10 Aug 2025 12:17:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 956C5189904B
	for <lists+linux-fsdevel@lfdr.de>; Sun, 10 Aug 2025 10:17:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C68B25BEF2;
	Sun, 10 Aug 2025 10:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mFbw6hvG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6581223FC42;
	Sun, 10 Aug 2025 10:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754820968; cv=none; b=OA0MIuIQD6QBaxcl3RvlCnvQCMRZtka9AxN0AEqBYuRLEr6uL9p1KADcs300r0XF6CQJ6I1oHVQpqVXe2ykAaX0E4jM8D+8JXEhcgD46rlVDCsVZmdxYLVBQtZF06R0gQcGonDPhEk4K6slX2Mrfy0iqZvoa16GrgvhRYrc6HwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754820968; c=relaxed/simple;
	bh=rDQIx1s6A6hGmi9HbZcEjXtoTdyxpU+DpS5cyiDpCqs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DDe/fbt9pB5rHEhzhk5lpxR/RHoj/jqZNP0DwqDCCgQZvhGwTaI3r8AAUbqOvegCEJJLSEVzujjKNUuRCKvhOd3UfkygbxC+YVGXeTebvJAcTnDkDSW9fII1o6PfiLz9M6jb2YPkvb7wmG8kv9sXkrQwDWGv34hIzRKfpLHHQxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mFbw6hvG; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-b34a8f69862so2490250a12.2;
        Sun, 10 Aug 2025 03:16:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754820967; x=1755425767; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y2OT5F7bZ/arjZTso2AUwwEE0thLjDqJvHVad93pKuM=;
        b=mFbw6hvGLvoMahE0p51EHAvIUB3WPzywNgIvWj8QsbqTaq+/pMM9y8Gdi/hXytJqep
         1pru4AksJ9UddzlisCFr0aEjZTR2Bbja7tJb3ws38trz54NCBZu/MA9G9Wt2meCKQlfv
         +zxDKifr9/SWtJ+QaP9T48drAZ9WzG4+gBAVDPxqVPH7F5ql4NGSC8iVMleBBnwGlBC3
         iTraatSIQ4b3Htuuu3G32Zw6APLScJo8S4aa/YByMn4f4SDJo99XIayvPQ4yYuKJYdKQ
         uwQ38oB3WSh2boQolLrmicWKr2Kmo9nCPMAP7B8BohAYJD3Lrr1FyQ5ydv9kk4OGleiv
         IiMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754820967; x=1755425767;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y2OT5F7bZ/arjZTso2AUwwEE0thLjDqJvHVad93pKuM=;
        b=w3LLOQxDrJY2Mfeba7CitJANmCaTVDu159IEHed6qDcwISS+9lgMjyklrCILjbaPtV
         mFiEAXFwRBZ/UQeTVj5env44XC3JPm8D1COFJM6lLDVDfLlAJLXvwNwnJTBOAvZDkvrV
         9qLzejUgmJXc1QEfjET3IVg/gWoXON/4mpuCVpl+Sr3zN+UpAXektU3vyh0E38cmSMMa
         TVxebOgXNy3JQnXgD3/9Cinn2KvBJpcfmIiHpUw8e3Tckr87AdVBKVrZYTgNz6O6pTJ/
         pyiPALipThCH3B1pMvDoHOvsx9eYjzSUGuZjUJVQI0X/3Q8vsP7NJUbxyZZyfxCCZFJ2
         iFoA==
X-Forwarded-Encrypted: i=1; AJvYcCWJy+L+DYt1sFEwR/9e/dTbvpf3plkZFncRHHv7bAOn8juyDkGaVvMBfKBN0Hsdx6YPm2M4Jz54kd7pcDID@vger.kernel.org, AJvYcCXQM74ixIaCknYoLjRkw3XFdGoMPRXsHU2gqxdxAg21uRKScB1uI/tnp4aQcswg1ZHNV38EfQVvUxF4sV5Y@vger.kernel.org
X-Gm-Message-State: AOJu0Yyp1euaY+W1QPX3wfLxb/4zDEIT4vzOWx+r0NnWG5oBwZq23PRg
	+zaUs2IG1SMZa/FA9YLHJNDE0YYRrs+3mvbEr6mZ/HNLeHpH+KwceQjM
X-Gm-Gg: ASbGncsLcPywx2W386SnOAGEkJokk8IfLnqGV91jTk1iRw+i1UUeLqPoEny5BxvXxc6
	j4tA3CK3fvIxB9qgcuzjWBTNJK3nOPnt7CfDz4dp3f9CwAtGFWnBB/b49mQRtxG+XFinh5mQAx/
	eW4JzM046p3/EuUpN1xnlBfmHOHQaHkRiKmpnt4rBfWa5LzmyLtZs/89tWzrCG6RmmkUXCpL+ft
	oVAjIIFoaxU49SVUyoMkUd2YxQdUHbSvsqRzV1ipv7fU4zOaUwNIc/nH0jxsXp1OfeZdM9K4xal
	HtT4gqmZWIfmmnG5JKMr8AhBEJ5YFhu1JTtqN5blqHo7dZlLBCHCrOyePwotCavI+he+vDF1vVB
	YY1Fij/aTBCNzoyW4g8N/D8qU2Py8pJPapjXwBmNIO4Rfcg==
X-Google-Smtp-Source: AGHT+IEfzIB/bMwT0gz0dl/X1susnwXrNxFT85X7Tg/EAtUZIdu1PG7GaBu71SPqPgTGFInFXAWt6A==
X-Received: by 2002:a17:90b:48c4:b0:31e:fe18:c6df with SMTP id 98e67ed59e1d1-32183e32f54mr15165340a91.16.1754820966597;
        Sun, 10 Aug 2025 03:16:06 -0700 (PDT)
Received: from VM-16-24-fedora.. ([43.153.32.141])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32161259329sm11923432a91.17.2025.08.10.03.16.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Aug 2025 03:16:06 -0700 (PDT)
From: alexjlzheng@gmail.com
X-Google-Original-From: alexjlzheng@tencent.com
To: brauner@kernel.org,
	djwong@kernel.org
Cc: linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jinliang Zheng <alexjlzheng@tencent.com>
Subject: [PATCH v2 4/4] iomap: don't abandon the whole thing with iomap_folio_state
Date: Sun, 10 Aug 2025 18:15:54 +0800
Message-ID: <20250810101554.257060-5-alexjlzheng@tencent.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250810101554.257060-1-alexjlzheng@tencent.com>
References: <20250810101554.257060-1-alexjlzheng@tencent.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jinliang Zheng <alexjlzheng@tencent.com>

With iomap_folio_state, we can identify uptodate states at the block
level, and a read_folio reading can correctly handle partially
uptodate folios.

Therefore, when a partial write occurs, accept the block-aligned
partial write instead of rejecting the entire write.

Signed-off-by: Jinliang Zheng <alexjlzheng@tencent.com>
---
 fs/iomap/buffered-io.c | 32 +++++++++++++++++++++++++++-----
 1 file changed, 27 insertions(+), 5 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index f80386a57d37..19bf879f3333 100644
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
@@ -886,12 +905,15 @@ static int __iomap_write_end(struct inode *inode, loff_t pos, size_t len,
 	 * read_folio might come in and destroy our partial write.
 	 *
 	 * Do the simplest thing and just treat any short write to a
-	 * non-uptodate page as a zero-length write, and force the caller to
-	 * redo the whole thing.
+	 * non-uptodate block as a zero-length write, and force the caller to
+	 * redo the things begin from the block.
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


