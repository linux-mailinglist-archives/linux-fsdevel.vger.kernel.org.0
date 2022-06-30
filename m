Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36D145622D1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Jun 2022 21:14:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235578AbiF3TOb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 30 Jun 2022 15:14:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232621AbiF3TO0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 30 Jun 2022 15:14:26 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CA85393D5
        for <linux-fsdevel@vger.kernel.org>; Thu, 30 Jun 2022 12:14:24 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id v126so211930pgv.11
        for <linux-fsdevel@vger.kernel.org>; Thu, 30 Jun 2022 12:14:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CseVMsc9DMcvnremI2IMCVn9RXMEwKZ3PfQxnseEk1Y=;
        b=L86qxID6q2M+JSm6WJlw/ywbiK2Bd4F4OqP2crvM+fBErSUs7vAk8+S+Iq/oWCc3S3
         A/zD733aSeW/NQtqDBUXacjPlB7RxpFMnf6lRRa/+NdtBmLjMtHmcPsoOWwkq8KCWT59
         Wrjd2sZMC+z5N1mQaKCk8s3sRW71BeCnVhZwSRy715zMP+SNJe7eU9WYohudOv1KNRGA
         /2Hl1gt/4XtlScYZ3mwC111MIu9O+AEpZ9xmxnKCHZmdZRhh6DrJvNuc5sQfRD0Ka1kU
         JrjpbfOKNuX8+d69m9LSTBv0r1O0mwEp5rUB+SIBwil7KVtufeEqPNZkhvO1MatEsuMw
         lriQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CseVMsc9DMcvnremI2IMCVn9RXMEwKZ3PfQxnseEk1Y=;
        b=dIgWtbW0TKQPaFLkyH0YyAHzUSfWSG34cmXCXu/i6NnDu23FfDxzY5lig2Z5fnU/SC
         bGJ+n12lW44AB2FX7iU/MihmQ4LjB6BoL4trpGacmjgRpUeuVfepgDLW2OW8VMHBaBS4
         q/BunWLZ9yRITU3ylXYUt0Ksx26RP31WkYiN9C/RVRLOcNEPm+XZMHomXsLT/F8OLbs8
         m1MZIS9egVh2atj8WLfubjx1hsUe4V2yvSCXoFVEOzIHIBcgmcx8buEGHi13uDXKP5tJ
         24pyXHAA4hhQaiY/6NISMWToavUxBxmAzRZ8xx1D+a4uBw1L+YnGG/ApjPW2k429ZrvJ
         tY8Q==
X-Gm-Message-State: AJIora9MioJGIclBGrSe4ZwB8nRlQGVJ+cTFFq3N+WWenA0JGtz72gPm
        VhsaAKxZwnFBRTBponFItuqIAvsb9hsuxgRAWvN3dQ==
X-Google-Smtp-Source: AGRyM1sSw2bcuHVxuECIXV0dhinx7eNbwu+6Xk72mVPwUCDEPf65Qjtbn+gPrnXqf1ZcPTdHgl0RAcjI8NMysu55SIM=
X-Received: by 2002:a65:6b8a:0:b0:3db:7dc5:fec2 with SMTP id
 d10-20020a656b8a000000b003db7dc5fec2mr8746604pgw.223.1656616463900; Thu, 30
 Jun 2022 12:14:23 -0700 (PDT)
MIME-Version: 1.0
References: <20220519153713.819591-1-chao.p.peng@linux.intel.com>
 <20220519153713.819591-7-chao.p.peng@linux.intel.com> <b3ce0855-0e4b-782a-599c-26590df948dd@amd.com>
 <20220624090246.GA2181919@chaop.bj.intel.com>
In-Reply-To: <20220624090246.GA2181919@chaop.bj.intel.com>
From:   Vishal Annapurve <vannapurve@google.com>
Date:   Thu, 30 Jun 2022 12:14:13 -0700
Message-ID: <CAGtprH82H_fjtRbL0KUxOkgOk4pgbaEbAydDYfZ0qxz41JCnAQ@mail.gmail.com>
Subject: Re: [PATCH v6 6/8] KVM: Handle page fault for private memory
To:     Chao Peng <chao.p.peng@linux.intel.com>
Cc:     "Nikunj A. Dadhania" <nikunj@amd.com>,
        kvm list <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
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
        x86 <x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>,
        Hugh Dickins <hughd@google.com>,
        Jeff Layton <jlayton@kernel.org>,
        "J . Bruce Fields" <bfields@fieldses.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@kernel.org>,
        Steven Price <steven.price@arm.com>,
        "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
        Vlastimil Babka <vbabka@suse.cz>,
        Yu Zhang <yu.c.zhang@linux.intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Jun Nakajima <jun.nakajima@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        David Hildenbrand <david@redhat.com>, aarcange@redhat.com,
        ddutile@redhat.com, dhildenb@redhat.com,
        Quentin Perret <qperret@google.com>,
        Michael Roth <michael.roth@amd.com>, mhocko@suse.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

