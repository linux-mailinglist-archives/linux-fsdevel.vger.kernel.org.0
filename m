Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB1C2316FA8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Feb 2021 20:08:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233814AbhBJTIB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 10 Feb 2021 14:08:01 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:32609 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234487AbhBJTHo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 10 Feb 2021 14:07:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612983977;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mTO49+9LAVg0rMFnoR7UG6tSv24dSvHoSbA2pY65UM0=;
        b=fYdbl/Yk89JUAKqhU5KSPo9uJ7A7sfWjmo0ZMkRyz/aK9qb8sL1BKihIjS7DXckrhsWSt4
        nHUG4g93iubjCB+U0vAthCXFhaUBO10qXv6ugFF6L/RgpeLJytk1PThXmnY5LitHTfVXcg
        1cNzappu4FAniqLIVveU5nFpge9LBE0=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-88-aZFIKgo4NqaSjVr_BOLXug-1; Wed, 10 Feb 2021 14:06:16 -0500
X-MC-Unique: aZFIKgo4NqaSjVr_BOLXug-1
Received: by mail-qk1-f199.google.com with SMTP id p185so2406110qkc.9
        for <linux-fsdevel@vger.kernel.org>; Wed, 10 Feb 2021 11:06:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=mTO49+9LAVg0rMFnoR7UG6tSv24dSvHoSbA2pY65UM0=;
        b=lDmena9Zbrzg9unDy6jJbvXuK9N1S9osiPHRgehLGIar1aiDGSLZHTWOnS41GLRcS2
         7hV+DZ/PiCh9Em8hWCyIYKmHEVVqOn8OtR2BJvnyORqLCc3+Sv1r6ipoEB1BCMZOxXiL
         31xUjBzU2uFeh0rEdNZoa3t0zzlIK/rtvan3zV3SwN2ost8JFWTQd2udOXllPLtK36HF
         AynOcJg3xaTz+f9cnm1ZNpUHVAdCf7KuIsfNbUa/IcaIf4pGJGZZ+HV1/eKKcX5SkLK1
         AFM4/vakCSYuWqyeDXPQxojWiy6A1MezQXCzv91EBKsDuIg7GJiZuzPNob95fX+AaWvO
         kgZQ==
X-Gm-Message-State: AOAM530UGbNjFBRAVSPn1gvoOTqOnXeiCItU5yZ0Hu75kPExlbTorOpH
        p5xH+m+8fYdHiBZ3shqqGRNIsFSVebIqDuAcR/7f55pjWWFDb84xmOmshzUsw1+VKMz79ECwOxU
        7uKE7tcOKDctYhx8lT4FbX5vn3A==
X-Received: by 2002:ac8:5448:: with SMTP id d8mr4222556qtq.6.1612983975767;
        Wed, 10 Feb 2021 11:06:15 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx/tRv5jLjJTHr+SmhyryUCprE3egVTktEAB26vf0nH0SrxAd7lAW7psca7AdeRoRpnWVCiiA==
X-Received: by 2002:ac8:5448:: with SMTP id d8mr4222534qtq.6.1612983975422;
        Wed, 10 Feb 2021 11:06:15 -0800 (PST)
Received: from xz-x1 (bras-vprn-toroon474qw-lp130-20-174-93-89-182.dsl.bell.ca. [174.93.89.182])
        by smtp.gmail.com with ESMTPSA id o24sm1948099qtt.36.2021.02.10.11.06.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Feb 2021 11:06:14 -0800 (PST)
Date:   Wed, 10 Feb 2021 14:06:12 -0500
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
Subject: Re: [PATCH v4 08/10] userfaultfd: add UFFDIO_CONTINUE ioctl
Message-ID: <20210210190612.GR103365@xz-x1>
References: <20210204183433.1431202-1-axelrasmussen@google.com>
 <20210204183433.1431202-9-axelrasmussen@google.com>
 <20210208235411.GC71523@xz-x1>
 <CAJHvVcgC1zXoVde2Uva9zm3TjzA7g-qOMPm7wxX0dXxxwTLs6A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJHvVcgC1zXoVde2Uva9zm3TjzA7g-qOMPm7wxX0dXxxwTLs6A@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Feb 10, 2021 at 10:00:21AM -0800, Axel Rasmussen wrote:
> > >  static __always_inline ssize_t mfill_atomic_pte(struct mm_struct *dst_mm,
> > > @@ -417,10 +416,14 @@ static __always_inline ssize_t mfill_atomic_pte(struct mm_struct *dst_mm,
> > >                                               unsigned long dst_addr,
> > >                                               unsigned long src_addr,
> > >                                               struct page **page,
> > > -                                             bool zeropage,
> > > +                                             enum mcopy_atomic_mode mode,
> > >                                               bool wp_copy)
> > >  {
> > >       ssize_t err;
> > > +     bool zeropage = (mode == MCOPY_ATOMIC_ZEROPAGE);
> > > +
> > > +     if (mode == MCOPY_ATOMIC_CONTINUE)
> > > +             return -EINVAL;
> >
> > So you still passed in the mode into mfill_atomic_pte() just to make sure
> > CONTINUE is not called there.  It's okay, but again I think it's not extremely
> > necessary: we should make sure to fail early at the entry of uffdio_continue()
> > by checking against the vma type to be hugetlb, rather than reaching here.
> 
> Hmm, it's not quite as simple as that. We don't have the dst_vma yet
> in uffdio_continue(), __mcopy_atomic looks it up.
> 
> I'd prefer not to look it up in uffdio_continue(), because I think
> that means changing the API so all the ioctls look up the vma, and
> then plumb it into __mcopy_atomic. (We don't want to look it up twice,
> since each lookup has to traverse the rbtree.) This is complicated too
> by the fact that the ioctl handlers would need to perform various
> validation / checks - e.g., acquiring mmap_lock, dealing with
> *mmap_changing, validating the range, ....

Sure.

> 
> We can move the enforcement up one more layer, into __mcopy_atomic,
> easily enough, though.

Right, that sounds good to me.  It should be right after the "if
(!vma_is_anonymous(dst_vma) && !vma_is_shmem(dst_vma))" check.

Thanks,

-- 
Peter Xu

