Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C4AA425B1E
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Oct 2021 20:46:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243788AbhJGSsS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 7 Oct 2021 14:48:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243763AbhJGSsR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 7 Oct 2021 14:48:17 -0400
Received: from mail-vs1-xe34.google.com (mail-vs1-xe34.google.com [IPv6:2607:f8b0:4864:20::e34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B7F5C061570
        for <linux-fsdevel@vger.kernel.org>; Thu,  7 Oct 2021 11:46:23 -0700 (PDT)
Received: by mail-vs1-xe34.google.com with SMTP id l22so5392729vsq.9
        for <linux-fsdevel@vger.kernel.org>; Thu, 07 Oct 2021 11:46:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PuYqO/zJtQOmgXw2qiQOgqREvWNqtpex61JFiCc79Ko=;
        b=CCe9Q+Wzt/QEv9979yejyS0tWuJH+dcvGtBBW1bYtkVqjeObvjvXAzy4XCUc1dHK6H
         25jiPL/FjQlKqZKH51ekonjY7Pk4eccOYYyuN+5i0GhVq1k8DYIt5yvfrkjwqiN1egX8
         yBDLwKlo3HbldtdGWxmZIQ61rc9kSwZ+1NdB8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PuYqO/zJtQOmgXw2qiQOgqREvWNqtpex61JFiCc79Ko=;
        b=rM9O/0isyP2WJgYZgXYt/vCWZhHeiIUp8l3wk+NqNr0cbilYFzEiXWk1UEx47n2fvr
         Fjqk7jAstl6Lpq7Is4ToX5HewjraESMDmTBPkYYsYBzPDVf+9ubKz11Jnsfd9yJ4d/er
         eXGnqe+PcAxr8OB8LxjQTVAbv0xUYzmnIY6XkFIkqgQCoTKwLb1j60ygf+/31LAf5Wn1
         sIDj8p+aMSiKvv/rzmkSRX7NZ7N/x1u/I0EksAg0jiyxzlptyzyCK+y2r8qlPhHZ3Hlt
         lyH66F82pS/EpXrmDk8/KAKgIvrqNcoU0u3v/Hd/TQRyYE2CB5A4X0xPAmSweAGRqHMu
         dPKw==
X-Gm-Message-State: AOAM530LwWUBD2ari3pGxq+Il/Z+4L/f+Mmes0VMd4XWgPUfRmckr816
        vI0cfsx3cZCZjSlKSaBtg/PKliaprRQK0nLj9F5z0kCYuY0=
X-Google-Smtp-Source: ABdhPJwTaCP56bvX5M9hgOW7LlXFaa8+v54Biywnns5l2vYzpD3LjttZaKzFay3q8jUHNyKP96qcaTz0f8DVSD3tbjc=
X-Received: by 2002:a67:c284:: with SMTP id k4mr6317059vsj.24.1633632382129;
 Thu, 07 Oct 2021 11:46:22 -0700 (PDT)
MIME-Version: 1.0
References: <20210930143850.1188628-1-vgoyal@redhat.com> <20210930143850.1188628-8-vgoyal@redhat.com>
 <CAJfpegtdftj7jQFu+4LBjysiAJ-hhLHkBC_KhowfJtepvZqaoQ@mail.gmail.com>
 <YV3LBNM3jnGBBzwS@redhat.com> <CAJfpegtoNSXFwiiFuU0tczogS6NFqeodLaxcr0Ax5d=dG0-utw@mail.gmail.com>
 <YV8Ca/wP9HDWJITq@redhat.com> <CAJfpegsguYZ3y5G6Rj4hoxEOn2ObnUVajTVhtyvm4ZSeFqGtFw@mail.gmail.com>
 <YV89S46OMGOVN8zZ@redhat.com>
In-Reply-To: <YV89S46OMGOVN8zZ@redhat.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Thu, 7 Oct 2021 20:46:11 +0200
Message-ID: <CAJfpegsWP7G=PQQRfVnB0kBup9qnOrZBx4VJ+4X1r5u-yqoneQ@mail.gmail.com>
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

On Thu, 7 Oct 2021 at 20:32, Vivek Goyal <vgoyal@redhat.com> wrote:
>
> On Thu, Oct 07, 2021 at 08:11:13PM +0200, Miklos Szeredi wrote:
> > On Thu, 7 Oct 2021 at 16:22, Vivek Goyal <vgoyal@redhat.com> wrote:
> > >
> > > On Thu, Oct 07, 2021 at 03:45:40PM +0200, Miklos Szeredi wrote:
> > > > On Wed, 6 Oct 2021 at 18:13, Vivek Goyal <vgoyal@redhat.com> wrote:
> > > > >
> > > > > On Wed, Oct 06, 2021 at 03:02:36PM +0200, Miklos Szeredi wrote:
> > > > > > On Thu, 30 Sept 2021 at 16:39, Vivek Goyal <vgoyal@redhat.com> wrote:
> > > > > > >
> > > > > > > Add a new notification type FUSE_NOTIFY_LOCK. This notification can be
> > > > > > > sent by file server to signifiy that a previous locking request has
> > > > > > > completed and actual caller should be woken up.
> > > > > >
> > > > > > Shouldn't this also be generic instead of lock specific?
> > > > > >
> > > > > > I.e. generic header  + original outarg.
> > > > >
> > > > > Hi Miklos,
> > > > >
> > > > > I am not sure I understand the idea. Can you please elaborate a bit more.
> > > > >
> > > > > IIUC, "fuse_out_header + original outarg"  is format for responding
> > > > > to regular fuse requests. If we use that it will become like responding
> > > > > to same request twice. First time we responded with ->error=1 so that
> > > > > caller can wait and second time we respond with actual outarg (if
> > > > > there is one depending on the type of request).
> > > > >
> > > > > IOW, this will become more like implementing blocking of request in
> > > > > client in a more generic manner.
> > > > >
> > > > > But outarg, depends on type of request (In case of locking there is
> > > > > none). And outarg memory is allocated by driver and filled by server.
> > > > > In case of notifications, driver is allocating the memory but it
> > > > > does not know what will come in notification and how much memory
> > > > > to allocate. So it relies on device telling it how much memory
> > > > > to allocate in general so that bunch of pre-defined notification
> > > > > types can fit in (fs->notify_buf_size).
> > > > >
> > > > > I modeled this on the same lines as other fuse notifications where
> > > > > server sends notifications with following format.
> > > > >
> > > > > fuse_out_header + <structure based on notification type>
> > > > >
> > > > > out_header->unique is 0 for notifications to differentiate notifications
> > > > > from request reply.
> > > > >
> > > > > out_header->error contains the code of actual notification being sent.
> > > > > ex. FUSE_NOTIFY_INVAL_INODE or FUSE_NOTIFY_LOCK or FUSE_NOTIFY_DELETE.
> > > > > Right now virtiofs supports only one notification type. But in future
> > > > > we can introduce more types (to support inotify stuff etc).
> > > > >
> > > > > In short, I modeled this on existing notion of fuse notifications
> > > > > (and not fuse reply). And given notifications are asynchronous,
> > > > > we don't know what were original outarg. In fact they might
> > > > > be generated not necessarily in response to a request. And that's
> > > > > why this notion of defining a type of notification (FUSE_NOTIFY_LOCK)
> > > > > and then let driver decide how to handle this notification.
> > > > >
> > > > > I might have completely misunderstood your suggestion. Please help
> > > > > me understand.
> > > >
> > > > Okay, so we are expecting this mechanism to be only used for blocking
> > > > locks.
> > >
> > > Yes, as of now it is only being used only for blocking locks. So there
> > > are two parts to it.
> > >
> > > A. For a blocking operation, server can reply with error=1, and that's
> > >    a signal to client to wait for a notification to arrive later. And
> > >    fuse client will not complete the request and instead will queue it
> > >    in one of the internal lists.
> > >
> > > B. Later server will send a fuse notification event (FUSE_NOTIFY_LOCK)
> > >    when it has acquired the lock. This notification will have unique
> > >    number of request for which this notification has been generated.
> > >    Fuse client will search for the request with expected unique number
> > >    in the list and complete the request.
> > >
> > > I think part A is generic in the sense it could be used for other
> > > kind of blocking requests as well down the line, where server is
> > > doing the blocking operation on behalf of client and will send
> > > notification later. Part B is very specific to blocking locks though.
> >
> > I don't really get why B is specific to blocking locks. But anyway...
> > we are only implementing it for blocking locks for now.
>
> Hmm.., I am wondering do I have to make notification specific to
> lock. All it is doing is returning an "error" code which signifies
> either operation completed successfully or represents error code
> if error occurred.
>
> This probably could be more generic. May be I can call this
> notification FUSE_NOTIFY_OP_COMPLETE. This notification is
> just signalling that a previously issued request has completed.
> Request is identified by notify->unique and result of blocking operation
> is in notify->error. So that way it is more generic and can be
> used for other kind of operations too (and not just locking).

That's exactly what I was thinking.   The implementation can remain
the same for now...

Thanks,
Miklos
