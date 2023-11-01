Return-Path: <linux-fsdevel+bounces-1766-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AA487DE690
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Nov 2023 20:57:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 75F4E1C20E00
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Nov 2023 19:57:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 187471A265;
	Wed,  1 Nov 2023 19:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="NnRz+sQF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FA05101FD
	for <linux-fsdevel@vger.kernel.org>; Wed,  1 Nov 2023 19:57:48 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C6E69F;
	Wed,  1 Nov 2023 12:57:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Sender:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=EWtpRWigEp4aNg0HcdQgbJ0QY7oVa1tRy34Oox0Ohhk=; b=NnRz+sQFO4TaN94d+IZKtQuMXa
	cH/22Apxzzalu/C7pYjKBwNwEAPg3QUDEyftbtCu9f4hFgnTzl9gSEt3Bah561+oyL7o/S5JcRU2T
	zH0t5N8ah2UCoyW8LbIi/PDXQWzdd1aH+rvsnTWlUR2C68rS2MAfOsvRMqw+ydFrr/EbBfM6id+4e
	AlMY7gZue7oKfDyUoURzx/OunTlAppdPithXjHzMkTwu0CdPW0b6CFdjbJzQQS0TAC2CI4gJVc3ig
	Ig0E76C6JGn5eZldwc2n/rDAiDRXyk/jPZ05mULtXrH63I0PT5szzRPfRQ7EzG1ACA9aL8CApgFhj
	bXRm0N1g==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
	id 1qyHLS-0083qj-2c;
	Wed, 01 Nov 2023 19:57:42 +0000
Date: Wed, 1 Nov 2023 12:57:42 -0700
From: Luis Chamberlain <mcgrof@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Joel Granados <joel.granados@gmail.com>,
	Krister Johansen <kjlx@templeofstupid.com>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	Kees Cook <keescook@chromium.org>,
	Iurii Zaikin <yzaikin@google.com>
Subject: [GIT PULL] sysctl changes for v6.7-rc1
Message-ID: <ZUKttkQ2/hgweOQP@bombadil.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Luis Chamberlain <mcgrof@infradead.org>

