Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F2EA23F449
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Aug 2020 23:30:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727868AbgHGV36 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 7 Aug 2020 17:29:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727803AbgHGV3r (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 7 Aug 2020 17:29:47 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 333B4C061A86
        for <linux-fsdevel@vger.kernel.org>; Fri,  7 Aug 2020 14:29:44 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id g127so4355055ybf.11
        for <linux-fsdevel@vger.kernel.org>; Fri, 07 Aug 2020 14:29:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=iVslrzv4xFzBXNEn359Z/Whm6d2iMTLeHC3W31lAdWA=;
        b=PMRwb4NmL4IuF15MfQo+H9K6Qn15ZHpQlFswnPN/N1ayXiu4uDc5kMokYO7brGLnRA
         34RvfsEoemKACz3SSygAzLYTNbPPn+yIpaRuSfUJO3w/L09IMlBjOoCkem7/IpMbKm91
         3tnCRlvu1GYumA3TL/IePEohcsP++2ix3zFqbldToEgq6dgZMV4QKsaTJNHgQklhmjho
         RiYMb0G9JJB5PuWtxMP2x+5xImZ7zwdyFPtjEb+0+uDgMjrZjvWSbKKrc2w0PINSFFvQ
         2uMQCw5nkyPclDnu8N0xl4fHSznqCH2Buiusi1bTDSmqxwryDPA95mriJfyN/ApwQxy2
         NuDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=iVslrzv4xFzBXNEn359Z/Whm6d2iMTLeHC3W31lAdWA=;
        b=nWHD5jWrFsWJG1FuZDY/hpRGulcp0pj0HbKSsnyRwY7Q+1xdKK5jRYYIlR/MBbF72R
         s4rwmlZxpZXzeDZHxpNUOjjAhkhe6GtwPPsgncBaNnrzSjF1ByeWwHwlLoi/vLlZ+MvD
         +vVRPXUW/hulqoix2e25vCSbb1/yMq3v/gueEu93uMibyc6RwRoq2NThevNkQFQT60fs
         jf0glLs4fvk1Pq52r5FocS1Zm4F5Zyc0PAhebnTWn/SdtmRNWhxDD0UpXOA89XASXV2M
         KWqOvrYAsR4hNnTBl82+hTJsCoiAyDZiKXkY3qz0ABewBz1Qk8j8dDmKDydK+3gcA3Zz
         ODPQ==
X-Gm-Message-State: AOAM5301BLA1I9/4zd7aTacqOATtASDzTG0hX49wECCOtXmlAt96KmJ0
        SX39sSHCmSaoJrxUCO3s3+4KBHm26eA=
X-Google-Smtp-Source: ABdhPJxcSm5w8AA6P4+MwGuTbTjPOW9Gn09XxR/9hjwAMXQFwA18Lv9fE2jFeD1Vp1hTVPD0RBmh1mdiBy15
X-Received: by 2002:a25:37c8:: with SMTP id e191mr20472648yba.230.1596835783402;
 Fri, 07 Aug 2020 14:29:43 -0700 (PDT)
Date:   Fri,  7 Aug 2020 14:29:14 -0700
In-Reply-To: <20200807212916.2883031-1-jwadams@google.com>
Message-Id: <20200807212916.2883031-6-jwadams@google.com>
Mime-Version: 1.0
References: <20200807212916.2883031-1-jwadams@google.com>
X-Mailer: git-send-email 2.28.0.236.gb10cc79966-goog
Subject: [RFC PATCH 5/7] core/metricfs: expose scheduler stat information
 through metricfs
From:   Jonathan Adams <jwadams@google.com>
To:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     netdev@vger.kernel.org, kvm@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Jim Mattson <jmattson@google.com>,
        David Rientjes <rientjes@google.com>,
        Jonathan Adams <jwadams@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add metricfs support for displaying percpu scheduler counters.
The top directory is /sys/kernel/debug/metricfs/stat (analogous
to /proc/stat).  Then there is a subdirectory for each scheduler
stat.  For example:

    cat /sys/kernel/debug/metricfs/stat/user/values

Signed-off-by: Jonathan Adams <jwadams@google.com>

---

jwadams@google.com: rebased to 5.8-pre6
	This is work originally done by another engineer at
	google, who would rather not have their name associated with this
	patchset. They're okay with me sending it under my name.
---
 fs/proc/stat.c | 57 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 57 insertions(+)

diff --git a/fs/proc/stat.c b/fs/proc/stat.c
index 46b3293015fe..deb378507b0b 100644
--- a/fs/proc/stat.c
+++ b/fs/proc/stat.c
@@ -13,6 +13,7 @@
 #include <linux/irqnr.h>
 #include <linux/sched/cputime.h>
 #include <linux/tick.h>
+#include <linux/metricfs.h>
 
 #ifndef arch_irq_stat_cpu
 #define arch_irq_stat_cpu(cpu) 0
@@ -237,3 +238,59 @@ static int __init proc_stat_init(void)
 	return 0;
 }
 fs_initcall(proc_stat_init);
