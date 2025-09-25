Return-Path: <linux-fsdevel+bounces-62783-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DE1DBA0BFB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Sep 2025 19:08:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0DFF316ACCF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Sep 2025 17:08:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C140630B527;
	Thu, 25 Sep 2025 17:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y+JoObfz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2F67277C8F;
	Thu, 25 Sep 2025 17:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758820095; cv=none; b=UF5pS/hbCvtcrOk9hNH6ZpEv90vusX3LqOJqwq+uZlh2W76LGV9cKgcpdAkKCHDFQ1RPCpa6oMjZsZQxHvrHD3x3zRYj9tmGjT6dIROMVAJkDRbmYSbhciMNOWA74ogxvM5RLOzZw3DD8zOVDRQ0ieTyUHVmGeURICh4Cu9eAA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758820095; c=relaxed/simple;
	bh=6HwOUkB0yToBaYa1glGfR0wga34tK3y6ETCOnEezSa4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YuDTLprrU4VAV+yy6Z+gy8VMPjTSlXKYeYFwIEvBuwJUtkRWEeKKxyjGPK5KfDJjwdaqnbAduzaamTxy/AC5jxbRseSMu1+hucQEsEAvihO5z7tqDt8vyBvWRUPa1+MO3KSzVLKdKfzqSxHwsHVuNNJdriQWIGUpnSYE49TgdbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y+JoObfz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55E60C4CEF0;
	Thu, 25 Sep 2025 17:08:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758820094;
	bh=6HwOUkB0yToBaYa1glGfR0wga34tK3y6ETCOnEezSa4=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=Y+JoObfzDbCmu9AkTyqHCIH8JTaAPFRuffUKiUBZa4ged8sp7zN40k6ugKI9mdPK5
	 zz6cv7UJ805SecPvfXUvMtwegfc1QjzvrbWO1FDMynHdxfDGdz+6uhKiRCQ8pEQ+6a
	 X3O8M7oQ7gy6cWZsG8YSvtBwgDMDoeqvB1iut916uwhbbzNque5a4FV6/r3VmIxM1i
	 4uhGmy09P4zEmg8fLbWHLZJRcziVdHttOF/7GcVcre4N/3seyM6WqiZy1YweFX9To2
	 DhDHbB2mLSZQbeZNMH/8jQFQOwBl7T88eF6uxTym0+/Qa2X3Kz6P/Ustve/9+NWRcE
	 mQJfgXXslcR2w==
Message-ID: <77d7000f15341c20d254a7804e08b3b252cc4e52.camel@kernel.org>
Subject: Re: [PATCH v3 00/38] vfs, nfsd: implement directory delegations
From: Jeff Layton <jlayton@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>, Alexander Viro	
 <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara
	 <jack@suse.cz>, Alexander Aring <alex.aring@gmail.com>, Trond Myklebust	
 <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, Steve French	
 <sfrench@samba.org>, Ronnie Sahlberg <ronniesahlberg@gmail.com>, Shyam
 Prasad N	 <sprasad@microsoft.com>, Tom Talpey <tom@talpey.com>, Bharath SM	
 <bharathsm@microsoft.com>, NeilBrown <neil@brown.name>, Olga Kornievskaia	
 <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, Jonathan Corbet	
 <corbet@lwn.net>, Amir Goldstein <amir73il@gmail.com>, Miklos Szeredi	
 <miklos@szeredi.hu>, Paulo Alcantara <pc@manguebit.org>, Greg Kroah-Hartman
	 <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
 Danilo Krummrich	 <dakr@kernel.org>, David Howells <dhowells@redhat.com>,
 Tyler Hicks	 <code@tyhicks.com>, Namjae Jeon <linkinjeon@kernel.org>, Steve
 French	 <smfrench@gmail.com>, Sergey Senozhatsky
 <senozhatsky@chromium.org>, Carlos Maiolino <cem@kernel.org>, Steven
 Rostedt <rostedt@goodmis.org>, Masami Hiramatsu	 <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Rick Macklem <rick.macklem@gmail.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-nfs@vger.kernel.org, 
	linux-cifs@vger.kernel.org, samba-technical@lists.samba.org, 
	linux-doc@vger.kernel.org, netfs@lists.linux.dev, ecryptfs@vger.kernel.org,
 	linux-unionfs@vger.kernel.org, linux-xfs@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org
Date: Thu, 25 Sep 2025 13:08:10 -0400
In-Reply-To: <e8889519-ca38-430f-b79c-790dabacafac@oracle.com>
References: <20250924-dir-deleg-v3-0-9f3af8bc5c40@kernel.org>
	 <e8889519-ca38-430f-b79c-790dabacafac@oracle.com>
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

