Return-Path: <linux-fsdevel+bounces-1631-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A5F07DCBC3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 31 Oct 2023 12:26:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5A8D281751
	for <lists+linux-fsdevel@lfdr.de>; Tue, 31 Oct 2023 11:26:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C55011A721;
	Tue, 31 Oct 2023 11:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RvCilsc0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03A46539D
	for <linux-fsdevel@vger.kernel.org>; Tue, 31 Oct 2023 11:26:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 227E6C433C8;
	Tue, 31 Oct 2023 11:26:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698751601;
	bh=tIQoT8O1PyTdUbqVi0uuMs4acJL9ksBo1KPTYEzsyc0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=RvCilsc0iZwQ3xfymeMbXe4id1bffDE6E0pQsEk7tOQCWOJvFgPC6wZAKIwy4uRCD
	 DLoyKhwAX4ymXVl39DHR5ODG3mgk4O05xoNzKLvditJBk3Qyb8HovJArd4ryWLHc8K
	 YPbUIK9tMTGAQLcM6qyN2EaWjgKbokN8sLmCwIQrNZKIgB4x6LSKo/h7bJ5KNbhMzQ
	 V+q/dYRDq5octxBcHyWUtchoTxIJGwIWsZHteEaxXfpjiWNWHUxT1Xg7NC+lJk834Q
	 i90X0PSRsL1tZczx7il1jxKh8AQ3R/66rcFjCmQx6y9qx198zCEWEwjZLRSg8DW4Cj
	 ung6Up12kBj4Q==
Message-ID: <b4c04efdde3bc7d107d0bdc68e100a94942aca3c.camel@kernel.org>
Subject: Re: [PATCH RFC 2/9] timekeeping: new interfaces for multigrain
 timestamp handing
From: Jeff Layton <jlayton@kernel.org>
To: Dave Chinner <david@fromorbit.com>, Linus Torvalds
	 <torvalds@linux-foundation.org>
Cc: Amir Goldstein <amir73il@gmail.com>, Kent Overstreet
 <kent.overstreet@linux.dev>, Christian Brauner <brauner@kernel.org>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, John Stultz <jstultz@google.com>,
 Thomas Gleixner <tglx@linutronix.de>,  Stephen Boyd <sboyd@kernel.org>,
 Chandan Babu R <chandan.babu@oracle.com>, "Darrick J. Wong"
 <djwong@kernel.org>, Theodore Ts'o <tytso@mit.edu>, Andreas Dilger
 <adilger.kernel@dilger.ca>, Chris Mason <clm@fb.com>, Josef Bacik
 <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>, Hugh Dickins
 <hughd@google.com>, Andrew Morton <akpm@linux-foundation.org>, Jan Kara
 <jack@suse.de>, David Howells <dhowells@redhat.com>, 
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-xfs@vger.kernel.org, linux-ext4@vger.kernel.org, 
 linux-btrfs@vger.kernel.org, linux-mm@kvack.org, linux-nfs@vger.kernel.org
Date: Tue, 31 Oct 2023 07:26:37 -0400
In-Reply-To: <ZUBbj8XsA6uW8ZDK@dread.disaster.area>
References: 
	<CAHk-=whphyjjLwDcEthOOFXXfgwGrtrMnW2iyjdQioV6YSMEPw@mail.gmail.com>
	 <ZTc8tClCRkfX3kD7@dread.disaster.area>
	 <CAOQ4uxhJGkZrUdUJ72vjRuLec0g8VqgRXRH=x7W9ogMU6rBxcQ@mail.gmail.com>
	 <d539804a2a73ad70265c5fa599ecd663cd235843.camel@kernel.org>
	 <ZTjMRRqmlJ+fTys2@dread.disaster.area>
	 <2ef9ac6180e47bc9cc8edef20648a000367c4ed2.camel@kernel.org>
	 <ZTnNCytHLGoJY9ds@dread.disaster.area>
	 <6df5ea54463526a3d898ed2bd8a005166caa9381.camel@kernel.org>
	 <ZUAwFkAizH1PrIZp@dread.disaster.area>
	 <CAHk-=wg4jyTxO8WWUc1quqSETGaVsPHh8UeFUROYNwU-fEbkJg@mail.gmail.com>
	 <ZUBbj8XsA6uW8ZDK@dread.disaster.area>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2023-10-31 at 12:42 +1100, Dave Chinner wrote:
