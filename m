Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04FD36765B0
	for <lists+linux-fsdevel@lfdr.de>; Sat, 21 Jan 2023 11:23:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229752AbjAUKXb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 21 Jan 2023 05:23:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229697AbjAUKXZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 21 Jan 2023 05:23:25 -0500
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5006846D74;
        Sat, 21 Jan 2023 02:23:24 -0800 (PST)
Received: by mail-qt1-x842.google.com with SMTP id h24so2186928qta.12;
        Sat, 21 Jan 2023 02:23:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ACObeGmvp/0Nnei4QCSvOb8xescxKyeceEFZIuDD2Fc=;
        b=MvgOXV4a9b8FFR7E4w2hZdj30Z7Om2ZS7Br9wR9ZecVYL0MBWrr3ZF/16KQF1f6vCZ
         w23Rx/4Tndk44FpOoUlbZBivV1wBCqWpzj+E6/MS/lywaipbEcUncSWuXXkBxfXYvcQy
         r7v2HiJnWour4ErFmxvtX0jggEevVsdIEgesXbK+G/e8eJB6yW72LWAK4TYJPwIweo01
         AY2ShvdvDwyeJV+MbTk2zYJ+zTX2gEN3hXiM51a3D6E/yNUJxrBcrWWDcPUxdqxDC/HH
         r/sUIuu/8QJd1A2tDXOoq3ml6CWvY68DWhbDmB3WEUEA/gaPJWgHpy33kWGxCktu7VAw
         VWkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ACObeGmvp/0Nnei4QCSvOb8xescxKyeceEFZIuDD2Fc=;
        b=cIh6Zb/FQyK+2yq7G9o37q7iGzBpPlIe8sVe7Gb5qVJUOSMbIBL9l0Pqz/la7+Bgh8
         17ZMO5f+h02L/snYb8EkaggbelbTHwFNnG7gHrAMyi6yfmJj3W0W09EgZaFCw/WRdXNn
         j4VGEkKS5aJMKxeQfbV6U2SXBsk1pw04Gl6ncQ5mTjqk3zUBuj1BIoMGCvv3y/SuY8UP
         zU3RjbKoX277Bp9ODTZO8dn2j0gypqRn4ilhKa4NAzTeXSPsxACVzSs6nOs1DCOeHj8Q
         Q4c0oYAb5+Dp4mJSJ0P5fxIIXzOr7KXsanAf1f+0dS32Bv0Z6P5SJEmLrmUGGt7LXs2D
         8ZQg==
X-Gm-Message-State: AFqh2kqzRhdmixUTEqexrCuWq5d4S9S0chRPFQrKEeTxjs1rxQK9hIl2
        foV1XoecOakw/P1CqcQHfsU+vDWzYsLm
X-Google-Smtp-Source: AMrXdXsGXw83Ni91md2ApeibRl6pO81Y36UffPwEt335DPhivm/9X3h+XjnIgYI9k5wTzoGnIXhlXw==
X-Received: by 2002:a05:622a:22a5:b0:3b4:a6ac:770c with SMTP id ay37-20020a05622a22a500b003b4a6ac770cmr25548530qtb.45.1674296603337;
        Sat, 21 Jan 2023 02:23:23 -0800 (PST)
Received: from fedora.mshome.net (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id y2-20020a05620a44c200b006e42a8e9f9bsm14128630qkp.121.2023.01.21.02.23.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Jan 2023 02:23:23 -0800 (PST)
From:   Gregory Price <gourry.memverge@gmail.com>
X-Google-Original-From: Gregory Price <gregory.price@memverge.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kselftest@vger.kernel.org, krisman@collabora.com,
        tglx@linutronix.de, luto@kernel.org, oleg@redhat.com,
        peterz@infradead.org, ebiederm@xmission.com,
        akpm@linux-foundation.org, adobriyan@gmail.com, corbet@lwn.net,
        shuah@kernel.org, Gregory Price <gregory.price@memverge.com>
Subject: [PATCH v4 2/3] fs/proc/array: Add Syscall User Dispatch to proc status
Date:   Sat, 21 Jan 2023 05:23:15 -0500
Message-Id: <20230121102316.331935-3-gregory.price@memverge.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230121102316.331935-1-gregory.price@memverge.com>
References: <20230121102316.331935-1-gregory.price@memverge.com>
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

Report the value of test_syscall_work(SYSCALL_USER_DISPATCH)) in
proc/status.

This provides an indicator to userland checkpoint/resume software that
it must manage special signal conditions (similar to SECCOMP)

Signed-off-by: Gregory Price <gregory.price@memverge.com>
---
 fs/proc/array.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/fs/proc/array.c b/fs/proc/array.c
index 49283b8103c7..2275ac153c4c 100644
--- a/fs/proc/array.c
+++ b/fs/proc/array.c
@@ -428,6 +428,13 @@ static inline void task_thp_status(struct seq_file *m, struct mm_struct *mm)
 	seq_printf(m, "THP_enabled:\t%d\n", thp_enabled);
 }
 
+static inline void task_syscall_user_dispatch(struct seq_file *m,
+						struct task_struct *p)
+{
+	seq_put_decimal_ull(m, "\nSyscall_user_dispatch:\t",
+			    test_syscall_work(SYSCALL_USER_DISPATCH));
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
2.39.0

