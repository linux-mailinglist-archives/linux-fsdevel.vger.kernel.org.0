Return-Path: <linux-fsdevel+bounces-9547-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B2429842A0C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jan 2024 17:53:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 510D81F2351C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jan 2024 16:53:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 238C281AB6;
	Tue, 30 Jan 2024 16:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="O3j0OrZH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E657086ADC;
	Tue, 30 Jan 2024 16:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706633591; cv=none; b=EKHxJ3fA+ILWUQd9x7CBnQDnY4R7bPScxhDL6I+NVJQXqH+h64t2OQKAiltORg/XPqs1jZvg299eazWGgfLzol133jwEcS4RDfWh6Je3KiLRxn3f4OkSWd0dZHmwIgq+NHlSIA+2pNMbtQPtg+xfISc++vmLVyXjqtr5KYoXvLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706633591; c=relaxed/simple;
	bh=Y0wTQsFQxBGihii2XUTlKjm4PLqLm9Iv8iRpB5W6oiU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=bjKCaPid54xCcpoxWexp/m3dIN+c+tYNVDF/Y60Zcs6EL9zMAo2S67p01d5LOEx63YiwXL2CuBlHNaHM6Qt2GLtmcANThAvHwpJBnDWn8uAXEhghoanIVhSBSlJtaQQI4agxIEo+zIxIwyCoEdTmABgWdRGfiuJZExPGGwmXt1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=O3j0OrZH; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1706633582;
	bh=Y0wTQsFQxBGihii2XUTlKjm4PLqLm9Iv8iRpB5W6oiU=;
	h=From:To:Cc:Subject:Date:From;
	b=O3j0OrZHAaPVHqKNJDlGd9sdFDBgJv7ZTPNfF/geXnNU8X+vdyJrGNeG7jc2PmFcT
	 vHVBTx2cw/X2mEB4vo+xPPWOPtfj3AJKyF1VL4ekbW/3UeTl1bhrPL7GJsbsUA4Xjf
	 QN5n1PkrJytSFnG4MMAUxz0Hshp1lnfrHlGiViw5dhz+dbt5tSbQFQdUYOVz5zEo+z
	 dkhR8Eo1aBMX3GoMv7Wy6G2ZBwdyZyWjGByfMC4pdfKcGaepdNqVweTXxNJdIP/9Jx
	 3w/wriketsu8SXr0KY8sxsTXpUqpeoZdN4oQeD4+Ioed20ctoxadZGPgNX63/gVKyG
	 2ldjjViqgwmkA==
Received: from thinkos.internal.efficios.com (192-222-143-198.qc.cable.ebox.net [192.222.143.198])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4TPWSZ2LkgzVCQ;
	Tue, 30 Jan 2024 11:53:02 -0500 (EST)
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To: Dan Williams <dan.j.williams@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Dave Jiang <dave.jiang@intel.com>
Cc: linux-kernel@vger.kernel.org,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	linux-mm@kvack.org,
	linux-arch@vger.kernel.org,
	Matthew Wilcox <willy@infradead.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Russell King <linux@armlinux.org.uk>,
	linux-cxl@vger.kernel.org,
	nvdimm@lists.linux.dev,
	linux-fsdevel@vger.kernel.org
Subject: [RFC PATCH v2 0/8] Introduce dcache_is_aliasing() to fix DAX regression
Date: Tue, 30 Jan 2024 11:52:47 -0500
Message-Id: <20240130165255.212591-1-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit introduced in v5.13 prevents building FS_DAX on 32-bit ARM,
even on ARMv7 which does not have virtually aliased dcaches:

commit d92576f1167c ("dax: does not work correctly with virtual aliasing caches")

It used to work fine before: I have customers using DAX over pmem on
ARMv7, but this regression will likely prevent them from upgrading their
kernel.

The root of the issue here is the fact that DAX was never designed to
handle virtually aliased dcache (VIVT and VIPT with aliased dcache). It
touches the pages through their linear mapping, which is not consistent
with the userspace mappings on virtually aliased dcaches.

This patch series introduces dcache_is_aliasing() with the new Kconfig
option ARCH_HAS_CACHE_ALIASING and implements it for all architectures.
The implementation of dcache_is_aliasing() is either evaluated to a
constant at compile-time or a runtime check, which is what is needed on
ARM.

With this we can basically narrow down the list of architectures which
are unsupported by DAX to those which are really affected.

Note that the order of the series was completely changed based on the
feedback received on v1, cache_is_aliasing() is renamed to
dcache_is_aliasing(), ARCH_HAS_CACHE_ALIASING_DYNAMIC is gone,
dcache_is_aliasing() vs ARCH_HAS_CACHE_ALIASING relationship is
simplified, and the dax_is_supported() check was moved to its rightful
place in all filesystems.

Feedback is welcome,

Thanks,

Mathieu

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-mm@kvack.org
Cc: linux-arch@vger.kernel.org
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Vishal Verma <vishal.l.verma@intel.com>
Cc: Dave Jiang <dave.jiang@intel.com>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Russell King <linux@armlinux.org.uk>
Cc: linux-cxl@vger.kernel.org
Cc: nvdimm@lists.linux.dev
Cc: linux-fsdevel@vger.kernel.org

Mathieu Desnoyers (8):
  dax: Introduce dax_is_supported()
  erofs: Use dax_is_supported()
  ext2: Use dax_is_supported()
  ext4: Use dax_is_supported()
  fuse: Use dax_is_supported()
  xfs: Use dax_is_supported()
  Introduce dcache_is_aliasing() across all architectures
  dax: Fix incorrect list of dcache aliasing architectures

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
 fs/Kconfig                          |  1 -
 fs/erofs/super.c                    |  5 ++++-
 fs/ext2/super.c                     |  6 +++++-
 fs/ext4/super.c                     |  5 ++++-
 fs/fuse/dax.c                       |  7 +++++++
 fs/xfs/xfs_iops.c                   |  2 +-
 include/linux/cacheinfo.h           |  6 ++++++
 include/linux/dax.h                 |  9 +++++++++
 mm/Kconfig                          |  6 ++++++
 29 files changed, 142 insertions(+), 5 deletions(-)
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


