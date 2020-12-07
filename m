Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06F9E2D0F34
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Dec 2020 12:35:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727135AbgLGLe7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 7 Dec 2020 06:34:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727094AbgLGLe4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 Dec 2020 06:34:56 -0500
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85852C0613D0;
        Mon,  7 Dec 2020 03:34:16 -0800 (PST)
Received: by mail-pf1-x443.google.com with SMTP id 11so3391456pfu.4;
        Mon, 07 Dec 2020 03:34:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oiWdzjaw1OmADmhfyVOwsM+WBviDc5Qv5LoJ9srjCn8=;
        b=GojkmbMdLZzqltnpM8dqoYBuO8JaFV8vAaCoFvmgCZQqrwLo0y16hu1kT/YygK2K44
         QgsvracpXFSOoq10bZ7qguwwQu1ru9XSbbiMvPp7eesw75iZj6ZVQsKNtR0IjjS26QMH
         cFd6l1CrJHxoPJQJu6/K0t0PkR9kVQ4MSXDRj7v5lcuc0TVQB2XR1UsK6wwur1N5vxSU
         AwwTCEI7iBkKTY/Nxu9R233DLfjsq3wT7bb41Rt1La/5OFAq97XS6aCduvxnutsk9ctX
         w+0uFdcrlcAyAqvQc0wAp/QKxdlcnw+cQ5Vx+NJlV1uHfISi3iC7tddWQEiSnJWzi119
         ZeCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oiWdzjaw1OmADmhfyVOwsM+WBviDc5Qv5LoJ9srjCn8=;
        b=AyG4r3He7t8088duijeyQzhRKz0Hb+CUjMR2YFBkMOqujld3guXDn/flD4qjb3tg4g
         oGxxJpobdaXjtC22SshdZyAs7siZPLUbRVGziWU33RlcLVYnrnXGvB1aJe73fn63tboN
         p2620a4OvfbhM2ud3W6lsEALq8S+HZM9krVxTjE+G8M1CrhdUt8BOz4bZ+HXwaPD/u6d
         fOdusf2+DwYXuAuTeixzre+BXw7roU2hRloI1wm7mo5fMde88YnKPAvhlL8tyCx6LlXy
         jSsQpgDUEINbEiNyG2jbnfB8y6aYqnIXTFcRUG3A049zBqLySNP4z+fz6VTnb2gOEYSP
         /r+g==
X-Gm-Message-State: AOAM533cCeqMe7tFwjRNZ0wRmRTo/tIn6gURBSqH8+hoMSXpe0iaf/0W
        n8qkQqJrZA07vTy/KQszyZ0=
X-Google-Smtp-Source: ABdhPJxqMp4yjvhA/Bg9lRA+V9tn9lbXheFRUjSeNQl1fvqRvMg3Qy9PvhPeukmBJN6/2hsxmmnCGQ==
X-Received: by 2002:a63:ce0c:: with SMTP id y12mr18084599pgf.208.1607340856109;
        Mon, 07 Dec 2020 03:34:16 -0800 (PST)
Received: from localhost.localdomain ([203.205.141.39])
        by smtp.gmail.com with ESMTPSA id d4sm14219822pfo.127.2020.12.07.03.34.13
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 Dec 2020 03:34:15 -0800 (PST)
From:   yulei.kernel@gmail.com
X-Google-Original-From: yuleixzhang@tencent.com
To:     linux-mm@kvack.org, akpm@linux-foundation.org,
        linux-fsdevel@vger.kernel.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, naoya.horiguchi@nec.com,
        viro@zeniv.linux.org.uk, pbonzini@redhat.com
Cc:     joao.m.martins@oracle.com, rdunlap@infradead.org,
        sean.j.christopherson@intel.com, xiaoguangrong.eric@gmail.com,
        kernellwp@gmail.com, lihaiwei.kernel@gmail.com,
        Yulei Zhang <yuleixzhang@tencent.com>
Subject: [RFC V2 11/37] mm: export mempolicy interfaces to serve dmem allocator
Date:   Mon,  7 Dec 2020 19:31:04 +0800
Message-Id: <f3a54a74d35057cbdc451eb559dd94d5413f3947.1607332046.git.yuleixzhang@tencent.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <cover.1607332046.git.yuleixzhang@tencent.com>
References: <cover.1607332046.git.yuleixzhang@tencent.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Yulei Zhang <yuleixzhang@tencent.com>

Export interface interleave_nid() to serve dmem allocator.

Signed-off-by: Yulei Zhang <yuleixzhang@tencent.com>
---
 include/linux/mempolicy.h | 3 +++
 mm/mempolicy.c            | 4 ++--
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/include/linux/mempolicy.h b/include/linux/mempolicy.h
index 5f1c74d..4789661 100644
--- a/include/linux/mempolicy.h
+++ b/include/linux/mempolicy.h
@@ -139,6 +139,9 @@ struct mempolicy *mpol_shared_policy_lookup(struct shared_policy *sp,
 struct mempolicy *get_task_policy(struct task_struct *p);
 struct mempolicy *__get_vma_policy(struct vm_area_struct *vma,
 		unsigned long addr);
+struct mempolicy *get_vma_policy(struct vm_area_struct *vma, unsigned long addr);
+unsigned interleave_nid(struct mempolicy *pol, struct vm_area_struct *vma,
+			unsigned long addr, int shift);
 bool vma_policy_mof(struct vm_area_struct *vma);
 
 extern void numa_default_policy(void);
diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 3ca4898..efd80e5 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -1813,7 +1813,7 @@ struct mempolicy *__get_vma_policy(struct vm_area_struct *vma,
  * freeing by another task.  It is the caller's responsibility to free the
  * extra reference for shared policies.
  */
-static struct mempolicy *get_vma_policy(struct vm_area_struct *vma,
+struct mempolicy *get_vma_policy(struct vm_area_struct *vma,
 						unsigned long addr)
 {
 	struct mempolicy *pol = __get_vma_policy(vma, addr);
@@ -1978,7 +1978,7 @@ static unsigned offset_il_node(struct mempolicy *pol, unsigned long n)
 }
 
 /* Determine a node number for interleave */
-static inline unsigned interleave_nid(struct mempolicy *pol,
+unsigned interleave_nid(struct mempolicy *pol,
 		 struct vm_area_struct *vma, unsigned long addr, int shift)
 {
 	if (vma) {
-- 
1.8.3.1

