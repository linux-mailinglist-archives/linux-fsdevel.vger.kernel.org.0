Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC10A3780F6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 May 2021 12:13:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230356AbhEJKOL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 10 May 2021 06:14:11 -0400
Received: from mx2.suse.de ([195.135.220.15]:57232 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230295AbhEJKOK (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 10 May 2021 06:14:10 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 45199B15B;
        Mon, 10 May 2021 10:13:05 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 10ED51F2C5C; Mon, 10 May 2021 12:13:05 +0200 (CEST)
Date:   Mon, 10 May 2021 12:13:05 +0200
From:   Jan Kara <jack@suse.cz>
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [RFC][PATCH] fanotify: introduce filesystem view mark
Message-ID: <20210510101305.GC11100@quack2.suse.cz>
References: <20201124134916.GC19336@quack2.suse.cz>
 <CAOQ4uxiJz-j8GA7kMYRTGMmE9SFXCQ-xZxidOU1GzjAN33Txdg@mail.gmail.com>
 <20201125110156.GB16944@quack2.suse.cz>
 <CAOQ4uxgmExbSmcfhp0ir=7QJMVcwu2QNsVUdFTiGONkg3HgjJw@mail.gmail.com>
 <20201126111725.GD422@quack2.suse.cz>
 <CAOQ4uxgt1Cx5jx3L6iaDvbzCWPv=fcMgLaa9ODkiu9h718MkwQ@mail.gmail.com>
 <20210503165315.GE2994@quack2.suse.cz>
 <CAOQ4uxgy0DUEUo810m=bnLuHNbs60FLFPUUw8PLq9jJ8VTFD8g@mail.gmail.com>
 <20210505122815.GD29867@quack2.suse.cz>
 <20210505142405.vx2wbtadozlrg25b@wittgenstein>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210505142405.vx2wbtadozlrg25b@wittgenstein>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 05-05-21 16:24:05, Christian Brauner wrote:
> On Wed, May 05, 2021 at 02:28:15PM +0200, Jan Kara wrote:
> > On Mon 03-05-21 21:44:22, Amir Goldstein wrote:
> > > > > Getting back to this old thread, because the "fs view" concept that
> > > > > it presented is very close to two POCs I tried out recently which leverage
> > > > > the availability of mnt_userns in most of the call sites for fsnotify hooks.
> > > > >
> > > > > The first POC was replacing the is_subtree() check with in_userns()
> > > > > which is far less expensive:
> > > > >
> > > > > https://github.com/amir73il/linux/commits/fanotify_in_userns
> > > > >
> > > > > This approach reduces the cost of check per mark, but there could
> > > > > still be a significant number of sb marks to iterate for every fs op
> > > > > in every container.
> > > > >
> > > > > The second POC is based off the first POC but takes the reverse
> > > > > approach - instead of marking the sb object and filtering by userns,
> > > > > it places a mark on the userns object and filters by sb:
> > > > >
> > > > > https://github.com/amir73il/linux/commits/fanotify_idmapped
> > > > >
> > > > > The common use case is a single host filesystem which is
> > > > > idmapped via individual userns objects to many containers,
> > > > > so normally, fs operations inside containers would have to
> > > > > iterate a single mark.
> > > > >
> > > > > I am well aware of your comments about trying to implement full
> > > > > blown subtree marks (up this very thread), but the userns-sb
> > > > > join approach is so much more low hanging than full blown
> > > > > subtree marks. And as a by-product, it very naturally provides
> > > > > the correct capability checks so users inside containers are
> > > > > able to "watch their world".
> > > > >
> > > > > Patches to allow resolving file handles inside userns with the
> > > > > needed permission checks are also available on the POC branch,
> > > > > which makes the solution a lot more useful.
> > > > >
> > > > > In that last POC, I introduced an explicit uapi flag
> > > > > FAN_MARK_IDMAPPED in combination with
> > > > > FAN_MARK_FILESYSTEM it provides the new capability.
> > > > > This is equivalent to a new mark type, it was just an aesthetic
> > > > > decision.
> > > >
> > > > So in principle, I have no problem with allowing mount marks for ns-capable
> > > > processes. Also FAN_MARK_FILESYSTEM marks filtered by originating namespace
> > > > look OK to me (although if we extended mount marks to support directory
> > > > events as you try elsewhere, would there be still be a compeling usecase for
> > > > this?).
> > > 
> > > In my opinion it would. This is the reason why I stopped that direction.
> > > The difference between FAN_MARK_FILESYSTEM|FAN_MARK_IDMAPPED
> > > and FAN_MARK_MOUNT is that the latter can be easily "escaped" by creating
> > > a bind mount or cloning a mount ns while the former is "sticky" to all additions
> > > to the mount tree that happen below the idmapped mount.
> > 
> > As far as I understood Christian, he was specifically interested in mount
> > events for container runtimes because filtering by 'mount' was desirable
> > for his usecase. But maybe I misunderstood. Christian? Also if you have
> 
> I discussed this with Amir about two weeks ago. For container runtimes
> Amir's idea of generating events based on the userns the fsnotify
> instance was created in is actually quite clever because it gives a way
> for the container to receive events for all filesystems and idmapped
> mounts if its userns is attached to it. The model as we discussed it -
> Amir, please tell me if I'm wrong - is that you'd be setting up an
> fsnotify watch in a given userns and you'd be seeing events from all
> superblocks that have the caller's userns as s_user_ns and all mounts
> that have the caller's userns as mnt_userns. I think that's safe.

OK, so this feature would effectively allow sb-wide watching of events that
are generated from within the container (or its descendants). That sounds
useful. Just one question: If there's some part of a filesystem, that is
accesible by multiple containers (and thus multiple namespaces), or if
there's some change done to the filesystem say by container management SW,
then event for this change won't be visible inside the container (despite
that the fs change itself will be visible). This is kind of a similar
problem to the one we had with mount marks and why sb marks were created.
So aren't we just repeating the mistake with mount marks? Because it seems
to me that more often than not, applications are interested in getting
notification when what they can actually access within the fs has changed
(and this is what they actually get with the inode marks) and they don't
care that much where the change came from... Do you have some idea how
frequent are such cross-ns filesystem changes? I fully appreciate the
simplicity of Amir's proposal but I'm trying to estimate when (or how many)
users are going to come back complaining it is not good enough ;).

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
