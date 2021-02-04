Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B391430FBAA
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Feb 2021 19:39:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238713AbhBDShn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 4 Feb 2021 13:37:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237649AbhBDSgI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 4 Feb 2021 13:36:08 -0500
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26B90C06121E
        for <linux-fsdevel@vger.kernel.org>; Thu,  4 Feb 2021 10:34:56 -0800 (PST)
Received: by mail-qt1-x84a.google.com with SMTP id f7so3294063qtd.9
        for <linux-fsdevel@vger.kernel.org>; Thu, 04 Feb 2021 10:34:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=dnNo0P9pQk4mCWpPk9SkHpqnJh6eIBtgx02Oeb/UXjo=;
        b=Al/UauZV1DDE1GQ/B3cVQR4rotIVxh2DLihJOd/5CWM7XthzAeW499I1SxHk1BPVLl
         dEowBo6pNqZumu/JZm1jSFVw8i1MjyIgVLbAi90z4s0xRZzHVnnToEs7fW+HS9kf00lk
         4oAQmnRtfTxMbdZjOrBsGE/MZfMsT25k5kWdEbxtyY9wMtiqQtxHtx5uhlPsRx/VHdLG
         sJ/ahIQhrG/y3oGYrRQvsUscM6Yru+JLmb67PlIw4/1jSXn+PrZ7i7EzVDQgg/tdricm
         UC9q2irp8osM7qLusXPZ7c9F8DyZjphS272uL5NoPER97hCV15fQvLGUwQktxrXH2CMl
         J3+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=dnNo0P9pQk4mCWpPk9SkHpqnJh6eIBtgx02Oeb/UXjo=;
        b=t8Qb+/rLR+VReCMmK4xzOpS6Q3uwUYe7OJgTjd6mYvp14f0muorawu7zsswNYzYtop
         4/ShZxLaZj1Qv+fLklLu8V6OC3Q/4nVIy7qpk1L8BASka96+sJP8xfaXOR7WFoJt9z2J
         +suqOIoSXwdxm4Op33ZduTrsIV9hoadaPPgjn4Y2+LXZW87dMTLVpyJakw7J50XI9eWQ
         bXR7KyV4UyfP5wTI4pLjhveQRjkaZGBIKFH0+7oDVMyzRjW2VCoQGP2TDtwBd4iNHqg0
         jBZzHo3O8ih9zMScQGw/18LaoO3HwA6oOW3FHZQ8yvIHa8AxNuykAJTZdfFLY9d76jw+
         GOBw==
X-Gm-Message-State: AOAM530GSJYySsIZf3/pxUvkdFCyrnMMBIgv95MoBYWY35uLShIRR3dF
        2wcdiCtICG31F5z17L7xoGTWxH8BiCt8A0w6dbj9
X-Google-Smtp-Source: ABdhPJwzY/m5iDRQzjnkOcfC3idOuJxllyLq6tjUscyKEYj5/eihbt8Wssn5DtrwP7t8RsmeAVnnF7FClkXApTydM2XJ
Sender: "axelrasmussen via sendgmr" <axelrasmussen@ajr0.svl.corp.google.com>
X-Received: from ajr0.svl.corp.google.com ([2620:15c:2cd:203:b001:12c1:dc19:2089])
 (user=axelrasmussen job=sendgmr) by 2002:a0c:e652:: with SMTP id
 c18mr505898qvn.59.1612463695305; Thu, 04 Feb 2021 10:34:55 -0800 (PST)
Date:   Thu,  4 Feb 2021 10:34:29 -0800
In-Reply-To: <20210204183433.1431202-1-axelrasmussen@google.com>
Message-Id: <20210204183433.1431202-7-axelrasmussen@google.com>
Mime-Version: 1.0
References: <20210204183433.1431202-1-axelrasmussen@google.com>
X-Mailer: git-send-email 2.30.0.365.g02bc693789-goog
Subject: [PATCH v4 06/10] userfaultfd: disable huge PMD sharing for MINOR
 registered VMAs
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
        Mina Almasry <almasrymina@google.com>,
        Oliver Upton <oupton@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

As the comment says: for the MINOR fault use case, although the page
might be present and populated in the other (non-UFFD-registered) half
of the mapping, it may be out of date, and we explicitly want userspace
to get a minor fault so it can check and potentially update the page's
contents.

Huge PMD sharing would prevent these faults from occurring for
suitably aligned areas, so disable it upon UFFD registration.

Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>
---
 include/linux/userfaultfd_k.h | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/include/linux/userfaultfd_k.h b/include/linux/userfaultfd_k.h
index 0390e5ac63b3..e060d5f77cc5 100644
--- a/include/linux/userfaultfd_k.h
+++ b/include/linux/userfaultfd_k.h
@@ -56,12 +56,19 @@ static inline bool is_mergeable_vm_userfaultfd_ctx(struct vm_area_struct *vma,
 }
 
 /*
- * Never enable huge pmd sharing on uffd-wp registered vmas, because uffd-wp
- * protect information is per pgtable entry.
+ * Never enable huge pmd sharing on some uffd registered vmas:
+ *
+ * - VM_UFFD_WP VMAs, because write protect information is per pgtable entry.
+ *
+ * - VM_UFFD_MINOR VMAs, because otherwise we would never get minor faults for
+ *   VMAs which share huge pmds. (If you have two mappings to the same
+ *   underlying pages, and fault in the non-UFFD-registered one with a write,
+ *   with huge pmd sharing this would *also* setup the second UFFD-registered
+ *   mapping, and we'd not get minor faults.)
  */
 static inline bool uffd_disable_huge_pmd_share(struct vm_area_struct *vma)
 {
-	return vma->vm_flags & VM_UFFD_WP;
+	return vma->vm_flags & (VM_UFFD_WP | VM_UFFD_MINOR);
 }
 
 static inline bool userfaultfd_missing(struct vm_area_struct *vma)
-- 
2.30.0.365.g02bc693789-goog