> On Mon, Oct 30, 2023 at 01:11:56PM -1000, Linus Torvalds wrote:
> > On Mon, 30 Oct 2023 at 12:37, Dave Chinner <david@fromorbit.com> wrote:
> > >=20
> > > If XFS can ignore relatime or lazytime persistent updates for given
> > > situations, then *we don't need to make periodic on-disk updates of
> > > atime*. This makes the whole problem of "persistent atime update bump=
s
> > > i_version" go away because then we *aren't making persistent atime
> > > updates* except when some other persistent modification that bumps
> > > [cm]time occurs.
> >=20
> > Well, I think this should be split into two independent questions:
> >=20
> >  (a) are relatime or lazytime atime updates persistent if nothing else =
changes?
>=20
> They only become persistent after 24 hours or, in the case of
> relatime, immediately persistent if mtime < atime (i.e. read after a
> modification). Those are the only times that the VFS triggers
> persistent writeback of atime, and it's the latter case (mtime <
> atime) that is the specific trigger that exposed the problem with
> atime bumping i_version in the first place.
>=20
> >  (b) do atime updates _ever_ update i_version *regardless* of relatime
> > or lazytime?
> >=20
> > and honestly, I think the best answer to (b) would be that "no,
> > i_version should simply not change for atime updates". And I think
> > that answer is what it is because no user of i_version seems to want
> > it.
>=20
> As I keep repeating: Repeatedly stating that "atime should not bump
> i_version" does not address the questions I'm asking *at all*.
>=20
> > Now, the reason it's a single question for you is that apparently for
> > XFS, the only thing that matters is "inode was written to disk" and
> > that "di_changecount" value is thus related to the persistence of
> > atime updates, but splitting di_changecount out to be a separate thing
> > from i_version seems to be on the table, so I think those two things
> > really could be independent issues.
>=20
> Wrong way around - we'd have to split i_version out from
> di_changecount. It's i_version that has changed semantics, not
> di_changecount, and di_changecount behaviour must remain unchanged.
>=20

I have to take issue with your characterization of this. The
requirements for NFS's change counter have not changed. Clearly there
was a breakdown in communications when it was first implemented in Linux
that caused atime updates to get counted in the i_version value, but
that was never intentional and never by design.

I'm simply trying to correct this historical mistake.

