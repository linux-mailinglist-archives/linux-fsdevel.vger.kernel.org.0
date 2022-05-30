Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0276537A28
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 May 2022 13:50:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234546AbiE3Luw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 30 May 2022 07:50:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235989AbiE3LtU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 30 May 2022 07:49:20 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6520069CF8;
        Mon, 30 May 2022 04:49:16 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id f9so20391422ejc.0;
        Mon, 30 May 2022 04:49:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nd6S/4FbujckFXHbJ3x2tPms//JAl6b3bx2ELwdlV/U=;
        b=NPflMS1B9xhIemPrWGKN7vducBeMfUV4uuo+ekGv7by4KZnFIPxTge/bZIBrlXmPVC
         ScsR+ZoOVabR40Q390DpCBkvUiEhu3YM1CMkaYY2Fc0qrb2CoZBdk3GpSG0VGyAxj2Kk
         HdLVu61VAaebUg+hal+WHLbutfocELl1RQypZpbVrLfiXw6lIv6sQNckv7GmYC/JOvee
         X/aeCCxJa8ZP0/Br2iG/SjzWOJ7s+TFdSphFigU7p1s6ZBRTEZVvFj0nw07uMQtdCPIE
         08BYV9oV3Esf0v2Eo01EgPMPMXuoAJeZVdB52to1AF01NDWF19fLA9o03vfg3FL0/JR6
         JzaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nd6S/4FbujckFXHbJ3x2tPms//JAl6b3bx2ELwdlV/U=;
        b=oJLto3o6w1Frsqikf9+/U6FOFy/OBQFnUyDzSqJM1fO3oLCQYIoFGrvMkb+FvAF+n5
         J370vDYtXPa3GomfB1Y2Z8DQsY5c7NmNC82s560i9qp4NK16sRZGrRhJz9GkQgqPlk1k
         fbBIY91Dl6HN4xPhu7CzrSAgICdCTlvnQ0tzkrtmkeabZ4nVIvI6WEOlEOtk4Gb4lmgT
         NtvMCFb7BLKPLPx+G2siXgol/Ri9koFcyKxi03PESdUIc9N/1wKGECLVcwl84SHxO3Z7
         4SNAnIi5BmHsDw2v7HJTrKQb4Y5SJ0Pty3TeJeHPVo8/voA1nzX9rrGfH/L2jvNJO+QW
         b+uA==
X-Gm-Message-State: AOAM531b+IbcHTBCfR6XpGR5blO3LRg7/AP9R495yLFscKDS0V22c+sP
        carsB8P8992MHtnA8uwOWx4myAxRUORRdfw7nFI=
X-Google-Smtp-Source: ABdhPJwTUeoIA6iQJJkcj+IXPZ41zpTMDJ6E19vx+XvXImeWk5jsLPwwgWTolQK/RXtrY6P8EbNJiFj6NxumIvZi4mM=
X-Received: by 2002:a17:907:9496:b0:6ff:1012:1b9c with SMTP id
 dm22-20020a170907949600b006ff10121b9cmr23322900ejc.457.1653911354724; Mon, 30
 May 2022 04:49:14 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1649370874.git.khalid.aziz@oracle.com> <CAGsJ_4yXnmifuU7+BFOkZrz-7AkW4CDQF5cHqQS-oci-rJ=ZdA@mail.gmail.com>
 <55109e8f-29b8-4016-dcee-28eb8a70bd12@redhat.com>
In-Reply-To: <55109e8f-29b8-4016-dcee-28eb8a70bd12@redhat.com>
From:   Barry Song <21cnbao@gmail.com>
Date:   Mon, 30 May 2022 23:49:03 +1200
Message-ID: <CAGsJ_4xXDqzEuBuXukY7M954MNkybicTYUHtYCC8yY1jm2Gagg@mail.gmail.com>
Subject: Re: [PATCH v1 00/14] Add support for shared PTEs across processes
To:     David Hildenbrand <david@redhat.com>
Cc:     Khalid Aziz <khalid.aziz@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Aneesh Kumar <aneesh.kumar@linux.ibm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Jonathan Corbet <corbet@lwn.net>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        ebiederm@xmission.com, hagen@jauu.net, jack@suse.cz,
        Kees Cook <keescook@chromium.org>, kirill@shutemov.name,
        kucharsk@gmail.com, linkinjeon@kernel.org,
        linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>, longpeng2@huawei.com,
        Andy Lutomirski <luto@kernel.org>, markhemm@googlemail.com,
        pcc@google.com, Mike Rapoport <rppt@kernel.org>,
        sieberf@amazon.com, sjpark@amazon.de,
        Suren Baghdasaryan <surenb@google.com>, tst@schoebel-theuer.de,
        Iurii Zaikin <yzaikin@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, May 30, 2022 at 11:18 PM David Hildenbrand <david@redhat.com> wrote:
