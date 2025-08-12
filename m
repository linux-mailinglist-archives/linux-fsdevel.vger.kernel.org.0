Return-Path: <linux-fsdevel+bounces-57495-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D07DB222CD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Aug 2025 11:20:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C5D5620C5A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Aug 2025 09:16:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB4CC2E9752;
	Tue, 12 Aug 2025 09:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jyqRxKVH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A27EE2E9723;
	Tue, 12 Aug 2025 09:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754990161; cv=none; b=CpAQ1YlvdMRA8ayVZ513jIztu6YWCFP8UANEzmT3962Xk2PL58itIayNuA0xIXw5IP/pAnaZyBk8/F+ieUJszD7NTaKTLEkf66sTPWMC8Ko68nr1hMFylYNtornOpAqLlWeU8/AS0iTa1Bi0eExWfrfzKoYF8XSwyPmnEzNeJGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754990161; c=relaxed/simple;
	bh=ycpaoNa3MN6uF82TEzzmVwGPWKJsfjTrnr+qTVnDsf8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oaqB5Jh5F7bPkDmTJBoXGpg346E74ZoObiix8/9MKbT9X6Ka77sKUrF+5UCV4fecxfmFZXpb0L312QH1+FxKOuCyRVs1vPgAtSrq0W7EvNgpBxHR8GLEMZv4KGLEWb4TqezqWKWNLFo2xEFMl7SQ+cIlIne5aR4jeCrNH4Nfz+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jyqRxKVH; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-b390136ed88so4005823a12.2;
        Tue, 12 Aug 2025 02:15:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754990159; x=1755594959; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kUVL95c0pEIZMhDo9pFvxVeTSyzxblZ+STNvH3cwOYE=;
        b=jyqRxKVHmc5b5qikZCDP2X0up4I8ag6MpJcR1kv4k7Oc4B/yzomAC/ftGkMWNicI9n
         GfbN4EGNR0ivlitts5xzET8xD/ER+rreN4ePD8YQ8kO/HqCGuMLrRhsDQapMwNWWXsKa
         gVwo1pWzYb/V5NRlUyTswgj4fsf06kOsiD3JKvDK9L93GPstT4BLvvcHiUOjzQ7P/E6p
         hcqqns/bcUcPW1qUG86erE532v3lv0dTxKWnVWUoH+YnCvle1l5EtPYO0MXMKML1QYhY
         2IVytLS/juGQgWbMhL9/V/qjfYySXaVunM1mqmwtah/PWm6kbePJC4v5ENY6R0IhERvc
         Tcyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754990159; x=1755594959;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kUVL95c0pEIZMhDo9pFvxVeTSyzxblZ+STNvH3cwOYE=;
        b=MIFshHrizpEDjKDuNLsCv1U3Og0KcvZojtCL1rglK8E21gX+7tKuSArl/436kBXqJM
         CWWw80GGqszBN3yb15efbgrP2SzDnGg2YUrzwTjQcSFlVmOzdEAhOhtA6Sm0nEPmqQr/
         2mSztv6JtwGl+Y5cSEFJrcF7tnMsQwTlwnFMr2FjAlBaD/4E7JNan+/HIV4SvlF19Ayv
         LIvF+uLe/6DSzNY7GmgOqI5r8T4gnMPFhCLAGLsVAWO6VqKTec5xNyhi18Klt20q3IIv
         1L/CMOAuw/6rUc0FSbqt/YU6QgezTBc3ZxO9mXYETh6OnDBAg+zLGjP/MYcTp+EKaGM6
         ew2w==
