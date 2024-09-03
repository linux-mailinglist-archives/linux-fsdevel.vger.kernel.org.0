Return-Path: <linux-fsdevel+bounces-28303-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 471059691FF
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Sep 2024 05:31:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03872283730
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Sep 2024 03:31:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDF221CDFB8;
	Tue,  3 Sep 2024 03:31:06 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAD903207;
	Tue,  3 Sep 2024 03:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725334266; cv=none; b=WELS1zcmXXao0oOI3jFb3eMeyAks83K7j4edej1dUFNpCO35RM4Gszeza6GuAC8llhC/rxtxoY0mqrugphaHY4KpRNc1Ju/+dkKHHUPplcNaR7e4mC8ufGmVMc0AJgMeRycr/p9ycL3MFU3RoOXwUjkpAp4yBILXF7eNo062Ph4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725334266; c=relaxed/simple;
	bh=jFm7EO7ARbGov5WdE2QDUqYwjdJQGV3ecJbmMgqsloE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ISWIfMCWhv+Gn72n77WvNN7ESxcHiBug3aKyN1BBJ6+XdjJY2h+/HHYgO18IlIEqSUAJBwUUfCSNTW5A1eJxFfm/tQRDM2R3XYhW7zfDHu+ywp9F10MA0NHVf66xbZ64tkF8SaRHrjO88UflGyhQEvSebsbIMhlffy7noDQJVNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4WyWNJ16TYzyRMc;
	Tue,  3 Sep 2024 11:30:24 +0800 (CST)
Received: from kwepemh100016.china.huawei.com (unknown [7.202.181.102])
	by mail.maildlp.com (Postfix) with ESMTPS id BCE3B1402D0;
	Tue,  3 Sep 2024 11:31:00 +0800 (CST)
Received: from huawei.com (10.175.113.32) by kwepemh100016.china.huawei.com
 (7.202.181.102) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 3 Sep
 2024 11:30:58 +0800
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
Subject: [PATCH v2 -next 00/15] sysctl: move sysctls from vm_table into its own files
Date: Tue, 3 Sep 2024 11:29:56 +0800
Message-ID: <20240903033011.2870608-1-yukaixiong@huawei.com>
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
linux-next(tags/next-20240902). To test this patch series, the code was
compiled with both the CONFIG_SYSCTL enabled and disabled on arm64 and
x86_64 architectures. After this patch series is applied, all files
under /proc/sys/vm can be read or written normally.

Changes in v2:
 - fix sysctl_max_map_count undeclared issue in mm/nommu.c for patch6
 - update changelog for patch7/12, suggested by Kees/Paul
 - fix patch8, sorry for wrong changes and forget to built with NOMMU
 - add reviewed-by from Kees except patch8 since patch8 is wrong in v1
 - add reviewed-by from Jan Kara, Christian Brauner in patch12

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
 mm/vmstat.c                        |  42 +++++-
 net/sunrpc/auth.c                  |   2 +-
 security/min_addr.c                |  11 ++
 23 files changed, 328 insertions(+), 310 deletions(-)

-- 
2.25.1


