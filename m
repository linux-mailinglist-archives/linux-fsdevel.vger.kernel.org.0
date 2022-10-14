Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E83455FF3DD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Oct 2022 20:57:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231191AbiJNS53 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 14 Oct 2022 14:57:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231147AbiJNS51 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 14 Oct 2022 14:57:27 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12D841D374F
        for <linux-fsdevel@vger.kernel.org>; Fri, 14 Oct 2022 11:57:25 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id 78so5061770pgb.13
        for <linux-fsdevel@vger.kernel.org>; Fri, 14 Oct 2022 11:57:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Hp3yAxY8quCRjHZnHuBPErW5fHEohLMFvOXbDGO/GC8=;
        b=smV3l+b0gPfxsb+cqdrtrWHgL08g1JwC/C9k3qD53pTkH5zIwd+CIdIyQkxG2V3LLQ
         vr0fhAZDODX1iShv+uzVVoKO2yI7QS7Dpy4QRu2J0zo+aNXAVzvGg9sHUoPxlMruufUT
         Kd/EU2UsY1bQRGYb9CuGI8JhB7KR+4XGd9bVk3KgrDAwpXMdf9mvoLDt+7277BOEjAQV
         15NUZRhkPpmEySXzwlsNUL2z1AS+68J/MFJRdyKFhuc1w6rWzoLKg91755NPIspVj/io
         XF7nOZ5WJqalD97V+ZX9AqmTvPbtx0IjpzWhO5nEiArwNwQFjprucchbkW3wnXB21FW0
         xdnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hp3yAxY8quCRjHZnHuBPErW5fHEohLMFvOXbDGO/GC8=;
        b=VRygHi9dEw6cuzMrx5XTD54tQE9+M8e9RXsuOXic+tj87hRrz9gElyZj8j+X2zW7JY
         jx3I7HY0BT1GKHR6M/wEmF6dBJTUyt3ynqQqSAM4TgcvMoub7GtFw/ivcjKh6JTsKQAT
         grFKC3H/fB7LiRHQPZyMLlxiiz5nA/PyeDSJE2Jx5YJPIZlu/C0MRzaNPyewjcisfOsp
         5C5lRVu1joY0tKzI333Q7nkJXhXMze69KTZld00tnER/a2Z1ir15saIhu77B9HuqGAFW
         vUJlkBSeK5GDwYh/bV2ceQi8rLbj0xldwGSn0+TqeHWGIjgEfnOK96P2nmZp+Zjr831m
         LYnQ==
X-Gm-Message-State: ACrzQf2s0CPBh7tWA889HBsWig3FaZxzYb82sjDYcfvjOTae3XBm/6Ox
        /D7DJTgpPtwVIVSeTm8JpPnOrg==
X-Google-Smtp-Source: AMsMyM4sMMNxa+29AKQJlblJPyT5lnKnzMKJX7jVmbsXLFeWuFqUiTCO3icedQ7T+zlfYZ0ltLMusQ==
X-Received: by 2002:a63:2483:0:b0:461:ab67:ccfb with SMTP id k125-20020a632483000000b00461ab67ccfbmr5521853pgk.341.1665773844428;
        Fri, 14 Oct 2022 11:57:24 -0700 (PDT)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id j5-20020a625505000000b00562019b961asm2064125pfb.188.2022.10.14.11.57.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Oct 2022 11:57:23 -0700 (PDT)
Date:   Fri, 14 Oct 2022 18:57:20 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Chao Peng <chao.p.peng@linux.intel.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org, linux-doc@vger.kernel.org,
        qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>,
        Hugh Dickins <hughd@google.com>,
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
        Quentin Perret <qperret@google.com>,
        Michael Roth <michael.roth@amd.com>, mhocko@suse.com,
        Muchun Song <songmuchun@bytedance.com>, wei.w.wang@intel.com
