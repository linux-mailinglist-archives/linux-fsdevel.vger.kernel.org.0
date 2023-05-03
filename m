Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A52F6F605F
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 May 2023 22:58:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229706AbjECU6Z (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 3 May 2023 16:58:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229670AbjECU6X (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 3 May 2023 16:58:23 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F06CD8A52
        for <linux-fsdevel@vger.kernel.org>; Wed,  3 May 2023 13:58:05 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-959a626b622so878549966b.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 03 May 2023 13:58:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683147482; x=1685739482;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fOKjucXS3bLNlM0zdkAZGUqfwQjiAxpZxAhc5U8CzHU=;
        b=M76iV/Cp1NdgRUq/sw7nrkkQZ1f5OQw/FLMsnaaaGZ9WDv4dmUFRbQJ7/aaMVURbXH
         jtw5XjZVNFYAGal1iu1GucmpcCJ0CgdZf5Dbshiuo8AvHjIdf0WWbQM1167FJbGBLOVb
         +m1nnTAklcYmPuroSxwm4K/URkI9jq+Kt+7F8TF3u4xM52Qw3iUGnjjoffhghD/7aHOY
         ZqstTs/T4J5k1rFcbF9bu5rwKRDcjvJp9ImpLerVMoag/moEHoqxkO/YcyexIo1OJITP
         UPEfOHgdeHnqeQ1WiBjWWHnrzmC9+Io4K3aoUpIz3h6fXx4MOAIJD5q5jVcoAjZcEg/c
         i7NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683147482; x=1685739482;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fOKjucXS3bLNlM0zdkAZGUqfwQjiAxpZxAhc5U8CzHU=;
        b=JdwejKnqnYg26EiI1Fz14WfeWyzVMX7cL7DtmltBkDSvvNyMoIETWscfzHh7uqqNci
         vWoNHtaG3rY9brqYONqV0kilaIDCEt3yC7/s3Es26aKhq3ra44QKXIp8kNMIRxJ68sgO
         8bf5trMpTdVO5m87DuCCEM6vzEcT26rsseqIPjAOyYTuoXZHGOizu+1vclNlfatq5yZU
         TkewIBuSzYYMAoT0sUvKDKci9sW+46fGtF1vnijeEdQ0KzNviRAbzwdk9V2D1rjnsNnv
         oCwDvaFlN28Wkpqjc9LmXRDwa8qJ9bQ9cPk7SHl3V75drsTxiyknrCYcGsPw8szMWAnm
         rMCg==
X-Gm-Message-State: AC+VfDxtkYp6CVpgQBVDC9/Fqtj8aKiQ7f6kiCyyua5VoVjUhc2B+YRz
        8dSV/15+PJ2ujONlvKhSfK2Jg0HHwIGre7cm2Z0kAA==
X-Google-Smtp-Source: ACHHUZ7bG8Xn1LjA65SfnlqTNN22QeCgktHev9DSXBWTCamKtyQdrW7/6BUqHXApnZNL4m4+BsdZL7Rw4nFGoBYOPAM=
X-Received: by 2002:a17:906:6a14:b0:953:7be7:91de with SMTP id
 qw20-20020a1709066a1400b009537be791demr4660114ejc.20.1683147481570; Wed, 03
 May 2023 13:58:01 -0700 (PDT)
MIME-Version: 1.0
References: <20230501175025.36233-1-surenb@google.com> <ZFBvOh8r5WbTVyA8@casper.infradead.org>
 <CAJuCfpHfAFx9rjv0gHK77LbP-8gd-kFnWw=aqfQTP6pH=zvMNg@mail.gmail.com>
 <ZFCB+G9KSNE+J9cZ@casper.infradead.org> <CAJuCfpES=G8i99yYXWoeJq9+JVUjX5Bkq_5VNVTVX7QT+Wkfxg@mail.gmail.com>
 <ZFEmN6G7WRy59Mum@casper.infradead.org> <CAJuCfpFs+Rgpu8v+ddHFwtOx33W5k1sKDdXHM2ej1Upyo_9y4g@mail.gmail.com>
 <ZFGPLXIis6tl1QWX@casper.infradead.org> <CAJuCfpGgc_bCEAE5LrhYPk=qXMU=owgiABTO9ZNqaBx-xfrOuQ@mail.gmail.com>
 <CAJD7tkZJ1VPB+bA0cjHHcehoMW2fT96-h=C5pRHD=Z+SJXYosA@mail.gmail.com> <CAJuCfpE9dVK01c-aNT_uwTC=m8RSdEiXsoe6XBR48GjL=ezsmg@mail.gmail.com>
In-Reply-To: <CAJuCfpE9dVK01c-aNT_uwTC=m8RSdEiXsoe6XBR48GjL=ezsmg@mail.gmail.com>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Wed, 3 May 2023 13:57:17 -0700
Message-ID: <CAJD7tkadk9=-PT1daXQyA=X_qz60XOEciXOkXWwPqxYJOaWRXQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] mm: handle swap page faults under VMA lock if page is uncontended
To:     Suren Baghdasaryan <surenb@google.com>, Ying <ying.huang@intel.com>
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
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, May 3, 2023 at 12:57=E2=80=AFPM Suren Baghdasaryan <surenb@google.c=
om> wrote:
>
> On Wed, May 3, 2023 at 1:34=E2=80=AFAM Yosry Ahmed <yosryahmed@google.com=
> wrote:
> >
> > On Tue, May 2, 2023 at 4:05=E2=80=AFPM Suren Baghdasaryan <surenb@googl=
e.com> wrote:
> > >
> > > On Tue, May 2, 2023 at 3:31=E2=80=AFPM Matthew Wilcox <willy@infradea=
d.org> wrote:
> > > >
> > > > On Tue, May 02, 2023 at 09:36:03AM -0700, Suren Baghdasaryan wrote:
> > > > > On Tue, May 2, 2023 at 8:03=E2=80=AFAM Matthew Wilcox <willy@infr=
adead.org> wrote:
> > > > > >
> > > > > > On Mon, May 01, 2023 at 10:04:56PM -0700, Suren Baghdasaryan wr=
ote:
> > > > > > > On Mon, May 1, 2023 at 8:22=E2=80=AFPM Matthew Wilcox <willy@=
infradead.org> wrote:
> > > > > > > >
> > > > > > > > On Mon, May 01, 2023 at 07:30:13PM -0700, Suren Baghdasarya=
n wrote:
> > > > > > > > > On Mon, May 1, 2023 at 7:02=E2=80=AFPM Matthew Wilcox <wi=
lly@infradead.org> wrote:
> > > > > > > > > >
> > > > > > > > > > On Mon, May 01, 2023 at 10:50:23AM -0700, Suren Baghdas=
aryan wrote:
> > > > > > > > > > > +++ b/mm/memory.c
> > > > > > > > > > > @@ -3711,11 +3711,6 @@ vm_fault_t do_swap_page(struct=
 vm_fault *vmf)
> > > > > > > > > > >       if (!pte_unmap_same(vmf))
> > > > > > > > > > >               goto out;
> > > > > > > > > > >
> > > > > > > > > > > -     if (vmf->flags & FAULT_FLAG_VMA_LOCK) {
> > > > > > > > > > > -             ret =3D VM_FAULT_RETRY;
> > > > > > > > > > > -             goto out;
> > > > > > > > > > > -     }
> > > > > > > > > > > -
> > > > > > > > > > >       entry =3D pte_to_swp_entry(vmf->orig_pte);
> > > > > > > > > > >       if (unlikely(non_swap_entry(entry))) {
> > > > > > > > > > >               if (is_migration_entry(entry)) {
> > > > > > > > > >
> > > > > > > > > > You're missing the necessary fallback in the (!folio) c=
ase.
> > > > > > > > > > swap_readpage() is synchronous and will sleep.
> > > > > > > > >
> > > > > > > > > True, but is it unsafe to do that under VMA lock and has =
to be done
> > > > > > > > > under mmap_lock?
> > > > > > > >
> > > > > > > > ... you were the one arguing that we didn't want to wait fo=
r I/O with
> > > > > > > > the VMA lock held?
> > > > > > >
> > > > > > > Well, that discussion was about waiting in folio_lock_or_retr=
y() with
> > > > > > > the lock being held. I argued against it because currently we=
 drop
> > > > > > > mmap_lock lock before waiting, so if we don't drop VMA lock w=
e would
> > > > > > > be changing the current behavior which might introduce new
> > > > > > > regressions. In the case of swap_readpage and swapin_readahea=
d we
> > > > > > > already wait with mmap_lock held, so waiting with VMA lock he=
ld does
> > > > > > > not introduce new problems (unless there is a need to hold mm=
ap_lock).
> > > > > > >
> > > > > > > That said, you are absolutely correct that this situation can=
 be
> > > > > > > improved by dropping the lock in these cases too. I just didn=
't want
> > > > > > > to attack everything at once. I believe after we agree on the=
 approach
> > > > > > > implemented in https://lore.kernel.org/all/20230501175025.362=
33-3-surenb@google.com
> > > > > > > for dropping the VMA lock before waiting, these cases can be =
added
> > > > > > > easier. Does that make sense?
> > > > > >
> > > > > > OK, I looked at this path some more, and I think we're fine.  T=
his
> > > > > > patch is only called for SWP_SYNCHRONOUS_IO which is only set f=
or
> > > > > > QUEUE_FLAG_SYNCHRONOUS devices, which are brd, zram and nvdimms
> > > > > > (both btt and pmem).  So the answer is that we don't sleep in t=
his
> > > > > > path, and there's no need to drop the lock.
> > > > >
> > > > > Yes but swapin_readahead does sleep, so I'll have to handle that =
case
> > > > > too after this.
> > > >
> > > > Sleeping is OK, we do that in pXd_alloc()!  Do we block on I/O anyw=
here
> > > > in swapin_readahead()?  It all looks like async I/O to me.
> > >
> > > Hmm. I thought that we have synchronous I/O in the following paths:
> > >     swapin_readahead()->swap_cluster_readahead()->swap_readpage()
> > >     swapin_readahead()->swap_vma_readahead()->swap_readpage()
> > > but just noticed that in both cases swap_readpage() is called with th=
e
> > > synchronous parameter being false. So you are probably right here...
> >
> > In both swap_cluster_readahead() and swap_vma_readahead() it looks
> > like if the readahead window is 1 (aka we are not reading ahead), then
> > we jump to directly calling read_swap_cache_async() passing do_poll =3D
> > true, which means we may end up calling swap_readpage() passing
> > synchronous =3D true.
> >
> > I am not familiar with readahead heuristics, so I am not sure how
> > common this is, but it's something to think about.
>
> Uh, you are correct. If this branch is common, we could use the same
> "drop the lock and retry" pattern inside read_swap_cache_async(). That
> would be quite easy to implement.
> Thanks for checking on it!


I am honestly not sure how common this is.

+Ying who might have a better idea.


>
>
> >
> > > Does that mean swapin_readahead() might return a page which does not
> > > have its content swapped-in yet?
> > >
