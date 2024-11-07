Return-Path: <linux-fsdevel+bounces-33887-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DCB7A9C037B
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Nov 2024 12:10:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0896285450
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Nov 2024 11:10:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B40A61F4FBE;
	Thu,  7 Nov 2024 11:10:30 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8CB31F472F;
	Thu,  7 Nov 2024 11:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730977830; cv=none; b=dfv4jsr2V++LOEps/bGcRNIUy2PvkO1Vw+mSWOiHdaGxzEdACjHLem3ix+uSPWGPhf5egNXMJ9qoF5uTJNwQ11R5uH8r4DQMdm4ndsfRZlAw0pWyDAU60fcQNkSnG2qZjvpYhBoLC9InDzGJtI6Dqx02syahs9072N1jmygdxIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730977830; c=relaxed/simple;
	bh=Ohm+oiB/qt3VEt9jKxU2Epk59biCI7J/0xVonQqAvas=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aECai4xjccV+wFZ0O7ZnNKz9Vtk5N0JS+WeN4AMltV3DTnxtzp3P1HzviezwS9ZZhEIzQfwD+jCrpwbmTpRtmzO+oZ8Mk6xrr8BFS/fPgczsqonxa7ouOFcbSiOUxpGJa5PDjYgpcG1yosw76zqoXaRQ4K2PE1Qr+4D9Ozf3MR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4XkfSL0W0fz10QlX;
	Thu,  7 Nov 2024 19:08:02 +0800 (CST)
Received: from kwepemf100017.china.huawei.com (unknown [7.202.181.16])
	by mail.maildlp.com (Postfix) with ESMTPS id 9D8A41400DC;
	Thu,  7 Nov 2024 19:10:23 +0800 (CST)
Received: from huawei.com (10.175.104.67) by kwepemf100017.china.huawei.com
 (7.202.181.16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 7 Nov
 2024 19:10:22 +0800
From: Zizhi Wo <wozizhi@huawei.com>
To: <netfs@lists.linux.dev>, <dhowells@redhat.com>, <jlayton@kernel.org>,
	<brauner@kernel.org>
CC: <hsiangkao@linux.alibaba.com>, <jefflexu@linux.alibaba.com>,
	<zhujia.zj@bytedance.com>, <linux-erofs@lists.ozlabs.org>,
	<linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<wozizhi@huawei.com>, <libaokun1@huawei.com>, <yangerkun@huawei.com>,
	<houtao1@huawei.com>, <yukuai3@huawei.com>
Subject: [PATCH v2 2/5] cachefiles: Fix missing pos updates in cachefiles_ondemand_fd_write_iter()
Date: Thu, 7 Nov 2024 19:06:46 +0800
Message-ID: <20241107110649.3980193-3-wozizhi@huawei.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20241107110649.3980193-1-wozizhi@huawei.com>
References: <20241107110649.3980193-1-wozizhi@huawei.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemf100017.china.huawei.com (7.202.181.16)

In the erofs on-demand loading scenario, read and write operations are
usually delivered through "off" and "len" contained in read req in user
mode. Naturally, pwrite is used to specify a specific offset to complete
write operations.

However, if the write(not pwrite) syscall is called multiple times in the
read-ahead scenario, we need to manually update ki_pos after each write
operation to update file->f_pos.

This step is currently missing from the cachefiles_ondemand_fd_write_iter
function, added to address this issue.

Fixes: c8383054506c ("cachefiles: notify the user daemon when looking up cookie")
Signed-off-by: Zizhi Wo <wozizhi@huawei.com>
Acked-by: David Howells <dhowells@redhat.com>
---
 fs/cachefiles/ondemand.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/cachefiles/ondemand.c b/fs/cachefiles/ondemand.c
index bdd321017f1c..38ca6dce8ef2 100644
--- a/fs/cachefiles/ondemand.c
+++ b/fs/cachefiles/ondemand.c
@@ -77,8 +77,10 @@ static ssize_t cachefiles_ondemand_fd_write_iter(struct kiocb *kiocb,
 
 	trace_cachefiles_ondemand_fd_write(object, file_inode(file), pos, len);
 	ret = __cachefiles_write(object, file, pos, iter, NULL, NULL);
-	if (!ret)
+	if (!ret) {
 		ret = len;
+		kiocb->ki_pos += ret;
+	}
 
 	return ret;
 }
-- 
2.39.2


