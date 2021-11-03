Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A240D443FDA
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Nov 2021 11:09:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231623AbhKCKLi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 3 Nov 2021 06:11:38 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:40820 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231338AbhKCKLi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 3 Nov 2021 06:11:38 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 115AF218B5;
        Wed,  3 Nov 2021 10:09:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1635934141; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8HGD5RvVZwoEhr+bbkXYrRWnUZwarkL/HucXToSOAbs=;
        b=IX66hhWVPi9mOYHEdPgcUJCG7A9Il1FwpUsCqdb7Chm+agQYlGRhPNAC1TeBNnyhGP1Gcg
        LCdV6gZu0V4ddhHcAdYB/iDJTwH7U/gii8Vq5lZ57WcRHPUla32zqLB+B2kpyhAkG5uWR1
        sAkWKnkLgm+FtW1c95A4PDS50/VwPYU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1635934141;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8HGD5RvVZwoEhr+bbkXYrRWnUZwarkL/HucXToSOAbs=;
        b=7BjsoI+5w30r2BNvryLHqsy7Q6tJErMo6B81zt7YccGt544T5beFoG2z9rz2IRPq1nl57N
        pZYkkNgaAz2vHcCw==
Received: from quack2.suse.cz (unknown [10.163.28.18])
        by relay2.suse.de (Postfix) with ESMTP id E54C1A3B84;
        Wed,  3 Nov 2021 10:09:00 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id BDC9C1E0BEA; Wed,  3 Nov 2021 11:09:00 +0100 (CET)
Date:   Wed, 3 Nov 2021 11:09:00 +0100
From:   Jan Kara <jack@suse.cz>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jan Kara <jack@suse.cz>, Vivek Goyal <vgoyal@redhat.com>,
        Ioannis Angelakopoulos <iangelak@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        virtio-fs-list <virtio-fs@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Steve French <sfrench@samba.org>
Subject: Re: [RFC PATCH 0/7] Inotify support in FUSE and virtiofs
Message-ID: <20211103100900.GB20482@quack2.suse.cz>
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
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue 02-11-21 14:54:01, Amir Goldstein wrote:
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
> > there? When e.g. file is created from the client, client tells the server
> > about creation, the server performs the creation which generates the
> > fsnotify event, that is received by the server and forwared back to the
> > client which just queues it into notification group's queue for userspace
> > to read it.
> >
> > Now with this architecture there's no problem with duplicate events for
> > local & server notification marks, similarly there's no problem with lost
> > events after inode deletion because events received by the client are
> > directly queued into notification queue without any checking whether inode
> > is still alive etc. Would this work or am I missing something?
> >
> 
> What about group #1 that wants mask A and group #2 that wants mask B
> events?
> 
> Do you propose to maintain separate event queues over the protocol?
> Attach a "recipient list" to each event?

Yes, that was my idea. Essentially when we see group A creates mark on FUSE
for path P, we notify server, it will create notification group A on the
server (if not already existing - there we need some notification group
identifier unique among all clients), and place mark for it on path P. Then
the full stream of notification events generated for group A on the server
will just be forwarded to the client and inserted into the A's notification
queue. IMO this is very simple solution to implement - you just need to
forward mark addition / removal events from the client to the server and you
forward event stream from the server to the client. Everything else is
handled by the fsnotify infrastructure on the server.

> I just don't see how this can scale other than:
> - Local marks and connectors manage the subscriptions on local machine
> - Protocol updates the server with the combined masks for watched objects

I agree that depending on the usecase and particular FUSE filesystem
performance of this solution may be a concern. OTOH the only additional
cost of this solution I can see (compared to all those processes just
watching files locally) is the passing of the events from the server to the
client. For local FUSE filesystems such as virtiofs this should be rather
cheap since you have to do very little processing for each generated event.
For filesystems such as sshfs, I can imagine this would be a bigger deal.

Also one problem I can see with my proposal is that it will have problems
with stuff such as leases - i.e., if the client does not notify the server
of the changes quickly but rather batches local operations and tells the
server about them only on special occasions. I don't know enough about FUSE
filesystems to tell whether this is a frequent problem or not.

> I think that the "post-mortem events" issue could be solved by keeping an
> S_DEAD fuse inode object in limbo just for the mark.
> When a remote server sends FS_IN_IGNORED or FS_DELETE_SELF for
> an inode, the fuse client inode can be finally evicted.
> I haven't tried to see how hard that would be to implement.

Sure, there can be other solutions to this particular problem. I just
want to discuss the other architecture to see why we cannot to it in a
simple way :).

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
