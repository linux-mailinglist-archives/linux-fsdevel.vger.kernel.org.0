Return-Path: <linux-fsdevel+bounces-10098-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC800847B07
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Feb 2024 22:03:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C3D3FB28F36
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Feb 2024 21:03:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1C431308C6;
	Fri,  2 Feb 2024 21:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="xjzjRcKH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22A5C126F35;
	Fri,  2 Feb 2024 21:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706907631; cv=none; b=jf/HuTWHz0fwxBUBStaK8x4YWMmpt6CUKrL/q3KwcogWIPzYtQZLobLQ0ApgqyHc4PSfTePrh/rAqDh24YHGAKwDklue+koF2HQc4RiI5JRuGkh2RLFgEbSp++We++IJqrTlumjWjkJ5kd5fwWr6ZFLJgkSVLH4GhyIE6uQ/vr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706907631; c=relaxed/simple;
	bh=7Ochv10fF/HDECdDCBhY5k3B/jWscDOgrt50maoZBSM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=loAtgcHKugxaRK5AWl7e5VonpMbFuO6tjqTK8IW53fUoBr2gSR5gHQnDX2DUaVTkOwFJXBUQ9a9vebGbEVg2OZ0YuIoa3YzJ5BlRtZFqfw/Wh0AnP2ehg//lAQiOR167k+YLrzT4WnUH8NOljzUoRPR222Do2XXHWWMIMFs+FFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=xjzjRcKH; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1706907626;
	bh=7Ochv10fF/HDECdDCBhY5k3B/jWscDOgrt50maoZBSM=;
	h=From:To:Cc:Subject:Date:From;
	b=xjzjRcKHc51L5uKfgoLW2u8kKhQcQ2vVNWK/MJWjdE614MR4/YJkA1CwTEe73bbQQ
	 B9HyfCDUh7U0ymCixBQN8EiJgzkpW6+kLC9IvSas607tEiAr6kadxi+bJn5RUzSABk
	 nWHeEMWr/PgG+1BneAGKshZDLvngXgGNtmQ6U1dg9VAFgDpd/MAq57ojIIddXMTqyj
	 B6Zo1w7TxPuHLYzrtCkp62x4HF5uLit0wQ/pQraJaWYxXOvP89GmSYmoePEO47U+zj
	 C6bZ1Xg/IaMryfb+SACk6Vlr4te2Eu6M6BU4Oph1tlIewmiv0Nre/GFkq9H57Fehoq
	 A1W/ENWhVIuAA==
Received: from thinkos.internal.efficios.com (192-222-143-198.qc.cable.ebox.net [192.222.143.198])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4TRSpf4VlxzX6l;
	Fri,  2 Feb 2024 16:00:26 -0500 (EST)
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To: Dan Williams <dan.j.williams@intel.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Dave Chinner <david@fromorbit.com>
Cc: linux-kernel@vger.kernel.org,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Matthew Wilcox <willy@infradead.org>,
	Russell King <linux@armlinux.org.uk>,
	linux-arch@vger.kernel.org,
	linux-cxl@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-xfs@vger.kernel.org,
	dm-devel@lists.linux.dev,
	nvdimm@lists.linux.dev,
	linux-s390@vger.kernel.org
Subject: [RFC PATCH v4 00/12] Introduce cpu_dcache_is_aliasing() to fix DAX regression
Date: Fri,  2 Feb 2024 16:00:07 -0500
Message-Id: <20240202210019.88022-1-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit introduced in v4.0 prevents building FS_DAX on 32-bit ARM,
even on ARMv7 which does not have virtually aliased data caches:

commit d92576f1167c ("dax: does not work correctly with virtual aliasing caches")

It used to work fine before: I have customers using DAX over pmem on
ARMv7, but this regression will likely prevent them from upgrading their
kernel.

The root of the issue here is the fact that DAX was never designed to
handle virtually aliasing data caches (VIVT and VIPT with aliasing data
cache). It touches the pages through their linear mapping, which is not
consistent with the userspace mappings with virtually aliasing data
caches.

This patch series introduces cpu_dcache_is_aliasing() with the new
Kconfig option ARCH_HAS_CPU_CACHE_ALIASING and implements it for all
architectures. The implementation of cpu_dcache_is_aliasing() is either
evaluated to a constant at compile-time or a runtime check, which is
what is needed on ARM.

With this we can basically narrow down the list of architectures which
are unsupported by DAX to those which are really affected.

Testing done so far:

- Compile allyesconfig on x86-64,
- Compile allyesconfig on x86-64, with FS_DAX=n.
- Compile allyesconfig on x86-64, with DAX=n.
- Boot test after modifying alloc_dax() to force returning -EOPNOTSUPP
  even on x86-64, thus simulating the behavior expected on an
  architecture with data cache aliasing.

There are many more axes to test however. I would welcome Tested-by for:

- affected architectures,
- affected drivers,
- affected filesytems.

