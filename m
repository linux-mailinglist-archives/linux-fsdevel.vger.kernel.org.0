Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36AF15108FA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Apr 2022 21:29:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354220AbiDZTcQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 Apr 2022 15:32:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354213AbiDZTcK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 26 Apr 2022 15:32:10 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A415C12CC
        for <linux-fsdevel@vger.kernel.org>; Tue, 26 Apr 2022 12:28:47 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id y21so11866096wmi.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 26 Apr 2022 12:28:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iQFCk4jvRcDNbkwKt80r8M9Ev1zqOHCdGqGh5NtELGk=;
        b=kXX2A5pPeYzQ7cMHjUay8+MRco1JY+qcFRaRS08NAVmtfBRdvFVDmNjStpeUWkd6Zl
         vQU5f0FWDf6xsz3RbldyIy9/g5QXdZSQZuDeQifodlFGCf1YGsKpdQYyR2g9y7Y6oB7V
         /fsu0vO21DVFRug79wN6ff9wbCwuMNbpj0fPxn9wyJ+3cQTLW9PimSQ9f6xgnaxtH2fO
         AlrXyAXCzlK49e6n1Ju/HDLsl9jTbgxFH3GdBJYGeSidfswDSkOpdP8/KDLnQJLtqZUp
         IpGuwUWRrQLmAANIliRHGcWrJVnvTEjLAdmNwn2651HlpB30PBm/qWLfwGYSI3Qrg/mB
         i7nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iQFCk4jvRcDNbkwKt80r8M9Ev1zqOHCdGqGh5NtELGk=;
        b=Qpr2uehbdzR4m9JwCHFNG2q8d0qx4z+yPjMwxXAvhWg6xxF7+3837kXjXr+kdMobhM
         x+K3aMNgkanOe/gI56E2H1JyGWaAojPVTyCDUp8gm/jgO8F8kETxugvJ3WiJrKK46TsG
         GaG+H/71KeQSNGOFJgrnAex25loLe9pwACeUVzRPzCf1DQD1kVpgGjtxbb2vTZ9LX/if
         oOmOmc4oVd6Aq7AlSQJc389tGDyD0hZFaCxjL6LUPS2bgp5Xi3XDNAMg21VNedhr3Nbu
         2gnwErKlKpOjHQwggB1Pb7zFWhhbwUxBi07CK51Y1KLOduPTSL25aLNJQdg2g7GZnwBb
         A4Dg==
X-Gm-Message-State: AOAM533eLUg9XEZsK1S/zbugN75f0ckDC4gk5FKItdTUbJUmcn9pgqVM
        qvSu254uJv8LHLC4sR3ryt13nzzJ/S3NmjuVl9IrUw==
X-Google-Smtp-Source: ABdhPJxE4uF7k63kUhII0yfWNs5hqWLsW6+10S6JtH7VxMkI6vG6IvE9QqtG19aVEP77InoCW4FL0NJd1Gr2ps0f3PU=
X-Received: by 2002:a05:600c:1c90:b0:393:e5b9:b567 with SMTP id
 k16-20020a05600c1c9000b00393e5b9b567mr16137822wms.27.1651001314470; Tue, 26
 Apr 2022 12:28:34 -0700 (PDT)
MIME-Version: 1.0
References: <20220426053904.3684293-1-yosryahmed@google.com>
 <20220426053904.3684293-5-yosryahmed@google.com> <YmegoB/fBkfwaE5z@google.com>
In-Reply-To: <YmegoB/fBkfwaE5z@google.com>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Tue, 26 Apr 2022 12:27:57 -0700
Message-ID: <CAJD7tkY-WZKcyer=TbWF0dVfOhvZO7hqPN=AYCDZe1f+2HA-QQ@mail.gmail.com>
Subject: Re: [PATCH v3 4/6] KVM: arm64/mmu: count KVM page table pages in
 pagetable stats
To:     Oliver Upton <oupton@google.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Huacai Chen <chenhuacai@kernel.org>,
        Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
        Anup Patel <anup@brainfault.org>,
        Atish Patra <atishp@atishpatra.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        James Morse <james.morse@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
        Marc Zyngier <maz@kernel.org>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        linux-mips@vger.kernel.org, kvm@vger.kernel.org,
        kvm-riscv@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, Linux-MM <linux-mm@kvack.org>,
        cgroups@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kvmarm@lists.cs.columbia.edu
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Oliver,
Thanks so much for taking the time to take a look at this!

