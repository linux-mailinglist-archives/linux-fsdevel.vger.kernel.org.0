Return-Path: <linux-fsdevel+bounces-37964-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BFFB89F95DF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Dec 2024 16:56:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6DAEE1893C91
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Dec 2024 15:52:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ECE62206B0;
	Fri, 20 Dec 2024 15:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="rQoXGEdg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14E8321D5BB
	for <linux-fsdevel@vger.kernel.org>; Fri, 20 Dec 2024 15:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734709733; cv=none; b=QKjqPpeaq/2OJ74Yhe/o8IfUSoh8b+e+LlU6utmp+IjMDo1wnqch0Q73nFWQxWlXHAUGn8yHCb7TJt1UYKlRoua6pdI9Js1KZAPGW5HAGxCYzfPmxO9P9v8w07Q7ciy7sTn9vZnGAunWph4Q0NKlt604k1RDccFbE4Xq2/dCj3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734709733; c=relaxed/simple;
	bh=nMl1WIMQHt2bPQz6aG6MCeSjhSpxjtnQ2LzuXFwS3EE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FBgqOj7GID5cfWzYMwKs3spJ8MJIFWA9/j1fg8aGTOfs2N7wHW7smSZAe2fjfMGwxzgybewh6jYq3s7tjTORCQzqMETqf8DB5JkIflrDg54xhoim1YajYBctce5pGmocQ7fEeusu8t+18/J0437a4rcGUDQ+70CYKTp8ojtuJYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=rQoXGEdg; arc=none smtp.client-ip=209.85.166.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-3a8c7b02d68so14944085ab.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 20 Dec 2024 07:48:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1734709731; x=1735314531; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=86GdD84SMshyNZnB2LgwxYI5vb/3z8g/QfHnuRLr9vU=;
        b=rQoXGEdgBAzash2UkPI/h6AWqTly2sPjVW9b7hA4HKvUEDfPRY9hME8xK+5OHk9dPB
         imdsvJiZzoYLSP1vgailaI0VzLusxo0vLieDcqeeQsKtokxL9Y8ZP3QaILODAfuWpe8R
         1StjFxmLHfw26Thl9noyWzN8NYsirgyQkUFyhe2nQAs4waoVe01LDIQsJOzfrAd1+4b4
         reZMrtNARzwTYhjFHd+s3dWJ7Wjg9zBWH1SZ//2Lk3JMTczFKAFrBRdlDnf8vYolCv7N
         kynphxojBktG2JkHYrhoDacuNHMOPY9LODRFxN4kdxcuG4IeO6nP5L9fpm6gAs/Jm4sz
         3vZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734709731; x=1735314531;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=86GdD84SMshyNZnB2LgwxYI5vb/3z8g/QfHnuRLr9vU=;
        b=SWtgNKkDnJ+CxVUV1ZWZAeFSWK3HLURlBhNYZnjEj4AB8glM7vGCLwBjZ8usBriNCa
         NBUHVJWbbwh90t0iRQL30grFYXPJvO6EcG/EhwQKyW2ac75nw9NyotCh+zNyur+iH9o/
         9kQ1+uVO1LGbQuS82cGora/KvjJ8hZsEaoHHEwbNzUArofi3paaukxOCH1QuUn/r19u6
         cscQXrHaJsX8xa6UW+8R62j2whQeIC2PtAXYPcDkEAamEMcwx/Bs+KDs1hwFnemz7t1i
         pJvKvjw5AJpLd8z6qLAdJVj8k2wJbCvhdqCnoNT8nfrKNCubM39fttT6FKCVUHxS53J6
         FV9w==
X-Forwarded-Encrypted: i=1; AJvYcCU8zAmJnPhBRCG8RGQLlT465JKPtfwDKf62XSPUb5jbH6gPDudk+VaCj0966rP/3n+Z7gtL+DZnaRCbvgC9@vger.kernel.org
X-Gm-Message-State: AOJu0Yx050LSyP8dLhUcZdVS+eNLojT86+uitwoYk7jALcPnzV/RzM1Y
	0ANyoo/kIRezoBBCT4nJL61FYtz7CegTIMOAmpIDPoPcspmoCxkhAvRYNaa4ub1vXV0DhISqdBW
	D
