Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3B787A2338
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Sep 2023 18:06:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234441AbjIOQGI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 Sep 2023 12:06:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234348AbjIOQFg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 Sep 2023 12:05:36 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DB251713
        for <linux-fsdevel@vger.kernel.org>; Fri, 15 Sep 2023 09:05:23 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id af79cd13be357-770819c1db6so149091785a.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 15 Sep 2023 09:05:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=hefring-com.20230601.gappssmtp.com; s=20230601; t=1694793922; x=1695398722; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fk8or89hqXtZNxRZ7/0FlKmmKA1FK/3FeO0U6tr3+Qw=;
        b=gGn6NV2E8bWZ9T5PsSi6eJ+t8/YYsopEEcY7XaOm5C0k3Fk2qZ/raXM+RKIjzlWvZs
         SckIpabPqYym/8yBNqP9MoUftyiq7C+L48d0CAL24qhmTdgem64BWpWDEOGqkXuKiEKF
         BV6eGsq9L+4b2BkJ+CIrd2AGCKBnslwRg7WpXyMXtlDcbWe0VQPwDicDgcQnY/RXM6L4
         H+6hMIjZ2KtkeJig2zea4u/iUmKfReHM/hx80UT99xXs0ZCjpg5fX5DVYd0xhb9vloIB
         Ekxnwh+ERVDxXaeTQppJrHRYdi8H3Vgup61ly5WcHsulsUW7jPRdBFx3IY/Snz5TP8fG
         Lw7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694793922; x=1695398722;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fk8or89hqXtZNxRZ7/0FlKmmKA1FK/3FeO0U6tr3+Qw=;
        b=oFE6g/w/vm7bz47hrAatsjNXzr9kCPPQshxmq97ZOCdssBhi7ZOfBTSGhtPFNO4gxA
         VGCKu2nkuzHQc1XUIep6/TS67btI5CaJSJxZnZBB73tXbOhX40/1TMr5bCax+7/pPHME
         Xl+upXGD9NFoiso8dQGCF4/m1peyd53/7H71fVuIdxNnCzdr+VGvP1fjQrT6XFEvk6JG
         n6t92L8itBOCc8I0+zHSnlF9COJfY/iz0IGLuNAQltKGfEZvIWBy2t8/zwwLLCTYfp4z
         QmCTAf5SKhqrudgHMUhJLrcoqW7mN9AZR8vQfjQ0tNda1ePspD6d9n/o9GrYsdp80233
         FvEg==
X-Gm-Message-State: AOJu0YyEM1edm1JE8juKhe+RzbAB5hDABLYyUfOj8j2YCZ+u0BbTtOkl
        BdQAUOTf+A7QNgwhGRGM1ZTJow==
X-Google-Smtp-Source: AGHT+IGNopyQAWgjLiZyLLE2OHldJh9hVHBKQnVhoXeQg4js5a7zst/J8AzN/m9JdWEFQ8h10KrTpA==
X-Received: by 2002:a05:620a:280c:b0:76f:12fa:c1ac with SMTP id f12-20020a05620a280c00b0076f12fac1acmr2187595qkp.28.1694793922431;
        Fri, 15 Sep 2023 09:05:22 -0700 (PDT)
Received: from localhost.localdomain ([50.212.55.89])
        by smtp.gmail.com with ESMTPSA id v5-20020ae9e305000000b0076d9e298928sm1311009qkf.66.2023.09.15.09.05.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Sep 2023 09:05:21 -0700 (PDT)
From:   Ben Wolsieffer <ben.wolsieffer@hefring.com>
To:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     Vlastimil Babka <vbabka@suse.cz>,
        "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Giulio Benetti <giulio.benetti@benettiengineering.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Ben Wolsieffer <ben.wolsieffer@hefring.com>
