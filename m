Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8F482CE569
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Dec 2020 02:51:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726134AbgLDBvf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 3 Dec 2020 20:51:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725849AbgLDBvf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 3 Dec 2020 20:51:35 -0500
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCCA4C061A4F
        for <linux-fsdevel@vger.kernel.org>; Thu,  3 Dec 2020 17:50:54 -0800 (PST)
Received: by mail-il1-x132.google.com with SMTP id y9so3855774ilb.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 03 Dec 2020 17:50:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qCJ1it8zJOPA25xd7mTUoE9DDkyV+Z6lS0LOQKBluo0=;
        b=GwHUa4e6QGVNQn8jmCYZFIio42DGHIKmyMsD5pmMyaqtBsI7JoZxtB3sMapUeJRq1U
         QhqrzkxkaX50+svI+uX2/ZWudAVWclOwYnAOz+cvD4uttbcUJ0hxstw8GALFD2bjipTg
         kaB9ndn+nadh92i0oOrfbROPlZiaDuTpVaUAZsDwGqax36P4RPtcY9sbZ1YrxYhACodi
         KKEjxcZtQjMSkqbc1yqas+9eHsAyeLcMkvYMfZtgiKQYy58pR6ZClY1HJni3Q5VT3/eU
         lAE7iy2c93TvyBb5upKyDqXAqHnB6xanzPxjs7AmaMuCaJ/ECYMOfY2pR3nBl7EswnQM
         dN5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qCJ1it8zJOPA25xd7mTUoE9DDkyV+Z6lS0LOQKBluo0=;
        b=NO4skPhbOD8oT1mnBqn+WrCC2/82Y+hAEFwam9Kdt2ZP9DfgakVAeZ85leUaK+S5n8
         GNM0VKTOlsY1h0zOyu1UXdw9RIS0MFtn+6VjKl9dY2xb1ILm06iNItOm88OjnfiHxfWJ
         QJmRZY8UvjyqFRGZyWhe8DLn54dxytu4Ocyhiliodhf9HhMOJWzE69GbkNlr9AGOc7Et
         E66AMi6Z7OxnrVhIDL8EpaJmDTm2gS+nA8OUVNn/ZYcmA5xo7ecOT8OtW6D9YJeS9MGX
         vuUpkOoNlOMD+c9B5aiXGvz7zsYMuQ5+aeJOFkZ+jtckFpUXR1Wb2dV0MJonfKCOjiZN
         Lm5Q==
X-Gm-Message-State: AOAM531+99aJwDjNd/nsaFE8jrEOh5B4VZqyByIAPXXDd0zkSFuwRUAe
        Vx39z+/Xlwjr7ne9rG+LBmoP9Lg2DL9UNgpNbnQ=
X-Google-Smtp-Source: ABdhPJxNOVrY2lOh8aL9bBkX6+LKDEDdxJSpo+BUoWAH3laql3zLcmCNBdDRDFtgVk8HH39l+UrYqK7k8r6H/NkGXSA=
X-Received: by 2002:a92:a115:: with SMTP id v21mr2821782ili.203.1607046654009;
 Thu, 03 Dec 2020 17:50:54 -0800 (PST)
MIME-Version: 1.0
References: <914680.1607004656@warthog.procyon.org.uk> <20201203221202.GA4170059@dread.disaster.area>
 <20201203230541.GL11935@casper.infradead.org>
In-Reply-To: <20201203230541.GL11935@casper.infradead.org>
From:   Yafang Shao <laoar.shao@gmail.com>
Date:   Fri, 4 Dec 2020 09:50:18 +0800
Message-ID: <CALOAHbCW1i=P=NB6z9gb0=20GD_7ymbZ_HVyFj7_O-VxBRjw9A@mail.gmail.com>
Subject: Re: Problems doing DIO to netfs cache on XFS from Ceph
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Dave Chinner <david@fromorbit.com>,
        David Howells <dhowells@redhat.com>,
        Christoph Hellwig <hch@infradead.org>, jlayton@redhat.com,
        Dave Chinner <dchinner@redhat.com>,
        linux-fsdevel@vger.kernel.org, linux-cachefs@redhat.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Dec 4, 2020 at 7:05 AM Matthew Wilcox <willy@infradead.org> wrote:
>
> Might be a good idea to cc Yafang on this ...
>

Thanks

> On Fri, Dec 04, 2020 at 09:12:02AM +1100, Dave Chinner wrote:
> > On Thu, Dec 03, 2020 at 02:10:56PM +0000, David Howells wrote:
> > > Hi Christoph,
> > >
> > > We're having a problem making the fscache/cachefiles rewrite work with XFS, if
> > > you could have a look?  Jeff Layton just tripped the attached warning from
> > > this:
> > >
> > >     /*
> > >      * Given that we do not allow direct reclaim to call us, we should
> > >      * never be called in a recursive filesystem reclaim context.
> > >      */
> > >     if (WARN_ON_ONCE(current->flags & PF_MEMALLOC_NOFS))
> > >             goto redirty;
> >
> > I've pointed out in other threads where issues like this have been
> > raised that this check is not correct and was broken some time ago
> > by the PF_FSTRANS removal. The "NOFS" case here was originally using
> > PF_FSTRANS to protect against recursion from within transaction
> > contexts, not recursion through memory reclaim.  Doing writeback
> > from memory reclaim is caught by the preceeding PF_MEMALLOC check,
> > not this one.
> >
> > What it is supposed to be warning about is that writeback in XFS can
> > start new transactions and nesting transactions is a guaranteed way
> > to deadlock the journal. IOWs, doing writeback from an active
> > transaction context is a bug in XFS.
> >
> > IOWs, we are waiting on a new version of this patchset to be posted:
> >
> > https://lore.kernel.org/linux-xfs/20201103131754.94949-1-laoar.shao@gmail.com/
> >

I will post it soon.

> > so that we can get rid of this from iomap and check the transaction
> > recursion case directly in the XFS code. Then your problem goes away
> > completely....
> >
> > Cheers,
> >
> > Dave.
> > --
> > Dave Chinner
> > david@fromorbit.com



-- 
Thanks
Yafang
