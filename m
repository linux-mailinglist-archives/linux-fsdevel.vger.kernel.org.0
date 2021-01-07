Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9245F2ED72D
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Jan 2021 20:07:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729104AbhAGTFq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 7 Jan 2021 14:05:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727177AbhAGTFq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 7 Jan 2021 14:05:46 -0500
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6A9EC0612F5
        for <linux-fsdevel@vger.kernel.org>; Thu,  7 Jan 2021 11:05:05 -0800 (PST)
Received: by mail-pg1-x549.google.com with SMTP id w13so5473664pgr.13
        for <linux-fsdevel@vger.kernel.org>; Thu, 07 Jan 2021 11:05:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=1Ks8/3nZJCYS90R8JKk2puoyafhaeYHGuGPtcF6mxek=;
        b=s33gwiE6wEj4kJwKpZ+JBEnAPq2Iul6GLks8POMY9MgZc9LBZEzjlEFhyqZYiwx4id
         dMUAawf6ZO1RuNGq6qWn7XiCwJZaExLSJ/x0qIdCrZcZ5lvZbgLpOXACTZgO7pmlu87x
         Zv/9mH/Oxu+THRCrCKk23deOoYVx+kIKAa5hSJt7UI49J1EJO2RC9KiHnXTjT/vb1SAb
         yhuOQHXkHuckcPE1Q+qkGIReZWdZZ1KhdiTyGY799YowVmEqWHJf722bg2qLRozEV0Kd
         vZm4JkDx7ZwLeiNeB2q5xb7tZVq7cjBJEKYOlzBvaCQRi8AAGDzniY+am3PWed00CrYr
         UxpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=1Ks8/3nZJCYS90R8JKk2puoyafhaeYHGuGPtcF6mxek=;
        b=WGJRlAq7jZFdSVjygVVMUFwX7/bTOHY0bwlBph5vGegunMFLqiwM4zraCDOsGbHJu9
         ngV7Kj+1uMP1rSrudy09c9TJTCAqAoXA/vq1VZ17mrH/l52faGHaJu2IlRfja/3EtZUJ
         3UdTQC/F8RJr9dmigMdjs/wTJGNAn3oYCcQBzrDvCzBcghRZyaTfzVM/kyMKBmb8jbBZ
         iYrbJn8z0t6JFJOwq69DN//dlWFmk6urlspotqY4tWI9vFGGaPWDy5g6ez51ytPX3Kfa
         9FW1PrSUc+EeduEShczcemK6uKpUjOIYYUyfnpFmh89dWKlNTTN9JgbtZJrpVAgtf0d9
         BcbA==
X-Gm-Message-State: AOAM531/LXt4r7lcHFKVTSabRByC7wLGH4LRcdWacLFNNDf+Wf1z6rht
        fjWvRCLvVTbvyiiFhE+H+KKbjFSCeQeF7SYX1w6e
X-Google-Smtp-Source: ABdhPJxFND2XY3Pg2WyGKBNLXJEiCRrx4CwvkyILubCDSqYj/vz535k983RPVy3w45oJ8bmaDS3h0zHA99/3XyZBAkZh
Sender: "axelrasmussen via sendgmr" <axelrasmussen@ajr0.svl.corp.google.com>
X-Received: from ajr0.svl.corp.google.com ([2620:15c:2cd:203:f693:9fff:feef:c8f8])
 (user=axelrasmussen job=sendgmr) by 2002:a17:90a:c085:: with SMTP id
 o5mr10737346pjs.210.1610046305274; Thu, 07 Jan 2021 11:05:05 -0800 (PST)
Date:   Thu,  7 Jan 2021 11:04:51 -0800
Message-Id: <20210107190453.3051110-1-axelrasmussen@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.29.2.729.g45daf8777d-goog
Subject: [RFC PATCH 0/2] userfaultfd: handle minor faults, add UFFDIO_CONTINUE
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

Overview
========

This series adds a new userfaultfd registration mode,
UFFDIO_REGISTER_MODE_MINOR. This allows userspace to intercept "minor" faults.
By "minor" fault, I mean the following situation:

Let there exist two mappings (i.e., VMAs) to the same page(s) (shared memory).
One of the mappings is registered with userfaultfd (in minor mode), and the
other is not. Via the non-UFFD mapping, the underlying pages have already been
allocated & filled with some contents. The UFFD mapping has not yet been
faulted in; when it is touched for the first time, this results in what I'm
calling a "minor" fault. As a concrete example, when working with hugetlbfs, we
have huge_pte_none(), but find_lock_page() finds an existing page.

