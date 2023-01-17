Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1805F66E838
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Jan 2023 22:13:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229579AbjAQVNj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 17 Jan 2023 16:13:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229651AbjAQVMm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 17 Jan 2023 16:12:42 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A21804A21B
        for <linux-fsdevel@vger.kernel.org>; Tue, 17 Jan 2023 11:36:03 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id r21so2505754plg.13
        for <linux-fsdevel@vger.kernel.org>; Tue, 17 Jan 2023 11:36:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/Y/+6b+/J99MLnqP/RvN51sj3DHWazl0lw52Vf0WKHU=;
        b=mO/P06835gXK/fd1eBgp4cGBD2kC3K+6imr5T+2jtDjdUBhDC2ZA6VrIPZfU/f9xjC
         IEFaPiulMS/0ZqDbxbtw2cJsM7Tc3tGTV1WEaKwKEM7/onV7W8gwNEZgbjFg1D9VPFPt
         zOrBnI+uh6uL/yAkjlKRTpwIo5mbtRcjK3EEpUEcbJ7VVRL/gSQAf4SQnwHxKqHb/sTQ
         MXdsYhc4zLlGvKOCRi98eQbAPaNpu9G8SHim8g88Gvn8/JWvst4ReoqQ54dQnmQu9Cx8
         q4mO4VJKRFbwHLXOegE1kYwL9GcvTKshaR6/+a9qCY329OuOlMsj+GHmm1PrfY3+znUl
         l0+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/Y/+6b+/J99MLnqP/RvN51sj3DHWazl0lw52Vf0WKHU=;
        b=tSsfAPYiboIz1rrhwUHbMtlPskLJb05tvKjz6I9bGBsC+LCnl29RW6TtrOuvqj0rEh
         RVsXcDuNskTtgDjMhOW0Iqx07Ds5l0qrhY/jfxtshATDWH2KOfQT+LCw1aKlq7Vk1OAb
         At/giaS57pDvQPZnV7cFh8sAbN1uRplxVSqErw+9WvtO0L8ovMWM6eiyk3ccunaeCB8t
         cQ8MkH/DAeY7MQRuJIkcMxhcYBD+XDboirKbl6pLdNbtKGlNifjaw1m/RTjeg7JP1usf
         9XivPek4fgRy8uj4zDi+/TUO+Xr5cfgJuqvND+QZmXhkp6e6KsduEydv9/F1UOvDcbWc
         G6qQ==
X-Gm-Message-State: AFqh2kqH/c+vjATl3/IJ8BaYXF0j1IjzN8vCl+ZU7IyjORsxFXcpcsfA
        R4FVTjkr+F7JzGULeaJcWwx0ig==
X-Google-Smtp-Source: AMrXdXu1hk8ysrAGJplB4OjNB7xeVQaqK5fZ7KwLIxI5L/arUaD+5uicI01yTWHuGz/H+vtFbMLBdw==
X-Received: by 2002:a05:6a20:93a4:b0:b8:e33c:f160 with SMTP id x36-20020a056a2093a400b000b8e33cf160mr178599pzh.0.1673984162308;
        Tue, 17 Jan 2023 11:36:02 -0800 (PST)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id t1-20020a63d241000000b004c974bb9a4esm5296842pgi.83.2023.01.17.11.36.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jan 2023 11:36:01 -0800 (PST)
Date:   Tue, 17 Jan 2023 19:35:58 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Chao Peng <chao.p.peng@linux.intel.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-api@vger.kernel.org,
        linux-doc@vger.kernel.org, qemu-devel@nongnu.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
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
        wei.w.wang@intel.com
Subject: Re: [PATCH v10 9/9] KVM: Enable and expose KVM_MEM_PRIVATE
Message-ID: <Y8b4nsMJm+4Hr/e0@google.com>
References: <20221202061347.1070246-1-chao.p.peng@linux.intel.com>
 <20221202061347.1070246-10-chao.p.peng@linux.intel.com>
 <Y8HwvTik/2avrCOU@google.com>
 <20230117131251.GC273037@chaop.bj.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230117131251.GC273037@chaop.bj.intel.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jan 17, 2023, Chao Peng wrote:
> On Sat, Jan 14, 2023 at 12:01:01AM +0000, Sean Christopherson wrote:
> > On Fri, Dec 02, 2022, Chao Peng wrote:
> > > @@ -10357,6 +10364,12 @@ static int vcpu_enter_guest(struct kvm_vcpu *vcpu)
> > >  
> > >  		if (kvm_check_request(KVM_REQ_UPDATE_CPU_DIRTY_LOGGING, vcpu))
> > >  			static_call(kvm_x86_update_cpu_dirty_logging)(vcpu);
> > > +
> > > +		if (kvm_check_request(KVM_REQ_MEMORY_MCE, vcpu)) {
> > > +			vcpu->run->exit_reason = KVM_EXIT_SHUTDOWN;
> > 
> > Synthesizing triple fault shutdown is not the right approach.  Even with TDX's
> > MCE "architecture" (heavy sarcasm), it's possible that host userspace and the
> > guest have a paravirt interface for handling memory errors without killing the
> > host.
> 
> Agree shutdown is not the correct choice. I see you made below change:
> 
> send_sig_mceerr(BUS_MCEERR_AR, (void __user *)hva, PAGE_SHIFT, current)
> 
> The MCE may happen in any thread than KVM thread, sending siginal to
> 'current' thread may not be the expected behavior.

This is already true today, e.g. a #MC in memory that is mapped into the guest can
be triggered by a host access.  Hrm, but in this case we actually have a KVM
instance, and we know that the #MC is relevant to the KVM instance, so I agree
that signaling 'current' is kludgy.

>  Also how userspace can tell is the MCE on the shared page or private page?
>  Do we care?

We care.  I was originally thinking we could require userspace to keep track of
things, but that's quite prescriptive and flawed, e.g. could race with conversions.

One option would be to KVM_EXIT_MEMORY_FAULT, and then wire up a generic (not x86
specific) KVM request to exit to userspace, e.g.

		/* KVM_EXIT_MEMORY_FAULT */
		struct {
#define KVM_MEMORY_EXIT_FLAG_PRIVATE	(1ULL << 3)
#define KVM_MEMORY_EXIT_FLAG_HW_ERROR	(1ULL << 4)
			__u64 flags;
			__u64 gpa;
			__u64 size;
		} memory;

But I'm not sure that's the correct approach.  It kinda feels like we're reinventing
the wheel.  It seems like restrictedmem_get_page() _must_ be able to reject attempts
to get a poisoned page, i.e. restrictedmem_get_page() should yield KVM_PFN_ERR_HWPOISON.
Assuming that's the case, then I believe KVM simply needs to zap SPTEs in response
to an error notification in order to force vCPUs to fault on the poisoned page.

> > > +		return -EINVAL;
> > >  	if (as_id >= KVM_ADDRESS_SPACE_NUM || id >= KVM_MEM_SLOTS_NUM)
> > >  		return -EINVAL;
> > >  	if (mem->guest_phys_addr + mem->memory_size < mem->guest_phys_addr)
> > > @@ -2020,6 +2154,9 @@ int __kvm_set_memory_region(struct kvm *kvm,
> > >  		if ((kvm->nr_memslot_pages + npages) < kvm->nr_memslot_pages)
> > >  			return -EINVAL;
> > >  	} else { /* Modify an existing slot. */
> > > +		/* Private memslots are immutable, they can only be deleted. */
> > 
> > I'm 99% certain I suggested this, but if we're going to make these memslots
> > immutable, then we should straight up disallow dirty logging, otherwise we'll
> > end up with a bizarre uAPI.
> 
> But in my mind dirty logging will be needed in the very short time, when
> live migration gets supported?

Ya, but if/when live migration support is added, private memslots will no longer
be immutable as userspace will want to enable dirty logging only when a VM is
being migrated, i.e. something will need to change.

Given that it looks like we have clear line of sight to SEV+UPM guests, my
preference would be to allow toggling dirty logging from the get-go.  It doesn't
necessarily have to be in the first patch, e.g. KVM could initially reject
KVM_MEM_LOG_DIRTY_PAGES + KVM_MEM_PRIVATE and then add support separately to make
the series easier to review, test, and bisect.

static int check_memory_region_flags(struct kvm *kvm,
				     const struct kvm_userspace_memory_region2 *mem)
{
	u32 valid_flags = KVM_MEM_LOG_DIRTY_PAGES;

	if (kvm_arch_has_private_mem(kvm) &&
	    ~(mem->flags & KVM_MEM_LOG_DIRTY_PAGES))
		valid_flags |= KVM_MEM_PRIVATE;


	...
}

> > > +		if (mem->flags & KVM_MEM_PRIVATE)
> > > +			return -EINVAL;
> > >  		if ((mem->userspace_addr != old->userspace_addr) ||
> > >  		    (npages != old->npages) ||
> > >  		    ((mem->flags ^ old->flags) & KVM_MEM_READONLY))
> > > @@ -2048,10 +2185,28 @@ int __kvm_set_memory_region(struct kvm *kvm,
> > >  	new->npages = npages;
> > >  	new->flags = mem->flags;
> > >  	new->userspace_addr = mem->userspace_addr;
> > > +	if (mem->flags & KVM_MEM_PRIVATE) {
> > > +		new->restricted_file = fget(mem->restricted_fd);
> > > +		if (!new->restricted_file ||
> > > +		    !file_is_restrictedmem(new->restricted_file)) {
> > > +			r = -EINVAL;
> > > +			goto out;
> > > +		}
> > > +		new->restricted_offset = mem->restricted_offset;
> 
> I see you changed slot->restricted_offset type from loff_t to gfn_t and
> used pgoff_t when doing the restrictedmem_bind/unbind(). Using page
> index is reasonable KVM internally and sounds simpler than loff_t. But
> we also need initialize it to page index here as well as changes in
> another two cases. This is needed when restricted_offset != 0.

Oof.  I'm pretty sure I completely missed that loff_t is used for byte offsets,
whereas pgoff_t is a frame index. 

Given that the restrictmem APIs take pgoff_t, I definitely think it makes sense
to the index, but I'm very tempted to store pgoff_t instead of gfn_t, and name
the field "index" to help connect the dots to the rest of kernel, where "pgoff_t index"
is quite common.

And looking at those bits again, we should wrap all of the restrictedmem fields
with CONFIG_KVM_PRIVATE_MEM.  It'll require minor tweaks to __kvm_set_memory_region(),
but I think will yield cleaner code (and internal APIs) overall.

And wrap the three fields in an anonymous struct?  E.g. this is a little more
versbose (restrictedmem instead restricted), but at first glance it doesn't seem
to cause widespared line length issues.

#ifdef CONFIG_KVM_PRIVATE_MEM
	struct {
		struct file *file;
		pgoff_t index;
		struct restrictedmem_notifier notifier;
	} restrictedmem;
#endif

> diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
> index 547b92215002..49e375e78f30 100644
> --- a/include/linux/kvm_host.h
> +++ b/include/linux/kvm_host.h
> @@ -2364,8 +2364,7 @@ static inline int kvm_restricted_mem_get_pfn(struct kvm_memory_slot *slot,
>                                              gfn_t gfn, kvm_pfn_t *pfn,
>                                              int *order)
>  {
> -       pgoff_t index = gfn - slot->base_gfn +
> -                       (slot->restricted_offset >> PAGE_SHIFT);
> +       pgoff_t index = gfn - slot->base_gfn + slot->restricted_offset;
>         struct page *page;
>         int ret;
>  
> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> index 01db35ddd5b3..7439bdcb0d04 100644
> --- a/virt/kvm/kvm_main.c
> +++ b/virt/kvm/kvm_main.c
> @@ -935,7 +935,7 @@ static bool restrictedmem_range_is_valid(struct kvm_memory_slot *slot,
>                                          pgoff_t start, pgoff_t end,
>                                          gfn_t *gfn_start, gfn_t *gfn_end)
>  {
> -       unsigned long base_pgoff = slot->restricted_offset >> PAGE_SHIFT;
> +       unsigned long base_pgoff = slot->restricted_offset;
>  
>         if (start > base_pgoff)
>                 *gfn_start = slot->base_gfn + start - base_pgoff;
> @@ -2275,7 +2275,7 @@ int __kvm_set_memory_region(struct kvm *kvm,
>                         r = -EINVAL;
>                         goto out;
>                 }
> -               new->restricted_offset = mem->restricted_offset;
> +               new->restricted_offset = mem->restricted_offset >> PAGE_SHIFT;
>         }
>  
>         r = kvm_set_memslot(kvm, old, new, change);
> 
> Chao
> > > +	}
> > > +
> > > +	new->kvm = kvm;
> > 
> > Set this above, just so that the code flows better.
