Return-Path: <linux-fsdevel+bounces-78209-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id fWUuJInznGk5MQQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78209-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 01:40:41 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DA7A18047B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 01:40:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 891FF3030FC2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 00:40:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64E9222A1E1;
	Tue, 24 Feb 2026 00:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vHOAsa6z"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E91EB1367
	for <linux-fsdevel@vger.kernel.org>; Tue, 24 Feb 2026 00:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771893637; cv=none; b=iH7oyLZSp2+/B14z6tKMJDym8bZplYmuE1Q0MupnLerAGOtEGN5P+aTeUKEVDG/E2SYDwCcHh7lcvVt2y1JBPu/zK0SJ+zoA6oWc5QCO10g0uCDEXuUzHUhMWSDBT6vB9tTzP17aX4+vQryY9iqxZxBY3Ms4e5WbcjYOFzZrx+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771893637; c=relaxed/simple;
	bh=O7RPHvSlozQsT1ZKa2hmcU1xHi+cmFKY9UNuTW5qgaY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=KIicAPLr2RGS6bSn0hgaMKDbt9bCzgLJ3oYMa3sttVgyv1WDx0BbR70BQuCA5HD4rpPZEBU1yh9ji+SiAaqDhg0+5EN9QxpHdWNgw4eXcbcUcMbG9ZRlggossXc54jXoYE1AUtBdXk13Brfhn2HziaCQpX307zgnQI4tt+trmuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vHOAsa6z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F5C3C116C6;
	Tue, 24 Feb 2026 00:40:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771893636;
	bh=O7RPHvSlozQsT1ZKa2hmcU1xHi+cmFKY9UNuTW5qgaY=;
	h=From:Subject:Date:To:Cc:From;
	b=vHOAsa6zqpP9omULcTCHfr1PbeKylPJfiNrTOjyMiShfxd6msR+FJgC2DjCWUMrt4
	 OLEPYFcn+BjM4wDETAscBPb4dw6nWvLEAkDhTloGxOpEsjsrz7sHIi7prOEL8BR5qq
	 ZHmaByYw5f9Rkc/iTDCHpkBLkfqqV1y4ohYDhXWgJn7o/uK69NIp0Hf1/ryri/AOY3
	 TLAuEAkBML4eouUSOv8Aol8ziTZPo7QcLFjKIoCRh6Oaz2hon+UO+ZZFVfF5YYVv1j
	 Jr2SMsV7F1kPCbHIf6N4br1sTXHBE2ZVpUOGfrHnqQXxRIzO/V9ZaSsdQJQo8kTIOH
	 5KpGSdE/0yYOw==
From: Christian Brauner <brauner@kernel.org>
Subject: [PATCH RFC 0/3] move_mount: expand MOVE_MOUNT_BENEATH
Date: Tue, 24 Feb 2026 01:40:25 +0100
Message-Id: <20260224-work-mount-beneath-rootfs-v1-0-8c58bf08488f@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHrznGkC/yWMQQ7CIBBFr9LM2jGFGFC3Jh7ArXEBOBU0ghloN
 Wl6d0GX7+X/N0MmDpRh383ANIUcUqwgVh04b+KNMFwrg+yl6qUU+E78wGcaY0FLkUzxyCmVIeN
 OqM2gtNVCbqH+X0xD+PzaZzgdD3D5yzzaO7nSqm1mTSa0bKLzTU163SM7AcvyBU/oNuKdAAAA
