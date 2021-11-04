Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0DE6445166
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Nov 2021 11:03:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229809AbhKDKF6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 4 Nov 2021 06:05:58 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:36686 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229636AbhKDKF6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 4 Nov 2021 06:05:58 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 85A071FD33;
        Thu,  4 Nov 2021 10:03:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1636020199; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=sVjy7Hw4GYNbSvj0ehLiUNu3FfEdD2HU+7SF+Zx3qk4=;
        b=TNdu7+J7NWAB1VvsLkufNxmcRY0fJihnQj7K3kNiYgsqeknZcr7R5aQIylKeBRC9k9HxCR
        capTDiMyClwLaMc1r+TG367sqBkWrl6LCt4iC1hL8r5bh2Qz9wAMxU/im2iP3iy0Ct7JL4
        YToFeEtJB/u5kvx70Qxq+bmQ+L/XEWE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1636020199;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=sVjy7Hw4GYNbSvj0ehLiUNu3FfEdD2HU+7SF+Zx3qk4=;
        b=kkNzGMIRpEgI2uvzRMkBfmgY2aQxzbDw37NYJr99e8NEsvLllKKtBpoUqBh5U+T3q5Q82S
        6UC+w0VgqXxVoYDQ==
Received: from quack2.suse.cz (jack.udp.ovpn1.nue.suse.de [10.163.28.18])
        by relay2.suse.de (Postfix) with ESMTP id 6DC7A2C144;
        Thu,  4 Nov 2021 10:03:19 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 86FC11E10D0; Thu,  4 Nov 2021 11:03:16 +0100 (CET)
Date:   Thu, 4 Nov 2021 11:03:16 +0100
From:   Jan Kara <jack@suse.cz>
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     Amir Goldstein <amir73il@gmail.com>, Jan Kara <jack@suse.cz>,
        Ioannis Angelakopoulos <iangelak@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        virtio-fs-list <virtio-fs@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Steve French <sfrench@samba.org>
Subject: Re: [RFC PATCH 0/7] Inotify support in FUSE and virtiofs
Message-ID: <20211104100316.GA10060@quack2.suse.cz>
References: <YXhIm3mOvPsueWab@redhat.com>
 <CAO17o20sdKAWQN6w7Oe0Ze06qcK+J=6rrmA_aWGnY__MRVDCKw@mail.gmail.com>
 <CAOQ4uxhA+f-GZs-6SwNtSYZvSwfsYz4_=8_tWAUqt9s-49bqLw@mail.gmail.com>
 <20211027132319.GA7873@quack2.suse.cz>
 <YXm2tAMYwFFVR8g/@redhat.com>
 <20211102110931.GD12774@quack2.suse.cz>
 <CAOQ4uxiYQYG8Ta=MNJKpa_0pAPd0MS9PL2r_0ZRD+_TKOw6C7g@mail.gmail.com>
 <20211103100900.GB20482@quack2.suse.cz>
 <CAOQ4uxjsULgLuOFUYkEePySx6iPXRczgCZMxx8E5ncw=oarLPg@mail.gmail.com>
 <YYMO1ip9ynXFXc8f@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YYMO1ip9ynXFXc8f@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 03-11-21 18:36:06, Vivek Goyal wrote:
