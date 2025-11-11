Return-Path: <linux-fsdevel+bounces-67937-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 801DEC4E594
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Nov 2025 15:16:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE4273ACBF9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Nov 2025 14:13:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18C8733ADA2;
	Tue, 11 Nov 2025 14:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SkLj8QVr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47C4E307ACF;
	Tue, 11 Nov 2025 14:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762870385; cv=none; b=sBqs96HNbbScxRG4SZYDe8I2wqKfrJVQR6UUgwFN4JFjNMQVouoiO8TNhrs6DAKSpMktLfVC9M64iOZttkutl+MUR7Nsm2VWVkT4pJUoahoWBxzioSj0nZWhKmZwVqrXXDzqsZtJS8CzqIG655+WZ/LpcdRVZU8FnYTE3pLFdWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762870385; c=relaxed/simple;
	bh=5h7RkLioFUMB+LPNk9u9S7ASRzlRqbs2gto882mjrGc=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=sgKekqVw0a3LWoURq5+UdzZA32+TrXJ16mgKx2GUXALAcaM9Vxt2WNHkhieM9KV9dIpRbpvQr/gvS7RKq8jNBgQwWDBm2HvNJghR5ANdYet36xYfAN5cMvfcG2jYixxesF5PmV1t10tXvxKj8WJsEKqa2amVnvBAo58IlMmFlzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SkLj8QVr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B87AEC19425;
	Tue, 11 Nov 2025 14:12:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762870382;
	bh=5h7RkLioFUMB+LPNk9u9S7ASRzlRqbs2gto882mjrGc=;
	h=From:Subject:Date:To:Cc:From;
	b=SkLj8QVrnBSCBecvMBq2NW2ncjPK9W9W3/debPfzLa26k62hZjRufvSGG5Op3I2pV
	 Sx3xVbraPUdzQj4CzSfQv6xc4mKnyVlJtbRIJBaLVH5LMgLRouxRWT3k2FvIKuSAtA
	 jzL/28h5TZHYmQT3sfABOoqVzmQ0LjXq9P10MdxriaEz8h5m61VqrQ8eV4Lp6LCTf/
	 Lji6yv3OSvqJGbgm3t/JRX3BY/Ike5cDOru6HK763OPbMl1HEQMVgdi/lJi4TMuspp
	 s3N5Qhw6WsNYm1Bq/d3KHY7+odhcvapp8pX/H0hiNpQC3VJTKh9pP3pEku6eHZKrRn
	 hhqSZXO5PSfbw==
From: Jeff Layton <jlayton@kernel.org>
Subject: [PATCH v6 00/17] vfs: recall-only directory delegations for knfsd
Date: Tue, 11 Nov 2025 09:12:41 -0500
Message-Id: <20251111-dir-deleg-ro-v6-0-52f3feebb2f2@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3XOTW7DIBCG4atErEs1AwbGWeUeVRf8jB3UyI5wZ
 bWKfPeSbOrYyvJDet7hJiYumSdxPNxE4TlPeRzqsG8HEc9+6FnmVLdQoAwCaplykYkv3MsyygQ
 dY0tKB4WikmvhLv88ch+fdZ/z9D2W30d9xvvri9CMEmQD1hF4B2z49MVl4Mv7WHpxL81qrd1Gq
 6opUmdTUjpS2Gm90go3WlftgQLGxG3XxJ1u/jXC9udN1a3FYJ1PzNTutFlrs9GmaschoiVP5J9
 vL8vyByZYe82hAQAA
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
 linux-api@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4578; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=5h7RkLioFUMB+LPNk9u9S7ASRzlRqbs2gto882mjrGc=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBpE0RhXZc3zlSR9KwkUEDh7QznT+wZyhLl0qE3F
 hOKLwxlAjaJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaRNEYQAKCRAADmhBGVaC
 FbOjD/9Bza9tIaT33dOL1RySziMT8MlJGCPPp4aMdvOCL6wQrCv+Kj2kMdmiOG/zHjU7eOuxuXB
 WtsJr84Qetxd+ExmK1cjv9quRzdrjPdQvEp6rK3Te4xhtUwenjayswY2bV1UxXRyykNiDRVNgLS
 HqjeSNBMq632uWhSiwbPUivxuY6mEeDiTpVf5Adnvry+JddbgNbN6W1wZZXbDtMQ7h+XNKiCkN4
 XWHgr6qVG1snbR4AbTXSGAGtv3OCzU9849XSBZLcH2FtVGUOfMHWGYTGVqhYT+4Juxa74Vdr7WJ
 Dg3JQm94om5oKs15uBNps7btijIxtwm/XoueWeTxNuXZXhtPlYTnD1dWqyDwgAI8kyUZO2tu6//
 /C3Mwg1B4Pt4ozw0L/nA5QnlrJ5UJ/BRrKgsEFnRWaa1PxFo0Nw8tJKum+E0t+R3XN87qZrcSzh
 dkxf40AiTjX7lPP+XbWCG7ivh5rhO1rbtz4FTgb2mH80H7qpePvnIDnoVgz4h6orT8fwVrWZpM1
 kSm8isaNfrT23dxUfklHjc3hcOPCqzgEoMhbMXs07cSDDa+ZX2nzbng3oyvoG8LHtjsSdB9E8fI
 tZ2QLjF2gcmRbUzu+j+c6Z7DvePj3t0kUSoZ+nKtMNgHDmsZzsvs1gFTWkMR1YSrBJcq2Ald1FH
 i0F5Q5ecPAl5ZCA==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Behold, another version of the directory delegation patchset. This
version contains support for recall-only delegations. Support for
CB_NOTIFY will be forthcoming (once the client-side patches have caught
up).

The main changes here are in response to Jan's comments. I also changed
struct delegation use to fixed-with integer types.

Thanks!
Jeff

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
Changes in v6:
- Change struct delegation to use fixed-width types, and add explicit padding
- Link to v5: https://lore.kernel.org/r/20251105-dir-deleg-ro-v5-0-7ebc168a88ac@kernel.org

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
 include/uapi/linux/fcntl.h |  11 +++
 net/unix/af_unix.c         |   2 +-
 32 files changed, 543 insertions(+), 176 deletions(-)
---
base-commit: 3a8660878839faadb4f1a6dd72c3179c1df56787
change-id: 20251013-dir-deleg-ro-d0fe19823b21

Best regards,
-- 
Jeff Layton <jlayton@kernel.org>