...
> > >     /*
> > > diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
> > > index afe18d70ece7..e18460e0d743 100644
> > > --- a/arch/x86/kvm/mmu/mmu.c
> > > +++ b/arch/x86/kvm/mmu/mmu.c
> > > @@ -2899,6 +2899,9 @@ int kvm_mmu_max_mapping_level(struct kvm *kvm,
> > >     if (max_level == PG_LEVEL_4K)
> > >             return PG_LEVEL_4K;
> > >
> > > +   if (kvm_slot_is_private(slot))
> > > +           return max_level;
> >
> > Can you explain the rationale behind the above change?
> > AFAIU, this overrides the transparent_hugepage=never setting for both
> > shared and private mappings.
>
> As Sean pointed out, this should check against fault->is_private instead
> of the slot. For private fault, the level is retrieved and stored to
> fault->max_level in kvm_faultin_pfn_private() instead of here.
>
> For shared fault, it will continue to query host_level below. For
> private fault, the host level has already been accounted in
> kvm_faultin_pfn_private().
>
> Chao
> >

With transparent_hugepages=always setting I see issues with the
current implementation.

Scenario:
1) Guest accesses a gfn range 0x800-0xa00 as private
2) Guest calls mapgpa to convert the range 0x84d-0x86e as shared
3) Guest tries to access recently converted memory as shared for the first time
Guest VM shutdown is observed after step 3 -> Guest is unable to
proceed further since somehow code section is not as expected

Corresponding KVM trace logs after step 3:
VCPU-0-61883   [078] ..... 72276.115679: kvm_page_fault: address
84d000 error_code 4
VCPU-0-61883   [078] ..... 72276.127005: kvm_mmu_spte_requested: gfn
84d pfn 100b4a4d level 2
VCPU-0-61883   [078] ..... 72276.127008: kvm_tdp_mmu_spte_changed: as
id 0 gfn 800 level 2 old_spte 100b1b16827 new_spte 100b4a00ea7
VCPU-0-61883   [078] ..... 72276.127009: kvm_mmu_prepare_zap_page: sp
gen 0 gfn 800 l1 8-byte q0 direct wux nxe ad root 0 sync
VCPU-0-61883   [078] ..... 72276.127009: kvm_tdp_mmu_spte_changed: as
id 0 gfn 800 level 1 old_spte 1003eb27e67 new_spte 5a0
VCPU-0-61883   [078] ..... 72276.127010: kvm_tdp_mmu_spte_changed: as
id 0 gfn 801 level 1 old_spte 10056cc8e67 new_spte 5a0
VCPU-0-61883   [078] ..... 72276.127010: kvm_tdp_mmu_spte_changed: as
id 0 gfn 802 level 1 old_spte 10056fa2e67 new_spte 5a0
VCPU-0-61883   [078] ..... 72276.127010: kvm_tdp_mmu_spte_changed: as
id 0 gfn 803 level 1 old_spte 0 new_spte 5a0
....
 VCPU-0-61883   [078] ..... 72276.127089: kvm_tdp_mmu_spte_changed: as
id 0 gfn 9ff level 1 old_spte 100a43f4e67 new_spte 5a0
 VCPU-0-61883   [078] ..... 72276.127090: kvm_mmu_set_spte: gfn 800
spte 100b4a00ea7 (rwxu) level 2 at 10052fa5020
 VCPU-0-61883   [078] ..... 72276.127091: kvm_fpu: unload

Looks like with transparent huge pages enabled kvm tried to handle the
shared memory fault on 0x84d gfn by coalescing nearby 4K pages
to form a contiguous 2MB page mapping at gfn 0x800, since level 2 was
requested in kvm_mmu_spte_requested.
This caused the private memory contents from regions 0x800-0x84c and
0x86e-0xa00 to get unmapped from the guest leading to guest vm
shutdown.

Does getting the mapping level as per the fault access type help
address the above issue? Any such coalescing should not cross between
private to
shared or shared to private memory regions.

> > >     host_level = host_pfn_mapping_level(kvm, gfn, pfn, slot);
> > >     return min(host_level, max_level);
> > >  }
> >

Regards,
Vishal
