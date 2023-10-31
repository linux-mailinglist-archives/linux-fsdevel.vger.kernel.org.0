Return-Path: <linux-fsdevel+bounces-1641-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A15557DCD51
	for <lists+linux-fsdevel@lfdr.de>; Tue, 31 Oct 2023 13:55:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF10C1C20C41
	for <lists+linux-fsdevel@lfdr.de>; Tue, 31 Oct 2023 12:55:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79B3512E7D;
	Tue, 31 Oct 2023 12:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fc9r3Hnh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9D46125C4
	for <linux-fsdevel@vger.kernel.org>; Tue, 31 Oct 2023 12:55:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33947C433C8;
	Tue, 31 Oct 2023 12:55:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698756932;
	bh=s7UBSmOan5oLtMhAz9UbCJu2Vxkj6b+7mYph/6f2OQ4=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=Fc9r3HnhP2vrDNKoCbIYyj3IJrXZ1Gm3bIlLEPBLpBVAkLstdVfLk6/LS2vex+SSO
	 IditxlTPlqhQJJBWOO4+9OnQvTpiyYVst57FnePcyEXPbPf6WafvGffAsLZsmjSeLk
	 TA7XVfrRoSpIxjCKtKIzdMUQZaDByKBL3fVP/bni2e6bgRUy0dsa2oaqhYVI3GaSD5
	 PGrVhNmfxijl1WfwMkaFeLulhpH5WRmskhcrN5LVFtQ9v9FPE8kO4eFEI9JeukVXxV
	 Gz1bmq0XjkkizrBM9/eo9IILVDmb28ZOBoHHxY6PHPZm35yM391OYl8lssPbx3jcZG
	 dGJal2gIxTzgQ==
Message-ID: <34e2c1231f54309c204c5b67e1999dfe1a00fceb.camel@kernel.org>
Subject: Re: [PATCH RFC 2/9] timekeeping: new interfaces for multigrain
 timestamp handing
From: Jeff Layton <jlayton@kernel.org>
To: Jan Kara <jack@suse.cz>
Cc: Dave Chinner <david@fromorbit.com>, Amir Goldstein <amir73il@gmail.com>,
  Linus Torvalds <torvalds@linux-foundation.org>, Kent Overstreet
 <kent.overstreet@linux.dev>, Christian Brauner <brauner@kernel.org>,
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
Date: Tue, 31 Oct 2023 08:55:28 -0400
In-Reply-To: <20231031122201.kmxzttzfbearu6iu@quack3>
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
	 <d5965ba7ed012433a9914ba38a6046f2ddb015ac.camel@kernel.org>
	 <20231031122201.kmxzttzfbearu6iu@quack3>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2023-10-31 at 13:22 +0100, Jan Kara wrote:
> On Tue 31-10-23 07:04:53, Jeff Layton wrote:
> > On Tue, 2023-10-31 at 09:37 +1100, Dave Chinner wrote:
> > > I have suggested mechanisms for using masked off bits of timestamps
> > > to encode sub-timestamp granularity change counts and keep them
> > > invisible to userspace and then not using i_version at all for XFS.
> > > This avoids all the problems that the multi-grain timestamp
> > > infrastructure exposed due to variable granularity of user visible
> > > timestamps and ordering across inodes with different granularity.
> > > This is potentially a general solution, too.
> >=20
> > I don't really understand this at all, but trying to do anything with
> > fine-grained timestamps will just run into a lot of the same problems w=
e
> > hit with the multigrain work. If you still see this as a path forward,
> > maybe you can describe it more detail?
>=20
> Dave explained a bit more details here [1] like:
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
> -
>=20
> So as far as I understand Dave wants to effectively persist counter in lo=
w
> bits of ctime and expose ctime+counter as its change cookie. I guess that
> could work and what makes the complexity manageable compared to full
> multigrain timestamps is the fact that we have one filesystem, one on-dis=
k
> format etc. The only slight trouble could be that if we previously handed
> out something in low bits of ctime for XFS, we need to keep handing the
> same thing out until the inode changes (i.e., no rounding until the momen=
t
> inode changes) as the old timestamp could be stored somewhere externally
> and compared.
>=20
> 								Honza
>=20
> [1] https://lore.kernel.org/all/ZTjMRRqmlJ+fTys2@dread.disaster.area/
>=20
>=20

Got it. That makes sense and could probably be made to work.
Doing that all in XFS won't be simple though. You'll need to reimplement
stuff like file_modified() and file_update_time(). Those get called from
deep within the VFS and from page fault handlers.

FWIW, that's the main reason the multigrain work was so invasive, even
though it was a filesystem-specific feature.
--=20
Jeff Layton <jlayton@kernel.org>

