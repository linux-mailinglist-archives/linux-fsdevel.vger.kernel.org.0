Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87F3267466E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Jan 2023 23:55:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230342AbjASWzP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 19 Jan 2023 17:55:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229807AbjASWyd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 19 Jan 2023 17:54:33 -0500
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 459635895D;
        Thu, 19 Jan 2023 14:37:07 -0800 (PST)
Received: by mail-pg1-x52d.google.com with SMTP id f3so2768049pgc.2;
        Thu, 19 Jan 2023 14:37:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=c3/xglDrs4GgAM40Pjq1vzK1v2T7qf4JcCCRFWl6k4g=;
        b=NSYj639Mp9v5ap+wI0hCjvD0/JJIjDFxjIAk8s0W6QQZeGagLHTMYL5/dvvI2DPi4B
         +aGueObJ+RXaUVDn4NiXYFIhEcPYWxInkxzarthRsu1sZZ256/vMx7XvGmJtSYSWRLwB
         vl6fpplWJgAyhnKrjElYHYhD8OeiwcbmHLjIG5BiksGBX7KJzcLCywEenDObbw+Mxjwr
         pmu+l0l6CF6xX7jvLuX0TRIXSYOrvw5purr8S55V7TS8hL4NzHy8DcBRiXHfgymzDvFg
         PvZjALLBOjVmU5MNA64b0nuXlR2yYuFwQaHv+ETJElDhkdksrjTql7nEvp7HQxv7QCn3
         HOLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c3/xglDrs4GgAM40Pjq1vzK1v2T7qf4JcCCRFWl6k4g=;
        b=OpVuXW90GREJ8IPsBgaqU3tmELFOp4W+5eWlo+Q4wj0EQvohSimiv5iIP/nbKMBSDl
         +QgbbhwKsf2aXFQ+yWDH62NAvqLscYAkolUtMrSzIA+U8gZJ3CBuYgUlDQVWFOkgHmQm
         Z8EB1vbArrSTFv/3geeyzgVVJQ67U1Z3wslOnP0+oDDO5qU//mfNbAJ9104Y7HN7IIP+
         zcjXcxunpwpwa/kJ4MoteHh2xf45+xrYrP9IfH9oS9j3rLCGFMEXeWZOOSk+p1x815Ry
         SsGhayfVldf9dr8TwS/QcO2bs5T/IS/yy54lYdPsy4KkftCwkmPe2h5Bm0tlrKBTZcL2
         2Ilg==
X-Gm-Message-State: AFqh2ko9jBOMzyZ/8bInYMczvJo1WTEnXDMpYXwlreoiix5J3ddKEY5O
        YiIgHEDFbkTDmlDqffsrRII=
X-Google-Smtp-Source: AMrXdXtheeUgW/ehdT20D8crA3E+xLX19dRj8kq2j9cAtxWEF6/jTGrekTIsjKUTNo8D+nlbVHnJHA==
X-Received: by 2002:a62:ab0b:0:b0:58b:46c9:a6b1 with SMTP id p11-20020a62ab0b000000b0058b46c9a6b1mr13080521pff.33.1674167826597;
        Thu, 19 Jan 2023 14:37:06 -0800 (PST)
Received: from localhost ([192.55.54.55])
        by smtp.gmail.com with ESMTPSA id c202-20020a621cd3000000b0058dc1d54db1sm6563910pfc.206.2023.01.19.14.37.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jan 2023 14:37:05 -0800 (PST)
Date:   Thu, 19 Jan 2023 14:37:04 -0800
From:   Isaku Yamahata <isaku.yamahata@gmail.com>
To:     Sean Christopherson <seanjc@google.com>
Cc:     Isaku Yamahata <isaku.yamahata@gmail.com>,
        Chao Peng <chao.p.peng@linux.intel.com>, kvm@vger.kernel.org,
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
        wei.w.wang@intel.com
Subject: Re: [PATCH v10 0/9] KVM: mm: fd-based approach for supporting KVM
Message-ID: <20230119223704.GD2976263@ls.amr.corp.intel.com>
References: <20221202061347.1070246-1-chao.p.peng@linux.intel.com>
 <Y8H5Z3e4hZkFxAVS@google.com>
 <20230119111308.GC2976263@ls.amr.corp.intel.com>
 <Y8lg1G2lRIrI/hld@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y8lg1G2lRIrI/hld@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jan 19, 2023 at 03:25:08PM +0000,
Sean Christopherson <seanjc@google.com> wrote:

