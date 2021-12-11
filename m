Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADB81471230
	for <lists+linux-fsdevel@lfdr.de>; Sat, 11 Dec 2021 07:40:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229607AbhLKGkK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 11 Dec 2021 01:40:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbhLKGkF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 11 Dec 2021 01:40:05 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7EA1C061714;
        Fri, 10 Dec 2021 22:40:04 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id v23so8298700pjr.5;
        Fri, 10 Dec 2021 22:40:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/I2CQOSPxPl3e4Yr2uDBAw9mvwLM+fXKuKYxA0ZrAYc=;
        b=VIOouOyVNGP8AMS7vH25R7ezTHIuVaLkOsH1g8p5QlmHTgcBJDKschh6e69WqeS5lg
         1A+26/jKzb+DENoLnSfK/GkVY1ny5DfT8VcQfNhTXBj4n4Cx+tkzLOViWV04Zl2FZ+gY
         i56ke3Yog79crQ2m03IiInSJjf2DqTjTz/HO5dOHu33LzJmYCpsT02C2SeZRj5TBaQVQ
         y9aV+JJA33lbAA/0CqRqIdEnKMNrPSWeav3knE0MLSq6ln2gbFu7jRxL149TNAmm4X7Y
         ELabuPWamLYFojIGKpiAYr0Ef/CKj3V2RsEs/lJplEihtkM9YuMLB1w23mGqB7ZjcIfl
         SEKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/I2CQOSPxPl3e4Yr2uDBAw9mvwLM+fXKuKYxA0ZrAYc=;
        b=DtYsJeUeLLueZxJAZlA9mpxvszZP9+UajFhmCcTYAh4pLfhjPF5GDPpErkzNNkhFoW
         GMdfEkp5A3y/iasOa7LYkERKOOSgIkkKd7bTBjXk1MTvVnwiK/8zrsOcA9gD6Ob9LHa2
         C99GyAxCzAkbek0MTHD6e0iAlR9kPuKR+iSpeoiY+AVAlduncjbT1eqqwb7zlIASreY7
         jt4SOnJSN6MGbHb2SfDVbUcGLG8AIQH3/oesKP6J3MAYvmABC/4TzDdq9O0WlWM2lCcr
         A1QqNHFHnvpL/xm6eDrZt1C/8/k3E90q4zuooytxleHEkFJfKX9AkTQYSbwFjip7XVgv
         1KxA==
X-Gm-Message-State: AOAM5336zj7vVoEjQ2M0S1MXF5xElVE304eorVSw7yGdN22D3GM+zm5w
        PyrvMEOmqqwxtzDb4iqtoX8=
X-Google-Smtp-Source: ABdhPJwawVgqpJxNH0/hvqcqPlFrrhcBZidD0MqAaYCGD9tZ+aPQrl2q+kL/z2lm1d9TKwQ7RMOMaQ==
X-Received: by 2002:a17:903:11c4:b0:141:da55:6158 with SMTP id q4-20020a17090311c400b00141da556158mr81495925plh.7.1639204804265;
        Fri, 10 Dec 2021 22:40:04 -0800 (PST)
Received: from vultr.guest ([45.76.74.237])
        by smtp.gmail.com with ESMTPSA id mr2sm869638pjb.25.2021.12.10.22.40.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Dec 2021 22:40:03 -0800 (PST)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     akpm@linux-foundation.org, rostedt@goodmis.org,
        keescook@chromium.org, pmladek@suse.com, david@redhat.com,
        arnaldo.melo@gmail.com, andrii.nakryiko@gmail.com,
        alexei.starovoitov@gmail.com
Cc:     linux-mm@kvack.org, bpf@vger.kernel.org,
        linux-perf-users@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Yafang Shao <laoar.shao@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Michal Miroslaw <mirq-linux@rere.qmqm.pl>,
        Peter Zijlstra <peterz@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH -mm v2 2/3] cn_proc: replaced old hard-coded 16 with TASK_COMM_LEN_16
Date:   Sat, 11 Dec 2021 06:39:48 +0000
Message-Id: <20211211063949.49533-3-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20211211063949.49533-1-laoar.shao@gmail.com>
References: <20211211063949.49533-1-laoar.shao@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This TASK_COMM_LEN_16 has the same meaning with the macro defined in
linux/sched.h, but we can't include linux/sched.h in a UAPI header, so
we should specifically define it in the cn_proc.h.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Michal Miroslaw <mirq-linux@rere.qmqm.pl>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: David Hildenbrand <david@redhat.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Kees Cook <keescook@chromium.org>
Cc: Petr Mladek <pmladek@suse.com>
---
 include/uapi/linux/cn_proc.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/uapi/linux/cn_proc.h b/include/uapi/linux/cn_proc.h
index db210625cee8..6dcccaed383f 100644
--- a/include/uapi/linux/cn_proc.h
+++ b/include/uapi/linux/cn_proc.h
@@ -21,6 +21,8 @@
 
 #include <linux/types.h>
 
+#define TASK_COMM_LEN_16 16
+
 /*
  * Userspace sends this enum to register with the kernel that it is listening
  * for events on the connector.
@@ -110,7 +112,7 @@ struct proc_event {
 		struct comm_proc_event {
 			__kernel_pid_t process_pid;
 			__kernel_pid_t process_tgid;
-			char           comm[16];
+			char           comm[TASK_COMM_LEN_16];
 		} comm;
 
 		struct coredump_proc_event {
-- 
2.17.1

