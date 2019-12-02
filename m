Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3021710E884
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Dec 2019 11:16:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727416AbfLBKQC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 Dec 2019 05:16:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:60936 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727354AbfLBKQB (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Dec 2019 05:16:01 -0500
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 81C3A217D9;
        Mon,  2 Dec 2019 10:15:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575281761;
        bh=XFUFq878wx8ulylKj+mozx37qxZmGp3eAXgARqgqM+U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JtzBU/s38nrPqUf1ry6hevb4//dMP8J4G7izDWfMOJnSDw802eLgtJSc1gyBq8t5i
         AtWcPSJME3wUq82qKsP2h3bHPmooeOqOAOni6/4hPa9VjvfcQrccOVCBkOvIMfSGzh
         mPvTw0xp6T81ewuBuXbZn+kUwgm38KLzRakYjH1M=
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
Subject: [RFC PATCH v4 14/22] tracing: Add NULL trace-array check in print_synth_event()
Date:   Mon,  2 Dec 2019 19:15:55 +0900
Message-Id: <157528175542.22451.2622783120594712316.stgit@devnote2>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <157528159833.22451.14878731055438721716.stgit@devnote2>
References: <157528159833.22451.14878731055438721716.stgit@devnote2>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add NULL trace-array check in print_synth_event(), because
if we enable tp_printk option, iter->tr can be NULL.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 kernel/trace/trace_events_hist.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index 06d91bb59297..d902a61775c4 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -833,7 +833,7 @@ static enum print_line_t print_synth_event(struct trace_iterator *iter,
 		fmt = synth_field_fmt(se->fields[i]->type);
 
 		/* parameter types */
-		if (tr->trace_flags & TRACE_ITER_VERBOSE)
+		if (tr && tr->trace_flags & TRACE_ITER_VERBOSE)
 			trace_seq_printf(s, "%s ", fmt);
 
 		snprintf(print_fmt, sizeof(print_fmt), "%%s=%s%%s", fmt);

