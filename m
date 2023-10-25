Return-Path: <linux-fsdevel+bounces-1156-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8841D7D6B59
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Oct 2023 14:25:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 80D94B21143
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Oct 2023 12:25:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9316C27EDC;
	Wed, 25 Oct 2023 12:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ch094CrQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7EC11CF95
	for <linux-fsdevel@vger.kernel.org>; Wed, 25 Oct 2023 12:25:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DCB4C433C7;
	Wed, 25 Oct 2023 12:25:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698236739;
	bh=CPfbQfAM1itjWCIx0nw3DPeg3BGsp7SHrr2xBrG+Ips=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=ch094CrQN1hvWHJzxzq0IS9uCUYQiHYjKqCOkuwf4HlKsyJ2HZiCCxOkwAmYD4odl
	 qU39q/+5YQ9Jr14/taFrQ3L4M5PsQ4Hz+zO8fS2DDSTRPt3CEZ6KwdhSiyQLCVeOiH
	 RF9LRyGj9F9mr+PRazMgZ2g3+yBA+1FPMyTHo+wZGsBzOyZF2KhuTUFy+8BruFeIvn
	 Dne7XJuj38EA0kEHqAtmp0iW40c2AYLb5ZTPsxoUu1lsZHmzbAOOw+A8gBvPbArZFG
	 QJPDTq++2IQoHaUqYhyEMeZQku3OZ+hmiHdNkYVCjm2Xe309kQXDCFT4E5ZaojbH29
	 3Ye+PQ3PI6l7w==
Message-ID: <2ef9ac6180e47bc9cc8edef20648a000367c4ed2.camel@kernel.org>
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
Date: Wed, 25 Oct 2023 08:25:35 -0400
In-Reply-To: <ZTjMRRqmlJ+fTys2@dread.disaster.area>
References: <0a1a847af4372e62000b259e992850527f587205.camel@kernel.org>
	 <ZTGncMVw19QVJzI6@dread.disaster.area>
	 <eb3b9e71ee9c6d8e228b0927dec3ac9177b06ec6.camel@kernel.org>
	 <ZTWfX3CqPy9yCddQ@dread.disaster.area>
	 <61b32a4093948ae1ae8603688793f07de764430f.camel@kernel.org>
	 <ZTcBI2xaZz1GdMjX@dread.disaster.area>
	 <CAHk-=whphyjjLwDcEthOOFXXfgwGrtrMnW2iyjdQioV6YSMEPw@mail.gmail.com>
	 <ZTc8tClCRkfX3kD7@dread.disaster.area>
	 <CAOQ4uxhJGkZrUdUJ72vjRuLec0g8VqgRXRH=x7W9ogMU6rBxcQ@mail.gmail.com>
	 <d539804a2a73ad70265c5fa599ecd663cd235843.camel@kernel.org>
	 <ZTjMRRqmlJ+fTys2@dread.disaster.area>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2023-10-25 at 19:05 +1100, Dave Chinner wrote:
