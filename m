Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFC2C5704B3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Jul 2022 15:53:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230495AbiGKNxL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 Jul 2022 09:53:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230445AbiGKNwu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 Jul 2022 09:52:50 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 102C961DBF
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 Jul 2022 06:52:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657547567;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rop7OK4IumhZoT3E3GNMDnS+35IynqSezhWluPU0kXM=;
        b=L3wGLXEcAT4ZNqu12K0wCQmcnuaWlf5TY1mqdRNw7pixoTDp6EMg9BzZ564LqXnzMc0OUq
        8An0K1saj2Fc2WN4Da7uLq3UlCRz/MO/oubQqSv7Eqvj0zt6O8z/tpG0SDvGF15XUE/ad2
        xS5CvyX8mv26u12v/zem3krMtPYh/kg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-166-fVzmwPV6NGmL3XJbDS8qWQ-1; Mon, 11 Jul 2022 09:52:38 -0400
X-MC-Unique: fVzmwPV6NGmL3XJbDS8qWQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 938C0857A87;
        Mon, 11 Jul 2022 13:52:38 +0000 (UTC)
Received: from bfoster.redhat.com (unknown [10.22.32.24])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6154518ECC;
        Mon, 11 Jul 2022 13:52:38 +0000 (UTC)
From:   Brian Foster <bfoster@redhat.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     ikent@redhat.com, onestero@redhat.com, willy@infradead.org
Subject: [PATCH v2 3/4] pid: tag pids associated with group leader tasks
Date:   Mon, 11 Jul 2022 09:52:36 -0400
Message-Id: <20220711135237.173667-4-bfoster@redhat.com>
In-Reply-To: <20220711135237.173667-1-bfoster@redhat.com>
References: <20220711135237.173667-1-bfoster@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Searching the pid_namespace for group leader tasks is a fairly
inefficient operation. Listing the root directory of a procfs mount
performs a linear scan of allocated pids, checking each entry for an
associated PIDTYPE_TGID task to determine whether to populate a
directory entry. This can cause a significant increase in readdir()
syscall latency when run in namespaces that might have one or more
processes with significant thread counts.

To facilitate improved TGID pid searches, tag the ids of pid entries
that are likely to have an associated PIDTYPE_TGID task. To keep the
code simple and avoid having to maintain synchronization between tag
state and post-fork pid-task association changes, the tag is applied
to all pids allocated for tasks cloned without CLONE_THREAD.

This means that it is possible for a pid to remain tagged in the idr
tree after being disassociated from the group leader task. For
example, a process that does a setsid() followed by fork() and
exit() (to daemonize) will remain associated with the original pid
for the session, but link with the child pid as the group leader.
OTOH, the only place other than fork() where a tgid association
occurs is in the exec() path, which kills all other tasks in the
group and associates the current task with the preexisting leader
pid. Therefore, the semantics of the tag are that false positives
(tagged pids without PIDTYPE_TGID tasks) are possible, but false
negatives (untagged pids without PIDTYPE_TGID tasks) should never
occur.

This is an effective optimization because false negatives are fairly
uncommon and don't add overhead (i.e. we already have to check
pid_task() for tagged entries), but still filters out thread pids
that are guaranteed not to have TGID task association.

Tag entries in the pid allocation path when the caller specifies
that the pid associates with a new thread group. Since false
negatives are not allowed, warn in the event that a PIDTYPE_TGID
task is ever attached to an untagged pid. Finally, create a helper
to implement the task search based on the tag semantics defined
above (based on search logic currently implemented by next_tgid() in
procfs).

Signed-off-by: Brian Foster <bfoster@redhat.com>
---
 include/linux/pid.h |  3 ++-
 kernel/fork.c       |  2 +-
 kernel/pid.c        | 40 +++++++++++++++++++++++++++++++++++++++-
 3 files changed, 42 insertions(+), 3 deletions(-)

diff --git a/include/linux/pid.h b/include/linux/pid.h
index 343abf22092e..64caf21be256 100644
--- a/include/linux/pid.h
+++ b/include/linux/pid.h
@@ -132,9 +132,10 @@ extern struct pid *find_vpid(int nr);
  */
 extern struct pid *find_get_pid(int nr);
 extern struct pid *find_ge_pid(int nr, struct pid_namespace *);
