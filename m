Return-Path: <linux-fsdevel+bounces-61740-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B55F8B5987B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 16:01:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21E134E22B2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 14:00:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F3A6338F3E;
	Tue, 16 Sep 2025 13:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KrVb8ntp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39FB7324B1E
	for <linux-fsdevel@vger.kernel.org>; Tue, 16 Sep 2025 13:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758031179; cv=none; b=I4nqTPFwLSmLB2K+N6rs43eW6+x1bqtWi2mUO/IFVr5U0IO2QceldLpqnpGvcE7vIKBDef1LDYWsNFfDYR2zPk6MBX9WAfB6ozDK5HQOz+arLe74f3xRoMXXPpYC5wOsJ/OvoYBs5Cu+KDiO7MSzkLAwdcs5cREst88iCijaAf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758031179; c=relaxed/simple;
	bh=yLMPeF7r6XzF4rIgQOlbMWD/LlRZPUZb50aHf6jH/dk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rYqV+equUtw/xVFfosW9lunM+Uf1gDtC81j0Ize1IKHBoKLFqP5/Ki7vphdCusHf0aNABc9MXD5UX3HhRQHDM5EYEGlywUG0UH3n89BIjaItQglwWdZXnMnsYYu3G94nRwITxxQcrRx8Qf1lbw5CmpOedacxK5uhVSwnZ1S1xSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KrVb8ntp; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-45f31adf368so10029995e9.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 16 Sep 2025 06:59:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758031172; x=1758635972; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6DF2J2Z+6y5Gxjq0TsSAVydkfkGFo/dKJy7cslD4M0Y=;
        b=KrVb8ntpRRa4HzzscA4DR4ssaiQygJodW+YbzfPpjuCgIcBcguf92tFcPskU1yeiA6
         qwK5AnQsnqXsYGdg2fOr1VWxfavMyUYe5KwMUqiu3nFZKbhmfmXd/LDKCyQ/fHKAMCY2
         Pzk7fgJvy8f8D/rEbV+1hS7NLOkh/yZbm2JkbkmKJY29YryaT8X40+9ADQyERYlIMwe8
         8EymRnhOELDAxw+p2jA2ap03CScCwDd/1mMKcvoOPwGEVpvb1ds8j+eHGOgFY370A9Os
         KkaL+S+CYf+ptQVNF1dxsqURYcrPIZ7TXfInf425ETcSslWkVNbcpPmrdSmpaDEaS1BD
         2KXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758031172; x=1758635972;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6DF2J2Z+6y5Gxjq0TsSAVydkfkGFo/dKJy7cslD4M0Y=;
        b=oNWs3I79H2PWqrmiHPUQfaZrKjLovtmvPebuNrBkYczH6TpDt9HOI1+lToTdVlUHAF
         8V3iKnp2y8gczWL0w0exiRmBOvWPBbgN5w1Ds0i0ZmIqdt+KdpuWlv32XsbdsjnCwwyu
         6mBHvDNYqNkQNE8RuBCbTDyWgnaxmG1469IM1A2e0YqyYUoY6HsmYWmN4+DmjvONvHvV
         qwxDnMc6Cyx1HpsFrBq9/oU/tMvMhoA2Yy47wDgNVsh2cA0IcEVGM1Zu5fpSS+GQIjDb
         wqKVJ31KPPsqw3v+eDPu4KeZwd4T/VKdUByY51b7aJqds4rua2l2Bv2UggCXSXzHhJS6
         kEkg==
X-Forwarded-Encrypted: i=1; AJvYcCUpqTK0/RazjqRdJUrSYZ5EbWynUpzsk36jvpWiYRAcpSGFP6mI42dMkTKBTCSMWWqQSsOtimjHvfMuZbaH@vger.kernel.org
X-Gm-Message-State: AOJu0YyvXbNkBhGuqvwnjcEcmGHLYvGTKZn7woZGhEgK0tPfcB8Qt7Qs
	4NFRF1oOKWXx7aKzy9qqNOkSL1D6OFMoqzbULQU88XeKg6UV00+KCGH8
