Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0952F4D2446
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Mar 2022 23:28:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345998AbiCHW3J (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Mar 2022 17:29:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241588AbiCHW3J (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Mar 2022 17:29:09 -0500
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9FE541B78B;
        Tue,  8 Mar 2022 14:28:11 -0800 (PST)
Received: from localhost.localdomain (c-73-140-2-214.hsd1.wa.comcast.net [73.140.2.214])
        by linux.microsoft.com (Postfix) with ESMTPSA id 2EBD420B7178;
        Tue,  8 Mar 2022 14:28:11 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 2EBD420B7178
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1646778491;
        bh=XTaWdFtvrgMqEqAwScaJHL3xY9KS+lKMXsqnqkHeuNo=;
        h=From:To:Cc:Subject:Date:From;
        b=c1uTSjXB8dn1wQ90CV62MMSyZNL04gQOLzpiCr+740IVaiEyYkP5/+012H13RJdWc
         O2CbtvoA+EXJAkz9zuNttLxyjHY89EOiPmVqJX3wV/9l1kD+Wta01n5JILVwxvy24y
         huDiij4LCjW6LWRmvdvt9jjDo0ITvb00OXmwKE8o=
From:   Beau Belgrave <beaub@linux.microsoft.com>
To:     rostedt@goodmis.org
Cc:     keescook@chromium.org, linux-trace-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        beaub@linux.microsoft.com
Subject: [PATCH] user_events: Add trace event call as root for low permission cases
Date:   Tue,  8 Mar 2022 14:28:07 -0800
Message-Id: <20220308222807.2040-1-beaub@linux.microsoft.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-19.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Tracefs by default is locked down heavily. System operators can open up
some files, such as user_events to a broader set of users. These users
do not have access within tracefs beyond just the user_event files. Due
to this restriction the trace_add_event_call/remove calls will silently
fail since the caller does not have permissions to create directories.

To fix this trace_add_event_call/remove calls will be issued with
override creds of the global root UID. Creds are reverted immediately
afterward.

Signed-off-by: Beau Belgrave <beaub@linux.microsoft.com>
---
 kernel/trace/trace_events_user.c | 39 ++++++++++++++++++++++++++++++--
 1 file changed, 37 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/trace_events_user.c b/kernel/trace/trace_events_user.c
index 2b5e9fdb63a0..7dfa83ff2466 100644
--- a/kernel/trace/trace_events_user.c
+++ b/kernel/trace/trace_events_user.c
@@ -557,6 +557,41 @@ static struct trace_event_functions user_event_funcs = {
 	.trace = user_event_print_trace,
 };
 
+static int user_event_set_call_visible(struct user_event *user, bool visible)
+{
+	int ret;
+	const struct cred *old_cred;
+	struct cred *cred;
+
+	cred = prepare_creds();
+
+	if (!cred)
+		return -ENOMEM;
+
+	/*
+	 * While by default tracefs is locked down, systems can be configured
+	 * to allow user_event files to be less locked down. The extreme case
+	 * being "other" has read/write access to user_events_data/status.
+	 *
+	 * When not locked down, processes may not have have permissions to
+	 * add/remove calls themselves to tracefs. We need to temporarily
+	 * switch to root file permission to allow for this scenario.
+	 */
+	cred->fsuid = GLOBAL_ROOT_UID;
+
+	old_cred = override_creds(cred);
+
+	if (visible)
+		ret = trace_add_event_call(&user->call);
+	else
+		ret = trace_remove_event_call(&user->call);
+
+	revert_creds(old_cred);
+	put_cred(cred);
+
+	return ret;
+}
+
 static int destroy_user_event(struct user_event *user)
 {
 	int ret = 0;
@@ -564,7 +599,7 @@ static int destroy_user_event(struct user_event *user)
 	/* Must destroy fields before call removal */
 	user_event_destroy_fields(user);
 
-	ret = trace_remove_event_call(&user->call);
+	ret = user_event_set_call_visible(user, false);
 
 	if (ret)
 		return ret;
@@ -1037,7 +1072,7 @@ static int user_event_trace_register(struct user_event *user)
 	if (!ret)
 		return -ENODEV;
 
-	ret = trace_add_event_call(&user->call);
+	ret = user_event_set_call_visible(user, true);
 
 	if (ret)
 		unregister_trace_event(&user->call.event);

base-commit: 864ea0e10cc90416a01b46f0d47a6f26dc020820
-- 
2.17.1

