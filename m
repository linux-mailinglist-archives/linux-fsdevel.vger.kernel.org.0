Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D5BD6AFAE9
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Mar 2023 01:13:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229750AbjCHANb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Mar 2023 19:13:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbjCHAN3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Mar 2023 19:13:29 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07AAB51FA7
        for <linux-fsdevel@vger.kernel.org>; Tue,  7 Mar 2023 16:13:27 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id k6-20020a25e806000000b00a623fca0d0aso15900724ybd.16
        for <linux-fsdevel@vger.kernel.org>; Tue, 07 Mar 2023 16:13:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678234406;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=mmMlzzjnms9LP64W1EI4s9J2Aar/VS+/OpXG4YzMt1g=;
        b=DQipY5o6kwt2urMmc3ga0lGBCwLobU1Ifep42NoUNsZIX8Td2En8TfxAl5sbGzyNBB
         LIWsf3t77LSuCc0pGvjcZjIWULi+KlePCMmeN/QbMHXhC1Ixa4kOh+7152WsxGf2VC2d
         Ms1xKb6gHNm+/4O8RDcSjT+AzBbqUzpwW93RRiqm6+BJSL4+2HqKul5reyJxS2qUjQVn
         TjBmoEh1iNCS+lDVRczhTC0nw7EmFFlXj/fUYAlIAjyVh4kOpH9EZLnti4uHp00WyheW
         Vcv6eAX7BJrGIniLd7INUu4OdKbDatMzJF7cbOv0xYoxbaZDVLO31xC6G1jgMlMxSBxo
         JYtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678234406;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mmMlzzjnms9LP64W1EI4s9J2Aar/VS+/OpXG4YzMt1g=;
        b=tMi8CTpeuEDo1dnEBfjnEF3AaIdgI9TVWQIrTs71bD5mO2n08lLxBOfvEf7+hHaFsW
         jawrGGqsusp6P/XiG02NJ2CRr7jqrrBIyJVsxoAWyFu7XByb/0juRND596073S3++Ogw
         lrYS55Dx6uajojLC69gCKXt4ZPflrrsRA3rN/EmXN6gJxUuGQyxD+vkpOFZukEC1Ak9l
         PWcGI7rva3FOJ5SIq95gavhpL9IfARyzzwgTwQOaKss0DtbXTHhVnjnFuQr5SPXWlyhj
         SDtBbyX46rfXjP4eRk+aVhcm1SO5+wFTeW6oF+AB7f/c0aoCveFzppcj7V0ROqsaXI5M
         WYIg==
X-Gm-Message-State: AO0yUKWd/WochtVoERgAUTWX1mLrhBnp8P9GI17yFbDugzStFaoaFRs1
        OzKRteY4PJ8Rp/3pvTT26JnlOvEvlplFLfwJkg==
X-Google-Smtp-Source: AK7set9fM9oqHN6RTfjUl1adN2jlRFEqmkZWFcTMizE5EgbRXDHz1eOesgkblPkKuD6/cVScAGsGMu92G3PJwAt7ew==
X-Received: from ackerleytng-cloudtop.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:1f5f])
 (user=ackerleytng job=sendgmr) by 2002:a05:6902:145:b0:ac2:a7a7:23c3 with
 SMTP id p5-20020a056902014500b00ac2a7a723c3mr5937614ybh.12.1678234406173;
 Tue, 07 Mar 2023 16:13:26 -0800 (PST)
Date:   Wed, 08 Mar 2023 00:13:24 +0000
In-Reply-To: <20230128140030.GB700688@chaop.bj.intel.com> (message from Chao
 Peng on Sat, 28 Jan 2023 22:00:30 +0800)
