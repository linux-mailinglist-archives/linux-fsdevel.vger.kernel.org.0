Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C0997C0358
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Oct 2023 20:23:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343554AbjJJSXf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Oct 2023 14:23:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232771AbjJJSXZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Oct 2023 14:23:25 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D3E8B4;
        Tue, 10 Oct 2023 11:23:23 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-406619b53caso55636875e9.1;
        Tue, 10 Oct 2023 11:23:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696962202; x=1697567002; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xYZtGWQnk+qTSD3PTRtexwtcvMKng8mprQW/gWAvlII=;
        b=Do005hS3MBtjlRP/eePtZYM2fbI8oEUW8eCM2L5plqHtFOAExM8jV+oKRZrqUREm9d
         n+PZoZSVoiELbAEpS+t1Dw/OdxMX/c1r/A+usd7GEJY0KWy7dtPTBK9ZDWNhdUK7Qyi/
         dP4PjWpi7iM+Z1i/jDHLcpqxQ6f2zqK10uDCB6AaKckLlZw4w6rGskOPoE2d9dXpZlss
         S+hajuSXmL/h4m335de8iB/Tpv4Emj8Qi/dEb3qiMySf7hHcx+TAH5ZkWET8jtlJFPxc
         D/zKdFRk/OvBp2lTooE6094QvFGfi0lbO2zCkrtZ+c6yPahEWq5J9iNqsWFrDfi+6Seo
         O+sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696962202; x=1697567002;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xYZtGWQnk+qTSD3PTRtexwtcvMKng8mprQW/gWAvlII=;
        b=iv8p8ehGTJOdz8L8TGmcGr9+BVfVCdDnYs9Wt1tzOLdiwjQF+7gpya+IcP++qg0LB7
         07XE5SEMN3FpoWAwQN/gOzq7lYZqHc7gWXGAdrD66+3rtQFmK0yfgMZbqMlyaQgkfits
         z00Xuyc5PRHB5XtfjFGUtwvlMWIEjKL/ElKfTjXIGrRRm4ddYp792iROTmmPC6UQ2IY6
         NcKX2MAoDQbXGyMPuncSC8ZrvjiPeC0c73u9mO6b4Z1vVvuySi5VPYOFgY/CU9hegAZ5
         0z4I/COmNJjF85F3TG1mVCugFy9mL2iLlGhmbCn/EcLF4u7vEU5d8u+K3e4ZTCqQTQ6B
         Zwjw==
X-Gm-Message-State: AOJu0YyMwzyRm6mE3w1rsN15VMIal6RuxGuRKLVbJvgX70fVj0IQhsDl
        OK7EyJ+jOndhWuXNxxhvK5U=
X-Google-Smtp-Source: AGHT+IFeSuY+leWpp9QNGQShZwfaneWw9EVs9ggK3b4usECxkab1t01uZ2nxvXac8yGuffFvBzg59A==
X-Received: by 2002:a05:600c:2298:b0:406:513d:7373 with SMTP id 24-20020a05600c229800b00406513d7373mr17049867wmf.11.1696962201906;
        Tue, 10 Oct 2023 11:23:21 -0700 (PDT)
Received: from lucifer.home ([2a00:23c5:dc8c:8701:1663:9a35:5a7b:1d76])
        by smtp.googlemail.com with ESMTPSA id j16-20020a5d6190000000b003217cbab88bsm13225312wru.16.2023.10.10.11.23.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Oct 2023 11:23:20 -0700 (PDT)
From:   Lorenzo Stoakes <lstoakes@gmail.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>
Cc:     "=Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        linux-fsdevel@vger.kernel.org, Lorenzo Stoakes <lstoakes@gmail.com>
Subject: [PATCH v3 3/5] mm: make vma_merge() and split_vma() internal
Date:   Tue, 10 Oct 2023 19:23:06 +0100
Message-ID: <188659ab3a8efc58a26fbd64b735ebbb88a65aa0.1696929425.git.lstoakes@gmail.com>
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

Now the common pattern of - attempting a merge via vma_merge() and should
this fail splitting VMAs via split_vma() - has been abstracted, the former
can be placed into mm/internal.h and the latter made static.

