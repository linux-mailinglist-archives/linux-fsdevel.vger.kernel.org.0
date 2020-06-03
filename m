Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EE301ED440
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jun 2020 18:24:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726262AbgFCQYg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 3 Jun 2020 12:24:36 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:32311 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726170AbgFCQYf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 3 Jun 2020 12:24:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591201472;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=l5wNWGAWcER1sXm4h1esAhVHOr4X55D6SxvEN9Yk3MA=;
        b=SkytYYha/7/0HkSfFOTG34FCO/Lj1mjwdwFapNqnJQ6QEBqrh0gNsTWEf0oJJwbVpTJ3L8
        +yS+a8UVZDuTr/dJuuWGj+qnhSnpjN5Zs0pStNYSOHIUS7golBY7BV+vPA7TZq8+C192eX
        kyGdLYQd7qakQKOvs44iIspbEyPr3rk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-409-dynHbkedO62XE_42CvQ2hA-1; Wed, 03 Jun 2020 12:24:27 -0400
X-MC-Unique: dynHbkedO62XE_42CvQ2hA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8BBB7185696F;
        Wed,  3 Jun 2020 16:24:23 +0000 (UTC)
Received: from dcbz.redhat.com (ovpn-113-67.ams2.redhat.com [10.36.113.67])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1BB7B19C71;
        Wed,  3 Jun 2020 16:24:18 +0000 (UTC)
From:   Adrian Reber <areber@redhat.com>
To:     Christian Brauner <christian.brauner@ubuntu.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Pavel Emelyanov <ovzxemul@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Andrei Vagin <avagin@gmail.com>,
        Nicolas Viennot <Nicolas.Viennot@twosigma.com>,
        =?UTF-8?q?Micha=C5=82=20C=C5=82api=C5=84ski?= 
        <mclapinski@google.com>, Kamil Yurtsever <kyurtsever@google.com>,
        Dirk Petersen <dipeit@gmail.com>,
        Christine Flood <chf@redhat.com>,
        Casey Schaufler <casey@schaufler-ca.com>
Cc:     Mike Rapoport <rppt@linux.ibm.com>,
        Radostin Stoyanov <rstoyanov1@gmail.com>,
        Adrian Reber <areber@redhat.com>,
        Cyrill Gorcunov <gorcunov@openvz.org>,
        Serge Hallyn <serge@hallyn.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Sargun Dhillon <sargun@sargun.me>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, selinux@vger.kernel.org,
        Eric Paris <eparis@parisplace.org>,
        Jann Horn <jannh@google.com>, linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 1/3] capabilities: Introduce CAP_CHECKPOINT_RESTORE
Date:   Wed,  3 Jun 2020 18:23:26 +0200
Message-Id: <20200603162328.854164-2-areber@redhat.com>
In-Reply-To: <20200603162328.854164-1-areber@redhat.com>
References: <20200603162328.854164-1-areber@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This patch introduces CAP_CHECKPOINT_RESTORE, a new capability facilitating
checkpoint/restore for non-root users.

Over the last years, The CRIU (Checkpoint/Restore In Userspace) team has been
asked numerous times if it is possible to checkpoint/restore a process as
non-root. The answer usually was: 'almost'.

The main blocker to restore a process as non-root was to control the PID of the
restored process. This feature available via the clone3 system call, or via
/proc/sys/kernel/ns_last_pid is unfortunately guarded by CAP_SYS_ADMIN.

In the past two years, requests for non-root checkpoint/restore have increased
due to the following use cases:
* Checkpoint/Restore in an HPC environment in combination with a resource
  manager distributing jobs where users are always running as non-root.
  There is a desire to provide a way to checkpoint and restore long running
  jobs.
* Container migration as non-root
* We have been in contact with JVM developers who are integrating
  CRIU into a Java VM to decrease the startup time. These checkpoint/restore
  applications are not meant to be running with CAP_SYS_ADMIN.

We have seen the following workarounds:
* Use a setuid wrapper around CRIU:
  See https://github.com/FredHutch/slurm-examples/blob/master/checkpointer/lib/checkpointer/checkpointer-suid.c
* Use a setuid helper that writes to ns_last_pid.
  Unfortunately, this helper delegation technique is impossible to use with
  clone3, and is thus prone to races.
  See https://github.com/twosigma/set_ns_last_pid
* Cycle through PIDs with fork() until the desired PID is reached:
  This has been demonstrated to work with cycling rates of 100,000 PIDs/s
  See https://github.com/twosigma/set_ns_last_pid
* Patch out the CAP_SYS_ADMIN check from the kernel
* Run the desired application in a new user and PID namespace to provide
  a local CAP_SYS_ADMIN for controlling PIDs. This technique has limited use in
  typical container environments (e.g., Kubernetes) as /proc is
  typically protected with read-only layers (e.g., /proc/sys) for hardening
  purposes. Read-only layers prevent additional /proc mounts (due to proc's
  SB_I_USERNS_VISIBLE property), making the use of new PID namespaces limited as
  certain applications need access to /proc matching their PID namespace.

The introduced capability allows to:
* Control PIDs when the current user is CAP_CHECKPOINT_RESTORE capable
  for the corresponding PID namespace via ns_last_pid/clone3.
* Open files in /proc/pid/map_files when the current user is
  CAP_CHECKPOINT_RESTORE capable in the root namespace, useful for recovering
  files that are unreachable via the file system such as deleted files, or memfd
  files.

See corresponding selftest for an example with clone3().

