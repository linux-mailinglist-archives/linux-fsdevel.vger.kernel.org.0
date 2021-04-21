Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35563367335
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Apr 2021 21:10:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239732AbhDUTKk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Apr 2021 15:10:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239728AbhDUTKh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Apr 2021 15:10:37 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF41BC06174A
        for <linux-fsdevel@vger.kernel.org>; Wed, 21 Apr 2021 12:10:02 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id h8so10462268edb.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 21 Apr 2021 12:10:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NBcAuPkDB8yn7vxrbycYSSA5wndCepu03NrNjeW39ik=;
        b=pthqRNwvDGzcKw29vq+beBkIOvNN/fF7gZ2Xe3IXaGqVyzwBsLaqthgSuIMoUo8IW+
         gumEibGbH+L9n3/IkDXke2EWisNXcNsuQf6FnbaaEy/QeVNwKXdGbkZ8gOO9PSRg/1tX
         kwpHvf8Dnvam7XnxffqBhiCqCrOzMrFlKJ0zzdSJYgIVgPVSylOM6txrHN/8UiwP6HfA
         yla17QS2aL3iB+isH0nkwPXzzVoti8Zr1k8OZUkULS65Qk4I6Ao+xwxtWVYQdJYqZq+u
         WaYCdpb8iRaFCZA0dUw7sziGDrn8XZ0N4rnmBOYyoVOkjZHatSAF/GDUpT6/5BGbcEFC
         b0/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NBcAuPkDB8yn7vxrbycYSSA5wndCepu03NrNjeW39ik=;
        b=hMabFLpoi9aK3Y3F19Hu9Bl/uv3N7afFX7+TZf6wb6kP+r9j2IEARotmQrVZMxVLa0
         RXFXOLT2sgmUQOZZE+e5/JDoOmVCPSTj6VdkRsOTpIGROxBAGJ9jJjG6cabgFg0Gv0SA
         tVq2R3kOi0mCgt1ERfkv/VwVAAX4V4tqeQ+Rxde5SPYZJWqIpUmS9FNxDF5aE/0/kwru
         Oux62Hhup6Ht2RYjVbQmFDNTFKqNp66pn8+YAO2viTJUdF16c30JKD2HYkROE7aF3qPf
         H8LhEXkMRx/0mgjZkkSORJPyF8+jSTCwUZokudLl/HLkuxw/ZcgFUtrvcRYQRWowXGVW
         sduA==
X-Gm-Message-State: AOAM532XKcHK4m9ypnhRrbxC8r0O1/HZi1tKAqIpe14kSYJIPC6adjD4
        o4TDS7JiItm5FZykITxlhfMmIv0VHdPNzyuts6iHew==
X-Google-Smtp-Source: ABdhPJzUzvWoqsHVgj6q4VHtvt/KU0qakEZL3zMXCyN6iQAH2qDqBVdMEkOUp4sI5gEzwoBW8HbVmWc5LR0glCxieKk=
X-Received: by 2002:a50:e607:: with SMTP id y7mr40985113edm.18.1619032201627;
 Wed, 21 Apr 2021 12:10:01 -0700 (PDT)
MIME-Version: 1.0
References: <20210419213636.1514816-1-vgoyal@redhat.com> <20210419213636.1514816-3-vgoyal@redhat.com>
 <20210420093420.2eed3939@bahia.lan> <20210420140033.GA1529659@redhat.com>
