Return-Path: <linux-fsdevel+bounces-14488-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CD61687D187
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Mar 2024 17:53:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D36D1F23199
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Mar 2024 16:53:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4289D495E5;
	Fri, 15 Mar 2024 16:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nPSxfnA0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 856A845BE1;
	Fri, 15 Mar 2024 16:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710521587; cv=none; b=rzWOPMDm95IdN/0YWtrwXTK69BIm+r13hJb6anCnh+0WlqRLV+NHpVdtC0grNUo1ibPKzHUAA3S50LJJpUKjx0h6ofAoAKQ1EISMEUZCDjkggFntiLDK0khIe2e4+wZRQbvlZzAGF//OzsUZIK5ue+fYTVf6s7taIGsej0eG8eM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710521587; c=relaxed/simple;
	bh=qYctyXGEOoZXV6Jh8OrILzQOvS7D8Y2IuiQCeaSls9A=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ijdLTwJhKeuEbN0jO8p0zMQDLSnEUGE6RX03C4PQ5GSF58XBeUDqW+Xon0gfRiBehSjoY/jCRfmNW5LqR1DKPPkOBpeoYglC14aZjGc+6I7GtjdTYMDO6NxDLr///4zPC1qBH1M7FZrnmf9XXn8YPmnrctlhnLCB6M7cNS41IBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nPSxfnA0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07B64C433F1;
	Fri, 15 Mar 2024 16:53:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710521587;
	bh=qYctyXGEOoZXV6Jh8OrILzQOvS7D8Y2IuiQCeaSls9A=;
	h=From:Subject:Date:To:Cc:From;
	b=nPSxfnA0NHvOyANVe4L+CLdzIHMbJ6G1FEbax+MoZilCvP6jyio9LFQ9avi16uOKE
	 45PJHVmSARkIaZE3+Zg9gYMeQ60+F7YgtEuf6RXwrSzau5+Emyf8RFM8er61XNq3CH
	 qHRaQ1JIJhDw9H5uCJvyGoKGCyvbkLJemR/EPUiYpjAojWp/jr5KSJbke9XEFYzuo7
	 bQvMj0M24b+c8lnJq8HujEREygx3yFdqQtvhuECka3dZrZurid7knDwEt+t3ra98TG
	 FmkYUz9V+UTNszGaz0coC5c8HRp5V3KSqhLsMi5Gplo4zG69sWu3NGrjq65j+5EY4E
	 Bjh3b1O3dQLdg==
From: Jeff Layton <jlayton@kernel.org>
Subject: [PATCH RFC 00/24] vfs, nfsd, nfs: implement directory delegations
Date: Fri, 15 Mar 2024 12:52:51 -0400
Message-Id: <20240315-dir-deleg-v1-0-a1d6209a3654@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOR89GUC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDI0NT3ZTMIt2U1JzUdN1UI0MjI0ODpETLFBMloPqCotS0zAqwWdFKQW7
 OSrG1tQD7IB8JYAAAAA==
