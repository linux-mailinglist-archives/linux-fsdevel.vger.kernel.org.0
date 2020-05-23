Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADBAE1DF815
	for <lists+linux-fsdevel@lfdr.de>; Sat, 23 May 2020 17:49:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727006AbgEWPtq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 23 May 2020 11:49:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726650AbgEWPtp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 23 May 2020 11:49:45 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3726C061A0E;
        Sat, 23 May 2020 08:49:45 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id x13so6584657pfn.11;
        Sat, 23 May 2020 08:49:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+mvctUy91IWcg4jckZ10jndkvPR8FzL6g68HcXaaASk=;
        b=bRlClyHRxNVF3xZpJltSKBJ7Rzcbm5VeSCke5DOHrjwJ5zDbWjHMKL66++sGRnoOwk
         Jpj9Di5V6GAa2hZUfNsIr7XNkin081bpYXRA2aRrzHPvgVryPDgwNxzVQyNEw7KdYNJA
         VYYNCvJmNvsYV1c1m1bgYHy7FzrnpUp6NQOzsTpS9yu59rRAP2vFCHMiLJzr8zTbcm0M
         YICByfXtMEcwntE++EdouXW88H194T79aiBh3Zw+hwwyWKuIIPhmn7SwBdzK3aTobokC
         kT9WZJTB4eVBgbV9yWUxklHkP1brXvmFjCwXYcB6jYlnmPGeKHNdnkRqrnmp15g14gTX
         18Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+mvctUy91IWcg4jckZ10jndkvPR8FzL6g68HcXaaASk=;
        b=Q5fLaOs4D3sXf91u5FZqsCQfxliBAR2/Ir6MTooetdRWsZBbt4HWmm0fICx3JhWF10
         gMloyMY9tnYEEr2t+Y7FBMGpW87+m2ihTw7d0/U4uRZWo21hQvGh9twSGW9uwkglmdiz
         CJJ3/kEdHAQm/aWdjPWdG201Q/j/N2bK7kJwseKCo6BqBEbMIaxGKw8RPme51Oax9mxo
         aNIwurS28huqL/v+G8sBu+B2ZUvXA17MptINWyhU2IKbLURUzurLykuoAQq0XMM4fnBP
         Wy/QVj+LTsj7YO8H/x/yLEP12cp90AZsgn1QAgh9HS752DoyqzHOur+Ubw69v3NOJ16n
         pYBg==
X-Gm-Message-State: AOAM533dMfT3aB3TWJl+IWvuEY4nUjzSOE9vTFV04oqZCNXK3cczKZSM
        ijqgGcKkcIGV6WyOmt3KavTlmIdq
X-Google-Smtp-Source: ABdhPJxoqGXntA05cnQEf7f+x9tNJuou5/40kP8RBnL1iU0C/mDW5KfYg1f7OU93wE5apoljukkBUA==
X-Received: by 2002:a63:7d4e:: with SMTP id m14mr19416328pgn.391.1590248985504;
        Sat, 23 May 2020 08:49:45 -0700 (PDT)
Received: from Smcdef-MBP.lan ([103.136.220.68])
        by smtp.gmail.com with ESMTPSA id p19sm8773968pfn.216.2020.05.23.08.49.42
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 23 May 2020 08:49:44 -0700 (PDT)
From:   Kaitao Cheng <pilgrimtao@gmail.com>
To:     adobriyan@gmail.com
Cc:     pilgrimtao@gmail.com, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, songmuchun@bytedance.com
Subject: [PATCH] proc/fd: Remove the initialization of variables in seq_show()
Date:   Sat, 23 May 2020 23:49:31 +0800
Message-Id: <20200523154931.29255-1-pilgrimtao@gmail.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The variables{files, file} will definitely be assigned,
so we don't need to initialize them.

Signed-off-by: Kaitao Cheng <pilgrimtao@gmail.com>
---
 fs/proc/fd.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/proc/fd.c b/fs/proc/fd.c
index 81882a13212d..6f95baf44e37 100644
--- a/fs/proc/fd.c
+++ b/fs/proc/fd.c
@@ -19,9 +19,9 @@
 
 static int seq_show(struct seq_file *m, void *v)
 {
-	struct files_struct *files = NULL;
+	struct files_struct *files;
 	int f_flags = 0, ret = -ENOENT;
-	struct file *file = NULL;
+	struct file *file;
 	struct task_struct *task;
 
 	task = get_proc_task(m->private);
-- 
2.20.1

