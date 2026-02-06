Return-Path: <linux-fsdevel+bounces-76602-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IMWtDcIchmmTJwQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76602-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Feb 2026 17:54:26 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 517E210096D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Feb 2026 17:54:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 148923021CC1
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Feb 2026 16:51:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A00BF2DECB1;
	Fri,  6 Feb 2026 16:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lExUHATh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E591335BA7;
	Fri,  6 Feb 2026 16:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770396690; cv=none; b=NZ/77rfygQ90X+jI/8BlLvz+ket7IkbPjvrD85guBD4Nzzqk7cwv0anOgDNfcGPfwxIXQm96+3e3zNMYW/+4st56AkTiUQtxLq838lC9uF2svsmIXG0kcn0lF89NQ1FD+xpLltZ/SR8skqdzVGDAImUsA7qObKtBRV9y8QKZF50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770396690; c=relaxed/simple;
	bh=Pet4EAtK3c5M0AM2vXvuPKy464a9XTf038KI7Nqwy4k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MJnBJeirER1MgQ9spI7MJOof8AiVlPIPZ/x5Bz2xWowuQ7aEvaN6s1ErguAzhqf1Kx8rNN4IOSMEvPTyyXGHttnGH1zN5SsUj0vwtDuRRQTQi5qTpS1MkOCmvo04Ba2UXD9dnVy+yQYh8u4CJb2ihXIGl/7aWH0Q1J9NbnHQHhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lExUHATh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8197EC116C6;
	Fri,  6 Feb 2026 16:51:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770396689;
	bh=Pet4EAtK3c5M0AM2vXvuPKy464a9XTf038KI7Nqwy4k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lExUHAThMKznX44Ll00JY8eHDgaKlIH5ysflcKAVoXEUIiLAGrCA9vrKouw0n8JJQ
	 gKwdiPKEBz4qkNWmoKbQrqMruQxTpjW9UNB/VOFx9LDav9oZ2OxgsY4+17eY1tFSFf
	 TA/9H0vzF03H4epq7SD5vIY8bWMvnrrEHmVHTpRB7+uAn/BHNWp+RF5BZyuOQt+lRw
	 y83gO0fchfNmt4P2VxVdu8u3sTFu9KC/lFkdFL1Qa7cBIeQLGKlXYFbxQ56eWD/hVK
	 ipHTRIR1DV1wpOk0y1zTLoCHNsQ2PcYq74acLH4LLJCsn2ynrTaBjRSacWI3ZBNjVP
	 kdRroaQZp1x4g==
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL 04/12 for v7.0] vfs leases
Date: Fri,  6 Feb 2026 17:50:00 +0100
Message-ID: <20260206-vfs-leases-v70-bff7da8bfd23@brauner>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260206-vfs-v70-7df0b750d594@brauner>
References: <20260206-vfs-v70-7df0b750d594@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=7240; i=brauner@kernel.org; h=from:subject:message-id; bh=Pet4EAtK3c5M0AM2vXvuPKy464a9XTf038KI7Nqwy4k=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWS2Se+cka/TlSuj3s0buuPGZJZd2h2nDc9kqU8s6KjZt +n5t5yqjlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgIk8tWFkuGl1buOurXmzSj3/ +SkW2LrJcBT0ifkGuLtnWwdNDj92i+G/J5vi8pfMz6T8Zj6tYnG+LfjZZWITp6eWSWMHZyWbnQA XAA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-76602-lists,linux-fsdevel=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
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
X-Rspamd-Queue-Id: 517E210096D
X-Rspamd-Action: no action

Hey Linus,

/* Summary */

This contains updates for lease support to require filesystems to
explicitly opt-in to lease support

Currently kernel_setlease() falls through to generic_setlease() when a
filesystem does not define ->setlease(), silently granting lease support
to every filesystem regardless of whether it is prepared for it. This is
a poor default: most filesystems never intended to support leases, and
the silent fallthrough makes it impossible to distinguish "supports
leases" from "never thought about it".

This series inverts the default. It adds explicit .setlease =
generic_setlease assignments to every in-tree filesystem that should
retain lease support, then changes kernel_setlease() to return -EINVAL
when ->setlease is NULL. With the new default in place,
simple_nosetlease() is redundant and is removed along with all
references to it.

/* Testing */

gcc (Debian 14.2.0-19) 14.2.0
Debian clang version 19.1.7 (3+b1)

No build failures or warnings were observed.

/* Conflicts */

Merge conflicts with mainline
=============================

No known conflicts.

Merge conflicts with other trees
================================

diff --cc Documentation/filesystems/porting.rst
index ed3ac56e3c76,2b4dddfe6c66..000000000000
--- a/Documentation/filesystems/porting.rst
+++ b/Documentation/filesystems/porting.rst
@@@ -1336,7 -1339,6 +1336,15 @@@ in-tree filesystems have done)

 **mandatory**

+The ->setlease() file_operation must now be explicitly set in order to provide
+support for leases. When set to NULL, the kernel will now return -EINVAL to
+attempts to set a lease. Filesystems that wish to use the kernel-internal lease
+implementation should set it to generic_setlease().
++
++---
++
++**mandatory**
++
+ do_{mkdir,mknod,link,symlink,renameat2,rmdir,unlink}() are gone; filename_...()
+ counterparts replace those.  The difference is that the former used to consume
+ filename references; the latter do not.

