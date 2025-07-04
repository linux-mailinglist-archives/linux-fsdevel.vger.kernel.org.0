Return-Path: <linux-fsdevel+bounces-53891-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F0317AF87AB
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Jul 2025 08:09:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 05C121882D12
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Jul 2025 06:09:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB0AA242D68;
	Fri,  4 Jul 2025 06:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pOSeexGj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2BC6242D7F
	for <linux-fsdevel@vger.kernel.org>; Fri,  4 Jul 2025 06:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751609265; cv=none; b=AnDpj9XlSCX6qWzmMEZX94SRKfzHY5VhBqx63vAURfBKz1/CmxxS51FH9+Pn422YJATeaqwNwTwN/pSDL0NQ9CyvYfFOn1sMjorHw4iWHS7NeIQ4gElSN4QWAmfebxyQpOyanLLqNU9021LQjHPg8hWNAm6qXpgPqIb0iPu3QIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751609265; c=relaxed/simple;
	bh=Ckxo6CgOFeLwkg+7L2QC60dmSgMIafJFsZkepFdeJnQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=bHw8e/Gb/wG3ds174mR1tmlhVDFB3ClQQsD+6n4dNS/8o843r+X1DIJy3nIWZbVs+flX8tZfBP4Bk0WV2rGbYAvJh++/GRmScuS08QfIc+GNNvhzbHK6jk3k79mB06B/wFQLb+nx4murkJVa+9kttaF7QjncRtrpGUNqZSCm34E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pOSeexGj; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-313d346dc8dso892307a91.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 03 Jul 2025 23:07:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1751609263; x=1752214063; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=h5UIhHsA2QH3v7duxv2jqX5tfGSl+3WijZnkCT/PyKo=;
        b=pOSeexGjSzNEtzQ3RDxauUjgOnWOxJ82VTNUiJ6eL8erzaEzj2MjtAiGkKrijQLMzZ
         juaHSK1FjpMK0rf198IqtTuUIzJcaFEltpB+1LMB7QoS3KUlnOL1wTgq96uW8tRaauAZ
         626nEYOUf7+j+JeQH3PNXPJOZQuFAGqwTe2stuRSvMT6q0q2lnjX5+U31NQgNP00dtZB
         XWcx/1fFyXSYXSUvF1VeYTp+BezstZqh+NFaTVFMx/I9Z8nypQ94HUdS2hypqHSKP94F
         0ux+8QXwF/VNEe/s4aDxaEBaCh8IzH5fvUpOawyNzYRbuBiW8UtqGmqg/D+kwqqYEiPF
         l/2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751609263; x=1752214063;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=h5UIhHsA2QH3v7duxv2jqX5tfGSl+3WijZnkCT/PyKo=;
        b=DK6B3YiLighxFhM/OuU377y+eHFOrXlzN7WKQVP3ahhMqTLGpOOfFMb//axNyEVc88
         LHh+gnqsxLQoxzggbh38zcyjITLg5pqHfGsIrLMz13vudCR2hD8nziZjRRp7v8aQ6RlE
         jrDRCOKejPQ1l7hHguFy9tIBk7+xJIUaAmAhOkdjf5z093jFcTNZc59Qu9O9jGAFImFh
         V9IrI8YAnIVK3nIhfmZDVWEZ+78OtRfJ3CGv7ABwggzbx+5c+9bcSm+uhUZNeA59Ra1A
         fEGj1Y+4x/oskTHNGMA+XGZRA2RX8sg1qAc6APzN1HpKInYyHXIbOkWXdnF0K7GJkeOF
         +NUQ==
X-Forwarded-Encrypted: i=1; AJvYcCWlZSI3Xsf+8ZvqFUw8tagZaQmm8txImHdSNJkUiDmZAjvwvG7eGioffbxb+MDRcHlS4QqZfeNsKBSd9uLy@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9uyje80b1JTafho4gg+VNQZ0jdHjowc3RT/kbHVPpCYREMz8h
	Y0SuycxBbqO8c6R4cseuTj2jszMqkLn9m3jBL5YkifusBOUdmy7uYiGW/AAIaYoEDfzsZEXWdiT
	Cx4hdVA==
X-Google-Smtp-Source: AGHT+IGb1KdAzn5YP1WDTyP0Cp9f49AuhUCkK4JgigY7PefACgEs5tH7aIbj4XAEANijeDnY8cuDukZytlM=
X-Received: from pjtd10.prod.google.com ([2002:a17:90b:4a:b0:311:c197:70a4])
 (user=surenb job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2702:b0:314:2939:efdc
 with SMTP id 98e67ed59e1d1-31aac44a392mr2310092a91.13.1751609263074; Thu, 03
 Jul 2025 23:07:43 -0700 (PDT)
Date: Thu,  3 Jul 2025 23:07:24 -0700
In-Reply-To: <20250704060727.724817-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250704060727.724817-1-surenb@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250704060727.724817-7-surenb@google.com>
Subject: [PATCH v6 6/8] fs/proc/task_mmu: remove conversion of seq_file
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
and change sentinel values to signed.

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 fs/proc/task_mmu.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index 751479eb128f..b8bc06d05a72 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -135,7 +135,7 @@ static struct vm_area_struct *proc_get_vma(struct proc_maps_private *priv,
 	if (vma) {
 		*ppos = vma->vm_start;
 	} else {
-		*ppos = -2UL;
+		*ppos = -2;
 		vma = get_gate_vma(priv->mm);
 	}
 
@@ -145,11 +145,11 @@ static struct vm_area_struct *proc_get_vma(struct proc_maps_private *priv,
 static void *m_start(struct seq_file *m, loff_t *ppos)
 {
 	struct proc_maps_private *priv = m->private;
-	unsigned long last_addr = *ppos;
+	loff_t last_addr = *ppos;
 	struct mm_struct *mm;
 
 	/* See m_next(). Zero at the start or after lseek. */
-	if (last_addr == -1UL)
+	if (last_addr == -1)
 		return NULL;
 
 	priv->task = get_proc_task(priv->inode);
@@ -170,9 +170,9 @@ static void *m_start(struct seq_file *m, loff_t *ppos)
 		return ERR_PTR(-EINTR);
 	}
 
-	vma_iter_init(&priv->iter, mm, last_addr);
+	vma_iter_init(&priv->iter, mm, (unsigned long)last_addr);
 	hold_task_mempolicy(priv);
-	if (last_addr == -2UL)
+	if (last_addr == -2)
 		return get_gate_vma(mm);
 
 	return proc_get_vma(priv, ppos);
@@ -180,8 +180,8 @@ static void *m_start(struct seq_file *m, loff_t *ppos)
 
 static void *m_next(struct seq_file *m, void *v, loff_t *ppos)
 {
-	if (*ppos == -2UL) {
-		*ppos = -1UL;
+	if (*ppos == -2) {
+		*ppos = -1;
 		return NULL;
 	}
 	return proc_get_vma(m->private, ppos);
-- 
2.50.0.727.gbf7dc18ff4-goog


