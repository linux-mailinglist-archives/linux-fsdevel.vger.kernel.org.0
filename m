Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 994B8E9EDE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Oct 2019 16:27:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727133AbfJ3P1O (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 30 Oct 2019 11:27:14 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:34543 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726461AbfJ3P1O (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 30 Oct 2019 11:27:14 -0400
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1iPpsG-0003Xy-Om; Wed, 30 Oct 2019 16:27:04 +0100
Received: from sha by dude.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1iPpsF-0005n2-QI; Wed, 30 Oct 2019 16:27:03 +0100
From:   Sascha Hauer <s.hauer@pengutronix.de>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-mtd@lists.infradead.org, Jan Kara <jack@suse.com>,
        Richard Weinberger <richard@nod.at>, kernel@pengutronix.de,
        Sascha Hauer <s.hauer@pengutronix.de>
Subject: [PATCH v2 00/10] Add quota support to UBIFS
Date:   Wed, 30 Oct 2019 16:26:52 +0100
Message-Id: <20191030152702.14269-1-s.hauer@pengutronix.de>
X-Mailer: git-send-email 2.24.0.rc1
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

It's been a while since I last time posted this series. Here's an update
with the review feedback I received integrated. There are quite some
if(!inode) sprinkled in the quota code, maybe this could be done more
clever. I think this series is a good improvement to the last one I sent
though, so I decided to send it out like this for now.

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

Changes since v1:
- Introduce Q_PATH flag to make passing a mountpath explicit
- Do not mess with fs layer as suggested by Al Viro
- create separate usrquota, grpquota and prjquota options rather than just
  a single quota option
- register a UBIFS specific quota_format and use dquot_enable()
- drop "quota: Only module_put the format when existing" which is no
  longer necesary

Sascha Hauer (10):
  quota: Make inode optional
  quota: Pass sb to vfs_load_quota_inode()
  quota: Introduce dquot_enable_sb()
  quota: Allow to pass mount path to quotactl
  ubifs: move checks and preparation into setflags()
  ubifs: Add support for FS_IOC_FS[SG]ETXATTR ioctls
  ubifs: do not ubifs_inode() on potentially NULL pointer
  ubifs: Add support for project id
  ubifs: export get_znode
  ubifs: Add quota support

 Documentation/filesystems/ubifs.txt |   7 +-
 fs/quota/dquot.c                    |  66 ++-
 fs/quota/quota.c                    |  37 +-
 fs/ubifs/Makefile                   |   1 +
 fs/ubifs/dir.c                      |  31 +-
 fs/ubifs/file.c                     |  43 ++
 fs/ubifs/ioctl.c                    | 222 +++++++++-
 fs/ubifs/journal.c                  |   4 +-
 fs/ubifs/quota.c                    | 609 ++++++++++++++++++++++++++++
 fs/ubifs/super.c                    |  83 +++-
 fs/ubifs/tnc.c                      |  34 +-
 fs/ubifs/ubifs-media.h              |   6 +-
 fs/ubifs/ubifs.h                    |  42 ++
 include/linux/quotaops.h            |   2 +
 include/uapi/linux/quota.h          |   2 +
 15 files changed, 1110 insertions(+), 79 deletions(-)
 create mode 100644 fs/ubifs/quota.c

-- 
2.24.0.rc1

