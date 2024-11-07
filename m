Return-Path: <linux-fsdevel+bounces-33891-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 907D79C0387
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Nov 2024 12:11:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD4701C21FC3
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Nov 2024 11:11:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EC391F7082;
	Thu,  7 Nov 2024 11:10:37 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93E871F6680;
	Thu,  7 Nov 2024 11:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730977836; cv=none; b=skrWbP9bOkTrms3YwgNDaK6c9krYyofrTVWOplqQuelKk+USM2FwP37mOpdTcCgTxYIux7FxvA/lBIaUZyHnTGtdDYkNqRFp32iRTVIjqxAxfTTgZnu7rWHyHwiDWSFgMJ2kCpRBeXpoOhZrAoUcaoVVufrojD2IQAeoIHgk3kI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730977836; c=relaxed/simple;
	bh=qWDhbIEFWCOCwM370sGSBoKdqofWiHM85gaoBK1VQNk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fG5gELsDnbohBGPbxpG3B0U0NI6kMdJl+z7EesX022yI7r/9qbK94rG2WRf2En8DI84aoHB8RhyzGaETrJ8VUcJQDq4PIFIEyJsUOEU9EQmRE8ADXeOYdQsk4zEBWxD7l9GoHcJxswDBRu8ppgsF2hKGhmTOPVQEUz1jy9U1Gtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4XkfT7637Rz1SGC6;
	Thu,  7 Nov 2024 19:08:43 +0800 (CST)
Received: from kwepemf100017.china.huawei.com (unknown [7.202.181.16])
	by mail.maildlp.com (Postfix) with ESMTPS id C45F41A0188;
	Thu,  7 Nov 2024 19:10:26 +0800 (CST)
Received: from huawei.com (10.175.104.67) by kwepemf100017.china.huawei.com
 (7.202.181.16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 7 Nov
 2024 19:10:25 +0800
From: Zizhi Wo <wozizhi@huawei.com>
To: <netfs@lists.linux.dev>, <dhowells@redhat.com>, <jlayton@kernel.org>,
	<brauner@kernel.org>
CC: <hsiangkao@linux.alibaba.com>, <jefflexu@linux.alibaba.com>,
	<zhujia.zj@bytedance.com>, <linux-erofs@lists.ozlabs.org>,
	<linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<wozizhi@huawei.com>, <libaokun1@huawei.com>, <yangerkun@huawei.com>,
	<houtao1@huawei.com>, <yukuai3@huawei.com>
Subject: [PATCH v2 5/5] netfs/fscache: Add a memory barrier for FSCACHE_VOLUME_CREATING
Date: Thu, 7 Nov 2024 19:06:49 +0800
Message-ID: <20241107110649.3980193-6-wozizhi@huawei.com>
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

In fscache_create_volume(), there is a missing memory barrier between the
bit-clearing operation and the wake-up operation. This may cause a
situation where, after a wake-up, the bit-clearing operation hasn't been
detected yet, leading to an indefinite wait. The triggering process is as
follows:

  [cookie1]                [cookie2]                  [volume_work]
fscache_perform_lookup
  fscache_create_volume
                        fscache_perform_lookup
                          fscache_create_volume
			                        fscache_create_volume_work
                                                  cachefiles_acquire_volume
                                                  clear_and_wake_up_bit
    test_and_set_bit
                            test_and_set_bit
                              goto maybe_wait
      goto no_wait

In the above process, cookie1 and cookie2 has the same volume. When cookie1
enters the -no_wait- process, it will clear the bit and wake up the waiting
process. If a barrier is missing, it may cause cookie2 to remain in the
-wait- process indefinitely.

In commit 3288666c7256 ("fscache: Use clear_and_wake_up_bit() in
fscache_create_volume_work()"), barriers were added to similar operations
in fscache_create_volume_work(), but fscache_create_volume() was missed.

By combining the clear and wake operations into clear_and_wake_up_bit() to
fix this issue.

Fixes: bfa22da3ed65 ("fscache: Provide and use cache methods to lookup/create/free a volume")
Signed-off-by: Zizhi Wo <wozizhi@huawei.com>
Acked-by: David Howells <dhowells@redhat.com>
---
 fs/netfs/fscache_volume.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/netfs/fscache_volume.c b/fs/netfs/fscache_volume.c
index cb75c07b5281..ced14ac78cc1 100644
--- a/fs/netfs/fscache_volume.c
+++ b/fs/netfs/fscache_volume.c
@@ -322,8 +322,7 @@ void fscache_create_volume(struct fscache_volume *volume, bool wait)
 	}
 	return;
 no_wait:
-	clear_bit_unlock(FSCACHE_VOLUME_CREATING, &volume->flags);
-	wake_up_bit(&volume->flags, FSCACHE_VOLUME_CREATING);
+	clear_and_wake_up_bit(FSCACHE_VOLUME_CREATING, &volume->flags);
 }
 
 /*
-- 
2.39.2


