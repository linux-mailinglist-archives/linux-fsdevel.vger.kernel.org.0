Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96AEC31A6BB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Feb 2021 22:21:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232041AbhBLVUf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 12 Feb 2021 16:20:35 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:34446 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231501AbhBLVU3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 12 Feb 2021 16:20:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1613164741;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ECWAuKMicsl2BzJlbKNKyjnZw633xrb05WUgP1ZpmLg=;
        b=Z+fll2QmRkL0khjovo38O8CGBRss+7iUZVo9vlSPCjb/u9Y2swDiVcKd1QG9EQXbDbo/In
        Fed7pkda1lEUjZk9fl1DdFlUZ5N7RFE5GSp/jX2y68NKBNg6MUHfF6Cme/obIRuf0qSqoH
        qs73OLCaQqHlnPQLkf0LhRWbM9LCAKg=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-250-36h4QpFDPYSl8OukqGPZQg-1; Fri, 12 Feb 2021 16:19:00 -0500
X-MC-Unique: 36h4QpFDPYSl8OukqGPZQg-1
Received: by mail-qv1-f69.google.com with SMTP id h10so470571qvf.19
        for <linux-fsdevel@vger.kernel.org>; Fri, 12 Feb 2021 13:19:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ECWAuKMicsl2BzJlbKNKyjnZw633xrb05WUgP1ZpmLg=;
        b=VN1HbzC3Id7HCKKrQNOWf573WkFwdzViAmmeoSh7cPJ4nwXH9nPu1UqJ3bC7CH84uT
         MchlNbXaUM23DTOm3ZbU02Xkk7z5KhfkRdOrq9Hkfvf8WrMoKnIOA7EZU3IMhQaUIouX
         LAuQ2Xi6M3ZO3zrdKm1ak+tNwDJExQilIfwaubKOoKgO+6nNxZiYfNHXP6Su20lYfR8V
         dnG1/2D5JETDS5WonZtmDaieqUd+Y6/DILwdYoiTfPj2GbMDVhPhYZpQe1f06kT7TDIt
         8rZsnL8MqOfRmaX+i4FC+8hhVd/k/5zf4rn5K5nDtWJomekyZYBO4hHDMsn2MyhGfeqM
         Bg3A==
X-Gm-Message-State: AOAM531ESVbEkfnCmbiN7WR7mUFgSkRaT2hbjWpblqIyrMcS0xvnXKix
        p8lyszHQaux+TbOcErIS2oBuLUusXDhOoKqr2+Nf1lredBr9MFXU9Hgw/XES14UpPdYWRSu58MG
        VhdlgS4u3jWROVOQe8bWe+xLORQ==
X-Received: by 2002:ac8:7293:: with SMTP id v19mr4170944qto.161.1613164739643;
        Fri, 12 Feb 2021 13:18:59 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzpW1ZrKczGFvQg8f9YGeyNR1U6/C4kBa+gzLkCiCXhmBa2oPo/7DrcFs0x1XZjSs2ZPOEjcw==
X-Received: by 2002:ac8:7293:: with SMTP id v19mr4170895qto.161.1613164739311;
        Fri, 12 Feb 2021 13:18:59 -0800 (PST)
Received: from xz-x1 (bras-vprn-toroon474qw-lp130-20-174-93-89-182.dsl.bell.ca. [174.93.89.182])
        by smtp.gmail.com with ESMTPSA id h11sm6971410qkj.135.2021.02.12.13.18.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Feb 2021 13:18:58 -0800 (PST)
Date:   Fri, 12 Feb 2021 16:18:56 -0500
From:   Peter Xu <peterx@redhat.com>
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     Axel Rasmussen <axelrasmussen@google.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Chinwen Chang <chinwen.chang@mediatek.com>,
        Huang Ying <ying.huang@intel.com>,
        Ingo Molnar <mingo@redhat.com>, Jann Horn <jannh@google.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Lokesh Gidra <lokeshgidra@google.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>,
        Michel Lespinasse <walken@google.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Nicholas Piggin <npiggin@gmail.com>, Shaohua Li <shli@fb.com>,
        Shawn Anastasio <shawn@anastas.io>,
        Steven Rostedt <rostedt@goodmis.org>,
        Steven Price <steven.price@arm.com>,
        Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        Adam Ruprecht <ruprecht@google.com>,
        Cannon Matthews <cannonmatthews@google.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Mina Almasry <almasrymina@google.com>,
        Oliver Upton <oupton@google.com>