+struct task_struct *find_get_tgid_task(int *id, struct pid_namespace *);
 
 extern struct pid *alloc_pid(struct pid_namespace *ns, pid_t *set_tid,
-			     size_t set_tid_size);
+			     size_t set_tid_size, bool group_leader);
 extern void free_pid(struct pid *pid);
 extern void disable_pid_allocation(struct pid_namespace *ns);
 
diff --git a/kernel/fork.c b/kernel/fork.c
index 9d44f2d46c69..3c52f45ec93e 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -2254,7 +2254,7 @@ static __latent_entropy struct task_struct *copy_process(
 
 	if (pid != &init_struct_pid) {
 		pid = alloc_pid(p->nsproxy->pid_ns_for_children, args->set_tid,
-				args->set_tid_size);
+				args->set_tid_size, !(clone_flags & CLONE_THREAD));
 		if (IS_ERR(pid)) {
 			retval = PTR_ERR(pid);
 			goto bad_fork_cleanup_thread;
diff --git a/kernel/pid.c b/kernel/pid.c
index 2fc0a16ec77b..bd72d1dbff95 100644
--- a/kernel/pid.c
+++ b/kernel/pid.c
@@ -157,7 +157,7 @@ void free_pid(struct pid *pid)
 }
 
 struct pid *alloc_pid(struct pid_namespace *ns, pid_t *set_tid,
-		      size_t set_tid_size)
+		      size_t set_tid_size, bool group_leader)
 {
 	struct pid *pid;
 	enum pid_type type;
@@ -272,6 +272,8 @@ struct pid *alloc_pid(struct pid_namespace *ns, pid_t *set_tid,
 	for ( ; upid >= pid->numbers; --upid) {
 		/* Make the PID visible to find_pid_ns. */
 		idr_replace(&upid->ns->idr, pid, upid->nr);
+		if (group_leader)
+			idr_set_tag(&upid->ns->idr, upid->nr);
 		upid->ns->pid_allocated++;
 	}
 	spin_unlock_irq(&pidmap_lock);
@@ -331,6 +333,10 @@ static struct pid **task_pid_ptr(struct task_struct *task, enum pid_type type)
 void attach_pid(struct task_struct *task, enum pid_type type)
 {
 	struct pid *pid = *task_pid_ptr(task, type);
+	struct pid_namespace *pid_ns = ns_of_pid(pid);
+	pid_t pid_nr = pid_nr_ns(pid, pid_ns);
+
+	WARN_ON(type == PIDTYPE_TGID && !idr_get_tag(&pid_ns->idr, pid_nr));
 	hlist_add_head_rcu(&task->pid_links[type], &pid->tasks[type]);
 }
 
@@ -520,6 +526,38 @@ struct pid *find_ge_pid(int nr, struct pid_namespace *ns)
 	return idr_get_next(&ns->idr, &nr);
 }
 
+/*
+ * Used by proc to find the first thread group leader task with an id greater
+ * than or equal to *id.
+ *
+ * Use the idr tag hint to find the next best pid. The tag does not guarantee a
+ * linked task exists, so retry until a suitable entry is found.
+ */
+struct task_struct *find_get_tgid_task(int *id, struct pid_namespace *ns)
+{
+	struct pid *pid;
+	struct task_struct *t;
+	unsigned int nr = *id;
+
+	rcu_read_lock();
+
+	do {
+		pid = idr_get_next_tag(&ns->idr, nr);
+		if (!pid) {
+			rcu_read_unlock();
+			return NULL;
+		}
+		t = pid_task(pid, PIDTYPE_TGID);
+		nr++;
+	} while (!t);
+
+	*id = pid_nr_ns(pid, ns);
+	get_task_struct(t);
+	rcu_read_unlock();
+
+	return t;
+}
+
 struct pid *pidfd_get_pid(unsigned int fd, unsigned int *flags)
 {
 	struct fd f;
-- 
2.35.3

