Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6443CDDB6F
	for <lists+linux-fsdevel@lfdr.de>; Sun, 20 Oct 2019 01:27:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726162AbfJSX1g (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 19 Oct 2019 19:27:36 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:44128 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726145AbfJSX1g (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 19 Oct 2019 19:27:36 -0400
Received: by mail-oi1-f195.google.com with SMTP id w6so8159500oie.11
        for <linux-fsdevel@vger.kernel.org>; Sat, 19 Oct 2019 16:27:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3J1jZ/n3oL2BPGIWFZaJFKJlZuVwc5pXYUu/dIK5arI=;
        b=T+psi48ohJfRR1GMOlfSgYdd36qHs4P9a+xR60PQDWs3XG25CJh+FKeinlvLdnlLte
         oLrZIR2ogyz8jn3NT2WGneJtpW71T/aReyOSWiKqztT8WNXSJLeGenz7OYkdOS+p1SfO
         vwjaXIvW8eTssResIjsUvMEXNZ7ma8OGuIiL9wDfzZiaLTgffog1aifUBAZJNQ2/tfU3
         eu5jESGsp9//2zkHW0jD4WsqRgNh3Br8DxOTmSw1n4J410a1FaE51KOUW8YecPDEkld5
         GdekJkpvPWaJkfuY2VPbXoLS1kQIeymhGLSf4UGWu4Z+K/s+Y9QaOvUqpKtoYIdGRXRz
         qPQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3J1jZ/n3oL2BPGIWFZaJFKJlZuVwc5pXYUu/dIK5arI=;
        b=HBl5n3MlOpZBsA96gk97Y8L4cQT9uBgERcgX0kSabPjYHUHVLtyS/GWbwUGI0tY3+d
         KtquFuh4dNJ4L5nq7ayY0+fjjmsKUm5lFlJ6C/Tw+G1kFsxYbo0mt5/WyZNBhiPQTgBZ
         U2DkolXhKbEo8pFR7QQZp+nE56ToEZiYDRPpGZr2bf1MZSUiTKqHRURYiSePMJ15TKCg
         jW6MDF/8W+sIWiXwn2FRMuTRaHCURUyl7NoryLlSXIU5fM3CZiOE6Qq5XbasFduwm0IZ
         B9zAo6bfz1T8tTgDhJc2aDHTYfEz0JIMjdSStTsvCzZdhoBrJcrj+ai3TIUD/5dMj06f
         MrEA==
X-Gm-Message-State: APjAAAUh+8timb934BpCimV0SEPItDSpRsu2ytWsNREeZOAIGe09aHqR
        o2VOfRUcbu9FoqP0ovAZ/1B8vWRjFKBlVMUXUCypCA==
X-Google-Smtp-Source: APXvYqwTmZrTbxXuJ19lehyTkMwlX85En8TEvDWQiYgioR6j7EF0BYhEAUOgoPXcnncF+IB6q91TK5YYOJ0uaOHO+Yw=
X-Received: by 2002:aca:620a:: with SMTP id w10mr13893693oib.0.1571527655430;
 Sat, 19 Oct 2019 16:27:35 -0700 (PDT)
MIME-Version: 1.0
References: <157150237973.3940076.12626102230619807187.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20191019205003.GN32665@bombadil.infradead.org> <CAPcyv4jj-BqhPj3vB5=G7YfGPvBgugEZ39gf+3Wwn6BC1fAUJw@mail.gmail.com>
In-Reply-To: <CAPcyv4jj-BqhPj3vB5=G7YfGPvBgugEZ39gf+3Wwn6BC1fAUJw@mail.gmail.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Sat, 19 Oct 2019 16:27:24 -0700
Message-ID: <CAPcyv4hDXWTEZC__3zK8PeJNStmsjwzAQb+CqDOUYjuLx0J9Ag@mail.gmail.com>
Subject: Re: [PATCH] fs/dax: Fix pmd vs pte conflict detection
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Jeff Smits <jeff.smits@intel.com>,
        Doug Nelson <doug.nelson@intel.com>,
        stable <stable@vger.kernel.org>, Jan Kara <jack@suse.cz>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Oct 19, 2019 at 4:09 PM Dan Williams <dan.j.williams@intel.com> wrote:
>
> On Sat, Oct 19, 2019 at 1:50 PM Matthew Wilcox <willy@infradead.org> wrote:
> >
> > On Sat, Oct 19, 2019 at 09:26:19AM -0700, Dan Williams wrote:
> > > Check for NULL entries before checking the entry order, otherwise NULL
> > > is misinterpreted as a present pte conflict. The 'order' check needs to
> > > happen before the locked check as an unlocked entry at the wrong order
> > > must fallback to lookup the correct order.
> > >
> > > Reported-by: Jeff Smits <jeff.smits@intel.com>
> > > Reported-by: Doug Nelson <doug.nelson@intel.com>
> > > Cc: <stable@vger.kernel.org>
> > > Fixes: 23c84eb78375 ("dax: Fix missed wakeup with PMD faults")
> > > Cc: Jan Kara <jack@suse.cz>
> > > Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
> > > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> > > ---
> > >  fs/dax.c |    5 +++--
> > >  1 file changed, 3 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/fs/dax.c b/fs/dax.c
> > > index a71881e77204..08160011d94c 100644
> > > --- a/fs/dax.c
> > > +++ b/fs/dax.c
> > > @@ -221,10 +221,11 @@ static void *get_unlocked_entry(struct xa_state *xas, unsigned int order)
> > >
> > >       for (;;) {
> > >               entry = xas_find_conflict(xas);
> > > +             if (!entry || WARN_ON_ONCE(!xa_is_value(entry)))
> > > +                     return entry;
> > >               if (dax_entry_order(entry) < order)
> > >                       return XA_RETRY_ENTRY;
> > > -             if (!entry || WARN_ON_ONCE(!xa_is_value(entry)) ||
> > > -                             !dax_is_locked(entry))
> > > +             if (!dax_is_locked(entry))
> > >                       return entry;
> >
> > Yes, I think this works.  Should we also add:
> >
> >  static unsigned int dax_entry_order(void *entry)
> >  {
> > +       BUG_ON(!xa_is_value(entry));
> >         if (xa_to_value(entry) & DAX_PMD)
> >                 return PMD_ORDER;
> >         return 0;
> >  }
> >
> > which would have caught this logic error before it caused a performance
> > regression?
>
> Sounds good will add it to v2.

...except that there are multiple dax helpers that have the 'value'
entry assumption. I'd rather do all of them in a separate patch, or
none of them. It turns out that after this change all
dax_entry_order() invocations are now protected by a xa_is_value()
assert earlier in the calling function.
