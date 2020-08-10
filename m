Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 307F4240805
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Aug 2020 16:59:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727805AbgHJO7X (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 10 Aug 2020 10:59:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727101AbgHJO7I (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 10 Aug 2020 10:59:08 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B082C061788;
        Mon, 10 Aug 2020 07:59:07 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id k18so5514467pfp.7;
        Mon, 10 Aug 2020 07:59:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ruYvdMbii/j+x/dI93qL4vRoOYrodwnZ58dBT1YxKkA=;
        b=cJ3UAfYaKXqd+FptaPG25kx+DBrRyAu0Sqmzq6OJIz8+8IS8M305kFWhOx1I6DkWNf
         CXXwYKW1sLLSfpwsC1M5LxW4oEWpJx41gZTftnikDGKCUMosWaiO05YOtmj9MSwzNRUO
         wHeV+ZTrhiMnccHB33z64NoUjCiTBeCu0fOzA0OkVWn0WmdH6ZxyyehUqKJROiv94K6V
         o5YuSvEmSkDT2EyUQWkzrjIXnmgk325IRGa8L5vRPox/hXVM2+leHjLhSQaVIg0XTKXM
         qDCkz54n9HTGxceS+j9qXnPyBJpicBk1M7U4TgVbfrjY7mrEiGQF4keJNymHL3WA+Xy6
         Rkzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ruYvdMbii/j+x/dI93qL4vRoOYrodwnZ58dBT1YxKkA=;
        b=WP6i4cXlIdaNu6lzfELPhpsmwlKzq/7nfUc5C4DoDnZeJ3p6CfMVWCdd13JCRhWaME
         +vPmET6wHVO/79KLtpJT2jHPnc9SSlwnhvjYQ47uz6gHJeQylDD7SJE/ccVJytjKeLg2
         DLgu5JhDFfdJQXxmF2nXOmFTj7dxxiPUC9Q78RU66m5g0QxcoLCpP9JRdopnJePlyLuz
         RL0szh8EoMoBCzSIDAzY4ePDL8iDcxIKu9trSc00wO/CRxrMa+JWije93ZHje73VBoAX
         TMLPjxMs7rSxZK7eN9kroJLqAZ/NGKKJt6K15/Vxor8XTrqqRSoNPBlJExHnM9m4D9fK
         sHSg==
X-Gm-Message-State: AOAM533IZ+LBUzF7P2f/QcXKXRDzvJjd7pRye3LQOaQB59yXnGpBdbSd
        vclJjYF4QVqh+SIwVOuTokuxVa+3vJY=
X-Google-Smtp-Source: ABdhPJyAiyduaFWuMI4o7atq0s7beFzvjvIYhQjIPealynagFxitSnbspx6TAdkgHACm4o162xVvhQ==
X-Received: by 2002:a63:ef46:: with SMTP id c6mr8975962pgk.96.1597071546830;
        Mon, 10 Aug 2020 07:59:06 -0700 (PDT)
Received: from localhost.localdomain ([124.170.227.101])
        by smtp.gmail.com with ESMTPSA id o192sm25631162pfg.81.2020.08.10.07.59.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2020 07:59:06 -0700 (PDT)
From:   Eugene Lubarsky <elubarsky.linux@gmail.com>
To:     linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, adobriyan@gmail.com,
        avagin@gmail.com, dsahern@gmail.com
Subject: [RFC PATCH 3/5] fs/proc: Introduce /proc/all/status
Date:   Tue, 11 Aug 2020 00:58:50 +1000
Message-Id: <20200810145852.9330-4-elubarsky.linux@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200810145852.9330-1-elubarsky.linux@gmail.com>
References: <20200810145852.9330-1-elubarsky.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Returns status lines for all visible processes in the existing format.

Signed-off-by: Eugene Lubarsky <elubarsky.linux@gmail.com>
---
 fs/proc/base.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/fs/proc/base.c b/fs/proc/base.c
index 8396a38ba7d2..5982fd43dd21 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -3897,6 +3897,14 @@ static int proc_all_statm(struct seq_file *m, void *v)
 }
 
 
+
+static int proc_all_status(struct seq_file *m, void *v)
+{
+	struct all_iter *iter = (struct all_iter *) v;
+
+	return proc_pid_status(m, iter->ns, iter->tgid_iter.task->thread_pid, iter->tgid_iter.task);
+}
+
 #define PROC_ALL_OPS(NAME) static const struct seq_operations proc_all_##NAME##_ops = { \
 	.start	= proc_all_start, \
 	.next	= proc_all_next, \
@@ -3906,6 +3914,7 @@ static int proc_all_statm(struct seq_file *m, void *v)
 
 PROC_ALL_OPS(stat);
 PROC_ALL_OPS(statm);
+PROC_ALL_OPS(status);
 
 #define PROC_ALL_CREATE(NAME) \
 	do { \
@@ -3922,4 +3931,5 @@ void __init proc_all_init(void)
 
 	PROC_ALL_CREATE(stat);
 	PROC_ALL_CREATE(statm);
+	PROC_ALL_CREATE(status);
 }
-- 
2.25.1

