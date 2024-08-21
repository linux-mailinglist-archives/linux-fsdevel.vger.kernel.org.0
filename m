Return-Path: <linux-fsdevel+bounces-26421-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35D21959300
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Aug 2024 04:48:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 68A031C2102C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Aug 2024 02:48:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CC39158554;
	Wed, 21 Aug 2024 02:47:46 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1489153BF9;
	Wed, 21 Aug 2024 02:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724208465; cv=none; b=prnHi5DSz1TRzMbjIxUVOWUNCWe14aLULnPYWJpwxxH5BCHZaXBzI9kgJVPuSR5UUFGJIPSuEsJdsLZKUu6YftgUEo7K80HlGB7Wm1pZOQHQ6klI5U4PqQlYYI+NzwY/C23StHFIyE7n7ZPpFJFitz31Qgjw41magV4HUfhqIgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724208465; c=relaxed/simple;
	bh=oR86lsSjRYREQ6YFGkWLXCqh3JSmHKvNTAllmQAgw2M=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BixKCUgdWOTB7HjeKweCcMqMYI3sTW+95WKC/SnJ5e143+j7ulKe0BxDCBGwGaAdrvrEHgIOTppHq61ucJxo3pChmclWVFw0tmtO4+ke0Ju+VySAc52pxazCoUV4FyXLmJ1Eezv1TqPNoGNu0/+uFWRwo53GtEUTnG22J2xrYws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4WpW0j5V5TzhXty;
	Wed, 21 Aug 2024 10:45:41 +0800 (CST)
Received: from kwepemf100017.china.huawei.com (unknown [7.202.181.16])
	by mail.maildlp.com (Postfix) with ESMTPS id 2BB841401F4;
	Wed, 21 Aug 2024 10:47:42 +0800 (CST)
Received: from localhost.localdomain (10.175.104.67) by
 kwepemf100017.china.huawei.com (7.202.181.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 21 Aug 2024 10:47:40 +0800
From: Zizhi Wo <wozizhi@huawei.com>
To: <netfs@lists.linux.dev>, <dhowells@redhat.com>, <jlayton@kernel.org>
CC: <hsiangkao@linux.alibaba.com>, <jefflexu@linux.alibaba.com>,
	<zhujia.zj@bytedance.com>, <linux-erofs@lists.ozlabs.org>,
	<linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<wozizhi@huawei.com>, <libaokun1@huawei.com>, <yangerkun@huawei.com>,
	<houtao1@huawei.com>, <yukuai3@huawei.com>
Subject: [PATCH 3/8] cachefiles: Fix missing pos updates in cachefiles_ondemand_fd_write_iter()
Date: Wed, 21 Aug 2024 10:42:56 +0800
Message-ID: <20240821024301.1058918-4-wozizhi@huawei.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240821024301.1058918-1-wozizhi@huawei.com>
References: <20240821024301.1058918-1-wozizhi@huawei.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
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


