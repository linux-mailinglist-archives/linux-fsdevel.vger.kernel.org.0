Return-Path: <linux-fsdevel+bounces-36366-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E2CEC9E236C
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Dec 2024 16:37:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1F07286D4B
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Dec 2024 15:37:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3006C20A5DA;
	Tue,  3 Dec 2024 15:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="QOc0N/NU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B0041F892A
	for <linux-fsdevel@vger.kernel.org>; Tue,  3 Dec 2024 15:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733239985; cv=none; b=aHYnBlVneWc+ApLd6/rzmNzi1AiL6J9T0w/VdHluEVqY9liu32DjIdt6rn7ModslhzhYw21hIhjCy/oLLtxetzNV+Sx2ZFkfc0ZKiKudHSO3R0y4SCdbgArypodufzU1loJL0TWHI+HXC1l1L1fH23I+ZS9IwjDD/oLiqsExJPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733239985; c=relaxed/simple;
	bh=uuqM4dJdCE0QCImMtNfF8QapqPv5QHbWROfY8tXB1So=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j2jAM7LNZAJlDVC0/kLWgvTBT1DKFgWrf9BVED7Jr0z6Eqq57MfUm40a+QUPZPGfAt+6u4/e8qy8EJBOfOkTIIEtlVgr3AMx04j6sdxaxGLOsU7JZAVjcoCXDZKNxoy/sXvd6vNXsvsSXEnZnUCWGd9b8ojVhOYR3u5GUL1pJUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=QOc0N/NU; arc=none smtp.client-ip=209.85.167.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-3ea5a7a5e48so2650385b6e.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 03 Dec 2024 07:33:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1733239983; x=1733844783; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=45ZT5fvdDImmdgAdnvc6z/+AzY3WZJ2Fl5NYIbZiSAo=;
        b=QOc0N/NUqzgyQBFL3YcsFrekttyd/1YnrV1H2WXWVqq8rRuDr/fMbYTz0t0nSvjZsZ
         PM0IJhaPyr1XFGkB+CgN5rJGrQo594jDOQh7cePyS+sg/JBAs1GtxQqcsovONgFLy5Op
         1+ljoiONKHAsiMjXtSjgd+p1IUQBCGfFdjwWv68j6hNyma/YiG/+fSzPcVvx21A7TXKZ
         J8YTAo4MNYwj2TozO7JRy9v50QYghtb7lOuUhpepBkAbV48PxgCkaesFHij5OlaLIewn
         r6GeI3nXSYx2eMFHBv35VFSCGjE7XwwK8w5vv5wtuIXoUTRr94mCjgtrTWpg37lX2KUa
         Jc9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733239983; x=1733844783;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=45ZT5fvdDImmdgAdnvc6z/+AzY3WZJ2Fl5NYIbZiSAo=;
        b=OwzzHzMLyCEr/ibjz3BDlk8OQAxo6mdW+E7Xtx0I7RZ6hwG40dK98lEiTJ59s/Y7gN
         NzyQ8J2hu+qpum7U3F60XMy6PKNO2sAKezW0IFb1hoJAbWiSoX6sKLOgF0hiVUp4gK0w
         mGyvnC0aA1ZmBYRwqpchHKPnAX2LhaE5/2f8PYTdgy27J/jGO8aAMSU2fmSoqUNrgnWb
         AFpkUQo9sZQPhDXOs9kcYnnx9Rgg+BzNrbykAfblPQNXyeMC6puAG29304aNF5jboBWO
         f6F7KU+SnsJ5FDCx9LcswO+GcJ4kl5hFzV2oFU4cSHIuzk0tP15Cr23+PTp63Lh+oLi9
         tLww==
X-Forwarded-Encrypted: i=1; AJvYcCVL7v4lHM5MENimCxKcUQU7l6b1sZhsknA+tANe+pkEXNq6vY+KTE7QXXSMT0u5BKr1UU3Uh3GxhhL16PvP@vger.kernel.org
X-Gm-Message-State: AOJu0YyU7w44qEbYu3Jx44IEX8UahGYa75DqLHiB3wXeufuNNke97nsb
	gU0c6fI4AJ3wRrLsAaJpwTuZq3m5zXpBicBILaqjxuqRAA476DAJyqKhdTxOxVA=
