Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABB0B698B96
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Feb 2023 06:14:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229528AbjBPFOV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 Feb 2023 00:14:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjBPFOT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 Feb 2023 00:14:19 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD2EB3E095;
        Wed, 15 Feb 2023 21:14:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5F28361E79;
        Thu, 16 Feb 2023 05:14:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57DFEC433EF;
        Thu, 16 Feb 2023 05:14:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676524457;
        bh=5bN2qNXzQ4ZA0g4le+lak/ncOAC6JWfVkeV3mS7J638=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=S6DhiGdHj1JDcPoZ1SfQW0UbLyKedojDvkeLmMsMmBwPwm5Yt9ALPyAEdUcNs/Kri
         y0wdQjtRgesQPv1yH4KbX2jBYemiOzTpuPf+dczvYxTVGZ2quVV8mTHQhPE8aLG4e7
         DXI8KPzfDbQEhul6FRH1xmCTTBptlv18inIYrE3lZPKsxHrObglGNVUJjYWLJw+yRh
         qLoEV/M0+FXsR2Yyl4A/8ONxeFBM4nRHoCK+SPySEBCED0DLIe2fRJWz1w55/Uvg/l
         XxPsCan76eLvTZglTKRcCOa4i7hQJI9KrgiS2Iu63uqvrH8MGX/DwoTfVEw+ty44Xp
         JVI04vumpZNTw==
Date:   Thu, 16 Feb 2023 07:13:53 +0200
From:   Mike Rapoport <rppt@kernel.org>
To:     Chao Peng <chao.p.peng@linux.intel.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-api@vger.kernel.org,
        linux-doc@vger.kernel.org, qemu-devel@nongnu.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Miaohe Lin <linmiaohe@huawei.com>, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>, Hugh Dickins <hughd@google.com>,
        Jeff Layton <jlayton@kernel.org>,
        "J . Bruce Fields" <bfields@fieldses.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>,
        Steven Price <steven.price@arm.com>,
        "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
        Vlastimil Babka <vbabka@suse.cz>,
        Vishal Annapurve <vannapurve@google.com>,
        Yu Zhang <yu.c.zhang@linux.intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        luto@kernel.org, jun.nakajima@intel.com, dave.hansen@intel.com,
        ak@linux.intel.com, david@redhat.com, aarcange@redhat.com,
        ddutile@redhat.com, dhildenb@redhat.com,
        Quentin Perret <qperret@google.com>, tabba@google.com,
        Michael Roth <michael.roth@amd.com>, mhocko@suse.com,
        wei.w.wang@intel.com
Subject: Re: [PATCH v10 0/9] KVM: mm: fd-based approach for supporting KVM
Message-ID: <Y+27kRxJoXlMcbtH@kernel.org>
References: <20221202061347.1070246-1-chao.p.peng@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221202061347.1070246-1-chao.p.peng@linux.intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

On Fri, Dec 02, 2022 at 02:13:38PM +0800, Chao Peng wrote:
> This patch series implements KVM guest private memory for confidential
> computing scenarios like Intel TDX[1]. If a TDX host accesses
> TDX-protected guest memory, machine check can happen which can further
> crash the running host system, this is terrible for multi-tenant
> configurations. The host accesses include those from KVM userspace like
> QEMU. This series addresses KVM userspace induced crash by introducing
> new mm and KVM interfaces so KVM userspace can still manage guest memory
> via a fd-based approach, but it can never access the guest memory
> content.

Sorry for jumping late.

Unless I'm missing something, hibernation will also cause an machine check
when there is TDX-protected memory in the system. When the hibernation
creates memory snapshot it essentially walks all physical pages and saves
their contents, so for TDX memory this will trigger machine check, right?
 
>  Documentation/virt/kvm/api.rst         | 125 ++++++-
>  arch/x86/entry/syscalls/syscall_32.tbl |   1 +
>  arch/x86/entry/syscalls/syscall_64.tbl |   1 +
>  arch/x86/include/asm/kvm_host.h        |   9 +
>  arch/x86/kvm/Kconfig                   |   3 +
>  arch/x86/kvm/mmu/mmu.c                 | 205 ++++++++++-
>  arch/x86/kvm/mmu/mmu_internal.h        |  14 +-
>  arch/x86/kvm/mmu/mmutrace.h            |   1 +
>  arch/x86/kvm/mmu/tdp_mmu.c             |   2 +-
>  arch/x86/kvm/x86.c                     |  17 +-
>  include/linux/kvm_host.h               | 103 +++++-
>  include/linux/restrictedmem.h          |  71 ++++
>  include/linux/syscalls.h               |   1 +
>  include/uapi/asm-generic/unistd.h      |   5 +-
>  include/uapi/linux/kvm.h               |  53 +++
>  include/uapi/linux/magic.h             |   1 +
>  kernel/sys_ni.c                        |   3 +
>  mm/Kconfig                             |   4 +
>  mm/Makefile                            |   1 +
>  mm/memory-failure.c                    |   3 +
>  mm/restrictedmem.c                     | 318 +++++++++++++++++
>  virt/kvm/Kconfig                       |   6 +
>  virt/kvm/kvm_main.c                    | 469 +++++++++++++++++++++----
>  23 files changed, 1323 insertions(+), 93 deletions(-)
>  create mode 100644 include/linux/restrictedmem.h
>  create mode 100644 mm/restrictedmem.c

-- 
Sincerely yours,
Mike.
