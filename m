Return-Path: <linux-fsdevel+bounces-49910-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8849BAC4FD8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 May 2025 15:33:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3CD573B2A3E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 May 2025 13:33:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93244274FE3;
	Tue, 27 May 2025 13:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="0z/AurMq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 846892749E5
	for <linux-fsdevel@vger.kernel.org>; Tue, 27 May 2025 13:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748352787; cv=none; b=JPnwqVrCqkRJwutOo07tqODRue3aGSliTDBF2qMimWzp/E7P0yFO1VHzdSY9jtTnODE5giPUppmk6xUFb6dd9dB55kQLlfC6KY4vdZvSOkb4upunFLNQgdv8Z70jo3gmVxqNhkiWX5LotnqhDYde0eG3F/8ySjxhEga3ZxJaVu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748352787; c=relaxed/simple;
	bh=g3jNXd5f4YE2QTYxN//ZZYN0VMjcyb5RSi6zIy+/NAQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DiiAw4qnsPlW7umfxrZoKZqqz8VXDKm7wpAv0ESXcvA1vjETEXS4evLMvMxnO1Q7QvWVl7BIjAYN6iKin8eUAAqnybSabvQ2FBxeqZ6cB4wI1fLGJPxWBZ6RbmBF4zM1T3/XAsrnNe6ARBZ81Q1iKDopUKrVUVPFZUew94Wt/kA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=0z/AurMq; arc=none smtp.client-ip=209.85.166.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f181.google.com with SMTP id e9e14a558f8ab-3d8020ba858so29819245ab.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 27 May 2025 06:33:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1748352784; x=1748957584; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YigTW3TLYXri3BMTK0ET9lWA9qX/r7cT516Z/9S9JW8=;
        b=0z/AurMqUGQBIRUMjmUrR+FpEkg2oWPCYlAaK3lXM5p2MhQ1a9UxTM6mw4DcqwfUL6
         W41uIseEe/r29oa6bXkaBcX5lfqDbHPWjxF0p3wg/NEp/JPt7g3wKHEzUJX0KHv4ehXU
         +ZnkujMyb5gKqmME7FPJdz+q4Fsi2dU6L2RloWFE+RrYJ4rDQNrXViXJY+JnIlcDcTFd
         t3NTAfyjCHp+/wf2tl2zheCJ6dNeak5/mBBWa1oT37QShNwqZkDzawj4iQ266k4JSpDY
         zn2DBci1figLjw289WQ4utEAT9Y72w5gxPPCUHQeZl6weaWXlva8Uxt6RrAtCR1mVENP
         KvPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748352784; x=1748957584;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YigTW3TLYXri3BMTK0ET9lWA9qX/r7cT516Z/9S9JW8=;
        b=JQaEmNx/NbYfSWPt1ONUGpWngaN3i/SnfYV8s45SbcxCoObT8Pb+CiKwkbkZTlROkF
         lLOJ2ICASoZ7jGEyCiC2xlJ+SqF0AQPMlZRDirlL0movpAzDOjZW6tbCG7TvanksmKtX
         pSJWvM1YtHrVFQUG3aHCAALwyDYEwU3UW4OkFlmUe2n580JaT7VGeCu2jj5BTm7vrgRK
         KHTK/Z3pwwkLD3fMecBvHMw3YOltOTqYomY3DFwr/Rbdbz/8IaEZ9AJfBcMW2BgDik5i
         noO8+2LRoKOvVr9BrZMR4aadRGW6t3uyPWKUHlj42o04mKXT8KCV9UemhnEkIo3e8Xn0
         1z6Q==
X-Gm-Message-State: AOJu0Yy9R+GRP4EGi56XmyYv4a9GhpPA0L6B3th5BWyNFMZr9ln7aEcW
	9z3gy+D42unqijiAKdLZiXAOk3L6IfqGnAWOBkWvUUuZvUnuMCa3hl9k502JhY9UIfk7+nFBudU
	73Hvz
X-Gm-Gg: ASbGnctm+lwgKr6LsfdYKsYBwHl91EhjDDapUH77VEpDs3G70y7uM6Qid4fzJ+EP2H4
	IqNYQILJFF17dV44IeixlpVlp4ktbDooHbOzdVtbENtMWkAPVhGcZck1mki0S1gsGWfn29CHzPn
	ddw/oifZsk/WKTC3nSA6gwgfCqbF8MlBBn0uqHjur/Mqz6f/jCV/9ZiXPMvMWAXxKlB4LzuS1O3
	W96sT4a4ajxirWHffFgUJYhWnzAc6AaSzGT7Ez9jA5GAu8tIqON72yHOZyENZEfVgGHX0KOVm8B
	9Nbmzws3PmKUzGuETvGbKShuMRJn0hgUvUPfqHKI7UWMaQQucOM/EmQ=
X-Google-Smtp-Source: AGHT+IG3mLUrnex4Gh9YISOt+4Z8QFRbgf2nAEOG6iyUfs+FJoe4M3Wz+qc68ntwqoBsuMuCZNxt3Q==
X-Received: by 2002:a05:6e02:214c:b0:3dc:8075:ccd3 with SMTP id e9e14a558f8ab-3dc9b6d3c0fmr118743355ab.9.1748352784204;
        Tue, 27 May 2025 06:33:04 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3dc8298d8a2sm37404315ab.18.2025.05.27.06.33.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 May 2025 06:33:03 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-fsdevel@vger.kernel.org
Cc: viro@zeniv.linux.org.uk,
	djwong@kernel.org,
	brauner@kernel.org,
	torvalds@linux-foundation.org,
	trondmy@hammerspace.com,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 4/5] mm/filemap: unify read/write dropbehind naming
Date: Tue, 27 May 2025 07:28:55 -0600
Message-ID: <20250527133255.452431-5-axboe@kernel.dk>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250527133255.452431-1-axboe@kernel.dk>
References: <20250527133255.452431-1-axboe@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The read side is filemap_end_dropbehind_read(), while the write side
used folio_ as the prefix rather than filemap_. The read side makes more
sense, unify the naming such that the write side follows that.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 mm/filemap.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index 6af6d8f2929c..2ba1ed116103 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -1604,7 +1604,7 @@ static void filemap_end_dropbehind(struct folio *folio)
  * completes. Do that now. If we fail, it's likely because of a big folio -
  * just reset dropbehind for that case and latter completions should invalidate.
  */
-static void folio_end_dropbehind_write(struct folio *folio)
+static void filemap_end_dropbehind_write(struct folio *folio)
 {
 	/*
 	 * Hitting !in_task() should not happen off RWF_DONTCACHE writeback,
@@ -1659,7 +1659,7 @@ void folio_end_writeback(struct folio *folio)
 	acct_reclaim_writeback(folio);
 
 	if (folio_dropbehind)
-		folio_end_dropbehind_write(folio);
+		filemap_end_dropbehind_write(folio);
 	folio_put(folio);
 }
 EXPORT_SYMBOL(folio_end_writeback);
-- 
2.49.0


