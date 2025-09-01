Return-Path: <linux-fsdevel+bounces-59754-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E983FB3DDFF
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Sep 2025 11:21:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B6D0F17919D
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Sep 2025 09:21:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3569830F523;
	Mon,  1 Sep 2025 09:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="eeV44nzn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 435F930DEAF
	for <linux-fsdevel@vger.kernel.org>; Mon,  1 Sep 2025 09:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756718377; cv=none; b=ahq7bWJTBuWgoZIFgiMZUv3ERlggsvDzw7Asxnw+NW3mkFLIGQHW5ldhXM85JIVVbQVjR2B4RIfijBX3q1v3CMylWKmWbRucv3hOrlQM7srsqgidw17NlsYn0QAUvyx7YF/ZxVBwghH2u9MbhT0WTdVTUBJK6k6SDJzlFndPeVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756718377; c=relaxed/simple;
	bh=bekKkiG6OK0h/uU3LqpFmD7Nmq5naPE4b3ceLP62f4g=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MisHyd6AjqDccBN1S4SBB2afvHssDFXosJc6efj0QKMLXnifOos+l3RF+uII+TAU/fna8cQyttExGXmv4qW7sNNNWmNnd7pliZ8Qnc3q0g1UEN1YUwlYqXQiYVCzjKSfPHnccWY+0Hxq3FSdVKeRLbD/C05xSyXRBaHfEnlusug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=eeV44nzn; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-61cc281171cso7047366a12.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 01 Sep 2025 02:19:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1756718373; x=1757323173; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NQi1DlLk53At+sb7Dxdlwb1wfYNq5fMfR6Ecet/hRlk=;
        b=eeV44nznuHFtUeH4qROWiS9PpVPkUe3tBP74MkqyuCxBcAL01l0Dx804DyyXlukHiQ
         /W/Gex0HDmir4I1Tb1EOLf9HC+CGo8yCXh+aYhx2VMaiH852A4MlMgHrtE9VpWtmDz7A
         U64+syKDI1K7Qb8NTyx4SDNw+BqMAJcmB5SEZ47ifiwwu37XwAIFvASfmh56p5Fy2ph0
         ylqYzIfvynaVsqG4foLqfn+YHma+oMJCzmBgugyP/gD0ZNnnrmz1dl1cFr1rLXehjIjR
         aMojLABbJ28ViI/tVEpMLrt/kao3inha3cM867DWl0LxHVFZqYRCKWu/tOPjDosl291r
         0lGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756718373; x=1757323173;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NQi1DlLk53At+sb7Dxdlwb1wfYNq5fMfR6Ecet/hRlk=;
        b=Yhc6yhcFvFhqnCuY21xPttQEk04k47eB9EQio8yBUPNu3Myrcpi7/9H/8hi2eag+6B
         SU89cYwBRNHoWhzYUj480T26iIKJra7g/Ip+sG/4MG5LqRNKazpxVF0HDItQ2lzpHXvN
         cQlyUOduI4SzPaGs7LgnZ88SIVWRWpy4TzyYKcp8jsMZwyGGuAPG//YSgwWKSBM6MR93
         UqoFAP0Fdq10+Uv/0spBjXrDt7QadU9NQMyxysLqfZD3mwwK+vCy0pWuHekfnmaLrJy4
         wDDX14gdr5xvbHHrxprpuT/zsqoRRaIWBOniUMbXtTe++NyOB/09TT+bqEetZUZUBOMx
         iZ7w==
X-Forwarded-Encrypted: i=1; AJvYcCV3G9tVppluD+wtsMXb80/iBLjo8eW9eCAp037jjvswW2nx2AKkDtX4zzVNwcheOAFDNe/QmuJ0MJuOwcBs@vger.kernel.org
X-Gm-Message-State: AOJu0YxEqan/25fvngAUcVgWIE7/SrMlNvVphxHyqE5tGd7hjec+9LBu
	pBtMgacL4U8ymowE2EDzx2DQwjUOzyCGrbaQGNWzUyGhuAKcSflNNW3AnhMGaY2Ljrs=
X-Gm-Gg: ASbGncuJYHH9nJO3qUbB0fIGgnUPXhCbMVTDJgU4NphvdVEQZkCfys5RyFKPxwSQvzG
	BKIXf+uhgZLVIPWr4on7qV00Pz/hrvLSeFnNN7hcRvurRnGAr7E0T71tybb767u7MYJrXZWU+kY
	dP6wMeCyoJz3Dc4EFEhdK1OAqa106h5Rlfb35nMSHlAe0smUyA05yVfVlqIxUxN+ird3PDtTO6b
	xeIyaxBKvvwR3aHE3mZsx73qnm4+5ka9Svak4HzwjjpEfRa+G+lwEdH0n5tRa5pvf5dHPv1koND
	infXT79df4xw7ZDFgbUkhk6jt8LhRg6+480KeD1Fg1r8srQ4WhJaHDV097yWaUvCXxRJBjo23LQ
	nWxA7To3KMc3XXVgLI+39+0/5Spbq67VTEpOjWTX8lmZyJWntH2NbUNvb3JUdAgWskvFHYr1wmL
	Tm1Ahm8JaTgoaS3BTV8gBFEIXk+2sp1HzQ
