Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5926300EFD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Jan 2021 22:35:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729468AbhAVVfF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Jan 2021 16:35:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729656AbhAVVcK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Jan 2021 16:32:10 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14E58C061352
        for <linux-fsdevel@vger.kernel.org>; Fri, 22 Jan 2021 13:29:42 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id d38so6765242ybe.15
        for <linux-fsdevel@vger.kernel.org>; Fri, 22 Jan 2021 13:29:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=MPwAJ6+DP3gIY4R9V98gU/QUOgUfEvMZgCw03h5dW3o=;
        b=WYQGdSXW9Dowjq/tEtiJqYSTEnelLtZWHHwZiMQ94JhsG1GVc6oXRQMkpKu7eDAnHv
         NKg5GF6ig1ZApuH4agXonVwcgSdI+18UP1rEYDJjiagiX3nla69C6i534XagdKIa5rE/
         stPFS97wq9OkZoeiz1rFi1x1kJZsS2k9umbO6YttlIBN6TmYynWgLi/QmC+NEZMItDTO
         9ysUFg8CGvemV55rGYVD9R4kBsLZU/1kcscl/p0tmtk7bRUTGBNMM7r2jE3Eu/jv59Vv
         SJiRApl3UATIW3JdL0kjcsHrNtMWZkb94lqg3baFBxmKgHWZhyt+UWO78Fr7MO3m0ey5
         ztKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=MPwAJ6+DP3gIY4R9V98gU/QUOgUfEvMZgCw03h5dW3o=;
        b=uirOZrjhAlFlDBEHVygSpa08kjSE3MAHnrlEi08702qmvrZiPpZ4oPnAMrmST+BkED
         lM07BKlXQO6IPH1icBlupINppE06ZYc4Pe1wnvqXmoT+9LPqpu/fUsulOuMGsmPdG2W1
         ratOBNMi2rW82T4z+ksGGlrDSzkYRoVR6dxCUlX2QcnqObc4jgxfbeccM2qnzEpo13fb
         W74VLyfIh6BPt6W+DmhDGT95+bIhB913gKPH1934q1m9I7XrfNHSDuxjxhszzrBpiNSU
         1wxsM3EpGq5qo1YkZbVd0H/ZHP9rJFSubSaQR8cDe4KdKAxUZSMn9BIbovFhEoJlblNc
         9vOA==
X-Gm-Message-State: AOAM531z9chVbn0rdyTcFoH7dcjSj4F8J4ZO5A6MkRlpjTJc72LKJXCI
        rm92Uu/G1SSXq5rPSv4FV3Ikn/24j5c+5Ku7+Z+R
X-Google-Smtp-Source: ABdhPJyHx4pF16cMtKv8VUHxhdr6uUrqdN7OvpRpZ9uoUtGCjEIg5DdoSNeVrersXyA8X3p5MBqwn7u8giCGUi5oMp4a
Sender: "axelrasmussen via sendgmr" <axelrasmussen@ajr0.svl.corp.google.com>
X-Received: from ajr0.svl.corp.google.com ([2620:15c:2cd:203:f693:9fff:feef:c8f8])
 (user=axelrasmussen job=sendgmr) by 2002:a25:c6d3:: with SMTP id
 k202mr9150649ybf.284.1611350981237; Fri, 22 Jan 2021 13:29:41 -0800 (PST)
Date:   Fri, 22 Jan 2021 13:29:23 -0800
In-Reply-To: <20210122212926.3457593-1-axelrasmussen@google.com>
Message-Id: <20210122212926.3457593-7-axelrasmussen@google.com>
Mime-Version: 1.0
References: <20210122212926.3457593-1-axelrasmussen@google.com>
X-Mailer: git-send-email 2.30.0.280.ga3ce27912f-goog
Subject: [PATCH v2 6/9] userfaultfd: disable huge PMD sharing for MINOR
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

Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>
---
 include/linux/userfaultfd_k.h | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/include/linux/userfaultfd_k.h b/include/linux/userfaultfd_k.h
index 0390e5ac63b3..fb9abaeb4194 100644
--- a/include/linux/userfaultfd_k.h
+++ b/include/linux/userfaultfd_k.h
@@ -56,12 +56,18 @@ static inline bool is_mergeable_vm_userfaultfd_ctx(struct vm_area_struct *vma,
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
2.30.0.280.ga3ce27912f-goog

