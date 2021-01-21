Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AC172FE4B3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Jan 2021 09:14:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727368AbhAUINs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Jan 2021 03:13:48 -0500
Received: from out30-56.freemail.mail.aliyun.com ([115.124.30.56]:36812 "EHLO
        out30-56.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727681AbhAUIN2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Jan 2021 03:13:28 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04423;MF=abaci-bugfix@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0UMPTkGS_1611216755;
Received: from j63c13417.sqa.eu95.tbsite.net(mailfrom:abaci-bugfix@linux.alibaba.com fp:SMTPD_---0UMPTkGS_1611216755)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 21 Jan 2021 16:12:43 +0800
From:   Yang Li <abaci-bugfix@linux.alibaba.com>
To:     dyoung@redhat.com
Cc:     bhe@redhat.com, vgoyal@redhat.com, adobriyan@gmail.com,
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        Yang Li <abaci-bugfix@linux.alibaba.com>
Subject: [PATCH] vmalloc: remove redundant NULL check
Date:   Thu, 21 Jan 2021 16:12:33 +0800
Message-Id: <1611216753-44598-1-git-send-email-abaci-bugfix@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Fix below warnings reported by coccicheck:
./fs/proc/vmcore.c:1503:2-7: WARNING: NULL check before some freeing
functions is not needed.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Yang Li <abaci-bugfix@linux.alibaba.com>
---
 fs/proc/vmcore.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/fs/proc/vmcore.c b/fs/proc/vmcore.c
index c3a345c..9a15334 100644
--- a/fs/proc/vmcore.c
+++ b/fs/proc/vmcore.c
@@ -1503,11 +1503,8 @@ int vmcore_add_device_dump(struct vmcoredd_data *data)
 	return 0;
 
 out_err:
-	if (buf)
-		vfree(buf);
-
-	if (dump)
-		vfree(dump);
+	vfree(buf);
+	vfree(dump);
 
 	return ret;
 }
-- 
1.8.3.1

