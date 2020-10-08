Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94D0428702F
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Oct 2020 09:57:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729084AbgJHHzp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 8 Oct 2020 03:55:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729040AbgJHHzm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 8 Oct 2020 03:55:42 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5382C0613D7;
        Thu,  8 Oct 2020 00:55:27 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id g10so3317316pfc.8;
        Thu, 08 Oct 2020 00:55:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=rgl0RB6gKY0poqmey3m0fH+Fzjy9yKEsxNNtoKcaNdI=;
        b=fngZ4V7uI0g9A6oGR8TT184yksleNQiusVTwWIjxfwwoKMU1wm78uDgw4GhFCinpLT
         +5h7GvXwXYZ/tSqURQ2Tq28OTn9cZdYpbuc9i/+5QfFNfKDql8jLuOJvp3pZMqzzSpoq
         JkVRBPdFlpg9p5p4nO8u2r6ghJvAjYSFs0VzTnFqWT3Qklsxq3dHrx1QJOD/FqOKir/8
         c390Pqs5yl9bpYxI3jAZA1NmbAB5FRlB6FYY0jt/dbirBkws2o2k9Jnx+xEXda7bDKi5
         lxSdolQfWzRLtbR+EYOMZUQ3G0mV1QvhE3zsSPnWXDu70Oqzf2AfwS6qh6JW6y4MgiHh
         W2fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=rgl0RB6gKY0poqmey3m0fH+Fzjy9yKEsxNNtoKcaNdI=;
        b=IZpNoWgh+u7LvNhjZjxuf9BNmBooDMYkoC5hxF4crnpKMHjQZdcUfKtw0vbuNnLYM1
         HBCX9kuxR1kNk7Jd2/OEctRfbM1dBglZuzsHKH790wwaGNgFfEzJqjlV9/YX4Ig20r8V
         oK+R+YtKlkT5FEsrC/MHx+L6Gm0Fab1mZt3zKU74LtgAC1YWrGOQ7iaMTmGtu+xleRQL
         ZmpPA4eDDdhHz646ExoxhfXRcv96cg6+E5gZxbe2VMUGWvL99VrIBv3Z59nz0Odhvau7
         jkhF+Grr3qi8M7bfrsokIjElr68tjVir6KwkUr6MEq/N+8X4JKNTqVZBtFmGJXK5PCO3
         doqw==
X-Gm-Message-State: AOAM533RlCSC6Rly6NeFLM7/tuWUJu2AR8JkUrzwhrmO5dSyIN3xzbDt
        pba/q7PNGOo4dAwbwc/xHR602ix3zQ+NXA==
X-Google-Smtp-Source: ABdhPJw6ynUy5YDxI8vIljMLF5r1pNoOsWb1QWSg0/UqQKFCKO4W8P/RsEsn26/IjH6bTFmivX+QQA==
X-Received: by 2002:a17:90b:f8b:: with SMTP id ft11mr6844289pjb.8.1602143727295;
        Thu, 08 Oct 2020 00:55:27 -0700 (PDT)
Received: from localhost.localdomain ([203.205.141.61])
        by smtp.gmail.com with ESMTPSA id k206sm6777106pfd.126.2020.10.08.00.55.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2020 00:55:26 -0700 (PDT)
From:   yulei.kernel@gmail.com
X-Google-Original-From: yuleixzhang@tencent.com
To:     akpm@linux-foundation.org, naoya.horiguchi@nec.com,
        viro@zeniv.linux.org.uk, pbonzini@redhat.com
Cc:     linux-fsdevel@vger.kernel.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, xiaoguangrong.eric@gmail.com,
        kernellwp@gmail.com, lihaiwei.kernel@gmail.com,
        Yulei Zhang <yuleixzhang@tencent.com>,
        Chen Zhuo <sagazchen@tencent.com>
Subject: [PATCH 23/35] kvm, x86: introduce VM_DMEM
Date:   Thu,  8 Oct 2020 15:54:13 +0800
Message-Id: <3c8fc6f37abe66c13348c9af2eacee04d4dfaa72.1602093760.git.yuleixzhang@tencent.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1602093760.git.yuleixzhang@tencent.com>
References: <cover.1602093760.git.yuleixzhang@tencent.com>
In-Reply-To: <cover.1602093760.git.yuleixzhang@tencent.com>
References: <cover.1602093760.git.yuleixzhang@tencent.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Yulei Zhang <yuleixzhang@tencent.com>

