Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C7B51F7B76
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Jun 2020 18:10:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726319AbgFLQKF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 12 Jun 2020 12:10:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726053AbgFLQKE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 12 Jun 2020 12:10:04 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C90E8C03E96F;
        Fri, 12 Jun 2020 09:10:04 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id i4so4051153pjd.0;
        Fri, 12 Jun 2020 09:10:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xGowqnfFw5R0e+Qkd5MSY7h9qfsgL+NMoQac/0huSiE=;
        b=LWM0JgqePgHG1PtiYO/tQhhZ1IXZhDY688eqkDRtu1G1KB+lncE7qt6C/K+OD2wmIo
         tev4g5xZQfGKLtZ0hvJbO+hFbxh7VtYJUr0VfhammcNc+16YdKyPEoDrU+UqTTNm7XLq
         mekKCMO+v1GtAxaPyZszhPsElYm4alT9pqHosUEB+yoz/ipvIZkjuTReR1HFg5aPgTIp
         YUI/maaYipbxTTfA9mf7qWkSnmRZP3EbkWmXiOssuTHB6qN6L2YJ+0pm2Kt3lMpONx62
         RUYKiVwKxZdPpFIkevS+tVZYMrn24QAyZsQIk6WxXsFgGDP+UxyUvpPcUqHyzBftA3Xm
         toIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xGowqnfFw5R0e+Qkd5MSY7h9qfsgL+NMoQac/0huSiE=;
        b=FvxgINoX7u0GGrWc8QdTTi8QI6leOgUe44hadKgm+rwUTPb0EZJ56WE+qUO27Ha1wb
         0dmLuHztCuPADe3k8IU0YgykqQboVnCw/nsi2f/yJVyB3oTGcQOczdElkcYZIUZkQUqO
         loFqiIgco6UY4UL04betue9TrGiOD1K5ZbZEeXcXrMOipAHBvDuwnfQarfiNZLtXKhQ4
         u1Sy+n26zXFEUDLG72AfzgUjn16dLCgVXc0RYT1Fmd12xhuxg4tHn09tDsNFfV5rH1l7
         kjmC8dyb5qz/0iYDQNCdB1ZSEoqIfbRyMwLkZWACc8ve+XyIk5BJH3LKhCDn5s2ZxTAe
         VFOQ==
X-Gm-Message-State: AOAM532kQlNOjZUZrRkh06c9BKEjmQQ5c5DdAHxqe9RyZMU2zzB6YMRu
        gTZJVylgclVUPrk+qOdT8No=
X-Google-Smtp-Source: ABdhPJxdvPCcklOmzTvVthz1jvb5cZfjfI+ke/dS44xFChUkO0IZXR8rFybDkP8OxkPZmS5VPqeVig==
X-Received: by 2002:a17:902:b718:: with SMTP id d24mr11541086pls.185.1591978204151;
        Fri, 12 Jun 2020 09:10:04 -0700 (PDT)
Received: from Smcdef-MBP.lan ([103.136.221.72])
        by smtp.gmail.com with ESMTPSA id x1sm5794879pju.3.2020.06.12.09.10.01
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 Jun 2020 09:10:03 -0700 (PDT)
From:   Kaitao Cheng <pilgrimtao@gmail.com>
To:     adobriyan@gmail.com, Markus.Elfring@web.de
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        songmuchun@bytedance.com, kernel-janitors@vger.kernel.org,
        Kaitao Cheng <pilgrimtao@gmail.com>
Subject: [PATCH v2] proc/fd: Remove unnecessary {files, f_flags, file} initialization in seq_show()
Date:   Sat, 13 Jun 2020 00:09:46 +0800
Message-Id: <20200612160946.21187-1-pilgrimtao@gmail.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

'files' will be immediately reassigned. 'f_flags' and 'file' will be
overwritten in the if{} or seq_show() directly exits with an error.
so we don't need to consume CPU resources to initialize them.

Signed-off-by: Kaitao Cheng <pilgrimtao@gmail.com>
---

v2 ChangeLog:
  1. Fix some commit message
  2. Remove unnecessary f_flags initialization

 fs/proc/fd.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/proc/fd.c b/fs/proc/fd.c
index 81882a13212d..d3854b76e95e 100644
--- a/fs/proc/fd.c
+++ b/fs/proc/fd.c
@@ -19,9 +19,9 @@
 
 static int seq_show(struct seq_file *m, void *v)
 {
-	struct files_struct *files = NULL;
-	int f_flags = 0, ret = -ENOENT;
-	struct file *file = NULL;
+	struct files_struct *files;
+	int f_flags, ret = -ENOENT;
+	struct file *file;
 	struct task_struct *task;
 
 	task = get_proc_task(m->private);
-- 
2.20.1

