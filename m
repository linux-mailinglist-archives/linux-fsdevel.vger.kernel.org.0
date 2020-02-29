Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E2860174832
	for <lists+linux-fsdevel@lfdr.de>; Sat, 29 Feb 2020 17:59:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727495AbgB2Q7S (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 29 Feb 2020 11:59:18 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:48506 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727220AbgB2Q7R (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 29 Feb 2020 11:59:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=bZU1QGPbEb9lwYcRay9rnLUfHS7hKzLwsMAyIzDNWkg=; b=jsgOkQwkkT0KHcR2nj2716cdst
        kY/O8yozEfzK2cv3PDhivghxWgCESjlG6c0b9uPY7Vbtky3sDuDq6anEmRqCaDMqTDCw+7Kf/J5Cs
        vjt/XdMPHLFEYm8V4vz2TqYKRABy6tPxizBABYp2nW7P7FIYIGpFcGp35sSn0QdmCfQ5x+nkhOwW3
        i0BfctIPjehI1wqagGKf5LyX7ng3lYAb3noc+egM8zukMKYPtQjob3QHoaa/ZHJ1+R+JZ6EkvgQcb
        yL1b8E2tZqNCyNmwScJ9yjGc5OwSB2vlgPr/5bAVwShrAo7DHlmcEgbpr4rkBvNyb+kyGYi186Py1
        TpXB8JEg==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j85SJ-0006Pl-Bu; Sat, 29 Feb 2020 16:59:11 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org,
        Alexey Dobriyan <adobriyan@gmail.com>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/5] proc: Use ppos instead of m->version
Date:   Sat, 29 Feb 2020 08:59:08 -0800
Message-Id: <20200229165910.24605-4-willy@infradead.org>
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

The ppos is a private cursor, just like m->version.  Use the canonical
cursor, not a special one.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/proc/task_mmu.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index ff40d5d79f24..9f10ef72b839 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -134,7 +134,7 @@ m_next_vma(struct proc_maps_private *priv, struct vm_area_struct *vma)
 static void *m_start(struct seq_file *m, loff_t *ppos)
 {
 	struct proc_maps_private *priv = m->private;
-	unsigned long last_addr = m->version;
+	unsigned long last_addr = *ppos;
 	struct mm_struct *mm;
 	struct vm_area_struct *vma;
 
@@ -170,14 +170,13 @@ static void *m_start(struct seq_file *m, loff_t *ppos)
 	return priv->tail_vma;
 }
 
-static void *m_next(struct seq_file *m, void *v, loff_t *pos)
+static void *m_next(struct seq_file *m, void *v, loff_t *ppos)
 {
 	struct proc_maps_private *priv = m->private;
 	struct vm_area_struct *next;
 
-	(*pos)++;
 	next = m_next_vma(priv, v);
-	m->version = next ? next->vm_start : -1UL;
+	*ppos = next ? next->vm_start : -1UL;
 
 	return next;
 }
-- 
2.25.0

