Return-Path: <linux-fsdevel+bounces-8761-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 888BF83ABA1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jan 2024 15:26:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 31ED31F2B08C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jan 2024 14:26:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C8AB7A730;
	Wed, 24 Jan 2024 14:26:31 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56DAA60DD1;
	Wed, 24 Jan 2024 14:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706106390; cv=none; b=pB5kVLTbgoiJxA3TJ42u8y15t2/F2FGWOXW3C/s693OGBPMT5C5UZ1dkqIn3mO+4Om0hKR5Vwdzs/5w0PDvOLJVng4nUkf0ke5nXrjVMbCZ2NVsREFtW7vadPgn4SM3mPeLx84u8oK9B12Mpo3CENSI9cmIGfSsTOm/amkLVEZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706106390; c=relaxed/simple;
	bh=T4ZmNyGgSAx5pc1IvXagEPFYy85Sq3UzouNrKov/L9w=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=eqE2FvLK0FJwW7mrzIKAa+B0GAWjLXDQ7mC1K8YkxNSLUPm59PZQkT3gGODwsG0w6AfwOfCW26myslIMpX37hh1m7JFodqWBqPuYQdOQYDnYMPTz8yTs4saJCSiIgpUmEWk0nJG2qFRettsbpa366GgGf9KuQzs+Y0POxo1dlRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4TKmSl4JKCzXgcK;
	Wed, 24 Jan 2024 22:25:11 +0800 (CST)
Received: from dggpeml500021.china.huawei.com (unknown [7.185.36.21])
	by mail.maildlp.com (Postfix) with ESMTPS id 26FC51400D7;
	Wed, 24 Jan 2024 22:26:24 +0800 (CST)
Received: from huawei.com (10.175.127.227) by dggpeml500021.china.huawei.com
 (7.185.36.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 24 Jan
 2024 22:26:23 +0800
From: Baokun Li <libaokun1@huawei.com>
To: <linux-fsdevel@vger.kernel.org>
CC: <torvalds@linux-foundation.org>, <viro@zeniv.linux.org.uk>,
	<brauner@kernel.org>, <jack@suse.cz>, <willy@infradead.org>,
	<akpm@linux-foundation.org>, <arnd@arndb.de>, <linux-arch@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <yi.zhang@huawei.com>,
	<yangerkun@huawei.com>, <yukuai3@huawei.com>, <libaokun1@huawei.com>
Subject: [PATCH v2 0/3] fs: make the i_size_read/write helpers be smp_load_acquire/store_release()
Date: Wed, 24 Jan 2024 22:28:54 +0800
Message-ID: <20240124142857.4146716-1-libaokun1@huawei.com>
X-Mailer: git-send-email 2.31.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpeml500021.china.huawei.com (7.185.36.21)

V1->V2:
  Add patch 3 to fix an error when compiling code for 32-bit architectures
  without CONFIG_SMP enabled.

This patchset follows the Linus suggestion to make the i_size_read/write
helpers be smp_load_acquire/store_release(), after which the extra smp_rmb
in filemap_read() is no longer needed, so it is removed. And remove the
extra type checking in smp_load_acquire/smp_store_release under the
!CONFIG_SMP case to avoid compilation errors.

Functional tests were performed and no new problems were found.

Here are the results of unixbench tests based on 6.7.0-next-20240118 on
arm64, with some degradation in single-threading and some optimization in
multi-threading, but overall the impact is not significant.

### 72 CPUs in system; running 1 parallel copy of tests
System Benchmarks Index Values        |   base  | patched |  cmp   |
--------------------------------------|---------|---------|--------|
Dhrystone 2 using register variables  | 3635.06 | 3596.3  | -1.07% |
Double-Precision Whetstone            | 808.58  | 808.58  | 0.00%  |
Execl Throughput                      | 623.52  | 618.1   | -0.87% |
File Copy 1024 bufsize 2000 maxblocks | 1715.82 | 1668.58 | -2.75% |
File Copy 256 bufsize 500 maxblocks   | 1320.98 | 1250.16 | -5.36% |
File Copy 4096 bufsize 8000 maxblocks | 2639.36 | 2488.48 | -5.72% |
Pipe Throughput                       | 869.06  | 872.3   | 0.37%  |
Pipe-based Context Switching          | 106.26  | 117.22  | 10.31% |
Process Creation                      | 247.72  | 246.74  | -0.40% |
Shell Scripts (1 concurrent)          | 1234.98 | 1226    | -0.73% |
Shell Scripts (8 concurrent)          | 6893.96 | 6210.46 | -9.91% |
System Call Overhead                  | 493.72  | 494.28  | 0.11%  |
--------------------------------------|---------|---------|--------|
Total                                 | 1003.92 | 989.58  | -1.43% |

### 72 CPUs in system; running 72 parallel copy of tests
System Benchmarks Index Values        |   base    |  patched  |  cmp   |
--------------------------------------|-----------|-----------|--------|
Dhrystone 2 using register variables  | 260471.88 | 258065.04 | -0.92% |
Double-Precision Whetstone            | 58212.32  | 58219.3   | 0.01%  |
Execl Throughput                      | 6954.7    | 7444.08   | 7.04%  |
File Copy 1024 bufsize 2000 maxblocks | 64244.74  | 64618.24  | 0.58%  |
File Copy 256 bufsize 500 maxblocks   | 89933.8   | 87026.38  | -3.23% |
File Copy 4096 bufsize 8000 maxblocks | 79808.14  | 81916.42  | 2.64%  |
Pipe Throughput                       | 62174.38  | 62389.74  | 0.35%  |
Pipe-based Context Switching          | 27239.28  | 27887.24  | 2.38%  |
Process Creation                      | 3551.28   | 3800.54   | 7.02%  |
Shell Scripts (1 concurrent)          | 19212.26  | 20749.34  | 8.00%  |
Shell Scripts (8 concurrent)          | 20842.02  | 21958.12  | 5.36%  |
System Call Overhead                  | 35328.24  | 35451.68  | 0.35%  |
--------------------------------------|-----------|-----------|--------|
Total                                 | 35592.42  | 36450.36  | 2.41%  |

Baokun Li (3):
  fs: make the i_size_read/write helpers be
    smp_load_acquire/store_release()
  Revert "mm/filemap: avoid buffered read/write race to read
    inconsistent data"
  asm-generic: remove extra type checking in acquire/release for non-SMP
    case

 include/asm-generic/barrier.h |  2 --
 include/linux/fs.h            | 10 ++++++++--
 mm/filemap.c                  |  9 ---------
 3 files changed, 8 insertions(+), 13 deletions(-)

-- 
2.31.1


