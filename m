Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C54736733A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Apr 2021 21:13:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240264AbhDUTNu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Apr 2021 15:13:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:40061 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239913AbhDUTNt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Apr 2021 15:13:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619032395;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Ftb3f+P7+1mOJewyvfh1G9UljZ8q13sSYxQQCbMYd20=;
        b=dCplDRE68G8M7d9zGfOf4KITOkZ6Z1xgI/HxnyFP/XqTi/RbswzMoh4gpcd4nRtXvw0mic
        vjiRD66HJ7uX1br5kzM2VJnoO8/ZrVgbE2ax0c6ElMGVHuGw29WE7jOsVTB7h8cG0VLQuU
        6Sp/4agxWo1CLKxTQfkpPtGAVVBuxx4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-356-uCi6xlovOaShJNxmp9ojMg-1; Wed, 21 Apr 2021 15:13:11 -0400
X-MC-Unique: uCi6xlovOaShJNxmp9ojMg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3EA19107ACCA;
        Wed, 21 Apr 2021 19:13:10 +0000 (UTC)
Received: from horse.redhat.com (ovpn-114-206.rdu2.redhat.com [10.10.114.206])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3FB5D10023AE;
        Wed, 21 Apr 2021 19:13:06 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id AFEA5220BCF; Wed, 21 Apr 2021 15:13:05 -0400 (EDT)
Date:   Wed, 21 Apr 2021 15:13:05 -0400
From:   Vivek Goyal <vgoyal@redhat.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Greg Kurz <groug@kaod.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Jan Kara <jack@suse.cz>, Matthew Wilcox <willy@infradead.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        virtio-fs-list <virtio-fs@redhat.com>
Subject: Re: [Virtio-fs] [PATCH v3 2/3] dax: Add a wakeup mode parameter to
 put_unlocked_entry()
Message-ID: <20210421191305.GG1579961@redhat.com>
References: <20210419213636.1514816-1-vgoyal@redhat.com>
 <20210419213636.1514816-3-vgoyal@redhat.com>
 <20210420093420.2eed3939@bahia.lan>
 <20210420140033.GA1529659@redhat.com>
 <CAPcyv4g2raipYhivwbiSvsHmSdgLO8wphh5dhY3hpjwko9G4Hw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4g2raipYhivwbiSvsHmSdgLO8wphh5dhY3hpjwko9G4Hw@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Apr 21, 2021 at 12:09:54PM -0700, Dan Williams wrote:
