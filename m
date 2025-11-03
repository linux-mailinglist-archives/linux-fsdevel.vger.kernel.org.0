Return-Path: <linux-fsdevel+bounces-66775-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 22C5AC2BE67
	for <lists+linux-fsdevel@lfdr.de>; Mon, 03 Nov 2025 14:00:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 82DE84F4C1D
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Nov 2025 12:53:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0821D30DD1C;
	Mon,  3 Nov 2025 12:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lHyvCauD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 317FA2FD7B9;
	Mon,  3 Nov 2025 12:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762174371; cv=none; b=t9JU5uIGF98bp0C/W+IsBoWS4FkwryyFg0b/GCVAa7UUm2mv68sNb3+y1oG7n1a5r7U/df75YoY9sgDPw5JXTDNS0TnwSL19r9o3c2jSIHK7vsn1gB2iKFI2tW29zZiqy0HmRdUAwX7uPVzOSNp5pzUlo7lch4rnjBQ7C3es180=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762174371; c=relaxed/simple;
	bh=u6A9koQ2xVQsjkH9oiygy5jAtJIGok9qr0mKJ1On4cs=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=PXOHVnBwfP/5fxKurRgmC0t31qd+dvrbw50yIJ0b+DtKEPOQOH3gsxasU+iOTw9ZSGSWrezz99HI0MNSrGw3zgQF/1ePJ5HRi7DHTE7i/4+QCeUboaiPzmpdE8fFJtRwcXvlDgnAzy2CEGJndu4hBmetjFNwPB154jKKD0QofmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lHyvCauD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97FF4C4CEE7;
	Mon,  3 Nov 2025 12:52:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762174370;
	bh=u6A9koQ2xVQsjkH9oiygy5jAtJIGok9qr0mKJ1On4cs=;
	h=From:Subject:Date:To:Cc:From;
	b=lHyvCauDwaqlluxP3ROrItFIQ9ln8CaKTo81/+7brPR7/MzWMRljYM+1rc5iiO2eH
	 JUVo14IRwxW41bTyS/at49oohuTi6ODFfywx9qWWXP707X7bwCnCqFxLkClTNIWXWf
	 /nHOvB5dbavoo8RjKyXxt5RiJcWiGwJIdVzQPzIqdurHbtDDN+PLf2E3+SLkqRfva+
	 z7ghoGi70X+xqMIeSyKHPt/NnqX6M9P+Rjyjwjxb9VC+nz5qqmMbikw4Ghge0LUS4i
	 9H7rlQUICg9no6LjGNk54igcTxlFD55ECKQgOvNx/hukzJZauX2uBC/tCKQ5VGIQIg
	 TIC4WXJPgNlGg==
