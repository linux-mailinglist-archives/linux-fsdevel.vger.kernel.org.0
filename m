Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC18043B98D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Oct 2021 20:27:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238299AbhJZSaP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 Oct 2021 14:30:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:55216 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236065AbhJZSaL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 26 Oct 2021 14:30:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635272865;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=EscYdYoKFznsl9xa1uV38OQBXXjCOhTbcZL+lFxVyJE=;
        b=Hc7ddk2K+vLatIES6rsj2N/pY/VQiWv01n2li96UlGWC+GlJ3D/e64VXhh31vkwNJk1ahB
        YP5D8YN8vhq9+V6+uS5iKHHroYZdDjAAYA/IAfBAZb6MRxlLDH6qZBUxRfpzLwhAHX7CQ2
        C12BpyuUfLHvlAKbhAgmlnbyscguC/0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-204-Kd3WGJfrP4GBtBfZszVotw-1; Tue, 26 Oct 2021 14:27:44 -0400
X-MC-Unique: Kd3WGJfrP4GBtBfZszVotw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0508B19057A0;
        Tue, 26 Oct 2021 18:27:43 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.22.17.178])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E19E65F4E0;
        Tue, 26 Oct 2021 18:27:39 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 7C2CE2204A5; Tue, 26 Oct 2021 14:27:39 -0400 (EDT)
Date:   Tue, 26 Oct 2021 14:27:39 -0400
From:   Vivek Goyal <vgoyal@redhat.com>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Ioannis Angelakopoulos <iangelak@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        virtio-fs-list <virtio-fs@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Jan Kara <jack@suse.cz>, Al Viro <viro@zeniv.linux.org.uk>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Steve French <sfrench@samba.org>
Subject: Re: [RFC PATCH 0/7] Inotify support in FUSE and virtiofs
Message-ID: <YXhIm3mOvPsueWab@redhat.com>
References: <20211025204634.2517-1-iangelak@redhat.com>
 <CAOQ4uxieK3KpY7pf0YTKcrNHW7rnTATTDZdK9L4Mqy32cDwV8w@mail.gmail.com>
 <YXgqRb21hvYyI69D@redhat.com>
 <CAOQ4uxhpCKK2MYxSmRJYYMEWaHKy5ezyKgxaM+YAKtpjsZkD-g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxhpCKK2MYxSmRJYYMEWaHKy5ezyKgxaM+YAKtpjsZkD-g@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Oct 26, 2021 at 08:59:44PM +0300, Amir Goldstein wrote:
> On Tue, Oct 26, 2021 at 7:18 PM Vivek Goyal <vgoyal@redhat.com> wrote:
> >
> > On Tue, Oct 26, 2021 at 06:23:50PM +0300, Amir Goldstein wrote:
> >
> > [..]
> > > > 3) The lifetime of the local watch in the guest kernel is very
> > > > important. Specifically, there is a possibility that the guest does not
> > > > receive remote events on time, if it removes its local watch on the
> > > > target or deletes the inode (and thus the guest kernel removes the watch).
> > > > In these cases the guest kernel removes the local watch before the
> > > > remote events arrive from the host (virtiofsd) and as such the guest
> > > > kernel drops all the remote events for the target inode (since the
> > > > corresponding local watch does not exist anymore).
> >
> > So this is one of the issues which has been haunting us in virtiofs. If
> > a file is removed, for local events, event is generated first and
> > then watch is removed. But in case of remote filesystems, it is racy.
> > It is possible that by the time event arrives, watch is already gone
> > and application never sees the delete event.
> >
> > Not sure how to address this issue.
> 

> Can you take me through the scenario step by step.
> I am not sure I understand the exact sequence of the race.

Ioannis, please correct me If I get something wrong. You know exact
details much more than me.

A. Say a guest process unlinks a file.
B. Fuse sends an unlink request to server (virtiofsd)
C. File is unlinked on host. Assume there are no other users so inode
   will be freed as well. And event will be generated on host and watch
   removed.
D. Now Fuse server will send a unlink request reply. unlink notification
   might still be in kernel buffers or still be in virtiofsd or could
   be in virtiofs virtqueue.
E. Fuse client will receive unlink reply and remove local watch.

Fuse reply and notification event are now traveling in parallel on
different virtqueues and there is no connection between these two. And
it could very well happen that fuse reply comes first, gets processed
first and local watch is removed. And notification is processed right
after but by then local watch is gone and filesystem will be forced to
drop event.

As of now situation is more complicated in virtiofsd. We don't keep
file handle open for file and keep an O_PATH fd open for each file.
That means in step D above, inode on host is not freed yet and unlink
event is not generated yet. When unlink reply reaches fuse client,
it sends FORGET messages to server, and then server closes O_PATH fd
and then host generates unlink events. By that time its too late,
guest has already remove local watches (and triggered removal of
remote watches too).

This second problem probably can be solved by using file handles, but
basic race will still continue to be there.

> If it is local file removal that causes watch to be removed,
> then don't drop local events and you are good to go.
> Is it something else?

- If remote events are enabled, then idea will be that user space gets
  and event when file is actually removed from server, right? Now it
  is possible that another VM has this file open and file has not been
  yet removed. So local event only tells you that file has been removed
  in guest VM (or locally) but does not tell anything about the state
  of file on server. (It has been unlinked on server but inode continues
  to be alive internall).

- If user receives both local and remote delete event, it will be
  confusing. I guess if we want to see both the events, then there
  has to be some sort of info in event which classifies whether event
  is local or remote. And let application act accordingly.

Thanks
Vivek

