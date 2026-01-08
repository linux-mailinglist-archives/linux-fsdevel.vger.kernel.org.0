Return-Path: <linux-fsdevel+bounces-72695-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E6D49D007A3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 08 Jan 2026 01:41:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 283DB302C135
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Jan 2026 00:40:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 997621DE3AD;
	Thu,  8 Jan 2026 00:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l8R8efoU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 008F91D5CFE;
	Thu,  8 Jan 2026 00:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767832823; cv=none; b=L4vtnWMri5J1BY65ZKPnfrxBjhA+AuIxdbAEPhiLA+BDAbtlYj1ktDQrUooVRd0s+4zO6VKtY+gn3K60o4i/pn8nhKxG7MV2ZmqDScyID8uHA8j+2BE2TgFSa7PvjIB7gv2W0WsRt77puFVH6ZJmRe2hRNOwFFFNpORpAsTGFDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767832823; c=relaxed/simple;
	bh=lCr25JyiroJH9anX4xgULqRLmslXynO4tD06DKJ6+m4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Wdw1yNoTsohKMpoiIer0zg5dEIRPAApZuA5QCqgEvzU5TYT7Z34KCT7KwKaaBt5Lfpwc4PDCq98jeSJDcBp/wJoCqGtTfxmAgZU8FleoQsgfWxkc7Et7J2ECPRBJwkcyP0cCpvyD8kpZN+rgiTH/ugiKgxwPIaJlxFA2IsV6MSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l8R8efoU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7177AC4CEF1;
	Thu,  8 Jan 2026 00:40:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767832821;
	bh=lCr25JyiroJH9anX4xgULqRLmslXynO4tD06DKJ6+m4=;
	h=From:To:Cc:Subject:Date:From;
	b=l8R8efoUE8nGyhbuO8Umg4YjMmNgZeYb5NwJjC3xSR5IaBfva/SjiFHTzY+c/5OIT
	 ZfqVrT6S1yJ4H4P03DAYc/NK834Ocl9U3Zgd1SPf6NUXI9H4iBK0rp2EJsGoyImHpT
	 l5Kj7s8/GbuqXd0W18mO++/6TpqMzEPs6OxnMLBLdYEcPKlsjPUx9A+vM3OQL9YRvm
	 rMEc5VB32dQDFUDcPpSl0ATe7GkBcSTTuP9/SOPb59qSVm0DpnevMBghED1nsR1d2c
	 hDb4vpwiz4Hpe+ypDNApdPj2dBuxOzOBOeYtnC90uy38g4JMmbwtoXkhDslsWkWUwp
	 nAG8rVG1sJeWA==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neilb@ownmail.net>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	<linux-fsdevel@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v2 0/6] Automatic NFSv4 state revocation on filesystem unmount
Date: Wed,  7 Jan 2026 19:40:10 -0500
Message-ID: <20260108004016.3907158-1-cel@kernel.org>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

When an NFS server exports a filesystem and clients hold NFSv4 state
(opens, locks, delegations), unmounting the underlying filesystem
fails with EBUSY. The /proc/fs/nfsd/unlock_fs interface exists for
administrators to manually revoke state before retrying the unmount,
but this approach has significant operational drawbacks.

Manual intervention breaks automation workflows. Containerized NFS
servers, orchestration systems, and unattended maintenance scripts
cannot reliably unmount exported filesystems without implementing
custom logic to detect the failure and invoke unlock_fs. System
administrators managing many exports face tedious, error-prone
procedures when decommissioning storage.

This series enables the NFS server to detect filesystem unmount
events and automatically revoke associated state. The mechanism
uses the kernel's existing fs_pin infrastructure, which provides
callbacks during mount lifecycle transitions. When a filesystem
is unmounted, all NFSv4 opens, locks, and delegations referencing
it are revoked, async COPY operations are cancelled with
NFS4ERR_ADMIN_REVOKED sent to clients, NLM locks are released,
and cached file handles are closed.

With automatic revocation, unmount operations complete without
administrator intervention once the brief state cleanup finishes.
Clients receive immediate notification of state loss through
standard NFSv4 error codes, allowing applications to handle the
situation appropriately rather than encountering silent failures.

Based on the nfsd-testing branch of:

  https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git/

Changes since v1:
- Explain why drop_client() is being renamed
- Finish implementing revocation on umount
- Rename pin_insert_group
- Clarified log output and code comments
- Hold nfsd_mutex while closing nfsd_files

Chuck Lever (6):
  nfsd: cancel async COPY operations when admin revokes filesystem state
  fs: export pin_insert and pin_remove for modular filesystems
  fs: add pin_insert_sb() for superblock-only pins
  fs: invoke group_pin_kill() during mount teardown
  nfsd: revoke NFSv4 state when filesystem is unmounted
  nfsd: close cached files on filesystem unmount

 fs/fs_pin.c            |  50 ++++++++
 fs/namespace.c         |   2 +
 fs/nfsd/Makefile       |   2 +-
 fs/nfsd/filecache.c    |  44 +++++++
 fs/nfsd/filecache.h    |   1 +
 fs/nfsd/netns.h        |   4 +
 fs/nfsd/nfs4proc.c     | 124 +++++++++++++++++--
 fs/nfsd/nfs4state.c    |  46 +++++--
 fs/nfsd/nfsctl.c       |  11 +-
 fs/nfsd/pin.c          | 274 +++++++++++++++++++++++++++++++++++++++++
 fs/nfsd/state.h        |   9 ++
 fs/nfsd/xdr4.h         |   1 +
 include/linux/fs_pin.h |   1 +
 13 files changed, 548 insertions(+), 21 deletions(-)
 create mode 100644 fs/nfsd/pin.c

-- 
2.52.0


