Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9E961F9206
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Jun 2020 10:45:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729031AbgFOIpL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 15 Jun 2020 04:45:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728746AbgFOIpK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 15 Jun 2020 04:45:10 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05B63C05BD43
        for <linux-fsdevel@vger.kernel.org>; Mon, 15 Jun 2020 01:45:09 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id x93so10875010ede.9
        for <linux-fsdevel@vger.kernel.org>; Mon, 15 Jun 2020 01:45:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OXy80G/QuWlMsF/9ZGjBxujaTTvUrmfWIzv9XF+RHas=;
        b=mb5wlVjn0ratQKJ42h3GHcIVlDnVaMT+Y0sd3By4do/QOYmPV7Aq+Y2zatzsI7SOrn
         uhkPX6n2/5cxQmCMLpHxsYCjwN+0ROujisKn33HA1NeF+zxYT/qIyuzyaqX7GXK3x8+e
         OxQ+ScFLCE+B8bFFPL0VH/0VJEF8kb46qelzU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OXy80G/QuWlMsF/9ZGjBxujaTTvUrmfWIzv9XF+RHas=;
        b=m1C0cE5tnGC+wLtxDBEgfUGMKxHfCknKJ0oDxa6sAG570ykJY03B7NDRlyJax3cPC/
         m2DCUcz6ReIKnRtXPXN/jgjptaUZD56qtyagTR+r80o2OC1kjf7dH6CBLu7jQAIvobia
         Eiie4ExLzc43QElgyTjm6Uo7xdiyXmdNXtySpfGPrihpHoidhZd5j3zsacYOPT0Gxoyi
         RzJBMVXRANrBsj/iCz+f0IfDsd6VAjgoM1qm+oyl9lqQ7s6EVVwlIkPXJKXtbNNpn0KB
         9h3em4R5MDrP+MUZp+v1AKq6kBJics/1Siaw2iiEHfDo17BhYvNRlk6uLrAjbvLr3YdV
         sgrg==
X-Gm-Message-State: AOAM531qeWo6wfoCUIwHQvzoENNSMcigV9LjHCLZ8YlQtq2VW+mvVgNp
        PBOTP7UJG90h0K0F3wT2oUNsoMgYrc+1/v+5pcaX1w==
X-Google-Smtp-Source: ABdhPJyO4Zt3HWq71S+Z2BgNwO3mxs8JAJdgIAdXB02awF1aP6ubx5B2i1EercDpoimnNHKzSTYdhNfWuV8yG31tLAk=
X-Received: by 2002:a50:d785:: with SMTP id w5mr22207839edi.212.1592210708330;
 Mon, 15 Jun 2020 01:45:08 -0700 (PDT)
MIME-Version: 1.0
References: <158454378820.2863966.10496767254293183123.stgit@warthog.procyon.org.uk>
 <158454391302.2863966.1884682840541676280.stgit@warthog.procyon.org.uk>
 <CAJfpegspWA6oUtdcYvYF=3fij=Bnq03b8VMbU9RNMKc+zzjbag@mail.gmail.com> <0991792b6e2af0a5cc1a2c2257b535b5e6b032e4.camel@themaw.net>
In-Reply-To: <0991792b6e2af0a5cc1a2c2257b535b5e6b032e4.camel@themaw.net>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Mon, 15 Jun 2020 10:44:57 +0200
Message-ID: <CAJfpeguZuCTmCWf-mF3=iZQeaaUYRoCRU9wcyz_gCMD94-bFFQ@mail.gmail.com>
Subject: Re: [PATCH 13/17] watch_queue: Implement mount topology and attribute
 change notifications [ver #5]
To:     Ian Kent <raven@themaw.net>
Cc:     David Howells <dhowells@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Nicolas Dichtel <nicolas.dichtel@6wind.com>,
        Christian Brauner <christian@brauner.io>, andres@anarazel.de,
        Jeff Layton <jlayton@redhat.com>, dray@redhat.com,
        Karel Zak <kzak@redhat.com>, keyrings@vger.kernel.org,
        Linux API <linux-api@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org,
        LSM <linux-security-module@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Jun 14, 2020 at 5:07 AM Ian Kent <raven@themaw.net> wrote:
>
> On Thu, 2020-04-02 at 17:19 +0200, Miklos Szeredi wrote:
> >
> > > Firstly, a watch queue needs to be created:
> > >
> > >         pipe2(fds, O_NOTIFICATION_PIPE);
> > >         ioctl(fds[1], IOC_WATCH_QUEUE_SET_SIZE, 256);
> > >
> > > then a notification can be set up to report notifications via that
> > > queue:
> > >
> > >         struct watch_notification_filter filter = {
> > >                 .nr_filters = 1,
> > >                 .filters = {
> > >                         [0] = {
> > >                                 .type = WATCH_TYPE_MOUNT_NOTIFY,
> > >                                 .subtype_filter[0] = UINT_MAX,
> > >                         },
> > >                 },
> > >         };
> > >         ioctl(fds[1], IOC_WATCH_QUEUE_SET_FILTER, &filter);
> > >         watch_mount(AT_FDCWD, "/", 0, fds[1], 0x02);
> > >
> > > In this case, it would let me monitor the mount topology subtree
> > > rooted at
> > > "/" for events.  Mount notifications propagate up the tree towards
> > > the
> > > root, so a watch will catch all of the events happening in the
> > > subtree
> > > rooted at the watch.
> >
> > Does it make sense to watch a single mount?  A set of mounts?   A
> > subtree with an exclusion list (subtrees, types, ???)?
>
> Yes, filtering, perhaps, I'm not sure a single mount is useful
> as changes generally need to be monitored for a set of mounts.
>
> Monitoring a subtree is obviously possible because the monitor
> path doesn't need to be "/".
>
> Or am I misunderstanding what your trying to get at.
>
> The notion of filtering types and other things is interesting
> but what I've seen that doesn't fit in the current implementation
> so far probably isn't appropriate for kernel implementation.
>
> There's a special case of acquiring a list of mounts where the
> path is not a mount point itself but you need all mount below
> that path prefix.
>
> In this case you get all mounts, including the mounts of the mount
> containing the path, so you still need to traverse the list to match
> the prefix and that can easily mean the whole list of mounts in the
> system.
>
> Point is it leads to multiple traversals of a larger than needed list
> of mounts, one to get the list of mounts to check, and one to filter
> on the prefix.
>
> I've seen this use case with fsinfo() and that's where it's needed
> although it may be useful to carry it through to notifications as
> well.
>
> While this sounds like it isn't such a big deal it can sometimes
> make a considerable difference to the number of mounts you need
> to traverse when there are a large number of mounts in the system.
>
> I didn't consider it appropriate for kernel implementation but
> since you asked here it is. OTOH were checking for connectedness
> in fsinfo() anyway so maybe this is something that could be done
> without undue overhead.

Good point.  Filtering notifications for mounts outside of the
specified path makes sense.

Thanks,
Miklos
