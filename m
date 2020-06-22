Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F9432032ED
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Jun 2020 11:08:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726874AbgFVJIP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 22 Jun 2020 05:08:15 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:37678 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725907AbgFVJIP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 22 Jun 2020 05:08:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592816893;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RCKX5GS7JWN5V5e59N4MpanE/MlwLHSwobXRaeohnIs=;
        b=N1hluJ66vpcPSxGbzcySdZZdGmnnPFXD/tgjMgs3SgE9KLrpqcGt6mttIY8p0Pd42wwJGC
        98EMvSZghcNmQ6Z+yyWLcKY+BZ/zLlU3iru7E0zWyTrw4N1A9gVMzOxUdbUq9PAmfN/pnh
        x7oGwyCB23iNjaAcIbV0go3C8Hj2TSY=
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-294-TTQD_C_rMdmllZ54M7wruA-1; Mon, 22 Jun 2020 05:08:11 -0400
X-MC-Unique: TTQD_C_rMdmllZ54M7wruA-1
Received: by mail-ot1-f70.google.com with SMTP id c2so7841413otb.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 22 Jun 2020 02:08:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RCKX5GS7JWN5V5e59N4MpanE/MlwLHSwobXRaeohnIs=;
        b=a2uADUbk6SU1j6nJVABWE2mp51RGBJ0XwD/eRNOdF/mPJdL1hlpifrJ/7vMAs56QjC
         M/PSgwYCw7vlWAxrknNIPHLhM1yChYvrkFQMz3dg0sip8L8MiqC/xiYY6XB9gfqv6b4K
         vtCghKdu1AHleHYHm4GS790iOta2MtTVlNY+qo0dEQwB5kJ2IWQ174ga4UhYNdBg4cz4
         Pl189ds39ylqKH496jEVJcbMrzF6er08RgzlY7GBvqlZPJMyO/dEa653YeyVhalwrtfR
         OyJru5fXdgg1AgN9feyoyDWbNWXOUeR9MrNaVkSAKvftC/la9KjJzSiopYX9IIfwley/
         lTHA==
X-Gm-Message-State: AOAM531vlnvpbMPNPzJH36hXzpOmOq4K9fcr8EApd4p8leElqubZaRVw
        vNeS50eGrak/htrWpCdFm9N78zB51OhULXGi/Z20JGteUbwO+/Jh3S+8oVoP/7aHG/GbwJad4Ka
        CJUh6Q6/+aoqWvIJXTZOWev8xHV3s2pR/iAaL+MusXg==
X-Received: by 2002:aca:5049:: with SMTP id e70mr12026833oib.72.1592816891188;
        Mon, 22 Jun 2020 02:08:11 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyf1UlkS0QUbrHlpUEpl7yyMoJOq+l/zWCgfs0PQCmZvMH3Mzx49MdVcvg1uxxRhc751A7eZ3hkcs/YxKB3XPU=
X-Received: by 2002:aca:5049:: with SMTP id e70mr12026813oib.72.1592816890888;
 Mon, 22 Jun 2020 02:08:10 -0700 (PDT)
MIME-Version: 1.0
References: <20200618122408.1054092-1-agruenba@redhat.com> <20200619131347.GA22412@infradead.org>
In-Reply-To: <20200619131347.GA22412@infradead.org>
From:   Andreas Gruenbacher <agruenba@redhat.com>
Date:   Mon, 22 Jun 2020 11:07:59 +0200
Message-ID: <CAHc6FU7uKUV-R+qJ9ifLAJkS6aPoG_6qWe7y7wJOb7EbWRL4dQ@mail.gmail.com>
Subject: Re: [PATCH v2] iomap: Make sure iomap_end is called after iomap_begin
To:     Christoph Hellwig <hch@infradead.org>
Cc:     "Darrick J. Wong" <darrick.wong@oracle.com>,
        linux-xfs@vger.kernel.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Bob Peterson <rpeterso@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jun 19, 2020 at 3:25 PM Christoph Hellwig <hch@infradead.org> wrote:
> On Thu, Jun 18, 2020 at 02:24:08PM +0200, Andreas Gruenbacher wrote:
> > Make sure iomap_end is always called when iomap_begin succeeds.
> >
> > Without this fix, iomap_end won't be called when a filesystem's
> > iomap_begin operation returns an invalid mapping, bypassing any
> > unlocking done in iomap_end.  With this fix, the unlocking would
> > at least still happen.
> >
> > This iomap_apply bug was found by Bob Peterson during code review.
> > It's unlikely that such iomap_begin bugs will survive to affect
> > users, so backporting this fix seems unnecessary.
> >
> > Fixes: ae259a9c8593 ("fs: introduce iomap infrastructure")
> > Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
> > ---
> >  fs/iomap/apply.c | 10 ++++++----
> >  1 file changed, 6 insertions(+), 4 deletions(-)
> >
> > diff --git a/fs/iomap/apply.c b/fs/iomap/apply.c
> > index 76925b40b5fd..32daf8cb411c 100644
> > --- a/fs/iomap/apply.c
> > +++ b/fs/iomap/apply.c
> > @@ -46,10 +46,11 @@ iomap_apply(struct inode *inode, loff_t pos, loff_t length, unsigned flags,
> >       ret = ops->iomap_begin(inode, pos, length, flags, &iomap, &srcmap);
> >       if (ret)
> >               return ret;
> > -     if (WARN_ON(iomap.offset > pos))
> > -             return -EIO;
> > -     if (WARN_ON(iomap.length == 0))
> > -             return -EIO;
> > +     if (WARN_ON(iomap.offset > pos) ||
> > +         WARN_ON(iomap.length == 0)) {
> > +             written = -EIO;
> > +             goto out;
> > +     }
>
> As said before please don't merge these for no good reason.

I really didn't expect this tiny patch to require much discussion at
all, but just to be clear ... do you actually object to this very
patch that explicitly doesn't merge the two checks and keeps them on
two separate lines so that the warning messages will report different
line numbers, or are you fine with that?

Thanks,
Andreas

