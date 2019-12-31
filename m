Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 68F9F12DB61
	for <lists+linux-fsdevel@lfdr.de>; Tue, 31 Dec 2019 20:50:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727313AbfLaTue (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 31 Dec 2019 14:50:34 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:39804 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727249AbfLaTud (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 31 Dec 2019 14:50:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1577821832;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:in-reply-to:
         references:references:references;
        bh=unG8HxtSeq9PJ+7Zhk+DRiM+AVuaUj0jfr4vQ4Xw44M=;
        b=afllN5uFFksgyNatiNrWOtN2Anjzi+QMhaDUINRsD6pBHjDwRhiY4/VdWoChRsrhiDJOi6
        zDub4MWFkCHBGAJbK2BNiWJ7wheCJgkW4e2SCWszq1hlAjO5g+fgn1ywAWbpn8uTwjVo9f
        sc7TKQnuMFFMfjZZmlmHheN/Wu8+SuU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-3-SRSHJE-dMAG7n0dhoUlgXA-1; Tue, 31 Dec 2019 14:50:30 -0500
X-MC-Unique: SRSHJE-dMAG7n0dhoUlgXA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B143C800D55;
        Tue, 31 Dec 2019 19:50:28 +0000 (UTC)
Received: from madcap2.tricolour.ca (ovpn-112-15.phx2.redhat.com [10.3.112.15])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2109067673;
        Tue, 31 Dec 2019 19:50:23 +0000 (UTC)
From:   Richard Guy Briggs <rgb@redhat.com>
To:     containers@lists.linux-foundation.org, linux-api@vger.kernel.org,
        Linux-Audit Mailing List <linux-audit@redhat.com>,
        linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        netdev@vger.kernel.org, netfilter-devel@vger.kernel.org
Cc:     Paul Moore <paul@paul-moore.com>, sgrubb@redhat.com,
        omosnace@redhat.com, dhowells@redhat.com, simo@redhat.com,
        eparis@parisplace.org, serge@hallyn.com, ebiederm@xmission.com,
        nhorman@tuxdriver.com, dwalsh@redhat.com, mpatel@redhat.com,
        Richard Guy Briggs <rgb@redhat.com>
Subject: [PATCH ghak90 V8 06/16] audit: log container info of syscalls
Date:   Tue, 31 Dec 2019 14:48:19 -0500
Message-Id: <e222763664c784cef1c9963cfb633fdb9748db09.1577736799.git.rgb@redhat.com>
In-Reply-To: <cover.1577736799.git.rgb@redhat.com>
References: <cover.1577736799.git.rgb@redhat.com>
In-Reply-To: <cover.1577736799.git.rgb@redhat.com>
References: <cover.1577736799.git.rgb@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Create a new audit record AUDIT_CONTAINER_ID to document the audit
container identifier of a process if it is present.

Called from audit_log_exit(), syscalls are covered.

A sample raw event:
type=SYSCALL msg=audit(1519924845.499:257): arch=c000003e syscall=257 success=yes exit=3 a0=ffffff9c a1=56374e1cef30 a2=241 a3=1b6 items=2 ppid=606 pid=635 auid=0 uid=0 gid=0 euid=0 suid=0 fsuid=0 egid=0 sgid=0 fsgid=0 tty=pts0 ses=3 comm="bash" exe="/usr/bin/bash" subj=unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023 key="tmpcontainerid"
type=CWD msg=audit(1519924845.499:257): cwd="/root"
type=PATH msg=audit(1519924845.499:257): item=0 name="/tmp/" inode=13863 dev=00:27 mode=041777 ouid=0 ogid=0 rdev=00:00 obj=system_u:object_r:tmp_t:s0 nametype= PARENT cap_fp=0 cap_fi=0 cap_fe=0 cap_fver=0
type=PATH msg=audit(1519924845.499:257): item=1 name="/tmp/tmpcontainerid" inode=17729 dev=00:27 mode=0100644 ouid=0 ogid=0 rdev=00:00 obj=unconfined_u:object_r:user_tmp_t:s0 nametype=CREATE cap_fp=0 cap_fi=0 cap_fe=0 cap_fver=0
type=PROCTITLE msg=audit(1519924845.499:257): proctitle=62617368002D6300736C65657020313B206563686F2074657374203E202F746D702F746D70636F6E7461696E65726964
type=CONTAINER_ID msg=audit(1519924845.499:257): contid=123458

Please see the github audit kernel issue for the main feature:
  https://github.com/linux-audit/audit-kernel/issues/90
Please see the github audit userspace issue for supporting additions:
  https://github.com/linux-audit/audit-userspace/issues/51
Please see the github audit testsuiite issue for the test case:
  https://github.com/linux-audit/audit-testsuite/issues/64
Please see the github audit wiki for the feature overview:
  https://github.com/linux-audit/audit-kernel/wiki/RFE-Audit-Container-ID
Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
Acked-by: Serge Hallyn <serge@hallyn.com>
Acked-by: Steve Grubb <sgrubb@redhat.com>
Acked-by: Neil Horman <nhorman@tuxdriver.com>
Reviewed-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 include/linux/audit.h      |  5 +++++
 include/uapi/linux/audit.h |  1 +
 kernel/audit.c             | 20 ++++++++++++++++++++
 kernel/auditsc.c           | 20 ++++++++++++++------
 4 files changed, 40 insertions(+), 6 deletions(-)

diff --git a/include/linux/audit.h b/include/linux/audit.h
index 0e6dbe943ae4..2636b0ad0011 100644
--- a/include/linux/audit.h
+++ b/include/linux/audit.h
@@ -216,6 +216,8 @@ static inline u64 audit_get_contid(struct task_struct *tsk)
 	return tsk->audit->cont->id;
 }
 
+extern void audit_log_container_id(struct audit_context *context, u64 contid);
+
 extern u32 audit_enabled;
 
 extern int audit_signal_info(int sig, struct task_struct *t);
@@ -285,6 +287,9 @@ static inline u64 audit_get_contid(struct task_struct *tsk)
 	return AUDIT_CID_UNSET;
 }
 
