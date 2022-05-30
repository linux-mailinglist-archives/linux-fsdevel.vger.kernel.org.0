Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82B0D53796A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 May 2022 12:49:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234009AbiE3KtP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 30 May 2022 06:49:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232169AbiE3KtM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 30 May 2022 06:49:12 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B2975F81;
        Mon, 30 May 2022 03:49:10 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id h19so4885340edj.0;
        Mon, 30 May 2022 03:49:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=u8/gVE/Pbp62avAa1Q8ygK8Oh0lOsYwIbjg3E/Srd1Q=;
        b=LW+7inV/O/KfwTsWL0Cw5bsbbGjlmaBNUoJmaEP8JT+hQiN6ttyguldUhl0K4dCDQr
         2gp4pFy95gBz8dKQ53lr5/i36B0lByFcL1d8NCH8Kpx4njJUDyGWV+ZChrbENPrVit1u
         1au7bUO4Jqy+pnCVz3CdPCAD8lkNROPRiHYhe3DXPbbtUjmddTmh7TyXpuOsJH0Bp5ig
         D4fiuWAeIuTgBYivtrER0ygkw5M7qfKEanVeAqBDo1KLUL212dOTPUK5jAsl04I6DCPj
         YVO0qhR3oLVgmjWlyGk1tG8905TmzyMlOkbtBccLOv/iElTsXVFf3ncu/paor+UkYo16
         JSew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=u8/gVE/Pbp62avAa1Q8ygK8Oh0lOsYwIbjg3E/Srd1Q=;
        b=d5c8dFY1EFn7npNmcOzh/1tjsq79bUSdGZWHm5D8KtWiEOBCi3QiUt790ViIVMZ7l8
         bU7Yx/7eXhqxP65DDusVRHDL5/cX4V4sO5WwFp5lRSH3DwdwUTx6+zWuZCTgd9VYhN/v
         o+OK1ghlFEikIRUZ565JOJI+mfIE3LBI5V9ERbLBWvDHjkUYIbAY+YP99JbiHyaZRbjw
         A3SzdnS01r13treCXyPvAk20SPCDUyDjgB7Ij8uXgIqbAYACd2+U8cKz/z6WagRydmhc
         +N0YSFvj3xq/ev4X793qM5Z7+eVphuu5GG1OdDvHXGLgY5KR8dTvu0mHEHMSrAR4YtUd
         mTmA==
X-Gm-Message-State: AOAM532x37cZRsZWb+59MfClNPUmZG4E9PzpfvhGvZmmAtrRU5iGFH5D
        +H0Llh+dMz6uRhhQfwXHIHuVNbI9O0KAn+8ydY0=
X-Google-Smtp-Source: ABdhPJwACLhNljTmUMeodtv1EfTWuS+98geZiCEO9SBjnTFUg4tcEBT9akWjVShivNXVR0b2lmSLzjGNUujuVONjU1Q=
X-Received: by 2002:a05:6402:cae:b0:42a:ba8f:9d05 with SMTP id
 cn14-20020a0564020cae00b0042aba8f9d05mr57661697edb.277.1653907749063; Mon, 30
 May 2022 03:49:09 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1649370874.git.khalid.aziz@oracle.com>
In-Reply-To: <cover.1649370874.git.khalid.aziz@oracle.com>
From:   Barry Song <21cnbao@gmail.com>
Date:   Mon, 30 May 2022 22:48:57 +1200
Message-ID: <CAGsJ_4yXnmifuU7+BFOkZrz-7AkW4CDQF5cHqQS-oci-rJ=ZdA@mail.gmail.com>
Subject: Re: [PATCH v1 00/14] Add support for shared PTEs across processes
To:     Khalid Aziz <khalid.aziz@oracle.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Aneesh Kumar <aneesh.kumar@linux.ibm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Jonathan Corbet <corbet@lwn.net>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        David Hildenbrand <david@redhat.com>, ebiederm@xmission.com,
        hagen@jauu.net, jack@suse.cz, Kees Cook <keescook@chromium.org>,
        kirill@shutemov.name, kucharsk@gmail.com, linkinjeon@kernel.org,
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

