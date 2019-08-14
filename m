Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0FB408D2D6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Aug 2019 14:19:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727266AbfHNMTF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 14 Aug 2019 08:19:05 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:49939 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727010AbfHNMTE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 14 Aug 2019 08:19:04 -0400
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1hxsEp-0005k9-EW; Wed, 14 Aug 2019 14:18:47 +0200
Received: from sha by dude.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1hxsEm-00080y-Kp; Wed, 14 Aug 2019 14:18:44 +0200
From:   Sascha Hauer <s.hauer@pengutronix.de>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-mtd@lists.infradead.org, Jan Kara <jack@suse.com>,
        Richard Weinberger <richard@nod.at>, kernel@pengutronix.de,
        Sascha Hauer <s.hauer@pengutronix.de>
Subject: [PATCH 00/11] Add quota support to UBIFS
Date:   Wed, 14 Aug 2019 14:18:23 +0200
Message-Id: <20190814121834.13983-1-s.hauer@pengutronix.de>
X-Mailer: git-send-email 2.20.1
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
this we add support for passing the mount point instead. quota uses
 get_super_exclusive_thawed(), get_super_thawed() and get_super() to
get hold of a super_block. All these functions require a block_device
which we do not have for UBIFS, so this code has to be refactored a bit.
I'm a bit outside of my comfort zone here, so please review carefully ;)

The UBIFS quota support itself is based on a series by Dongsheng Yang
posted here:
http://lists.infradead.org/pipermail/linux-mtd/2015-September/061812.html
This part hasn't changed much, except that the code for reading and writing
quota files has been dropped.

Sascha

Dongsheng Yang (1):
  ubifs: Add quota support

Sascha Hauer (10):
  quota: Make inode optional
  quota: Only module_put the format when existing
  fs: move __get_super() out of loop
  fs, quota: introduce wait_super_thawed() to wait until a superblock is
    thawed
  quota: Allow to pass quotactl a mountpoint
  ubifs: move checks and preparation into setflags()
  ubifs: Add support for FS_IOC_FS[SG]ETXATTR ioctls
  ubifs: do not ubifs_inode() on potentially NULL pointer
  ubifs: Add support for project id
  ubifs: export get_znode

 fs/quota/dquot.c       |   9 +-
 fs/quota/quota.c       |  79 ++++--
 fs/super.c             |  74 +++---
 fs/ubifs/Makefile      |   1 +
 fs/ubifs/dir.c         |  31 ++-
 fs/ubifs/file.c        |  43 +++
 fs/ubifs/ioctl.c       | 222 ++++++++++++++--
 fs/ubifs/journal.c     |   4 +-
 fs/ubifs/quota.c       | 590 +++++++++++++++++++++++++++++++++++++++++
 fs/ubifs/super.c       |  46 +++-
 fs/ubifs/tnc.c         |  34 +--
 fs/ubifs/ubifs-media.h |   6 +-
 fs/ubifs/ubifs.h       |  33 +++
 include/linux/fs.h     |   5 +-
 14 files changed, 1076 insertions(+), 101 deletions(-)
 create mode 100644 fs/ubifs/quota.c

-- 
2.20.1

