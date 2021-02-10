Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49993317246
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Feb 2021 22:24:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233704AbhBJVYY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 10 Feb 2021 16:24:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233404AbhBJVXF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 10 Feb 2021 16:23:05 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEB7BC0617AA
        for <linux-fsdevel@vger.kernel.org>; Wed, 10 Feb 2021 13:22:18 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id g17so1291646ybh.4
        for <linux-fsdevel@vger.kernel.org>; Wed, 10 Feb 2021 13:22:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=C7eX4+NVGX5He9yBXKDzK09THiAFk9zxs8Mq4BgC9+k=;
        b=X4O2XnKeTyP1mrCdcCUv43l+RzH7IHrvPnQey/wsi4M+B7W6hzZlGZRvvKHgHPwxwy
         /WvTVU9Ez2URRDEtOOJilnHqyhVt6olC/GaNJXdnpvVpPBeGB4gNunb7ZQQAvUfzsdxe
         edZieAb5VYpDFXolL8aMA/zf1+cab8/dJJYDrbwRG+GaG11wlghI8k3l4/uai0ppkIOY
         VRGXu6go8MCoW4HFmNHNxwfTbMwbVHMUk2ma8RoEvXxXQ4B5PVnkOj5fjrgRZZ2y3LAP
         0DBfUQeu/ImT99KF9thtVNcUbahpM0amXl0cGg6p/tFca2fEUDbwL7TN4RyPqcPqmPCr
         FDgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=C7eX4+NVGX5He9yBXKDzK09THiAFk9zxs8Mq4BgC9+k=;
        b=JrrmgOW0IvsvxKmk3uKn5+gUA75vVct91+Z7sSt3BFevChC//kSiApH/VopBPUAPM8
         7cRpQtc3qCh/B64cqw6VO2cnXJ7xsukAgYcev22WiyMqaG9A7M1tjJipL092rG8gYbFN
         X23sxRvfW5c8zOT+aJJxQVrf+9lz01S3NUHcOPSOGR5zg0J/cCyK2GypU2k4qyIPrNeQ
         IggJ0whpSUE3ycEqmSS3dNOm2J51jJCLWaU3QFCIK3+wpoKsgE1usR2B6D8pe//yDAcn
         ZCg/KMCzPsqR2b8z3ifLsHeULuhF/Iy+m4kUyXtF6dp5zQ6Vzu27AE1oSNEtNltYnxYZ
         33Ug==
X-Gm-Message-State: AOAM532fO3XBcUO+Sp3t09vbl2jp3fpk9jPgz/1wC3pd7dbhtx6GoYhu
        8/xWoGxhtSewnRg/skNge86VLkW5JFImTOMwBoCY
X-Google-Smtp-Source: ABdhPJwagtVWNE35dh8EXmqH56OhS+dAouO564OVOUkNaVQb6+9yLc/FG1bX+ngeJuwo0ZOZsUjMFDiVvTAXntctl3Gj
Sender: "axelrasmussen via sendgmr" <axelrasmussen@ajr0.svl.corp.google.com>
X-Received: from ajr0.svl.corp.google.com ([2620:15c:2cd:203:94ee:de01:168:9f20])
 (user=axelrasmussen job=sendgmr) by 2002:a25:cc46:: with SMTP id
 l67mr7659356ybf.16.1612992138150; Wed, 10 Feb 2021 13:22:18 -0800 (PST)
Date:   Wed, 10 Feb 2021 13:21:56 -0800
In-Reply-To: <20210210212200.1097784-1-axelrasmussen@google.com>
Message-Id: <20210210212200.1097784-7-axelrasmussen@google.com>
Mime-Version: 1.0
References: <20210210212200.1097784-1-axelrasmussen@google.com>
X-Mailer: git-send-email 2.30.0.478.g8a0d178c01-goog
Subject: [PATCH v5 06/10] userfaultfd: disable huge PMD sharing for MINOR
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
2.30.0.478.g8a0d178c01-goog

