Return-Path: <linux-fsdevel+bounces-64943-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 681E0BF7510
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Oct 2025 17:26:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id DF33E353D1F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Oct 2025 15:26:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D12E343D84;
	Tue, 21 Oct 2025 15:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aqd79Qve"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9BE42F2910;
	Tue, 21 Oct 2025 15:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761060362; cv=none; b=rNWNYDSUiDGMHL/fS4r58cbwhqaKjLz6JW3YQvid8l08MBaf3EqoulbxcE3rvF7fbaqzBYPMVONVWma/uJIQnLGECv9lPNegkjk9gagVCwITBYozq7EKIOlZj+qe2jJl7KZzcwU8DdMm3uB6n3kNGyvg1J5cFKnzRUTCtWyXO7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761060362; c=relaxed/simple;
	bh=Q87QCWTMqM/Fch2ObvjDPBq/NiDII/xJMjnOVOUNThI=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=eTFiXmgpo43ofEgJUo6KunDHVUbKaXEkXVkMyC8hTw/OnTvSUN/tP+ZcDMt1RH8YgKalOYU+9kiJPZU4I9nnyjZkz+eHUqlTmKdlwRfHLB4IOFJzXmp8Wwgybe8sKmSWbjc4PATxHPz+FynyhaUcRZKqZYqPsT0E2gyGfI+yfDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aqd79Qve; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE8D2C4CEF5;
	Tue, 21 Oct 2025 15:25:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761060362;
	bh=Q87QCWTMqM/Fch2ObvjDPBq/NiDII/xJMjnOVOUNThI=;
	h=From:Subject:Date:To:Cc:From;
	b=aqd79QvexMw3yN1Z6OIdtZ68aEqbM9S90kkYaFvknnnoeeYhQYX7ZvHxUDNuQBDUv
	 jINyyGLgoo4lPhCvpAaIaPbZt4e2iFK673pNXgEl52qrZWWnDA7iwsiHsY7J0VY1Q1
	 n2+wx5nkHBwXRDkAHaowNh2pUHZuzq3pjCl9ypkRUQWBR6nqjKPz7/GBh/iDo9nOz7
	 +Vnjit/h95K5z09gRLQdBpBXO4WjzpnVgBKLgtRtNqetd88WonQXgV0vj7Y2UhMgiv
	 cEdjeZptTpwzyXuCUN4TEid646aVjwF+cMl49RQH6Sx9gZxO+YNJlKE9mejpgPMVYo
	 B3QxunChlynTQ==
From: Jeff Layton <jlayton@kernel.org>
Subject: [PATCH v3 00/13] vfs: recall-only directory delegations for knfsd
Date: Tue, 21 Oct 2025 11:25:35 -0400
Message-Id: <20251021-dir-deleg-ro-v3-0-a08b1cde9f4c@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAO+l92gC/3XMQQ6CMBCF4auQrq2ZtgLVlfcwLqAdYCKhZmoaD
 eHuFlZq4vK95PtnEZEJozgVs2BMFClMeZhdIdzQTD1K8nkLDbpUoIz0xNLjiL3kID10qI5Wm1Y
 rkcmdsaPnlrtc8x4oPgK/tnpS6/snlJQEeYCqttDUgCWeb8gTjvvAvVhLSX/q+kfrrK2zXeW9N
 s62X3pZljfWoL2A5wAAAA==
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
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3682; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=Q87QCWTMqM/Fch2ObvjDPBq/NiDII/xJMjnOVOUNThI=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBo96X8nMA6JHSE4mFHDRit04fMBMvd7Th3QybeV
 CKDwZihXoCJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaPel/AAKCRAADmhBGVaC
 FZKuD/9wyxvXLHuHQyIlhr6OCk+4aZduJGNL6vaxDdsNuZ7ewALoDKjX+Ty4+7PaFJlu7fbNqGM
 XAs4xRkkVvigjqXIb+TVsi44clXUmjoXDNeuW4RmmW8v3Ss65/vKIGGEGbnFH5EvA70sCZkDQoN
 vNgjjssxELH9zQZRCrgGaYHGcpiXl00KB9LRkJN9a/u03PzZVjQi2chbKkAB41EI+rPk8ehVUio
 1XEODXlHlY9u9Xtp+SoIASZ9TYkMF+rd9d7JkHdTk47ui7slW5S7Ga7l/VQ6yunARPKpNqngkhz
 mdX0/rf1Ria7H0sac8AwONw0owkWRyS809NjnAWB9yLLq5NxV2LzrkFq4X1kjdglJSsEvuRSjHd
 9utlHZGZE3xInDapqfqyj4mMWOwx0Omzxp7xpVB1yUL6tvPQEJlf0/FJvPdtSJ4sUUYlP11FKPI
 Zx8nX97umOGWgtIEOp2N9hHTGm3I8+KiOWV1Lxn5V4ZX4IwTmYf5BNsUjR4kEtsBLtPwz6W/KyW
 n3e0/HghTWzTkNmqBM5F5Kkql6MZQZ8RjDROWWzZuYnkLTgrYYz3bjGR4MMWeE+MAnCgIomRE8z
 qRIdC8hA10RfRYZ8c1SAnpYLTwPM16ij/Jgp9PwWPq4QaerUM6pwEH6T8tLVfrJnr1ykqB7mAu+
 QWKKCCCZ8Jofm6A==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Behold, another version of directory delegations. This version contains
