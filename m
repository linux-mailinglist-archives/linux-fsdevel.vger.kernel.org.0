Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA41135D4BA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Apr 2021 03:22:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242198AbhDMBWS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Apr 2021 21:22:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:55540 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240140AbhDMBWS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Apr 2021 21:22:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618276919;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NEBjah6KfnPorZE8w92CEcFAPh+QAGov51+i+ByIFoM=;
        b=Cz1P3TT46JJdZqreKS9C1BcSFp1FdVgkDteWZSR2GXifkP624MkGCegkavEev0jqv3bSOO
        TtWajD2S2G4QWLyIx7Qs/Ir/b0C8DjK57/uMuLHGKGuhNgV163Oy/dF5BwXp6gKrc/q7NY
        DwMwSVGxMNrueM0edf9G1FZ8GweRrTI=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-528-3JhxYi1hM3evWoM-I2qItQ-1; Mon, 12 Apr 2021 21:21:57 -0400
X-MC-Unique: 3JhxYi1hM3evWoM-I2qItQ-1
Received: by mail-qt1-f199.google.com with SMTP id 11so311432qtz.7
        for <linux-fsdevel@vger.kernel.org>; Mon, 12 Apr 2021 18:21:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=NEBjah6KfnPorZE8w92CEcFAPh+QAGov51+i+ByIFoM=;
        b=Ya5HBdK0ju+yLIvsewhCYVWiwOM7NLfRw5eP+QUFMHo7JuK391CKyHA5nWp8PIBxEP
         YfMLUfOFi70CNvUHR4EIrREQfS1zODkj7qb8396yVyGktnm27VfMH+B+JjHQb5Z/o1w7
         I0mcTHQ0rq9LWJQZ319RG14rMvm7szZ2cSpftqIwiQ3iMykEwwaPSDU8gafjFyk1jnWX
         bWOovu4kAkQTOKWPTgBTjDcXpEcWmRYqKeMdEZg4veaQMenzKttyxL1TO0Zr3T1uQlrY
         fksXlz/fcxZG5JVMiNKTSq98wzQiFfW+CwgHIwsFM6wQCsK3hk9RCiTU+PQG/dZAoRDv
         U08A==
X-Gm-Message-State: AOAM530UCegUZR5gkpYVucVfXfRwjRaIJuUhPCUuJbzX9FUmRkOMIRt/
        +aU/nMmlIGFKdpFp3v7jWYrOthAI6rRQPjNz0zVCmfCBc4b0J7zY1T9Bu77gEhpVOqLm7RpHZLv
        kuSZ6xKkHtKArqHNEE5/FAlOwPg==
X-Received: by 2002:ac8:5996:: with SMTP id e22mr29052757qte.64.1618276916969;
        Mon, 12 Apr 2021 18:21:56 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy+67rQx0v+TacpKguZsqrrTReCrJzBFDPqLkJ0oEZn8JA/kzQvGaBMhEOyxp/AVVcMzR5Q6Q==
X-Received: by 2002:ac8:5996:: with SMTP id e22mr29052737qte.64.1618276916674;
        Mon, 12 Apr 2021 18:21:56 -0700 (PDT)
Received: from xz-x1 (bras-base-toroon474qw-grc-88-174-93-75-154.dsl.bell.ca. [174.93.75.154])
        by smtp.gmail.com with ESMTPSA id t4sm2659038qkg.75.2021.04.12.18.21.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Apr 2021 18:21:55 -0700 (PDT)
Date:   Mon, 12 Apr 2021 21:21:52 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Hugh Dickins <hughd@google.com>
Cc:     Axel Rasmussen <axelrasmussen@google.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jerome Glisse <jglisse@redhat.com>,
        Joe Perches <joe@perches.com>,
        Lokesh Gidra <lokeshgidra@google.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Shaohua Li <shli@fb.com>, Shuah Khan <shuah@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Wang Qing <wangqing@vivo.com>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, Brian Geffon <bgeffon@google.com>,
        Cannon Matthews <cannonmatthews@google.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Michel Lespinasse <walken@google.com>,
        Mina Almasry <almasrymina@google.com>,
        Oliver Upton <oupton@google.com>
Subject: Re: [PATCH v4] userfaultfd/shmem: fix MCOPY_ATOMIC_CONTINUE behavior
Message-ID: <20210413012152.GE1002612@xz-x1>
References: <20210401183701.1774159-1-axelrasmussen@google.com>
 <alpine.LSU.2.11.2104062307110.14082@eggly.anvils>
 <20210412215437.GA1001332@xz-x1>
 <alpine.LSU.2.11.2104121657050.1097@eggly.anvils>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alpine.LSU.2.11.2104121657050.1097@eggly.anvils>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Apr 12, 2021 at 05:51:14PM -0700, Hugh Dickins wrote:
