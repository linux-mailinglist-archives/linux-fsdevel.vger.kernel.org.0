Return-Path: <linux-fsdevel+bounces-8990-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0128883C965
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jan 2024 18:09:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A476C28E095
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jan 2024 17:09:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEF2712A17E;
	Thu, 25 Jan 2024 17:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QdfN0skv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE2FC12FF81;
	Thu, 25 Jan 2024 17:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706202060; cv=none; b=f4/aYJ+VWcZCFivyJJL1UTc7LysZbGERgSGCO7hT+he3cOyx3307l+9IEzXGvZ3zinTJasy9/k9rweMN7qL/3e8hVSQcfH7bQAjf0zOQGaLA72XWwdbIM4pRwg54CDpws//L6NIMGpyaScAf+QqzPaESN6nqMOUJ2z5bN8RcL4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706202060; c=relaxed/simple;
	bh=H8IBspkwmRfy9bqg3eKhwZcIGGOrbhoil+KGMN1foAg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KBI31llcmgnbnc0+e7jBehhxmO3D2sZYkCqiklldZpnFnCFI60uxtWxijIe6MvAYpqX9Om8P8/RXVQRT1ZjH0p8Aa6XtmWUmZyK21cDeFpNZlTlbbzls/RaKFkyVnLZOiW9YU5lcOO11qi3fIb5PpyKuPmnPtYE5E2cb6H9FoZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QdfN0skv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41875C43394;
	Thu, 25 Jan 2024 17:00:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706202059;
	bh=H8IBspkwmRfy9bqg3eKhwZcIGGOrbhoil+KGMN1foAg=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=QdfN0skvyqqh5QZBw5Iu1WYqhbsfJa5rp6S6qxloGxPYwbLWQmfs+VZ5f0ZMs0P27
	 jqWWpOEHdeKOMX52A3TWVKKXD35r4on9zrx5o7/gYUGcajpWNiOz4pQLESvTbkTB5p
	 0nDQ4a+zdB80xjAAz1tclpenCHRq68GVd0isoEtEYC7jwNFtXQAoWETKv/fZzHxBdM
	 +wVaMdyd4/k9uwnro1pVpO6oijl7jxGX04/bgRa6KlF2s/rqP52BdykaP1wk8lUvYL
	 7V9lO5X8U/G5qN2jO6+IhlC84p3K2Lh0T8KV60S8dUoGv/J515ABZv3Ex7bZ1RvKfn
	 D/VLG2AGMS6YA==
Message-ID: <94225dc3b16b254cd7c25cbc79b192f657514814.camel@kernel.org>
Subject: Re: [PATCH v2 00/41] filelock: split struct file_lock into
 file_lock and file_lease structs
From: Jeff Layton <jlayton@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>
Cc: Christian Brauner <brauner@kernel.org>, Alexander Viro
 <viro@zeniv.linux.org.uk>, Eric Van Hensbergen <ericvh@kernel.org>, 
 Latchesar Ionkov <lucho@ionkov.net>, Dominique Martinet
 <asmadeus@codewreck.org>, Christian Schoenebeck <linux_oss@crudebyte.com>,
 David Howells <dhowells@redhat.com>, Marc Dionne
 <marc.dionne@auristor.com>, Xiubo Li <xiubli@redhat.com>, Ilya Dryomov
 <idryomov@gmail.com>, Alexander Aring <aahringo@redhat.com>, David Teigland
 <teigland@redhat.com>, Miklos Szeredi <miklos@szeredi.hu>, Andreas
 Gruenbacher <agruenba@redhat.com>, Trond Myklebust
 <trond.myklebust@hammerspace.com>,  Anna Schumaker <anna@kernel.org>, Neil
 Brown <neilb@suse.de>, Olga Kornievskaia <kolga@netapp.com>, Dai Ngo
 <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,  Jan Kara
 <jack@suse.cz>, Mark Fasheh <mark@fasheh.com>, Joel Becker
 <jlbec@evilplan.org>, Joseph Qi <joseph.qi@linux.alibaba.com>, Steve French
 <sfrench@samba.org>, Paulo Alcantara <pc@manguebit.com>, Shyam Prasad N
 <sprasad@microsoft.com>, Namjae Jeon <linkinjeon@kernel.org>, Sergey
 Senozhatsky <senozhatsky@chromium.org>,  Steven Rostedt
 <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, Mathieu
 Desnoyers <mathieu.desnoyers@efficios.com>, Ronnie Sahlberg
 <ronniesahlberg@gmail.com>,  linux-kernel@vger.kernel.org,
 v9fs@lists.linux.dev,  linux-afs@lists.infradead.org,
 ceph-devel@vger.kernel.org, gfs2@lists.linux.dev, 
 linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org, 
 ocfs2-devel@lists.linux.dev, linux-cifs@vger.kernel.org, 
 linux-trace-kernel@vger.kernel.org