Currently dmemfs do not support memory readonly, so change_protection()
will be disabled for dmemfs vma. Since vma->vm_flags could be changed to
new flag in mprotect_fixup(), so we introduce a new vma flag VM_DMEM and
check this flag in mprotect_fixup() to avoid changing vma->vm_flags.

We also check it in vma_to_resize() to disable mremap() for dmemfs vma.

Signed-off-by: Chen Zhuo <sagazchen@tencent.com>
Signed-off-by: Yulei Zhang <yuleixzhang@tencent.com>
---
 fs/dmemfs/inode.c  | 2 +-
 include/linux/mm.h | 7 +++++++
 mm/mprotect.c      | 5 ++++-
 mm/mremap.c        | 3 +++
 4 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/fs/dmemfs/inode.c b/fs/dmemfs/inode.c
index e37498c00497..b3e394f33b42 100644
--- a/fs/dmemfs/inode.c
+++ b/fs/dmemfs/inode.c
@@ -510,7 +510,7 @@ int dmemfs_file_mmap(struct file *file, struct vm_area_struct *vma)
 	if (!(vma->vm_flags & VM_SHARED))
 		return -EINVAL;
 
-	vma->vm_flags |= VM_PFNMAP;
+	vma->vm_flags |= VM_PFNMAP | VM_DMEM | VM_IO;
 
 	file_accessed(file);
 	vma->vm_ops = &dmemfs_vm_ops;
diff --git a/include/linux/mm.h b/include/linux/mm.h
index ca6e6a81576b..7b1e574d2387 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -309,6 +309,8 @@ extern unsigned int kobjsize(const void *objp);
 #define VM_HIGH_ARCH_4	BIT(VM_HIGH_ARCH_BIT_4)
 #endif /* CONFIG_ARCH_USES_HIGH_VMA_FLAGS */
 
+#define VM_DMEM		BIT(38)		/* Dmem page VM */
+
 #ifdef CONFIG_ARCH_HAS_PKEYS
 # define VM_PKEY_SHIFT	VM_HIGH_ARCH_BIT_0
 # define VM_PKEY_BIT0	VM_HIGH_ARCH_0	/* A protection key is a 4-bit value */
@@ -656,6 +658,11 @@ static inline bool vma_is_accessible(struct vm_area_struct *vma)
 	return vma->vm_flags & VM_ACCESS_FLAGS;
 }
 
+static inline bool vma_is_dmem(struct vm_area_struct *vma)
+{
+	return !!(vma->vm_flags & VM_DMEM);
+}
+
 #ifdef CONFIG_SHMEM
 /*
  * The vma_is_shmem is not inline because it is used only by slow
diff --git a/mm/mprotect.c b/mm/mprotect.c
index ce8b8a5eacbb..36f885cbbb30 100644
--- a/mm/mprotect.c
+++ b/mm/mprotect.c
@@ -236,7 +236,7 @@ static inline unsigned long change_pmd_range(struct vm_area_struct *vma,
 		 * for all the checks.
 		 */
 		if (!is_swap_pmd(*pmd) && !pmd_devmap(*pmd) &&
-		     pmd_none_or_clear_bad_unless_trans_huge(pmd))
+		     pmd_none_or_clear_bad_unless_trans_huge(pmd) && !pmd_special(*pmd))
 			goto next;
 
 		/* invoke the mmu notifier if the pmd is populated */
@@ -412,6 +412,9 @@ mprotect_fixup(struct vm_area_struct *vma, struct vm_area_struct **pprev,
 		return 0;
 	}
 
+	if (vma_is_dmem(vma))
+		return -EINVAL;
+
 	/*
 	 * Do PROT_NONE PFN permission checks here when we can still
 	 * bail out without undoing a lot of state. This is a rather
diff --git a/mm/mremap.c b/mm/mremap.c
index 138abbae4f75..598e68174e24 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -482,6 +482,9 @@ static struct vm_area_struct *vma_to_resize(unsigned long addr,
 	if (!vma || vma->vm_start > addr)
 		return ERR_PTR(-EFAULT);
 
+	if (vma_is_dmem(vma))
+		return ERR_PTR(-EINVAL);
+
 	/*
 	 * !old_len is a special case where an attempt is made to 'duplicate'
 	 * a mapping.  This makes no sense for private mappings as it will
-- 
2.28.0

