Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 309417C035B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Oct 2023 20:24:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234160AbjJJSYJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Oct 2023 14:24:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234252AbjJJSXe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Oct 2023 14:23:34 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A366ED3;
        Tue, 10 Oct 2023 11:23:26 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-40666aa674fso56556985e9.0;
        Tue, 10 Oct 2023 11:23:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696962205; x=1697567005; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vy50Imp7hsFcD9fQ9yun20NmSXPiCxJvkitJven0GZ0=;
        b=N7BDA+6Li75fATy2x1o65jGpuOrb7lkdTK+F7gqjzZamZHmeA1/dJsFUaBTORtlF1p
         xSrGGWv9AQfvLbzgK92e+cL1Xu0DDcR1wK5+ZsS+Re/w2akiV0YF312CjhJkvMHNh6f7
         L4psrlLf2eRerhGj7K8DXM6tQfatwe4NkZeIGpVam83zCnh8iQhQglNsKGHsWUwJ3AjG
         Tb/uZP3W75cuZfYXoXr/wiq9dDU6kNNwXWgk7Rqb6ysKkugZ3btyBkvrLtno7dL5g2Sd
         6OvGPVGJDMKsw1FxWVE45H7JDDNZYdu5/J1VaXBFxYS+QVwWdT/FCmA5F0crrK/Iu69z
         rzYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696962205; x=1697567005;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vy50Imp7hsFcD9fQ9yun20NmSXPiCxJvkitJven0GZ0=;
        b=Uq6V6Cajz8i2tKJILlH3Tco2Z9syTKkHfuOnrbFqARUSkQYR5KvIm8m6j+tH6Jm/mo
         Pz15ofoMR2rcevDC0I9AYeCuPY/91NV5JlP/b/sAsVlI2T4cnmGhZD2jIz/pxhK2VflV
         8mos1mkn5z+LEXjSvajiRJqqfqh0gGDfkyeeMEzhduhWrY6ckrH6tSP+7LJJporZispa
         sd5UxzlDrkgJWqIN8i9Lw2jSLfSiNealP2NXqAaJVjfEslNy9fcn1AICE6gRSSff8NVf
         uzFprY1s3M4PgD2An34XI7Zxk0BlgqnkQheIDlgkkz+lhqW2aLtXgioTVo5wllnKlli1
         UpPg==
X-Gm-Message-State: AOJu0YwPYENGMOFsb179UpW3z5FcblpSZdo7ESqqOEIo28xgp19GV3hr
        5zckEN9nysCl2KnnXYPEbk0=
X-Google-Smtp-Source: AGHT+IESkqPmjjAOvbILmnJkd4RsbqA/GSj+EQxsInZHrckbIauEIItGkohtMZgNuXuLytwtz90QZQ==
X-Received: by 2002:a05:600c:ad0:b0:406:7029:7cc3 with SMTP id c16-20020a05600c0ad000b0040670297cc3mr15993235wmr.28.1696962204923;
        Tue, 10 Oct 2023 11:23:24 -0700 (PDT)
Received: from lucifer.home ([2a00:23c5:dc8c:8701:1663:9a35:5a7b:1d76])
        by smtp.googlemail.com with ESMTPSA id j16-20020a5d6190000000b003217cbab88bsm13225312wru.16.2023.10.10.11.23.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Oct 2023 11:23:22 -0700 (PDT)
From:   Lorenzo Stoakes <lstoakes@gmail.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>
Cc:     "=Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        linux-fsdevel@vger.kernel.org, Lorenzo Stoakes <lstoakes@gmail.com>
Subject: [PATCH v3 4/5] mm: abstract merge for new VMAs into vma_merge_new_vma()
Date:   Tue, 10 Oct 2023 19:23:07 +0100
Message-ID: <fe658ae961de1206f1557001f4d41d6e931d3919.1696929425.git.lstoakes@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1696929425.git.lstoakes@gmail.com>
References: <cover.1696929425.git.lstoakes@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Only in mmap_region() and copy_vma() do we attempt to merge VMAs which
occupy entirely new regions of virtual memory.

We can abstract this logic and make the intent of this invocations of it
completely explicit, rather than invoking vma_merge() with an inscrutable
wall of parameters.

This also paves the way for a simplification of the core vma_merge()
implementation, as we seek to make it entirely an implementation detail.

Note that on mmap_region(), VMA fields are initialised to zero, so we can
simply reference these rather than explicitly specifying NULL.

Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
Signed-off-by: Lorenzo Stoakes <lstoakes@gmail.com>
---
 mm/mmap.c | 27 ++++++++++++++++++++-------
 1 file changed, 20 insertions(+), 7 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index a516f2412f79..db3842601a88 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -2485,6 +2485,22 @@ struct vm_area_struct *vma_modify(struct vma_iterator *vmi,
 	return vma;
 }
 
+/*
+ * Attempt to merge a newly mapped VMA with those adjacent to it. The caller
+ * must ensure that [start, end) does not overlap any existing VMA.
+ */
+static struct vm_area_struct *vma_merge_new_vma(struct vma_iterator *vmi,
+						struct vm_area_struct *prev,
+						struct vm_area_struct *vma,
+						unsigned long start,
+						unsigned long end,
+						pgoff_t pgoff)
+{
+	return vma_merge(vmi, vma->vm_mm, prev, start, end, vma->vm_flags,
+			 vma->anon_vma, vma->vm_file, pgoff, vma_policy(vma),
+			 vma->vm_userfaultfd_ctx, anon_vma_name(vma));
+}
+
 /*
  * do_vmi_align_munmap() - munmap the aligned region from @start to @end.
  * @vmi: The vma iterator
@@ -2840,10 +2856,9 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 		 * vma again as we may succeed this time.
 		 */
 		if (unlikely(vm_flags != vma->vm_flags && prev)) {
-			merge = vma_merge(&vmi, mm, prev, vma->vm_start,
-				    vma->vm_end, vma->vm_flags, NULL,
-				    vma->vm_file, vma->vm_pgoff, NULL,
-				    NULL_VM_UFFD_CTX, NULL);
+			merge = vma_merge_new_vma(&vmi, prev, vma,
+						  vma->vm_start, vma->vm_end,
+						  pgoff);
 			if (merge) {
 				/*
 				 * ->mmap() can change vma->vm_file and fput
@@ -3385,9 +3400,7 @@ struct vm_area_struct *copy_vma(struct vm_area_struct **vmap,
 	if (new_vma && new_vma->vm_start < addr + len)
 		return NULL;	/* should never get here */
 
-	new_vma = vma_merge(&vmi, mm, prev, addr, addr + len, vma->vm_flags,
-			    vma->anon_vma, vma->vm_file, pgoff, vma_policy(vma),
-			    vma->vm_userfaultfd_ctx, anon_vma_name(vma));
+	new_vma = vma_merge_new_vma(&vmi, prev, vma, addr, addr + len, pgoff);
 	if (new_vma) {
 		/*
 		 * Source vma may have been merged into new_vma
-- 
2.42.0

