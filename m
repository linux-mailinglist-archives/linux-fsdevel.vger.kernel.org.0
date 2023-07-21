Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68E6E75C25E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Jul 2023 11:04:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231180AbjGUJEq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 Jul 2023 05:04:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230093AbjGUJEo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 Jul 2023 05:04:44 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3379AE74
        for <linux-fsdevel@vger.kernel.org>; Fri, 21 Jul 2023 02:03:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689930237;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UkppB3amY8e+ZFUORFAPfGoR63QBz1mTawh0tzwUFzU=;
        b=LQP6XBILE98E9vsC1vDQTB4+jRvd/3e8SnMSohe/gtMVLoozMI1Al33V79jIwfp1dj5ZuN
        JzloFMiUXpT332GcmJj3Jz8J3ObnmzpccY3lKEMFMthaMNNUYTmZnH3bMxgYjsKMZzA2uy
        xTCduHU3SD6pjlA2cN4bltSuiSwDTPE=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-296-_IzcV-qvPrONzkNcls_kVQ-1; Fri, 21 Jul 2023 05:03:56 -0400
X-MC-Unique: _IzcV-qvPrONzkNcls_kVQ-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-993c24f3246so206747866b.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 21 Jul 2023 02:03:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689930235; x=1690535035;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UkppB3amY8e+ZFUORFAPfGoR63QBz1mTawh0tzwUFzU=;
        b=Rco9vRZ6VRiQ9etvE3k1hjtiw5PIguLPvMmjiFPECpTFl//2Q6KSkI4WgcgDFMryO0
         bpwSL6oYgfTIzbCKYZsGF5iWrDcGF6hbJoWANV7u5nIzJbsilCrSpgrBnP2B3TuI6IZW
         WGREjphN0C59ujPQoLl31ZnkqgPpeSpj855dj+Y40Fazx4C7okPzSv6jtvA/fA8QlReJ
         3FxnYWEeoCfn0AzS+wWuqHBC0c7q5hDcknHKb8ZYqRBMgEsmpAcbf7jp0RgDmaivWGAD
         vCGHWm3ZKNit2ebAVHFwSTuNlPZ0HTLiyRulaFC0ATTh9ln/sEDECK33VmPmEVno/KA2
         Sydw==
X-Gm-Message-State: ABy/qLa44jpZ5GQFc1kL5DHNIbLm99Fm2GgZtc9HvxrfiSMeSJuje4wh
        mjS9tjrtSsXQrQFgYt3zpVU6DPctsVEpUvTb8qCkSmc5oqkNEJmrDRto5n5Vz0Yp2SG633gXIzj
        996trPhz+JPB0KgE4UlzLD1qaYg==
X-Received: by 2002:a17:907:6d8c:b0:98d:abd4:4000 with SMTP id sb12-20020a1709076d8c00b0098dabd44000mr7889161ejc.35.1689930234817;
        Fri, 21 Jul 2023 02:03:54 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGH6YzYN7wVD16W6bBWRZvka9R57MaW1yVsDxFFu0qfog7UhF1jWQDyj4gC4NTPLd7VWeWUJA==
X-Received: by 2002:a17:907:6d8c:b0:98d:abd4:4000 with SMTP id sb12-20020a1709076d8c00b0098dabd44000mr7889108ejc.35.1689930234273;
        Fri, 21 Jul 2023 02:03:54 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:9af8:e5f5:7516:fa89? ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
        by smtp.googlemail.com with ESMTPSA id rv7-20020a17090710c700b00993a9a951fasm1915159ejb.11.2023.07.21.02.03.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Jul 2023 02:03:53 -0700 (PDT)
Message-ID: <47c5f57c-a191-1983-b4ef-6e0c59c0c446@redhat.com>
Date:   Fri, 21 Jul 2023 11:03:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [RFC PATCH v11 06/29] KVM: Introduce KVM_SET_USER_MEMORY_REGION2
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
 <20230718234512.1690985-7-seanjc@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <20230718234512.1690985-7-seanjc@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 7/19/23 01:44, Sean Christopherson wrote:
