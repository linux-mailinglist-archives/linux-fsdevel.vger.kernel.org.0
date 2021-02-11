Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A595318EC5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Feb 2021 16:39:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230521AbhBKPdi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 11 Feb 2021 10:33:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231343AbhBKPbQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 11 Feb 2021 10:31:16 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A626C06178B
        for <linux-fsdevel@vger.kernel.org>; Thu, 11 Feb 2021 07:30:36 -0800 (PST)
Received: from dude02.hi.pengutronix.de ([2001:67c:670:100:1d::28])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1lADvG-0006zC-Oo; Thu, 11 Feb 2021 16:30:26 +0100
Received: from sha by dude02.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1lADvF-0000A5-MZ; Thu, 11 Feb 2021 16:30:25 +0100
From:   Sascha Hauer <s.hauer@pengutronix.de>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>, kernel@pengutronix.de,
        Jan Kara <jack@suse.com>, Richard Weinberger <richard@nod.at>,
        Sascha Hauer <s.hauer@pengutronix.de>
Subject: [PATCH v2 0/2] quota: Add mountpath based quota support
Date:   Thu, 11 Feb 2021 16:30:21 +0100
Message-Id: <20210211153024.32502-1-s.hauer@pengutronix.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::28
X-SA-Exim-Mail-From: sha@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-fsdevel@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Current quotactl syscall uses a path to a block device to specify the
filesystem to work on which makes it unsuitable for filesystems that
do not have a block device. This series adds a new syscall quotactl_path()
which replaces the path to the block device with a mountpath, but otherwise
behaves like original quotactl.

This is done to add quota support to UBIFS. UBIFS quota support has been
posted several times with different approaches to put the mountpath into
the existing quotactl() syscall until it has been suggested to make it a
new syscall instead, so here it is.

I'm not posting the full UBIFS quota series here as it remains unchanged
and I'd like to get feedback to the new syscall first. For those interested
the most recent series can be found here: https://lwn.net/Articles/810463/

Changes since (implicit) v1:
- Ignore second path argument to Q_QUOTAON. With this quotactl_path() can
  only do the Q_QUOTAON operation on filesystems which use hidden inodes
  for quota metadata storage
- Drop unnecessary quotactl_cmd_onoff() check

Sascha Hauer (2):
  quota: Add mountpath based quota support
  quota: wire up quotactl_path

 arch/alpha/kernel/syscalls/syscall.tbl      |  1 +
 arch/arm/tools/syscall.tbl                  |  1 +
 arch/arm64/include/asm/unistd.h             |  2 +-
 arch/arm64/include/asm/unistd32.h           |  2 +
 arch/ia64/kernel/syscalls/syscall.tbl       |  1 +
 arch/m68k/kernel/syscalls/syscall.tbl       |  1 +
 arch/microblaze/kernel/syscalls/syscall.tbl |  1 +
 arch/mips/kernel/syscalls/syscall_n32.tbl   |  1 +
 arch/mips/kernel/syscalls/syscall_n64.tbl   |  1 +
 arch/mips/kernel/syscalls/syscall_o32.tbl   |  1 +
 arch/parisc/kernel/syscalls/syscall.tbl     |  1 +
 arch/powerpc/kernel/syscalls/syscall.tbl    |  1 +
 arch/s390/kernel/syscalls/syscall.tbl       |  1 +
 arch/sh/kernel/syscalls/syscall.tbl         |  1 +
 arch/sparc/kernel/syscalls/syscall.tbl      |  1 +
 arch/x86/entry/syscalls/syscall_32.tbl      |  1 +
 arch/x86/entry/syscalls/syscall_64.tbl      |  1 +
 arch/xtensa/kernel/syscalls/syscall.tbl     |  1 +
 fs/quota/quota.c                            | 49 +++++++++++++++++++++
 include/linux/syscalls.h                    |  2 +
 include/uapi/asm-generic/unistd.h           |  4 +-
 kernel/sys_ni.c                             |  1 +
 22 files changed, 74 insertions(+), 2 deletions(-)

-- 
2.20.1

