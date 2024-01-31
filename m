Return-Path: <linux-fsdevel+bounces-9672-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C169844410
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jan 2024 17:26:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 169141F28447
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jan 2024 16:26:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6BE112BF0D;
	Wed, 31 Jan 2024 16:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="HmNK3iFb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 202FB129A8D;
	Wed, 31 Jan 2024 16:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706718351; cv=none; b=ofVH/uolrglBC++dw51+r0cBD+V1b0KO7VIYVGNfzgTNNuEaM0BkV85FP6+LWl4eRpOWHQ9MdtNN/Wx3FGhGx6ifdnGnyvtW7LtvWNzejIfBsC1UKpyGqyQkf9elq7tGXlXz4ztuitCnO3+xNCC8OdS6bYVub8oEF9+qlXxC8u0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706718351; c=relaxed/simple;
	bh=SE0hCaz/UCatOaT7XYyPZfO37Tgvrd//zPyFSuYAShc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=LLxf0NUEowbVNWQJ3oZfPqKSiHy4svt68FhUul+Y9I2vSu+Qyf4Xs/Tan2GcXuC7/kYSC1Up3pxDN1JQOe7MFPr1qv7kh02kTjM4BTKVUdCuTkRGHXRcu77+4kctPghwaX88ky4Ev2GiC8pLGGz8LkY3apiOuy+xm1jyGfhDy8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=HmNK3iFb; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1706718348;
	bh=SE0hCaz/UCatOaT7XYyPZfO37Tgvrd//zPyFSuYAShc=;
	h=From:To:Cc:Subject:Date:From;
	b=HmNK3iFbnhZ9uL2TsXya0QhLbmSWEGjkJSAhi50JkcA/esMo4ok2j9htp8X63zx+3
	 YqkVXrI1HPbrOhhdVDzMjoU+x/vBXioLiikodDuerLU8hYerKMjK12GpnZQQKx2dIK
	 L9/PQ8Ow7DDL5mpxEYgJZq+9R7nXjAh7zCI1d4HlgcTr6mO03xXFUXvz9fKWcXsq/H
	 Au5igpoBzSDtsK4XyEvvoxS1HvP8w4HZ7JFdZf1sGkav8IhtCEyTWvzuI/PRST8W6V
	 XFJgrOB403KnY8sPWsjROZeDcwm1lpJ+JTVC3WCsx4ZsRpmSIuwLbvlGzuawNM7eqP
	 b9cb01C+1Y2jQ==
Received: from thinkos.internal.efficios.com (192-222-143-198.qc.cable.ebox.net [192.222.143.198])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4TQ6pg5GkFzVnw;
	Wed, 31 Jan 2024 11:25:47 -0500 (EST)
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To: Dan Williams <dan.j.williams@intel.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Dave Chinner <david@fromorbit.com>
Cc: linux-kernel@vger.kernel.org,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	linux-mm@kvack.org,
	linux-arch@vger.kernel.org,
	Vishal Verma <vishal.l.verma@intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Matthew Wilcox <willy@infradead.org>,
	Russell King <linux@armlinux.org.uk>,
	linux-cxl@vger.kernel.org,
	nvdimm@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	dm-devel@lists.linux.dev
Subject: [RFC PATCH v3 0/4] Introduce cpu_dcache_is_aliasing() to fix DAX regression
Date: Wed, 31 Jan 2024 11:25:29 -0500
Message-Id: <20240131162533.247710-1-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit introduced in v5.13 prevents building FS_DAX on 32-bit ARM,
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

Feedback is welcome,

Thanks,

Mathieu

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
Cc: dm-devel@lists.linux.dev

Mathieu Desnoyers (4):
  dm: Treat alloc_dax failure as non-fatal
  dax: Check for data cache aliasing at runtime
  Introduce cpu_dcache_is_aliasing() across all architectures
  dax: Fix incorrect list of data cache aliasing architectures

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
 drivers/dax/super.c                 |  5 +++++
 drivers/md/dm.c                     | 10 +++++-----
 fs/Kconfig                          |  1 -
 include/linux/cacheinfo.h           |  6 ++++++
 mm/Kconfig                          |  6 ++++++
 25 files changed, 122 insertions(+), 6 deletions(-)
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


