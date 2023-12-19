Return-Path: <linux-fsdevel+bounces-6463-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 22330817FE9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Dec 2023 03:43:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 36A011C22E3C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Dec 2023 02:43:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2270DD2F5;
	Tue, 19 Dec 2023 02:42:59 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBE77BA5D;
	Tue, 19 Dec 2023 02:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R511e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046060;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0Vyp0pKX_1702953767;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0Vyp0pKX_1702953767)
          by smtp.aliyun-inc.com;
          Tue, 19 Dec 2023 10:42:48 +0800
From: Jingbo Xu <jefflexu@linux.alibaba.com>
To: shr@devkernel.io,
	akpm@linux-foundation.org
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	joseph.qi@linux.alibaba.com,
	linux-fsdevel@vger.kernel.org,
	linux-block@vger.kernel.org
Subject: [PATCH v2 1/2] mm: fix arithmetic for bdi min_ratio
Date: Tue, 19 Dec 2023 10:42:45 +0800
Message-Id: <20231219024246.65654-2-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20231219024246.65654-1-jefflexu@linux.alibaba.com>
References: <20231219024246.65654-1-jefflexu@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since now bdi->min_ratio is part per million, fix the wrong arithmetic.
Otherwise it will fail with -EINVAL when setting a reasonable min_ratio,
as it tries to set min_ratio to (min_ratio * BDI_RATIO_SCALE) in
percentage unit, which exceeds 100% anyway.

    # cat /sys/class/bdi/253\:0/min_ratio
    0
    # cat /sys/class/bdi/253\:0/max_ratio
    100
    # echo 1 > /sys/class/bdi/253\:0/min_ratio
    -bash: echo: write error: Invalid argument

Fixes: 8021fb3232f2 ("mm: split off __bdi_set_min_ratio() function")
Reported-by: Joseph Qi <joseph.qi@linux.alibaba.com>
Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
---
 mm/page-writeback.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index ee2fd6a6af40..2140382dd768 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -692,7 +692,6 @@ static int __bdi_set_min_ratio(struct backing_dev_info *bdi, unsigned int min_ra
 
 	if (min_ratio > 100 * BDI_RATIO_SCALE)
 		return -EINVAL;
-	min_ratio *= BDI_RATIO_SCALE;
 
 	spin_lock_bh(&bdi_lock);
 	if (min_ratio > bdi->max_ratio) {
-- 
2.19.1.6.gb485710b


