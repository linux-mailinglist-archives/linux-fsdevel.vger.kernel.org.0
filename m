Return-Path: <linux-fsdevel+bounces-1355-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 370097D9553
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Oct 2023 12:36:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9ADF2B21492
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Oct 2023 10:36:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B85251863D;
	Fri, 27 Oct 2023 10:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UVXKZh2p"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0513618049
	for <linux-fsdevel@vger.kernel.org>; Fri, 27 Oct 2023 10:36:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39336C433C8;
	Fri, 27 Oct 2023 10:35:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698402961;
	bh=VhY7QbKdLKYqIDXPYrnQDYPAsjSB5qnb7uEtzCqAr40=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=UVXKZh2puLMQITt0KDbqEsmmgGhrSIaUjArTj/QriDrgVKraAist2AE0jWBDqkMHT
	 ek/J3aYZfXbMG+/FCT7xA4Zi3AwrcLD58zQru0GR0mZgTkyHGdmGHt4U0T1d1YvzaQ
	 RvWiCsKGFdE9RWj6E5hsMkft1377XkUIKDCnYbBx49FeN3DXvEgloG7jNWBV62Vhai
	 fsFVEc4KrZkFPWkOwucZw+pQ/M+RKLFFm+/x/A0Ggg9MCMRtNFMBIFHKYe/+DRjoKa
	 QJsDY1eJqd4hcY9s/Q2y6wmnEsaxcKts4CImuXC3iNrZChbj2Z2To5ICWXius09aEt
	 45jXgjywaDQVw==
Message-ID: <6df5ea54463526a3d898ed2bd8a005166caa9381.camel@kernel.org>
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
Date: Fri, 27 Oct 2023 06:35:58 -0400
In-Reply-To: <ZTnNCytHLGoJY9ds@dread.disaster.area>
References: <eb3b9e71ee9c6d8e228b0927dec3ac9177b06ec6.camel@kernel.org>
	 <ZTWfX3CqPy9yCddQ@dread.disaster.area>
	 <61b32a4093948ae1ae8603688793f07de764430f.camel@kernel.org>
	 <ZTcBI2xaZz1GdMjX@dread.disaster.area>
	 <CAHk-=whphyjjLwDcEthOOFXXfgwGrtrMnW2iyjdQioV6YSMEPw@mail.gmail.com>
	 <ZTc8tClCRkfX3kD7@dread.disaster.area>
	 <CAOQ4uxhJGkZrUdUJ72vjRuLec0g8VqgRXRH=x7W9ogMU6rBxcQ@mail.gmail.com>
	 <d539804a2a73ad70265c5fa599ecd663cd235843.camel@kernel.org>
	 <ZTjMRRqmlJ+fTys2@dread.disaster.area>
	 <2ef9ac6180e47bc9cc8edef20648a000367c4ed2.camel@kernel.org>
	 <ZTnNCytHLGoJY9ds@dread.disaster.area>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2023-10-26 at 13:20 +1100, Dave Chinner wrote:
