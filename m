Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 55754170696
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Feb 2020 18:50:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726787AbgBZRuo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Feb 2020 12:50:44 -0500
Received: from mail-il1-f196.google.com ([209.85.166.196]:42713 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726151AbgBZRuo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Feb 2020 12:50:44 -0500
Received: by mail-il1-f196.google.com with SMTP id x2so3118942ila.9
        for <linux-fsdevel@vger.kernel.org>; Wed, 26 Feb 2020 09:50:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zRHntwf7wB6r4I//h2I2sj6muipFmRMB/JHABjroEKc=;
        b=mxqrlSuZDqTplcYz3FU4w26++Bppw6NVRfVPFrb2L0Y25lQ++dDlTppST2NDmal0Fw
         TwkRflLm8c2yefF4RJg1xf3knyLqFYyAkSzYHDQ0renM5skO5nJVYtASxdg2TN6c0ODQ
         XXCfU4vg1NeLnmF+Q+gXJbDwWxNVZZ9w6yNi7141ipgrs7o+TXLeHNBsB/uMp0E+4D65
         G7EnewfyeYu5z8kynFLPCm4/1kPgPqdJ/seRim6KsJAUGxXLdd7G2ctk1EeSQ18+gMqt
         Q4yap0ZvTQBPa1HdW6/U6/bgXtKsp78gZYlJvdd1GwRr6QPIwCqvjnKZ09RErR5i6nc/
         lRrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zRHntwf7wB6r4I//h2I2sj6muipFmRMB/JHABjroEKc=;
        b=Rl+pbyEp8Slp0Q8n+DriCLmk6J7BJIwUxFtfAqYbHBOOyrOCDnYa/RrrFw3MITqVnO
         9rdliErt2i9Ibj2D49NFpxQ7Z4mXZRaM6rGtTYvjaZrllwL4SQCHc9ItNMgsps/ns8mM
         G3nEwA5MsiftiYrdLF37B0+eqMHOu2yjzzAkFFJncQ9+yBlMELW28FVD7Tb7bzI8v6+N
         1SICkdw4LkoE/q/v9mc9cIlCTqwPwcE29oW4f+IOWikmh591c658tMCp59HcRdrbKonC
         TeBLBbX4BwI2UPr0fJnz48JaMnS+CGgDs72CyT0A1bTu79wmVmb21bmwWf/y7X5IJg1o
         9Nbg==
X-Gm-Message-State: APjAAAUFmqIVsDalSNSYETbH4fBYIaJk8eNhuzgDSE1idgMKJ7gFDfTd
        DVMO8vmeCBPYJOuzn9ynqlomdgnf31SVlFVRhyX069P9
X-Google-Smtp-Source: APXvYqw6B9239Nk4lk6+GRdCr4BFnwzCHgO357n9m3ealLmhJM7s41C+8fZyU6RF+n6y1fJ2gQOft20fpR3pRX4MrdU=
X-Received: by 2002:a92:6f10:: with SMTP id k16mr157075ilc.275.1582739442068;
 Wed, 26 Feb 2020 09:50:42 -0800 (PST)
MIME-Version: 1.0
References: <20200217131455.31107-1-amir73il@gmail.com> <20200217131455.31107-12-amir73il@gmail.com>
 <20200226102354.GE10728@quack2.suse.cz> <CAOQ4uxivfnmvXag8+f5wJujqRgp9FW+2_CVD6MSgB40_yb+sHw@mail.gmail.com>
 <20200226170705.GU10728@quack2.suse.cz>
In-Reply-To: <20200226170705.GU10728@quack2.suse.cz>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Wed, 26 Feb 2020 19:50:30 +0200
Message-ID: <CAOQ4uxgW9Jcj_hG639nw=j0rFQ1fGxBHJJz=nHKTPBat=L+mXg@mail.gmail.com>
Subject: Re: [PATCH v2 11/16] fanotify: prepare to encode both parent and
 child fid's
To:     Jan Kara <jack@suse.cz>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Feb 26, 2020 at 7:07 PM Jan Kara <jack@suse.cz> wrote:
>
> On Wed 26-02-20 13:53:06, Amir Goldstein wrote:
> > On Wed, Feb 26, 2020 at 12:23 PM Jan Kara <jack@suse.cz> wrote:
> > >
> > > > +     __kernel_fsid_t fsid;
> > > >       union {
> > > >               /*
> > > >                * We hold ref to this path so it may be dereferenced at any
> > >
> > > Here I disagree. IMO 'fsid' should be still part of the union below because
> > > the "object identification" is either struct path or (fsid + fh). I
> > > understand that you want to reuse fsid for the other file handle. But then
> > > I believe it should rather be done like:
> > >
> > > struct fanotify_fh {
> > >         union {
> > >                 unsigned char fh[FANOTIFY_INLINE_FH_LEN];
> > >                 unsigned char *ext_fh;
> > >         };
> > > };
> > >
> >
> > This I will do.
> >
> > > struct fanotify_fid {
> > >         __kernel_fsid_t fsid;
> > >         struct fanotify_fh object;
> > >         struct fanotify_fh dir;
> > > }
> > >
> >
> > object and dir do not end up in the same struct.
>
> Right, ok.
>
> > object is in fanotify_event
> > dir is in the extended fanotify_name_event, but I can do:
> >
> > struct fanotify_fid {
> >         __kernel_fsid_t fsid;
> >         struct fanotify_fh fh;
> > }
> >
> >  struct fanotify_event {
> >         struct fsnotify_event fse;
> >         u32 mask;
> >         struct fanotify_fid_hdr fh;
> >         struct fanotify_fid_hdr dfh;
> >         union {
> >                 struct path path;
> >                 struct fanotify_fid object;
> >         };
> >         struct pid *pid;
> > };
> >
> > struct fanotify_name_event {
> >         struct fanotify_event fae;
> >         struct fanotify_fh  dir;
> >         struct qstr name;
> >         unsigned char inline_name[FANOTIFY_INLINE_NAME_LEN];
> > };
>
> Looking at this I'm not quite happy either :-| E.g. 'dfh' contents here
> somewhat magically tells that this is not fanotify_event but
> fanotify_name_event. Also I agree that fsid hidden in 'object' is not ideal
> although I still dislike having it directly in fanotify_event as for path
> events it will not be filled and that can lead to confusion.
>
> I understand this is so convoluted because there are several constraints:
> 1) We don't want to grow event size unnecessarily.
> 2) We prefer allocating from dedicated slab cache
> 3) We have events of several types needing to store different kind of
> information.
>
> But seeing how things evolve I think we should consider relaxing some of
> the constraints to make the code easier to follow. How about having
> something like:
>
> struct fanotify_event {
>         struct fsnotify_event fse;
>         u32 mask;
>         enum fanotify_event_type type;
>         struct pid *pid;
> };
>
> where type would identify what kind of event we have. Then we would have
>
> struct fanotify_path_event {
>         struct fanotify_event fae;
>         struct path path;
> };
>
> struct fanotify_perm_path_event {
>         struct fanotify_event fae;
>         struct path path;

Any reason not to "inherit" from fanotify_path_event?
There is code that is generic to permission and non-permission path
events that accesses event->path and I wouldn't
want to make that code two cases instead of just one.


>         unsigned short response;
>         unsigned short state;
>         int fd;
> };
>
> struct fanotify_fh {
>         u8 type;
>         u8 len;

That's a 6 bytes hole! and then there are two of those
in object_fh and dir_fh.
That is why I stored the header in separate from the fh itself
so that two headers could pack up nicely and yes,
I also used the headers as an event type indication.

>         union {
>                 unsigned char fh[FANOTIFY_INLINE_FH_LEN];
>                 unsigned char *ext_fh;
>         };
> };
>
> struct fanotify_fid_event {
>         struct fanotify_event fae;
>         __kernel_fsid_t fsid;
>         struct fanotify_fh object_fh;
> };
>
> struct fanofify_name_event {
>         struct fanotify_event fae;
>         __kernel_fsid_t fsid;
>         struct fanotify_fh object_fh;

Again, any reason not to "inherit" from fanotify_fid_event?
There is plenty of code that is common to fid and name events
because name events are also fid events.

>         struct fanotify_fh dir_fh;
>         u8 name_len;
>         char name[0];
> };
>
> WRT size, this would grow fanotify_fid_event by 1 long on 64-bits,
> fanotify_path_event would be actually smaller by 1 long, fanofify_name_event
> would be smaller but that's not really comparable because you chose a
> solution with fixed-inline length while I'd just go with allocating from
> kmalloc when we have to store the name.

OK. Same an inotify.
I guess I started with the name_snapshot thing that was really fixed-size
event and then reused the same construct without the snapshot, but I
guess we can do away with the inline name.

>
> In terms of kmalloc caches, we would need three: for path, perm_path, fid
> events, I'd allocate name events from generic kmalloc caches.
>
> So overall I think this would be better. The question is whether the
> resulting code will really be more readable. I hope so because the
> structures are definitely nicer this way and things belonging logically
> together are now together. But you never know until you convert the code...
> Would you be willing to try this refactoring?

Yes, but I would like to know what you think about the two 6 byte holes
Just let that space be wasted for the sake of nicer abstraction?
It seems like too much to me.

Thanks,
Amir.
