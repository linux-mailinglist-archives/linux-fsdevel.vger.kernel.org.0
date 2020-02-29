Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B0F95174836
	for <lists+linux-fsdevel@lfdr.de>; Sat, 29 Feb 2020 17:59:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727509AbgB2Q7V (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 29 Feb 2020 11:59:21 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:48524 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727220AbgB2Q7U (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 29 Feb 2020 11:59:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=R4/efYX2AMUxkzLNczQj9yHiCvePBGSNY4rfiNOEknk=; b=lb16h5oP6116M+XhI68IkvOiz/
        njG2n2wRWHSzWWkZ+UFcI/NlRZYDd8mQ41bFNK7IR5cw1bG0tUy5MAYxbInQWkQzRSvBVfevmpTep
        TkkMddzT75x3ndhW0+2HDc7bMVihG3kTnqYDsnxiUqM3ifSnd+62W157a7WGiSH2kcladV7JtS9cZ
        RjeJp0HX2tmfNHqmxyg3t2sDMhaUXtxFa75OWnPkFe9in45HUFFAL6DpGtLaB5NVI0Vdft4mOJL1X
        Y/uIqYkAwei+5veOWXv8PLyCsnyu5ZnuGAsAISr7eQaashJ4lB3QbkKHlUYLwQ8rd7QoEyi1BdNyf
        ZVBd4MKQ==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j85SJ-0006Pd-9t; Sat, 29 Feb 2020 16:59:11 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org,
        Alexey Dobriyan <adobriyan@gmail.com>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/5] proc: Inline vma_stop into m_stop
Date:   Sat, 29 Feb 2020 08:59:06 -0800
Message-Id: <20200229165910.24605-2-willy@infradead.org>
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

Instead of calling vma_stop() from m_start() and m_next(), do its work
in m_stop().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/proc/task_mmu.c | 34 +++++++++++++++-------------------
 1 file changed, 15 insertions(+), 19 deletions(-)

diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index 9442631fd4af..41f63df4789d 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -123,15 +123,6 @@ static void release_task_mempolicy(struct proc_maps_private *priv)
 }
 #endif
 
-static void vma_stop(struct proc_maps_private *priv)
-{
-	struct mm_struct *mm = priv->mm;
-
-	release_task_mempolicy(priv);
-	up_read(&mm->mmap_sem);
-	mmput(mm);
-}
-
 static struct vm_area_struct *
 m_next_vma(struct proc_maps_private *priv, struct vm_area_struct *vma)
 {
@@ -163,11 +154,16 @@ static void *m_start(struct seq_file *m, loff_t *ppos)
 		return ERR_PTR(-ESRCH);
 
 	mm = priv->mm;
-	if (!mm || !mmget_not_zero(mm))
+	if (!mm || !mmget_not_zero(mm)) {
+		put_task_struct(priv->task);
+		priv->task = NULL;
 		return NULL;
+	}
 
 	if (down_read_killable(&mm->mmap_sem)) {
 		mmput(mm);
+		put_task_struct(priv->task);
+		priv->task = NULL;
 		return ERR_PTR(-EINTR);
 	}
 
@@ -195,7 +191,6 @@ static void *m_start(struct seq_file *m, loff_t *ppos)
 	if (pos == mm->map_count && priv->tail_vma)
 		return priv->tail_vma;
 
-	vma_stop(priv);
 	return NULL;
 }
 
@@ -206,21 +201,22 @@ static void *m_next(struct seq_file *m, void *v, loff_t *pos)
 
 	(*pos)++;
 	next = m_next_vma(priv, v);
-	if (!next)
-		vma_stop(priv);
 	return next;
 }
 
 static void m_stop(struct seq_file *m, void *v)
 {
 	struct proc_maps_private *priv = m->private;
+	struct mm_struct *mm = priv->mm;
 
-	if (!IS_ERR_OR_NULL(v))
-		vma_stop(priv);
-	if (priv->task) {
-		put_task_struct(priv->task);
-		priv->task = NULL;
-	}
+	if (!priv->task)
+		return;
+
+	release_task_mempolicy(priv);
+	up_read(&mm->mmap_sem);
+	mmput(mm);
+	put_task_struct(priv->task);
+	priv->task = NULL;
 }
 
 static int proc_maps_open(struct inode *inode, struct file *file,
-- 
2.25.0