> On Wed, Oct 25, 2023 at 08:25:35AM -0400, Jeff Layton wrote:
> > On Wed, 2023-10-25 at 19:05 +1100, Dave Chinner wrote:
> > > On Tue, Oct 24, 2023 at 02:40:06PM -0400, Jeff Layton wrote:
> > > > On Tue, 2023-10-24 at 10:08 +0300, Amir Goldstein wrote:
> > > > > On Tue, Oct 24, 2023 at 6:40=E2=80=AFAM Dave Chinner <david@fromo=
rbit.com> wrote:
> > > > > >=20
> > > > > > On Mon, Oct 23, 2023 at 02:18:12PM -1000, Linus Torvalds wrote:
> > > > > > > On Mon, 23 Oct 2023 at 13:26, Dave Chinner <david@fromorbit.c=
om> wrote:
> > > > > Does xfs_repair guarantee that changes of atime, or any inode cha=
nges
> > > > > for that matter, update i_version? No, it does not.
> > > > > So IMO, "atime does not update i_version" is not an "on-disk form=
at change",
> > > > > it is a runtime behavior change, just like lazytime is.
> > > >=20
> > > > This would certainly be my preference. I don't want to break any
> > > > existing users though.
> > >=20
> > > That's why I'm trying to get some kind of consensus on what
> > > rules and/or atime configurations people are happy for me to break
> > > to make it look to users like there's a viable working change
> > > attribute being supplied by XFS without needing to change the on
> > > disk format.
> > >=20
> >=20
> > I agree that the only bone of contention is whether to count atime
> > updates against the change attribute. I think we have consensus that al=
l
> > in-kernel users do _not_ want atime updates counted against the change
> > attribute. The only real question is these "legacy" users of
> > di_changecount.
>=20
> Please stop refering to "legacy users" of di_changecount. Whether
> there are users or not is irrelevant - it is defined by the current
> on-disk format specification, and as such there may be applications
> we do not know about making use of the current behaviour.
>=20
> It's like a linux syscall - we can't remove them because there may
> be some user we don't know about still using that old syscall. We
> simply don't make changes that can potentially break user
> applications like that.
>=20
> The on disk format is the same - there is software out that we don't
> know about that expects a certain behaviour based on the
> specification. We don't break the on disk format by making silent
> behavioural changes - we require a feature flag to indicate
> behaviour has changed so that applications can take appropriate
> actions with stuff they don't understand.
>=20
> The example for this is the BIGTIME timestamp format change. The on
> disk inode structure is physically unchanged, but the contents of
> the timestamp fields are encoded very differently. Sure, the older
> kernels can read the timestamp data without any sort of problem
> occurring, except for the fact the timestamps now appear to be
> completely corrupted.
>=20
> Changing the meaning of ithe contents of di_changecount is no
> different. It might look OK and nothing crashes, but nothing can be
> inferred from the value in the field because we don't know how it
> has been modified.
>=20
> Hence we can't just change the meaning, encoding or behaviour of an
> on disk field that would result in existing kernels and applications
> doing the wrong thing with that field (either read or write) without
> adding a feature flag to indicate what behaviour that field should
> have.
>=20
> > > > Perhaps this ought to be a mkfs option? Existing XFS filesystems co=
uld
> > > > still behave with the legacy behavior, but we could make mkfs.xfs b=
uild
> > > > filesystems by default that work like NFS requires.
> > >=20
> > > If we require mkfs to set a flag to change behaviour, then we're
> > > talking about making an explicit on-disk format change to select the
> > > optional behaviour. That's precisely what I want to avoid.
> > >=20
> >=20
> > Right. The on-disk di_changecount would have a (subtly) different
> > meaning at that point.
> >=20
> > It's not a change that requires drastic retooling though. If we were to
> > do this, we wouldn't need to grow the on-disk inode. Booting to an olde=
r
> > kernel would cause the behavior to revert. That's sub-optimal, but not
> > fatal.
>=20
> See above: redefining the contents, behaviour or encoding of an on
> disk field is a change of the on-disk format specification.
>=20
> The rules for on disk format changes that we work to were set in
> place long before I started working on XFS.  They are sane, well
> thought out rules that have stood the test of time and massive new
> feature introductions (CRCs, reflink, rmap, etc). And they only work
> because we don't allow anyone to bend them for convenience, short
> cuts or expediting their pet project.
>=20
> > What I don't quite understand is how these tools are accessing
> > di_changecount?
>=20
> As I keep saying: this is largely irrelevant to the problem at hand.
>=20
> > XFS only accesses the di_changecount to propagate the value to and from
> > the i_version,
>=20
> Yes.  XFS has a strong separation between on-disk structures and
> in-memory values, and i_version is simply the in-memory field we use
> to store the current di_changecount value.  We force bump i_version
> every time we modify the inode core regardless of whether anyone has
> queried i_version because that's what di_changecount requires. i.e.
> the filesystem controls the contents of i_version, not the VFS.
>=20
> Now that NFS is using a proper abstraction (i.e. vfs_statx()) to get
> the change cookie, we really don't need to expose di_changecount in
> i_version at all - we could simply copy an internal di_changecount
> value into the statx cookie field in xfs_vn_getattr() and there
> would be almost no change of behaviour from the perspective of NFS
> and IMA at all.
>=20
> > and there is nothing besides NFSD and IMA that queries
> > the i_version value in-kernel. So, this must be done via some sort of
> > userland tool that is directly accessing the block device (or some 3rd
> > party kernel module).
>=20
> Yup, both of those sort of applications exist. e.g. the DMAPI kernel
> module allows direct access to inode metadata through a custom
> bulkstat formatter implementation - it returns different information
> comapred to the standard XFS one in the upstream kernel.
>=20
> > In earlier discussions you alluded to some repair and/or analysis tools
> > that depended on this counter.
>=20
> Yes, and one of those "tools" is *me*.
>=20
> I frequently look at the di_changecount when doing forensic and/or
> failure analysis on filesystem corpses.  SOE analysis, relative
> modification activity, etc all give insight into what happened to
> the filesystem to get it into the state it is currently in, and
> di_changecount provides information no other metadata in the inode
> contains.
>=20
> > I took a quick look in xfsprogs, but I
> > didn't see anything there. Is there a library or something that these
> > tools use to get at this value?
>=20
> xfs_db is the tool I use for this, such as:
>=20
> $ sudo xfs_db -c "sb 0" -c "a rootino" -c "p v3.change_count" /dev/mapper=
/fast
> v3.change_count =3D 35
> $
>=20
> The root inode in this filesystem has a change count of 35. The root
> inode has 32 dirents in it, which means that no entries have ever
> been removed or renamed. This sort of insight into the past history
> of inode metadata is largely impossible to get any other way, and
> it's been the difference between understanding failure and having no
> clue more than once.
>=20
> Most block device parsing applications simply write their own
> decoder that walks the on-disk format. That's pretty trivial to do,
> developers can get all the information needed to do this from the
> on-disk format specification documentation we keep on kernel.org...
>=20

Fair enough. I'm not here to tell you that you guys that you need to
change how di_changecount works. If it's too valuable to keep it
counting atime-only updates, then so be it.

If that's the case however, and given that the multigrain timestamp work
is effectively dead, then I don't see an alternative to growing the on-
disk inode. Do you?
--=20
Jeff Layton <jlayton@kernel.org>