X-Forwarded-Encrypted: i=1; AJvYcCWLM4hjMwoIdyL5t+fr2WiUrUwQOWdCBc0edmr1VbmzbtfF6TGCXukqVkXC7AchgvPAHadGPo2rcJPW5rQc@vger.kernel.org, AJvYcCX8xYoqtpgSf6UFtqEEfFAvE5s4Lz3IQwhAfoRc/jodUWYBO5UPSTeES7r4jNu/bxv4DhGgIUvMYmEwzRzo@vger.kernel.org
X-Gm-Message-State: AOJu0YwVlE+G9Kk+39P1vMqtiPoGoPWDbk22Awn/quJuEvNWSllst/Xq
	lVLijwIAZwzXfvwKrZ3M7oyU8upmTLgIH01Vy0tSZQe0FElWTrUoFZKE
X-Gm-Gg: ASbGncta64flWALxDRRPyGVfclOCE55mVzsrkH3gHc0rFkupZUXQZIOOb0goTooan12
	wiaIwuhfW1Lnm4DcsQAYpdHGLE/6tyhtyK9WI46Jh7BE85+Lx9KEdrzBt/bwZSu+htqpntCuToR
	zFdU1fcLW3yyFGbIomMxnboA4O7UBY7Sd+dJHo9HP1Vwn+RuIN9PuDkXmWCvETi24HfWtvuQNE1
	lPVrPTShElPpumSqmBS//rcjgMcdzLjvNCltHJ9tneIsNF2ykVJT0gDMI8/+IHNLalPgmxa+c4U
	YMTXgOBnqW/Wf06olUNFdgtYwzs0SwykPPt19/PcGhKBs3tijkZDlaAz8baLIiuIFgYqPGU31hl
	kUChtoATqTVnDGgG3laodDQshzSKoZrj3nlI=
X-Google-Smtp-Source: AGHT+IG6s8wRhNll09E9mnFMqnkGHcJHCk3ofhuGPJ7PDVhD420zRD/2YPXhHcnAq8Kxiqco4LDBqQ==
X-Received: by 2002:a17:902:da92:b0:242:accd:bbe8 with SMTP id d9443c01a7336-242fc36829fmr43178685ad.36.1754990158712;
        Tue, 12 Aug 2025 02:15:58 -0700 (PDT)
Received: from VM-16-24-fedora.. ([43.153.32.141])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241d1f1efe8sm291670665ad.69.2025.08.12.02.15.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Aug 2025 02:15:58 -0700 (PDT)
From: alexjlzheng@gmail.com
X-Google-Original-From: alexjlzheng@tencent.com
To: brauner@kernel.org,
	djwong@kernel.org
Cc: linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	yi.zhang@huawei.com,
	Jinliang Zheng <alexjlzheng@tencent.com>
Subject: [PATCH v3 3/4] iomap: make iomap_write_end() return the number of written length again
Date: Tue, 12 Aug 2025 17:15:37 +0800
Message-ID: <20250812091538.2004295-4-alexjlzheng@tencent.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250812091538.2004295-1-alexjlzheng@tencent.com>
References: <20250812091538.2004295-1-alexjlzheng@tencent.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jinliang Zheng <alexjlzheng@tencent.com>

In the next patch, we allow iomap_write_end() to conditionally accept
partial writes, so this patch makes iomap_write_end() return the number
of accepted write bytes in preparation for the next patch.

Signed-off-by: Jinliang Zheng <alexjlzheng@tencent.com>
---
 fs/iomap/buffered-io.c | 27 +++++++++++++--------------
 1 file changed, 13 insertions(+), 14 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 109c3bad6ccf..7b9193f8243a 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -873,7 +873,7 @@ static int iomap_write_begin(struct iomap_iter *iter,
 	return status;
 }
 