support for recall-only delegations. Support for CB_NOTIFY will be
forthcoming (once the client-side patches have caught up).

This main differences in this version are bugfixes, but the last patch
adds a more formal API for userland to request a delegation. That
support is optional. We can drop it and the rest of the series should be
fine.

My main interest in making delegations available to userland is to allow
testing this support without nfsd. I have an xfstest ready to submit for
this if that support looks acceptable. If it is, then I'll also plan to
submit an update for fcntl(2).

Christian, Chuck mentioned he was fine with you merging the nfsd bits
too, if you're willing to take the whole pile.

Thanks!
Jeff

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
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
Jeff Layton (13):
      filelock: push the S_ISREG check down to ->setlease handlers
      vfs: add try_break_deleg calls for parents to vfs_{link,rename,unlink}
      vfs: allow mkdir to wait for delegation break on parent
      vfs: allow rmdir to wait for delegation break on parent
      vfs: break parent dir delegations in open(..., O_CREAT) codepath
      vfs: make vfs_create break delegations on parent directory
      vfs: make vfs_mknod break delegations on parent directory
      vfs: make vfs_symlink break delegations on parent dir
      filelock: lift the ban on directory leases in generic_setlease
      nfsd: allow filecache to hold S_IFDIR files
      nfsd: allow DELEGRETURN on directories
      nfsd: wire up GET_DIR_DELEGATION handling
      vfs: expose delegation support to userland

 drivers/base/devtmpfs.c    |   6 +-
 fs/cachefiles/namei.c      |   2 +-
 fs/ecryptfs/inode.c        |  10 +--
 fs/fcntl.c                 |   9 +++
 fs/fuse/dir.c              |   1 +
 fs/init.c                  |   6 +-
 fs/locks.c                 |  68 +++++++++++++++-----
 fs/namei.c                 | 150 +++++++++++++++++++++++++++++++++++----------
 fs/nfs/nfs4file.c          |   2 +
 fs/nfsd/filecache.c        |  57 ++++++++++++-----
 fs/nfsd/filecache.h        |   2 +
 fs/nfsd/nfs3proc.c         |   2 +-
 fs/nfsd/nfs4proc.c         |  22 ++++++-
 fs/nfsd/nfs4recover.c      |   6 +-
 fs/nfsd/nfs4state.c        | 103 ++++++++++++++++++++++++++++++-
 fs/nfsd/state.h            |   5 ++
 fs/nfsd/vfs.c              |  16 ++---
 fs/nfsd/vfs.h              |   2 +-
 fs/open.c                  |   2 +-
 fs/overlayfs/overlayfs.h   |  10 +--
 fs/smb/client/cifsfs.c     |   3 +
 fs/smb/server/vfs.c        |   8 +--
 fs/xfs/scrub/orphanage.c   |   2 +-
 include/linux/filelock.h   |  12 ++++
 include/linux/fs.h         |  13 ++--
 include/uapi/linux/fcntl.h |  10 +++
 net/unix/af_unix.c         |   2 +-
 27 files changed, 425 insertions(+), 106 deletions(-)
---
base-commit: d2ced3cadfab04c7e915adf0a73c53fcf1642719
change-id: 20251013-dir-deleg-ro-d0fe19823b21

Best regards,
-- 
Jeff Layton <jlayton@kernel.org>


