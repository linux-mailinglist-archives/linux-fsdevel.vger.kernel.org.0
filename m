Return-Path: <linux-fsdevel+bounces-14860-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A088880974
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Mar 2024 03:08:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B83A9283892
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Mar 2024 02:08:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDD32CA47;
	Wed, 20 Mar 2024 02:06:18 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8152E2BB0C;
	Wed, 20 Mar 2024 02:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710900378; cv=none; b=aSoFfZZ89ZmsULm+h2S+IV2vkG25oseQuZLgtN01/YQYiupZbJHjdXvetWVOJ3NhQ+JTAcwZIRCIhnomZ+1gC7L4IYJueqx8z3ydUXsBV8c82ijD5DWoSDUspmySS+Q9V2muWUaggEDWqKAxm05WtAF7AOpXYtiw+zRL/eWl5e8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710900378; c=relaxed/simple;
	bh=Z8+wiNGtDIToSwps2ZuWbC29SNBtJ0uiL3GiMA5SDxw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lSdHLZYyJ+LOS1vNeD50BKBIcxZrEQMobt/9MxwywiDJfcYXAlrmigml+33hOOeYSSgICr12kZn64jpXdkx/EMCQZKGAZbF/erzWgtgrUKYik1t4Am4nUQN5VDz/JF+kuPBAWSmwr/Bo/Ey4hU5gLk7C9r30RLkWkrWmClIUUXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4TzsQ15DZ3z4f3kFW;
	Wed, 20 Mar 2024 10:06:01 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id B0C7A1A01A7;
	Wed, 20 Mar 2024 10:06:07 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.101.6])
	by APP3 (Coremail) with SMTP id _Ch0CgAHFZ2KRPplVj2CHQ--.18626S8;
	Wed, 20 Mar 2024 10:06:07 +0800 (CST)
From: Kemeng Shi <shikemeng@huaweicloud.com>
To: akpm@linux-foundation.org,
	tj@kernel.org,
	linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: willy@infradead.org,
	bfoster@redhat.com,
	jack@suse.cz,
	dsterba@suse.com,
	mjguzik@gmail.com,
	dhowells@redhat.com,
	peterz@infradead.org
Subject: [PATCH 6/6] writeback: remove unneeded GDTC_INIT_NO_WB
Date: Wed, 20 Mar 2024 19:02:22 +0800
Message-Id: <20240320110222.6564-7-shikemeng@huaweicloud.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20240320110222.6564-1-shikemeng@huaweicloud.com>
References: <20240320110222.6564-1-shikemeng@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_Ch0CgAHFZ2KRPplVj2CHQ--.18626S8
X-Coremail-Antispam: 1UD129KBjvJXoW7WF1xJrWxtF1rZw4xXFWxCrg_yoW8Aw1UpF
	W3Cw1UKF4UArsFgFnxCasrXrnIqrZ7tFW7K3sxCw4ayF1xG3W8WFyjkw10yr4UAr93try7
	ArWxtFyxZF40yrJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPmb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M280x2IEY4vEnII2IxkI6r1a6r45M2
	8IrcIa0xkI8VA2jI8067AKxVWUAVCq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAv
	FVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3w
	A2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE
	3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr2
	1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv
	67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7
	CjxVA2Y2ka0xkIwI1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2Iq
	xVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r
	1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY
	6xkF7I0E14v26F4j6r4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aV
	AFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZE
	Xa7IU0TqcUUUUUU==
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/

We never use gdtc->dom set with GDTC_INIT_NO_WB, just remove unneeded
GDTC_INIT_NO_WB

Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
---
 mm/page-writeback.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index 481b6bf34c21..09b2b0754cc5 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -154,8 +154,6 @@ struct dirty_throttle_control {
 				.dom = &global_wb_domain,		\
 				.wb_completions = &(__wb)->completions
 
-#define GDTC_INIT_NO_WB		.dom = &global_wb_domain
-
 #define MDTC_INIT(__wb, __gdtc)	.wb = (__wb),				\
 				.dom = mem_cgroup_wb_domain(__wb),	\
 				.wb_completions = &(__wb)->memcg_completions, \
@@ -210,7 +208,6 @@ static void wb_min_max_ratio(struct bdi_writeback *wb,
 
 #define GDTC_INIT(__wb)		.wb = (__wb),                           \
 				.wb_completions = &(__wb)->completions
-#define GDTC_INIT_NO_WB
 #define MDTC_INIT(__wb, __gdtc)
 
 static bool mdtc_valid(struct dirty_throttle_control *dtc)
@@ -438,7 +435,7 @@ static void domain_dirty_limits(struct dirty_throttle_control *dtc)
  */
 void global_dirty_limits(unsigned long *pbackground, unsigned long *pdirty)
 {
-	struct dirty_throttle_control gdtc = { GDTC_INIT_NO_WB };
+	struct dirty_throttle_control gdtc = { };
 
 	gdtc.avail = global_dirtyable_memory();
 	domain_dirty_limits(&gdtc);
@@ -895,7 +892,7 @@ unsigned long wb_calc_thresh(struct bdi_writeback *wb, unsigned long thresh)
 
 unsigned long wb_calc_cg_thresh(struct bdi_writeback *wb)
 {
-	struct dirty_throttle_control gdtc = { GDTC_INIT_NO_WB };
+	struct dirty_throttle_control gdtc = { };
 	struct dirty_throttle_control mdtc = { MDTC_INIT(wb, &gdtc) };
 	unsigned long filepages, headroom, writeback;
 
-- 
2.30.0


