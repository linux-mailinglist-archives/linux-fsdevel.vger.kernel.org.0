Return-Path: <linux-fsdevel+bounces-1632-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B1DAD7DCBD3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 31 Oct 2023 12:29:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E25561C20BE7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 31 Oct 2023 11:29:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 444C51A727;
	Tue, 31 Oct 2023 11:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="szcK99jQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85CD6156C1
	for <linux-fsdevel@vger.kernel.org>; Tue, 31 Oct 2023 11:29:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAC34C433C7;
	Tue, 31 Oct 2023 11:29:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698751762;
	bh=sQi8lLN99TqACM6Lr/LTk68QS9WcLZ1H4O7ExjoVBrM=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=szcK99jQWDGhlXMi1UgH+Os3Ra+DjckTFa7eXi2kTman6U6wMaiPqiHE0ZUb7/2zU
	 SxHagS2QXuXkot3N6SG26/AfQjhmkK3OTBneaxECmrkBwHlxt4tEEd2b5Vf4DVWEty
	 +Gy4OK9zIxQsh7X9k178PrZDUB2B3ULtpSkR3p0AgVJPSURjL40mlCwxjTK1hAHwQV
	 JCnIuZYdexIZDob5OIE0bV5CWZy/m8dHmIeGwvdmPApv4vcsah3tV52UAUfYKAR5Us
	 3of6oyBVaM+ko1bQu3KUaH+BILSplQUKX9RZpAnhyNe+62km1wfnW/C2jHnZmRv1AT
	 crFIyLnj00vXg==
Message-ID: <3d6a4c21626e6bbb86761a6d39e0fafaf30a4a4d.camel@kernel.org>
Subject: Re: [PATCH RFC 2/9] timekeeping: new interfaces for multigrain
 timestamp handing
From: Jeff Layton <jlayton@kernel.org>
To: Amir Goldstein <amir73il@gmail.com>, Dave Chinner <david@fromorbit.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Kent Overstreet
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
Date: Tue, 31 Oct 2023 07:29:18 -0400
In-Reply-To: <CAOQ4uxgSRw26J+MPK-zhysZX9wBkXFRNx+n1bwnQwykCJ1=F4Q@mail.gmail.com>
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
	 <CAOQ4uxgSRw26J+MPK-zhysZX9wBkXFRNx+n1bwnQwykCJ1=F4Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2023-10-31 at 09:03 +0200, Amir Goldstein wrote:
> On Tue, Oct 31, 2023 at 3:42=E2=80=AFAM Dave Chinner <david@fromorbit.com=
> wrote:
> >=20
> [...]
> > .... and what is annoying is that that the new i_version just a
> > glorified ctime change counter. What we should be fixing is ctime -
> > integrating this change counting into ctime would allow us to make
> > i_version go away entirely. i.e. We don't need a persistent ctime
> > change counter if the ctime has sufficient resolution or persistent
> > encoding that it does not need an external persistent change
> > counter.
> >=20
> > That was reasoning behind the multi-grain timestamps. While the mgts
> > implementation was flawed, the reasoning behind it certainly isn't.
> > We should be trying to get rid of i_version by integrating it into
> > ctime updates, not arguing how atime vs i_version should work.
> >=20
> > > So I don't think the issue here is "i_version" per se. I think in a
> > > vacuum, the best option of i_version is pretty obvious.  But if you
> > > want i_version to track di_changecount, *then* you end up with that
> > > situation where the persistence of atime matters, and i_version needs
> > > to update whenever a (persistent) atime update happens.
> >=20
> > Yet I don't want i_version to track di_changecount.
> >=20
> > I want to *stop supporting i_version altogether* in XFS.
> >=20
> > I want i_version as filesystem internal metadata to die completely.
> >=20
> > I don't want to change the on disk format to add a new i_version
> > field because we'll be straight back in this same siutation when the
> > next i_version bug is found and semantics get changed yet again.
> >=20
> > Hence if we can encode the necessary change attributes into ctime,
> > we can drop VFS i_version support altogether.  Then the "atime bumps
> > i_version" problem also goes away because then we *don't use
> > i_version*.
> >=20
> > But if we can't get the VFS to do this with ctime, at least we have
> > the abstractions available to us (i.e. timestamp granularity and
> > statx change cookie) to allow XFS to implement this sort of
> > ctime-with-integrated-change-counter internally to the filesystem
> > and be able to drop i_version support....
> >=20
>=20
> I don't know if it was mentioned before in one of the many threads,
> but there is another benefit of ctime-with-integrated-change-counter
> approach - it is the ability to extend the solution with some adaptations
> also to mtime.
>=20
> The "change cookie" is used to know if inode metadata cache should
> be invalidated and mtime is often used to know if data cache should
> be invalidated, or if data comparison could be skipped (e.g. rsync).
>=20
> The difference is that mtime can be set by user, so using lower nsec
> bits for modification counter would require to truncate the user set
> time granularity to 100ns - that is probably acceptable, but only as
> an opt-in behavior.
>=20
> The special value 0 for mtime-change-counter could be reserved for
> mtime that was set by the user or for upgrade of existing inode,
> where 0 counter means that mtime cannot be trusted as an accurate
> data modification-cookie.
>=20
> This feature is going to be useful for the vfs HSM implementation [1]
> that I am working on and it actually rhymes with the XFS DMAPI
> patches that were never fully merged upstream.
>=20
> Speaking on behalf of my employer, we would love to see the data
> modification-cookie feature implemented, whether in vfs or in xfs.
>=20
> *IF* the result on this thread is that the chosen solution is
> ctime-with-change-counter in XFS
> *AND* if there is agreement among XFS developers to extend it with
> an opt-in mkfs/mount option to 100ns-mtime-with-change-counter in XFS
> *THEN* I think I will be able to allocate resources to drive this xfs wor=
k.
>=20
> Thanks,
> Amir.
>=20
> [1] https://github.com/amir73il/fsnotify-utils/wiki/Hierarchical-Storage-=
Management-API

I agree with Christian that if you can do this inside of XFS altogether,
then that's a preferable solution. I don't quite understand how ctime-
with-change-counter is intended to work however, so I'll have to reserve
judgement there.

--=20
Jeff Layton <jlayton@kernel.org>

