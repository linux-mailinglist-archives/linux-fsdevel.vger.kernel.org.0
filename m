Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C502B439076
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Oct 2021 09:37:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231743AbhJYHjg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 25 Oct 2021 03:39:36 -0400
Received: from smtp21.cstnet.cn ([159.226.251.21]:53020 "EHLO cstnet.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229491AbhJYHjg (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 25 Oct 2021 03:39:36 -0400
X-Greylist: delayed 331 seconds by postgrey-1.27 at vger.kernel.org; Mon, 25 Oct 2021 03:39:35 EDT
Received: from localhost.localdomain (unknown [124.16.138.128])
        by APP-01 (Coremail) with SMTP id qwCowAAHoCBHXXZhWuRJBQ--.64178S2;
        Mon, 25 Oct 2021 15:31:19 +0800 (CST)
From:   Jiasheng Jiang <jiasheng@iscas.ac.cn>
To:     viro@zeniv.linux.org.uk
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiasheng Jiang <jiasheng@iscas.ac.cn>
Subject: [PATCH] seq_file: Fix potential addition overflow
Date:   Mon, 25 Oct 2021 07:31:18 +0000
Message-Id: <1635147078-2409190-1-git-send-email-jiasheng@iscas.ac.cn>
X-Mailer: git-send-email 2.7.4
X-CM-TRANSID: qwCowAAHoCBHXXZhWuRJBQ--.64178S2
X-Coremail-Antispam: 1UD129KBjvdXoWrZF1rAw1ktFW8AryrWw4xtFb_yoWfXFc_ta
        9avw1rGr42qa1vvF9rtr409rykAwn7tr4Yq34fX3sxtFWUKr43AF1DCr9xCr1fC395XF1D
        X34vvF90g3W5ujkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbc8FF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2IYs7xG
        6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
        A2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_
        Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s
        1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0
        cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8Jw
        ACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc2xSY4AK67AK6r4xMxAI
        w28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr
        4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxG
        rwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8Jw
        CI42IY6xAIw20EY4v20xvaj40_WFyUJVCq3wCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY
        6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUekucDUUUU
X-Originating-IP: [124.16.138.128]
X-CM-SenderInfo: pmld2xxhqjqxpvfd2hldfou0/
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

After seq_hlist_start_percpu(), the value of &iter->li_cpu might be
MAX_UINT.
In that case, there will be addition overflow in the cpumask_next().
Therefore, it might be better to add the check before.

Fixes: 0bc7738 ("seq_file: add seq_list_*_percpu helpers")
Signed-off-by: Jiasheng Jiang <jiasheng@iscas.ac.cn>
---
 fs/seq_file.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/seq_file.c b/fs/seq_file.c
index 5059248..f768c28 100644
--- a/fs/seq_file.c
+++ b/fs/seq_file.c
@@ -1105,6 +1105,9 @@ seq_hlist_next_percpu(void *v, struct hlist_head __percpu *head,
 	if (node->next)
 		return node->next;
 
+	if (*cpu >= nr_cpu_ids)
+		return NULL;
+
 	for (*cpu = cpumask_next(*cpu, cpu_possible_mask); *cpu < nr_cpu_ids;
 	     *cpu = cpumask_next(*cpu, cpu_possible_mask)) {
 		struct hlist_head *bucket = per_cpu_ptr(head, *cpu);
-- 
2.7.4

