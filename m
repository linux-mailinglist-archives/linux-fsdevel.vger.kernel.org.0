Return-Path: <linux-fsdevel+bounces-54593-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F1E8BB015C6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Jul 2025 10:23:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1CEE54817AD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Jul 2025 08:22:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93D071FAC54;
	Fri, 11 Jul 2025 08:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QCS7dZcU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79DBC1FECB4;
	Fri, 11 Jul 2025 08:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752221533; cv=none; b=LouZqeJWkUfOaGgVXnoHEOfbJ3/nbt/GL6Lj4Y5mAXfaPB5J7BvD5EirG1lCMzAqv1/WXuXmX0LIXq/SFTbAE5adbjQzL5ERakA7mAf8z2TA6pgIZ1gyvTm/vh+Kq/Re/AIZDTSRSjZxMV3pLys0E6u1abAhX+1XSrl3elI6Y04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752221533; c=relaxed/simple;
	bh=P/WRYOeJmMfJ9uLcgWCRbsDmLIZYYisRO4sgPekjSMA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fviMuUY0kVlBpU9Imfqa09GPLv8Kh1ZsJBi3Y1QjQWATU2fjcrq9Uk94j/Na+6GMrz4VfhorsjBQckKRT7LXuVkFrjPN/T0j6pW4oR02Hk3OHiakGvrXv6+Uwgw1uO94RU0qxS926c+LZ84SYW1NkTjVO+NPVBC84xYJpv9Hl1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QCS7dZcU; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-747fba9f962so1636893b3a.0;
        Fri, 11 Jul 2025 01:12:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752221531; x=1752826331; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JfnEX4CV8vat7MsTbzHXWZHUFjNxkpFlCdgj6sJoyGA=;
        b=QCS7dZcUuNZiHHMcOCInlQUoOtkQ2veBO1+QUd/p/Sg8RBrSxpTLMkTa6dP6hi2lql
         5Tzl/aE5BlrG6k5UpYT0Kjebb1kOEw+UGQUDMug7vzCRWqC6P18HbfjUxOZpf6HLwCyh
         HsTsKxvW8UksjDDmjkXZWUFCLFSz0jLMBxwaIX4oxQ917MVpC7xrDH9012C3lJyvbF5x
         Y/V8fndhnYFTs/NbZAfnXu9EUy+6dOfXaReZp9EFnrNEnd2nbypdITMeMwH/ffcctpKz
         Up7GM2lBI4oiOEzYOb+Uxil4JmJkVx9GzTXvHPvp7407lzUd5aREdquyoOBOYz2imV/n
         RWig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752221531; x=1752826331;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JfnEX4CV8vat7MsTbzHXWZHUFjNxkpFlCdgj6sJoyGA=;
        b=tyT7v+IrI2BqQfx1VN5Hd1KWIykfWaCOkwv7Sj2ClfGW9Jg9OCyUl7AJYfhnnZMYut
         piT3u3FFcx+GVI66AhtVSl0dqdRuPbgwuD1nvNj4X6MLLpXws1ncidZb9stqYuVM8S/s
         FALBTa2YsAt6WVjFDmvDfilplaLCHatWRZNJ1+De9RX2QHYOTapJ5j4b6MuXepfszmCB
         m7F2RdxyNeHESDkQwll+WRbQW1FKX8SXiRmrmjyuWk4YxqkSuNxRNwo4b6uLVw4N/sGx
         oe2ZOBvrVNUDwWQGzGivBEeLzsCFlhFScls8Scl9CnP+Tv43rFyr5/9DBGbxfMMkDzRm
         vq1A==
X-Forwarded-Encrypted: i=1; AJvYcCVEAkZRJdFsdvcWGb+s7BRkDMdWDAWW54LbE1m/Ro65FxpF2I6f2Q/5BZ4NbDALbfTLpLs+To6MzNQpgJZc@vger.kernel.org, AJvYcCVZMvy5A24vpokHsqINN1SC/qWzHV4yg4JgDLXRjmm3VydVFQlvS9qDRfZCM4HXwvGddrLwQkMHH2zLWwU/@vger.kernel.org
X-Gm-Message-State: AOJu0YzJzqU3t6ksLcty7w57l2w3Hmq/4ZDcvKzmCNoeCTICfoFW0t7Z
	1HfL/XWhzuVVukO8FTz5+33S2hjtbgyf6Dyd4BrLURGuaw8JF3AK8TNnrV7x3Q==
