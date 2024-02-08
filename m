Return-Path: <linux-fsdevel+bounces-10751-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E29AB84DCD0
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Feb 2024 10:26:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 187561C24A2F
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Feb 2024 09:26:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E66DF6F50C;
	Thu,  8 Feb 2024 09:23:13 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 107316EB6C;
	Thu,  8 Feb 2024 09:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707384193; cv=none; b=j2vyj8OLsEY5XzXYG3OyVhbS4fhtLQawSXu0fhSLHCe4/wSpMtIYZXZRl66N8Qg3+Vj5QaCg/XHrthjO9G2VVGVP4mIteZUNhINOPYdzR3ZHU7jr//a50aScqdHPSPxYKbT+XN9RBI4chYu0PX3Umc5LZOZnYNcpMZ3aP+XHTXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707384193; c=relaxed/simple;
	bh=c8ghA0u9LWy+i3HgbXNw12xdIMNRO454mnesp/BH9+0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AKSf1JbLJE4vQpCyKzw+FYGTavI/HtCAWsjjK9p+EgKrIDqUgbY+XkMbJwkXlFYmNCuz0hjBPIDHbixjimPuW0d+eO3X5WrcHkKOn0hSXWSb6SpVYBrCF2RUoQ3zYNgFlqzVWRqPRpaIp9rF5D7qrfRwgoLQZqqMKgXiLworOU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4TVs3D6Vl8z4f3k6W;
	Thu,  8 Feb 2024 17:23:04 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id B76A11A027B;
	Thu,  8 Feb 2024 17:23:07 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
	by APP2 (Coremail) with SMTP id Syh0CgAnSQx4ncRl3tGXDQ--.8574S6;
	Thu, 08 Feb 2024 17:23:07 +0800 (CST)
From: Kemeng Shi <shikemeng@huaweicloud.com>
To: viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 4/7] fs/writeback: remove unneeded check in writeback_single_inode
Date: Fri,  9 Feb 2024 01:20:21 +0800
Message-Id: <20240208172024.23625-5-shikemeng@huaweicloud.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20240208172024.23625-1-shikemeng@huaweicloud.com>
References: <20240208172024.23625-1-shikemeng@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgAnSQx4ncRl3tGXDQ--.8574S6
X-Coremail-Antispam: 1UD129KBjvdXoW7XF1rXrWDtFykZF48Cw4kWFg_yoW3WFc_XF
	4qyr4kAr4FvFyrAw4kCF9aqrnY9w1UGr93JF13KFn0ga4YqryDZ39YqrZ8A34qvFW2gFZx
	Kwn7JrW7tFWfKjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbfAYFVCjjxCrM7AC8VAFwI0_Wr0E3s1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l87I20VAvwVAaII0Ic2I_JFv_Gryl82
	xGYIkIc2x26280x7IE14v26r126s0DM28IrcIa0xkI8VCY1x0267AKxVW8JVW5JwA2ocxC
	64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM2
	8EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0D
	M28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc
	02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAF
	wI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JMxAIw28IcxkI7V
	AKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCj
	r7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6x
	IIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAI
	w20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x
	0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IUnr9NDUUUUU==
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/

I_DIRTY_ALL consists of I_DIRTY_TIME and I_DIRTY, so I_DIRTY_TIME must
be set when any bit of I_DIRTY_ALL is set but I_DIRTY is not set.

Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
---
 fs/fs-writeback.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
index 2619f74ced70..b61bf2075931 100644
--- a/fs/fs-writeback.c
+++ b/fs/fs-writeback.c
@@ -1788,7 +1788,7 @@ static int writeback_single_inode(struct inode *inode,
 		else if (!(inode->i_state & I_SYNC_QUEUED)) {
 			if ((inode->i_state & I_DIRTY))
 				redirty_tail_locked(inode, wb);
-			else if (inode->i_state & I_DIRTY_TIME) {
+			else {
 				inode->dirtied_when = jiffies;
 				inode_io_list_move_locked(inode,
 							  wb,
-- 
2.30.0


