Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C915204B67
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Jun 2020 09:41:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731246AbgFWHla (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 Jun 2020 03:41:30 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:32228 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1731227AbgFWHl3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 Jun 2020 03:41:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592898088;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kANMhVOVTkewDfS+wze7GKWDAqJzYtfvX0eoCKjfpM4=;
        b=MWu64jiNxPsqzmYF+W8QwiTeLJGnrqLtlBwx0WUE753YBmCGTf/XyJPmEEREivuAwJnDTH
        Yu+SqjYRIniu+yfkLcWD1g4Swkrx8CqKV/waEdovAq0b4tBWvOla/3S6SR90sNE7GgwObz
        pAun7osbRHXfXIpnABUI9ljqhhPDvwM=
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com
 [209.85.210.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-191-xQkPl2hbOcqh_7I2m_4_tw-1; Tue, 23 Jun 2020 03:41:26 -0400
X-MC-Unique: xQkPl2hbOcqh_7I2m_4_tw-1
Received: by mail-ot1-f69.google.com with SMTP id t10so9841741otl.19
        for <linux-fsdevel@vger.kernel.org>; Tue, 23 Jun 2020 00:41:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kANMhVOVTkewDfS+wze7GKWDAqJzYtfvX0eoCKjfpM4=;
        b=uUJmmQLRdppu0MZhhLhMJdXRQfny/jpa9iwJNBc2Ecah0ewGBnwFjViF6sOukH2peH
         Q9ETueZzwolT+DJ3IegEXE02WB3/9R69MrvrwfSY+akWP7F0fUFb4CSIgJG9uhAU7g3N
         DdnKo//Eac/E5obYWU+SJKzygYfR5LSgmuBHOt0Svz18lrz/FQdgjigAZTQIARmsfUWa
         Oa+WljUOCZV8zBuwLvbHKa/arc7jpUbhC6zd/amc+FN6c0PAayTB7qUgTFeDJVmAh847
         x8hxWiopR4McGOWbe3D2nOKuB2+yOu2QWSYiFBsAwdJwv698MOLzjkdT/MdmakZtnzTc
         nd3g==
X-Gm-Message-State: AOAM530m9ImIDJL1vgILGCDyj2BUpiWxTeiX5LqW+KUwvWRhuMEd6DNn
        9CO9E3LFyhH6ww4AS7p42aOpt0gIfQ4WjGap/0XCodBT2GZiX81fw6FWMF7jwMPrYGEvAvI9ajw
        vhXyMySfONVl/rXZ/LTVHQCjFj074fb1r1xht/ZTZeQ==
X-Received: by 2002:aca:5049:: with SMTP id e70mr15806171oib.72.1592898085712;
        Tue, 23 Jun 2020 00:41:25 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxvT6etI273O3836DUQF/ve/uxCrBhp8TObCS3rPpRZkC9DlVwAUGbt/aCSwt2x93cFLClNeboKKcK+g/zgNg8=
X-Received: by 2002:aca:5049:: with SMTP id e70mr15806157oib.72.1592898085470;
 Tue, 23 Jun 2020 00:41:25 -0700 (PDT)
MIME-Version: 1.0
References: <20200619155036.GZ8681@bombadil.infradead.org> <20200622003215.GC2040@dread.disaster.area>
 <CAHc6FU4b_z+vhjVPmaU46VhqoD+Y7jLN3=BRDZPrS2v=_pVpfw@mail.gmail.com> <20200623005218.GF2040@dread.disaster.area>
In-Reply-To: <20200623005218.GF2040@dread.disaster.area>
From:   Andreas Gruenbacher <agruenba@redhat.com>
Date:   Tue, 23 Jun 2020 09:41:13 +0200
Message-ID: <CAHc6FU7KgYJsEGy_BCUB2Akvgrn7NMKyrGpcFe2iCb02wjNK3Q@mail.gmail.com>
Subject: Re: [RFC] Bypass filesystems for reading cached pages
To:     Dave Chinner <david@fromorbit.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 23, 2020 at 2:52 AM Dave Chinner <david@fromorbit.com> wrote:
> On Mon, Jun 22, 2020 at 04:35:05PM +0200, Andreas Gruenbacher wrote:
> > On Mon, Jun 22, 2020 at 2:32 AM Dave Chinner <david@fromorbit.com> wrote:
> > > On Fri, Jun 19, 2020 at 08:50:36AM -0700, Matthew Wilcox wrote:
> > > >
> > > > This patch lifts the IOCB_CACHED idea expressed by Andreas to the VFS.
> > > > The advantage of this patch is that we can avoid taking any filesystem
> > > > lock, as long as the pages being accessed are in the cache (and we don't
> > > > need to readahead any pages into the cache).  We also avoid an indirect
> > > > function call in these cases.
> > >
> > > What does this micro-optimisation actually gain us except for more
> > > complexity in the IO path?
> > >
> > > i.e. if a filesystem lock has such massive overhead that it slows
> > > down the cached readahead path in production workloads, then that's
> > > something the filesystem needs to address, not unconditionally
> > > bypass the filesystem before the IO gets anywhere near it.
> >
> > I'm fine with not moving that functionality into the VFS. The problem
> > I have in gfs2 is that taking glocks is really expensive. Part of that
> > overhead is accidental, but we definitely won't be able to fix it in
> > the short term. So something like the IOCB_CACHED flag that prevents
> > generic_file_read_iter from issuing readahead I/O would save the day
> > for us. Does that idea stand a chance?
>
> I have no problem with a "NOREADAHEAD" flag being passed to
> generic_file_read_iter(). It's not a "already cached" flag though,
> it's a "don't start any IO" directive, just like the NOWAIT flag is
> a "don't block on locks or IO in progress" directive and not an
> "already cached" flag. Readahead is something we should be doing,
> unless a filesystem has a very good reason not to, such as the gfs2
> locking case here...

The requests coming in can have the IOCB_NOWAIT flag set or cleared.
The idea was to have an additional flag that implies IOCB_NOWAIT so
that you can do:

    iocb->ki_flags |= IOCB_NOIO;
    generic_file_read_iter()
    if ("failed because of IOCB_NOIO") {
        if ("failed because of IOCB_NOWAIT")
            return -EAGAIN;
        iocb->ki_flags &= ~IOCB_NOIO;
        "locking"
         generic_file_read_iter()
        "unlocking"
    }

without having to save iocb->ki_flags. The alternative would be:

    int flags = iocb->ki_flags;
    iocb->ki_flags |= IOCB_NOIO | IOCB_NOWAIT;
    ret = generic_file_read_iter()
    if ("failed because of IOCB_NOIO or IOCB_NOWAIT") {
        if ("failed because of IOCB_NOWAIT" && (flags & IOCB_NOWAIT))
            return -EAGAIN;
        iocb->ki_flags &= ~IOCB_NOIO;
        "locking"
         generic_file_read_iter()
        "unlocking"
    }

Andreas