X-Gm-Gg: ASbGncvKIw9XEopxLliS6Tp1KBqE8sIYPfLTUduyP+DWSlV1TUg4Ya5Z6L0tLxQevy2
	LVBGr3eO69NdQMcz9zbRLNN2VWYgNO2YyUznc21N1JzpM3ayOzLIF/zhQks1Z8Awi/lDZy4gNao
	rpxCUG0uWM4s3yOm4unimr+M3rAJG82gz/z5oj3yIyswSz7BmtyKfobSKDGjAEOd+vdm3qbmGXV
	H6UFnstcP3x6f8iNGIGhZkL7br81tea55jgpfqgEy18iXKALMtDocMY/IxWPqvBBCsveIunfXYy
	PLXYwpYhHmJMMy4LVMKDJHYUaRGElvYLKG7cajl3S2HOe6ZVQKIYdwxOu9RDQ8eEwClbPWrjbbw
	xxbKpoWg6nwkJGcTx1PS4oUpGt0yKJ7gF++ZO3FNIxRdfdJt+/jr5SP7Y7mNNjFpooHQFwoQoBt
	V8ycRy1JE=
X-Google-Smtp-Source: AGHT+IHkyxZSdleVcRcq5axlXGpzPCRLfwiNpgKrjAoChXMhNeI4RSYdJZPYfMUMQGJW4d225pPhzA==
X-Received: by 2002:a05:6000:4203:b0:3ea:63d:44ca with SMTP id ffacd0b85a97d-3ea063d4b3emr6612649f8f.32.1758031172282;
        Tue, 16 Sep 2025 06:59:32 -0700 (PDT)
