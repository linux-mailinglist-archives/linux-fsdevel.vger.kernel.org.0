Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EC6848219A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Dec 2021 03:39:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241120AbhLaCjj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 30 Dec 2021 21:39:39 -0500
Received: from mga14.intel.com ([192.55.52.115]:15598 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242565AbhLaCji (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 30 Dec 2021 21:39:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640918378; x=1672454378;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   mime-version:in-reply-to;
  bh=TzNuTr+rkRfs/siMv5ThwCQ6SRkD7qmXiB7orZOuuAY=;
  b=elUyzkWNmh0KZpvzTSjePKdtZ9sdnB9rouZfQ+UiR3GxofonQD9F+liS
   y7fpVvvC3MLyIX21zw5qK57Oc0shGKPwHS/2kDA+vaJAU7sEm8JaMcxzd
   yVby785qp8ThgQUy8S7nfp8ttsWE6UTM7k6gAR/P4M6G7tTmWizBQSllM
   tCPXYNch9l6x4gzJPzkjbc4rLe5xHWdrlDG8LO7zni4sctcoSoSIeMPDc
   aGwLe63anaoczA/a36pDpP3kC+CJdd3dKX00AvW64aOEKDQG6Glvbzf4o
   37lXZRpvlmFqFDykSkHfXiGLksmM320st+N9RRR1B6ctTaESaaTsu92I/
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10213"; a="241971565"
X-IronPort-AV: E=Sophos;i="5.88,250,1635231600"; 
   d="scan'208";a="241971565"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Dec 2021 18:39:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,250,1635231600"; 
   d="scan'208";a="666708085"
Received: from chaop.bj.intel.com (HELO localhost) ([10.240.192.101])
  by fmsmga001.fm.intel.com with ESMTP; 30 Dec 2021 18:39:29 -0800
Date:   Fri, 31 Dec 2021 10:38:53 +0800
From:   Chao Peng <chao.p.peng@linux.intel.com>
To:     Robert Hoo <robert.hu@linux.intel.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Sean Christopherson <seanjc@google.com>,
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
Message-ID: <20211231023853.GB7255@chaop.bj.intel.com>
Reply-To: Chao Peng <chao.p.peng@linux.intel.com>
References: <20211223123011.41044-1-chao.p.peng@linux.intel.com>
 <20211223123011.41044-4-chao.p.peng@linux.intel.com>
 <95d13ac7da32aa1530d6883777ef3279e4ad825d.camel@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <95d13ac7da32aa1530d6883777ef3279e4ad825d.camel@linux.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Dec 24, 2021 at 11:53:15AM +0800, Robert Hoo wrote:
> On Thu, 2021-12-23 at 20:29 +0800, Chao Peng wrote:
> > From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
> >  
> > +static void notify_fallocate(struct inode *inode, pgoff_t start,
> > pgoff_t end)
> > +{
> > +#ifdef CONFIG_MEMFD_OPS
> > +	struct shmem_inode_info *info = SHMEM_I(inode);
> > +	const struct memfd_falloc_notifier *notifier;
> > +	void *owner;
> > +	bool ret;
> > +
> > +	if (!info->falloc_notifier)
> > +		return;
> > +
> > +	spin_lock(&info->lock);
> > +	notifier = info->falloc_notifier;
> > +	if (!notifier) {
> > +		spin_unlock(&info->lock);
> > +		return;
> > +	}
> > +
> > +	owner = info->owner;
> > +	ret = notifier->get_owner(owner);
> > +	spin_unlock(&info->lock);
> > +	if (!ret)
> > +		return;
> > +
> > +	notifier->fallocate(inode, owner, start, end);
> 
> I see notifier->fallocate(), i.e. memfd_fallocate(), discards
> kvm_memfd_fallocate_range()'s return value. Should it be checked?

I think we can ignore it, just like how current mmu_notifier does,
the return value of __kvm_handle_hva_range is discarded in
kvm_mmu_notifier_invalidate_range_start(). Even when KVM side failed,
it's not fatal, it should not block the operation in the primary MMU.

Thanks,
Chao
> 
> > +	notifier->put_owner(owner);
> > +#endif
> > +}
> > +

