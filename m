Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C5FA41485B7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Jan 2020 14:13:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389240AbgAXNNn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Jan 2020 08:13:43 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:59155 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389106AbgAXNNn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Jan 2020 08:13:43 -0500
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1iuym5-0003aD-RR; Fri, 24 Jan 2020 14:13:25 +0100
Received: from sha by dude.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1iuym4-0006Z6-Vz; Fri, 24 Jan 2020 14:13:24 +0100
From:   Sascha Hauer <s.hauer@pengutronix.de>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-mtd@lists.infradead.org, Jan Kara <jack@suse.com>,
        Richard Weinberger <richard@nod.at>, kernel@pengutronix.de,
        Sascha Hauer <s.hauer@pengutronix.de>
Subject: [PATCH v4 0/8] Add quota support to UBIFS
Date:   Fri, 24 Jan 2020 14:13:15 +0100
Message-Id: <20200124131323.23885-1-s.hauer@pengutronix.de>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::7
X-SA-Exim-Mail-From: sha@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-fsdevel@vger.kernel.org
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


This series adds quota support to UBIFS.

Integrated more review feedback this time, see changelog.

This series follows a very simple approach to quota: Neither the quota
limits nor the quota usage are ever written to the medium. The quota
usage is reconstructed from the filesystem during mount time. The quota
limits must be set by the user each time after mount. This is probably
not very convenient for systems that are used interactively, but UBIFS
is targetted to embedded systems and here running a script after mount
shouldn't be a problem. This of course isn't the way quota was thought
to be, but I believe this is a good compromise for a feature that I predict
is only rarely used on UBIFS. The big upside of this approach is that
no on-disk format changes are required and thus we can't get any
broken/corrupt filesystems because of quota support. Reconstructing the
quota data each time during mount has an noticable but I think for many
cases acceptable time overhead. I mounted a ~56MiB rootfs with 1920 files
which takes around 0.7s longer when quota is enabled.

As UBIFS works on mtd there is no block_device involved. The quotactl
system call requires a path to a block device as argument. To overcome
this we add support for passing the mount point instead. This is done
with a new Q_PATH flag to the quotactl syscall indicating that the special
argument belongs to the mount path rather than a path to the block device
file

The UBIFS quota support itself is based on a series by Dongsheng Yang
posted here:
http://lists.infradead.org/pipermail/linux-mtd/2015-September/061812.html
This part hasn't changed much, except that the code for reading and writing
quota files has been dropped.

Sascha

changes since v3:
- implement ubifs_dqblk_find() using ubifs_dqblk_find_next()
- Fix copy/paste errors in flag settings
- drop unnecessary inline declaration
- add ubifs_assert() for catching wrong usage of setflags()
- add helper function for projid checking
- Add a feature flag for supporting projid

changes since v2:
- Rebase on Jans quota-without-inode series
- Use recently introduced vfs_ioc_fssetxattr_check() and simple_fill_fsxattr()
- fix project quota support (was broken in v2 due to upstream changes in UBIFS)
- check for illegal renames due to different project id

Changes since v1:
- Introduce Q_PATH flag to make passing a mountpath explicit
- Do not mess with fs layer as suggested by Al Viro
- create separate usrquota, grpquota and prjquota options rather than just
  a single quota option
- register a UBIFS specific quota_format and use dquot_enable()
- drop "quota: Only module_put the format when existing" which is no
  longer necesary

Sascha Hauer (8):
  quota: Allow to pass mount path to quotactl
  ubifs: move checks and preparation into setflags()
  ubifs: Add support for FS_IOC_FS[SG]ETXATTR ioctls
  ubifs: do not ubifs_inode() on potentially NULL pointer
  ubifs: Factor out ubifs_set_feature_flag()
  ubifs: Add support for project id
  ubifs: export get_znode
  ubifs: Add quota support


Sascha Hauer (8):
  quota: Allow to pass mount path to quotactl
  ubifs: move checks and preparation into setflags()
  ubifs: Add support for FS_IOC_FS[SG]ETXATTR ioctls
  ubifs: do not ubifs_inode() on potentially NULL pointer
  ubifs: Factor out ubifs_set_feature_flag()
  ubifs: Add support for project id
  ubifs: export get_znode
  ubifs: Add quota support

 Documentation/filesystems/ubifs.txt |   7 +-
 fs/quota/quota.c                    |  53 ++-
 fs/ubifs/Makefile                   |   1 +
 fs/ubifs/dir.c                      |  56 ++-
 fs/ubifs/file.c                     |  43 ++
 fs/ubifs/ioctl.c                    | 220 ++++++++--
 fs/ubifs/journal.c                  |   4 +-
 fs/ubifs/quota.c                    | 603 ++++++++++++++++++++++++++++
 fs/ubifs/sb.c                       |  29 +-
 fs/ubifs/super.c                    |  87 +++-
 fs/ubifs/tnc.c                      |  34 +-
 fs/ubifs/ubifs-media.h              |  10 +-
 fs/ubifs/ubifs.h                    |  43 ++
 include/uapi/linux/quota.h          |   2 +
 14 files changed, 1117 insertions(+), 75 deletions(-)
 create mode 100644 fs/ubifs/quota.c

-- 
2.25.0

