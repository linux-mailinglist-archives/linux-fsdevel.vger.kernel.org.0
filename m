Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C34D47E7A8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Dec 2021 19:34:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349722AbhLWSe1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Dec 2021 13:34:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240285AbhLWSe1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Dec 2021 13:34:27 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1DBCC061401
        for <linux-fsdevel@vger.kernel.org>; Thu, 23 Dec 2021 10:34:26 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id z3so4984513plg.8
        for <linux-fsdevel@vger.kernel.org>; Thu, 23 Dec 2021 10:34:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=wgoegRi5bG9RfU6sMp0VEJxN3NnOXgdV/DTIFT/FP9s=;
        b=L+zXpuXCNgLWcMvoCH32XVHU3LmaAvryhek/ia9zaFUu0ZSn7rADevGixqyB2soisL
         lb8sy3eZ0Qb13+uIbTieaElB9/eNeY1LdDq+a6B1I4SCMgjk8KynVB6mC3VxCjS62dVR
         shouleL8Xc9cW4Wz78SXSVxVyqQLoN4F0NG+DvAR8pOfjTfWeQzVKxXB0o9Pq4oNeD2u
         D/l3mjhlcj2MVLlMZngH+SksfEZR9/1Wk/yngiydrBqbgLH3qAIjqS5gEc7eeKDfOTuB
         avLlOIlX+XDpMaVWp30QaJoxFQY/I8sNhRtyyMDPfKjd8Jl1YaMQ7pZgNNA9C4UmrgVB
         9akA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wgoegRi5bG9RfU6sMp0VEJxN3NnOXgdV/DTIFT/FP9s=;
        b=kUL2E8vxoxrYYSjhBzxu2ylexTj4SCKE/WBNnngViDCw2BMBqqAQn0/YFM7UYxJNX4
         ITdy1yySBmpFr0v6OB5B4R7AZZPSIF428TwT/Wt1YKG88c83P6WvAiofCB32CAn9QzT3
         hqE8JMcPov7DeDBNpa4EqWcv8rwbnqEL1Ya5ablpq1zh8UpmBJ3mNwXfCVickTUC2leT
         hadGaehIaWjHN2DiQhZ+MaZRYSB6RmYtZag3Ue+0/pS+bwz4Pq4Q/rJxiXepbMcHqfo4
         ZFMLbWe5nftZIShZVSyN9OBsGNCu3Un8LR46eKIEf1pDDU0Bajk/5hLm8Mzf7gyTaC25
         F0iQ==
X-Gm-Message-State: AOAM532J+m6gbOzU/KzAFQOfgG6tgrG6CatAsQv9V8UWb3Hn/dWM8D7N
        tBY316uk8To/6vSihjlZwRJFKw==
X-Google-Smtp-Source: ABdhPJymsNE7J9ptKr2BtgChAzAfQEzAGp2WzRVvToHDYcXxBbfV5GZE58CrgE/W67Py/7kxVbiHvg==
X-Received: by 2002:a17:90a:c58f:: with SMTP id l15mr3967558pjt.227.1640284466086;
        Thu, 23 Dec 2021 10:34:26 -0800 (PST)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id k6sm6898801pff.17.2021.12.23.10.34.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Dec 2021 10:34:25 -0800 (PST)
Date:   Thu, 23 Dec 2021 18:34:22 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Chao Peng <chao.p.peng@linux.intel.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
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
        Yu Zhang <yu.c.zhang@linux.intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        luto@kernel.org, john.ji@intel.com, susie.li@intel.com,
        jun.nakajima@intel.com, dave.hansen@intel.com, ak@linux.intel.com,
        david@redhat.com
Subject: Re: [PATCH v3 kvm/queue 06/16] KVM: Implement fd-based memory using
 MEMFD_OPS interfaces
Message-ID: <YcTBLpVlETdI8JHi@google.com>
References: <20211223123011.41044-1-chao.p.peng@linux.intel.com>
 <20211223123011.41044-7-chao.p.peng@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211223123011.41044-7-chao.p.peng@linux.intel.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Dec 23, 2021, Chao Peng wrote:
> diff --git a/arch/x86/kvm/Kconfig b/arch/x86/kvm/Kconfig
> index 03b2ce34e7f4..86655cd660ca 100644
> --- a/arch/x86/kvm/Kconfig
> +++ b/arch/x86/kvm/Kconfig
> @@ -46,6 +46,7 @@ config KVM
>  	select SRCU
>  	select INTERVAL_TREE
>  	select HAVE_KVM_PM_NOTIFIER if PM
> +	select MEMFD_OPS

MEMFD_OPS is a weird Kconfig name given that it's not just memfd() that can
implement the ops.

>  	help
>  	  Support hosting fully virtualized guest machines using hardware
>  	  virtualization extensions.  You will need a fairly recent
> diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
> index 3bd875f9669f..21f8b1880723 100644
> --- a/include/linux/kvm_host.h
> +++ b/include/linux/kvm_host.h
> @@ -806,6 +806,12 @@ static inline void kvm_irqfd_exit(void)
>  {
>  }
>  #endif
> +
> +int kvm_memfd_register(struct kvm *kvm, struct kvm_memory_slot *slot);
> +void kvm_memfd_unregister(struct kvm_memory_slot *slot);
> +long kvm_memfd_get_pfn(struct kvm_memory_slot *slot, gfn_t gfn, int *order);
> +void kvm_memfd_put_pfn(kvm_pfn_t pfn);
> +
>  int kvm_init(void *opaque, unsigned vcpu_size, unsigned vcpu_align,
>  		  struct module *module);
>  void kvm_exit(void);
> diff --git a/virt/kvm/Makefile.kvm b/virt/kvm/Makefile.kvm
> index ffdcad3cc97a..8842128d8429 100644
> --- a/virt/kvm/Makefile.kvm
> +++ b/virt/kvm/Makefile.kvm
> @@ -5,7 +5,7 @@
>  
>  KVM ?= ../../../virt/kvm
>  
> -kvm-y := $(KVM)/kvm_main.o $(KVM)/eventfd.o $(KVM)/binary_stats.o
> +kvm-y := $(KVM)/kvm_main.o $(KVM)/eventfd.o $(KVM)/binary_stats.o $(KVM)/memfd.o

This should be

   kvm-$(CONFIG_MEMFD_OPS) += $(KVM)/memfd.o

with stubs provided in a header file as needed.  I also really dislike naming KVM's
file memfd.c, though I don't have a good alternative off the top of my head.

>  kvm-$(CONFIG_KVM_VFIO) += $(KVM)/vfio.o
>  kvm-$(CONFIG_KVM_MMIO) += $(KVM)/coalesced_mmio.o
>  kvm-$(CONFIG_KVM_ASYNC_PF) += $(KVM)/async_pf.o


> +#ifdef CONFIG_MEMFD_OPS
> +static const struct memfd_pfn_ops *memfd_ops;

memfd_ops needs to be associated with the slot, e.g. userspace should be able to
map multiple types of a backing stores into a single VM.  This doesn't even allow
that for multiple VMs, and there are all kinds of ordering issues.

> +void kvm_memfd_unregister(struct kvm_memory_slot *slot)
> +{
> +#ifdef CONFIG_MEMFD_OPS
> +	if (slot->file) {
> +		fput(slot->file);

Needs to actually unregister.

> +		slot->file = NULL;
> +	}
> +#endif
> +}
> -- 
> 2.17.1
> 