From: Jeff Layton <jlayton@kernel.org>
Subject: [PATCH v4 00/17] vfs: recall-only directory delegations for knfsd
Date: Mon, 03 Nov 2025 07:52:28 -0500
Message-Id: <20251103-dir-deleg-ro-v4-0-961b67adee89@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIylCGkC/3XMSw6CMBSF4a2Yjq25veVRHLkP4wDaCzQSalrTa
 Ah7tzBCjMNzku+fWCBvKbDzYWKeog3WjWlkxwPTfT12xK1JmyFgLkBIbqznhgbquHfcQEuiUig
 bFCyRh6fWvtbc9ZZ2b8PT+fdaj2J5/4Si4MAzKEoFdQmU0+VOfqTh5HzHllLErS53GpNWWrWFM
 Si1an603GgUOy2TrkE1Qhuq2kx/6XmePzRDu7glAQAA
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4366; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=u6A9koQ2xVQsjkH9oiygy5jAtJIGok9qr0mKJ1On4cs=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBpCKWXr30KVYtOxoUsahFyZyv+uirSJdGtOZ8Rh
 HIBi6FelJ+JAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaQillwAKCRAADmhBGVaC
 FT/dD/9rIay1ovJvXW4AikPA3o56RzRpLaEsEkWH8M8fMLsDivQ93UQA/EUyUiIgzhkqd9+WeYG
 3dwzFkLufuSlB1rxj618yVFWdl6z9EqokcQwg3Qh2OW+1xjMVBR1rZPzVz+WBSWnOs1F2DE8CBb
 qjhpkUR6ANv2fzbb3v0czZOF7htLe0wSIcz9WutlE5idePMsmltcTCUvSt2LegrKy4/H3HcMhaG
 C/rN8VQAK5oFmAdOdiTisXHS/knFh+RBrgmfS2c0hoKEdclXlrp4Q5we3vIKbbtnRtxEzo0Hhxu
 j/jnQbeMNtHx8HPSyqIZRC5dM2D3+ojedbmjBOBWo3Nc5Ny0xdt49daJrmLhFNIF5662yJQUymr
 pvkPy3C+jwSmIfz0I+DnHoii+MU58WMK0ozvRD61sGD1g9G6Lc+MwxIfkBM9OP6aG4zfPhjoaKH
 wg0v0faP7zm7VfLjHAN5mGa6XMlW4hwle6OD+p6wB/W3uw1PiRk5NPgJn2RDE18/xACVMwGJbU1
 EjG3q5yXkCCK6CEWvkfRzkaODHde1HlqluTCyWFCAeNt+Bzg+KjXr4QNEwCDAcYqRnVOd942zmo
 9ZxxxnYVz6qXJmhKbROgwhc5reZXaKLSR0uSkdpsGDSzH8WLqY32QN5EwLPzx1g08Mr1IKeX2nb
 Q7EZQkC8mn77+rw==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Behold, another version of the directory delegation patchset. This
version contains support for recall-only delegations. Support for
CB_NOTIFY will be forthcoming (once the client-side patches have caught
up).

This main differences in this version are to address Christian's review
comments. I left the R-b's from Neil and Jan intact. There are some
changes to the first few patches to add support for struct
delegated_inode, but I didn't think they were significant enough to
remove the R-b lines. Let me know if that's a problem for anyone.

Thanks!
Jeff

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
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
      vfs: add struct createdata for passing arguments to vfs_create()
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
 fs/ecryptfs/inode.c        |  19 +++--
 fs/fcntl.c                 |  14 ++++
 fs/fuse/dir.c              |   1 +
 fs/init.c                  |   6 +-
 fs/locks.c                 |  97 +++++++++++++++++-------
 fs/namei.c                 | 183 +++++++++++++++++++++++++++++++++------------
 fs/nfs/nfs4file.c          |   2 +
 fs/nfsd/filecache.c        |  57 ++++++++++----
 fs/nfsd/filecache.h        |   2 +
 fs/nfsd/nfs3proc.c         |   9 ++-
 fs/nfsd/nfs4proc.c         |  22 +++++-
 fs/nfsd/nfs4recover.c      |   6 +-
 fs/nfsd/nfs4state.c        | 103 ++++++++++++++++++++++++-
 fs/nfsd/state.h            |   5 ++
 fs/nfsd/vfs.c              |  32 ++++----
 fs/nfsd/vfs.h              |   2 +-
 fs/open.c                  |  17 +++--
 fs/overlayfs/overlayfs.h   |  15 ++--
 fs/posix_acl.c             |   8 +-
 fs/smb/client/cifsfs.c     |   3 +
 fs/smb/server/vfs.c        |  15 ++--
 fs/utimes.c                |   4 +-
 fs/xattr.c                 |  12 +--
 fs/xfs/scrub/orphanage.c   |   2 +-
 include/linux/filelock.h   |  98 ++++++++++++++++++------
 include/linux/fs.h         |  33 +++++---
 include/linux/xattr.h      |   4 +-
 include/uapi/linux/fcntl.h |  10 +++
 net/unix/af_unix.c         |   2 +-
 32 files changed, 605 insertions(+), 188 deletions(-)
---
base-commit: 3a8660878839faadb4f1a6dd72c3179c1df56787
change-id: 20251013-dir-deleg-ro-d0fe19823b21

Best regards,
-- 
Jeff Layton <jlayton@kernel.org>


