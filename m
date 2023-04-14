Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A3DB6E1CB6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Apr 2023 08:33:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230030AbjDNGdR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 14 Apr 2023 02:33:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229989AbjDNGdP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 14 Apr 2023 02:33:15 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4369455B4;
        Thu, 13 Apr 2023 23:33:10 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id D950D219BF;
        Fri, 14 Apr 2023 06:33:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1681453988; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xslQPF17zT9apx+cU2US+PpxMshzU35IKYkk2wpIDLg=;
        b=DJN+y564b8swWIzIhMyoJZmTzvSqa6m/5QtSbnrPb54+xfDbvOpGA38sWt+1Iy8fdfPh8j
        /+hfnbGVW18WolgOUyQInIsmtDRk1oPV2dCNEN5y/6IV7iJSpAtkQDgSz9Z+XWZ5eKGQbL
        /2OIoGOXmGQ9yUAigxFE1FWMOYCh4zM=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B0322139FC;
        Fri, 14 Apr 2023 06:33:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id YpWfKqTzOGQiNgAAMHmgww
        (envelope-from <mhocko@suse.com>); Fri, 14 Apr 2023 06:33:08 +0000
Date:   Fri, 14 Apr 2023 08:33:08 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Ackerley Tng <ackerleytng@google.com>
Cc:     kvm@vger.kernel.org, linux-api@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, qemu-devel@nongnu.org, aarcange@redhat.com,
        ak@linux.intel.com, akpm@linux-foundation.org, arnd@arndb.de,
        bfields@fieldses.org, bp@alien8.de, chao.p.peng@linux.intel.com,
        corbet@lwn.net, dave.hansen@intel.com, david@redhat.com,
        ddutile@redhat.com, dhildenb@redhat.com, hpa@zytor.com,
        hughd@google.com, jlayton@kernel.org, jmattson@google.com,
        joro@8bytes.org, jun.nakajima@intel.com,
        kirill.shutemov@linux.intel.com, linmiaohe@huawei.com,
        luto@kernel.org, mail@maciej.szmigiero.name, michael.roth@amd.com,
        mingo@redhat.com, naoya.horiguchi@nec.com, pbonzini@redhat.com,
        qperret@google.com, rppt@kernel.org, seanjc@google.com,
        shuah@kernel.org, steven.price@arm.com, tabba@google.com,
        tglx@linutronix.de, vannapurve@google.com, vbabka@suse.cz,
        vkuznets@redhat.com, wanpengli@tencent.com, wei.w.wang@intel.com,
        x86@kernel.org, yu.c.zhang@linux.intel.com, muchun.song@linux.dev,
        feng.tang@intel.com, brgerst@gmail.com, rdunlap@infradead.org,
        masahiroy@kernel.org, mailhol.vincent@wanadoo.fr
Subject: Re: [RFC PATCH 0/6] Setting memory policy for restrictedmem file
Message-ID: <ZDjzpKL9Omcox991@dhcp22.suse.cz>
References: <cover.1681430907.git.ackerleytng@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1681430907.git.ackerleytng@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri 14-04-23 00:11:49, Ackerley Tng wrote:
> Hello,
> 
> This patchset builds upon the memfd_restricted() system call that was
> discussed in the 'KVM: mm: fd-based approach for supporting KVM' patch
> series [1].
> 
> The tree can be found at:
> https://github.com/googleprodkernel/linux-cc/tree/restrictedmem-set-memory-policy
> 
> In this patchset, a new syscall is introduced, which allows userspace
> to set the memory policy (e.g. NUMA bindings) for a restrictedmem
> file, to the granularity of offsets within the file.
> 
> The offset/length tuple is termed a file_range which is passed to the
> kernel via a pointer to get around the limit of 6 arguments for a
> syscall.
> 
> The following other approaches were also considered:
> 
> 1. Pre-configuring a mount with a memory policy and providing that
>    mount to memfd_restricted() as proposed at [2].
>     + Pro: It allows choice of a specific backing mount with custom
>       memory policy configurations
>     + Con: Will need to create an entire new mount just to set memory
>       policy for a restrictedmem file; files on the same mount cannot
>       have different memory policies.

