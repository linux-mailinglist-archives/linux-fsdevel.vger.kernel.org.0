Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C357B4683CC
	for <lists+linux-fsdevel@lfdr.de>; Sat,  4 Dec 2021 10:53:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384562AbhLDJ4i (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 4 Dec 2021 04:56:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384546AbhLDJ4f (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 4 Dec 2021 04:56:35 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2F85C061751;
        Sat,  4 Dec 2021 01:53:09 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id w33-20020a17090a6ba400b001a722a06212so6643676pjj.0;
        Sat, 04 Dec 2021 01:53:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=y/3OH0dv1UtiAFVROi6oJBNv875tsxlRHeEufUcGAE8=;
        b=SarWfOANlxY+W1wqzZLUdID9Fc3MKFpV03tydsm+v0n8XUl+dcwUDrvIiMoajZcN/8
         VygHDL+xUCD/1rvmo4SnyP2WVPTJltzUxeDFRhWIJHSlIvbTENzg7A49yvMRspqt5kk8
         GWVUqC9U/qbUiBA4LeT7O45VG2yDScE5EQzmMgDgJMB5jqBMFmaal7UuUJ8u5dmPdTGJ
         83XteKkH/SE6b6jtPaiEtlYD5dVEae4/oo0qaR3E0V++A3XlLVER+QRX6/53iexk+IaZ
         enzhxKb+F6Nw1Uik2BMvUPFslykGrZv3WzczdX1dvZ252t/S6+BIi0RphSKjA3DDhb8S
         sXlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=y/3OH0dv1UtiAFVROi6oJBNv875tsxlRHeEufUcGAE8=;
        b=bCinzKASWFp4yi3giURS1s6tv4PQvvnOYlAq+bkMap6jbQLVFzPMa+LYaEs1RTS6n3
         MJGH0vqw9aVudU1FCKOXjDgSiSwqXYZbVErpEJJ6kW29knobpe+vwlE/qy4xmOKkV/7G
         jl8qwOJp4w4gwxGTUVXR/dFJ69pixxwvnbop66ujQ6KrcjFLBRBwyVHiUOfduyl/pV2N
         KFP7kenr5qNb+UWJJbGKirFMfcIpPxUpo887dePNOyjWsxwKmgOkh8vRFLi89EYJ+XcW
         BhTAqSruA1ai07MBv0EVzEs2R8HOP6rsJMRHOO9xAuKgUlIbbUMpmHzimcQdXs5CStJj
         S7hw==
X-Gm-Message-State: AOAM532ZR+4IQCwGfOnwJmsKd6ByOcgMDv4ampJG6E6Zy7AN2vx4sc4O
        RAF/Gx/O527chihgW+ZZECo=
X-Google-Smtp-Source: ABdhPJyWUyZ8FNI0GA/R20IXskf5Z9SPmJGG1ragdsZ42JEvCLKUvt/9eoB/AkMYg6APTu6I88aWLA==
X-Received: by 2002:a17:902:e806:b0:142:830:eaa4 with SMTP id u6-20020a170902e80600b001420830eaa4mr28670068plg.16.1638611589538;
        Sat, 04 Dec 2021 01:53:09 -0800 (PST)
Received: from vultr.guest ([45.76.74.237])
        by smtp.gmail.com with ESMTPSA id ms15sm4343198pjb.26.2021.12.04.01.53.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Dec 2021 01:53:09 -0800 (PST)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     akpm@linux-foundation.org, rostedt@goodmis.org,
        keescook@chromium.org, pmladek@suse.com, david@redhat.com,
        arnaldo.melo@gmail.com, andrii.nakryiko@gmail.com
Cc:     linux-mm@kvack.org, bpf@vger.kernel.org,
        linux-perf-users@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Yafang Shao <laoar.shao@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Michal Miroslaw <mirq-linux@rere.qmqm.pl>,
        Peter Zijlstra <peterz@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH -mm 2/5] cn_proc: replaced old hard-coded 16 with TASK_COMM_LEN_16
Date:   Sat,  4 Dec 2021 09:52:53 +0000
Message-Id: <20211204095256.78042-3-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20211204095256.78042-1-laoar.shao@gmail.com>
References: <20211204095256.78042-1-laoar.shao@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This TASK_COMM_LEN_16 has the same meaning with the macro defined in
linux/sched.h, but we can't include linux/sched.h in a UAPI header, so
we should specifically define it in the cn_proc.h.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
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

