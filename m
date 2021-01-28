Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55A2530817E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Jan 2021 23:54:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231768AbhA1Wwi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 Jan 2021 17:52:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231316AbhA1Wux (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 Jan 2021 17:50:53 -0500
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93050C0617A7
        for <linux-fsdevel@vger.kernel.org>; Thu, 28 Jan 2021 14:48:38 -0800 (PST)
Received: by mail-qt1-x849.google.com with SMTP id w3so4589131qti.17
        for <linux-fsdevel@vger.kernel.org>; Thu, 28 Jan 2021 14:48:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=ZyNXN+vY7+byGEzXckl2cjsPvL1+MihL3e0jf1aRuY0=;
        b=hInQaWuhlmhVzsJQOOP66wxpBpJkZz0jp3JdPNaTamPFbqY2Iw7tYezAFSsj/X/h0l
         T//j35IRMXVjHvbnrOMRm67QMdJNZC4EVEFLwXjxKbG2ItZIlriMw4yPfN8SL0+axm10
         nB3lG6H5halTcOohKo2Bunr1Mhiv0S6uvccIRFE2yavExj+oydg1TXJPsp2+5JIPJEUI
         iLlqvTWsvE5vTvctddRV6sDEkokg+J+axchFI7fLCP3v0fRC7iBag6zrKuQHOaIQoC6f
         C8HmrO04qOrB5OSzTgypkr0jqRAv7jVcvbkbd+9FxJRfviJoAvrCOhjbuY7/dlG/jqqn
         HHCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=ZyNXN+vY7+byGEzXckl2cjsPvL1+MihL3e0jf1aRuY0=;
        b=LSPm0w3q9mxvj0nuqxd+1pwgqWV2GfI10AtzNdHdEQPjSBgnvchT0gQ7J0k+w3GX8A
         dwQuR64IViOGw4kRj9OPZHwuBBz7xp5xJudxapca5zBRgPSfFr3VJUSrMYbGnq6n0AMT
         vN0n2Crnf+mv2dxITlnVHuMXCyLdb6OXEYwGmrvY+9V0cBKCseSAg59GgRg2MVHqlQJE
         Ln2TgNDVbcykze0eY9uezxzOT0h9iRXcas7AeAQgEH0TWjqRbxymM4EvdMD+L1V8ei29
         klMuQ1QiFncSRjk+tAVnDVF5C+OOBmQuWWpxTLBT13jufaUC1owm+7SRZSfi9TdWxoDK
         nEQQ==
X-Gm-Message-State: AOAM530q3x7FyIO0wjRbT/UE9D2Z8ofNyPXXlM/XAr8lX2/M7+OGsu4Y
        q4MIrwL0K1CpZj389MfMW5Y5QxKE0ZXqXLqEHPwQ
X-Google-Smtp-Source: ABdhPJyHrrCangWtMdVH/noVU09GiXPhxfCnDmS90lrLcv56JYZpgSU6zPBSDzBuR3Gym8HoUHwHDj38s9I65tdP/sDJ
Sender: "axelrasmussen via sendgmr" <axelrasmussen@ajr0.svl.corp.google.com>
X-Received: from ajr0.svl.corp.google.com ([2620:15c:2cd:203:f693:9fff:feef:c8f8])
 (user=axelrasmussen job=sendgmr) by 2002:ad4:544b:: with SMTP id
 h11mr1850894qvt.24.1611874117664; Thu, 28 Jan 2021 14:48:37 -0800 (PST)
Date:   Thu, 28 Jan 2021 14:48:16 -0800
In-Reply-To: <20210128224819.2651899-1-axelrasmussen@google.com>
Message-Id: <20210128224819.2651899-7-axelrasmussen@google.com>
Mime-Version: 1.0
References: <20210128224819.2651899-1-axelrasmussen@google.com>
X-Mailer: git-send-email 2.30.0.365.g02bc693789-goog
Subject: [PATCH v3 6/9] userfaultfd: disable huge PMD sharing for MINOR
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
2.30.0.365.g02bc693789-goog

