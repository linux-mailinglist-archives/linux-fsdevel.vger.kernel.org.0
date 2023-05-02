Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12D2E6F4865
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 May 2023 18:36:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234267AbjEBQg5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 2 May 2023 12:36:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234301AbjEBQgl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 2 May 2023 12:36:41 -0400
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E96573A86
        for <linux-fsdevel@vger.kernel.org>; Tue,  2 May 2023 09:36:15 -0700 (PDT)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-55a8e9e2c53so12379047b3.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 02 May 2023 09:36:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683045375; x=1685637375;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PtHOXsoZHVHTmGblvz+PcxSG2DNLj2mPGHa/Jp7hssk=;
        b=b++Vx6hWqbLjpG9pnp5Ijs00NxZ1mHvxjgv1ePpwdZx2ULh2lbwRETeHpoJq0keTl1
         CDQHvn4OX37rIDwpXen1KFevJ0EcM7ietpn5afxAn27BQAPRoX4jmGjKGx+gZ91c4zph
         7D8QwN0qu6fhoe5vtUQU7vYVq/dAcwBcdQ8V54c8LxkZ2b4Vo2+IcIc2qNsJdaBaYUFs
         NYiPXrJRcYiwXtB4gihMnOTQCmvyeYrYPVieyZLwhhb9KwC0t7s5IIo53/J+dNVMQrrk
         ALJpCPG/A+NV3VOe7EfJIKwejwuAf29e4p2u/Ss6sQYZHKyEP2h4QpAvgdplxvbVgLVu
         5AWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683045375; x=1685637375;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PtHOXsoZHVHTmGblvz+PcxSG2DNLj2mPGHa/Jp7hssk=;
        b=KP4NgJ4c42tFRX+16Ije+NLedCmAst+8CEtKIcRW5H2JQtYkESmQ3+8z1wQCFyjK1r
         PvwyuvXMsEZs9GfGEMHxl8GsEwPDInnXBvRAeSqwGfb/UIs32rcur4vC8YzzoIch216m
         m7bffjR1vKZ3xmVeXIUds3DoO/ezD6BSGeAYOBfH2fqOL+iZ0DnQJTmjfrtQ+EEOTvrz
         qCE4DIG+jiwGR0TKV4ctoGoKaBuTMl7fWNm+/LN/R9soXV+3r6QwZ3xyDkxxxiNqkJPX
         DsFuHGiQQ19/1GgYIB4EW3SEXS5gXQfwJfJPX0i2uVS/CQI8nLYAAyRns9IrJ4hs62VB
         1IqQ==
X-Gm-Message-State: AC+VfDxcC3qrQ+YndO3HdSk37UNdUpdiw1qYy5yvs1meJOIJAkMPMhjc
        0Qg9e/SIJmCLHn7cnk3zk4/FswVFekMYhNsBGzOjqQ==
X-Google-Smtp-Source: ACHHUZ73XlgT3bgGX5m8siCZEgkQHLsvJiAYZQGGcfObRt8oITj9J8UmuFb+PbbPPfobFj5Vtk4gYJaOsQYYHPRraxQ=
X-Received: by 2002:a05:6902:110e:b0:b99:36ff:d530 with SMTP id
 o14-20020a056902110e00b00b9936ffd530mr21584727ybu.30.1683045374954; Tue, 02
 May 2023 09:36:14 -0700 (PDT)
MIME-Version: 1.0
References: <20230501175025.36233-1-surenb@google.com> <ZFBvOh8r5WbTVyA8@casper.infradead.org>
 <CAJuCfpHfAFx9rjv0gHK77LbP-8gd-kFnWw=aqfQTP6pH=zvMNg@mail.gmail.com>
 <ZFCB+G9KSNE+J9cZ@casper.infradead.org> <CAJuCfpES=G8i99yYXWoeJq9+JVUjX5Bkq_5VNVTVX7QT+Wkfxg@mail.gmail.com>
 <ZFEmN6G7WRy59Mum@casper.infradead.org>