-static bool __iomap_write_end(struct inode *inode, loff_t pos, size_t len,
+static int __iomap_write_end(struct inode *inode, loff_t pos, size_t len,
 		size_t copied, struct folio *folio)
 {
 	flush_dcache_folio(folio);
@@ -890,11 +890,11 @@ static bool __iomap_write_end(struct inode *inode, loff_t pos, size_t len,
 	 * redo the whole thing.
 	 */
 	if (unlikely(copied < len && !folio_test_uptodate(folio)))
-		return false;
+		return 0;
 	iomap_set_range_uptodate(folio, offset_in_folio(folio, pos), len);
 	iomap_set_range_dirty(folio, offset_in_folio(folio, pos), copied);
 	filemap_dirty_folio(inode->i_mapping, folio);
-	return true;
+	return copied;
 }
 
 static void iomap_write_end_inline(const struct iomap_iter *iter,
@@ -915,10 +915,10 @@ static void iomap_write_end_inline(const struct iomap_iter *iter,
 }
 
 /*
- * Returns true if all copied bytes have been written to the pagecache,
- * otherwise return false.
+ * Returns number of copied bytes have been written to the pagecache,
+ * zero if block is partial update.
  */
-static bool iomap_write_end(struct iomap_iter *iter, size_t len, size_t copied,
+static int iomap_write_end(struct iomap_iter *iter, size_t len, size_t copied,
 		struct folio *folio)
 {
 	const struct iomap *srcmap = iomap_iter_srcmap(iter);
@@ -926,7 +926,7 @@ static bool iomap_write_end(struct iomap_iter *iter, size_t len, size_t copied,
 
 	if (srcmap->type == IOMAP_INLINE) {
 		iomap_write_end_inline(iter, folio, pos, copied);
-		return true;
+		return copied;
 	}
 
 	if (srcmap->flags & IOMAP_F_BUFFER_HEAD) {
@@ -934,7 +934,7 @@ static bool iomap_write_end(struct iomap_iter *iter, size_t len, size_t copied,
 
 		bh_written = block_write_end(pos, len, copied, folio);
 		WARN_ON_ONCE(bh_written != copied && bh_written != 0);
-		return bh_written == copied;
+		return bh_written;
 	}
 
 	return __iomap_write_end(iter->inode, pos, len, copied, folio);
@@ -1000,8 +1000,7 @@ static int iomap_write_iter(struct iomap_iter *iter, struct iov_iter *i,
 			flush_dcache_folio(folio);
 
 		copied = copy_folio_from_iter_atomic(folio, offset, bytes, i);
-		written = iomap_write_end(iter, bytes, copied, folio) ?
-			  copied : 0;
+		written = iomap_write_end(iter, bytes, copied, folio);
 
 		/*
 		 * Update the in-memory inode size after copying the data into
@@ -1315,7 +1314,7 @@ static int iomap_unshare_iter(struct iomap_iter *iter,
 	do {
 		struct folio *folio;
 		size_t offset;
-		bool ret;
+		int ret;
 
 		bytes = min_t(u64, SIZE_MAX, bytes);
 		status = iomap_write_begin(iter, write_ops, &folio, &offset,
@@ -1327,7 +1326,7 @@ static int iomap_unshare_iter(struct iomap_iter *iter,
 
 		ret = iomap_write_end(iter, bytes, bytes, folio);
 		__iomap_put_folio(iter, write_ops, bytes, folio);
-		if (WARN_ON_ONCE(!ret))
+		if (WARN_ON_ONCE(ret != bytes))
 			return -EIO;
 
 		cond_resched();
@@ -1388,7 +1387,7 @@ static int iomap_zero_iter(struct iomap_iter *iter, bool *did_zero,
 	do {
 		struct folio *folio;
 		size_t offset;
-		bool ret;
+		int ret;
 
 		bytes = min_t(u64, SIZE_MAX, bytes);
 		status = iomap_write_begin(iter, write_ops, &folio, &offset,
@@ -1406,7 +1405,7 @@ static int iomap_zero_iter(struct iomap_iter *iter, bool *did_zero,
 
 		ret = iomap_write_end(iter, bytes, bytes, folio);
 		__iomap_put_folio(iter, write_ops, bytes, folio);
-		if (WARN_ON_ONCE(!ret))
+		if (WARN_ON_ONCE(ret != bytes))
 			return -EIO;
 
 		status = iomap_iter_advance(iter, &bytes);
-- 
2.49.0