Could you expand on this some more please? How many restricted
files/mounts do we expect? My understanding was that this would be
essentially a backing store for guest memory so it would scale with the
number of guests.

> 2. Passing memory policy to the memfd_restricted() syscall at creation time.
>     + Pro: Only need to make a single syscall to create a file with a
>       given memory policy
>     + Con: At creation time, the kernel doesn’t know the size of the
>       restrictedmem file. Given that memory policy is stored in the
>       inode based on ranges (start, end), it is awkward for the kernel
>       to store the memory policy and then add hooks to set the memory
>       policy when allocation is done.
> 
> 3. A more generic fbind(): it seems like this new functionality is
>    really only needed for restrictedmem files, hence a separate,
>    specific syscall was proposed to avoid complexities with handling
>    conflicting policies that may be specified via other syscalls like
>    mbind()

I do not think it is a good idea to make the syscall restrict mem
specific. History shows that users are much more creative when it comes
to usecases than us. I do understand that the nature of restricted
memory is that it is not mapable but memory policies without a mapping
are a reasonable concept in genereal. After all this just tells where
the memory should be allocated from. Do we need to implement that for
any other fs? No, you can safely return EINVAL for anything but
memfd_restricted fd for now but you shouldn't limit usecases upfront.

> 
> TODOs

How do you query a policy for the specific fd? Are there any plans to
add a syscall for that as well but you just wait for the direction for
the set method?

> + Return -EINVAL if file_range is not within the size of the file and
>   tests for this
> 
> Dependencies:
> 
> + Chao’s work on UPM [3]
> 
> [1] https://lore.kernel.org/lkml/20221202061347.1070246-1-chao.p.peng@linux.intel.com/T/
> [2] https://lore.kernel.org/lkml/cover.1681176340.git.ackerleytng@google.com/T/
> [3] https://github.com/chao-p/linux/commits/privmem-v11.5
> 
> ---
> 
> Ackerley Tng (6):
>   mm: shmem: Refactor out shmem_shared_policy() function
>   mm: mempolicy: Refactor out mpol_init_from_nodemask
>   mm: mempolicy: Refactor out __mpol_set_shared_policy()
>   mm: mempolicy: Add and expose mpol_create
>   mm: restrictedmem: Add memfd_restricted_bind() syscall
>   selftests: mm: Add selftest for memfd_restricted_bind()
> 
>  arch/x86/entry/syscalls/syscall_32.tbl        |   1 +
>  arch/x86/entry/syscalls/syscall_64.tbl        |   1 +
>  include/linux/mempolicy.h                     |   4 +
>  include/linux/shmem_fs.h                      |   7 +
>  include/linux/syscalls.h                      |   5 +
>  include/uapi/asm-generic/unistd.h             |   5 +-
>  include/uapi/linux/mempolicy.h                |   7 +-
>  kernel/sys_ni.c                               |   1 +
>  mm/mempolicy.c                                | 100 ++++++++++---
>  mm/restrictedmem.c                            |  75 ++++++++++
>  mm/shmem.c                                    |  10 +-
>  scripts/checksyscalls.sh                      |   1 +
>  tools/testing/selftests/mm/.gitignore         |   1 +
>  tools/testing/selftests/mm/Makefile           |   8 +
>  .../selftests/mm/memfd_restricted_bind.c      | 139 ++++++++++++++++++
>  .../mm/restrictedmem_testmod/Makefile         |  21 +++
>  .../restrictedmem_testmod.c                   |  89 +++++++++++
>  tools/testing/selftests/mm/run_vmtests.sh     |   6 +
>  18 files changed, 454 insertions(+), 27 deletions(-)
>  create mode 100644 tools/testing/selftests/mm/memfd_restricted_bind.c
>  create mode 100644 tools/testing/selftests/mm/restrictedmem_testmod/Makefile
>  create mode 100644 tools/testing/selftests/mm/restrictedmem_testmod/restrictedmem_testmod.c
> 
> --
> 2.40.0.634.g4ca3ef3211-goog

-- 
Michal Hocko
SUSE Labs
