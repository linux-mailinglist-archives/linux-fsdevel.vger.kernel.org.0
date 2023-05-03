Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81F2E6F536B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 May 2023 10:36:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230096AbjECIgM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 3 May 2023 04:36:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229636AbjECIfM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 3 May 2023 04:35:12 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1484525F
        for <linux-fsdevel@vger.kernel.org>; Wed,  3 May 2023 01:34:57 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-95369921f8eso787369066b.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 03 May 2023 01:34:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683102896; x=1685694896;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RKXe+0lIfwy/hoC6Q/hB1sfMQ+ty9Wsj1woFdQCY7+o=;
        b=oTmHERwURtYowEbOhsdjlBElVU56uTSujBYryGwaA4nmO6I7hEsQgvTTuOPcujdLpj
         +t3XMGxFDsE332VGiC/54o1lDCbkSLy1osJIk+MoQBLmJI8JMyQoPhiGzhnTMYP+hT2A
         LEhGwTakEv9uqIwur7uMvIHpHmEdmsyBM6IwMfbIdSgyIaQnUtwYcL8/xkIXAK2H2T3+
         AIIK+1i4pDtV5+ml0/Bn4cjvX2k+w5CHF7lVJ5LL36Ny2BXNaEP8YXrlkGDdbqHoqzrP
         csVJC6AvkO3sMeL8maLauLiQpWlcuun19/DBFEqM9StMhrvL1iim2ciBZZEWyiNkdqGR
         oalA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683102896; x=1685694896;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RKXe+0lIfwy/hoC6Q/hB1sfMQ+ty9Wsj1woFdQCY7+o=;
        b=KUybSPgqYxQ0RUYcLBEJHVCqNM9ETQ2kltjCtSV9PSxTYe+yPFv4I82oRSZL65ORJv
         NhPc3nDStqK2o9pNTLegqMtqQmI+Z6CjidcU+0yBl/9OCiH3+2fprNtM903DsuPrXFXU
         GMUHvuRTHWWetSINu4UOQWJdk2XZNoomGXMEijkkqnjjW3x9a2ZfuUpk2uKP3mg4GBLS
         5omrKfgsNf+I8j+ertpQe1yQVJwpUoZxjL1WUa3Tv6aQ6KddoJ+VFdzXBx/XCkepB0Qn
         rFpQV/pfux4LOhMp43xTAxrfnjBEJ9kgs+/lMlIDy4Jkc3qGSriXZi1ErRWsOlkJifcr
         WTSA==
X-Gm-Message-State: AC+VfDxd7pwGz51/ko3Im4+ScvAXZbqHUfu+x/ZlBVeKRJpUeH3+0ygq
        A2L8uYVbocWZmoDM8jr/4S4FQBU4EzIjy7dLV60PmQ==
X-Google-Smtp-Source: ACHHUZ54SmU1rXcXVFPIu75CyjtBvtdahZczabFaZ0bwQm2AsOxeoMspuMu+x+JDpcZq9sutqKu8oMDngYDT08mOsfY=
X-Received: by 2002:a17:906:4fc8:b0:94d:8b66:46cb with SMTP id
 i8-20020a1709064fc800b0094d8b6646cbmr2559292ejw.3.1683102895630; Wed, 03 May
 2023 01:34:55 -0700 (PDT)
MIME-Version: 1.0
References: <20230501175025.36233-1-surenb@google.com> <ZFBvOh8r5WbTVyA8@casper.infradead.org>
 <CAJuCfpHfAFx9rjv0gHK77LbP-8gd-kFnWw=aqfQTP6pH=zvMNg@mail.gmail.com>
 <ZFCB+G9KSNE+J9cZ@casper.infradead.org> <CAJuCfpES=G8i99yYXWoeJq9+JVUjX5Bkq_5VNVTVX7QT+Wkfxg@mail.gmail.com>
 <ZFEmN6G7WRy59Mum@casper.infradead.org> <CAJuCfpFs+Rgpu8v+ddHFwtOx33W5k1sKDdXHM2ej1Upyo_9y4g@mail.gmail.com>
 <ZFGPLXIis6tl1QWX@casper.infradead.org> <CAJuCfpGgc_bCEAE5LrhYPk=qXMU=owgiABTO9ZNqaBx-xfrOuQ@mail.gmail.com>
In-Reply-To: <CAJuCfpGgc_bCEAE5LrhYPk=qXMU=owgiABTO9ZNqaBx-xfrOuQ@mail.gmail.com>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Wed, 3 May 2023 01:34:13 -0700
Message-ID: <CAJD7tkZJ1VPB+bA0cjHHcehoMW2fT96-h=C5pRHD=Z+SJXYosA@mail.gmail.com>
Subject: Re: [PATCH 1/3] mm: handle swap page faults under VMA lock if page is uncontended
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     Matthew Wilcox <willy@infradead.org>, akpm@linux-foundation.org,
        hannes@cmpxchg.org, mhocko@suse.com, josef@toxicpanda.com,
        jack@suse.cz, ldufour@linux.ibm.com, laurent.dufour@fr.ibm.com,
        michel@lespinasse.org, liam.howlett@oracle.com, jglisse@google.com,
        vbabka@suse.cz, minchan@google.com, dave@stgolabs.net,
        punit.agrawal@bytedance.com, lstoakes@gmail.com, hdanton@sina.com,
        apopple@nvidia.com, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, May 2, 2023 at 4:05=E2=80=AFPM Suren Baghdasaryan <surenb@google.co=
