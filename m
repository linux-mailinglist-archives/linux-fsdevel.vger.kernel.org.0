Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB96844DB23
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Nov 2021 18:30:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234308AbhKKRdi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 11 Nov 2021 12:33:38 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:54602 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229710AbhKKRdh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 11 Nov 2021 12:33:37 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 3468F21B2D;
        Thu, 11 Nov 2021 17:30:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1636651847; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=eMlI4REmxQS7q9claJoGhhHqfhqrytf65Kp/9KOdFhE=;
        b=2LFav6K/ze6UqXrvKNjQEXv6jw0TxM6rk2IeE8Xh/kq8JuP/9G/w9g+Y9+/YHj1lgHVCWp
        3BNTj6YFv3O5ehNSX4woHMHcsJq4mFovL28W20OPAzTlqHsNCYhRlX/nNZ1DOmVBavRueQ
        gx+IYe1lmX58hJ1fm02DVRUG6BJXp2Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1636651847;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=eMlI4REmxQS7q9claJoGhhHqfhqrytf65Kp/9KOdFhE=;
        b=HppQ4C9UeSr/5dTfam95WAcwAJ0thVH2HWx1jH8vkljcPwOecsiTAxaf5u+Fj8DE82yZVE
        PYnOJc0XkHr/jWDA==
Received: from quack2.suse.cz (unknown [10.100.200.198])
        by relay2.suse.de (Postfix) with ESMTP id 0849CA3B84;
        Thu, 11 Nov 2021 17:30:47 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id D007C1E14EF; Thu, 11 Nov 2021 18:30:43 +0100 (CET)
Date:   Thu, 11 Nov 2021 18:30:43 +0100
From:   Jan Kara <jack@suse.cz>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Vivek Goyal <vgoyal@redhat.com>, Jan Kara <jack@suse.cz>,
        Ioannis Angelakopoulos <iangelak@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        virtio-fs-list <virtio-fs@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Steve French <sfrench@samba.org>
Subject: Re: [RFC PATCH 0/7] Inotify support in FUSE and virtiofs
Message-ID: <20211111173043.GB25491@quack2.suse.cz>
References: <20211027132319.GA7873@quack2.suse.cz>
 <YXm2tAMYwFFVR8g/@redhat.com>
 <20211102110931.GD12774@quack2.suse.cz>
 <CAOQ4uxiYQYG8Ta=MNJKpa_0pAPd0MS9PL2r_0ZRD+_TKOw6C7g@mail.gmail.com>
 <20211103100900.GB20482@quack2.suse.cz>
 <CAOQ4uxjsULgLuOFUYkEePySx6iPXRczgCZMxx8E5ncw=oarLPg@mail.gmail.com>
 <YYMO1ip9ynXFXc8f@redhat.com>
 <20211104100316.GA10060@quack2.suse.cz>
 <YYU/7269JX2neLjz@redhat.com>
 <CAOQ4uxiM_i+6Zs+ewg8mfA5aKs-gY7yj3kdrmPLO8Zn+bz4DbA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxiM_i+6Zs+ewg8mfA5aKs-gY7yj3kdrmPLO8Zn+bz4DbA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 10-11-21 08:28:13, Amir Goldstein wrote:
> > > OK, so do I understand both you and Amir correctly that you think that
> > > always relying on the FUSE server for generating the events and just piping
> > > them to the client is not long-term viable design for FUSE? Mostly because
> > > caching of modifications on the client is essentially inevitable and hence
> > > generating events from the server would be unreliable (delayed too much)?
> 
> This is one aspect, but we do not have to tie remote notifications to
> the cache coherency problem that is more complicated.
> 
> OTOH, if virtiofs take the route of "remote groups", why not take it one step
> further and implement "remote event queue".
> Then, it does not need to push event notifications from the server
> into fsnotify at all.
> Instead, FUSE client can communicate with the server using ioctl or a new
> command to implement new_group() that returns a special FUSE file and
> use FUSE POLL/READ to check/read the server's event queue.

Yes, that could work. But I don't see how you want to avoid pushing events
to fsnotify on the client side. Suppose app creates fanotify group G, it
adds mark for some filesystem F1 to it, then in adds marks for another
filesystem F2 - this time it is FUSE based fs. App wants to receive events
for both F1 and F2 but events for F2 are actually coming from the server
and somehow they have to get into G's queue for an app to read them.

