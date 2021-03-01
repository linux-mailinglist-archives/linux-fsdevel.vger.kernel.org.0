Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5D1C329712
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Mar 2021 10:00:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238114AbhCAWcQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 1 Mar 2021 17:32:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244932AbhCAW2U (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 1 Mar 2021 17:28:20 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E9D3C061797
        for <linux-fsdevel@vger.kernel.org>; Mon,  1 Mar 2021 14:27:40 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id u1so20472489ybu.14
        for <linux-fsdevel@vger.kernel.org>; Mon, 01 Mar 2021 14:27:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=Ffolv6cCxRHUvURj2O7pa1bwsyAQ1T5kdza2OAkkouY=;
        b=OqWULVsjc5kG1tSiKzdPQ6lmZhTxIus8AFl8m9sfc24TVgVwz+5dJB9LVZ92SGAztl
         M1nnT5eqN8K86Cbg+aZbMvtu+VsW5UwayjcttoCx9NyGETzAEsuZ206lgRVsAfTL3pP0
         BUSXsrDQSABJsXlXkpzuhE3HmrUVv7mf6okeR275r+qQlu/EWudrDmmc+gwTnDmONdmt
         qAKuZwItPa/F/QHolBwTCLgzowfYc6iWaevajuM+UoGhnj6Y+5ctlwg8YlPTFZbQ9hP2
         HQMwj8mxoXk0G2t2xhmk5WVUczMKf52EW+fioAByRJTMOPvXR3agMuDhmHFn36hUBmol
         NmJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Ffolv6cCxRHUvURj2O7pa1bwsyAQ1T5kdza2OAkkouY=;
        b=RaBQ8LWHTppSa/6muVwe8q6AUTE98kTv4AFy8FhnsJsZsDvr7vNPG6bZ4VVEKOQYB1
         JQ331HqLj2eAlC9h1BYlNpjMHSU7ltWldlW/MUHZbQ735KCyGw3EEwyy/yuDJ338Ve1L
         920X4Y2Zun/xnpLVqRUo090yEpsOd2O/eFMhjYbWTVSUjXsYymLlZWucCEsSc7kevQwx
         MaAwb1U7SmUie1Bz/waB72QNX88J44qzCfywhDzRwWOxoV2sxqc9WEmk8X2VRLLmCS+p
         3j97rhn4XgdixfVqwa+3u0QWCeAfOJjclIX+pQo3XJs2YGaf9gsec3spX892zraYsnVw
         ZQgw==
X-Gm-Message-State: AOAM53362ScWJUCgFuP6OaCYyRMok934fCoUiSuZtuIBqw/6dBuOo232
        5MSdNCEhTHVrbQY5g/E2NGl5tcK54ktJF0KXOZpj
X-Google-Smtp-Source: ABdhPJzc5y7AU15P9PCUuTuAnbP63qIvfhyNPhEpq27PTqPFwjyDNYHkSqeT60bmJ8CafzW2xk2sNBegVQIFa0LllhKV
Sender: "axelrasmussen via sendgmr" <axelrasmussen@ajr0.svl.corp.google.com>
X-Received: from ajr0.svl.corp.google.com ([2620:15c:2cd:203:1998:8165:ca50:ab8d])
 (user=axelrasmussen job=sendgmr) by 2002:a25:e785:: with SMTP id
 e127mr26698696ybh.451.1614637659522; Mon, 01 Mar 2021 14:27:39 -0800 (PST)
Date:   Mon,  1 Mar 2021 14:27:24 -0800
In-Reply-To: <20210301222728.176417-1-axelrasmussen@google.com>
Message-Id: <20210301222728.176417-3-axelrasmussen@google.com>
Mime-Version: 1.0
References: <20210301222728.176417-1-axelrasmussen@google.com>
X-Mailer: git-send-email 2.30.1.766.gb4fecdf3b7-goog
Subject: [PATCH v9 2/6] userfaultfd: disable huge PMD sharing for MINOR
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
Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
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
2.30.1.766.gb4fecdf3b7-goog

