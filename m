Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02AD22C5E2F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Nov 2020 00:36:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391971AbgKZXdl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 26 Nov 2020 18:33:41 -0500
Received: from lilium.sigma-star.at ([109.75.188.150]:55254 "EHLO
        lilium.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391952AbgKZXdl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 26 Nov 2020 18:33:41 -0500
Received: from localhost (localhost [127.0.0.1])
        by lilium.sigma-star.at (Postfix) with ESMTP id 3948F18191058;
        Fri, 27 Nov 2020 00:33:38 +0100 (CET)
Received: from lilium.sigma-star.at ([127.0.0.1])
        by localhost (lilium.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id dbwzsOq9we2G; Fri, 27 Nov 2020 00:33:37 +0100 (CET)
Received: from lilium.sigma-star.at ([127.0.0.1])
        by localhost (lilium.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id ojufQZoP_csG; Fri, 27 Nov 2020 00:33:37 +0100 (CET)
From:   Richard Weinberger <richard@nod.at>
To:     miklos@szeredi.hu
Cc:     miquel.raynal@bootlin.com, vigneshr@ti.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org, Richard Weinberger <richard@nod.at>
Subject: [PATCH 0/7] [RFC] MUSE: Userspace backed MTD v2
Date:   Fri, 27 Nov 2020 00:32:53 +0100
Message-Id: <20201126233300.10714-1-richard@nod.at>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

First of all, sorry for sending v2 before getting a review.
I found a much better way to process IO and to get rid of all hacks
from v1.


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

1. Init parameter passing
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

2. OOB (out of band) handling
So far OOB support is not implemented. I plan to do so.
Mabye just the bare minimum to make jffs2 happy.
I'm still digging into FUSE to find a nice way how to implement
it.

Changes since v1:
- Rewrote IO path, fuse_direct_io() is no longer used.
  Instead of cheating fuse_direct_io() use custom ops to implement
  reading and writing. That way MUSE no longer needs a dummy file object
  nor a fuse file object.
  In MTD all IO is synchronous and operations on kernel buffers, this
  makes IO processing simple for MUSE.
- Support for bad blocks.
- No more (ab)use of FUSE ops such as FUSE_FSYNC.
- Major code cleanup.

This series can also be found at:
git://git.kernel.org/pub/scm/linux/kernel/git/rw/misc.git muse_v2

Richard Weinberger (7):
  fuse: Export fuse_simple_request
  fuse: Export IO helpers
  fuse: Make cuse_parse_one a common helper
  mtd: Add MTD_MUSE flag
  fuse: Add MUSE specific defines FUSE interface
  fuse: Implement MUSE: MTD in userspace
  MAINTAINERS: Add entry for MUSE

 MAINTAINERS                |   7 +
 fs/fuse/Kconfig            |  15 +
 fs/fuse/Makefile           |   2 +
 fs/fuse/cuse.c             |  58 +--
 fs/fuse/dev.c              |   1 +
 fs/fuse/file.c             |  16 +-
 fs/fuse/fuse_i.h           |  18 +
 fs/fuse/helper.c           |  70 ++++
 fs/fuse/muse.c             | 730 +++++++++++++++++++++++++++++++++++++
 include/uapi/linux/fuse.h  |  73 +++-
 include/uapi/mtd/mtd-abi.h |   1 +
 11 files changed, 920 insertions(+), 71 deletions(-)
 create mode 100644 fs/fuse/helper.c
 create mode 100644 fs/fuse/muse.c

--=20
2.26.2

