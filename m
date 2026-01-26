Return-Path: <linux-fsdevel+bounces-75446-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sKs1KBxHd2mMdQEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75446-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jan 2026 11:51:08 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 25A7987490
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jan 2026 11:51:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C7660302B381
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jan 2026 10:50:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD6A432AAA2;
	Mon, 26 Jan 2026 10:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PEapxEBf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BF672D060B;
	Mon, 26 Jan 2026 10:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769424623; cv=none; b=O2K7bG8MqbeCwkmCcHn/BLdSD0lIR62+L/0S1c+Y6WWsPpQZmVV97PiB7uRqEJ1nJ6kAikMBKc6Y+ZgY/sJJKqiEfOo/FWuchyE2sQyiCKQ/48ug8MuYhbCOFD82kQYfi45QL0L+7AS5SAdjHrLL3V9/KPj8/g20A5kFwIE0gLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769424623; c=relaxed/simple;
	bh=MCDbVZNVP7lrFTkV8MLdy/TifEsK6J4zGdbggK1ZBNM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IL9hK7t2+U/IN5u2/TeGOtkmj0t2iijZ2UjiVP6/afhLtwD4wIwlrq1hv2tmYjAdksqojJlnXtYPWMLqxUFrOPsSgTUop1fYQAyfiZD61BP83lZvrvs+d7lAM+zau46Pmb3zTYhaMo7V9isca2My+MKPKLM3d+pRxWNNNYTK//o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PEapxEBf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11270C19421;
	Mon, 26 Jan 2026 10:50:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769424622;
	bh=MCDbVZNVP7lrFTkV8MLdy/TifEsK6J4zGdbggK1ZBNM=;
	h=From:To:Cc:Subject:Date:From;
	b=PEapxEBfx2kpoXCzs+B1lkSLAnMmEbzQOwNGtUWZo6WcdY+O+G+BH03dQNr4qoiqQ
	 fngsr/iit7iP/Z27wqa1NbbGrLxVozrZHj0O0iDc0HG/2nyzpBwCk0bA3mjJm/a1W+
	 3z6jSgy5f+76cUf1Zr9Z492OIRCurwYcLen5i9bGE4i5lLBwUHsmuPIxDkqLDsMiqZ
	 FWq7pV/UB3ol69CyvlwwYkcL0Qjd7pmGCur2A0ITOFFDfCLG6GO0yKXiv5qc0z4Up3
	 WGaLoCwUviau3FAMgWbhGJb7u/bBTCyMDMqw7D8XawJnTmul7Fcxj4+cZ7HdS7DSnH
	 OpNPsw67y7ahw==
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] vfs fixes
Date: Mon, 26 Jan 2026 11:49:55 +0100
Message-ID: <20260126-vfs-fixes-v6.19-rc8-acd9fdd8d9b8@brauner>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4259; i=brauner@kernel.org; h=from:subject:message-id; bh=MCDbVZNVP7lrFTkV8MLdy/TifEsK6J4zGdbggK1ZBNM=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSWuz39IyKxNurk/OY1CqsirpixO5sac/7tLefTYyw7e HjH22WRHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABM5XsjI0Ptw6b0HBysNK0Iu xbh77A8zu7861iZv+SXmu8ddfA/Ous/IsIPz7czi0zM6D2+QX2bneT7BNOzzVgO7i0zRq7qPrnP iYQIA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-75446-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[brauner@kernel.org,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 25A7987490
X-Rspamd-Action: no action

Hey Linus,

/* Summary */

Here's a few fixes for the current cycle:

- Fix the the buggy conversion of fuse_reverse_inval_entry() introduced
  during the creation rework.

- Disallow nfs delegation requests for directories by setting
  simple_nosetlease().

- Require an opt-in for getting readdir flag bits outside of
  S_DT_MASK set in d_type.

- Fix scheduling delayed writeback work by only scheduling when the
  dirty time expiry interval is non-zero and cancel the delayed work if
  the interval is set to zero.

- Use rounded_jiffies_interval for dirty time work.

- Check the return value of sb_set_blocksize() for romfs.

- Wait for batched folios to be stable in __iomap_get_folio().

- Use private naming for fuse hash size.

- Fix the stale dentry cleanup to prevent a race that causes a UAF.

/* Conflicts */

Merge conflicts with mainline
=============================

No known conflicts.

Merge conflicts with other trees
================================

No known conflicts.

The following changes since commit 0f61b1860cc3f52aef9036d7235ed1f017632193:

  Linux 6.19-rc5 (2026-01-11 17:03:14 -1000)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.19-rc8.fixes

for you to fetch changes up to 6358461178ca29a87c66495f1ce854388b0107c3:

  Merge patch series "fuse: fixes and cleanups for expired dentry eviction" (2026-01-16 19:15:20 +0100)

Please consider pulling these changes from the signed vfs-6.19-rc8.fixes tag.

Thanks!
Christian

----------------------------------------------------------------
vfs-6.19-rc8.fixes

----------------------------------------------------------------
Amir Goldstein (1):
      readdir: require opt-in for d_type flags

Christian Brauner (3):
      Merge patch series "vfs: properly deny directory leases on filesystems with special lease handling"
      Merge patch series "Fix vm.dirtytime_expire_seconds=0 causing 100% CPU"
      Merge patch series "fuse: fixes and cleanups for expired dentry eviction"

Christoph Hellwig (1):
      iomap: wait for batched folios to be stable in __iomap_get_folio

Deepanshu Kartikey (1):
      romfs: check sb_set_blocksize() return value

Jeff Layton (6):
      nfs: properly disallow delegation requests on directories
      smb/client: properly disallow delegations on directories
      9p: don't allow delegations to be set on directories
      gfs2: don't allow delegations to be set on directories
      ceph: don't allow delegations to be set on directories
      vboxsf: don't allow delegations to be set on directories

Jens Axboe (1):
      fuse: use private naming for fuse hash size

Laveesh Bansal (2):
      writeback: fix 100% CPU usage when dirtytime_expire_interval is 0
      docs: clarify that dirtytime_expire_seconds=0 disables writeback

Miklos Szeredi (6):
      fuse: fix race when disposing stale dentries
      fuse: make sure dentry is evicted if stale
      fuse: add need_resched() before unlocking bucket
      fuse: clean up fuse_dentry_tree_work()
      fuse: shrink once after all buckets have been scanned
      vfs: document d_dispose_if_unused()

NeilBrown (1):
      fuse: fix conversion of fuse_reverse_inval_entry() to start_removing()

Zhao Mengmeng (1):
      writeback: use round_jiffies_relative for dirtytime_work

 Documentation/admin-guide/sysctl/vm.rst |  2 +
 fs/9p/vfs_dir.c                         |  2 +
 fs/ceph/dir.c                           |  2 +
 fs/dcache.c                             | 10 +++++
 fs/fs-writeback.c                       | 16 ++++++--
 fs/fuse/dir.c                           | 66 ++++++++++++++++++---------------
 fs/gfs2/file.c                          |  1 +
 fs/iomap/buffered-io.c                  |  1 +
 fs/nfs/dir.c                            |  1 +
 fs/nfs/nfs4file.c                       |  2 -
 fs/readdir.c                            |  3 ++
 fs/romfs/super.c                        |  5 ++-
 fs/smb/client/cifsfs.c                  |  4 +-
 fs/vboxsf/dir.c                         |  1 +
 include/linux/fs.h                      |  6 ++-
 15 files changed, 82 insertions(+), 40 deletions(-)

