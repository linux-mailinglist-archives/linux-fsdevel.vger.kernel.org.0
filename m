Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B81643230C5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Feb 2021 19:31:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233965AbhBWSab (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 Feb 2021 13:30:31 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:41956 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233880AbhBWSa3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 Feb 2021 13:30:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1614104942;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=o+lMNmwE9sWeaJZim5ktBynQMO9mBkWFkIPu3ZX6sdY=;
        b=GxTI5FNILOwQGgO1im5rT80uUghcNdet7H1yRoj0nI2rCJwZ+w2uw0uWQu1NGk5QVYskYi
        zs1+9flIieVgh9vgXQn2c7RyuLG4H1JfIHW+5doLTxgagC/HAXpgIJbZLKGjZ0WzG1p+Uv
        hgcabndRFG/vLrIYVLnuRzunbw8csz4=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-153-kpm7Qzw6Nguy1H67XbP_5A-1; Tue, 23 Feb 2021 13:29:00 -0500
X-MC-Unique: kpm7Qzw6Nguy1H67XbP_5A-1
Received: by mail-qt1-f197.google.com with SMTP id 22so10642302qty.14
        for <linux-fsdevel@vger.kernel.org>; Tue, 23 Feb 2021 10:29:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=o+lMNmwE9sWeaJZim5ktBynQMO9mBkWFkIPu3ZX6sdY=;
        b=CtDGDRiNSlahKuyOYc4gsTgXUpyzpJRpNL0j5uZ7jHv4nvf5xUabgHZ5bVLJgPCcF1
         K+p+BmIUmlEcJH3qjh4rW0PSCHTPXrfE6chLUKjNJ2a+dTNw6H1vcl7Ch26MAMnLRyxu
         AhhHBr8XWMfoUioXhEsm8ubWkmsw1Vyl0/Vroq/DGMAlpXrhbe4/rVPGxYXW/NNJGeqM
         f8FDXoihg0Ks9XocvC/8VvEuyRanGhc9HzSITythReTdBZHUGS5MGFkOnGvOcR2oQic7
         QgxpM0UBc1YZ0CQ39omnqqPIJko+5pG/S3FEyEZwEzh+gFeclsXLXnbL9TxDZDkBlxMu
         8g1w==
X-Gm-Message-State: AOAM531cHWHteNV7iEv0Hwjdpsfj4nPkXqkLJ1/qlpjghn1p2i7uyYLy
        wQbz8NhuDbpAxyD9qbxneJtgH8Gqjv0nbdL7jDM6CdlX2EFV/cbDIOsgBo8y3jnLEvuITveKQxn
        /kLUBcrmQeu5SElIObRSmIDyesQ==
X-Received: by 2002:a05:620a:21c2:: with SMTP id h2mr27925122qka.494.1614104940024;
        Tue, 23 Feb 2021 10:29:00 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw/BshTm6p2mAAGoJn9l2lOs8hsKvkpGfB8X8pMIvq7Eii7zi5lDF8avtFrEUscK2NizzpzIA==
X-Received: by 2002:a05:620a:21c2:: with SMTP id h2mr27925073qka.494.1614104939764;
        Tue, 23 Feb 2021 10:28:59 -0800 (PST)
Received: from xz-x1 (bras-vprn-toroon474qw-lp130-25-174-95-95-253.dsl.bell.ca. [174.95.95.253])
        by smtp.gmail.com with ESMTPSA id d5sm9388455qtd.67.2021.02.23.10.28.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Feb 2021 10:28:58 -0800 (PST)
Date:   Tue, 23 Feb 2021 13:28:56 -0500
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
        Vlastimil Babka <vbabka@suse.cz>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, Linux MM <linux-mm@kvack.org>,
        Adam Ruprecht <ruprecht@google.com>,
        Cannon Matthews <cannonmatthews@google.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Mina Almasry <almasrymina@google.com>,
        Oliver Upton <oupton@google.com>
Subject: Re: [PATCH v7 4/6] userfaultfd: add UFFDIO_CONTINUE ioctl
Message-ID: <20210223182856.GA176114@xz-x1>
References: <20210219004824.2899045-1-axelrasmussen@google.com>
 <20210219004824.2899045-5-axelrasmussen@google.com>
 <20210223153840.GB154711@xz-x1>
 <CAJHvVcg_hV0diLxyB2=JbLbJkXWTW+zsPsdzBTJW_WcG-vbvbA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJHvVcg_hV0diLxyB2=JbLbJkXWTW+zsPsdzBTJW_WcG-vbvbA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Feb 23, 2021 at 10:05:49AM -0800, Axel Rasmussen wrote:
> On Tue, Feb 23, 2021 at 7:38 AM Peter Xu <peterx@redhat.com> wrote:
> >
> > On Thu, Feb 18, 2021 at 04:48:22PM -0800, Axel Rasmussen wrote:
> > > @@ -4645,8 +4646,18 @@ int hugetlb_mcopy_atomic_pte(struct mm_struct *dst_mm,
> > >       spinlock_t *ptl;
> > >       int ret;
> > >       struct page *page;
> > > +     int writable;
> > >
> > > -     if (!*pagep) {
> > > +     mapping = dst_vma->vm_file->f_mapping;
> > > +     idx = vma_hugecache_offset(h, dst_vma, dst_addr);
> > > +
> > > +     if (is_continue) {
> > > +             ret = -EFAULT;
> > > +             page = find_lock_page(mapping, idx);
> > > +             *pagep = NULL;
> >
> > Why set *pagep to NULL?  Shouldn't it be NULL always?.. If that's the case,
> > maybe WARN_ON_ONCE(*pagep) suite more.
> 
> Right, the caller should be passing in NULL in the
> MCOPY_ATOMIC_CONTINUE case. Looking more closely at the caller
> (__mcopy_atomic_hugetlb), it already has a BUG_ON(page), so at best
> this assignment is redundant, and at worst it might actually cover up
> a real bug (say the caller mistakenly *did* pass in some page, we'd
> set it to NULL and the BUG_ON wouldn't trigger).
> 
> So, I'll just remove this - I don't think an additional WARN_ON_ONCE
> is needed given the existing BUG_ON.

It's still okay to have the WARN_ON_ONCE; it gives a direct hint that *pagep
should never be set for uffdio_continue.  No strong opinion.

> 
> >
> > Otherwise the patch looks good to me.
> 
> Shall I add a R-B? :)

Yes, as long as "*pagep = NULL" dropped, please feel free to. :)

Thanks,

-- 
Peter Xu

