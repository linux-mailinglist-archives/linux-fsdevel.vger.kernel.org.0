Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BC9C2F8516
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Jan 2021 20:08:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388179AbhAOTG7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 Jan 2021 14:06:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733221AbhAOTGa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 Jan 2021 14:06:30 -0500
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68960C06179E
        for <linux-fsdevel@vger.kernel.org>; Fri, 15 Jan 2021 11:05:19 -0800 (PST)
Received: by mail-pf1-x44a.google.com with SMTP id 193so6569045pfz.9
        for <linux-fsdevel@vger.kernel.org>; Fri, 15 Jan 2021 11:05:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=OiHmip5pShZEM0ZBAU71H+KEdKKSM8se2w8Pb4UEVUI=;
        b=TUlkIxxVvg+NbLyEdgqkaAFxnAFs01VNlKWsfh3GhNA8NsXjhKrFaUkXvV4Zr9JlPu
         z+UEL/4/8qbJIkIOvrHuW8ajVDx5H7EsPfrkYlJqFzph7GP8yf1Ex9J37PQBXLPFXPtu
         vEP4CaUe76NUa5oIaelgWSDdl6FVyXtg4S9mzJ4q3uramJL+1v3c5G7VKfkLPurURi+4
         MkIWx6zxZFDMqyIMy1Irl7i5Y6DP3eoZWqtJGvTB0p5cT/Ogg4f1uxSoP/Idw+iDZl0f
         UMDYOs1wOSsY9M/hMYlGZckdMEndJ22m2r/zFVpMH76XXN64MIlxgy1gnV9eSZHz8bKB
         vtxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=OiHmip5pShZEM0ZBAU71H+KEdKKSM8se2w8Pb4UEVUI=;
        b=kVkOMCzmykPYYuksrSqZOwKcTKy9kk6bpunq7glAp61Hn+TM+voGD0gSLg6aezoTIp
         +w3k1DzaMpg/xfsNDmWafBchmxSVSwdQLxS8ZG6o9jfwdEtOeEc7nHRYl/sodRqPkg6e
         /x/WsDWHX0ejlK1t3K6y42A3o8BnivdXUjLwU/d9xKfSKFgXKEZqq1dAOsSNpZRNoMvU
         Rdsusmj9X3Rmf9W/XorOSyEgFG5b6HpZEMMqOYjy2k87dMUbRYMGR8XyRK+Nc5tpd+hk
         +63L4zRPIFvyu8VkewOWUo+vqpYM8dcb11GDXl0ll1TkYG4+OgVX6JquZ4wbrL/YEgVc
         d9KA==
X-Gm-Message-State: AOAM530SonOWX3IWCwbGVTJKJc6qBiuB12Wtz01HW+V5RTRK4Ohsb10K
        WbyytDYvzRxe365WhbWaBn0nkw85GgLksyJyutZB
X-Google-Smtp-Source: ABdhPJx5ZFf+WD9DcKtl3XLJSR7XOnyXjgx1WlJfvxIQaqqkk6YFhDMOONtuyBr3KQM4NxvYJ8VqPx/7/n9aj6k0d8Qo
Sender: "axelrasmussen via sendgmr" <axelrasmussen@ajr0.svl.corp.google.com>
X-Received: from ajr0.svl.corp.google.com ([2620:15c:2cd:203:f693:9fff:feef:c8f8])
 (user=axelrasmussen job=sendgmr) by 2002:a17:902:12c:b029:da:e63c:dc92 with
 SMTP id 41-20020a170902012cb02900dae63cdc92mr14044589plb.71.1610737518850;
 Fri, 15 Jan 2021 11:05:18 -0800 (PST)
Date:   Fri, 15 Jan 2021 11:04:48 -0800
In-Reply-To: <20210115190451.3135416-1-axelrasmussen@google.com>
Message-Id: <20210115190451.3135416-7-axelrasmussen@google.com>
Mime-Version: 1.0
References: <20210115190451.3135416-1-axelrasmussen@google.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7-goog
Subject: [PATCH 6/9] userfaultfd: disable huge PMD sharing for MINOR
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
        Oliver Upton <oupton@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

As the comment says: for the MINOR fault use case, although the page
might be present and populated in the other (non-UFFD-registered) half
of the shared mapping, it may be out of date, and we explicitly want
userspace to get a minor fault so it can check and potentially update
the page's contents.

Huge PMD sharing would prevent these faults from occurring for
suitably aligned areas, so disable it upon UFFD registration.

Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>
---
 include/linux/userfaultfd_k.h | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/include/linux/userfaultfd_k.h b/include/linux/userfaultfd_k.h
index 7aa1461e1a8b..ed157804ca02 100644
--- a/include/linux/userfaultfd_k.h
+++ b/include/linux/userfaultfd_k.h
@@ -53,12 +53,18 @@ static inline bool is_mergeable_vm_userfaultfd_ctx(struct vm_area_struct *vma,
 }
 
 /*
- * Never enable huge pmd sharing on uffd-wp registered vmas, because uffd-wp
- * protect information is per pgtable entry.
+ * Never enable huge pmd sharing on some uffd registered vmas:
+ *
+ * - VM_UFFD_WP VMAs, because write protect information is per pgtable entry.
+ *
+ * - VM_UFFD_MINOR VMAs, because we explicitly want minor faults to occur even
+ *   when the other half of a shared mapping is populated (even though the page
+ *   is there, in our use case it may be out of date, so userspace needs to
+ *   check for this and possibly update it).
  */
 static inline bool uffd_disable_huge_pmd_share(struct vm_area_struct *vma)
 {
-	return vma->vm_flags & VM_UFFD_WP;
+	return vma->vm_flags & (VM_UFFD_WP | VM_UFFD_MINOR);
 }
 
 static inline bool userfaultfd_missing(struct vm_area_struct *vma)
-- 
2.30.0.284.gd98b1dd5eaa7-goog