>
> On 30.05.22 12:48, Barry Song wrote:
> > On Tue, Apr 12, 2022 at 4:07 AM Khalid Aziz <khalid.aziz@oracle.com> wrote:
> >>
> >> Page tables in kernel consume some of the memory and as long as number
> >> of mappings being maintained is small enough, this space consumed by
> >> page tables is not objectionable. When very few memory pages are
> >> shared between processes, the number of page table entries (PTEs) to
> >> maintain is mostly constrained by the number of pages of memory on the
> >> system. As the number of shared pages and the number of times pages
> >> are shared goes up, amount of memory consumed by page tables starts to
> >> become significant.
> >>
> >> Some of the field deployments commonly see memory pages shared across
> >> 1000s of processes. On x86_64, each page requires a PTE that is only 8
> >> bytes long which is very small compared to the 4K page size. When 2000
> >> processes map the same page in their address space, each one of them
> >> requires 8 bytes for its PTE and together that adds up to 8K of memory
> >> just to hold the PTEs for one 4K page. On a database server with 300GB
> >> SGA, a system carsh was seen with out-of-memory condition when 1500+
> >> clients tried to share this SGA even though the system had 512GB of
> >> memory. On this server, in the worst case scenario of all 1500
> >> processes mapping every page from SGA would have required 878GB+ for
> >> just the PTEs. If these PTEs could be shared, amount of memory saved
> >> is very significant.
> >>
> >> This patch series implements a mechanism in kernel to allow userspace
> >> processes to opt into sharing PTEs. It adds two new system calls - (1)
> >> mshare(), which can be used by a process to create a region (we will
> >> call it mshare'd region) which can be used by other processes to map
> >> same pages using shared PTEs, (2) mshare_unlink() which is used to
> >> detach from the mshare'd region. Once an mshare'd region is created,
> >> other process(es), assuming they have the right permissions, can make
> >> the mashare() system call to map the shared pages into their address
> >> space using the shared PTEs.  When a process is done using this
> >> mshare'd region, it makes a mshare_unlink() system call to end its
> >> access. When the last process accessing mshare'd region calls
> >> mshare_unlink(), the mshare'd region is torn down and memory used by
> >> it is freed.
> >>
> >>
> >> API
> >> ===
> >>
> >> The mshare API consists of two system calls - mshare() and mshare_unlink()
> >>
> >> --
> >> int mshare(char *name, void *addr, size_t length, int oflags, mode_t mode)
> >>
> >> mshare() creates and opens a new, or opens an existing mshare'd
> >> region that will be shared at PTE level. "name" refers to shared object
> >> name that exists under /sys/fs/mshare. "addr" is the starting address
> >> of this shared memory area and length is the size of this area.
> >> oflags can be one of:
> >>
> >> - O_RDONLY opens shared memory area for read only access by everyone
> >> - O_RDWR opens shared memory area for read and write access
> >> - O_CREAT creates the named shared memory area if it does not exist
> >> - O_EXCL If O_CREAT was also specified, and a shared memory area
> >>   exists with that name, return an error.
> >>
> >> mode represents the creation mode for the shared object under
> >> /sys/fs/mshare.
> >>
> >> mshare() returns an error code if it fails, otherwise it returns 0.
> >>
> >> PTEs are shared at pgdir level and hence it imposes following
> >> requirements on the address and size given to the mshare():
> >>
> >> - Starting address must be aligned to pgdir size (512GB on x86_64).
> >>   This alignment value can be looked up in /proc/sys/vm//mshare_size
> >> - Size must be a multiple of pgdir size
> >> - Any mappings created in this address range at any time become
> >>   shared automatically
> >> - Shared address range can have unmapped addresses in it. Any access
> >>   to unmapped address will result in SIGBUS
> >>
> >> Mappings within this address range behave as if they were shared
> >> between threads, so a write to a MAP_PRIVATE mapping will create a
> >> page which is shared between all the sharers. The first process that
> >> declares an address range mshare'd can continue to map objects in
> >> the shared area. All other processes that want mshare'd access to
> >> this memory area can do so by calling mshare(). After this call, the
> >> address range given by mshare becomes a shared range in its address
> >> space. Anonymous mappings will be shared and not COWed.
> >>
> >> A file under /sys/fs/mshare can be opened and read from. A read from
> >> this file returns two long values - (1) starting address, and (2)
> >> size of the mshare'd region.
> >>
> >> --
> >> int mshare_unlink(char *name)
> >>
> >> A shared address range created by mshare() can be destroyed using
> >> mshare_unlink() which removes the  shared named object. Once all
> >> processes have unmapped the shared object, the shared address range
> >> references are de-allocated and destroyed.
> >>
> >> mshare_unlink() returns 0 on success or -1 on error.
> >>
> >>
> >> Example Code
> >> ============
> >>
> >> Snippet of the code that a donor process would run looks like below:
> >>
> >> -----------------
> >>         addr = mmap((void *)TB(2), GB(512), PROT_READ | PROT_WRITE,
> >>                         MAP_SHARED | MAP_ANONYMOUS, 0, 0);
> >>         if (addr == MAP_FAILED)
> >>                 perror("ERROR: mmap failed");
> >>
> >>         err = syscall(MSHARE_SYSCALL, "testregion", (void *)TB(2),
> >>                         GB(512), O_CREAT|O_RDWR|O_EXCL, 600);
> >>         if (err < 0) {
> >>                 perror("mshare() syscall failed");
> >>                 exit(1);
> >>         }
> >>
> >>         strncpy(addr, "Some random shared text",
> >>                         sizeof("Some random shared text"));
> >> -----------------
> >>
> >> Snippet of code that a consumer process would execute looks like:
> >>
> >> -----------------
> >>         struct mshare_info minfo;
> >>
> >>         fd = open("testregion", O_RDONLY);
> >>         if (fd < 0) {
> >>                 perror("open failed");
> >>                 exit(1);
> >>         }
> >>
> >>         if ((count = read(fd, &minfo, sizeof(struct mshare_info)) > 0))
> >>                 printf("INFO: %ld bytes shared at addr 0x%lx \n",
> >>                                 minfo.size, minfo.start);
> >>         else
> >>                 perror("read failed");
> >>
> >>         close(fd);
> >>
> >>         addr = (void *)minfo.start;
> >>         err = syscall(MSHARE_SYSCALL, "testregion", addr, minfo.size,
> >>                         O_RDWR, 600);
> >>         if (err < 0) {
> >>                 perror("mshare() syscall failed");
> >>                 exit(1);
> >>         }
> >>
> >>         printf("Guest mmap at %px:\n", addr);
> >>         printf("%s\n", addr);
> >>         printf("\nDone\n");
> >>
> >>         err = syscall(MSHARE_UNLINK_SYSCALL, "testregion");
> >>         if (err < 0) {
> >>                 perror("mshare_unlink() failed");
> >>                 exit(1);
> >>         }
> >> -----------------
> >
> >
> > Does  that mean those shared pages will get page_mapcount()=1 ?
>
> AFAIU, for mshare() that is the case.
>
> >
> > A big pain for a memory limited system like a desktop/embedded system is
> > that reverse mapping will take tons of cpu in memory reclamation path
> > especially for those pages mapped by multiple processes. sometimes,
> > 100% cpu utilization on LRU to scan and find out if a page is accessed
> > by reading PTE young.
>
> Regarding PTE-table sharing:
>
> Even if we'd account each logical mapping (independent of page table
> sharing) in the page_mapcount(), we would benefit from page table
> sharing. Simply when we unmap the page from the shared page table, we'd
> have to adjust the mapcount accordingly. So unmapping from a single
> (shared) pagetable could directly result in the mapcount dropping to zero.
>
> What I am trying to say is: how the mapcount is handled might be an
> implementation detail for PTE-sharing. Not sure how hugetlb handles that
> with its PMD-table sharing.
>
> We'd have to clarify what the mapcount actually expresses. Having the
> mapcount express "is this page mapped by multiple processes or at
> multiple VMAs" might be helpful in some cases. Right now it mostly
> expresses exactly that.

