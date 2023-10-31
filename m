Return-Path: <linux-fsdevel+bounces-1629-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90AFA7DCB5F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 31 Oct 2023 12:05:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5EE4DB20D28
	for <lists+linux-fsdevel@lfdr.de>; Tue, 31 Oct 2023 11:05:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB8ED19BB6;
	Tue, 31 Oct 2023 11:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B0/jmFqp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 431AF19BA5
	for <linux-fsdevel@vger.kernel.org>; Tue, 31 Oct 2023 11:04:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7655DC433C8;
	Tue, 31 Oct 2023 11:04:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698750297;
	bh=seof9F/T3buCREfnRaM8n/SGCO7U8Q7G81Pbh+MqLSc=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=B0/jmFqpkWT9SLBYRDZGYIX/pJjNs4MsJ8bvvsaA4U4aW11phg5v1ZDR7id8JsNUd
	 zw7wKFBCoOozkUMgXREp3NScaoG75PhGVvyT0DRWC4CndqXfatxmQYN7afSYzvYzxl
	 Ew7aofGgt6KnA+bRoHMQRacfMT4SYz6jJClpQc4An/W3pqbp0PvDWQ0UFMhO3l6/uK
	 KlW1kzDr8H8qNnylIjSfelxj+IdLb9WebVPPRYxrpln//fJ9fD57xi8zLr4p9dCDnG
	 V9CUqL2LTaeMvAOIBUYTnePoIIgDRfOTBSgaPm/0Vsr0resDDxv6fsqVKLu0+aoWQe
	 uU5kVJIfA5VRg==
Message-ID: <d5965ba7ed012433a9914ba38a6046f2ddb015ac.camel@kernel.org>
Subject: Re: [PATCH RFC 2/9] timekeeping: new interfaces for multigrain
 timestamp handing
From: Jeff Layton <jlayton@kernel.org>
To: Dave Chinner <david@fromorbit.com>
Cc: Amir Goldstein <amir73il@gmail.com>, Linus Torvalds
 <torvalds@linux-foundation.org>, Kent Overstreet
 <kent.overstreet@linux.dev>,  Christian Brauner <brauner@kernel.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>, John Stultz <jstultz@google.com>,
 Thomas Gleixner <tglx@linutronix.de>, Stephen Boyd <sboyd@kernel.org>,
 Chandan Babu R <chandan.babu@oracle.com>, "Darrick J. Wong"
 <djwong@kernel.org>, Theodore Ts'o <tytso@mit.edu>, Andreas Dilger
 <adilger.kernel@dilger.ca>, Chris Mason <clm@fb.com>, Josef Bacik
 <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>, Hugh Dickins
 <hughd@google.com>, Andrew Morton <akpm@linux-foundation.org>, Jan Kara
 <jack@suse.de>, David Howells <dhowells@redhat.com>, 
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-xfs@vger.kernel.org, linux-ext4@vger.kernel.org, 
 linux-btrfs@vger.kernel.org, linux-mm@kvack.org, linux-nfs@vger.kernel.org
Date: Tue, 31 Oct 2023 07:04:53 -0400
In-Reply-To: <ZUAwFkAizH1PrIZp@dread.disaster.area>
References: <61b32a4093948ae1ae8603688793f07de764430f.camel@kernel.org>
	 <ZTcBI2xaZz1GdMjX@dread.disaster.area>
	 <CAHk-=whphyjjLwDcEthOOFXXfgwGrtrMnW2iyjdQioV6YSMEPw@mail.gmail.com>
	 <ZTc8tClCRkfX3kD7@dread.disaster.area>
	 <CAOQ4uxhJGkZrUdUJ72vjRuLec0g8VqgRXRH=x7W9ogMU6rBxcQ@mail.gmail.com>
	 <d539804a2a73ad70265c5fa599ecd663cd235843.camel@kernel.org>
	 <ZTjMRRqmlJ+fTys2@dread.disaster.area>
	 <2ef9ac6180e47bc9cc8edef20648a000367c4ed2.camel@kernel.org>
	 <ZTnNCytHLGoJY9ds@dread.disaster.area>
	 <6df5ea54463526a3d898ed2bd8a005166caa9381.camel@kernel.org>
	 <ZUAwFkAizH1PrIZp@dread.disaster.area>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2023-10-31 at 09:37 +1100, Dave Chinner wrote:
