Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 217092F375F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Jan 2021 18:39:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390830AbhALRiW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 12 Jan 2021 12:38:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726241AbhALRiV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 12 Jan 2021 12:38:21 -0500
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21B99C061786
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 Jan 2021 09:37:41 -0800 (PST)
Received: by mail-io1-xd32.google.com with SMTP id r9so5762600ioo.7
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 Jan 2021 09:37:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NAxlQKvrdS5yrFwFBQveOuSAj/TgVa80OtygrRtytek=;
        b=psue1+5emNwzRBP5lFlcypQibb13jqpMBYklmRW43IxYPa/IQFV/phMHjmDGZ/DAdw
         b3Mj4VuigTJyj40pqVFGEPSuoWlNW9SU6/Nl6dMUbTQiVtbTc6YaL7TnwIx/X9Hj0i87
         a/DcO8DMJcX4amvXNN2DsJYD6t3zmn/RYY8xcdE/BEDv1AXFWelMewTE62Au8ezUm92F
         Q+oRLxHA4lzlomFBES0Kpx/86/Le2/xwL7kIlucL0lqkdZEeWMksopm3et1n4qLDV3lx
         rdlwdD9Sj9fH2D6KZilphgorsMll+bRxaCsR+dvKXgN3/5i1nus1M20SvwHvsGd29TkF
         ywRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NAxlQKvrdS5yrFwFBQveOuSAj/TgVa80OtygrRtytek=;
        b=Hilplwb5EVyLKI7tlQTkW9YIiruH04oxdOh2oSxnblCmu9OTJeNhFVk/jddy64dDWu
         RHFoxEUT+CiHykQ1CZCOPrP4vLXOI74gMpK/3iP7lzX1f0KG6k9Lg0ek+lf2nwRxRqb8
         QIH5IuArMlTtVly3rVC0RE2l+bXq0uD1mWAKn/sxnbcZxyeHl+8o3mqjDl+rKoM78UYq
         /UaTGdOq3mM0CA09zfL0lSpfj2QZAnZtY2vAaplPy9xZp4JqnBrKu3Hhw2Xbgdpl9lov
         YFkciCOmTVhKqngs+NfcEc9sDj87OoS7Uz4uHLSt+jW8P6BDm7MQTXLgY4M6yrrQ6cQw
         ZUXw==
X-Gm-Message-State: AOAM533IRXvgoqG3pWqk9p3NBpvafVSNvfwNCP1hmuavsaXvfri27FnU
        N+pIUn1k+9vXQOhG10DR1+jI/U/dmRL6Ea8vjyDz9Q==
X-Google-Smtp-Source: ABdhPJxThQsGNk+2kONDfFVQqHwWGj7TdamfH4LwZLZu/MW1poRbFzb+kzi2EI5iklgTUj4VOgSO2ujUxoHYZrcCX3Y=
X-Received: by 2002:a5e:840d:: with SMTP id h13mr918688ioj.23.1610473060271;
 Tue, 12 Jan 2021 09:37:40 -0800 (PST)
MIME-Version: 1.0
References: <20210107190453.3051110-1-axelrasmussen@google.com>
 <48f4f43f-eadd-f37d-bd8f-bddba03a7d39@oracle.com> <20210111230848.GA588752@xz-x1>
 <2b31c1ad-2b61-32e7-e3e5-63a3041eabfd@oracle.com> <20210112014934.GB588752@xz-x1>
In-Reply-To: <20210112014934.GB588752@xz-x1>
From:   Axel Rasmussen <axelrasmussen@google.com>
Date:   Tue, 12 Jan 2021 09:37:03 -0800
Message-ID: <CAJHvVcgoqO5XQjqOVe3y5XHSBS4pjqmMPGKD35t-YaB0P1aL2g@mail.gmail.com>
Subject: Re: [RFC PATCH 0/2] userfaultfd: handle minor faults, add UFFDIO_CONTINUE
To:     Peter Xu <peterx@redhat.com>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
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
        =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
        Michel Lespinasse <walken@google.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Nicholas Piggin <npiggin@gmail.com>, Shaohua Li <shli@fb.com>,
        Shawn Anastasio <shawn@anastas.io>,
        Steven Rostedt <rostedt@goodmis.org>,
        Steven Price <steven.price@arm.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, Linux MM <linux-mm@kvack.org>,
        Adam Ruprecht <ruprecht@google.com>,
        Cannon Matthews <cannonmatthews@google.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Oliver Upton <oupton@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jan 11, 2021 at 5:49 PM Peter Xu <peterx@redhat.com> wrote:
>
> On Mon, Jan 11, 2021 at 04:13:41PM -0800, Mike Kravetz wrote:
> > On 1/11/21 3:08 PM, Peter Xu wrote:
> > > On Mon, Jan 11, 2021 at 02:42:48PM -0800, Mike Kravetz wrote:
> > >> On 1/7/21 11:04 AM, Axel Rasmussen wrote:
> > >>> Overview
> > >>> ========
> > >>>
> > >>> This series adds a new userfaultfd registration mode,
> > >>> UFFDIO_REGISTER_MODE_MINOR. This allows userspace to intercept "minor" faults.
> > >>> By "minor" fault, I mean the following situation:
> > >>>
> > >>> Let there exist two mappings (i.e., VMAs) to the same page(s) (shared memory).
> > >>> One of the mappings is registered with userfaultfd (in minor mode), and the
> > >>> other is not. Via the non-UFFD mapping, the underlying pages have already been
> > >>> allocated & filled with some contents. The UFFD mapping has not yet been
> > >>> faulted in; when it is touched for the first time, this results in what I'm
> > >>> calling a "minor" fault. As a concrete example, when working with hugetlbfs, we
> > >>> have huge_pte_none(), but find_lock_page() finds an existing page.
> > >>>
> > >>> We also add a new ioctl to resolve such faults: UFFDIO_CONTINUE. The idea is,
> > >>> userspace resolves the fault by either a) doing nothing if the contents are
> > >>> already correct, or b) updating the underlying contents using the second,
> > >>> non-UFFD mapping (via memcpy/memset or similar, or something fancier like RDMA,
> > >>> or etc...). In either case, userspace issues UFFDIO_CONTINUE to tell the kernel
> > >>> "I have ensured the page contents are correct, carry on setting up the mapping".
> > >>>
> > >>
> > >> One quick thought.
> > >>
> > >> This is not going to work as expected with hugetlbfs pmd sharing.  If you
> > >> are not familiar with hugetlbfs pmd sharing, you are not alone. :)
> > >>
> > >> pmd sharing is enabled for x86 and arm64 architectures.  If there are multiple
> > >> shared mappings of the same underlying hugetlbfs file or shared memory segment
> > >> that are 'suitably aligned', then the PMD pages associated with those regions
> > >> are shared by all the mappings.  Suitably aligned means 'on a 1GB boundary'
> > >> and 1GB in size.
> > >>
> > >> When pmds are shared, your mappings will never see a 'minor fault'.  This
> > >> is because the PMD (page table entries) is shared.
> > >
> > > Thanks for raising this, Mike.
> > >
> > > I've got a few patches that plan to disable huge pmd sharing for uffd in
> > > general, e.g.:
> > >
> > > https://github.com/xzpeter/linux/commit/f9123e803d9bdd91bf6ef23b028087676bed1540
> > > https://github.com/xzpeter/linux/commit/aa9aeb5c4222a2fdb48793cdbc22902288454a31
> > >
> > > I believe we don't want that for missing mode too, but it's just not extremely
> > > important for missing mode yet, because in missing mode we normally monitor all
> > > the processes that will be using the registered mm range.  For example, in QEMU
> > > postcopy migration with vhost-user hugetlbfs files as backends, we'll monitor
> > > both the QEMU process and the DPDK program, so that either of the programs will
> > > trigger a missing fault even if pmd shared between them.  However again I think
> > > it's not ideal since uffd (even if missing mode) is pgtable-based, so sharing
> > > could always be too tricky.
> > >
> > > They're not yet posted to public yet since that's part of uffd-wp support for
> > > hugetlbfs (along with shmem).  So just raise this up to avoid potential
> > > duplicated work before I post the patchset.
> > >
> > > (Will read into details soon; probably too many things piled up...)
> >
> > Thanks for the heads up about this Peter.
> >
> > I know Oracle DB really wants shared pmds -and- UFFD.  I need to get details
> > of their exact usage model.  I know they primarily use SIGBUS, but use
> > MISSING_HUGETLBFS as well.  We may need to be more selective in when to
> > disable.
>
> After a second thought, indeed it's possible to use it that way with pmd
> sharing.  Actually we don't need to generate the fault for every page, if what
> we want to do is simply "initializing the pages using some data" on the
> registered ranges.  Should also be the case even for qemu+dpdk, because if
> e.g. qemu faulted in a page, then it'll be nicer if dpdk can avoid faulting in
> again (so when huge pmd sharing enabled we can even avoid the PF irq to install
> the pte if at last page cache existed).  It should be similarly beneficial if
> the other process is not faulting in but proactively filling the holes using
> UFFDIO_COPY either for the current process or for itself; sounds like a valid
> scenario for Google too when VM migrates.

Exactly right, but I'm a little unsure how to get it to work. There
are two different cases:

- Allocate + populate a page in the background (not on demand) during
postcopy (i.e., after the VM has started executing on the migration
target). In this case, we can be certain that the page contents are up
to date, since execution on the source was already paused. In this
case PMD sharing would actually be nice, because it would mean the VM
would never fault on this page going forward.

- Allocate + populate a page during precopy (i.e., while the VM is
still executing on the migration source). In this case, we *don't*
want PMD sharing, because we need to intercept the first time this
page is touched, verify it's up to date, and copy over the updated
data if not.

Another related situation to consider is, at some point on the target
machine, we'll receive the "dirty map" indicating which pages are out
of date or not. My original thinking was, when the VM faults on any of
these pages, from this point forward we'd just look at the map and
then UFFDIO_CONTINUE if things were up to date. But you're right that
a possible optimization is, once we receive the map, just immediately
"enable PMD sharing" on these pages, so the VM will never fault on
them.

But, this is all kind of speculative. I don't know of any existing API
for *userspace* to take an existing shared memory mapping without PMD
sharing, and "turn on" PMD sharing for particular page(s).

For now, I'll plan on disabling PMD sharing for MINOR registered
ranges. Thanks, Peter and Mike!


>
> I've modified my local tree to only disable pmd sharing for uffd-wp but keep
> missing mode as-is [1].  A new helper uffd_disable_huge_pmd_share() is
> introduced in patch "hugetlb/userfaultfd: Forbid huge pmd sharing when uffd
> enabled", so should be easier if we would like to add minor mode too.
>
> Thanks!
>
> [1] https://github.com/xzpeter/linux/commits/uffd-wp-shmem-hugetlbfs
>
> --
> Peter Xu
>
