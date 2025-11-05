Return-Path: <linux-fsdevel+bounces-67158-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 66050C36D82
	for <lists+linux-fsdevel@lfdr.de>; Wed, 05 Nov 2025 17:57:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E2F20189C064
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Nov 2025 16:54:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFD50339710;
	Wed,  5 Nov 2025 16:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uRW9AJOg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0268B31353B;
	Wed,  5 Nov 2025 16:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762361650; cv=none; b=HMhpLuPCNSTkPmhcACuBsM+rhya9Qp7cAivfQ+49tPkH5+hNEBGyZQLRQkjTQ+1gFV7CHflRVvIvCS6xyjFfo2Az3WMJ0EHecihQH3UBa0B1kHDqe2meILTiRsRkLRaCW/3Kt65dw5AShOUX6m3J2QskOQoia29no3OfQJaiD48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762361650; c=relaxed/simple;
	bh=X568zCRsjEXh/3B6ZRy7jKHNt8H/ZML3yG8+iAorCd0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ZeJWwZ8pUNFYhF+PMKLvqlchY7kP734mUZYKn6iJE3PwPJzmSHcsmtkxlJK5i9Q12CSDBLc+Nd7qzLTO8rmdliHD7oNQqkOpnBeMfvgsxP24DAqp1bL31+b0ORmtDEDIUuEZIp1y55swr8TWA2W47R4uywI2LrRrtN9d4jGyZGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uRW9AJOg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47595C4CEF5;
	Wed,  5 Nov 2025 16:54:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762361649;
	bh=X568zCRsjEXh/3B6ZRy7jKHNt8H/ZML3yG8+iAorCd0=;
	h=From:Subject:Date:To:Cc:From;
	b=uRW9AJOguz+2wiyVAR5LG/LhjN5vmazIuaC5kF7dGZiUUXVoZ0uDtM89HcDRKxwos
	 w+dDYsGYxvgB5kg87spXKOIrQaaUablsDLg0tnH2ZvUln3UYpwzx5suNgWTbq5vf4J
	 Ji3dj30VPaeX7p52MnpCsYR8CWl+iVYIwyYF2Y17YWG3EJRQTef/+iWmrI1a+b+nSZ
	 LTSHBQXgo5qW/iY2Srd3UAGQ5X1KefJRhZHrD1Wm24CezZhfP+zw3ix9GRWC7clNes
	 lHOcifug4SwlYhi3CFXLe1Ul1P+w2+gSZJELJ67Sm3yf9b5AdddX3CcfrLGbKxHwjL
	 7N2Gc48XisuZg==
From: Jeff Layton <jlayton@kernel.org>
Subject: [PATCH v5 00/17] vfs: recall-only directory delegations for knfsd
Date: Wed, 05 Nov 2025 11:53:46 -0500
Message-Id: <20251105-dir-deleg-ro-v5-0-7ebc168a88ac@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3XOQQ6CMBCF4auYrq2ZaQsUV97DuKDtAI0ETDFEQ
 7i7hY0Icfkm+f7MyHoKnnp2Pows0OB737VxJMcDs3XRVsS9i5sJEAkCSu584I4aqnjouIOSMNd
 CGoEskkeg0r+W3PUWd+37ZxfeS33A+fonNCAHriDNNBQZUEKXO4WWmlMXKjaXBrHW2UaLqLXVZ
 eqckFabnZYrLXCjZdQFaIPWUV4qu9PqqxG2n6uo8xRNmhWOSOc/epqmD2TVPtpjAQAA
