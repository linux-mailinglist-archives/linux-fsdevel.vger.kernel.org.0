Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F36E275CB42
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Jul 2023 17:16:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230143AbjGUPQM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 Jul 2023 11:16:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231514AbjGUPQB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 Jul 2023 11:16:01 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 948C230F0
        for <linux-fsdevel@vger.kernel.org>; Fri, 21 Jul 2023 08:14:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689952478;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BrJmJjnrV3+4TK5GKS3+EEIdaYEFXLT6GE196jD6rfg=;
        b=CDsSk9s1/5DYm3LiyePOdaL3snLXKxVUwMmGMlCcE9k0aMCLJByEO2YOt/egccfVNdNFhs
        +9pVwpj8NaOb8sSUxm+fVlm3WsGG+BX5ACFYfv5cA+MXh37P03REGwnFHoJcp/OKlUr7k/
        LI5cUa232Jt3Iz486Z5A85UHreaURk4=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-74-3vbWzc5RM2KTj53nr1MOWQ-1; Fri, 21 Jul 2023 11:14:36 -0400
X-MC-Unique: 3vbWzc5RM2KTj53nr1MOWQ-1
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-4fb7d06a7e6so2074813e87.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 21 Jul 2023 08:14:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689952475; x=1690557275;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BrJmJjnrV3+4TK5GKS3+EEIdaYEFXLT6GE196jD6rfg=;
        b=fphBAOZkMLe7Brl0hMFZa848D+71WhrnK3rRJrrSe3TgEKsLSHjscD+6DgGSwx8d7f
         VTBZ4oZauCWA7NalQN3IQyhkNOYKIrQxhbXsbwFuS82D3x0Nl9Y/eLjjtLB4OrNtFUL7
         PYrQ6LF7Ys95WH7yIpXlq4qvV2xMPRBLy+2kPSvyZgq17PfI5WLW7jrte3brPikZiON2
         Yex8wHCiApe5QnLyvePkAwa/6fS5EkFeTkuhi5CH9W77+2G/8k5v8bb0XXQH85YrH8Ms
         tXF72/8sdFoJ8hBvDPhylSqxLIlHisBjj6o66Rw6hdESWV49yXpfS4E46lqYKh2/BB6h
         vZrA==
X-Gm-Message-State: ABy/qLaXXVUWGGcDnjMM25/5kurEM/ktPl3IDHuEy3kfVxZyct8MCj+9
        JhW7gUk4lSzKTh/ySTbA4r70fWiDO+ySVO52PwCkfBcJ+anK5EaVai9xTnjU7UOQgjwG8eBw2Ts
        FmWp8armNID/ahdZbNLbFaIYyNw==
X-Received: by 2002:a05:6512:1150:b0:4f8:661f:60a4 with SMTP id m16-20020a056512115000b004f8661f60a4mr1702759lfg.41.1689952475202;
        Fri, 21 Jul 2023 08:14:35 -0700 (PDT)
X-Google-Smtp-Source: APBJJlEY792MHWkKnplUr0Vx4lx09FEkAsdfsZuVIi7WtMfQ0gFs1YquUiOv8dJt4JtZPtFNMSuP/g==
X-Received: by 2002:a05:6512:1150:b0:4f8:661f:60a4 with SMTP id m16-20020a056512115000b004f8661f60a4mr1702736lfg.41.1689952474795;
        Fri, 21 Jul 2023 08:14:34 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:9af8:e5f5:7516:fa89? ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
        by smtp.googlemail.com with ESMTPSA id l23-20020a056402345700b00521d2cf5f3bsm2224721edc.96.2023.07.21.08.14.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Jul 2023 08:14:34 -0700 (PDT)
Message-ID: <75f13a8a-132f-99ee-d3c6-24a12f2f23d5@redhat.com>
Date:   Fri, 21 Jul 2023 17:14:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [RFC PATCH v11 18/29] KVM: selftests: Drop unused
 kvm_userspace_memory_region_find() helper
Content-Language: en-US
To:     Sean Christopherson <seanjc@google.com>,
        Marc Zyngier <maz@kernel.org>,
        Oliver Upton <oliver.upton@linux.dev>,
        Huacai Chen <chenhuacai@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Anup Patel <anup@brainfault.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Paul Moore <paul@paul-moore.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>
