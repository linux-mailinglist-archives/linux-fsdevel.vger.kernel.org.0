Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C21472A2A6
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Jun 2023 20:55:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231809AbjFISzp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 9 Jun 2023 14:55:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230044AbjFISzn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 9 Jun 2023 14:55:43 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DD2F3A80
        for <linux-fsdevel@vger.kernel.org>; Fri,  9 Jun 2023 11:55:42 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id 3f1490d57ef6-bb3d122a19fso2004976276.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 09 Jun 2023 11:55:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686336941; x=1688928941;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5fqmIPn7/SY3tNNptZ9MZAjCev2zdIK34rPEJNcoPJs=;
        b=pSBFc37PG5mqrdURgSEq7HdUoo9vHzD7lyKhb1CDn4/n16j/q5B1BJ0y6H1tKBObhc
         8RZT+6td4dTyXZuFu6FeMZ97TaHDu8XLCdS6QeHmInzWl42MSOpQwg8HuKz71iJlZ7EF
         3RD7Fc/SWTNEw3muGL0Hc5uRGZ8TSzZNWH09gNmkovGMNIFuMTPlALfJDHP4+GPQ0DCp
         OSXobLw+pHqC9UKqFHSszrNSrZnJi+VsiSpJzxAcZJ/EoYKW+djQsRRa+1IzDpGTvlOS
         u5PmY3Q9vlvGT5ApN7zfmUYZemIUYZTwaxkVzZpCqU+2W0+E/0bL8TdyHX7NUMepnKSq
         tq5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686336941; x=1688928941;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5fqmIPn7/SY3tNNptZ9MZAjCev2zdIK34rPEJNcoPJs=;
        b=GkecC8cCvDbnzR4Qd8i5jR+bu5yehwUnXFbXb7SXKYSmSJMbTrTiItlYN3XRj7Ws/2
         YFlnm9E0+CKKyKlwL/0YEYV3msHckYagcgSlLP1R/6ztYfFOjwZJzjBHZ/dzPSyhF8VT
         6+FmzU8ld+DEKvNfziIyAhtD2GHirPIl9AtjWRWe4rwizVSUkkNWXwySmDPRvMYL/nEZ
         K8tP0pkwh1jYB11MgphCT8jwxNhO3YHVHIT1+pRBEIwf7x4u0npNnneRKgeBSkMHTP+g
         pwSdtqTeqxjUgJXizKQeuo8z0q2pxtRbtodWRoeZc+fMAEpkuY8NMe/EFz75GXF5x/RS
         Qc5Q==
X-Gm-Message-State: AC+VfDz/an3oTqkG9HOZ2fhQZlQf1glZyRwCgTZklePvuQlDbydl0v4Q
        v5KQpttSzuulh4uyrhzQ3gpKcrHxbUNKLCbhjV2TYA==
X-Google-Smtp-Source: ACHHUZ5J+yJhDkwtV6pUXStA7V8gQSqeAoQnRlmfDE34ExCN9C+jXf8DNwMSEgyyXAYsVrV5phpv5KN7CFndQfkYX1g=
X-Received: by 2002:a25:4609:0:b0:bb3:a85c:759f with SMTP id
 t9-20020a254609000000b00bb3a85c759fmr1630007yba.0.1686336940940; Fri, 09 Jun
 2023 11:55:40 -0700 (PDT)
MIME-Version: 1.0
References: <20230609005158.2421285-1-surenb@google.com> <20230609005158.2421285-6-surenb@google.com>
 <ZIM/O54Q0waFq/tx@casper.infradead.org> <CAJuCfpE4VYz-Z4_aS3d9-8FGtQ-F4f7adYcJqRk3P3Ks7WPgQA@mail.gmail.com>
