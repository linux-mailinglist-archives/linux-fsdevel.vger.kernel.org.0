Return-Path: <linux-fsdevel+bounces-34154-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 207229C3332
	for <lists+linux-fsdevel@lfdr.de>; Sun, 10 Nov 2024 16:31:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB15B1F213B9
	for <lists+linux-fsdevel@lfdr.de>; Sun, 10 Nov 2024 15:31:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9309C158531;
	Sun, 10 Nov 2024 15:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="jpxkdGSA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79D9B156F5F
	for <linux-fsdevel@vger.kernel.org>; Sun, 10 Nov 2024 15:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731252568; cv=none; b=qoA1FHb0cqmqUbM1qjxx4VyhaToDXAWH20rkWy2YslXMlwh0pdprt1lRP3FUQdyP80cmSlOu5stuGz9PSPpOnam01y/LRckJnbH5/z4YD/M99RJgh8AqURu2NYbF9mkEJRmI8XisjuHc9l+r1S10B7j1cUrOpJK6sGEEWctQJp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731252568; c=relaxed/simple;
	bh=AKt+S745U93BEmbA6t/wcRBIgQj/soY+rT3nJS7qXJU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JL2gF/I6U8OUidraJa+cDu9epFGKVU1mWKonfGVnR8xB1oOIjoZiB55Z/LTAAaXJSqcwu5c53CBnpYdrM/RQKUEOGwzeqDeyJ+I0gqHfAkEpA6xHpZzJy+jV3lKwUIxdszDRWPS46nh8mzIi0DknIm42aDyOVpyx0cu0FF9xxb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=jpxkdGSA; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-21145812538so34653245ad.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 10 Nov 2024 07:29:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1731252566; x=1731857366; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xtqsp3FpRWE9h3nra5m9D1cpUkXI8hkSCKuFCrWSblw=;
        b=jpxkdGSACE2RIfxZR30I6RLxlbnIVcV8CQP+caD3TJTf9MGEGC2rENCIMrdqFSyPRW
         sximQLDX7ngw6JwKo6AoBMqN06YroHpC69obYTg9zcR5TfthsZZKuRbYrE4DxXnDpU+W
         yNp+1ynCzu3wN3TExVe/C0PsKAYsSkZusARdnCjiszGVukDMpprVY8wcpxSJn8tJNM/A
         DojcecxZxsAZafCdfcjlenpPY0f1UhUBl2p0KFkYWWdxG3LXKTHoTUbrm22m5NvlpL9D
         tfYK5FwXHhCl7N+++ecZbUuTVnkhOQeBJHYZ0QrL8yM7tLJY1HQ1KkcNb8WwDQTc8uV+
         pAjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731252566; x=1731857366;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xtqsp3FpRWE9h3nra5m9D1cpUkXI8hkSCKuFCrWSblw=;
        b=iCKx4PEsbMYYWDn93ESPNWAgbS6Z591xOHRlhGm8OeZfOBRhoGe5QlqyVWn2qyaPka
         x0NtV9QpuqxQ2bsPEKOFYzji8LmgK7Nz4MBPt5w0g4y2J4ctvZFRy7BGL8iAtkDWwT4q
         XnUEnaeCCa2V3ofJlOJEe9Rp12SmhVZSfBFSxfJ5UH4c7zYY0XlvDSsbPrPGI15ARXMB
         8vQsA58+FdZ/uigKlLbADolLHouQ/KYwGGJIUMsggo8yCYZ/lPJIfHnHjEimCdINzlER
         eUykJj01KajZJKdWV+EWACR4/fJWH+w6KrujFjjTEmuOaHVdEwg4joGwUpNy0Xwnywo0
         rGKw==
X-Forwarded-Encrypted: i=1; AJvYcCVpI5LsmN7GSp+cHaANI6LLVdCx7Hd2gd0/YjUS3aN7eNmc/FxdGwrDnLYGyCViCL9iNLaVsthSGsOay1//@vger.kernel.org
X-Gm-Message-State: AOJu0YySOSDGb4UuR86hTvnSLnt/NUo9GdFMz6JbAYGSy8P9QNcVJoif
	HOIEHGYS/fmBrHJW1jQ9f7p1cRqaj6TTP3Og9R3GpK46NEqd7sJnY38UG2/s7rI=
X-Google-Smtp-Source: AGHT+IF5qTNuztLawL22nFdoWM3hBa8g+iEMn3AucUKZX2m0zot7CflQJgWfjjOvLTZBT0mpwh+/bA==
X-Received: by 2002:a17:902:cf02:b0:20c:af07:a816 with SMTP id d9443c01a7336-21183d087c7mr129753345ad.31.1731252566678;
        Sun, 10 Nov 2024 07:29:26 -0800 (PST)
Received: from localhost.localdomain ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e99a5f935dsm9940973a91.35.2024.11.10.07.29.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Nov 2024 07:29:25 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org
Cc: hannes@cmpxchg.org,
	clm@meta.com,
	linux-kernel@vger.kernel.org,
	willy@infradead.org,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 09/15] mm/filemap: drop uncached pages when writeback completes
Date: Sun, 10 Nov 2024 08:28:01 -0700
Message-ID: <20241110152906.1747545-10-axboe@kernel.dk>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241110152906.1747545-1-axboe@kernel.dk>
References: <20241110152906.1747545-1-axboe@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If the folio is marked as uncached, drop pages when writeback completes.
Intended to be used with RWF_UNCACHED, to avoid needing sync writes for
uncached IO.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 mm/filemap.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/mm/filemap.c b/mm/filemap.c
index bd698340ef24..efd02b047541 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -1600,6 +1600,23 @@ int folio_wait_private_2_killable(struct folio *folio)
 }
 EXPORT_SYMBOL(folio_wait_private_2_killable);
 
+/*
+ * If folio was marked as uncached, then pages should be dropped when writeback
+ * completes. Do that now. If we fail, it's likely because of a big folio -
+ * just reset uncached for that case and latter completions should invalidate.
+ */
+static void folio_end_uncached(struct folio *folio)
+{
+	bool reset = true;
+
+	if (folio_trylock(folio)) {
+		reset = !invalidate_complete_folio2(folio->mapping, folio, 0);
+		folio_unlock(folio);
+	}
+	if (reset)
+		folio_set_uncached(folio);
+}
+
 /**
  * folio_end_writeback - End writeback against a folio.
  * @folio: The folio.
@@ -1610,6 +1627,8 @@ EXPORT_SYMBOL(folio_wait_private_2_killable);
  */
 void folio_end_writeback(struct folio *folio)
 {
+	bool folio_uncached;
+
 	VM_BUG_ON_FOLIO(!folio_test_writeback(folio), folio);
 
 	/*
@@ -1631,9 +1650,13 @@ void folio_end_writeback(struct folio *folio)
 	 * reused before the folio_wake_bit().
 	 */
 	folio_get(folio);
+	folio_uncached = folio_test_clear_uncached(folio);
 	if (__folio_end_writeback(folio))
 		folio_wake_bit(folio, PG_writeback);
 	acct_reclaim_writeback(folio);
+
+	if (folio_uncached)
+		folio_end_uncached(folio);
 	folio_put(folio);
 }
 EXPORT_SYMBOL(folio_end_writeback);
-- 
2.45.2


