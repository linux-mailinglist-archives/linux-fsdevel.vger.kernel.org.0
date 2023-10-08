Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1852D7BD00E
	for <lists+linux-fsdevel@lfdr.de>; Sun,  8 Oct 2023 22:23:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344620AbjJHUXa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 8 Oct 2023 16:23:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344590AbjJHUX0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 8 Oct 2023 16:23:26 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD47EAC;
        Sun,  8 Oct 2023 13:23:24 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-4065dea9a33so37583285e9.3;
        Sun, 08 Oct 2023 13:23:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696796603; x=1697401403; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xj76wJ9Zoom8wv+//ugduIlfQcCX14rBwnZA3eUs6cY=;
        b=j4zgUczgeIggSSznOPVE6wnl2CqQqeocYaKNwVGZblaLQvqVCEHT88RDPZI2vkQu77
         FGnMhXwvlPveKeKh36Ki++pGS6hVGoTFlnszs5ozjMkRFAeMbQqEhFuiKqFjA3q+8Lk2
         IJJsVZHXSErsCQV8eBTtUSC48DnS9DIDb7eQ/jC9+H2jBovu2pmh7KqehwUI59wUu0PU
         bBT1LMV5gi5DlA9lF1dQh8+FuOPKgTfdMccwTZSQd65Fjp57OMR3xuum1VgZQdaTeYWI
         b1js+S5mz8OSvBWX3+cEMKPQ52cyXHc1jIqRZmvnCQTG0rr6u88O202aLKyX8laU77bQ
         rbpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696796603; x=1697401403;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xj76wJ9Zoom8wv+//ugduIlfQcCX14rBwnZA3eUs6cY=;
        b=YFBgHjWhbIuiO8XcYurSWXHlkxSJxtPZItcXw8vVPVh2aT4Rs6tCKWYOjF9t4wKp0A
         lwRllsVP/P0SqdANfbllEfQDUfgoGMYu4KJLR7iYnGaSHcklh6QQ0pKMpVU71PXqUz3o
         at/TdAdqpnRbhqMJ9ytQZZn5IpoF+JmUPBT5Ik39X2wJJ8TfUT+KsaFlrXB77mwp0dF+
         sn163cYnb0WvTRcqODxhbRY6GzaYe4e+kyF6eoFzokKCr9oVMpWtyGLlaWlJiWBEl2kM
         Pbosl58xzh/1340LPU9QodlyUMlhWVz7kmp2foquwZ1E5bsuG/mfsvrPl/aBICzGh1v7
         Izlg==
X-Gm-Message-State: AOJu0YxVzr0YZ7nK6pDnJmUjvXLpGxqzUeeAY2uJ5d01DEjZae+6TNy2
        ZSPB9Lg8Opxlwb96L7Kj4FvzlxhAknA=
X-Google-Smtp-Source: AGHT+IG4F9Wkca1FesebOtAogwJp1fVsExkOmC7if9rq1cZTVc9/EQiXNYXRnEH6/EOgRmTVDlQ1tw==
X-Received: by 2002:a05:600c:2b0e:b0:406:848f:8711 with SMTP id y14-20020a05600c2b0e00b00406848f8711mr11974165wme.21.1696796602890;
        Sun, 08 Oct 2023 13:23:22 -0700 (PDT)
Received: from lucifer.home ([2a00:23c5:dc8c:8701:1663:9a35:5a7b:1d76])
        by smtp.googlemail.com with ESMTPSA id c5-20020a05600c0ac500b0040586360a36sm11474879wmr.17.2023.10.08.13.23.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Oct 2023 13:23:21 -0700 (PDT)
From:   Lorenzo Stoakes <lstoakes@gmail.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>
Cc:     "=Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        linux-fsdevel@vger.kernel.org, Lorenzo Stoakes <lstoakes@gmail.com>
Subject: [PATCH 2/4] mm: make vma_merge() and split_vma() internal
Date:   Sun,  8 Oct 2023 21:23:14 +0100
Message-ID: <6237f46d751d5dca385242a92c09169ad4d277ee.1696795837.git.lstoakes@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1696795837.git.lstoakes@gmail.com>
References: <cover.1696795837.git.lstoakes@gmail.com>
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

Now the vma_merge()/split_vma() pattern has been abstracted, we use it
entirely internally within mm/mmap.c, so make the function static. We also
no longer need vma_merge() anywhere else except mm/mremap.c, so make it
internal.

In addition, the split_vma() nommu variant also need not be exported.

Signed-off-by: Lorenzo Stoakes <lstoakes@gmail.com>
---
 include/linux/mm.h | 9 ---------
 mm/internal.h      | 9 +++++++++
 mm/mmap.c          | 8 ++++----
 mm/nommu.c         | 4 ++--
 4 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index c069813f215f..6aa532682094 100644
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
index 8c21171b431f..58d71f84e917 100644
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