> Cc: Jarkko Sakkinen <jarkko@kernel.org>
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>   arch/x86/kvm/x86.c       |  2 +-
>   include/linux/kvm_host.h |  4 ++--
>   include/uapi/linux/kvm.h | 13 +++++++++++++
>   virt/kvm/kvm_main.c      | 38 ++++++++++++++++++++++++++++++--------
>   4 files changed, 46 insertions(+), 11 deletions(-)
> 
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index a6b9bea62fb8..92e77afd3ffd 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -12420,7 +12420,7 @@ void __user * __x86_set_memory_region(struct kvm *kvm, int id, gpa_t gpa,
>   	}
>   
>   	for (i = 0; i < KVM_ADDRESS_SPACE_NUM; i++) {
> -		struct kvm_userspace_memory_region m;
> +		struct kvm_userspace_memory_region2 m;
>   
>   		m.slot = id | (i << 16);
>   		m.flags = 0;
> diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
> index d2d3e083ec7f..e9ca49d451f3 100644
> --- a/include/linux/kvm_host.h
> +++ b/include/linux/kvm_host.h
> @@ -1130,9 +1130,9 @@ enum kvm_mr_change {
>   };
>   
>   int kvm_set_memory_region(struct kvm *kvm,
> -			  const struct kvm_userspace_memory_region *mem);
> +			  const struct kvm_userspace_memory_region2 *mem);
>   int __kvm_set_memory_region(struct kvm *kvm,
> -			    const struct kvm_userspace_memory_region *mem);
> +			    const struct kvm_userspace_memory_region2 *mem);
>   void kvm_arch_free_memslot(struct kvm *kvm, struct kvm_memory_slot *slot);
>   void kvm_arch_memslots_updated(struct kvm *kvm, u64 gen);
>   int kvm_arch_prepare_memory_region(struct kvm *kvm,
> diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
> index f089ab290978..4d4b3de8ac55 100644
> --- a/include/uapi/linux/kvm.h
> +++ b/include/uapi/linux/kvm.h
> @@ -95,6 +95,16 @@ struct kvm_userspace_memory_region {
>   	__u64 userspace_addr; /* start of the userspace allocated memory */
>   };
>   
> +/* for KVM_SET_USER_MEMORY_REGION2 */
> +struct kvm_userspace_memory_region2 {
> +	__u32 slot;
> +	__u32 flags;
> +	__u64 guest_phys_addr;
> +	__u64 memory_size;
> +	__u64 userspace_addr;
> +	__u64 pad[16];
> +};
> +
>   /*
>    * The bit 0 ~ bit 15 of kvm_userspace_memory_region::flags are visible for
>    * userspace, other bits are reserved for kvm internal use which are defined
> @@ -1192,6 +1202,7 @@ struct kvm_ppc_resize_hpt {
>   #define KVM_CAP_COUNTER_OFFSET 227
>   #define KVM_CAP_ARM_EAGER_SPLIT_CHUNK_SIZE 228
>   #define KVM_CAP_ARM_SUPPORTED_BLOCK_SIZES 229
> +#define KVM_CAP_USER_MEMORY2 230
>   
>   #ifdef KVM_CAP_IRQ_ROUTING
>   
> @@ -1466,6 +1477,8 @@ struct kvm_vfio_spapr_tce {
>   					struct kvm_userspace_memory_region)
>   #define KVM_SET_TSS_ADDR          _IO(KVMIO,   0x47)
>   #define KVM_SET_IDENTITY_MAP_ADDR _IOW(KVMIO,  0x48, __u64)
> +#define KVM_SET_USER_MEMORY_REGION2 _IOW(KVMIO, 0x49, \
> +					 struct kvm_userspace_memory_region2)
>   
>   /* enable ucontrol for s390 */
>   struct kvm_s390_ucas_mapping {
> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> index 53346bc2902a..c14adf93daec 100644
> --- a/virt/kvm/kvm_main.c
> +++ b/virt/kvm/kvm_main.c
> @@ -1549,7 +1549,7 @@ static void kvm_replace_memslot(struct kvm *kvm,
>   	}
>   }
>   
> -static int check_memory_region_flags(const struct kvm_userspace_memory_region *mem)
> +static int check_memory_region_flags(const struct kvm_userspace_memory_region2 *mem)
>   {
>   	u32 valid_flags = KVM_MEM_LOG_DIRTY_PAGES;
>   
> @@ -1951,7 +1951,7 @@ static bool kvm_check_memslot_overlap(struct kvm_memslots *slots, int id,
>    * Must be called holding kvm->slots_lock for write.
>    */
>   int __kvm_set_memory_region(struct kvm *kvm,
> -			    const struct kvm_userspace_memory_region *mem)
> +			    const struct kvm_userspace_memory_region2 *mem)
>   {
>   	struct kvm_memory_slot *old, *new;
>   	struct kvm_memslots *slots;
> @@ -2055,7 +2055,7 @@ int __kvm_set_memory_region(struct kvm *kvm,
>   EXPORT_SYMBOL_GPL(__kvm_set_memory_region);
>   
>   int kvm_set_memory_region(struct kvm *kvm,
> -			  const struct kvm_userspace_memory_region *mem)
> +			  const struct kvm_userspace_memory_region2 *mem)
>   {
>   	int r;
>   
> @@ -2067,7 +2067,7 @@ int kvm_set_memory_region(struct kvm *kvm,
>   EXPORT_SYMBOL_GPL(kvm_set_memory_region);
>   
>   static int kvm_vm_ioctl_set_memory_region(struct kvm *kvm,
> -					  struct kvm_userspace_memory_region *mem)
> +					  struct kvm_userspace_memory_region2 *mem)
>   {
>   	if ((u16)mem->slot >= KVM_USER_MEM_SLOTS)
>   		return -EINVAL;
> @@ -4514,6 +4514,7 @@ static int kvm_vm_ioctl_check_extension_generic(struct kvm *kvm, long arg)
>   {
>   	switch (arg) {
>   	case KVM_CAP_USER_MEMORY:
> +	case KVM_CAP_USER_MEMORY2:
>   	case KVM_CAP_DESTROY_MEMORY_REGION_WORKS:
>   	case KVM_CAP_JOIN_MEMORY_REGIONS_WORKS:
>   	case KVM_CAP_INTERNAL_ERROR_DATA:
> @@ -4757,6 +4758,14 @@ static int kvm_vm_ioctl_get_stats_fd(struct kvm *kvm)
>   	return fd;
>   }
>   
> +#define SANITY_CHECK_MEM_REGION_FIELD(field)					\
> +do {										\
> +	BUILD_BUG_ON(offsetof(struct kvm_userspace_memory_region, field) !=		\
> +		     offsetof(struct kvm_userspace_memory_region2, field));	\
> +	BUILD_BUG_ON(sizeof_field(struct kvm_userspace_memory_region, field) !=		\
> +		     sizeof_field(struct kvm_userspace_memory_region2, field));	\
> +} while (0)
> +
>   static long kvm_vm_ioctl(struct file *filp,
>   			   unsigned int ioctl, unsigned long arg)
>   {
> @@ -4779,15 +4788,28 @@ static long kvm_vm_ioctl(struct file *filp,
>   		r = kvm_vm_ioctl_enable_cap_generic(kvm, &cap);
>   		break;
>   	}
> +	case KVM_SET_USER_MEMORY_REGION2:
>   	case KVM_SET_USER_MEMORY_REGION: {
> -		struct kvm_userspace_memory_region kvm_userspace_mem;
> +		struct kvm_userspace_memory_region2 mem;
> +		unsigned long size;
> +
> +		if (ioctl == KVM_SET_USER_MEMORY_REGION)
> +			size = sizeof(struct kvm_userspace_memory_region);
> +		else
> +			size = sizeof(struct kvm_userspace_memory_region2);
> +
> +		/* Ensure the common parts of the two structs are identical. */
> +		SANITY_CHECK_MEM_REGION_FIELD(slot);
> +		SANITY_CHECK_MEM_REGION_FIELD(flags);
> +		SANITY_CHECK_MEM_REGION_FIELD(guest_phys_addr);
> +		SANITY_CHECK_MEM_REGION_FIELD(memory_size);
> +		SANITY_CHECK_MEM_REGION_FIELD(userspace_addr);
>   
>   		r = -EFAULT;
> -		if (copy_from_user(&kvm_userspace_mem, argp,
> -						sizeof(kvm_userspace_mem)))
> +		if (copy_from_user(&mem, argp, size))
>   			goto out;
>   
> -		r = kvm_vm_ioctl_set_memory_region(kvm, &kvm_userspace_mem);
> +		r = kvm_vm_ioctl_set_memory_region(kvm, &mem);
>   		break;
>   	}
>   	case KVM_GET_DIRTY_LOG: {

Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>

