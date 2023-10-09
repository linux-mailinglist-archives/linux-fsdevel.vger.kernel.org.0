Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40FEF7BEC04
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Oct 2023 22:54:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377989AbjJIUyD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Oct 2023 16:54:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378102AbjJIUxm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Oct 2023 16:53:42 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D67BCF;
        Mon,  9 Oct 2023 13:53:39 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id ffacd0b85a97d-3232be274a0so3649600f8f.1;
        Mon, 09 Oct 2023 13:53:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696884817; x=1697489617; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TNmdoeRWtzhEBIdrRfXv8hL/K0SAgSJWqJyZUiMnE00=;
        b=EpqjRpfyiiX7wHKgfKsbcl2biJq1/1RXqVPajYmQau6r/EuHInFB2i4eqyIbY2kF1N
         S+DJCpIpDjZtVfhoi0SLXY30mR6a7cL/1dmNRbyOcuusxeZ5eEUkM5E1HwhpksOMdZQ0
         Q3pwjAUuFOaqbfaGkmEkfb7wvndJ7EHAshyDuF8HKUyfS6jp+MerjJfbln1FH6iNz/88
         tqt9QB0NnQRNpNsdxOOcd+BupfRUdBiO1QqkaRoMciMBGMqGpBSneTeaH+5mQEvrCn4b
         LvVsplgV3DzNZu0zyC6dNcZ8tYDYBm9mMDEIqY5OpgVJBrZI9tFcrpWS2MI5MSLcS5SH
         RW/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696884817; x=1697489617;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TNmdoeRWtzhEBIdrRfXv8hL/K0SAgSJWqJyZUiMnE00=;
        b=Jgw59/3+K5Qvx7s722bcTnNMs6cB8aY8x7sbPnbtSRSaqPiDu80JGxc2MkudIEveZa
         7UPZtRXpw/mU2tCvb7kYfR1qsLG18TY8yPN237Ej+1+jqED4b4QTSPXHZFQsbFbBAVkY
         UYU44RBl38gF70BIOcPHXF5VKgC6LWlNs/zImGlEbV+atfDdyay44GpnuFrO+yN5+yw5
         9PAURAxdceL4gxsRJwNiiy72qa4JMwsXog/zVDYtYuhtH2V1qHWPxTBn+O4YMls50/EF
         t+dnAd+MESglg5UZiOYwxMLwUHatI3TNXYqzSDmKzaB8NsqWjabejXJlbL+2DgaOHDfL
         krMA==
X-Gm-Message-State: AOJu0Yw5gN47PLJgl+0qdnoZOd1S+w6ARGi02QV59bEzk0+/UCKX9dtL
        05Hq8nwJRE48JLt9hpp5l6E=
X-Google-Smtp-Source: AGHT+IGxaxbfOsmbWfYeIketHcaygFp0L6cqjHa1Rm6inszqpIbIyR7FdF/1P3t2wIMfyeWkX0LuMQ==
X-Received: by 2002:a05:6000:3c3:b0:32c:d29c:2f77 with SMTP id b3-20020a05600003c300b0032cd29c2f77mr40326wrg.1.1696884817261;
        Mon, 09 Oct 2023 13:53:37 -0700 (PDT)
Received: from lucifer.home ([2a00:23c5:dc8c:8701:1663:9a35:5a7b:1d76])
        by smtp.googlemail.com with ESMTPSA id l2-20020a5d4802000000b0031fe0576460sm10578130wrq.11.2023.10.09.13.53.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Oct 2023 13:53:36 -0700 (PDT)
From:   Lorenzo Stoakes <lstoakes@gmail.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>
Cc:     "=Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        linux-fsdevel@vger.kernel.org, Lorenzo Stoakes <lstoakes@gmail.com>
Subject: [PATCH v2 3/5] mm: make vma_merge() and split_vma() internal
Date:   Mon,  9 Oct 2023 21:53:18 +0100
Message-ID: <31d2c79f7a3bca03d4a4c95e98d9a27cb1f99bf1.1696884493.git.lstoakes@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1696884493.git.lstoakes@gmail.com>
References: <cover.1696884493.git.lstoakes@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
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
index 22d968affc07..17c0dcfb1527 100644
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

