Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD55131F36C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Feb 2021 01:51:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229974AbhBSAuQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 Feb 2021 19:50:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229925AbhBSAuA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 Feb 2021 19:50:00 -0500
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18026C0617A7
        for <linux-fsdevel@vger.kernel.org>; Thu, 18 Feb 2021 16:48:42 -0800 (PST)
Received: by mail-qk1-x74a.google.com with SMTP id p27so2491561qkp.8
        for <linux-fsdevel@vger.kernel.org>; Thu, 18 Feb 2021 16:48:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=1cwm5N3iRSXNZcDifIiTRhsYT8Ky/UdIpcuK8zvOJso=;
        b=KOIP0f7r/7awfBYAwsiP/am4wnAatFFEUV0C/ZGa1HGU4QPkDXqyQT7hMY06fmCKpn
         pOeD7L0zsDoWrUSccbB/A6Xgn1Iix2vRx7bd4VMXz48CnhGVZKtbqRTamescV20PnCT9
         Z6y4D9UXmogsLgHVKFxXJInlJSbJifOEvMNDG5OI5cZFC/pdDWMFoVVEU929qqb8V4jM
         yP/+a4bKQ50e7fVm+b2KZco77RZC23ckyqym29kxbN01uYvQbFYkLxJb8UMKR0a/LmHt
         HBDf+qWky+cTz/zlyvFkj48fQMR1P7bYIH1MMUW5Ozz6SYAl3qWbTcUlZ2xkl8nyVZEX
         Ut4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=1cwm5N3iRSXNZcDifIiTRhsYT8Ky/UdIpcuK8zvOJso=;
        b=AvR9uUCC+ASKWSXGFtC8BElRGO2ONM8fQdyC1gnP/wTIeBUtDHtiK2WMODaBYCT3M7
         a0inMQraUAUEAHyfx+QGOVeR8brXbHOT9iOYIMDXtTfQbR4RSYvOvmSZe3bghx1I0Jbp
         T/pPqDk3GuU4xVa+Gyp48Lx4qw0aIwMC9X8kldvRJV/znjCTDb04rpdfpYDqluib7z8F
         qphGIXbSnaqQCcq+l7YagVh1QgNbfG7qG/1MdpSgWvjYgznB1029uFBBjPKMZlOWXmA6
         6HH5MMr9LIwKBcODXxVJb7UEwdJm8a5IMmIdx1sUGRkMxSsZiQFh6CjISigsC0Jf/vVB
         a0Jw==
X-Gm-Message-State: AOAM533km/c8jfH3xsKXALgMfsIK7fitfQy/ZMlwqwDVnPKttMJZ2+MD
        o5ywFXKPHmhSQdg+0l0VnVHF24qonpmuaQ62SoM3
X-Google-Smtp-Source: ABdhPJz4vhWFuVnp5vZJkaSLtjDx8IU8+aqy5+CrhvbiTfNv/ouXJ3YO2ta6NPQxm5kqWb2YzvielKKWLm4hxSFVydyd
Sender: "axelrasmussen via sendgmr" <axelrasmussen@ajr0.svl.corp.google.com>
X-Received: from ajr0.svl.corp.google.com ([2620:15c:2cd:203:e939:4cce:117:5af3])
 (user=axelrasmussen job=sendgmr) by 2002:a0c:dd05:: with SMTP id
 u5mr7037895qvk.54.1613695721183; Thu, 18 Feb 2021 16:48:41 -0800 (PST)
Date:   Thu, 18 Feb 2021 16:48:23 -0800
In-Reply-To: <20210219004824.2899045-1-axelrasmussen@google.com>
Message-Id: <20210219004824.2899045-6-axelrasmussen@google.com>
Mime-Version: 1.0
References: <20210219004824.2899045-1-axelrasmussen@google.com>
X-Mailer: git-send-email 2.30.0.617.g56c4b15f3c-goog
Subject: [PATCH v7 5/6] userfaultfd: update documentation to describe minor
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

Describe how UFFDIO_REGISTER_MODE_MINOR and UFFDIO_CONTINUE can be used
to intercept and resolve minor faults. Make it clear that COPY and
ZEROPAGE are used for MISSING faults, whereas CONTINUE is used for MINOR
faults.

Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>
---
 Documentation/admin-guide/mm/userfaultfd.rst | 107 ++++++++++++-------
 1 file changed, 66 insertions(+), 41 deletions(-)

diff --git a/Documentation/admin-guide/mm/userfaultfd.rst b/Documentation/admin-guide/mm/userfaultfd.rst
index 65eefa66c0ba..3aa38e8b8361 100644
--- a/Documentation/admin-guide/mm/userfaultfd.rst
+++ b/Documentation/admin-guide/mm/userfaultfd.rst
@@ -63,36 +63,36 @@ the generic ioctl available.
 
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
+events, except page fault notifications, may be generated:
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
+- ``UFFD_FEATURE_MINOR_HUGETLBFS`` indicates that the kernel supports
+  ``UFFDIO_REGISTER_MODE_MINOR`` registration for hugetlbfs virtual memory
+  areas.
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
@@ -100,21 +100,46 @@ memory from the ``userfaultfd`` registered range). This means a userfault
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
+- For ``UFFDIO_REGISTER_MODE_MISSING`` faults, the fault needs to be
+  resolved by either providing a new page (``UFFDIO_COPY``), or mapping
+  the zero page (``UFFDIO_ZEROPAGE``). By default, the kernel would map
+  the zero page for a missing fault. With userfaultfd, userspace can
+  decide what content to provide before the faulting thread continues.
+
+- For ``UFFDIO_REGISTER_MODE_MINOR`` faults, there is an existing page (in
+  the page cache). Userspace has the option of modifying the page's
+  contents before resolving the fault. Once the contents are correct
+  (modified or not), userspace asks the kernel to map the page and let the
+  faulting thread continue with ``UFFDIO_CONTINUE``.
 
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
@@ -122,9 +147,9 @@ Notes:
 
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
2.30.0.617.g56c4b15f3c-goog

