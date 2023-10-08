Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 045747BD00B
	for <lists+linux-fsdevel@lfdr.de>; Sun,  8 Oct 2023 22:23:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344608AbjJHUXa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 8 Oct 2023 16:23:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344467AbjJHUXZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 8 Oct 2023 16:23:25 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C93299;
        Sun,  8 Oct 2023 13:23:23 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-40684f53bfcso35599675e9.0;
        Sun, 08 Oct 2023 13:23:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696796601; x=1697401401; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oh6ec6CTQesC51vfa/4MCcXzfoVwgVcGNsFkXLPVEho=;
        b=esUqV6PRt1dJVwLCO4LT6NdW8eVE4ne5iU4/6+XRgtLmiDgCqhSgyVDiSajr6gd5Xl
         F+TtJkFABGITXvyOtzxW2Mbql/Gyd4x6YveQEIBGrT10mVXW5VqnGZXLphKBogRpaZej
         7AD0HoQi6N81KwcmddezKvbxPNE01XO0zNMaX2B6CuNTWDQKzIkRu9WIILCfPW/WF/WM
         pfMkXS7F05reffuyr0MEoTp1YxuaeTRgwOSAH/FbzlRPYoH3T1S4FbL5E+5wkTLM7oH4
         OVNSnjw1kN/TzqNa77JLN2AdDSfERH7lVR30PnIEkJLndfkBWj3ms0LXRoWcfOt8ibz7
         zgsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696796601; x=1697401401;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oh6ec6CTQesC51vfa/4MCcXzfoVwgVcGNsFkXLPVEho=;
        b=EJec6KmBbMkEyzCGpcCpyTX2PX9mmgLuVOj+gQoDIwALCpw2RDo08LTxthogajW3Sn
         SKMViEY7wbbBW7nqPRjrH8egTuFO8dZAx0v4Qwu8ppPiQcc0gWLui26cYAIFLnfwsNIK
         6e3+BvGynRZrTrkiaIt0uXZ0tDKITnJ3SUFpLH7W6wHb28VdP0CqilKvM5MaG2YE+1WG
         0l+T8gFd/Txdbta+Pcdiepj2peMPD8ubJIjSFt7dRMJ7IraURUuoPOM775zl6e/W0TYn
         AowuxLPVi48ffosPp1iVxQh4UCTGofqIVY0toLNPTLZsaWIEsjUt+crt2qOgAgTFOOn/
         ik5A==
X-Gm-Message-State: AOJu0Yytz9LtNx2kwNnD9COgcr0LRI/RikWfiIu+gN4/RHEEPKj2IOG/
        e6mQlmqqMzXKa/0r+QTwTMk=
X-Google-Smtp-Source: AGHT+IFX6EUh5dGcLh467RUTdLkD7TfmQOxpSCn/MZRadvHnRtJtkVpbin/HqLminQaG/NJnzpjLCg==
X-Received: by 2002:a1c:7419:0:b0:3fe:89be:cd3 with SMTP id p25-20020a1c7419000000b003fe89be0cd3mr11961603wmc.22.1696796601251;
        Sun, 08 Oct 2023 13:23:21 -0700 (PDT)
Received: from lucifer.home ([2a00:23c5:dc8c:8701:1663:9a35:5a7b:1d76])
        by smtp.googlemail.com with ESMTPSA id c5-20020a05600c0ac500b0040586360a36sm11474879wmr.17.2023.10.08.13.23.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Oct 2023 13:23:20 -0700 (PDT)
From:   Lorenzo Stoakes <lstoakes@gmail.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>
Cc:     "=Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        linux-fsdevel@vger.kernel.org, Lorenzo Stoakes <lstoakes@gmail.com>
Subject: [PATCH 1/4] mm: abstract the vma_merge()/split_vma() pattern for mprotect() et al.
Date:   Sun,  8 Oct 2023 21:23:13 +0100
Message-ID: <e5b228493b81d00fe3d82bd464976348df353733.1696795837.git.lstoakes@gmail.com>
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

