Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E0F759C7A7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Aug 2019 05:17:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729498AbfHZDQo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 25 Aug 2019 23:16:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:35902 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726434AbfHZDQo (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 25 Aug 2019 23:16:44 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F04D12173E;
        Mon, 26 Aug 2019 03:16:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566789403;
        bh=2KXefGGEbWZIuaONJPAxtXMECnSf0wCC1mBwVxRYIfc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PRWAMOsjGhV8t1Vxn5Mee8c4QWL5HxiR0OHr9LKGSOI4l7+ghu0D2MWxls1fvKzXX
         XPVmVvDpNjhts+zZTWh8urCuA4tjRghxCI9qj5YwwkIFUIoM5vKVDOaoZmNXG/B8fq
         prdZhS+s/WXzTJjNta/ELZ6g40L0wmk3CQoGmbjA=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Frank Rowand <frowand.list@gmail.com>
Cc:     Ingo Molnar <mingo@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
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
Subject: [RFC PATCH v3 05/19] tracing: Apply soft-disabled and filter to tracepoints printk
Date:   Mon, 26 Aug 2019 12:16:37 +0900
Message-Id: <156678939711.21459.14981591663181807734.stgit@devnote2>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <156678933823.21459.4100380582025186209.stgit@devnote2>
References: <156678933823.21459.4100380582025186209.stgit@devnote2>
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
 kernel/trace/trace.c |    7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 525a97fbbc60..ead3a9faa584 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -2502,6 +2502,7 @@ static DEFINE_MUTEX(tracepoint_printk_mutex);
 static void output_printk(struct trace_event_buffer *fbuffer)
 {
 	struct trace_event_call *event_call;
+	struct trace_event_file *file;
 	struct trace_event *event;
 	unsigned long flags;
 	struct trace_iterator *iter = tracepoint_print_iter;
@@ -2515,6 +2516,12 @@ static void output_printk(struct trace_event_buffer *fbuffer)
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