> On Fri, Oct 27, 2023 at 06:35:58AM -0400, Jeff Layton wrote:
> > On Thu, 2023-10-26 at 13:20 +1100, Dave Chinner wrote:
> > > On Wed, Oct 25, 2023 at 08:25:35AM -0400, Jeff Layton wrote:
> > > > On Wed, 2023-10-25 at 19:05 +1100, Dave Chinner wrote:
> > > > > On Tue, Oct 24, 2023 at 02:40:06PM -0400, Jeff Layton wrote:
> > > > In earlier discussions you alluded to some repair and/or analysis t=
ools
> > > > that depended on this counter.
> > >=20
> > > Yes, and one of those "tools" is *me*.
> > >=20
> > > I frequently look at the di_changecount when doing forensic and/or
> > > failure analysis on filesystem corpses.  SOE analysis, relative
> > > modification activity, etc all give insight into what happened to
> > > the filesystem to get it into the state it is currently in, and
> > > di_changecount provides information no other metadata in the inode
> > > contains.
> > >=20
> > > > I took a quick look in xfsprogs, but I
> > > > didn't see anything there. Is there a library or something that the=
se
> > > > tools use to get at this value?
> > >=20
> > > xfs_db is the tool I use for this, such as:
> > >=20
> > > $ sudo xfs_db -c "sb 0" -c "a rootino" -c "p v3.change_count" /dev/ma=
pper/fast
> > > v3.change_count =3D 35
> > > $
> > >=20
> > > The root inode in this filesystem has a change count of 35. The root
> > > inode has 32 dirents in it, which means that no entries have ever
> > > been removed or renamed. This sort of insight into the past history
> > > of inode metadata is largely impossible to get any other way, and
> > > it's been the difference between understanding failure and having no
> > > clue more than once.
> > >=20
> > > Most block device parsing applications simply write their own
> > > decoder that walks the on-disk format. That's pretty trivial to do,
> > > developers can get all the information needed to do this from the
> > > on-disk format specification documentation we keep on kernel.org...
> > >=20
> >=20
> > Fair enough. I'm not here to tell you that you guys that you need to
> > change how di_changecount works. If it's too valuable to keep it
> > counting atime-only updates, then so be it.
> >=20
> > If that's the case however, and given that the multigrain timestamp wor=
k
> > is effectively dead, then I don't see an alternative to growing the on-
> > disk inode. Do you?
>=20
> Yes, I do see alternatives. That's what I've been trying
> (unsuccessfully) to describe and get consensus on. I feel like I'm
> being ignored and rail-roaded here, because nobody is even
> acknowledging that I'm proposing alternatives and keeps insisting
> that the only solution is a change of on-disk format.
>=20
> So, I'll summarise the situation *yet again* in the hope that this
> time I won't get people arguing about atime vs i-version and what
> constitutes an on-disk format change because that goes nowhere and
> does nothing to determine which solution might be acceptible.
>=20
> The basic situation is this:
>=20
> If XFS can ignore relatime or lazytime persistent updates for given
> situations, then *we don't need to make periodic on-disk updates of
> atime*. This makes the whole problem of "persistent atime update bumps
> i_version" go away because then we *aren't making persistent atime
> updates* except when some other persistent modification that bumps
> [cm]time occurs.
>=20
> But I don't want to do this unconditionally - for systems not
> running anything that samples i_version we want relatime/lazytime
> to behave as they are supposed to and do periodic persistent updates
> as per normal. Principle of least surprise and all that jazz.
>=20
> So we really need an indication for inodes that we should enable this
> mode for the inode. I have asked if we can have per-operation
> context flag to trigger this given the needs for io_uring to have
> context flags for timestamp updates to be added.=20
>=20
> I have asked if we can have an inode flag set by the VFS or
> application code for this. e.g. a flag set by nfsd whenever it accesses a
> given inode.
>=20
> I have asked if this inode flag can just be triggered if we ever see
> I_VERSION_QUERIED set or statx is used to retrieve a change cookie,
> and whether this is a reliable mechanism for setting such a flag.
>=20

Ok, so to make sure I understand what you're proposing:

This would be a new inode flag that would be set in conjunction with
I_VERSION_QUERIED (but presumably is never cleared)? When XFS sees this
flag set, it would skip sending the atime to disk.

Given that you want to avoid on-disk changes, I assume this flag will
not be stored on disk. What happens after the NFS server reboots?

Consider:

1/ NFS server queries for the i_version and we set the
I_NO_ATIME_UPDATES_ON_DISK flag (or whatever) in conjunction with
I_VERSION_QUERIED. Some atime updates occur and the i_version isn't
bumped (as you'd expect).

2/ The server then reboots.

3/ Server comes back up, and some local task issues a read against the
inode. I_NO_ATIME_UPDATES_ON_DISK never had a chance to be set after the
reboot, so that atime update ends up incrementing the i_version counter.

4/ client cache invalidation occurs even though there was no write to
the file

This might reduce some of the spurious i_version bumps, but I don't see
how it can eliminate them entirely.

> I have suggested mechanisms for using masked off bits of timestamps
> to encode sub-timestamp granularity change counts and keep them
> invisible to userspace and then not using i_version at all for XFS.
> This avoids all the problems that the multi-grain timestamp
> infrastructure exposed due to variable granularity of user visible
> timestamps and ordering across inodes with different granularity.
> This is potentially a general solution, too.
>=20

I don't really understand this at all, but trying to do anything with
fine-grained timestamps will just run into a lot of the same problems we
hit with the multigrain work. If you still see this as a path forward,
maybe you can describe it more detail?


> So, yeah, there are *lots* of ways we can solve this problem without
> needing to change on-disk formats.
>=20

--=20
Jeff Layton <jlayton@kernel.org>

