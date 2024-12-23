Return-Path: <linux-fsdevel+bounces-38057-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06D339FB014
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Dec 2024 15:37:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D22B9169308
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Dec 2024 14:35:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A72741E47BE;
	Mon, 23 Dec 2024 14:21:20 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88BC51E3DE7;
	Mon, 23 Dec 2024 14:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734963680; cv=none; b=teLPAcG5/qDCtru4GnQx2MQWwOz2ivOdcyXCdkynIXkr1UhjqZm5MN/zl70P9YRnjwXIddDOglGozXxDtTDEVh2u2XoHBdQpr/Cxc01AJaLpY2yQK6EZjIfUJMMHf90D0oWwfUGTsb5UKkhgOqf3N6j9B4gVxK1ecCaREBQ8loQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734963680; c=relaxed/simple;
	bh=QlnJEpBp4fXU3fC+e0GKeOTxfhyigAYnpz0GbfIk3zI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=exVZo0PJjCHrCffO3aCXqKM18YcfCEbEN1g6KEXSGlc7YDAhN1iQNuCuKYvxJmerzDYB0L++z1Ml99F8ReL+177nNY8F1fvVr7sgjVY5viIuxmET+4tADdHlIb6Ee9EPnm38/w8gbIK2Zt8mj+CXCS0Z9wJo1icCttS+x+FFc94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4YH0ZR5blCz20mgG;
	Mon, 23 Dec 2024 22:21:35 +0800 (CST)
Received: from kwepemh100016.china.huawei.com (unknown [7.202.181.102])
	by mail.maildlp.com (Postfix) with ESMTPS id 486461A016C;
	Mon, 23 Dec 2024 22:21:16 +0800 (CST)
Received: from huawei.com (10.175.113.32) by kwepemh100016.china.huawei.com
 (7.202.181.102) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 23 Dec
 2024 22:21:12 +0800
From: Kaixiong Yu <yukaixiong@huawei.com>
To: <akpm@linux-foundation.org>, <mcgrof@kernel.org>
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
Subject: [PATCH v4 -next 15/15] sysctl: remove unneeded include
Date: Mon, 23 Dec 2024 22:15:50 +0800
Message-ID: <20241223141550.638616-32-yukaixiong@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241223141550.638616-1-yukaixiong@huawei.com>
References: <20241223141550.638616-1-yukaixiong@huawei.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemh100016.china.huawei.com (7.202.181.102)

Removing unneeded mm includes in kernel/sysctl.c.

Signed-off-by: Kaixiong Yu <yukaixiong@huawei.com>
Reviewed-by: Kees Cook <kees@kernel.org>
---
 kernel/sysctl.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index cebd0ef5d19d..aece984bee19 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -20,8 +20,6 @@
  */
 
 #include <linux/module.h>
-#include <linux/mm.h>
-#include <linux/slab.h>
 #include <linux/sysctl.h>
 #include <linux/bitmap.h>
 #include <linux/signal.h>
@@ -30,7 +28,6 @@
 #include <linux/proc_fs.h>
 #include <linux/security.h>
 #include <linux/ctype.h>
-#include <linux/kmemleak.h>
 #include <linux/filter.h>
 #include <linux/fs.h>
 #include <linux/init.h>
@@ -41,7 +38,6 @@
 #include <linux/highuid.h>
 #include <linux/writeback.h>
 #include <linux/ratelimit.h>
-#include <linux/hugetlb.h>
 #include <linux/initrd.h>
 #include <linux/key.h>
 #include <linux/times.h>
@@ -52,13 +48,11 @@
 #include <linux/reboot.h>
 #include <linux/ftrace.h>
 #include <linux/perf_event.h>
-#include <linux/oom.h>
 #include <linux/kmod.h>
 #include <linux/capability.h>
 #include <linux/binfmts.h>
 #include <linux/sched/sysctl.h>
 #include <linux/mount.h>
-#include <linux/userfaultfd_k.h>
 #include <linux/pid.h>
 
 #include "../lib/kstrtox.h"
-- 
2.34.1


