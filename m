Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFEB44DDF0F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Mar 2022 17:31:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238323AbiCRQcp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 18 Mar 2022 12:32:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239196AbiCRQcl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 18 Mar 2022 12:32:41 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 974451AE625;
        Fri, 18 Mar 2022 09:31:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9FC09B82475;
        Fri, 18 Mar 2022 16:31:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58498C340EC;
        Fri, 18 Mar 2022 16:31:00 +0000 (UTC)
Date:   Fri, 18 Mar 2022 12:30:58 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Sven Schnelle <svens@linux.ibm.com>
Cc:     Ritesh Harjani <riteshh@linux.ibm.com>, linux-ext4@vger.kernel.org,
        Jan Kara <jack@suse.cz>, "Theodore Ts'o" <tytso@mit.edu>,
        Harshad Shirwadkar <harshadshirwadkar@gmail.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@kernel.org
Subject: Re: [PATCHv3 02/10] ext4: Fix ext4_fc_stats trace point
Message-ID: <20220318123058.348938b1@gandalf.local.home>
In-Reply-To: <20220317143938.745e1420@gandalf.local.home>
References: <cover.1647057583.git.riteshh@linux.ibm.com>
        <b4b9691414c35c62e570b723e661c80674169f9a.1647057583.git.riteshh@linux.ibm.com>
        <yt9dr1706b4i.fsf@linux.ibm.com>
        <20220317143938.745e1420@gandalf.local.home>
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

On Thu, 17 Mar 2022 14:39:38 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> [ here I wanted to add a patch, but I haven't figured out the best way to
>   fix it yet. ]

Care to try this patch?

-- Steve

diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index 7b558c72f595..e11e167b7809 100644
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
@@ -2643,14 +2651,40 @@ static void update_event_printk(struct trace_event_call *call,
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
@@ -2664,9 +2698,26 @@ static void update_event_fields(struct trace_event_call *call,
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
 
@@ -2893,6 +2944,7 @@ static void trace_module_add_events(struct module *mod)
 static void trace_module_remove_events(struct module *mod)
 {
 	struct trace_event_call *call, *p;
+	struct module_string *modstr, *m;
 
 	down_write(&trace_event_sem);
 	list_for_each_entry_safe(call, p, &ftrace_events, list) {
@@ -2901,6 +2953,14 @@ static void trace_module_remove_events(struct module *mod)
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