In-Reply-To: <20210420140033.GA1529659@redhat.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 21 Apr 2021 12:09:54 -0700
Message-ID: <CAPcyv4g2raipYhivwbiSvsHmSdgLO8wphh5dhY3hpjwko9G4Hw@mail.gmail.com>
Subject: Re: [Virtio-fs] [PATCH v3 2/3] dax: Add a wakeup mode parameter to put_unlocked_entry()
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     Greg Kurz <groug@kaod.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Jan Kara <jack@suse.cz>, Matthew Wilcox <willy@infradead.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        virtio-fs-list <virtio-fs@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Apr 20, 2021 at 7:01 AM Vivek Goyal <vgoyal@redhat.com> wrote:
>
> On Tue, Apr 20, 2021 at 09:34:20AM +0200, Greg Kurz wrote:
> > On Mon, 19 Apr 2021 17:36:35 -0400
> > Vivek Goyal <vgoyal@redhat.com> wrote:
> >
> > > As of now put_unlocked_entry() always wakes up next waiter. In next
> > > patches we want to wake up all waiters at one callsite. Hence, add a
> > > parameter to the function.
> > >
> > > This patch does not introduce any change of behavior.
> > >
> > > Suggested-by: Dan Williams <dan.j.williams@intel.com>
> > > Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
> > > ---
> > >  fs/dax.c | 13 +++++++------
> > >  1 file changed, 7 insertions(+), 6 deletions(-)
> > >
> > > diff --git a/fs/dax.c b/fs/dax.c
> > > index 00978d0838b1..f19d76a6a493 100644
> > > --- a/fs/dax.c
> > > +++ b/fs/dax.c
> > > @@ -275,11 +275,12 @@ static void wait_entry_unlocked(struct xa_state *xas, void *entry)
> > >     finish_wait(wq, &ewait.wait);
> > >  }
> > >
> > > -static void put_unlocked_entry(struct xa_state *xas, void *entry)
> > > +static void put_unlocked_entry(struct xa_state *xas, void *entry,
> > > +                          enum dax_entry_wake_mode mode)
> > >  {
> > >     /* If we were the only waiter woken, wake the next one */
> >
> > With this change, the comment is no longer accurate since the
> > function can now wake all waiters if passed mode == WAKE_ALL.
> > Also, it paraphrases the code which is simple enough, so I'd
> > simply drop it.
> >
> > This is minor though and it shouldn't prevent this fix to go
> > forward.
> >
> > Reviewed-by: Greg Kurz <groug@kaod.org>
>
> Ok, here is the updated patch which drops that comment line.
>
> Vivek

Hi Vivek,

Can you get in the habit of not replying inline with new patches like
this? Collect the review feedback, take a pause, and resend the full
series so tooling like b4 and patchwork can track when a new posting
supersedes a previous one. As is, this inline style inflicts manual
effort on the maintainer.

>
> Subject: dax: Add a wakeup mode parameter to put_unlocked_entry()
>
> As of now put_unlocked_entry() always wakes up next waiter. In next
> patches we want to wake up all waiters at one callsite. Hence, add a
> parameter to the function.
>
> This patch does not introduce any change of behavior.
>
> Suggested-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
> ---
>  fs/dax.c |   14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
>
> Index: redhat-linux/fs/dax.c
> ===================================================================
> --- redhat-linux.orig/fs/dax.c  2021-04-20 09:55:45.105069893 -0400
> +++ redhat-linux/fs/dax.c       2021-04-20 09:56:27.685822730 -0400
> @@ -275,11 +275,11 @@ static void wait_entry_unlocked(struct x
>         finish_wait(wq, &ewait.wait);
>  }
>
> -static void put_unlocked_entry(struct xa_state *xas, void *entry)
> +static void put_unlocked_entry(struct xa_state *xas, void *entry,
> +                              enum dax_entry_wake_mode mode)
>  {
> -       /* If we were the only waiter woken, wake the next one */
>         if (entry && !dax_is_conflict(entry))
> -               dax_wake_entry(xas, entry, WAKE_NEXT);
> +               dax_wake_entry(xas, entry, mode);
>  }
>
>  /*
> @@ -633,7 +633,7 @@ struct page *dax_layout_busy_page_range(
>                         entry = get_unlocked_entry(&xas, 0);
>                 if (entry)
>                         page = dax_busy_page(entry);
> -               put_unlocked_entry(&xas, entry);
> +               put_unlocked_entry(&xas, entry, WAKE_NEXT);
>                 if (page)
>                         break;
>                 if (++scanned % XA_CHECK_SCHED)
> @@ -675,7 +675,7 @@ static int __dax_invalidate_entry(struct
>         mapping->nrexceptional--;
>         ret = 1;
>  out:
> -       put_unlocked_entry(&xas, entry);
> +       put_unlocked_entry(&xas, entry, WAKE_NEXT);
>         xas_unlock_irq(&xas);
>         return ret;
>  }
> @@ -954,7 +954,7 @@ static int dax_writeback_one(struct xa_s
>         return ret;
>
>   put_unlocked:
> -       put_unlocked_entry(xas, entry);
> +       put_unlocked_entry(xas, entry, WAKE_NEXT);
>         return ret;
>  }
>
> @@ -1695,7 +1695,7 @@ dax_insert_pfn_mkwrite(struct vm_fault *
>         /* Did we race with someone splitting entry or so? */
>         if (!entry || dax_is_conflict(entry) ||
>             (order == 0 && !dax_is_pte_entry(entry))) {
> -               put_unlocked_entry(&xas, entry);
> +               put_unlocked_entry(&xas, entry, WAKE_NEXT);
>                 xas_unlock_irq(&xas);
>                 trace_dax_insert_pfn_mkwrite_no_entry(mapping->host, vmf,
>                                                       VM_FAULT_NOPAGE);
>
