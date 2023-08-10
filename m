Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8860778421
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Aug 2023 01:30:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232496AbjHJXaH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Aug 2023 19:30:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229806AbjHJXaH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Aug 2023 19:30:07 -0400
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B529C270F
        for <linux-fsdevel@vger.kernel.org>; Thu, 10 Aug 2023 16:30:06 -0700 (PDT)
Received: by mail-oi1-x233.google.com with SMTP id 5614622812f47-3a76d882080so1228451b6e.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 10 Aug 2023 16:30:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691710206; x=1692315006;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Us0jQem01wTsq5oLI86XdBT1Bl2UNsOl181yWXsRIRw=;
        b=tKoJJzjFBECo6MzzydQY0LO8m6SpU5yiUNRwsNtA7/FU6MRsKPUdJat2cdGhDnfWn4
         Hc04Xu657oR6lvFH1D2hWfEJVoiGXEUSGgqv1H8oC0TOFDgvdPVXqwzRNXYxTFmXcjlT
         GHaa8qRx5dtgUbNl9622QBG6+AWvoyp2H0JYYMiE4rhgyREFt3n86nwY3MzuPydKe8K/
         xmXbWdIXDp5xUDjEDyrEc0KjjiOASYK9meCkuluo82JlsGJwhLz5DnK/yuw3DcbLnxK1
         tiVeyI6m8rQiSDl7MOjutH51FKczkolZGZaC25suA0WP+AhAlk+i/XGiGcMYGzY0HpSz
         LvRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691710206; x=1692315006;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Us0jQem01wTsq5oLI86XdBT1Bl2UNsOl181yWXsRIRw=;
        b=NXCYPHw890sYp2PLr3/UptGm9jvp/OWXPV7Ke1kpEwOP/qzXDmf0f1pStoJSnnXDAd
         OSVyTXlvDa1FkqlnEp0NihGscFZyj8lJlpXjpTvibeoZ/OcqI0EZ2HvEprJIV9Imyltu
         EPgIxgFcieyPcbBrBdDHD8fPnc1d3P33KArRPtLkuqLxg+VKUn7HAvbZkPnACZuLpB8T
         Ek5XzXoM1x2iJ6jf6hXkm2Uzs/DJsQp/jB/f65yMy9zKJjAxpUjsszDyblMu2JhA+95o
         UzOw6MjgqhyWQ7x5WBLsgB8g9i6yYNBe5p5H6BdL/zrvUNyAapSnEETY3jpDYWmNtnIW
         IfVg==
X-Gm-Message-State: AOJu0Yye9k4ZrRKyvkQWSrQek9VASzVYqzRRLZvCO41sMIF93WydnzJ5
        R83427+LSYiiVhxCg6TUjDPJoAAmZIyTAr/q515MBw==
X-Google-Smtp-Source: AGHT+IFeEMio2gJ4kBngRB4zbUtBoGQ2XJEN6qvjP50PbhujYl59Kaa5oh82GdgItIor5tQiS/o5bQzeaI16ZFTmPPs=
X-Received: by 2002:a05:6358:428f:b0:135:62de:ff7d with SMTP id
 s15-20020a056358428f00b0013562deff7dmr492898rwc.8.1691710205803; Thu, 10 Aug
 2023 16:30:05 -0700 (PDT)
MIME-Version: 1.0
References: <20230630211957.1341547-1-surenb@google.com> <a34a418a-9a6c-9d9a-b7a3-bde8013bf86c@redhat.com>
 <CAJuCfpGCWekMdno=L=4m7ujWTYMr0Wv77oYzXWT5RXnx+fWe0w@mail.gmail.com>
 <CAJuCfpGMvYxu-g9kVH40UDGnpF2kxctH7AazhvmwhWWq1Rn1sA@mail.gmail.com>
 <CAJuCfpHA78vxOBcaB3m7S7=CoBLMXTzRWego+jZM7JvUm3rEaQ@mail.gmail.com>
 <0ab6524a-6917-efe2-de69-f07fb5cdd9d2@redhat.com> <CAJuCfpEs2k8mHM+9uq05vmcOYCfkNnOb4s3xPSoWheizPkcwLA@mail.gmail.com>
 <CAJuCfpERuCx6QvfejUkS-ysMxbzp3mFfhCbH=rDtt2UGzbwtyg@mail.gmail.com>
 <CAJuCfpH-drRnwqUqynTnvgqSjs=_Fwc0H_7h6nzsdztRef0oKw@mail.gmail.com>
 <CAJuCfpH8ucOkCFYrVZafUAppi5+mVhy=uD+BK6-oYX=ysQv5qQ@mail.gmail.com> <ZNVhpeejqGkEqqSr@casper.infradead.org>
In-Reply-To: <ZNVhpeejqGkEqqSr@casper.infradead.org>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Thu, 10 Aug 2023 16:29:52 -0700
Message-ID: <CAJuCfpG2Sc8Og+9EfeWsZ-xX+bUuEokUJe8Bvg5+dAqHtC-DfQ@mail.gmail.com>
Subject: Re: [PATCH v7 0/6] Per-VMA lock support for swap and userfaults
To:     Matthew Wilcox <willy@infradead.org>
Cc:     David Hildenbrand <david@redhat.com>, akpm@linux-foundation.org,
        hannes@cmpxchg.org, mhocko@suse.com, josef@toxicpanda.com,
        jack@suse.cz, ldufour@linux.ibm.com, laurent.dufour@fr.ibm.com,
        michel@lespinasse.org, liam.howlett@oracle.com, jglisse@google.com,
        vbabka@suse.cz, minchan@google.com, dave@stgolabs.net,
        punit.agrawal@bytedance.com, lstoakes@gmail.com, hdanton@sina.com,
        apopple@nvidia.com, peterx@redhat.com, ying.huang@intel.com,
        yuzhao@google.com, dhowells@redhat.com, hughd@google.com,
        viro@zeniv.linux.org.uk, brauner@kernel.org,
        pasha.tatashin@soleen.com, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Aug 10, 2023 at 3:16=E2=80=AFPM Matthew Wilcox <willy@infradead.org=
> wrote:
>
> On Thu, Aug 10, 2023 at 06:24:15AM +0000, Suren Baghdasaryan wrote:
> > Ok, I think I found the issue.  wp_page_shared() ->
> > fault_dirty_shared_page() can drop mmap_lock (see the comment saying
> > "Drop the mmap_lock before waiting on IO, if we can...", therefore we
> > have to ensure we are not doing this under per-VMA lock.
>
> ... or we could change maybe_unlock_mmap_for_io() the same way
> that we changed folio_lock_or_retry():
>
> +++ b/mm/internal.h
> @@ -706,7 +706,7 @@ static inline struct file *maybe_unlock_mmap_for_io(s=
truct vm_fault *vmf,
>         if (fault_flag_allow_retry_first(flags) &&
>             !(flags & FAULT_FLAG_RETRY_NOWAIT)) {
>                 fpin =3D get_file(vmf->vma->vm_file);
> -               mmap_read_unlock(vmf->vma->vm_mm);
> +               release_fault_lock(vmf);
>         }
>         return fpin;
>  }
>
> What do you think?

This is very tempting... Let me try that and see if anything explodes,
but yes, this would be ideal.


>
> > I think what happens is that this path is racing with another page
> > fault which took mmap_lock for read. fault_dirty_shared_page()
> > releases this lock which was taken by another page faulting thread and
> > that thread generates an assertion when it finds out the lock it just
> > took got released from under it.
>
> I'm confused that our debugging didn't catch this earlier.  lockdep
> should always catch this.

Maybe this condition is rare enough?
