Return-Path: <linux-fsdevel+bounces-38053-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D44369FB016
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Dec 2024 15:37:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F290018815C2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Dec 2024 14:33:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7997C1E1A35;
	Mon, 23 Dec 2024 14:21:07 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BA171B4144;
	Mon, 23 Dec 2024 14:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734963667; cv=none; b=g3IWkL1yociGgWjM2jTc1EHuqkx0qloFVDptWULB+um458SOQSOYpjVQIfPfoLV061wS7CLi8E0ZrvfMT9hX+G6opMJBg9yvP1n9fOflJjjUpPk4aqtWdPBLUCCC3nYVeHZCw60nGl/OVZh3NtTJr1bOQVf0tQhwq4kFl9JS92I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734963667; c=relaxed/simple;
	bh=IdHQmWyFeAejWwE0EfX+57lJCHs3w51Kv+o9VdEPcQ0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kZAhouCV88T2FQCunQXkMYsiMr3LEp3NvoCBPmD2wU0dwGK6DSuJR+V5R0/yQXZMOoHmaqZYgQ67yC+1C53nRXUyZRt0QwXYW1nPDNxPY+SjOU89x5UJXUpCdsJnMbpooIjBjx6cFSBIesCbcb50KR85PXT0vIPPCvj9gCa8C1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4YH0Tx5HR3z11NKN;
	Mon, 23 Dec 2024 22:17:41 +0800 (CST)
Received: from kwepemh100016.china.huawei.com (unknown [7.202.181.102])
	by mail.maildlp.com (Postfix) with ESMTPS id 52466140120;
	Mon, 23 Dec 2024 22:21:03 +0800 (CST)
Received: from huawei.com (10.175.113.32) by kwepemh100016.china.huawei.com
 (7.202.181.102) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 23 Dec
 2024 22:20:59 +0800
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
Subject: [PATCH v4 -next 11/15] sunrpc: simplify rpcauth_cache_shrink_count()
Date: Mon, 23 Dec 2024 22:15:46 +0800
Message-ID: <20241223141550.638616-28-yukaixiong@huawei.com>
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

It is inappropriate to use sysctl_vfs_cache_pressure here.
The sysctl is documented as: This percentage value controls
the tendency of the kernel to reclaim the memory which is used
for caching of directory and inode objects.

So, simplify result of rpcauth_cache_shrink_count() to
"return number_cred_unused;".

Signed-off-by: Kaixiong Yu <yukaixiong@huawei.com>
Reviewed-by: Kees Cook <kees@kernel.org>
Acked-by: Anna Schumaker <anna.schumaker@oracle.com>
Acked-by: Jeff Layton <jlayton@kernel.org>
---
v4:
 - Simplify result of rpcauth_cache_shrink_count().
---
---
 net/sunrpc/auth.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/sunrpc/auth.c b/net/sunrpc/auth.c
index 04534ea537c8..5a827afd8e3b 100644
--- a/net/sunrpc/auth.c
+++ b/net/sunrpc/auth.c
@@ -489,7 +489,7 @@ static unsigned long
 rpcauth_cache_shrink_count(struct shrinker *shrink, struct shrink_control *sc)
 
 {
-	return number_cred_unused * sysctl_vfs_cache_pressure / 100;
+	return number_cred_unused;
 }
 
 static void
-- 
2.34.1