In-Reply-To: <ZFEmN6G7WRy59Mum@casper.infradead.org>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Tue, 2 May 2023 09:36:03 -0700
Message-ID: <CAJuCfpFs+Rgpu8v+ddHFwtOx33W5k1sKDdXHM2ej1Upyo_9y4g@mail.gmail.com>
Subject: Re: [PATCH 1/3] mm: handle swap page faults under VMA lock if page is uncontended
To:     Matthew Wilcox <willy@infradead.org>
Cc:     akpm@linux-foundation.org, hannes@cmpxchg.org, mhocko@suse.com,
        josef@toxicpanda.com, jack@suse.cz, ldufour@linux.ibm.com,
        laurent.dufour@fr.ibm.com, michel@lespinasse.org,
        liam.howlett@oracle.com, jglisse@google.com, vbabka@suse.cz,
        minchan@google.com, dave@stgolabs.net, punit.agrawal@bytedance.com,
        lstoakes@gmail.com, hdanton@sina.com, apopple@nvidia.com,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@android.com
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

On Tue, May 2, 2023 at 8:03=E2=80=AFAM Matthew Wilcox <willy@infradead.org>=
 wrote:
>
> On Mon, May 01, 2023 at 10:04:56PM -0700, Suren Baghdasaryan wrote:
> > On Mon, May 1, 2023 at 8:22=E2=80=AFPM Matthew Wilcox <willy@infradead.=
org> wrote:
> > >
> > > On Mon, May 01, 2023 at 07:30:13PM -0700, Suren Baghdasaryan wrote:
> > > > On Mon, May 1, 2023 at 7:02=E2=80=AFPM Matthew Wilcox <willy@infrad=
ead.org> wrote:
> > > > >
> > > > > On Mon, May 01, 2023 at 10:50:23AM -0700, Suren Baghdasaryan wrot=
e:
> > > > > > +++ b/mm/memory.c
> > > > > > @@ -3711,11 +3711,6 @@ vm_fault_t do_swap_page(struct vm_fault =
*vmf)
> > > > > >       if (!pte_unmap_same(vmf))
> > > > > >               goto out;
> > > > > >
> > > > > > -     if (vmf->flags & FAULT_FLAG_VMA_LOCK) {
> > > > > > -             ret =3D VM_FAULT_RETRY;
> > > > > > -             goto out;
> > > > > > -     }
> > > > > > -
> > > > > >       entry =3D pte_to_swp_entry(vmf->orig_pte);
> > > > > >       if (unlikely(non_swap_entry(entry))) {
> > > > > >               if (is_migration_entry(entry)) {
> > > > >
> > > > > You're missing the necessary fallback in the (!folio) case.
> > > > > swap_readpage() is synchronous and will sleep.
> > > >
> > > > True, but is it unsafe to do that under VMA lock and has to be done
> > > > under mmap_lock?
> > >
> > > ... you were the one arguing that we didn't want to wait for I/O with
> > > the VMA lock held?
> >
> > Well, that discussion was about waiting in folio_lock_or_retry() with
> > the lock being held. I argued against it because currently we drop
> > mmap_lock lock before waiting, so if we don't drop VMA lock we would
> > be changing the current behavior which might introduce new
> > regressions. In the case of swap_readpage and swapin_readahead we
> > already wait with mmap_lock held, so waiting with VMA lock held does
> > not introduce new problems (unless there is a need to hold mmap_lock).
> >
> > That said, you are absolutely correct that this situation can be
> > improved by dropping the lock in these cases too. I just didn't want
> > to attack everything at once. I believe after we agree on the approach
> > implemented in https://lore.kernel.org/all/20230501175025.36233-3-suren=
b@google.com
> > for dropping the VMA lock before waiting, these cases can be added
> > easier. Does that make sense?
>
> OK, I looked at this path some more, and I think we're fine.  This
> patch is only called for SWP_SYNCHRONOUS_IO which is only set for
> QUEUE_FLAG_SYNCHRONOUS devices, which are brd, zram and nvdimms
> (both btt and pmem).  So the answer is that we don't sleep in this
> path, and there's no need to drop the lock.

Yes but swapin_readahead does sleep, so I'll have to handle that case
too after this.
