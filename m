Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CBC3425544
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Oct 2021 16:22:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242045AbhJGOYD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 7 Oct 2021 10:24:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:59199 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242040AbhJGOYC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 7 Oct 2021 10:24:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633616528;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tc7wiOnKCvSSsne5CdSdXHmt3AbH+xCUv5dL5WmNJ5E=;
        b=XFD+zTwK9KxTyKsaqnWHG6tnp48YVvc90rDf8vuP/yYqcxN01KJK2j+3uSC9LzTO1X7lUx
        6J6HrpdR6ngaThJke85g5r/X1vNLfNc11zV36/KhBYTOOvYyCjY7HKqR0aC2h/rkodsHcu
        62LdrPqMM6CiLfPGvjRIZ5RVWGsg1rE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-586-jPjYo6cANNibK9AjlFzikw-1; Thu, 07 Oct 2021 10:21:57 -0400
X-MC-Unique: jPjYo6cANNibK9AjlFzikw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 188B3362FE;
        Thu,  7 Oct 2021 14:21:56 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.22.33.85])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 854A95F4EE;
        Thu,  7 Oct 2021 14:21:32 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 0AC1E2205D6; Thu,  7 Oct 2021 10:21:32 -0400 (EDT)
Date:   Thu, 7 Oct 2021 10:21:31 -0400
From:   Vivek Goyal <vgoyal@redhat.com>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     linux-fsdevel@vger.kernel.org,
        virtio-fs-list <virtio-fs@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Ioannis Angelakopoulos <iangelak@redhat.com>, jaggel@bu.edu,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Subject: Re: [PATCH 7/8] virtiofs: Add new notification type FUSE_NOTIFY_LOCK
Message-ID: <YV8Ca/wP9HDWJITq@redhat.com>
References: <20210930143850.1188628-1-vgoyal@redhat.com>
 <20210930143850.1188628-8-vgoyal@redhat.com>
 <CAJfpegtdftj7jQFu+4LBjysiAJ-hhLHkBC_KhowfJtepvZqaoQ@mail.gmail.com>
 <YV3LBNM3jnGBBzwS@redhat.com>
 <CAJfpegtoNSXFwiiFuU0tczogS6NFqeodLaxcr0Ax5d=dG0-utw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJfpegtoNSXFwiiFuU0tczogS6NFqeodLaxcr0Ax5d=dG0-utw@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Oct 07, 2021 at 03:45:40PM +0200, Miklos Szeredi wrote:
> On Wed, 6 Oct 2021 at 18:13, Vivek Goyal <vgoyal@redhat.com> wrote:
> >
> > On Wed, Oct 06, 2021 at 03:02:36PM +0200, Miklos Szeredi wrote:
> > > On Thu, 30 Sept 2021 at 16:39, Vivek Goyal <vgoyal@redhat.com> wrote:
> > > >
> > > > Add a new notification type FUSE_NOTIFY_LOCK. This notification can be
> > > > sent by file server to signifiy that a previous locking request has
> > > > completed and actual caller should be woken up.
> > >
> > > Shouldn't this also be generic instead of lock specific?
> > >
> > > I.e. generic header  + original outarg.
> >
> > Hi Miklos,
> >
> > I am not sure I understand the idea. Can you please elaborate a bit more.
> >
> > IIUC, "fuse_out_header + original outarg"  is format for responding
> > to regular fuse requests. If we use that it will become like responding
> > to same request twice. First time we responded with ->error=1 so that
> > caller can wait and second time we respond with actual outarg (if
> > there is one depending on the type of request).
> >
> > IOW, this will become more like implementing blocking of request in
> > client in a more generic manner.
> >
> > But outarg, depends on type of request (In case of locking there is
> > none). And outarg memory is allocated by driver and filled by server.
> > In case of notifications, driver is allocating the memory but it
> > does not know what will come in notification and how much memory
> > to allocate. So it relies on device telling it how much memory
> > to allocate in general so that bunch of pre-defined notification
> > types can fit in (fs->notify_buf_size).
> >
> > I modeled this on the same lines as other fuse notifications where
> > server sends notifications with following format.
> >
> > fuse_out_header + <structure based on notification type>
> >
> > out_header->unique is 0 for notifications to differentiate notifications
> > from request reply.
> >
> > out_header->error contains the code of actual notification being sent.
> > ex. FUSE_NOTIFY_INVAL_INODE or FUSE_NOTIFY_LOCK or FUSE_NOTIFY_DELETE.
> > Right now virtiofs supports only one notification type. But in future
> > we can introduce more types (to support inotify stuff etc).
> >
> > In short, I modeled this on existing notion of fuse notifications
> > (and not fuse reply). And given notifications are asynchronous,
> > we don't know what were original outarg. In fact they might
> > be generated not necessarily in response to a request. And that's
> > why this notion of defining a type of notification (FUSE_NOTIFY_LOCK)
> > and then let driver decide how to handle this notification.
> >
> > I might have completely misunderstood your suggestion. Please help
> > me understand.
> 
> Okay, so we are expecting this mechanism to be only used for blocking
> locks.

Yes, as of now it is only being used only for blocking locks. So there
are two parts to it.

A. For a blocking operation, server can reply with error=1, and that's
   a signal to client to wait for a notification to arrive later. And
   fuse client will not complete the request and instead will queue it
   in one of the internal lists.

B. Later server will send a fuse notification event (FUSE_NOTIFY_LOCK)
   when it has acquired the lock. This notification will have unique
   number of request for which this notification has been generated.
   Fuse client will search for the request with expected unique number
   in the list and complete the request.

I think part A is generic in the sense it could be used for other
kind of blocking requests as well down the line, where server is
doing the blocking operation on behalf of client and will send
notification later. Part B is very specific to blocking locks though.

> That makes sense, but then locking ops should be setting a
> flag indicating that this is locking op.  I.e. in fuse_setlk():
> 
>     args.blocking_lock = true;
> 
> And this should be verified when the reply with the positive error comes back.

So this args.blocking_lock, goes to server as well? Or this is something
internal to fuse client so that client can decide whether ->error=1 is
a valid response or not. IOW, client is trying to do verification
whether server should have generated ->error=1 or not for this specific
request.

In case of virtiofs server is trusted entity. So this kind of verification
might be nice to have but not necessary.

Thanks
Vivek