[1]: https://lore.kernel.org/linux-next/20260115093828.318572ea@canb.auug.org.au/
[2]: https://lore.kernel.org/linux-next/aW41jU88O4Hfnt9i@sirena.org.uk/

The following changes since commit 7d42f2b1cc3a60a71784967384ddcf29fe3f35ed:

  Merge patch series "vfs: properly deny directory leases on filesystems with special lease handling" (2026-01-12 10:54:52 +0100)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-7.0-rc1.leases

for you to fetch changes up to 056a96e65f3e2a3293b99a336de92376407af5fa:

  fuse: add setlease file operation (2026-01-13 09:56:11 +0100)

----------------------------------------------------------------
vfs-7.0-rc1.leases

Please consider pulling these changes from the signed vfs-7.0-rc1.leases tag.

Thanks!
Christian

----------------------------------------------------------------
Christian Brauner (1):
      Merge patch series "vfs: require filesystems to explicitly opt-in to lease support"

Jeff Layton (25):
      fs: add setlease to generic_ro_fops and read-only filesystem directory operations
      affs: add setlease file operation
      btrfs: add setlease file operation
      erofs: add setlease file operation
      ext2: add setlease file operation
      ext4: add setlease file operation
      exfat: add setlease file operation
      f2fs: add setlease file operation
      fat: add setlease file operation
      gfs2: add a setlease file operation
      jffs2: add setlease file operation
      jfs: add setlease file operation
      nilfs2: add setlease file operation
      ntfs3: add setlease file operation
      ocfs2: add setlease file operation
      orangefs: add setlease file operation
      overlayfs: add setlease file operation
      squashfs: add setlease file operation
      tmpfs: add setlease file operation
      udf: add setlease file operation
      ufs: add setlease file operation
      xfs: add setlease file operation
      filelock: default to returning -EINVAL when ->setlease operation is NULL
      fs: remove simple_nosetlease()
      fuse: add setlease file operation

 Documentation/filesystems/porting.rst |  9 +++++++++
 Documentation/filesystems/vfs.rst     |  9 ++++++---
 fs/9p/vfs_dir.c                       |  2 --
 fs/9p/vfs_file.c                      |  2 --
 fs/affs/dir.c                         |  2 ++
 fs/affs/file.c                        |  2 ++
 fs/befs/linuxvfs.c                    |  2 ++
 fs/btrfs/file.c                       |  2 ++
 fs/btrfs/inode.c                      |  2 ++
 fs/ceph/dir.c                         |  2 --
 fs/ceph/file.c                        |  1 -
 fs/cramfs/inode.c                     |  2 ++
 fs/efs/dir.c                          |  2 ++
 fs/erofs/data.c                       |  2 ++
 fs/erofs/dir.c                        |  2 ++
 fs/exfat/dir.c                        |  2 ++
 fs/exfat/file.c                       |  2 ++
 fs/ext2/dir.c                         |  2 ++
 fs/ext2/file.c                        |  2 ++
 fs/ext4/dir.c                         |  2 ++
 fs/ext4/file.c                        |  2 ++
 fs/f2fs/dir.c                         |  2 ++
 fs/f2fs/file.c                        |  2 ++
 fs/fat/dir.c                          |  2 ++
 fs/fat/file.c                         |  2 ++
 fs/freevxfs/vxfs_lookup.c             |  2 ++
 fs/fuse/dir.c                         |  1 -
 fs/fuse/file.c                        |  1 +
 fs/gfs2/file.c                        |  3 +--
 fs/isofs/dir.c                        |  2 ++
 fs/jffs2/dir.c                        |  2 ++
 fs/jffs2/file.c                       |  2 ++
 fs/jfs/file.c                         |  2 ++
 fs/jfs/namei.c                        |  2 ++
 fs/libfs.c                            | 20 ++------------------
 fs/locks.c                            |  3 +--
 fs/nfs/dir.c                          |  1 -
 fs/nfs/file.c                         |  1 -
 fs/nilfs2/dir.c                       |  3 ++-
 fs/nilfs2/file.c                      |  2 ++
 fs/ntfs3/dir.c                        |  3 +++
 fs/ntfs3/file.c                       |  3 +++
 fs/ocfs2/file.c                       |  5 +++++
 fs/orangefs/dir.c                     |  4 +++-
 fs/orangefs/file.c                    |  1 +
 fs/overlayfs/file.c                   |  2 ++
 fs/overlayfs/readdir.c                |  2 ++
 fs/qnx4/dir.c                         |  2 ++
 fs/qnx6/dir.c                         |  2 ++
 fs/read_write.c                       |  2 ++
 fs/smb/client/cifsfs.c                |  1 -
 fs/squashfs/dir.c                     |  2 ++
 fs/squashfs/file.c                    |  4 +++-
 fs/udf/dir.c                          |  2 ++
 fs/udf/file.c                         |  2 ++
 fs/ufs/dir.c                          |  2 ++
 fs/ufs/file.c                         |  2 ++
 fs/vboxsf/dir.c                       |  1 -
 fs/vboxsf/file.c                      |  1 -
 fs/xfs/xfs_file.c                     |  3 +++
 include/linux/fs.h                    |  1 -
 mm/shmem.c                            |  2 ++
 62 files changed, 117 insertions(+), 42 deletions(-)