X-Gm-Gg: ASbGncu6tM9OF67I+k/C04Ux76YWfLdgI6cCYS91Tu5lllWSTli9QNAq4q439mmF0BM
	npEWwnL/c5WCxMqHWd2+Uf7XeEtTBffUBp4svSE/onLKx7Xbxf6U4SvX6kB0wvri4MJKjPlW2SM
	9WrvmglFA829opF+EvtBgt2APpkwVG1/7vrUZLRdYgjhdCEQtjdZQKp+h4VQEZ+U085iiApXQGR
	EwN6hoMHhi+mTYVmRbAtTzhpNCGRBRmplRLNaRZytqm8L+EzpV2flwmOwQ+MG56Vjar9TdtDww9
	KMihkZiZmZ57spBoO/WysTngF9CJL19A4oYC1TDtxNKIvYX8OD/amlvp3pZmKP35q2a4Ii4gSSu
	IWgWu0fwQcMq6BkSCaDd15NPmObC7xpAMRuE=
X-Google-Smtp-Source: AGHT+IGIqOP5Nw9y/ybnCinHPlCO2D8U3ySjuxjHPQX1gFrGGxpPyOUoQG9vOk1+p0H9mxeufU9UZg==
X-Received: by 2002:a05:6a00:9086:b0:742:b928:59cb with SMTP id d2e1a72fcca58-74eb5a8d604mr7685707b3a.7.1752221530545;
        Fri, 11 Jul 2025 01:12:10 -0700 (PDT)
Received: from VM-16-24-fedora.. ([43.153.32.141])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74eb9e058fesm4820381b3a.40.2025.07.11.01.12.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jul 2025 01:12:10 -0700 (PDT)
From: alexjlzheng@gmail.com
X-Google-Original-From: alexjlzheng@tencent.com
To: brauner@kernel.org,
	djwong@kernel.org,
	hch@infradead.org,
	willy@infradead.org
Cc: linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jinliang Zheng <alexjlzheng@tencent.com>
Subject: [PATCH v2] iomap: avoid unnecessary ifs_set_range_uptodate() with locks
Date: Fri, 11 Jul 2025 16:12:07 +0800
Message-ID: <20250711081207.1782667-1-alexjlzheng@tencent.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jinliang Zheng <alexjlzheng@tencent.com>

In the buffer write path, iomap_set_range_uptodate() is called every
time iomap_end_write() is called. But if folio_test_uptodate() holds, we
know that all blocks in this folio are already in the uptodate state, so
there is no need to go deep into the critical section of state_lock to
execute bitmap_set().

This is because the folios always creep towards ifs_is_fully_uptodate()
state and once they've gotten there folio_mark_uptodate() is called, which
means the folio is uptodate.

Then once a folio is uptodate, there is no route back to !uptodate without
going through the removal of the folio from the page cache. Therefore, it's
fine to use folio_test_uptodate() to short-circuit unnecessary code paths.

Although state_lock may not have significant lock contention due to
folio lock, this patch at least reduces the number of instructions,
especially the expensive lock-prefixed instructions.

Signed-off-by: Jinliang Zheng <alexjlzheng@tencent.com>
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
Reviewed-by: Christoph Hellwig <hch@infradead.org>
---
Changelog:

V2: Update commit message

V1: https://lore.kernel.org/linux-xfs/20250701144847.12752-1-alexjlzheng@tencent.com/
---
 fs/iomap/buffered-io.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 3729391a18f3..fb4519158f3a 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -71,6 +71,9 @@ static void iomap_set_range_uptodate(struct folio *folio, size_t off,
 	unsigned long flags;
 	bool uptodate = true;
 
+	if (folio_test_uptodate(folio))
+		return;
+
 	if (ifs) {
 		spin_lock_irqsave(&ifs->state_lock, flags);
 		uptodate = ifs_set_range_uptodate(folio, ifs, off, len);
-- 
2.49.0


