Return-Path: <linux-fsdevel+bounces-38927-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BF68A0A16D
	for <lists+linux-fsdevel@lfdr.de>; Sat, 11 Jan 2025 08:12:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4CA7A16AE76
	for <lists+linux-fsdevel@lfdr.de>; Sat, 11 Jan 2025 07:12:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4A1617E015;
	Sat, 11 Jan 2025 07:12:30 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07C771114;
	Sat, 11 Jan 2025 07:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736579550; cv=none; b=P8+67X7rd990/+PluaKd6XP17RhScs9BRBZhPvRnHQxKZskzQaTlBRij1l5vi7j8t4xQtxcHK7Ptd7yNT5Ucv51wPmGtbjK457V3SmLm/I5pXeYEXNf8JxxwfEVdI99UJTUEjJ9Hcv7Timlfauomtz+hvDVplBSceBUaFiCVa4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736579550; c=relaxed/simple;
	bh=H2xHhvGHh0LxUT0zK6bublb7RZ7C0uwj4Q2+LPcQSI4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=KY6rakJUB83GeCtoQUMlbcM87c+rHpP68ciGltQnDoSB9GRGql5ODimUzeuzuvSJyWa3LkZe0S8P/BFYwFE8Qtl9DTjTJwI0u/sL43MEe7FHJjPeTemVJjdFAN4mi0hFPftxL9wdkZukphRrKeWbRzH0FXNjBC0cVdURfwSxF3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4YVV4m2cHRz1ky3H;
	Sat, 11 Jan 2025 15:09:12 +0800 (CST)
Received: from kwepemh100016.china.huawei.com (unknown [7.202.181.102])
	by mail.maildlp.com (Postfix) with ESMTPS id 331121A016C;
	Sat, 11 Jan 2025 15:12:17 +0800 (CST)
Received: from huawei.com (10.175.113.32) by kwepemh100016.china.huawei.com
 (7.202.181.102) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Sat, 11 Jan
 2025 15:12:13 +0800
From: Kaixiong Yu <yukaixiong@huawei.com>
To: <akpm@linux-foundation.org>, <mcgrof@kernel.org>,
	<joel.granados@kernel.org>
CC: <ysato@users.sourceforge.jp>, <dalias@libc.org>,
	<glaubitz@physik.fu-berlin.de>, <luto@kernel.org>, <tglx@linutronix.de>,
	<mingo@redhat.com>, <bp@alien8.de>, <dave.hansen@linux.intel.com>,
	<hpa@zytor.com>, <viro@zeniv.linux.org.uk>, <brauner@kernel.org>,
	<jack@suse.cz>, <kees@kernel.org>, <j.granados@samsung.com>,
	<willy@infradead.org>, <Liam.Howlett@oracle.com>, <vbabka@suse.cz>,
	<lorenzo.stoakes@oracle.com>, <trondmy@kernel.org>, <anna@kernel.org>,
	<chuck.lever@oracle.com>, <jlayton@kernel.org>, <neilb@suse.de>,
	<okorniev@redhat.com>, <Dai.Ngo@oracle.com>, <tom@talpey.com>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <paul@paul-moore.com>, <jmorris@namei.org>,
	<linux-sh@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-fsdevel@vger.kernel.org>, <linux-mm@kvack.org>,
	<linux-nfs@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-security-module@vger.kernel.org>, <dhowells@redhat.com>,
	<haifeng.xu@shopee.com>, <baolin.wang@linux.alibaba.com>,
	<shikemeng@huaweicloud.com>, <dchinner@redhat.com>, <bfoster@redhat.com>,
	<souravpanda@google.com>, <hannes@cmpxchg.org>, <rientjes@google.com>,
	<pasha.tatashin@soleen.com>, <david@redhat.com>, <ryan.roberts@arm.com>,
	<ying.huang@intel.com>, <yang@os.amperecomputing.com>,
	<zev@bewilderbeest.net>, <serge@hallyn.com>, <vegard.nossum@oracle.com>,
	<wangkefeng.wang@huawei.com>
Subject: [PATCH v5 -next 00/16] sysctl: move sysctls from vm_table into its own files
Date: Sat, 11 Jan 2025 15:07:35 +0800
Message-ID: <20250111070751.2588654-1-yukaixiong@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemh100016.china.huawei.com (7.202.181.102)

This patch series moves sysctls of vm_table in kernel/sysctl.c to
places where they actually belong, and do some related code clean-ups.
After this patch series, all sysctls in vm_table have been moved into its
own files, meanwhile, delete vm_table.

All the modifications of this patch series base on
linux-next(tags/next-20250110). To test this patch series, the code was
compiled with both the CONFIG_SYSCTL enabled and disabled on arm64 and
x86_64 architectures. After this patch series is applied, all files
under /proc/sys/vm can be read or written normally.

