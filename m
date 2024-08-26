Return-Path: <linux-fsdevel+bounces-27146-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C99CA95F075
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Aug 2024 14:06:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 747DB1F22891
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Aug 2024 12:06:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A9F117C987;
	Mon, 26 Aug 2024 12:05:43 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BBC917838B;
	Mon, 26 Aug 2024 12:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724673942; cv=none; b=eTXydzqdI4ip451GLNRDUBwraSHp62jCCDXQMsVkww834G5pU1ag1jsWaKcL11sGed/i2urbPwlWRHoGVgAjCCdSJ6EjQk6BQZQL9jNkTjRCx9owE9jwsMDr+QEOnqTqONKNevGoAJ7XFs+TyCiZMVuUTb5+FJV3K7s6CR/gDqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724673942; c=relaxed/simple;
	bh=VDHmXM5KukNaE4dbR5SxSX0XbfIcLcyvYJMo5CiWqMI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Pt85xy9FvsJqxGnRPsKpTge7CsVv+j2n/pJxp3rHZPvdaR8bO/tQW7f3pwm8OHYrQ9yeJLnhFFKU5iXu90h/MtVD+Ppm7iF8JCBU0uSpChfralMEW+dB2puowymzC6pKMLCtjJXaG2CNUQGliueeGTrIj0YnjEvLN6i+m4R5yvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Wsq9b1m3KzyQKg;
	Mon, 26 Aug 2024 20:04:51 +0800 (CST)
Received: from kwepemh100016.china.huawei.com (unknown [7.202.181.102])
	by mail.maildlp.com (Postfix) with ESMTPS id 1E7631800D0;
	Mon, 26 Aug 2024 20:05:37 +0800 (CST)
Received: from huawei.com (10.175.113.32) by kwepemh100016.china.huawei.com
 (7.202.181.102) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 26 Aug
 2024 20:05:34 +0800
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
Subject: [PATCH -next 07/15] security: min_addr: move sysctl into its own file
Date: Mon, 26 Aug 2024 20:04:41 +0800
Message-ID: <20240826120449.1666461-8-yukaixiong@huawei.com>
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

The dac_mmap_min_addr belongs to min_addr.c, move it into
its own file from /kernel/sysctl.c. In the previous Linux kernel
boot process, sysctl_init_bases needs to be executed before
init_mmap_min_addr, So, register_sysctl_init should be executed
before update_mmap_min_addr in init_mmap_min_addr.

Signed-off-by: Kaixiong Yu <yukaixiong@huawei.com>
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
2.25.1


