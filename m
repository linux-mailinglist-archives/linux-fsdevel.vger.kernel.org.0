Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2149030C75C
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Feb 2021 18:20:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236972AbhBBRSu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 2 Feb 2021 12:18:50 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:31457 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236832AbhBBRQq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 2 Feb 2021 12:16:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612286120;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lEa8TASFowTmr9kKp6sPUUyPmHU/46QcAZCj48yANfk=;
        b=egSHzr5DtruvlX8eepGt/qpkEQ1BCwwQBtSxmjPOSN4/bs5DaN6vWxviX2+CKAzH/a3VN/
        EFHk0aDG72/XTmgOMBeyIXA/deaX5ep0JDkRs++02Ihgz2M2YoxLX10VpU3ixTdRfsnXSp
        DrRwcQHTw2gNKN6AHa0vjuN+/+ZgUAI=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-564-GxSc77FbMaWJkZrH0WnQ_A-1; Tue, 02 Feb 2021 12:15:19 -0500
X-MC-Unique: GxSc77FbMaWJkZrH0WnQ_A-1
Received: by mail-qt1-f198.google.com with SMTP id n22so14730295qtv.10
        for <linux-fsdevel@vger.kernel.org>; Tue, 02 Feb 2021 09:15:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=lEa8TASFowTmr9kKp6sPUUyPmHU/46QcAZCj48yANfk=;
        b=WmVEG+aa3QDV7EfJLlztt102X2UhksouLHZ3fDjg/Q4fNql3hs9hd0N6VzoHCWfT8r
         nHkjp4VSlCn4gC6YsnIpFkMUKpgRwWgpaKs62Zh6PAXAnW2loNI5rc8+/GlLrGKtFL1F
         P4l1mJk9q5nqRElZgrFjk4IFA+4oaphZS7Y1BRSxJB48h4cQPRNhB1Wu1GGUZui/lS/S
         Tv5ntO2/amTR4v2JyXBXG9R8VqyD4YCSfyPW7aoReW1a7+Ra+Bas9eeWPHkbCLnQfA6v
         GpeuYeNnTkRBObYD5OQGjxnbgBSyz/Ik3FxrlYbecOZYeSUxougn2OO1pk2Vl4sifzne
         mPdQ==
X-Gm-Message-State: AOAM530dIS7LiavDFfoMD0nq8ysL7lgJRgtVzgoUuJ8JfxavOsjVUaJi
        ksQQku3j1XTbiC6TSUiV4rmly1qF/ZykQOPwITd5mnN+aCBPb82TDEEcO1hAGYxBDAJV8UzN6B5
        Kv/Kiy1SZ9JA4jCf9AMPdPlmPGw==
X-Received: by 2002:a37:8b81:: with SMTP id n123mr22342721qkd.242.1612286118801;
        Tue, 02 Feb 2021 09:15:18 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzcppnC7lKM0JkQf/E3mgt/JhPqhdB0jg+3iHEp7UqjdhDN2d+ysu+mJtwxQ/4NGaXhYRD90Q==
X-Received: by 2002:a37:8b81:: with SMTP id n123mr22342688qkd.242.1612286118538;
        Tue, 02 Feb 2021 09:15:18 -0800 (PST)
Received: from xz-x1 (bras-vprn-toroon474qw-lp130-20-174-93-89-182.dsl.bell.ca. [174.93.89.182])
        by smtp.gmail.com with ESMTPSA id p11sm17044941qtb.62.2021.02.02.09.15.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Feb 2021 09:15:17 -0800 (PST)
Date:   Tue, 2 Feb 2021 12:15:15 -0500
From:   Peter Xu <peterx@redhat.com>
To:     Axel Rasmussen <axelrasmussen@google.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
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
        Mike Kravetz <mike.kravetz@oracle.com>,
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
        Oliver Upton <oupton@google.com>
Subject: Re: [PATCH v3 5/9] userfaultfd: add minor fault registration mode
Message-ID: <20210202171515.GF6468@xz-x1>
References: <20210128224819.2651899-1-axelrasmussen@google.com>
 <20210128224819.2651899-6-axelrasmussen@google.com>
 <20210201183159.GF260413@xz-x1>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210201183159.GF260413@xz-x1>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Feb 01, 2021 at 01:31:59PM -0500, Peter Xu wrote:
