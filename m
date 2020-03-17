Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AB2AE188E13
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Mar 2020 20:32:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726549AbgCQTcV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 17 Mar 2020 15:32:21 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:54457 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726452AbgCQTcV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 17 Mar 2020 15:32:21 -0400
Received: by mail-wm1-f67.google.com with SMTP id n8so556695wmc.4;
        Tue, 17 Mar 2020 12:32:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2XX4av8BnQU6e6Q+23VgYpg7tfVGDDTS18cCb+m0Cnw=;
        b=jiIM9lHYCWJsyJYYKw/eUmEOJiRPiA3aEmTJcqBRnVL+QGoUGWKGHCYVtY2pMOxQ1v
         ryheDWKm6/z2USIYYGlELv4mvdDJkHFlnCnjC/p4iKXAYQ6k7v2aEWIYZYOVC8VbKhLb
         Gr1XGJPP++W2VBkjrD3eUY7MlvJwjN+1nmdqRjNjvNbNndbbNZnsyJ6B4rn5cvYgENwA
         v/nG1570bie4b7+DnRuxZ21Q+crpwji1z2X4pabkuxHj6/iP2opx6ttDkHZ8+7DvHrng
         H0Lh1ph5fxe3rP3KOva9w55LRvG8poF5FjXWOruFvIue2p+fKxb1B8+T6P8MpsCpqQT+
         CkNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2XX4av8BnQU6e6Q+23VgYpg7tfVGDDTS18cCb+m0Cnw=;
        b=pDXOoRO6x7dcRxXl4N0mvsFBNbgEHbbOIbAzJLVmVg3hFV0cVx5ry0vIvRZtLJcFrw
         sn5poiVGP7OYohpfUwxu87oI3jdTKd07EBauCVmNAh0PtXtI7l+0K4p364VsQoSGoGCN
         HSXNe2NjG60sVan2MamgHmQQpKjDPD2CfZBgTP8Zl/6vZXSIV6KDq6lZ9/d1NVox+aoR
         nhi2wGiSHRh5MKAeRWpxNujyRAmnL2jPMqEJ7gq0y9TKhEyFlWQDe43HLBAjAyj1yNR9
         QChPfb8adGxvKI8heibaIV0+ay8A06MxaQG4wF8F2Jdmna+F4hzl0t6m0utCp8wlLlrf
         IewA==
X-Gm-Message-State: ANhLgQ0vy9Gf8yz4myoqVQjGgAxYMb69dIsrSkkU48qwF9V1pwe1EA1h
        N+EzjCWetcKMRHohY7E7jQ==
X-Google-Smtp-Source: ADFU+vscvNdlS7W3wTEb5lVjwADvZtMOhQtwRZBnBmvJ9Jb1GYuGAULitlstbaS8mZ8IrVbyxspSgA==
X-Received: by 2002:a7b:c189:: with SMTP id y9mr545264wmi.47.1584473539381;
        Tue, 17 Mar 2020 12:32:19 -0700 (PDT)
Received: from avx2.telecom.by ([46.53.254.169])
        by smtp.gmail.com with ESMTPSA id t1sm5946323wrq.36.2020.03.17.12.32.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2020 12:32:18 -0700 (PDT)
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     akpm@linux-foundation.org
Cc:     willy@infradead.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk,
        adobriyan@gmail.com
Subject: [PATCH 1/5] proc: inline vma_stop into m_stop
Date:   Tue, 17 Mar 2020 22:31:57 +0300
Message-Id: <20200317193201.9924-1-adobriyan@gmail.com>
X-Mailer: git-send-email 2.24.1
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
Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
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