> On Tue, Oct 24, 2023 at 02:40:06PM -0400, Jeff Layton wrote:
> > On Tue, 2023-10-24 at 10:08 +0300, Amir Goldstein wrote:
> > > On Tue, Oct 24, 2023 at 6:40=E2=80=AFAM Dave Chinner <david@fromorbit=
.com> wrote:
> > > >=20
> > > > On Mon, Oct 23, 2023 at 02:18:12PM -1000, Linus Torvalds wrote:
> > > > > On Mon, 23 Oct 2023 at 13:26, Dave Chinner <david@fromorbit.com> =
wrote:
> > > > > >=20
> > > > > > The problem is the first read request after a modification has =
been
> > > > > > made. That is causing relatime to see mtime > atime and trigger=
ing
> > > > > > an atime update. XFS sees this, does an atime update, and in
> > > > > > committing that persistent inode metadata update, it calls
> > > > > > inode_maybe_inc_iversion(force =3D false) to check if an iversi=
on
> > > > > > update is necessary. The VFS sees I_VERSION_QUERIED, and so it =
bumps
> > > > > > i_version and tells XFS to persist it.
> > > > >=20
> > > > > Could we perhaps just have a mode where we don't increment i_vers=
ion
> > > > > for just atime updates?
> > > > >=20
> > > > > Maybe we don't even need a mode, and could just decide that atime
> > > > > updates aren't i_version updates at all?
> > > >=20
> > > > We do that already - in memory atime updates don't bump i_version a=
t
> > > > all. The issue is the rare persistent atime update requests that
> > > > still happen - they are the ones that trigger an i_version bump on
> > > > XFS, and one of the relatime heuristics tickle this specific issue.
> > > >=20
> > > > If we push the problematic persistent atime updates to be in-memory
> > > > updates only, then the whole problem with i_version goes away....
> > > >=20
> > > > > Yes, yes, it's obviously technically a "inode modification", but =
does
> > > > > anybody actually *want* atime updates with no actual other change=
s to
> > > > > be version events?
> > > >=20
> > > > Well, yes, there was. That's why we defined i_version in the on dis=
k
> > > > format this way well over a decade ago. It was part of some deep
> > > > dark magical HSM beans that allowed the application to combine
> > > > multiple scans for different inode metadata changes into a single
> > > > pass. atime changes was one of the things it needed to know about
> > > > for tiering and space scavenging purposes....
> > > >=20
> > >=20
> > > But if this is such an ancient mystical program, why do we have to
> > > keep this XFS behavior in the present?
> > > BTW, is this the same HSM whose DMAPI ioctls were deprecated
> > > a few years back?
>=20
> Drop the attitude, Amir.
>=20
> That "ancient mystical program" is this:
>=20
> https://buy.hpe.com/us/en/enterprise-solutions/high-performance-computing=
-solutions/high-performance-computing-storage-solutions/hpc-storage-solutio=
ns/hpe-data-management-framework-7/p/1010144088
>=20
> Yup, that product is backed by a proprietary descendent of the Irix
> XFS code base XFS that is DMAPI enabled and still in use today. It's
> called HPE XFS these days....
>=20
> > > I mean, I understand that you do not want to change the behavior of
> > > i_version update without an opt-in config or mount option - let the d=
istro
> > > make that choice.
> > > But calling this an "on-disk format change" is a very long stretch.
>=20
> Telling the person who created, defined and implemented the on disk
> format that they don't know what constitutes a change of that
> on-disk format seems kinda Dunning-Kruger to me....
>=20
> There are *lots* of ways that di_changecount is now incompatible
> with the VFS change counter. That's now defined as "i_version should
> only change when [cm]time is changed".
>=20
> di_changecount is defined to be a count of the number of changes
> made to the attributes of the inode.  It's not just atime at issue
> here - we bump di_changecount when make any inode change, including
> background work that does not otherwise change timestamps. e.g.
> allocation at writeback time, unwritten extent conversion, on-disk
> EOF extension at IO completion, removal of speculative
> pre-allocation beyond EOF, etc.
>=20
> IOWs, di_changecount was never defined as a linux "i_version"
> counter, regardless of the fact we originally we able to implement
> i_version with it - all extra bumps to di_changecount were not
> important to the users of i_version for about a decade.
>=20
> Unfortunately, the new i_version definition is very much
> incompatible with the existing di_changecount definition and that's
> the underlying problem here. i.e. the problem is not that we bump
> i_version on atime, it's that di_changecount is now completely
> incompatible with the new i_version change semantics.
>=20
> To implement the new i_version semantics exactly, we need to add a
> new field to the inode to hold this information.
> If we change the on disk format like this, then the atime
> problems go away because the new field would not get updated on
> atime updates. We'd still be bumping di_changecount on atime
> updates, though, because that's what is required by the on-disk
> format.
>=20
> I'm really trying to avoid changing the on-disk format unless it
> is absolutely necessary. If we can get the in-memory timestamp
> updates to avoid tripping di_changecount updates then the atime
> problems go away.
>=20
> If we can get [cm]time sufficiently fine grained that we don't need
> i_version, then we can turn off i_version in XFS and di_changecount
> ends up being entirely internal. That's what was attempted with
> generic multi-grain timestamps, but that hasn't worked.
>=20
> Another options is for XFS to play it's own internal tricks with
> [cm]time granularity and turn off i_version. e.g. limit external
> timestamp visibility to 1us and use the remaining dozen bits of the
> ns field to hold a change counter for updates within a single coarse
> timer tick. This guarantees the timestamp changes within a coarse
> tick for the purposes of change detection, but we don't expose those
> bits to applications so applications that compare timestamps across
> inodes won't get things back to front like was happening with the
> multi-grain timestamps....
>=20
> Another option is to work around the visible symptoms of the
> semantic mismatch between i_version and di_changecount. The only
> visible symptom we currently know about is the atime vs i_version
> issue.  If people are happy for us to simply ignore VFS atime
> guidelines (i.e. ignore realtime/lazytime) and do completely our own
> stuff with timestamp update deferal, then that also solve the
> immediate issues.
>=20
> > > Does xfs_repair guarantee that changes of atime, or any inode changes
> > > for that matter, update i_version? No, it does not.
> > > So IMO, "atime does not update i_version" is not an "on-disk format c=
hange",
> > > it is a runtime behavior change, just like lazytime is.
> >=20
> > This would certainly be my preference. I don't want to break any
> > existing users though.
>=20
> That's why I'm trying to get some kind of consensus on what
> rules and/or atime configurations people are happy for me to break
> to make it look to users like there's a viable working change
> attribute being supplied by XFS without needing to change the on
> disk format.
>=20

I agree that the only bone of contention is whether to count atime
updates against the change attribute. I think we have consensus that all
in-kernel users do _not_ want atime updates counted against the change
attribute. The only real question is these "legacy" users of
di_changecount.

> > Perhaps this ought to be a mkfs option? Existing XFS filesystems could
> > still behave with the legacy behavior, but we could make mkfs.xfs build
> > filesystems by default that work like NFS requires.
>=20
> If we require mkfs to set a flag to change behaviour, then we're
> talking about making an explicit on-disk format change to select the
> optional behaviour. That's precisely what I want to avoid.
>=20

Right. The on-disk di_changecount would have a (subtly) different
meaning at that point.

It's not a change that requires drastic retooling though. If we were to
do this, we wouldn't need to grow the on-disk inode. Booting to an older
kernel would cause the behavior to revert. That's sub-optimal, but not
fatal.

What I don't quite understand is how these tools are accessing
di_changecount?

XFS only accesses the di_changecount to propagate the value to and from
the i_version, and there is nothing besides NFSD and IMA that queries
the i_version value in-kernel. So, this must be done via some sort of
userland tool that is directly accessing the block device (or some 3rd
party kernel module).

In earlier discussions you alluded to some repair and/or analysis tools
that depended on this counter. I took a quick look in xfsprogs, but I
didn't see anything there. Is there a library or something that these
tools use to get at this value?
--=20
Jeff Layton <jlayton@kernel.org>

