Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C78831F056A
	for <lists+linux-fsdevel@lfdr.de>; Sat,  6 Jun 2020 08:32:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728628AbgFFGcb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 6 Jun 2020 02:32:31 -0400
Received: from mail.loongson.cn ([114.242.206.163]:38850 "EHLO loongson.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727077AbgFFGc3 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 6 Jun 2020 02:32:29 -0400
Received: from linux.localdomain (unknown [113.200.148.30])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9Dxj2p0ONtesFg+AA--.1141S2;
        Sat, 06 Jun 2020 14:32:20 +0800 (CST)
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Xuefeng Li <lixuefeng@loongson.cn>
Subject: [PATCH 1/3] fs: Use get_max_files() instead of files_stat.max_files in alloc_empty_file()
Date:   Sat,  6 Jun 2020 14:32:18 +0800
Message-Id: <1591425140-20613-1-git-send-email-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.1.0
X-CM-TRANSID: AQAAf9Dxj2p0ONtesFg+AA--.1141S2
X-Coremail-Antispam: 1UD129KBjvdXoWrKr15KFyrAry5tw4xZryDtrb_yoWfZrb_Z3
        srtryDurWUAr4rXas2yrW5Xr9Yg34UAw4Fvw4YgrZFv3W3X3yxJw4Dur1rCF4UZa17CFnY
        qr1rWFykCryq9jkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbcAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2IYs7xG
        6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
        A2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Jr0_
        Gr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4UJV
        WxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
        2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJV
        W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc2xSY4AK67AK6r47
        MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr
        0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0E
        wIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJV
        W8JwCI42IY6xAIw20EY4v20xvaj40_WFyUJVCq3wCI42IY6I8E87Iv67AKxVWUJVW8JwCI
        42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfU1MKuUUUUU
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

It is better to use get_max_files() instead of files_stat.max_files
to improve readability.

Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---
 fs/file_table.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/file_table.c b/fs/file_table.c
index 656647f..26516d0 100644
--- a/fs/file_table.c
+++ b/fs/file_table.c
@@ -139,12 +139,12 @@ struct file *alloc_empty_file(int flags, const struct cred *cred)
 	/*
 	 * Privileged users can go above max_files
 	 */
-	if (get_nr_files() >= files_stat.max_files && !capable(CAP_SYS_ADMIN)) {
+	if (get_nr_files() >= get_max_files() && !capable(CAP_SYS_ADMIN)) {
 		/*
 		 * percpu_counters are inaccurate.  Do an expensive check before
 		 * we go and fail.
 		 */
-		if (percpu_counter_sum_positive(&nr_files) >= files_stat.max_files)
+		if (percpu_counter_sum_positive(&nr_files) >= get_max_files())
 			goto over;
 	}
 
-- 
2.1.0

