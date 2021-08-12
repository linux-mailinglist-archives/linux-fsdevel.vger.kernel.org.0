Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA0743EAD37
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Aug 2021 00:36:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237946AbhHLWgY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Aug 2021 18:36:24 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:50660 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237804AbhHLWgX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Aug 2021 18:36:23 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 8FDAC222D6;
        Thu, 12 Aug 2021 22:35:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1628807756; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XFuJEJtU0FEz+asdLNDOk+fpi385WJHPm9mYuKCMiak=;
        b=YaGQw2nwcR8eQOiZl3QUgud7iFMDYaymXoVf2HnPx/mu+Q/zS69jJiL/d2n7LsF4t6fIuH
        Vjy2j0K3nbGm7dJ+EyNHhQGnNYQksl6z58r2jmgYWq+LxWQUWtyaDvy+5wB3hMQ1nSIMOR
        SMwCT2l7BHrlbeGJLQwzU99bpnwvEhY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1628807756;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XFuJEJtU0FEz+asdLNDOk+fpi385WJHPm9mYuKCMiak=;
        b=OvtpAplaXYELCa86c4H/vteQQ+LtsaTnFrp6uK2Tjoc95KOGTdj24T/JmrJULPJ7shSAo5
        aOYQWFz9OJXEm0BQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6B46213C82;
        Thu, 12 Aug 2021 22:35:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id CAQVCkqiFWFueAAAMHmgww
        (envelope-from <neilb@suse.de>); Thu, 12 Aug 2021 22:35:54 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Josef Bacik" <josef@toxicpanda.com>
Cc:     "Chris Mason" <clm@fb.com>, "David Sterba" <dsterba@suse.com>,
        linux-fsdevel@vger.kernel.org,
        "Linux NFS list" <linux-nfs@vger.kernel.org>,
        "Btrfs BTRFS" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH/RFC 0/4] Attempt to make progress with btrfs dev number
 strangeness.
In-reply-to: <6571d3fb-34ea-0f22-4fbe-995e5568e044@toxicpanda.com>
References: <162848123483.25823.15844774651164477866.stgit@noble.brown>,
 <e6496956-0df3-6232-eecb-5209b28ca790@toxicpanda.com>,
 <162872000356.22261.854151210687377005@noble.neil.brown.name>,
 <6571d3fb-34ea-0f22-4fbe-995e5568e044@toxicpanda.com>
Date:   Fri, 13 Aug 2021 08:35:51 +1000
Message-id: <162880775121.15074.3288255136681201159@noble.neil.brown.name>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 12 Aug 2021, Josef Bacik wrote:
> On 8/11/21 6:13 PM, NeilBrown wrote:
> > On Wed, 11 Aug 2021, Josef Bacik wrote:
> >>
> >> I think this is a step in the right direction, but I want to figure out =
a way to
> >> accomplish this without magical mount points that users must be aware of.
> >=20
> > magic mount *options* ???
> >=20
> >>
> >> I think the stat() st_dev ship as sailed, we're stuck with that.  However
> >> Christoph does have a valid point where it breaks the various info spit =
out by
> >> /proc.  You've done a good job with the treeid here, but it still makes =
it
> >> impossible for somebody to map the st_dev back to the correct mount.
> >=20
> > The ship might have sailed, but it is not water tight.  And as the world
> > it round, it can still come back to bite us from behind.
> > Anything can be transitioned away from, whether it is devfs or 32-bit
> > time or giving different device numbers to different file-trees.
> >=20
> > The linkage between device number and and filesystem is quite strong.
> > We could modified all of /proc and /sys/ and audit and whatever else to
> > report the fake device number, but we cannot get the fake device number
> > into the mount table (without making the mount table unmanageablely
> > large).
> > And if subtrees aren't in the mount-table for the NFS server, I don't
> > think they should be in the mount-table of the NFS client.  So we cannot
> > export them to NFS.
> >=20
> > I understand your dislike for mount options.  An alternative with
> > different costs and benefits would be to introduce a new filesystem type
> > - btrfs2 or maybe betrfs.  This would provide numdevs=3D1 semantics and do
> > whatever we decided was best with inode numbers.  How much would you
> > hate that?
> >=20
>=20
> A lot more ;).
>=20
> >>
> >> I think we aren't going to solve that problem, at least not with stat().=
  I
