Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3919255D910
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Jun 2022 15:20:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344105AbiF1KO0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Jun 2022 06:14:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245559AbiF1KOZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Jun 2022 06:14:25 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BADA11823;
        Tue, 28 Jun 2022 03:14:24 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id 9so11741362pgd.7;
        Tue, 28 Jun 2022 03:14:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NE608PFRqILqnXG38pNU+ErLdjvxNJ1H7ziYliYZy30=;
        b=ey1r16TEJvqhT+OBlAkqFMMCKk6sqkRnafipi1kDG1s/Xt9rxwnJJnZDnOx5OYQ3Ki
         B3sqnwH/Lua6v6KwVxgbxoIODlSf+UUCcqNzzZMlXJpW7etXr+t6hCePViCUn1n5UjeX
         cJDEwhmhm4mgyrJ5mHHlHbxp9LZWgsbEUeji+XEb3xbf7fK6OfhwVKrUKLG1mkGDZ8j8
         o2duNF4x0OHFShBo9Agi+7APFkl3q+AJilLvUfQa33T9vYTid12E3qv7JIqNhx1i45vc
         HYDGqJJptpu/VgZUs+b2RXKCZOgIGRPVNKAgcpFdOCt58+GfVv3iYiIzHVrWEhBpYaae
         TWKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NE608PFRqILqnXG38pNU+ErLdjvxNJ1H7ziYliYZy30=;
        b=mZOMLy9qCIO/UkGs2GEm9aRuatZgAbag6w9pmuZgckoU5fxWAe3h+Zr+B4rhwv+JsG
         IrvQ7uHcDVv1a++D2fprsqmsy6PwWwPGBWAnoaBIb8ZSVFbBxnfjvCEpRIg2COA2p94x
         WO4DFUrVBUyy8XtPc4Y8dudakktsk4o4+JEZRJj2w9WCJLxH3A1Y2dm8gYeGgR655ciB
         sauxbXUmClpXDGOKHuYIm6wP6vw+GoydLpavi8ZUScWvks9ZJk88+hn58qhXJ2HtlCKT
         Z/OPM+YND030Sgk7p4X3CrhcvLkvUvzO/+CL4BfQjf5xxUO1ufqarct5qj9mTlU7bpq/
         kiAA==
X-Gm-Message-State: AJIora9llB9VTL8dNAizfR3YM0Jy7eEO9DdjpZHMaY4sgQGBsP8bEV9f
        +4hrZqzHUZ7bWzbLYPk4Z54=
X-Google-Smtp-Source: AGRyM1uI4MLDZQfYaCHV4jPt4mYNUz2wxqGb1G96X+jR3z+y3WBlBt7oASCmkq03eWuOAQLK19klQQ==
X-Received: by 2002:a63:2254:0:b0:40d:d291:7710 with SMTP id t20-20020a632254000000b0040dd2917710mr12841095pgm.269.1656411264021;
        Tue, 28 Jun 2022 03:14:24 -0700 (PDT)
Received: from mi-HP-ProDesk-680-G4-MT.mioffice.cn ([43.224.245.232])
        by smtp.gmail.com with ESMTPSA id c16-20020a170902b69000b001678dcb4c5asm8890437pls.100.2022.06.28.03.14.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jun 2022 03:14:23 -0700 (PDT)
From:   Guowei Du <duguoweisz@gmail.com>
To:     jack@suse.cz, amir73il@gmail.com, repnop@google.com,
        brauner@kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        duguowei <duguowei@xiaomi.com>
Subject: [PATCH 6/6] fanotify: add current_user_instances node
Date:   Tue, 28 Jun 2022 18:14:13 +0800
Message-Id: <20220628101413.10432-1-duguoweisz@gmail.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: duguowei <duguowei@xiaomi.com>

Add a node of sysctl, which is current_user_instances.
It shows current initialized group counts of system.

Signed-off-by: duguowei <duguowei@xiaomi.com>
---
 fs/notify/fanotify/fanotify_user.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
index c2255b440df9..39674fbffc4f 100644
--- a/fs/notify/fanotify/fanotify_user.c
+++ b/fs/notify/fanotify/fanotify_user.c
@@ -51,6 +51,8 @@
 
 /* configurable via /proc/sys/fs/fanotify/ */
 static int fanotify_max_queued_events __read_mostly;
+/* current initialized group count */
+static int fanotify_user_instances __read_mostly;
 
 #ifdef CONFIG_SYSCTL
 
@@ -86,6 +88,14 @@ static struct ctl_table fanotify_table[] = {
 		.proc_handler	= proc_dointvec_minmax,
 		.extra1		= SYSCTL_ZERO
 	},
+	{
+		.procname	= "current_user_instances",
+		.data		= &fanotify_user_instances,
+		.maxlen		= sizeof(int),
+		.mode		= 0444,
+		.proc_handler	= proc_dointvec_minmax,
+		.extra1		= SYSCTL_ZERO
+	},
 	{ }
 };
 
@@ -905,6 +915,8 @@ static int fanotify_release(struct inode *ignored, struct file *file)
 	/* matches the fanotify_init->fsnotify_alloc_group */
 	fsnotify_destroy_group(group);
 
+	fanotify_user_instances--;
+
 	return 0;
 }
 
@@ -1459,6 +1471,8 @@ SYSCALL_DEFINE2(fanotify_init, unsigned int, flags, unsigned int, event_f_flags)
 	if (fd < 0)
 		goto out_destroy_group;
 
+	fanotify_user_instances++;
+
 	return fd;
 
 out_destroy_group:
-- 
2.36.1