X-Change-ID: 20251013-dir-deleg-ro-d0fe19823b21
To: Miklos Szeredi <miklos@szeredi.hu>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Chuck Lever <chuck.lever@oracle.com>, 
 Alexander Aring <alex.aring@gmail.com>, 
 Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
 Steve French <sfrench@samba.org>, Paulo Alcantara <pc@manguebit.org>, 
 Ronnie Sahlberg <ronniesahlberg@gmail.com>, 
 Shyam Prasad N <sprasad@microsoft.com>, Tom Talpey <tom@talpey.com>, 
 Bharath SM <bharathsm@microsoft.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
 David Howells <dhowells@redhat.com>, Tyler Hicks <code@tyhicks.com>, 
 NeilBrown <neil@brown.name>, Olga Kornievskaia <okorniev@redhat.com>, 
 Dai Ngo <Dai.Ngo@oracle.com>, Amir Goldstein <amir73il@gmail.com>, 
 Namjae Jeon <linkinjeon@kernel.org>, Steve French <smfrench@gmail.com>, 
 Sergey Senozhatsky <senozhatsky@chromium.org>, 
 Carlos Maiolino <cem@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org, 
 samba-technical@lists.samba.org, netfs@lists.linux.dev, 
 ecryptfs@vger.kernel.org, linux-unionfs@vger.kernel.org, 
 linux-xfs@vger.kernel.org, netdev@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>, NeilBrown <neilb@ownmail.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4262; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=X568zCRsjEXh/3B6ZRy7jKHNt8H/ZML3yG8+iAorCd0=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBpC4EjU/7X9+KFwYCOggzF+DpNV1fgPmF9z8W6w
 KML0a3pGseJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaQuBIwAKCRAADmhBGVaC
 FdHiD/0b0jAqTJc8n8ilb4rpF38JBVchUCvlO/YuBK6NgERHmpliYJvbcBvnzGRHuzyVRLbV/q3
 6wZewWmv7kURk/oxyYsedL7hxXyZHG3PGx9ve4Lov6gyQmzzNSm4N56EGlz2vvk7znTtkvPy7iC
 B0gph3O3VxSZbDp2x6bI0turqxVPJ4Bkpd64g3dvyoMirX9o1lm0Z7tPoTI4EdN//W/cjzrHVst
 hhjdejRT6L5rSvO/njDlrF7YhRTG4Xx05q0uEdtO860/m8DpfFmRy5mDjwr2yWWskuRI7yxiGJ9
 DvRYKKMO91vEeAVwSig9dHjiaDAd77OWSLAt6GmuvNKP/7mtBZd5s2g9BviOLkDS+rddMuEfM76
 1SNJaEyFJ88fvfs/6LXFtplO+YhnlsP9ufa4VrcIAuRZeuO7sVVpjtOowt7cdPj63JkCtzzsapH
 WMyRsaBMDpxmebym/cmUfug07OWQmiJoSmrSnPlG+kbWhN6hivOk1bol0ZlUQfDKxgzRq7D0R3L
 nvmQtp3TWMCDLmVzB/5lrzQmBHEHBir0AW9fgEGk2ZSoJwxSHP4QuLh0WhoHqRQ/v7blCbJnlid
 ZPvzpmjDpA98/V/Mb1/y0L8k3qP6XyrITLJ2+SvKrizyLU/acvTiaTyOQ/eqfpIuDJ0GaHCSNmI
 ypqH1AnwQ3m+VwA==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Behold, another version of the directory delegation patchset. This
version contains support for recall-only delegations. Support for
CB_NOTIFY will be forthcoming (once the client-side patches have caught
up).

Thanks!
Jeff

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
Changes in v5:
- drop struct createdata patch
- add patch to drop some unneeded arguments to vfs_create()
- make fcntl_getdeleg() vet delegation->d_flags
- Link to v4: https://lore.kernel.org/r/20251103-dir-deleg-ro-v4-0-961b67adee89@kernel.org

Changes in v4:
- Split lease_alloc() changes into separate patch
- new patches to switch break_lease() to use single set of flags
- add struct delegated_inode and use that instead of struct inode **
- add struct createdata and use that as argument to vfs_create()
- Rebase onto brauner/vfs-6.19.directory.delegation
- Make F_GETDELEG take and fill out struct delegation too
- Link to v3: https://lore.kernel.org/r/20251021-dir-deleg-ro-v3-0-a08b1cde9f4c@kernel.org

