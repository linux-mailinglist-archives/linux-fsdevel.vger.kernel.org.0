Return-Path: <linux-fsdevel+bounces-50330-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4396FACB087
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Jun 2025 16:06:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC2071BA64EB
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Jun 2025 14:03:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53374223DCD;
	Mon,  2 Jun 2025 14:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mIqSRB0w"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BAA51E3772;
	Mon,  2 Jun 2025 14:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748872942; cv=none; b=So3nR2d/b1s4UyQwWjKHRJVnmgENL8XOPs+SxybE3yzZdInNkVpjUUwqqvovAUESmuR673lamPWwVjrZdZBOhcb5hJ4BnkAUmLqTzGUTnZf9bUvHWKL92IOA6vkJltUXuyF++Pj4HPGj8lxKicohQZwRGq5hgpWBNr4Ydf/bc8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748872942; c=relaxed/simple;
	bh=iIK4xHtP2iB/dMVlgTRCrs6Nyv+GOjdTvMOXVehLvCw=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=eO65RsKcV0AJN1imAw/V9M0NaKFBsahK3Ga4VC/EvqMR8G7dsq0gG7ecRPK8KnUcXJhECb0yqdaoXHu7a5lh93pWtiCMS+0mFsHtxrNC+XQEn0w8eLdG7y/+HYvTctH9CGqiuZJER5xOdHhSTUG2WsWJtjEfWhm9fd+yltvE/C8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mIqSRB0w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F4F6C4CEEE;
	Mon,  2 Jun 2025 14:02:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748872942;
	bh=iIK4xHtP2iB/dMVlgTRCrs6Nyv+GOjdTvMOXVehLvCw=;
	h=From:Subject:Date:To:Cc:From;
	b=mIqSRB0wQgPqhsxVa/yNSBhTCnxYbWnQUlvlv69wc4Cq4E4u1+vwhXioO/ND29wuI
	 B5q5s+kF23ftfWNv2ruuBNEOPTlLoAk9ixsMZcqW6PZnKnzzMMTCvHVjNig1ksB+Aa
	 YD5JGnPJKlUPM/ohytpr2Pc+JCgxR23mDwbN/2kU7Oo0GU7/F6zbx/RAwnsZIpBfHn
	 FDTbwV3AB31MX1aZxS+tKtMiFELxaBKSSYGsTdGCER5cTLzKTkuuTT9WIXlgCNAHbR
	 hn1g4c/lUBMn5v8nv6am8MO3m1tr1IPNmK84fYgbz/wesGHiOGwjIRVfHlCncZdXUQ
	 e4rTXpkfcqKZw==
From: Jeff Layton <jlayton@kernel.org>
Subject: [PATCH RFC v2 00/28] vfs, nfsd, nfs: implement directory
 delegations
Date: Mon, 02 Jun 2025 10:01:43 -0400
Message-Id: <20250602-dir-deleg-v2-0-a7919700de86@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMeuPWgC/1XMSwrCMBAG4KuUWRvJTB9QV4LgAdxKF9GM7WBJZ
 CJFKb27ITuX/4NvhcQqnOBQraC8SJIYcqBdBffJhZGN+JyBLDWWsDVe1HieeTRMSIT25nrfQP6
 /lB/yKdYVLucTDLmcJL2jfou/YJkKVf9RCxprHPqObO/qrm2OT9bA8z7qCMO2bT/XK23mqAAAA
 A==