Subject: Re: [PATCH v5 04/10] hugetlb/userfaultfd: Unshare all pmds for
 hugetlbfs when register wp
Message-ID: <20210212211856.GD3171@xz-x1>
References: <20210210212200.1097784-1-axelrasmussen@google.com>
 <20210210212200.1097784-5-axelrasmussen@google.com>
 <517f3477-cb80-6dc9-bda0-b147dea68f95@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <517f3477-cb80-6dc9-bda0-b147dea68f95@oracle.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Feb 12, 2021 at 10:11:39AM -0800, Mike Kravetz wrote:
> On 2/10/21 1:21 PM, Axel Rasmussen wrote:
> > From: Peter Xu <peterx@redhat.com>
> > 
> > Huge pmd sharing for hugetlbfs is racy with userfaultfd-wp because
> > userfaultfd-wp is always based on pgtable entries, so they cannot be shared.
> > 
> > Walk the hugetlb range and unshare all such mappings if there is, right before
> > UFFDIO_REGISTER will succeed and return to userspace.
> > 
> > This will pair with want_pmd_share() in hugetlb code so that huge pmd sharing
> > is completely disabled for userfaultfd-wp registered range.
> > 
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>
> > ---
> >  fs/userfaultfd.c             | 48 ++++++++++++++++++++++++++++++++++++
> >  include/linux/mmu_notifier.h |  1 +
> >  2 files changed, 49 insertions(+)
> > 
> > diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
> > index 0be8cdd4425a..1f4a34b1a1e7 100644
> > --- a/fs/userfaultfd.c
> > +++ b/fs/userfaultfd.c
> > @@ -15,6 +15,7 @@
> >  #include <linux/sched/signal.h>
> >  #include <linux/sched/mm.h>
> >  #include <linux/mm.h>
> > +#include <linux/mmu_notifier.h>
> >  #include <linux/poll.h>
> >  #include <linux/slab.h>
> >  #include <linux/seq_file.h>
> > @@ -1191,6 +1192,50 @@ static ssize_t userfaultfd_read(struct file *file, char __user *buf,
> >  	}
> >  }
> >  
> > +/*
> > + * This function will unconditionally remove all the shared pmd pgtable entries
> > + * within the specific vma for a hugetlbfs memory range.
> > + */
> > +static void hugetlb_unshare_all_pmds(struct vm_area_struct *vma)
> > +{
> > +#ifdef CONFIG_HUGETLB_PAGE
> > +	struct hstate *h = hstate_vma(vma);
> > +	unsigned long sz = huge_page_size(h);
> > +	struct mm_struct *mm = vma->vm_mm;
> > +	struct mmu_notifier_range range;
> > +	unsigned long address;
> > +	spinlock_t *ptl;
> > +	pte_t *ptep;
> > +
> > +	if (!(vma->vm_flags & VM_MAYSHARE))
> > +		return;
> > +
> > +	/*
> > +	 * No need to call adjust_range_if_pmd_sharing_possible(), because
> > +	 * we're going to operate on the whole vma
> > +	 */
> 
> This code will certainly work as intended.  However, I wonder if we should
> try to optimize and only flush and call huge_pmd_unshare for addresses where
> sharing is possible.  Consider this worst case example:
> 
> vm_start = 8G + 2M
> vm_end   = 11G - 2M
> The vma is 'almost' 3G in size, yet only the range 9G to 10G is possibly
> shared.  This routine will potentially call lock/unlock ptl and call
> huge_pmd_share for every huge page in the range.  Ideally, we should only
> make one call to huge_pmd_share with address 9G.  If the unshare is
> successful or not, we are done.  The subtle manipulation of &address in
> huge_pmd_unshare will result in only one call if the unshare is successful,
> but if unsuccessful we will unnecessarily call huge_pmd_unshare for each
> address in the range.
> 
> Maybe we start by rounding up vm_start by PUD_SIZE and rounding down
> vm_end by PUD_SIZE.  

I didn't think that lot since it's slow path, but yeah if that's faster and
without extra logic, then why not. :)

