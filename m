Return-Path: <linux-fsdevel+bounces-1120-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F1D567D5B1C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Oct 2023 21:07:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2BE641C20CB2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Oct 2023 19:07:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64A023C6B8;
	Tue, 24 Oct 2023 19:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HkeRcCla"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A669224212
	for <linux-fsdevel@vger.kernel.org>; Tue, 24 Oct 2023 19:06:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF8E5C433C7;
	Tue, 24 Oct 2023 19:06:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698174416;
	bh=/qyszrF+QslBIDgbZwTZCkFxLKUnK+ZQhALdWhTGr/c=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=HkeRcCla7YTcsmf3F97hDH5Cm2CP926FMTscV+TrsAkS2Qg7kU5MbCEQufunns24W
	 eSVIs4H07ydZeiVv704Tr4duLbFQZCCphG5vHH0LQAIuvWqehqIrfdcovKZvBKw4W8
	 3luXOvsg7Dp1Go3pzOycuU8cTxoWNL+VqiDoCqJ5zOeUehu8Z0HM1YR3uLoou9uUPk
	 1Finikynnlw6ExA2RwW1L4cNCtlJWwYz+DpChxCUASHOOJKl4YRWTwvTmrolv4k/G8
	 OhRbcGTUG5s2eLuzvjnMDn9AbNmn4gFNGHOXcWmAv8goPnlMCeMZg/OGzvZUjRkLwG
	 V+oNRee2yf/AA==
Message-ID: <2c74660bc44557dba8391758535e4012cbea3724.camel@kernel.org>
Subject: Re: [PATCH RFC 2/9] timekeeping: new interfaces for multigrain
 timestamp handing
From: Jeff Layton <jlayton@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>, Dave Chinner
	 <david@fromorbit.com>
Cc: Kent Overstreet <kent.overstreet@linux.dev>, Christian Brauner
 <brauner@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, John Stultz
 <jstultz@google.com>, Thomas Gleixner <tglx@linutronix.de>, Stephen Boyd
 <sboyd@kernel.org>, Chandan Babu R <chandan.babu@oracle.com>, "Darrick J.
 Wong" <djwong@kernel.org>, Theodore Ts'o <tytso@mit.edu>, Andreas Dilger
 <adilger.kernel@dilger.ca>, Chris Mason <clm@fb.com>, Josef Bacik
 <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>, Hugh Dickins
 <hughd@google.com>, Andrew Morton <akpm@linux-foundation.org>, Amir
 Goldstein <amir73il@gmail.com>, Jan Kara <jack@suse.de>, David Howells
 <dhowells@redhat.com>,  linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org,  linux-xfs@vger.kernel.org,
 linux-ext4@vger.kernel.org,  linux-btrfs@vger.kernel.org,
 linux-mm@kvack.org, linux-nfs@vger.kernel.org
Date: Tue, 24 Oct 2023 15:06:52 -0400
In-Reply-To: <CAHk-=whphyjjLwDcEthOOFXXfgwGrtrMnW2iyjdQioV6YSMEPw@mail.gmail.com>
References: 
	<CAHk-=wixObEhBXM22JDopRdt7Z=tGGuizq66g4RnUmG9toA2DA@mail.gmail.com>
	 <d6162230b83359d3ed1ee706cc1cb6eacfb12a4f.camel@kernel.org>
	 <CAHk-=wiKJgOg_3z21Sy9bu+3i_34S86r8fd6ngvJpZDwa-ww8Q@mail.gmail.com>
	 <5f96e69d438ab96099bb67d16b77583c99911caa.camel@kernel.org>
	 <20231019-fluor-skifahren-ec74ceb6c63e@brauner>
	 <0a1a847af4372e62000b259e992850527f587205.camel@kernel.org>
	 <ZTGncMVw19QVJzI6@dread.disaster.area>
	 <eb3b9e71ee9c6d8e228b0927dec3ac9177b06ec6.camel@kernel.org>
	 <ZTWfX3CqPy9yCddQ@dread.disaster.area>
	 <61b32a4093948ae1ae8603688793f07de764430f.camel@kernel.org>
	 <ZTcBI2xaZz1GdMjX@dread.disaster.area>
	 <CAHk-=whphyjjLwDcEthOOFXXfgwGrtrMnW2iyjdQioV6YSMEPw@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2023-10-23 at 14:18 -1000, Linus Torvalds wrote:
> On Mon, 23 Oct 2023 at 13:26, Dave Chinner <david@fromorbit.com> wrote:
> >=20
> > The problem is the first read request after a modification has been
> > made. That is causing relatime to see mtime > atime and triggering
> > an atime update. XFS sees this, does an atime update, and in
> > committing that persistent inode metadata update, it calls
> > inode_maybe_inc_iversion(force =3D false) to check if an iversion
> > update is necessary. The VFS sees I_VERSION_QUERIED, and so it bumps
> > i_version and tells XFS to persist it.
>=20
> Could we perhaps just have a mode where we don't increment i_version
> for just atime updates?
>=20
> Maybe we don't even need a mode, and could just decide that atime
> updates aren't i_version updates at all?
>=20
> Yes, yes, it's obviously technically a "inode modification", but does
> anybody actually *want* atime updates with no actual other changes to
> be version events?
>=20
> Or maybe i_version can update, but callers of getattr() could have two
> bits for that STATX_CHANGE_COOKIE, one for "I care about atime" and
> one for others, and we'd pass that down to inode_query_version, and
> we'd have a I_VERSION_QUERIED and a I_VERSION_QUERIED_STRICT, and the
> "I care about atime" case ould set the strict one.
>=20
> Then inode_maybe_inc_iversion() could - for atome updates - skip the
> version update *unless* it sees that I_VERSION_QUERIED_STRICT bit.
>=20
> Does that sound sane to people?
>=20
> Because it does sound completely insane to me to say "inode changed"
> and have a cache invalidation just for an atime update.
>=20


The new flag idea is a good one. The catch though is that there are no
readers of i_version in-kernel other than NFSD and IMA, so there would
be no in-kernel users of I_VERSION_QUERIED_STRICT.

In earlier discussions, I was given to believe that the problem with
changing how this works in XFS involved offline filesystem access tools.
That said, I didn't press for enough details at the time, so I may have
misunderstood Dave's reticence to change how this works.
--=20
Jeff Layton <jlayton@kernel.org>

