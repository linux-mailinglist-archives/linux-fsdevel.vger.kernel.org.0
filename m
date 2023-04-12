Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B79CC6DF80C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Apr 2023 16:11:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231294AbjDLOLO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Apr 2023 10:11:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbjDLOLM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Apr 2023 10:11:12 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 933D310EB
        for <linux-fsdevel@vger.kernel.org>; Wed, 12 Apr 2023 07:11:08 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id c3so12558673pjg.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 12 Apr 2023 07:11:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1681308668;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/08sgLNHl+fvsLpz2QvFxww3IWnM9URQXV0BTGByAnM=;
        b=ah3FfTCwtmlj6FL1p8yzw2jYC7yFw0+4YehGEEbWBum7kI6Rd8emsG3gTnRLPIDlzh
         ATgUdGcX4JxsAU42Ffd9/mElLT1w8zU8H/mkPAnLKxngubSiYHWJMjyc6BnmshadOED1
         LZRA0eOhn+4dYVysVIEjabVJqL7TfXQi4aW/yK5TwlI6V/GsuIqGPPVchpGQD6LGlPuA
         XyFSWOr6h00KIKAOv2ek3wwmT02wxHTToefvZLeXFZAMqdN8GEAmtubIAZcQMmiGqZ7R
         IjkMW4IB3+IzCJYsfTEj/31H02aplIOF8P5doPfLi6S/Tqk3AdLW2ZOz6rI2P4JmHPkR
         rHIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681308668;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/08sgLNHl+fvsLpz2QvFxww3IWnM9URQXV0BTGByAnM=;
        b=ot0ioNjZilVnAu5tfbufBWAK6SkY/RgbjjmvMfwRvyDv5ro+zogWw6/PeLt8h64P2A
         mxpuA6dqB884w9355icLOrIHQCHDLZcaTY1C7E7CoPW7IpC8RIP4w3uNoUfjhtBdYK1M
         2et12LSGpCXeWDzBtkBNdMK5uHLi/TFAEVWDd/ykjcl1TQexBA+/PeLdiUTD2YgfcacN
         ZHoN3eWt2vB/PqyadiqOu43O8d0kCkJ4MkGG8y8ySSFjeb6g7t7fMsuC/imsAOuU63SM
         oBpOIrqeXDSS6vZadYHmvvKrqN+9kgzzfpRXRHyobZxBKSZgBPADGcygstPeAb7j6tSz
         8JhA==
X-Gm-Message-State: AAQBX9djKwxcVn0KobnVSzKRQa/CDI8HRoGdYtaq55OV6GP1Jwnw7VMa
        fXZKPB2emGgtKULJcB266EXooQ==
X-Google-Smtp-Source: AKy350YdZubU5x7WHR5Ra7lyb5gK5DZdvAGIACucw2eA1QSl4JVAZfxjZzWbzpgx+BaceamCCqKDzw==
X-Received: by 2002:a17:90b:1d04:b0:23d:3913:bc26 with SMTP id on4-20020a17090b1d0400b0023d3913bc26mr21902907pjb.2.1681308667917;
        Wed, 12 Apr 2023 07:11:07 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.253])
        by smtp.gmail.com with ESMTPSA id gz2-20020a17090b0ec200b00246aa8b0e8csm1503359pjb.55.2023.04.12.07.11.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Apr 2023 07:11:07 -0700 (PDT)
From:   Gang Li <ligang.bdlg@bytedance.com>
To:     John Hubbard <jhubbard@nvidia.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>
Cc:     linux-api@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
        Gang Li <ligang.bdlg@bytedance.com>
Subject: [PATCH v6 1/2] sched/numa: use static_branch_inc/dec for sched_numa_balancing
Date:   Wed, 12 Apr 2023 22:10:52 +0800
Message-Id: <20230412141053.59498-1-ligang.bdlg@bytedance.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20230412140701.58337-1-ligang.bdlg@bytedance.com>
References: <20230412140701.58337-1-ligang.bdlg@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

per-process numa balancing use static_branch_inc/dec() to count
how many enables in sched_numa_balancing. So here must be converted
to inc/dec too.

Cc: linux-api@vger.kernel.org
Signed-off-by: Gang Li <ligang.bdlg@bytedance.com>
Acked-by: John Hubbard <jhubbard@nvidia.com>
---
 kernel/sched/core.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 94be4eebfa53..99cc1d5821a1 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -4501,21 +4501,15 @@ DEFINE_STATIC_KEY_FALSE(sched_numa_balancing);
 
 int sysctl_numa_balancing_mode;
 
-static void __set_numabalancing_state(bool enabled)
-{
-	if (enabled)
-		static_branch_enable(&sched_numa_balancing);
-	else
-		static_branch_disable(&sched_numa_balancing);
-}
-
 void set_numabalancing_state(bool enabled)
 {
-	if (enabled)
+	if (enabled) {
 		sysctl_numa_balancing_mode = NUMA_BALANCING_NORMAL;
-	else
+		static_branch_enable(&sched_numa_balancing);
+	} else {
 		sysctl_numa_balancing_mode = NUMA_BALANCING_DISABLED;
-	__set_numabalancing_state(enabled);
+		static_branch_disable(&sched_numa_balancing);
+	}
 }
 
 #ifdef CONFIG_PROC_SYSCTL
@@ -4549,8 +4543,14 @@ static int sysctl_numa_balancing(struct ctl_table *table, int write,
 		if (!(sysctl_numa_balancing_mode & NUMA_BALANCING_MEMORY_TIERING) &&
 		    (state & NUMA_BALANCING_MEMORY_TIERING))
 			reset_memory_tiering();
-		sysctl_numa_balancing_mode = state;
-		__set_numabalancing_state(state);
+		if (sysctl_numa_balancing_mode != state) {
+			if (state == NUMA_BALANCING_DISABLED)
+				static_branch_dec(&sched_numa_balancing);
+			else if (sysctl_numa_balancing_mode == NUMA_BALANCING_DISABLED)
+				static_branch_inc(&sched_numa_balancing);
+
+			sysctl_numa_balancing_mode = state;
+		}
 	}
 	return err;
 }
-- 
2.20.1

