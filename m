Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B78530B2D5
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Feb 2021 23:42:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229606AbhBAWmK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 1 Feb 2021 17:42:10 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:35099 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229593AbhBAWmG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 1 Feb 2021 17:42:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612219240;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=J18vp4BI/ebFhdk0cpsu32Zy+DBZ0tg0DUF5VJd/Tc0=;
        b=LuFQ339/I2nM/5Rj6130QGBG36mwtK88bPPH5Og3e/+RmkCNYJ71J/zlPJXA3d5EJQAn1t
        YdeDSMElGQO3r0MP+NAi2YvNXmjUm51SGgzizRX0FRnqCgelVf6etbPlIfxeDWcgSbm19a
        1/kf9SjIzYAmOqybIVEowHkSgji0olE=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-253-vQyAO7LEMcOv-gKObbqjJA-1; Mon, 01 Feb 2021 17:40:39 -0500
X-MC-Unique: vQyAO7LEMcOv-gKObbqjJA-1
Received: by mail-qv1-f70.google.com with SMTP id u8so12381095qvm.5
        for <linux-fsdevel@vger.kernel.org>; Mon, 01 Feb 2021 14:40:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=J18vp4BI/ebFhdk0cpsu32Zy+DBZ0tg0DUF5VJd/Tc0=;
        b=oel9URWbGOpeN4wCZPEB5CcERP+YczrVCAZn62s8ehV49E7v1rfJQY1vcNNWn+ei76
         m3D9SfRc3zRXatK3Bk72ja9339xzm3g5DjZU8ghHZgizh0ypMyilmfSSbWmI0xyMVUP0
         GsJIZXU96Cs+dkcDNChGqtEx7oyWpfm+PUTeArKmZIpA6EnhDaSwjdMuLRG2dLxXNlG/
         x0ddWHErcp3c9dbySUO1eQpkyjEZ4wLOPuMnH488TYDSqj/VwtVfh+a+qhGAw4UyG0q6
         m4OWwVebozCH5CHwlmbHt3Aa6aKJXx+dgoGVl4DHvED8eHTZPeZ/U8W/mlEJj4UIQ/T5
         QZxA==
X-Gm-Message-State: AOAM5327W2GTDKFS5PvxCuyrrE+c8Da+TAiWXfgSjIOQMcmk8wJrsf0z
        N3XX75b8+KUspJ+TnK3q6wkyH9eauskCWSl80Ovwgy2xLAZ7IiFPUf6c0apGMdWAMS/9ju3eejL
        qkFTzG/LrTmaRov2V676cyNEIRQ==
X-Received: by 2002:ac8:a0e:: with SMTP id b14mr17645152qti.84.1612219237530;
        Mon, 01 Feb 2021 14:40:37 -0800 (PST)
X-Google-Smtp-Source: ABdhPJz7xwXfMofxMeMxRqMfaHNZOg0cOL3zUZ3F3Qf+B3DM0/q4O8qqrR6sOuxbjzxvhBSR938x4Q==
X-Received: by 2002:ac8:a0e:: with SMTP id b14mr17645127qti.84.1612219237292;
        Mon, 01 Feb 2021 14:40:37 -0800 (PST)
Received: from xz-x1 ([142.126.83.202])
        by smtp.gmail.com with ESMTPSA id q92sm14531141qtd.92.2021.02.01.14.40.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Feb 2021 14:40:36 -0800 (PST)
Date:   Mon, 1 Feb 2021 17:40:34 -0500
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
        Oliver Upton <oupton@google.com>
Subject: Re: [PATCH v3 7/9] userfaultfd: add UFFDIO_CONTINUE ioctl
Message-ID: <20210201224034.GK260413@xz-x1>
References: <20210128224819.2651899-1-axelrasmussen@google.com>
 <20210128224819.2651899-8-axelrasmussen@google.com>
 <20210201192120.GG260413@xz-x1>
 <CAJHvVciv0-Xq75TKB=g=Sb+HmwMdJEd+CHg885TWX2svYCwFiQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJHvVciv0-Xq75TKB=g=Sb+HmwMdJEd+CHg885TWX2svYCwFiQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Feb 01, 2021 at 02:11:55PM -0800, Axel Rasmussen wrote:
