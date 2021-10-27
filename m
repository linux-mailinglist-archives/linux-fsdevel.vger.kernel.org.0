Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9123643D603
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Oct 2021 23:46:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229549AbhJ0Vsf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 27 Oct 2021 17:48:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:31452 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229437AbhJ0Vse (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 27 Oct 2021 17:48:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635371168;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PpY3g+kdd2h/bCGlCR7H75yg2a+8geFMUXDx9cFt3tY=;
        b=dwVsRfEswbDq5QDYVLLUTciuP+FX0VQGXrZ4WrLQVYqwdX304hc/wA2qXwzC6oG4JPqGKf
        c733tDtVhrQb8d9/9JRja+hTBG//RI6npKjGUyHqnVjwa5Dn13UsGotJx8IkVRWsjMFV9E
        7OTnmqE1FIet79WH0HkX2gtP8G4vEro=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-423-wtTguOCmM9K5PjTvdJexfA-1; Wed, 27 Oct 2021 17:46:04 -0400
X-MC-Unique: wtTguOCmM9K5PjTvdJexfA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9204C10A8E00;
        Wed, 27 Oct 2021 21:46:03 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.22.34.10])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C5CBF607CB;
        Wed, 27 Oct 2021 21:46:00 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 554A7220562; Wed, 27 Oct 2021 17:46:00 -0400 (EDT)
Date:   Wed, 27 Oct 2021 17:46:00 -0400
From:   Vivek Goyal <vgoyal@redhat.com>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Ioannis Angelakopoulos <iangelak@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        virtio-fs-list <virtio-fs@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Jan Kara <jack@suse.cz>, Al Viro <viro@zeniv.linux.org.uk>,
        Miklos Szeredi <miklos@szeredi.hu>
Subject: Re: [RFC PATCH 1/7] FUSE: Add the fsnotify opcode and in/out structs
 to FUSE
Message-ID: <YXnImHp1QfZYZ1OU@redhat.com>
References: <20211025204634.2517-1-iangelak@redhat.com>
 <20211025204634.2517-2-iangelak@redhat.com>
 <CAOQ4uxinGYb0QtgE8To5wc2iijT9VpTgDiXEp-9YXz=t_6eMbA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxinGYb0QtgE8To5wc2iijT9VpTgDiXEp-9YXz=t_6eMbA@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Oct 26, 2021 at 05:56:03PM +0300, Amir Goldstein wrote:
> On Mon, Oct 25, 2021 at 11:47 PM Ioannis Angelakopoulos
> <iangelak@redhat.com> wrote:
> >
> > Since fsnotify is the backend for the inotify subsystem all the backend
> > code implementation we add is related to fsnotify.
> >
> > To support an fsnotify request in FUSE and specifically virtiofs we add a
> > new opcode for the FSNOTIFY (51) operation request in the "fuse.h" header.
> >
> > Also add the "fuse_notify_fsnotify_in" and "fuse_notify_fsnotify_out"
> > structs that are responsible for passing the fsnotify/inotify related data
> > to and from the FUSE server.
> >
> > Signed-off-by: Ioannis Angelakopoulos <iangelak@redhat.com>
> > ---
> >  include/uapi/linux/fuse.h | 23 ++++++++++++++++++++++-
> >  1 file changed, 22 insertions(+), 1 deletion(-)
> >
> > diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
> > index 46838551ea84..418b7fc72417 100644
> > --- a/include/uapi/linux/fuse.h
> > +++ b/include/uapi/linux/fuse.h
> > @@ -186,6 +186,9 @@
> >   *  - add FUSE_SYNCFS
> >   *  7.35
> >   *  - add FUSE_NOTIFY_LOCK
> > + *  7.36
> > + *  - add FUSE_HAVE_FSNOTIFY
> > + *  - add fuse_notify_fsnotify_(in,out)
> >   */
> >
> >  #ifndef _LINUX_FUSE_H
> > @@ -221,7 +224,7 @@
> >  #define FUSE_KERNEL_VERSION 7
> >
> >  /** Minor version number of this interface */
> > -#define FUSE_KERNEL_MINOR_VERSION 35
> > +#define FUSE_KERNEL_MINOR_VERSION 36
> >
> >  /** The node ID of the root inode */
> >  #define FUSE_ROOT_ID 1
> > @@ -338,6 +341,7 @@ struct fuse_file_lock {
> >   *                     write/truncate sgid is killed only if file has group
> >   *                     execute permission. (Same as Linux VFS behavior).
> >   * FUSE_SETXATTR_EXT:  Server supports extended struct fuse_setxattr_in
> > + * FUSE_HAVE_FSNOTIFY: remote fsnotify/inotify event subsystem support
> >   */
> >  #define FUSE_ASYNC_READ                (1 << 0)
> >  #define FUSE_POSIX_LOCKS       (1 << 1)
> > @@ -369,6 +373,7 @@ struct fuse_file_lock {
> >  #define FUSE_SUBMOUNTS         (1 << 27)
> >  #define FUSE_HANDLE_KILLPRIV_V2        (1 << 28)
> >  #define FUSE_SETXATTR_EXT      (1 << 29)
> > +#define FUSE_HAVE_FSNOTIFY     (1 << 30)
> >
> >  /**
> >   * CUSE INIT request/reply flags
> > @@ -515,6 +520,7 @@ enum fuse_opcode {
> >         FUSE_SETUPMAPPING       = 48,
> >         FUSE_REMOVEMAPPING      = 49,
> >         FUSE_SYNCFS             = 50,
> > +       FUSE_FSNOTIFY           = 51,
> >
> >         /* CUSE specific operations */
> >         CUSE_INIT               = 4096,
> > @@ -532,6 +538,7 @@ enum fuse_notify_code {
> >         FUSE_NOTIFY_RETRIEVE = 5,
> >         FUSE_NOTIFY_DELETE = 6,
> >         FUSE_NOTIFY_LOCK = 7,
> > +       FUSE_NOTIFY_FSNOTIFY = 8,
> >         FUSE_NOTIFY_CODE_MAX,
> >  };
> >
> > @@ -571,6 +578,20 @@ struct fuse_getattr_in {
> >         uint64_t        fh;
> >  };
> >
> > +struct fuse_notify_fsnotify_out {
> > +       uint64_t inode;
> 
> 64bit inode is not a good unique identifier of the object.

I think he wants to store 64bit nodeid (internal to fuse so that client
and server can figure out which inode they are talking about). But I 
think you are concerned about what happens if an event arrived for an
inode after inode has been released and nodeid possibly used for some
other inode. And then we will find that new inode in guest cache and
end up associating event with wrong inode.

Generation number will help in the sense that server has a chance
to always update generation number on lookup. So even if nodeid
is reused, generation number will make make sure we don't end
up associating this event with reused node id inode. I guess
makes sense.

> you need to either include the generation in object identifier
> or much better use the object's nfs file handle, the same way
> that fanotify stores object identifiers.

I think nfs file handle is much more complicated and its a separate
project altogether. I am assuming we are talking about persistent
nfs file handle as generated by host. I think biggest issue we faced
with that is that guest is untrusted and we don't want to resolve
file handle provided by guest on host otherwise guest can craft
file handles and possibly be able to open other files on same filesystem
outside shared dir. 

> 
> > +       uint64_t mask;
> > +       uint32_t namelen;
> > +       uint32_t cookie;
> 
> I object to persisting with the two-events-joined-by-cookie design.
> Any new design should include a single event for rename
> with information about src and dst.
> 
> I know this is inconvenient, but we are NOT going to create a "remote inotify"
> interface, we need to create a "remote fsnotify" interface and if server wants
> to use inotify, it will need to join the disjoined MOVE_FROM/TO event into
> a single "remote event", that FUSE will use to call fsnotify_move().

man inotify says following.

"       Matching up the IN_MOVED_FROM and IN_MOVED_TO event pair  generated  by
       rename(2)  is thus inherently racy.  (Don't forget that if an object is
       renamed outside of a monitored directory, there  may  not  even  be  an
       IN_MOVED_TO  event.)"

So if guest is no monitoring target dir of renamed file, then we will not
even get IN_MOVED_TO. In that case we can't merge two events into one.

And this sounds like inotify/fanotify interface needs to come up with
an merged event and in that case remote filesystem will simply propagate
that event. (Instead of coming up with a new event only for remote
filesystems. Sounds like this is not a problem limited to remote
filesystems only).

Thanks
Vivek

