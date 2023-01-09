Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68CD4662A36
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Jan 2023 16:39:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233321AbjAIPiY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Jan 2023 10:38:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236468AbjAIPhf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Jan 2023 10:37:35 -0500
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BDD137519;
        Mon,  9 Jan 2023 07:34:13 -0800 (PST)
Received: by mail-qt1-x843.google.com with SMTP id j15so2626560qtv.4;
        Mon, 09 Jan 2023 07:34:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+S7QN2t7RPu5nMtRIP4C7w9Lruz5sccy1rhUaYF8qIk=;
        b=Or1Z24KyFUDjD/nf3geUXj9YFpFJI0aCTDGLMJU2gLZn4QQ/BOKkP+WsDIMgGBybtU
         DeNUGQUbkq5pIMrA06JF8Bidn/WUZn6EYjRHtH3KYzlwECiQR8yFUJajGo+pTXnqYdcr
         XOsMZRely6LkLWnIYst/fcTygqpcPq19IKWT4JHwHTfg1S/GpF/Wiw8tC4IiCJEHYMe2
         nIntroBefDOLbVIQFBBICCdKpYuywyGAYJMvlCa6b/wktmXWuXRe3e4hFCOFf3Vd3RmB
         15uDY93s9rClzE4X22xKB7RETvYje9895Uhixa/K0Nbf9YyMqZkVuUA0z5v0GoDK8XkH
         9aMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+S7QN2t7RPu5nMtRIP4C7w9Lruz5sccy1rhUaYF8qIk=;
        b=R4bxWjDFw/hHxNi6fkiUgzulm9QCjd+sqFQYUwxSSjr6IpEuZDPLBP0wX5ZopvDJS7
         LXlhJYyLjavWkpm7vDbU6vOsWNhpeHUNdMCv+2ksCKN5Qwrt10uscQUfDQvfpyhrJGzE
         w84dthl0YmoCrVFJ152nZ8eRBCFtjC73gQCGDXxgdm0Sggr94TufAfGow7T4lic+yLxS
         FvsKNT0NGuOIgDdtLJUfKkW7H3su/Uua0encHc+cxcVcV/LcoC7lKi+IZ7qZrKtp1Y0C
         RgYqPWKHXEhqWJwvfNS/Cn7JZFucEY6yfp2pDg+n1OYXFLO61UhCzS3pfXSGll/pmK7p
         I8Xg==
X-Gm-Message-State: AFqh2kqlkBe/HaF+Hq5Btv47GXJIpQOizyaMFwFuP9+3HZMl7v1Vr/e7
        B8huWpSMWS1VZ5GjUr4rQw87dC5XIg==
X-Google-Smtp-Source: AMrXdXvYoFuf4O4+qbl9zE23zNJw1H6w61oylZqvFIZI/tVwUmJ5LLRxdwBuZ/JS6ukfnl3GwAV4zA==
X-Received: by 2002:ac8:7409:0:b0:3a9:6b35:e7aa with SMTP id p9-20020ac87409000000b003a96b35e7aamr89946403qtq.51.1673278450601;
        Mon, 09 Jan 2023 07:34:10 -0800 (PST)
Received: from fedora.mshome.net (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id f1-20020ac81341000000b003a6a19ee4f0sm4687236qtj.33.2023.01.09.07.34.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jan 2023 07:34:08 -0800 (PST)
From:   Gregory Price <gourry.memverge@gmail.com>
X-Google-Original-From: Gregory Price <gregory.price@memverge.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kselftest@vger.kernel.org, krisman@collabora.com,
        tglx@linutronix.de, luto@kernel.org, oleg@redhat.com,
        peterz@infradead.org, ebiederm@xmission.com,
        akpm@linux-foundation.org, adobriyan@gmail.com, corbet@lwn.net,
        shuah@kernel.org, Gregory Price <gregory.price@memverge.com>
Subject: [PATCH 2/3] fs/proc/array: Add Syscall User Dispatch to proc status
Date:   Mon,  9 Jan 2023 10:33:47 -0500
Message-Id: <20230109153348.5625-3-gregory.price@memverge.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20230109153348.5625-1-gregory.price@memverge.com>
References: <20230109153348.5625-1-gregory.price@memverge.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

If a dispatch selector has been configured for Syscall User Dispatch,
report Syscall User Dispath as configured in proc/status.

This provides an indicator to userland checkpoint/restart software that
it must manage special signal conditions (similar to SECCOMP)

Signed-off-by: Gregory Price <gregory.price@memverge.com>
---
 fs/proc/array.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/fs/proc/array.c b/fs/proc/array.c
index 49283b8103c7..c85cdb4c137c 100644
--- a/fs/proc/array.c
+++ b/fs/proc/array.c
@@ -428,6 +428,13 @@ static inline void task_thp_status(struct seq_file *m, struct mm_struct *mm)
 	seq_printf(m, "THP_enabled:\t%d\n", thp_enabled);
 }
 
+static inline void task_syscall_user_dispatch(struct seq_file *m,
+						struct task_struct *p)
+{
+	seq_put_decimal_ull(m, "\nSyscall_user_dispatch:\t",
+			    (p->syscall_dispatch.selector != NULL));
+}
+
 int proc_pid_status(struct seq_file *m, struct pid_namespace *ns,
 			struct pid *pid, struct task_struct *task)
 {
@@ -451,6 +458,7 @@ int proc_pid_status(struct seq_file *m, struct pid_namespace *ns,
 	task_cpus_allowed(m, task);
 	cpuset_task_status_allowed(m, task);
 	task_context_switch_counts(m, task);
+	task_syscall_user_dispatch(m, task);
 	return 0;
 }
 
-- 
2.37.3

