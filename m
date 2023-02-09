Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E37ED69013A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Feb 2023 08:25:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229830AbjBIHZw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Feb 2023 02:25:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229664AbjBIHZv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Feb 2023 02:25:51 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2397B4A1E7;
        Wed,  8 Feb 2023 23:25:34 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id f16-20020a17090a9b1000b0023058bbd7b2so1510230pjp.0;
        Wed, 08 Feb 2023 23:25:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rmVDDhkBD33dRebxUB6WkABikP1v8rHGLOz9oy+lzOw=;
        b=Qqsr8VuFj/cb61lWwBfIJiwftaSsXtTbIODDj9kMRlVfS2CUTcXAcnkVENwaHeFXCc
         eXeZ9Y66+6ildCk3obb8k3r83H0DWVz4TJzYVPAXagF7GXjgZ3GxGOCw/EF1i0/rp5IN
         pgGJSBfHppwSSxlu/WOaFOQm7D96GzMtKBjclGwqHDQYZ8V5NNbTw5oahMvkY62J4Bcv
         xvuULTn8M1jB7ooQLdS2tItxTCRS2SNix0Lv5msweEF06EcK/+YQoovw+ALLc950AbCO
         dNuYMGg/puoIQ39KxeNIBvRe2lqaJj+1rlej0C5Dhe4aDgkWXgpDufZzv1pwpPPiB1NX
         cjLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rmVDDhkBD33dRebxUB6WkABikP1v8rHGLOz9oy+lzOw=;
        b=fHXlptSQsRUIKjFOT0E54fTp1M+fvo+LmopMDezQsQHAn6O3yItgPd6wha0MAtwNfJ
         x/l9YYNkKXSuGmCE1RZSsBDBnXOFT7kAkZNsqbk43WbGeCRz253O+M9bb/xW1tnENivI
         1HJOwn1i9ZX9vT8fPO2T/SKFiS5sYLBB4RkHOT9V2HW5ECBZKOgWxzpAhOKhjnLxHROL
         epm5IGwUv518/FakgSCJEESeUhecWtzSVn3pNHy9sAToKeK4G5uO97NFvWcfYJGi0YuD
         E6kcc7GHWGPqUmDTtJThXgq+XjZcVvAtFlErpICSAhSXRgYwqBhh8BsHE+tuaBNz1bow
         dumQ==
X-Gm-Message-State: AO0yUKXgkW/Sozgb++k19n79YWzZq5yPISWh2L0SC+g1QeRJGC6rpyod
        BE1Cw23FZZKuorxonuRCDl4=
X-Google-Smtp-Source: AK7set81TKZAFzmOrFzSNHYZptbc1qRIgjmsCDass4PkbAdTYVS+WfbfkwETMnLWvQHYBCaWiFrNHA==
X-Received: by 2002:a17:902:f2c9:b0:19a:6098:103a with SMTP id h9-20020a170902f2c900b0019a6098103amr325179plc.23.1675927531617;
        Wed, 08 Feb 2023 23:25:31 -0800 (PST)
Received: from localhost ([192.55.54.55])
        by smtp.gmail.com with ESMTPSA id n20-20020a170902d0d400b0019948184c33sm664782pln.243.2023.02.08.23.25.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Feb 2023 23:25:30 -0800 (PST)
Date:   Wed, 8 Feb 2023 23:25:29 -0800
From:   Isaku Yamahata <isaku.yamahata@gmail.com>
To:     Chao Peng <chao.p.peng@linux.intel.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-api@vger.kernel.org,
        linux-doc@vger.kernel.org, qemu-devel@nongnu.org,
        Paolo Bonzini <pbonzini@redhat.com>,
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
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        luto@kernel.org, jun.nakajima@intel.com, dave.hansen@intel.com,
        ak@linux.intel.com, david@redhat.com, aarcange@redhat.com,
        ddutile@redhat.com, dhildenb@redhat.com,
        Quentin Perret <qperret@google.com>, tabba@google.com,
        Michael Roth <michael.roth@amd.com>, mhocko@suse.com,
        wei.w.wang@intel.com, isaku.yamahata@gmail.com
Subject: Re: [PATCH v10 2/9] KVM: Introduce per-page memory attributes
Message-ID: <20230209072529.GB4175971@ls.amr.corp.intel.com>
References: <20221202061347.1070246-1-chao.p.peng@linux.intel.com>
 <20221202061347.1070246-3-chao.p.peng@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221202061347.1070246-3-chao.p.peng@linux.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Dec 02, 2022 at 02:13:40PM +0800,
Chao Peng <chao.p.peng@linux.intel.com> wrote:

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

If memslot isn't private, it should return error if private attribute is set.
Something like following check is needed.

+       if (attrs->flags & KVM_MEM_PRIVATE) {
+               /* non-private memory slot doesn't allow KVM_MEM_PRIVATE */
+               for (i = 0; i < kvm_arch_nr_memslot_as_ids(kvm); i++) {
+                       struct kvm_memslot_iter iter;
+                       struct kvm_memslots *slots;
+
+                       slots = __kvm_memslots(kvm, i);
+                       kvm_for_each_memslot_in_gfn_range(&iter, slots, start, end) {
+                               if (!kvm_slot_can_be_private(iter.slot)) {
+                                       mutex_unlock(&kvm->slots_lock);
+                                       return -EINVAL;
+                               }
+                       }
+               }
+       }
+


-- 
Isaku Yamahata <isaku.yamahata@gmail.com>
