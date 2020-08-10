Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B486F240802
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Aug 2020 16:59:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727813AbgHJO7X (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 10 Aug 2020 10:59:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727088AbgHJO7E (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 10 Aug 2020 10:59:04 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E2A8C061787;
        Mon, 10 Aug 2020 07:59:04 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id d4so5398694pjx.5;
        Mon, 10 Aug 2020 07:59:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SHSkT38oPDjdbo6Pdfg3IfSW8k0GGeohQthylBq7Wn0=;
        b=Vmv4SoRlK/lnjdXh8GMWKAyKi9m2lK4HXA+zWWINhSGp8Y3XQmZ4R3y1ZqW5lybs0y
         Tte/X+X5OmI4N4WUk7ro0Z7+wDelXCVEABSXreridok4vVcIc8ZHKyBOJHip4P4Ct+14
         uQR4qtWymrwj7WYgkUkQ4tDXmPCnBmwrMPHpXeUbsFsJDprGHmr0qvfrhg+VLYBhaqj4
         oL4/CX6tcS+wbwgqC2gT3ro4gWEbUwLWtu3PjSY6FYk361od1lv23yPs3jY166E8KfLZ
         3K862j2OJugJ+y+bI3glgulvjLtRG3wkXdaa798tqSfSUzPRVJey0YUrHqpmkIpUvMkP
         mWcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SHSkT38oPDjdbo6Pdfg3IfSW8k0GGeohQthylBq7Wn0=;
        b=NpC5AmDxZHPGdos5J3SwRD77WAl/V/PT0T3rCTSm56IhjPrXut7pXknHOCaUG0pWnX
         iQ7mIxSv7TIfquH4+9ebjYer17D/lsy5/KBHAhtXD8XpTKouvhpDdTu1Ww4N0T/5YaWL
         1kXEJ+0Mrgkj6YArErRWCX1FmgUCggEuChzUVSjlX2sEXZRuf/DtBKkER8VwUwmt4bI9
         vLqcackx44/hL3JtGOIljsvRJdoAl/PpLxjs04PrgFiY2fVVK58+90K6TNZRSI4DvP5z
         Hw0izWKgYBunCyLBiKZ7qm/0qc3Z6fIwp+VAsr0WZ0F6cNcXJ3Xx1dWqcO+Tj1OliaB5
         JvcA==
X-Gm-Message-State: AOAM531B7sxDJjmtI9oVgzKmJ0nn1QslN3hluiCSaXs3eH1ll0pIhxcY
        0KeP4vJ2v4R8ZuSzFkada+U4uMin5uw=
X-Google-Smtp-Source: ABdhPJwrSqQIv+MnSLjA8lx5FF9Up7X45VlVn660QsB4QWfz9tQ7cK6O/q1alWL7bU4tO54E7t7yBg==
X-Received: by 2002:a17:90a:cc6:: with SMTP id 6mr28424689pjt.2.1597071543924;
        Mon, 10 Aug 2020 07:59:03 -0700 (PDT)
Received: from localhost.localdomain ([124.170.227.101])
        by smtp.gmail.com with ESMTPSA id o192sm25631162pfg.81.2020.08.10.07.59.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2020 07:59:03 -0700 (PDT)
From:   Eugene Lubarsky <elubarsky.linux@gmail.com>
To:     linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, adobriyan@gmail.com,
        avagin@gmail.com, dsahern@gmail.com
Subject: [RFC PATCH 2/5] fs/proc: Introduce /proc/all/statm
Date:   Tue, 11 Aug 2020 00:58:49 +1000
Message-Id: <20200810145852.9330-3-elubarsky.linux@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200810145852.9330-1-elubarsky.linux@gmail.com>
References: <20200810145852.9330-1-elubarsky.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Returns statm lines for all visible processes with prepended PIDs.

Signed-off-by: Eugene Lubarsky <elubarsky.linux@gmail.com>
---
 fs/proc/base.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/fs/proc/base.c b/fs/proc/base.c
index e0f60a1528b7..8396a38ba7d2 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -3884,6 +3884,18 @@ static int proc_all_stat(struct seq_file *m, void *v)
 	return proc_tgid_stat(m, iter->ns, iter->tgid_iter.task->thread_pid, iter->tgid_iter.task);
 }
 
+static int proc_all_statm(struct seq_file *m, void *v)
+{
+	struct all_iter *iter = (struct all_iter *) v;
+	struct pid_namespace *ns = iter->ns;
+	struct task_struct *task = iter->tgid_iter.task;
+	struct pid *pid = task->thread_pid;
+
+	seq_put_decimal_ull(m, "", pid_nr_ns(pid, ns));
+	seq_puts(m, " ");
+	return proc_pid_statm(m, ns, pid, task);
+}
+
 
 #define PROC_ALL_OPS(NAME) static const struct seq_operations proc_all_##NAME##_ops = { \
 	.start	= proc_all_start, \
@@ -3893,6 +3905,7 @@ static int proc_all_stat(struct seq_file *m, void *v)
 }
 
 PROC_ALL_OPS(stat);
+PROC_ALL_OPS(statm);
 
 #define PROC_ALL_CREATE(NAME) \
 	do { \
@@ -3908,4 +3921,5 @@ void __init proc_all_init(void)
 		return;
 
 	PROC_ALL_CREATE(stat);
+	PROC_ALL_CREATE(statm);
 }
-- 
2.25.1

