Return-Path: <linux-fsdevel+bounces-78285-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sDZrA2vXnWmFSQQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78285-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 17:52:59 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A19B118A18E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 17:52:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DC12931E6C9B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 16:40:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21B043AE6EB;
	Tue, 24 Feb 2026 16:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a0RCkZ2d"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A36113A9634;
	Tue, 24 Feb 2026 16:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771951151; cv=none; b=IsAiMSYXF+DqOeUncpDSPVXswL+kgXU1BHGKFFNPfjABDUJdTGnQLhQrHahfUzTGnamzSzxu9aJKGUH/Rsy6osHrWdgap4v3cLIQ5z7onIF9VlZ2JQSq0T83Z9jHaunu4nlckAJiALp7AmIfy2/uVaXoUAf3/Aeppjbw286t0po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771951151; c=relaxed/simple;
	bh=IlIcZvuWrnYBniv2AVd4SyZHU7eb0N18hBt7+gtanEo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LDgW4PKmjZwllsjmF9RyjPv6Z7UrYcNuCLsBZLVqFLU/SriodwjikEeCT3azA1Y9TSB/So7v5Fx8pWlBxAUfkxBbolbazHq5giTYwUUb/qZlxF4MUpb6PYvCy4CQmjGdeRrwuLQVq4KHjcIRV2uNEAvoHPIBW5/Dur910r/y/g4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a0RCkZ2d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8F36C19423;
	Tue, 24 Feb 2026 16:39:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771951151;
	bh=IlIcZvuWrnYBniv2AVd4SyZHU7eb0N18hBt7+gtanEo=;
	h=From:To:Cc:Subject:Date:From;
	b=a0RCkZ2dFahrKTdYCb414r+G9IR9ouKN56ZWeOSmDeQmr/z3Clum1sWU6PKsLIYVg
	 grK8EKpPas+OVIJCWm5QkNZJZxjLguQ9sA4TIQ4P1KabRyXMPvOZAWQThQAUEz2WFM
	 h6YQVh/dDu5v6/YfoaoP0e3JTM7du1hUzVzEqQOom1fCHG8cCvnhq0NSHGWR0m4Rcu
	 fzjleuw/Aa+u1tuVeGP07sZ3M8Dl1wexQ9ZRX/zsuZ6McKdhnwRuNQsrA+PhNyjojv
	 jK0CKmTzV+nLzv9StX6Qx6ALe+wCJae5/j6YYR4UArBkh8+tjpiVJwwNZoCvyHxcaN
	 6n9uiXuL55YTw==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neilb@ownmail.net>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: linux-nfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v3 0/3] Automatic NFSv4 state revocation on filesystem unmount
Date: Tue, 24 Feb 2026 11:39:05 -0500
Message-ID: <20260224163908.44060-1-cel@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-78285-lists,linux-fsdevel=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[ownmail.net,kernel.org,redhat.com,oracle.com,talpey.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oracle.com:email]
X-Rspamd-Queue-Id: A19B118A18E
X-Rspamd-Action: no action

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
registers with a new SRCU notifier chain in VFS that fires during
mount teardown, after processing stuck children but before
fsnotify_vfsmount_delete(), while SB_ACTIVE is still set. When a
filesystem is unmounted, all NFSv4 opens, locks, and delegations
referencing it are revoked, async COPY operations are cancelled
with NFS4ERR_ADMIN_REVOKED sent to clients, NLM locks are released,
and cached file handles are closed.

With automatic revocation, unmount operations complete without
administrator intervention once the brief state cleanup finishes.
Clients receive immediate notification of state loss through
standard NFSv4 error codes, allowing applications to handle the
situation appropriately rather than encountering silent failures.

Based on v7.0-rc1

---

Changes since v2:
- Replace fs_pin with an SRCU umount notifier chain in VFS
- Merge the pending COPY cancellation patch
- Replace xa_cmpxchg() with xa_insert()
- Use cancel_work_sync() instead of flush_workqueue()
- Remove rcu_barrier()
- Correct misleading claims in kdoc comments and commit messages

Changes since v1:
- Explain why drop_client() is being renamed
- Finish implementing revocation on umount
- Rename pin_insert_group
- Clarified log output and code comments
- Hold nfsd_mutex while closing nfsd_files

Chuck Lever (3):
  fs: add umount notifier chain for filesystem unmount notification
  nfsd: revoke NFSv4 state when filesystem is unmounted
  nfsd: close cached files on filesystem unmount

 fs/namespace.c        |  69 ++++++++++
 fs/nfsd/Makefile      |   2 +-
 fs/nfsd/filecache.c   |  45 +++++++
 fs/nfsd/filecache.h   |   1 +
 fs/nfsd/netns.h       |   5 +
 fs/nfsd/nfs4state.c   |  29 +++++
 fs/nfsd/nfsctl.c      |  10 +-
 fs/nfsd/sb_watch.c    | 283 ++++++++++++++++++++++++++++++++++++++++++
 fs/nfsd/state.h       |   7 ++
 include/linux/mount.h |   4 +
 10 files changed, 452 insertions(+), 3 deletions(-)
 create mode 100644 fs/nfsd/sb_watch.c

-- 
2.53.0