+static inline void audit_log_container_id(struct audit_context *context, u64 contid)
+{ }
+
 #define audit_enabled AUDIT_OFF
 
 static inline int audit_signal_info(int sig, struct task_struct *t)
diff --git a/include/uapi/linux/audit.h b/include/uapi/linux/audit.h
index 866e1606c4ae..93417a8af9d0 100644
--- a/include/uapi/linux/audit.h
+++ b/include/uapi/linux/audit.h
@@ -117,6 +117,7 @@
 #define AUDIT_FANOTIFY		1331	/* Fanotify access decision */
 #define AUDIT_TIME_INJOFFSET	1332	/* Timekeeping offset injected */
 #define AUDIT_TIME_ADJNTPVAL	1333	/* NTP value adjustment */
+#define AUDIT_CONTAINER_ID	1335	/* Container ID */
 
 #define AUDIT_AVC		1400	/* SE Linux avc denial or grant */
 #define AUDIT_SELINUX_ERR	1401	/* Internal SE Linux Errors */
diff --git a/kernel/audit.c b/kernel/audit.c
index fa8f1aa3a605..0871c3e5d6df 100644
--- a/kernel/audit.c
+++ b/kernel/audit.c
@@ -2156,6 +2156,26 @@ void audit_log_session_info(struct audit_buffer *ab)
 	audit_log_format(ab, "auid=%u ses=%u", auid, sessionid);
 }
 
+/*
+ * audit_log_container_id - report container info
+ * @context: task or local context for record
+ * @contid: container ID to report
+ */
+void audit_log_container_id(struct audit_context *context, u64 contid)
+{
+	struct audit_buffer *ab;
+
+	if (!audit_contid_valid(contid))
+		return;
+	/* Generate AUDIT_CONTAINER_ID record with container ID */
+	ab = audit_log_start(context, GFP_KERNEL, AUDIT_CONTAINER_ID);
+	if (!ab)
+		return;
+	audit_log_format(ab, "contid=%llu", contid);
+	audit_log_end(ab);
+}
+EXPORT_SYMBOL(audit_log_container_id);
+
 void audit_log_key(struct audit_buffer *ab, char *key)
 {
 	audit_log_format(ab, " key=");
diff --git a/kernel/auditsc.c b/kernel/auditsc.c
index bd855794ad26..ac438fcff807 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -1534,7 +1534,7 @@ static void audit_log_exit(void)
 	for (aux = context->aux_pids; aux; aux = aux->next) {
 		struct audit_aux_data_pids *axs = (void *)aux;
 
-		for (i = 0; i < axs->pid_count; i++)
+		for (i = 0; i < axs->pid_count; i++) {
 			if (audit_log_pid_context(context, axs->target_pid[i],
 						  axs->target_auid[i],
 						  axs->target_uid[i],
@@ -1542,14 +1542,20 @@ static void audit_log_exit(void)
 						  axs->target_sid[i],
 						  axs->target_comm[i]))
 				call_panic = 1;
+			audit_log_container_id(context, axs->target_cid[i]);
+		}
 	}
 
-	if (context->target_pid &&
-	    audit_log_pid_context(context, context->target_pid,
-				  context->target_auid, context->target_uid,
-				  context->target_sessionid,
-				  context->target_sid, context->target_comm))
+	if (context->target_pid) {
+		if (audit_log_pid_context(context, context->target_pid,
+					  context->target_auid,
+					  context->target_uid,
+					  context->target_sessionid,
+					  context->target_sid,
+					  context->target_comm))
 			call_panic = 1;
+		audit_log_container_id(context, context->target_cid);
+	}
 
 	if (context->pwd.dentry && context->pwd.mnt) {
 		ab = audit_log_start(context, GFP_KERNEL, AUDIT_CWD);
@@ -1568,6 +1574,8 @@ static void audit_log_exit(void)
 
 	audit_log_proctitle();
 
+	audit_log_container_id(context, audit_get_contid(current));
+
 	audit_log_container_drop();
 
 	/* Send end of event record to help user space know we are finished */
-- 
1.8.3.1