Subject: [PATCH] proc: nommu: fix empty /proc/<pid>/maps
Date:   Fri, 15 Sep 2023 12:00:56 -0400
Message-ID: <20230915160055.971059-2-ben.wolsieffer@hefring.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On no-MMU, /proc/<pid>/maps reads as an empty file. This happens because
find_vma(mm, 0) always returns NULL (assuming no vma actually contains
the zero address, which is normally the case).

To fix this bug and improve the maintainability in the future, this
patch makes the no-MMU implementation as similar as possible to the MMU
implementation.

The only remaining differences are the lack of
hold/release_task_mempolicy and the extra code to shoehorn the gate vma
into the iterator.

This has been tested on top of 6.5.3 on an STM32F746.

Fixes: 0c563f148043 ("proc: remove VMA rbtree use from nommu")
Signed-off-by: Ben Wolsieffer <ben.wolsieffer@hefring.com>
---
 fs/proc/internal.h   |  2 --
 fs/proc/task_nommu.c | 37 ++++++++++++++++++++++---------------
 2 files changed, 22 insertions(+), 17 deletions(-)

diff --git a/fs/proc/internal.h b/fs/proc/internal.h
index 9dda7e54b2d0..9a8f32f21ff5 100644
--- a/fs/proc/internal.h
+++ b/fs/proc/internal.h
@@ -289,9 +289,7 @@ struct proc_maps_private {
 	struct inode *inode;
 	struct task_struct *task;
 	struct mm_struct *mm;
-#ifdef CONFIG_MMU
 	struct vma_iterator iter;
-#endif
 #ifdef CONFIG_NUMA
 	struct mempolicy *task_mempolicy;
 #endif
diff --git a/fs/proc/task_nommu.c b/fs/proc/task_nommu.c
index 061bd3f82756..d3e19080df4a 100644
--- a/fs/proc/task_nommu.c
+++ b/fs/proc/task_nommu.c
@@ -188,15 +188,28 @@ static int show_map(struct seq_file *m, void *_p)
 	return nommu_vma_show(m, _p);
 }
 
-static void *m_start(struct seq_file *m, loff_t *pos)
+static struct vm_area_struct *proc_get_vma(struct proc_maps_private *priv,
+						loff_t *ppos)
+{
+	struct vm_area_struct *vma = vma_next(&priv->iter);
+
+	if (vma) {
+		*ppos = vma->vm_start;
+	} else {
+		*ppos = -1UL;
+	}
+
+	return vma;
+}
+
+static void *m_start(struct seq_file *m, loff_t *ppos)
 {
 	struct proc_maps_private *priv = m->private;
+	unsigned long last_addr = *ppos;
 	struct mm_struct *mm;
-	struct vm_area_struct *vma;
-	unsigned long addr = *pos;
 
-	/* See m_next(). Zero at the start or after lseek. */
-	if (addr == -1UL)
+	/* See proc_get_vma(). Zero at the start or after lseek. */
+	if (last_addr == -1UL)
 		return NULL;
 
 	/* pin the task and mm whilst we play with them */
@@ -218,12 +231,9 @@ static void *m_start(struct seq_file *m, loff_t *pos)
 		return ERR_PTR(-EINTR);
 	}
 
-	/* start the next element from addr */
-	vma = find_vma(mm, addr);
-	if (vma)
-		return vma;
+	vma_iter_init(&priv->iter, mm, last_addr);
 
-	return NULL;
+	return proc_get_vma(priv, ppos);
 }
 
 static void m_stop(struct seq_file *m, void *v)
@@ -240,12 +250,9 @@ static void m_stop(struct seq_file *m, void *v)
 	priv->task = NULL;
 }
 
-static void *m_next(struct seq_file *m, void *_p, loff_t *pos)
+static void *m_next(struct seq_file *m, void *_p, loff_t *ppos)
 {
-	struct vm_area_struct *vma = _p;
-
-	*pos = vma->vm_end;
-	return find_vma(vma->vm_mm, vma->vm_end);
+	return proc_get_vma(m->private, ppos);
 }
 
 static const struct seq_operations proc_pid_maps_ops = {
-- 
2.42.0

