Return-Path: <linux-fsdevel+bounces-64477-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C5A7BE8562
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Oct 2025 13:32:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D649A427FD1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Oct 2025 11:32:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99E4A2C234A;
	Fri, 17 Oct 2025 11:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P9DGnOuC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D45BA17B50F;
	Fri, 17 Oct 2025 11:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760700743; cv=none; b=CAD9QKgCfkCjJ9049TjdF9D+IdWRujzQ0GiVqwfJk1/6zVQ9lf8W0QpUXuYzjktFJzyiS4O6rj2wNRJpcM0juBqXU1IuOiT9BvmQxXRj6HvuY2rwt9FasASog6/PdfdCnObPw0njR9aNcqqw6pMzh+ePcWKk7suDKTxezisKHf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760700743; c=relaxed/simple;
	bh=gdRsiICWh3EgJw0ZvUIQMngA14LooVC9WxK4QW7lzRI=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=e0f7O3Y/sgExy3GNqmD7YnA9jlGGb3eMFz3MYF3JoWhKcO8lX6V96y06DEaArqMuNbsOoH6dEkykkgVmXXWbtYUlMeuTCk/O1Hf3ChfWFMJct+jpMMrRAxgzDMs9oefIWhrbOlGMvRBBbX2YDJes0tv0UmxZYuXTHV3uJtpAvGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P9DGnOuC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D363C4CEE7;
	Fri, 17 Oct 2025 11:32:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760700742;
	bh=gdRsiICWh3EgJw0ZvUIQMngA14LooVC9WxK4QW7lzRI=;
	h=From:Subject:Date:To:Cc:From;
	b=P9DGnOuCmOdNG5W6RgjuTjeyk3P/whn02BodWjCQc47gPiDqG8sWr/M9A/aDQjTT9
	 bcJJtqJjay7hjMWRAkrXWXd0+5+pVcivdbmAXI2qU7++jU58sGX0b6iqSPb7TIPrMr
	 vU+aYQIAZB+zTtzWD9co1r/MqyHMlNUUZ8/vw0PB511S2ilyi3hXyHvFHlSNQ1m3TB
	 rAk1LugA3nJ2NSiifLNWMZGnAdtbwZiwWi8PpNz8HWNk/zSBPzVX25kaFOf+thDBMc
	 xL5HISBtOKclTMuABiFs963NrU8vFX/u9WImuZmo6P/BrlN2fT8FMT/T01w2SZTt28
	 86zAz6/aVpYxw==
From: Jeff Layton <jlayton@kernel.org>
Subject: [PATCH v2 00/11] vfs: recall-only directory delegations for knfsd
Date: Fri, 17 Oct 2025 07:31:52 -0400
Message-Id: <20251017-dir-deleg-ro-v2-0-8c8f6dd23c8b@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACgp8mgC/3XMQQ6CMBCF4auQWTtmWkTQlfcwLNAOZSKhZmoaD
 endrexd/i953wqRVTjCuVpBOUmUsJSwuwru07B4RnGlwZJtDJkanSg6ntmjBnQ0sjl1tr5ZA+X
 yVB7lvXHXvvQk8RX0s+nJ/NY/UDJIeKBj29HQEjd8ebAuPO+Deuhzzl8uvWOZqQAAAA==
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3197; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=gdRsiICWh3EgJw0ZvUIQMngA14LooVC9WxK4QW7lzRI=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBo8ik3EpoIalOYOkMRgI596gVJT9uKOT6J/UA2z
 hjZrLzfxTOJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaPIpNwAKCRAADmhBGVaC
 FQa9D/9cjUk8OnoE/zt0+4W35Y3S6cEy77nQNmdLzjYUeqVP0cspJl/cBn2UJ4IKH/zEMzEFQYv
 vyIyJb5J9vBUPP8rNDmdBfoKAein/H5Y6cq9/PNpHdFEGawIYEvaF9wG08m4AklUXB/cdtPeGd2
 TkpZDQew0lwk6eJO4BO+siahaYMTAfOl4L0OOnoDWtjv0kMvsBn/BHK2YAu36P4INTolyBLKFoI
 SCoHOI55m4xOsumm9zmseIMehrYBium5Los+5/30X7LePQ52AxB55v6jLD6XMHnmSNKlj4zyl41
 LHv0g0YJpigkk+3T8K8jvV5OGBosQhVYDoHqmF+p8VrpOhsWQbnNiRKCP/OPqCGoARzVeAV7u4y
 FHGSBl8txliR/AJzCj06BIrV7cMkBVdx6A9ND+znGn4gLBDul7ZdgIqczPAuzhLglLPbd7Rc+hW
 xPcFJlzkaV903BHtX+O5LKwKYBRl5hQdK74LhHXlIE3S8RfqffqmsBibpiq3+MVZpaAYStdNg6d
 qx2NGTDdOIpmUL1vMLIMEGKjvNqM1OqtYOKldlOMdsmwp/4GbGeGPE6eL/xmhQR5N5eFyjwrn9+
 b3DcDp+yxRXK8rpStLktF1rQETH4lYaJ1k+xgvYMID7KbS6v2GrDoaxxXpj+DLiFNwWS/jdR8hP
 xBcaiql1VYWFQGg==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

