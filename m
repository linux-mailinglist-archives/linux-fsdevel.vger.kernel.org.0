Return-Path: <linux-fsdevel+bounces-31582-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C8D5998908
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Oct 2024 16:15:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35AB42824EA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Oct 2024 14:15:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 312761CF281;
	Thu, 10 Oct 2024 14:11:58 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB8A91CB518;
	Thu, 10 Oct 2024 14:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728569517; cv=none; b=TZulgkrIeRif4qvbBE+T68F769KmiKcf/8A9gIZ2hjQ01HOmV0vGW7THus1WhQcxRzOgs6WXTIskp5TRBeIv0bsdHlhscWZHjWuxKusB3PE37W+vbEYzaex85hujN6r4wiK7fXzqNxAAaM2Q2puaskVW2VG8PgfKAyiK1Btm7b4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728569517; c=relaxed/simple;
	bh=MWbkokKMy/fY6oBSoA2n/4kx6pYPHx/UhzHKigiT8jQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QvcelegKb5k0AZWi8lQrlw6eXvKsDk4XKfh0545bUYApHbTq7hxby3SlQ1pGK6DcrBVYn4Pcfan4iLltHIRUl/d/xT/lO8eoM2lzojx+82WSrAYy9EstbrsUt0WFH+lo+nFrsEHNCzyEI33sIcgBMWR8e0e7gWgXdH9NMuQA3+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4XPWsT6mQjz2KXx6;
	Thu, 10 Oct 2024 22:11:57 +0800 (CST)
Received: from kwepemh100016.china.huawei.com (unknown [7.202.181.102])
	by mail.maildlp.com (Postfix) with ESMTPS id 3D1631A016C;
	Thu, 10 Oct 2024 22:11:53 +0800 (CST)
Received: from huawei.com (10.175.113.32) by kwepemh100016.china.huawei.com
 (7.202.181.102) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 10 Oct
 2024 22:11:49 +0800
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
	<wangkefeng.wang@huawei.com>, <sunnanyong@huawei.com>
Subject: [PATCH v3 -next 07/15] security: min_addr: move sysctl to security/min_addr.c
Date: Thu, 10 Oct 2024 23:22:07 +0800
Message-ID: <20241010152215.3025842-8-yukaixiong@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241010152215.3025842-1-yukaixiong@huawei.com>
References: <20241010152215.3025842-1-yukaixiong@huawei.com>
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

The dac_mmap_min_addr belongs to min_addr.c, move it to
min_addr.c from /kernel/sysctl.c. In the previous Linux kernel
boot process, sysctl_init_bases needs to be executed before
init_mmap_min_addr, So, register_sysctl_init should be executed
before update_mmap_min_addr in init_mmap_min_addr. And according
to the compilation condition in security/Makefile:

      obj-$(CONFIG_MMU)            += min_addr.o

if CONFIG_MMU is not defined, min_addr.c would not be included in the
compilation process. So, drop the CONFIG_MMU check.

Signed-off-by: Kaixiong Yu <yukaixiong@huawei.com>
Reviewed-by: Kees Cook <kees@kernel.org>
Acked-by: Paul Moore <paul@paul-moore.com>
---
v3:
 - change the title
v2:
 - update the changelog to explain why drop CONFIG_MMU check.
---
 kernel/sysctl.c     |  9 ---------
 security/min_addr.c | 11 +++++++++++
 2 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index 41d4afc978e6..0c0bab3dad7d 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -2059,15 +2059,6 @@ static struct ctl_table vm_table[] = {
 		.proc_handler	= proc_dointvec_minmax,
 		.extra1		= SYSCTL_ZERO,
 	},
-#ifdef CONFIG_MMU
-	{
-		.procname	= "mmap_min_addr",
-		.data		= &dac_mmap_min_addr,
-		.maxlen		= sizeof(unsigned long),
-		.mode		= 0644,
-		.proc_handler	= mmap_min_addr_handler,
-	},
-#endif
 #if (defined(CONFIG_X86_32) && !defined(CONFIG_UML))|| \
    (defined(CONFIG_SUPERH) && defined(CONFIG_VSYSCALL))
 	{
diff --git a/security/min_addr.c b/security/min_addr.c
index 0ce267c041ab..b2f61649e110 100644
--- a/security/min_addr.c
+++ b/security/min_addr.c
@@ -44,8 +44,19 @@ int mmap_min_addr_handler(const struct ctl_table *table, int write,
 	return ret;
 }
 
+static struct ctl_table min_addr_sysctl_table[] = {
+	{
+		.procname	= "mmap_min_addr",
+		.data		= &dac_mmap_min_addr,
+		.maxlen		= sizeof(unsigned long),
+		.mode		= 0644,
+		.proc_handler	= mmap_min_addr_handler,
+	},
+};
+
 static int __init init_mmap_min_addr(void)
 {
+	register_sysctl_init("vm", min_addr_sysctl_table);
 	update_mmap_min_addr();
 
 	return 0;
-- 
2.34.1


