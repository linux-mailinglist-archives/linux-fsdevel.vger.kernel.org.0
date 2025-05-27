Return-Path: <linux-fsdevel+bounces-49908-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AD20BAC4FD3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 May 2025 15:33:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 171E13B3D6F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 May 2025 13:32:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF9DA274FCB;
	Tue, 27 May 2025 13:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="M14tqoi3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CBC6272E4A
	for <linux-fsdevel@vger.kernel.org>; Tue, 27 May 2025 13:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748352784; cv=none; b=VllQBjbj24FOmDIWgEpgVj/ns1bqhSXFoylwC5gDI90INlgQmXQKgRghKGjGjfvtIjjDx1JW9Cn5PVIr7J74BJyOQ96vZzyamHQ/YxfLQCwCzIYDREMvoKUSEo2/Dj3rNqskqRhsIhwbsIHTX9noXupX5SDXbSzZmqC3pTvziQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748352784; c=relaxed/simple;
	bh=SnfCPd09KI83AwFhxqISP1WhHm2KbgZjrK8l6DCnIbU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fbz2kOazkTLb7qMwrRBlEDrj5NWr/I5B6sz6gQZzVkMnP9c4HT5C1TScF6wR4MoZc0y/lq3ik2F4e2MAFWWEISP8wA+LD68/PTxpfq0QsQutgznXp8WbqqQj5jEqL8XL6muVEMJgpv6GMK8tL5zE2NJW2X2FAp+KONqyhLcrh+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=M14tqoi3; arc=none smtp.client-ip=209.85.166.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f173.google.com with SMTP id e9e14a558f8ab-3d80bbf3aefso8030385ab.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 27 May 2025 06:33:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1748352781; x=1748957581; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AeTFSAEd3e9K4f20EuEzamS6jJURw+VLEXVfeVvYL4A=;
        b=M14tqoi3cEATmh2wq0jFZ6CW95GQDWFGv22lw8onrS5YknxeHpS5vooAYC8LKk67+8
         Pz7MpRcrInVrdSxbHeMPvYdPtAH+SeRc3d1RJYhlUTi1/EkYx+7hNgZYJ740DVOUz98n
         IUi3T0q5eTVe236gb2Vg1fes9GpvV8EXTVeP333GuYxRd223Kb7Yc58Jl9FF38ElKiVz
         AvwEPKQmZ+tbFFiDNPDzApGXe/olt1VPLr4Omdo1rRHN9S2ckV9otWy9TuZWVp6uOENB
         ffr56nvQ83IEe17z9w4wydP1Xb4bJLrwJ020VlgfnkbAMgRKvw/btFUSrIZDqmzsCZe9
         HaYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748352781; x=1748957581;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AeTFSAEd3e9K4f20EuEzamS6jJURw+VLEXVfeVvYL4A=;
        b=wBdJx0vwp6F6pej85yzY6Zme2uP1X5KXClAv2wt1JwEBE0HbyA5WDE2g3HT7Fhf198
         wk9ZFRd0xiR+AFVwRG64Xz/k75IF7LEIwL8f+B2D9vhwb8Sdj5iC1Cab7omoU1tNgxO5
         PcW6F4Wwtj86bwLy9mj/49yJlbiK+OP2hVLQRpJg8rQt0jySKxRV77D7VfATLG3aqI0C
         BOkH06nnFkdetlcJUED1AlqEcV7eEd6f0mIBcTVOdVRRmR4xEbCiisyU3P4r3P4r2RAi
         +HlgICeArnjoAeUGFXoaBfVNngkZf65W6YY3Icl19zcO826e35Tfjjd3TCumqtQhcuIW
         hNMQ==
X-Gm-Message-State: AOJu0YwOgESu5/Nsr+JnDIgd5D5LyAlO/aAw9Zl+2VnmsOSQlpYsM8JT
	WWyc6OEBqZ8FmBDu4mrJxvln+mgKDTit3OvDQFFSZh+p/zDXP/6tXzGPlvaaHr8wCYiiLGA6lMD
	pBOoL