> On Mon, Feb 1, 2021 at 11:21 AM Peter Xu <peterx@redhat.com> wrote:
> >
> > On Thu, Jan 28, 2021 at 02:48:17PM -0800, Axel Rasmussen wrote:
> > > diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
> > > index f94a35296618..79e1f0155afa 100644
> > > --- a/include/linux/hugetlb.h
> > > +++ b/include/linux/hugetlb.h
> > > @@ -135,11 +135,14 @@ void hugetlb_show_meminfo(void);
> > >  unsigned long hugetlb_total_pages(void);
> > >  vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
> > >                       unsigned long address, unsigned int flags);
> > > +#ifdef CONFIG_USERFAULTFD
> >
> > I'm confused why this is needed.. hugetlb_mcopy_atomic_pte() should only be
> > called in userfaultfd.c, but if without uffd config set it won't compile
> > either:
> >
> >         obj-$(CONFIG_USERFAULTFD) += userfaultfd.o
> 
> With this series as-is, but *without* the #ifdef CONFIG_USERFAULTFD
> here, we introduce a bunch of build warnings like this:
> 
> 
> 
> In file included from ./include/linux/migrate.h:8:0,
>                  from kernel/sched/sched.h:53,
>                  from kernel/sched/isolation.c:10:
> ./include/linux/hugetlb.h:143:12: warning: 'enum mcopy_atomic_mode'
> declared inside parameter list
>      struct page **pagep);
>             ^
> ./include/linux/hugetlb.h:143:12: warning: its scope is only this
> definition or declaration, which is probably not what you want
> 
> And similarly we get an error about the "mode" parameter having an
> incomplete type in hugetlb.c.
> 
> 
> 
> This is because enum mcopy_atomic_mode is defined in userfaultfd_k.h,
> and that entire header is wrapped in a #ifdef CONFIG_USERFAULTFD. So
> we either need to define enum mcopy_atomic_mode unconditionally, or we
> need to #ifdef CONFIG_USERFAULTFD the references to it also.
> 
> - I opted not to move it outside the #ifdef CONFIG_USERFAULTFD in
> userfaultfd_k.h (defining it unconditionally), because that seemed
> messy to me.
> - I opted not to define it unconditionally in hugetlb.h, because we'd
> have to move it to userfaultfd_k.h anyway when shmem or other users
> are introduced. I'm planning to send a series to add this a few days
> or so after this series is merged, so it seems churn-y to move it
> then.
> - It seemed optimal to not compile hugetlb_mcopy_atomic_pte anyway
> (even ignoring adding the continue ioctl), since as you point out
> userfaultfd is the only caller.
> 
> Hopefully this clarifies this and the next two comments. Let me know
> if you still feel strongly, I don't hate any of the alternatives, just
> wanted to clarify that I had considered them and thought this approach
> was best.

Then I'd suggest you use a standalone patch to put hugetlb_mcopy_atomic_pte()
into CONFIG_USERFAULTFD blocks, then propose your change with the minor mode.
Note that there're two hugetlb_mcopy_atomic_pte() defined in hugetlb.h.
Although I don't think it a problem since the other one is inlined - I think
you should still put that one into the same ifdef:

#ifdef CONFIG_USERFAULTFD
static inline int hugetlb_mcopy_atomic_pte(struct mm_struct *dst_mm,
						pte_t *dst_pte,
						struct vm_area_struct *dst_vma,
						unsigned long dst_addr,
						unsigned long src_addr,
						struct page **pagep)
{
	BUG();
	return 0;
}
#endif /* CONFIG_USERFAULTFD */

Let's also see whether Mike would have a preference on this.

Thanks,

-- 
Peter Xu

