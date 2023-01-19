Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70E8E673670
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Jan 2023 12:13:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230165AbjASLNO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 19 Jan 2023 06:13:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229593AbjASLNM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 19 Jan 2023 06:13:12 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EB7944BF5;
        Thu, 19 Jan 2023 03:13:11 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id t12-20020a17090aae0c00b00229f4cff534so254814pjq.1;
        Thu, 19 Jan 2023 03:13:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WobviXpwWUZxD+2oQmL88+wYfR6mU0tdRKmjmFL+nas=;
        b=f7L1TD8+BmvD+A9pFAjMprM7B0spRnkeduPMQvbgLHvYJpiHQnNW4NU1/YfORCUZQb
         xaAorOgKYQmiKRAwik+pNTZYr9eT0raty08UEzrXavMtcLBX61EQYx+vZD2j0NdavbRC
         gf42Gt0VLrwev9tri3s4QJ8s/wW15sCEWExzZjJxOc6DlYr2SBEqQnmG10REIoIr2x7u
         xRy4XvEACzmTSzYCJ1ebtTfjCFCkLZHZY79OZCLCLg34Z7JITOr+iw6UlLUVH9Yq9b2o
         CUC0rAHKgZYzWzRKZZhXOG8dkikcSAUrekSJE3ShE6L2WgvT5bMYEZSjZYPJ7WvpIEyk
         UzDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WobviXpwWUZxD+2oQmL88+wYfR6mU0tdRKmjmFL+nas=;
        b=beHmFQ7ElNBT7GS8Lrwiry/C8q306qbubhERr0RnNWDeN8FhQf5VNSTgAHKuugQyBz
         HC0vyv/t2dm16vkS/lbPC6L2wFaMxaWzDl73AgttFOow9Ei5918/P6eBkarlwz7MgRJ1
         yss25GUY+BcBh4tbTG0eFnQNxiEnic3wBzK9nWtk2fQbpFheJPjQnruCTX35qI20Z0wp
         N0zDvwFvoAggxLIXbhrJd11ROdUCqwqnKMf4IetRVWHHGZg0fadd1B1yeagXFT05NDgA
         1T722vOV9UiALRpBy7AQcavIK7z/B9lQ+rHHwz4+uh+UWfu5xcRK6f/LzeLCZP3Aojh8
         8J3g==
X-Gm-Message-State: AFqh2kqNGHuCF4DAu7INNAX6gd29ISZbDqnyQGYlA/m/9vyNuPVZtAh9
        96gbnyz37kf3xBFeeyDJ6+Q=
X-Google-Smtp-Source: AMrXdXuFUYPr4gl2HBth8ATukfpSeD4X8dOtFLmJYA5beRkuYlrBNgWB27UfhgflYvUdjqzwEfWuFQ==
X-Received: by 2002:a17:903:248f:b0:189:6ab3:9e64 with SMTP id p15-20020a170903248f00b001896ab39e64mr10324160plw.34.1674126790421;
        Thu, 19 Jan 2023 03:13:10 -0800 (PST)
Received: from localhost ([192.55.54.55])
        by smtp.gmail.com with ESMTPSA id k7-20020a170902ce0700b001885d15e3c1sm24860035plg.26.2023.01.19.03.13.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jan 2023 03:13:09 -0800 (PST)
Date:   Thu, 19 Jan 2023 03:13:08 -0800
From:   Isaku Yamahata <isaku.yamahata@gmail.com>
To:     Sean Christopherson <seanjc@google.com>
Cc:     Chao Peng <chao.p.peng@linux.intel.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-api@vger.kernel.org, linux-doc@vger.kernel.org,
        qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
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
        Shuah Khan <shuah@kernel.org>, Mike Rapoport <rppt@kernel.org>,
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
        wei.w.wang@intel.com, isaku.yamahata@gmail.com
Subject: Re: [PATCH v10 0/9] KVM: mm: fd-based approach for supporting KVM
Message-ID: <20230119111308.GC2976263@ls.amr.corp.intel.com>
References: <20221202061347.1070246-1-chao.p.peng@linux.intel.com>
 <Y8H5Z3e4hZkFxAVS@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y8H5Z3e4hZkFxAVS@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Jan 14, 2023 at 12:37:59AM +0000,
Sean Christopherson <seanjc@google.com> wrote:

> On Fri, Dec 02, 2022, Chao Peng wrote:
> > This patch series implements KVM guest private memory for confidential
> > computing scenarios like Intel TDX[1]. If a TDX host accesses
> > TDX-protected guest memory, machine check can happen which can further
> > crash the running host system, this is terrible for multi-tenant
> > configurations. The host accesses include those from KVM userspace like
> > QEMU. This series addresses KVM userspace induced crash by introducing
> > new mm and KVM interfaces so KVM userspace can still manage guest memory
> > via a fd-based approach, but it can never access the guest memory
> > content.
> > 
> > The patch series touches both core mm and KVM code. I appreciate
> > Andrew/Hugh and Paolo/Sean can review and pick these patches. Any other
> > reviews are always welcome.
> >   - 01: mm change, target for mm tree
> >   - 02-09: KVM change, target for KVM tree
> 
> A version with all of my feedback, plus reworked versions of Vishal's selftest,
> is available here:
> 
>   git@github.com:sean-jc/linux.git x86/upm_base_support
> 
> It compiles and passes the selftest, but it's otherwise barely tested.  There are
> a few todos (2 I think?) and many of the commits need changelogs, i.e. it's still
> a WIP.
> 
> As for next steps, can you (handwaving all of the TDX folks) take a look at what
> I pushed and see if there's anything horrifically broken, and that it still works
> for TDX?
> 
> Fuad (and pKVM folks) same ask for you with respect to pKVM.  Absolutely no rush
> (and I mean that).
> 
> On my side, the two things on my mind are (a) tests and (b) downstream dependencies
> (SEV and TDX).  For tests, I want to build a lists of tests that are required for
> merging so that the criteria for merging are clear, and so that if the list is large
> (haven't thought much yet), the work of writing and running tests can be distributed.
> 
> Regarding downstream dependencies, before this lands, I want to pull in all the
> TDX and SNP series and see how everything fits together.  Specifically, I want to
> make sure that we don't end up with a uAPI that necessitates ugly code, and that we
> don't miss an opportunity to make things simpler.  The patches in the SNP series to
> add "legacy" SEV support for UPM in particular made me slightly rethink some minor
> details.  Nothing remotely major, but something that needs attention since it'll
> be uAPI.

Although I'm still debuging with TDX KVM, I needed the following.
kvm_faultin_pfn() is called without mmu_lock held.  the race to change
private/shared is handled by mmu_seq.  Maybe dedicated function only for
kvm_faultin_pfn().

diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 02be5e1cba1e..38699ca75ab8 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -2322,7 +2322,7 @@ static inline void kvm_account_pgtable_pages(void *virt, int nr)
 #ifdef CONFIG_KVM_GENERIC_MEMORY_ATTRIBUTES
 static inline unsigned long kvm_get_memory_attributes(struct kvm *kvm, gfn_t gfn)
 {
-       lockdep_assert_held(&kvm->mmu_lock);
+       // lockdep_assert_held(&kvm->mmu_lock);
 
        return xa_to_value(xa_load(&kvm->mem_attr_array, gfn));
 }


-- 
Isaku Yamahata <isaku.yamahata@gmail.com>