To: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Chuck Lever <chuck.lever@oracle.com>, 
 Alexander Aring <alex.aring@gmail.com>, 
 Trond Myklebust <trond.myklebust@hammerspace.com>, 
 Anna Schumaker <anna@kernel.org>, Steve French <sfrench@samba.org>, 
 Paulo Alcantara <pc@manguebit.com>, 
 Ronnie Sahlberg <ronniesahlberg@gmail.com>, 
 Shyam Prasad N <sprasad@microsoft.com>, Tom Talpey <tom@talpey.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 David Howells <dhowells@redhat.com>, Tyler Hicks <code@tyhicks.com>, 
 Neil Brown <neilb@suse.de>, Olga Kornievskaia <kolga@netapp.com>, 
 Dai Ngo <Dai.Ngo@oracle.com>, Miklos Szeredi <miklos@szeredi.hu>, 
 Amir Goldstein <amir73il@gmail.com>, Namjae Jeon <linkinjeon@kernel.org>, 
 Sergey Senozhatsky <senozhatsky@chromium.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org, 
 samba-technical@lists.samba.org, netfs@lists.linux.dev, 
 ecryptfs@vger.kernel.org, linux-unionfs@vger.kernel.org, 
 netdev@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=7113; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=qYctyXGEOoZXV6Jh8OrILzQOvS7D8Y2IuiQCeaSls9A=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBl9HzsIFPO4qmRNI+ITLK0st6aVgzmSJbLcGqra
 AThOkCTgOeJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZfR87AAKCRAADmhBGVaC
 FaGeEAChIS9AQaRvxbB+6LQSElzXukcCCobpzzUO21Dhx8VFbVzHqQH2W+mMjIN7UALlOxT9VEZ
 h6VaIkDGob695Aqi/wq/Qm0BEpd+XKO2Y4IuMDP8A+8+k2J3j4mdyz6nDWJiiau0Ng5EF4pb3Sq
 vhYUy7Bpu0culANSYWXqs930FVPqaqshNWVtRKIGHMW3/VZEpB8O0XLkFT0OW4fhHW5+FHl8rkd
 CuYP5bWk2xk0b4+ZEwvBvDJ0Zc9mndRNQMbbFQr0G4WhwISQO3BKf4zK/21jYhCfJd3FsasqQgh
 Lhnce75SrlI1HWO+ozACZGrm3yhF9rirXGZScKNUsFJAz+9b1J1gQ4vDVj5EDdRUzAp7V54p3Wl
 2EtHjlUtNot+NPK2wBzdM1zg8m70t6JV4STWgn8WKQPMy8xG/HMUnSkKIDG4NWpKmIoQO/qiQCD
 46ufSgaK1lFYVA9RNtHjy3+8JctkIlBOOuxV/AZgN887cSSAwI06oI7v9YzqUDhhetqMLaJFoDQ
 ZJOqa+wMvuxhA94xB1lPPDAnQaG2g2Ebkleu4lSoAj8PPP/HP17Fj5a0935G32oPb+jcdU0cbDw
 7bU+U3cGLl3b962IHh3XyLos88DpoLOHtdwmX11r2usfdvcX6iGHfwv2UVDo7uDyNvsPkrjNbWE
 z53diDtmAR7ssuA==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

NFSv4.1 adds a new GET_DIR_DELEGATION operation, to allow clients
to request a delegation on a directory. If the client holds a directory
delegation, then it knows that nothing will change the dentries in it
until it has been recalled.

Last year, Rick Macklem gave a talk at the NFS Bakeathon on his
implementation of directory delegations for FreeBSD [1], and showed that
it can greatly improve LOOKUP-heavy workloads. There is also some
earlier work by CITI [2] that showed similar results. The SMB protocol
also has a similar sort of construct, and they have also seen great
performance improvements from it.

This patchset adds minimal support for directory delegations to the VFS
layer, and and plumbs support for GET_DIR_DELEGATION handling into nfsd.
It also has a set of patches for the NFS client. The VFS and server-side
bits all seem to work now and do the right thing. The client side is
still very much a WIP since it relies more on policy and heuristics.

What I've found is that without directory delegations in play, the
client usually revalidates dentries by issuing a GETATTR for the parent.
If it holds a delegation on the parent, it can avoid that GETATTR, which
is a nice benefit.

But...the catch is that the Linux NFS client defaults to caching
dentries for 30-60s before revalidating them. The attrcache timeout
quickly ends up as 60s on directories that aren't changing, so for a
delegation to be useful, you need to be revalidating dentries in the
same directory over a rather long span of time. Even then, at best it'll
be optimizing away one GETATTR per inode every 60s or so.

I've done a little ad-hoc testing with kernel builds, but they don't
show much benefit from this. Testing with them both enabled and
disabled, the kernel builds finished within 5 seconds of one another on
a 12.5 minute build, which is insignificant.

The GETATTR load seems to be reduced by about 7% with dir delegs
enabled, which is nice, but GETATTRs are usually pretty lightweight
anyway, and we do have the overhead of dir delegations to deal with.

There is a lot of room for improvement that could make this more
compelling:

1) The client's logic for fetching a delegation is probably too
   primitive. Maybe we need to request one only after every 3-5
   revalidations?

2) The client uses the same "REFERENCED" timeout for dir delegations
   as it does for clients. It could probably benefit from holding them
   longer by default. I'm not sure how best to do that.

3) The protocol allows for clients and server to use asynchronous
   notifications to avoid issuing delegation breaks when there are
   changes to a delegated directory. That's not implemented yet,
   but it could change the calculus here for workloads where multiple
   clients are accessing and changing child dentries.

4) A GET_DIR_DELEGATION+READDIR compound could be worthwhile. If we have
   all of the dentries in the directory, then we could (in principle)
   satisfy any negtive dentry lookup w/o going to the server. If they're
   all in the correct order on d_subdirs, we could satisfy a readdir
   via dcache_readdir without going to the server.

5) The server could probably avoid handing them out if the inode changed
   <60s in the past?