Thanks,

Mathieu

Changes since v3:
- Fix a leak on dax_add_host() failure in nvdimm/pmem.
- Split the series into a bissectable sequence of changes.
- Ensure that device-dax use-cases still works on data cache
  aliasing architectures.

Changes since v2:
- Move DAX supported runtime check to alloc_dax(),
- Modify DM to handle alloc_dax() error as non-fatal,
- Remove all filesystem modifications, since the check is now done by
  alloc_dax(),
- rename "dcache" and "cache" to "cpu dcache" and "cpu cache" to
  eliminate confusion with VFS terminology.

Changes since v1:
- The order of the series was completely changed based on the
  feedback received on v1,
- cache_is_aliasing() is renamed to dcache_is_aliasing(),
- ARCH_HAS_CACHE_ALIASING_DYNAMIC is gone,
- dcache_is_aliasing() vs ARCH_HAS_CACHE_ALIASING relationship is
  simplified,
- the dax_is_supported() check was moved to its rightful place in all
  filesystems.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Vishal Verma <vishal.l.verma@intel.com>
Cc: Dave Jiang <dave.jiang@intel.com>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Russell King <linux@armlinux.org.uk>
Cc: linux-arch@vger.kernel.org
Cc: linux-cxl@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org
Cc: linux-mm@kvack.org
Cc: linux-xfs@vger.kernel.org
Cc: dm-devel@lists.linux.dev
Cc: nvdimm@lists.linux.dev
Cc: linux-s390@vger.kernel.org

Mathieu Desnoyers (12):
  nvdimm/pmem: Fix leak on dax_add_host() failure
  nvdimm/pmem: Treat alloc_dax() -EOPNOTSUPP failure as non-fatal
  dm: Treat alloc_dax() -EOPNOTSUPP failure as non-fatal
  dcssblk: Handle alloc_dax() -EOPNOTSUPP failure
  virtio: Treat alloc_dax() -EOPNOTSUPP failure as non-fatal
  dax: Check for data cache aliasing at runtime
  Introduce cpu_dcache_is_aliasing() across all architectures
  dax: Fix incorrect list of data cache aliasing architectures
  nvdimm/pmem: Cleanup alloc_dax() error handling
  dm: Cleanup alloc_dax() error handling
  dcssblk: Cleanup alloc_dax() error handling
  virtio: Cleanup alloc_dax() error handling

 arch/arc/Kconfig                    |  1 +
 arch/arc/include/asm/cachetype.h    |  9 +++++++++
 arch/arm/Kconfig                    |  1 +
 arch/arm/include/asm/cachetype.h    |  2 ++
 arch/csky/Kconfig                   |  1 +
 arch/csky/include/asm/cachetype.h   |  9 +++++++++
 arch/m68k/Kconfig                   |  1 +
 arch/m68k/include/asm/cachetype.h   |  9 +++++++++
 arch/mips/Kconfig                   |  1 +
 arch/mips/include/asm/cachetype.h   |  9 +++++++++
 arch/nios2/Kconfig                  |  1 +
 arch/nios2/include/asm/cachetype.h  | 10 ++++++++++
 arch/parisc/Kconfig                 |  1 +
 arch/parisc/include/asm/cachetype.h |  9 +++++++++
 arch/sh/Kconfig                     |  1 +
 arch/sh/include/asm/cachetype.h     |  9 +++++++++
 arch/sparc/Kconfig                  |  1 +
 arch/sparc/include/asm/cachetype.h  | 14 ++++++++++++++
 arch/xtensa/Kconfig                 |  1 +
 arch/xtensa/include/asm/cachetype.h | 10 ++++++++++
 drivers/dax/super.c                 | 14 ++++++++++++++
 drivers/md/dm.c                     | 17 +++++++++--------
 drivers/nvdimm/pmem.c               | 23 ++++++++++++-----------
 drivers/s390/block/dcssblk.c        | 11 ++++++-----
 fs/Kconfig                          |  1 -
 fs/fuse/virtio_fs.c                 | 15 +++++++++++----
 include/linux/cacheinfo.h           |  6 ++++++
 include/linux/dax.h                 |  6 +-----
 mm/Kconfig                          |  6 ++++++
 29 files changed, 165 insertions(+), 34 deletions(-)
 create mode 100644 arch/arc/include/asm/cachetype.h
 create mode 100644 arch/csky/include/asm/cachetype.h
 create mode 100644 arch/m68k/include/asm/cachetype.h
 create mode 100644 arch/mips/include/asm/cachetype.h
 create mode 100644 arch/nios2/include/asm/cachetype.h
 create mode 100644 arch/parisc/include/asm/cachetype.h
 create mode 100644 arch/sh/include/asm/cachetype.h
 create mode 100644 arch/sparc/include/asm/cachetype.h
 create mode 100644 arch/xtensa/include/asm/cachetype.h

-- 
2.39.2

