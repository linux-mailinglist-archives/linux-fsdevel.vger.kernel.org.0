Return-Path: <linux-fsdevel+bounces-14855-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E6D6D88096A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Mar 2024 03:07:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C65F1F230B1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Mar 2024 02:07:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DAEB1400A;
	Wed, 20 Mar 2024 02:06:11 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 571A6125C4;
	Wed, 20 Mar 2024 02:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710900371; cv=none; b=AxfC497eApAeHtY/5YEPNmVoOu3BOcRJgTcNgHuuS1GNYD1WQYTn6lc7/nt/rIKDGaWSozSIuz9iWkmBhnu58OMVN2IgJja6llPmXszE9Tvej8X+thjFBawDQX2R+Hd+NafYMR+DSvDeCEDXphDoF/FwAvt3gdWj6wgvAP9VRLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710900371; c=relaxed/simple;
	bh=niE9a21M2fG8af9wfgYRU3gIVnddd4hp8Zph3fA39zg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=X20Kb7qW7cXMSc60aPYRodoF1wtXFUWWEYsYOQC612+UeSzpEs0oselZCbnWtC/LkwilBuKItbTu3rP1yKZs4XhCzBE351DLHluoxWf5OQ7d5pLKnfikh/USfsCja4Q+IxILwMf3fkUowjM90V2wLh5xcSAYTCLu7C63BNlWnDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4TzsPy2LM7z4f3n6G;
	Wed, 20 Mar 2024 10:05:58 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id 3E1D81A016E;
	Wed, 20 Mar 2024 10:06:06 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.101.6])
	by APP3 (Coremail) with SMTP id _Ch0CgAHFZ2KRPplVj2CHQ--.18626S5;
	Wed, 20 Mar 2024 10:06:05 +0800 (CST)
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
Subject: [PATCH 3/6] workqueue: remove unnecessary import and function in wq_monitor.py
Date: Wed, 20 Mar 2024 19:02:19 +0800
Message-Id: <20240320110222.6564-4-shikemeng@huaweicloud.com>
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
X-CM-TRANSID:_Ch0CgAHFZ2KRPplVj2CHQ--.18626S5
X-Coremail-Antispam: 1UD129KBjvJXoWrtr1Dtw1xCF15Xr4rXw47Jwb_yoW8Jr15pF
	sakF47G3yfXryUX3Z5W343AFyfWrWDAF1qgayrXr1avrs8Xr9Ig34xK398Jr95Xa4DXFW0
	9a9rWrZ0qr4DZF7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPab4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M280x2IEY4vEnII2IxkI6r1a6r45M2
	8IrcIa0xkI8VA2jI8067AKxVWUWwA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK
	0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4
	x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l
	84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I
	8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AK
	xVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxV
	A2Y2ka0xkIwI1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAq
	x4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r
	43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF
	7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxV
	WUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU
	Iq2MUUUUU
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/

Remove unnecessary import and function in wq_monitor.py

Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
---
 tools/workqueue/wq_monitor.py | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/tools/workqueue/wq_monitor.py b/tools/workqueue/wq_monitor.py
index a8856a9c45dc..9e964c5be40c 100644
--- a/tools/workqueue/wq_monitor.py
+++ b/tools/workqueue/wq_monitor.py
@@ -32,16 +32,13 @@ https://github.com/osandov/drgn.
   rescued  The number of work items executed by the rescuer.
 """
 
-import sys
 import signal
-import os
 import re
 import time
 import json
 
 import drgn
-from drgn.helpers.linux.list import list_for_each_entry,list_empty
-from drgn.helpers.linux.cpumask import for_each_possible_cpu
+from drgn.helpers.linux.list import list_for_each_entry
 
 import argparse
 parser = argparse.ArgumentParser(description=desc,
@@ -54,10 +51,6 @@ parser.add_argument('-j', '--json', action='store_true',
                     help='Output in json')
 args = parser.parse_args()
 
-def err(s):
-    print(s, file=sys.stderr, flush=True)
-    sys.exit(1)
-
 workqueues              = prog['workqueues']
 
 WQ_UNBOUND              = prog['WQ_UNBOUND']
-- 
2.30.0


