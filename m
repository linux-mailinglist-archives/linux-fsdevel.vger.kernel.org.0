Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EC94319945
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Feb 2021 05:45:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229733AbhBLEpl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 11 Feb 2021 23:45:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbhBLEp2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 11 Feb 2021 23:45:28 -0500
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75052C061788
        for <linux-fsdevel@vger.kernel.org>; Thu, 11 Feb 2021 20:44:48 -0800 (PST)
Received: by mail-pg1-x532.google.com with SMTP id o7so5465373pgl.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 11 Feb 2021 20:44:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kOCq94xjVzI4ceYxRuWCABPovXysMtiBjdG9BO6ZZlk=;
        b=YFLT2F+J3RvMBDSiUHuypueB0DK/XGg7G87wgW+rPVjaHKPEEMXI6pHivuc83P91bE
         kMLIh6M0HtmB+EqZNhXx8eoQnJCEoy1eUXnUxMxjpVTr74I6Q4FoQDJQkOySytnwuLdy
         R55uL0VGEYvuO4NVzPP+pMQ1ef5edLP85FnNk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kOCq94xjVzI4ceYxRuWCABPovXysMtiBjdG9BO6ZZlk=;
        b=YdwUtZfmFl9ohAhkLAAILtat330qiLDhGkUJ1bysHSZzUWbh1htLaD3U00oGOSngv6
         ATRr0+j9x0N3zGZLwOduJljeZZicuLORrIsEWCDEWQZGmDsrxv+EnLeDyBt3KVcCDlyw
         uMVOjtARSXjO/DQyIQyigGiJU4MXwt2fQx3M3l5qPZyuLagWLxKbhClwJZrQ2A2bqOOj
         4kYWwUkKGankww1xEUo2Zz0lLaj+jTRWXBki6jUS+66teG2e4/K9MSJ8MghKcLo3RrpS
         oKHnK4pLyZ/5PLAI7CeU+lnNwiJ9+5Ach0mRPjUhYezeaysXOUdPecYpppK0VGRYWAfX
         Xa8A==
X-Gm-Message-State: AOAM531dhA0vMfk8QA+6IGuFQ82VEDioYuRKE2a3yGrDiJFAheShvrbz
        kBq8j7RlWNyom1R7rp98QSSnkw==
X-Google-Smtp-Source: ABdhPJyDqCSgz7B7i5HFEOaYVmF8gpNgKK8UqSgtygiJmq1OSOo2Gge9hjbzPGZv5mCs18fovQKXMg==
X-Received: by 2002:a62:43:0:b029:1cd:2de2:5a24 with SMTP id 64-20020a6200430000b02901cd2de25a24mr1403879pfa.27.1613105088055;
        Thu, 11 Feb 2021 20:44:48 -0800 (PST)
Received: from drinkcat2.tpe.corp.google.com ([2401:fa00:1:b:a453:d6cd:41b9:5925])
        by smtp.gmail.com with ESMTPSA id 25sm7298904pfh.199.2021.02.11.20.44.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Feb 2021 20:44:47 -0800 (PST)
From:   Nicolas Boichat <drinkcat@chromium.org>
To:     "Darrick J . Wong" <djwong@kernel.org>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Ian Lance Taylor <iant@google.com>,
        Luis Lozano <llozano@chromium.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Dave Chinner <david@fromorbit.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Alexey Gladkov <gladkov.alexey@gmail.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/6] proc: Add FS_GENERATED_CONTENT to filesystem flags
Date:   Fri, 12 Feb 2021 12:44:01 +0800
Message-Id: <20210212124354.2.I89f693bbe7011553bfac5fedd88d2fc7398be61b@changeid>
X-Mailer: git-send-email 2.30.0.478.g8a0d178c01-goog
In-Reply-To: <20210212044405.4120619-1-drinkcat@chromium.org>
References: <20210212044405.4120619-1-drinkcat@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

procfs content is generated at runtime.

Signed-off-by: Nicolas Boichat <drinkcat@chromium.org>
---

 fs/proc/root.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/proc/root.c b/fs/proc/root.c
index c7e3b1350ef8..7ed715a0f807 100644
--- a/fs/proc/root.c
+++ b/fs/proc/root.c
@@ -282,7 +282,7 @@ static struct file_system_type proc_fs_type = {
 	.init_fs_context	= proc_init_fs_context,
 	.parameters		= proc_fs_parameters,
 	.kill_sb		= proc_kill_sb,
-	.fs_flags		= FS_USERNS_MOUNT | FS_DISALLOW_NOTIFY_PERM,
+	.fs_flags		= FS_USERNS_MOUNT | FS_DISALLOW_NOTIFY_PERM | FS_GENERATED_CONTENT,
 };
 
 void __init proc_root_init(void)
-- 
2.30.0.478.g8a0d178c01-goog

