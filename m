Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 183FA479EDF
	for <lists+linux-fsdevel@lfdr.de>; Sun, 19 Dec 2021 03:44:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229727AbhLSCoL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 18 Dec 2021 21:44:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229720AbhLSCoL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 18 Dec 2021 21:44:11 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68E27C061574
        for <linux-fsdevel@vger.kernel.org>; Sat, 18 Dec 2021 18:44:11 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id w24so5199331ply.12
        for <linux-fsdevel@vger.kernel.org>; Sat, 18 Dec 2021 18:44:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+/WmQ/iRXlvfFQfyUxv672lLQSIAmQe/JfLFwckBMM8=;
        b=VrtCE048LD8DRTjNSOBoqXx5EQ81QV4t0Eu/JTofGG4c2UqCNGWgNI8jsDnHev5LXS
         wKsI8Ts0wtL0Zm6v+lLYu9IgyCxOY8wj1M/tVC7ZptbN4AxUvXLc2YegdfDMKnnoKZTY
         J6IMJqkGn31opL38WeuuFt10071KkRgMgg/2mgcZGcYzIuWX/zzFscX9RKvfqF8T5h1T
         U3MHgUjS+B7yTy2lO5SjzV8ub/cqJ21kEKunSxx14IXWl2tgKwbEuI5V7uWbfFoklp6Z
         1nNf4/9dUpVXWtJNTL02ABAkkrav7s+1SOIu3/wJimbtSNz9d5TEoV6BKl+GQe0dDEVg
         SnQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+/WmQ/iRXlvfFQfyUxv672lLQSIAmQe/JfLFwckBMM8=;
        b=V1oU+J/Lcqu6r/fRiC0BwDK8ggjGNVgCPKn9diamEWp2Ea+8ol+whPsaoM59VdIYc4
         Jc8g3bbRejjf3ISsHQ9HkS+W1YmNnQNpZZvqFZFhaaL7upid2vZeULC4R6jdesxrb8PW
         7bhUbUPVttofW40oIleWdfiiwSSr5JQ0yhOP7AQyfdwl21RbmkQBeFYc/jtTwsjEou+e
         /5LH8pNSFYyQoTs7SdC9pbgwKCYHWHQKK32DmKcM76h38cIFSCXHUaMkf7GbvCWmG2oX
         sBYIepS+/oTiGZLy21oSjrYcUZ4yNGaGNvk0umNF/Ykn/GHrQhJMk0zo1/YOWcuutYQf
         rSXA==
X-Gm-Message-State: AOAM533nByK0/lIUR9+g2TEWS7Wh+vzG4xfW+bxp9KuD0jUIPzrTY/9e
        0xQKZDLzjRKDz+A2SQmB7mBCFn4OL9/Geg==
X-Google-Smtp-Source: ABdhPJwmN/h8U1PBybZ9renDYxDqdOjoXnQkkwYOWAOKQVq0lOmzH6l62LgHVRjG6sALKJM+o4/8Wg==
X-Received: by 2002:a17:903:2348:b0:141:d60b:ee90 with SMTP id c8-20020a170903234800b00141d60bee90mr9980528plh.15.1639881850944;
        Sat, 18 Dec 2021 18:44:10 -0800 (PST)
Received: from localhost.localdomain ([139.177.225.247])
        by smtp.gmail.com with ESMTPSA id s16sm13854211pfu.109.2021.12.18.18.44.08
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 18 Dec 2021 18:44:10 -0800 (PST)
From:   Qi Zheng <zhengqi.arch@bytedance.com>
To:     akpm@linux-foundation.org, keescook@chromium.org
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Qi Zheng <zhengqi.arch@bytedance.com>
Subject: [PATCH] proc: convert the return type of proc_fd_access_allowed() to be boolean
Date:   Sun, 19 Dec 2021 10:44:04 +0800
Message-Id: <20211219024404.29779-1-zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Convert return type of proc_fd_access_allowed() and the 'allowed' in it
to be boolean since the return type of ptrace_may_access() is boolean.

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
---
 fs/proc/base.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/proc/base.c b/fs/proc/base.c
index 13eda8de2998..d654ce7150fd 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -670,10 +670,10 @@ static int proc_pid_syscall(struct seq_file *m, struct pid_namespace *ns,
 /************************************************************************/
 
 /* permission checks */
-static int proc_fd_access_allowed(struct inode *inode)
+static bool proc_fd_access_allowed(struct inode *inode)
 {
 	struct task_struct *task;
-	int allowed = 0;
+	bool allowed = false;
 	/* Allow access to a task's file descriptors if it is us or we
 	 * may use ptrace attach to the process and find out that
 	 * information.
-- 
2.11.0

