Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 529575379AB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 May 2022 13:19:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233726AbiE3LS7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 30 May 2022 07:18:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233379AbiE3LS6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 30 May 2022 07:18:58 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1446D1CB0F
        for <linux-fsdevel@vger.kernel.org>; Mon, 30 May 2022 04:18:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1653909536;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wEJh1v0yLYrSJEztMDHMWNNVxRvZnSx1mwbtnZON0mc=;
        b=F0eD5cBBLXa5ml3E4vgpDLAbZ/Ny9T5lio+m/f3f+8TGyRbs7DH85cpUM1IhL7rASnQ8qY
        Xev9qhzlIoUVezxx1JbA5y46yYA+NwB+ZEHqyMNWPdOnX7miVitLMjjHQG2UMizg9fIzOS
        mn9zemIzZDPbGyADvw2HgSYAIQUsIkU=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-378-TPQN5JRbNNKOeJKJK8wNbw-1; Mon, 30 May 2022 07:18:54 -0400
X-MC-Unique: TPQN5JRbNNKOeJKJK8wNbw-1
Received: by mail-wm1-f69.google.com with SMTP id o3-20020a05600c510300b0039743540ac7so4412855wms.5
        for <linux-fsdevel@vger.kernel.org>; Mon, 30 May 2022 04:18:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:organization:subject
         :in-reply-to:content-transfer-encoding;
        bh=wEJh1v0yLYrSJEztMDHMWNNVxRvZnSx1mwbtnZON0mc=;
        b=YeW0dPkGMQenMmvZlywxbts7yht/DwBx3S8bDQdax7j3ep4tQzXloFzdrpcmowfSh9
         QcuTHrlI9BXOAteDBLnbdUzREEyU7LnUH4h+1gjKSFzcBLMZnet6HE9lpqMy2McwuyKT
         DOBnRfH2P9ImPDuAZ98t+fWX1GQ0b+uY1ggm+IoUGAeK98oAog+XI3LPwlLqWok6AM0s
         Pmg0Z4jXPBKHVjXTjo5Nxtdd922y1h+EVrWvqGCoPXzLCVEoK8Pjgvk7gHsHE1xbVnbT
         pEWvooYNuG5iIHUUhWTH3ql7fM0AHm80MClVvbwm/2pxi+6CBKY2OLhUghVTMMR9T5Gu
         DgrQ==
X-Gm-Message-State: AOAM533bkyJEAq5Ti0BrEgohUl0A1rt136IDb0W4pegraWtEeTp2CNwb
        HDmVE76ig6WDp+BH68uO6oxy5HlP55ExNt4+PuPtyBG0yy/8v+oZ06LYtekO8Cciu/bnB1dWR7m
        6c3c/sfCyrLvk4nSdfO8lKGV6GQ==
X-Received: by 2002:a5d:42c6:0:b0:210:28d4:428e with SMTP id t6-20020a5d42c6000000b0021028d4428emr8771524wrr.656.1653909533620;
        Mon, 30 May 2022 04:18:53 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz4SCvlVorH7XhVUqk5VCMW1In5HEL8g6G5SaYE+tD5YzSnK2c4QB/yCmPf0uA2yyfXAYNkxw==
X-Received: by 2002:a5d:42c6:0:b0:210:28d4:428e with SMTP id t6-20020a5d42c6000000b0021028d4428emr8771480wrr.656.1653909533220;
        Mon, 30 May 2022 04:18:53 -0700 (PDT)
Received: from ?IPV6:2003:cb:c704:7c00:aaa9:2ce5:5aa0:f736? (p200300cbc7047c00aaa92ce55aa0f736.dip0.t-ipconnect.de. [2003:cb:c704:7c00:aaa9:2ce5:5aa0:f736])
        by smtp.gmail.com with ESMTPSA id m3-20020a5d6243000000b0020cd8f1d25csm8957554wrv.8.2022.05.30.04.18.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 May 2022 04:18:52 -0700 (PDT)
Message-ID: <55109e8f-29b8-4016-dcee-28eb8a70bd12@redhat.com>
Date:   Mon, 30 May 2022 13:18:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Content-Language: en-US
To:     Barry Song <21cnbao@gmail.com>,
        Khalid Aziz <khalid.aziz@oracle.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
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
References: <cover.1649370874.git.khalid.aziz@oracle.com>
 <CAGsJ_4yXnmifuU7+BFOkZrz-7AkW4CDQF5cHqQS-oci-rJ=ZdA@mail.gmail.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v1 00/14] Add support for shared PTEs across processes
