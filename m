Return-Path: <linux-fsdevel+bounces-42419-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 602EEA42379
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Feb 2025 15:43:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 554151895987
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Feb 2025 14:39:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA3BF1624C8;
	Mon, 24 Feb 2025 14:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=scylladb.com header.i=@scylladb.com header.b="P6VAJO94"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 989DC13F43A
	for <linux-fsdevel@vger.kernel.org>; Mon, 24 Feb 2025 14:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740407859; cv=none; b=IOV7yST9LAjk4PonPsNDZzqGwlYP09k95SugkbHFaS9TCEirxLnjydVLE1iOKYeQIq9brMJ0QauuY4EVOdgTNnFZF68h+fOBJ5Ceq2kXOdeXQ3yvbaJdYvjvTbVEK6pHE1lv0fCVybht3jaH1XKSGzxLKOaQH0wwQsJpBV2ZX1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740407859; c=relaxed/simple;
	bh=Gc23huDW2EMDvsPrII/FfATOT3S+8qNoqO/SY9zSRVM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=k7LtTSxOiDPOsA8ww751wI1T9P2wuvJXRCGnfN/HBMRi6LUeh1Wf2JZKkQfkYt0KaFlHvz8MH2xOIgqf28BAMoegVpi8H+T5iFbWNp2ovd2zyj8sPIJFkgQ29S2lStzjrdvagC59H2SEkX4HjJQPT/jTrKIJYI2kk7nmDd6WaKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=scylladb.com; spf=pass smtp.mailfrom=scylladb.com; dkim=pass (2048-bit key) header.d=scylladb.com header.i=@scylladb.com header.b=P6VAJO94; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=scylladb.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=scylladb.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-220e989edb6so121899725ad.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Feb 2025 06:37:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=scylladb.com; s=google; t=1740407857; x=1741012657; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tr5NrMy0t1nSuRnqeN8ZOfvTg64bXP6rdk8GuFGDbik=;
        b=P6VAJO94A2JQVD2Oq1AQuldioP9LkI+3vTV5g6M3wCI+tf4sUMMSaugybK08sjwR4n
         swe9XSLhJrfikIo6L6PZLo7SI9homo7vKtxCoGsNWnIoPa4YpJGyFDssJ8hbNXVVRJqh
         UHibyBTQsfFusU/D393hjXxsYylqqh71tdWThqQLB6FWC0Rxr+lPKIf01HSkdrJR1fUl
         nQXgs1rlcltDfN6UQ4Zkr7Gnfj6QLRZI6RY+KE+hgtCVsWfGRCgS7TdN6MxliC1LLe8Z
         PEjvcENQMrftBXYY/Zfu6NdgY9luF65xoJRCyTLbrz4sKakm03k6vIPbfXhRMoD2JXgR
         HxOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740407857; x=1741012657;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tr5NrMy0t1nSuRnqeN8ZOfvTg64bXP6rdk8GuFGDbik=;
        b=Cd6Grch/u4NSvohHGz8PxlW9a/c/978BPx6N/4QpkFFcG+kpxRrH6nu7p9gYFywWKi
         fioAu2ClnhiU/lWoknznQKTSjmIdOTwTbD6vCywjZiXLK7oCDbNx8+b6J2hx23DU0CSy
         IwrjT/B0+EFiN1o4zjmGABMU5MCrJGa9tQ8b0I2E5LN2hCM+SgJPH8Vye6hXZAsFKZ/M
         7yU/gKEwJr4xWm5pVlUOnJly1QyhpUPFrF8Y+e9dSTs4UaWP4dFIdYzObJIeyBbsWnnt
         FoGMMxClboW87dh7wpJ+jev5LwdqSk5ri8dOvAW60oUgYBaFg0Zw5Atxyn+z1s9U48U6
         12CA==
X-Forwarded-Encrypted: i=1; AJvYcCU11A/8F0BrsuYEL6P6TwdKGgPAVjUR6UpgZrisy61VQ/Qt3fjUOsK2W51TJfbqglrxCIC4pRSdsfwoTEak@vger.kernel.org
X-Gm-Message-State: AOJu0Yyb+p4slDBf8ciskamfK5UM4Ig+8tOeXkgsxLlTXREegBVMv+vg
	ZzIgR3k8Lz3Ezo/K0exz7J7dTszIUZtmIW4zwZ0NSAysK74YLMxLL/7MsaWHC/fTmmHdg1/27mL
	Rgo1wCxzfZdVBg+8+V9yuDPVIisU88fKHk+9yRABWcugwoSKr7FgwgqVsleJS6FPjJCfmPZEISK
	6OSKLLba6/n+pwf5rDNgRSU/P0CofqFEtnY9trNWpolAR87+zzzmUbtB0n8PtYFfCImZYpxEmob
	kP6bxuM7fP//hdamHcIRLIT+GWjJzdUbBgrUU3vfRGH55/5OoiqsSbhllg/39pnXj0UtPkKn7yJ
	mfZkAnz4ypGemM5qqtgx3r+RIYO7/iAcm8NKqwrHe6izJTMamA==
X-Gm-Gg: ASbGncsD4IGVbVgy8gUTjEMVx0ELj2IryX+gQq1HaJpRlPYRO0tB3NMCCzcLOe9VZQl
	MDgxqMKyrw/hSsg5YYU+VCyuttk708EAIkFGj+HuyZAiSP6vG03Z6if472lrHLHCzkRrmxCGdcs
	+VTj9CXD1c7HEYJUbfMXj9tqMtOUa7QXKUjw6Npvw/0uLxmFZtjxwPoGOfAUkEH/uPdFHjXdJtl
	sh7pOfwJF/gKfYzlntc7ZzqXhmtac3bjqpEBmOQMu5jRLNPedREO8+eTld6UVOswFanC/bw/bqs
	vMNH9oEcjRwaG6HgA2Ry8ksFAUI=
