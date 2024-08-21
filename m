Return-Path: <linux-fsdevel+bounces-26427-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F04295930D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Aug 2024 04:49:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B26E31C2230E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Aug 2024 02:49:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8FB716DC11;
	Wed, 21 Aug 2024 02:47:51 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D84616B75C;
	Wed, 21 Aug 2024 02:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724208471; cv=none; b=rIYDbsakSBCQVVSmSFWfrEMV1IP1HRCAeIdBiBq6ISnJqxpl0zToG5G4tPaO2s2ctJ/Nx1jAPwsvzdZcEpVVlhW0rF0guRDOVwu0Q12+7DzgDKLAKgoscJAcYVbRj2TTnzTcIZW9LjVg2u/JeSu2QxzVVixPKhAeFN29OWT5Ktc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724208471; c=relaxed/simple;
	bh=w703GJBiRakD5YiiL/tpRpWDMUnq32ojEGAp0ZbBnJ4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n0DMvX3oboDBGw3FFZBdBQ4eFp/NZAQL3wJdSGmOgTOARBasEkEmBD9At8xpfjRlfzPvInMEJUtC2+l/v3cxZeiSrtNz7a1VQNp/UgjmTccSUCHHJuGe7Yxt2B949zEN9h6yVjyTBv12giYz2XBrAsn9bLkXEyGwj/20tOaotO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4WpW345j9Cz1S8Nd;
	Wed, 21 Aug 2024 10:47:44 +0800 (CST)
Received: from kwepemf100017.china.huawei.com (unknown [7.202.181.16])
	by mail.maildlp.com (Postfix) with ESMTPS id 4132F1A016C;
	Wed, 21 Aug 2024 10:47:47 +0800 (CST)
Received: from localhost.localdomain (10.175.104.67) by
 kwepemf100017.china.huawei.com (7.202.181.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 21 Aug 2024 10:47:46 +0800
From: Zizhi Wo <wozizhi@huawei.com>
To: <netfs@lists.linux.dev>, <dhowells@redhat.com>, <jlayton@kernel.org>
CC: <hsiangkao@linux.alibaba.com>, <jefflexu@linux.alibaba.com>,
	<zhujia.zj@bytedance.com>, <linux-erofs@lists.ozlabs.org>,
	<linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<wozizhi@huawei.com>, <libaokun1@huawei.com>, <yangerkun@huawei.com>,
	<houtao1@huawei.com>, <yukuai3@huawei.com>
Subject: [PATCH 8/8] netfs/fscache: Add a memory barrier for FSCACHE_VOLUME_CREATING
Date: Wed, 21 Aug 2024 10:43:01 +0800
Message-ID: <20240821024301.1058918-9-wozizhi@huawei.com>
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