Date: Thu, 25 Jan 2024 12:00:54 -0500
In-Reply-To: <ZbJ2zc3I3uBwF/RE@tissot.1015granger.net>
References: <20240125-flsplit-v2-0-7485322b62c7@kernel.org>
	 <ZbJ2zc3I3uBwF/RE@tissot.1015granger.net>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=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
	kZWuOsJdJQdmwlWC5L5ln9xgfr/4mOY38B0U=
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 (3.50.3-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-01-25 at 09:57 -0500, Chuck Lever wrote:
> On Thu, Jan 25, 2024 at 05:42:41AM -0500, Jeff Layton wrote:
> > Long ago, file locks used to hang off of a singly-linked list in struct
> > inode. Because of this, when leases were added, they were added to the
> > same list and so they had to be tracked using the same sort of
> > structure.
> >=20
> > Several years ago, we added struct file_lock_context, which allowed us
> > to use separate lists to track different types of file locks. Given
> > that, leases no longer need to be tracked using struct file_lock.
> >=20
> > That said, a lot of the underlying infrastructure _is_ the same between
> > file leases and locks, so we can't completely separate everything.
> >=20
> > This patchset first splits a group of fields used by both file locks an=
d
> > leases into a new struct file_lock_core, that is then embedded in struc=
t
> > file_lock. Coccinelle was then used to convert a lot of the callers to
> > deal with the move, with the remaining 25% or so converted by hand.
> >=20
> > It then converts several internal functions in fs/locks.c to work
> > with struct file_lock_core. Lastly, struct file_lock is split into
> > struct file_lock and file_lease, and the lease-related APIs converted t=
o
> > take struct file_lease.
> >=20
> > After the first few patches (which I left split up for easier review),
> > the set should be bisectable. I'll plan to squash the first few
> > together to make sure the resulting set is bisectable before merge.
> >=20
> > Finally, I left the coccinelle scripts I used in tree. I had heard it
> > was preferable to merge those along with the patches that they
> > generate, but I wasn't sure where they go. I can either move those to a
> > more appropriate location or we can just drop that commit if it's not
> > needed.
> >=20
> > Signed-off-by: Jeff Layton <jlayton@kernel.org>
>=20
> v2 looks nicer.
>=20
> I would add a few list handling primitives, as I see enough
> instances of list_for_each_entry, list_for_each_entry_safe,
> list_first_entry, and list_first_entry_or_null on fl_core.flc_list
> to make it worth having those.
>=20
> Also, there doesn't seem to be benefit for API consumers to have to
> understand the internal structure of struct file_lock/lease to reach
> into fl_core. Having accessor functions for common fields like
> fl_type and fl_flags could be cleaner.
>=20

That is a good suggestion. I had considered it before and figured "why
bother", but I think that would make things simpler.

I'll plan to do a v3 that has more helpers. Possibly we can just convert
some of the subsystems ahead of time and avoid some churn. Stay tuned...

> For the series:
>=20
> Reviewed-by: Chuck Lever <chuck.lever@oracle.com>
>=20
> For the nfsd and lockd parts:
>=20
> Acked-by: Chuck Lever <chuck.lever@oracle.com>
>=20
>=20
> > ---
> > Changes in v2:
> > - renamed file_lock_core fields to have "flc_" prefix
> > - used macros to more easily do the change piecemeal
> > - broke up patches into per-subsystem ones
> > - Link to v1: https://lore.kernel.org/r/20240116-flsplit-v1-0-c9d0f4370=
a5d@kernel.org
> >=20
> > ---
> > Jeff Layton (41):
> >       filelock: rename some fields in tracepoints
> >       filelock: rename fl_pid variable in lock_get_status
> >       dlm: rename fl_flags variable in dlm_posix_unlock
> >       nfs: rename fl_flags variable in nfs4_proc_unlck
> >       nfsd: rename fl_type and fl_flags variables in nfsd4_lock
> >       lockd: rename fl_flags and fl_type variables in nlmclnt_lock
> >       9p: rename fl_type variable in v9fs_file_do_lock
> >       afs: rename fl_type variable in afs_next_locker
> >       filelock: drop the IS_* macros
> >       filelock: split common fields into struct file_lock_core
> >       filelock: add coccinelle scripts to move fields to struct file_lo=
ck_core
> >       filelock: have fs/locks.c deal with file_lock_core directly
> >       filelock: convert some internal functions to use file_lock_core i=
nstead
> >       filelock: convert more internal functions to use file_lock_core
> >       filelock: make posix_same_owner take file_lock_core pointers
> >       filelock: convert posix_owner_key to take file_lock_core arg
> >       filelock: make locks_{insert,delete}_global_locks take file_lock_=
core arg
> >       filelock: convert locks_{insert,delete}_global_blocked
> >       filelock: make __locks_delete_block and __locks_wake_up_blocks ta=
ke file_lock_core
> >       filelock: convert __locks_insert_block, conflict and deadlock che=
cks to use file_lock_core
> >       filelock: convert fl_blocker to file_lock_core
> >       filelock: clean up locks_delete_block internals
> >       filelock: reorganize locks_delete_block and __locks_insert_block
> >       filelock: make assign_type helper take a file_lock_core pointer
> >       filelock: convert locks_wake_up_blocks to take a file_lock_core p=
ointer
> >       filelock: convert locks_insert_lock_ctx and locks_delete_lock_ctx
> >       filelock: convert locks_translate_pid to take file_lock_core
> >       filelock: convert seqfile handling to use file_lock_core
> >       9p: adapt to breakup of struct file_lock
> >       afs: adapt to breakup of struct file_lock
> >       ceph: adapt to breakup of struct file_lock
> >       dlm: adapt to breakup of struct file_lock
> >       gfs2: adapt to breakup of struct file_lock
> >       lockd: adapt to breakup of struct file_lock
> >       nfs: adapt to breakup of struct file_lock
> >       nfsd: adapt to breakup of struct file_lock
> >       ocfs2: adapt to breakup of struct file_lock
> >       smb/client: adapt to breakup of struct file_lock
> >       smb/server: adapt to breakup of struct file_lock
> >       filelock: remove temporary compatability macros
> >       filelock: split leases out of struct file_lock
> >=20
> >  cocci/filelock.cocci            |  88 +++++
> >  cocci/nlm.cocci                 |  81 ++++
> >  fs/9p/vfs_file.c                |  40 +-
> >  fs/afs/flock.c                  |  59 +--
> >  fs/ceph/locks.c                 |  74 ++--
> >  fs/dlm/plock.c                  |  44 +--
> >  fs/gfs2/file.c                  |  16 +-
> >  fs/libfs.c                      |   2 +-
> >  fs/lockd/clnt4xdr.c             |  14 +-
> >  fs/lockd/clntlock.c             |   2 +-
> >  fs/lockd/clntproc.c             |  65 +--
> >  fs/lockd/clntxdr.c              |  14 +-
> >  fs/lockd/svc4proc.c             |  10 +-
> >  fs/lockd/svclock.c              |  64 +--
> >  fs/lockd/svcproc.c              |  10 +-
> >  fs/lockd/svcsubs.c              |  24 +-
> >  fs/lockd/xdr.c                  |  14 +-
> >  fs/lockd/xdr4.c                 |  14 +-
> >  fs/locks.c                      | 848 ++++++++++++++++++++++----------=
--------
> >  fs/nfs/delegation.c             |   4 +-
> >  fs/nfs/file.c                   |  22 +-
> >  fs/nfs/nfs3proc.c               |   2 +-
> >  fs/nfs/nfs4_fs.h                |   2 +-
> >  fs/nfs/nfs4file.c               |   2 +-
> >  fs/nfs/nfs4proc.c               |  39 +-
> >  fs/nfs/nfs4state.c              |  22 +-
> >  fs/nfs/nfs4trace.h              |   4 +-
> >  fs/nfs/nfs4xdr.c                |   8 +-
> >  fs/nfs/write.c                  |   8 +-
> >  fs/nfsd/filecache.c             |   4 +-
> >  fs/nfsd/nfs4callback.c          |   2 +-
> >  fs/nfsd/nfs4layouts.c           |  34 +-
> >  fs/nfsd/nfs4state.c             | 118 +++---
> >  fs/ocfs2/locks.c                |  12 +-
> >  fs/ocfs2/stack_user.c           |   2 +-
> >  fs/open.c                       |   2 +-
> >  fs/posix_acl.c                  |   4 +-
> >  fs/smb/client/cifsfs.c          |   2 +-
> >  fs/smb/client/cifssmb.c         |   8 +-
> >  fs/smb/client/file.c            |  76 ++--
> >  fs/smb/client/smb2file.c        |   2 +-
> >  fs/smb/server/smb2pdu.c         |  44 +--
> >  fs/smb/server/vfs.c             |  14 +-
> >  include/linux/filelock.h        |  80 ++--
> >  include/linux/fs.h              |   5 +-
> >  include/linux/lockd/lockd.h     |   8 +-
> >  include/linux/lockd/xdr.h       |   2 +-
> >  include/trace/events/afs.h      |   4 +-
> >  include/trace/events/filelock.h | 102 ++---
> >  49 files changed, 1198 insertions(+), 923 deletions(-)
> > ---
> > base-commit: 615d300648869c774bd1fe54b4627bb0c20faed4
> > change-id: 20240116-flsplit-bdb46824db68
> >=20
> > Best regards,
> > --=20
> > Jeff Layton <jlayton@kernel.org>
> >=20
>=20

--=20
Jeff Layton <jlayton@kernel.org>