X-Google-Smtp-Source: AGHT+IFpy3+E5cMzJqqit+IUZQ9CCf4tM5IGjll5j8aYvpZK6kzjNSVYR9yVXPP52A1Zj8pouSbmXQ==
X-Received: by 2002:a05:6a00:4b4f:b0:732:622f:ec39 with SMTP id d2e1a72fcca58-73426c7c77cmr19802356b3a.1.1740407856561;
        Mon, 24 Feb 2025 06:37:36 -0800 (PST)
Received: from localhost.localdomain ([2a09:bac5:7a2:878::d8:ed])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-732575e055dsm19294949b3a.68.2025.02.24.06.37.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2025 06:37:36 -0800 (PST)
From: "Raphael S. Carvalho" <raphaelsc@scylladb.com>
To: linux-kernel@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org
Cc: djwong@kernel.org,
	Dave Chinner <david@fromorbit.com>,
	hch@lst.de,
	willy@infradead.org,
	"Raphael S. Carvalho" <raphaelsc@scylladb.com>
Subject: [PATCH v3] mm: Fix error handling in __filemap_get_folio() with FGP_NOWAIT
Date: Mon, 24 Feb 2025 11:37:00 -0300
Message-ID: <20250224143700.23035-1-raphaelsc@scylladb.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CLOUD-SEC-AV-Sent: true
X-CLOUD-SEC-AV-Info: scylladb,google_mail,monitor
X-Gm-Spam: 0
X-Gm-Phishy: 0
X-CLOUD-SEC-AV-Sent: true
X-CLOUD-SEC-AV-Info: scylla,google_mail,monitor
X-Gm-Spam: 0
X-Gm-Phishy: 0

original report:
https://lore.kernel.org/all/CAKhLTr1UL3ePTpYjXOx2AJfNk8Ku2EdcEfu+CH1sf3Asr=B-Dw@mail.gmail.com/T/

When doing buffered writes with FGP_NOWAIT, under memory pressure, the system
returned ENOMEM despite there being plenty of available memory, to be reclaimed
from page cache. The user space used io_uring interface, which in turn submits
I/O with FGP_NOWAIT (the fast path).

retsnoop pointed to iomap_get_folio:

00:34:16.180612 -> 00:34:16.180651 TID/PID 253786/253721
(reactor-1/combined_tests):

                    entry_SYSCALL_64_after_hwframe+0x76
                    do_syscall_64+0x82
                    __do_sys_io_uring_enter+0x265
                    io_submit_sqes+0x209
                    io_issue_sqe+0x5b
                    io_write+0xdd
                    xfs_file_buffered_write+0x84
                    iomap_file_buffered_write+0x1a6
    32us [-ENOMEM]  iomap_write_begin+0x408
iter=&{.inode=0xffff8c67aa031138,.len=4096,.flags=33,.iomap={.addr=0xffffffffffffffff,.length=4096,.type=1,.flags=3,.bdev=0x…
pos=0 len=4096 foliop=0xffffb32c296b7b80
!    4us [-ENOMEM]  iomap_get_folio
iter=&{.inode=0xffff8c67aa031138,.len=4096,.flags=33,.iomap={.addr=0xffffffffffffffff,.length=4096,.type=1,.flags=3,.bdev=0x…
pos=0 len=4096

This is likely a regression caused by 66dabbb65d67 ("mm: return an ERR_PTR
from __filemap_get_folio"), which moved error handling from
io_map_get_folio() to __filemap_get_folio(), but broke FGP_NOWAIT handling, so
ENOMEM is being escaped to user space. Had it correctly returned -EAGAIN with
NOWAIT, either io_uring or user space itself would be able to retry the
request.
It's not enough to patch io_uring since the iomap interface is the one
responsible for it, and pwritev2(RWF_NOWAIT) and AIO interfaces must return
the proper error too.

The patch was tested with scylladb test suite (its original reproducer), and
the tests all pass now when memory is pressured.

Fixes: 66dabbb65d67 ("mm: return an ERR_PTR from __filemap_get_folio")
Signed-off-by: Raphael S. Carvalho <raphaelsc@scylladb.com>
---
v3: make comment more descriptive as per hch's suggestion.
---
 mm/filemap.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index 804d7365680c..3e75dced0fd9 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -1986,8 +1986,19 @@ struct folio *__filemap_get_folio(struct address_space *mapping, pgoff_t index,
 
 		if (err == -EEXIST)
 			goto repeat;
-		if (err)
+		if (err) {
+			/*
+			 * When NOWAIT I/O fails to allocate folios this could
+			 * be due to a nonblocking memory allocation and not
+			 * because the system actually is out of memory.
+			 * Return -EAGAIN so that there caller retries in a
+			 * blocking fashion instead of propagating -ENOMEM
+			 * to the application.
+			 */
+			if ((fgp_flags & FGP_NOWAIT) && err == -ENOMEM)
+				err = -EAGAIN;
 			return ERR_PTR(err);
+		}
 		/*
 		 * filemap_add_folio locks the page, and for mmap
 		 * we expect an unlocked page.
-- 
2.48.1


