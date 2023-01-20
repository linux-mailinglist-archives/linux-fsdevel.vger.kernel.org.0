Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBB656757AF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Jan 2023 15:45:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231151AbjATOpT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 20 Jan 2023 09:45:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231165AbjATOpQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 20 Jan 2023 09:45:16 -0500
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94510D0DB6;
        Fri, 20 Jan 2023 06:44:48 -0800 (PST)
Received: by mail-il1-x142.google.com with SMTP id f8so2795954ilj.5;
        Fri, 20 Jan 2023 06:44:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fqgqlvxl2/AjHmd8bF7KdCJg7y96KUb9pTAZ52R5/2g=;
        b=LnkI5KpNCjol1eJRa1CeU/Ka3N1fJp1SFPwR8vNOaRqLIo56jlYqGRYpXaJlDi6Pzb
         f4dI/Qped/yuiW1YvWStBpb75NDAk1VgKzY4hjv0r3WIC/rHd6ZtILpTweCNIOehdyvx
         BiKQ3i5u2IZSxuhgB8IIkEvtgetqRSmNS5kB6nWjG+gfnvfJAVRkly/EZzT1EU3vkxET
         C9bYRZBG6kbkHa9GW0YR3bt1m2UpCOZV8eKICKy+3EAlZWwZ0MK9tM66c5dVcFQs6urC
         zYpA6AM94BfeJczIHlnlHVY/XYUpi5S63DzgQmwdmvYgn44khT4MjnjzmCqif8z+LPan
         1rpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fqgqlvxl2/AjHmd8bF7KdCJg7y96KUb9pTAZ52R5/2g=;
        b=2uUkoyQ8Gi3oEAPJWTQVrma4CTTIes3uEwBMTs6f27ih8+Ds5eWFA+P2dBwZm18xUb
         5n+q573IxaP9tVurxu8xclgykb8tD/UeyXWBUur/GAXhR8VCy3i+4VLPqmVDR/OLLFqQ
         5azKxMAyAMS+wqe9ZxiMyq5DF0Pqaqtz8YpbPKH2Jx76eOyVX97a+DjASW98993dvdDG
         jbsHLrH0cAnPHvTvEroAhAQTrkwJOgVvMPr1/LjFzFgQYnacqlQrgypZVKCz5GRvFiJC
         23AbGSv1GQnU060ZkY3NC24Tf5R5RSQbCvtykNIl9cL6lXMDSIyXWMs+Kb8fmTpDArGF
         qrgA==
X-Gm-Message-State: AFqh2kqS6ChHMQzMGH2VMZVc1483YyvBfWPbPbtDe1X4v1KQMTdLSLGe
        lGZBodfsJP8b0br/vaxDa+dlJqEOR/ZK
X-Google-Smtp-Source: AMrXdXt3Yz1hmgZ+mVPQhzOA/jtz7/t+tye693usGwvJflFkDLvhnjzE+eu0rz2Jn2Tc4fSgi9TATQ==
X-Received: by 2002:a92:da43:0:b0:30e:f171:660f with SMTP id p3-20020a92da43000000b0030ef171660fmr11011884ilq.31.1674225855361;
        Fri, 20 Jan 2023 06:44:15 -0800 (PST)
Received: from fedora.mshome.net ([104.184.156.161])
        by smtp.gmail.com with ESMTPSA id p185-20020a0229c2000000b003a7c47efde0sm1513852jap.11.2023.01.20.06.44.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jan 2023 06:44:14 -0800 (PST)
From:   Gregory Price <gourry.memverge@gmail.com>
X-Google-Original-From: Gregory Price <gregory.price@memverge.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kselftest@vger.kernel.org, krisman@collabora.com,
        tglx@linutronix.de, luto@kernel.org, oleg@redhat.com,
        peterz@infradead.org, ebiederm@xmission.com,
        akpm@linux-foundation.org, adobriyan@gmail.com, corbet@lwn.net,
        shuah@kernel.org, Gregory Price <gregory.price@memverge.com>
Subject: [PATCH v3 2/3] fs/proc/array: Add Syscall User Dispatch to proc status
Date:   Fri, 20 Jan 2023 09:43:55 -0500
Message-Id: <20230120144356.40717-3-gregory.price@memverge.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230120144356.40717-1-gregory.price@memverge.com>
References: <20230120144356.40717-1-gregory.price@memverge.com>
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
it much manage special signal conditions (similar to SECCOMP)

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
2.39.0