In-Reply-To: <CAGsJ_4yXnmifuU7+BFOkZrz-7AkW4CDQF5cHqQS-oci-rJ=ZdA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 30.05.22 12:48, Barry Song wrote:
> On Tue, Apr 12, 2022 at 4:07 AM Khalid Aziz <khalid.aziz@oracle.com> wrote:
>>
>> Page tables in kernel consume some of the memory and as long as number
>> of mappings being maintained is small enough, this space consumed by
>> page tables is not objectionable. When very few memory pages are
>> shared between processes, the number of page table entries (PTEs) to
>> maintain is mostly constrained by the number of pages of memory on the
>> system. As the number of shared pages and the number of times pages
>> are shared goes up, amount of memory consumed by page tables starts to
>> become significant.
>>
>> Some of the field deployments commonly see memory pages shared across
>> 1000s of processes. On x86_64, each page requires a PTE that is only 8
>> bytes long which is very small compared to the 4K page size. When 2000
>> processes map the same page in their address space, each one of them
>> requires 8 bytes for its PTE and together that adds up to 8K of memory
>> just to hold the PTEs for one 4K page. On a database server with 300GB
>> SGA, a system carsh was seen with out-of-memory condition when 1500+
>> clients tried to share this SGA even though the system had 512GB of
>> memory. On this server, in the worst case scenario of all 1500
>> processes mapping every page from SGA would have required 878GB+ for
>> just the PTEs. If these PTEs could be shared, amount of memory saved
>> is very significant.
>>
>> This patch series implements a mechanism in kernel to allow userspace
>> processes to opt into sharing PTEs. It adds two new system calls - (1)
>> mshare(), which can be used by a process to create a region (we will
>> call it mshare'd region) which can be used by other processes to map
>> same pages using shared PTEs, (2) mshare_unlink() which is used to
>> detach from the mshare'd region. Once an mshare'd region is created,
>> other process(es), assuming they have the right permissions, can make
>> the mashare() system call to map the shared pages into their address
>> space using the shared PTEs.  When a process is done using this
>> mshare'd region, it makes a mshare_unlink() system call to end its
>> access. When the last process accessing mshare'd region calls
>> mshare_unlink(), the mshare'd region is torn down and memory used by
>> it is freed.
>>
>>
>> API
>> ===
>>
>> The mshare API consists of two system calls - mshare() and mshare_unlink()
>>
>> --
>> int mshare(char *name, void *addr, size_t length, int oflags, mode_t mode)
>>
>> mshare() creates and opens a new, or opens an existing mshare'd
>> region that will be shared at PTE level. "name" refers to shared object
>> name that exists under /sys/fs/mshare. "addr" is the starting address
>> of this shared memory area and length is the size of this area.
>> oflags can be one of:
>>
>> - O_RDONLY opens shared memory area for read only access by everyone
>> - O_RDWR opens shared memory area for read and write access
>> - O_CREAT creates the named shared memory area if it does not exist
>> - O_EXCL If O_CREAT was also specified, and a shared memory area
>>   exists with that name, return an error.
>>
>> mode represents the creation mode for the shared object under
>> /sys/fs/mshare.
>>
>> mshare() returns an error code if it fails, otherwise it returns 0.
>>
>> PTEs are shared at pgdir level and hence it imposes following
>> requirements on the address and size given to the mshare():
>>
>> - Starting address must be aligned to pgdir size (512GB on x86_64).
>>   This alignment value can be looked up in /proc/sys/vm//mshare_size
>> - Size must be a multiple of pgdir size
>> - Any mappings created in this address range at any time become
>>   shared automatically
>> - Shared address range can have unmapped addresses in it. Any access
>>   to unmapped address will result in SIGBUS
>>
>> Mappings within this address range behave as if they were shared
>> between threads, so a write to a MAP_PRIVATE mapping will create a
>> page which is shared between all the sharers. The first process that
>> declares an address range mshare'd can continue to map objects in
>> the shared area. All other processes that want mshare'd access to
>> this memory area can do so by calling mshare(). After this call, the
>> address range given by mshare becomes a shared range in its address
>> space. Anonymous mappings will be shared and not COWed.
>>
>> A file under /sys/fs/mshare can be opened and read from. A read from
>> this file returns two long values - (1) starting address, and (2)
>> size of the mshare'd region.
>>
>> --
>> int mshare_unlink(char *name)
>>
>> A shared address range created by mshare() can be destroyed using
>> mshare_unlink() which removes the  shared named object. Once all
>> processes have unmapped the shared object, the shared address range
>> references are de-allocated and destroyed.
>>
>> mshare_unlink() returns 0 on success or -1 on error.
>>
>>
>> Example Code
>> ============
>>
>> Snippet of the code that a donor process would run looks like below:
>>
>> -----------------
>>         addr = mmap((void *)TB(2), GB(512), PROT_READ | PROT_WRITE,
>>                         MAP_SHARED | MAP_ANONYMOUS, 0, 0);
>>         if (addr == MAP_FAILED)
>>                 perror("ERROR: mmap failed");
>>
>>         err = syscall(MSHARE_SYSCALL, "testregion", (void *)TB(2),
>>                         GB(512), O_CREAT|O_RDWR|O_EXCL, 600);
>>         if (err < 0) {
>>                 perror("mshare() syscall failed");
>>                 exit(1);
>>         }
>>
>>         strncpy(addr, "Some random shared text",
>>                         sizeof("Some random shared text"));
>> -----------------
>>
>> Snippet of code that a consumer process would execute looks like:
>>
>> -----------------
>>         struct mshare_info minfo;
>>
>>         fd = open("testregion", O_RDONLY);
>>         if (fd < 0) {
>>                 perror("open failed");
>>                 exit(1);
>>         }
>>
>>         if ((count = read(fd, &minfo, sizeof(struct mshare_info)) > 0))
>>                 printf("INFO: %ld bytes shared at addr 0x%lx \n",
>>                                 minfo.size, minfo.start);
>>         else
>>                 perror("read failed");
>>
>>         close(fd);
>>
>>         addr = (void *)minfo.start;
>>         err = syscall(MSHARE_SYSCALL, "testregion", addr, minfo.size,
>>                         O_RDWR, 600);
>>         if (err < 0) {
>>                 perror("mshare() syscall failed");
>>                 exit(1);
>>         }
>>
>>         printf("Guest mmap at %px:\n", addr);
>>         printf("%s\n", addr);
>>         printf("\nDone\n");
>>
>>         err = syscall(MSHARE_UNLINK_SYSCALL, "testregion");
>>         if (err < 0) {
>>                 perror("mshare_unlink() failed");
>>                 exit(1);
>>         }
>> -----------------
> 
> 
> Does  that mean those shared pages will get page_mapcount()=1 ?

AFAIU, for mshare() that is the case.

> 
> A big pain for a memory limited system like a desktop/embedded system is
> that reverse mapping will take tons of cpu in memory reclamation path
> especially for those pages mapped by multiple processes. sometimes,
> 100% cpu utilization on LRU to scan and find out if a page is accessed
> by reading PTE young.

Regarding PTE-table sharing:

Even if we'd account each logical mapping (independent of page table
sharing) in the page_mapcount(), we would benefit from page table
sharing. Simply when we unmap the page from the shared page table, we'd
have to adjust the mapcount accordingly. So unmapping from a single
(shared) pagetable could directly result in the mapcount dropping to zero.

