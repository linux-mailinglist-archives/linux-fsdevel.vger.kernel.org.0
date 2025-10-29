Return-Path: <linux-fsdevel+bounces-66302-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B171CC1B33D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 15:28:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B9C08507CD7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 13:49:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADE593502A2;
	Wed, 29 Oct 2025 13:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kS2IntEj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFA0F34FF63;
	Wed, 29 Oct 2025 13:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761745202; cv=none; b=j2qUloR6kdqmn1QQ7Rn/RLettipWNXO6r1lLRWQBad3opxOujr0I2J1HZyTj/7m7fmchHMBpojwk8s3nE80nsDFrdO9das9NRXYk6jpQ5A1pFAHn2sKhphmRyD2eSyNgSkZBNak1NBRIi5+P6AAUDQDkT/jnoA6bQOPyIjVDi9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761745202; c=relaxed/simple;
	bh=Qinq6giTwi2ySMiAwThTVWg/TdY5jx7j7hNrly2hSwk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BZVq1fXMHU9/YtjjNgih6y66Z1LjtZNaCwLD2dqv1Wd0vJRmS6uQuySHhv5X4+NezjcmeMbHdXz6hqPLll9LoromUY7Wn7n01IFnGhJfqWvTdgdq5lwxzjVTH7ho3OvK7iySjBID2wu6amgXVzsqc2HqUubYX/aZF6WZ1E2bWB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kS2IntEj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EE4CC4CEF7;
	Wed, 29 Oct 2025 13:39:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761745200;
	bh=Qinq6giTwi2ySMiAwThTVWg/TdY5jx7j7hNrly2hSwk=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=kS2IntEjZYOOgJCFT5GpuNXIgsoPZv5v4n+ew2r3YNWrqBlmyCfwwHl7BcL/H1JTA
	 pGwCA7liMENAIAbyxfuTMjsqIHpm2mAF7LMfgOkRE6V7WmEZvrsyHnzp0CNcKj/Z5a
	 fY383GhPJ/0as8F9jw6+8chK/OLdSQ8Eg3/4cdW5KlkABa/St/WTnAaz+AoGlmTDuP
	 3XbMzLwIKYfo1O1X6yAVUCMTIaVzOY5+TGqicvwCyQ42ScEWm2j9GTxHdoNXatGzZe
	 lZzD6jTDSvifhWr5o98hR1aJ40wLRgyC/IBJPJkL8KwWvJzLfkGju/GZilrslRjWOs
	 861kBa1wOyUEQ==
Message-ID: <c3ee834daeaa7a5dbd73bd3c94b12ee5353a9b2e.camel@kernel.org>
Subject: Re: [PATCH v3 00/13] vfs: recall-only directory delegations for
 knfsd
From: Jeff Layton <jlayton@kernel.org>
To: Christian Brauner <brauner@kernel.org>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Alexander Viro
 <viro@zeniv.linux.org.uk>,  Jan Kara <jack@suse.cz>, Chuck Lever
 <chuck.lever@oracle.com>, Alexander Aring <alex.aring@gmail.com>,  Trond
 Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, Steve
 French <sfrench@samba.org>, Paulo Alcantara <pc@manguebit.org>, Ronnie
 Sahlberg <ronniesahlberg@gmail.com>, Shyam Prasad N	
 <sprasad@microsoft.com>, Tom Talpey <tom@talpey.com>, Bharath SM	
 <bharathsm@microsoft.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
  "Rafael J. Wysocki"	 <rafael@kernel.org>, Danilo Krummrich
 <dakr@kernel.org>, David Howells	 <dhowells@redhat.com>, Tyler Hicks
 <code@tyhicks.com>, NeilBrown <neil@brown.name>,  Olga Kornievskaia
 <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, Amir Goldstein
 <amir73il@gmail.com>, Namjae Jeon	 <linkinjeon@kernel.org>, Steve French
 <smfrench@gmail.com>, Sergey Senozhatsky	 <senozhatsky@chromium.org>,
 Carlos Maiolino <cem@kernel.org>, Kuniyuki Iwashima	 <kuniyu@google.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet	
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni	
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org, 
	samba-technical@lists.samba.org, netfs@lists.linux.dev,
 ecryptfs@vger.kernel.org, 	linux-unionfs@vger.kernel.org,
 linux-xfs@vger.kernel.org, netdev@vger.kernel.org
Date: Wed, 29 Oct 2025 09:39:55 -0400
In-Reply-To: <20251029-scham-munkeln-53f3dd551a91@brauner>
References: <20251021-dir-deleg-ro-v3-0-a08b1cde9f4c@kernel.org>
	 <20251029-scham-munkeln-53f3dd551a91@brauner>
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