On Tue, Apr 26, 2022 at 12:35 AM Oliver Upton <oupton@google.com> wrote:
>
> Hi Yosry,
>
> On Tue, Apr 26, 2022 at 05:39:02AM +0000, Yosry Ahmed wrote:
> > Count the pages used by KVM in arm64 for page tables in pagetable stats.
> >
> > Account pages allocated for PTEs in pgtable init functions and
> > kvm_set_table_pte().
> >
> > Since most page table pages are freed using put_page(), add a helper
> > function put_pte_page() that checks if this is the last ref for a pte
> > page before putting it, and unaccounts stats accordingly.
> >
> > Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
> > ---
> >  arch/arm64/kernel/image-vars.h |  3 ++
> >  arch/arm64/kvm/hyp/pgtable.c   | 50 +++++++++++++++++++++-------------
> >  2 files changed, 34 insertions(+), 19 deletions(-)
> >
> > diff --git a/arch/arm64/kernel/image-vars.h b/arch/arm64/kernel/image-vars.h
> > index 241c86b67d01..25bf058714f6 100644
> > --- a/arch/arm64/kernel/image-vars.h
> > +++ b/arch/arm64/kernel/image-vars.h
> > @@ -143,6 +143,9 @@ KVM_NVHE_ALIAS(__hyp_rodata_end);
> >  /* pKVM static key */
> >  KVM_NVHE_ALIAS(kvm_protected_mode_initialized);
> >
> > +/* Called by kvm_account_pgtable_pages() to update pagetable stats */
> > +KVM_NVHE_ALIAS(__mod_lruvec_page_state);
> > +
> >  #endif /* CONFIG_KVM */
> >
> >  #endif /* __ARM64_KERNEL_IMAGE_VARS_H */
> > diff --git a/arch/arm64/kvm/hyp/pgtable.c b/arch/arm64/kvm/hyp/pgtable.c
> > index 2cb3867eb7c2..53e13c3313e9 100644
> > --- a/arch/arm64/kvm/hyp/pgtable.c
> > +++ b/arch/arm64/kvm/hyp/pgtable.c
> > @@ -152,6 +152,7 @@ static void kvm_set_table_pte(kvm_pte_t *ptep, kvm_pte_t *childp,
> >
> >       WARN_ON(kvm_pte_valid(old));
> >       smp_store_release(ptep, pte);
> > +     kvm_account_pgtable_pages((void *)childp, +1);
>
> What page tables do we want to account? KVM on ARM manages several page
> tables.
>
> For regular KVM, the host kernel manages allocations for the hyp stage 1
> tables in addition to the stage 2 tables used for a particular VM. The
> former is system overhead whereas the latter could be attributed to a
> guest VM.

Honestly I would love to get your input on this. The main motivation
here is to give users insights on the kernel memory usage on their
system (or in a cgroup). We currently have NR_PAGETABLE stats for
normal kernel page tables (allocated using
__pte_alloc_one()/pte_free()), this shows up in /proc/meminfo,
/path/to/cgroup/memory.stat, and node stats. The idea is to add
NR_SECONDARY_PAGETABLE that should include the memory used for kvm
pagetables, which should be a separate category (no overlap). What
gets included or not depends on the semantics of KVM and what exactly
falls under the category of secondary pagetables from the user's pov.

Currently it looks like s2 page table allocations get accounted to
kmem of memory control groups (GFP_KERNEL_ACCOUNT), while hyp page
table allocations do not (GFP_KERNEL). So we could either follow this
and only account s2 page table allocations in the stats, or make hyp
allocations use GFP_KERNEL_ACCOUNT as well and add them to the stats.
Let me know what you think.

>
> I imagine protected KVM is out of scope, since it actually manages its
> own allocations outside of the host kernel.
>
> Given this, I would recommend adding the accounting hooks to mmu.c as
> that is where we alloc/free table pages and it is in the host address
> space. kvm_s2_mm_ops and kvm_hyp_mm_ops point to all the relevant
> functions, though the latter is only relevant if we want to count system
> page tables too.

Yeah moving the accounting hooks to mmu.c is much cleaner, I will do
this in the next version. The only reason I did not do this is that I
found other kvm_pgtable_mm_ops structs (such as pkvm_pgtable_mm_ops),
but it looks like these may be irrelevant here.

>
> --
> Thanks,
> Oliver
