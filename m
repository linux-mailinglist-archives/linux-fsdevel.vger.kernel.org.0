Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C662912860B
	for <lists+linux-fsdevel@lfdr.de>; Sat, 21 Dec 2019 01:33:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726909AbfLUAd3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 20 Dec 2019 19:33:29 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:42345 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726514AbfLUAdX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 20 Dec 2019 19:33:23 -0500
Received: by mail-ot1-f67.google.com with SMTP id 66so14018950otd.9
        for <linux-fsdevel@vger.kernel.org>; Fri, 20 Dec 2019 16:33:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XVjQ97c8G7umA/g4YaI+/jO3BewDKZctzOnZC5BmFqQ=;
        b=NxkPIx6gPzcP+NXij1w+89bHEi7PYx6RDrVXfOrDIkdh+E7c284gPJ/0Dx2IJRsIft
         qP5T8NtrvpAsFtZJNiMXPf9SGU4N9wr5z+lgDWNxH2MBFYJJfj0GLWFq66F8hA8xMDwM
         ov7u3YL8g33gzLkte/P8S28VjwmfLrsJUJcmEzcKaTtNMXut/ZNsXZe9vfWea/1QjPP6
         N0GRE8v962QNXMp6fYZk5hH7oLV3Lp6tTV/jTFHhgGgHEDEf0U1UN9i75GJoFwyFGEsY
         SYO9o7ANj6kyCM+b6zbGskkaWwyZXrFC+rdJdbREHxNwKiODm9oDVUMAmNYqjYSReePl
         i8OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XVjQ97c8G7umA/g4YaI+/jO3BewDKZctzOnZC5BmFqQ=;
        b=eXIux7rXgynxwzpWoqleYRT3t+nEuuFS10NYZY5Hd3S6kX9Pv3584tW748UsfFPtT5
         bjukWYhvqUcRgIzyx2zM6CwRi/5aXLNKMHAHBNnXXaaepnRfGrnrnr6ARs8ChhDq8khu
         kvRd+oEtpUOH4ALdUVM3rC0QWGUmDWSXB7G7i5YFUxw/P1s8H1uqgZgsG8GfsYnBZEGp
         kK6bi59NTy/SjgXCsCapX49Ewoo5fmR/aQP2YyjaiOOwyUjU8BROJ3MXHJjVF3e5PvY5
         jqOkDMVz7YXEtwJEMtw/w+YooMVgsO5YrUeTICm4sRA/N1DgElZmUHfHF48UX8QCrVOQ
         RLfw==
X-Gm-Message-State: APjAAAXib/VFY4AwqrimkCLZ6RSJ2DfAXyiSgPk/ypz5pNT6OmbGcG8e
        rIo7me+ZpgL30ScNEOCfpeCEHVu1hIICQZvto2IcIA==
X-Google-Smtp-Source: APXvYqy/KNT1IU+5waxH3mP7tUKkhYZTihNH7vJc1BvBwnbhmpk83oq7GDXye3Q8miizDxXxgCPpRIrHDtOoKRr7C2c=
X-Received: by 2002:a9d:4e99:: with SMTP id v25mr18407223otk.363.1576888401949;
 Fri, 20 Dec 2019 16:33:21 -0800 (PST)
MIME-Version: 1.0
References: <20191216222537.491123-1-jhubbard@nvidia.com> <20191219132607.GA410823@unreal>
 <a4849322-8e17-119e-a664-80d9f95d850b@nvidia.com> <20191220092154.GA10068@quack2.suse.cz>