In addition, the split_vma() nommu variant also need not be exported.

Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
Signed-off-by: Lorenzo Stoakes <lstoakes@gmail.com>
---
 include/linux/mm.h | 9 ---------
 mm/internal.h      | 9 +++++++++
 mm/mmap.c          | 8 ++++----
 mm/nommu.c         | 4 ++--
 4 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 83ee1f35febe..74d7547ffb70 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -3237,16 +3237,7 @@ extern int vma_expand(struct vma_iterator *vmi, struct vm_area_struct *vma,
 		      struct vm_area_struct *next);
 extern int vma_shrink(struct vma_iterator *vmi, struct vm_area_struct *vma,
 		       unsigned long start, unsigned long end, pgoff_t pgoff);
-extern struct vm_area_struct *vma_merge(struct vma_iterator *vmi,
-	struct mm_struct *, struct vm_area_struct *prev, unsigned long addr,
-	unsigned long end, unsigned long vm_flags, struct anon_vma *,
-	struct file *, pgoff_t, struct mempolicy *, struct vm_userfaultfd_ctx,
-	struct anon_vma_name *);
 extern struct anon_vma *find_mergeable_anon_vma(struct vm_area_struct *);
-extern int __split_vma(struct vma_iterator *vmi, struct vm_area_struct *,
-		       unsigned long addr, int new_below);
-extern int split_vma(struct vma_iterator *vmi, struct vm_area_struct *,
-			 unsigned long addr, int new_below);
 extern int insert_vm_struct(struct mm_struct *, struct vm_area_struct *);
 extern void unlink_file_vma(struct vm_area_struct *);
 extern struct vm_area_struct *copy_vma(struct vm_area_struct **,
diff --git a/mm/internal.h b/mm/internal.h
index 3a72975425bb..ddaeb9f2d9d7 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -1011,6 +1011,15 @@ struct page *follow_trans_huge_pmd(struct vm_area_struct *vma,
 				   unsigned long addr, pmd_t *pmd,
 				   unsigned int flags);
 
+/*
+ * mm/mmap.c
+ */
+struct vm_area_struct *vma_merge(struct vma_iterator *vmi,
+	struct mm_struct *, struct vm_area_struct *prev, unsigned long addr,
+	unsigned long end, unsigned long vm_flags, struct anon_vma *,
+	struct file *, pgoff_t, struct mempolicy *, struct vm_userfaultfd_ctx,
+	struct anon_vma_name *);
+
 enum {
 	/* mark page accessed */
 	FOLL_TOUCH = 1 << 16,
diff --git a/mm/mmap.c b/mm/mmap.c
index bca685820763..a516f2412f79 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -2346,8 +2346,8 @@ static void unmap_region(struct mm_struct *mm, struct ma_state *mas,
  * has already been checked or doesn't make sense to fail.
  * VMA Iterator will point to the end VMA.
  */
-int __split_vma(struct vma_iterator *vmi, struct vm_area_struct *vma,
-		unsigned long addr, int new_below)
+static int __split_vma(struct vma_iterator *vmi, struct vm_area_struct *vma,
+		       unsigned long addr, int new_below)
 {
 	struct vma_prepare vp;
 	struct vm_area_struct *new;
@@ -2428,8 +2428,8 @@ int __split_vma(struct vma_iterator *vmi, struct vm_area_struct *vma,
  * Split a vma into two pieces at address 'addr', a new vma is allocated
  * either for the first part or the tail.
  */
-int split_vma(struct vma_iterator *vmi, struct vm_area_struct *vma,
-	      unsigned long addr, int new_below)
+static int split_vma(struct vma_iterator *vmi, struct vm_area_struct *vma,
+		     unsigned long addr, int new_below)
 {
 	if (vma->vm_mm->map_count >= sysctl_max_map_count)
 		return -ENOMEM;
diff --git a/mm/nommu.c b/mm/nommu.c
index f9553579389b..fc4afe924ad5 100644
--- a/mm/nommu.c
+++ b/mm/nommu.c
@@ -1305,8 +1305,8 @@ SYSCALL_DEFINE1(old_mmap, struct mmap_arg_struct __user *, arg)
  * split a vma into two pieces at address 'addr', a new vma is allocated either
  * for the first part or the tail.
  */
-int split_vma(struct vma_iterator *vmi, struct vm_area_struct *vma,
-	      unsigned long addr, int new_below)
+static int split_vma(struct vma_iterator *vmi, struct vm_area_struct *vma,
+		     unsigned long addr, int new_below)
 {
 	struct vm_area_struct *new;
 	struct vm_region *region;
-- 
2.42.0