Mime-Version: 1.0
Message-ID: <diqz5ybc3xsr.fsf@ackerleytng-cloudtop.c.googlers.com>
Subject: Re: [PATCH v10 9/9] KVM: Enable and expose KVM_MEM_PRIVATE
From:   Ackerley Tng <ackerleytng@google.com>
To:     Chao Peng <chao.p.peng@linux.intel.com>
Cc:     seanjc@google.com, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-api@vger.kernel.org, linux-doc@vger.kernel.org,
        qemu-devel@nongnu.org, pbonzini@redhat.com, corbet@lwn.net,
        vkuznets@redhat.com, wanpengli@tencent.com, jmattson@google.com,
        joro@8bytes.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, arnd@arndb.de, naoya.horiguchi@nec.com,
        linmiaohe@huawei.com, x86@kernel.org, hpa@zytor.com,
        hughd@google.com, jlayton@kernel.org, bfields@fieldses.org,
        akpm@linux-foundation.org, shuah@kernel.org, rppt@kernel.org,
        steven.price@arm.com, mail@maciej.szmigiero.name, vbabka@suse.cz,
        vannapurve@google.com, yu.c.zhang@linux.intel.com,
        kirill.shutemov@linux.intel.com, luto@kernel.org,
        jun.nakajima@intel.com, dave.hansen@intel.com, ak@linux.intel.com,
        david@redhat.com, aarcange@redhat.com, ddutile@redhat.com,
        dhildenb@redhat.com, qperret@google.com, tabba@google.com,
        michael.roth@amd.com, mhocko@suse.com, wei.w.wang@intel.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Chao Peng <chao.p.peng@linux.intel.com> writes:

> On Sat, Jan 14, 2023 at 12:01:01AM +0000, Sean Christopherson wrote:
>> On Fri, Dec 02, 2022, Chao Peng wrote:
> ...
>> Strongly prefer to use similar logic to existing code that detects wraps:

>> 		mem->restricted_offset + mem->memory_size < mem->restricted_offset

>> This is also where I'd like to add the "gfn is aligned to offset" check,  
>> though
>> my brain is too fried to figure that out right now.

> Used count_trailing_zeros() for this TODO, unsure we have other better
> approach.

> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> index afc8c26fa652..fd34c5f7cd2f 100644
> --- a/virt/kvm/kvm_main.c
> +++ b/virt/kvm/kvm_main.c
> @@ -56,6 +56,7 @@
>   #include <asm/processor.h>
>   #include <asm/ioctl.h>
>   #include <linux/uaccess.h>
> +#include <linux/count_zeros.h>

>   #include "coalesced_mmio.h"
>   #include "async_pf.h"
> @@ -2087,6 +2088,19 @@ static bool kvm_check_memslot_overlap(struct  
> kvm_memslots *slots, int id,
>   	return false;
>   }

> +/*
> + * Return true when ALIGNMENT(offset) >= ALIGNMENT(gpa).
> + */
> +static bool kvm_check_rmem_offset_alignment(u64 offset, u64 gpa)
> +{
> +	if (!offset)
> +		return true;
> +	if (!gpa)
> +		return false;
> +
> +	return !!(count_trailing_zeros(offset) >= count_trailing_zeros(gpa));

Perhaps we could do something like

#define lowest_set_bit(val) (val & -val)

and use

return lowest_set_bit(offset) >= lowest_set_bit(gpa);

Please help me to understand: why must ALIGNMENT(offset) >=
ALIGNMENT(gpa)? Why is it not sufficient to have both gpa and offset be
aligned to PAGE_SIZE?

> +}
> +
>   /*
>    * Allocate some memory and give it an address in the guest physical  
> address
>    * space.
> @@ -2128,7 +2142,8 @@ int __kvm_set_memory_region(struct kvm *kvm,
>   	if (mem->flags & KVM_MEM_PRIVATE &&
>   	    (mem->restrictedmem_offset & (PAGE_SIZE - 1) ||
>   	     mem->restrictedmem_offset + mem->memory_size <  
> mem->restrictedmem_offset ||
> -	     0 /* TODO: require gfn be aligned with restricted offset */))
> +	     !kvm_check_rmem_offset_alignment(mem->restrictedmem_offset,
> +					      mem->guest_phys_addr)))
>   		return -EINVAL;
>   	if (as_id >= kvm_arch_nr_memslot_as_ids(kvm) || id >= KVM_MEM_SLOTS_NUM)
>   		return -EINVAL;
