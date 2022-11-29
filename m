Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44E1663C207
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Nov 2022 15:11:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235316AbiK2OLO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 29 Nov 2022 09:11:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235190AbiK2OKu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 29 Nov 2022 09:10:50 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B74BB5E9C8;
        Tue, 29 Nov 2022 06:10:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669731048; x=1701267048;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   mime-version:in-reply-to;
  bh=kCh+qqjMcaQj1b5b/Ai4VtSeoBos0JWTLvFP/zM/hG0=;
  b=QJW1alFgIMednKYKb4BGTSaZt2rGXAxcfyDipr3PuLZt2nqCmmGEMrMZ
   7ki7F/1X6ARBI8SFSxr04eS1PKeJIRC/zxjo/FwoRXdhpkb+7bddWKrSi
   vP4QRCSqW7knFd8mSBDYVWb3S0hutNFq01fdXJKMkuxqnwvMByavbGrwy
   hO62JAJ91GS0860Zop58A2Ohx+GhmuI+hD+d+S1bmCrt1FzJoVswO3Urf
   B1lP32lUod1UGAEqyXeXJ2+Aj8U+kPnej242APiGxQ4MZr/7bzyxN8oXl
   Md206TL25XHQQ4R9VCGbw179F8JBbUBJCTfagvbO/MEYt4srHwh+K82+9
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10546"; a="316950711"
X-IronPort-AV: E=Sophos;i="5.96,203,1665471600"; 
   d="scan'208";a="316950711"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2022 06:10:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10546"; a="707224365"
X-IronPort-AV: E=Sophos;i="5.96,203,1665471600"; 
   d="scan'208";a="707224365"
Received: from chaop.bj.intel.com (HELO localhost) ([10.240.193.75])
  by fmsmga008.fm.intel.com with ESMTP; 29 Nov 2022 06:10:37 -0800
Date:   Tue, 29 Nov 2022 22:06:15 +0800
From:   Chao Peng <chao.p.peng@linux.intel.com>
To:     Michael Roth <michael.roth@amd.com>
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
        x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>,
        Hugh Dickins <hughd@google.com>,
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
        mhocko@suse.com, Muchun Song <songmuchun@bytedance.com>,
        wei.w.wang@intel.com
Subject: Re: [PATCH v9 1/8] mm: Introduce memfd_restricted system call to
 create restricted user memory
Message-ID: <20221129140615.GC902164@chaop.bj.intel.com>
Reply-To: Chao Peng <chao.p.peng@linux.intel.com>
References: <20221025151344.3784230-1-chao.p.peng@linux.intel.com>
 <20221025151344.3784230-2-chao.p.peng@linux.intel.com>
 <20221129003725.l34qhx6n44mq2gtl@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221129003725.l34qhx6n44mq2gtl@amd.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Nov 28, 2022 at 06:37:25PM -0600, Michael Roth wrote:
> On Tue, Oct 25, 2022 at 11:13:37PM +0800, Chao Peng wrote:
...
> > +static long restrictedmem_fallocate(struct file *file, int mode,
> > +				    loff_t offset, loff_t len)
> > +{
> > +	struct restrictedmem_data *data = file->f_mapping->private_data;
> > +	struct file *memfd = data->memfd;
> > +	int ret;
> > +
> > +	if (mode & FALLOC_FL_PUNCH_HOLE) {
> > +		if (!PAGE_ALIGNED(offset) || !PAGE_ALIGNED(len))
> > +			return -EINVAL;
> > +	}
> > +
> > +	restrictedmem_notifier_invalidate(data, offset, offset + len, true);
> 
> The KVM restrictedmem ops seem to expect pgoff_t, but here we pass
> loff_t. For SNP we've made this strange as part of the following patch
> and it seems to produce the expected behavior:

That's correct. Thanks.

> 
>   https://github.com/mdroth/linux/commit/d669c7d3003ff7a7a47e73e8c3b4eeadbd2c4eb6
> 
> > +	ret = memfd->f_op->fallocate(memfd, mode, offset, len);
> > +	restrictedmem_notifier_invalidate(data, offset, offset + len, false);
> > +	return ret;
> > +}
> > +
> 
> <snip>
> 
> > +int restrictedmem_get_page(struct file *file, pgoff_t offset,
> > +			   struct page **pagep, int *order)
> > +{
> > +	struct restrictedmem_data *data = file->f_mapping->private_data;
> > +	struct file *memfd = data->memfd;
> > +	struct page *page;
> > +	int ret;
> > +
> > +	ret = shmem_getpage(file_inode(memfd), offset, &page, SGP_WRITE);
> 
> This will result in KVM allocating pages that userspace hasn't necessary
> fallocate()'d. In the case of SNP we need to get the PFN so we can clean
> up the RMP entries when restrictedmem invalidations are issued for a GFN
> range.

Yes fallocate() is unnecessary unless someone wants to reserve some
space (e.g. for determination or performance purpose), this matches its
semantics perfectly at:
https://www.man7.org/linux/man-pages/man2/fallocate.2.html

> 
> If the guest supports lazy-acceptance however, these pages may not have
> been faulted in yet, and if the VMM defers actually fallocate()'ing space
> until the guest actually tries to issue a shared->private for that GFN
> (to support lazy-pinning), then there may never be a need to allocate
> pages for these backends.
> 
> However, the restrictedmem invalidations are for GFN ranges so there's
> no way to know inadvance whether it's been allocated yet or not. The
> xarray is one option but currently it defaults to 'private' so that
> doesn't help us here. It might if we introduced a 'uninitialized' state
> or something along that line instead of just the binary
> 'shared'/'private' though...

How about if we change the default to 'shared' as we discussed at
https://lore.kernel.org/all/Y35gI0L8GMt9+OkK@google.com/?
> 
> But for now we added a restrictedmem_get_page_noalloc() that uses
> SGP_NONE instead of SGP_WRITE to avoid accidentally allocating a bunch
> of memory as part of guest shutdown, and a
> kvm_restrictedmem_get_pfn_noalloc() variant to go along with that. But
> maybe a boolean param is better? Or maybe SGP_NOALLOC is the better
> default, and we just propagate an error to userspace if they didn't
> fallocate() in advance?

This (making fallocate() a hard requirement) not only complicates the
userspace but also forces the lazy-faulting going through a long path of
exiting to userspace. Unless we don't have other options I would not go
this way.

Chao
> 
> -Mike
> 
> > +	if (ret)
> > +		return ret;
> > +
> > +	*pagep = page;
> > +	if (order)
> > +		*order = thp_order(compound_head(page));
> > +
> > +	SetPageUptodate(page);
> > +	unlock_page(page);
> > +
> > +	return 0;
> > +}
> > +EXPORT_SYMBOL_GPL(restrictedmem_get_page);
> > -- 
> > 2.25.1
> > 