Cc:     kvm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kvmarm@lists.linux.dev, linux-mips@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, kvm-riscv@lists.infradead.org,
        linux-riscv@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Chao Peng <chao.p.peng@linux.intel.com>,
        Fuad Tabba <tabba@google.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Yu Zhang <yu.c.zhang@linux.intel.com>,
        Vishal Annapurve <vannapurve@google.com>,
        Ackerley Tng <ackerleytng@google.com>,
        Maciej Szmigiero <mail@maciej.szmigiero.name>,
        Vlastimil Babka <vbabka@suse.cz>,
        David Hildenbrand <david@redhat.com>,
        Quentin Perret <qperret@google.com>,
        Michael Roth <michael.roth@amd.com>,
        Wang <wei.w.wang@intel.com>,
        Liam Merwick <liam.merwick@oracle.com>,
        Isaku Yamahata <isaku.yamahata@gmail.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
References: <20230718234512.1690985-1-seanjc@google.com>
 <20230718234512.1690985-19-seanjc@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <20230718234512.1690985-19-seanjc@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 7/19/23 01:45, Sean Christopherson wrote:
> Drop kvm_userspace_memory_region_find(), it's unused and a terrible API
> (probably why it's unused).  If anything outside of kvm_util.c needs to
> get at the memslot, userspace_mem_region_find() can be exposed to give
> others full access to all memory region/slot information.
> 
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>   .../selftests/kvm/include/kvm_util_base.h     |  4 ---
>   tools/testing/selftests/kvm/lib/kvm_util.c    | 29 -------------------
>   2 files changed, 33 deletions(-)
> 
> diff --git a/tools/testing/selftests/kvm/include/kvm_util_base.h b/tools/testing/selftests/kvm/include/kvm_util_base.h
> index 07732a157ccd..6aeb008dd668 100644
> --- a/tools/testing/selftests/kvm/include/kvm_util_base.h
> +++ b/tools/testing/selftests/kvm/include/kvm_util_base.h
> @@ -753,10 +753,6 @@ vm_adjust_num_guest_pages(enum vm_guest_mode mode, unsigned int num_guest_pages)
>   	return n;
>   }
>   
> -struct kvm_userspace_memory_region *
> -kvm_userspace_memory_region_find(struct kvm_vm *vm, uint64_t start,
> -				 uint64_t end);
> -
>   #define sync_global_to_guest(vm, g) ({				\
>   	typeof(g) *_p = addr_gva2hva(vm, (vm_vaddr_t)&(g));	\
>   	memcpy(_p, &(g), sizeof(g));				\
> diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
> index 9741a7ff6380..45d21e052db0 100644
> --- a/tools/testing/selftests/kvm/lib/kvm_util.c
> +++ b/tools/testing/selftests/kvm/lib/kvm_util.c
> @@ -586,35 +586,6 @@ userspace_mem_region_find(struct kvm_vm *vm, uint64_t start, uint64_t end)
>   	return NULL;
>   }
>   
> -/*
> - * KVM Userspace Memory Region Find
> - *
> - * Input Args:
> - *   vm - Virtual Machine
> - *   start - Starting VM physical address
> - *   end - Ending VM physical address, inclusive.
> - *
> - * Output Args: None
> - *
> - * Return:
> - *   Pointer to overlapping region, NULL if no such region.
> - *
> - * Public interface to userspace_mem_region_find. Allows tests to look up
> - * the memslot datastructure for a given range of guest physical memory.
> - */
> -struct kvm_userspace_memory_region *
> -kvm_userspace_memory_region_find(struct kvm_vm *vm, uint64_t start,
> -				 uint64_t end)
> -{
> -	struct userspace_mem_region *region;
> -
> -	region = userspace_mem_region_find(vm, start, end);
> -	if (!region)
> -		return NULL;
> -
> -	return &region->region;
> -}
> -
>   __weak void vcpu_arch_free(struct kvm_vcpu *vcpu)
>   {
>   

Will queue this.

Paolo

