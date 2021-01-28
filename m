Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE4FA308174
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Jan 2021 23:52:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231649AbhA1Wv4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 Jan 2021 17:51:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231464AbhA1Wun (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 Jan 2021 17:50:43 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55F1AC06178A
        for <linux-fsdevel@vger.kernel.org>; Thu, 28 Jan 2021 14:48:32 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id g4so7810584ybf.16
        for <linux-fsdevel@vger.kernel.org>; Thu, 28 Jan 2021 14:48:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=OciUxHGE8yPtNB1tP0JCFV9IjbQOZ16vEY+TJUcu0OU=;
        b=UjjKqRO5AOxn7VghbHUw7xvhRzuZWkeaAaVM7UsiVsZqqPPnVwNcjCankgnlRZhI2O
         PKHvFIYLdSWZ8DSeM5UKoTqDrxdc+9VL7KKtMtUlz4I7ql6WNJ+2cWIDBPoqd00aJIHv
         avryAgtCu84JvL4Vjvm2+EZiMKH0mBwzPYfyX361RqY9Xp/M/Vfbm9yH4nmc+zWgG9va
         Asy9CEXI/FQgKsvMW9lvHROA3BpwHhMLh4mhCKm3QKnEv4/Rs2DLAiSL/MZGC+/h7jmD
         nULMCwbHXvLa1OQE2xAMwR02xcdib9WnZ2x6HBTHU/UDRO5mwi2kYTt9441WjmAm5blH
         IzGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=OciUxHGE8yPtNB1tP0JCFV9IjbQOZ16vEY+TJUcu0OU=;
        b=AVU1kIHeIUqzgF6j6hhNGVQkKZpyvws/Wt3AcIy60oMEJ7k3Ko+rSruNtE25jaxqBF
         9tNaFFj7xMkstJ9nCj6W1rgpCC1tlBHHukBgFua4lw4fwz0NyxaGOmY54RO6bfb8jp2d
         GjuHzybL9Wxj4x6ywYntRfDMFurg59qckteYnya0dU9JUEDA1DeOzMUJWKjntGbJSiGD
         xq7h2GFldxwJVtlMmysA1Nqw5uXV2Ztpo9YbA3mNrtQurSoJ929RpeXE3y3XVnWqMXPT
         OXxvPD3RMP3gbciS0DhGyDAyU1pgbDwq0BungvsLgqGpNkUMS0YpRlxHT5VhXGEASp6Z
         GSSQ==
X-Gm-Message-State: AOAM5314fP20RY/uKBH7qaE+eS7UKyZxvUJSHzoP3nleQRGaH65Xh3RU
        2S1Bf2cd8HuG0M2I5oS8KHDEsVKlwF2lgSVPeZzp
X-Google-Smtp-Source: ABdhPJw86pxf23g4Od2JKgL7AdfU/8fImCexkNA+9/GE9YYbkMW17SXES6xjCQ91GFP1lbryJ3LOBh8Tv4Ihn9H2FAtX
Sender: "axelrasmussen via sendgmr" <axelrasmussen@ajr0.svl.corp.google.com>
X-Received: from ajr0.svl.corp.google.com ([2620:15c:2cd:203:f693:9fff:feef:c8f8])
 (user=axelrasmussen job=sendgmr) by 2002:a25:3812:: with SMTP id
 f18mr2151012yba.207.1611874111477; Thu, 28 Jan 2021 14:48:31 -0800 (PST)
Date:   Thu, 28 Jan 2021 14:48:13 -0800
In-Reply-To: <20210128224819.2651899-1-axelrasmussen@google.com>
Message-Id: <20210128224819.2651899-4-axelrasmussen@google.com>
Mime-Version: 1.0
References: <20210128224819.2651899-1-axelrasmussen@google.com>
X-Mailer: git-send-email 2.30.0.365.g02bc693789-goog
Subject: [PATCH v3 3/9] mm/hugetlb: Move flush_hugetlb_tlb_range() into hugetlb.h
From:   Axel Rasmussen <axelrasmussen@google.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Chinwen Chang <chinwen.chang@mediatek.com>,
        Huang Ying <ying.huang@intel.com>,
        Ingo Molnar <mingo@redhat.com>, Jann Horn <jannh@google.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Lokesh Gidra <lokeshgidra@google.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "=?UTF-8?q?Michal=20Koutn=C3=BD?=" <mkoutny@suse.com>,
        Michel Lespinasse <walken@google.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Peter Xu <peterx@redhat.com>, Shaohua Li <shli@fb.com>,
        Shawn Anastasio <shawn@anastas.io>,
        Steven Rostedt <rostedt@goodmis.org>,
        Steven Price <steven.price@arm.com>,
        Vlastimil Babka <vbabka@suse.cz>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, Adam Ruprecht <ruprecht@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Cannon Matthews <cannonmatthews@google.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Oliver Upton <oupton@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Peter Xu <peterx@redhat.com>

Prepare for it to be called outside of mm/hugetlb.c.

Signed-off-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>
---
 include/linux/hugetlb.h | 8 ++++++++
 mm/hugetlb.c            | 8 --------
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index 4508136c8376..f94a35296618 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -962,4 +962,12 @@ static inline bool want_pmd_share(struct vm_area_struct *vma)
 #endif
 }
 
+#ifndef __HAVE_ARCH_FLUSH_HUGETLB_TLB_RANGE
+/*
+ * ARCHes with special requirements for evicting HUGETLB backing TLB entries can
+ * implement this.
+ */
+#define flush_hugetlb_tlb_range(vma, addr, end)	flush_tlb_range(vma, addr, end)
+#endif
+
 #endif /* _LINUX_HUGETLB_H */
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index d46f50a99ff1..30a087dda57d 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -4924,14 +4924,6 @@ long follow_hugetlb_page(struct mm_struct *mm, struct vm_area_struct *vma,
 	return i ? i : err;
 }
 
-#ifndef __HAVE_ARCH_FLUSH_HUGETLB_TLB_RANGE
-/*
- * ARCHes with special requirements for evicting HUGETLB backing TLB entries can
- * implement this.
- */
-#define flush_hugetlb_tlb_range(vma, addr, end)	flush_tlb_range(vma, addr, end)
-#endif
-
 unsigned long hugetlb_change_protection(struct vm_area_struct *vma,
 		unsigned long address, unsigned long end, pgprot_t newprot)
 {
-- 
2.30.0.365.g02bc693789-goog