For the VFS and NFSD bits, I mainly want to get some early feedback.
Does this seem like a reasonable approach? Anyone see major problems
with handling directory delegations in the VFS codepaths?

The NFS client bits are quite a bit more rough.  Is there a better
heuristic for when to request a dir delegation? I could use a bit of
guidance here.

[1]: https://www.youtube.com/watch?v=DdFyH3BN5pI
[2]: https://linux-nfs.org/wiki/index.php/CITI_Experience_with_Directory_Delegations

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
Jeff Layton (24):
      filelock: push the S_ISREG check down to ->setlease handlers
      filelock: add a lm_set_conflict lease_manager callback
      vfs: add try_break_deleg calls for parents to vfs_{link,rename,unlink}
      vfs: allow mkdir to wait for delegation break on parent
      vfs: allow rmdir to wait for delegation break on parent
      vfs: break parent dir delegations in open(..., O_CREAT) codepath
      vfs: make vfs_create break delegations on parent directory
      vfs: make vfs_mknod break delegations on parent directory
      filelock: lift the ban on directory leases in generic_setlease
      nfsd: allow filecache to hold S_IFDIR files
      nfsd: allow DELEGRETURN on directories
      nfsd: encoders and decoders for GET_DIR_DELEGATION
      nfsd: check for delegation conflicts vs. the same client
      nfsd: wire up GET_DIR_DELEGATION handling
      nfs: fix nfs_stateid_hash prototype when CONFIG_CRC32 isn't set
      nfs: remove unused NFS_CALL macro
      nfs: add cache_validity to the nfs_inode_event tracepoints
      nfs: add a tracepoint to nfs_inode_detach_delegation_locked
      nfs: new tracepoint in nfs_delegation_need_return
      nfs: new tracepoint in match_stateid operation
      nfs: add a GDD_GETATTR rpc operation
      nfs: skip dentry revalidation when parent dir has a delegation
      nfs: optionally request a delegation on GETATTR
      nfs: add a module parameter to disable directory delegations

 drivers/base/devtmpfs.c   |   6 +-
 fs/cachefiles/namei.c     |   2 +-
 fs/ecryptfs/inode.c       |   8 +--
 fs/init.c                 |   4 +-
 fs/locks.c                |  12 +++-
 fs/namei.c                | 101 ++++++++++++++++++++++++++++------
 fs/nfs/delegation.c       |   5 ++
 fs/nfs/dir.c              |  20 +++++++
 fs/nfs/internal.h         |   2 +-
 fs/nfs/nfs4file.c         |   2 +
 fs/nfs/nfs4proc.c         |  55 ++++++++++++++++++-
 fs/nfs/nfs4trace.h        | 104 +++++++++++++++++++++++++++++++++++
 fs/nfs/nfs4xdr.c          | 136 ++++++++++++++++++++++++++++++++++++++++++++++
 fs/nfs/nfstrace.h         |   8 ++-
 fs/nfsd/filecache.c       |  37 +++++++++++--
 fs/nfsd/filecache.h       |   2 +
 fs/nfsd/nfs3proc.c        |   2 +-
 fs/nfsd/nfs4proc.c        |  49 +++++++++++++++++
 fs/nfsd/nfs4recover.c     |   6 +-
 fs/nfsd/nfs4state.c       | 112 +++++++++++++++++++++++++++++++++++++-
 fs/nfsd/nfs4xdr.c         |  72 +++++++++++++++++++++++-
 fs/nfsd/state.h           |   5 ++
 fs/nfsd/vfs.c             |  13 +++--
 fs/nfsd/vfs.h             |   2 +-
 fs/nfsd/xdr4.h            |   8 +++
 fs/open.c                 |   2 +-
 fs/overlayfs/overlayfs.h  |   8 +--
 fs/smb/client/cifsfs.c    |   3 +
 fs/smb/server/vfs.c       |   8 +--
 include/linux/filelock.h  |  10 ++++
 include/linux/fs.h        |  11 ++--
 include/linux/nfs4.h      |   6 ++
 include/linux/nfs_fs.h    |   1 +
 include/linux/nfs_fs_sb.h |   1 +
 include/linux/nfs_xdr.h   |   9 +--
 net/unix/af_unix.c        |   2 +-
 36 files changed, 754 insertions(+), 80 deletions(-)
---
base-commit: b80a250a20975e30ff8635dd75d6d20bf05405a1
change-id: 20240215-dir-deleg-e212210ba9d4

Best regards,
-- 
Jeff Layton <jlayton@kernel.org>


