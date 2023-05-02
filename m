Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AC346F4D64
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 May 2023 01:05:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230012AbjEBXFY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 2 May 2023 19:05:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229784AbjEBXFX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 2 May 2023 19:05:23 -0400
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F25BD40D9
        for <linux-fsdevel@vger.kernel.org>; Tue,  2 May 2023 16:05:11 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id 3f1490d57ef6-b9da6374fa2so5504813276.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 02 May 2023 16:05:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683068711; x=1685660711;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TUKDQYPWqgHcO1XQ1Dc3esJ/u5Dg98+S6HrK92DBIP4=;
        b=irnUbCMInaRspFhs3sQBArEm1VLRoaQ9dsFTug/GipTofQOyfj68J22hJg25cBpCFa
         neyxbrNX9aQ9z5xXk15pWRUaUwR+5QgJM8TqriRmL8ztfmvqQCN4MiiWE1B0wFHGiiHx
         4GM4VR0O4EVzRz0QvQBpwHUEvFYxjOBbz5Hcn165JzmykAzr96NDzGbVwj/GDj8htxHG
         r8qhF1b9SyF6Tuk3/OUl6CvUBQYyDi5DzhjLXkL+YkHMWIjVDlJ1JSl5Ewmicn8HBlTm
         CjRhSDMWUV8w9jW9ymx/+nARIPsvY6dtlPmlqwsOWMivijJCRtT8eYEiUldUJT2XQDZW
         GYrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683068711; x=1685660711;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TUKDQYPWqgHcO1XQ1Dc3esJ/u5Dg98+S6HrK92DBIP4=;
        b=FJtvX3dNBDfO2/yM1uzIe0lWwAnJfzJ/unb8WKJuOjhPUvM6e0onk/WCu4+VsFgl9q
         zz6XghZznld8j1L92hg7jARZGBclmh0EgyrMmKjbTrOAsFTCVy7NiTxAyMsKkp8otKB2
         uDb+VsHYXdhVqOpAQ0/fnm67IILlgPNJqYIndjF66RtvueKXEbX+njRCNI5JHCixxEaC
         /HdNWJl6USDLkIPWG7pT7cnM4/18CqUOH1bbsPYaBIu7ekYRh05Ckeyx7WH/FX9Ci93c
         Jehgk+2G3TmXogMXl9E7lirxt0EquxxwtWgx7w0dbcSXTFmQmqBsEbbQr0cR04aqluEj
         h8CA==
X-Gm-Message-State: AC+VfDyUYen0aEgHI7NSVmFVJZBBAZ+cvVmdDIV/hbdlYBNRF4JGWk9b
        S+4cgqQfWX776/HV+h9O4PlPSBVH6HliQDNy3ALNtlgFSRfyVo/ap9T/71JT
X-Google-Smtp-Source: ACHHUZ7jsYrkoiEy4cySESG4HDKDzMYd6UFgrTHZJlXYGIrBwQiXUk/zzGx2KyuHlp7BIdqF6rvzDKznYWKiH5AXqvU=
X-Received: by 2002:a25:e792:0:b0:b9d:8613:6936 with SMTP id
 e140-20020a25e792000000b00b9d86136936mr14622784ybh.50.1683068710692; Tue, 02
 May 2023 16:05:10 -0700 (PDT)
MIME-Version: 1.0
References: <20230501175025.36233-1-surenb@google.com> <ZFBvOh8r5WbTVyA8@casper.infradead.org>
 <CAJuCfpHfAFx9rjv0gHK77LbP-8gd-kFnWw=aqfQTP6pH=zvMNg@mail.gmail.com>
 <ZFCB+G9KSNE+J9cZ@casper.infradead.org> <CAJuCfpES=G8i99yYXWoeJq9+JVUjX5Bkq_5VNVTVX7QT+Wkfxg@mail.gmail.com>
 <ZFEmN6G7WRy59Mum@casper.infradead.org> <CAJuCfpFs+Rgpu8v+ddHFwtOx33W5k1sKDdXHM2ej1Upyo_9y4g@mail.gmail.com>
 <ZFGPLXIis6tl1QWX@casper.infradead.org>
In-Reply-To: <ZFGPLXIis6tl1QWX@casper.infradead.org>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Tue, 2 May 2023 16:04:59 -0700
Message-ID: <CAJuCfpGgc_bCEAE5LrhYPk=qXMU=owgiABTO9ZNqaBx-xfrOuQ@mail.gmail.com>
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
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, May 2, 2023 at 3:31=E2=80=AFPM Matthew Wilcox <willy@infradead.org>=
 wrote:
