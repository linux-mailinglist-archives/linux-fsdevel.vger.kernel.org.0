Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B161444ADA
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Nov 2021 23:29:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229728AbhKCWcH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 3 Nov 2021 18:32:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:31480 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229618AbhKCWcH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 3 Nov 2021 18:32:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635978569;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XpWD6dE9QflP7edMm7n10/MD8FPaGtnElvxsO1BRWpc=;
        b=L/50GiLHQZ3ivcxuI0hOQ5Plezo2PYbVknZ356RSdKAZ5+xx3APJrFXOnhVkOX6nnJQTxe
        Y8fR205nFu4V9mwr/IhswKYSQ1Rdr6tALH4U3qOAb7DOo7mq1AwdDEbMfUMd90Tr4WD5qf
        sdHjeEo8wUz8tXayNen700rPkAtRijA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-202-N7snxRnPPcujkIag2j2pBg-1; Wed, 03 Nov 2021 18:29:26 -0400
X-MC-Unique: N7snxRnPPcujkIag2j2pBg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DBC97871803;
        Wed,  3 Nov 2021 22:29:24 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.22.17.117])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E7B68641A7;
        Wed,  3 Nov 2021 22:29:18 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 7A8FC220562; Wed,  3 Nov 2021 18:29:18 -0400 (EDT)
Date:   Wed, 3 Nov 2021 18:29:18 -0400
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
Message-ID: <YYMNPqVnOWD3gNsw@redhat.com>
References: <CAOQ4uxhpCKK2MYxSmRJYYMEWaHKy5ezyKgxaM+YAKtpjsZkD-g@mail.gmail.com>
 <YXhIm3mOvPsueWab@redhat.com>
 <CAO17o20sdKAWQN6w7Oe0Ze06qcK+J=6rrmA_aWGnY__MRVDCKw@mail.gmail.com>
 <CAOQ4uxhA+f-GZs-6SwNtSYZvSwfsYz4_=8_tWAUqt9s-49bqLw@mail.gmail.com>
 <20211027132319.GA7873@quack2.suse.cz>
 <YXm2tAMYwFFVR8g/@redhat.com>
 <20211102110931.GD12774@quack2.suse.cz>
 <CAOQ4uxiYQYG8Ta=MNJKpa_0pAPd0MS9PL2r_0ZRD+_TKOw6C7g@mail.gmail.com>
 <YYGg1w/q31SC3PQ8@redhat.com>
 <CAOQ4uxg_KAg34TgmVRQ5nrfgHddzQepVv_bAUAhqtkDfHB7URw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxg_KAg34TgmVRQ5nrfgHddzQepVv_bAUAhqtkDfHB7URw@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Nov 03, 2021 at 09:31:02AM +0200, Amir Goldstein wrote:
> > > >
> > >
> > > What about group #1 that wants mask A and group #2 that wants mask B
> > > events?
> > >
> > > Do you propose to maintain separate event queues over the protocol?
> > > Attach a "recipient list" to each event?
> > >
> > > I just don't see how this can scale other than:
> > > - Local marks and connectors manage the subscriptions on local machine
> > > - Protocol updates the server with the combined masks for watched objects
> > >
> > > I think that the "post-mortem events" issue could be solved by keeping an
> > > S_DEAD fuse inode object in limbo just for the mark.
> > > When a remote server sends FS_IN_IGNORED or FS_DELETE_SELF for
> > > an inode, the fuse client inode can be finally evicted.
> >
> > There is no guarantee that FS_IN_IGNORED or FS_DELETE_SELF will come
> > or when will it come. If another guest has reference on inode it might
> > not come for a long time. And this will kind of become a mechanism
> > for one guest to keep other's inode cache full of such objects.
> >
> > If event queue becomes too full, we might drop these events. But I guess
> > in that case we will have to generate IN_Q_OVERFLOW and that can somehow
> > be used to cleanup such S_DEAD inodes?
> 
> That depends on the server implementation.
> If the server is watching host fs using fanotify filesystem mark, then
> an overflow
> event does NOT mean that other new events on inode may be missed only
> that old events could have been missed.
> Server should know about all the watched inodes, so it can check on overflow
> if any of the watched inodes were deleted and notify the client using a reliable
> channel.

Ok. We have only one channel for notifications. I guess we can program
the channel in such a way so that it does not drop overflow events but
can drop other kind of events if things get crazy. If too many overflow
events and we allocate too much of memory, I guess at some point of
time, oom killer will kick in a kill server.

> 
> Given the current server implementation with inotify, IN_Q_OVERFLOW
> means server may have lost an IN_IGNORED event and may not get any
> more events on inode, so server should check all the watched inodes after
> overflow, notify the client of all deleted inodes and try to re-create
> the watches
> for all inodes with known path or use magic /prod/pid/fd path if that
> works (??).

Re-doing the watches sounds very painful. That means we will need to
keep track of aggregated mask in server side inode as well. As of
now we just pass mask to kernel using inotify_add_watch() and forget
about it.

/proc/pid/fd should work because I think that's how ioannis is putting
current watches on inodes. We don't send path info to server.

> 
> >
> > nodeid is managed by server. So I am assuming that FORGET messages will
> > not be sent to server for this inode till we have seen FS_IN_IGNORED
> > and FS_DELETE_SELF events?
> >
> 
> Or until the application that requested the watch calls
> inotify_rm_watch() or closes
> the inotify fd.
> 
> IOW, when fs implements remote fsnotify, the local watch keeps the local deleted
> inode object in limbo until the local watch is removed.
> When the remote fsnotify server informs that the remote watch (or remote inode)
> is gone, the local watch is removed as well and then the inotify
> application also gets
> an FS_IN_IGNORED event.

Hmm.., I guess remote server will simply send IN_DELETE event when it
gets it and forward to client. And client will have to then cleanup
this S_DEAD inode which is in limbo waiting for IN_DELETE_SELF event.
And that should trigger cleanup of marks/local-watches on the inode, IIUC.

> 
> Lifetime of local inode is complicated and lifetime of this "shared inode"
> is much more complicated, so I am not pretending to claim that I have this all
> figured out or that it could be reliably done at all.

Yes this handling of IN_DELETE_SELF is turning out to be the most
complicated piece of this proposal. I wish initial implementation
could just be designed that it does not send IN_DELETE_SELF and
IN_INGORED is generated locally. And later enhance it to support
reliable delivery of IN_DELETE_SELF.

Thanks
Vivek

