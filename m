Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2DDF4EA3F5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Mar 2022 02:02:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231230AbiC1X54 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 28 Mar 2022 19:57:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231215AbiC1X5y (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 28 Mar 2022 19:57:54 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFEB948E72
        for <linux-fsdevel@vger.kernel.org>; Mon, 28 Mar 2022 16:56:11 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id j13so16110192plj.8
        for <linux-fsdevel@vger.kernel.org>; Mon, 28 Mar 2022 16:56:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=R5oHCy312DV02dgL2mbxc6XsFyRp35/nzV9uAHuDVL8=;
        b=VdeMGDhBvYtE+tVfMkspuND3/7DIoOMPUCVTDtTlEioK4Zp5hqbOfTFDiZt5K44ayS
         fnvlBEdPsoSL7x/DbpE7cgK+SfpEKdBSB73Z0G459wlOPyvqyXpjszHn5jZxV954Y1m+
         kGEdjSVuItAQwgX97aOEemfU1wnkxTdxglSoMzxoatlN8MoeBrVjAW62nJb0oTxRhDev
         ZbdqY4WeMFHrp8BIIgBZ/dpZ8uGNofipq0r54d/7/2DNqRhUnOG6G0byQfKsrs8taS9d
         UJB9bfRxpxBlPxluUE6silYECHfQnTGdtWDbmLuSXWXNy9ykNzkceeJBNRFaESkJx2jL
         vn/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=R5oHCy312DV02dgL2mbxc6XsFyRp35/nzV9uAHuDVL8=;
        b=P4X9bAwCW0jO5gJm8OH6u5ECf79mJ7JUI02MIHuZfQvEo8jxgwqccYSzyidE0/9NXP
         Vo/20HosRj1ncWoZs7Bg4P34yNQGV02jga9r9BJRQ8QEfyYP5tQzci9KPwKha4yQywP4
         Qz6eL7Vnh7D5JRNL/nNxB7Te8Av3XcsTFhMiPpRIpBijXOJcUBW9iIyPTsHzh5wn2Fiq
         nJhPvzoFRDtZTqFm0MJQQyB8usj6rlXDPUpc8AjlyItb/3Z/R9l6Pjw2X3wuLOvgJgI5
         xTU7Dz6ytIvjaRqSc+fyRlQk3ApF4+fk9Z3I708t0Jm3yIsnJQN09TrXEwpe30/xTCth
         hl+A==
X-Gm-Message-State: AOAM532vQKElRzl0oULD/mLX0G1EYKJigjOYiNuNFwUnupY5ngDX3etO
        Bwrin/ezLjk0weOAHxJ2Z8iE3Q==
X-Google-Smtp-Source: ABdhPJwWwKwcbx4mWnZcS0vNwCcr+CGjSoNFeM3hP68m739AGvq4ty6tV34XjWMljTYtL4iWZ09X6A==
X-Received: by 2002:a17:90a:889:b0:1c9:8baa:3eeb with SMTP id v9-20020a17090a088900b001c98baa3eebmr1612687pjc.44.1648511771099;
        Mon, 28 Mar 2022 16:56:11 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id p128-20020a625b86000000b004fa666a1327sm16920043pfb.102.2022.03.28.16.56.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Mar 2022 16:56:10 -0700 (PDT)
Date:   Mon, 28 Mar 2022 23:56:06 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Chao Peng <chao.p.peng@linux.intel.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org, qemu-devel@nongnu.org,
        Paolo Bonzini <pbonzini@redhat.com>,
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
        ak@linux.intel.com, david@redhat.com
Subject: Re: [PATCH v5 08/13] KVM: Use memfile_pfn_ops to obtain pfn for
 private pages
Message-ID: <YkJLFu98hZOvTSrL@google.com>
References: <20220310140911.50924-1-chao.p.peng@linux.intel.com>
 <20220310140911.50924-9-chao.p.peng@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220310140911.50924-9-chao.p.peng@linux.intel.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Mar 10, 2022, Chao Peng wrote:
> @@ -2217,4 +2220,34 @@ static inline void kvm_handle_signal_exit(struct kvm_vcpu *vcpu)
>  /* Max number of entries allowed for each kvm dirty ring */
>  #define  KVM_DIRTY_RING_MAX_ENTRIES  65536
>  
> +#ifdef CONFIG_MEMFILE_NOTIFIER
> +static inline long kvm_memfile_get_pfn(struct kvm_memory_slot *slot, gfn_t gfn,
> +				       int *order)
> +{
> +	pgoff_t index = gfn - slot->base_gfn +
> +			(slot->private_offset >> PAGE_SHIFT);

This is broken for 32-bit kernels, where gfn_t is a 64-bit value but pgoff_t is a
32-bit value.  There's no reason to support this for 32-bit kernels, so...

The easiest fix, and likely most maintainable for other code too, would be to
add a dedicated CONFIG for private memory, and then have KVM check that for all
the memfile stuff.  x86 can then select it only for 64-bit kernels, and in turn
select MEMFILE_NOTIFIER iff private memory is supported.

diff --git a/arch/x86/kvm/Kconfig b/arch/x86/kvm/Kconfig
index ca7b2a6a452a..ee9c8c155300 100644
--- a/arch/x86/kvm/Kconfig
+++ b/arch/x86/kvm/Kconfig
@@ -48,7 +48,9 @@ config KVM
        select SRCU
        select INTERVAL_TREE
        select HAVE_KVM_PM_NOTIFIER if PM
-       select MEMFILE_NOTIFIER
+       select HAVE_KVM_PRIVATE_MEM if X86_64
+       select MEMFILE_NOTIFIER if HAVE_KVM_PRIVATE_MEM
+
        help
          Support hosting fully virtualized guest machines using hardware
          virtualization extensions.  You will need a fairly recent

And in addition to replacing checks on CONFIG_MEMFILE_NOTIFIER, the probing of
whether or not KVM_MEM_PRIVATE is allowed can be:

@@ -1499,23 +1499,19 @@ static void kvm_replace_memslot(struct kvm *kvm,
        }
 }

-bool __weak kvm_arch_private_memory_supported(struct kvm *kvm)
-{
-       return false;
-}
-
 static int check_memory_region_flags(struct kvm *kvm,
                                const struct kvm_userspace_memory_region *mem)
 {
        u32 valid_flags = KVM_MEM_LOG_DIRTY_PAGES;

-       if (kvm_arch_private_memory_supported(kvm))
-               valid_flags |= KVM_MEM_PRIVATE;
-
 #ifdef __KVM_HAVE_READONLY_MEM
        valid_flags |= KVM_MEM_READONLY;
 #endif

+#ifdef CONFIG_KVM_HAVE_PRIVATE_MEM
+       valid_flags |= KVM_MEM_PRIVATE;
+#endif
+
        if (mem->flags & ~valid_flags)
                return -EINVAL;

> +
> +	return slot->pfn_ops->get_lock_pfn(file_inode(slot->private_file),
> +					   index, order);

In a similar vein, get_locK_pfn() shouldn't return a "long".  KVM likely won't use
these APIs on 32-bit kernels, but that may not hold true for other subsystems, and
this code is confusing and technically wrong.  The pfns for struct page squeeze
into an unsigned long because PAE support is capped at 64gb, but casting to a
signed long could result in a pfn with bit 31 set being misinterpreted as an error.

Even returning an "unsigned long" for the pfn is wrong.  It "works" for the shmem
code because shmem deals only with struct page, but it's technically wrong, especially
since one of the selling points of this approach is that it can work without struct
page.

OUT params suck, but I don't see a better option than having the return value be
0/-errno, with "pfn_t *pfn" for the resolved pfn.

> +}
> +
> +static inline void kvm_memfile_put_pfn(struct kvm_memory_slot *slot,
> +				       kvm_pfn_t pfn)
> +{
> +	slot->pfn_ops->put_unlock_pfn(pfn);
> +}
> +
> +#else
> +static inline long kvm_memfile_get_pfn(struct kvm_memory_slot *slot, gfn_t gfn,
> +				       int *order)
> +{

This should be a WARN_ON() as its usage should be guarded by a KVM_PRIVATE_MEM
check, and private memslots should be disallowed in this case.

Alternatively, it might be a good idea to #ifdef these out entirely and not provide
stubs.  That'd likely require a stub or two in arch code, but overall it might be
less painful in the long run, e.g. would force us to more carefully consider the
touch points for private memory.  Definitely not a requirement, just an idea.