Signed-off-by: Adrian Reber <areber@redhat.com>
Signed-off-by: Nicolas Viennot <Nicolas.Viennot@twosigma.com>
---
v2:
 - Renamed CAP_RESTORE to CAP_CHECKPOINT_RESTORE
 - Added a test
 - Added details about CRIU's use of map_files
 - Allow changing /proc/self/exe link with CAP_CHECKPOINT_RESTORE
---
 fs/proc/base.c                      | 8 ++++----
 include/linux/capability.h          | 6 ++++++
 include/uapi/linux/capability.h     | 9 ++++++++-
 kernel/pid.c                        | 2 +-
 kernel/pid_namespace.c              | 2 +-
 security/selinux/include/classmap.h | 5 +++--
 6 files changed, 23 insertions(+), 9 deletions(-)

diff --git a/fs/proc/base.c b/fs/proc/base.c
index d86c0afc8a85..ce02f3a4b2d7 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -2189,16 +2189,16 @@ struct map_files_info {
 };
 
 /*
- * Only allow CAP_SYS_ADMIN to follow the links, due to concerns about how the
- * symlinks may be used to bypass permissions on ancestor directories in the
- * path to the file in question.
+ * Only allow CAP_SYS_ADMIN and CAP_CHECKPOINT_RESTORE to follow the links, due
+ * to concerns about how the symlinks may be used to bypass permissions on
+ * ancestor directories in the path to the file in question.
  */
 static const char *
 proc_map_files_get_link(struct dentry *dentry,
 			struct inode *inode,
 		        struct delayed_call *done)
 {
-	if (!capable(CAP_SYS_ADMIN))
+	if (!(capable(CAP_SYS_ADMIN) || capable(CAP_CHECKPOINT_RESTORE)))
 		return ERR_PTR(-EPERM);
 
 	return proc_pid_get_link(dentry, inode, done);
diff --git a/include/linux/capability.h b/include/linux/capability.h
index b4345b38a6be..1e7fe311cabe 100644
--- a/include/linux/capability.h
+++ b/include/linux/capability.h
@@ -261,6 +261,12 @@ static inline bool bpf_capable(void)
 	return capable(CAP_BPF) || capable(CAP_SYS_ADMIN);
 }
 
+static inline bool checkpoint_restore_ns_capable(struct user_namespace *ns)
+{
+	return ns_capable(ns, CAP_CHECKPOINT_RESTORE) ||
+		ns_capable(ns, CAP_SYS_ADMIN);
+}
+
 /* audit system wants to get cap info from files as well */
 extern int get_vfs_caps_from_disk(const struct dentry *dentry, struct cpu_vfs_cap_data *cpu_caps);
 
diff --git a/include/uapi/linux/capability.h b/include/uapi/linux/capability.h
index 48ff0757ae5e..395dd0df8d08 100644
--- a/include/uapi/linux/capability.h
+++ b/include/uapi/linux/capability.h
@@ -408,7 +408,14 @@ struct vfs_ns_cap_data {
  */
 #define CAP_BPF			39
 
-#define CAP_LAST_CAP         CAP_BPF
+
+/* Allow checkpoint/restore related operations */
+/* Allow PID selection during clone3() */
+/* Allow writing to ns_last_pid */
+
+#define CAP_CHECKPOINT_RESTORE	40
+
+#define CAP_LAST_CAP         CAP_CHECKPOINT_RESTORE
 
 #define cap_valid(x) ((x) >= 0 && (x) <= CAP_LAST_CAP)
 
diff --git a/kernel/pid.c b/kernel/pid.c
index 3122043fe364..ada55c7b2b19 100644
--- a/kernel/pid.c
+++ b/kernel/pid.c
@@ -198,7 +198,7 @@ struct pid *alloc_pid(struct pid_namespace *ns, pid_t *set_tid,
 			if (tid != 1 && !tmp->child_reaper)
 				goto out_free;
 			retval = -EPERM;
-			if (!ns_capable(tmp->user_ns, CAP_SYS_ADMIN))
+			if (!checkpoint_restore_ns_capable(tmp->user_ns))
 				goto out_free;
 			set_tid_size--;
 		}
diff --git a/kernel/pid_namespace.c b/kernel/pid_namespace.c
index 0e5ac162c3a8..ac135bd600eb 100644
--- a/kernel/pid_namespace.c
+++ b/kernel/pid_namespace.c
@@ -269,7 +269,7 @@ static int pid_ns_ctl_handler(struct ctl_table *table, int write,
 	struct ctl_table tmp = *table;
 	int ret, next;
 
-	if (write && !ns_capable(pid_ns->user_ns, CAP_SYS_ADMIN))
+	if (write && !checkpoint_restore_ns_capable(pid_ns->user_ns))
 		return -EPERM;
 
 	/*
diff --git a/security/selinux/include/classmap.h b/security/selinux/include/classmap.h
index 98e1513b608a..40cebde62856 100644
--- a/security/selinux/include/classmap.h
+++ b/security/selinux/include/classmap.h
@@ -27,9 +27,10 @@
 	    "audit_control", "setfcap"
 
 #define COMMON_CAP2_PERMS  "mac_override", "mac_admin", "syslog", \
-		"wake_alarm", "block_suspend", "audit_read", "perfmon", "bpf"
+		"wake_alarm", "block_suspend", "audit_read", "perfmon", "bpf", \
+		"checkpoint_restore"
 
-#if CAP_LAST_CAP > CAP_BPF
+#if CAP_LAST_CAP > CAP_CHECKPOINT_RESTORE
 #error New capability defined, please update COMMON_CAP2_PERMS.
 #endif
 
-- 
2.26.2