> On Mon, 12 Apr 2021, Peter Xu wrote:
> > On Tue, Apr 06, 2021 at 11:14:30PM -0700, Hugh Dickins wrote:
> > > > +static int mcopy_atomic_install_ptes(struct mm_struct *dst_mm, pmd_t *dst_pmd,
> > > > +				     struct vm_area_struct *dst_vma,
> > > > +				     unsigned long dst_addr, struct page *page,
> > > > +				     enum mcopy_atomic_mode mode, bool wp_copy)
> > > > +{
> > 
> > [...]
> > 
> > > > +	if (writable) {
> > > > +		_dst_pte = pte_mkdirty(_dst_pte);
> > > > +		if (wp_copy)
> > > > +			_dst_pte = pte_mkuffd_wp(_dst_pte);
> > > > +		else
> > > > +			_dst_pte = pte_mkwrite(_dst_pte);
> > > > +	} else if (vm_shared) {
> > > > +		/*
> > > > +		 * Since we didn't pte_mkdirty(), mark the page dirty or it
> > > > +		 * could be freed from under us. We could do this
> > > > +		 * unconditionally, but doing it only if !writable is faster.
> > > > +		 */
> > > > +		set_page_dirty(page);
> > > 
> > > I do not remember why Andrea or I preferred set_page_dirty() here to
> > > pte_mkdirty(); but I suppose there might somewhere be a BUG_ON(pte_dirty)
> > > which this would avoid.  Risky to change it, though it does look odd.
> > 
> > Is any of the possible BUG_ON(pte_dirty) going to trigger because the pte has
> > write bit cleared?  That's one question I was not very sure, e.g., whether one
> > pte is allowed to be "dirty" if it's not writable.
> > 
> > To me it's okay, it's actually very suitable for UFFDIO_COPY case, where it is
> > definitely dirty data (so we must never drop it) even if it's installed as RO,
> > however to achieve that we can still set the dirty on the page rather than the
> > pte as what we do here.  It's just a bit awkward as you said.
> > 
> > Meanwhile today I just noticed this in arm64 code:
> > 
> > static inline pte_t pte_wrprotect(pte_t pte)
> > {
> > 	/*
> > 	 * If hardware-dirty (PTE_WRITE/DBM bit set and PTE_RDONLY
> > 	 * clear), set the PTE_DIRTY bit.
> > 	 */
> > 	if (pte_hw_dirty(pte))
> > 		pte = pte_mkdirty(pte);
> > 
> > 	pte = clear_pte_bit(pte, __pgprot(PTE_WRITE));
> > 	pte = set_pte_bit(pte, __pgprot(PTE_RDONLY));
> > 	return pte;
> > }
> > 
> > So arm64 will explicitly set the dirty bit (from the HW dirty bit) when
> > wr-protect.  It seems to prove that at least for arm64 it's very valid to have
> > !write && dirty pte.
> 
> I did not mean to imply that it's wrong to have pte_dirty without
> pte_write: no, I agree with you, I believe that there are accepted
> and generic ways in which we can have pte_dirty without pte_write
> (and we could each probably add a warning somewhere which would
> very quickly prove that - but those would not prove that there
> are not BUG_ONs on some other path, which had been my fear).
> 
> I wanted now to demonstrate that by pointing to change_pte_range() in
> mm/mprotect.c, showing that it does not clear pte_dirty when it clears
> pte_write. But alarmingly found rather the reverse: that it appears to
> set pte_write when it finds pte_dirty - if dirty_accountable.
> 
> That looks very wrong, but if I spent long enough following up
> dirty_accountable in detail, I think I would be reassured to find that
> it is only adding the pte_write there when it had removed it from the
> prot passed down, for dirty accounting reasons (which apply !VM_SHARED
> protections in the VM_SHARED case, so that page_mkwrite() is called
> and dirty accounting done when necessary).
> 
> What I did mean to imply is that changing set_page_dirty to pte_mkdirty,
> to make that userfaultfd code block look nicer, is not a change to be
> done lightly: by all means try it out, test it, and send a patch after
> Axel's series is in, but please do not ask Axel to make that change as
> a part of his series - it would be taking a risk, just for a cleanup.

Fair enough.  Sorry if I wasn't clear when asking, the reason to ask was that I
wanted to be clear on these differences.  For example, in my uffd-wp shmem
series I'll have to make sure dirty bit always there, I used pte_mkdirty()
unconditionally but I wanted to make sure I'm not overlooking anything..

Though this case is slightly special here, since if without the cleaning up the
logic will definitely be harder to review (with the cleanup, it'll be as simple
as one unconditional pte_mkdirty() and that's all).  However you're definitely
right, it's not a reason to overload Axel with this patchset, especially if
such a cleanup is seen to be risky.

> 
> Now, I have also looked up the mail exchange with Andrea which led to
> his dcf7fe9d8976 ("userfaultfd: shmem: UFFDIO_COPY: set the page dirty
> if VM_WRITE is not set") - it had to be off-list at the time.  And he
> was rather led to that set_page_dirty by following old patterns left
> over in shmem_getpage_gfp(); but when I said "or it could be done with
> pte_mkdirty without pte_mkwrite", he answered "I explicitly avoided
> that because pte_dirty then has side effects on mprotect to decide
> pte_write. It looks safer to do set_page_dirty and not set dirty bits
> in not writable ptes unnecessarily".
> 
> Haha: I think Andrea is referring to exactly the dirty_accountable code
> in change_pte_protection() which worried me above. Now, I think that
> will turn out okay (shmem does not have a page_mkwrite(), and does not
> participate in dirty accounting), but you will have to do some work to
> assure us all of that, before sending in a cleanup patch.

OK. Maybe I can clean this after Axel's work.

Thanks a lot for all these details, Hugh!

-- 
Peter Xu

