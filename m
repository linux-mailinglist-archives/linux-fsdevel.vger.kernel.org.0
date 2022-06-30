Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC6B95619B5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Jun 2022 13:57:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235173AbiF3L5Q (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 30 Jun 2022 07:57:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235167AbiF3L5P (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 30 Jun 2022 07:57:15 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4316A5A465;
        Thu, 30 Jun 2022 04:57:14 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id dw10-20020a17090b094a00b001ed00a16eb4so2596599pjb.2;
        Thu, 30 Jun 2022 04:57:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ssV3BijP819GyjFZBA03r3B0/BGXRwO+N1QrLHf0riE=;
        b=FcEcbf2+bJoSX1iwK4hNNtuMb0654YUXlfXG/xRN5T5axCiE2v4fkfK/8zrAGU8YCt
         5aurUNLExmvO3F0N/dd2wv8Im1beU/ZH6XWNevV+LZ7FfWSv59FdmiRWg+Dl40Yv/4FF
         RZfKJ4pu+66R5oXyJLwJguAgUOc+W10qiCHUD9xg5DP8UsrTtYmgJ7vh8k+Fp+VvkDDL
         V1c37xSJW82u82QO7aMuQSRIhG9NzkopXDOXl9bc9f78RxBGFs3qlFNROQZGR1b4172Q
         vIZ9t4sKiI38U37K9wOMRaXrSWAaPxS4z3YdrFVvV0ZYcQQYpfFpKuhZ4fKi7Pk57CeG
         v9sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ssV3BijP819GyjFZBA03r3B0/BGXRwO+N1QrLHf0riE=;
        b=WSfSqer8NQRyKVanoas5/jzs8tuJVJeErq2mCRMLuCiRmugWQ2R6tyBD2akUsZCYY+
         R1za09amBg+3m6x1VnPLJrXp6MdNkmLNZgjbeo2UW+0H4jGEQcGc7TMYFeI5yxPSPAOE
         5po3WilcaqqKNh7isfuuMVwZaOf03QLnamUSKhxz/si+xnX2sXUF7zfPc01xO/TAP5Gb
         uoMtAW5KLxT2vlrxmCfBhyZAvR+T7eru9QzoQdoYXzdWllS++EB9ihQFsAZNUgsjcgBJ
         aeTJz39Ig4wE3TYTNIy88xwJu+PPP65o3Hps3BXQRJxNeUFTEaO5fayz1s1ra8uRFV9O
         gNPA==
X-Gm-Message-State: AJIora+EnXUyCNN2HhmB/hxRsXqPzMlqnCZRmWx7UaVCPy2O23Mn7F9J
        uhxkRf15+zBULnXZQqU+S2VxBjXhfTyrBgBaBeQ=
X-Google-Smtp-Source: AGRyM1vyl+TrG19s+XDd/i6A759a/ZBIdLQHRy45NvDuoDk4NbKh4OiybR5wm6zwy4rSsjGq7htGFLyGfkFxEs1BWMg=
X-Received: by 2002:a17:90b:1810:b0:1ed:28dd:c215 with SMTP id
 lw16-20020a17090b181000b001ed28ddc215mr9824225pjb.18.1656590233763; Thu, 30
 Jun 2022 04:57:13 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1656531090.git.khalid.aziz@oracle.com>
In-Reply-To: <cover.1656531090.git.khalid.aziz@oracle.com>
From:   Mark Hemment <markhemm@googlemail.com>
Date:   Thu, 30 Jun 2022 12:57:02 +0100
Message-ID: <CANe_+Uj6RXw_X5Bv9_UkD_ngA_7haz3rqmbd2FAGzP1uHsxAfA@mail.gmail.com>
Subject: Re: [PATCH v2 0/9] Add support for shared PTEs across processes
To:     Khalid Aziz <khalid.aziz@oracle.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        aneesh.kumar@linux.ibm.com, arnd@arndb.de, 21cnbao@gmail.com,
        corbet@lwn.net, dave.hansen@linux.intel.com, david@redhat.com,
        ebiederm@xmission.com, hagen@jauu.net, jack@suse.cz,
        Kees Cook <keescook@chromium.org>, kirill@shutemov.name,
        kucharsk@gmail.com, linkinjeon@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linux-MM <linux-mm@kvack.org>, longpeng2@huawei.com,
        luto@kernel.org, pcc@google.com, rppt@kernel.org,
        sieberf@amazon.com, sjpark@amazon.de,
        Suren Baghdasaryan <surenb@google.com>, tst@schoebel-theuer.de,
        yzaikin@google.com
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

Hi Khalid,

On Wed, 29 Jun 2022 at 23:54, Khalid Aziz <khalid.aziz@oracle.com> wrote:
>
>
> Memory pages shared between processes require a page table entry
> (PTE) for each process. Each of these PTE consumes consume some of
> the memory and as long as number of mappings being maintained is
> small enough, this space consumed by page tables is not
> objectionable. When very few memory pages are shared between
> processes, the number of page table entries (PTEs) to maintain is
> mostly constrained by the number of pages of memory on the system.
> As the number of shared pages and the number of times pages are
> shared goes up, amount of memory consumed by page tables starts to
> become significant. This issue does not apply to threads. Any number
> of threads can share the same pages inside a process while sharing
> the same PTEs. Extending this same model to sharing pages across
> processes can eliminate this issue for sharing across processes as
> well.
>
> Some of the field deployments commonly see memory pages shared
> across 1000s of processes. On x86_64, each page requires a PTE that
> is only 8 bytes long which is very small compared to the 4K page
> size. When 2000 processes map the same page in their address space,
> each one of them requires 8 bytes for its PTE and together that adds
> up to 8K of memory just to hold the PTEs for one 4K page. On a
> database server with 300GB SGA, a system crash was seen with
> out-of-memory condition when 1500+ clients tried to share this SGA
> even though the system had 512GB of memory. On this server, in the
> worst case scenario of all 1500 processes mapping every page from
> SGA would have required 878GB+ for just the PTEs. If these PTEs
> could be shared, amount of memory saved is very significant.
>
> This patch series implements a mechanism in kernel to allow
> userspace processes to opt into sharing PTEs. It adds a new
> in-memory filesystem - msharefs. A file created on msharefs creates
> a new shared region where all processes sharing that region will
> share the PTEs as well. A process can create a new file on msharefs
> and then mmap it which assigns a starting address and size to this
> mshare'd region. Another process that has the right permission to
> open the file on msharefs can then mmap this file in its address
> space at same virtual address and size and share this region through
> shared PTEs. An unlink() on the file marks the mshare'd region for
> deletion once there are no more users of the region. When the mshare
> region is deleted, all the pages used by the region are freed.

  Noting the flexibility of 'mshare' has been reduced from v1.  The
earlier version allowed msharing of named mappings, while this patch
is only for anonymous mappings.
  Any plans to support named mappings?  If not, I guess *someone* will
want it (eventually).  Minor, as the patch does not introduce new
syscalls, but having an API which is flexible for both named and anon
mappings would be good (this is a nit, not a strong suggestion).

  The cover letter details the problem being solved and the API, but
gives no details of the implementation.  A paragraph on the use of a
mm_struct per-msharefs file would be helpful.

  I've only quickly scanned the patchset; not in enough detail to
comment on each patch, but a few observations.

  o I was expecting to see mprotect() against a mshared vma to either
be disallowed or code to support the splitting of a mshared vma.  I
didn't see either.

  o For the case where the mshare file has been closed/unmmap but not
unlinked, a 'mshare_data' structure will leaked when the inode is
evicted.

  o The alignment requirement is PGDIR_SIZE, which is very large.
Should/could this be PMD_SIZE?

  o mshare should be a conditional feature (CONFIG_MSHARE ?).


  I might get a chance do a finer grain review later/tomorrow.

> API
> ===
>
> mshare does not introduce a new API. It instead uses existing APIs
> to implement page table sharing. The steps to use this feature are:
>
> 1. Mount msharefs on /sys/fs/mshare -
>         mount -t msharefs msharefs /sys/fs/mshare
>
> 2. mshare regions have alignment and size requirements. Start
>    address for the region must be aligned to an address boundary and
>    be a multiple of fixed size. This alignment and size requirement
>    can be obtained by reading the file /sys/fs/mshare/mshare_info
>    which returns a number in text format. mshare regions must be
>    aligned to this boundary and be a multiple of this size.
>
> 3. For the process creating mshare region:
>         a. Create a file on /sys/fs/mshare, for example -
>                 fd = open("/sys/fs/mshare/shareme",
>                                 O_RDWR|O_CREAT|O_EXCL, 0600);
>
>         b. mmap this file to establish starting address and size -
>                 mmap((void *)TB(2), BUF_SIZE, PROT_READ | PROT_WRITE,
>                         MAP_SHARED, fd, 0);
>
>         c. Write and read to mshared region normally.
>
> 4. For processes attaching to mshare'd region:
>         a. Open the file on msharefs, for example -
>                 fd = open("/sys/fs/mshare/shareme", O_RDWR);
>
>         b. Get information about mshare'd region from the file:
>                 struct mshare_info {
>                         unsigned long start;
>                         unsigned long size;
>                 } m_info;
>
>                 read(fd, &m_info, sizeof(m_info));
>
>         c. mmap the mshare'd region -
>                 mmap(m_info.start, m_info.size,
>                         PROT_READ | PROT_WRITE, MAP_SHARED, fd, 0);
>
> 5. To delete the mshare region -
>                 unlink("/sys/fs/mshare/shareme");
>
>
>
> Example Code
> ============
>
> Snippet of the code that a donor process would run looks like below:
>
> -----------------
>         fd = open("/sys/fs/mshare/mshare_info", O_RDONLY);
>         read(fd, req, 128);
>         alignsize = atoi(req);
>         close(fd);
>         fd = open("/sys/fs/mshare/shareme", O_RDWR|O_CREAT|O_EXCL, 0600);
>         start = alignsize * 4;
>         size = alignsize * 2;
>         addr = mmap((void *)start, size, PROT_READ | PROT_WRITE,
>                         MAP_SHARED | MAP_ANONYMOUS, 0, 0);

Typo, missing 'fd'; MAP_SHARED | MAP_ANONYMOUS, fd, 0)

>         if (addr == MAP_FAILED)
>                 perror("ERROR: mmap failed");
>
>         strncpy(addr, "Some random shared text",
>                         sizeof("Some random shared text"));
> -----------------
>
>
> Snippet of code that a consumer process would execute looks like:
>
> -----------------
>         struct mshare_info {
>                 unsigned long start;
>                 unsigned long size;
>         } minfo;
>
>
>         fd = open("/sys/fs/mshare/shareme", O_RDONLY);
>
>         if ((count = read(fd, &minfo, sizeof(struct mshare_info)) > 0))
>                 printf("INFO: %ld bytes shared at addr 0x%lx \n",
>                                 minfo.size, minfo.start);
>
>         addr = mmap(minfo.start, minfo.size, PROT_READ | PROT_WRITE,
>                         MAP_SHARED, fd, 0);
>
>         printf("Guest mmap at %px:\n", addr);
>         printf("%s\n", addr);
>         printf("\nDone\n");
>
> -----------------
>
>
>
> v1 -> v2:
>         - Eliminated mshare and mshare_unlink system calls and
>           replaced API with standard mmap and unlink (Based upon
>           v1 patch discussions and LSF/MM discussions)
>         - All fd based API (based upon feedback and suggestions from
>           Andy Lutomirski, Eric Biederman, Kirill and others)
>         - Added a file /sys/fs/mshare/mshare_info to provide
>           alignment and size requirement info (based upon feedback
>           from Dave Hansen, Mark Hemment and discussions at LSF/MM)
>         - Addressed TODOs in v1
>         - Added support for directories in msharefs
>         - Added locks around any time vma is touched (Dave Hansen)
>         - Eliminated the need to point vm_mm in original vmas to the
>           newly synthesized mshare mm
>         - Ensured mmap_read_unlock is called for correct mm in
>           handle_mm_fault (Dave Hansen)
>
> Khalid Aziz (9):
>   mm: Add msharefs filesystem
>   mm/mshare: pre-populate msharefs with information file
>   mm/mshare: make msharefs writable and support directories
>   mm/mshare: Add a read operation for msharefs files
>   mm/mshare: Add vm flag for shared PTE
>   mm/mshare: Add mmap operation
>   mm/mshare: Add unlink and munmap support
>   mm/mshare: Add basic page table sharing support
>   mm/mshare: Enable mshare region mapping across processes
>
>  Documentation/filesystems/msharefs.rst |  19 +
>  include/linux/mm.h                     |  10 +
>  include/trace/events/mmflags.h         |   3 +-
>  include/uapi/linux/magic.h             |   1 +
>  include/uapi/linux/mman.h              |   5 +
>  mm/Makefile                            |   2 +-
>  mm/internal.h                          |   7 +
>  mm/memory.c                            | 101 ++++-
>  mm/mshare.c                            | 575 +++++++++++++++++++++++++
>  9 files changed, 719 insertions(+), 4 deletions(-)
>  create mode 100644 Documentation/filesystems/msharefs.rst
>  create mode 100644 mm/mshare.c
>
> --
> 2.32.0

Cheers,
Mark
