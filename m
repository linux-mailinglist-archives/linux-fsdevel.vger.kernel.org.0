Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 76A7E188E10
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Mar 2020 20:32:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726744AbgCQTcX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 17 Mar 2020 15:32:23 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:54462 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726452AbgCQTcW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 17 Mar 2020 15:32:22 -0400
Received: by mail-wm1-f67.google.com with SMTP id n8so556805wmc.4;
        Tue, 17 Mar 2020 12:32:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ricf2BdJdyy+MI+5dglcQZRK8QJ6f3OrAioatix4nI4=;
        b=MQBGgdIc2wwxwDHci9iOL34Nke69ZJWu8B5sq+F9EWNu+mUpHYe4fvuKEh2ot156GK
         eCjON/Up/2p+w0n4RGRP3z9ikGAlV8KaG9gHqmJpaDdjlxXVdrmeb+FZXzIEkRi414ce
         VQ4sPfa0xH+7InypWkujQLexO4/y1DQDSgIxkFPNlnbW0TJyKX68Ct4lXjmB0DJdTMjK
         nEGuyrGC9Q8RMouLezhkCkCX/TsO4iNpPCfIL232DB2WcaIThuB4NojUtcDGP+P37F7D
         A4sHfCeu9Gb3ZaorFoggJVCReOwg/3Y7pDPSTVJvitreABMr3HxK7b5cou67f5jDEj8y
         I6gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ricf2BdJdyy+MI+5dglcQZRK8QJ6f3OrAioatix4nI4=;
        b=U3bfkWoywxZYQ4N5X1KxtLZqlYDD8vGn5WGBCCjOnerbVezdCG3cHOiyMya3Elu08x
         X6BSp+hi9FmcKJZz/OVJz0eJ5qb61fN9/R9/JcrR1pH1w8cws6xFA8kal5ow/8GS9QVt
         wu04mvTO9UHfnVQUQvavYTeWCrEA+/F3C27liKugFMy4iSuOjxqGAu3c7/3YQOlMXe5S
         PLNaa0fQfQ6/rkvTDKY03+/LRS4slaxWmO04HRAdNBkZQFpHMHjg0FFyonQZtdaaAbEz
         RBP3Ecw5UcPRhlRms3sCcV1o7TAncXZdp5y9KRNRWDnVn/hF6LHncYn2lLN1bPOlA0Wh
         qOkw==
X-Gm-Message-State: ANhLgQ1+RoMnlZAhTh/9U+4dgSqzt2vpWmJFCDb9sGo7NtZZs+R9Qa6e
        Mgr4QnCiXP3kYdwAWDd8YA==
X-Google-Smtp-Source: ADFU+vvxZVQupZ78DRnmyyAffSMYsm5xmCWlr5bozfSNvDevSrGn3UYQDd5MKjqTqrexbeXypIArbQ==
X-Received: by 2002:a7b:c341:: with SMTP id l1mr557574wmj.146.1584473541281;
        Tue, 17 Mar 2020 12:32:21 -0700 (PDT)
Received: from avx2.telecom.by ([46.53.254.169])
        by smtp.gmail.com with ESMTPSA id t1sm5946323wrq.36.2020.03.17.12.32.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2020 12:32:20 -0700 (PDT)
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     akpm@linux-foundation.org
Cc:     willy@infradead.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk,
        adobriyan@gmail.com
Subject: [PATCH 2/5] proc: remove m_cache_vma
Date:   Tue, 17 Mar 2020 22:31:58 +0300
Message-Id: <20200317193201.9924-2-adobriyan@gmail.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200317193201.9924-1-adobriyan@gmail.com>
References: <20200317193201.9924-1-adobriyan@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: "Matthew Wilcox (Oracle)" <willy@infradead.org>

Instead of setting m->version in the show method, set it in m_next(),
where it should be.  Also remove the fallback code for failing to find
a vma, or version being zero.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---
 fs/proc/task_mmu.c | 38 ++++++--------------------------------
 1 file changed, 6 insertions(+), 32 deletions(-)

diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index 41f63df4789d..ff40d5d79f24 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -131,21 +131,14 @@ m_next_vma(struct proc_maps_private *priv, struct vm_area_struct *vma)
 	return vma->vm_next ?: priv->tail_vma;
 }
 
-static void m_cache_vma(struct seq_file *m, struct vm_area_struct *vma)
-{
-	if (m->count < m->size)	/* vma is copied successfully */
-		m->version = m_next_vma(m->private, vma) ? vma->vm_end : -1UL;
-}
-
 static void *m_start(struct seq_file *m, loff_t *ppos)
 {
 	struct proc_maps_private *priv = m->private;
 	unsigned long last_addr = m->version;
 	struct mm_struct *mm;
 	struct vm_area_struct *vma;
-	unsigned int pos = *ppos;
 
-	/* See m_cache_vma(). Zero at the start or after lseek. */
+	/* See m_next(). Zero at the start or after lseek. */
 	if (last_addr == -1UL)
 		return NULL;
 
@@ -170,28 +163,11 @@ static void *m_start(struct seq_file *m, loff_t *ppos)
 	hold_task_mempolicy(priv);
 	priv->tail_vma = get_gate_vma(mm);
 
-	if (last_addr) {
-		vma = find_vma(mm, last_addr - 1);
-		if (vma && vma->vm_start <= last_addr)
-			vma = m_next_vma(priv, vma);
-		if (vma)
-			return vma;
-	}
-
-	m->version = 0;
-	if (pos < mm->map_count) {
-		for (vma = mm->mmap; pos; pos--) {
-			m->version = vma->vm_start;
-			vma = vma->vm_next;
-		}
+	vma = find_vma(mm, last_addr);
+	if (vma)
 		return vma;
-	}
-
-	/* we do not bother to update m->version in this case */
-	if (pos == mm->map_count && priv->tail_vma)
-		return priv->tail_vma;
 
-	return NULL;
+	return priv->tail_vma;
 }
 
 static void *m_next(struct seq_file *m, void *v, loff_t *pos)
@@ -201,6 +177,8 @@ static void *m_next(struct seq_file *m, void *v, loff_t *pos)
 
 	(*pos)++;
 	next = m_next_vma(priv, v);
+	m->version = next ? next->vm_start : -1UL;
+
 	return next;
 }
 
@@ -359,7 +337,6 @@ show_map_vma(struct seq_file *m, struct vm_area_struct *vma)
 static int show_map(struct seq_file *m, void *v)
 {
 	show_map_vma(m, v);
-	m_cache_vma(m, v);
 	return 0;
 }
 
@@ -843,8 +820,6 @@ static int show_smap(struct seq_file *m, void *v)
 		seq_printf(m, "ProtectionKey:  %8u\n", vma_pkey(vma));
 	show_smap_vma_flags(m, vma);
 
-	m_cache_vma(m, vma);
-
 	return 0;
 }
 
@@ -1883,7 +1858,6 @@ static int show_numa_map(struct seq_file *m, void *v)
 	seq_printf(m, " kernelpagesize_kB=%lu", vma_kernel_pagesize(vma) >> 10);
 out:
 	seq_putc(m, '\n');
-	m_cache_vma(m, vma);
 	return 0;
 }
 
-- 
2.25.0

