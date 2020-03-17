Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 15ABC188E0D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Mar 2020 20:32:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726783AbgCQTc1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 17 Mar 2020 15:32:27 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:41230 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726757AbgCQTcZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 17 Mar 2020 15:32:25 -0400
Received: by mail-wr1-f67.google.com with SMTP id f11so10471012wrp.8;
        Tue, 17 Mar 2020 12:32:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mFBe8SVNMk8NQ0Cg/QItB1GqMx3KA9maWgv9PhH0jlI=;
        b=ExojwpsOYrw9jNcEILxqwlqDbYs2+T3W9Bxla2mm+2xgjNUcKz+Qt1gOyDEOVhmP25
         iHqDSFdxlRx6z2xS/ITZFKAF1RpmOEKgPPZfIuNoL9JiWR5qP9/7i4tmGXO2uNGDFdWp
         xddeLk69emf+MA/kpAqwidDVKInIMavAVEmArRCNJmy5wi0OM2/etWk/3hHRcz47mY8s
         hD7MFxBw+lpa0OW+M/WUePEbKpTU5TtPQvagHuoJk5NTuHHoGLDyto1GmxlB8hlzrtcs
         q2J1Zzwfrw8IYdqD5YZVDY3NM4gcclIS0k/j5WMEFTYhXNMOxlN9MKUaq0/m1t3DRt+H
         EDgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mFBe8SVNMk8NQ0Cg/QItB1GqMx3KA9maWgv9PhH0jlI=;
        b=meTunc1GJCAhjZGhpfjuW8CpYoPFySmUVzFemqMJRWpLzZY1qe/FHiiBTLDHlTNzlB
         XFrdCdDsuIodQnOAsH/cJbSdaRuzrNJxk3MgwKaxYimGrLW6e6nVTH4Y96Ylq5L6+qYM
         rhQULAVcQGP5FrfdZZs7DhhFY2oit156BQ1MeAaUkmtgXq6Q7bxJXazFDJqaweohNsfL
         stBSwbV5gQa4tSF601amW4W3z5eHOvvjEWVsZuOihwmJko3mNlasYZ2S1XoWrzNNKOzu
         eIK3Ux47+5jh6T/zjTJoVFq3lOmedCAoDbXXZtC2QSCiBPCHgobiXB27sh6SFgh0ZiJG
         xfyg==
X-Gm-Message-State: ANhLgQ2obyUjKRU+Nb9bwPaKAzb3w3znMNaM3dRNV96s0mac4U5VCH0R
        35YanKIlUFhmpoPq8kqpZeshA7M=
X-Google-Smtp-Source: ADFU+vtR/cAJQtnRHSKPRb6ac82+gTJz0ySapTCYJNA8csRijl2D3EJ6n1KfHg7MmJEoMZhuvFUDEw==
X-Received: by 2002:adf:91c3:: with SMTP id 61mr594754wri.384.1584473543461;
        Tue, 17 Mar 2020 12:32:23 -0700 (PDT)
Received: from avx2.telecom.by ([46.53.254.169])
        by smtp.gmail.com with ESMTPSA id t1sm5946323wrq.36.2020.03.17.12.32.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2020 12:32:22 -0700 (PDT)
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     akpm@linux-foundation.org
Cc:     willy@infradead.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk,
        adobriyan@gmail.com
Subject: [PATCH 3/5] proc: use ppos instead of m->version
Date:   Tue, 17 Mar 2020 22:31:59 +0300
Message-Id: <20200317193201.9924-3-adobriyan@gmail.com>
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

The ppos is a private cursor, just like m->version.  Use the canonical
cursor, not a special one.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
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

