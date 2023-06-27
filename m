Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8814774004B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jun 2023 18:05:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232078AbjF0QFu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Jun 2023 12:05:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231989AbjF0QFt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Jun 2023 12:05:49 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EFE52D5E
        for <linux-fsdevel@vger.kernel.org>; Tue, 27 Jun 2023 09:05:44 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-676f16e0bc4so1611119b3a.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 27 Jun 2023 09:05:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687881944; x=1690473944;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q26ddN6EaiG+6pUfPDCx1Slx/RD6peq9xPMgzmc1DZ0=;
        b=GjHZ1FPL4Uf5eOs8kydNy5ZtRjtHSLXq4QEouhq/SzL/NIX/VYDhx2RV5DZs3iVInm
         3l/6uAlkL6DIwiurz1xhs1cnC2fUZnsGFoxg6boimRtdXBRh1ObuA2j9AjK6dmkiu87G
         DlrF/l3ezbzmGpdqLW8zujMOqsy/0bCV0BgEhxViprPgs0TZT3u7T2Mfv/J8SkJULIKq
         LYeEKM5YertQUMrf4P2rcVHxDM7XOLvPqR3ci14/Z+TLxf9yoZlotgXdnKuooHOZ1Uaw
         89dzVGLYaJtIPecoAmy6jYXmQBIPSQwHj3O6s9HoVghYcej8/RP0Cwy2VvRmCpd8TrRE
         IQ1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687881944; x=1690473944;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q26ddN6EaiG+6pUfPDCx1Slx/RD6peq9xPMgzmc1DZ0=;
        b=Pu6hoSKbq2LqVKBmlq6rOKY+30KlLpHJ1C59VwdixpvyqHTlKkzjXhtgKqXAL7FWWG
         oC5kDt41sAkFp245W06IUSKccT4JFPUaa+DYpDPlvCEbfG/xKZSH6HJgIneDMNv6Cz4j
         uKM3lxAeVZMocLnsbyq0NyCiR+cjQPg6YXVIMroT/hScErKx8bQEljQSog2S59M60I2a
         brn3yJC/0Wug4brJbZZ48QPd0q6r4ALTbw5kPMdjFfzlAY9RJxV4P+F7NztrGu2+wmLS
         F+ii4YMhzUCbBlKx7iut58eQfADMzPxLZHrN/jP8c1ycoEE1mKrEsSpS/x4t34Q7Vo3q
         xHsQ==
X-Gm-Message-State: AC+VfDwSZP/dlXb1H7I94Q8tPSQhfMbhHMu/sAcfM5QWQS61HffvSNJx
        fueYDe2YQwJ8OlDL/YA0XKbqCVJsZ0ZvrvxPSi3nrQ==
X-Google-Smtp-Source: ACHHUZ7qNIqz25NqhtZvximqJ6qWhiZHpcocQ+RiSDrTYZkluHctdAXLi6rX/cQ8We3t7qgOBbM6dTOpUrhhLyaiYk0=
X-Received: by 2002:a05:6a20:4286:b0:125:9d7f:3c03 with SMTP id
 o6-20020a056a20428600b001259d7f3c03mr11721657pzj.23.1687881943704; Tue, 27
 Jun 2023 09:05:43 -0700 (PDT)
MIME-Version: 1.0
References: <20230627042321.1763765-1-surenb@google.com> <20230627042321.1763765-7-surenb@google.com>
 <ZJsDMRkFRz11R0dt@x1n>