> On Thu, Jan 19, 2023, Isaku Yamahata wrote:
> > On Sat, Jan 14, 2023 at 12:37:59AM +0000,
> > Sean Christopherson <seanjc@google.com> wrote:
> > 
> > > On Fri, Dec 02, 2022, Chao Peng wrote:
> > > > This patch series implements KVM guest private memory for confidential
> > > > computing scenarios like Intel TDX[1]. If a TDX host accesses
> > > > TDX-protected guest memory, machine check can happen which can further
> > > > crash the running host system, this is terrible for multi-tenant
> > > > configurations. The host accesses include those from KVM userspace like
> > > > QEMU. This series addresses KVM userspace induced crash by introducing
> > > > new mm and KVM interfaces so KVM userspace can still manage guest memory
> > > > via a fd-based approach, but it can never access the guest memory
> > > > content.
> > > > 
> > > > The patch series touches both core mm and KVM code. I appreciate
> > > > Andrew/Hugh and Paolo/Sean can review and pick these patches. Any other
> > > > reviews are always welcome.
> > > >   - 01: mm change, target for mm tree
> > > >   - 02-09: KVM change, target for KVM tree
> > > 
> > > A version with all of my feedback, plus reworked versions of Vishal's selftest,
> > > is available here:
> > > 
> > >   git@github.com:sean-jc/linux.git x86/upm_base_support
> > > 
> > > It compiles and passes the selftest, but it's otherwise barely tested.  There are
> > > a few todos (2 I think?) and many of the commits need changelogs, i.e. it's still
> > > a WIP.
> > > 
> > > As for next steps, can you (handwaving all of the TDX folks) take a look at what
> > > I pushed and see if there's anything horrifically broken, and that it still works
> > > for TDX?
> > > 
> > > Fuad (and pKVM folks) same ask for you with respect to pKVM.  Absolutely no rush
> > > (and I mean that).
> > > 
> > > On my side, the two things on my mind are (a) tests and (b) downstream dependencies
> > > (SEV and TDX).  For tests, I want to build a lists of tests that are required for
> > > merging so that the criteria for merging are clear, and so that if the list is large
> > > (haven't thought much yet), the work of writing and running tests can be distributed.
> > > 
> > > Regarding downstream dependencies, before this lands, I want to pull in all the
> > > TDX and SNP series and see how everything fits together.  Specifically, I want to
> > > make sure that we don't end up with a uAPI that necessitates ugly code, and that we
> > > don't miss an opportunity to make things simpler.  The patches in the SNP series to
> > > add "legacy" SEV support for UPM in particular made me slightly rethink some minor
> > > details.  Nothing remotely major, but something that needs attention since it'll
> > > be uAPI.
> > 
> > Although I'm still debuging with TDX KVM, I needed the following.
> > kvm_faultin_pfn() is called without mmu_lock held.  the race to change
> > private/shared is handled by mmu_seq.  Maybe dedicated function only for
> > kvm_faultin_pfn().
> 
> Gah, you're not on the other thread where this was discussed[*].  Simply deleting
> the lockdep assertion is safe, for guest types that rely on the attributes to
> define shared vs. private, KVM rechecks the attributes under the protection of
> mmu_seq.
> 
> I'll get a fixed version pushed out today.
> 
> [*] https://lore.kernel.org/all/Y8gpl+LwSuSgBFks@google.com

Now I have tdx kvm working. I've uploaded at the followings.
It's rebased to v6.2-rc3.
        git@github.com:yamahata/linux.git tdx/upm
        git@github.com:yamahata/qemu.git tdx/upm

kvm_mmu_do_page_fault() needs the following change.
kvm_mem_is_private() queries mem_attr_array.  kvm_faultin_pfn() also uses
kvm_mem_is_private(). So the shared-private check in kvm_faultin_pfn() doesn't
make sense. This change would belong to TDX KVM patches, though.

diff --git a/arch/x86/kvm/mmu/mmu_internal.h b/arch/x86/kvm/mmu/mmu_internal.h
index 72b0da8e27e0..f45ac438bbf4 100644
--- a/arch/x86/kvm/mmu/mmu_internal.h
+++ b/arch/x86/kvm/mmu/mmu_internal.h
@@ -430,7 +430,7 @@ static inline int kvm_mmu_do_page_fault(struct kvm_vcpu *vcpu, gpa_t cr2_or_gpa,
                .max_level = vcpu->kvm->arch.tdp_max_page_level,
                .req_level = PG_LEVEL_4K,
                .goal_level = PG_LEVEL_4K,
-               .is_private = kvm_mem_is_private(vcpu->kvm, cr2_or_gpa >> PAGE_SHIFT),
+               .is_private = kvm_is_private_gpa(vcpu->kvm, cr2_or_gpa),
        };
        int r;


-- 
Isaku Yamahata <isaku.yamahata@gmail.com>
