Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D36FA23F448
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Aug 2020 23:30:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727854AbgHGV34 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 7 Aug 2020 17:29:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727111AbgHGV3m (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 7 Aug 2020 17:29:42 -0400
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F430C061A28
        for <linux-fsdevel@vger.kernel.org>; Fri,  7 Aug 2020 14:29:42 -0700 (PDT)
Received: by mail-qt1-x849.google.com with SMTP id m13so2600799qth.16
        for <linux-fsdevel@vger.kernel.org>; Fri, 07 Aug 2020 14:29:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=O7nU7lYRfe2R9ziGF333WHlsyARaR/Q4/HWduypodHg=;
        b=wF2sKYSCPfS1oM0NH0xBupgB1N/FqdnAiRnprzF9CglUuoj8PFS0W/tP4/W0GJPNuX
         TyrQaJi9YYWikcZeI0piuRjIgi7S5jtC+iCUMgx8SN14rfqmKY7koAozdgACk/O4WfVJ
         yv7+JzWcCmipUuyAMJMfzjLlkCoyIjH1rZVL2QfDcg/SnWLNI8ygMAJbmEQc4uzHhanr
         cOazUENtE+ArWoT9JNvMKb2ZhVEp8J8eXYoSQYPithEBghTam0jogYR9DsEv5IJ8i0zG
         nhl2W24qoGsirdUwqm7iXnLP0F2QVNElE3cyh5qkdYDPSSJRi85rrFJtgQ3oy1s4p4h+
         sSCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=O7nU7lYRfe2R9ziGF333WHlsyARaR/Q4/HWduypodHg=;
        b=Cp8fGDgi8MgfmEIftQX6zoDZU/T1eaTfNRtg/vOfY1p4RYEwUidN2H7hM3zhn51S8b
         YUgqu9cKqo+cRzxP/rtVMsfPRfU0fJ55KkoCXlhQRCE0jmV2GKZOCYLqJauFoJAKkCRZ
         dkKHJZPjEpjuH0Gem2LLaCstXzds14zKAwDIRq1le9L0HihOHGzRuEbuWaV7P4+mRQFc
         cgb0ohUmIsBK56BbDA7QmHpC+lMCEXEj/7bYQz4gCddK5Od3C0BlcmEi+vO9MZM8wdqQ
         vySkv14Xo/NWUvFNj78h3TbX/ZrpTWNY+Ub9HDc69LMM1dpmXODnD5UKibJjq/PszkGq
         uanQ==
X-Gm-Message-State: AOAM531/xnufLJ88qFfhH0eUE3BG0rC3dYS9vOlWsZcn0uBdr7Ogfg9y
        2VaC6k9OTzW9ufc6qMIvZKZvcpCD4R0=
X-Google-Smtp-Source: ABdhPJwX9D4en+hACeaFijzp6xuG9EX9sqMK2d3+XO8tWnEdN3dt94ChhAurZV3Fxr5jxFzwH9+/rqq5AG1s
X-Received: by 2002:a05:6214:11a8:: with SMTP id u8mr15191510qvv.88.1596835781537;
 Fri, 07 Aug 2020 14:29:41 -0700 (PDT)
Date:   Fri,  7 Aug 2020 14:29:13 -0700
In-Reply-To: <20200807212916.2883031-1-jwadams@google.com>
Message-Id: <20200807212916.2883031-5-jwadams@google.com>
Mime-Version: 1.0
References: <20200807212916.2883031-1-jwadams@google.com>
X-Mailer: git-send-email 2.28.0.236.gb10cc79966-goog
Subject: [RFC PATCH 4/7] core/metricfs: expose softirq information through metricfs
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

Add metricfs support for displaying percpu softirq counters.  The
top directory is /sys/kernel/debug/metricfs/softirq.  Then there
is a subdirectory for each softirq type.  For example:

    cat /sys/kernel/debug/metricfs/softirq/NET_RX/values

Signed-off-by: Jonathan Adams <jwadams@google.com>

---

jwadams@google.com: rebased to 5.8-pre6
	This is work originally done by another engineer at
	google, who would rather not have their name associated with this
	patchset. They're okay with me sending it under my name.
---
 kernel/softirq.c | 45 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/kernel/softirq.c b/kernel/softirq.c
index c4201b7f42b1..1ae3a540b789 100644
--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -25,6 +25,8 @@
 #include <linux/smpboot.h>
 #include <linux/tick.h>
 #include <linux/irq.h>
+#include <linux/jump_label.h>
+#include <linux/metricfs.h>
 
 #define CREATE_TRACE_POINTS
 #include <trace/events/irq.h>
@@ -738,3 +740,46 @@ unsigned int __weak arch_dynirq_lower_bound(unsigned int from)
 {
 	return from;
 }
+
+#ifdef CONFIG_METRICFS
+
+#define METRICFS_ITEM(name) \
+static void \
+metricfs_##name(struct metric_emitter *e, int cpu) \
+{ \
+	int64_t v = kstat_softirqs_cpu(name##_SOFTIRQ, cpu); \
+	METRIC_EMIT_PERCPU_INT(e, cpu, v); \
+} \
+METRIC_EXPORT_PERCPU_COUNTER(name, #name " softirq", metricfs_##name)
+
+METRICFS_ITEM(HI);
+METRICFS_ITEM(TIMER);
+METRICFS_ITEM(NET_TX);
+METRICFS_ITEM(NET_RX);
+METRICFS_ITEM(BLOCK);
+METRICFS_ITEM(IRQ_POLL);
+METRICFS_ITEM(TASKLET);
+METRICFS_ITEM(SCHED);
+METRICFS_ITEM(HRTIMER);
+METRICFS_ITEM(RCU);
+
+static int __init init_softirq_metricfs(void)
+{
+	struct metricfs_subsys *subsys;
+
+	subsys = metricfs_create_subsys("softirq", NULL);
+	metric_init_HI(subsys);
+	metric_init_TIMER(subsys);
+	metric_init_NET_TX(subsys);
+	metric_init_NET_RX(subsys);
+	metric_init_BLOCK(subsys);
+	metric_init_IRQ_POLL(subsys);
+	metric_init_TASKLET(subsys);
+	metric_init_SCHED(subsys);
+	metric_init_RCU(subsys);
+
+	return 0;
+}
+module_init(init_softirq_metricfs);
+
+#endif
-- 
2.28.0.236.gb10cc79966-goog

