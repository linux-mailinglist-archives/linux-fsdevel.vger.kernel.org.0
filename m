Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C4754DE1D5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Mar 2022 20:34:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240327AbiCRTf7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 18 Mar 2022 15:35:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235675AbiCRTf5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 18 Mar 2022 15:35:57 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0A2A2E9C7;
        Fri, 18 Mar 2022 12:34:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 60FA8B82535;
        Fri, 18 Mar 2022 19:34:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6E70C340EF;
        Fri, 18 Mar 2022 19:34:33 +0000 (UTC)
Date:   Fri, 18 Mar 2022 15:34:32 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        Sven Schnelle <svens@linux.ibm.com>,
        Ritesh Harjani <riteshh@linux.ibm.com>,
        Jan Kara <jack@suse.cz>, "Theodore Ts'o" <tytso@mit.edu>,
        Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Subject: [PATCH] tracing: Have type enum modifications copy the strings
Message-ID: <20220318153432.3984b871@gandalf.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: "Steven Rostedt (Google)" <rostedt@goodmis.org>

When an enum is used in the visible parts of a trace event that is
exported to user space, the user space applications like perf and
trace-cmd do not have a way to know what the value of the enum is. To
solve this, at boot up (or module load) the printk formats are modified to
replace the enum with their numeric value in the string output.

Array fields of the event are defined by [<nr-elements>] in the type
portion of the format file so that the user space parsers can correctly
parse the array into the appropriate size chunks. But in some trace
events, an enum is used in defining the size of the array, which once
again breaks the parsing of user space tooling.

This was solved the same way as the print formats were, but it modified
the type strings of the trace event. This caused crashes in some
architectures because, as supposed to the print string, is a const string
value. This was not detected on x86, as it appears that const strings are
still writable (at least in boot up), but other architectures this is not
the case, and writing to a const string will cause a kernel fault.

To fix this, use kstrdup() to copy the type before modifying it. If the
trace event is for the core kernel there's no need to free it because the
string will be in use for the life of the machine being on line. For
modules, create a link list to store all the strings being allocated for
modules and when the module is removed, free them.

Link: https://lore.kernel.org/all/yt9dr1706b4i.fsf@linux.ibm.com/

Fixes: b3bc8547d3be ("tracing: Have TRACE_DEFINE_ENUM affect trace event types as well")
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace_events.c | 62 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 61 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index ae9a3b8481f5..0d91152172c9 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -40,6 +40,14 @@ static LIST_HEAD(ftrace_generic_fields);
 static LIST_HEAD(ftrace_common_fields);
 static bool eventdir_initialized;
 
+static LIST_HEAD(module_strings);
+
+struct module_string {
+	struct list_head	next;
+	struct module		*module;
+	char			*str;
+};
+
 #define GFP_TRACE (GFP_KERNEL | __GFP_ZERO)
 
 static struct kmem_cache *field_cachep;
@@ -2633,14 +2641,40 @@ static void update_event_printk(struct trace_event_call *call,
 	}
 }
 
+static void add_str_to_module(struct module *module, char *str)
+{
+	struct module_string *modstr;
+
+	modstr = kmalloc(sizeof(*modstr), GFP_KERNEL);
+
+	/*
+	 * If we failed to allocate memory here, then we'll just
+	 * let the str memory leak when the module is removed.
+	 * If this fails to allocate, there's worse problems than
+	 * a leaked string on module removal.
+	 */
+	if (WARN_ON_ONCE(!modstr))
+		return;
+
+	modstr->module = module;
+	modstr->str = str;
+
+	list_add(&modstr->next, &module_strings);
+}
+
 static void update_event_fields(struct trace_event_call *call,
 				struct trace_eval_map *map)
 {
 	struct ftrace_event_field *field;
 	struct list_head *head;
 	char *ptr;
+	char *str;
 	int len = strlen(map->eval_string);
 
+	/* Dynamic events should never have field maps */
+	if (WARN_ON_ONCE(call->flags & TRACE_EVENT_FL_DYNAMIC))
+		return;
+
 	head = trace_get_fields(call);
 	list_for_each_entry(field, head, link) {
 		ptr = strchr(field->type, '[');
@@ -2654,9 +2688,26 @@ static void update_event_fields(struct trace_event_call *call,
 		if (strncmp(map->eval_string, ptr, len) != 0)
 			continue;
 
+		str = kstrdup(field->type, GFP_KERNEL);
+		if (WARN_ON_ONCE(!str))
+			return;
+		ptr = str + (ptr - field->type);
 		ptr = eval_replace(ptr, map, len);
 		/* enum/sizeof string smaller than value */
-		WARN_ON_ONCE(!ptr);
+		if (WARN_ON_ONCE(!ptr)) {
+			kfree(str);
+			continue;
+		}
+
+		/*
+		 * If the event is part of a module, then we need to free the string
+		 * when the module is removed. Otherwise, it will stay allocated
+		 * until a reboot.
+		 */
+		if (call->module)
+			add_str_to_module(call->module, str);
+
+		field->type = str;
 	}
 }
 
@@ -2883,6 +2934,7 @@ static void trace_module_add_events(struct module *mod)
 static void trace_module_remove_events(struct module *mod)
 {
 	struct trace_event_call *call, *p;
+	struct module_string *modstr, *m;
 
 	down_write(&trace_event_sem);
 	list_for_each_entry_safe(call, p, &ftrace_events, list) {
@@ -2891,6 +2943,14 @@ static void trace_module_remove_events(struct module *mod)
 		if (call->module == mod)
 			__trace_remove_event_call(call);
 	}
+	/* Check for any strings allocade for this module */
+	list_for_each_entry_safe(modstr, m, &module_strings, next) {
+		if (modstr->module != mod)
+			continue;
+		list_del(&modstr->next);
+		kfree(modstr->str);
+		kfree(modstr);
+	}
 	up_write(&trace_event_sem);
 
 	/*
-- 
2.35.1

