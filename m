Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D9304137255
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Jan 2020 17:06:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728601AbgAJQGM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 10 Jan 2020 11:06:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:54686 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728497AbgAJQGM (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 10 Jan 2020 11:06:12 -0500
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BC1EE208E4;
        Fri, 10 Jan 2020 16:06:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578672371;
        bh=5PhsvcLu2SEfj/jWR5AT1Tp2dDe9WXeiCF0tfbbG4MA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fWI5KiSedCdj7E38HDknQEUlKRNPt/juS5KVx3bkp0HFclEozmqP084DJaTuM+/iX
         GkQ/VXd+V2wPl/1BcgPQMo+4V60gQLkrEJzFqlJOZM8/JRL3UMafduzBi5B9+9ce5v
         XDvSCU0pzlMSutp0sq0i1b+DFEVgX+IOGqk6NyN8=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Frank Rowand <frowand.list@gmail.com>,
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
Subject: [PATCH v6 14/22] tracing: Add NULL trace-array check in print_synth_event()
Date:   Sat, 11 Jan 2020 01:06:05 +0900
Message-Id: <157867236536.17873.12529350542460184019.stgit@devnote2>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <157867220019.17873.13377985653744804396.stgit@devnote2>
References: <157867220019.17873.13377985653744804396.stgit@devnote2>
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
index dae2c25b209a..137fc50f2b35 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -833,7 +833,7 @@ static enum print_line_t print_synth_event(struct trace_iterator *iter,
 		fmt = synth_field_fmt(se->fields[i]->type);
 
 		/* parameter types */
-		if (tr->trace_flags & TRACE_ITER_VERBOSE)
+		if (tr && tr->trace_flags & TRACE_ITER_VERBOSE)
 			trace_seq_printf(s, "%s ", fmt);
 
 		snprintf(print_fmt, sizeof(print_fmt), "%%s=%s%%s", fmt);

