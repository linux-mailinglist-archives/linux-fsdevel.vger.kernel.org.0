Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F2662B9498
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Nov 2020 15:31:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727694AbgKSO1G (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 19 Nov 2020 09:27:06 -0500
Received: from lilium.sigma-star.at ([109.75.188.150]:58536 "EHLO
        lilium.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727214AbgKSO1E (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 19 Nov 2020 09:27:04 -0500
Received: from localhost (localhost [127.0.0.1])
        by lilium.sigma-star.at (Postfix) with ESMTP id 3FE14181C88E8;
        Thu, 19 Nov 2020 15:18:26 +0100 (CET)
Received: from lilium.sigma-star.at ([127.0.0.1])
        by localhost (lilium.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id KYEAPqzs0CVc; Thu, 19 Nov 2020 15:18:25 +0100 (CET)
Received: from lilium.sigma-star.at ([127.0.0.1])
        by localhost (lilium.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id OqOEmPr6IOK7; Thu, 19 Nov 2020 15:18:25 +0100 (CET)
From:   Richard Weinberger <richard@nod.at>
To:     miklos@szeredi.hu
Cc:     miquel.raynal@bootlin.com, vigneshr@ti.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org, Richard Weinberger <richard@nod.at>
Subject: [PATCH 0/5] [RFC] MUSE: Userspace backed MTD
Date:   Thu, 19 Nov 2020 15:16:54 +0100
Message-Id: <20201119141659.26176-1-richard@nod.at>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

When working with flash devices a common task is emulating them to run va=
rious
tests or inspect dumps from real hardware. To achieve that we have plenty=
 of
emulators in the mtd subsystem: mtdram, block2mtd, nandsim.

Each of them implements a adhoc MTD and have various drawbacks.
Over the last years some developers tried to extend them but these attemp=
ts
often got rejected because they added just more adhoc feature instead of
addressing overall problems.

MUSE is a novel approach to address the need of advanced MTD emulators.
Advanced means in this context supporting different (vendor specific) ima=
ge
formats, different ways for fault injection (fuzzing) and recoding/replay=
ing
IOs to emulate power cuts.

The core goal of MUSE is having the complexity on the userspace side and
only a small MTD driver in kernelspace.
While playing with different approaches I realized that FUSE offers every=
thing
we need. So MUSE is a little like CUSE except that it does not implement =
a
bare character device but an MTD.

To get early feedback I'm sending this series as RFC, so don't consider i=
t as
ready to merge yet.

Open issues are:

1. Dummy file object
The logic around fuse_direct_io() expects a file object.
Unlike FUSE or CUSE we don't have such an object in MUSE because usually =
an
MTD is not opened by userspace. The kernel uses the MTD and makes it avai=
lable
to filesystems or other layers such as mtdblock, mtdchar or UBI.
Currently a anon inode is (ab)used for that.
Maybe there is a better way?

2. Init parameter passing
Currently parameter passing borrowed the logic from CUSE and parameters a=
re
passed as stringy key value pairs.
Most MTD paramerters are numbers (erase size, etc..) so passing them via
struct muse_init_out seems more natural.
But I plan to pass also pure string parameters such as an mtdparts comman=
d line.
What is the perffered way these days in FUSE?
Am I allowed to embed structs such as struct mtd_info_user (mtd-abi.h) in
muse_init_out?

3. MUSE specific FUSE ops
At this time MUSE_INIT, FUSE_READ, FUSE_WRITE, FUSE_FSYNC and MUSE_ERASE =
are
used.

I plan to get rid of FUSE_READ and FUSE_WRITE too. On NAND'ish MTDs there=
 is
out of band (OOB) data which can be read and written. Strictly speaking f=
or
testing UBI/UBIFS OOB is not needed but for JFFS2 it is.

FUSE_READ/WRITE also consider every non-zero return code as fatal and abo=
rt
the transfer. In MTD, -EUCLEAN and -EBADMSG are not fatal, a driver is
expected to return possible corrupted data and let the next layer deal
with it.
So far I found no good way how to encode this in FUSE_READ. Maybe you can
point me in the right direction?

This series can also be found at:
git://git.kernel.org/pub/scm/linux/kernel/git/rw/misc.git muse_v1

Richard Weinberger (5):
  fuse: Rename FUSE_DIO_CUSE
  fuse: Export fuse_simple_request
  fuse: Make cuse_parse_one a common helper
  mtd: Add MTD_MUSE flag
  fuse: Implement MUSE: MTD in userspace

 fs/fuse/Kconfig            |  15 ++
 fs/fuse/Makefile           |   2 +
 fs/fuse/cuse.c             |  62 +----
 fs/fuse/dev.c              |   1 +
 fs/fuse/file.c             |   4 +-
 fs/fuse/fuse_i.h           |   7 +-
 fs/fuse/helper.c           |  68 ++++++
 fs/fuse/muse.c             | 450 +++++++++++++++++++++++++++++++++++++
 include/uapi/linux/fuse.h  |  25 ++-
 include/uapi/mtd/mtd-abi.h |   1 +
 10 files changed, 571 insertions(+), 64 deletions(-)
 create mode 100644 fs/fuse/helper.c
 create mode 100644 fs/fuse/muse.c

--=20
2.26.2

