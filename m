Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C2B24821A3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Dec 2021 03:54:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241115AbhLaCy3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 30 Dec 2021 21:54:29 -0500
Received: from mga14.intel.com ([192.55.52.115]:39380 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241081AbhLaCy2 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 30 Dec 2021 21:54:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640919268; x=1672455268;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   mime-version:in-reply-to;
  bh=LPcVk7Dhs/psxqqcTf8fKAlDbNnm7Ve0rMtCoM0tbUc=;
  b=gwYHV3/AilQsyS4mOLhcMIKE6Y21gtunjFMJheEH1KP88PqTQr/IjWzZ
   MgNBP2Zec4RKxDL7eFeUVtqnxgwl0We2kKVm+6hyYKie+S4h/81fPvQuW
   pzmqreLKQKA30YfCjQcryz1/purTc70yhvvPoKNU0qttj0Q4nuSheo3qw
   D6gZBGRWx/+bB00qsHgOgelXIi1CNtLCiRvdlk4qjceBcleHSwyt/tgW5
   QclsngPqyDDOGbnGEp4bOd6lfZxaplrRnw7QlARSJhwBXlL7C8c4BZTNN
   DkN5DhQf5f5CF+RVkJbLwLCu1sRrxG2p120SOr/MlLrKy3rGzlGt9gAVJ
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10213"; a="241972471"
X-IronPort-AV: E=Sophos;i="5.88,250,1635231600"; 
   d="scan'208";a="241972471"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Dec 2021 18:54:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,250,1635231600"; 
   d="scan'208";a="666710583"
Received: from chaop.bj.intel.com (HELO localhost) ([10.240.192.101])
  by fmsmga001.fm.intel.com with ESMTP; 30 Dec 2021 18:54:19 -0800
Date:   Fri, 31 Dec 2021 10:53:44 +0800
From:   Chao Peng <chao.p.peng@linux.intel.com>
To:     Sean Christopherson <seanjc@google.com>
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
Subject: Re: [PATCH v3 kvm/queue 04/16] KVM: Extend the memslot to support
 fd-based private memory
Message-ID: <20211231025344.GC7255@chaop.bj.intel.com>
Reply-To: Chao Peng <chao.p.peng@linux.intel.com>
References: <20211223123011.41044-1-chao.p.peng@linux.intel.com>
 <20211223123011.41044-5-chao.p.peng@linux.intel.com>
 <YcSzafzpjMy6m28B@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YcSzafzpjMy6m28B@google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Dec 23, 2021 at 05:35:37PM +0000, Sean Christopherson wrote:
> On Thu, Dec 23, 2021, Chao Peng wrote:
> 
> > +	struct file *file;
> 
> Please use more descriptive names, shaving characters is not at all priority.
> 
> > +	u64 ofs;
> 
> I believe this should be loff_t.
> 
> 	struct file *private_file;
> 	struct loff_t private_offset;
> 
> >  };
> >  
> > +static inline bool kvm_slot_is_private(const struct kvm_memory_slot *slot)
> > +{
> > +	if (slot && (slot->flags & KVM_MEM_PRIVATE))
> > +		return true;
> > +	return false;
> 
> 	return slot && (slot->flags & KVM_MEM_PRIVATE);
> 
> > +}
> > +
> >  static inline bool kvm_slot_dirty_track_enabled(const struct kvm_memory_slot *slot)
> >  {
> >  	return slot->flags & KVM_MEM_LOG_DIRTY_PAGES;
> > diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
> > index 1daa45268de2..41434322fa23 100644
> > --- a/include/uapi/linux/kvm.h
> > +++ b/include/uapi/linux/kvm.h
> > @@ -103,6 +103,17 @@ struct kvm_userspace_memory_region {
> >  	__u64 userspace_addr; /* start of the userspace allocated memory */
> >  };
> >  
> > +struct kvm_userspace_memory_region_ext {
> > +	__u32 slot;
> > +	__u32 flags;
> > +	__u64 guest_phys_addr;
> > +	__u64 memory_size; /* bytes */
> > +	__u64 userspace_addr; /* hva */
> 
> Would it make sense to embed "struct kvm_userspace_memory_region"?
> 
> > +	__u64 ofs; /* offset into fd */
> > +	__u32 fd;
> 
> Again, use descriptive names, then comments like "offset into fd" are unnecessary.
> 
> 	__u64 private_offset;
> 	__u32 private_fd;

My original thought is the same fields might be used for shared memslot
as well in future (e.g. there may be another KVM_MEM_* bit can reuse the
same fields for shared slot) so non private-specific name may sound
better. But definitely I have no objection and can use private_* names
for next version unless there is other objection.

Thanks,
Chao
> 
> > +	__u32 padding[5];
> > +};
> > +
> >  /*
> >   * The bit 0 ~ bit 15 of kvm_memory_region::flags are visible for userspace,
> >   * other bits are reserved for kvm internal use which are defined in
> > @@ -110,6 +121,7 @@ struct kvm_userspace_memory_region {
> >   */
> >  #define KVM_MEM_LOG_DIRTY_PAGES	(1UL << 0)
> >  #define KVM_MEM_READONLY	(1UL << 1)
> > +#define KVM_MEM_PRIVATE		(1UL << 2)
> >  
> >  /* for KVM_IRQ_LINE */
> >  struct kvm_irq_level {
> > -- 
> > 2.17.1
> > 
