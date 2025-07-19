Return-Path: <linux-fsdevel+bounces-55516-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52EC1B0B167
	for <lists+linux-fsdevel@lfdr.de>; Sat, 19 Jul 2025 20:30:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F569AA7288
	for <lists+linux-fsdevel@lfdr.de>; Sat, 19 Jul 2025 18:30:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E2E228B4E7;
	Sat, 19 Jul 2025 18:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="y36oTUK3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A54228A714
	for <linux-fsdevel@vger.kernel.org>; Sat, 19 Jul 2025 18:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752949750; cv=none; b=rKaoy0/jcDbqwXluuQBhTIHjup8HNf8ozSH3hoLp/VVlahDoTBHT6ihkCWuzb0bd2eaaZrPZVLt2Z7Uiz29VBC7o9xUMRIYjUzRBwz9Y/7T+tlcBAAEA/LtEEkHTJ4WTp3ey/orPqodB9/lVc6a1QkgupZGsxCzhi2oNV2P7xTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752949750; c=relaxed/simple;
	bh=SGDFTeiKPGTkAuerpbJP68A8Byp9ih/c04po0z++Ajw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=XoHnOeKt43ScWXWnxDi1nNnKBV7FPiHe8CO2xO5cj19pFITD/VzGum3YVUCHSrjarEBFGuxnxj0HADfcFClHsewpjTrg3eV09yS5hyodeeEfJpz+H0VOZJcH57dVvjpAx42NmwaOToqhBNsjL8pm/32helnUQJX5jenzB9st9Wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=y36oTUK3; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-311e7337f26so3265630a91.3
        for <linux-fsdevel@vger.kernel.org>; Sat, 19 Jul 2025 11:29:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752949748; x=1753554548; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Wv6Rc6knLCwk0bVTU7Jho39C3VrUJugHZkg7EchZAig=;
        b=y36oTUK3Lqho/mcc5c7FGvkg46be4SDijV0330fmrmHSt9iiEHkqqQfM3/9Khh8w8c
         SIDNztaKU9GROBXGCvnwqnXGNH5lZSMeIV7qSGt1RJQ0bjABypM/PoZ7LCULZVCoLEYA
         bKZeut1WUnChEMV7dEcd8/SXgNXlJNbAQujVM3TkaYmLXk3+YF6ymg4hp0Iu80Ncfnyv
         +4N4NMkHC+KxFCZsAght6TO65cAiAhF6coMTjtgsgUwDf6nutM8+1Q0ocXwqZpMagolq
         dzFhDhEjFJIWnChcq0w5QeUp8UBM0lMpkyEmQA2JTf+Y0+IE7nhqNHjVXyPy9XrM3m6Q
         xdJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752949748; x=1753554548;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Wv6Rc6knLCwk0bVTU7Jho39C3VrUJugHZkg7EchZAig=;
        b=UOKoqxv+m9C1nn3EPGoQODkSYiDVBUa4IGN4XpNWrYjFBYcrs60rSWnFHWfQNGFAtw
         8tjaGfDTJNpgeT2CWVUv4/rJxnXj9zj9sUbp6oVLLjtqN/HiXpAEPTxpvDeX1xxki0W+
         xbKMe3bPsJzw7p7cbghi2POtVLY/7qCaD+rSJUH0IDpc3pJIrDBQAQ007Xnl2siT1kXd
         p/M7cto2FxClogHcVFjLgcuUEGXPpCdF4Bas+o9G2iWZ8IwYJpjR53ANguMg53of9DYF
         Ny2yBAx+BEMp+2L6x61UiQr+DUKnLpQKwx+OOuxEMFpaohJ+6bx/6cfZ/CK52APTCxhb
         hNng==
X-Forwarded-Encrypted: i=1; AJvYcCXvX5+Yzk46H1m0R4WSwiv9ZqDGi1tNy+sdZB0lqd1i/vQtCCRxIMGg/z2oGM0S4mcNmj2SNY+ru9l87Wpp@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8n2gllFC9Dbg0XcGGf9mpvqZyL/ncy3coRo7ENWpIWRJi0OmG
	qe/JSjg1LRkwU31PNtFR//s+ERDZRl5sM8xm716IBwmwUjoH80picxt8wKF2kaCqZtfIs/m+wja
	oFuutJw==
