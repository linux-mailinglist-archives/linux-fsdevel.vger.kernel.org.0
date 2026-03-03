Return-Path: <linux-fsdevel+bounces-79223-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gKoLEIPnpmlWZgAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79223-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Mar 2026 14:52:03 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D628C1F0C50
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Mar 2026 14:52:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 216B13052DA8
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Mar 2026 13:50:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EAF435C1AD;
	Tue,  3 Mar 2026 13:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NA8BjHMy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FC9335BDCB;
	Tue,  3 Mar 2026 13:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772545769; cv=none; b=ueVPNPzT11VN+is64JTV8A+MXBHF2E1bvTSqA39KkHoN/5JNil8tCxfhhNsM32VEHe9AxEFU1PEGyYzrHhRNIdAbyFY6j3UrBbh9YtvSdUWZOtHApCR+w9l2nSSBt6rVr5WscCRx2zw9b9QDfIushVAdtp7A6YfPIlJYvQ8QuLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772545769; c=relaxed/simple;
	bh=/f8YATYhS0KcmnbHrVL7/juOKyb+2GwTV5/gywiNp5o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Gz35jA+nh5ptPOohJBZj9Vqa8oIrpdMXuTu5TR+JDfy6PKWS4lqQuhMDTia1Nxx9eoUf4z7YVV+ITKHJKzXDKi6M7r5tsiDz4GH5ZfZ//lN3ntRmqU5tuxZUVr17gao589gPet5GdwsyOjMycEcBBr0fYHhC2IZFQlu1rMPekt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NA8BjHMy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65797C116C6;
	Tue,  3 Mar 2026 13:49:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772545768;
	bh=/f8YATYhS0KcmnbHrVL7/juOKyb+2GwTV5/gywiNp5o=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=NA8BjHMym9Yb2haF8WM9w0xcIXLD5G2JVRqS38O8cenvLpqLGQSfRUvDEl+/ANEBL
	 TWAa7GYUpx4rpMVEpW0BTh/6qGd/Li55L7VxyxyLJORmeAVmZ8Aurp7uOKbUyl4pi0
	 uv8usSYsYtSLI81zUjeTMHw39KZVRV2JwvzExLf0S0Q0RIXsEM0AwZQ63JgkWEwZR2
	 mP46lt8V2EGXfK2XeY3hHe+wFCpGACEbghMxVfE0go1QuHUuFOjmuMRYoQOj5i6GZw
	 UXiBD1el/o79JbhTWZCuKha8q0xPr7uvHUkqLJWCUPay5wuL9c2K9g8ByY3p8AsAtf
	 KVRrNEcW48EPg==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 03 Mar 2026 14:49:14 +0100
Subject: [PATCH RFC DRAFT POC 03/11] kthread: add extensible
 kthread_create()/kthread_run() pattern
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260303-work-kthread-nullfs-v1-3-87e559b94375@kernel.org>
References: <20260303-work-kthread-nullfs-v1-0-87e559b94375@kernel.org>
In-Reply-To: <20260303-work-kthread-nullfs-v1-0-87e559b94375@kernel.org>
To: linux-fsdevel@vger.kernel.org, 
 Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>, 
 Tejun Heo <tj@kernel.org>, Jann Horn <jannh@google.com>, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-47773
X-Developer-Signature: v=1; a=openpgp-sha256; l=9767; i=brauner@kernel.org;
 h=from:subject:message-id; bh=/f8YATYhS0KcmnbHrVL7/juOKyb+2GwTV5/gywiNp5o=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQue3aPaf7B6+kBrY0Tzjrf0l/tkvSl8o1e+qwKw5vZ9
 onC/2fv7ihlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZgIy1KGv1Ityxbyvr2/cRej
 +fsVh7d+vmP0NqFHwblko0cGn0x7rjjDP4t+X7c5+df3mO81MthsN/VqyN2Nl0qFdhQw2eme65g
 lwQMA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
X-Rspamd-Queue-Id: D628C1F0C50
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-79223-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[brauner@kernel.org,linux-fsdevel@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Action: no action

This is similar to what I did for kmem_cache_create() in
b2e7456b5c25 ("slab: create kmem_cache_create() compatibility layer").
Instead of piling on new variants of the functions add a struct
kthread_args variant that just passes the relevant paramter.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 include/linux/kthread.h | 69 +++++++++++++++++++++++++++-------------
 kernel/kthread.c        | 83 +++++++++++++++++++++++++++++++++++++++++--------
 2 files changed, 118 insertions(+), 34 deletions(-)

diff --git a/include/linux/kthread.h b/include/linux/kthread.h
index 2630791295ac..972cb2960b61 100644
--- a/include/linux/kthread.h
+++ b/include/linux/kthread.h
@@ -25,26 +25,53 @@ static inline struct kthread *tsk_is_kthread(struct task_struct *p)
 	return NULL;
 }
 
