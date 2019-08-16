Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3D8688FDDB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Aug 2019 10:33:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726863AbfHPIcy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 16 Aug 2019 04:32:54 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:42657 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726739AbfHPIcy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 16 Aug 2019 04:32:54 -0400
Received: by mail-pf1-f195.google.com with SMTP id i30so2771593pfk.9;
        Fri, 16 Aug 2019 01:32:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=yuE873IbiwemYHZMD4KW0OvYRCF9sChEloERx3wmBIM=;
        b=FhLJEG7YhCU0zZJ6JdxwQsm4Mj02X4bxWld0f+9ALxBLVr5UTKyBPJPbwp/AKIeK2m
         CY7hEJHrGPpcxq1592Ha0F3qkPxTR/M1MVqAMaGSuuqIfWwmM22OcFD0keTOiO31vuFJ
         //GLl+bVrg0OrKBXLKF0BTyrbZ6P+XIvzrVUYvhOhUaPmiRD/7yms1Eu2GvPoCyxtRlr
         eSyHjqdXsLbloZIi+7iFEifnATWl8OLcTn+d8n4AeAVA6dCb+DJMrOjXftNA21sQI5df
         hvAklMZZ43Ll0LljkiYjkU2TMCxkWjLZgToNWmN/glQ+yd9UZEvG8QenCp2nFkxsF8hL
         gfcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=yuE873IbiwemYHZMD4KW0OvYRCF9sChEloERx3wmBIM=;
        b=drAL8D4asiFnN4Mbc5JBelyUPqH4CPFoAYUHvHZNq1bMSCJqnDqGORV9Nq71VqDML9
         PvFj34psqd+oqrAA9wWJdmJizTLmxuCQ8C8slFVaA2+jGQyUUn4QGqhoQao1ujCEem9i
         4oMhfh7Sr7QoArInN0CYQxwVs2GH4j9uLgu6NDMXyIQ0T3uPocdDJqox13fCHgna7Vmi
         tdScu5NmDwsrcmNfafZcMD4WTOhtGh4U4op/LaCa/8OpsQDyk6DTDtJgsMd/yVri44tm
         ecukJfaS1Ler4Y4j28BkmC+2oA8zv9SmIi7jdQac4bu3Tx2/xMWbjMbGycPs4lNtwajf
         bmeQ==
X-Gm-Message-State: APjAAAXfY1eY/u1o16rqRk7jjZy+dDHvqh3IbRJIeRM7SxUi1lf2vWV1
        wnF3WJ4abKBhK5/wqWFHM1A=
X-Google-Smtp-Source: APXvYqwH0DMAs0ppI6tDcRbJQwqINk2TOD2JE++LEGy84nkvf5UOiyc6kAJoPZ1FBqfhH36k28dKhQ==
X-Received: by 2002:a65:5183:: with SMTP id h3mr6822290pgq.250.1565944373616;
        Fri, 16 Aug 2019 01:32:53 -0700 (PDT)
Received: from localhost.localdomain (sdc02.force10networks.com. [63.80.56.89])
        by smtp.gmail.com with ESMTPSA id o24sm9824597pfp.135.2019.08.16.01.32.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Aug 2019 01:32:52 -0700 (PDT)
From:   arul.jeniston@gmail.com
To:     viro@zeniv.linux.org.uk, tglx@linutronix.de
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        arul_mc@dell.com, ARUL JENISTON MC <arul.jeniston@gmail.com>
Subject: [PATCH] FS: timerfd: Fix unexpected return value of timerfd_read function.  'hrtimer_forward_now()' returns zero due to bigger backward time drift.  This causes timerfd_read to return 0. As per man page, read on timerfd  is not expected to return 0. This patch fixes this problem.  Signed-off-by: Arul Jeniston <arul.jeniston@gmail.com>
Date:   Fri, 16 Aug 2019 01:32:46 -0700
Message-Id: <20190816083246.169312-1-arul.jeniston@gmail.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: ARUL JENISTON MC <arul.jeniston@gmail.com>

---
 fs/timerfd.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/fs/timerfd.c b/fs/timerfd.c
index 6a6fc8aa1de7..f5094e070e9a 100644
--- a/fs/timerfd.c
+++ b/fs/timerfd.c
@@ -284,8 +284,16 @@ static ssize_t timerfd_read(struct file *file, char __user *buf, size_t count,
 					&ctx->t.alarm, ctx->tintv) - 1;
 				alarm_restart(&ctx->t.alarm);
 			} else {
-				ticks += hrtimer_forward_now(&ctx->t.tmr,
-							     ctx->tintv) - 1;
+				u64 nooftimeo = hrtimer_forward_now(&ctx->t.tmr,
+								 ctx->tintv);
+				/*
+				 * ticks shouldn't become zero at this point.
+				 * Ignore if hrtimer_forward_now returns 0
+				 * due to larger backward time drift.
+				 */
+				if (likely(nooftimeo)) {
+					ticks += nooftimeo - 1;
+				}
 				hrtimer_restart(&ctx->t.tmr);
 			}
 		}
-- 
2.11.0