> What I really don't want to do is implement a new i_version field in
> the XFS on-disk format. What this redefinition of i_version
> semantics has made clear is that i_version is *user defined
> metadata*, not internal filesystem metadata that is defined by the
> filesystem on-disk format.
>=20
> User defined persistent metadata *belongs in xattrs*, not in the
> core filesystem on-disk formats. If the VFS wants to define and
> manage i_version behaviour, smeantics and persistence independently
> of the filesystems that manage the persistent storage (as it clearly
> does!) then we should treat it just like any other VFS defined inode
> metadata (e.g. per inode objects like security constraints, ACLs,
> fsverity digests, fscrypt keys, etc). i.e. it should be in a named
> xattr, not directly implemented in the filesystem on-disk format
> deinfitions.
>=20
> Then the application can change the meaning of the metadata whenever
> and however it likes. Then filesystem developers just don't need
> to care about it at all because the VFS specific persistent metadata
> is not part of the on-disk format we need to maintain
> cross-platform forwards and backwards compatibility for.
>=20
> > > But I don't want to do this unconditionally - for systems not
> > > running anything that samples i_version we want relatime/lazytime
> > > to behave as they are supposed to and do periodic persistent updates
> > > as per normal. Principle of least surprise and all that jazz.
> >=20
> > Well - see above: I think in a perfect world, we'd simply never change
> > i_version at all for any atime updates, and relatime/lazytime simply
> > wouldn't be an issue at all wrt i_version.
>=20
> Right, that's what I'd like, especially as the new definition of
> i_version - "only change when [cm]time changes" - means that the VFS
> i_version is really now just a glorified timestamp.
>=20
> > Wouldn't _that_ be the trule "least surprising" behavior? Considering
> > that nobody wants i_version to change for what are otherwise pure
> > reads (that's kind of the *definition* of atime, after all).
>=20
> So, if you don't like the idea of us ignoring relatime/lazytime
> conditionally, are we allowed to simply ignore them *all the time*
> and do all timestamp updates in the manner that causes users the
> least amount of pain?
>=20
> I mean, relatime only exists because atime updates cause users pain.
> lazytime only exists because relatime doesn't address the pain that
> timestamp updates cause mixed read/write or pure O_DSYNC overwrite
> workloads pain. noatime is a pain because it loses all atime
> updates.
>=20
> There is no "one size is right for everyone", so why not just let
> filesystems do what is most efficient from an internal IO and
> persistence POV whilst still maintaining the majority of "expected"
> behaviours?
>=20
> Keep in mind, though, that this is all moot if we can get rid of
> i_version entirely....
>=20
> > Now, the annoyance here is that *both* (a) and (b) then have that
> > impact of "i_version no longer tracks di_changecount".
>=20
> .... and what is annoying is that that the new i_version just a
> glorified ctime change counter. What we should be fixing is ctime -
> integrating this change counting into ctime would allow us to make
> i_version go away entirely. i.e. We don't need a persistent ctime
> change counter if the ctime has sufficient resolution or persistent
> encoding that it does not need an external persistent change
> counter.
>=20
> That was reasoning behind the multi-grain timestamps. While the mgts
> implementation was flawed, the reasoning behind it certainly isn't.
> We should be trying to get rid of i_version by integrating it into
> ctime updates, not arguing how atime vs i_version should work.
>=20
> > So I don't think the issue here is "i_version" per se. I think in a
> > vacuum, the best option of i_version is pretty obvious.  But if you
> > want i_version to track di_changecount, *then* you end up with that
> > situation where the persistence of atime matters, and i_version needs
> > to update whenever a (persistent) atime update happens.
>=20
> Yet I don't want i_version to track di_changecount.
>=20
> I want to *stop supporting i_version altogether* in XFS.
>=20
> I want i_version as filesystem internal metadata to die completely.
>=20
> I don't want to change the on disk format to add a new i_version
> field because we'll be straight back in this same siutation when the
> next i_version bug is found and semantics get changed yet again.
>=20
> Hence if we can encode the necessary change attributes into ctime,
> we can drop VFS i_version support altogether.  Then the "atime bumps
> i_version" problem also goes away because then we *don't use
> i_version*.
>=20
> But if we can't get the VFS to do this with ctime, at least we have
> the abstractions available to us (i.e. timestamp granularity and
> statx change cookie) to allow XFS to implement this sort of
> ctime-with-integrated-change-counter internally to the filesystem
> and be able to drop i_version support....=20
>=20
> [....]

> > This really is all *entirely* an artifact of that "bi_changecount" vs
> > "i_version" being tied together. You did seem to imply that you'd be
> > ok with having "bi_changecount" be split from i_version, ie from an
> > earlier email in this thread:
> >=20
> >  "Now that NFS is using a proper abstraction (i.e. vfs_statx()) to get
> >   the change cookie, we really don't need to expose di_changecount in
> >   i_version at all - we could simply copy an internal di_changecount
> >   value into the statx cookie field in xfs_vn_getattr() and there
> >   would be almost no change of behaviour from the perspective of NFS
> >   and IMA at all"
>=20
> .... which is what I was talking about here.
>=20
> i.e. I was not talking about splitting i_version from di_changecount
> - I was talking about being able to stop supporting the VFS
> i_version counter entirely and still having NFS and IMA work
> correctly.
>=20
> Continually bring the argument back to "atime vs i_version" misses
> the bigger issues around this new i_version definition and
> implementation, and that the real solution should be to fix ctime
> updates to make i_version at the VFS level go away forever.
>=20

Ok, so your proposal is to keep using coarse grained timestamps, but use
the "insignificant" bits in them to store a change counter?

That sounds complex and fraught with peril, but I'm willing to listen to
some specifics about how that would work.
--=20
Jeff Layton <jlayton@kernel.org>

