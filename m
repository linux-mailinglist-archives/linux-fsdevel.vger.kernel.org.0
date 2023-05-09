Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AAB86FCC27
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 May 2023 19:00:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229838AbjEIRAJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 9 May 2023 13:00:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234968AbjEIQ7S (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 9 May 2023 12:59:18 -0400
Received: from out-15.mta1.migadu.com (out-15.mta1.migadu.com [IPv6:2001:41d0:203:375::f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E78130FB
        for <linux-fsdevel@vger.kernel.org>; Tue,  9 May 2023 09:57:41 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1683651458;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=R1CKn2DNdt+nUP3OEYLc0FEKerxTzeneNiYGijAjw4w=;
        b=MWyrh9lTZEKvAjK54wQLwMmHmVWpNM37wFWrK8Q5auXGHq22dsN5xqqiOumHjYP49lY2bB
        o8u0C/aFn62GOYNPBbIfgOahC2Fj+hR7+2lBPSyPpU+gL7KBAllKr1kecg10NBdQmKTRqa
        dOIjSLmj5brVSuAmKbeJPBDHpevngMs=
From:   Kent Overstreet <kent.overstreet@linux.dev>
To:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-bcachefs@vger.kernel.org
Cc:     Christopher James Halse Rogers <raof@ubuntu.com>,
        Kent Overstreet <kent.overstreet@linux.dev>
Subject: [PATCH 28/32] stacktrace: Export stack_trace_save_tsk
Date:   Tue,  9 May 2023 12:56:53 -0400
Message-Id: <20230509165657.1735798-29-kent.overstreet@linux.dev>
In-Reply-To: <20230509165657.1735798-1-kent.overstreet@linux.dev>
References: <20230509165657.1735798-1-kent.overstreet@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Christopher James Halse Rogers <raof@ubuntu.com>

The bcachefs module wants it, and there doesn't seem to be any
reason it shouldn't be exported like the other functions.

Signed-off-by: Christopher James Halse Rogers <raof@ubuntu.com>
Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
---
 kernel/stacktrace.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/stacktrace.c b/kernel/stacktrace.c
index 9ed5ce9894..4f65824879 100644
--- a/kernel/stacktrace.c
+++ b/kernel/stacktrace.c
@@ -151,6 +151,7 @@ unsigned int stack_trace_save_tsk(struct task_struct *tsk, unsigned long *store,
 	put_task_stack(tsk);
 	return c.len;
 }
+EXPORT_SYMBOL_GPL(stack_trace_save_tsk);
 
 /**
  * stack_trace_save_regs - Save a stack trace based on pt_regs into a storage array
@@ -301,6 +302,7 @@ unsigned int stack_trace_save_tsk(struct task_struct *task,
 	save_stack_trace_tsk(task, &trace);
 	return trace.nr_entries;
 }
+EXPORT_SYMBOL_GPL(stack_trace_save_tsk);
 
 /**
  * stack_trace_save_regs - Save a stack trace based on pt_regs into a storage array
-- 
2.40.1

