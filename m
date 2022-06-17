Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C414254FF58
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Jun 2022 23:27:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235579AbiFQV1f (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 Jun 2022 17:27:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235559AbiFQV1d (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 Jun 2022 17:27:33 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA75D3A1A2
        for <linux-fsdevel@vger.kernel.org>; Fri, 17 Jun 2022 14:27:30 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id i15so4892001plr.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 17 Jun 2022 14:27:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=4Nh/ioaLxS4TiMuv6mrO3BuuJxs5edtEcbJCJ0DlzHg=;
        b=kqV10ZowD4mEAwkhnGeH7Vi46uyd6cVb+D27K/8D7q4ZgbepI0UMc7Xg/GhUj7mWCn
         sUXIO1GdA6DWiQTudDzJU8yc0x7fO1CRRIYu+qGUSrN9fwrVOrLdD1rfHGdBXyFAfxoY
         HUeLpXo40NmxK6NMGADGQ7EfuqeHEdheydvWwcQvIfZxA5YfRVWSMGNAX2325hWiHuHY
         7FXv22PI/DmPa7E2x1nANjza+zy8ei0HlKM5niFMLK6Y/yuw6Rd/UBQlspC2hX9x3Qb4
         bTlUA9qVQpHAf6cfcS9FKqlK43DFOWeREbCmJaIPzqYk2+TsXXbIzRcnGQoReMxVEUKW
         K2kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4Nh/ioaLxS4TiMuv6mrO3BuuJxs5edtEcbJCJ0DlzHg=;
        b=b9AMSta1EoaMLLfvJYwwu1reqhFS1bF8gBG8TG/rfoUKRlQUGINu9lr3zRY+UYq0RQ
         7ygGQZQqHKjL1FP3/gvJxGZwCKVSMGOUJLVmEkWE7173nTaxNsTp+p0dYW7ChtDXSXP+
         vipDqlWMM5FEoj+HkWLy4U8743arDmPRIOX4IKO7V83Ps9Skg+ALXYW563GoMxoI93Dr
         gkd+wmMocbpmw8wUNKai5U9h3J2t8r54dHwL2bbO8ZB0lyXKhsu63nbX8KhuY+Lz74GL
         MUprCDff2H0ellN6ekFfwhSXW6GmuXZ/eh1rb4IJ+Huf0ngxMQj0Ist97kVDPPFmCB4b
         pBbA==
X-Gm-Message-State: AJIora/qvKHg4eIX2V9j2MfPjw5MifjgKwpL8ql5IYrsIoPGfI/hAQy0
        BiizC0CIcQ471oZOEHACkWfl9w==
X-Google-Smtp-Source: AGRyM1uRS2fAbjyxhFU2PYlmkBtwm8UeO62IZrWZixGAXkVAe6FeSFCI9nOgPKmO0Bfh0yLM2ya5lQ==
X-Received: by 2002:a17:90a:4503:b0:1ea:4718:829f with SMTP id u3-20020a17090a450300b001ea4718829fmr12496982pjg.103.1655501249895;
        Fri, 17 Jun 2022 14:27:29 -0700 (PDT)
Received: from google.com (123.65.230.35.bc.googleusercontent.com. [35.230.65.123])
        by smtp.gmail.com with ESMTPSA id f2-20020a62db02000000b0051868677e6dsm4218356pfg.51.2022.06.17.14.27.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jun 2022 14:27:29 -0700 (PDT)
Date:   Fri, 17 Jun 2022 21:27:25 +0000
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
        Mike Rapoport <rppt@kernel.org>,
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
        Michael Roth <michael.roth@amd.com>, mhocko@suse.com
Subject: Re: [PATCH v6 4/8] KVM: Extend the memslot to support fd-based
 private memory
Message-ID: <YqzxvYU7EtHab6U7@google.com>
References: <20220519153713.819591-1-chao.p.peng@linux.intel.com>
 <20220519153713.819591-5-chao.p.peng@linux.intel.com>
 <Yqzpf3AEYabFWjnW@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yqzpf3AEYabFWjnW@google.com>
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

On Fri, Jun 17, 2022, Sean Christopherson wrote:
> > @@ -110,6 +133,7 @@ struct kvm_userspace_memory_region {
> >   */
> >  #define KVM_MEM_LOG_DIRTY_PAGES	(1UL << 0)
> >  #define KVM_MEM_READONLY	(1UL << 1)
> > +#define KVM_MEM_PRIVATE		(1UL << 2)
> 
> Hmm, KVM_MEM_PRIVATE is technically wrong now that a "private" memslot maps private
> and/or shared memory.  Strictly speaking, we don't actually need a new flag.  Valid
> file descriptors must be >=0, so the logic for specifying a memslot that can be
> converted between private and shared could be that "(int)private_fd < 0" means
> "not convertible", i.e. derive the flag from private_fd.
> 
> And looking at the two KVM consumers of the flag, via kvm_slot_is_private(), they're
> both wrong.  Both kvm_faultin_pfn() and kvm_mmu_max_mapping_level() should operate
> on the _fault_, not the slot.  So it would actually be a positive to not have an easy
> way to query if a slot supports conversion.

I take that back, the usage in kvm_faultin_pfn() is correct, but the names ends
up being confusing because it suggests that it always faults in a private pfn.

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index b6d75016e48c..e1008f00609d 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -4045,7 +4045,7 @@ static int kvm_faultin_pfn(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault)
                        return RET_PF_EMULATE;
        }

-       if (fault->is_private) {
+       if (kvm_slot_can_be_private(slot)) {
                r = kvm_faultin_pfn_private(vcpu, fault);
                if (r != RET_PF_CONTINUE)
                        return r == RET_PF_FIXED ? RET_PF_CONTINUE : r;
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 31f704c83099..c5126190fb71 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -583,9 +583,9 @@ struct kvm_memory_slot {
        struct kvm *kvm;
 };

-static inline bool kvm_slot_is_private(const struct kvm_memory_slot *slot)
+static inline bool kvm_slot_can_be_private(const struct kvm_memory_slot *slot)
 {
-       return slot && (slot->flags & KVM_MEM_PRIVATE);
+       return slot && !!slot->private_file;
 }

 static inline bool kvm_slot_dirty_track_enabled(const struct kvm_memory_slot *slot)