> There is already a precedent of this model with CIFS_IOC_NOTIFY
> and SMB2_CHANGE_NOTIFY - SMB protocol, samba server and Windows server
> support watching a directory or a subtree. I think it is a "oneshot" watch, so
> there is no polling nor queue involved.

OK, are you aiming at completely separate notification API for userspace
for FUSE-based filesystems? Then I see why you don't need to push events
to fsnotify but I don't quite like that for a few reasons:

1) Application has to be aware whether the filesystem it operates on is
FUSE based or not. That is IMO unnecessary burden for the applications.

2) If application wants to watch for several paths potentially on multiple
filesystems, it would now need to somehow merge the event streams from FUSE
API and {fa/i}notify API.

3) It would potentially duplicate quite some parts of fsnotify API
handling.

> > So initial implementation could be about, application either get local
> > events or remote events (based on filesystem). Down the line more
> > complicated modes can emerge where some combination of local and remote
> > events could be generated and applications could specify it. That
> > probably will be extension of fanotiy/inotify API.
> 
> There is one more problem with this approach.
> We cannot silently change the behavior of existing FUSE filesystems.
> What if a system has antivirus configured to scan access to virtiofs mounts?
> Do you consider it reasonable that on system upgrade, the capability of
> adding local watches would go away?
 
I agree we have to be careful there. If fanotify / inotify is currently
usable with virtiofs, just missing events coming from host changes (which
are presumably rare for lots of setups), it is likely used by someone and
we should not regress it.

> I understand the desire to have existing inotify applications work out of
> the box to get remote notifications, but I have doubts if this goal is even
> worth pursuing. Considering that the existing known use case described in this
> thread is already using polling to identify changes to config files on the host,
> it could just as well be using a new API to get the job done.
> 
> If we had to plan an interface without considering existing applications,
> I think it would look something like:
> 
> #define FAN_MARK_INODE                                 0x00000000
> #define FAN_MARK_MOUNT                               0x00000010
> #define FAN_MARK_FILESYSTEM                      0x00000100
> #define FAN_MARK_REMOTE_INODE                0x00001000
> #define FAN_MARK_REMOTE_FILESYSTEM     0x00001100
> 
> Then, the application can choose to add a remote mark with a certain
> event mask and a local mark with a different event mask without any ambiguity.
> The remote events could be tagged with a flag (turn reserved member of
> fanotify_event_metadata into flags).
> 
> We have made a lot of effort to make fanotify a super set of inotify
> functionality removing old UAPI mistakes and baggage along the way,
> so I'd really hate to see us going down the path of ambiguous UAPI
> again.

So there's a question: Does application care whether the event comes from
local or remote side? I'd say generally no - a file change is simply a file
change and it does not matter who did it. Also again this API implies the
application has to be aware it runs on a filesystem that may generate
remote events to ask for them. But presumably knowledgeable app can always
ask for local & remote events and if that fails (fs does not support remote
events), ask only for local. That's not a big burden.

The question is why would we make remote events explicit (and thus
complicate the API and usage) when generally apps cannot be bothered who
did the change. I suppose it makes implementation and some of the
consequences on the stream of events more obvious. Also it allows
functionality such as permission or mount events which are only local when
the server does not support them which could be useful for "mostly local"
filesystems. Hum...

> IMO, the work that Ioannis has already done to support remote
> notifications with virtiofsd is perfectly valid as a private functionality
> of virtiofs, just like cifs CIFS_IOC_NOTIFY.
> 
> If we want to go further and implement a "remote notification subsystem"
> then I think we should take other fs (e.g.cifs) into consideration and think
> about functionality beyond the plain remote watch and create an UAPI
> that can be used to extend the functionality further.

So I agree that if we go for "remote notification subsystem", then we
better consider cases like other FUSE filesystems, cifs, or NFS. I haven't
yet made up my mind whether we cannot somehow seamlessly incorporate remote
events into fsnotify because it seems to me they are identical to local
events from app point of view. But I agree that if we cannot find a way to
integrate remote events without many rough edges, then it is better to make
remote events explicit.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