right, i guess mapcount, as a number for itself, isn't so important. the
only important thing is that we only need to read one PTE rather
than 1000 PTEs to figure out if one page is young.

so this patchset has already been able to do reverse mapping only
one time for a page shared by 1000 processes rather than reading
1000 PTEs?

i mean, i actually haven't found your actually touched any files in
mm/vmscan.c etc.

>
> >
> > if we result in one PTE only by this patchset, it means we are getting
> > significant
> > performance improvement in kernel LRU particularly when free memory
> > approaches the watermarks.
> >
> > But I don't see how a new system call like mshare(),  can be used
> > by those systems as they might need some more automatic PTEs sharing
> > mechanism.
>
> IMHO, we should look into automatic PTE-table sharing of MAP_SHARED
> mappings, similar to what hugetlb provides for PMD table sharing, which
> leaves semantics unchanged for existing user space. Maybe there is a way
> to factor that out and reuse it for PTE-table sharing.
>
> I can understand that there are use cases for explicit sharing with new
> (e.g., mprotect) semantics.
>
> >
> > BTW, I suppose we are actually able to share PTEs as long as the address
> > is 2MB aligned?
>
> 2MB is x86 specific, but yes. As long as we're aligned to PMDs and
> * the VMA spans the complete PMD
> * the VMA permissions match the page table
> * no process-specific page table features are used (uffd, softdirty
>   tracking)
>
> ... probably there are more corner cases. (e.g., referenced and dirty
> bit don't reflect what the mapping process did, which might or might not
> be relevant for current/future features)
>
> --
> Thanks,
>
> David / dhildenb
>

Thanks
Barry