We also add a new ioctl to resolve such faults: UFFDIO_CONTINUE. The idea is,
userspace resolves the fault by either a) doing nothing if the contents are
already correct, or b) updating the underlying contents using the second,
non-UFFD mapping (via memcpy/memset or similar, or something fancier like RDMA,
or etc...). In either case, userspace issues UFFDIO_CONTINUE to tell the kernel
"I have ensured the page contents are correct, carry on setting up the mapping".

Use Case
========

Consider the use case of VM live migration (e.g. under QEMU/KVM):

1. While a VM is still running, we copy the contents of its memory to a
   target machine. The pages are populated on the target by writing to the
   non-UFFD mapping, using the setup described above. The VM is still running
   (and therefore its memory is likely changing), so this may be repeated
   several times, until we decide the target is "up to date enough".

2. We pause the VM on the source, and start executing on the target machine.
   During this gap, the VM's user(s) will *see* a pause, so it is desirable to
   minimize this window.

3. Between the last time any page was copied from the source to the target, and
   when the VM was paused, the contents of that page may have changed - and
   therefore the copy we have on the target machine is out of date. Although we
   can keep track of which pages are out of date, for VMs with large amounts of
   memory, it is "slow" to transfer this information to the target machine. We
   want to resume execution before such a transfer would complete.

4. So, the guest begins executing on the target machine. The first time it
   touches its memory (via the UFFD-registered mapping), userspace wants to
   intercept this fault. Userspace checks whether or not the page is up to date,
   and if not, copies the updated page from the source machine, via the non-UFFD
   mapping. Finally, whether a copy was performed or not, userspace issues a
   UFFDIO_CONTINUE ioctl to tell the kernel "I have ensured the page contents
   are correct, carry on setting up the mapping".

We don't have to do all of the final updates on-demand. The userfaultfd manager
can, in the background, also copy over updated pages once it receives the map of
which pages are up-to-date or not.

Interaction with Existing APIs
==============================

Because it's possible to combine registration modes (e.g. a single VMA can be
userfaultfd-registered MINOR | MISSING), and because it's up to userspace how to
resolve faults once they are received, I spent some time thinking through how
the existing API interacts with the new feature.

UFFDIO_CONTINUE cannot be used to resolve non-minor faults, as it does not
allocate a new page. If UFFDIO_CONTINUE is used on a non-minor fault:

- For non-shared memory or shmem, -EINVAL is returned.
- For hugetlb, -EFAULT is returned.

UFFDIO_COPY and UFFDIO_ZEROPAGE cannot be used to resolve minor faults. Without
modifications, the existing codepath assumes a new page needs to be allocated.
This is okay, since userspace must have a second non-UFFD-registered mapping
anyway, thus there isn't much reason to want to use these in any case (just
memcpy or memset or similar).

- If UFFDIO_COPY is used on a minor fault, -EEXIST is returned.
- If UFFDIO_ZEROPAGE is used on a minor fault, -EEXIST is returned (or -EINVAL
  in the case of hugetlb, as UFFDIO_ZEROPAGE is unsupported in any case).
- UFFDIO_WRITEPROTECT simply doesn't work with shared memory, and returns
  -ENOENT in that case (regardless of the kind of fault).

Remaining Work
==============

This patchset doesn't include updates to userfaultfd's documentation or
selftests. This will be added before I send a non-RFC version of this series
(I want to find out if there are strong objections to the API surface before
spending the time to document it.)

Currently the patchset only supports hugetlbfs. There is no reason it can't work
with shmem, but I expect hugetlbfs to be much more commonly used since we're
talking about backing guest memory for VMs. I plan to implement shmem support in
a follow-up patch series.

Axel Rasmussen (2):
  userfaultfd: add minor fault registration mode
  userfaultfd: add UFFDIO_CONTINUE ioctl

 fs/proc/task_mmu.c               |   1 +
 fs/userfaultfd.c                 | 143 ++++++++++++++++++++++++-------
 include/linux/mm.h               |   1 +
 include/linux/userfaultfd_k.h    |  14 ++-
 include/trace/events/mmflags.h   |   1 +
 include/uapi/linux/userfaultfd.h |  36 +++++++-
 mm/hugetlb.c                     |  42 +++++++--
 mm/userfaultfd.c                 |  86 ++++++++++++++-----
 8 files changed, 261 insertions(+), 63 deletions(-)

--
2.29.2.729.g45daf8777d-goog

