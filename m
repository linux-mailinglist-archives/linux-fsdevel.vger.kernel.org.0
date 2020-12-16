Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06D602DC8EB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Dec 2020 23:26:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730221AbgLPW0f (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Dec 2020 17:26:35 -0500
Received: from mx2.suse.de ([195.135.220.15]:35848 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730213AbgLPW0e (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Dec 2020 17:26:34 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 5D02FAC90;
        Wed, 16 Dec 2020 22:25:53 +0000 (UTC)
Date:   Wed, 16 Dec 2020 23:25:49 +0100
From:   Oscar Salvador <osalvador@suse.de>
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     Muchun Song <songmuchun@bytedance.com>, corbet@lwn.net,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        hpa@zytor.com, dave.hansen@linux.intel.com, luto@kernel.org,
        peterz@infradead.org, viro@zeniv.linux.org.uk,
        akpm@linux-foundation.org, paulmck@kernel.org,
        mchehab+huawei@kernel.org, pawan.kumar.gupta@linux.intel.com,
        rdunlap@infradead.org, oneukum@suse.com, anshuman.khandual@arm.com,
        jroedel@suse.de, almasrymina@google.com, rientjes@google.com,
        willy@infradead.org, mhocko@suse.com, song.bao.hua@hisilicon.com,
        david@redhat.com, duanxiongchun@bytedance.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v9 03/11] mm/hugetlb: Free the vmemmap pages associated
 with each HugeTLB page
Message-ID: <20201216222549.GC3207@localhost.localdomain>
References: <20201213154534.54826-1-songmuchun@bytedance.com>
 <20201213154534.54826-4-songmuchun@bytedance.com>
 <5936a766-505a-eab0-42a6-59aab2585880@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5936a766-505a-eab0-42a6-59aab2585880@oracle.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Dec 16, 2020 at 02:08:30PM -0800, Mike Kravetz wrote:
> > + * vmemmap_rmap_walk - walk vmemmap page table
> 
> I am not sure if 'rmap' should be part of these names.  rmap today is mostly
> about reverse mapping lookup.  Did you use rmap for 'remap', or because this
> code is patterned after the page table walking rmap code?  Just think the
> naming could cause some confusion.

I also had the same feeling about the 'rmap' usage.

> > +
> > +static void vmemmap_pte_range(pmd_t *pmd, unsigned long addr,
> > +			      unsigned long end, struct vmemmap_rmap_walk *walk)
> > +{
> > +	pte_t *pte;
> > +
> > +	pte = pte_offset_kernel(pmd, addr);
> > +	do {
> > +		BUG_ON(pte_none(*pte));
> > +
> > +		if (!walk->reuse)
> > +			walk->reuse = pte_page(pte[VMEMMAP_TAIL_PAGE_REUSE]);
> 
> It may be just me, but I don't like the pte[-1] here.  It certainly does work
> as designed because we want to remap all pages in the range to the page before
> the range (at offset -1).  But, we do not really validate this 'reuse' page.
> There is the BUG_ON(pte_none(*pte)) as a sanity check, but we do nothing similar
> for pte[-1].  Based on the usage for HugeTLB pages, we can be confident that
> pte[-1] is actually a pte.  In discussions with Oscar, you mentioned another
> possible use for these routines.

Without giving it much of a thought, I guess we could duplicate the
BUG_ON for the pte outside the loop, and add a new one for pte[-1].
Also, since walk->reuse seems to not change once it is set, we can take
it outside the loop? e.g:

	pte *pte;

	pte = pte_offset_kernel(pmd, addr);
	BUG_ON(pte_none(*pte));
	BUG_ON(pte_none(pte[VMEMMAP_TAIL_PAGE_REUSE]));
	walk->reuse = pte_page(pte[VMEMMAP_TAIL_PAGE_REUSE]);
	do {
		....
	} while...

Or I am not sure whether we want to keep it inside the loop in case
future cases change walk->reuse during the operation.
But to be honest, I do not think it is realistic of all future possible
uses of this, so I would rather keep it simple for now.

-- 
Oscar Salvador
SUSE L3