> On Thu, Jan 28, 2021 at 02:48:15PM -0800, Axel Rasmussen wrote:
> > This feature allows userspace to intercept "minor" faults. By "minor"
> > faults, I mean the following situation:
> > 
> > Let there exist two mappings (i.e., VMAs) to the same page(s) (shared
> > memory). One of the mappings is registered with userfaultfd (in minor
> > mode), and the other is not. Via the non-UFFD mapping, the underlying
> > pages have already been allocated & filled with some contents. The UFFD
> > mapping has not yet been faulted in; when it is touched for the first
> > time, this results in what I'm calling a "minor" fault. As a concrete
> > example, when working with hugetlbfs, we have huge_pte_none(), but
> > find_lock_page() finds an existing page.
> > 
> > This commit adds the new registration mode, and sets the relevant flag
> > on the VMAs being registered. In the hugetlb fault path, if we find
> > that we have huge_pte_none(), but find_lock_page() does indeed find an
> > existing page, then we have a "minor" fault, and if the VMA has the
> > userfaultfd registration flag, we call into userfaultfd to handle it.
> 
> When re-read, now I'm thinking whether we should restrict the minor fault
> scenario with shared mappings always, assuming there's one mapping with uffd
> and the other one without, while the non-uffd can modify the data before an
> UFFDIO_CONTINUE kicking the uffd process.
> 
> To me, it's really more about page cache and that's all..
> 
> So I'm wondering whether below would be simpler and actually clearer on
> defining minor faults, comparing to the above whole two paragraphs.  For
> example, the scemantics do not actually need two mappings:
> 
>     For shared memory, userfaultfd missing fault used to only report the event
>     if the page cache does not exist for the current fault process.  Here we
>     define userfaultfd minor fault as the case where the missing page fault
>     does have a backing page cache (so only the pgtable entry is missing).
> 
> It should not affect most of your code, but only one below [1].

OK it could be slightly more than that...

E.g. we'd need to make UFFDIO_COPY to not install the write bit if it's
UFFDIO_CONTINUE and if it's private mappings. In hugetlb_mcopy_atomic_pte() now
we apply the write bit unconditionally:

	_dst_pte = make_huge_pte(dst_vma, page, dst_vma->vm_flags & VM_WRITE);

That'll need a touch-up otherwise.

It's just the change seems still very small so I'd slightly prefer to support
it all.  However I don't want to make your series complicated and blocking it,
so please feel free to still make it shared memory if that's your preference.
The worst case is if someone would like to enable this (if with a valid user
scenario) we'd export a new uffd feature flag.

> 
> [...]
> 
> > @@ -1302,9 +1301,26 @@ static inline bool vma_can_userfault(struct vm_area_struct *vma,
> >  				     unsigned long vm_flags)
> >  {
> >  	/* FIXME: add WP support to hugetlbfs and shmem */
> > -	return vma_is_anonymous(vma) ||
> > -		((is_vm_hugetlb_page(vma) || vma_is_shmem(vma)) &&
> > -		 !(vm_flags & VM_UFFD_WP));
> > +	if (vm_flags & VM_UFFD_WP) {
> > +		if (is_vm_hugetlb_page(vma) || vma_is_shmem(vma))
> > +			return false;
> > +	}
> > +
> > +	if (vm_flags & VM_UFFD_MINOR) {
> > +		/*
> > +		 * The use case for minor registration (intercepting minor
> > +		 * faults) is to handle the case where a page is present, but
> > +		 * needs to be modified before it can be used. This requires
> > +		 * two mappings: one with UFFD registration, and one without.
> > +		 * So, it only makes sense to do this with shared memory.
> > +		 */
> > +		/* FIXME: Add minor fault interception for shmem. */
> > +		if (!(is_vm_hugetlb_page(vma) && (vma->vm_flags & VM_SHARED)))
> > +			return false;
> 
> [1]
> 
> So here we also restrict the mapping be shared.  My above comment on the commit
> message is also another way to ask whether we could also allow it to happen
> with non-shared mappings as long as there's a page cache.  If so, we could drop
> the VM_SHARED check here.  It won't affect your existing use case for sure, it
> just gives more possibility that maybe it could also be used on non-shared
> mappings due to some reason in the future.
> 
> What do you think?
> 
> The rest looks good to me.
> 
> Thanks,
> 
> -- 
> Peter Xu

-- 
Peter Xu

