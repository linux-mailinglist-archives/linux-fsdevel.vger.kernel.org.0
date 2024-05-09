Return-Path: <linux-fsdevel+bounces-19170-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E0FA98C0F96
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 May 2024 14:22:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 96F4E1F237DA
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 May 2024 12:22:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 057F81527A2;
	Thu,  9 May 2024 12:21:27 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D07E214D716;
	Thu,  9 May 2024 12:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715257286; cv=none; b=A9bcm75h5YhnaPdTrrJN+iP1k4mmxVNGAgDfqTOEj6iRNPf1F5eC9e4xi0WVth0F1581wAfq7uv1BiA969c+0LFtr9VYvCccOebH/YJiTirwwC9hYJOqMYgdqjTzGzASdBDRQjZ9sh33OTWJPJZpwMkTJm+dJO9DEDtxvhgbsDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715257286; c=relaxed/simple;
	bh=wtNKA/BVYmyPpeazghGcOT8sEnRtriRRNSsPvORb9UA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sBTvPZ7/t4tp/w7HOkhmoSPBWm7gOD5ZR0iM9pzrfkIgTOabphIE19upMF6bpZGJcxcbkOME+7OeZaFFQGnwFAgiERtlm4/n8EhXubgA+mH1VVU3g00nvIN0lzdLE32jrDikaMRnT+iw5tPoJzSfUOxDlcaVkJQAzvh6NHOoiJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4VZrhk5pLGz4f3nTs;
	Thu,  9 May 2024 20:21:10 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id B07931A017D;
	Thu,  9 May 2024 20:21:20 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
	by APP1 (Coremail) with SMTP id cCh0CgAn+RG+vzxm2lnBMA--.55991S5;
	Thu, 09 May 2024 20:21:20 +0800 (CST)
From: Hou Tao <houtao@huaweicloud.com>
To: linux-fsdevel@vger.kernel.org
Cc: Miklos Szeredi <miklos@szeredi.hu>,
	Zhao Chen <winters.zc@antgroup.com>,
	linux-kernel@vger.kernel.org,
	houtao1@huawei.com
Subject: [PATCH 1/2] fuse: set FR_PENDING atomically in fuse_resend()
Date: Thu,  9 May 2024 20:21:53 +0800
Message-Id: <20240509122154.782930-2-houtao@huaweicloud.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20240509122154.782930-1-houtao@huaweicloud.com>
References: <20240509122154.782930-1-houtao@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgAn+RG+vzxm2lnBMA--.55991S5
X-Coremail-Antispam: 1UD129KBjvdXoWruFyfZrW7Jw18Jw4ruw1xZrb_yoWDKrc_ur
	yxZrn7GF45Jryvgr95uan5KryF9rWkGFy7Gw4kXF93GFWDu397Ww1vvwn5tFW3Wr45Ga4k
	Wr1vga93K3yagjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbsAYFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l82xGYIkIc2x26280x7IE14v26r18M2
	8IrcIa0xkI8VCY1x0267AKxVWUXVWUCwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK
	021l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r
	4UJVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx
	0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWU
	JVW8JwACjcxG0xvY0x0EwIxGrwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJV
	W8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF
	1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6x
	IIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvE
	x4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnU
	UI43ZEXa7IU14CJJUUUUU==
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/

From: Hou Tao <houtao1@huawei.com>

When fuse_resend() moves the requests from processing lists to pending
list, it uses __set_bit() to set FR_PENDING bit in req->flags.

Using __set_bit() is not safe, because other functions may update
req->flags concurrently (e.g., request_wait_answer() may call
set_bit(FR_INTERRUPTED, &flags)).

Fix it by using set_bit() instead.

Fixes: 760eac73f9f69 ("fuse: Introduce a new notification type for resend pending requests")
Signed-off-by: Hou Tao <houtao1@huawei.com>
---
 fs/fuse/dev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index 3ec8bb5e68ff5..8eb2ce7c0b012 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -1813,7 +1813,7 @@ static void fuse_resend(struct fuse_conn *fc)
 	spin_unlock(&fc->lock);
 
 	list_for_each_entry_safe(req, next, &to_queue, list) {
-		__set_bit(FR_PENDING, &req->flags);
+		set_bit(FR_PENDING, &req->flags);
 		/* mark the request as resend request */
 		req->in.h.unique |= FUSE_UNIQUE_RESEND;
 	}
-- 
2.29.2