X-Gm-Gg: ASbGncswUyYu//iXZbkAHi+FSttQKEjTjXxtIa0qbAIDJongA25JuKlm1/hTvSjU30m
	dYpW0wxNXoSfxgMd8Fb3LW/NJDTl+7h47IxKx07ii/bqJ0vknaz4O43oeZghtZ2XTjjmDanZbx2
	3o3uhKvuJDfNRvAJ6gMTK4slIYUzMLDloVrTE9EM8whoFsHuJZHnj46I9NG4EM+xYHdxwbJ4vB+
	N9WgQ3P8GYk/ZlxhjjQIIIfJe7v4Ku45qy1OcecEVRMu/9ftJLszD1ItWRH
X-Google-Smtp-Source: AGHT+IENwEpB78XkZV/FFvO7zp/8wAKDMGCn+bUr8XfGQ9+IvUs//gy2KTAuIDXDGGYGOcgB+kegLA==
X-Received: by 2002:a05:6e02:20c1:b0:3a7:e3e3:bd57 with SMTP id e9e14a558f8ab-3c2d533e943mr33235325ab.15.1734709731154;
        Fri, 20 Dec 2024 07:48:51 -0800 (PST)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4e68bf66ed9sm837821173.45.2024.12.20.07.48.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Dec 2024 07:48:50 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org
Cc: hannes@cmpxchg.org,
	clm@meta.com,
	linux-kernel@vger.kernel.org,
	willy@infradead.org,
	kirill@shutemov.name,
	bfoster@redhat.com,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 12/12] mm: add FGP_DONTCACHE folio creation flag
Date: Fri, 20 Dec 2024 08:47:50 -0700
Message-ID: <20241220154831.1086649-13-axboe@kernel.dk>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241220154831.1086649-1-axboe@kernel.dk>
References: <20241220154831.1086649-1-axboe@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Callers can pass this in for uncached folio creation, in which case if
a folio is newly created it gets marked as uncached. If a folio exists
for this index and lookup succeeds, then it will not get marked as
uncached. If an !uncached lookup finds a cached folio, clear the flag.
For that case, there are competeting uncached and cached users of the
folio, and it should not get pruned.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 include/linux/pagemap.h | 2 ++
 mm/filemap.c            | 5 +++++
 2 files changed, 7 insertions(+)

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 5da4b6d42fae..64c6dada837e 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -710,6 +710,7 @@ pgoff_t page_cache_prev_miss(struct address_space *mapping,
  * * %FGP_NOFS - __GFP_FS will get cleared in gfp.
  * * %FGP_NOWAIT - Don't block on the folio lock.
  * * %FGP_STABLE - Wait for the folio to be stable (finished writeback)
+ * * %FGP_DONTCACHE - Uncached buffered IO
  * * %FGP_WRITEBEGIN - The flags to use in a filesystem write_begin()
  *   implementation.
  */
@@ -723,6 +724,7 @@ typedef unsigned int __bitwise fgf_t;
 #define FGP_NOWAIT		((__force fgf_t)0x00000020)
 #define FGP_FOR_MMAP		((__force fgf_t)0x00000040)
 #define FGP_STABLE		((__force fgf_t)0x00000080)
+#define FGP_DONTCACHE		((__force fgf_t)0x00000100)
 #define FGF_GET_ORDER(fgf)	(((__force unsigned)fgf) >> 26)	/* top 6 bits */
 
 #define FGP_WRITEBEGIN		(FGP_LOCK | FGP_WRITE | FGP_CREAT | FGP_STABLE)
diff --git a/mm/filemap.c b/mm/filemap.c
index 9842258ba343..68bdfff4117e 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2001,6 +2001,8 @@ struct folio *__filemap_get_folio(struct address_space *mapping, pgoff_t index,
 			/* Init accessed so avoid atomic mark_page_accessed later */
 			if (fgp_flags & FGP_ACCESSED)
 				__folio_set_referenced(folio);
+			if (fgp_flags & FGP_DONTCACHE)
+				__folio_set_dropbehind(folio);
 
 			err = filemap_add_folio(mapping, folio, index, gfp);
 			if (!err)
@@ -2023,6 +2025,9 @@ struct folio *__filemap_get_folio(struct address_space *mapping, pgoff_t index,
 
 	if (!folio)
 		return ERR_PTR(-ENOENT);
+	/* not an uncached lookup, clear uncached if set */
+	if (folio_test_dropbehind(folio) && !(fgp_flags & FGP_DONTCACHE))
+		folio_clear_dropbehind(folio);
 	return folio;
 }
 EXPORT_SYMBOL(__filemap_get_folio);
-- 
2.45.2


