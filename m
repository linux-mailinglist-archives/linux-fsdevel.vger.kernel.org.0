Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 520EA174837
	for <lists+linux-fsdevel@lfdr.de>; Sat, 29 Feb 2020 17:59:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727479AbgB2Q7P (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 29 Feb 2020 11:59:15 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:48502 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727220AbgB2Q7P (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 29 Feb 2020 11:59:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=B5x1KGhXgTj4rZpKWNMbv/j9tHW3KR8xER2nKA5ahK0=; b=dHmKR873n+B49VNJxrQDDf1Fzi
        jg4OIR+GYcy0S0P4nUUqlojTzwp6cl841jeJP5oLWNQ5kqD+zoqWSQwzNIibx4H0RsVqlQMZUJA3X
        veeV4+Vhy/22NIIMi5wE7M5ffU1W0SNW0rVKSgySjVlrqCDCBbo15FnGTS+wlm3YWqydonjvHRgcj
        FZ9tEe9RQ702ijm+XUpk4ulWjmDJJwNA5Xmp/KoGtUbbEWb853B11M+5NQzigmfBQdi8sEiWZ+0le
        mi2HAPZfsDUktxj45URf+0wi68SlOriCBHKsw3/RWobPGQpYZcko89dtg7yGC6D1M7v/OiHLR+aRK
        /P/glaTA==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j85SJ-0006Pt-E0; Sat, 29 Feb 2020 16:59:11 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org,
        Alexey Dobriyan <adobriyan@gmail.com>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 5/5] proc: Inline m_next_vma into m_next
Date:   Sat, 29 Feb 2020 08:59:10 -0800
Message-Id: <20200229165910.24605-6-willy@infradead.org>
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

It's clearer to just put this inline.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/proc/task_mmu.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index 9f10ef72b839..87641df8c0d0 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -123,14 +123,6 @@ static void release_task_mempolicy(struct proc_maps_private *priv)
 }
 #endif
 
-static struct vm_area_struct *
-m_next_vma(struct proc_maps_private *priv, struct vm_area_struct *vma)
-{
-	if (vma == priv->tail_vma)
-		return NULL;
-	return vma->vm_next ?: priv->tail_vma;
-}
-
 static void *m_start(struct seq_file *m, loff_t *ppos)
 {
 	struct proc_maps_private *priv = m->private;
@@ -173,9 +165,15 @@ static void *m_start(struct seq_file *m, loff_t *ppos)
 static void *m_next(struct seq_file *m, void *v, loff_t *ppos)
 {
 	struct proc_maps_private *priv = m->private;
-	struct vm_area_struct *next;
+	struct vm_area_struct *next, *vma = v;
+
+	if (vma == priv->tail_vma)
+		next = NULL;
+	else if (vma->vm_next)
+		next = vma->vm_next;
+	else
+		next = priv->tail_vma;
 
-	next = m_next_vma(priv, v);
 	*ppos = next ? next->vm_start : -1UL;
 
 	return next;
-- 
2.25.0

