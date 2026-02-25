Return-Path: <linux-fsdevel+bounces-78412-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OMTYJVaEn2mVcgQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78412-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 00:23:02 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 01CF619EC10
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 00:23:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8CCC630610C7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Feb 2026 23:22:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 590393806CA;
	Wed, 25 Feb 2026 23:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yu0wz58+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB6FB3016F1;
	Wed, 25 Feb 2026 23:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772061772; cv=none; b=nwpQjLa7SSGPqGoikKgNA/YEERJLMoMuHkHaaQachbEV4ZEmrl/6XbGhkTf7Qb+Q424weK2nSq2mNh5cWhN7i3e7x7zUcHUBcq5vZT57iBeGk3Rbo1MaKEmWFqp/zrFwdblfBH2UDwd82lOYIGi6VrV24sav1p5++N1Ujilj3cY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772061772; c=relaxed/simple;
	bh=b5G+/cnDPnxqxYSudJSMptEph1vuCvxq3yfoKXpq3Sk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=igXzr+niLD6T+U1fdDAYiB3YVblKccpH91XQMCgUVgyKcuPq9AGkROoZVs32tFYf7cPG+k4xrSI5Tqjh5vvplT0tLAynruE11bnKQl6JPAtpns8Kw+Yjq0Rd8iFSJQ8RgnOsaFKH1kMwZFXoGQTDerus76E0vn/GORgCrTpEKzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yu0wz58+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBA09C116D0;
	Wed, 25 Feb 2026 23:22:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772061772;
	bh=b5G+/cnDPnxqxYSudJSMptEph1vuCvxq3yfoKXpq3Sk=;
	h=From:Subject:Date:To:Cc:From;
	b=Yu0wz58+v90UsLXyNgBpX+XWTc5ukUwOfUNl1nfyUer/DbvwI6nuWnuhI05gO+TKw
	 c4iROGQPCgKL2wWWs0g4s50zCamnwKYrpLd1f+9u0+m1NCRgmosmADV69qXlReinJI
	 FrATae+cI2jYU+GQGJRfN5BqiF7JCVjs+O3EwEHRUt8jc0a782VQ3RnbEWUQHZDDNj
	 xq+yD467FSiT/bjbBx+2ppK9JHL263uZooqU9FW5EV6o1Gr/RxNWnJAAAZ7mDUt2UN
	 BgVbqT2+CulZO0QDg2quXcjFkn2OJmnSku7lJDynDXBZfzEWXyvPJAgGAh/8EzcM6z
	 UZFq/bUeprzHA==
From: Christian Brauner <brauner@kernel.org>
Subject: [PATCH RFC v4 0/2] pidfs: make the {g,u}id the owner of the inode
Date: Thu, 26 Feb 2026 00:22:43 +0100
Message-Id: <20260226-work-pidfs-inode-owner-v4-0-990032ec9700@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEOEn2kC/3XOzWrDMAwH8FcpPlfFH3E+ehoM+gC9jh0cR25Mi
 13k4naUvPucsENHiW4S0u+vJ0tIHhPbb56MMPvkYyhNtd0wO5pwQvBD6ZnksuZSCLhHOsPVDy6
 BD3FAiPeABNwayQfs0EnFyvGV0PnHAn+x4+GTfZdhbxJCTybYcTZzs+NAVsz7o0+3SD/LH1ksV
 3+R9VpkFiDAtc6Yum9U16qPM1LAyy7SaYnL8tVpVh05O7zqda1aJbR5c9SLI9Wqo4BD1fFWa6u
 7Uv+caZp+AcQ+bDdtAQAA
X-Change-ID: 20260211-work-pidfs-inode-owner-0ca20de9ef23
To: linux-fsdevel@vger.kernel.org, Jann Horn <jannh@google.com>
Cc: Kees Cook <kees@kernel.org>, Andy Lutomirski <luto@amacapital.net>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 linux-kernel@vger.kernel.org, Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-47773
X-Developer-Signature: v=1; a=openpgp-sha256; l=3809; i=brauner@kernel.org;
 h=from:subject:message-id; bh=b5G+/cnDPnxqxYSudJSMptEph1vuCvxq3yfoKXpq3Sk=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTOb/E6a5J1r71eaenBJBbpdd3rnacG1Ow5k/Mqu7Mv4
 y1L5u6AjlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgIl83MLwi2my4EpevRmzoo6v
 ++H1aF2f75V/U5nfPbF4PiXw/anULZ8ZGX5oMQf/1TvXlcp+Yte8/YqlavneCQ5NMouln3brt3f
 v4wUA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-78412-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[brauner@kernel.org,linux-fsdevel@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url]
