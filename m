Return-Path: <linux-fsdevel+bounces-27151-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DB7C95F096
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Aug 2024 14:08:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 367151F23B99
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Aug 2024 12:08:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E95E18D62B;
	Mon, 26 Aug 2024 12:06:00 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37CD118A6DD;
	Mon, 26 Aug 2024 12:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724673959; cv=none; b=clhGi3mwYq11Dg/JBSh82BG7sVewRWRNL2NVVGd0r4oaDKDSIICUqfBVCGe8q1FiNS1HvFuVUAMOsMPHPE99rncuxbMJAsXpGHbcgZPJsos1C7UvEY8zDs+Q+zOnkEbl+iwthui8awcj9MSTLzBzUABh/4jwVYVkfO5+/BrEwNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724673959; c=relaxed/simple;
	bh=fcId/KzZShAyCSi5rsz8ZDzxf5TvkVVpkGEoV9FLoLI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IhysoHWBL6B88bbU5RAdytdMqGUjPQO8SMtMAUKCN32KAKhvOQwhW29fKut511f9H/o43VqrOWcfRzrMlAJCM+yhU3xfZUir4lFEYcU1lQk5/cmuTG8zp5vQpTXd8aBxdey4gB3X3DDbbVBeQEs42GmQF92VVE/85KuY3zRB550=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4Wsq9y0730z13Kmh;
	Mon, 26 Aug 2024 20:05:10 +0800 (CST)
Received: from kwepemh100016.china.huawei.com (unknown [7.202.181.102])
	by mail.maildlp.com (Postfix) with ESMTPS id 94F22180101;
	Mon, 26 Aug 2024 20:05:55 +0800 (CST)
Received: from huawei.com (10.175.113.32) by kwepemh100016.china.huawei.com
 (7.202.181.102) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 26 Aug
 2024 20:05:53 +0800
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
Subject: [PATCH -next 15/15] sysctl: remove unneeded include
Date: Mon, 26 Aug 2024 20:04:49 +0800
Message-ID: <20240826120449.1666461-16-yukaixiong@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240826120449.1666461-1-yukaixiong@huawei.com>
References: <20240826120449.1666461-1-yukaixiong@huawei.com>
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

Removing unneeded mm includes in kernel/sysctl.c.

Signed-off-by: Kaixiong Yu <yukaixiong@huawei.com>
---
 kernel/sysctl.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index f04da9f3abc6..6e3e0ce4da79 100644
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
2.25.1