+/**
+ * struct kthread_args - kthread creation parameters.
+ * @threadfn: the function to run in the kthread.
+ * @data: data pointer passed to @threadfn.
+ * @node: NUMA node for stack/task allocation (NUMA_NO_NODE for any).
+ * @kthread_worker: set to 1 to create a kthread worker.
+ *
+ * Pass a pointer to this struct as the first argument of kthread_create()
+ * or kthread_run() to use the struct-based creation path.  Legacy callers
+ * that pass a function pointer as the first argument continue to work
+ * unchanged via _Generic dispatch.
+ */
+struct kthread_args {
+	int (*threadfn)(void *data);
+	void *data;
+	int node;
+	u32 kthread_worker:1;
+};
+
 __printf(4, 5)
 struct task_struct *kthread_create_on_node(int (*threadfn)(void *data),
 					   void *data,
 					   int node,
 					   const char namefmt[], ...);
 
+__printf(2, 3)
+struct task_struct *kthread_create_on_info(struct kthread_args *kargs,
+					   const char namefmt[], ...);
+
+__printf(3, 4)
+struct task_struct *__kthread_create(int (*threadfn)(void *data),
+				     void *data,
+				     const char namefmt[], ...);
+
 /**
- * kthread_create - create a kthread on the current node
- * @threadfn: the function to run in the thread
- * @data: data pointer for @threadfn()
- * @namefmt: printf-style format string for the thread name
- * @arg: arguments for @namefmt.
+ * kthread_create - create a kthread on the current node.
+ * @first: either a function pointer (legacy) or a &struct kthread_args
+ *         pointer (struct-based).
  *
- * This macro will create a kthread on the current node, leaving it in
- * the stopped state.  This is just a helper for kthread_create_on_node();
- * see the documentation there for more details.
+ * _Generic dispatch: when @first is a &struct kthread_args pointer the
+ * call is forwarded to kthread_create_on_info(); otherwise it goes through
+ * __kthread_create() which wraps kthread_create_on_node() with NUMA_NO_NODE.
  */
