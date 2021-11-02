Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D182744375F
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Nov 2021 21:34:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230445AbhKBUhQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 2 Nov 2021 16:37:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:24334 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229813AbhKBUhP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 2 Nov 2021 16:37:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635885279;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DiiRsZdQ8OIlrThW8zEI6oQz9jwKfgzxxMTuP5JA/HE=;
        b=J68120A1fGhErc4fTu8RIpDFyrC+hR/b1CqhUyKyYszvbIP/B389FQWrUUdHQLjqyglhdf
        wmA2NiPaRaDAbGm7cIByH0vqs6lQEnxvVDfDgUqKs3s+iCeVE3HZSPX4Ziui0y5XLoSSp3
        vLwulIwhjL2hUQBy2HZRB08L9o2TUtU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-502-LLPi4ZgsNqyGur4cvw06kA-1; Tue, 02 Nov 2021 16:34:36 -0400
X-MC-Unique: LLPi4ZgsNqyGur4cvw06kA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7B77B9F92D;
        Tue,  2 Nov 2021 20:34:35 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.22.9.72])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2EA525F4F5;
        Tue,  2 Nov 2021 20:34:32 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 9DDA8222F94; Tue,  2 Nov 2021 16:34:31 -0400 (EDT)
Date:   Tue, 2 Nov 2021 16:34:31 -0400
From:   Vivek Goyal <vgoyal@redhat.com>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jan Kara <jack@suse.cz>,
        Ioannis Angelakopoulos <iangelak@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        virtio-fs-list <virtio-fs@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Steve French <sfrench@samba.org>
Subject: Re: [RFC PATCH 0/7] Inotify support in FUSE and virtiofs
Message-ID: <YYGg1w/q31SC3PQ8@redhat.com>
References: <CAOQ4uxieK3KpY7pf0YTKcrNHW7rnTATTDZdK9L4Mqy32cDwV8w@mail.gmail.com>
 <YXgqRb21hvYyI69D@redhat.com>
 <CAOQ4uxhpCKK2MYxSmRJYYMEWaHKy5ezyKgxaM+YAKtpjsZkD-g@mail.gmail.com>
 <YXhIm3mOvPsueWab@redhat.com>
 <CAO17o20sdKAWQN6w7Oe0Ze06qcK+J=6rrmA_aWGnY__MRVDCKw@mail.gmail.com>
 <CAOQ4uxhA+f-GZs-6SwNtSYZvSwfsYz4_=8_tWAUqt9s-49bqLw@mail.gmail.com>
 <20211027132319.GA7873@quack2.suse.cz>
 <YXm2tAMYwFFVR8g/@redhat.com>
 <20211102110931.GD12774@quack2.suse.cz>
 <CAOQ4uxiYQYG8Ta=MNJKpa_0pAPd0MS9PL2r_0ZRD+_TKOw6C7g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxiYQYG8Ta=MNJKpa_0pAPd0MS9PL2r_0ZRD+_TKOw6C7g@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Nov 02, 2021 at 02:54:01PM +0200, Amir Goldstein wrote:
> On Tue, Nov 2, 2021 at 1:09 PM Jan Kara <jack@suse.cz> wrote:
> >
> > On Wed 27-10-21 16:29:40, Vivek Goyal wrote:
> > > On Wed, Oct 27, 2021 at 03:23:19PM +0200, Jan Kara wrote:
> > > > On Wed 27-10-21 08:59:15, Amir Goldstein wrote:
> > > > > On Tue, Oct 26, 2021 at 10:14 PM Ioannis Angelakopoulos
> > > > > <iangelak@redhat.com> wrote:
> > > > > > On Tue, Oct 26, 2021 at 2:27 PM Vivek Goyal <vgoyal@redhat.com> wrote:
> > > > > > The problem here is that the OPEN event might still be travelling towards the guest in the
> > > > > > virtqueues and arrives after the guest has already deleted its local inode.
> > > > > > While the remote event (OPEN) received by the guest is valid, its fsnotify
> > > > > > subsystem will drop it since the local inode is not there.
> > > > > >
> > > > >
> > > > > I have a feeling that we are mixing issues related to shared server
> > > > > and remote fsnotify.
> > > >
> > > > I don't think Ioannis was speaking about shared server case here. I think
> > > > he says that in a simple FUSE remote notification setup we can loose OPEN
> > > > events (or basically any other) if the inode for which the event happens
> > > > gets deleted sufficiently early after the event being generated. That seems
> > > > indeed somewhat unexpected and could be confusing if it happens e.g. for
> > > > some directory operations.
> > >
> > > Hi Jan,
> > >
> > > Agreed. That's what Ioannis is trying to say. That some of the remote events
> > > can be lost if fuse/guest local inode is unlinked. I think problem exists
> > > both for shared and non-shared directory case.
> > >
> > > With local filesystems we have a control that we can first queue up
> > > the event in buffer before we remove local watches. With events travelling
> > > from a remote server, there is no such control/synchronization. It can
> > > very well happen that events got delayed in the communication path
> > > somewhere and local watches went away and now there is no way to
> > > deliver those events to the application.
> >
> > So after thinking for some time about this I have the following question
> > about the architecture of this solution: Why do you actually have local
> > fsnotify watches at all? They seem to cause quite some trouble... I mean
> > cannot we have fsnotify marks only on FUSE server and generate all events
> > there?

