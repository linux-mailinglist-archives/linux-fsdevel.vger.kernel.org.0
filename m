Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2934D47E79F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Dec 2021 19:28:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349836AbhLWS2W (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Dec 2021 13:28:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349669AbhLWS2V (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Dec 2021 13:28:21 -0500
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3401C061756
        for <linux-fsdevel@vger.kernel.org>; Thu, 23 Dec 2021 10:28:20 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id u20so5914900pfi.12
        for <linux-fsdevel@vger.kernel.org>; Thu, 23 Dec 2021 10:28:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=7wTJlpDnuPQgd5sRMIxWsKYDgHKSf1zajdarpvU4BP8=;
        b=H9GE8/0WJSfVCBxwX7YmsYmrxKU20hzA4nFrL46IZE+eyAdGOfha/Hyqv+fNrruNiH
         j47UrLLXJ8JHF1LnXN1xtdMGpicasrVGqe2Udg72b41X/WlEgSQcxUGNRWKMZhnvl1kk
         3WDyAdFxO90rCHZcE+SykfWw9QrBKnSzzqVNJOESgiyblz1n2+WlMP8i8xULzvnvgZq3
         qJY3z77uTuFC0JLdzk0CagQpxhSt1Xlh9vsvyOj/ernZI69DvTf5ZXrCtQaDJfKGbeOn
         0EtsOt4FmEpFAsva/S/zhw2+nA8kW6VZEnFmuTzGG8/Yyvf6BeN2+gncneFq3dp7aqKn
         O57w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7wTJlpDnuPQgd5sRMIxWsKYDgHKSf1zajdarpvU4BP8=;
        b=s3+B1iW/FDsxxLJMslLjQ+5N4aiRTWyv77KTUJzpC02k2imSfO/FBG7UeZEjHm4Uf8
         K0x8DkAplamJqaWBm3I5siOsP3COJLY0J/8Zzy+9lRvn0Z6b89UhVyAg3uTJc7zitEh5
         6XqJAfTSr43M42Ui/mQ/9e2cWHsK/1ImbdrNHq/0hfXnorfq+9SoHtChXOzJ5H9uFxy2
         KJHRB4AQIrHpk8xlWFqAqb/nRNdexVCn61RkV5YTF/4GtnIU8WeTjNoIwxTULXZGb14F
         +OqO10QVuX7xYXPfEricKhMx10niszmPzImrquQs3FgK4ophmGxiuYIui1a7AGHXahOI
         uYag==
X-Gm-Message-State: AOAM530+nkBx5vIakvBmKuYgXTTUimFOGna6/65zCoLlNMWOljwZ1lTp
        9kgzugJhw/OucZkSlz0BRb7VlA==
X-Google-Smtp-Source: ABdhPJwQylY2BbogStT370CePLN112VmFpKu2AtyipMo2sbwznqF9Xp0DeoetP/Z16aer2U7trKPow==
X-Received: by 2002:a62:6184:0:b0:4a2:a063:fe8e with SMTP id v126-20020a626184000000b004a2a063fe8emr3493055pfb.69.1640284100185;
        Thu, 23 Dec 2021 10:28:20 -0800 (PST)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id t21sm5481782pgn.28.2021.12.23.10.28.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Dec 2021 10:28:19 -0800 (PST)
Date:   Thu, 23 Dec 2021 18:28:16 +0000
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
Subject: Re: [PATCH v3 kvm/queue 13/16] KVM: Add KVM_EXIT_MEMORY_ERROR exit
Message-ID: <YcS/wCJnCVooyBMN@google.com>
References: <20211223123011.41044-1-chao.p.peng@linux.intel.com>
 <20211223123011.41044-14-chao.p.peng@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211223123011.41044-14-chao.p.peng@linux.intel.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Dec 23, 2021, Chao Peng wrote:
> This new exit allows user space to handle memory-related errors.
> Currently it supports two types (KVM_EXIT_MEM_MAP_SHARED/PRIVATE) of
> errors which are used for shared memory <-> private memory conversion
> in memory encryption usage.
> 
> After private memory is enabled, there are two places in KVM that can
> exit to userspace to trigger private <-> shared conversion:
>   - explicit conversion: happens when guest explicitly calls into KVM to
>     map a range (as private or shared), KVM then exits to userspace to
>     do the map/unmap operations.
>   - implicit conversion: happens in KVM page fault handler.
>     * if the fault is due to a private memory access then causes a
>       userspace exit for a shared->private conversion request when the
>       page has not been allocated in the private memory backend.
>     * If the fault is due to a shared memory access then causes a
>       userspace exit for a private->shared conversion request when the
>       page has already been allocated in the private memory backend.
> 
> Signed-off-by: Yu Zhang <yu.c.zhang@linux.intel.com>
> Signed-off-by: Chao Peng <chao.p.peng@linux.intel.com>
> ---
>  include/uapi/linux/kvm.h | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
> index 41434322fa23..d68db3b2eeec 100644
> --- a/include/uapi/linux/kvm.h
> +++ b/include/uapi/linux/kvm.h
> @@ -243,6 +243,18 @@ struct kvm_xen_exit {
>  	} u;
>  };
>  
> +struct kvm_memory_exit {
> +#define KVM_EXIT_MEM_MAP_SHARED         1
> +#define KVM_EXIT_MEM_MAP_PRIVATE        2

I don't think the exit should explicitly say "map", it's userspace's decision on
what to do in response to the exit, i. e. describe the properties of the exit,
not what userspace should do in response to the exit.

> +	__u32 type;

Hmm, I think private vs. shared should be a flag, not a type, and should be split
out from the type of error, i.e. !KVM_EXIT_MEMORY_PRIVATE == KVM_EXIT_MEMORY_SHARED.
By error type I mean page fault vs. KVM access vs. ???.  And we'll probably want to
communicate read/write/execute information as well.

To get this uABI right the first time, I think we should implement this support
in advance of this series and wire up all architectures to use the new exit reason
instead of -EFAULT.  It's mostly just page fault handlers, but KVM access to guest
memory, e.g. when reading/writing steal_time, also needs to use this new exit
reason.

Having two __u32s for "error" and "flags" would also pad things so that the __u64s
are correctly aligned.

> +	union {
> +		struct {
> +			__u64 gpa;
> +			__u64 size;
> +		} map;
> +	} u;

I'd strongly prefer to avoid another union, those get nasty when userspace just
wants to dump the info because then the meaning of each field is conditional on
the flags/error.  I don't we'll get _that_ many fields, certainly far fewer than
256 bytes total, so the footprint really isn't an issue.

> +};
> +
>  #define KVM_S390_GET_SKEYS_NONE   1
>  #define KVM_S390_SKEYS_MAX        1048576
>  
> @@ -282,6 +294,7 @@ struct kvm_xen_exit {
>  #define KVM_EXIT_X86_BUS_LOCK     33
>  #define KVM_EXIT_XEN              34
>  #define KVM_EXIT_RISCV_SBI        35
> +#define KVM_EXIT_MEMORY_ERROR     36
>  
>  /* For KVM_EXIT_INTERNAL_ERROR */
>  /* Emulate instruction failed. */
> @@ -499,6 +512,8 @@ struct kvm_run {
>  			unsigned long args[6];
>  			unsigned long ret[2];
>  		} riscv_sbi;
> +		/* KVM_EXIT_MEMORY_ERROR */
> +		struct kvm_memory_exit mem;

As gross as it is to make struct kvm_run super long, I actually prefer the inline
definitions, e.g.

		struct {
			__u32 flags;
			__u32 padding;
			__u64 gpa;
			__u64 size;
		} memory;

>  		/* Fix the size of the union. */
>  		char padding[256];
>  	};
> -- 
> 2.17.1
> 
