Return-Path: <linux-fsdevel+bounces-33896-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D0F99C0403
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Nov 2024 12:30:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E0B81C21F62
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Nov 2024 11:30:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C7D95B1FB;
	Thu,  7 Nov 2024 11:30:26 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AB151E1325;
	Thu,  7 Nov 2024 11:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730979026; cv=none; b=iAd6RbL6c+UaE8atfuXhXZF2KRxAJP6yed+dcS23jIG6aVSfpstvk0ND8hoZQYtjvcAM6rWy2KFEryHbXmR3dOVEZ8eMM3wyHgUi4AaTqygxtA+jVjTaOvzPpY0EF/MfRjmTgOG73+NRFVoJnn4JxwdCaYsxmm5jB7UoEQtbp/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730979026; c=relaxed/simple;
	bh=tycehnml7nIskV1IKhFmTrfCzq+GzAVvOOf7z24DQ6k=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZV4oQkk0156HYCp6on57juBQnKzHZSNMRQcJY1g9GCIcUfrE1Kc3Q7h+iOYal7Yp57o7Lt5YVxwwcE3jiHSnUMG+r1uxMyKusAEaGDWoRhrkcduGwIOQIbH3xFduly6BbNLQoL0+W8zlr0Ehx2kK6Ks/32hwMcPIf/9jv8bX+b4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4XkfWD6Ng5z2gL16;
	Thu,  7 Nov 2024 19:10:32 +0800 (CST)
Received: from kwepemf100017.china.huawei.com (unknown [7.202.181.16])
	by mail.maildlp.com (Postfix) with ESMTPS id 8E6621A016C;
	Thu,  7 Nov 2024 19:10:22 +0800 (CST)
Received: from huawei.com (10.175.104.67) by kwepemf100017.china.huawei.com
 (7.202.181.16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 7 Nov
 2024 19:10:21 +0800
From: Zizhi Wo <wozizhi@huawei.com>
To: <netfs@lists.linux.dev>, <dhowells@redhat.com>, <jlayton@kernel.org>,
	<brauner@kernel.org>
CC: <hsiangkao@linux.alibaba.com>, <jefflexu@linux.alibaba.com>,
	<zhujia.zj@bytedance.com>, <linux-erofs@lists.ozlabs.org>,
	<linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<wozizhi@huawei.com>, <libaokun1@huawei.com>, <yangerkun@huawei.com>,
	<houtao1@huawei.com>, <yukuai3@huawei.com>
Subject: [PATCH v2 1/5] cachefiles: Fix incorrect length return value in cachefiles_ondemand_fd_write_iter()
Date: Thu, 7 Nov 2024 19:06:45 +0800
Message-ID: <20241107110649.3980193-2-wozizhi@huawei.com>
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

cachefiles_ondemand_fd_write_iter() function first aligns "pos" and "len"
to block boundaries. When calling __cachefiles_write(), the aligned "pos"
is passed in, but "len" is the original unaligned value(iter->count).
Additionally, the returned length of the write operation is the modified
"len" aligned by block size, which is unreasonable.

The alignment of "pos" and "len" is intended only to check whether the
cache has enough space. But the modified len should not be used as the
return value of cachefiles_ondemand_fd_write_iter() because the length we
passed to __cachefiles_write() is the previous "len". Doing so would result
in a mismatch in the data written on-demand. For example, if the length of
the user state passed in is not aligned to the block size (the preread
scene/DIO writes only need 512 alignment/Fault injection), the length of
the write will differ from the actual length of the return.

To solve this issue, since the __cachefiles_prepare_write() modifies the
size of "len", we pass "aligned_len" to __cachefiles_prepare_write() to
calculate the free blocks and use the original "len" as the return value of
cachefiles_ondemand_fd_write_iter().

Fixes: c8383054506c ("cachefiles: notify the user daemon when looking up cookie")
Signed-off-by: Zizhi Wo <wozizhi@huawei.com>
---
 fs/cachefiles/ondemand.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/cachefiles/ondemand.c b/fs/cachefiles/ondemand.c
index 470c96658385..bdd321017f1c 100644
--- a/fs/cachefiles/ondemand.c
+++ b/fs/cachefiles/ondemand.c
@@ -61,7 +61,7 @@ static ssize_t cachefiles_ondemand_fd_write_iter(struct kiocb *kiocb,
 	struct cachefiles_object *object = kiocb->ki_filp->private_data;
 	struct cachefiles_cache *cache = object->volume->cache;
 	struct file *file = object->file;
-	size_t len = iter->count;
+	size_t len = iter->count, aligned_len = len;
 	loff_t pos = kiocb->ki_pos;
 	const struct cred *saved_cred;
 	int ret;
@@ -70,7 +70,7 @@ static ssize_t cachefiles_ondemand_fd_write_iter(struct kiocb *kiocb,
 		return -ENOBUFS;
 
 	cachefiles_begin_secure(cache, &saved_cred);
-	ret = __cachefiles_prepare_write(object, file, &pos, &len, len, true);
+	ret = __cachefiles_prepare_write(object, file, &pos, &aligned_len, len, true);
 	cachefiles_end_secure(cache, saved_cred);
 	if (ret < 0)
 		return ret;
-- 
2.39.2


