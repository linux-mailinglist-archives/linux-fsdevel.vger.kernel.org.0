Return-Path: <linux-fsdevel+bounces-32731-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B0F559AE611
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Oct 2024 15:24:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D2601F25E38
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Oct 2024 13:24:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EED01E9063;
	Thu, 24 Oct 2024 13:23:07 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B4081E7642;
	Thu, 24 Oct 2024 13:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729776186; cv=none; b=ssL73TQGxZas3cw9CSnVrvVPi5dbDtuIUHY6bIzv9130qfQ9G+ipt6JqOzTNsaHlfo7qDaAw9RJMvgqfgPpjw7NEjxStroV1CwrZeMyeiWCMFaFtKGX1QZctxZn+PQ+9opVcnWBxk5IbaDaIyGFl9c+xX2xJldsGCNdxS2TbXpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729776186; c=relaxed/simple;
	bh=wiRBpvH3YiE1zO3SQo5lm8zIGbTHlGLtpGjSdtJwXr8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OQKJzFr6uYQoqXAkLuG0JFmp/oZCdh/2pkg9/LCw2r2qn2RqMljVynMcSkZb2DGCxddwCMbF7LC9P+lv5ZhmeoecjciwiysHBnZFDZau2oIwreDpprKMuhBMdDafandful18nEyZ3+fpDfKRiwDnWJHXFsouyJDWkq/07cHTZJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4XZ66B68q9z4f3jdS;
	Thu, 24 Oct 2024 21:22:42 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 514F71A07BA;
	Thu, 24 Oct 2024 21:23:00 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgCHusYpShpn7tb6Ew--.444S9;
	Thu, 24 Oct 2024 21:22:59 +0800 (CST)
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
Subject: [PATCH 6.6 05/28] maple_tree: preserve the tree attributes when destroying maple tree
Date: Thu, 24 Oct 2024 21:19:46 +0800
Message-Id: <20241024132009.2267260-6-yukuai1@huaweicloud.com>
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
X-CM-TRANSID:gCh0CgCHusYpShpn7tb6Ew--.444S9
X-Coremail-Antispam: 1UD129KBjvJXoW7KFyfXFW3Ar4kAr4xXry7Wrg_yoW8XF43pr
	nrGw10qFyIqw18Cay0qay8Ca4UWFs5Wr1Iqa4DCr1UZr98Jws2g3yayrWxZa13Za4DuF15
	AF4Y934xta4kArJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUmq14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
	kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
	z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F
	4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq
	3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7
	IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4U
	M4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2
	kIc2xKxwCY1x0262kKe7AKxVWrXVW3AwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkE
	bVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67
	AF67kF1VAFwI0_Wrv_Gr1UMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Gr0_Xr1l
	IxAIcVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r
	1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIY
	CTnIWIevJa73UjIFyTuYvjTRAR6zUUUUU
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

From: Peng Zhang <zhangpeng.00@bytedance.com>

commit 8e50d32c7a89bde896945e4e572ef28ccd87bbf8 upstream.

When destroying maple tree, preserve its attributes and then turn it into
an empty tree.  This allows it to be reused without needing to be
reinitialized.

Link: https://lkml.kernel.org/r/20231027033845.90608-10-zhangpeng.00@bytedance.com
Signed-off-by: Peng Zhang <zhangpeng.00@bytedance.com>
Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Mateusz Guzik <mjguzik@gmail.com>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Michael S. Tsirkin <mst@redhat.com>
Cc: Mike Christie <michael.christie@oracle.com>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Suren Baghdasaryan <surenb@google.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 lib/maple_tree.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index 6f1addbbc820..97a610307d38 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -6774,7 +6774,7 @@ void __mt_destroy(struct maple_tree *mt)
 	if (xa_is_node(root))
 		mte_destroy_walk(root, mt);
 
-	mt->ma_flags = 0;
+	mt->ma_flags = mt_attr(mt);
 }
 EXPORT_SYMBOL_GPL(__mt_destroy);
 
-- 
2.39.2


