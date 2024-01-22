Return-Path: <linux-fsdevel+bounces-8402-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D559D835E61
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Jan 2024 10:43:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D0FF1F241EB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Jan 2024 09:43:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A01B39AE5;
	Mon, 22 Jan 2024 09:43:32 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F70CF500;
	Mon, 22 Jan 2024 09:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705916612; cv=none; b=oCj27GRGp9z7OR69lSUiFlN2GeOir03OAAuBtqtQTJvTwzDG3oSIo1XlzR0foe5jGmBMlO9eGWqGoOhpPs/7qhGHbmM0O6tah6IoruMDHrsrrPt9rmqZGyrdjoZJaZVJ2EPMLRdejAG6xPP0O2UtBiZ60cKm4cM6DcSkiyVZixw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705916612; c=relaxed/simple;
	bh=Tb9Wt1hmy4GfQJBjbVvHV0UhlFWCkpUYxqBD5bV+Ce8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Au6oxd+2n5mX5YGjgqWzctL6fr9iQDQXyByRs4O68lbjoxNmulJelfkpHlsAEVVdHUi155Bok+bLfXBTygUXxjdm1Oc7gZZ6LkPLwb2qBa/cNADqrpQGlNYrDt1i2IRMS8Rezo/5RDz7g6mqGOHwh0Vd9lXAGSZCmiFMTy+Bxe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4TJQJ31vvfz1wnBS;
	Mon, 22 Jan 2024 17:42:59 +0800 (CST)
Received: from dggpeml500021.china.huawei.com (unknown [7.185.36.21])
	by mail.maildlp.com (Postfix) with ESMTPS id 76E3D1404FC;
	Mon, 22 Jan 2024 17:43:05 +0800 (CST)
Received: from huawei.com (10.175.127.227) by dggpeml500021.china.huawei.com
 (7.185.36.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 22 Jan
 2024 17:42:59 +0800
From: Baokun Li <libaokun1@huawei.com>
To: <linux-fsdevel@vger.kernel.org>
CC: <torvalds@linux-foundation.org>, <viro@zeniv.linux.org.uk>,
	<brauner@kernel.org>, <jack@suse.cz>, <willy@infradead.org>,
	<akpm@linux-foundation.org>, <linux-kernel@vger.kernel.org>,
	<yi.zhang@huawei.com>, <yangerkun@huawei.com>, <yukuai3@huawei.com>,
	<libaokun1@huawei.com>
Subject: [PATCH 0/2] fs: make the i_size_read/write helpers be smp_load_acquire/store_release()
Date: Mon, 22 Jan 2024 17:45:34 +0800
Message-ID: <20240122094536.198454-1-libaokun1@huawei.com>
X-Mailer: git-send-email 2.31.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpeml500021.china.huawei.com (7.185.36.21)

This patchset follows the linus suggestion to make the i_size_read/write
helpers be smp_load_acquire/store_release(), after which the extra smp_rmb
in filemap_read() is no longer needed, so it is removed.

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

Baokun Li (2):
  fs: make the i_size_read/write helpers be
    smp_load_acquire/store_release()
  Revert "mm/filemap: avoid buffered read/write race to read
    inconsistent data"

 include/linux/fs.h | 10 ++++++++--
 mm/filemap.c       |  9 ---------
 2 files changed, 8 insertions(+), 11 deletions(-)

-- 
2.31.1


