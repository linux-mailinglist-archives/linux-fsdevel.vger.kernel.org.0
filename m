Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A23304EA31F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Mar 2022 00:41:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229822AbiC1WfZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 28 Mar 2022 18:35:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229928AbiC1WfX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 28 Mar 2022 18:35:23 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9D4526F3
        for <linux-fsdevel@vger.kernel.org>; Mon, 28 Mar 2022 15:33:41 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id y10so10827760pfa.7
        for <linux-fsdevel@vger.kernel.org>; Mon, 28 Mar 2022 15:33:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=2ABviws9BXbfxTsMHoYmEcQBLN3yu8stMpTqnw9eDk8=;
        b=rYUjTKzGOFHx6d15Tswooja+d30xBTDDUHatG0/ZcYrDXuH0PfkjhUH1PWeOTfidl+
         vYJIWPT6oxLsddoyOabTrOO1tVAq7mc/vYWGRF/xHT6Zkm9YinxTH/0vsmRSLsdzVkKr
         6pd96qJfscL7yKbX4y+A5Mu5s1jsgn8U+dy5S4ZqCvCfco0t//embRohXdJdoJUpkoR/
         +rAdfVLcRZcp7qqE5ZtyTqie24GhbftV5PTRJAHm1SFW93aYXxALqSwG5/AMgSwMco3+
         dtnGSwv8eE42JLUTvRoXFyxnboBZbMprh1RRTGVK+iAeHGKfsjUevmvmc+QSSrVtaClB
         o0gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2ABviws9BXbfxTsMHoYmEcQBLN3yu8stMpTqnw9eDk8=;
        b=b3a/n/OBUvgK0JfvCNQnGMh59ssZUVXxjbP+pWbE83ux0WeONFnK/WTBSsALphAUa8
         AD8w4UGfz/o/AXj22mYCo3LtsMSVD9YbIhMkFbibv8VPiYAOXdEP7V0HlFSE3lCcYzSK
         X3ChjbUwFv7c2BHXZkNx+PhuOx25RTuT04VkSce4+cAVq+kXntedV5D5GQ0TorMZyoai
         sxN65ulrfMi+kGKr3La2pGXsLqOZn6Z07zQyiXdqYDBhXqQoVp1ju9bRLyvhQ6aFxaqd
         zQ3KLWdEwZxh5kAb5BagVIc5AYQx66Awc36wXDqhnymYlhGtYPEUlXxtnnSQM7Vu0nao
         glOQ==
X-Gm-Message-State: AOAM530TCQPKiZjjmvrS8Eh+C+4urJg0Gv1T7kjzr8rNTSd31K5yOsZ5
        FLwHhqCttIfpnWe5KF7hUA7S5REuJY8t+g==
X-Google-Smtp-Source: ABdhPJwxvlht5QIP7qnxQ/NrpyslimX+9K7yNm7qbqA6RcGg490QKIvotfYQ+yrSTDNk0Bag7lNL6A==
X-Received: by 2002:a05:6a00:21c8:b0:4c4:4bd:dc17 with SMTP id t8-20020a056a0021c800b004c404bddc17mr24814255pfj.57.1648506821242;
        Mon, 28 Mar 2022 15:33:41 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id 22-20020a17090a019600b001c6457e1760sm479337pjc.21.2022.03.28.15.33.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Mar 2022 15:33:40 -0700 (PDT)
Date:   Mon, 28 Mar 2022 22:33:37 +0000
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
Subject: Re: [PATCH v5 07/13] KVM: Add KVM_EXIT_MEMORY_ERROR exit
Message-ID: <YkI3wa3rmWTOrpmw@google.com>
References: <20220310140911.50924-1-chao.p.peng@linux.intel.com>
 <20220310140911.50924-8-chao.p.peng@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220310140911.50924-8-chao.p.peng@linux.intel.com>
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
> This new KVM exit allows userspace to handle memory-related errors. It
> indicates an error happens in KVM at guest memory range [gpa, gpa+size).
> The flags includes additional information for userspace to handle the
> error. Currently bit 0 is defined as 'private memory' where '1'
> indicates error happens due to private memory access and '0' indicates
> error happens due to shared memory access.
> 
> After private memory is enabled, this new exit will be used for KVM to
> exit to userspace for shared memory <-> private memory conversion in
> memory encryption usage.
> 
> In such usage, typically there are two kind of memory conversions:
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
>  Documentation/virt/kvm/api.rst | 22 ++++++++++++++++++++++
>  include/uapi/linux/kvm.h       |  9 +++++++++
>  2 files changed, 31 insertions(+)
> 
> diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
> index f76ac598606c..bad550c2212b 100644
> --- a/Documentation/virt/kvm/api.rst
> +++ b/Documentation/virt/kvm/api.rst
> @@ -6216,6 +6216,28 @@ array field represents return values. The userspace should update the return
>  values of SBI call before resuming the VCPU. For more details on RISC-V SBI
>  spec refer, https://github.com/riscv/riscv-sbi-doc.
>  
> +::
> +
> +		/* KVM_EXIT_MEMORY_ERROR */
> +		struct {
> +  #define KVM_MEMORY_EXIT_FLAG_PRIVATE	(1 << 0)
> +			__u32 flags;
> +			__u32 padding;
> +			__u64 gpa;
> +			__u64 size;
> +		} memory;
> +If exit reason is KVM_EXIT_MEMORY_ERROR then it indicates that the VCPU has

Doh, I'm pretty sure I suggested KVM_EXIT_MEMORY_ERROR.  Any objection to using
KVM_EXIT_MEMORY_FAULT instead of KVM_EXIT_MEMORY_ERROR?  "ERROR" makes me think
of ECC errors, i.e. uncorrected #MC in x86 land, not more generic "faults".  That
would align nicely with -EFAULT.

> +encountered a memory error which is not handled by KVM kernel module and
> +userspace may choose to handle it. The 'flags' field indicates the memory
> +properties of the exit.