Received: from f.. (cst-prg-88-146.cust.vodafone.cz. [46.135.88.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e7cde81491sm16557991f8f.42.2025.09.16.06.59.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 06:59:31 -0700 (PDT)
From: Mateusz Guzik <mjguzik@gmail.com>
To: brauner@kernel.org
Cc: viro@zeniv.linux.org.uk,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	josef@toxicpanda.com,
	kernel-team@fb.com,
	amir73il@gmail.com,
	linux-btrfs@vger.kernel.org,
	linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	ceph-devel@vger.kernel.org,
	linux-unionfs@vger.kernel.org,
	Mateusz Guzik <mjguzik@gmail.com>
Subject: [PATCH v4 00/12] hide ->i_state behind accessors
Date: Tue, 16 Sep 2025 15:58:48 +0200
Message-ID: <20250916135900.2170346-1-mjguzik@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is generated against:
https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git/commit/?h=vfs-6.18.inode.refcount.preliminaries

First commit message quoted verbatim with rationable + API:

[quote]
Open-coded accesses prevent asserting they are done correctly. One
obvious aspect is locking, but significantly more can checked. For
example it can be detected when the code is clearing flags which are
already missing, or is setting flags when it is illegal (e.g., I_FREEING
when ->i_count > 0).

In order to keep things manageable this patchset merely gets the thing
off the ground with only lockdep checks baked in.

Current consumers can be trivially converted.

Suppose flags I_A and I_B are to be handled, then if ->i_lock is held:

state = inode->i_state  	=> state = inode_state_read(inode)
inode->i_state |= (I_A | I_B) 	=> inode_state_add(inode, I_A | I_B)
inode->i_state &= ~(I_A | I_B) 	=> inode_state_del(inode, I_A | I_B)
inode->i_state = I_A | I_B	=> inode_state_set(inode, I_A | I_B)

If ->i_lock is not held or only held conditionally, add "_once"
suffix for the read routine or "_raw" for the rest:

state = inode->i_state  	=> state = inode_state_read_once(inode)
inode->i_state |= (I_A | I_B) 	=> inode_state_add_raw(inode, I_A | I_B)
inode->i_state &= ~(I_A | I_B) 	=> inode_state_del_raw(inode, I_A | I_B)
inode->i_state = I_A | I_B	=> inode_state_set_raw(inode, I_A | I_B)

The "_once" vs "_raw" discrepancy stems from the read variant differing
by READ_ONCE as opposed to just lockdep checks.
[/quote]

A series with one patch per subsystem/filesystem is quite big (over 50
largely trivial mails) and that's probably not warranted. Instead, core
kernel was handled in one commit and only file systems with changes
which should be looked at got split (all the rest is one combined commit).
This all mostly mechanical churn and that alone should not be
objectional. If someone does not like the API, they should raise it
here.

per-fs postings are there in case something is correctly marked as
unlocked access.

Note that in the worst case should a mistake be made here, it either
will fail to spot ->i_lock not being held (which is equivalent to the
stock state) OR it will generate a lockdep splat. While not pretty, it
is loud and readily fixable. Otherwise this patchset is a NOP.

Testing was limited:
kernel with CONFIG_DEBUG_VFS + lockdep was booted with ext4, survived
kernel builds and whatnot. xfs and btrfs filesystems were mounted had
files linked and unlinked on them.

I very much will need someone with more resources to give this a
beating. I tried to err on the side of expecting the caller does *need*
->i_lock and it is possible something is using inode_state_read()
instead of inode_state_read_once() as a result. If so, there will be a
lockdep splat though.

Coccinelle was used to do the conversion, with all changes audited +
some manual fixups (more eyes welcome):

@@
expression inode, flags;
@@

- inode->i_state & flags
+ inode_state_read(inode) & flags

@@
expression inode, flags;
@@

- inode->i_state &= ~flags
+ inode_state_del(inode, flags)

@@
expression inode, flags;
@@

- inode->i_state |= flags
+ inode_state_add(inode, flags)

@@
expression inode, flags;
@@

- inode->i_state = flags
+ inode_state_set_raw(inode, flags)

Patch breakdown:
  fs: provide accessors for ->i_state

This only adds the routines, nothing is using them and overall it's a
NOP.

  fs: use ->i_state accessors in core kernel

Converts the entirety of the kernel modulo specific file systems.

  fs: mechanically convert most filesystems to use ->i_state accessors

This includes all trivial changes (mostly when the filesystem just
checks for I_NEW after getting the inode from the hash).

  btrfs: use the new ->i_state accessors
  netfs: use the new ->i_state accessors
  nilfs2: use the new ->i_state accessors
  xfs: use the new ->i_state accessors
  ext4: use the new ->i_state accessors
  f2fs: use the new ->i_state accessors
  ceph: use the new ->i_state accessors
  overlayfs: use the new ->i_state accessors

Per-fs split if there was more work in the area just to sanity check by
interested parties.

  fs: make plain ->i_state access fail to compile

This hides ->i_state behind a struct, so things nicely fail to compile
if someone open-codes plain access.

v3:
- rename accessors (s/unchecked/raw; s/unstable/once/)
- rebase
- provide actual commit messages
- per fs patches as I deemed applicable

Mateusz Guzik (12):
  fs: provide accessors for ->i_state
  fs: use ->i_state accessors in core kernel
  fs: mechanically convert most filesystems to use ->i_state accessors
  btrfs: use the new ->i_state accessors
  netfs: use the new ->i_state accessors
  nilfs2: use the new ->i_state accessors
  xfs: use the new ->i_state accessors
  ext4: use the new ->i_state accessors
  f2fs: use the new ->i_state accessors
  ceph: use the new ->i_state accessors
  overlayfs: use the new ->i_state accessors
  fs: make plain ->i_state access fail to compile

 block/bdev.c                     |   4 +-
 drivers/dax/super.c              |   2 +-
 fs/9p/vfs_inode.c                |   2 +-
 fs/9p/vfs_inode_dotl.c           |   2 +-
 fs/affs/inode.c                  |   2 +-
 fs/afs/dynroot.c                 |   6 +-
 fs/afs/inode.c                   |   8 +-
 fs/bcachefs/fs.c                 |   7 +-
 fs/befs/linuxvfs.c               |   2 +-
 fs/bfs/inode.c                   |   2 +-
 fs/btrfs/inode.c                 |  10 +--
 fs/buffer.c                      |   4 +-
 fs/ceph/cache.c                  |   2 +-
 fs/ceph/crypto.c                 |   4 +-
 fs/ceph/file.c                   |   4 +-
 fs/ceph/inode.c                  |  28 +++----
 fs/coda/cnode.c                  |   4 +-
 fs/cramfs/inode.c                |   2 +-
 fs/crypto/keyring.c              |   2 +-
 fs/crypto/keysetup.c             |   2 +-
 fs/dcache.c                      |   8 +-
 fs/drop_caches.c                 |   2 +-
 fs/ecryptfs/inode.c              |   6 +-
 fs/efs/inode.c                   |   2 +-
 fs/erofs/inode.c                 |   2 +-
 fs/ext2/inode.c                  |   2 +-
 fs/ext4/inode.c                  |  10 +--
 fs/ext4/orphan.c                 |   4 +-
 fs/f2fs/data.c                   |   2 +-
 fs/f2fs/inode.c                  |   2 +-
 fs/f2fs/namei.c                  |   4 +-
 fs/f2fs/super.c                  |   2 +-
 fs/freevxfs/vxfs_inode.c         |   2 +-
 fs/fs-writeback.c                | 123 ++++++++++++++++---------------
 fs/fuse/inode.c                  |   4 +-
 fs/gfs2/file.c                   |   2 +-
 fs/gfs2/glops.c                  |   2 +-
 fs/gfs2/inode.c                  |   4 +-
 fs/gfs2/ops_fstype.c             |   2 +-
 fs/hfs/btree.c                   |   2 +-
 fs/hfs/inode.c                   |   2 +-
 fs/hfsplus/super.c               |   2 +-
 fs/hostfs/hostfs_kern.c          |   2 +-
 fs/hpfs/dir.c                    |   2 +-
 fs/hpfs/inode.c                  |   2 +-
 fs/inode.c                       | 104 +++++++++++++-------------
 fs/isofs/inode.c                 |   2 +-
 fs/jffs2/fs.c                    |   4 +-
 fs/jfs/file.c                    |   4 +-
 fs/jfs/inode.c                   |   2 +-
 fs/jfs/jfs_txnmgr.c              |   2 +-
 fs/kernfs/inode.c                |   2 +-
 fs/libfs.c                       |   6 +-
 fs/minix/inode.c                 |   2 +-
 fs/namei.c                       |   8 +-
 fs/netfs/misc.c                  |   8 +-
 fs/netfs/read_single.c           |   6 +-
 fs/nfs/inode.c                   |   2 +-
 fs/nfs/pnfs.c                    |   2 +-
 fs/nfsd/vfs.c                    |   2 +-
 fs/nilfs2/cpfile.c               |   2 +-
 fs/nilfs2/dat.c                  |   2 +-
 fs/nilfs2/ifile.c                |   2 +-
 fs/nilfs2/inode.c                |  10 +--
 fs/nilfs2/sufile.c               |   2 +-
 fs/notify/fsnotify.c             |   2 +-
 fs/ntfs3/inode.c                 |   2 +-
 fs/ocfs2/dlmglue.c               |   2 +-
 fs/ocfs2/inode.c                 |  10 +--
 fs/omfs/inode.c                  |   2 +-
 fs/openpromfs/inode.c            |   2 +-
 fs/orangefs/inode.c              |   2 +-
 fs/orangefs/orangefs-utils.c     |   6 +-
 fs/overlayfs/dir.c               |   2 +-
 fs/overlayfs/inode.c             |   6 +-
 fs/overlayfs/util.c              |  10 +--
 fs/pipe.c                        |   2 +-
 fs/qnx4/inode.c                  |   2 +-
 fs/qnx6/inode.c                  |   2 +-
 fs/quota/dquot.c                 |   2 +-
 fs/romfs/super.c                 |   2 +-
 fs/smb/client/cifsfs.c           |   2 +-
 fs/smb/client/inode.c            |  14 ++--
 fs/squashfs/inode.c              |   2 +-
 fs/sync.c                        |   2 +-
 fs/ubifs/file.c                  |   2 +-
 fs/ubifs/super.c                 |   2 +-
 fs/udf/inode.c                   |   2 +-
 fs/ufs/inode.c                   |   2 +-
 fs/xfs/scrub/common.c            |   2 +-
 fs/xfs/scrub/inode_repair.c      |   2 +-
 fs/xfs/scrub/parent.c            |   2 +-
 fs/xfs/xfs_bmap_util.c           |   2 +-
 fs/xfs/xfs_health.c              |   4 +-
 fs/xfs/xfs_icache.c              |   6 +-
 fs/xfs/xfs_inode.c               |   6 +-
 fs/xfs/xfs_inode_item.c          |   4 +-
 fs/xfs/xfs_iops.c                |   2 +-
 fs/xfs/xfs_reflink.h             |   2 +-
 fs/zonefs/super.c                |   4 +-
 include/linux/backing-dev.h      |   5 +-
 include/linux/fs.h               |  70 +++++++++++++++++-
 include/linux/writeback.h        |   4 +-
 include/trace/events/writeback.h |   8 +-
 mm/backing-dev.c                 |   2 +-
 security/landlock/fs.c           |   2 +-
 106 files changed, 371 insertions(+), 310 deletions(-)

-- 
2.43.0