X-Change-ID: 20260221-work-mount-beneath-rootfs-9164f67b7128
To: linux-fsdevel@vger.kernel.org
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 Linus Torvalds <torvalds@linux-foundation.org>, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-47773
X-Developer-Signature: v=1; a=openpgp-sha256; l=3613; i=brauner@kernel.org;
 h=from:subject:message-id; bh=O7RPHvSlozQsT1ZKa2hmcU1xHi+cmFKY9UNuTW5qgaY=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTO+dz0fL+Vkeb327sX9609unSpzbcPvxmy4hZa/Nurk
 v83XqBjcUcpC4MYF4OsmCKLQ7tJuNxynorNRpkaMHNYmUCGMHBxCsBEfiox/Pd6/yr/blicyu7g
 BcXCOQt2dGWvfFDMoXZrs7g9iyXjpwWMDJ/i2BYmJB2V+LBNbZHUzW3by+w/1LVPZLiQaXBg5sn
 +iewA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-78209-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[brauner@kernel.org,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2DA7A18047B
X-Rspamd-Action: no action

I'm too tired now to keep refining this but I think it's in good enough
shape for review.

Allow MOVE_MOUNT_BENEATH to target the caller's rootfs, allowing to
switch out the rootfs without pivot_root(2).

The traditional approach to switching the rootfs involves pivot_root(2)
or a chroot_fs_refs()-based mechanism that atomically updates fs->root
for all tasks sharing the same fs_struct. This has consequences for
fork(), unshare(CLONE_FS), and setns().

This series instead decomposes root-switching into individually atomic,
locally-scoped steps:

    fd_tree = open_tree(-EBADF, "/newroot",
                        OPEN_TREE_CLONE | OPEN_TREE_CLOEXEC);
    fchdir(fd_tree);
    move_mount(fd_tree, "", AT_FDCWD, "/",
               MOVE_MOUNT_BENEATH | MOVE_MOUNT_F_EMPTY_PATH);
    chroot(".");
    umount2(".", MNT_DETACH);

Since each step only modifies the caller's own state, the
fork/unshare/setns races are eliminated by design.

A key step to making this possible is to remove the locked mount
restriction. Originally MOVE_MOUNT_BENEATH doesn't support mounting
beneath a mount that is locked. The locked mount protects the underlying
mount from being revealed. This is a core mechanism of
unshare(CLONE_NEWUSER | CLONE_NEWNS). The mounts in the new mount
namespace become locked. That effectively makes the new mount table
useless as the caller cannot ever get rid of any of the mounts no matter
how useless they are.

We can lift this restriction though. We simply transfer the locked
property from the top mount to the mount beneath. This works because
what we care about is to protect the underlying mount aka the parent.
The mount mounted between the parent and the top mount takes over the
job of protecting the parent mount from the top mount mount. This leaves
us free to remove the locked property from the top mount which can
consequently be unmounted:

  unshare(CLONE_NEWUSER | CLONE_NEWNS)

and we inherit a clone of procfs on /proc then currently we cannot
unmount it as:

  umount -l /proc

will fail with EINVAL because the procfs mount is locked.

After this series we can now do:

  mount --beneath -t tmpfs tmpfs /proc
  umount -l /proc

after which a tmpfs mount has been placed beneath the procfs mount. The
tmpfs mount has become locked and the procfs mount has become unlocked.

This means you can safely modify an inherited mount table after
unprivileged namespace creation.

Afterwards we simply make it possible to move a mount beneath the
rootfs allowing to upgrade the rootfs.

Removing the locked restriction makes this very useful for containers
created with unshare(CLONE_NEWUSER | CLONE_NEWNS) to reshuffle an
inherited mount table safely and MOVE_MOUNT_BENEATH makes it possible to
switch out the rootfs instead of using the costly pivot_root(2).

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
Christian Brauner (3):
      move_mount: transfer MNT_LOCKED
      move_mount: allow MOVE_MOUNT_BENEATH on the rootfs
      selftests/filesystems: add MOVE_MOUNT_BENEATH rootfs tests

 fs/namespace.c                                     |  37 +-
 tools/testing/selftests/Makefile                   |   1 +
 .../selftests/filesystems/move_mount/.gitignore    |   2 +
 .../selftests/filesystems/move_mount/Makefile      |  10 +
 .../filesystems/move_mount/move_mount_test.c       | 492 +++++++++++++++++++++
 5 files changed, 523 insertions(+), 19 deletions(-)
---
base-commit: 6de23f81a5e08be8fbf5e8d7e9febc72a5b5f27f
change-id: 20260221-work-mount-beneath-rootfs-9164f67b7128