>
> On Tue, May 02, 2023 at 09:36:03AM -0700, Suren Baghdasaryan wrote:
> > On Tue, May 2, 2023 at 8:03=E2=80=AFAM Matthew Wilcox <willy@infradead.=
org> wrote:
> > >
> > > On Mon, May 01, 2023 at 10:04:56PM -0700, Suren Baghdasaryan wrote:
> > > > On Mon, May 1, 2023 at 8:22=E2=80=AFPM Matthew Wilcox <willy@infrad=
ead.org> wrote:
> > > > >
> > > > > On Mon, May 01, 2023 at 07:30:13PM -0700, Suren Baghdasaryan wrot=
e:
> > > > > > On Mon, May 1, 2023 at 7:02=E2=80=AFPM Matthew Wilcox <willy@in=
fradead.org> wrote:
> > > > > > >
> > > > > > > On Mon, May 01, 2023 at 10:50:23AM -0700, Suren Baghdasaryan =
wrote:
> > > > > > > > +++ b/mm/memory.c
> > > > > > > > @@ -3711,11 +3711,6 @@ vm_fault_t do_swap_page(struct vm_fa=
ult *vmf)
> > > > > > > >       if (!pte_unmap_same(vmf))
> > > > > > > >               goto out;
> > > > > > > >
> > > > > > > > -     if (vmf->flags & FAULT_FLAG_VMA_LOCK) {
> > > > > > > > -             ret =3D VM_FAULT_RETRY;
> > > > > > > > -             goto out;
> > > > > > > > -     }
> > > > > > > > -
> > > > > > > >       entry =3D pte_to_swp_entry(vmf->orig_pte);
> > > > > > > >       if (unlikely(non_swap_entry(entry))) {
> > > > > > > >               if (is_migration_entry(entry)) {
> > > > > > >
> > > > > > > You're missing the necessary fallback in the (!folio) case.
> > > > > > > swap_readpage() is synchronous and will sleep.
> > > > > >
> > > > > > True, but is it unsafe to do that under VMA lock and has to be =
done
> > > > > > under mmap_lock?
> > > > >
> > > > > ... you were the one arguing that we didn't want to wait for I/O =
with
> > > > > the VMA lock held?
> > > >
> > > > Well, that discussion was about waiting in folio_lock_or_retry() wi=
th
> > > > the lock being held. I argued against it because currently we drop
> > > > mmap_lock lock before waiting, so if we don't drop VMA lock we woul=
d
> > > > be changing the current behavior which might introduce new
> > > > regressions. In the case of swap_readpage and swapin_readahead we
> > > > already wait with mmap_lock held, so waiting with VMA lock held doe=
s
> > > > not introduce new problems (unless there is a need to hold mmap_loc=
k).
> > > >
> > > > That said, you are absolutely correct that this situation can be
> > > > improved by dropping the lock in these cases too. I just didn't wan=
t
> > > > to attack everything at once. I believe after we agree on the appro=
ach
> > > > implemented in https://lore.kernel.org/all/20230501175025.36233-3-s=
urenb@google.com
> > > > for dropping the VMA lock before waiting, these cases can be added
> > > > easier. Does that make sense?
> > >
> > > OK, I looked at this path some more, and I think we're fine.  This
> > > patch is only called for SWP_SYNCHRONOUS_IO which is only set for
> > > QUEUE_FLAG_SYNCHRONOUS devices, which are brd, zram and nvdimms
> > > (both btt and pmem).  So the answer is that we don't sleep in this
> > > path, and there's no need to drop the lock.
> >
> > Yes but swapin_readahead does sleep, so I'll have to handle that case
> > too after this.
>
> Sleeping is OK, we do that in pXd_alloc()!  Do we block on I/O anywhere
> in swapin_readahead()?  It all looks like async I/O to me.

Hmm. I thought that we have synchronous I/O in the following paths:
    swapin_readahead()->swap_cluster_readahead()->swap_readpage()
    swapin_readahead()->swap_vma_readahead()->swap_readpage()
but just noticed that in both cases swap_readpage() is called with the
synchronous parameter being false. So you are probably right here...
Does that mean swapin_readahead() might return a page which does not
have its content swapped-in yet?
