Return-Path: <linux-fsdevel+bounces-32746-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EAB399AE658
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Oct 2024 15:29:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE429287254
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Oct 2024 13:29:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44CA61EBFF5;
	Thu, 24 Oct 2024 13:25:19 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39D731E7645;
	Thu, 24 Oct 2024 13:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729776318; cv=none; b=Yvwp+LnoHB0luPHmBnoJW4jxBtPpVv4zHKgVNX1sNFEkA8eZecrjppxPKyDVA3Cht9JtpLuiL9qy6SJphyvVHbbZF5PZRDImvGHHIjoadLZAXaloR/Od7b+mcbRFT1tJ2CjaEQYjvutUdavkEM8qFycyuvASWFOJbd7ZqIDS4Yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729776318; c=relaxed/simple;
	bh=j52ouEhBVSfVGFNJ1jw1qxVPuTAHKF6u7li8pHy9Uy8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lWvEgS/vtNGBtQjNDeSgHe7FZrU/yonn8vHgSeNVqE89AXSoEow8eHcxiOgTTJIK9rs85FanSdIGwhpLVL3j9BTAq+ldDwwHmF3y823Ef4Wsonv0P45y8MEVwQ1MViRJ6FVrEgzVM+uqCS7uicHL/SonexUmSJRkmQN7l+oRtSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4XZ68l5TKCz4f3jdh;
	Thu, 24 Oct 2024 21:24:55 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 3CEDC1A0194;
	Thu, 24 Oct 2024 21:25:13 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgD3LMmxShpnmfz6Ew--.42902S8;
	Thu, 24 Oct 2024 21:25:12 +0800 (CST)
From: Yu Kuai <yukuai1@huaweicloud.com>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org,
	harry.wentland@amd.com,
	sunpeng.li@amd.com,
	Rodrigo.Siqueira@amd.com,
	alexander.deucher@amd.com,
	christian.koenig@amd.com,
	Xinhui.Pan@amd.com,
	airlied@gmail.com,
	daniel@ffwll.ch,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	Liam.Howlett@oracle.com,
	akpm@linux-foundation.org,
	hughd@google.com,
	willy@infradead.org,
	sashal@kernel.org,
	srinivasan.shanmugam@amd.com,
	chiahsuan.chung@amd.com,
	mingo@kernel.org,
	mgorman@techsingularity.net,
	yukuai3@huawei.com,
	chengming.zhou@linux.dev,
	zhangpeng.00@bytedance.com,
	chuck.lever@oracle.com
Cc: amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	maple-tree@lists.infradead.org,
	linux-mm@kvack.org,
	yukuai1@huaweicloud.com,
	yi.zhang@huawei.com,
	yangerkun@huawei.com
Subject: [PATCH 6.6 20/28] lib/maple_tree.c: fix build error due to hotfix alteration
Date: Thu, 24 Oct 2024 21:22:17 +0800
Message-Id: <20241024132225.2271667-5-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20241024132225.2271667-1-yukuai1@huaweicloud.com>
References: <20241024132009.2267260-1-yukuai1@huaweicloud.com>
 <20241024132225.2271667-1-yukuai1@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgD3LMmxShpnmfz6Ew--.42902S8
X-Coremail-Antispam: 1UD129KBjvJXoWrtr13CryUAF17Xw4rWw13XFb_yoW8Jr43pa
	9rGr48K3yxuFyxC39Yqw40v3srXFn8Ww40qa4UGr18trn8Jr92q34ruFyI9ayfu34xA3Wa
	gF4Ygw48WFnrZa7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUmI14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
	kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
	z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr1j6r
	xdM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0D
	M2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjx
	v20xvE14v26r1Y6r17McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1l
	F7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxan2
	IY04v7MxkF7I0En4kS14v26rWY6Fy7MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY
	6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17
	CEb7AF67AKxVWrXVW8Jr1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVW5JVW7JwCI
	42IY6xIIjxv20xvEc7CjxVAFwI0_Cr1j6rxdMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCw
	CI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26F4UJVW0obIYCTnI
	WIevJa73UjIFyTuYvjTRGg4SUUUUU
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

From: Andrew Morton <akpm@linux-foundation.org>

commit 5143eecd2af2b5424f7b96d53f17bb4718e46bd3 upstream.

Commit 0de56e38b307 ("maple_tree: use maple state end for write
operations") was broken by a later patch "maple_tree: do not preallocate
nodes for slot stores".  But the later patch was scheduled ahead of
0de56e38b307, for 6.7-rc.

This fixlet undoes the damage.

Fixes: 0de56e38b307 ("maple_tree: use maple state end for write operations")
Cc: Liam R. Howlett <Liam.Howlett@oracle.com>
Cc: Sidhartha Kumar <sidhartha.kumar@oracle.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 lib/maple_tree.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index d90f4b7e7511..905fa1143f8d 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -5524,7 +5524,7 @@ int mas_preallocate(struct ma_state *mas, void *entry, gfp_t gfp)
 	node_size = mas_wr_new_end(&wr_mas);
 
 	/* Slot store, does not require additional nodes */
-	if (node_size == wr_mas.node_end) {
+	if (node_size == mas->end) {
 		/* reuse node */
 		if (!mt_in_rcu(mas->tree))
 			return 0;
-- 
2.39.2