> 
> > +	mmu_notifier_range_init(&range, MMU_NOTIFY_HUGETLB_UNSHARE,
> > +				0, vma, mm, vma->vm_start, vma->vm_end);
> > +	mmu_notifier_invalidate_range_start(&range);
> > +	i_mmap_lock_write(vma->vm_file->f_mapping);
> > +	for (address = vma->vm_start; address < vma->vm_end; address += sz) {
> 
> Then, change the loop increment to PUD_SIZE.  And, also ignore the &address
> manipulation done by huge_pmd_unshare.

Will do!

> 
> > +		ptep = huge_pte_offset(mm, address, sz);
> > +		if (!ptep)
> > +			continue;
> > +		ptl = huge_pte_lock(h, mm, ptep);
> > +		huge_pmd_unshare(mm, vma, &address, ptep);
> > +		spin_unlock(ptl);
> > +	}
> > +	flush_hugetlb_tlb_range(vma, vma->vm_start, vma->vm_end);
> > +	i_mmap_unlock_write(vma->vm_file->f_mapping);
> > +	/*
> > +	 * No need to call mmu_notifier_invalidate_range(), see
> > +	 * Documentation/vm/mmu_notifier.rst.
> > +	 */
> > +	mmu_notifier_invalidate_range_end(&range);
> > +#endif
> > +}
> > +
> >  static void __wake_userfault(struct userfaultfd_ctx *ctx,
> >  			     struct userfaultfd_wake_range *range)
> >  {
> > @@ -1449,6 +1494,9 @@ static int userfaultfd_register(struct userfaultfd_ctx *ctx,
> >  		vma->vm_flags = new_flags;
> >  		vma->vm_userfaultfd_ctx.ctx = ctx;
> >  
> > +		if (is_vm_hugetlb_page(vma) && uffd_disable_huge_pmd_share(vma))
> > +			hugetlb_unshare_all_pmds(vma);
> > +
> >  	skip:
> >  		prev = vma;
> >  		start = vma->vm_end;
> > diff --git a/include/linux/mmu_notifier.h b/include/linux/mmu_notifier.h
> > index b8200782dede..ff50c8528113 100644
> > --- a/include/linux/mmu_notifier.h
> > +++ b/include/linux/mmu_notifier.h
> > @@ -51,6 +51,7 @@ enum mmu_notifier_event {
> >  	MMU_NOTIFY_SOFT_DIRTY,
> >  	MMU_NOTIFY_RELEASE,
> >  	MMU_NOTIFY_MIGRATE,
> > +	MMU_NOTIFY_HUGETLB_UNSHARE,
> 
> I don't claim to know much about mmu notifiers.  Currently, we use other
> event notifiers such as MMU_NOTIFY_CLEAR.  I guess we do 'clear' page table
> entries if we unshare.  More than happy to have a MMU_NOTIFY_HUGETLB_UNSHARE
> event, but will consumers of the notifications know what this new event type
> means?  And, if we introduce this should we use this other places where
> huge_pmd_unshare is called?

Yeah AFAICT that is a new feature to mmu notifiers and it's not really used a
lot by consumers yet.  Hmm... is there really any consumer at all? I simply
grepped MMU_NOTIFY_UNMAP and see no hook took special care of that.  So it's
some extra information that the upper layer would like to deliever to the
notifiers, it's just not vastly used so far.

So far I didn't worry too much on that either.  MMU_NOTIFY_HUGETLB_UNSHARE is
introduced here simply because I tried to make it explicit, then it's easy to
be overwritten one day if we think huge pmd unshare is not worth a standalone
flag but reuse some other common one.  But I think at least I owe one
documentation of that new enum. :)

I'm not extremely willing to touch the rest callers of huge pmd unshare yet,
unless I've a solid reason.  E.g., one day maybe one mmu notifier hook would
start to monitor some events, then that's a better place imho to change them.
Otherwise any of my future change could be vague, imho.

For this patch - how about I simply go back to use MMU_NOTIFIER_CLEAR instead?

Thanks,

-- 
Peter Xu