mprotect() and other functions which change VMA parameters over a range
each employ a pattern of:-

1. Attempt to merge the range with adjacent VMAs.
2. If this fails, and the range spans a subset of the VMA, split it
accordingly.

This is open-coded and duplicated in each case. Also in each case most of
the parameters passed to vma_merge() remain the same.

Create a new static function, vma_modify(), which abstracts this operation,
accepting only those parameters which can be changed.

To avoid the mess of invoking each function call with unnecessary
parameters, create wrapper functions for each of the modify operations,
parameterised only by what is required to perform the action.

Note that the userfaultfd_release() case works even though it does not
split VMAs - since start is set to vma->vm_start and end is set to
vma->vm_end, the split logic does not trigger.

In addition, since we calculate pgoff to be equal to vma->vm_pgoff + (start
- vma->vm_start) >> PAGE_SHIFT, and start - vma->vm_start will be 0 in this
instance, this invocation will remain unchanged.

Signed-off-by: Lorenzo Stoakes <lstoakes@gmail.com>
---
 fs/userfaultfd.c   | 53 +++++++++-----------------
 include/linux/mm.h | 23 ++++++++++++
 mm/madvise.c       | 25 ++++---------
 mm/mempolicy.c     | 20 ++--------
 mm/mlock.c         | 24 ++++--------
 mm/mmap.c          | 93 ++++++++++++++++++++++++++++++++++++++++++++++
 mm/mprotect.c      | 27 ++++----------
 7 files changed, 157 insertions(+), 108 deletions(-)

diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
index a7c6ef764e63..9e5232d23927 100644
--- a/fs/userfaultfd.c
+++ b/fs/userfaultfd.c
@@ -927,11 +927,10 @@ static int userfaultfd_release(struct inode *inode, struct file *file)
 			continue;
 		}
 		new_flags = vma->vm_flags & ~__VM_UFFD_FLAGS;