X-Change-ID: 20240215-dir-deleg-e212210ba9d4
To: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Chuck Lever <chuck.lever@oracle.com>, 
 Alexander Aring <alex.aring@gmail.com>, 
 Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
 Steve French <sfrench@samba.org>, Paulo Alcantara <pc@manguebit.com>, 
 Ronnie Sahlberg <ronniesahlberg@gmail.com>, 
 Shyam Prasad N <sprasad@microsoft.com>, Tom Talpey <tom@talpey.com>, 
 Bharath SM <bharathsm@microsoft.com>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Jonathan Corbet <corbet@lwn.net>, Amir Goldstein <amir73il@gmail.com>, 
 Miklos Szeredi <miklos@szeredi.hu>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org, 
 samba-technical@lists.samba.org, linux-doc@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=7294; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=iIK4xHtP2iB/dMVlgTRCrs6Nyv+GOjdTvMOXVehLvCw=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBoPa7eH4dxLZMTDUBiNfi1m6jZ0a8U8aP49Cb4o
 QXXiOiXSFmJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaD2u3gAKCRAADmhBGVaC
 FQlxEAC7HyMj6Wi4Cj2ZXRnQ6tLUiAPql3kGQ6b+4TnB4C5INTYH7QJn6GyrOCsIWBLZs7RmO1Q
 OWJUM5dpkulxHcf0SZRjhHJrL4jTxxpEjaNJyCs6uwmLF8xEmJYOpuRC5bGeylO6YFVA4VMa7d9
 sL/zck8SI6v5sCFz82OKq4sdpCUqLwUSltgIvme+NYwcLCyIrxfPD629U39PecA2Fjj07lObW8Z
 0CcWx6ktdW7qGKdefjnwMfXB4VSH3BbBBfxn0KZO51xscytcGwbtVmBZrfV0ji8ltYXZTON8twR
 vdFB6tzhYQH+U16o9DXnReztt6CIhRxAUq8yvv3BjlDZAOiGl8BoIQHgn1JSxQ00+nmZheWm8kX
 2ixcydZyThSs0rTCmfwF1aQuHZoK1Uufs98/J9VLGPWx6jI5CO6NrT04TEO8UmMKystNLkwCdw/
 LTs6FPreZIf4fWk+/O2jdcmZY7pvQvDyvp64Fw+Vg+RVIj20vrjfZ3jV2Ys/b4nEy+LOvc2CNwY
 TbqDGl7Jp/cS6BcU2vNsEkYuAYgQn1v1KnPkRLthM3vw58O9peuOTyYvYJf9pMoAaLdYGW6++1Z
 BDcrfBdS5uvbRUM3Jj+WdpETlHmM+JBs2SCloiRD9foknEAo64p/XEE4pGLSxiy8gc0Ha3qWzMe
 jbZtKoCl7Di4jOA==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

This patchset is an update to a patchset that I posted just over a year
ago [1]. That version had client and server patches. This one is just
the server-side patches.

NFSv4.1 adds a GET_DIR_DELEGATION operation, to allow clients
to request a delegation on a directory. If the client holds a directory
delegation, then it knows that nothing will change the dentries in it
until it has been recalled.

In 2023, Rick Macklem gave a talk at the NFS Bakeathon on his
implementation of directory delegations for FreeBSD [2], and showed that
it can greatly improve LOOKUP-heavy workloads. There is also some
earlier work by CITI [3] that showed similar results. The SMB protocol
also has a similar sort of construct, and they have also seen large
performance improvements on certain workloads.

This version also starts with support for trivial directory delegations.
From there it adds VFS support for ignoring certain break_lease() events
on on directories. The server can then request leases that ignore
certain events (like a create or delete) and set its fsnotify mask to
receive a callback after that event occurs. That allows it to avoid
breaking the lease.

When a fsnotify callback comes in, the server will encode the
information directly as XDR in a buffer attached to the delegation. The
CB_NOTIFY callback is then queued, which will scoop up that buffer and
allocate another to start gathering more events.  If it runs out of
space to spool events, it will give up and trigger a recall of the
delegation.

This is still a work-in-progress however:

The main thing missing at this point is support for sending attributes
in the CB_NOTIFY, particularly on ADD events. The right set of fattrs
would allow the client to instantiate a dentry and inode without having
to contact the server.

Still, it's getting close to the point where the server side is somewhat
functional so it's a good time to post what I have so far.

Anna has graciously agreed to work on the client-side pieces. I do have
some patches, but that piece is still pretty rough:

    https://git.kernel.org/pub/scm/linux/kernel/git/jlayton/linux.git/log/?h=dir-deleg-clnt

In a nutshell, the client-side GDD4 support is still simplistic, and
there is no support for CB_NOTIFY yet.

I also have a MR up for wireshark [4], and I have patches for some basic
pynfs tests that I've been using to drive the server (to be posted
soon).

At this point I'm mainly interested in feedback on the VFS bits,
particularly the delegated_inode changes. Also, I should make special
mention of atomic_open since Al pointed it out in the last set:

I think we can't reasonably support dir delegations on filesystems that
support atomic_open. When we do a create on those filesystems, we don't
know whether the file exists or not, so we can't know whether we need to
break a dir delegation.

It would be nice to have a compile-time check for that, but I'm not sure
how we could reasonably do it. For now, I've settled for disabling
directory leases in FUSE, NFS and CIFS, which should work around the
potential problem.