Changes in v3:
- Fix potential nfsd_file refcount leaks on GET_DIR_DELEGATION error
- Add missing parent dir deleg break in vfs_symlink()
- Add F_SETDELEG/F_GETDELEG support to fcntl()
- Link to v2: https://lore.kernel.org/r/20251017-dir-deleg-ro-v2-0-8c8f6dd23c8b@kernel.org

Changes in v2:
- handle lease conflict resolution inside of nfsd
- drop the lm_may_setlease lock_manager operation
- just add extra argument to vfs_create() instead of creating wrapper
- don't allocate fsnotify_mark for open directories
- Link to v1: https://lore.kernel.org/r/20251013-dir-deleg-ro-v1-0-406780a70e5e@kernel.org

---
Jeff Layton (17):
      filelock: make lease_alloc() take a flags argument
      filelock: rework the __break_lease API to use flags
      filelock: add struct delegated_inode
      filelock: push the S_ISREG check down to ->setlease handlers
      vfs: add try_break_deleg calls for parents to vfs_{link,rename,unlink}
      vfs: allow mkdir to wait for delegation break on parent
      vfs: allow rmdir to wait for delegation break on parent
      vfs: break parent dir delegations in open(..., O_CREAT) codepath
      vfs: clean up argument list for vfs_create()
      vfs: make vfs_create break delegations on parent directory
      vfs: make vfs_mknod break delegations on parent directory
      vfs: make vfs_symlink break delegations on parent dir
      filelock: lift the ban on directory leases in generic_setlease
      nfsd: allow filecache to hold S_IFDIR files
      nfsd: allow DELEGRETURN on directories
      nfsd: wire up GET_DIR_DELEGATION handling
      vfs: expose delegation support to userland

 drivers/base/devtmpfs.c    |   6 +-
 fs/attr.c                  |   2 +-
 fs/cachefiles/namei.c      |   2 +-
 fs/ecryptfs/inode.c        |  11 ++-
 fs/fcntl.c                 |  13 ++++
 fs/fuse/dir.c              |   1 +
 fs/init.c                  |   6 +-
 fs/locks.c                 | 100 +++++++++++++++++++++-------
 fs/namei.c                 | 162 +++++++++++++++++++++++++++++++++------------
 fs/nfs/nfs4file.c          |   2 +
 fs/nfsd/filecache.c        |  57 ++++++++++++----
 fs/nfsd/filecache.h        |   2 +
 fs/nfsd/nfs3proc.c         |   2 +-
 fs/nfsd/nfs4proc.c         |  22 +++++-
 fs/nfsd/nfs4recover.c      |   6 +-
 fs/nfsd/nfs4state.c        | 103 +++++++++++++++++++++++++++-
 fs/nfsd/state.h            |   5 ++
 fs/nfsd/vfs.c              |  16 ++---
 fs/nfsd/vfs.h              |   2 +-
 fs/open.c                  |  12 ++--
 fs/overlayfs/overlayfs.h   |  10 +--
 fs/posix_acl.c             |   8 +--
 fs/smb/client/cifsfs.c     |   3 +
 fs/smb/server/vfs.c        |   9 ++-
 fs/utimes.c                |   4 +-
 fs/xattr.c                 |  12 ++--
 fs/xfs/scrub/orphanage.c   |   2 +-
 include/linux/filelock.h   |  98 +++++++++++++++++++++------
 include/linux/fs.h         |  24 ++++---
 include/linux/xattr.h      |   4 +-
 include/uapi/linux/fcntl.h |  10 +++
 net/unix/af_unix.c         |   2 +-
 32 files changed, 542 insertions(+), 176 deletions(-)
---
base-commit: 3a8660878839faadb4f1a6dd72c3179c1df56787
change-id: 20251013-dir-deleg-ro-d0fe19823b21

Best regards,
-- 
Jeff Layton <jlayton@kernel.org>