On Thu, 2025-09-25 at 09:39 -0400, Chuck Lever wrote:
> On 9/24/25 11:05 AM, Jeff Layton wrote:
> > This patchset is an update to a patchset that I posted in early June
> > this year [1]. This version should be basically feature-complete, with =
a
> > few caveats.
> >=20
> > NFSv4.1 adds a GET_DIR_DELEGATION operation, to allow clients
> > to request a delegation on a directory. If the client holds a directory
> > delegation, then it knows that nothing will change the dentries in it
> > until it has been recalled (modulo the case where the client requests
> > notifications of directory changes).
> >=20
> > In 2023, Rick Macklem gave a talk at the NFS Bakeathon on his
> > implementation of directory delegations for FreeBSD [2], and showed tha=
t
> > it can greatly improve LOOKUP-heavy workloads. There is also some
> > earlier work by CITI [3] that showed similar results. The SMB protocol
> > also has a similar sort of construct, and they have also seen large
> > performance improvements on certain workloads.
> >=20
> > This version also starts with support for trivial directory delegations
> > that support no notifications.  From there it adds VFS support for
> > ignoring certain break_lease() events in directories. It then adds
> > support for basic CB_NOTIFY calls (with names only). Next, support for
> > sending attributes in the notifications is added.
> >=20
> > I think that this version should be getting close to merge ready. Anna
> > has graciously agreed to work on the client-side pieces for this. I've
> > mostly been testing using pynfs tests (which I will submit soon).
> >=20
> > The main limitation at this point is that callback requests are
> > currently limited to a single page, so we can't send very many in a
> > single CB_NOTIFY call. This will make it easy to "get into the weeds" i=
f
> > you're changing a directory quickly. The server will just recall the
> > delegation in that case, so it's harmless even though it's not ideal.
> >=20
> > If this approach looks acceptable I'll see if we can increase that
> > limitation (it seems doable).
> >=20
> > If anyone wishes to try this out, it's in the "dir-deleg" branch in my
> > tree at kernel.org [4].
> >=20
> > [1]: https://lore.kernel.org/linux-nfs/20250602-dir-deleg-v2-0-a7919700=
de86@kernel.org/
> > [2]: https://www.youtube.com/watch?v=3DDdFyH3BN5pI
> > [3]: https://linux-nfs.org/wiki/index.php/CITI_Experience_with_Director=
y_Delegations
> > [4]: https://git.kernel.org/pub/scm/linux/kernel/git/jlayton/linux.git/
> >=20
> > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > ---
> > Changes in v3:
> > - Rework to do minimal work in fsnotify callbacks
> > - Add support for sending attributes in CB_NOTIFY calls
> > - Add support for dir attr change notifications
> > - Link to v2: https://lore.kernel.org/r/20250602-dir-deleg-v2-0-a791970=
0de86@kernel.org
> >=20
> > Changes in v2:
> > - add support for ignoring certain break_lease() events
> > - basic support for CB_NOTIFY
> > - Link to v1: https://lore.kernel.org/r/20240315-dir-deleg-v1-0-a1d6209=
a3654@kernel.org
> >=20
> > ---
> > Jeff Layton (38):
> >       filelock: push the S_ISREG check down to ->setlease handlers
> >       filelock: add a lm_may_setlease lease_manager callback
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
> >       nfsd: check for delegation conflicts vs. the same client
> >       nfsd: wire up GET_DIR_DELEGATION handling
> >       filelock: rework the __break_lease API to use flags
> >       filelock: add struct delegated_inode
> >       filelock: add support for ignoring deleg breaks for dir change ev=
ents
> >       filelock: add a tracepoint to start of break_lease()
> >       filelock: add an inode_lease_ignore_mask helper
> >       nfsd: add protocol support for CB_NOTIFY
> >       nfs_common: add new NOTIFY4_* flags proposed in RFC8881bis
> >       nfsd: allow nfsd to get a dir lease with an ignore mask
> >       vfs: add fsnotify_modify_mark_mask()
> >       nfsd: update the fsnotify mark when setting or removing a dir del=
egation
> >       nfsd: make nfsd4_callback_ops->prepare operation bool return
> >       nfsd: add callback encoding and decoding linkages for CB_NOTIFY
> >       nfsd: add data structures for handling CB_NOTIFY to directory del=
egation
> >       nfsd: add notification handlers for dir events
> >       nfsd: add tracepoint to dir_event handler
> >       nfsd: apply the notify mask to the delegation when requested
> >       nfsd: add helper to marshal a fattr4 from completed args
> >       nfsd: allow nfsd4_encode_fattr4_change() to work with no export
> >       nfsd: send basic file attributes in CB_NOTIFY
> >       nfsd: allow encoding a filehandle into fattr4 without a svc_fh
> >       nfsd: add a fi_connectable flag to struct nfs4_file
> >       nfsd: add the filehandle to returned attributes in CB_NOTIFY
> >       nfsd: properly track requested child attributes
> >       nfsd: track requested dir attributes
> >       nfsd: add support to CB_NOTIFY for dir attribute changes
> >=20
> >  Documentation/sunrpc/xdr/nfs4_1.x    | 267 +++++++++++++++++-
> >  drivers/base/devtmpfs.c              |   2 +-
> >  fs/attr.c                            |   4 +-
> >  fs/cachefiles/namei.c                |   2 +-
> >  fs/ecryptfs/inode.c                  |   2 +-
> >  fs/fuse/dir.c                        |   1 +
> >  fs/init.c                            |   2 +-
> >  fs/locks.c                           | 122 ++++++--
> >  fs/namei.c                           | 253 +++++++++++------
> >  fs/nfs/nfs4file.c                    |   2 +
> >  fs/nfsd/filecache.c                  | 101 +++++--
> >  fs/nfsd/filecache.h                  |   2 +
> >  fs/nfsd/nfs4callback.c               |  60 +++-
> >  fs/nfsd/nfs4layouts.c                |   3 +-
> >  fs/nfsd/nfs4proc.c                   |  36 ++-
> >  fs/nfsd/nfs4recover.c                |   2 +-
> >  fs/nfsd/nfs4state.c                  | 531 +++++++++++++++++++++++++++=
++++++--
> >  fs/nfsd/nfs4xdr.c                    | 298 +++++++++++++++++---
> >  fs/nfsd/nfs4xdr_gen.c                | 506 +++++++++++++++++++++++++++=
+++++-
> >  fs/nfsd/nfs4xdr_gen.h                |  20 +-
> >  fs/nfsd/state.h                      |  73 ++++-
> >  fs/nfsd/trace.h                      |  21 ++
> >  fs/nfsd/vfs.c                        |   7 +-
> >  fs/nfsd/vfs.h                        |   2 +-
> >  fs/nfsd/xdr4.h                       |   3 +
> >  fs/nfsd/xdr4cb.h                     |  12 +
> >  fs/notify/mark.c                     |  29 ++
> >  fs/open.c                            |   8 +-
> >  fs/overlayfs/overlayfs.h             |   2 +-
> >  fs/posix_acl.c                       |  12 +-
> >  fs/smb/client/cifsfs.c               |   3 +
> >  fs/smb/server/vfs.c                  |   2 +-
> >  fs/utimes.c                          |   4 +-
> >  fs/xattr.c                           |  16 +-
> >  fs/xfs/scrub/orphanage.c             |   2 +-
> >  include/linux/filelock.h             | 143 +++++++---
> >  include/linux/fs.h                   |  11 +-
> >  include/linux/fsnotify_backend.h     |   1 +
> >  include/linux/nfs4.h                 | 127 ---------
> >  include/linux/sunrpc/xdrgen/nfs4_1.h | 304 +++++++++++++++++++-
> >  include/linux/xattr.h                |   4 +-
> >  include/trace/events/filelock.h      |  38 ++-
> >  include/uapi/linux/nfs4.h            |   2 -
> >  43 files changed, 2636 insertions(+), 406 deletions(-)
> > ---
> > base-commit: 36c204d169319562eed170f266c58460d5dad635
> > change-id: 20240215-dir-deleg-e212210ba9d4
> >=20
> > Best regards,
>=20
> Series is clean and easy to read, thanks for your hard work! I agree
> that the NFSD portions appear to be complete and ready to accept.
>=20
> Because the series is cross-subsystem, we will need to discuss a merge
> plan. So I'll hold off on R-b or Acked until that is nailed down.
>=20

Thanks. It's sensible to hold off for a bit. There is at least one leak
that I found earlier today, and a few cleanups that I have queued up.

We also have a bake-a-thon in another couple of weeks where I hope to
test this more extensively. After that, I'm hoping we'll be in
reasonable shape to take it into linux-next.

What I may do is reorder the vfs patches to the front of the queue and
plead to Christian and Al to take them into a branch that feeds into
linux-next. That way we can at least get some feedback and testing with
those bits in place, and a foundation on which we can merge the nfsd
bits.

--=20
Jeff Layton <jlayton@kernel.org>