[1]: https://lore.kernel.org/linux-nfs/20240315-dir-deleg-v1-0-a1d6209a3654@kernel.org/
[2]: https://www.youtube.com/watch?v=DdFyH3BN5pI
[3]: https://linux-nfs.org/wiki/index.php/CITI_Experience_with_Directory_Delegations
[4]: https://gitlab.com/wireshark/wireshark/-/merge_requests/20048

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
Changes in v2:
- add support for ignoring certain break_lease() events
- basic support for CB_NOTIFY
- Link to v1: https://lore.kernel.org/r/20240315-dir-deleg-v1-0-a1d6209a3654@kernel.org

---
Jeff Layton (28):
      filelock: push the S_ISREG check down to ->setlease handlers
      filelock: add a lm_may_setlease lease_manager callback
      vfs: add try_break_deleg calls for parents to vfs_{link,rename,unlink}
      vfs: allow mkdir to wait for delegation break on parent
      vfs: allow rmdir to wait for delegation break on parent
      vfs: break parent dir delegations in open(..., O_CREAT) codepath
      vfs: make vfs_create break delegations on parent directory
      vfs: make vfs_mknod break delegations on parent directory
      filelock: lift the ban on directory leases in generic_setlease
      nfsd: allow filecache to hold S_IFDIR files
      nfsd: allow DELEGRETURN on directories
      nfsd: check for delegation conflicts vs. the same client
      nfsd: wire up GET_DIR_DELEGATION handling
      filelock: rework the __break_lease API to use flags
      filelock: add struct delegated_inode
      filelock: add support for ignoring deleg breaks for dir change events
      filelock: add an inode_lease_ignore_mask helper
      nfsd: add protocol support for CB_NOTIFY
      nfsd: add callback encoding and decoding linkages for CB_NOTIFY
      nfsd: add data structures for handling CB_NOTIFY to directory delegation
      fsnotify: export fsnotify_recalc_mask()
      nfsd: update the fsnotify mark when setting or removing a dir delegation
      nfsd: make nfsd4_callback_ops->prepare operation bool return
      nfsd: add notification handlers for dir events
      nfsd: allow nfsd to get a dir lease with an ignore mask
      nfsd: add a tracepoint for nfsd_file_fsnotify_handle_dir_event()
      nfsd: add support for NOTIFY4_ADD_ENTRY events
      nfsd: add support for NOTIFY4_RENAME_ENTRY events

 Documentation/sunrpc/xdr/nfs4_1.x    | 252 ++++++++++++++++-
 fs/attr.c                            |   4 +-
 fs/fuse/dir.c                        |   1 +
 fs/locks.c                           | 120 ++++++--
 fs/namei.c                           | 296 ++++++++++++-------
 fs/nfs/nfs4file.c                    |   2 +
 fs/nfsd/filecache.c                  | 103 +++++--
 fs/nfsd/filecache.h                  |   2 +
 fs/nfsd/nfs4callback.c               |  60 +++-
 fs/nfsd/nfs4layouts.c                |   3 +-
 fs/nfsd/nfs4proc.c                   |  24 +-
 fs/nfsd/nfs4state.c                  | 535 +++++++++++++++++++++++++++++++++--
 fs/nfsd/nfs4xdr_gen.c                | 506 ++++++++++++++++++++++++++++++++-
 fs/nfsd/nfs4xdr_gen.h                |  17 +-
 fs/nfsd/state.h                      |  47 ++-
 fs/nfsd/trace.h                      |  26 +-
 fs/nfsd/vfs.c                        |   5 +-
 fs/nfsd/vfs.h                        |   2 +-
 fs/nfsd/xdr4cb.h                     |  11 +
 fs/notify/mark.c                     |   1 +
 fs/open.c                            |   8 +-
 fs/posix_acl.c                       |  12 +-
 fs/smb/client/cifsfs.c               |   3 +
 fs/utimes.c                          |   4 +-
 fs/xattr.c                           |  16 +-
 include/linux/filelock.h             | 143 +++++++---
 include/linux/fs.h                   |   9 +-
 include/linux/nfs4.h                 | 127 ---------
 include/linux/sunrpc/xdrgen/nfs4_1.h | 293 ++++++++++++++++++-
 include/linux/xattr.h                |   4 +-
 include/uapi/linux/nfs4.h            |   2 -
 31 files changed, 2249 insertions(+), 389 deletions(-)
---
base-commit: 22b71eb34051a70c39c86997657de92722ec1838
change-id: 20240215-dir-deleg-e212210ba9d4

Best regards,
-- 
Jeff Layton <jlayton@kernel.org>


