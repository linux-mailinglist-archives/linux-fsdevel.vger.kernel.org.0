Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BF3F650880
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Dec 2022 09:20:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231531AbiLSIUE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 19 Dec 2022 03:20:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbiLSIUC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 19 Dec 2022 03:20:02 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C8ADBF7F;
        Mon, 19 Dec 2022 00:20:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1671438000; x=1702974000;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   mime-version:in-reply-to;
  bh=LNCdKsFcaAqCxKwjGOGvE5vkO4LxzR3OxK3Y+B+ZSpI=;
  b=LBTL0lT9N7OTJVymllyL6GEEIxeCqISqegKeG8rzigRhMjKVbSyWddah
   42K2kKHP8aZZ1+tw966Dq9ZdidMew+6klGCrMuBK0AXqctiFu/t5+SH/x
   0b/DhfzJ6hx/CaYQBRjiTMrr4xfTNvU96Ev0zpbQRAzJeSZrGghs6N+o5
   vS3X+ny02gWk49F9Bdlkz/6TydT7mfnfK5JoMNM6zOGlK0xe1S6gDodpT
   uN5eKplH07m0d2R4ZCOhMa/j9XAkKqery7HeaqmHCDvq5ewsoPsI5du1b
   Y15D731j3waALz/L5OVumxnzBgGxTAEFFttJclyWCya+xTX5rmbmgNSuP
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10565"; a="299627805"
X-IronPort-AV: E=Sophos;i="5.96,255,1665471600"; 
   d="scan'208";a="299627805"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2022 00:19:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10565"; a="719033720"
X-IronPort-AV: E=Sophos;i="5.96,255,1665471600"; 
   d="scan'208";a="719033720"
Received: from chaop.bj.intel.com (HELO localhost) ([10.240.193.75])
  by fmsmga004.fm.intel.com with ESMTP; 19 Dec 2022 00:19:49 -0800
Date:   Mon, 19 Dec 2022 16:15:32 +0800
From:   Chao Peng <chao.p.peng@linux.intel.com>
To:     Borislav Petkov <bp@alien8.de>
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
        Ingo Molnar <mingo@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
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
        wei.w.wang@intel.com
Subject: Re: [PATCH v10 2/9] KVM: Introduce per-page memory attributes
Message-ID: <20221219081532.GD1691829@chaop.bj.intel.com>
Reply-To: Chao Peng <chao.p.peng@linux.intel.com>
References: <20221202061347.1070246-1-chao.p.peng@linux.intel.com>
 <20221202061347.1070246-3-chao.p.peng@linux.intel.com>
 <Y5yKEpwCzZpNoBrp@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y5yKEpwCzZpNoBrp@zn.tnic>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Dec 16, 2022 at 04:09:06PM +0100, Borislav Petkov wrote:
> On Fri, Dec 02, 2022 at 02:13:40PM +0800, Chao Peng wrote:
> > diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> > index 1782c4555d94..7f0f5e9f2406 100644
> > --- a/virt/kvm/kvm_main.c
> > +++ b/virt/kvm/kvm_main.c
> > @@ -1150,6 +1150,9 @@ static struct kvm *kvm_create_vm(unsigned long type, const char *fdname)
> >  	spin_lock_init(&kvm->mn_invalidate_lock);
> >  	rcuwait_init(&kvm->mn_memslots_update_rcuwait);
> >  	xa_init(&kvm->vcpu_array);
> > +#ifdef CONFIG_HAVE_KVM_MEMORY_ATTRIBUTES
> > +	xa_init(&kvm->mem_attr_array);
> > +#endif
> 
> 	if (IS_ENABLED(CONFIG_HAVE_KVM_MEMORY_ATTRIBUTES))
> 		...
> 
> would at least remove the ugly ifdeffery.
> 
> Or you could create wrapper functions for that xa_init() and
> xa_destroy() and put the ifdeffery in there.

Agreed.

> 
> > @@ -2323,6 +2329,49 @@ static int kvm_vm_ioctl_clear_dirty_log(struct kvm *kvm,
> >  }
> >  #endif /* CONFIG_KVM_GENERIC_DIRTYLOG_READ_PROTECT */
> >  
> > +#ifdef CONFIG_HAVE_KVM_MEMORY_ATTRIBUTES
> > +static u64 kvm_supported_mem_attributes(struct kvm *kvm)
> 
> I guess that function should have a verb in the name:
> 
> kvm_get_supported_mem_attributes()

Right!
> 
> > +static int kvm_vm_ioctl_set_mem_attributes(struct kvm *kvm,
> > +					   struct kvm_memory_attributes *attrs)
> > +{
> > +	gfn_t start, end;
> > +	unsigned long i;
> > +	void *entry;
> > +	u64 supported_attrs = kvm_supported_mem_attributes(kvm);
> > +
> > +	/* flags is currently not used. */
> > +	if (attrs->flags)
> > +		return -EINVAL;
> > +	if (attrs->attributes & ~supported_attrs)
> > +		return -EINVAL;
> > +	if (attrs->size == 0 || attrs->address + attrs->size < attrs->address)
> > +		return -EINVAL;
> > +	if (!PAGE_ALIGNED(attrs->address) || !PAGE_ALIGNED(attrs->size))
> > +		return -EINVAL;
> 
> Dunno, shouldn't those issue some sort of an error message so that the
> caller knows where it failed? Or at least return different retvals which
> signal what the problem is?

Tamping down with error number a bit:

        if (attrs->flags)
                return -ENXIO;
        if (attrs->attributes & ~supported_attrs)
                return -EOPNOTSUPP;
        if (!PAGE_ALIGNED(attrs->address) || !PAGE_ALIGNED(attrs->size) ||
            attrs->size == 0)
                return -EINVAL;
        if (attrs->address + attrs->size < attrs->address)
                return -E2BIG;

Chao
> 
> > +	start = attrs->address >> PAGE_SHIFT;
> > +	end = (attrs->address + attrs->size - 1 + PAGE_SIZE) >> PAGE_SHIFT;
> > +
> > +	entry = attrs->attributes ? xa_mk_value(attrs->attributes) : NULL;
> > +
> > +	mutex_lock(&kvm->lock);
> > +	for (i = start; i < end; i++)
> > +		if (xa_err(xa_store(&kvm->mem_attr_array, i, entry,
> > +				    GFP_KERNEL_ACCOUNT)))
> > +			break;
> > +	mutex_unlock(&kvm->lock);
> > +
> > +	attrs->address = i << PAGE_SHIFT;
> > +	attrs->size = (end - i) << PAGE_SHIFT;
> > +
> > +	return 0;
> > +}
> 
> -- 
> Regards/Gruss,
>     Boris.
> 
> https://people.kernel.org/tglx/notes-about-netiquette