+
+#ifdef CONFIG_METRICFS
+#define METRICFS_ITEM(name, field, desc) \
+static void \
+metricfs_##name(struct metric_emitter *e, int cpu) \
+{ \
+	int64_t v = kcpustat_field(&kcpustat_cpu(cpu), field, cpu); \
+	METRIC_EMIT_PERCPU_INT(e, cpu, v); \
+} \
+METRIC_EXPORT_PERCPU_COUNTER(name, desc, metricfs_##name)
+
+#define METRICFS_FUNC_ITEM(name, func, desc) \
+static void \
+metricfs_##name(struct metric_emitter *e, int cpu) \
+{ \
+	struct kernel_cpustat cpustat; \
+	int64_t v; \
+	kcpustat_cpu_fetch(&cpustat, cpu); \
+	v = func(&cpustat, cpu); \
+	METRIC_EMIT_PERCPU_INT(e, cpu, v); \
+} \
+METRIC_EXPORT_PERCPU_COUNTER(name, desc, metricfs_##name)
+
+METRICFS_ITEM(user, CPUTIME_USER, "time in user mode (nsec)");
+METRICFS_ITEM(nice, CPUTIME_NICE, "time in user mode niced (nsec)");
+METRICFS_ITEM(system, CPUTIME_SYSTEM, "time in system calls (nsec)");
+METRICFS_ITEM(irq, CPUTIME_IRQ, "time in interrupts (nsec)");
+METRICFS_ITEM(softirq, CPUTIME_SOFTIRQ, "time in softirqs (nsec)");
+METRICFS_ITEM(steal, CPUTIME_STEAL, "time in involuntary wait (nsec)");
+METRICFS_ITEM(guest, CPUTIME_GUEST, "time in guest mode (nsec)");
+METRICFS_ITEM(guest_nice, CPUTIME_GUEST_NICE,
+	"time in guest mode niced (nsec)");
+METRICFS_FUNC_ITEM(idle, get_idle_time, "time in idle (nsec)");
+METRICFS_FUNC_ITEM(iowait, get_iowait_time, "time in iowait (nsec)");
+
+static int __init init_stat_metricfs(void)
+{
+	struct metricfs_subsys *subsys;
+
+	subsys = metricfs_create_subsys("stat", NULL);
+	metric_init_user(subsys);
+	metric_init_nice(subsys);
+	metric_init_system(subsys);
+	metric_init_irq(subsys);
+	metric_init_softirq(subsys);
+	metric_init_steal(subsys);
+	metric_init_guest(subsys);
+	metric_init_guest_nice(subsys);
+	metric_init_idle(subsys);
+	metric_init_iowait(subsys);
+
+	return 0;
+}
+module_init(init_stat_metricfs);
+
+#endif
-- 
2.28.0.236.gb10cc79966-goog

