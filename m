Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A738258E9A5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Aug 2022 11:30:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232103AbiHJJae (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 10 Aug 2022 05:30:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232099AbiHJJab (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 10 Aug 2022 05:30:31 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FBD1260A;
        Wed, 10 Aug 2022 02:30:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660123830; x=1691659830;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   mime-version:in-reply-to;
  bh=zHygXbTWCyPOJ+4aJpksT5a9YTzKkpyV1mfD/3Fs2Cg=;
  b=JpAhHRjiVNQiy83F70gwisr6MF3gEDtSJy+qDfOk2lHMyEsCRxI/aosk
   lYaVYequjkGeOsXkEQXgB8ebcVeovnXl0uXqPLEioH9NesaT+4VFQIOV0
   blTcyJKDJTneMm5mouhbl4ME+zMoRU5D1I7YxHfZPoL09mVr5NdiTeDCK
   l3fLPrLCTv71x8qb+f+GWjxZrCe4s+1tRJwxRlVgAy+PEEDzXYiLl7kLb
   HHcaY+4oeZ1VvpPeEyFviJfs9HS4qfPbeuWYMGo6MM4kgM3CRjM8qeD1M
   BfysjD5+GcBKVJdH9TyFPgqNe/gvQOv57xn43ITFbRk61T3y8+skcytIK
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10434"; a="316987586"
X-IronPort-AV: E=Sophos;i="5.93,227,1654585200"; 
   d="scan'208";a="316987586"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2022 02:30:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,227,1654585200"; 
   d="scan'208";a="664821304"
Received: from chaop.bj.intel.com (HELO localhost) ([10.240.193.75])
  by fmsmga008.fm.intel.com with ESMTP; 10 Aug 2022 02:30:18 -0700
Date:   Wed, 10 Aug 2022 17:25:32 +0800
From:   Chao Peng <chao.p.peng@linux.intel.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org, linux-doc@vger.kernel.org,
        qemu-devel@nongnu.org, linux-kselftest@vger.kernel.org,
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
        ak@linux.intel.com, aarcange@redhat.com, ddutile@redhat.com,
        dhildenb@redhat.com, Quentin Perret <qperret@google.com>,
        Michael Roth <michael.roth@amd.com>, mhocko@suse.com,
        Muchun Song <songmuchun@bytedance.com>
Subject: Re: [PATCH v7 04/14] mm/shmem: Support memfile_notifier
Message-ID: <20220810092532.GD862421@chaop.bj.intel.com>
Reply-To: Chao Peng <chao.p.peng@linux.intel.com>
References: <20220706082016.2603916-1-chao.p.peng@linux.intel.com>
 <20220706082016.2603916-5-chao.p.peng@linux.intel.com>
 <a34d88b9-a4b9-cb9e-91d9-c5a89449fcd5@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a34d88b9-a4b9-cb9e-91d9-c5a89449fcd5@redhat.com>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Aug 05, 2022 at 03:26:02PM +0200, David Hildenbrand wrote:
> On 06.07.22 10:20, Chao Peng wrote:
> > From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
> > 
> > Implement shmem as a memfile_notifier backing store. Essentially it
> > interacts with the memfile_notifier feature flags for userspace
> > access/page migration/page reclaiming and implements the necessary
> > memfile_backing_store callbacks.
> > 
> > Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> > Signed-off-by: Chao Peng <chao.p.peng@linux.intel.com>
> > ---
> 
> [...]
> 
> > +#ifdef CONFIG_MEMFILE_NOTIFIER
> > +static struct memfile_node *shmem_lookup_memfile_node(struct file *file)
> > +{
> > +	struct inode *inode = file_inode(file);
> > +
> > +	if (!shmem_mapping(inode->i_mapping))
> > +		return NULL;
> > +
> > +	return  &SHMEM_I(inode)->memfile_node;
> > +}
> > +
> > +
> > +static int shmem_get_pfn(struct file *file, pgoff_t offset, pfn_t *pfn,
> > +			 int *order)
> > +{
> > +	struct page *page;
> > +	int ret;
> > +
> > +	ret = shmem_getpage(file_inode(file), offset, &page, SGP_WRITE);
> > +	if (ret)
> > +		return ret;
> > +
> > +	unlock_page(page);
> > +	*pfn = page_to_pfn_t(page);
> > +	*order = thp_order(compound_head(page));
> > +	return 0;
> > +}
> > +
> > +static void shmem_put_pfn(pfn_t pfn)
> > +{
> > +	struct page *page = pfn_t_to_page(pfn);
> > +
> > +	if (!page)
> > +		return;
> > +
> > +	put_page(page);
> 
> 
> Why do we export shmem_get_pfn/shmem_put_pfn and not simply
> 
> get_folio()
> 
> and let the caller deal with putting the folio? What's the reason to
> 
> a) Operate on PFNs and not folios
> b) Have these get/put semantics?

We have a design assumption that somedays this can even support non-page
based backing stores. There are some discussions:
  https://lkml.org/lkml/2022/3/28/1440
I should add document for this two callbacks.

> 
> > +}
> > +
> > +static struct memfile_backing_store shmem_backing_store = {
> > +	.lookup_memfile_node = shmem_lookup_memfile_node,
> > +	.get_pfn = shmem_get_pfn,
> > +	.put_pfn = shmem_put_pfn,
> > +};
> > +#endif /* CONFIG_MEMFILE_NOTIFIER */
> > +
> >  void __init shmem_init(void)
> >  {
> >  	int error;
> > @@ -3956,6 +4059,10 @@ void __init shmem_init(void)
> >  	else
> >  		shmem_huge = SHMEM_HUGE_NEVER; /* just in case it was patched */
> >  #endif
> > +
> > +#ifdef CONFIG_MEMFILE_NOTIFIER
> > +	memfile_register_backing_store(&shmem_backing_store);
> 
> Can we instead prove a dummy function that does nothing without
> CONFIG_MEMFILE_NOTIFIER?

Sounds good.

Chao
> 
> > +#endif
> >  	return;
> >  
> >  out1:
> 
> 
> -- 
> Thanks,
> 
> David / dhildenb
> 
