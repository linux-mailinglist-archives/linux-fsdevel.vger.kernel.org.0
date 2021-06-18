Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81F2B3ACB1A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Jun 2021 14:38:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231946AbhFRMkb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 18 Jun 2021 08:40:31 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:36734 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229877AbhFRMka (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 18 Jun 2021 08:40:30 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1624019901; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=qiuLMl18HhFSYMKHcPeThGQ32zAb/F1gnFVEgwuX6pw=; b=l3uCbpbVd0vLNAkZJ4jENzZyDqv1oeUMtOyLr2VdyZiQk9IjCAvHJ8HjBETimY/I1g8+6pni
 Fo0S3sB/Lht+GghP0kTTVIElzPgjyqwKJmab0oJaGxiZ5+8OwDfu0/J+JsSc/dRTuECh92aG
 F6vO5YuvBpNLZUQthl7SXMVU9y8=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyIxOTQxNiIsICJsaW51eC1mc2RldmVsQHZnZXIua2VybmVsLm9yZyIsICJiZTllNGEiXQ==
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-east-1.postgun.com with SMTP id
 60cc93bbe27c0cc77f549f4e (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 18 Jun 2021 12:38:19
 GMT
Sender: faiyazm=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id A991CC43147; Fri, 18 Jun 2021 12:38:18 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from faiyazm-linux.qualcomm.com (unknown [202.46.22.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: faiyazm)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 6ACCCC433F1;
        Fri, 18 Jun 2021 12:38:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 6ACCCC433F1
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=faiyazm@codeaurora.org
From:   Faiyaz Mohammed <faiyazm@codeaurora.org>
To:     cl@linux.com, penberg@kernel.org, rientjes@google.com,
        iamjoonsoo.kim@lge.com, akpm@linux-foundation.org, vbabka@suse.cz,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org, greg@kroah.com,
        glittao@gmail.com, andy.shevchenko@gmail.com
Cc:     vinmenon@codeaurora.org, catalin.marinas@arm.com,
        viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        Faiyaz Mohammed <faiyazm@codeaurora.org>
Subject: [PATCH v1] mm: slub: fix the leak of alloc/free traces debugfs interface
Date:   Fri, 18 Jun 2021 18:07:55 +0530
Message-Id: <1624019875-611-1-git-send-email-faiyazm@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

fix the leak of alloc/free traces debugfs interface, reported
by kmemleak like below,

unreferenced object 0xffff00091ae1b540 (size 64):
  comm "lsbug", pid 1607, jiffies 4294958291 (age 1476.340s)
  hex dump (first 32 bytes):
    02 00 00 00 00 00 00 00 6b 6b 6b 6b 6b 6b 6b 6b  ........kkkkkkkk
    6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
  backtrace:
    [<ffff8000106b06b8>] slab_post_alloc_hook+0xa0/0x418
    [<ffff8000106b5c7c>] kmem_cache_alloc_trace+0x1e4/0x378
    [<ffff8000106b5e40>] slab_debugfs_start+0x30/0x50
    slab_debugfs_start at mm/slub.c:5831
    [<ffff8000107b3dbc>] seq_read_iter+0x214/0xd50
    [<ffff8000107b4b84>] seq_read+0x28c/0x418
    [<ffff8000109560b4>] full_proxy_read+0xdc/0x148
    [<ffff800010738f24>] vfs_read+0x104/0x340
    [<ffff800010739ee0>] ksys_read+0xf8/0x1e0
    [<ffff80001073a03c>] __arm64_sys_read+0x74/0xa8
    [<ffff8000100358d4>] invoke_syscall.constprop.0+0xdc/0x1d8
    [<ffff800010035ab4>] do_el0_svc+0xe4/0x298
    [<ffff800011138528>] el0_svc+0x20/0x30
    [<ffff800011138b08>] el0t_64_sync_handler+0xb0/0xb8
    [<ffff80001001259c>] el0t_64_sync+0x178/0x17c

Fixes: 84a2bdb1b458fc968d6d9e07dab388dc679bd747 ("mm: slub: move sysfs slab alloc/free interfaces to debugfs")
Link: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/mm/slub.c?h=next-20210617&id=84a2bdb1b458fc968d6d9e07dab388dc679bd747

Signed-off-by: Faiyaz Mohammed <faiyazm@codeaurora.org>
---
 mm/slub.c | 17 +++++------------
 1 file changed, 5 insertions(+), 12 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index fcb0c50..f006766 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -5785,31 +5785,24 @@ static int slab_debugfs_show(struct seq_file *seq, void *v)
 
 static void slab_debugfs_stop(struct seq_file *seq, void *v)
 {
-	kfree(v);
 }
 
 static void *slab_debugfs_next(struct seq_file *seq, void *v, loff_t *ppos)
 {
-	loff_t *spos = v;
 	struct loc_track *t = seq->private;
 
+	v = ppos;
 	if (*ppos < t->count) {
-		*ppos = ++*spos;
-		return spos;
+		++*ppos;
+		return v;
 	}
-	*ppos = ++*spos;
+	++*ppos;
 	return NULL;
 }
 
 static void *slab_debugfs_start(struct seq_file *seq, loff_t *ppos)
 {
-	loff_t *spos = kmalloc(sizeof(loff_t), GFP_KERNEL);
-
-	if (!spos)
-		return NULL;
-
-	*spos = *ppos;
-	return spos;
+	return ppos;
 }
 
 static const struct seq_operations slab_debugfs_sops = {
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a
member of the Code Aurora Forum, hosted by The Linux Foundation