What I am trying to say is: how the mapcount is handled might be an
implementation detail for PTE-sharing. Not sure how hugetlb handles that
with its PMD-table sharing.

We'd have to clarify what the mapcount actually expresses. Having the
mapcount express "is this page mapped by multiple processes or at
multiple VMAs" might be helpful in some cases. Right now it mostly
expresses exactly that.

> 
> if we result in one PTE only by this patchset, it means we are getting
> significant
> performance improvement in kernel LRU particularly when free memory
> approaches the watermarks.
> 
> But I don't see how a new system call like mshare(),  can be used
> by those systems as they might need some more automatic PTEs sharing
> mechanism.

IMHO, we should look into automatic PTE-table sharing of MAP_SHARED
mappings, similar to what hugetlb provides for PMD table sharing, which
leaves semantics unchanged for existing user space. Maybe there is a way
to factor that out and reuse it for PTE-table sharing.

I can understand that there are use cases for explicit sharing with new
(e.g., mprotect) semantics.

> 
> BTW, I suppose we are actually able to share PTEs as long as the address
> is 2MB aligned?

2MB is x86 specific, but yes. As long as we're aligned to PMDs and
* the VMA spans the complete PMD
* the VMA permissions match the page table
* no process-specific page table features are used (uffd, softdirty
  tracking)

... probably there are more corner cases. (e.g., referenced and dirty
bit don't reflect what the mapping process did, which might or might not
be relevant for current/future features)

-- 
Thanks,

David / dhildenb

