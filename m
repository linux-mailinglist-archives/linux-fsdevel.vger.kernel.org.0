Return-Path: <linux-fsdevel+bounces-76606-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iGRkNhodhmmTJwQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76606-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Feb 2026 17:55:54 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 03A431009CD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Feb 2026 17:55:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4DE15302E24C
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Feb 2026 16:52:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA392395247;
	Fri,  6 Feb 2026 16:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TvPZ3526"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37FCC38F92C;
	Fri,  6 Feb 2026 16:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770396696; cv=none; b=WgqHClylCWl4+WXYCIVl3hIzT1FafWgthKAm9mVJ+XtBthPEP5ToIHiwfG9L1wrMuAQ/tRDnw/9rluN2KIt9FU/P3zpDi6YqddpNNyH3mfwXh7gaN6FZOMZkV/zHIMBKYCYaiyzPjlItGGZgu0x9HKVKtZOfWZ7vOAhmFNhDdrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770396696; c=relaxed/simple;
	bh=lplwV6b1bn/Na2m41GcdODxECKL7k8furN+dNpvdYAs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OqTOAN5nH2qU5UmTvllHvkT8l/W9xwGQKFbiVqIMJ4Gh6Im6lg9BtXzvbeqxgGnbUdPAvPs8/rUSoQDorPsx1hNCMn0vhMn1KSthG/Sg5BDErzS2mn4/7Mw0mVZQ4x1tM0fW7rhJVaCSarrfC3PBqwZ+VLFJOGB+xeoSe3RZebA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TvPZ3526; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02025C19423;
	Fri,  6 Feb 2026 16:51:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770396696;
	bh=lplwV6b1bn/Na2m41GcdODxECKL7k8furN+dNpvdYAs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TvPZ35269JXmLaQTNEpCW94BnqIDabtOH8E++pXmOLb76RrwPmqyixs1gud1WNVN3
	 0I09V6gMeJzazvf16fxJq83FyQ+2dLWedU/kOKXkrHXQZdi1zJOEZfrvE6O1rTR7Y7
	 LyfyVaWXxKCwjQMySYhbpYGKegb+0f5D+3/PHuDFZ69VeNS4l1HLuhDOGSUNUQYMQd
	 ovf5e9spenxoJHPNv5X4mp6TtpvAyxFzaw2e9pn6UIIFBF/bg0FmJvZNfbLjw8i8DN
	 /inl1SJOo2Oh6J8rXzhOJF7AccqtJyGKkSlUAR2hAlhh8v1+27PySFEzkYV75rT0M1
	 bP1AhMjKtNpAw==
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL 08/12 for v7.0] vfs nullfs
Date: Fri,  6 Feb 2026 17:50:04 +0100
Message-ID: <20260206-vfs-nullfs-v70-20f5788c0c2f@brauner>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260206-vfs-v70-7df0b750d594@brauner>
References: <20260206-vfs-v70-7df0b750d594@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4330; i=brauner@kernel.org; h=from:subject:message-id; bh=lplwV6b1bn/Na2m41GcdODxECKL7k8furN+dNpvdYAs=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWS2Se/acufFR4a1fiJ3ba45O+tW34v9vunbjze/E7TE2 g7Zby1f3VHKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjCRdgWGfxq/jOZ82HtoyZRg kz8zF9s8cWPrrPx+cBJ/gLzjj9jwm5yMDO/+7ee7ZcQtKh+60bjI3n6XveN8Tua9mi8qon+YHF7 hxAkA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-76606-lists,linux-fsdevel=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[brauner@kernel.org,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 03A431009CD
X-Rspamd-Action: no action

Hey Linus,

/* Summary */

Add a completely catatonic minimal pseudo filesystem called "nullfs" and
make pivot_root() work in the initramfs.

Currently pivot_root() does not work on the real rootfs because it
cannot be unmounted. Userspace has to recursively delete initramfs
contents manually before continuing boot, using the fragile switch_root
sequence (overmount + chroot).

Add nullfs, a minimal immutable filesystem that serves as the true root
of the mount hierarchy. The mutable rootfs (tmpfs/ramfs) is mounted on
top of it. This allows userspace to simply:

      chdir(new_root);
      pivot_root(".", ".");
      umount2(".", MNT_DETACH);

without the traditional switch_root workarounds. systemd already handles
this correctly. It tries pivot_root() first and falls back to MS_MOVE
only when that fails.

This also means rootfs mounts in unprivileged namespaces no longer need
MNT_LOCKED, since the immutable nullfs guarantees nothing can be
revealed by unmounting the covering mount.

nullfs is a single-instance filesystem (get_tree_single()) marked
SB_NOUSER | SB_I_NOEXEC | SB_I_NODEV with an immutable empty root
directory. This means sooner or later it can be used to overmount other
directories to hide their contents without any additional protection
needed.

We enable it unconditionally. If we see any real regression we'll hide
it behind a boot option.

nullfs has extensions beyond this in the future. It will serve as a
concept to support the creation of completely empty mount namespaces -
which is work coming up in the next cycle.

/* Testing */

gcc (Debian 14.2.0-19) 14.2.0
Debian clang version 19.1.7 (3+b1)

No build failures or warnings were observed.

/* Conflicts */

Merge conflicts with mainline or other vfs branches
====================================================

Conflict with the vfs fserror branch in fs/Makefile. The fserror branch
added fserror.o, while the nullfs branch added nullfs.o. The resolution
includes both.

diff --cc fs/Makefile
index f238cc5ea2e9,becf133e4791..cf4a745e9679
--- a/fs/Makefile
+++ b/fs/Makefile
@@@ -16,7 -16,7 +16,7 @@@ obj-y :=	open.o read_write.o file_table
 		stack.o fs_struct.o statfs.o fs_pin.o nsfs.o \
 		fs_dirent.o fs_context.o fs_parser.o fsopen.o init.o \
 		kernel_read_file.o mnt_idmapping.o remap_range.o pidfs.o \
- 		file_attr.o fserror.o
 -		file_attr.o nullfs.o
++		file_attr.o fserror.o nullfs.o

 obj-$(CONFIG_BUFFER_HEAD)	+= buffer.o mpage.o
 obj-$(CONFIG_PROC_FS)		+= proc_namespace.o

Merge conflicts with other trees
================================

The following changes since commit 8f0b4cce4481fb22653697cced8d0d04027cb1e8:

  Linux 6.19-rc1 (2025-12-14 16:05:07 +1200)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-7.0-rc1.nullfs

for you to fetch changes up to 313c47f4fe4d07eb2969f429a66ad331fe2b3b6f:

  fs: use nullfs unconditionally as the real rootfs (2026-01-14 11:23:39 +0100)

----------------------------------------------------------------
vfs-7.0-rc1.nullfs

Please consider pulling these changes from the signed vfs-7.0-rc1.nullfs tag.

Thanks!
Christian

----------------------------------------------------------------
Christian Brauner (6):
      fs: ensure that internal tmpfs mount gets mount id zero
      fs: add init_pivot_root()
      fs: add immutable rootfs
      docs: mention nullfs
      Merge patch series "fs: add immutable rootfs"
      fs: use nullfs unconditionally as the real rootfs

 .../filesystems/ramfs-rootfs-initramfs.rst         |  26 ++--
 fs/Makefile                                        |   2 +-
 fs/init.c                                          |  17 +++
 fs/internal.h                                      |   1 +
 fs/mount.h                                         |   1 +
 fs/namespace.c                                     | 159 +++++++++++++--------
 fs/nullfs.c                                        |  70 +++++++++
 include/linux/init_syscalls.h                      |   1 +
 include/uapi/linux/magic.h                         |   1 +
 init/do_mounts.c                                   |  12 +-
 10 files changed, 216 insertions(+), 74 deletions(-)
 create mode 100644 fs/nullfs.c