X-Gm-Gg: ASbGncsvFJvGJVFhMPqHY5uJutzzoT7raavTMqLyZy/DTLRqNmDONG9hjkRs2ABWB2g
	QK29RtVHjxZmuS3P0ZpiMDCj5Rqi9XK3m250kF97PQIu43GVdJ+SHRyfLgPt89+virMUqdCWp5V
	Gx25juLbeh8Z/lWYDonFyZHbHojymO1SsntuniCqc8svfvluqNb5Q0JKopSfkG8JxIQtzYsonPQ
	BwoUd2BK7xpgTju8kQDLJ+b8fDUJNqfxp/cniBGvU0hFdOpa667Sc32KkA=
X-Google-Smtp-Source: AGHT+IFgNffB59kRtGSa279D+oxFDG6GGmZlBVzfslJYY485yS6Rp8valFBlgcp9p+EP83czXVtQIg==
X-Received: by 2002:a05:6808:199e:b0:3ea:6533:f19d with SMTP id 5614622812f47-3eae505a0femr2960000b6e.30.1733239982974;
        Tue, 03 Dec 2024 07:33:02 -0800 (PST)
Received: from localhost.localdomain ([130.250.255.163])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3ea86036cbbsm2891878b6e.8.2024.12.03.07.33.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2024 07:33:02 -0800 (PST)
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
Subject: [PATCH 12/12] mm: add FGP_UNCACHED folio creation flag
Date: Tue,  3 Dec 2024 08:31:48 -0700
Message-ID: <20241203153232.92224-14-axboe@kernel.dk>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241203153232.92224-2-axboe@kernel.dk>
References: <20241203153232.92224-2-axboe@kernel.dk>
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
index e49587c40157..374872acbe1d 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -721,6 +721,7 @@ pgoff_t page_cache_prev_miss(struct address_space *mapping,
  * * %FGP_NOFS - __GFP_FS will get cleared in gfp.
  * * %FGP_NOWAIT - Don't block on the folio lock.
  * * %FGP_STABLE - Wait for the folio to be stable (finished writeback)
+ * * %FGP_UNCACHED - Uncached buffered IO
  * * %FGP_WRITEBEGIN - The flags to use in a filesystem write_begin()
  *   implementation.
  */
@@ -734,6 +735,7 @@ typedef unsigned int __bitwise fgf_t;
 #define FGP_NOWAIT		((__force fgf_t)0x00000020)
 #define FGP_FOR_MMAP		((__force fgf_t)0x00000040)
 #define FGP_STABLE		((__force fgf_t)0x00000080)
+#define FGP_UNCACHED		((__force fgf_t)0x00000100)
 #define FGF_GET_ORDER(fgf)	(((__force unsigned)fgf) >> 26)	/* top 6 bits */
 
 #define FGP_WRITEBEGIN		(FGP_LOCK | FGP_WRITE | FGP_CREAT | FGP_STABLE)
diff --git a/mm/filemap.c b/mm/filemap.c
index 00f3c6c58629..a03a9b9127b8 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2001,6 +2001,8 @@ struct folio *__filemap_get_folio(struct address_space *mapping, pgoff_t index,
 			/* Init accessed so avoid atomic mark_page_accessed later */
 			if (fgp_flags & FGP_ACCESSED)
 				__folio_set_referenced(folio);
+			if (fgp_flags & FGP_UNCACHED)
+				__folio_set_uncached(folio);
 
 			err = filemap_add_folio(mapping, folio, index, gfp);
 			if (!err)
@@ -2023,6 +2025,9 @@ struct folio *__filemap_get_folio(struct address_space *mapping, pgoff_t index,
 
 	if (!folio)
 		return ERR_PTR(-ENOENT);
+	/* not an uncached lookup, clear uncached if set */
+	if (folio_test_uncached(folio) && !(fgp_flags & FGP_UNCACHED))
+		folio_clear_uncached(folio);
 	return folio;
 }
 EXPORT_SYMBOL(__filemap_get_folio);
-- 
2.45.2


