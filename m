Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0225C54B852
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Jun 2022 20:10:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343886AbiFNSJy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Jun 2022 14:09:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245502AbiFNSJx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Jun 2022 14:09:53 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8B36D3F8A6
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Jun 2022 11:09:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655230191;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CsdcR2rHWMCCKyL47D03FvUoZIC1ppi2VFdhmhI3LlA=;
        b=XF6rkcNUVh2VIzwBklDaVMdls9HDnIO9tqIrBo3g0elNLHLPpAucfIKKwAab1T5Jv06mDe
        T8BOrDaOhSThJ8St3EBDtG21RLQUJ1KG2GaUZjdl7OlzUeZinHWF3l4mS7UPdDc6QMF9si
        c2yYWP6j9isXdpZAdvqz1ciTU7HyCIU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-638-rSLMswUmPuKdxuF31sOhNw-1; Tue, 14 Jun 2022 14:09:50 -0400
X-MC-Unique: rSLMswUmPuKdxuF31sOhNw-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 44F70804197;
        Tue, 14 Jun 2022 18:09:50 +0000 (UTC)
Received: from bfoster.redhat.com (unknown [10.22.16.60])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 183BE492C3B;
        Tue, 14 Jun 2022 18:09:50 +0000 (UTC)
From:   Brian Foster <bfoster@redhat.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     ikent@redhat.com, onestero@redhat.com
Subject: [PATCH 2/3] pid: use idr tag to hint pids associated with group leader tasks
Date:   Tue, 14 Jun 2022 14:09:48 -0400
Message-Id: <20220614180949.102914-3-bfoster@redhat.com>
In-Reply-To: <20220614180949.102914-1-bfoster@redhat.com>
References: <20220614180949.102914-1-bfoster@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.9
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Searching the pid_namespace for group leader tasks is a fairly
inefficient operation. Listing the root directory of a procfs mount
performs a linear walk of allocated pids, checking each for an
associated PIDTYPE_TGID task to determine whether to populate a
directory entry. This can cause a significant increase in readdir()
syscall latency when run in runtime environments that might have one
or more processes with significant thread counts.

To facilitate improved TGID pid searches, define a new IDR
radix-tree tag for struct pid entries that are likely to have an
associated PIDTYPE_TGID task. To keep the code simple and avoid
having to maintain synchronization between tag state and post-fork
pid-task association changes, the tag is applied to all pids
initially allocated for tasks that are cloned without CLONE_THREAD.
The semantics of the tag are thus that false positives are possible
(i.e. tagged pids without PIDTYPE_TGID tasks), but false negatives
(i.e. untagged pids without PIDTYPE_TGID tasks) are not allowed.

For example, a userspace task that does a setsid() followed by a
fork() and exit() in the initial task will leave the initial pid
tagged (as it remains allocated for the PIDTYPE_SID association)
while the group leader task associates with the pid allocated for
the child fork. Once set, the tag persists for the lifetime of the
pid and is cleared when the pid is freed and associated entry
removed from the idr tree.

This is an effective optimization because false negatives are
relatively uncommon, essentially don't add any overhead that doesn't
already exist (i.e. having to check pid_task(..., PIDTYPE_TGID), but
still allows filtering out large numbers of thread pids that are
guaranteed to not have TGID task association.

Define the new IDR_TGID radix tree tag and provide a couple helpers
to set and check tag state. Set the tag in the allocation path when
the caller specifies that the pid is expected to track a group
leader. Since false negatives are not allowed, warn in the event
that a PIDTYPE_TGID task is ever attached to an untagged pid.

Signed-off-by: Brian Foster <bfoster@redhat.com>
---
 include/linux/idr.h | 11 +++++++++++
 include/linux/pid.h |  2 +-
 kernel/fork.c       |  2 +-
 kernel/pid.c        |  9 ++++++++-
 4 files changed, 21 insertions(+), 3 deletions(-)

diff --git a/include/linux/idr.h b/include/linux/idr.h
index a0dce14090a9..11e0ccedfc92 100644
--- a/include/linux/idr.h
+++ b/include/linux/idr.h
@@ -27,6 +27,7 @@ struct idr {
  * to users.  Use tag 0 to track whether a node has free space below it.
  */
 #define IDR_FREE	0
+#define IDR_TGID	1
 
 /* Set the IDR flag and the IDR_FREE tag */
 #define IDR_RT_MARKER	(ROOT_IS_IDR | (__force gfp_t)			\
@@ -174,6 +175,16 @@ static inline void idr_preload_end(void)
 	local_unlock(&radix_tree_preloads.lock);
 }
 
+static inline void idr_set_group_lead(struct idr *idr, unsigned long id)
+{
+	radix_tree_tag_set(&idr->idr_rt, id, IDR_TGID);
+}
+
+static inline bool idr_is_group_lead(struct idr *idr, unsigned long id)
+{
+	return radix_tree_tag_get(&idr->idr_rt, id, IDR_TGID);
+}
+
 /**
  * idr_for_each_entry() - Iterate over an IDR's elements of a given type.
  * @idr: IDR handle.
diff --git a/include/linux/pid.h b/include/linux/pid.h
index 343abf22092e..31f3cf765cee 100644
--- a/include/linux/pid.h
+++ b/include/linux/pid.h
@@ -134,7 +134,7 @@ extern struct pid *find_get_pid(int nr);
 extern struct pid *find_ge_pid(int nr, struct pid_namespace *);
 
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
index 2fc0a16ec77b..5a745c35475e 100644
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
+			idr_set_group_lead(&upid->ns->idr, upid->nr);
 		upid->ns->pid_allocated++;
 	}
 	spin_unlock_irq(&pidmap_lock);
@@ -331,6 +333,11 @@ static struct pid **task_pid_ptr(struct task_struct *task, enum pid_type type)
 void attach_pid(struct task_struct *task, enum pid_type type)
 {
 	struct pid *pid = *task_pid_ptr(task, type);
+	struct pid_namespace *pid_ns = ns_of_pid(pid);
+	pid_t pid_nr = pid_nr_ns(pid, pid_ns);
+
+	WARN_ON(type == PIDTYPE_TGID &&
+		!idr_is_group_lead(&pid_ns->idr, pid_nr));
 	hlist_add_head_rcu(&task->pid_links[type], &pid->tasks[type]);
 }
 
-- 
2.34.1

