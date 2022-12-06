Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A0EC6444A9
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Dec 2022 14:34:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234414AbiLFNel (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 6 Dec 2022 08:34:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232676AbiLFNek (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 6 Dec 2022 08:34:40 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D60EEBC36;
        Tue,  6 Dec 2022 05:34:36 -0800 (PST)
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 79BDE1FE58;
        Tue,  6 Dec 2022 13:34:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1670333675; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dRjMqe9XUfWybRrbUF7GOm/XPQRxXJ5e2gntwceUOoI=;
        b=rMUnPAsfEpWIJsbRvlnc4Kq8LUTLvMgy4L7RRJsI38/Pmp/I/IQPIER3EVlgM35dwn6gLF
        9ZOffk1YPWciOp0dX967xPXIahIWRQ/5YzUUD9f2frz4WDMV5fLhJNjg4n1USKz1p0k6RD
        nGflIZSZE9DevBpSu3wVbSjTUepE5JY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1670333675;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dRjMqe9XUfWybRrbUF7GOm/XPQRxXJ5e2gntwceUOoI=;
        b=bYBAhVZ4hM49gizquEVGwEMgfkUk376WJJmV6+Gbni2jnjdakO1jwryltaQqbVYP29g2vR
        iDS88CFVOgK4GaAA==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 82E5D13326;
        Tue,  6 Dec 2022 13:34:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id /kz2H+pEj2MYBwAAGKfGzw
        (envelope-from <farosas@suse.de>); Tue, 06 Dec 2022 13:34:34 +0000
From:   Fabiano Rosas <farosas@suse.de>
To:     Chao Peng <chao.p.peng@linux.intel.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-api@vger.kernel.org, linux-doc@vger.kernel.org,
        qemu-devel@nongnu.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Miaohe Lin <linmiaohe@huawei.com>, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>, Hugh Dickins <hughd@google.com>,
        Jeff Layton <jlayton@kernel.org>,
        "J . Bruce Fields" <bfields@fieldses.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>, Mike Rapoport <rppt@kernel.org>,
        Steven Price <steven.price@arm.com>,
        "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
        Vlastimil Babka <vbabka@suse.cz>,
        Vishal Annapurve <vannapurve@google.com>,
        Yu Zhang <yu.c.zhang@linux.intel.com>,
        Chao Peng <chao.p.peng@linux.intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        luto@kernel.org, jun.nakajima@intel.com, dave.hansen@intel.com,
        ak@linux.intel.com, david@redhat.com, aarcange@redhat.com,
        ddutile@redhat.com, dhildenb@redhat.com,
        Quentin Perret <qperret@google.com>, tabba@google.com,
        Michael Roth <michael.roth@amd.com>, mhocko@suse.com,
        wei.w.wang@intel.com
Subject: Re: [PATCH v10 2/9] KVM: Introduce per-page memory attributes
In-Reply-To: <20221202061347.1070246-3-chao.p.peng@linux.intel.com>
References: <20221202061347.1070246-1-chao.p.peng@linux.intel.com>
 <20221202061347.1070246-3-chao.p.peng@linux.intel.com>
Date:   Tue, 06 Dec 2022 10:34:32 -0300
Message-ID: <877cz4ac5z.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Chao Peng <chao.p.peng@linux.intel.com> writes:

> In confidential computing usages, whether a page is private or shared is
> necessary information for KVM to perform operations like page fault
> handling, page zapping etc. There are other potential use cases for
> per-page memory attributes, e.g. to make memory read-only (or no-exec,
> or exec-only, etc.) without having to modify memslots.
>
> Introduce two ioctls (advertised by KVM_CAP_MEMORY_ATTRIBUTES) to allow
> userspace to operate on the per-page memory attributes.
>   - KVM_SET_MEMORY_ATTRIBUTES to set the per-page memory attributes to
>     a guest memory range.
>   - KVM_GET_SUPPORTED_MEMORY_ATTRIBUTES to return the KVM supported
>     memory attributes.
>
> KVM internally uses xarray to store the per-page memory attributes.
>
> Suggested-by: Sean Christopherson <seanjc@google.com>
> Signed-off-by: Chao Peng <chao.p.peng@linux.intel.com>
> Link: https://lore.kernel.org/all/Y2WB48kD0J4VGynX@google.com/
> ---
>  Documentation/virt/kvm/api.rst | 63 ++++++++++++++++++++++++++++
>  arch/x86/kvm/Kconfig           |  1 +
>  include/linux/kvm_host.h       |  3 ++
>  include/uapi/linux/kvm.h       | 17 ++++++++
>  virt/kvm/Kconfig               |  3 ++
>  virt/kvm/kvm_main.c            | 76 ++++++++++++++++++++++++++++++++++
>  6 files changed, 163 insertions(+)
>
> diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
> index 5617bc4f899f..bb2f709c0900 100644
> --- a/Documentation/virt/kvm/api.rst
> +++ b/Documentation/virt/kvm/api.rst
> @@ -5952,6 +5952,59 @@ delivery must be provided via the "reg_aen" struct.
>  The "pad" and "reserved" fields may be used for future extensions and should be
>  set to 0s by userspace.
>  
> +4.138 KVM_GET_SUPPORTED_MEMORY_ATTRIBUTES
> +-----------------------------------------
> +
> +:Capability: KVM_CAP_MEMORY_ATTRIBUTES
> +:Architectures: x86
> +:Type: vm ioctl
> +:Parameters: u64 memory attributes bitmask(out)
> +:Returns: 0 on success, <0 on error
> +
> +Returns supported memory attributes bitmask. Supported memory attributes will
> +have the corresponding bits set in u64 memory attributes bitmask.
> +
> +The following memory attributes are defined::
> +
> +  #define KVM_MEMORY_ATTRIBUTE_READ              (1ULL << 0)
> +  #define KVM_MEMORY_ATTRIBUTE_WRITE             (1ULL << 1)
> +  #define KVM_MEMORY_ATTRIBUTE_EXECUTE           (1ULL << 2)
> +  #define KVM_MEMORY_ATTRIBUTE_PRIVATE           (1ULL << 3)
> +
> +4.139 KVM_SET_MEMORY_ATTRIBUTES
> +-----------------------------------------
> +
> +:Capability: KVM_CAP_MEMORY_ATTRIBUTES
> +:Architectures: x86
> +:Type: vm ioctl
> +:Parameters: struct kvm_memory_attributes(in/out)
> +:Returns: 0 on success, <0 on error
> +
> +Sets memory attributes for pages in a guest memory range. Parameters are
> +specified via the following structure::
> +
> +  struct kvm_memory_attributes {
> +	__u64 address;
> +	__u64 size;
> +	__u64 attributes;
> +	__u64 flags;
> +  };
> +
> +The user sets the per-page memory attributes to a guest memory range indicated
> +by address/size, and in return KVM adjusts address and size to reflect the
> +actual pages of the memory range have been successfully set to the attributes.

This wording could cause some confusion, what about a simpler:

"reflect the range of pages that had its attributes successfully set"

> +If the call returns 0, "address" is updated to the last successful address + 1
> +and "size" is updated to the remaining address size that has not been set
> +successfully.

"address + 1 page" or "subsequent page" perhaps.

In fact, wouldn't this all become simpler if size were number of pages instead?

> The user should check the return value as well as the size to
> +decide if the operation succeeded for the whole range or not. The user may want
> +to retry the operation with the returned address/size if the previous range was
> +partially successful.
> +
> +Both address and size should be page aligned and the supported attributes can be
> +retrieved with KVM_GET_SUPPORTED_MEMORY_ATTRIBUTES.
> +
> +The "flags" field may be used for future extensions and should be set to 0s.
> +

...

> +static int kvm_vm_ioctl_set_mem_attributes(struct kvm *kvm,
> +					   struct kvm_memory_attributes *attrs)
> +{
> +	gfn_t start, end;
> +	unsigned long i;
> +	void *entry;
> +	u64 supported_attrs = kvm_supported_mem_attributes(kvm);
> +
> +	/* flags is currently not used. */
> +	if (attrs->flags)
> +		return -EINVAL;
> +	if (attrs->attributes & ~supported_attrs)
> +		return -EINVAL;
> +	if (attrs->size == 0 || attrs->address + attrs->size < attrs->address)
> +		return -EINVAL;
> +	if (!PAGE_ALIGNED(attrs->address) || !PAGE_ALIGNED(attrs->size))
> +		return -EINVAL;
> +
> +	start = attrs->address >> PAGE_SHIFT;
> +	end = (attrs->address + attrs->size - 1 + PAGE_SIZE) >> PAGE_SHIFT;

Here PAGE_SIZE and -1 cancel out.

Consider using gpa_to_gfn as well.

> +
> +	entry = attrs->attributes ? xa_mk_value(attrs->attributes) : NULL;
> +
> +	mutex_lock(&kvm->lock);
> +	for (i = start; i < end; i++)
> +		if (xa_err(xa_store(&kvm->mem_attr_array, i, entry,
> +				    GFP_KERNEL_ACCOUNT)))
> +			break;
> +	mutex_unlock(&kvm->lock);
> +
> +	attrs->address = i << PAGE_SHIFT;
> +	attrs->size = (end - i) << PAGE_SHIFT;
> +
> +	return 0;
> +}
> +#endif /* CONFIG_HAVE_KVM_MEMORY_ATTRIBUTES */
> +
>  struct kvm_memory_slot *gfn_to_memslot(struct kvm *kvm, gfn_t gfn)
>  {
>  	return __gfn_to_memslot(kvm_memslots(kvm), gfn);
> @@ -4459,6 +4508,9 @@ static long kvm_vm_ioctl_check_extension_generic(struct kvm *kvm, long arg)
>  #ifdef CONFIG_HAVE_KVM_MSI
>  	case KVM_CAP_SIGNAL_MSI:
>  #endif
> +#ifdef CONFIG_HAVE_KVM_MEMORY_ATTRIBUTES
> +	case KVM_CAP_MEMORY_ATTRIBUTES:
> +#endif
>  #ifdef CONFIG_HAVE_KVM_IRQFD
>  	case KVM_CAP_IRQFD:
>  	case KVM_CAP_IRQFD_RESAMPLE:
> @@ -4804,6 +4856,30 @@ static long kvm_vm_ioctl(struct file *filp,
>  		break;
>  	}
>  #endif /* CONFIG_HAVE_KVM_IRQ_ROUTING */
> +#ifdef CONFIG_HAVE_KVM_MEMORY_ATTRIBUTES
> +	case KVM_GET_SUPPORTED_MEMORY_ATTRIBUTES: {
> +		u64 attrs = kvm_supported_mem_attributes(kvm);
> +
> +		r = -EFAULT;
> +		if (copy_to_user(argp, &attrs, sizeof(attrs)))
> +			goto out;
> +		r = 0;
> +		break;
> +	}
> +	case KVM_SET_MEMORY_ATTRIBUTES: {
> +		struct kvm_memory_attributes attrs;
> +
> +		r = -EFAULT;
> +		if (copy_from_user(&attrs, argp, sizeof(attrs)))
> +			goto out;
> +
> +		r = kvm_vm_ioctl_set_mem_attributes(kvm, &attrs);
> +
> +		if (!r && copy_to_user(argp, &attrs, sizeof(attrs)))
> +			r = -EFAULT;
> +		break;
> +	}
> +#endif /* CONFIG_HAVE_KVM_MEMORY_ATTRIBUTES */
>  	case KVM_CREATE_DEVICE: {
>  		struct kvm_create_device cd;
