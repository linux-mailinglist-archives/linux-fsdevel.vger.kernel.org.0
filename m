Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9EDAD17482F
	for <lists+linux-fsdevel@lfdr.de>; Sat, 29 Feb 2020 17:59:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727461AbgB2Q7M (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 29 Feb 2020 11:59:12 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:48496 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727220AbgB2Q7L (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 29 Feb 2020 11:59:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=Cn5vXJtCX5densT7YR0QVPmHHiF9oMHR5C0MELn/q+4=; b=Tu7dp3VDlW8OZMzuGS7XyGSpUB
        l4UY3cVZspUQVMpXX3zs3ioJCE6j3kn8PqholnPE4ft+HocrEI0TpUk0U/dCqaWToaRxALAZxorHo
        A0JjG35KVN2Llhk/AsF3CNHWjeeFoSren2kgC5Se2HBP8ukYeeRUZijuhoooG9jwrWllFzqAmgAxd
        vw8hIOvFLlwztmJCyviKhkXNOypCAUD/bdNufKR0NZxKsjd/+ZQP8+9eCD52eXFOpvv0PNGjiRVXZ
        5OXLoLn2q26LngA+TnoU2mOoI1Sx6rfQpMivYR2kVzfTrT3R+Xxf0YrTKQqXAu5/WvFHCaJsiE1+N
        v18I+sxA==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j85SJ-0006Ph-As; Sat, 29 Feb 2020 16:59:11 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org,
        Alexey Dobriyan <adobriyan@gmail.com>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/5] proc: remove m_cache_vma
Date:   Sat, 29 Feb 2020 08:59:07 -0800
Message-Id: <20200229165910.24605-3-willy@infradead.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200229165910.24605-1-willy@infradead.org>
References: <20200229165910.24605-1-willy@infradead.org>
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