m> wrote:
>
> On Tue, May 2, 2023 at 3:31=E2=80=AFPM Matthew Wilcox <willy@infradead.or=
g> wrote:
> >
> > On Tue, May 02, 2023 at 09:36:03AM -0700, Suren Baghdasaryan wrote:
> > > On Tue, May 2, 2023 at 8:03=E2=80=AFAM Matthew Wilcox <willy@infradea=
d.org> wrote:
> > > >
> > > > On Mon, May 01, 2023 at 10:04:56PM -0700, Suren Baghdasaryan wrote:
> > > > > On Mon, May 1, 2023 at 8:22=E2=80=AFPM Matthew Wilcox <willy@infr=
adead.org> wrote:
> > > > > >
> > > > > > On Mon, May 01, 2023 at 07:30:13PM -0700, Suren Baghdasaryan wr=
ote:
> > > > > > > On Mon, May 1, 2023 at 7:02=E2=80=AFPM Matthew Wilcox <willy@=
infradead.org> wrote:
> > > > > > > >
> > > > > > > > On Mon, May 01, 2023 at 10:50:23AM -0700, Suren Baghdasarya=
n wrote:
> > > > > > > > > +++ b/mm/memory.c
> > > > > > > > > @@ -3711,11 +3711,6 @@ vm_fault_t do_swap_page(struct vm_=
fault *vmf)
> > > > > > > > >       if (!pte_unmap_same(vmf))
> > > > > > > > >               goto out;
> > > > > > > > >
> > > > > > > > > -     if (vmf->flags & FAULT_FLAG_VMA_LOCK) {
> > > > > > > > > -             ret =3D VM_FAULT_RETRY;
> > > > > > > > > -             goto out;
> > > > > > > > > -     }
> > > > > > > > > -
> > > > > > > > >       entry =3D pte_to_swp_entry(vmf->orig_pte);
> > > > > > > > >       if (unlikely(non_swap_entry(entry))) {
> > > > > > > > >               if (is_migration_entry(entry)) {
> > > > > > > >
> > > > > > > > You're missing the necessary fallback in the (!folio) case.
> > > > > > > > swap_readpage() is synchronous and will sleep.
> > > > > > >
> > > > > > > True, but is it unsafe to do that under VMA lock and has to b=
e done
> > > > > > > under mmap_lock?
> > > > > >
> > > > > > ... you were the one arguing that we didn't want to wait for I/=
O with
> > > > > > the VMA lock held?
> > > > >
> > > > > Well, that discussion was about waiting in folio_lock_or_retry() =
with
> > > > > the lock being held. I argued against it because currently we dro=
p
> > > > > mmap_lock lock before waiting, so if we don't drop VMA lock we wo=
uld
> > > > > be changing the current behavior which might introduce new
> > > > > regressions. In the case of swap_readpage and swapin_readahead we
> > > > > already wait with mmap_lock held, so waiting with VMA lock held d=
oes
> > > > > not introduce new problems (unless there is a need to hold mmap_l=
ock).
> > > > >
> > > > > That said, you are absolutely correct that this situation can be
> > > > > improved by dropping the lock in these cases too. I just didn't w=
ant
> > > > > to attack everything at once. I believe after we agree on the app=
roach
> > > > > implemented in https://lore.kernel.org/all/20230501175025.36233-3=
-surenb@google.com
> > > > > for dropping the VMA lock before waiting, these cases can be adde=
d
> > > > > easier. Does that make sense?
> > > >
> > > > OK, I looked at this path some more, and I think we're fine.  This
> > > > patch is only called for SWP_SYNCHRONOUS_IO which is only set for
> > > > QUEUE_FLAG_SYNCHRONOUS devices, which are brd, zram and nvdimms
> > > > (both btt and pmem).  So the answer is that we don't sleep in this
> > > > path, and there's no need to drop the lock.
> > >
> > > Yes but swapin_readahead does sleep, so I'll have to handle that case
> > > too after this.
> >
> > Sleeping is OK, we do that in pXd_alloc()!  Do we block on I/O anywhere
> > in swapin_readahead()?  It all looks like async I/O to me.
>
> Hmm. I thought that we have synchronous I/O in the following paths:
>     swapin_readahead()->swap_cluster_readahead()->swap_readpage()
>     swapin_readahead()->swap_vma_readahead()->swap_readpage()
> but just noticed that in both cases swap_readpage() is called with the
> synchronous parameter being false. So you are probably right here...

In both swap_cluster_readahead() and swap_vma_readahead() it looks
like if the readahead window is 1 (aka we are not reading ahead), then
we jump to directly calling read_swap_cache_async() passing do_poll =3D
true, which means we may end up calling swap_readpage() passing
synchronous =3D true.

I am not familiar with readahead heuristics, so I am not sure how
common this is, but it's something to think about.

> Does that mean swapin_readahead() might return a page which does not
> have its content swapped-in yet?
>
