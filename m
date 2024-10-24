Return-Path: <linux-fsdevel+bounces-32743-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F7BE9AE64B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Oct 2024 15:28:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C9227B27D30
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Oct 2024 13:28:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C6BB1E764B;
	Thu, 24 Oct 2024 13:25:16 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 940A61D8A08;
	Thu, 24 Oct 2024 13:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729776315; cv=none; b=Shrt2qN8tlXXXbLCeyBXYUAyMQuG4OBtmYivPUj1H6uM3ph2WJk9F6cIUkSCuyR62okkZgzgaf5S2NNju97cJjkhgMSGUmiaP/bmpnY3xXeBA+frORGhEeoH2p41CxJWP+M0ghLjocJeR2DVdsv00bY4S+5F/PlFhRehS8lUhB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729776315; c=relaxed/simple;
	bh=uc1LQeotcsNDpPS9/9fVNAcor0v2+3tE0pf/V0nNm/c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QzFS1WJ4CyhC3vG+aI0EUd30Q1qGtOrQ/sJnNRPD7g+Y5z9ewUAkhTpqaV9qiGGptKKBFhvUasE+mnd/i1eTbHJ1COQgvSwaennHgWkYE05OkIZTXO/1+eiDz2tzHAGysDGdpYYXfb+8muI7B9Y/+jag7YszSa2Xi/n9K39IV8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4XZ68f45Szz4f3jsB;
	Thu, 24 Oct 2024 21:24:50 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 0BE5F1A0194;
	Thu, 24 Oct 2024 21:25:08 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgD3LMmxShpnmfz6Ew--.42902S4;
	Thu, 24 Oct 2024 21:25:07 +0800 (CST)
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
Subject: [PATCH 6.6 16/28] Revert "maple_tree: correct tree corruption on spanning store"
Date: Thu, 24 Oct 2024 21:22:13 +0800
Message-Id: <20241024132225.2271667-1-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20241024132009.2267260-1-yukuai1@huaweicloud.com>
References: <20241024132009.2267260-1-yukuai1@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgD3LMmxShpnmfz6Ew--.42902S4
X-Coremail-Antispam: 1UD129KBjvJXoW7tF1fZF4UAw4fCFyfCFyfWFg_yoW8ury5pa
	yDCFW2yr1jyF18GFWvk3y0vas8J3WDtF4YvFW5KanYvFyDKr9IganYvw1IvFW5Z3yxCr1S
	yFWjvr4DG3ZayFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9F14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4U
	JVW0owA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628v
	n2kIc2xKxwCY1x0262kKe7AKxVWrXVW3AwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7x
	kEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E
	67AF67kF1VAFwI0_Wrv_Gr1UMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Xr0_Ar
	1lIxAIcVC0I7IYx2IY6xkF7I0E14v26F4UJVW0owCI42IY6xAIw20EY4v20xvaj40_Jr0_
	JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVWxJr0_GcJvcS
	sGvfC2KfnxnUUI43ZEXa7sR_v38UUUUUU==
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

From: Yu Kuai <yukuai3@huawei.com>

This reverts commit 677f1df179cb68c12ddf7707ec325eb50e99c7d9.

Above commit contain manual changes and will cause conflicts for
following patches. The commit be backported from mainline later, without
conflicts.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 lib/maple_tree.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index f73e3772c883..291412b91047 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -2236,8 +2236,6 @@ static inline void mas_node_or_none(struct ma_state *mas,
 
 /*
  * mas_wr_node_walk() - Find the correct offset for the index in the @mas.
- *                      If @mas->index cannot be found within the containing
- *                      node, we traverse to the last entry in the node.
  * @wr_mas: The maple write state
  *
  * Uses mas_slot_locked() and does not need to worry about dead nodes.
@@ -3657,7 +3655,7 @@ static bool mas_wr_walk(struct ma_wr_state *wr_mas)
 	return true;
 }
 
-static void mas_wr_walk_index(struct ma_wr_state *wr_mas)
+static bool mas_wr_walk_index(struct ma_wr_state *wr_mas)
 {
 	struct ma_state *mas = wr_mas->mas;
 
@@ -3666,9 +3664,11 @@ static void mas_wr_walk_index(struct ma_wr_state *wr_mas)
 		wr_mas->content = mas_slot_locked(mas, wr_mas->slots,
 						  mas->offset);
 		if (ma_is_leaf(wr_mas->type))
-			return;
+			return true;
 		mas_wr_walk_traverse(wr_mas);
+
 	}
+	return true;
 }
 /*
  * mas_extend_spanning_null() - Extend a store of a %NULL to include surrounding %NULLs.
@@ -3905,8 +3905,8 @@ static inline int mas_wr_spanning_store(struct ma_wr_state *wr_mas)
 	memset(&b_node, 0, sizeof(struct maple_big_node));
 	/* Copy l_mas and store the value in b_node. */
 	mas_store_b_node(&l_wr_mas, &b_node, l_wr_mas.node_end);
-	/* Copy r_mas into b_node if there is anything to copy. */
-	if (r_mas.max > r_mas.last)
+	/* Copy r_mas into b_node. */
+	if (r_mas.offset <= r_wr_mas.node_end)
 		mas_mab_cp(&r_mas, r_mas.offset, r_wr_mas.node_end,
 			   &b_node, b_node.b_end + 1);
 	else
-- 
2.39.2