my test steps as below listed:

Step 1: Set CONFIG_SYSCTL to 'n' and compile the Linux kernel on the
arm64 architecture. The kernel compiles successfully without any errors
or warnings.

Step 2: Set CONFIG_SYSCTL to 'y' and compile the Linux kernel on the
arm64 architecture. The kernel compiles successfully without any errors
or warnings.

Step 3: Use QEMU to boot the kernel compiled in Step 2, then use the
Linux command |ls -ll /proc/sys/vm/| to check the permissions of all
sysctls under the |/proc/sys/vm| directory.
When compared with the kernel version that did not apply this series of
patches, there is no difference in the sysctl permissions under the
|/proc/sys/vm| directory between the two kernel versions.

Step 4: Repeat steps 1 to 3 on the x86_64 architecture.

Changes in v5:
 - add reviewed-by from Lorenzo Stoakes in patch6,8
 - Accept Brian Gerst's suggestion to reduce the preprocessor
   condition "#elif (defined(CONFIG_X86_32) && !defined(CONFIG_UML))"
   in patch13
 - fix the error discovered by Geert Uytterhoeven in patch14 in V4.
   Move the call to register_sysctl_init() into its own fs_initcall()
   as Geert Uytterhoeven's patch does.
 - take the advice of Joel Granados, separating patch14 in V4 into
   patch14 and patch15 in V5. patch14 in V5 just moves the vdso_enabled
   table. patch15 in V5 removes the vm_table.
 - modify the change log of patch14
 - clarify test steps.

Changes in v4:
 - due to my mistake, the previous version sent 15 patches twice.
   Please ignore that, as this version is the correct one.
 - change all "static struct ctl_table" type into
   "static const struct ctl_table" type in patch1~10,12,13,14
 - simplify result of rpcauth_cache_shrink_count() in patch11

Changes in v3:
 - change patch1~10, patch14 title suggested by Joel Granados
 - change sysctl_stat_interval to static type in patch1
 - add acked-by from Paul Moore in patch7
 - change dirtytime_expire_interval to static type in patch9
 - add acked-by from Anna Schumaker in patch11

Changes in v2:
 - fix sysctl_max_map_count undeclared issue in mm/nommu.c for patch6
 - update changelog for patch7/12, suggested by Kees/Paul
 - fix patch8, sorry for wrong changes and forget to built with NOMMU
 - add reviewed-by from Kees except patch8 since patch8 is wrong in v1
 - add reviewed-by from Jan Kara, Christian Brauner in patch12

Kaixiong Yu (16):
  mm: vmstat: move sysctls to mm/vmstat.c
  mm: filemap: move sysctl to mm/filemap.c
  mm: swap: move sysctl to mm/swap.c
  mm: vmscan: move vmscan sysctls to mm/vmscan.c
  mm: util: move sysctls to mm/util.c
  mm: mmap: move sysctl to mm/mmap.c
  security: min_addr: move sysctl to security/min_addr.c
  mm: nommu: move sysctl to mm/nommu.c
  fs: fs-writeback: move sysctl to fs/fs-writeback.c
  fs: drop_caches: move sysctl to fs/drop_caches.c
  sunrpc: simplify rpcauth_cache_shrink_count()
  fs: dcache: move the sysctl to fs/dcache.c
  x86: vdso: move the sysctl to arch/x86/entry/vdso/vdso32-setup.c
  sh: vdso: move the sysctl to arch/sh/kernel/vsyscall/vsyscall.c
  sysctl: remove the vm_table
  sysctl: remove unneeded include

 arch/sh/kernel/vsyscall/vsyscall.c |  20 +++
 arch/x86/entry/vdso/vdso32-setup.c |  16 ++-
 fs/dcache.c                        |  21 ++-
 fs/drop_caches.c                   |  23 ++-
 fs/fs-writeback.c                  |  30 ++--
 include/linux/dcache.h             |   7 +-
 include/linux/mm.h                 |  23 ---
 include/linux/mman.h               |   2 -
 include/linux/swap.h               |   9 --
 include/linux/vmstat.h             |  11 --
 include/linux/writeback.h          |   4 -
 kernel/sysctl.c                    | 221 -----------------------------
 mm/filemap.c                       |  18 ++-
 mm/internal.h                      |  10 ++
 mm/mmap.c                          |  54 +++++++
 mm/nommu.c                         |  15 +-
 mm/swap.c                          |  16 ++-
 mm/swap.h                          |   1 +
 mm/util.c                          |  67 +++++++--
 mm/vmscan.c                        |  23 +++
 mm/vmstat.c                        |  44 +++++-
 net/sunrpc/auth.c                  |   2 +-
 security/min_addr.c                |  11 ++
 23 files changed, 336 insertions(+), 312 deletions(-)

-- 
2.34.1


