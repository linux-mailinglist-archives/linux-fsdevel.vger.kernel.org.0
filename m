Return-Path: <linux-fsdevel+bounces-64624-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 91077BEE6AA
	for <lists+linux-fsdevel@lfdr.de>; Sun, 19 Oct 2025 16:18:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3D4464E4585
	for <lists+linux-fsdevel@lfdr.de>; Sun, 19 Oct 2025 14:18:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 150702EB5BA;
	Sun, 19 Oct 2025 14:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QF1ZKDnx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29ADB21FF4A;
	Sun, 19 Oct 2025 14:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760883482; cv=none; b=EZNw2BONiz5vC6C7e2eLYwMmQC+bKs9HJGQea+NQ/okbl+sjV1VCIQkI474RH/lq3Z8ljU9EhI6l+E3+YWHr4WwtNDdGxT/zB7DjiTWJ+ne+WNlbw7r7lYyd4TKrLALZa5texs+DxHSOWJfrggPau5q1FlRo1J/4Wgj5qZgK3zQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760883482; c=relaxed/simple;
	bh=vrXYWgR9uRU087VqRnV8tgrLtFPdV6Vnal19D1rVo54=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QgV43f7IxtFx2Dr9H+AdpPHR5YTRZ6aqlHJOj7rqbuvwFadpQsXqseUD6BCkrgNuL05Rsp8N7eoD5F32aon9meNlDwk8h/g078mR/67k5PgAcrPYL8EI8YOO15t6Zfqmj9gyndiLqMR1JR+uv2NJBtsesmAobQwnQrm4E3ZVtRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QF1ZKDnx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A4A9C4CEF1;
	Sun, 19 Oct 2025 14:17:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760883481;
	bh=vrXYWgR9uRU087VqRnV8tgrLtFPdV6Vnal19D1rVo54=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=QF1ZKDnxd73pRqQR7fHMSgXJzLeanlq55VKyJWjm+0STwYP7h3AxYHM6lzRpQCGm1
	 isRI5p6IR079g/3PRTYsHr3YdqFhD9T8tf25p2XSB+1LHBLGN0I8SgRh3ikY9hjM67
	 s6Gbd5ULzegNjHzQ1Argu1kgyNceGHfm0/IYG4pux1jWZ7cCvhCaYbAJy05xhA0m5+
	 ez63bSonpbET7olGhMqeKPdk5Tigs8ec7jz8RyoYsy/90jkEmiieRwGmoCDZEQqWfn
	 SXYA78GLhkz1tzM+ftBtwh5RR6nmD84zHBede93+kklPKu/PCMGPNlXUKPj6apOWkP
	 9ouqrF99hc9DA==
Message-ID: <1e009577aaae1af56dc66dadcfc05caf5d4c6b72.camel@kernel.org>
Subject: Re: [PATCH v2 00/11] vfs: recall-only directory delegations for
 knfsd
From: Jeff Layton <jlayton@kernel.org>
To: NeilBrown <neil@brown.name>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Alexander Viro
 <viro@zeniv.linux.org.uk>,  Christian Brauner	 <brauner@kernel.org>, Jan
 Kara <jack@suse.cz>, Chuck Lever	 <chuck.lever@oracle.com>, Alexander Aring
 <alex.aring@gmail.com>, Trond Myklebust <trondmy@kernel.org>, Anna
 Schumaker <anna@kernel.org>, Steve French <sfrench@samba.org>,  Paulo
 Alcantara	 <pc@manguebit.org>, Ronnie Sahlberg <ronniesahlberg@gmail.com>,
 Shyam Prasad N	 <sprasad@microsoft.com>, Tom Talpey <tom@talpey.com>,
 Bharath SM	 <bharathsm@microsoft.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>,  "Rafael J. Wysocki"	 <rafael@kernel.org>,
 Danilo Krummrich <dakr@kernel.org>, David Howells	 <dhowells@redhat.com>,
 Tyler Hicks <code@tyhicks.com>, Olga Kornievskaia	 <okorniev@redhat.com>,
 Dai Ngo <Dai.Ngo@oracle.com>, Amir Goldstein	 <amir73il@gmail.com>, Namjae
 Jeon <linkinjeon@kernel.org>, Steve French	 <smfrench@gmail.com>, Sergey
 Senozhatsky <senozhatsky@chromium.org>, Carlos Maiolino <cem@kernel.org>,
 Kuniyuki Iwashima <kuniyu@google.com>, "David S. Miller"	
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski	
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman	
 <horms@kernel.org>, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, 	linux-nfs@vger.kernel.org,
 linux-cifs@vger.kernel.org, 	samba-technical@lists.samba.org,
 netfs@lists.linux.dev, ecryptfs@vger.kernel.org, 
	linux-unionfs@vger.kernel.org, linux-xfs@vger.kernel.org,
 netdev@vger.kernel.org
