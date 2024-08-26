Return-Path: <linux-fsdevel+bounces-27153-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A93595F0A8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Aug 2024 14:09:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C55441F23EEE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Aug 2024 12:09:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51300192B79;
	Mon, 26 Aug 2024 12:06:02 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E36941714B8;
	Mon, 26 Aug 2024 12:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724673961; cv=none; b=XYwegzUvQk/SRdokgkMJ1QaVH23WemnJhomb4SRXiOHNuoYgwMDVmoWnQ9bca/q6HIc3ZK11/z5hOR++jX7TpNojI0u4AWscwKT45zhRQ3myNUIDwBmxgtPcTKTS7fye/9aikCBEudDPsd7UdtLz6iuwVeqlC5JbZpAHnAlv7t8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724673961; c=relaxed/simple;
	bh=jYSQ6pJxpSYwMpwZDbbEJZOSv/YbXrBVP6F9ORiCQek=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=RJcMMI2eobD2PV7TFs84x2Al4jmSQp8BcaGgWuVWwTgy4Tk0P6ljkNNcRvadx8G2xbYN6Jqq87shaEVR8aC38WLSxdzA3TdxZjKNpze63uBUAOH9Mi32YR5rqPwRGF+isZlxf8ifUeydoRgszAlBNIcr+vmJdFVc29h0Gfr9zIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4WsqB02FC8z1j7CK;
	Mon, 26 Aug 2024 20:05:12 +0800 (CST)
Received: from kwepemh100016.china.huawei.com (unknown [7.202.181.102])
	by mail.maildlp.com (Postfix) with ESMTPS id E18471402E1;
	Mon, 26 Aug 2024 20:05:20 +0800 (CST)
Received: from huawei.com (10.175.113.32) by kwepemh100016.china.huawei.com
 (7.202.181.102) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 26 Aug
 2024 20:05:18 +0800
From: Kaixiong Yu <yukaixiong@huawei.com>
To: <akpm@linux-foundation.org>, <mcgrof@kernel.org>
CC: <ysato@users.sourceforge.jp>, <dalias@libc.org>,
	<glaubitz@physik.fu-berlin.de>, <luto@kernel.org>, <tglx@linutronix.de>,
	<bp@alien8.de>, <dave.hansen@linux.intel.com>, <hpa@zytor.com>,
	<viro@zeniv.linux.org.uk>, <brauner@kernel.org>, <jack@suse.cz>,
	<kees@kernel.org>, <j.granados@samsung.com>, <willy@infradead.org>,
	<Liam.Howlett@oracle.com>, <vbabka@suse.cz>, <lorenzo.stoakes@oracle.com>,
	<trondmy@kernel.org>, <anna@kernel.org>, <chuck.lever@oracle.com>,
	<jlayton@kernel.org>, <neilb@suse.de>, <okorniev@redhat.com>,
	<Dai.Ngo@oracle.com>, <tom@talpey.com>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<paul@paul-moore.com>, <jmorris@namei.org>, <linux-sh@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
	<linux-mm@kvack.org>, <linux-nfs@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-security-module@vger.kernel.org>, <wangkefeng.wang@huawei.com>
Subject: [PATCH -next 00/15] sysctl: move sysctls from vm_table into its own files
Date: Mon, 26 Aug 2024 20:04:34 +0800
Message-ID: <20240826120449.1666461-1-yukaixiong@huawei.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemh100016.china.huawei.com (7.202.181.102)

This patch series moves sysctls of vm_table in kernel/sysctl.c to
places where they actually belong, and do some related code clean-ups.
After this patch series, all sysctls in vm_table have been moved into its
own files, meanwhile, delete vm_table.

All the modifications of this patch series base on
linux-next(tags/next-20240823). To test this patch series, the code was
compiled with both the CONFIG_SYSCTL enabled and disabled on arm64 and
x86_64 architectures. After this patch series is applied, all files
under /proc/sys/vm can be read or written normally.

Kaixiong Yu (15):
  mm: vmstat: move sysctls to its own files
  mm: filemap: move sysctl to its own file
  mm: swap: move sysctl to its own file
  mm: vmscan: move vmscan sysctls to its own file
  mm: util: move sysctls into it own files
  mm: mmap: move sysctl into its own file
  security: min_addr: move sysctl into its own file
  mm: nommu: move sysctl to its own file
  fs: fs-writeback: move sysctl to its own file
  fs: drop_caches: move sysctl to its own file
  sunrpc: use vfs_pressure_ratio() helper
  fs: dcache: move the sysctl into its own file
  x86: vdso: move the sysctl into its own file
  sh: vdso: move the sysctl into its own file
  sysctl: remove unneeded include

 arch/sh/kernel/vsyscall/vsyscall.c |  14 ++
 arch/x86/entry/vdso/vdso32-setup.c |  16 ++-
 fs/dcache.c                        |  21 ++-
 fs/drop_caches.c                   |  23 ++-
 fs/fs-writeback.c                  |  28 ++--
 include/linux/dcache.h             |   7 +-
 include/linux/mm.h                 |  42 ------
 include/linux/mman.h               |   2 -
 include/linux/swap.h               |   9 --
 include/linux/vmstat.h             |  11 --
 include/linux/writeback.h          |   4 -
 kernel/sysctl.c                    | 221 -----------------------------
 mm/filemap.c                       |  18 ++-
 mm/internal.h                      |  10 ++
 mm/mmap.c                          |  75 ++++++++++
 mm/nommu.c                         |  15 +-
 mm/swap.c                          |  16 ++-
 mm/swap.h                          |   1 +
 mm/util.c                          |  68 +++++++--
 mm/vmscan.c                        |  23 +++
 mm/vmstat.c                        |  42 +++++-
 net/sunrpc/auth.c                  |   2 +-
 security/min_addr.c                |  11 ++
 23 files changed, 349 insertions(+), 330 deletions(-)

-- 
2.25.1


