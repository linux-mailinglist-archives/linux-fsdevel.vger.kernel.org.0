Return-Path: <linux-fsdevel+bounces-63972-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A7392BD3BEE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Oct 2025 16:56:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id ACD4A4FBC47
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Oct 2025 14:51:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CA152D5924;
	Mon, 13 Oct 2025 14:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lKGV3p7A"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A29E6211290;
	Mon, 13 Oct 2025 14:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760366896; cv=none; b=CSU2HVB91Qyp1U5UQpOtSLlURnIC7NTjTRSQ3YhttUEnOK/dZ5qp1uV78lRyDfmhkvhfD8uWd0pDfS+CvPrKeuWj+kNxpIDU44fk/qHNmxUfgCvWYZUSIlkew2o6ATK8u79yFZeS6t3ckC6BnKdJigwHNbCYsFZXtYZtHgglWCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760366896; c=relaxed/simple;
	bh=jWgRdOclHfQbfaaf9W2P4KkHZdNwhBqzpIGWPibgK3c=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=hae2wJ7NDRafYQh8LIA0b8jwu8oAFbGvk6fzN7MHeaBBcZ6mWA0a1h0kqfODEjc4eXWKKAaB9xHYrAAgbxbRxzCKJrKN2Xubd5fiWDKHF1i6xN9nUMYPP1m+yQfgX3FiYfssj/PTO5K/zIhI6pyxfYbh7KNQABhg3o8+/mmG9xM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lKGV3p7A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB088C4CEE7;
	Mon, 13 Oct 2025 14:48:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760366896;
	bh=jWgRdOclHfQbfaaf9W2P4KkHZdNwhBqzpIGWPibgK3c=;
	h=From:Subject:Date:To:Cc:From;
	b=lKGV3p7AwvrM7OJT7hOATJJT/UQN+kJq3n5xXj6pTbNb/aPqxIKhMOTBAMtYBveMU
	 TgVOAT3NRJ2aqglav+lGus1drXMm5aA7AevvrCajbMeOZRo73m8fEM85t6G9zOnC47
	 bkXLvwRG4lqnGBYomaZtBBEvED6bhbRwQKQzmgMFrnyZCIApHKZO4f7D6WeL8G25Rg
	 c78aaDpyifmo5QKKLtVuHnMGcM83XQC/oy/41mkt0StfUpPOcU04WD37SJs+QTiVDz
	 BHIRDvjN4HiU4B7Taa7rtLbx8UC+3WZc2Bx3pqHcQkG8pBWPz6ckrC0p8kFu8F2RJB
	 G42YDsjvFASow==
From: Jeff Layton <jlayton@kernel.org>
Subject: [PATCH 00/13] vfs: recall-only directory delegations for knfsd
Date: Mon, 13 Oct 2025 10:47:58 -0400
Message-Id: <20251013-dir-deleg-ro-v1-0-406780a70e5e@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAB4R7WgC/x3MMQqAMAxA0atIZgNNi6BeRRzUpjUgVVIQoXh3i
 +Mb/i+QWYUzjE0B5VuynKmC2ga2fUmRUXw1WGM7MuTQi6LngyPqid4EpqG3brUENbmUgzz/bpr
 f9wMsflGqXgAAAA==
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4011; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=jWgRdOclHfQbfaaf9W2P4KkHZdNwhBqzpIGWPibgK3c=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBo7REpbSXN3G6FhVhF7XoUUMttobFKJ1BVSzBKY
 aCDKYuY4e2JAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaO0RKQAKCRAADmhBGVaC
 FdWwEADB1fG+r8Su4S75zX1urKLYXefEdzK/4m7dqrLwtnMwVrkRljoJZTmFyjRp1sLur6cTdfm
 BefXgRYtzswymnNoi9hw19fh/D0zWJ5o/nJetdEaseeMqb9pwOuflLudHalhJIQ+G3evmWazi1F
 ZJJzDF9WiQchXF9Ezx56oZQTJpcxdXIdtE9VRLz//IFzRwAGlHttrOpnW8iKq7jaouBEwFQ7pLj
 l5aF/xUAMxIKotGm0r1pOf6BFMLZd6n3e1NZJTPllLvT1bvpa/w9EW1ABO4SgzvFmPTl5Yj7OVi
 eXYM2I9HeykVe3h9cW0z0jRIkSuJGZC5Cmvvlpg6PFHQXBJqbHuIKQb4wMMCxoebTZJVBanLuIc
 SkSncW7lEH8Z56zqAJHNFSN7ApLT6xo8Cljcbk2ZpciKJcoWjXjCFIat62ASVUwAhpT2V1rIMZl
 DvINrGLx1hl1stODptoSPvW8f+P4UbeRI5UAYRDYsV38WJPYwrCJlFbdXnY8SaxH+YSslvABTVh
 xG1M9pPAgwZDe+2SN3/krfrgncKX9UujZrJBaIkuJS8YFJMG6+R4LcajTSrQvdyOSj+7+TTB+vx
 a1jxuVEnA/cOqUmxrGC5B64PWdoG+UQEmYMFp2gg38R7C0Yls2PcT9yGsdlWTcUXohOHPoWsR8L
 IIbHtLPojiFcNXg==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