> >> think with statx() spitting out treeid we have given userspace a way to
> >> differentiate subvolumes, and so we should fix statx() to spit out the t=
he super
> >> block device, that way new userspace things can do their appropriate loo=
kup if
> >> they so choose.
> >=20
> > I don't think we should normalize having multiple devnums per filesystem
> > by encoding it in statx().  It *would* make sense to add a btrfs ioctl
> > which reports the real device number of a file.  Tools that really need
> > to work with btrfs could use that, but it would always be obvious that
> > it was an exception.
>=20
> That's not what I'm saying.  I'm saying that stat() continues to behave the=
 way=20
> it currently does, for legacy users.
>=20
> And then for statx() it returns the correct devnum like any other file syst=
em,=20
> with the augmentation of the treeid so that future userspace programs can u=
se=20
> the treeid to decide if they want to wander into a subvolume.

Yes, that is what I thought you were saying.  It implies that the
possibility of a file having two different device numbers becomes
normalised in the API - one returned by stat(), the other by statx()
(presumably in a new field - the FS cannot tell what libc call the
application made).  I don't like that.

>=20
> This way moving forward we have a way to map back to a mount point because =

> statx() will return the actual devnum for the mountpoint, and then we can u=
se=20
> the treeid to be smart about when we wander into a subvolume.

We already have a way to map back to a mountpoint.  statx reports a
mnt_id with result flag STATX_MNT_ID.  This is the number at the start
of the line in mountinfo.  Hmmm, this isn't in the manpage.  It has been
in the kernel since Linux 5.8.  I'll send a patch for the manpage.

So we could pursue a path where the device-id no longer defines the
filesystem (or mount), but instead it defines some arbitrary grouping of
objects within a filesystem.  So instead of my proposed
   dev-id  /  subtree-id / inode-number
we would have
   dev-id-in-mountinfo / mnt_id / dev-id-in-stat / inode-number

In some ways this would be a smoother path forward - no change to statx,
no new concepts, just formalizing some de-facto concepts.
In other ways it might be rougher - we would need to convince the
community to use the stat() dev-id in all those proc files etc.

I think having the two meanings for a device-id would cause confusion for
quite some years..... but then any change will probably cause confusion.

>=20
> And if we're going to add a treeid, I would actually like to add a parent_t=
reeid=20
> as well so we could tell if we're a snapshot or just a normal subvolume.

Is this a well-defined concept? Isn't "snapshot" just one possible
use-case for the btrfs functionality of creating a reflink to a subtree?
What happens to the "parent_treeid" reference when that "parent" gets
deleted?

I understand the desire to track this sort of connection, but I wonder
if the filesystem is really the right place to track it.  Maybe having
the tools track it would be better.

>=20
> >=20
> >>
> >> This leaves the problem of nfsd.  Can you just integrate this new treeid=
 into
> >> nfsd, and use that to either change the ino within nfsd itself, or do so=
mething
> >> similar to what your first patchset did and generate a fsid based on the=
 treeid?
> >=20
> > I would only want nfsd to change the inode number.  I no longer think it
> > is acceptable for nfsd to report different device number (as I mention
> > above).
> > I would want the new inode number to be explicitly provided by the
> > filesystem.  Whether that is a new export_operation or a new field in
> > 'struct kstat' doesn't really bother me.  I'd *prefer* it to be st_ino,
> > but I can live without that.
> >
>=20
> Right, I'm not saying nfsd has to propagate our dev_t thing, I'm saying tha=
t you=20
> could accomplish the same behavior without the mount options.  We add eithe=
r a=20
> new SB_I_HAS_TREEID or FS_HAS_TREEID, depending on if you prefer to tag the=
 sb=20
