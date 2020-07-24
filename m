Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80B5B22C729
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Jul 2020 15:58:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726692AbgGXN6C (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Jul 2020 09:58:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726539AbgGXN6B (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Jul 2020 09:58:01 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E242DC0619D3;
        Fri, 24 Jul 2020 06:58:00 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id k20so706561wmi.5;
        Fri, 24 Jul 2020 06:58:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CUhUhKCuy8agxo7tDptaGW+9yrnkDXsJKIUfVuiOOsk=;
        b=TGT15mfNTOTGaL2vs88EXgpQzE9DMiI17s6WLMqXZ8pqC64tIhL23QZ4PTf36/8IrD
         yNSOZ7NBCciligIswVZJKcHbI2m+KRe+O2kVYrkc25S+uPgmoJzcURCBWDw+XN2cDOEm
         zd0dK6e3y4M66CGJ9hn5FPrrUFG/JGRizDdKq4OQWbMh7MnhuJbhi8pB+SCS4NUQZxmv
         //VRw4TBJV9H1gcaNHqcTDLvDS6uIdidimGes4PSYXFXpr0SJfREm/aFyxEJhNWuZX9K
         BJndGBI4F+QebTwnSZw/jkICUzgI9qO4HxqrKpHml9WJil9DPVzScpOVNEVH0MHpv2i6
         Anwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CUhUhKCuy8agxo7tDptaGW+9yrnkDXsJKIUfVuiOOsk=;
        b=fla7Rmm0kEL7W6JH+7QiUB42dEK4wr9q/8TC07wSpAsmdmfhZbjygkUInL3w0ZIfnW
         iDlldsjkqDnCQPihVegyvppqSschKfZHFVh+c7Czai2jm6usPa1haNwkMxKTFv7eyR1I
         SgITj+TV07IVop4DXBqsHIJevBM9pxaA4lFvzgKHqlyPc/UCWrDsQJ0m/MG64ab4TcbF
         NonMGVJDFg/goY8gDtLI5JR0CDk6gFqeZv3xbvN0aBXzq8mplXLzBG3Mx9UqckUSNgk0
         Irpp7jWY1GWWLXoRPL4r1+s3a+EeK8kM+Jk2Q4TELDG4f5+MkwVFPHu3GZbcv8Die2/B
         I9lA==
X-Gm-Message-State: AOAM532zvK9nk2n0F62CeUcRyYigvG1UY3gRhZ8hA7aH9CZup+/A/AGG
        qFx/hF+wT5N73NliBVZTYEe9hXjaYvMtsMpstso=
X-Google-Smtp-Source: ABdhPJzXYsFesSNHLRuxFOcIheC7s7E2FyeJN/nG7rNB42+dgqlSME4YpGtL9el1Ip3s4MqOowe/EHGqQfESz0IfEmw=
X-Received: by 2002:a7b:c841:: with SMTP id c1mr9462849wml.25.1595599079523;
 Fri, 24 Jul 2020 06:57:59 -0700 (PDT)
MIME-Version: 1.0
References: <20200720132118.10934-1-johannes.thumshirn@wdc.com>
 <20200720132118.10934-3-johannes.thumshirn@wdc.com> <20200720134549.GB3342@lst.de>
 <SN4PR0401MB3598A542AA5BC8218C2A78D19B7B0@SN4PR0401MB3598.namprd04.prod.outlook.com>
 <20200721055410.GA18032@infradead.org> <SN4PR0401MB3598536959BFAE08AA8DA8AD9B790@SN4PR0401MB3598.namprd04.prod.outlook.com>
 <20200722145156.GA20266@lst.de>
In-Reply-To: <20200722145156.GA20266@lst.de>
From:   Kanchan Joshi <joshiiitr@gmail.com>
Date:   Fri, 24 Jul 2020 19:27:32 +0530
Message-ID: <CA+1E3rKBH=Pj+Do3p0zv+WPipgZKDLaHr20fb+WqLh55CQ7J6A@mail.gmail.com>
Subject: Re: [PATCH 2/2] zonefs: use zone-append for AIO as well
To:     Christoph Hellwig <hch@lst.de>
Cc:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        "hch@infradead.org" <hch@infradead.org>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jul 22, 2020 at 8:22 PM Christoph Hellwig <hch@lst.de> wrote:
>
> On Wed, Jul 22, 2020 at 12:43:21PM +0000, Johannes Thumshirn wrote:
> > On 21/07/2020 07:54, Christoph Hellwig wrote:
> > > On Mon, Jul 20, 2020 at 04:48:50PM +0000, Johannes Thumshirn wrote:
> > >> On 20/07/2020 15:45, Christoph Hellwig wrote:
> > >>> On Mon, Jul 20, 2020 at 10:21:18PM +0900, Johannes Thumshirn wrote:
> > >>>> On a successful completion, the position the data is written to is
> > >>>> returned via AIO's res2 field to the calling application.
> > >>>
> > >>> That is a major, and except for this changelog, undocumented ABI
> > >>> change.  We had the whole discussion about reporting append results
> > >>> in a few threads and the issues with that in io_uring.  So let's
> > >>> have that discussion there and don't mix it up with how zonefs
> > >>> writes data.  Without that a lot of the boilerplate code should
> > >>> also go away.
> > >>>
> > >>
> > >> OK maybe I didn't remember correctly, but wasn't this all around
> > >> io_uring and how we'd report the location back for raw block device
> > >> access?
> > >
> > > Report the write offset.  The author seems to be hell bent on making
> > > it block device specific, but that is a horrible idea as it is just
> > > as useful for normal file systems (or zonefs).

Patchset only made the feature opt-in, due to the constraints that we
had. ZoneFS was always considered and it fits as fine as block-IO.
You already know that  we did not have enough room in io-uring, which
did not really allow to think of other FS (any-size cached-writes).
After working on multiple schemes in io_uring, now we have 64bits, and
we will return absolute offset in bytes now (in V4).

But still, it comes at the cost of sacrificing the ability to do
short-write, which is fine for zone-append but may trigger
behavior-change for regular file-append.
Write may become short if
- spanning beyond end-of-file
- going beyond RLIMIT_FSIZE limit
- probably for MAX_NON_LFS as well

We need to fail all above cases if we extend the current model for
regular FS. And that may break existing file-append users.
Class of applications which just append without caring about the exact
location - attempt was not to affect these while we try to enable the
path for zone-append.

Patches use O/RWF_APPEND, but try to isolate appending-write
(IOCB_APPEND) from appending-write-that-returns-location
(IOCB_ZONE_APPEND - can be renamed when we actually have all that it
takes to apply the feature in regular FS).
Enabling block-IO and zoneFS now, and keeping regular-FS as future
work - hope that does not sound too bad!

> > After having looked into io_uring I don't this there is anything that
> > prevents io_uring from picking up the write offset from ki_complete's
> > res2 argument. As of now io_uring ignores the filed but that can be
> > changed.

We use ret2 of ki_complete to collect append-offset in io_uring too.
It's just that unlike aio it required some work to send it to user-space.


--
Kanchan Joshi
