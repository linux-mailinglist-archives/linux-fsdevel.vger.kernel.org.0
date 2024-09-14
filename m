Return-Path: <linux-fsdevel+bounces-29374-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 36D19978F45
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Sep 2024 10:55:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B4DA7B245BE
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Sep 2024 08:55:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6B3E146D5A;
	Sat, 14 Sep 2024 08:55:30 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA97D15D1
	for <linux-fsdevel@vger.kernel.org>; Sat, 14 Sep 2024 08:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726304130; cv=none; b=S5vHUHScykSxqjtYhfdLir76k//3djvfynJxWNohdts4IrQGkyN2NKO3AVDpaAc4lPSzI2cDOg9AvT75yQhdW+BR1VS8XLjiVQfy64SssLYYbRQEE7kh+/odImIT4f5/1rIALXqJNyWnZwfV00kb7kUc7r9pRpUh/ZXGHH+U+HU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726304130; c=relaxed/simple;
	bh=j8DxqegxzaeIemxWvcTNED8U48U43F5T27GAMKAyHW8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=YaQv1b4ygdPe3S6votsum1ilVWXisKYXHIpj0aBVMfzKW68DT7bmmqfz3vGx7iHGWzfpmfULTTB5AwO4fbL18LDfCBvPqkTJPo3kksyVI3Yo8u2JN+C+yxDWvFQPooqNEf4idB3XAP7AzKbekLPi6yr9mFeVaIXipAhgnlZpT3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4X5Q425ZQqz20npl;
	Sat, 14 Sep 2024 16:55:14 +0800 (CST)
Received: from kwepemd100024.china.huawei.com (unknown [7.221.188.41])
	by mail.maildlp.com (Postfix) with ESMTPS id EA2021401F0;
	Sat, 14 Sep 2024 16:55:23 +0800 (CST)
Received: from huawei.com (10.175.124.27) by kwepemd100024.china.huawei.com
 (7.221.188.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Sat, 14 Sep
 2024 16:55:23 +0800
From: yangyun <yangyun50@huawei.com>
To: Miklos Szeredi <miklos@szeredi.hu>
CC: Bernd Schubert <bschubert@ddn.com>, Amir Goldstein <amir73il@gmail.com>,
	<linux-fsdevel@vger.kernel.org>, <lixiaokeng@huawei.com>
Subject: [PATCH] fuse: use exclusive lock when FUSE_I_CACHE_IO_MODE is set
Date: Sat, 14 Sep 2024 16:51:31 +0800
Message-ID: <20240914085131.3871317-1-yangyun50@huawei.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemd100024.china.huawei.com (7.221.188.41)

This may be a typo. The comment has said shared locks are
not allowed when this bit is set. If using shared lock, the
wait in `fuse_file_cached_io_open` may be forever.

Fixes: 205c1d802683 ("fuse: allow parallel dio writes with FUSE_DIRECT_IO_ALLOW_MMAP")
CC: stable@vger.kernel.org
Signed-off-by: yangyun <yangyun50@huawei.com>
---
 fs/fuse/file.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index ca553d7a7c9e..e5f6affb0baa 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -1345,7 +1345,7 @@ static bool fuse_dio_wr_exclusive_lock(struct kiocb *iocb, struct iov_iter *from
 
 	/* shared locks are not allowed with parallel page cache IO */
 	if (test_bit(FUSE_I_CACHE_IO_MODE, &fi->state))
-		return false;
+		return true;
 
 	/* Parallel dio beyond EOF is not supported, at least for now. */
 	if (fuse_io_past_eof(iocb, from))
-- 
2.33.0


