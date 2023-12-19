Return-Path: <linux-fsdevel+bounces-6495-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C1DE18189C3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Dec 2023 15:26:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E45981C24010
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Dec 2023 14:26:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D6641CA84;
	Tue, 19 Dec 2023 14:25:22 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBA161C6B2;
	Tue, 19 Dec 2023 14:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R771e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0Vyr60qx_1702995911;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0Vyr60qx_1702995911)
          by smtp.aliyun-inc.com;
          Tue, 19 Dec 2023 22:25:12 +0800
From: Jingbo Xu <jefflexu@linux.alibaba.com>
To: shr@devkernel.io,
	akpm@linux-foundation.org
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	joseph.qi@linux.alibaba.com,
	linux-fsdevel@vger.kernel.org,
	linux-block@vger.kernel.org,
	willy@infradead.org
Subject: [PATCH v3 2/2] mm: fix arithmetic for max_prop_frac when setting max_ratio
Date: Tue, 19 Dec 2023 22:25:08 +0800
Message-Id: <20231219142508.86265-3-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20231219142508.86265-1-jefflexu@linux.alibaba.com>
References: <20231219142508.86265-1-jefflexu@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since now bdi->max_ratio is part per million, fix the wrong arithmetic
for max_prop_frac when setting max_ratio.  Otherwise the miscalculated
max_prop_frac will affect the incrementing of writeout completion count
when max_ratio is not 100%.

Fixes: efc3e6ad53ea ("mm: split off __bdi_set_max_ratio() function")
Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
---
 mm/page-writeback.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index 2140382dd768..05e5c425b3ff 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -728,7 +728,8 @@ static int __bdi_set_max_ratio(struct backing_dev_info *bdi, unsigned int max_ra
 		ret = -EINVAL;
 	} else {
 		bdi->max_ratio = max_ratio;
-		bdi->max_prop_frac = (FPROP_FRAC_BASE * max_ratio) / 100;
+		bdi->max_prop_frac = (FPROP_FRAC_BASE * max_ratio) /
+						(100 * BDI_RATIO_SCALE);
 	}
 	spin_unlock_bh(&bdi_lock);
 
-- 
2.19.1.6.gb485710b


