Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9AB8677456
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jan 2023 04:29:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230368AbjAWD3u (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 22 Jan 2023 22:29:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230259AbjAWD3t (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 22 Jan 2023 22:29:49 -0500
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99AB91448C;
        Sun, 22 Jan 2023 19:29:48 -0800 (PST)
Received: by mail-qv1-xf43.google.com with SMTP id h10so8255889qvq.7;
        Sun, 22 Jan 2023 19:29:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KtHmWIx6vulvHYGAYeWjtOeo6VWNy9zzuy5Mzq72830=;
        b=PZQBT6bC8aW98pEFkJmpao9JeJdKadz3kb+CggprRR9jSRvc/oMoUXNkUPrGkuBYI6
         9dzsbtFAxL69hMA0dK2+riMqSMS5BZe6fuq3BLm6oyJ4C1wROgRidgz+5xG9JS2LbOai
         8YI+Hg36U+GGcW7y8NGqaQZ61YolfG056HSVh5VsnBRZc6UDJOcnA1KqAXTo4FiIGUMG
         YWMu0JG/zRBH0fVXXUfWcSC+4cBCqthoEULK5jMVSdoOiXzxFIlFv4tuF5QmKyDz5XZX
         KC9pAf3I/nZc0buiABx2tXiBcHd8mucMBJbXQ72snu3tZR5h6iFy7r3KyNca8Rf1soyZ
         CY2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KtHmWIx6vulvHYGAYeWjtOeo6VWNy9zzuy5Mzq72830=;
        b=fVvn3MO27+DhHeJpa2Pv7GYpH9ZGJrkxHdGxp1UAUkZoBSvbAcZ3g7G6eVnGQChCyC
         OCEhr7uPNizXCw+Q2+hFmFtSc45i3g2B2Y3t/RN07cK+26oGMU5qPdweTK/4PVBTRatx
         tAw65eNfIjJbkY7CF8JfuQzdYtkxkhBwhyGSo/MtnH8/i1VaRYp7FkKztIeDsY19FqxK
         dPYUJZgn4PnUE99nFFEoiYxavilOxBO4JcDcY5XKA6R5oE9HZ1oaKnWsX3U0U+ZL8UDt
         XJXJa3UE6NbLGWoRRnkIvgvnRcfFdZvV1raKHUla7ofuZ2mYTAjhmvTfDK6L/6ro22LT
         3u8Q==
X-Gm-Message-State: AFqh2kpn0IOJfd8r5ba043AY1QoHruA6EYFtw1lxRX0xS7GbwYpB78yw
        Rtw+Z7AG3PX/NNzkpq0VJ341MnhMKACO
X-Google-Smtp-Source: AMrXdXvec9nTcHOybVyNL6D93K3etzV56PtBd8VTNbTmvvePmf3CI55bNbuMeIRRCtxa46vSVjaIAg==
X-Received: by 2002:a05:6214:5cc6:b0:535:2539:f6f5 with SMTP id lk6-20020a0562145cc600b005352539f6f5mr32375957qvb.19.1674444587670;
        Sun, 22 Jan 2023 19:29:47 -0800 (PST)
Received: from fedora.mshome.net (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id u3-20020ae9c003000000b0070928ee3933sm4875492qkk.75.2023.01.22.19.29.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Jan 2023 19:29:47 -0800 (PST)
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
Date:   Sun, 22 Jan 2023 22:29:41 -0500
Message-Id: <20230123032942.18263-3-gregory.price@memverge.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230123032942.18263-1-gregory.price@memverge.com>
References: <20230123032942.18263-1-gregory.price@memverge.com>
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
proc/status if GENERIC_ENTRY is enabled or the arch has implemented it.

This provides an indicator to userland checkpoint/restore software that
it must manage special signal conditions (similar to SECCOMP)

Signed-off-by: Gregory Price <gregory.price@memverge.com>
---
 fs/proc/array.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/fs/proc/array.c b/fs/proc/array.c
index 49283b8103c7..d4e4ee2409c6 100644
--- a/fs/proc/array.c
+++ b/fs/proc/array.c
@@ -428,6 +428,15 @@ static inline void task_thp_status(struct seq_file *m, struct mm_struct *mm)
 	seq_printf(m, "THP_enabled:\t%d\n", thp_enabled);
 }
 
+static inline void task_syscall_user_dispatch(struct seq_file *m,
+						struct task_struct *p)
+{
+#if defined(CONFIG_GENERIC_ENTRY) || defined(TIF_SYSCALL_USER_DISPATCH)
+	seq_put_decimal_ull(m, "\nSyscall_user_dispatch:\t",
+			    test_task_syscall_work(p, SYSCALL_USER_DISPATCH));
+#endif
+}
+
 int proc_pid_status(struct seq_file *m, struct pid_namespace *ns,
 			struct pid *pid, struct task_struct *task)
 {
@@ -451,6 +460,7 @@ int proc_pid_status(struct seq_file *m, struct pid_namespace *ns,
 	task_cpus_allowed(m, task);
 	cpuset_task_status_allowed(m, task);
 	task_context_switch_counts(m, task);
+	task_syscall_user_dispatch(m, task);
 	return 0;
 }
 
-- 
2.39.0

