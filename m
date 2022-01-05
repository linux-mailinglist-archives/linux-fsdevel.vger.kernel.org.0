Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC9A9484DFD
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Jan 2022 07:07:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233414AbiAEGH4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 Jan 2022 01:07:56 -0500
Received: from mga14.intel.com ([192.55.52.115]:32760 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229543AbiAEGHz (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 Jan 2022 01:07:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641362875; x=1672898875;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   mime-version:in-reply-to;
  bh=07p9MpW9zMg9Qp6lAa6OCqWxIJ+2lO0bV8d8+HqWdzA=;
  b=HdLKlmaf2uM2e3YuP4t85s3KUnU0DYq7veFuc3Q5of94t7ucFHWlmAht
   a3qbjsS8Hxv/tqz/BF9kjw0VQlvrD5IDfTEr46yunCiuY01wZN0cg1TtH
   qjv5+N8jSm8aLivTOT3LYyy22eYeJhN/yX3RC5VGTMwzw8yhdL63UnbKU
   CBbqwEWpeet01x7DxOho7Lsed7rRS6MAdfIyNAJrnAl8+5KAK4Qsfa2W1
   IsdvHSiYuaHHvCTDhzJu7N7ek/jxOfUDY4Ltm16MOo61GRxVRu2NjU2s+
   R6d8lu+XrwPpy+gQ7DUHrAzSqZgiEgkpMdhCocM4Vf/yA6mqUoD5SN1xv
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10217"; a="242583901"
X-IronPort-AV: E=Sophos;i="5.88,262,1635231600"; 
   d="scan'208";a="242583901"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2022 22:07:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,262,1635231600"; 
   d="scan'208";a="526379627"
Received: from chaop.bj.intel.com (HELO localhost) ([10.240.192.101])
  by orsmga008.jf.intel.com with ESMTP; 04 Jan 2022 22:07:38 -0800
Date:   Wed, 5 Jan 2022 14:07:04 +0800
From:   Chao Peng <chao.p.peng@linux.intel.com>
To:     Sean Christopherson <seanjc@google.com>
Cc:     Robert Hoo <robert.hu@linux.intel.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, qemu-devel@nongnu.org,
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
        Yu Zhang <yu.c.zhang@linux.intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        luto@kernel.org, john.ji@intel.com, susie.li@intel.com,
        jun.nakajima@intel.com, dave.hansen@intel.com, ak@linux.intel.com,
        david@redhat.com
Subject: Re: [PATCH v3 kvm/queue 03/16] mm/memfd: Introduce MEMFD_OPS
Message-ID: <20220105060704.GA25009@chaop.bj.intel.com>
Reply-To: Chao Peng <chao.p.peng@linux.intel.com>
References: <20211223123011.41044-1-chao.p.peng@linux.intel.com>
 <20211223123011.41044-4-chao.p.peng@linux.intel.com>
 <95d13ac7da32aa1530d6883777ef3279e4ad825d.camel@linux.intel.com>
 <20211231023853.GB7255@chaop.bj.intel.com>
 <YdSGHnMFV5Mu9vdF@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YdSGHnMFV5Mu9vdF@google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jan 04, 2022 at 05:38:38PM +0000, Sean Christopherson wrote:
> On Fri, Dec 31, 2021, Chao Peng wrote:
> > On Fri, Dec 24, 2021 at 11:53:15AM +0800, Robert Hoo wrote:
> > > On Thu, 2021-12-23 at 20:29 +0800, Chao Peng wrote:
> > > > From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
> > > >  
> > > > +static void notify_fallocate(struct inode *inode, pgoff_t start,
> > > > pgoff_t end)
> > > > +{
> > > > +#ifdef CONFIG_MEMFD_OPS
> > > > +	struct shmem_inode_info *info = SHMEM_I(inode);
> > > > +	const struct memfd_falloc_notifier *notifier;
> > > > +	void *owner;
> > > > +	bool ret;
> > > > +
> > > > +	if (!info->falloc_notifier)
> > > > +		return;
> > > > +
> > > > +	spin_lock(&info->lock);
> > > > +	notifier = info->falloc_notifier;
> > > > +	if (!notifier) {
> > > > +		spin_unlock(&info->lock);
> > > > +		return;
> > > > +	}
> > > > +
> > > > +	owner = info->owner;
> > > > +	ret = notifier->get_owner(owner);
> > > > +	spin_unlock(&info->lock);
> > > > +	if (!ret)
> > > > +		return;
> > > > +
> > > > +	notifier->fallocate(inode, owner, start, end);
> > > 
> > > I see notifier->fallocate(), i.e. memfd_fallocate(), discards
> > > kvm_memfd_fallocate_range()'s return value. Should it be checked?
> > 
> > I think we can ignore it, just like how current mmu_notifier does,
> > the return value of __kvm_handle_hva_range is discarded in
> > kvm_mmu_notifier_invalidate_range_start(). Even when KVM side failed,
> > it's not fatal, it should not block the operation in the primary MMU.
> 
> If the return value is ignored, it'd be better to have no return value at all so
> that it's clear fallocate() will continue on regardless of whether or not the
> secondary MMU callback succeeds.  E.g. if KVM can't handle the fallocate() for
> whatever reason, then knowing that fallocate() will continue on means KVM should
> mark the VM as dead so that the broken setup cannot be abused by userspace.

After a close look, kvm_unmap_gfn_range() actually does not return a
error code, so it's safe to not return in kvm_memfd_handle_range().

Chao