I think currently we are already implementing this part of the proposal.
We are sending "group" pointer to server while updating a watch. And server
is managing watches per inode per group. IOW, if client has group1 wanting
mask A and group2 wanting mask B, then server is going to add two watches
with two masks on same inotify fd instance.

Admittedly we did this because we did not know that an aggregate mask
exists. And using an aggregate mask in guest kernel and then server
putting a single watch for that inode based on aggregate mask simplifies
server implementation.

One downside of this approach is more complexity on server. Also more
number of events will be travelling from host to guest. So if two groups
are watching same events on same inode, then I think two copies of
events will travel to guest. One for the group1 and one for group2 (as
we are having separate watches on host). If we use aggregate watch on
host, then only one event can travel between host and guest and I am
assuming same event can be replicated among multiple groups, depending
on their interest.

> When e.g. file is created from the client, client tells the server
> > about creation, the server performs the creation which generates the
> > fsnotify event, that is received by the server and forwared back to the
> > client which just queues it into notification group's queue for userspace
> > to read it.

This is the part we have not implemented. When we generate the event,
we just generate the event for the inode. There is no notion
of that this event has been generated for a specific group with-in
this inode. As of now that's left to the local fsnotify code to manage
and figure out.

So the idea is, that when event arrives from remote, queue it up directly
into the group (without having to worry about inode). Hmm.., how do we do
that. That means we need to return that group identifier in notification
event atleast so that client can find out the group (without having to
worry about inode?).

So group will basically become part of the remote protocol if we were
to go this way. And implementation becomes more complicated.

> >
> > Now with this architecture there's no problem with duplicate events for
> > local & server notification marks,

I guess supressing local events is really trivial. Either we have that
inode flag Amir suggested or have an inode operation to let file system
decide.

> similarly there's no problem with lost
> > events after inode deletion because events received by the client are
> > directly queued into notification queue without any checking whether inode
> > is still alive etc. Would this work or am I missing something?


So when will the watches on remote go away. When a file is unlinked and
inode is going away we call fsnotify_inoderemove(). This generates
FS_DELETE_SELF and then seems to remove all local marks on the inode.

Now if we don't have local marks and guest inode is going away, and client
sends FUSE_FORGET message, I am assuming that will be the time to cleanup
all the remote watches and groups etc. And if file is open by some other
guest, then DELETE_SELF event will not have been generated by then and
we will clean remote watches.

Even if other guest did not have file open, cleanup of remote watches
and DELETE_SELF will be parallel operation and can be racy. So if
thread reading inotify descriptor gets little late in reading DELETE_SELF,
it is possible another thread in virtiofsd cleaned up all remote
watches and associated groups. And now there is no way to send event
back to guest and we lost event?

My understanding of this notification magic is very primitive. So it
is very much possible I am misunderstanding how remote watches and
groups will be managed and reported back. But my current assumption
is that their life time will have to be tied to remote inode we
are managing. Otherwise when will remote server clean its own
internal state (watch descriptors), when inode goes away. 

> >
> 
> What about group #1 that wants mask A and group #2 that wants mask B
> events?
> 
> Do you propose to maintain separate event queues over the protocol?
> Attach a "recipient list" to each event?
> 
> I just don't see how this can scale other than:
> - Local marks and connectors manage the subscriptions on local machine
> - Protocol updates the server with the combined masks for watched objects
> 
> I think that the "post-mortem events" issue could be solved by keeping an
> S_DEAD fuse inode object in limbo just for the mark.
> When a remote server sends FS_IN_IGNORED or FS_DELETE_SELF for
> an inode, the fuse client inode can be finally evicted.

There is no guarantee that FS_IN_IGNORED or FS_DELETE_SELF will come
or when will it come. If another guest has reference on inode it might
not come for a long time. And this will kind of become a mechanism
for one guest to keep other's inode cache full of such objects.

If event queue becomes too full, we might drop these events. But I guess
in that case we will have to generate IN_Q_OVERFLOW and that can somehow
be used to cleanup such S_DEAD inodes?

nodeid is managed by server. So I am assuming that FORGET messages will
not be sent to server for this inode till we have seen FS_IN_IGNORED
and FS_DELETE_SELF events?

Thanks
Vivek

> I haven't tried to see how hard that would be to implement.
> 
> Thanks,
> Amir.
> 