On Tue, Apr 12, 2022 at 4:07 AM Khalid Aziz <khalid.aziz@oracle.com> wrote:
>
> Page tables in kernel consume some of the memory and as long as number
> of mappings being maintained is small enough, this space consumed by
> page tables is not objectionable. When very few memory pages are
> shared between processes, the number of page table entries (PTEs) to
> maintain is mostly constrained by the number of pages of memory on the
> system. As the number of shared pages and the number of times pages
> are shared goes up, amount of memory consumed by page tables starts to
> become significant.
>
> Some of the field deployments commonly see memory pages shared across
> 1000s of processes. On x86_64, each page requires a PTE that is only 8
> bytes long which is very small compared to the 4K page size. When 2000
> processes map the same page in their address space, each one of them
> requires 8 bytes for its PTE and together that adds up to 8K of memory
> just to hold the PTEs for one 4K page. On a database server with 300GB
> SGA, a system carsh was seen with out-of-memory condition when 1500+
> clients tried to share this SGA even though the system had 512GB of
> memory. On this server, in the worst case scenario of all 1500
> processes mapping every page from SGA would have required 878GB+ for
> just the PTEs. If these PTEs could be shared, amount of memory saved
> is very significant.
>
> This patch series implements a mechanism in kernel to allow userspace
> processes to opt into sharing PTEs. It adds two new system calls - (1)
> mshare(), which can be used by a process to create a region (we will
> call it mshare'd region) which can be used by other processes to map
> same pages using shared PTEs, (2) mshare_unlink() which is used to
> detach from the mshare'd region. Once an mshare'd region is created,
> other process(es), assuming they have the right permissions, can make
> the mashare() system call to map the shared pages into their address
> space using the shared PTEs.  When a process is done using this
> mshare'd region, it makes a mshare_unlink() system call to end its
> access. When the last process accessing mshare'd region calls
> mshare_unlink(), the mshare'd region is torn down and memory used by
> it is freed.
>
>
> API
> ===
>
> The mshare API consists of two system calls - mshare() and mshare_unlink()
>
> --
> int mshare(char *name, void *addr, size_t length, int oflags, mode_t mode)
>
> mshare() creates and opens a new, or opens an existing mshare'd
> region that will be shared at PTE level. "name" refers to shared object
> name that exists under /sys/fs/mshare. "addr" is the starting address
> of this shared memory area and length is the size of this area.
> oflags can be one of:
>
> - O_RDONLY opens shared memory area for read only access by everyone
> - O_RDWR opens shared memory area for read and write access
> - O_CREAT creates the named shared memory area if it does not exist
> - O_EXCL If O_CREAT was also specified, and a shared memory area
>   exists with that name, return an error.
>
> mode represents the creation mode for the shared object under
> /sys/fs/mshare.
>
> mshare() returns an error code if it fails, otherwise it returns 0.
>
> PTEs are shared at pgdir level and hence it imposes following
> requirements on the address and size given to the mshare():
>
> - Starting address must be aligned to pgdir size (512GB on x86_64).
>   This alignment value can be looked up in /proc/sys/vm//mshare_size
> - Size must be a multiple of pgdir size
> - Any mappings created in this address range at any time become
>   shared automatically
> - Shared address range can have unmapped addresses in it. Any access
>   to unmapped address will result in SIGBUS
>
> Mappings within this address range behave as if they were shared
> between threads, so a write to a MAP_PRIVATE mapping will create a
> page which is shared between all the sharers. The first process that
> declares an address range mshare'd can continue to map objects in
> the shared area. All other processes that want mshare'd access to
> this memory area can do so by calling mshare(). After this call, the
> address range given by mshare becomes a shared range in its address
> space. Anonymous mappings will be shared and not COWed.
>
> A file under /sys/fs/mshare can be opened and read from. A read from
> this file returns two long values - (1) starting address, and (2)
> size of the mshare'd region.
>
> --
> int mshare_unlink(char *name)
>
> A shared address range created by mshare() can be destroyed using
> mshare_unlink() which removes the  shared named object. Once all
> processes have unmapped the shared object, the shared address range
> references are de-allocated and destroyed.
>
> mshare_unlink() returns 0 on success or -1 on error.
>
>
> Example Code
> ============
>
> Snippet of the code that a donor process would run looks like below:
>
> -----------------
>         addr = mmap((void *)TB(2), GB(512), PROT_READ | PROT_WRITE,
>                         MAP_SHARED | MAP_ANONYMOUS, 0, 0);
>         if (addr == MAP_FAILED)
>                 perror("ERROR: mmap failed");
>
>         err = syscall(MSHARE_SYSCALL, "testregion", (void *)TB(2),
>                         GB(512), O_CREAT|O_RDWR|O_EXCL, 600);
>         if (err < 0) {
>                 perror("mshare() syscall failed");
>                 exit(1);
>         }
>
>         strncpy(addr, "Some random shared text",
>                         sizeof("Some random shared text"));
> -----------------
>
> Snippet of code that a consumer process would execute looks like:
>
> -----------------
>         struct mshare_info minfo;
>
>         fd = open("testregion", O_RDONLY);
>         if (fd < 0) {
>                 perror("open failed");
>                 exit(1);
>         }
>
>         if ((count = read(fd, &minfo, sizeof(struct mshare_info)) > 0))
>                 printf("INFO: %ld bytes shared at addr 0x%lx \n",
>                                 minfo.size, minfo.start);
>         else
>                 perror("read failed");
>
>         close(fd);
>
>         addr = (void *)minfo.start;
>         err = syscall(MSHARE_SYSCALL, "testregion", addr, minfo.size,
>                         O_RDWR, 600);
>         if (err < 0) {
>                 perror("mshare() syscall failed");
>                 exit(1);
>         }
>
>         printf("Guest mmap at %px:\n", addr);
>         printf("%s\n", addr);
>         printf("\nDone\n");
>
>         err = syscall(MSHARE_UNLINK_SYSCALL, "testregion");
>         if (err < 0) {
>                 perror("mshare_unlink() failed");
>                 exit(1);
>         }
> -----------------


Does  that mean those shared pages will get page_mapcount()=1 ?

A big pain for a memory limited system like a desktop/embedded system is
that reverse mapping will take tons of cpu in memory reclamation path
especially for those pages mapped by multiple processes. sometimes,
100% cpu utilization on LRU to scan and find out if a page is accessed
by reading PTE young.

if we result in one PTE only by this patchset, it means we are getting
significant
performance improvement in kernel LRU particularly when free memory
approaches the watermarks.

But I don't see how a new system call like mshare(),  can be used
by those systems as they might need some more automatic PTEs sharing
mechanism.

BTW, I suppose we are actually able to share PTEs as long as the address
is 2MB aligned?

>
>
> Patch series
> ============
>
> This series of patches is an initial implementation of these two
> system calls. This code implements working basic functionality.
>
> Prototype for the two syscalls is:
>
> SYSCALL_DEFINE5(mshare, const char *, name, unsigned long, addr,
>                 unsigned long, len, int, oflag, mode_t, mode)
>
> SYSCALL_DEFINE1(mshare_unlink, const char *, name)
>
> In order to facilitate page table sharing, this implemntation adds a
> new in-memory filesystem - msharefs which will be mounted at
> /sys/fs/mshare. When a new mshare'd region is created, a file with
> the name given by initial mshare() call is created under this
> filesystem.  Permissions for this file are given by the "mode"
> parameter to mshare(). The only operation supported on this file is
> read. A read from this file returns a structure containing
> information about mshare'd region - (1) starting virtual address for
> the region, and (2) size of mshare'd region.
>
> A donor process that wants to create an mshare'd region from a
> section of its mapped addresses calls mshare() with O_CREAT oflag.
> mshare() syscall then creates a new mm_struct which will host the
> page tables for the mshare'd region.  vma->vm_private_data for the
> vmas covering address range for this region are updated to point to
> a structure containing pointer to this new mm_struct.  Existing page
> tables are copied over to new mm struct.
>
> A consumer process that wants to map mshare'd region opens
> /sys/fs/mshare/<filename> and reads the starting address and size of
> mshare'd region. It then calls mshare() with these values to map the
> entire region in its address space. Consumer process calls
> mshare_unlink() to terminate its access.
>
>
> Since RFC
> =========
>
> This patch series includes better error handling and more robust
> locking besides improved implementation of mshare since the original
> RFC. It also incorporates feedback from original RFC. Alignment and
> size requirment are PGDIR_SIZE, same as RFC and this is open to
> change based upon further feedback. More review is needed for this
> patch series and is much appreciated.
>
>
>
> Khalid Aziz (14):
>   mm: Add new system calls mshare, mshare_unlink
>   mm: Add msharefs filesystem
>   mm: Add read for msharefs
>   mm: implement mshare_unlink syscall
>   mm: Add locking to msharefs syscalls
>   mm/msharefs: Check for mounted filesystem
>   mm: Add vm flag for shared PTE
>   mm/mshare: Add basic page table sharing using mshare
>   mm: Do not free PTEs for mshare'd PTEs
>   mm/mshare: Check for mapped vma when mshare'ing existing mshare'd
>     range
>   mm/mshare: unmap vmas in mshare_unlink
>   mm/mshare: Add a proc file with mshare alignment/size information
>   mm/mshare: Enforce mshare'd region permissions
>   mm/mshare: Copy PTEs to host mm
>
>  Documentation/filesystems/msharefs.rst |  19 +
>  arch/x86/entry/syscalls/syscall_64.tbl |   2 +
>  include/linux/mm.h                     |  11 +
>  include/trace/events/mmflags.h         |   3 +-
>  include/uapi/asm-generic/unistd.h      |   7 +-
>  include/uapi/linux/magic.h             |   1 +
>  include/uapi/linux/mman.h              |   5 +
>  kernel/sysctl.c                        |   7 +
>  mm/Makefile                            |   2 +-
>  mm/internal.h                          |   7 +
>  mm/memory.c                            | 105 ++++-
>  mm/mshare.c                            | 587 +++++++++++++++++++++++++
>  12 files changed, 750 insertions(+), 6 deletions(-)
>  create mode 100644 Documentation/filesystems/msharefs.rst
>  create mode 100644 mm/mshare.c
>
> --
> 2.32.0
>

Thanks
Barry
