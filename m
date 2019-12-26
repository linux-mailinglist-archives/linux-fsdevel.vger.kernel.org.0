Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1B82312ACCE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Dec 2019 15:06:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726839AbfLZOF5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 26 Dec 2019 09:05:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:51878 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726453AbfLZOF5 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 26 Dec 2019 09:05:57 -0500
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 12DF720828;
        Thu, 26 Dec 2019 14:05:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577369156;
        bh=yMBl8XxaxKdvGCY+1+Oua0hhZ/Go8NMOCgUYd9B9UNE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MpEHs14iMrx9XIgrnOUTokYdmLRpK9XlDm/Bk3V8RWnsnS8L4gH1DQmxEmgPoTIhJ
         jqCaTvte6rqJZieGBCCPeuVwi7S2peHJRKMO2FxlBTxTUU3EDHnkmD4vpa5BlAMQAm
         Ya9pgdAmedAXrqzrRTOmJznRo7rky4P6axKsScwk=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Frank Rowand <frowand.list@gmail.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Tim Bird <Tim.Bird@sony.com>, Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 10/22] tracing: Apply soft-disabled and filter to tracepoints printk
Date:   Thu, 26 Dec 2019 23:05:49 +0900
Message-Id: <157736914939.11126.13682942838710986821.stgit@devnote2>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <157736902773.11126.2531161235817081873.stgit@devnote2>
References: <157736902773.11126.2531161235817081873.stgit@devnote2>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Apply soft-disabled and the filter rule of the trace events to
the printk output of tracepoints (a.k.a. tp_printk kernel parameter)
as same as trace buffer output.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 0 files changed

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index ddb7e7f5fe8d..43f0f255ad66 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -2610,6 +2610,7 @@ static DEFINE_MUTEX(tracepoint_printk_mutex);
 static void output_printk(struct trace_event_buffer *fbuffer)
 {
 	struct trace_event_call *event_call;
+	struct trace_event_file *file;
 	struct trace_event *event;
 	unsigned long flags;
 	struct trace_iterator *iter = tracepoint_print_iter;
@@ -2623,6 +2624,12 @@ static void output_printk(struct trace_event_buffer *fbuffer)
 	    !event_call->event.funcs->trace)
 		return;
 
+	file = fbuffer->trace_file;
+	if (test_bit(EVENT_FILE_FL_SOFT_DISABLED_BIT, &file->flags) ||
+	    (unlikely(file->flags & EVENT_FILE_FL_FILTERED) &&
+	     !filter_match_preds(file->filter, fbuffer->entry)))
+		return;
+
 	event = &fbuffer->trace_file->event_call->event;
 
 	spin_lock_irqsave(&tracepoint_iter_lock, flags);