X-Google-Smtp-Source: AGHT+IFF+l8YOMdVgdfAKyd00OGIBIw32C6yb0RlsDUFxpfFgJAmPbDpH0QnnK8+9k8e/WhkoyFB5zF8/XQ=
X-Received: from pjmm4.prod.google.com ([2002:a17:90b:5804:b0:312:3b05:5f44])
 (user=surenb job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:48c8:b0:315:b07a:ac12
 with SMTP id 98e67ed59e1d1-31c9e6f71b8mr24466775a91.14.1752949747704; Sat, 19
 Jul 2025 11:29:07 -0700 (PDT)
Date: Sat, 19 Jul 2025 11:28:53 -0700
In-Reply-To: <20250719182854.3166724-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250719182854.3166724-1-surenb@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250719182854.3166724-6-surenb@google.com>
Subject: [PATCH v8 5/6] fs/proc/task_mmu: remove conversion of seq_file
 position to unsigned
From: Suren Baghdasaryan <surenb@google.com>
To: akpm@linux-foundation.org
Cc: Liam.Howlett@oracle.com, lorenzo.stoakes@oracle.com, david@redhat.com, 
	vbabka@suse.cz, peterx@redhat.com, jannh@google.com, hannes@cmpxchg.org, 
	mhocko@kernel.org, paulmck@kernel.org, shuah@kernel.org, adobriyan@gmail.com, 
	brauner@kernel.org, josef@toxicpanda.com, yebin10@huawei.com, 
	linux@weissschuh.net, willy@infradead.org, osalvador@suse.de, 
	andrii@kernel.org, ryan.roberts@arm.com, christophe.leroy@csgroup.eu, 
	tjmercier@google.com, kaleshsingh@google.com, aha310510@gmail.com, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org, linux-kselftest@vger.kernel.org, surenb@google.com
Content-Type: text/plain; charset="UTF-8"

Back in 2.6 era, last_addr used to be stored in seq_file->version
variable, which was unsigned long. As a result, sentinels to represent
gate vma and end of all vmas used unsigned values. In more recent
kernels we don't used seq_file->version anymore and therefore conversion
from loff_t into unsigned type is not needed. Similarly, sentinel values
don't need to be unsigned. Remove type conversion for set_file position
and change sentinel values to signed. While at it, change the hardcoded
sentinel values with named definitions for better documentation.

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
Acked-by: David Hildenbrand <david@redhat.com>
---
 fs/proc/task_mmu.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index 751479eb128f..90237df1ed33 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -29,6 +29,9 @@
 #include <asm/tlbflush.h>
 #include "internal.h"
 
+#define SENTINEL_VMA_END	-1
+#define SENTINEL_VMA_GATE	-2
+
 #define SEQ_PUT_DEC(str, val) \
 		seq_put_decimal_ull_width(m, str, (val) << (PAGE_SHIFT-10), 8)
 void task_mem(struct seq_file *m, struct mm_struct *mm)
@@ -135,7 +138,7 @@ static struct vm_area_struct *proc_get_vma(struct proc_maps_private *priv,
 	if (vma) {
 		*ppos = vma->vm_start;
 	} else {
-		*ppos = -2UL;
+		*ppos = SENTINEL_VMA_GATE;
 		vma = get_gate_vma(priv->mm);
 	}
 
@@ -145,11 +148,11 @@ static struct vm_area_struct *proc_get_vma(struct proc_maps_private *priv,
 static void *m_start(struct seq_file *m, loff_t *ppos)
 {
 	struct proc_maps_private *priv = m->private;
-	unsigned long last_addr = *ppos;
+	loff_t last_addr = *ppos;
 	struct mm_struct *mm;
 
 	/* See m_next(). Zero at the start or after lseek. */
-	if (last_addr == -1UL)
+	if (last_addr == SENTINEL_VMA_END)
 		return NULL;
 
 	priv->task = get_proc_task(priv->inode);
@@ -170,9 +173,9 @@ static void *m_start(struct seq_file *m, loff_t *ppos)
 		return ERR_PTR(-EINTR);
 	}
 
-	vma_iter_init(&priv->iter, mm, last_addr);
+	vma_iter_init(&priv->iter, mm, (unsigned long)last_addr);
 	hold_task_mempolicy(priv);
-	if (last_addr == -2UL)
+	if (last_addr == SENTINEL_VMA_GATE)
 		return get_gate_vma(mm);
 
 	return proc_get_vma(priv, ppos);
@@ -180,8 +183,8 @@ static void *m_start(struct seq_file *m, loff_t *ppos)
 
 static void *m_next(struct seq_file *m, void *v, loff_t *ppos)
 {
-	if (*ppos == -2UL) {
-		*ppos = -1UL;
+	if (*ppos == SENTINEL_VMA_GATE) {
+		*ppos = SENTINEL_VMA_END;
 		return NULL;
 	}
 	return proc_get_vma(m->private, ppos);
-- 
2.50.0.727.gbf7dc18ff4-goog


