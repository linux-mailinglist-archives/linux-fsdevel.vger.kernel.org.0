Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0841731A727
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Feb 2021 22:57:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231394AbhBLV4U (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 12 Feb 2021 16:56:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231200AbhBLVzm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 12 Feb 2021 16:55:42 -0500
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F834C0617AA
        for <linux-fsdevel@vger.kernel.org>; Fri, 12 Feb 2021 13:54:29 -0800 (PST)
Received: by mail-pl1-x64a.google.com with SMTP id o8so701871pls.7
        for <linux-fsdevel@vger.kernel.org>; Fri, 12 Feb 2021 13:54:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=bDtjA5Mj64PKIXivN7+vBaDB7zA4gfkDWN/bO1d3kzE=;
        b=mlGrz0560MvpN6T2897JEFwbu8KJgaRSL8SgF9PP3/OStRDKY5lmRkzyCNdkhemT0y
         dZOruNOcEQfjty93lbZyO4wyIaDqkxNPZFw98D/HCmo4JFl/NfYr/ZN/u1plmNp80MIk
         1CRMRMQ/Do3BDpbIoK5/C4FdumyYHZHclNj9Jn7dU6a21II1aUo+5seKKYTtlDqwbkLv
         pe6u/9N2xLFVZenMgg3V+5mPv8ybp2YVNq6NGjU3tG9kNP2nm3dSzjF+rQRHkpctaNnz
         xoms8isX2NshX0o10O99DyI4KkzsA+KDkZj4HgX+FLeDbfeK3mxdslR5azG0anjvhkwY
         aWYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=bDtjA5Mj64PKIXivN7+vBaDB7zA4gfkDWN/bO1d3kzE=;
        b=sVegGtH568KxYwWf1AWdfyN/Rh/79jV+QkeqwpMhAXI5p/juOn4uUnnC6u5vA+rmpb
         BMt8snM6fSTsnU69wBNxw1kZHZeo4UI5RHovxAYUfS2Jc0lvvKjNL7p0TL0VCyfCH2X/
         G1sq7pILMfTl9eqGfHWOql3GhEDQACpevyIVEmhLtGYzKkFehVw+eft2PygMcWG4YbMD
         ZNkf9Akl24hG1OsbGXZzZtfRcJG+Yu2RYlPa/Ut5Pn2p/vo34dkKREwz9X+2vmuIFXZm
         zO3sJ5tOM3/0Hbct4bh1KPjLlJiITLMtIEP70guOnsBSlf29NfyP+rcJV+uvvZ1H5lyB
         RWRw==
X-Gm-Message-State: AOAM530OsdNewMETsDTRPU/AgG7hUXKpTMN/TQyxqItoUXhMf2//bq4p
        C2qGK/igo0G5cHQImgU0NoUzZlZ8jFc/HWQh0+Sz
X-Google-Smtp-Source: ABdhPJwM54ZLRvUd3VQAdohmT5ljP8vEvqwCvhdBPZQxg11B4p/OTJRCJ7EcRDarTlPbCflo4kN0FWkumWE8VVbCbXgq
Sender: "axelrasmussen via sendgmr" <axelrasmussen@ajr0.svl.corp.google.com>
X-Received: from ajr0.svl.corp.google.com ([2620:15c:2cd:203:d2f:99bb:c1e0:34ba])
 (user=axelrasmussen job=sendgmr) by 2002:a17:90a:8d83:: with SMTP id
 d3mr1528pjo.0.1613166868460; Fri, 12 Feb 2021 13:54:28 -0800 (PST)
Date:   Fri, 12 Feb 2021 13:54:02 -0800
In-Reply-To: <20210212215403.3457686-1-axelrasmussen@google.com>
Message-Id: <20210212215403.3457686-7-axelrasmussen@google.com>
Mime-Version: 1.0
References: <20210212215403.3457686-1-axelrasmussen@google.com>
X-Mailer: git-send-email 2.30.0.478.g8a0d178c01-goog
Subject: [PATCH v6 6/7] userfaultfd: update documentation to describe minor
 fault handling
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

Reword / reorganize things a little bit into "lists", so new features /
modes / ioctls can sort of just be appended.

Describe how minor faults can be intercepted and resolved. Make it clear
that COPY and ZEROPAGE are for missing faults, whereas CONTINUE is for
minor faults.

Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>
---
 Documentation/admin-guide/mm/userfaultfd.rst | 109 ++++++++++++-------
 1 file changed, 68 insertions(+), 41 deletions(-)

diff --git a/Documentation/admin-guide/mm/userfaultfd.rst b/Documentation/admin-guide/mm/userfaultfd.rst
index 65eefa66c0ba..a3434b3f4f2d 100644
--- a/Documentation/admin-guide/mm/userfaultfd.rst
+++ b/Documentation/admin-guide/mm/userfaultfd.rst
@@ -63,36 +63,37 @@ the generic ioctl available.
 
 The ``uffdio_api.features`` bitmask returned by the ``UFFDIO_API`` ioctl
 defines what memory types are supported by the ``userfaultfd`` and what
-events, except page fault notifications, may be generated.
-
-If the kernel supports registering ``userfaultfd`` ranges on hugetlbfs
-virtual memory areas, ``UFFD_FEATURE_MISSING_HUGETLBFS`` will be set in
-``uffdio_api.features``. Similarly, ``UFFD_FEATURE_MISSING_SHMEM`` will be
-set if the kernel supports registering ``userfaultfd`` ranges on shared
-memory (covering all shmem APIs, i.e. tmpfs, ``IPCSHM``, ``/dev/zero``,
-``MAP_SHARED``, ``memfd_create``, etc).
-
-The userland application that wants to use ``userfaultfd`` with hugetlbfs
-or shared memory need to set the corresponding flag in
-``uffdio_api.features`` to enable those features.
-
-If the userland desires to receive notifications for events other than
-page faults, it has to verify that ``uffdio_api.features`` has appropriate
-``UFFD_FEATURE_EVENT_*`` bits set. These events are described in more
-detail below in `Non-cooperative userfaultfd`_ section.
-
-Once the ``userfaultfd`` has been enabled the ``UFFDIO_REGISTER`` ioctl should
-be invoked (if present in the returned ``uffdio_api.ioctls`` bitmask) to
-register a memory range in the ``userfaultfd`` by setting the
+events, beyond page fault notifications, may be generated:
+
+- The ``UFFD_FEATURE_EVENT_*`` flags indicate that various other events
+  other than page faults are supported. These events are described in more
+  detail below in the `Non-cooperative userfaultfd`_ section.
+
+- ``UFFD_FEATURE_MISSING_HUGETLBFS`` and ``UFFD_FEATURE_MISSING_SHMEM``
+  indicate that the kernel supports ``UFFDIO_REGISTER_MODE_MISSING``
+  registrations for hugetlbfs and shared memory (covering all shmem APIs,
+  i.e. tmpfs, ``IPCSHM``, ``/dev/zero``, ``MAP_SHARED``, ``memfd_create``,
+  etc) virtual memory areas, respectively.
+
+- ``UFFD_FEATURE_MINOR_HUGETLBFS`` indicates that hugetlbfs virtual memory
+  areas that are ``UFFDIO_REGISTER_MODE_MINOR`` registered will also
+  receive page fault events for minor faults. This feature is not enabled
+  unless specifically requested.
+
+The userland application should set the feature flags it intends to use
+when invoking the ``UFFDIO_API`` ioctl, to request that those features be
+enabled if supported.
+
+Once the ``userfaultfd`` API has been enabled the ``UFFDIO_REGISTER``
+ioctl should be invoked (if present in the returned ``uffdio_api.ioctls``
+bitmask) to register a memory range in the ``userfaultfd`` by setting the
 uffdio_register structure accordingly. The ``uffdio_register.mode``
 bitmask will specify to the kernel which kind of faults to track for
-the range (``UFFDIO_REGISTER_MODE_MISSING`` would track missing
-pages). The ``UFFDIO_REGISTER`` ioctl will return the
+the range. The ``UFFDIO_REGISTER`` ioctl will return the
 ``uffdio_register.ioctls`` bitmask of ioctls that are suitable to resolve
 userfaults on the range registered. Not all ioctls will necessarily be
-supported for all memory types depending on the underlying virtual
-memory backend (anonymous memory vs tmpfs vs real filebacked
-mappings).
+supported for all memory types (e.g. anonymous memory vs. shmem vs.
+hugetlbfs), or all types of intercepted faults.
 
 Userland can use the ``uffdio_register.ioctls`` to manage the virtual
 address space in the background (to add or potentially also remove
@@ -100,21 +101,47 @@ memory from the ``userfaultfd`` registered range). This means a userfault
 could be triggering just before userland maps in the background the
 user-faulted page.
 
-The primary ioctl to resolve userfaults is ``UFFDIO_COPY``. That
-atomically copies a page into the userfault registered range and wakes
-up the blocked userfaults
-(unless ``uffdio_copy.mode & UFFDIO_COPY_MODE_DONTWAKE`` is set).
-Other ioctl works similarly to ``UFFDIO_COPY``. They're atomic as in
-guaranteeing that nothing can see an half copied page since it'll
-keep userfaulting until the copy has finished.
+Resolving Userfaults
+--------------------
+
+There are three basic ways to resolve userfaults:
+
+- ``UFFDIO_COPY`` atomically copies some existing page contents from
+  userspace.
+
+- ``UFFDIO_ZEROPAGE`` atomically zeros the new page.
+
+- ``UFFDIO_CONTINUE`` maps an existing, previously-populated page.
+
+These operations are atomic in the sense that they guarantee nothing can
+see a half-populated page, since readers will keep userfaulting until the
+operation has finished.
+
+By default, these wake up userfaults blocked on the range in question.
+They support a ``UFFDIO_*_MODE_DONTWAKE`` ``mode`` flag, which indicates
+that waking will be done separately at some later time.
+
+Which ioctl to choose depends on the kind of page fault, and what we'd
+like to do to resolve it:
+
+- For missing faults (neither ``UFFD_PAGEFAULT_FLAG_WP`` nor
+  ``UFFD_PAGEFAULT_FLAG_MINOR`` are set), the fault needs to be resolved
+  by either providing a new page (``UFFDIO_COPY``), or mapping the zero
+  page (``UFFDIO_ZEROPAGE``). By default, the kernel would map the zero
+  page for a missing fault. With userfaultfd, userspace can decide what
+  content to provide before the faulting thread continues.
+
+- For minor faults (``UFFD_PAGEFAULT_FLAG_MINOR`` is set), there is an
+  existing page (in the page cache). Userspace has the option of modifying
+  the page's contents before resolving the fault. Once the contents are
+  correct (modified or not), userspace asks the kernel to map the page and
+  let the faulting thread continue with ``UFFDIO_CONTINUE``.
 
 Notes:
 
-- If you requested ``UFFDIO_REGISTER_MODE_MISSING`` when registering then
-  you must provide some kind of page in your thread after reading from
-  the uffd.  You must provide either ``UFFDIO_COPY`` or ``UFFDIO_ZEROPAGE``.
-  The normal behavior of the OS automatically providing a zero page on
-  an anonymous mmaping is not in place.
+- You can tell which kind of fault occurred by examining
+  ``pagefault.flags`` within the ``uffd_msg``, checking for the
+  ``UFFD_PAGEFAULT_FLAG_*`` flags.
 
 - None of the page-delivering ioctls default to the range that you
   registered with.  You must fill in all fields for the appropriate
@@ -122,9 +149,9 @@ Notes:
 
 - You get the address of the access that triggered the missing page
   event out of a struct uffd_msg that you read in the thread from the
-  uffd.  You can supply as many pages as you want with ``UFFDIO_COPY`` or
-  ``UFFDIO_ZEROPAGE``.  Keep in mind that unless you used DONTWAKE then
-  the first of any of those IOCTLs wakes up the faulting thread.
+  uffd.  You can supply as many pages as you want with these IOCTLs.
+  Keep in mind that unless you used DONTWAKE then the first of any of
+  those IOCTLs wakes up the faulting thread.
 
 - Be sure to test for all errors including
   (``pollfd[0].revents & POLLERR``).  This can happen, e.g. when ranges
-- 
2.30.0.478.g8a0d178c01-goog

