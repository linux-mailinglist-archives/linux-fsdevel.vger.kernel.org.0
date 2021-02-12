Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 016A231A723
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Feb 2021 22:57:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229660AbhBLVzy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 12 Feb 2021 16:55:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230270AbhBLVzi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 12 Feb 2021 16:55:38 -0500
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 421AAC06178B
        for <linux-fsdevel@vger.kernel.org>; Fri, 12 Feb 2021 13:54:23 -0800 (PST)
Received: by mail-pg1-x54a.google.com with SMTP id c30so778275pgl.15
        for <linux-fsdevel@vger.kernel.org>; Fri, 12 Feb 2021 13:54:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=YlfIormFBY/rysSGqj+ed5treI/R2/QqIMyWcQNPNXw=;
        b=CTA6VBPTeFoAytyEos3lFWsVfDnGleeYtmq/FweYdKvW2QZB2YOJ2iA5510aDYkwwm
         f1M4M0HXg164r7mCCQYA8E96Khx3lIUmOQCYKUU6G88yAzBKEo21KmMcQvRZeWO37DMT
         GuCm3Juq29cIL78PNFnwnb1evyu9ZvJY7rMy4EV+45WqOfBr00LinEOZ0kn4BPWi1s/v
         IsevNgCw4AzhAORs6F1A/oWmx8boULq3Uhrrc269HT0dzBi5x3fTSVlMO+xQ5ZMxjK7L
         E70c3DKqkObmpcmJsSksnqXlyE/pVf++EDEpmdEg0e2ecnMT9pcJVoet4SwErpYyG2sZ
         zHzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=YlfIormFBY/rysSGqj+ed5treI/R2/QqIMyWcQNPNXw=;
        b=axRlK7mz/KWyByc/m33NGoVsqudkw/rHpFI08zAxHRMUAkFHcFnh95pQfKFWKRYmrY
         yaaXNT9JW7+/zhfvhoVbV3zxNLMOKTBk+It1Rg7tx1xKJ6Q0fdBlq3GwTVKN4QpH5YHf
         m2DwNgqwjt7jtPLlmR3uxb17YtbblxzIlNKPL8JAxya61zW5wjIN+D8aBryqtqVz5iNv
         ZMoS/gDbeKOCnFm6bQxWhBBp0G69eHaJef1gys9Qdxwx9WF1FC+bDIaw+TH7/1Yw0vDs
         owelHYfmWorWXNms4T0nh/PvIU0pDTt1eHCWHQYjlzxslJ2o4Eo8GHEErdzbshoUliuC
         NNkA==
X-Gm-Message-State: AOAM533E6Tdtx56/NrOGUszMQfmBGZiGkhSvBJ38GePy9Wz4RmyaK6kh
        +5YVWE+YAUwTtO4AxqWGxj3rcCTLgzSptBJa4JmL
X-Google-Smtp-Source: ABdhPJwGFRdVdg0cd7jePQFHLBhd+X3gZzHYFwdheoONEE1KBWOaidn+Vm+YQFlcd9yaV231OScKlUtfWhrhA94tO2JM
Sender: "axelrasmussen via sendgmr" <axelrasmussen@ajr0.svl.corp.google.com>
X-Received: from ajr0.svl.corp.google.com ([2620:15c:2cd:203:d2f:99bb:c1e0:34ba])
 (user=axelrasmussen job=sendgmr) by 2002:a63:da4a:: with SMTP id
 l10mr5133633pgj.222.1613166862664; Fri, 12 Feb 2021 13:54:22 -0800 (PST)
Date:   Fri, 12 Feb 2021 13:53:59 -0800
In-Reply-To: <20210212215403.3457686-1-axelrasmussen@google.com>
Message-Id: <20210212215403.3457686-4-axelrasmussen@google.com>
Mime-Version: 1.0
References: <20210212215403.3457686-1-axelrasmussen@google.com>
X-Mailer: git-send-email 2.30.0.478.g8a0d178c01-goog
Subject: [PATCH v6 3/7] userfaultfd: disable huge PMD sharing for minor fault
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

As the comment says: for the minor fault use case, although the page
might be present and populated in the other (non-UFFD-registered) half
of the mapping, it may be out of date, and we explicitly want userspace
to get a minor fault so it can check and potentially update the page's
contents.

Huge PMD sharing would prevent these faults from occurring for
suitably aligned areas, so disable it upon UFFD registration.

Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>
---
 include/linux/userfaultfd_k.h | 26 +++++++++++++++++---------
 1 file changed, 17 insertions(+), 9 deletions(-)

diff --git a/include/linux/userfaultfd_k.h b/include/linux/userfaultfd_k.h
index 4e03268c65ec..98cb6260b4b4 100644
--- a/include/linux/userfaultfd_k.h
+++ b/include/linux/userfaultfd_k.h
@@ -62,15 +62,6 @@ static inline bool is_mergeable_vm_userfaultfd_ctx(struct vm_area_struct *vma,
 	return vma->vm_userfaultfd_ctx.ctx == vm_ctx.ctx;
 }
 
-/*
- * Never enable huge pmd sharing on uffd-wp registered vmas, because uffd-wp
- * protect information is per pgtable entry.
- */
-static inline bool uffd_disable_huge_pmd_share(struct vm_area_struct *vma)
-{
-	return vma->vm_flags & VM_UFFD_WP;
-}
-
 static inline bool userfaultfd_missing(struct vm_area_struct *vma)
 {
 	return vma->vm_flags & VM_UFFD_MISSING;
@@ -83,6 +74,23 @@ static inline bool userfaultfd_wp(struct vm_area_struct *vma)
 
 bool userfaultfd_minor(struct vm_area_struct *vma);
 
+/*
+ * Never enable huge pmd sharing on some uffd registered vmas:
+ *
+ * - VM_UFFD_WP VMAs, because write protect information is per pgtable entry.
+ *
+ * - VM_UFFD_MISSING VMAs with UFFD_FEATURE_MINOR_HUGETLBFS, because otherwise
+ *   we would never get minor faults for VMAs which share huge pmds. (If you
+ *   have two mappings to the same underlying pages, and fault in the
+ *   non-UFFD-registered one with a write, with huge pmd sharing this would
+ *   *also* setup the second UFFD-registered mapping, and we'd not get minor
+ *   faults.)
+ */
+static inline bool uffd_disable_huge_pmd_share(struct vm_area_struct *vma)
+{
+	return userfaultfd_wp(vma) || userfaultfd_minor(vma);
+}
+
 static inline bool userfaultfd_pte_wp(struct vm_area_struct *vma,
 				      pte_t pte)
 {
-- 
2.30.0.478.g8a0d178c01-goog

