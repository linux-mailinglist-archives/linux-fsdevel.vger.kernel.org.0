Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1AA9A42548A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Oct 2021 15:45:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241676AbhJGNrr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 7 Oct 2021 09:47:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241693AbhJGNrp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 7 Oct 2021 09:47:45 -0400
Received: from mail-ua1-x92e.google.com (mail-ua1-x92e.google.com [IPv6:2607:f8b0:4864:20::92e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38A66C061570
        for <linux-fsdevel@vger.kernel.org>; Thu,  7 Oct 2021 06:45:52 -0700 (PDT)
Received: by mail-ua1-x92e.google.com with SMTP id h4so4338872uaw.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 07 Oct 2021 06:45:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BHgJ8xR03MQxxuRgsALjQ78eFvupQlvUPGqd6iVHlXY=;
        b=CiaSENkSGvf3h/iY3iy766RE/NeGjpxctbrKVrQA4aWGQV0dGPf1P/Naw0xIBtTftF
         vszL2t8/4Ys5H/fj9sQmFHHQ4jV52FR/xN4lX8PEDZDNnygHiGUzt7siQky1fzu4FzMb
         fbenV/UBvHKoGMHfHzQ1HsBKUKVjQpjoG0GvQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BHgJ8xR03MQxxuRgsALjQ78eFvupQlvUPGqd6iVHlXY=;
        b=MedgyHYxLRsVzFvSVbDG96lOWiJkhJ2iE/fRYyM8PGsdhkgvNrzg7IwZ3yrmj3YWc7
         k+Svqa6rSvu16A9qRkZyFDi2LD4+5hCd40JugIFSBA2zNGHf4FzVMBQg/7e8/mD26Psn
         /JMsZ5L2cKXSk4wovLh+J6sjhYNyHhl2Bvc7Y5DiNVUNs7fWYpKuxCMUDzUyuaGCHlDW
         g0vXXz9KXOR878ncjnNnfk7ytjBniHqA54s5eOrQh/21Fjt4YeWHg1nSBjchsTHEFuRi
         SCBww1BSR5EcQfcPsFXEuDm/280mHDBcxFgCip5aK9uyv6NY2fnPrAk0PP+3BfJYWsi4
         myHw==
X-Gm-Message-State: AOAM531siGV0qWQvuCbCnSgzsNEPWPOiegWQBJF+e4BHEOa3OSm8hzUb
        XlCYRg3GbgeGZC/lxFI+VU/dfDL3iApeJTndyyjPIA==
X-Google-Smtp-Source: ABdhPJzC+EAK1G2KBElEd6FsXcv9jJCgqTnoyt2f2QBiW/QrRz7VWDQ5N6aj2eRDF7o+nYYZr4d34OafuIGfxFATj/A=
X-Received: by 2002:ab0:471d:: with SMTP id h29mr4368965uac.11.1633614351398;
 Thu, 07 Oct 2021 06:45:51 -0700 (PDT)
MIME-Version: 1.0
References: <20210930143850.1188628-1-vgoyal@redhat.com> <20210930143850.1188628-8-vgoyal@redhat.com>
 <CAJfpegtdftj7jQFu+4LBjysiAJ-hhLHkBC_KhowfJtepvZqaoQ@mail.gmail.com> <YV3LBNM3jnGBBzwS@redhat.com>
In-Reply-To: <YV3LBNM3jnGBBzwS@redhat.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Thu, 7 Oct 2021 15:45:40 +0200
Message-ID: <CAJfpegtoNSXFwiiFuU0tczogS6NFqeodLaxcr0Ax5d=dG0-utw@mail.gmail.com>
Subject: Re: [PATCH 7/8] virtiofs: Add new notification type FUSE_NOTIFY_LOCK
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org,
        virtio-fs-list <virtio-fs@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Ioannis Angelakopoulos <iangelak@redhat.com>, jaggel@bu.edu,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 6 Oct 2021 at 18:13, Vivek Goyal <vgoyal@redhat.com> wrote:
>
> On Wed, Oct 06, 2021 at 03:02:36PM +0200, Miklos Szeredi wrote:
> > On Thu, 30 Sept 2021 at 16:39, Vivek Goyal <vgoyal@redhat.com> wrote:
> > >
> > > Add a new notification type FUSE_NOTIFY_LOCK. This notification can be
> > > sent by file server to signifiy that a previous locking request has
> > > completed and actual caller should be woken up.
> >
> > Shouldn't this also be generic instead of lock specific?
> >
> > I.e. generic header  + original outarg.
>
> Hi Miklos,
>
> I am not sure I understand the idea. Can you please elaborate a bit more.
>
> IIUC, "fuse_out_header + original outarg"  is format for responding
> to regular fuse requests. If we use that it will become like responding
> to same request twice. First time we responded with ->error=1 so that
> caller can wait and second time we respond with actual outarg (if
> there is one depending on the type of request).
>
> IOW, this will become more like implementing blocking of request in
> client in a more generic manner.
>
> But outarg, depends on type of request (In case of locking there is
> none). And outarg memory is allocated by driver and filled by server.
> In case of notifications, driver is allocating the memory but it
> does not know what will come in notification and how much memory
> to allocate. So it relies on device telling it how much memory
> to allocate in general so that bunch of pre-defined notification
> types can fit in (fs->notify_buf_size).
>
> I modeled this on the same lines as other fuse notifications where
> server sends notifications with following format.
>
> fuse_out_header + <structure based on notification type>
>
> out_header->unique is 0 for notifications to differentiate notifications
> from request reply.
>
> out_header->error contains the code of actual notification being sent.
> ex. FUSE_NOTIFY_INVAL_INODE or FUSE_NOTIFY_LOCK or FUSE_NOTIFY_DELETE.
> Right now virtiofs supports only one notification type. But in future
> we can introduce more types (to support inotify stuff etc).
>
> In short, I modeled this on existing notion of fuse notifications
> (and not fuse reply). And given notifications are asynchronous,
> we don't know what were original outarg. In fact they might
> be generated not necessarily in response to a request. And that's
> why this notion of defining a type of notification (FUSE_NOTIFY_LOCK)
> and then let driver decide how to handle this notification.
>
> I might have completely misunderstood your suggestion. Please help
> me understand.

Okay, so we are expecting this mechanism to be only used for blocking
locks.  That makes sense, but then locking ops should be setting a
flag indicating that this is locking op.  I.e. in fuse_setlk():

    args.blocking_lock = true;

And this should be verified when the reply with the positive error comes back.

Thanks,
Miklos
