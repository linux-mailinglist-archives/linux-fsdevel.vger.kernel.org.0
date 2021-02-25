Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 330A63247E8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Feb 2021 01:29:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236426AbhBYA2l (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 24 Feb 2021 19:28:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236410AbhBYA2b (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 24 Feb 2021 19:28:31 -0500
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89834C06178A
        for <linux-fsdevel@vger.kernel.org>; Wed, 24 Feb 2021 16:27:12 -0800 (PST)
Received: by mail-qk1-x749.google.com with SMTP id 19so3152631qks.13
        for <linux-fsdevel@vger.kernel.org>; Wed, 24 Feb 2021 16:27:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=Gqbdv7dcKJ3HCSbhGAkcVMLKp5XjaZ2pyZBQ0WD1HYc=;
        b=iQABgmB2nLQqaKFyd+0m8gvgul2Nt+XEMSupc3YU+qI9MdQ6eucQVi37eJUoliHxGc
         OCA3NnqnU0jVrAPr6wJdk3zwxFyRkq+GqYdIMH7GKD9BkNJKUAZdzcpJ/WYkwuIVfhHo
         MaUfU84qw3yu0dvwnEga90NViMOUtE5V3Qicxd5SqkolYKOv31XWFq6wa8zduh/NmSgY
         XY84n067XFrVpjAncfw/6qjH75qZVlt6Z+XyGvVZeJhdTxVXr8gGI+LIbtVIAJ2TWosG
         GNO1H5CyC1zMdrXCjCEpGj8ujleA4lr68NUOhYwhlhplb8jOusKFkKYl49EDsMiVJI9D
         kVng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Gqbdv7dcKJ3HCSbhGAkcVMLKp5XjaZ2pyZBQ0WD1HYc=;
        b=KINLOuEubMQkInq89U/HpjQsHdnvEaD0zdxHylXvNaqYp2Ah4QF/+5LGaDziTLttNu
         /hgsl2jFoi4SBnW8Q+6XPpIilh/QY3mQfeESYyMFGBDP4eaondiwiHxYyaeh0g7nX/4A
         xZra6y56pSsiq0xtXVkLNjG7MXSPALVEtkwgZOnTcQIAX/+1NMIDwjx2W1+v3D7tywqX
         //VSKG5PR0yPIKj9t6cpkYj6Ob9MTb4o7XCH75cyBTKcazGFaY+EhUum14Clpw5UIOsS
         YT6kvG2Gl8q+3ICdIhovsXoRV90i75780iYPuPfJEt1qoYaLw0CCO0VLHP64LpCUlAOe
         U4lg==
X-Gm-Message-State: AOAM531mbSXq3GFuSRXktxcOSvYjEVTn7dp4wj0UJ+hbb7B9+SmWyVJj
        7mzjmMHsnmsmwkZ9YuaDxy5Ow0GvEPdJKiHQ1NbA
X-Google-Smtp-Source: ABdhPJzA2CyX9smbu/vAvGixwBcY7izPD9oc6hVVChcH0GmIKCU5YaZZlii7h51Djyv6Qa6Kto2hlehC23SMRVOPwSYi
Sender: "axelrasmussen via sendgmr" <axelrasmussen@ajr0.svl.corp.google.com>
X-Received: from ajr0.svl.corp.google.com ([2620:15c:2cd:203:a5fd:f848:2fdf:4651])
 (user=axelrasmussen job=sendgmr) by 2002:a05:6214:941:: with SMTP id
 dn1mr237760qvb.61.1614212831623; Wed, 24 Feb 2021 16:27:11 -0800 (PST)
Date:   Wed, 24 Feb 2021 16:26:54 -0800
In-Reply-To: <20210225002658.2021807-1-axelrasmussen@google.com>
Message-Id: <20210225002658.2021807-3-axelrasmussen@google.com>
Mime-Version: 1.0
References: <20210225002658.2021807-1-axelrasmussen@google.com>
X-Mailer: git-send-email 2.30.0.617.g56c4b15f3c-goog
Subject: [PATCH v8 2/6] userfaultfd: disable huge PMD sharing for MINOR
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
2.30.0.617.g56c4b15f3c-goog

