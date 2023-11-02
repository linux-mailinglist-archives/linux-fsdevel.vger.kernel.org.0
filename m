Return-Path: <linux-fsdevel+bounces-1803-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 05B787DEFAC
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Nov 2023 11:18:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 879161F22628
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Nov 2023 10:18:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAA7E134DC;
	Thu,  2 Nov 2023 10:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GPzXf+02"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F287134BD
	for <linux-fsdevel@vger.kernel.org>; Thu,  2 Nov 2023 10:17:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42655C433C8;
	Thu,  2 Nov 2023 10:17:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698920276;
	bh=bpWiJO3vrZtaIhf4lJAzkNfBmBiB4Rlew74U352mP2c=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=GPzXf+02TCcU8r7ah904XYsjziscTwo8ubIMx0FnRpAc0grUJB/LjtGbUvypwzPWH
	 z2YGVH+Ieghb7Zv8phNGcsZo29LVQp/tUIkwbgrRts8XVe0VPs8Ln/n+1DqHBiDgCQ
	 GkeZKPYeW1hxdR7F51croDYL7gTK40NJo0vo/TjFs4zUFq9SPFfx9nCBsUz54pqcFZ
	 IjmMGHHIGM9YLTJ+Qmd5jyiQrDbf69piUW4JCbvNhBWw6UUr7YnzF3c1T2MkcWYMWf
	 AVnlg5GKxgAMrRf7y9VnmNDhbKnB7WDGuraRJr0U3ut39E/oV6N8iyoCLIDPbeuhqL
	 FKjqFi4uhzMCg==
Message-ID: <3ec97baef1ebbbd7ace97a7d7023bf3f36e1cbc7.camel@kernel.org>
Subject: Re: [PATCH RFC 2/9] timekeeping: new interfaces for multigrain
 timestamp handing
From: Jeff Layton <jlayton@kernel.org>
To: Amir Goldstein <amir73il@gmail.com>, Jan Kara <jack@suse.cz>
Cc: Dave Chinner <david@fromorbit.com>, Linus Torvalds
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
Date: Thu, 02 Nov 2023 06:17:53 -0400
In-Reply-To: <CAOQ4uxgGxtErFEcSdxoFDnZZ1XfmVKn2LT1dQcJqhNj5_rnC6A@mail.gmail.com>
References: <ZTjMRRqmlJ+fTys2@dread.disaster.area>
	 <2ef9ac6180e47bc9cc8edef20648a000367c4ed2.camel@kernel.org>
	 <ZTnNCytHLGoJY9ds@dread.disaster.area>
	 <6df5ea54463526a3d898ed2bd8a005166caa9381.camel@kernel.org>
	 <ZUAwFkAizH1PrIZp@dread.disaster.area>
	 <CAHk-=wg4jyTxO8WWUc1quqSETGaVsPHh8UeFUROYNwU-fEbkJg@mail.gmail.com>
	 <ZUBbj8XsA6uW8ZDK@dread.disaster.area>
	 <CAOQ4uxgSRw26J+MPK-zhysZX9wBkXFRNx+n1bwnQwykCJ1=F4Q@mail.gmail.com>
	 <3d6a4c21626e6bbb86761a6d39e0fafaf30a4a4d.camel@kernel.org>
	 <ZUF4NTxQXpkJADxf@dread.disaster.area>
	 <20231101101648.zjloqo5su6bbxzff@quack3>
	 <CAOQ4uxgGxtErFEcSdxoFDnZZ1XfmVKn2LT1dQcJqhNj5_rnC6A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2023-11-01 at 13:38 +0200, Amir Goldstein wrote:
> On Wed, Nov 1, 2023 at 12:16=E2=80=AFPM Jan Kara <jack@suse.cz> wrote:
> >=20
> > On Wed 01-11-23 08:57:09, Dave Chinner wrote:
> > > 5. When-ever the inode is persisted, the timestamp is copied to the
> > > on-disk structure and the current change counter is folded in.
> > >=20
> > >       This means the on-disk structure always contains the latest
> > >       change attribute that has been persisted, just like we
> > >       currently do with i_version now.
> > >=20
> > > 6. When-ever we read the inode off disk, we split the change counter
> > > from the timestamp and update the appropriate internal structures
> > > with this information.
> > >=20
> > >       This ensures that the VFS and userspace never see the change
> > >       counter implementation in the inode timestamps.
> >=20
> > OK, but is this compatible with the current XFS behavior? AFAICS curren=
tly
> > XFS sets sb->s_time_gran to 1 so timestamps currently stored on disk wi=
ll
> > have some mostly random garbage in low bits of the ctime. Now if you lo=
ok
> > at such inode with a kernel using this new scheme, stat(2) will report
> > ctime with low bits zeroed-out so if the ctime fetched in the old kerne=
l was
> > stored in some external database and compared to the newly fetched ctim=
e, it
> > will appear that ctime has gone backwards... Maybe we don't care but it=
 is
> > a user visible change that can potentially confuse something.
>=20
> See xfs_inode_has_bigtime() and auto-upgrade of inode format in
> xfs_inode_item_precommit().
>=20
> In the case of BIGTIME inode format, admin needs to opt-in to
> BIGTIME format conversion by setting an INCOMPAT_BIGTIME
> sb feature flag.
>=20
> I imagine that something similar (inode flag + sb flag) would need
> to be done for the versioned-timestamp, but I think that in that case,
> the feature flag could be RO_COMPAT - there is no harm in exposing
> made-up nsec lower bits if fs would be mounted read-only on an old
> kernel, is there?
>=20
> The same RO_COMPAT feature flag could also be used to determine
> s_time_gran, because IIUC, s_time_gran for timestamp updates
> is uniform across all inodes.
>=20
> I know that Dave said he wants to avoid changing on-disk format,
> but I am hoping that this well defined and backward compat with
> lazy upgrade, on-disk format change may be acceptable?


With the ctime, we're somewhat saved by the fact that it's not settable
by users, so we don't need to worry as much about returning specific
values there, I think.

With the scheme Dave is proposing, booting to a new kernel vs. an old
kernel might show a different ctime on an inode though. That might be
enough to justify needing a way to opt-in to the change on existing
filesystems.
--=20
Jeff Layton <jlayton@kernel.org>

