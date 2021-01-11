Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B20DE2F11BA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Jan 2021 12:46:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729854AbhAKLp3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 Jan 2021 06:45:29 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:33213 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729844AbhAKLp3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 Jan 2021 06:45:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610365441;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ttGeJCjE88RI/JbnjK4ApWmv5dTWaDqgt7cJ0I9tF9Y=;
        b=MhdcWvGitp67lOdWne9Tmx3n0uqYmWxh7zLMjYjKLuZoFYMxJNDkL7N7sAOk1jXtOrtFU8
        WRCvgM+F1g+JJPy/LX5OEWXQBBY2E4EGJ+SGsqTPm2/nooJXPNIxPOCdz7AE7fk92PoWaE
        t047UkY2+tKKoAhM2KhJtmxOL7plnKo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-89-MBrAzwhyNoKbZQXhtz3HHA-1; Mon, 11 Jan 2021 06:43:57 -0500
X-MC-Unique: MBrAzwhyNoKbZQXhtz3HHA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6FDAD15720;
        Mon, 11 Jan 2021 11:43:53 +0000 (UTC)
Received: from work-vm (ovpn-115-72.ams2.redhat.com [10.36.115.72])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 3982460939;
        Mon, 11 Jan 2021 11:43:43 +0000 (UTC)
Date:   Mon, 11 Jan 2021 11:43:40 +0000
From:   "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To:     Axel Rasmussen <axelrasmussen@google.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
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
        Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
        Michel Lespinasse <walken@google.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Peter Xu <peterx@redhat.com>, Shaohua Li <shli@fb.com>,
        Shawn Anastasio <shawn@anastas.io>,
        Steven Rostedt <rostedt@goodmis.org>,
        Steven Price <steven.price@arm.com>,
        Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        Adam Ruprecht <ruprecht@google.com>,
        Cannon Matthews <cannonmatthews@google.com>,
        David Rientjes <rientjes@google.com>,
        Oliver Upton <oupton@google.com>
Subject: Re: [RFC PATCH 0/2] userfaultfd: handle minor faults, add
 UFFDIO_CONTINUE
Message-ID: <20210111114340.GF2965@work-vm>
References: <20210107190453.3051110-1-axelrasmussen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210107190453.3051110-1-axelrasmussen@google.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

* Axel Rasmussen (axelrasmussen@google.com) wrote:
> Overview
> ========
> 
> This series adds a new userfaultfd registration mode,
> UFFDIO_REGISTER_MODE_MINOR. This allows userspace to intercept "minor" faults.
> By "minor" fault, I mean the following situation:
> 
> Let there exist two mappings (i.e., VMAs) to the same page(s) (shared memory).
> One of the mappings is registered with userfaultfd (in minor mode), and the
> other is not. Via the non-UFFD mapping, the underlying pages have already been
> allocated & filled with some contents. The UFFD mapping has not yet been
> faulted in; when it is touched for the first time, this results in what I'm
> calling a "minor" fault. As a concrete example, when working with hugetlbfs, we
> have huge_pte_none(), but find_lock_page() finds an existing page.
>
> We also add a new ioctl to resolve such faults: UFFDIO_CONTINUE. The idea is,
> userspace resolves the fault by either a) doing nothing if the contents are
> already correct, or b) updating the underlying contents using the second,
> non-UFFD mapping (via memcpy/memset or similar, or something fancier like RDMA,
> or etc...). In either case, userspace issues UFFDIO_CONTINUE to tell the kernel
> "I have ensured the page contents are correct, carry on setting up the mapping".
> 
> Use Case
> ========
> 
> Consider the use case of VM live migration (e.g. under QEMU/KVM):
> 
> 1. While a VM is still running, we copy the contents of its memory to a
>    target machine. The pages are populated on the target by writing to the
>    non-UFFD mapping, using the setup described above. The VM is still running
>    (and therefore its memory is likely changing), so this may be repeated
>    several times, until we decide the target is "up to date enough".
> 
> 2. We pause the VM on the source, and start executing on the target machine.
>    During this gap, the VM's user(s) will *see* a pause, so it is desirable to
>    minimize this window.
> 
> 3. Between the last time any page was copied from the source to the target, and
>    when the VM was paused, the contents of that page may have changed - and
>    therefore the copy we have on the target machine is out of date. Although we
>    can keep track of which pages are out of date, for VMs with large amounts of
>    memory, it is "slow" to transfer this information to the target machine. We
>    want to resume execution before such a transfer would complete.
> 
> 4. So, the guest begins executing on the target machine. The first time it
>    touches its memory (via the UFFD-registered mapping), userspace wants to
>    intercept this fault. Userspace checks whether or not the page is up to date,
>    and if not, copies the updated page from the source machine, via the non-UFFD
>    mapping. Finally, whether a copy was performed or not, userspace issues a
>    UFFDIO_CONTINUE ioctl to tell the kernel "I have ensured the page contents
>    are correct, carry on setting up the mapping".
> 
> We don't have to do all of the final updates on-demand. The userfaultfd manager
> can, in the background, also copy over updated pages once it receives the map of
> which pages are up-to-date or not.