X-Gm-Gg: ASbGnctukaVxOyV4YhsqjG1ejwdR7j7SNYb/AVvLcc1DLfIXydmxTZx6/VeccyTUmiv
	47VRrwhT/3Bop0AvfZNkXSFIO/YeKLPkyJ/oNcqN7H2ClYGjX+00UqQ03i5/asgx6ytblLOvs6K
	1+JzeE3g8Pr4y+sVgW46smWfXX8NqMh9a8x/klzMKjXaHgsxshbuNKSsD+aiBLpbAFtSPXxPyb5
	PTuwka0JECgXSe4OLBXBevM4fcEQXwPMAs6GU4y1SOFrZjkoI7eSeeajS2EfLoD5kEscuMrRzlX
	RYgXrf0ITvE1ympsmDQ8vm7YeZFrRWFkamM9hnB2F6VYdIE4iOOuRRI=
X-Google-Smtp-Source: AGHT+IFoo0WB7XDJf8IvZpsdTMDJP9rvKyN8h+HUxU8YOvFNZSTtnUk3xT+2sGlz4u+aQ1U76FPACA==
X-Received: by 2002:a92:cd88:0:b0:3d8:1ea5:26d1 with SMTP id e9e14a558f8ab-3dc9b7033d7mr137668275ab.18.1748352781236;
        Tue, 27 May 2025 06:33:01 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3dc8298d8a2sm37404315ab.18.2025.05.27.06.33.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 May 2025 06:33:00 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-fsdevel@vger.kernel.org
Cc: viro@zeniv.linux.org.uk,
	djwong@kernel.org,
	brauner@kernel.org,
	torvalds@linux-foundation.org,
	trondmy@hammerspace.com,
	Jens Axboe <axboe@kernel.dk>,
	stable@vger.kernel.org
Subject: [PATCH 2/5] mm/filemap: use filemap_end_dropbehind() for read invalidation
Date: Tue, 27 May 2025 07:28:53 -0600
Message-ID: <20250527133255.452431-3-axboe@kernel.dk>
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

Use the filemap_end_dropbehind() helper rather than calling
folio_unmap_invalidate() directly, as we need to check if the folio has
been redirtied or marked for writeback once the folio lock has been
re-acquired.

Cc: stable@vger.kernel.org
Reported-by: Trond Myklebust <trondmy@hammerspace.com>
Fixes: 8026e49bff9b ("mm/filemap: add read support for RWF_DONTCACHE")
Link: https://lore.kernel.org/linux-fsdevel/ba8a9805331ce258a622feaca266b163db681a10.camel@hammerspace.com/
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 mm/filemap.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index 008a55290f34..6af6d8f2929c 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2644,8 +2644,7 @@ static inline bool pos_same_folio(loff_t pos1, loff_t pos2, struct folio *folio)
 	return (pos1 >> shift == pos2 >> shift);
 }
 
-static void filemap_end_dropbehind_read(struct address_space *mapping,
-					struct folio *folio)
+static void filemap_end_dropbehind_read(struct folio *folio)
 {
 	if (!folio_test_dropbehind(folio))
 		return;
@@ -2653,7 +2652,7 @@ static void filemap_end_dropbehind_read(struct address_space *mapping,
 		return;
 	if (folio_trylock(folio)) {
 		if (folio_test_clear_dropbehind(folio))
-			folio_unmap_invalidate(mapping, folio, 0);
+			filemap_end_dropbehind(folio);
 		folio_unlock(folio);
 	}
 }
@@ -2774,7 +2773,7 @@ ssize_t filemap_read(struct kiocb *iocb, struct iov_iter *iter,
 		for (i = 0; i < folio_batch_count(&fbatch); i++) {
 			struct folio *folio = fbatch.folios[i];
 
-			filemap_end_dropbehind_read(mapping, folio);
+			filemap_end_dropbehind_read(folio);
 			folio_put(folio);
 		}
 		folio_batch_init(&fbatch);
-- 
2.49.0


