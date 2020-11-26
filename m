Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDB292C52C1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Nov 2020 12:17:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388961AbgKZLR1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 26 Nov 2020 06:17:27 -0500
Received: from mx2.suse.de ([195.135.220.15]:51092 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388960AbgKZLR1 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 26 Nov 2020 06:17:27 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 49A89AE59;
        Thu, 26 Nov 2020 11:17:25 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 0D57C1E130F; Thu, 26 Nov 2020 12:17:25 +0100 (CET)
Date:   Thu, 26 Nov 2020 12:17:25 +0100
From:   Jan Kara <jack@suse.cz>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jan Kara <jack@suse.cz>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: Re: [RFC][PATCH] fanotify: introduce filesystem view mark
Message-ID: <20201126111725.GD422@quack2.suse.cz>
References: <20201109180016.80059-1-amir73il@gmail.com>
 <20201124134916.GC19336@quack2.suse.cz>
 <CAOQ4uxiJz-j8GA7kMYRTGMmE9SFXCQ-xZxidOU1GzjAN33Txdg@mail.gmail.com>
 <20201125110156.GB16944@quack2.suse.cz>
 <CAOQ4uxgmExbSmcfhp0ir=7QJMVcwu2QNsVUdFTiGONkg3HgjJw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxgmExbSmcfhp0ir=7QJMVcwu2QNsVUdFTiGONkg3HgjJw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 26-11-20 05:42:01, Amir Goldstein wrote:
> On Wed, Nov 25, 2020 at 1:01 PM Jan Kara <jack@suse.cz> wrote:
> >
> > On Tue 24-11-20 16:47:41, Amir Goldstein wrote:
> > > On Tue, Nov 24, 2020 at 3:49 PM Jan Kara <jack@suse.cz> wrote:
> > > > On Mon 09-11-20 20:00:16, Amir Goldstein wrote:
> > > > > A filesystem view is a subtree of a filesystem accessible from a specific
> > > > > mount point.  When marking an FS view, user expects to get events on all
> > > > > inodes that are accessible from the marked mount, even if the events
> > > > > were generated from another mount.
> > > > >
> > > > > In particular, the events such as FAN_CREATE, FAN_MOVE, FAN_DELETE that
> > > > > are not delivered to a mount mark can be delivered to an FS view mark.
> > > > >
> > > > > One example of a filesystem view is btrfs subvolume, which cannot be
> > > > > marked with a regular filesystem mark.
> > > > >
> > > > > Another example of a filesystem view is a bind mount, not on the root of
> > > > > the filesystem, such as the bind mounts used for containers.
> > > > >
> > > > > A filesystem view mark is composed of a heads sb mark and an sb_view mark.
> > > > > The filesystem view mark is connected to the head sb mark and the head
> > > > > sb mark is connected to the sb object. The mask of the head sb mask is
> > > > > a cumulative mask of all the associated sb_view mark masks.
> > > > >
> > > > > Filesystem view marks cannot co-exist with a regular filesystem mark on
> > > > > the same filesystem.
> > > > >
> > > > > When an event is generated on the head sb mark, fsnotify iterates the
> > > > > list of associated sb_view marks and filter events that happen outside
> > > > > of the sb_view mount's root.
> > > > >
> > > > > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> > > >
> > > > I gave this just a high-level look (no detailed review) and here are my
> > > > thoughts:
> > > >
> > > > 1) I like the functionality. IMO this is what a lot of people really want
> > > > when looking for "filesystem wide fs monitoring".
> > > >
> > > > 2) I don't quite like the API you propose though. IMO it exposes details of
> > > > implementation in the API. I'd rather like to have API the same as for
> > > > mount marks but with a dedicated mark type flag in the API - like
> > > > FAN_MARK_FILESYSTEM_SUBTREE (or we can keep VIEW if you like it but I think
> > > > the less terms the better ;).
> > >
> > > Sure, FAN_MARK_FS_VIEW is a dedicated mark type.
> > > The fact that is it a bitwise OR of MOUNT and FILESYSTEM is just a fun fact.
> > > Sorry if that wasn't clear.
> > > FAN_MARK_FILESYSTEM_SUBTREE sounds better for uapi.
> > >
> > > But I suppose you also meant that we should not limit the subtree root
> > > to bind mount points?
> > >
> > > The reason I used a reference to mnt for a sb_view and not dentry
> > > is because we have fsnotify_clear_marks_by_mount() callback to
> > > handle cleanup of the sb_view marks (which I left as TODO).
> > >
> > > Alternatively, we can play cache pinning games with the subtree root dentry
> > > like the case with inode mark, but I didn't want to get into that nor did I know
> > > if we should - if subtree mark requires CAP_SYS_ADMIN anyway, why not
> > > require a bind mount as its target, which is something much more visible to
> > > admins.
> >
> > Yeah, I don't have problems with bind mounts in particular. Just I was
> > thinking that concievably we could make these marks less priviledged (just
> > with CAP_DAC_SEARCH or so) and then mountpoints may be unnecessarily
> > restricting. I don't think pinning of subtree root dentry would be
> > problematic as such - inode marks pin the inode anyway, this is not
> > substantially different - if we can make it work reliably...
> >
> > In fact I was considering for a while that we could even make subtree
> > watches completely unpriviledged - when we walk the dir tree anyway, we
> > could also check permissions along the way. Due to locking this would be
> > difficult to do when generating the event but it might be actually doable
> > if we perform the permission check when reporting the event to userspace.
> > Just a food for thought...
> >
> 
> I think unprivileged subtree watches are something nice for the future, but
> for these FS_VIEW (or whatnot) marks, there is a lower hanging opportunity -
> make them require privileges relative to userns.

Agreed, that's a middle step.

> We don't need to relax that right from the start and it may requires some
> more work, but it could allow  unprivileged container user to set a
> filesystem-like watch on a filesystem where user is privileged relative
> to s_user_ns and that is a big win already.

Yep, I'd prefer to separate these two problems. I.e., first handle the
subtree watches on their own (just keeping in mind we might want to make
them less priviledged eventually), when that it working, we can look in all
the implications of making fanotify accessible to less priviledged tasks.

> It may also be possible in the future to allow setting this mark on a
> "unserns contained" mount - I'm not exactly sure of the details of idmapped
> mounts [1], but if mount has a userns associated with it to map fs uids then
> in theory we can check the view-ability of the event either at event read time
> or at event generation time - it requires that all ancestors have uid/gid that
> are *mapped* to the mount userns and nothing else, because we know
> that the listener process has CAP_DAC_SEARCH (or more) in the target
> userns.

Event read is *much* simpler for permission checks IMO. First due to
locking necessary for permission checks (i_rwsem, xattr locks etc.), second
so that you don't have to mess with credentials used for checking.

> [1] https://lore.kernel.org/linux-fsdevel/20201115103718.298186-1-christian.brauner@ubuntu.com/

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