Yes, this would make the handover during postcopy of large VMs a heck of
a lot faster; and probably simpler; the cleanup code that tidies up the
re-dirty pages is pretty messy.

Dave

> Interaction with Existing APIs
> ==============================
> 
> Because it's possible to combine registration modes (e.g. a single VMA can be
> userfaultfd-registered MINOR | MISSING), and because it's up to userspace how to
> resolve faults once they are received, I spent some time thinking through how
> the existing API interacts with the new feature.
> 
> UFFDIO_CONTINUE cannot be used to resolve non-minor faults, as it does not
> allocate a new page. If UFFDIO_CONTINUE is used on a non-minor fault:
> 
> - For non-shared memory or shmem, -EINVAL is returned.
> - For hugetlb, -EFAULT is returned.
> 
> UFFDIO_COPY and UFFDIO_ZEROPAGE cannot be used to resolve minor faults. Without
> modifications, the existing codepath assumes a new page needs to be allocated.
> This is okay, since userspace must have a second non-UFFD-registered mapping
> anyway, thus there isn't much reason to want to use these in any case (just
> memcpy or memset or similar).
> 
> - If UFFDIO_COPY is used on a minor fault, -EEXIST is returned.
> - If UFFDIO_ZEROPAGE is used on a minor fault, -EEXIST is returned (or -EINVAL
>   in the case of hugetlb, as UFFDIO_ZEROPAGE is unsupported in any case).
> - UFFDIO_WRITEPROTECT simply doesn't work with shared memory, and returns
>   -ENOENT in that case (regardless of the kind of fault).
> 
> Remaining Work
> ==============
> 
> This patchset doesn't include updates to userfaultfd's documentation or
> selftests. This will be added before I send a non-RFC version of this series
> (I want to find out if there are strong objections to the API surface before
> spending the time to document it.)
> 
> Currently the patchset only supports hugetlbfs. There is no reason it can't work
> with shmem, but I expect hugetlbfs to be much more commonly used since we're
> talking about backing guest memory for VMs. I plan to implement shmem support in
> a follow-up patch series.
> 
> Axel Rasmussen (2):
>   userfaultfd: add minor fault registration mode
>   userfaultfd: add UFFDIO_CONTINUE ioctl
> 
>  fs/proc/task_mmu.c               |   1 +
>  fs/userfaultfd.c                 | 143 ++++++++++++++++++++++++-------
>  include/linux/mm.h               |   1 +
>  include/linux/userfaultfd_k.h    |  14 ++-
>  include/trace/events/mmflags.h   |   1 +
>  include/uapi/linux/userfaultfd.h |  36 +++++++-
>  mm/hugetlb.c                     |  42 +++++++--
>  mm/userfaultfd.c                 |  86 ++++++++++++++-----
>  8 files changed, 261 insertions(+), 63 deletions(-)
> 
> --
> 2.29.2.729.g45daf8777d-goog
> 
-- 
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