X-Google-Smtp-Source: AGHT+IH5BJhRk96TYnQheCz4kMoEb798UIqHjGpro1uj3IPOuzj2UHqou7p2evmbnRgTw9WnBmZqkw==
X-Received: by 2002:a17:907:72c8:b0:b04:39af:bee7 with SMTP id a640c23a62f3a-b0439afd503mr119373166b.26.1756718373122;
        Mon, 01 Sep 2025 02:19:33 -0700 (PDT)
Received: from raven.intern.cm-ag (p200300dc6f1d0f00023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f1d:f00:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b01902d0e99sm541005766b.12.2025.09.01.02.19.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Sep 2025 02:19:32 -0700 (PDT)
From: Max Kellermann <max.kellermann@ionos.com>
To: akpm@linux-foundation.org,
	david@redhat.com,
	axelrasmussen@google.com,
	yuanchu@google.com,
	willy@infradead.org,
	hughd@google.com,
	mhocko@suse.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com,
	vbabka@suse.cz,
	rppt@kernel.org,
	surenb@google.com,
	vishal.moola@gmail.com,
	linux@armlinux.org.uk,
	James.Bottomley@HansenPartnership.com,
	deller@gmx.de,
	agordeev@linux.ibm.com,
	gerald.schaefer@linux.ibm.com,
	hca@linux.ibm.com,
	gor@linux.ibm.com,
	borntraeger@linux.ibm.com,
	svens@linux.ibm.com,
	davem@davemloft.net,
	andreas@gaisler.com,
	dave.hansen@linux.intel.com,
	luto@kernel.org,
	peterz@infradead.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	x86@kernel.org,
	hpa@zytor.com,
	chris@zankel.net,
	jcmvbkbc@gmail.com,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz,
	weixugc@google.com,
	baolin.wang@linux.alibaba.com,
	rientjes@google.com,
	shakeel.butt@linux.dev,
	max.kellermann@ionos.com,
	thuth@redhat.com,
	broonie@kernel.org,
	osalvador@suse.de,
	jfalempe@redhat.com,
	mpe@ellerman.id.au,
	nysal@linux.ibm.com,
	linux-arm-kernel@lists.infradead.org,
	linux-parisc@vger.kernel.org,
	linux-s390@vger.kernel.org,
	sparclinux@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v4 05/12] mm/oom_kill: add const to pointer parameter for improved const-correctness
Date: Mon,  1 Sep 2025 11:19:08 +0200
Message-ID: <20250901091916.3002082-6-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250901091916.3002082-1-max.kellermann@ionos.com>
References: <20250901091916.3002082-1-max.kellermann@ionos.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The memory management (mm) subsystem is a fundamental low-level component
of the Linux kernel. Establishing const-correctness at this foundational
level enables higher-level subsystems, such as filesystems and drivers,
to also adopt const-correctness in their interfaces. This patch lays
the groundwork for broader const-correctness throughout the kernel
by starting with the core mm subsystem.

This patch adds const qualifiers to task_struct and mm_struct pointer
parameters in the OOM killer code that do not modify the referenced
memory, improving type safety and enabling compiler optimizations.

Functions improved:
- process_shares_mm()

Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
---
 include/linux/mm.h | 2 +-
 mm/oom_kill.c      | 3 ++-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 18deb14cb1f5..f70c6b4d5f80 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -3840,7 +3840,7 @@ static inline int in_gate_area(struct mm_struct *mm, unsigned long addr)
 }
 #endif	/* __HAVE_ARCH_GATE_AREA */
 
-extern bool process_shares_mm(struct task_struct *p, struct mm_struct *mm);
+bool process_shares_mm(const struct task_struct *p, const struct mm_struct *mm);
 
 void drop_slab(void);
 
diff --git a/mm/oom_kill.c b/mm/oom_kill.c
index 17650f0b516e..2620b32a8eba 100644
--- a/mm/oom_kill.c
+++ b/mm/oom_kill.c
@@ -490,7 +490,8 @@ static bool oom_killer_disabled __read_mostly;
  * task's threads: if one of those is using this mm then this task was also
  * using it.
  */
-bool process_shares_mm(struct task_struct *p, struct mm_struct *mm)
+bool process_shares_mm(const struct task_struct *const p,
+		       const struct mm_struct *const mm)
 {
 	struct task_struct *t;
 
-- 
2.47.2