Subject: Re: [PATCH v8 7/8] KVM: Handle page fault for private memory
Message-ID: <Y0mxEFpvS7O96CCD@google.com>
References: <20220915142913.2213336-1-chao.p.peng@linux.intel.com>
 <20220915142913.2213336-8-chao.p.peng@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220915142913.2213336-8-chao.p.peng@linux.intel.com>
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

On Thu, Sep 15, 2022, Chao Peng wrote:
> diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
> index a0f198cede3d..81ab20003824 100644
> --- a/arch/x86/kvm/mmu/mmu.c
> +++ b/arch/x86/kvm/mmu/mmu.c
> @@ -3028,6 +3028,9 @@ int kvm_mmu_max_mapping_level(struct kvm *kvm,
>  			break;
>  	}
>  
> +	if (kvm_mem_is_private(kvm, gfn))

Rather than reload the Xarray info, which is unnecessary overhead, pass in
@is_private.  The caller must hold mmu_lock, i.e. invalidations from
private<->shared conversions will be stalled and will zap the new SPTE if the
state is changed.

E.g.

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index d68944f07b4b..44eea47697d8 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -3072,8 +3072,8 @@ void kvm_mmu_hugepage_adjust(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault
         * Enforce the iTLB multihit workaround after capturing the requested
         * level, which will be used to do precise, accurate accounting.
         */
-       fault->req_level = kvm_mmu_max_mapping_level(vcpu->kvm, slot,
-                                                    fault->gfn, fault->max_level);
+       fault->req_level = kvm_mmu_max_mapping_level(vcpu->kvm, slot, fault->gfn,
+                                                    fault->max_level, fault->is_private);
        if (fault->req_level == PG_LEVEL_4K || fault->huge_page_disallowed)
                return;
 
@@ -6460,7 +6460,7 @@ static bool kvm_mmu_zap_collapsible_spte(struct kvm *kvm,
                 */
                if (sp->role.direct &&
                    sp->role.level < kvm_mmu_max_mapping_level(kvm, slot, sp->gfn,
-                                                              PG_LEVEL_NUM)) {
+                                                              PG_LEVEL_NUM, false)) {
                        kvm_zap_one_rmap_spte(kvm, rmap_head, sptep);
 
                        if (kvm_available_flush_tlb_with_range())
diff --git a/arch/x86/kvm/mmu/spte.h b/arch/x86/kvm/mmu/spte.h
index 7670c13ce251..9acdf72537ce 100644
--- a/arch/x86/kvm/mmu/spte.h
+++ b/arch/x86/kvm/mmu/spte.h
@@ -315,6 +315,12 @@ static inline bool is_dirty_spte(u64 spte)
        return dirty_mask ? spte & dirty_mask : spte & PT_WRITABLE_MASK;
 }
 
+static inline bool is_private_spte(u64 spte)
+{
+       /* FIXME: Query C-bit/S-bit for SEV/TDX. */
+       return false;
+}
+
 static inline u64 get_rsvd_bits(struct rsvd_bits_validate *rsvd_check, u64 pte,
                                int level)
 {
diff --git a/arch/x86/kvm/mmu/tdp_mmu.c b/arch/x86/kvm/mmu/tdp_mmu.c
index 672f0432d777..69ba00157e90 100644
--- a/arch/x86/kvm/mmu/tdp_mmu.c
+++ b/arch/x86/kvm/mmu/tdp_mmu.c
@@ -1767,8 +1767,9 @@ static void zap_collapsible_spte_range(struct kvm *kvm,
                if (iter.gfn < start || iter.gfn >= end)
                        continue;
 
-               max_mapping_level = kvm_mmu_max_mapping_level(kvm, slot,
-                                                             iter.gfn, PG_LEVEL_NUM);
+               max_mapping_level = kvm_mmu_max_mapping_level(kvm, slot, iter.gfn,
+                                                             PG_LEVEL_NUM,
+                                                             is_private_spte(iter.old_spte));
                if (max_mapping_level < iter.level)
                        continue;
 
