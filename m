Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F25CF4EA277
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Mar 2022 23:34:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229978AbiC1VaK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 28 Mar 2022 17:30:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbiC1VaI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 28 Mar 2022 17:30:08 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 531905FE5
        for <linux-fsdevel@vger.kernel.org>; Mon, 28 Mar 2022 14:28:18 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id mp6-20020a17090b190600b001c6841b8a52so412004pjb.5
        for <linux-fsdevel@vger.kernel.org>; Mon, 28 Mar 2022 14:28:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=WVVxBxlyVCxS7vEDq6k+BkZvn5usLnrTMDhIOyfoQRA=;
        b=F3l3l0SrNcazav4z9RryKfjHbpu2VZCStqEvabNnrpQsKduUOQ3GJ4YLD/Bnt3UC53
         9gigw6DRFNxzp6Tn0uRX1OSxCzSfPN1szWmGrwz4vNHvV9VLYO4WmYDXdPaWdH8TblyA
         El5pN/YNKIMy+iw6lu+xed7E4QwRzAZ0FR3pSWjUWLUUPJwMVJMtE8E6wGN4E5LNs8u0
         yM55QJ2oVDQAWknXjyDPGA1Gh8t7X0l+yW2q0hEFkIUxZQxSu7VSEXhtFwFrkoLq0Y0h
         pW8wbdUJiuzKmB2oEiRn9NUOZIq9e6JfKX2gwfUvAStK/w8sCzYOPevQeMdOmxmqtm3Z
         UnEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=WVVxBxlyVCxS7vEDq6k+BkZvn5usLnrTMDhIOyfoQRA=;
        b=b0tECGvY/xXDf23osaTFIIVKYOgaTMMEgjoh6GFHti4iI2KqKzj0C2whvIkjnV8c4s
         U2xHMZJCztyYcPOnK0ZNB1vU9P10sCt+n/JzHw0iqCcP45RNS5npRSyRiZptAma0v/7w
         NbkS+uk7sVlP6IAUwSz93M1EeQGiQEIQ/XQFcFY+g5D0CKfL1HLtwqEuyYz/jMFCYRwV
         VthlJXBhGro+ERdqFSe4sb3yR+f8eQFpV/Aci9k1GrNN8WXxHwFBVduhaBsQtPUZJjkn
         RcEpUkStNvXTnJWYC+V0zQV9zQZ1PchdM6XdMphpp0XNIGvdPvxxiUgtm45Q+qk29MBs
         vW7w==
X-Gm-Message-State: AOAM533fGKUAonXvNheGC3CbiAKFREym4dFNkFfz6L4M6jEhN5D1Ptjk
        +Ldzci40cK5DUbSgzeAJ0BDD1w==
X-Google-Smtp-Source: ABdhPJwWeZMb9Wt1LCrjPclYKOZxIau/iyRcg9FuFBqfs0Ro5aFT1BqcZ/SiNPFqKlNMwaMh8+jAOw==
X-Received: by 2002:a17:903:2288:b0:153:bfbe:7354 with SMTP id b8-20020a170903228800b00153bfbe7354mr27601061plh.112.1648502856956;
        Mon, 28 Mar 2022 14:27:36 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id 22-20020a17090a019600b001c6457e1760sm410018pjc.21.2022.03.28.14.27.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Mar 2022 14:27:36 -0700 (PDT)
Date:   Mon, 28 Mar 2022 21:27:32 +0000
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
Subject: Re: [PATCH v5 05/13] KVM: Extend the memslot to support fd-based
 private memory
Message-ID: <YkIoRDNbwJH/IDeC@google.com>
References: <20220310140911.50924-1-chao.p.peng@linux.intel.com>
 <20220310140911.50924-6-chao.p.peng@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220310140911.50924-6-chao.p.peng@linux.intel.com>
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

On Thu, Mar 10, 2022, Chao Peng wrote:
> Extend the memslot definition to provide fd-based private memory support
> by adding two new fields (private_fd/private_offset). The memslot then
> can maintain memory for both shared pages and private pages in a single
> memslot. Shared pages are provided by existing userspace_addr(hva) field
> and private pages are provided through the new private_fd/private_offset
> fields.
> 
> Since there is no 'hva' concept anymore for private memory so we cannot
> rely on get_user_pages() to get a pfn, instead we use the newly added
> memfile_notifier to complete the same job.
> 
> This new extension is indicated by a new flag KVM_MEM_PRIVATE.
> 
> Signed-off-by: Yu Zhang <yu.c.zhang@linux.intel.com>

Needs a Co-developed-by: for Yu, or a From: if Yu is the sole author.

> Signed-off-by: Chao Peng <chao.p.peng@linux.intel.com>
> ---
>  Documentation/virt/kvm/api.rst | 37 +++++++++++++++++++++++++++-------
>  include/linux/kvm_host.h       |  7 +++++++
>  include/uapi/linux/kvm.h       |  8 ++++++++
>  3 files changed, 45 insertions(+), 7 deletions(-)
> 
> diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
> index 3acbf4d263a5..f76ac598606c 100644
> --- a/Documentation/virt/kvm/api.rst
> +++ b/Documentation/virt/kvm/api.rst
> @@ -1307,7 +1307,7 @@ yet and must be cleared on entry.
>  :Capability: KVM_CAP_USER_MEMORY
>  :Architectures: all
>  :Type: vm ioctl
> -:Parameters: struct kvm_userspace_memory_region (in)
> +:Parameters: struct kvm_userspace_memory_region(_ext) (in)
>  :Returns: 0 on success, -1 on error
>  
>  ::
> @@ -1320,9 +1320,17 @@ yet and must be cleared on entry.
>  	__u64 userspace_addr; /* start of the userspace allocated memory */
>    };
>  
> +  struct kvm_userspace_memory_region_ext {
> +	struct kvm_userspace_memory_region region;
> +	__u64 private_offset;
> +	__u32 private_fd;
> +	__u32 padding[5];

Uber nit, I'd prefer we pad u32 for private_fd separate from padding the size of
the structure for future expansion.

Regarding future expansion, any reason not to go crazy and pad like 128+ bytes?
It'd be rather embarassing if the next memslot extension needs 3 u64s and we end
up with region_ext2 :-)

> +};
> +
>    /* for kvm_memory_region::flags */
>    #define KVM_MEM_LOG_DIRTY_PAGES	(1UL << 0)
>    #define KVM_MEM_READONLY	(1UL << 1)
> +  #define KVM_MEM_PRIVATE		(1UL << 2)
>  
>  This ioctl allows the user to create, modify or delete a guest physical
>  memory slot.  Bits 0-15 of "slot" specify the slot id and this value

...

> +static inline bool kvm_slot_is_private(const struct kvm_memory_slot *slot)

I 100% think we should usurp the name "private" for these memslots, but as prep
work this series should first rename KVM_PRIVATE_MEM_SLOTS to avoid confusion.
Maybe KVM_INTERNAL_MEM_SLOTS?