Date: Sun, 19 Oct 2025 10:17:57 -0400
In-Reply-To: <176074466364.1793333.7771684363912648120@noble.neil.brown.name>
References: <20251017-dir-deleg-ro-v2-0-8c8f6dd23c8b@kernel.org>
	 <176074466364.1793333.7771684363912648120@noble.neil.brown.name>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=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
 QZIQXVeAA+smfTT0tDrisj1U5x6ZB9b3nBg65kc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sat, 2025-10-18 at 10:44 +1100, NeilBrown wrote:
> On Fri, 17 Oct 2025, Jeff Layton wrote:
> > A smaller variation of the v1 patchset that I posted earlier this week.
> > Neil's review inspired me to get rid of the lm_may_setlease operation
> > and to do the conflict resolution internally inside of nfsd. That means
> > a smaller VFS-layer change, and an overall reduction in code.
> >=20
> > This patchset adds support for directory delegations to nfsd. This
> > version only supports recallable delegations. There is no CB_NOTIFY
> > support yet. I have patches for those, but we've decided to add that
> > support in a later kernel once we get some experience with this part.
> > Anna is working on the client-side pieces.
> >=20
> > It would be great if we could get into linux-next soon so that it can b=
e
> > merged for v6.19. Christian, could you pick up the vfs/filelock patches=
,
> > and Chuck pick up the nfsd patches?
> >=20
> > Thanks!
> > Jeff
> >=20
> > [1]: https://lore.kernel.org/all/20240315-dir-deleg-v1-0-a1d6209a3654@k=
ernel.org/
> >=20
> > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > ---
> > Changes in v2:
> > - handle lease conflict resolution inside of nfsd
> > - drop the lm_may_setlease lock_manager operation
> > - just add extra argument to vfs_create() instead of creating wrapper
> > - don't allocate fsnotify_mark for open directories
> > - Link to v1: https://lore.kernel.org/r/20251013-dir-deleg-ro-v1-0-4067=
80a70e5e@kernel.org
> >=20
> > ---
> > Jeff Layton (11):
> >       filelock: push the S_ISREG check down to ->setlease handlers
> >       vfs: add try_break_deleg calls for parents to vfs_{link,rename,un=
link}
> >       vfs: allow mkdir to wait for delegation break on parent
> >       vfs: allow rmdir to wait for delegation break on parent
> >       vfs: break parent dir delegations in open(..., O_CREAT) codepath
> >       vfs: make vfs_create break delegations on parent directory
> >       vfs: make vfs_mknod break delegations on parent directory
> >       filelock: lift the ban on directory leases in generic_setlease
> >       nfsd: allow filecache to hold S_IFDIR files
> >       nfsd: allow DELEGRETURN on directories
> >       nfsd: wire up GET_DIR_DELEGATION handling
>=20
> vfs_symlink() is missing from the updated APIs.  Surely that needs to be
> able to wait for a delegation to break.
>=20

Ouch! That's a major oversight. I'll fix that up.

> vfs_mkobj() maybe does too, but I could easily turn a blind eye to that.
>=20
> I haven't looked properly at the last patch but all the other could have
>  Reviewed-by: NeilBrown <neil@brown.name>
>=20
> once the vfs_symlink() omission is fixed.
>=20
> NeilBrown


Chuck found a couple of potential leaks in there so those will also
need to be fixed. As I was writing some xfstests for the VFS pieces, I
found another problem too:

Currently the F_SETLEASE API sets FL_LEASE leases, but the new
delegation breaks that this set adds don't break FL_LEASE leases, since
these are FL_DELEG leases.

This distinction is mostly due to historical reasons. Leases were added
first (for Samba oplocks), but didn't break on metadata changes. When
Bruce added delegations, he wanted to ensure that the lease API didn't
suddenly change behavior.

I see several potential options to fix this:

1/ The simplest is to just make the F_SETLEASE command set FL_DELEG
leases when the inode is a directory. That makes for a messy userland
interface where files get FL_LEASE objects, but directories get
FL_DELEG. I think that will be less useful for userland.

2/ Don't expose this to userland at all (yet?), and just keep returning
EINVAL on attempts to set a lease on a directory. The downside there is
that this would require us to use nfsd for testing this functionality.
Less people will do that than would if it were an xfstest that ran on
most local filesystems. I do have some pynfs tests though which could
help cover the gap.

3/ Add new F_SETDELEG/F_GETDELEG fcntl() commands. The nice thing about
this is that it would also allow us to add a flags field to these
commands. The later patches that add CB_NOTIFY support add the ability
to ignore certain types of delegation break events. This option would
allow us to expose that functionality to userland too. NFS Ganesha and
Samba, for example, could make use of this.

#3 wouldn't be too difficult (aside from having to update the
manpages), so I kind of like that idea.

Thoughts?
--=20
Jeff Layton <jlayton@kernel.org>

