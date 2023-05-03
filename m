Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D08A96F5F7B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 May 2023 21:57:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229986AbjECT50 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 3 May 2023 15:57:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbjECT5Z (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 3 May 2023 15:57:25 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72C0083E1
        for <linux-fsdevel@vger.kernel.org>; Wed,  3 May 2023 12:57:21 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id 3f1490d57ef6-b983027d0faso8119571276.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 03 May 2023 12:57:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683143840; x=1685735840;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1Ox1/516ZvGWiy6XQzvdYM7/gH/XZHZIVHoP8inhzxM=;
        b=tRO5/vsXmgz8bVUiKFCXTV8aovuqnpc72ZftAjAmKaHKUf97DDZm/88QvfymfWreye
         9t68UwHLaPnIKrub9j6Uh3xDEzv32OfM52MVZU5n2roAEMLmNGL5OgnkuwpX473CFnhE
         Q224qoZ9m0ei5qlLmUFmbz4acl3XMEWtwAyAq6pPi1lB4p9Mrd7Baw78EtRNJdYVkcvG
         D5WtsIugC6jkpwf9NZ1EZKUfSJyaLOnAJx5TgAasi0iBHbse8rj94z/kDqfv+sqddCPJ
         AWbxexAHZRDHXnRqbhJpejXPxipykhlLNVvttdrlypKH19n9HWGhOj23xTTvOI2T4CP9
         L2zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683143840; x=1685735840;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1Ox1/516ZvGWiy6XQzvdYM7/gH/XZHZIVHoP8inhzxM=;
        b=lUb1E2NLt7W5thZZRwGu9kCf5rk8y4QVyWaLrdnl8ZBCwqYXCsE7w2B3oyZZ0Hx+iv
         007aBKVsR/qeOXS4Zq6memrT2KM721rphOQfRJb55eqIBFGmvzDibHZMMM6ZT2aVmx0l
         RsecOb5p3Bmqih2Bv9kBJVepbRYLGytkblqK6zhdnkecNOV56PYRZSsOF6wfPS97pDql
         wSfOYsA0c4/Vr1RnIX36mQdZKHTvARPlzd+yk0v8UYiHPelOkCg5H+6b9P5pU+Cug1v9
         diFfBf4Wo0K98YMHQZB6mU67qc1ECaTjvViG3nCtMIwf3XHy0jsY12lulA715wSqH1cj
         s6rQ==
X-Gm-Message-State: AC+VfDxEQjom8y+GEiQbK87YjaGiSL/BFZrPC99LZdXFpT2Hg4pJP2Rq
        W6nAjSNVBvgEqH8U2/d0GY9ImaPcXipdg2cu/D/lYA==
X-Google-Smtp-Source: ACHHUZ7ABw610g4pAAup3sgwroFeEko5dVILAFx3nQjtdd9Aki/WRsMXwrfgPFiTJCmml2TfA6W46q0XZ5s6cGLvQ/g=
X-Received: by 2002:a25:f46:0:b0:b9d:f4df:b0ef with SMTP id
 67-20020a250f46000000b00b9df4dfb0efmr13111149ybp.42.1683143840443; Wed, 03
 May 2023 12:57:20 -0700 (PDT)
MIME-Version: 1.0
References: <20230501175025.36233-1-surenb@google.com> <ZFBvOh8r5WbTVyA8@casper.infradead.org>
 <CAJuCfpHfAFx9rjv0gHK77LbP-8gd-kFnWw=aqfQTP6pH=zvMNg@mail.gmail.com>
 <ZFCB+G9KSNE+J9cZ@casper.infradead.org> <CAJuCfpES=G8i99yYXWoeJq9+JVUjX5Bkq_5VNVTVX7QT+Wkfxg@mail.gmail.com>
 <ZFEmN6G7WRy59Mum@casper.infradead.org> <CAJuCfpFs+Rgpu8v+ddHFwtOx33W5k1sKDdXHM2ej1Upyo_9y4g@mail.gmail.com>
 <ZFGPLXIis6tl1QWX@casper.infradead.org> <CAJuCfpGgc_bCEAE5LrhYPk=qXMU=owgiABTO9ZNqaBx-xfrOuQ@mail.gmail.com>
 <CAJD7tkZJ1VPB+bA0cjHHcehoMW2fT96-h=C5pRHD=Z+SJXYosA@mail.gmail.com>
In-Reply-To: <CAJD7tkZJ1VPB+bA0cjHHcehoMW2fT96-h=C5pRHD=Z+SJXYosA@mail.gmail.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Wed, 3 May 2023 12:57:09 -0700
Message-ID: <CAJuCfpE9dVK01c-aNT_uwTC=m8RSdEiXsoe6XBR48GjL=ezsmg@mail.gmail.com>
Subject: Re: [PATCH 1/3] mm: handle swap page faults under VMA lock if page is uncontended
To:     Yosry Ahmed <yosryahmed@google.com>
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

On Wed, May 3, 2023 at 1:34=E2=80=AFAM Yosry Ahmed <yosryahmed@google.com> =
wrote:
>
> On Tue, May 2, 2023 at 4:05=E2=80=AFPM Suren Baghdasaryan <surenb@google.=
com> wrote:
> >
> > On Tue, May 2, 2023 at 3:31=E2=80=AFPM Matthew Wilcox <willy@infradead.=
org> wrote:
> > >
> > > On Tue, May 02, 2023 at 09:36:03AM -0700, Suren Baghdasaryan wrote:
> > > > On Tue, May 2, 2023 at 8:03=E2=80=AFAM Matthew Wilcox <willy@infrad=
ead.org> wrote:
> > > > >
> > > > > On Mon, May 01, 2023 at 10:04:56PM -0700, Suren Baghdasaryan wrot=
e:
> > > > > > On Mon, May 1, 2023 at 8:22=E2=80=AFPM Matthew Wilcox <willy@in=
fradead.org> wrote:
> > > > > > >
> > > > > > > On Mon, May 01, 2023 at 07:30:13PM -0700, Suren Baghdasaryan =
wrote:
> > > > > > > > On Mon, May 1, 2023 at 7:02=E2=80=AFPM Matthew Wilcox <will=
y@infradead.org> wrote:
> > > > > > > > >
> > > > > > > > > On Mon, May 01, 2023 at 10:50:23AM -0700, Suren Baghdasar=
yan wrote:
> > > > > > > > > > +++ b/mm/memory.c
> > > > > > > > > > @@ -3711,11 +3711,6 @@ vm_fault_t do_swap_page(struct v=
m_fault *vmf)
> > > > > > > > > >       if (!pte_unmap_same(vmf))
> > > > > > > > > >               goto out;
> > > > > > > > > >
> > > > > > > > > > -     if (vmf->flags & FAULT_FLAG_VMA_LOCK) {
> > > > > > > > > > -             ret =3D VM_FAULT_RETRY;
> > > > > > > > > > -             goto out;
> > > > > > > > > > -     }
> > > > > > > > > > -
> > > > > > > > > >       entry =3D pte_to_swp_entry(vmf->orig_pte);
> > > > > > > > > >       if (unlikely(non_swap_entry(entry))) {
> > > > > > > > > >               if (is_migration_entry(entry)) {
> > > > > > > > >
> > > > > > > > > You're missing the necessary fallback in the (!folio) cas=
e.
> > > > > > > > > swap_readpage() is synchronous and will sleep.
> > > > > > > >
> > > > > > > > True, but is it unsafe to do that under VMA lock and has to=
 be done
> > > > > > > > under mmap_lock?
> > > > > > >
> > > > > > > ... you were the one arguing that we didn't want to wait for =
I/O with
> > > > > > > the VMA lock held?
> > > > > >
> > > > > > Well, that discussion was about waiting in folio_lock_or_retry(=
) with
> > > > > > the lock being held. I argued against it because currently we d=
rop
> > > > > > mmap_lock lock before waiting, so if we don't drop VMA lock we =
would
> > > > > > be changing the current behavior which might introduce new
> > > > > > regressions. In the case of swap_readpage and swapin_readahead =
we
> > > > > > already wait with mmap_lock held, so waiting with VMA lock held=
 does
> > > > > > not introduce new problems (unless there is a need to hold mmap=
_lock).
> > > > > >
> > > > > > That said, you are absolutely correct that this situation can b=
e
> > > > > > improved by dropping the lock in these cases too. I just didn't=
 want
> > > > > > to attack everything at once. I believe after we agree on the a=
pproach
> > > > > > implemented in https://lore.kernel.org/all/20230501175025.36233=
-3-surenb@google.com
> > > > > > for dropping the VMA lock before waiting, these cases can be ad=
ded
> > > > > > easier. Does that make sense?
> > > > >
> > > > > OK, I looked at this path some more, and I think we're fine.  Thi=
s
> > > > > patch is only called for SWP_SYNCHRONOUS_IO which is only set for
> > > > > QUEUE_FLAG_SYNCHRONOUS devices, which are brd, zram and nvdimms
> > > > > (both btt and pmem).  So the answer is that we don't sleep in thi=
s
> > > > > path, and there's no need to drop the lock.
> > > >
> > > > Yes but swapin_readahead does sleep, so I'll have to handle that ca=
se
> > > > too after this.
> > >
> > > Sleeping is OK, we do that in pXd_alloc()!  Do we block on I/O anywhe=
re
> > > in swapin_readahead()?  It all looks like async I/O to me.
> >
> > Hmm. I thought that we have synchronous I/O in the following paths:
> >     swapin_readahead()->swap_cluster_readahead()->swap_readpage()
> >     swapin_readahead()->swap_vma_readahead()->swap_readpage()
> > but just noticed that in both cases swap_readpage() is called with the
> > synchronous parameter being false. So you are probably right here...
>
> In both swap_cluster_readahead() and swap_vma_readahead() it looks
> like if the readahead window is 1 (aka we are not reading ahead), then
> we jump to directly calling read_swap_cache_async() passing do_poll =3D
> true, which means we may end up calling swap_readpage() passing
> synchronous =3D true.
>
> I am not familiar with readahead heuristics, so I am not sure how
> common this is, but it's something to think about.

Uh, you are correct. If this branch is common, we could use the same
"drop the lock and retry" pattern inside read_swap_cache_async(). That
would be quite easy to implement.
Thanks for checking on it!

>
> > Does that mean swapin_readahead() might return a page which does not
> > have its content swapped-in yet?
> >