The following changes since commit ce9ecca0238b140b88f43859b211c9fdfd8e5b70:

  Linux 6.6-rc2 (2023-09-17 14:40:24 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux.git/ tags/sysctl-6.7-rc1

for you to fetch changes up to 8b793bcda61f6c3ed4f5b2ded7530ef6749580cb:

  watchdog: move softlockup_panic back to early_param (2023-11-01 12:10:02 -0700)

----------------------------------------------------------------
sysctl-6.7-rc1

To help make the move of sysctls out of kernel/sysctl.c not incur a size
penalty sysctl has been changed to allow us to not require the sentinel, the
final empty element on the sysctl array. Joel Granados has been doing all this
work. On the v6.6 kernel we got the major infrastructure changes required to
support this. For v6.7-rc1 we have all arch/ and drivers/ modified to remove
the sentinel. Both arch and driver changes have been on linux-next for a bit
less than a month. It is worth re-iterating the value:

  - this helps reduce the overall build time size of the kernel and run time
     memory consumed by the kernel by about ~64 bytes per array
  - the extra 64-byte penalty is no longer inncurred now when we move sysctls
    out from kernel/sysctl.c to their own files

For v6.8-rc1 expect removal of all the sentinels and also then the unneeded
check for procname == NULL.

The last 2 patches are fixes recently merged by Krister Johansen which allow
us again to use softlockup_panic early on boot. This used to work but the
alias work broke it. This is useful for folks who want to detect softlockups
super early rather than wait and spend money on cloud solutions with nothing
but an eventual hung kernel. Although this hadn't gone through linux-next it's
also a stable fix, so we might as well roll through the fixes now.

----------------------------------------------------------------
Joel Granados (21):
      S390: Remove now superfluous sentinel elem from ctl_table arrays
      arm: Remove now superfluous sentinel elem from ctl_table arrays
      arch/x86: Remove now superfluous sentinel elem from ctl_table arrays
      x86/vdso: Remove now superfluous sentinel element from ctl_table array
      riscv: Remove now superfluous sentinel element from ctl_table array
      powerpc: Remove now superfluous sentinel element from ctl_table arrays
      c-sky: Remove now superfluous sentinel element from ctl_talbe array
      hpet: Remove now superfluous sentinel element from ctl_table array
      xen: Remove now superfluous sentinel element from ctl_table array
      tty: Remove now superfluous sentinel element from ctl_table array
      scsi: Remove now superfluous sentinel element from ctl_table array
      parport: Remove the now superfluous sentinel element from ctl_table array
      macintosh: Remove the now superfluous sentinel element from ctl_table array
      infiniband: Remove the now superfluous sentinel element from ctl_table array
      char-misc: Remove the now superfluous sentinel element from ctl_table array
      vrf: Remove the now superfluous sentinel element from ctl_table array
      sgi-xp: Remove the now superfluous sentinel element from ctl_table array
      fw loader: Remove the now superfluous sentinel element from ctl_table array
      raid: Remove now superfluous sentinel element from ctl_table array
      Drivers: hv: Remove now superfluous sentinel element from ctl_table array
      intel drm: Remove now superfluous sentinel element from ctl_table array

Krister Johansen (2):
      proc: sysctl: prevent aliased sysctls from getting passed to init
      watchdog: move softlockup_panic back to early_param

 arch/arm/kernel/isa.c                         |  4 ++--
 arch/arm64/kernel/armv8_deprecated.c          |  8 +++-----
 arch/arm64/kernel/fpsimd.c                    |  2 --
 arch/arm64/kernel/process.c                   |  1 -
 arch/csky/abiv1/alignment.c                   |  1 -
 arch/powerpc/kernel/idle.c                    |  1 -
 arch/powerpc/platforms/pseries/mobility.c     |  1 -
 arch/riscv/kernel/vector.c                    |  1 -
 arch/s390/appldata/appldata_base.c            |  4 +---
 arch/s390/kernel/debug.c                      |  1 -
 arch/s390/kernel/topology.c                   |  1 -
 arch/s390/mm/cmm.c                            |  1 -
 arch/s390/mm/pgalloc.c                        |  1 -
 arch/x86/entry/vdso/vdso32-setup.c            |  1 -
 arch/x86/kernel/cpu/intel.c                   |  1 -
 arch/x86/kernel/itmt.c                        |  1 -
 drivers/base/firmware_loader/fallback_table.c |  1 -
 drivers/char/hpet.c                           |  1 -
 drivers/char/ipmi/ipmi_poweroff.c             |  1 -
 drivers/char/random.c                         |  1 -
 drivers/gpu/drm/i915/i915_perf.c              |  1 -
 drivers/hv/hv_common.c                        |  1 -
 drivers/infiniband/core/iwcm.c                |  1 -
 drivers/infiniband/core/ucma.c                |  1 -
 drivers/macintosh/mac_hid.c                   |  1 -
 drivers/md/md.c                               |  1 -
 drivers/misc/sgi-xp/xpc_main.c                |  2 --
 drivers/net/vrf.c                             |  1 -
 drivers/parport/procfs.c                      | 28 +++++++++++----------------
 drivers/perf/arm_pmuv3.c                      |  1 -
 drivers/scsi/scsi_sysctl.c                    |  1 -
 drivers/scsi/sg.c                             |  1 -
 drivers/tty/tty_io.c                          |  1 -
 drivers/xen/balloon.c                         |  1 -
 fs/proc/proc_sysctl.c                         |  8 +++++++-
 include/linux/sysctl.h                        |  6 ++++++
 init/main.c                                   |  4 ++++
 kernel/watchdog.c                             |  7 +++++++
 38 files changed, 41 insertions(+), 60 deletions(-)

