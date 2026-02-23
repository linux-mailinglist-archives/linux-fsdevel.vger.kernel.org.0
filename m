Return-Path: <linux-fsdevel+bounces-77932-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aPoJKhlUnGmSEAQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77932-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 14:20:25 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id BF257176B01
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 14:20:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id DB3543023D5D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 13:20:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE92919D081;
	Mon, 23 Feb 2026 13:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fSvOqhNP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B6AF86337;
	Mon, 23 Feb 2026 13:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771852816; cv=none; b=ImTN1VOGyvCN4H3Zm0iADvR17wHW4G+ZpLJk5+QWSD3qIIu6g+Aszwyuy+Qw6hezm6mP/zVMmsqM8xObHawLJ48C049x1Drp/14rTjcTju//Z067kv9oNaNI5piOAI0iFnN49tGj6k1DzEFC3bvz6ossmJIbWx9N9UMKzu3DKTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771852816; c=relaxed/simple;
	bh=iX7f4BYNyN7OXPgks7cDMKq43X3JYPYgohE1GM360Tg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=O+BNzy/LLjoZ/+5jsuzou3j6vcYee2gBEXq0AzVUErblQcJjlsNIkFHXOXfUvW9WFkdObpWxAyh2tyIiymLZDAJWuAFGn27cO8kAe7u1xnKl6dYqwTH7tkYwu1ikhd2WU4DHqSWoABKG4wFW8KEvVUZPWbPTGBrCxSKwZBtpvH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fSvOqhNP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64662C116C6;
	Mon, 23 Feb 2026 13:20:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771852816;
	bh=iX7f4BYNyN7OXPgks7cDMKq43X3JYPYgohE1GM360Tg=;
	h=From:Subject:Date:To:Cc:From;
	b=fSvOqhNPMwrkavNq7NUt3p75FM4tRVjbYc1dHTaZWsodXXT0qB2nXGKvBvyBCzRyu
	 mgQnkMwjEZdmQAs4IRXhLfV68UO8ljsZkBkJmQohmkSATIKuGhaB4nh09tnrTxqDVV
	 xHRzZiamxjgcATjqz8oHNTuUMt6w7pjKllvjYE8PMS6fdoMT36ZrR4ws0KpHUuQwxw
	 k2r5UZq4dK3aj4AFKYxJYjjR1+eh2W+Vx8VvHCtQQ//kYWLYyfBFoLcZAZNLq8MiDF
	 Kl7d9nbEl8zD1+2IraGgXOFSbT2MJo5ZKu9GImkqugHKL/t5qzViRBJsXRNhgs1yg/
	 dAn3AmBySystg==
From: Christian Brauner <brauner@kernel.org>
Subject: [PATCH RFC v3 0/2] pidfs: make the effective {g,u}id the owner of
 the inode
Date: Mon, 23 Feb 2026 14:20:07 +0100
Message-Id: <20260223-work-pidfs-inode-owner-v3-0-490855c59999@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAdUnGkC/3WOywrCMBBFf0Wydkoe2lZXguAHuBUXSTtpQyWRi
 USl9N9tiwtddHkvc8+ZnkUkh5HtVz0jTC664Meg1itWtdo3CK4eM5Nc5lwKAc9AHdxdbSM4H2q
 E8PRIwCsteY07tFKxcXwntO41gy/sfDqy61gaHREMaV+1EzMVGQeqxHTfuvgI9J7/SGJefZX5k
 jIJEGBLq3VuCrUr1aFD8njLAjWzLslfTrHIkROHb8w2V6USW/3HGYbhA6arMislAQAA
X-Change-ID: 20260211-work-pidfs-inode-owner-0ca20de9ef23
To: linux-fsdevel@vger.kernel.org, Jann Horn <jannh@google.com>
Cc: Kees Cook <kees@kernel.org>, Andy Lutomirski <luto@amacapital.net>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 linux-kernel@vger.kernel.org, Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-47773
X-Developer-Signature: v=1; a=openpgp-sha256; l=3288; i=brauner@kernel.org;
 h=from:subject:message-id; bh=iX7f4BYNyN7OXPgks7cDMKq43X3JYPYgohE1GM360Tg=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTOCeE9fOqsd4cGZ+LUwitRzpPNz94/w2OVfoP1lZDRC
 aFklxMrOkpZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACZi4cLIMMeyfZXE5JQVrDe/
 3TR6ZX+7vsX8oI+3yTpmfbZ45wjWowz/w9oLFxm2eh4u9jguMfPCWpP5098my/a73OwwP7J+p+N
 5TgA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-77932-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[brauner@kernel.org,linux-fsdevel@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: BF257176B01
X-Rspamd-Action: no action

Hey,

This adds inode ownership and permission checking to pidfs.

Right now pidfs only supports trusted.* xattrs which require
CAP_SYS_ADMIN so there was never a need for real permission checking.
In order to support user.* xattrs and custom pidfs.* xattrs in the
future we need a permission model for pidfs inodes.

The effective {u,g}id of the target task becomes the owner of the pidfs
inode similar to what procfs does. Ownership is reported dynamically via
getattr since credentials may change due to setuid() and similar
operations. For kernel threads the owner is root, for exited tasks the
credentials saved at exit time via pidfs_exit() are used.

The permission callback checks access in two steps. First it verifies
the caller is either in the same thread group as the target or has
equivalent signal permissions reusing the same uid-based logic as
kill(). Then it performs standard POSIX permission checking via
generic_permission() against the inode's mode bits (S_IRWXU / 0700).

This is intentionally less strict than ptrace_may_access() because pidfs
currently does not allow operating on data that is completely private to
the process such as its mm or file descriptors. Additional checks can be
layered on once that changes.

The second patch adds selftests covering ownership reporting via fstat
and the permission model via user.* xattr operations which trigger
pidfs_permission() through xattr_permission(). The tests exercise live
credential changes, exited tasks with saved exit credentials, same-user
cross-process access, cross-user denial, and kernel thread denial.

Christian

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
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

 fs/pidfs.c                                         | 133 +++++++++-
 include/linux/cred.h                               |   2 +
 kernel/signal.c                                    |  19 +-
 tools/testing/selftests/pidfd/.gitignore           |   1 +
 tools/testing/selftests/pidfd/Makefile             |   2 +-
 .../selftests/pidfd/pidfd_inode_owner_test.c       | 289 +++++++++++++++++++++
 6 files changed, 427 insertions(+), 19 deletions(-)
---
base-commit: 6de23f81a5e08be8fbf5e8d7e9febc72a5b5f27f
change-id: 20260211-work-pidfs-inode-owner-0ca20de9ef23


