Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB8EE388AA9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 May 2021 11:32:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234739AbhESJdU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 19 May 2021 05:33:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:51270 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229668AbhESJdT (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 19 May 2021 05:33:19 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 319B9611BD;
        Wed, 19 May 2021 09:31:58 +0000 (UTC)
Date:   Wed, 19 May 2021 11:31:56 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jan Kara <jack@suse.cz>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Miklos Szeredi <miklos@szeredi.hu>
Subject: Re: [RFC][PATCH] fanotify: introduce filesystem view mark
Message-ID: <20210519093156.7lxsmumxwesafn2c@wittgenstein>
References: <20210505122815.GD29867@quack2.suse.cz>
 <20210505142405.vx2wbtadozlrg25b@wittgenstein>
 <20210510101305.GC11100@quack2.suse.cz>
 <CAOQ4uxjqjB2pCoyLzreMziJcE5nYjgdhcAsDWDmu_5-g5AKM3w@mail.gmail.com>
 <20210512152625.i72ct7tbmojhuoyn@wittgenstein>
 <20210513105526.GG2734@quack2.suse.cz>
 <20210514135632.d53v3pwrh56pnc4d@wittgenstein>
 <CAOQ4uxgngZjBseOC_qYtxjZ_J4Rc50_Y7G+CSSpJznKBXvSU5A@mail.gmail.com>
 <20210518101135.jrldavggoibfpjhs@wittgenstein>
 <CAOQ4uxh09LqGOiTE-RgDfEwyXeK=bMn6LXr0W+Chp4rD5LZhRA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAOQ4uxh09LqGOiTE-RgDfEwyXeK=bMn6LXr0W+Chp4rD5LZhRA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, May 18, 2021 at 07:02:28PM +0300, Amir Goldstein wrote:
> > > > > > 2. data sharing among containers or among the host and containers etc.
> > > > > > The most common use-case is to share data from the host with the
> > > > > > container such as a download folder or the Linux folder on ChromeOS.
> > > > > > Most container managers will simly re-use the container's userns for
> > > > > > that too. More complex cases arise where data is shared between
> > > > > > containers with different idmappings then often a separate userns will
> > > > > > have to be used.
> > > > >
> > > > > OK, but if say on ChromeOS you copy something to the Linux folder by app A
> > > > > (say file manager) and containerized app B (say browser) watches that mount
> > > >
> > > > For ChromeOS it is currently somewhat simple since they currently only
> > > > allow a single container by default. So everytime you start an app in
> > > > the container it's the same app so they all write to the Linux Files
> > > > folder through the same container. (I'm glossing over a range of details
> > > > but that's not really relevant to the general spirit of the example.).
> > > >
> > > >
> > > > > for changes with idmap-filtered mark, then it won't see notification for
> > > > > those changes because A presumably runs in a different namespace than B, am
> > > > > I imagining this right? So mark which filters events based on namespace of
> > > > > the originating process won't be usable for such usecase AFAICT.
> > > >
> > > > Idmap filtered marks won't cover that use-case as envisioned now. Though
> > > > I'm not sure they really need to as the semantics are related to mount
> > > > marks.
> > >
> > > We really need to refer to those as filesystem marks. They are definitely
> > > NOT mount marks. We are trying to design a better API that will not share
> > > as many flaws with mount marks...
> > >
> > > > A mount mark would allow you to receive events based on the
> > > > originating mount. If two mounts A and B are separate but expose the
> > > > same files you wouldn't see events caused by B if you're watching A.
> > > > Similarly you would only see events from mounts that have been delegated
> > > > to you through the idmapped userns. I find this acceptable especially if
> > > > clearly documented.
> > > >
> > >
> > > The way I see it, we should delegate all the decisions over to userspace,
> > > but I agree that the current "simple" proposal may not provide a good
> > > enough answer to the case of a subtree that is shared with the host.
> >
> > I was focussed on what happens if you set an idmapped filtered mark for
> > a container for a set of files that is exposed to another container via
> > another idmapped mount. And it seemed to me that it was ok if the
> > container A doesn't see events from container B.
> >
> > You seem to be looking at this from the host's perspective right now
> > which is interesting as well.
> >
> > >
> > > IMO, it should be a container manager decision whether changes done by
> > > the host are:
> > > a) Not visible to containerized application
> >
> > Yes, that seems ok.
> >
> > > b) Watched in host via recursive inode watches
> > > c) Watched in host by filesystem mark filtered in userspace
> > > d) Watched in host by an "noop" idmapped mount in host, through
> > >      which all relevant apps in host access the shared folder
> >
> > So b)-d) are concerned with the host getting notifcations for changes
> > done from any container that uses a given set of files possibly through
> > different mounts.
> >
> 
> My perception was that container manager knows about all the idmapped
> mounts that share the same folder, so when container A requests to watch

Yes, the container manager would know this.

> the shared folder, container manager sets idmapped marks on *all* the
> idmapped mounts and when a new container is started which also maps
> the shared folder, idmapped marks are added to *all* the fanotify groups
> that the container manager currently maintains, which are interested in the
> shared folder.

Ah, that part wasn't spelled out in the previous mail. Yes, that would
work.

> 
> With (d) this can still be the model.
> With (c) it still makes sense to save filtering cycles in userspace in case
> events originate inside containers.
> With (b) there doesn't seem to be any need for the idmapped filtered marks
> at all.

Right, I wasn't sure at first whether you listed this as mutually
exclusive implementations. But I see now that these are choices the
manager can make about how to implement those watches. Thanks for the
clarification.

Christian