-#define kthread_create(threadfn, data, namefmt, arg...) \
-	kthread_create_on_node(threadfn, data, NUMA_NO_NODE, namefmt, ##arg)
-
+#define kthread_create(__first, ...)					\
+	_Generic((__first),						\
+		struct kthread_args *: kthread_create_on_info,	\
+		default: __kthread_create)(__first, __VA_ARGS__)
 
 struct task_struct *kthread_create_on_cpu(int (*threadfn)(void *data),
 					  void *data,
@@ -59,20 +86,20 @@ bool kthread_is_per_cpu(struct task_struct *k);
 
 /**
  * kthread_run - create and wake a thread.
- * @threadfn: the function to run until signal_pending(current).
- * @data: data ptr for @threadfn.
- * @namefmt: printf-style name for the thread.
+ * @first: either a function pointer (legacy) or a &struct kthread_args
+ *         pointer (struct-based).  Remaining arguments are forwarded to
+ *         kthread_create().
  *
  * Description: Convenient wrapper for kthread_create() followed by
  * wake_up_process().  Returns the kthread or ERR_PTR(-ENOMEM).
  */
-#define kthread_run(threadfn, data, namefmt, ...)			   \
-({									   \
-	struct task_struct *__k						   \
-		= kthread_create(threadfn, data, namefmt, ## __VA_ARGS__); \
-	if (!IS_ERR(__k))						   \
-		wake_up_process(__k);					   \
-	__k;								   \
+#define kthread_run(__first, ...)					\
+({									\
+	struct task_struct *__k						\
+		= kthread_create(__first, __VA_ARGS__);			\
+	if (!IS_ERR(__k))						\
+		wake_up_process(__k);					\
+	__k;								\
 })
 
 /**
diff --git a/kernel/kthread.c b/kernel/kthread.c
index 4c60c8082126..20ec96142ce6 100644
--- a/kernel/kthread.c
+++ b/kernel/kthread.c
@@ -38,8 +38,7 @@ struct task_struct *kthreadd_task;
 static LIST_HEAD(kthread_affinity_list);
 static DEFINE_MUTEX(kthread_affinity_lock);
 
-struct kthread_create_info
-{
+struct kthread_create_req {
 	/* Information passed to kthread() from kthreadd. */
 	char *full_name;
 	int (*threadfn)(void *data);
@@ -382,7 +381,7 @@ static int kthread(void *_create)
 {
 	static const struct sched_param param = { .sched_priority = 0 };
 	/* Copy data: it's on kthread's stack */
-	struct kthread_create_info *create = _create;
+	struct kthread_create_req *create = _create;
 	int (*threadfn)(void *data) = create->threadfn;
 	void *data = create->data;
 	struct completion *done;
@@ -449,7 +448,7 @@ int tsk_fork_get_node(struct task_struct *tsk)
 	return NUMA_NO_NODE;
 }
 
-static void create_kthread(struct kthread_create_info *create)
+static void create_kthread(struct kthread_create_req *create)
 {
 	int pid;
 	struct kernel_clone_args args = {
@@ -480,20 +479,23 @@ static void create_kthread(struct kthread_create_info *create)
 	}
 }
 
-static struct task_struct *__kthread_create_on_node(const struct kthread_create_info *info,
+static struct task_struct *__kthread_create_on_node(const struct kthread_args *kargs,
 						    const char namefmt[],
 						    va_list args)
 {
 	DECLARE_COMPLETION_ONSTACK(done);
 	struct kthread_worker *worker = NULL;
 	struct task_struct *task;
-	struct kthread_create_info *create;
+	struct kthread_create_req *create;
 
 	create = kmalloc_obj(*create);
 	if (!create)
 		return ERR_PTR(-ENOMEM);
 
-	*create = *info;
+	create->threadfn	= kargs->threadfn;
+	create->data		= kargs->data;
+	create->node		= kargs->node;
+	create->kthread_worker	= kargs->kthread_worker;
 
 	if (create->kthread_worker) {
 		worker = kzalloc_obj(*worker);
@@ -573,7 +575,7 @@ struct task_struct *kthread_create_on_node(int (*threadfn)(void *data),
 					   const char namefmt[],
 					   ...)
 {
-	struct kthread_create_info info = {
+	struct kthread_args kargs = {
 		.threadfn	= threadfn,
 		.data		= data,
 		.node		= node,
@@ -582,13 +584,68 @@ struct task_struct *kthread_create_on_node(int (*threadfn)(void *data),
 	va_list args;
 
 	va_start(args, namefmt);
-	task = __kthread_create_on_node(&info, namefmt, args);
+	task = __kthread_create_on_node(&kargs, namefmt, args);
 	va_end(args);
 
 	return task;
 }
 EXPORT_SYMBOL(kthread_create_on_node);
 
+/**
+ * kthread_create_on_info - create a kthread from a struct kthread_args.
+ * @kargs: kthread creation parameters.
+ * @namefmt: printf-style name for the thread.
+ *
+ * This is the struct-based kthread creation path, dispatched via the
+ * kthread_create() _Generic macro when the first argument is a
+ * &struct kthread_args pointer.
+ *
+ * Returns a task_struct or ERR_PTR(-ENOMEM) or ERR_PTR(-EINTR).
+ */
+struct task_struct *kthread_create_on_info(struct kthread_args *kargs,
+					   const char namefmt[], ...)
+{
+	struct task_struct *task;
+	va_list args;
+
+	va_start(args, namefmt);
+	task = __kthread_create_on_node(kargs, namefmt, args);
+	va_end(args);
+
+	return task;
+}
+EXPORT_SYMBOL(kthread_create_on_info);
+
+/**
+ * __kthread_create - create a kthread (legacy positional-argument path).
+ * @threadfn: the function to run until signal_pending(current).
+ * @data: data ptr for @threadfn.
+ * @namefmt: printf-style name for the thread.
+ *
+ * _Generic dispatch target for kthread_create() when the first argument
+ * is a function pointer rather than a &struct kthread_args.
+ *
+ * Returns a task_struct or ERR_PTR(-ENOMEM) or ERR_PTR(-EINTR).
+ */
+struct task_struct *__kthread_create(int (*threadfn)(void *data),
+				     void *data, const char namefmt[], ...)
+{
+	struct kthread_args kargs = {
+		.threadfn	= threadfn,
+		.data		= data,
+		.node		= NUMA_NO_NODE,
+	};
+	struct task_struct *task;
+	va_list args;
+
+	va_start(args, namefmt);
+	task = __kthread_create_on_node(&kargs, namefmt, args);
+	va_end(args);
+
+	return task;
+}
+EXPORT_SYMBOL(__kthread_create);
+
 static void __kthread_bind_mask(struct task_struct *p, const struct cpumask *mask, unsigned int state)
 {
 	if (!wait_task_inactive(p, state)) {
@@ -833,10 +890,10 @@ int kthreadd(void *unused)
 
 		spin_lock(&kthread_create_lock);
 		while (!list_empty(&kthread_create_list)) {
-			struct kthread_create_info *create;
+			struct kthread_create_req *create;
 
 			create = list_entry(kthread_create_list.next,
-					    struct kthread_create_info, list);
+					    struct kthread_create_req, list);
 			list_del_init(&create->list);
 			spin_unlock(&kthread_create_lock);
 
@@ -1080,7 +1137,7 @@ EXPORT_SYMBOL_GPL(kthread_worker_fn);
 struct kthread_worker *
 kthread_create_worker_on_node(int node, const char namefmt[], ...)
 {
-	struct kthread_create_info info = {
+	struct kthread_args kargs = {
 		.node		= node,
 		.kthread_worker	= 1,
 	};
@@ -1089,7 +1146,7 @@ kthread_create_worker_on_node(int node, const char namefmt[], ...)
 	va_list args;
 
 	va_start(args, namefmt);
-	task = __kthread_create_on_node(&info, namefmt, args);
+	task = __kthread_create_on_node(&kargs, namefmt, args);
 	va_end(args);
 
 	if (IS_ERR(task))

-- 
2.47.3


