Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F13766E2FB6
	for <lists+linux-fsdevel@lfdr.de>; Sat, 15 Apr 2023 10:22:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229894AbjDOIWQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 15 Apr 2023 04:22:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229890AbjDOIWO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 15 Apr 2023 04:22:14 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 301641BD9;
        Sat, 15 Apr 2023 01:22:11 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id lh8so7681254plb.1;
        Sat, 15 Apr 2023 01:22:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681546929; x=1684138929;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LrPwCHRKxX/7nUZU7PZjWjkHnyylgUC+HfUtdJ+I1OA=;
        b=GmKn0pkY+y4gxAFJO8QRU2AssljFiRnHqLbkDjlQryQjgHRs366l0iqZE/+Zn1xOiO
         WMkMnGDGN/dBIl6JfbefvxQeSkopMI5qtPC+rUt8UUk5z9/uITEsnkLIuD1PXyafC49r
         /TsdyblUhi3ga8bQ/f+KY0E3wdCjEcmfk4VVSmj1yZUxW/OwWkysjXaL0lDypcsr1nJX
         IH13ea1VH48ogvDimphguAOBOlAEnGM7kL5o82hA4NQsPohtQ2QeMR2bB7H5P0Y59wmr
         NDzPPao+zgs2klPtDhmS1PKpFH9s0oTDB2U2FKcChNkF76hQfSlTpx8+/C1lDW16lb3j
         OhkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681546929; x=1684138929;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LrPwCHRKxX/7nUZU7PZjWjkHnyylgUC+HfUtdJ+I1OA=;
        b=G7VYTXM9rnqxNB1vGWHtqP805RWTE9xWJHxafLcWdtOkhfvwFFbBEkilbsVfkqlGxo
         tTMP340K53uGFpUWeHbrvQeAZQtx5zOp7/gFHWvP6nU4vVrUEVqGKVgllFA0SN2ObftL
         OfcDR8tmc7fgjqclzBzMZR94uH9BQr6rCEV7crGI0nb1jz7CXfjhojddD2ooxmjC6iXZ
         xOzgdbOqGl6MxIiU4fZnCVJWPpNRe53k/zZ17/FHRBdm/fVAv3txO1IkC6DI3iUHqEUB
         3xpfeF8S0iorJfOm+5yQ7RW3ZM2tbG5EO1TK8I6nEml6PrshqANNCps+56n+/PiM8pOo
         WzfA==
X-Gm-Message-State: AAQBX9fWwkzKbQ7g/BxOTUACSgIONhdv9ZwGAEkknnw4OZX9dXkxOicQ
        jlTD8w4oTOUWrwFjEwttiNfvL3PPpGD6mbBu4Fc=
X-Google-Smtp-Source: AKy350YSz3vwB7wQXR4+sawo+URv8oaIToE1pI7vWvAkQXm3mUilnjYEnWDANYbg0bnktUmq3bF3xA==
X-Received: by 2002:a17:902:ce81:b0:19a:b754:4053 with SMTP id f1-20020a170902ce8100b0019ab7544053mr7225719plg.26.1681546929572;
        Sat, 15 Apr 2023 01:22:09 -0700 (PDT)
Received: from localhost.localdomain ([45.137.97.138])
        by smtp.gmail.com with ESMTPSA id jj14-20020a170903048e00b001a52c38350fsm762169plb.169.2023.04.15.01.22.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Apr 2023 01:22:09 -0700 (PDT)
From:   Chunguang Wu <fullspring2018@gmail.com>
To:     akpm@linux-foundation.org, corbet@lwn.net
Cc:     adobriyan@gmail.com, rdunlap@infradead.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: [PATCH] fs/proc: add Kthread flag to /proc/$pid/status
Date:   Sat, 15 Apr 2023 16:21:55 +0800
Message-Id: <20230415082155.5298-1-fullspring2018@gmail.com>
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
 Documentation/filesystems/proc.rst | 2 ++
 fs/proc/array.c                    | 7 +++++++
 2 files changed, 9 insertions(+)

diff --git a/Documentation/filesystems/proc.rst b/Documentation/filesystems/proc.rst
index 9d5fd9424e8b..8a563684586c 100644
--- a/Documentation/filesystems/proc.rst
+++ b/Documentation/filesystems/proc.rst
@@ -179,6 +179,7 @@ read the file /proc/PID/status::
   Gid:    100     100     100     100
   FDSize: 256
   Groups: 100 14 16
+  Kthread:    0
   VmPeak:     5004 kB
   VmSize:     5004 kB
   VmLck:         0 kB
@@ -256,6 +257,7 @@ It's slow but very precise.
  NSpid                       descendant namespace process ID hierarchy
  NSpgid                      descendant namespace process group ID hierarchy
  NSsid                       descendant namespace session ID hierarchy
+ Kthread                     kernel thread flag, 1 is yes, 0 is no
  VmPeak                      peak virtual memory size
  VmSize                      total program size
  VmLck                       locked memory size
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