X-Rspamd-Queue-Id: 01CF619EC10
X-Rspamd-Action: no action

This adds inode ownership and permission checking to pidfs.

Right now pidfs only supports trusted.* xattrs which require
CAP_SYS_ADMIN so there was never a need for real permission checking.
In order to support user.* xattrs and custom pidfs.* xattrs in the
future we need a permission model for pidfs inodes.

The {u,g}id of the target task becomes the owner of the pidfs inode.
Ownership is reported dynamically via getattr since credentials may
change due to setresuid() and similar operations. For kernel threads the
owner is root, for exited tasks the credentials saved at exit time via
pidfs_exit() are used.

The permission callback updates the inode ownership via
pidfs_update_owner() and then performs standard POSIX permission
checking via generic_permission().

This is intentionally less strict than ptrace_may_access() because pidfs
currently does not allow operating on data that is completely private to
the process such as its mm or file descriptors. Additional checks can be
layered on once that changes.

The second patch adds selftests covering ownership reporting via fstat
and the permission model via user.* xattr operations which trigger
pidfs_permission() through xattr_permission(). The tests exercise live
credential changes, exited tasks with saved exit credentials, same-user
cross-process access, and cross-user denial.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
Changes in v4:
- Switch from euid/egid to uid/gid for inode ownership per Jann Horn's
  feedback. Use cred->uid/cred->gid instead of cred->euid/cred->egid.
- Simplify pidfs_permission() to just call pidfs_update_owner() followed
  by generic_permission() instead of open-coding credential checks.
- Drop the may_signal_creds() helper and the kill_ok_by_cred() changes
  that were part of v3's two-step permission model.
- Fix bitmask enum values: use BIT(N) instead of plain integers since
  attr_mask is now an atomic_t using atomic_or()/atomic_read() instead
  of set_bit()/test_bit().
- Make PIDFS_ATTR_BIT_KTHREAD conditional on PF_KTHREAD in pidfs_exit()
  instead of unconditionally setting it for all exiting tasks.
- Remove unused kuid_t/kgid_t variables from pidfs_update_owner().
- Link to v3: https://patch.msgid.link/20260223-work-pidfs-inode-owner-v3-0-490855c59999@kernel.org

Changes in v3:
- Simplify pidfs_fill_owner() into pidfs_update_owner() writing directly
  to the inode via WRITE_ONCE() instead of using output parameters.
- Drop the separate pidfs_update_inode() helper and the
  security_task_to_inode() call.
- Update pidfs_getattr() to write ownership to the inode via
  pidfs_update_owner() instead of writing directly to stat.
- Update pidfs_permission() to also write ownership to the inode before
  calling generic_permission(), handling kernel threads with -EPERM.
- Drop VFS_WARN_ON_ONCE() for idmap check from pidfs_permission().
- Link to v2: https://patch.msgid.link/20260217-work-pidfs-inode-owner-v2-1-f04b5638315a@kernel.org

Changes in v2:
- Fix an obvious null-deref during PIDFD_STALE (CLONE_PIDFD).
- Link to v1: https://patch.msgid.link/20260216-work-pidfs-inode-owner-v1-1-f8faa6b73983@kernel.org

---
Christian Brauner (2):
      pidfs: add inode ownership and permission checks
      selftests/pidfd: add inode ownership and permission tests

 fs/pidfs.c                                         | 110 ++++++--
 tools/testing/selftests/pidfd/.gitignore           |   1 +
 tools/testing/selftests/pidfd/Makefile             |   2 +-
 .../selftests/pidfd/pidfd_inode_owner_test.c       | 314 +++++++++++++++++++++
 4 files changed, 409 insertions(+), 18 deletions(-)
---
base-commit: 6de23f81a5e08be8fbf5e8d7e9febc72a5b5f27f
change-id: 20260211-work-pidfs-inode-owner-0ca20de9ef23