In-Reply-To: <ZJsDMRkFRz11R0dt@x1n>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Tue, 27 Jun 2023 09:05:32 -0700
Message-ID: <CAJuCfpFNTj-1q=ZrNKO=4=VdBwiq_mTHWnXo0_QKi=AgCOo9yw@mail.gmail.com>
Subject: Re: [PATCH v3 6/8] mm: handle swap page faults under per-VMA lock
To:     Peter Xu <peterx@redhat.com>
Cc:     akpm@linux-foundation.org, willy@infradead.org, hannes@cmpxchg.org,
        mhocko@suse.com, josef@toxicpanda.com, jack@suse.cz,
        ldufour@linux.ibm.com, laurent.dufour@fr.ibm.com,
        michel@lespinasse.org, liam.howlett@oracle.com, jglisse@google.com,
        vbabka@suse.cz, minchan@google.com, dave@stgolabs.net,
        punit.agrawal@bytedance.com, lstoakes@gmail.com, hdanton@sina.com,
        apopple@nvidia.com, ying.huang@intel.com, david@redhat.com,
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
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 27, 2023 at 8:41=E2=80=AFAM Peter Xu <peterx@redhat.com> wrote:
>
> On Mon, Jun 26, 2023 at 09:23:19PM -0700, Suren Baghdasaryan wrote:
> > When page fault is handled under per-VMA lock protection, all swap page
> > faults are retried with mmap_lock because folio_lock_fault (formerly
> > known as folio_lock_or_retry) had to drop and reacquire mmap_lock
> > if folio could not be immediately locked.
> > Follow the same pattern as mmap_lock to drop per-VMA lock when waiting
> > for folio in folio_lock_fault and retrying once folio is available.
> > With this obstacle removed, enable do_swap_page to operate under
> > per-VMA lock protection. Drivers implementing ops->migrate_to_ram might
> > still rely on mmap_lock, therefore we have to fall back to mmap_lock in
> > that particular case.
> > Note that the only time do_swap_page calls synchronous swap_readpage
> > is when SWP_SYNCHRONOUS_IO is set, which is only set for
> > QUEUE_FLAG_SYNCHRONOUS devices: brd, zram and nvdimms (both btt and
> > pmem). Therefore we don't sleep in this path, and there's no need to
> > drop the mmap or per-VMA lock.
> >
> > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> > ---
> >  mm/filemap.c | 24 ++++++++++++++++--------
> >  mm/memory.c  | 21 ++++++++++++++-------
> >  2 files changed, 30 insertions(+), 15 deletions(-)
> >
> > diff --git a/mm/filemap.c b/mm/filemap.c
> > index 8ad06d69895b..683f11f244cd 100644
> > --- a/mm/filemap.c
> > +++ b/mm/filemap.c
> > @@ -1703,12 +1703,14 @@ static int __folio_lock_async(struct folio *fol=
io, struct wait_page_queue *wait)
> >   * Return values:
> >   * 0 - folio is locked.
> >   * VM_FAULT_RETRY - folio is not locked.
> > - *     mmap_lock has been released (mmap_read_unlock(), unless flags h=
ad both
> > - *     FAULT_FLAG_ALLOW_RETRY and FAULT_FLAG_RETRY_NOWAIT set, in
> > - *     which case mmap_lock is still held.
> > + *     FAULT_FLAG_LOCK_DROPPED bit in vmf flags will be set if mmap_lo=
ck or
>
> This "FAULT_FLAG_LOCK_DROPPED" should belong to that patch when introduce=
d.
> But again I still think this flag as a whole with that patch is not neede=
d
> and should be dropped, unless I miss something important..
>
> > + *     per-VMA lock got dropped. mmap_lock/per-VMA lock is dropped whe=
n
> > + *     function fails to lock the folio, unless flags had both
> > + *     FAULT_FLAG_ALLOW_RETRY and FAULT_FLAG_RETRY_NOWAIT set, in whic=
h case
> > + *     the lock is still held.
> >   *
> >   * If neither ALLOW_RETRY nor KILLABLE are set, will always return 0
> > - * with the folio locked and the mmap_lock unperturbed.
> > + * with the folio locked and the mmap_lock/per-VMA lock unperturbed.
> >   */
> >  vm_fault_t __folio_lock_fault(struct folio *folio, struct vm_fault *vm=
f)
> >  {
> > @@ -1716,13 +1718,16 @@ vm_fault_t __folio_lock_fault(struct folio *fol=
io, struct vm_fault *vmf)
> >
> >       if (fault_flag_allow_retry_first(vmf->flags)) {
> >               /*
> > -              * CAUTION! In this case, mmap_lock is not released
> > -              * even though return VM_FAULT_RETRY.
> > +              * CAUTION! In this case, mmap_lock/per-VMA lock is not
> > +              * released even though returning VM_FAULT_RETRY.
> >                */
> >               if (vmf->flags & FAULT_FLAG_RETRY_NOWAIT)
> >                       return VM_FAULT_RETRY;
> >
> > -             mmap_read_unlock(mm);
> > +             if (vmf->flags & FAULT_FLAG_VMA_LOCK)
> > +                     vma_end_read(vmf->vma);
> > +             else
> > +                     mmap_read_unlock(mm);
> >               vmf->flags |=3D FAULT_FLAG_LOCK_DROPPED;
> >               if (vmf->flags & FAULT_FLAG_KILLABLE)
> >                       folio_wait_locked_killable(folio);
> > @@ -1735,7 +1740,10 @@ vm_fault_t __folio_lock_fault(struct folio *foli=
o, struct vm_fault *vmf)
> >
> >               ret =3D __folio_lock_killable(folio);
> >               if (ret) {
> > -                     mmap_read_unlock(mm);
> > +                     if (vmf->flags & FAULT_FLAG_VMA_LOCK)
> > +                             vma_end_read(vmf->vma);
> > +                     else
> > +                             mmap_read_unlock(mm);
> >                       vmf->flags |=3D FAULT_FLAG_LOCK_DROPPED;
> >                       return VM_FAULT_RETRY;
> >               }
> > diff --git a/mm/memory.c b/mm/memory.c
> > index 3c2acafcd7b6..5caaa4c66ea2 100644
> > --- a/mm/memory.c
> > +++ b/mm/memory.c
> > @@ -3712,11 +3712,6 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
> >       if (!pte_unmap_same(vmf))
> >               goto out;
> >
> > -     if (vmf->flags & FAULT_FLAG_VMA_LOCK) {
>
> So if with my imagination, here we'll already have the vma_read_end() and
> this patch will remove it, which makes sense.  Then...
>
> > -             ret =3D VM_FAULT_RETRY;
> > -             goto out;
> > -     }
> > -
> >       entry =3D pte_to_swp_entry(vmf->orig_pte);
> >       if (unlikely(non_swap_entry(entry))) {
> >               if (is_migration_entry(entry)) {
> > @@ -3726,6 +3721,15 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
> >                       vmf->page =3D pfn_swap_entry_to_page(entry);
> >                       ret =3D remove_device_exclusive_entry(vmf);
> >               } else if (is_device_private_entry(entry)) {
> > +                     if (vmf->flags & FAULT_FLAG_VMA_LOCK) {
> > +                             /*
> > +                              * migrate_to_ram is not yet ready to ope=
rate
> > +                              * under VMA lock.
> > +                              */
>
> ... here we probably just do vma_read_end(), then...
>
> > +                             ret |=3D VM_FAULT_RETRY;
> > +                             goto out;
> > +                     }
> > +
> >                       vmf->page =3D pfn_swap_entry_to_page(entry);
> >                       vmf->pte =3D pte_offset_map_lock(vma->vm_mm, vmf-=
>pmd,
> >                                       vmf->address, &vmf->ptl);
> > @@ -5089,9 +5093,12 @@ static vm_fault_t __handle_mm_fault(struct vm_ar=
ea_struct *vma,
> >               /*
> >                * In case of VM_FAULT_RETRY or VM_FAULT_COMPLETED we mig=
ht
> >                * be still holding per-VMA lock to keep the vma stable a=
s long
> > -              * as possible. Drop it before returning.
> > +              * as possible. In this situation vmf.flags has
> > +              * FAULT_FLAG_VMA_LOCK set and FAULT_FLAG_LOCK_DROPPED un=
set.
> > +              * Drop the lock before returning when this happens.
> >                */
> > -             if (vmf.flags & FAULT_FLAG_VMA_LOCK)
> > +             if ((vmf.flags & (FAULT_FLAG_VMA_LOCK | FAULT_FLAG_LOCK_D=
ROPPED)) =3D=3D
> > +                 FAULT_FLAG_VMA_LOCK)
> >                       vma_end_read(vma);
>
> This whole chunk should have been dropped altogether with my comment in
> previous patch, iiuc, and it should be no-op anyway for swap case.  For t=
he
> real "waiting for page lock during swapin" phase we should always 100%
> release the vma lock in folio_lock_or_retry() - just like mmap lock.

Yep, we drop FAULT_FLAG_LOCK_DROPPED, release vma lock when we return
RETRY and that makes all this unnecessary. I just need to make sure we
do not access VMA after we drop its lock since we will be releasing it
now earlier than before.

>
> Thanks,
>
> >       }
> >       return ret;
> > --
> > 2.41.0.178.g377b9f9a00-goog
> >
>
> --
> Peter Xu
>