A smaller variation of the v1 patchset that I posted earlier this week.
Neil's review inspired me to get rid of the lm_may_setlease operation
and to do the conflict resolution internally inside of nfsd. That means
a smaller VFS-layer change, and an overall reduction in code.

This patchset adds support for directory delegations to nfsd. This
version only supports recallable delegations. There is no CB_NOTIFY
support yet. I have patches for those, but we've decided to add that
support in a later kernel once we get some experience with this part.
Anna is working on the client-side pieces.

It would be great if we could get into linux-next soon so that it can be
merged for v6.19. Christian, could you pick up the vfs/filelock patches,
and Chuck pick up the nfsd patches?

Thanks!
Jeff

[1]: https://lore.kernel.org/all/20240315-dir-deleg-v1-0-a1d6209a3654@kernel.org/

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
Changes in v2:
- handle lease conflict resolution inside of nfsd
- drop the lm_may_setlease lock_manager operation
- just add extra argument to vfs_create() instead of creating wrapper
- don't allocate fsnotify_mark for open directories
- Link to v1: https://lore.kernel.org/r/20251013-dir-deleg-ro-v1-0-406780a70e5e@kernel.org

---
Jeff Layton (11):
      filelock: push the S_ISREG check down to ->setlease handlers
      vfs: add try_break_deleg calls for parents to vfs_{link,rename,unlink}
      vfs: allow mkdir to wait for delegation break on parent
      vfs: allow rmdir to wait for delegation break on parent
      vfs: break parent dir delegations in open(..., O_CREAT) codepath
      vfs: make vfs_create break delegations on parent directory
      vfs: make vfs_mknod break delegations on parent directory
      filelock: lift the ban on directory leases in generic_setlease
      nfsd: allow filecache to hold S_IFDIR files
      nfsd: allow DELEGRETURN on directories
      nfsd: wire up GET_DIR_DELEGATION handling

 drivers/base/devtmpfs.c  |   6 +--
 fs/cachefiles/namei.c    |   2 +-
 fs/ecryptfs/inode.c      |   8 +--
 fs/fuse/dir.c            |   1 +
 fs/init.c                |   4 +-
 fs/locks.c               |  12 +++--
 fs/namei.c               | 134 ++++++++++++++++++++++++++++++++++++-----------
 fs/nfs/nfs4file.c        |   2 +
 fs/nfsd/filecache.c      |  57 +++++++++++++++-----
 fs/nfsd/filecache.h      |   2 +
 fs/nfsd/nfs3proc.c       |   2 +-
 fs/nfsd/nfs4proc.c       |  21 +++++++-
 fs/nfsd/nfs4recover.c    |   6 +--
 fs/nfsd/nfs4state.c      | 103 +++++++++++++++++++++++++++++++++++-
 fs/nfsd/state.h          |   5 ++
 fs/nfsd/vfs.c            |  14 ++---
 fs/nfsd/vfs.h            |   2 +-
 fs/open.c                |   2 +-
 fs/overlayfs/overlayfs.h |   8 +--
 fs/smb/client/cifsfs.c   |   3 ++
 fs/smb/server/vfs.c      |   8 +--
 fs/xfs/scrub/orphanage.c |   2 +-
 include/linux/fs.h       |  11 ++--
 net/unix/af_unix.c       |   2 +-
 24 files changed, 329 insertions(+), 88 deletions(-)
---
base-commit: 2c40814eb5ae104d3f898fd8b705ecad114105b5
change-id: 20251013-dir-deleg-ro-d0fe19823b21

Best regards,
-- 
Jeff Layton <jlayton@kernel.org>