-		prev = vma_merge(&vmi, mm, prev, vma->vm_start, vma->vm_end,
-				 new_flags, vma->anon_vma,
-				 vma->vm_file, vma->vm_pgoff,
-				 vma_policy(vma),
-				 NULL_VM_UFFD_CTX, anon_vma_name(vma));
+		prev = vma_modify_uffd(&vmi, prev, vma, vma->vm_start,
+				       vma->vm_end, new_flags,
+				       NULL_VM_UFFD_CTX);
+
 		if (prev) {
 			vma = prev;
 		} else {
@@ -1331,7 +1330,6 @@ static int userfaultfd_register(struct userfaultfd_ctx *ctx,
 	unsigned long start, end, vma_end;
 	struct vma_iterator vmi;
 	bool wp_async = userfaultfd_wp_async_ctx(ctx);
-	pgoff_t pgoff;
 
 	user_uffdio_register = (struct uffdio_register __user *) arg;
 
@@ -1484,26 +1482,18 @@ static int userfaultfd_register(struct userfaultfd_ctx *ctx,
 		vma_end = min(end, vma->vm_end);
 
 		new_flags = (vma->vm_flags & ~__VM_UFFD_FLAGS) | vm_flags;
-		pgoff = vma->vm_pgoff + ((start - vma->vm_start) >> PAGE_SHIFT);
-		prev = vma_merge(&vmi, mm, prev, start, vma_end, new_flags,
-				 vma->anon_vma, vma->vm_file, pgoff,
-				 vma_policy(vma),
-				 ((struct vm_userfaultfd_ctx){ ctx }),
-				 anon_vma_name(vma));
+		prev = vma_modify_uffd(&vmi, prev, vma, start, vma_end,
+				       new_flags,
+				       ((struct vm_userfaultfd_ctx){ ctx }));
 		if (prev) {
 			/* vma_merge() invalidated the mas */
 			vma = prev;
 			goto next;
 		}
-		if (vma->vm_start < start) {
-			ret = split_vma(&vmi, vma, start, 1);
-			if (ret)
-				break;
-		}
-		if (vma->vm_end > end) {
-			ret = split_vma(&vmi, vma, end, 0);
-			if (ret)
-				break;
+
+		if (IS_ERR(prev)) {
+			ret = PTR_ERR(prev);
+			break;
 		}
 	next:
 		/*
@@ -1568,7 +1558,6 @@ static int userfaultfd_unregister(struct userfaultfd_ctx *ctx,
 	const void __user *buf = (void __user *)arg;
 	struct vma_iterator vmi;
 	bool wp_async = userfaultfd_wp_async_ctx(ctx);
-	pgoff_t pgoff;
 
 	ret = -EFAULT;
 	if (copy_from_user(&uffdio_unregister, buf, sizeof(uffdio_unregister)))
@@ -1671,24 +1660,16 @@ static int userfaultfd_unregister(struct userfaultfd_ctx *ctx,
 			uffd_wp_range(vma, start, vma_end - start, false);
 
 		new_flags = vma->vm_flags & ~__VM_UFFD_FLAGS;
-		pgoff = vma->vm_pgoff + ((start - vma->vm_start) >> PAGE_SHIFT);
-		prev = vma_merge(&vmi, mm, prev, start, vma_end, new_flags,
-				 vma->anon_vma, vma->vm_file, pgoff,
-				 vma_policy(vma),
-				 NULL_VM_UFFD_CTX, anon_vma_name(vma));
+		prev = vma_modify_uffd(&vmi, prev, vma, start, vma_end,
+				       new_flags, NULL_VM_UFFD_CTX);
 		if (prev) {
 			vma = prev;
 			goto next;
 		}
-		if (vma->vm_start < start) {
-			ret = split_vma(&vmi, vma, start, 1);
-			if (ret)
-				break;
-		}
-		if (vma->vm_end > end) {
-			ret = split_vma(&vmi, vma, end, 0);
-			if (ret)
-				break;
+
+		if (IS_ERR(prev)) {
+			ret = PTR_ERR(prev);
+			break;
 		}
 	next:
 		/*
diff --git a/include/linux/mm.h b/include/linux/mm.h
index a7b667786cde..c069813f215f 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -3253,6 +3253,29 @@ extern struct vm_area_struct *copy_vma(struct vm_area_struct **,
 	unsigned long addr, unsigned long len, pgoff_t pgoff,
 	bool *need_rmap_locks);
 extern void exit_mmap(struct mm_struct *);
+struct vm_area_struct *vma_modify_flags(struct vma_iterator *vmi,
+					struct vm_area_struct *prev,
+					struct vm_area_struct *vma,
+					unsigned long start, unsigned long end,
+					unsigned long new_flags);
+struct vm_area_struct *vma_modify_flags_name(struct vma_iterator *vmi,
+					     struct vm_area_struct *prev,
+					     struct vm_area_struct *vma,
+					     unsigned long start,
+					     unsigned long end,
+					     unsigned long new_flags,
+					     struct anon_vma_name *new_name);
+struct vm_area_struct *vma_modify_policy(struct vma_iterator *vmi,
+					 struct vm_area_struct *prev,
+					 struct vm_area_struct *vma,
+					 unsigned long start, unsigned long end,
+					 struct mempolicy *new_pol);
+struct vm_area_struct *vma_modify_uffd(struct vma_iterator *vmi,
+				       struct vm_area_struct *prev,
+				       struct vm_area_struct *vma,
+				       unsigned long start, unsigned long end,
+				       unsigned long new_flags,
+				       struct vm_userfaultfd_ctx new_ctx);
 
 static inline int check_data_rlimit(unsigned long rlim,
 				    unsigned long new,
diff --git a/mm/madvise.c b/mm/madvise.c
index a4a20de50494..73024693d5c8 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -141,7 +141,7 @@ static int madvise_update_vma(struct vm_area_struct *vma,
 {
 	struct mm_struct *mm = vma->vm_mm;
 	int error;
-	pgoff_t pgoff;
+	struct vm_area_struct *merged;
 	VMA_ITERATOR(vmi, mm, start);
 
 	if (new_flags == vma->vm_flags && anon_vma_name_eq(anon_vma_name(vma), anon_name)) {
@@ -149,28 +149,17 @@ static int madvise_update_vma(struct vm_area_struct *vma,
 		return 0;
 	}
 
-	pgoff = vma->vm_pgoff + ((start - vma->vm_start) >> PAGE_SHIFT);
-	*prev = vma_merge(&vmi, mm, *prev, start, end, new_flags,
-			  vma->anon_vma, vma->vm_file, pgoff, vma_policy(vma),
-			  vma->vm_userfaultfd_ctx, anon_name);
-	if (*prev) {
-		vma = *prev;
+	merged = vma_modify_flags_name(&vmi, *prev, vma, start, end, new_flags,
+				       anon_name);
+	if (merged) {
+		vma = *prev = merged;
 		goto success;
 	}
 
 	*prev = vma;
 
-	if (start != vma->vm_start) {
-		error = split_vma(&vmi, vma, start, 1);
-		if (error)
-			return error;
-	}
-
-	if (end != vma->vm_end) {
-		error = split_vma(&vmi, vma, end, 0);
-		if (error)
-			return error;
-	}
+	if (IS_ERR(merged))
+		return PTR_ERR(merged);
 
 success:
 	/* vm_flags is protected by the mmap_lock held in write mode. */
diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index b01922e88548..b608b1744197 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -786,8 +786,6 @@ static int mbind_range(struct vma_iterator *vmi, struct vm_area_struct *vma,
 {
 	struct vm_area_struct *merged;
 	unsigned long vmstart, vmend;
-	pgoff_t pgoff;
-	int err;
 
 	vmend = min(end, vma->vm_end);
 	if (start > vma->vm_start) {
@@ -802,26 +800,14 @@ static int mbind_range(struct vma_iterator *vmi, struct vm_area_struct *vma,
 		return 0;
 	}
 
-	pgoff = vma->vm_pgoff + ((vmstart - vma->vm_start) >> PAGE_SHIFT);
-	merged = vma_merge(vmi, vma->vm_mm, *prev, vmstart, vmend, vma->vm_flags,
-			 vma->anon_vma, vma->vm_file, pgoff, new_pol,
-			 vma->vm_userfaultfd_ctx, anon_vma_name(vma));
+	merged =  vma_modify_policy(vmi, *prev, vma, vmstart, vmend, new_pol);
 	if (merged) {
 		*prev = merged;
 		return vma_replace_policy(merged, new_pol);
 	}
 
-	if (vma->vm_start != vmstart) {
-		err = split_vma(vmi, vma, vmstart, 1);
-		if (err)
-			return err;
-	}
-
-	if (vma->vm_end != vmend) {
-		err = split_vma(vmi, vma, vmend, 0);
-		if (err)
-			return err;
-	}
+	if (IS_ERR(merged))
+		return PTR_ERR(merged);
 
 	*prev = vma;
 	return vma_replace_policy(vma, new_pol);
diff --git a/mm/mlock.c b/mm/mlock.c
index 42b6865f8f82..50ebea3b7885 100644
--- a/mm/mlock.c
+++ b/mm/mlock.c
@@ -476,10 +476,10 @@ static int mlock_fixup(struct vma_iterator *vmi, struct vm_area_struct *vma,
 	       unsigned long end, vm_flags_t newflags)
 {
 	struct mm_struct *mm = vma->vm_mm;
-	pgoff_t pgoff;
 	int nr_pages;
 	int ret = 0;
 	vm_flags_t oldflags = vma->vm_flags;
+	struct vm_area_struct *merged;
 
 	if (newflags == oldflags || (oldflags & VM_SPECIAL) ||
 	    is_vm_hugetlb_page(vma) || vma == get_gate_vma(current->mm) ||
@@ -487,25 +487,15 @@ static int mlock_fixup(struct vma_iterator *vmi, struct vm_area_struct *vma,
 		/* don't set VM_LOCKED or VM_LOCKONFAULT and don't count */
 		goto out;
 
-	pgoff = vma->vm_pgoff + ((start - vma->vm_start) >> PAGE_SHIFT);
-	*prev = vma_merge(vmi, mm, *prev, start, end, newflags,
-			vma->anon_vma, vma->vm_file, pgoff, vma_policy(vma),
-			vma->vm_userfaultfd_ctx, anon_vma_name(vma));
-	if (*prev) {
-		vma = *prev;
+	merged = vma_modify_flags(vmi, *prev, vma, start, end, newflags);
+	if (merged) {
+		vma = *prev = merged;
 		goto success;
 	}
 
-	if (start != vma->vm_start) {
-		ret = split_vma(vmi, vma, start, 1);
-		if (ret)
-			goto out;
-	}
-
-	if (end != vma->vm_end) {
-		ret = split_vma(vmi, vma, end, 0);
-		if (ret)
-			goto out;
+	if (IS_ERR(merged)) {
+		ret = PTR_ERR(merged);
+		goto out;
 	}
 
 success:
diff --git a/mm/mmap.c b/mm/mmap.c
index 673429ee8a9e..8c21171b431f 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -2437,6 +2437,99 @@ int split_vma(struct vma_iterator *vmi, struct vm_area_struct *vma,
 	return __split_vma(vmi, vma, addr, new_below);
 }
 
+/*
+ * We are about to modify one or multiple of a VMA's flags, policy, userfaultfd
+ * context and anonymous VMA name within the range [start, end).
+ *
+ * As a result, we might be able to merge the newly modified VMA range with an
+ * adjacent VMA with identical properties.
+ *
+ * If no merge is possible and the range does not span the entirety of the VMA,
+ * we then need to split the VMA to accommodate the change.
+ */
+static struct vm_area_struct *vma_modify(struct vma_iterator *vmi,
+					 struct vm_area_struct *prev,
+					 struct vm_area_struct *vma,
+					 unsigned long start, unsigned long end,
+					 unsigned long vm_flags,
+					 struct mempolicy *policy,
+					 struct vm_userfaultfd_ctx uffd_ctx,
+					 struct anon_vma_name *anon_name)
+{
+	pgoff_t pgoff = vma->vm_pgoff + ((start - vma->vm_start) >> PAGE_SHIFT);
+	struct vm_area_struct *merged;
+
+	merged = vma_merge(vmi, vma->vm_mm, prev, start, end, vm_flags,
+			   vma->anon_vma, vma->vm_file, pgoff, policy,
+			   uffd_ctx, anon_name);
+	if (merged)
+		return merged;
+
+	if (vma->vm_start < start) {
+		int err = split_vma(vmi, vma, start, 1);
+
+		if (err)
+			return ERR_PTR(err);
+	}
+
+	if (vma->vm_end > end) {
+		int err = split_vma(vmi, vma, end, 0);
+
+		if (err)
+			return ERR_PTR(err);
+	}
+
+	return NULL;
+}
+
+/* We are about to modify the VMA's flags. */
+struct vm_area_struct *vma_modify_flags(struct vma_iterator *vmi,
+					struct vm_area_struct *prev,
+					struct vm_area_struct *vma,
+					unsigned long start, unsigned long end,
+					unsigned long new_flags)
+{
+	return vma_modify(vmi, prev, vma, start, end, new_flags,
+			  vma_policy(vma), vma->vm_userfaultfd_ctx,
+			  anon_vma_name(vma));
+}
+
+/* We are about to modify the VMA's flags and/or anon_name. */
+struct vm_area_struct *vma_modify_flags_name(struct vma_iterator *vmi,
+					     struct vm_area_struct *prev,
+					     struct vm_area_struct *vma,
+					     unsigned long start,
+					     unsigned long end,
+					     unsigned long new_flags,
+					     struct anon_vma_name *new_name)
+{
+	return vma_modify(vmi, prev, vma, start, end, new_flags,
+			  vma_policy(vma), vma->vm_userfaultfd_ctx, new_name);
+}
+
+/* We are about to modify the VMA's flags memory policy. */
+struct vm_area_struct *vma_modify_policy(struct vma_iterator *vmi,
+					 struct vm_area_struct *prev,
+					 struct vm_area_struct *vma,
+					 unsigned long start, unsigned long end,
+					 struct mempolicy *new_pol)
+{
+	return vma_modify(vmi, prev, vma, start, end, vma->vm_flags,
+			  new_pol, vma->vm_userfaultfd_ctx, anon_vma_name(vma));
+}
+
+/* We are about to modify the VMA's uffd context and/or flags. */
+struct vm_area_struct *vma_modify_uffd(struct vma_iterator *vmi,
+				       struct vm_area_struct *prev,
+				       struct vm_area_struct *vma,
+				       unsigned long start, unsigned long end,
+				       unsigned long new_flags,
+				       struct vm_userfaultfd_ctx new_ctx)
+{
+	return vma_modify(vmi, prev, vma, start, end, new_flags,
+			  vma_policy(vma), new_ctx, anon_vma_name(vma));
+}
+
 /*
  * do_vmi_align_munmap() - munmap the aligned region from @start to @end.
  * @vmi: The vma iterator
diff --git a/mm/mprotect.c b/mm/mprotect.c
index b94fbb45d5c7..fdc94453bced 100644
--- a/mm/mprotect.c
+++ b/mm/mprotect.c
@@ -581,7 +581,7 @@ mprotect_fixup(struct vma_iterator *vmi, struct mmu_gather *tlb,
 	long nrpages = (end - start) >> PAGE_SHIFT;
 	unsigned int mm_cp_flags = 0;
 	unsigned long charged = 0;
-	pgoff_t pgoff;
+	struct vm_area_struct *merged;
 	int error;
 
 	if (newflags == oldflags) {
@@ -625,31 +625,18 @@ mprotect_fixup(struct vma_iterator *vmi, struct mmu_gather *tlb,
 		}
 	}
 
-	/*
-	 * First try to merge with previous and/or next vma.
-	 */
-	pgoff = vma->vm_pgoff + ((start - vma->vm_start) >> PAGE_SHIFT);
-	*pprev = vma_merge(vmi, mm, *pprev, start, end, newflags,
-			   vma->anon_vma, vma->vm_file, pgoff, vma_policy(vma),
-			   vma->vm_userfaultfd_ctx, anon_vma_name(vma));
-	if (*pprev) {
-		vma = *pprev;
+	merged = vma_modify_flags(vmi, *pprev, vma, start, end, newflags);
+	if (merged) {
+		vma = *pprev = merged;
 		VM_WARN_ON((vma->vm_flags ^ newflags) & ~VM_SOFTDIRTY);
 		goto success;
 	}
 
 	*pprev = vma;
 
-	if (start != vma->vm_start) {
-		error = split_vma(vmi, vma, start, 1);
-		if (error)
-			goto fail;
-	}
-
-	if (end != vma->vm_end) {
-		error = split_vma(vmi, vma, end, 0);
-		if (error)
-			goto fail;
+	if (IS_ERR(merged)) {
+		error = PTR_ERR(merged);
+		goto fail;
 	}
 
 success:
-- 
2.42.0