> On Tue, Apr 20, 2021 at 7:01 AM Vivek Goyal <vgoyal@redhat.com> wrote:
> >
> > On Tue, Apr 20, 2021 at 09:34:20AM +0200, Greg Kurz wrote:
> > > On Mon, 19 Apr 2021 17:36:35 -0400
> > > Vivek Goyal <vgoyal@redhat.com> wrote:
> > >
> > > > As of now put_unlocked_entry() always wakes up next waiter. In next
> > > > patches we want to wake up all waiters at one callsite. Hence, add a
> > > > parameter to the function.
> > > >
> > > > This patch does not introduce any change of behavior.
> > > >
> > > > Suggested-by: Dan Williams <dan.j.williams@intel.com>
> > > > Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
> > > > ---
> > > >  fs/dax.c | 13 +++++++------
> > > >  1 file changed, 7 insertions(+), 6 deletions(-)
> > > >
> > > > diff --git a/fs/dax.c b/fs/dax.c
> > > > index 00978d0838b1..f19d76a6a493 100644
> > > > --- a/fs/dax.c
> > > > +++ b/fs/dax.c
> > > > @@ -275,11 +275,12 @@ static void wait_entry_unlocked(struct xa_state *xas, void *entry)
> > > >     finish_wait(wq, &ewait.wait);
> > > >  }
> > > >
> > > > -static void put_unlocked_entry(struct xa_state *xas, void *entry)
> > > > +static void put_unlocked_entry(struct xa_state *xas, void *entry,
> > > > +                          enum dax_entry_wake_mode mode)
> > > >  {
> > > >     /* If we were the only waiter woken, wake the next one */
> > >
> > > With this change, the comment is no longer accurate since the
> > > function can now wake all waiters if passed mode == WAKE_ALL.
> > > Also, it paraphrases the code which is simple enough, so I'd
> > > simply drop it.
> > >
> > > This is minor though and it shouldn't prevent this fix to go
> > > forward.
> > >
> > > Reviewed-by: Greg Kurz <groug@kaod.org>
> >
> > Ok, here is the updated patch which drops that comment line.
> >
> > Vivek
> 
> Hi Vivek,
> 
> Can you get in the habit of not replying inline with new patches like
> this? Collect the review feedback, take a pause, and resend the full
> series so tooling like b4 and patchwork can track when a new posting
> supersedes a previous one. As is, this inline style inflicts manual
> effort on the maintainer.

Hi Dan,

Sure. I will avoid doing this updated inline patch style. I will post new
version of patch series. 

Thanks
Vivek

> 
> >
> > Subject: dax: Add a wakeup mode parameter to put_unlocked_entry()
> >
> > As of now put_unlocked_entry() always wakes up next waiter. In next
> > patches we want to wake up all waiters at one callsite. Hence, add a
> > parameter to the function.
> >
> > This patch does not introduce any change of behavior.
> >
> > Suggested-by: Dan Williams <dan.j.williams@intel.com>
> > Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
> > ---
> >  fs/dax.c |   14 +++++++-------
> >  1 file changed, 7 insertions(+), 7 deletions(-)
> >
> > Index: redhat-linux/fs/dax.c
> > ===================================================================
> > --- redhat-linux.orig/fs/dax.c  2021-04-20 09:55:45.105069893 -0400
> > +++ redhat-linux/fs/dax.c       2021-04-20 09:56:27.685822730 -0400
> > @@ -275,11 +275,11 @@ static void wait_entry_unlocked(struct x
> >         finish_wait(wq, &ewait.wait);
> >  }
> >
> > -static void put_unlocked_entry(struct xa_state *xas, void *entry)
> > +static void put_unlocked_entry(struct xa_state *xas, void *entry,
> > +                              enum dax_entry_wake_mode mode)
> >  {
> > -       /* If we were the only waiter woken, wake the next one */
> >         if (entry && !dax_is_conflict(entry))
> > -               dax_wake_entry(xas, entry, WAKE_NEXT);
> > +               dax_wake_entry(xas, entry, mode);
> >  }
> >
> >  /*
> > @@ -633,7 +633,7 @@ struct page *dax_layout_busy_page_range(
> >                         entry = get_unlocked_entry(&xas, 0);
> >                 if (entry)
> >                         page = dax_busy_page(entry);
> > -               put_unlocked_entry(&xas, entry);
> > +               put_unlocked_entry(&xas, entry, WAKE_NEXT);
> >                 if (page)
> >                         break;
> >                 if (++scanned % XA_CHECK_SCHED)
> > @@ -675,7 +675,7 @@ static int __dax_invalidate_entry(struct
> >         mapping->nrexceptional--;
> >         ret = 1;
> >  out:
> > -       put_unlocked_entry(&xas, entry);
> > +       put_unlocked_entry(&xas, entry, WAKE_NEXT);
> >         xas_unlock_irq(&xas);
> >         return ret;
> >  }
> > @@ -954,7 +954,7 @@ static int dax_writeback_one(struct xa_s
> >         return ret;
> >
> >   put_unlocked:
> > -       put_unlocked_entry(xas, entry);
> > +       put_unlocked_entry(xas, entry, WAKE_NEXT);
> >         return ret;
> >  }
> >
> > @@ -1695,7 +1695,7 @@ dax_insert_pfn_mkwrite(struct vm_fault *
> >         /* Did we race with someone splitting entry or so? */
> >         if (!entry || dax_is_conflict(entry) ||
> >             (order == 0 && !dax_is_pte_entry(entry))) {
> > -               put_unlocked_entry(&xas, entry);
> > +               put_unlocked_entry(&xas, entry, WAKE_NEXT);
> >                 xas_unlock_irq(&xas);
> >                 trace_dax_insert_pfn_mkwrite_no_entry(mapping->host, vmf,
> >                                                       VM_FAULT_NOPAGE);
> >
> 