> On Wed, Nov 03, 2021 at 01:17:36PM +0200, Amir Goldstein wrote:
> > > > > > Hi Jan,
> > > > > >
> > > > > > Agreed. That's what Ioannis is trying to say. That some of the remote events
> > > > > > can be lost if fuse/guest local inode is unlinked. I think problem exists
> > > > > > both for shared and non-shared directory case.
> > > > > >
> > > > > > With local filesystems we have a control that we can first queue up
> > > > > > the event in buffer before we remove local watches. With events travelling
> > > > > > from a remote server, there is no such control/synchronization. It can
> > > > > > very well happen that events got delayed in the communication path
> > > > > > somewhere and local watches went away and now there is no way to
> > > > > > deliver those events to the application.
> > > > >
> > > > > So after thinking for some time about this I have the following question
> > > > > about the architecture of this solution: Why do you actually have local
> > > > > fsnotify watches at all? They seem to cause quite some trouble... I mean
> > > > > cannot we have fsnotify marks only on FUSE server and generate all events
> > > > > there? When e.g. file is created from the client, client tells the server
> > > > > about creation, the server performs the creation which generates the
> > > > > fsnotify event, that is received by the server and forwared back to the
> > > > > client which just queues it into notification group's queue for userspace
> > > > > to read it.
> > > > >
> > > > > Now with this architecture there's no problem with duplicate events for
> > > > > local & server notification marks, similarly there's no problem with lost
> > > > > events after inode deletion because events received by the client are
> > > > > directly queued into notification queue without any checking whether inode
> > > > > is still alive etc. Would this work or am I missing something?
> > > > >
> > > >
> > > > What about group #1 that wants mask A and group #2 that wants mask B
> > > > events?
> > > >
> > > > Do you propose to maintain separate event queues over the protocol?
> > > > Attach a "recipient list" to each event?
> > >
> > > Yes, that was my idea. Essentially when we see group A creates mark on FUSE
> > > for path P, we notify server, it will create notification group A on the
> > > server (if not already existing - there we need some notification group
> > > identifier unique among all clients), and place mark for it on path P. Then
> > > the full stream of notification events generated for group A on the server
> > > will just be forwarded to the client and inserted into the A's notification
> > > queue. IMO this is very simple solution to implement - you just need to
> > > forward mark addition / removal events from the client to the server and you
> > > forward event stream from the server to the client. Everything else is
> > > handled by the fsnotify infrastructure on the server.
> > >
> > > > I just don't see how this can scale other than:
> > > > - Local marks and connectors manage the subscriptions on local machine
> > > > - Protocol updates the server with the combined masks for watched objects
> > >
> > > I agree that depending on the usecase and particular FUSE filesystem
> > > performance of this solution may be a concern. OTOH the only additional
> > > cost of this solution I can see (compared to all those processes just
> > > watching files locally) is the passing of the events from the server to the
> > > client. For local FUSE filesystems such as virtiofs this should be rather
> > > cheap since you have to do very little processing for each generated event.
> > > For filesystems such as sshfs, I can imagine this would be a bigger deal.
> > >
> > > Also one problem I can see with my proposal is that it will have problems
> > > with stuff such as leases - i.e., if the client does not notify the server
> > > of the changes quickly but rather batches local operations and tells the
> > > server about them only on special occasions. I don't know enough about FUSE
> > > filesystems to tell whether this is a frequent problem or not.
> > >
> > > > I think that the "post-mortem events" issue could be solved by keeping an
> > > > S_DEAD fuse inode object in limbo just for the mark.
> > > > When a remote server sends FS_IN_IGNORED or FS_DELETE_SELF for
> > > > an inode, the fuse client inode can be finally evicted.
> > > > I haven't tried to see how hard that would be to implement.
> > >
> > > Sure, there can be other solutions to this particular problem. I just
> > > want to discuss the other architecture to see why we cannot to it in a
> > > simple way :).
> > >
> > 
> > Fair enough.
> > 
> > Beyond the scalability aspects, I think that a design that exposes the group
> > to the remote server and allows to "inject" events to the group queue
> > will prevent
> > users from useful features going forward.
> > 
> > For example, fanotify ignored_mask could be added to a group, even on
> > a mount mark, even if the remote server only supports inode marks and it
> > would just work.
> > 
> > Another point of view for the post-mortem events:
> > As Miklos once noted and as you wrote above, for cache coherency and leases,
> > an async notification queue is not adequate and synchronous notifications are
> > too costly, so there needs to be some shared memory solution involving guest
> > cache invalidation by host.
> 
> Any shared memory solution works only limited setup. If server is remote
> on other machine, there is no sharing. I am hoping that this can be
> generic enough to support other remote filesystems down the line.

OK, so do I understand both you and Amir correctly that you think that
always relying on the FUSE server for generating the events and just piping
them to the client is not long-term viable design for FUSE? Mostly because
caching of modifications on the client is essentially inevitable and hence
generating events from the server would be unreliable (delayed too much)?

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