In-Reply-To: <20191220092154.GA10068@quack2.suse.cz>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 20 Dec 2019 16:33:10 -0800
Message-ID: <CAPcyv4gYnXE-y_aGehazzF-Kej5ibSfqvE2hTnjKJD68bm8ANg@mail.gmail.com>
Subject: Re: [PATCH v11 00/25] mm/gup: track dma-pinned pages: FOLL_PIN
To:     Jan Kara <jack@suse.cz>
Cc:     John Hubbard <jhubbard@nvidia.com>,
        Leon Romanovsky <leon@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Alex Williamson <alex.williamson@redhat.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@intel.com>,
        Christoph Hellwig <hch@infradead.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Dave Chinner <david@fromorbit.com>,
        David Airlie <airlied@linux.ie>,
        "David S . Miller" <davem@davemloft.net>,
        Ira Weiny <ira.weiny@intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, Jens Axboe <axboe@kernel.dk>,
        Jonathan Corbet <corbet@lwn.net>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Magnus Karlsson <magnus.karlsson@intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Michal Hocko <mhocko@suse.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Paul Mackerras <paulus@samba.org>,
        Shuah Khan <shuah@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>, bpf@vger.kernel.org,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>, KVM list <kvm@vger.kernel.org>,
        linux-block@vger.kernel.org,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-kselftest@vger.kernel.org,
        "Linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Netdev <netdev@vger.kernel.org>, Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Maor Gottlieb <maorg@mellanox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Dec 20, 2019 at 1:22 AM Jan Kara <jack@suse.cz> wrote:
>
> On Thu 19-12-19 12:30:31, John Hubbard wrote:
> > On 12/19/19 5:26 AM, Leon Romanovsky wrote:
> > > On Mon, Dec 16, 2019 at 02:25:12PM -0800, John Hubbard wrote:
> > > > Hi,
> > > >
> > > > This implements an API naming change (put_user_page*() -->
> > > > unpin_user_page*()), and also implements tracking of FOLL_PIN pages. It
> > > > extends that tracking to a few select subsystems. More subsystems will
> > > > be added in follow up work.
> > >
> > > Hi John,
> > >
> > > The patchset generates kernel panics in our IB testing. In our tests, we
> > > allocated single memory block and registered multiple MRs using the single
> > > block.
> > >
> > > The possible bad flow is:
> > >   ib_umem_geti() ->
> > >    pin_user_pages_fast(FOLL_WRITE) ->
> > >     internal_get_user_pages_fast(FOLL_WRITE) ->
> > >      gup_pgd_range() ->
> > >       gup_huge_pd() ->
> > >        gup_hugepte() ->
> > >         try_grab_compound_head() ->
> >
> > Hi Leon,
> >
> > Thanks very much for the detailed report! So we're overflowing...
> >
> > At first look, this seems likely to be hitting a weak point in the
> > GUP_PIN_COUNTING_BIAS-based design, one that I believed could be deferred
> > (there's a writeup in Documentation/core-api/pin_user_page.rst, lines
> > 99-121). Basically it's pretty easy to overflow the page->_refcount
> > with huge pages if the pages have a *lot* of subpages.
> >
> > We can only do about 7 pins on 1GB huge pages that use 4KB subpages.
> > Do you have any idea how many pins (repeated pins on the same page, which
> > it sounds like you have) might be involved in your test case,
> > and the huge page and system page sizes? That would allow calculating
> > if we're likely overflowing for that reason.
> >
> > So, ideas and next steps:
> >
> > 1. Assuming that you *are* hitting this, I think I may have to fall back to
> > implementing the "deferred" part of this design, as part of this series, after
> > all. That means:
> >
> >   For the pin/unpin calls at least, stop treating all pages as if they are
> >   a cluster of PAGE_SIZE pages; instead, retrieve a huge page as one page.
> >   That's not how it works now, and the need to hand back a huge array of
> >   subpages is part of the problem. This affects the callers too, so it's not
> >   a super quick change to make. (I was really hoping not to have to do this
> >   yet.)
>
> Does that mean that you would need to make all GUP users huge page aware?
> Otherwise I don't see how what you suggest would work... And I don't think
> making all GUP users huge page aware is realistic (effort-wise) or even
> wanted (maintenance overhead in all those places).
>
> I believe there might be also a different solution for this: For
> transparent huge pages, we could find a space in 'struct page' of the
> second page in the huge page for proper pin counter and just account pins
> there so we'd have full width of 32-bits for it.

That would require THP accounting for dax pages. It is something that
was probably going to be needed, but this would seem to force the
issue.