On Wed, 2025-10-29 at 14:38 +0100, Christian Brauner wrote:
> On Tue, Oct 21, 2025 at 11:25:35AM -0400, Jeff Layton wrote:
> > Behold, another version of directory delegations. This version contains
> > support for recall-only delegations. Support for CB_NOTIFY will be
> > forthcoming (once the client-side patches have caught up).
> >=20
> > This main differences in this version are bugfixes, but the last patch
> > adds a more formal API for userland to request a delegation. That
> > support is optional. We can drop it and the rest of the series should b=
e
> > fine.
> >=20
> > My main interest in making delegations available to userland is to allo=
w
> > testing this support without nfsd. I have an xfstest ready to submit fo=
r
> > this if that support looks acceptable. If it is, then I'll also plan to
> > submit an update for fcntl(2).
> >=20
> > Christian, Chuck mentioned he was fine with you merging the nfsd bits
> > too, if you're willing to take the whole pile.
>=20
> This all looks good to me btw. The only thing I'm having issues with is:
>=20
>  Base: base-commit d2ced3cadfab04c7e915adf0a73c53fcf1642719 not known, ig=
noring
>  Base: attempting to guess base-commit...
>  Base: tags/v6.18-rc1-23-g2c09630d09c6 (best guess, 21/27 blobs matched)
>  Base: v6.18-rc1
> Magic: Preparing a sparse worktree
> Unable to cleanly apply series, see failure log below
> ---
> Applying: filelock: push the S_ISREG check down to ->setlease handlers
> Applying: vfs: add try_break_deleg calls for parents to vfs_{link,rename,=
unlink}
> Applying: vfs: allow mkdir to wait for delegation break on parent
> Applying: vfs: allow rmdir to wait for delegation break on parent
> Patch failed at 0004 vfs: allow rmdir to wait for delegation break on par=
ent
> error: invalid object 100644 423dd102b51198ea7c447be2b9a0a5020c950dba for=
 'fs/nfsd/nfs4recover.c'
> error: Repository lacks necessary blobs to fall back on 3-way merge.
> hint: Use 'git am --show-current-patch=3Ddiff' to see the failed patch
> hint: When you have resolved this problem, run "git am --continue".
> hint: If you prefer to skip this patch, run "git am --skip" instead.
> hint: To restore the original branch and stop patching, run "git am --abo=
rt".
> hint: Disable this message with "git config advice.mergeConflict false"
>=20
> That commit isn't in -next nor in any of my branches?
> Can you resend on top of: vfs-6.19.directory.delegations please?
>=20

Will do. It's a simple fix. I had based this on top of fs-next, which
has Chuck's tree in it too.

> >=20
> > Thanks!
> > Jeff
> >=20
> > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > ---
> > Changes in v3:
> > - Fix potential nfsd_file refcount leaks on GET_DIR_DELEGATION error
> > - Add missing parent dir deleg break in vfs_symlink()
> > - Add F_SETDELEG/F_GETDELEG support to fcntl()
> > - Link to v2: https://lore.kernel.org/r/20251017-dir-deleg-ro-v2-0-8c8f=
6dd23c8b@kernel.org
> >=20
> > Changes in v2:
> > - handle lease conflict resolution inside of nfsd
> > - drop the lm_may_setlease lock_manager operation
> > - just add extra argument to vfs_create() instead of creating wrapper
> > - don't allocate fsnotify_mark for open directories
> > - Link to v1: https://lore.kernel.org/r/20251013-dir-deleg-ro-v1-0-4067=
80a70e5e@kernel.org
> >=20
> > ---
> > Jeff Layton (13):
> >       filelock: push the S_ISREG check down to ->setlease handlers
> >       vfs: add try_break_deleg calls for parents to vfs_{link,rename,un=
link}
> >       vfs: allow mkdir to wait for delegation break on parent
> >       vfs: allow rmdir to wait for delegation break on parent
> >       vfs: break parent dir delegations in open(..., O_CREAT) codepath
> >       vfs: make vfs_create break delegations on parent directory
> >       vfs: make vfs_mknod break delegations on parent directory
> >       vfs: make vfs_symlink break delegations on parent dir
> >       filelock: lift the ban on directory leases in generic_setlease
> >       nfsd: allow filecache to hold S_IFDIR files
> >       nfsd: allow DELEGRETURN on directories
> >       nfsd: wire up GET_DIR_DELEGATION handling
> >       vfs: expose delegation support to userland
> >=20
> >  drivers/base/devtmpfs.c    |   6 +-
> >  fs/cachefiles/namei.c      |   2 +-
> >  fs/ecryptfs/inode.c        |  10 +--
> >  fs/fcntl.c                 |   9 +++
> >  fs/fuse/dir.c              |   1 +
> >  fs/init.c                  |   6 +-
> >  fs/locks.c                 |  68 +++++++++++++++-----
> >  fs/namei.c                 | 150 +++++++++++++++++++++++++++++++++++--=
--------
> >  fs/nfs/nfs4file.c          |   2 +
> >  fs/nfsd/filecache.c        |  57 ++++++++++++-----
> >  fs/nfsd/filecache.h        |   2 +
> >  fs/nfsd/nfs3proc.c         |   2 +-
> >  fs/nfsd/nfs4proc.c         |  22 ++++++-
> >  fs/nfsd/nfs4recover.c      |   6 +-
> >  fs/nfsd/nfs4state.c        | 103 ++++++++++++++++++++++++++++++-
> >  fs/nfsd/state.h            |   5 ++
> >  fs/nfsd/vfs.c              |  16 ++---
> >  fs/nfsd/vfs.h              |   2 +-
> >  fs/open.c                  |   2 +-
> >  fs/overlayfs/overlayfs.h   |  10 +--
> >  fs/smb/client/cifsfs.c     |   3 +
> >  fs/smb/server/vfs.c        |   8 +--
> >  fs/xfs/scrub/orphanage.c   |   2 +-
> >  include/linux/filelock.h   |  12 ++++
> >  include/linux/fs.h         |  13 ++--
> >  include/uapi/linux/fcntl.h |  10 +++
> >  net/unix/af_unix.c         |   2 +-
> >  27 files changed, 425 insertions(+), 106 deletions(-)
> > ---
> > base-commit: d2ced3cadfab04c7e915adf0a73c53fcf1642719
> > change-id: 20251013-dir-deleg-ro-d0fe19823b21
> >=20
> > Best regards,
> > --=20
> > Jeff Layton <jlayton@kernel.org>
> >=20

--=20
Jeff Layton <jlayton@kernel.org>

