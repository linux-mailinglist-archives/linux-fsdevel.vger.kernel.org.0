Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18FBC6E1F46
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Apr 2023 11:28:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229828AbjDNJ2S (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 14 Apr 2023 05:28:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbjDNJ2R (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 14 Apr 2023 05:28:17 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE4A41FD0;
        Fri, 14 Apr 2023 02:28:16 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id 98e67ed59e1d1-2466f65d7e0so652381a91.2;
        Fri, 14 Apr 2023 02:28:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681464496; x=1684056496;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GI8ljVnFQxCTzvC6PwuKXwzStCvfNXi/j+9CgA3e+z4=;
        b=XWKgpMwBpP4e4rV7De80aVftxE43Xp5Rd4h9sy4Sw2oYf/TZp34tQT9RH+8kOlB3vh
         X1LxrOriZT+Qas1wlUawqIzO7g1WiiTiK7uJiT+aYSWgE/23X0Q8Bm5qoo8/X0OO71k+
         vycVQln2VJWXuyzHJWdVPt2W39CsSBqRU/p54jGGUFlpz+LYKqZ8vlTcKS6UK+w+AXaY
         7TbNMSnKYWH8+HiWBLABoQYXNsndajUF7KbdwUU+UcUNe0ozpRbs0FRmf/9eqnVgA7I2
         iTCe8iLnhWT1pY9NHsDuW8TVOGyqHJteXU7G9NIhTwusc9w5Elr0XMWbWU5HUEkdxbFk
         vREA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681464496; x=1684056496;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GI8ljVnFQxCTzvC6PwuKXwzStCvfNXi/j+9CgA3e+z4=;
        b=NDPdvbK7vy5g7u6yMpMmQN8vapo8xVM4FMvJDijxnlEaXrG10LGs3OAfB/381Al1+R
         iv0qbWU8X06WKVPLy8UQfhAltgIh5VZYzNT0IQdvvQsQDWCp4Qcka7S5VIKQ6ktPEP8M
         bha7rrYbG+LVqTt8xfcHn+OmOzD9AwlI4KBHt3dkHMgXyNX8ynuslknX2qNkrIiQpgLc
         ILUT/YQAYj1CMAe4DUIcoAHzA9X1rXg/3QF7Fi6yhWZgJ7TrOFLZg4MbKli2vBg9G0jw
         xS0aupzuXY2xkYSDWmF9RoI1OLujtWc6jzmjTESouyktzpx+VPuXXmh5wrHF6RuxdbGj
         tFvg==
X-Gm-Message-State: AAQBX9cQcxGsdXHT1cNuP+5m/zpBNX0wjm5u54Fq2VqLcpKHwjpkd3Fv
        3kAmG74QhkALeGBvQozZEWI=
X-Google-Smtp-Source: AKy350a11amOU/Bch8+mREEBNYLu7C1s7xG2cdcCGI0WLltc8QfbW+ba19Csw8vRTmHtZDIMaRKS0g==
X-Received: by 2002:a05:6a00:1401:b0:63a:b035:8bf2 with SMTP id l1-20020a056a00140100b0063ab0358bf2mr7972282pfu.4.1681464496177;
        Fri, 14 Apr 2023 02:28:16 -0700 (PDT)
Received: from localhost.localdomain ([45.137.97.138])
        by smtp.gmail.com with ESMTPSA id p7-20020a170903248700b001a68d45e52dsm2250708plw.249.2023.04.14.02.28.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Apr 2023 02:28:15 -0700 (PDT)
From:   Chunguang Wu <fullspring2018@gmail.com>
To:     akpm@linux-foundation.org
Cc:     adobriyan@gmail.com, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH] fs/proc: add Kthread flag to /proc/$pid/status
Date:   Fri, 14 Apr 2023 17:27:51 +0800
Message-Id: <20230414092751.10636-1-fullspring2018@gmail.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The command `ps -ef ` and `top -c` mark kernel thread by '['
and ']', but sometimes the result is not correct.
The task->flags in /proc/$pid/stat is good, but we need remember
the value of PF_KTHREAD is 0x00200000 and convert dec to hex.
If we have no binary program and shell script which read
/proc/$pid/stat, we can know it directly by
`cat /proc/$pid/status`.

Signed-off-by: Chunguang Wu <fullspring2018@gmail.com>
---
 fs/proc/array.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/fs/proc/array.c b/fs/proc/array.c
index 9b0315d34c58..fde6a0b92728 100644
--- a/fs/proc/array.c
+++ b/fs/proc/array.c
@@ -434,6 +434,13 @@ int proc_pid_status(struct seq_file *m, struct pid_namespace *ns,
 
 	task_state(m, ns, pid, task);
 
+	seq_puts(m, "Kthread:\t");
+	if (task->flags & PF_KTHREAD) {
+		seq_puts(m, "1\n");
+	} else {
+		seq_puts(m, "0\n");
+	}
+
 	if (mm) {
 		task_mem(m, mm);
 		task_core_dumping(m, task);
-- 
2.39.1