> or the fs_type, and then NFS does the inode number magic transformation=20
> automatically and we are good to go.

I really don't want nfsd to do the magic transformations.  I want the
filesystem to do those if they need to be done.  I could cope with nfsd
xor-ing some provided number with i_ino, but I wouldn't like nfsd to
have the responsibility of doing the swab64().

>=20
> > On the topic of inode numbers....  I've recently learned that btrfs
> > never reuses inode (objectid) numbers (except possibly after an
> > unmount).  Equally it doesn't re-use subvol numbers.  How much does this
> > contribute to the 64 bits not being enough for subtree+inode?
> >=20
> > It would be nice if we could be comfortable limiting the objectid number
> > to 40 bits and the root.objectid (filetree) number to 24 bits, and
> > combine them into a 64bit inode number.
> >=20
> > If we added a inode number reuse scheme that was suitably performant,
> > would that make this possible?  That would remove the need for a treeid,
> > and allow us to use project-id to identify subtrees.
> >=20
>=20
> We had a resuse scheme, we deprecated and deleted it.  I don't want to=20
> arbitrarily limit objectid's to work around this issue.

These are computers we are working with.  There are always arbitrary
limits.
The syscall interface places an arbitrary limit of 64bits on the
identity of any object in a filesystem.  btrfs clearly doesn't like that
arbitrary limit, and plays games with device number to increase it to a
new arbitrary limit of 84 bits (sort-of).

I'm fully open to the possibility that last year's arbitrary limits are
no longer comfortable and that we might need to push the boundaries.
But I'd rather the justification was a bit stronger than "we cannot be
bothered reusing old inode numbers".

Are you at all aware of any site coming anywhere vaguely close to one trillion
concurrent inodes - maybe even 16 billion?
Or anything close to 16 million concurrent subvolumes?

>=20
> >>
> >> Mount options are messy, and are just going to lead to distro's turning =
them on
> >> without understanding what's going on and then we have to support them f=
orever.
> >>    I want to get this fixed in a way that we all hate the least with as =
little
> >> opportunity for confused users to make bad decisions.  Thanks,
> >=20
> > Hence my question: how much do you hate creating a new filesystem type
> > to fix the problems?
> >=20
>=20
> I'm still not convinced we can't solve this without adding new options or=20
> fstypes.  I think flags to indicate that we're special and to use a treeid =
that=20
> we stuff into the inode would be a reasonable solution.  That being said I'=
m a=20
> little sleep deprived so I could be missing why my plan is a bad one, so I'=
m=20
> willing to be convinced that mount options are the solution to this, but I =
want=20
> to make sure we're damned certain that's the best way forward.  Thanks,

I don't think "best way forward" is the appropriate goal - impossible to
assess.

What we need is a chosen way forward.  Someone - and ultimately that
someone needs to be the BTRFS maintainer team - needs to decide what
breakage they are willing to bear the cost of, and what breakage is
unacceptable to them, and to choose a way to move forward.  I cannot
make that decision for you because I'm just an interested bystander.  Al
Viro and Linus cannot either, though they are in a position to veto some
decisions.

The current choice appears to be "ignore the problem and hope it goes
away", though I appreciate that appearances can be deceiving.

You appear very keen to preserve as much of the status quo as possible.
Given that, I think you really need to push to get all the procfs files
changed to use the same device number as stat - so push the patch which
SUSE has that add inode_get_dev().

https://github.com/SUSE/kernel-source/blob/master/patches.suse/vfs-add-super_=
operations-get_inode_dev

(though the change to show_mountinfo() in that patch would need careful consi=
deration).

If that lands, you have a clear way forward, and we can find some
solution for NFSd (and other network filesystems), and for user-space to
use mnt_id.
If you cannot overcome the pushback, then you know you will have to
find another path - make a 64bit inode number unique, or add more bits
to the effective inode number.  Or something.

NeilBrown