In-Reply-To: <CAJuCfpE4VYz-Z4_aS3d9-8FGtQ-F4f7adYcJqRk3P3Ks7WPgQA@mail.gmail.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Fri, 9 Jun 2023 11:55:29 -0700
Message-ID: <CAJuCfpG9JeHBKF0fzqR7xpDufpm7HVwgfbQVDeKYW24TWkpckw@mail.gmail.com>
Subject: Re: [PATCH v2 5/6] mm: implement folio wait under VMA lock
To:     Matthew Wilcox <willy@infradead.org>
Cc:     akpm@linux-foundation.org, hannes@cmpxchg.org, mhocko@suse.com,
        josef@toxicpanda.com, jack@suse.cz, ldufour@linux.ibm.com,
        laurent.dufour@fr.ibm.com, michel@lespinasse.org,
        liam.howlett@oracle.com, jglisse@google.com, vbabka@suse.cz,
        minchan@google.com, dave@stgolabs.net, punit.agrawal@bytedance.com,
        lstoakes@gmail.com, hdanton@sina.com, apopple@nvidia.com,
        peterx@redhat.com, ying.huang@intel.com, david@redhat.com,
        yuzhao@google.com, dhowells@redhat.com, hughd@google.com,
        viro@zeniv.linux.org.uk, brauner@kernel.org,
        pasha.tatashin@soleen.com, linux-mm@kvack.org,
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

On Fri, Jun 9, 2023 at 11:49=E2=80=AFAM Suren Baghdasaryan <surenb@google.c=
om> wrote:
>
> On Fri, Jun 9, 2023 at 8:03=E2=80=AFAM Matthew Wilcox <willy@infradead.or=
g> wrote:
> >
> > On Thu, Jun 08, 2023 at 05:51:57PM -0700, Suren Baghdasaryan wrote:
> > >  static inline bool folio_lock_or_retry(struct folio *folio,
> > > -             struct mm_struct *mm, unsigned int flags)
> > > +             struct vm_area_struct *vma, unsigned int flags,
> > > +             bool *lock_dropped)
> >
> > I hate these double-return-value functions.
> >
> > How about this for an API:
> >
> > vm_fault_t folio_lock_fault(struct folio *folio, struct vm_fault *vmf)
> > {
> >         might_sleep();
> >         if (folio_trylock(folio))
> >                 return 0;
> >         return __folio_lock_fault(folio, vmf);
> > }
> >
> > Then the users look like ...
> >
> > > @@ -3580,8 +3581,10 @@ static vm_fault_t remove_device_exclusive_entr=
y(struct vm_fault *vmf)
> > >       if (!folio_try_get(folio))
> > >               return 0;
> > >
> > > -     if (!folio_lock_or_retry(folio, vma->vm_mm, vmf->flags)) {
> > > +     if (!folio_lock_or_retry(folio, vma, vmf->flags, &lock_dropped)=
) {
> > >               folio_put(folio);
> > > +             if (lock_dropped && vmf->flags & FAULT_FLAG_VMA_LOCK)
> > > +                     return VM_FAULT_VMA_UNLOCKED | VM_FAULT_RETRY;
> > >               return VM_FAULT_RETRY;
> > >       }
> >
> >         ret =3D folio_lock_fault(folio, vmf);
> >         if (ret)
> >                 return ret;
> >
> > > @@ -3837,9 +3840,9 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
> > >               goto out_release;
> > >       }
> > >
> > > -     locked =3D folio_lock_or_retry(folio, vma->vm_mm, vmf->flags);
> > > -
> > > -     if (!locked) {
> > > +     if (!folio_lock_or_retry(folio, vma, vmf->flags, &lock_dropped)=
) {
> > > +             if (lock_dropped && vmf->flags & FAULT_FLAG_VMA_LOCK)
> > > +                     ret |=3D VM_FAULT_VMA_UNLOCKED;
> > >               ret |=3D VM_FAULT_RETRY;
> > >               goto out_release;
> > >       }
> >
> >         ret |=3D folio_lock_fault(folio, vmf);
> >         if (ret & VM_FAULT_RETRY)
> >                 goto out_release;
> >
> > ie instead of trying to reconstruct what __folio_lock_fault() did from
> > its outputs, we just let folio_lock_fault() tell us what it did.
>
> Thanks for taking a look!
> Ok, I think what you are suggesting is to have a new set of
> folio_lock_fault()/__folio_lock_fault() functions which return
> vm_fault_t directly, __folio_lock_fault() will use
> __folio_lock_or_retry() internally and will adjust its return value
> based on __folio_lock_or_retry()'s return and the lock releasing rules
> described in the comments for __folio_lock_or_retry(). Is my
> understanding correct?

Oh, after rereading I think you are suggesting to replace
folio_lock_or_retry()/__folio_lock_or_retry() with
folio_lock_fault()/__folio_lock_fault(), not to add them. Is that
right?