At the fall NFS Bakeathon last week, the NFS client and server
maintainers had a discussion about how to merge support for directory
delegations. We decided to start with just merging support for simple,
recallable-only directory delegation support, for a number of reasons:

1/ RFC8881 has some gaps in coverage that we are hoping to have
addressed in RFC8881bis. In particular, it's written such that CB_NOTIFY
callbacks require directory position information. That will be hard to
do properly under Linux, so we're planning to extend the spec to allow
that information to be omitted.

2/ client-side support for CB_NOTIFY still lags a bit. The client side
is tricky, as it involves heuristics about when to request a delegation.

3/ we have some early indication that simple, recallable-only
delegations can help performance in some cases. Anna mentioned seeing a
multi-minute speedup in xfstests runs with them enabled. This needs more
investigation, but it's promising and seems like enough justification to
merge support.

This patchset is quite similar to the set I initially posted back in
early 2024 [1]. We've merged some GET_DIR_DELEGATION handling patches
since then, but the VFS layer support is basically the same.

One thing that I want to make clear is that with this patchset, userspace
can request a read lease on a directory that will be recalled on
conflicting accesses. I saw no reason to prevent this, and I think it may
be something useful for applications like Samba.

As always, users can disable leases altogether via the fs.leases-enable
sysctl if this is an issue, but I wanted to point this out in case
anyone sees footguns here.

It would be great if we could get into linux-next soon so that it can be
merged for v6.19. Christian, could you pick up the vfs/filelock patches,
and Chuck pick up the nfsd patches?

Thanks!

[1]: https://lore.kernel.org/all/20240315-dir-deleg-v1-0-a1d6209a3654@kernel.org/

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
Jeff Layton (13):
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

 drivers/base/devtmpfs.c  |   6 +-
 fs/cachefiles/namei.c    |   2 +-
 fs/ecryptfs/inode.c      |   6 +-
 fs/fuse/dir.c            |   1 +
 fs/init.c                |   4 +-
 fs/locks.c               |  17 ++++-
 fs/namei.c               | 163 ++++++++++++++++++++++++++++++++++-------------
 fs/nfs/nfs4file.c        |   2 +
 fs/nfsd/filecache.c      |  50 +++++++++++----
 fs/nfsd/filecache.h      |   2 +
 fs/nfsd/nfs4proc.c       |  21 +++++-
 fs/nfsd/nfs4recover.c    |   6 +-
 fs/nfsd/nfs4state.c      | 114 ++++++++++++++++++++++++++++++++-
 fs/nfsd/state.h          |   5 ++
 fs/nfsd/vfs.c            |  11 ++--
 fs/nfsd/vfs.h            |   2 +-
 fs/overlayfs/overlayfs.h |   6 +-
 fs/smb/client/cifsfs.c   |   3 +
 fs/smb/server/vfs.c      |   6 +-
 fs/xfs/scrub/orphanage.c |   2 +-
 include/linux/filelock.h |  14 ++++
 include/linux/fs.h       |   9 +--
 net/unix/af_unix.c       |   2 +-
 23 files changed, 363 insertions(+), 91 deletions(-)
---
base-commit: 2c40814eb5ae104d3f898fd8b705ecad114105b5
change-id: 20251013-dir-deleg-ro-d0fe19823b21

Best regards,
-- 
Jeff Layton <jlayton@kernel.org>


