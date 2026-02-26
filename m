Return-Path: <linux-fsdevel+bounces-78459-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +FlANiwYoGmzfgQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78459-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 10:53:48 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E88991A3CB7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 10:53:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 24865308ED63
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 09:48:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12AF13128B8;
	Thu, 26 Feb 2026 09:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j1V3XPIU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95B2623C8A0
	for <linux-fsdevel@vger.kernel.org>; Thu, 26 Feb 2026 09:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772099280; cv=none; b=H1qDjQHkBqh8Ct/efFkrFQiJZxQP+CE6e6VP6eH1lZnYA5BLQ0uH/KFPDS8K2TvCmxVHFzSeHk7nDJFI/bEMTG8ux+cM7dqqKjPudks5p5EBQ0/W2bbCw/tvYOLJy3yKN4vwm9dCUDrsIfIrvF58HFa4pdshafe/eZqZsHrd1Ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772099280; c=relaxed/simple;
	bh=y2O+F3r32zpRTS07ZL9mL6TauRC+5sjw3M7oRZHqtVU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rZ7r4OhWRPhbHcClkGAQMlsRtBp2O4yuHyE7OOXPtm+ySyCPt4HU62OI86NW3dMJHYaNC+2b1auwqjdPAJif//PL8XGDc6fyfy7Eqqr/82DJS2HmbX7pi38arawmRJCzoXW2IMrefYw2UmgRgllz9OBeowQIK1vuWLIZpYxhdZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j1V3XPIU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF0B7C19422;
	Thu, 26 Feb 2026 09:47:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772099280;
	bh=y2O+F3r32zpRTS07ZL9mL6TauRC+5sjw3M7oRZHqtVU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=j1V3XPIUsIw5Jb2ddvwLEbn9zfI9RBzyNKCzTbNh5ORX6M/S7kQfXIx6PahvGtRrt
	 b78P9Sq96uv9XjOY/amsJM36RstYkmS9sGPKsRkPy7O/rmQd6QF+6M6igeWTgBhIzk
	 Hezzvp3QutxlUo0S7zHemGZ+3YDEUg01GL5CZHHB8M5rPr7dm4i41Xrkt0Xi+ieQg8
	 HT/Mv2zD5XmyUl0dKyCsjs9SAo/tRhFTaMUtyb5psM48KE+Rk/H+5qoA4a8zSCEG/k
	 hgVj1CK6WtuVv6xomgFzZQwwxD0EHthb+GMAqagCYnJH+r2FOU0jvpY8804qsCZvB/
	 lmbfqlLakK57Q==
Date: Thu, 26 Feb 2026 10:47:55 +0100
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Guillaume Tucker <gtucker@gtucker.io>, Tejun Heo <tj@kernel.org>, 
	Mateusz Guzik <mjguzik@gmail.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, Mark Brown <broonie@kernel.org>, 
	kunit-dev@googlegroups.com, David Gow <davidgow@google.com>
Subject: Re: make_task_dead() & kthread_exit()
Message-ID: <20260226-ungeziefer-erzfeind-13425179c7b2@brauner>
References: <20260120-work-pidfs-rhashtable-v2-1-d593c4d0f576@kernel.org>
 <0150e237-41d2-40ae-a857-4f97ca664468@gtucker.io>
 <20260224-kurzgeschichten-urteil-976e57a38c5c@brauner>
 <20260224-mittlerweile-besessen-2738831ae7f6@brauner>
 <CAHk-=whEtuxXcgYLZPk1_mWd2VsLP2WPPCOr5fjPb2SpDsYdew@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="weeg7swa4awjafyy"
Content-Disposition: inline
In-Reply-To: <CAHk-=whEtuxXcgYLZPk1_mWd2VsLP2WPPCOr5fjPb2SpDsYdew@mail.gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[multipart/mixed,text/plain,text/x-diff];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-78459-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[gtucker.io,kernel.org,gmail.com,zeniv.linux.org.uk,suse.cz,vger.kernel.org,googlegroups.com,google.com];
	MIME_TRACE(0.00)[0:+,1:+,2:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[brauner@kernel.org,linux-fsdevel@vger.kernel.org];
	HAS_ATTACHMENT(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux-foundation.org:email,gtucker.io:email]
X-Rspamd-Queue-Id: E88991A3CB7
X-Rspamd-Action: no action


--weeg7swa4awjafyy
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

On Tue, Feb 24, 2026 at 11:30:57AM -0800, Linus Torvalds wrote:
> On Tue, 24 Feb 2026 at 08:25, Christian Brauner <brauner@kernel.org> wrote:
> >
> > If a kthread exits via a path that bypasses kthread_exit() (e.g.,
> > make_task_dead() after an oops -- which calls do_exit() directly),
> > the affinity_node remains in the global kthread_affinity_list. When
> > free_kthread_struct() later frees the kthread struct, the linked list
> > still references the freed memory. Any subsequent list_del() by another
> > kthread in kthread_exit() writes to the freed memory:
> 
> Ugh.
> 
> So this is nasty, but I really detest the suggested fix. It just
> smells wrong to have that affinity_node cleanup done in two different
> places depending on how the exit is done.
> 
> IOW, I think the proper fix would be to just make sure that
> kthread_exit() isn't actually ever bypassed.
> 
> Because looking at this, there are other issues with do_exit() killing
> a kthread - it currently also means that kthread->result randomly
> doesn't get set, for example, so kthread_stop() would appear to
> basically return garbage.
> 
> No, nobody likely cares about the kthread_stop() return value for that
> case, but it's an example of the same kind of "two different exit
> paths, inconsistent data structures" issue.
> 
> How about something like the attached, in other words?
> 
> NOTE NOTE NOTE! This is *entirely* untested. It might do unspeakable
> things to your pets, so please check it. I'm sending this patch out as
> a "I really would prefer this kind of approach" example, not as
> anything more than that.
> 
> Because I really think the core fundamental problem was that there
> were two different exit paths that did different things, and we
> shouldn't try to fix the symptoms of that problem, but instead really
> fix the core issue.
> 
> Hmm?
> 
> Side note: while writing this suggested patch, I do note that this
> comment is wrong:
> 
>  * When "(p->flags & PF_KTHREAD)" is set the task is a kthread and will
>  * always remain a kthread.  For kthreads p->worker_private always
>  * points to a struct kthread.  For tasks that are not kthreads
>  * p->worker_private is used to point to other things.
> 
> because 'init_task' is marked as PF_KTHREAD, but does *not* have a
> p->worker_private.
> 
> Anyway, that doesn't affect this particular code, but it might be
> worth thinking about.

Oh nice.
I was kinda hoping Tejun would jump on this one and so just pointed to
one potential way to fix it but didn't really spend time on it.

Anyway, let's just take what you proposed and slap a commit message on
it. Fwiw, init_task does have ->worker_private it just gets set later
during sched_init():

          /*
           * The idle task doesn't need the kthread struct to function, but it
           * is dressed up as a per-CPU kthread and thus needs to play the part
           * if we want to avoid special-casing it in code that deals with per-CPU
           * kthreads.
           */
          WARN_ON(!set_kthread_struct(current));

I think that @current here is misleading. When sched_init() runs it
should be single-threaded still and current == &init_task. So that
set_kthread_struct(current) call sets @init_task's worker_private iiuc.

Patch appended. I'll stuff it into vfs.fixes.

--weeg7swa4awjafyy
Content-Type: text/x-diff; charset=utf-8
Content-Disposition: attachment;
	filename="0001-kthread-consolidate-kthread-exit-paths-to-prevent-us.patch"

From 28aaa9c39945b7925a1cc1d513c8f21ed38f5e4f Mon Sep 17 00:00:00 2001
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 26 Feb 2026 10:43:55 +0100
Subject: [PATCH] kthread: consolidate kthread exit paths to prevent
 use-after-free

Guillaume reported crashes via corrupted RCU callback function pointers
during KUnit testing. The crash was traced back to the pidfs rhashtable
conversion which replaced the 24-byte rb_node with an 8-byte rhash_head
in struct pid, shrinking it from 160 to 144 bytes.

struct kthread (without CONFIG_BLK_CGROUP) is also 144 bytes. With
CONFIG_SLAB_MERGE_DEFAULT and SLAB_HWCACHE_ALIGN both round up to
192 bytes and share the same slab cache. struct pid.rcu.func and
struct kthread.affinity_node both sit at offset 0x78.

When a kthread exits via make_task_dead() it bypasses kthread_exit() and
misses the affinity_node cleanup. free_kthread_struct() frees the memory
while the node is still linked into the global kthread_affinity_list. A
subsequent list_del() by another kthread writes through dangling list
pointers into the freed and reused memory, corrupting the pid's
rcu.func pointer.

Instead of patching free_kthread_struct() to handle the missed cleanup,
consolidate all kthread exit paths. Turn kthread_exit() into a macro
that calls do_exit() and add kthread_do_exit() which is called from
do_exit() for any task with PF_KTHREAD set. This guarantees that
kthread-specific cleanup always happens regardless of the exit path -
make_task_dead(), direct do_exit(), or kthread_exit().

Replace __to_kthread() with a new tsk_is_kthread() accessor in the
public header. Export do_exit() since module code using the
kthread_exit() macro now needs it directly.

Reported-by: Guillaume Tucker <gtucker@gtucker.io>
Tested-by: Guillaume Tucker <gtucker@gtucker.io>
Tested-by: Mark Brown <broonie@kernel.org>
Tested-by: David Gow <davidgow@google.com>
Cc: <stable@vger.kernel.org>
Link: https://lore.kernel.org/all/20260224-mittlerweile-besessen-2738831ae7f6@brauner
Co-developed-by: Linus Torvalds <torvalds@linux-foundation.org>
Fixes: 4d13f4304fa4 ("kthread: Implement preferred affinity")
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 include/linux/kthread.h | 21 ++++++++++++++++++++-
 kernel/exit.c           |  6 ++++++
 kernel/kthread.c        | 41 +++++------------------------------------
 3 files changed, 31 insertions(+), 37 deletions(-)

diff --git a/include/linux/kthread.h b/include/linux/kthread.h
index c92c1149ee6e..a01a474719a7 100644
--- a/include/linux/kthread.h
+++ b/include/linux/kthread.h
@@ -7,6 +7,24 @@
 
 struct mm_struct;
 
+/* opaque kthread data */
+struct kthread;
+
+/*
+ * When "(p->flags & PF_KTHREAD)" is set the task is a kthread and will
+ * always remain a kthread.  For kthreads p->worker_private always
+ * points to a struct kthread.  For tasks that are not kthreads
+ * p->worker_private is used to point to other things.
+ *
+ * Return NULL for any task that is not a kthread.
+ */
+static inline struct kthread *tsk_is_kthread(struct task_struct *p)
+{
+	if (p->flags & PF_KTHREAD)
+		return p->worker_private;
+	return NULL;
+}
+
 __printf(4, 5)
 struct task_struct *kthread_create_on_node(int (*threadfn)(void *data),
 					   void *data,
@@ -98,9 +116,10 @@ void *kthread_probe_data(struct task_struct *k);
 int kthread_park(struct task_struct *k);
 void kthread_unpark(struct task_struct *k);
 void kthread_parkme(void);
-void kthread_exit(long result) __noreturn;
+#define kthread_exit(result) do_exit(result)
 void kthread_complete_and_exit(struct completion *, long) __noreturn;
 int kthreads_update_housekeeping(void);
+void kthread_do_exit(struct kthread *, long);
 
 int kthreadd(void *unused);
 extern struct task_struct *kthreadd_task;
diff --git a/kernel/exit.c b/kernel/exit.c
index 8a87021211ae..ede3117fa7d4 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -896,11 +896,16 @@ static void synchronize_group_exit(struct task_struct *tsk, long code)
 void __noreturn do_exit(long code)
 {
 	struct task_struct *tsk = current;
+	struct kthread *kthread;
 	int group_dead;
 
 	WARN_ON(irqs_disabled());
 	WARN_ON(tsk->plug);
 
+	kthread = tsk_is_kthread(tsk);
+	if (unlikely(kthread))
+		kthread_do_exit(kthread, code);
+
 	kcov_task_exit(tsk);
 	kmsan_task_exit(tsk);
 
@@ -1013,6 +1018,7 @@ void __noreturn do_exit(long code)
 	lockdep_free_task(tsk);
 	do_task_dead();
 }
+EXPORT_SYMBOL(do_exit);
 
 void __noreturn make_task_dead(int signr)
 {
diff --git a/kernel/kthread.c b/kernel/kthread.c
index 20451b624b67..791210daf8b4 100644
--- a/kernel/kthread.c
+++ b/kernel/kthread.c
@@ -85,24 +85,6 @@ static inline struct kthread *to_kthread(struct task_struct *k)
 	return k->worker_private;
 }
 
-/*
- * Variant of to_kthread() that doesn't assume @p is a kthread.
- *
- * When "(p->flags & PF_KTHREAD)" is set the task is a kthread and will
- * always remain a kthread.  For kthreads p->worker_private always
- * points to a struct kthread.  For tasks that are not kthreads
- * p->worker_private is used to point to other things.
- *
- * Return NULL for any task that is not a kthread.
- */
-static inline struct kthread *__to_kthread(struct task_struct *p)
-{
-	void *kthread = p->worker_private;
-	if (kthread && !(p->flags & PF_KTHREAD))
-		kthread = NULL;
-	return kthread;
-}
-
 void get_kthread_comm(char *buf, size_t buf_size, struct task_struct *tsk)
 {
 	struct kthread *kthread = to_kthread(tsk);
@@ -193,7 +175,7 @@ EXPORT_SYMBOL_GPL(kthread_should_park);
 
 bool kthread_should_stop_or_park(void)
 {
-	struct kthread *kthread = __to_kthread(current);
+	struct kthread *kthread = tsk_is_kthread(current);
 
 	if (!kthread)
 		return false;
@@ -234,7 +216,7 @@ EXPORT_SYMBOL_GPL(kthread_freezable_should_stop);
  */
 void *kthread_func(struct task_struct *task)
 {
-	struct kthread *kthread = __to_kthread(task);
+	struct kthread *kthread = tsk_is_kthread(task);
 	if (kthread)
 		return kthread->threadfn;
 	return NULL;
@@ -266,7 +248,7 @@ EXPORT_SYMBOL_GPL(kthread_data);
  */
 void *kthread_probe_data(struct task_struct *task)
 {
-	struct kthread *kthread = __to_kthread(task);
+	struct kthread *kthread = tsk_is_kthread(task);
 	void *data = NULL;
 
 	if (kthread)
@@ -309,19 +291,8 @@ void kthread_parkme(void)
 }
 EXPORT_SYMBOL_GPL(kthread_parkme);
 
-/**
- * kthread_exit - Cause the current kthread return @result to kthread_stop().
- * @result: The integer value to return to kthread_stop().
- *
- * While kthread_exit can be called directly, it exists so that
- * functions which do some additional work in non-modular code such as
- * module_put_and_kthread_exit can be implemented.
- *
- * Does not return.
- */
-void __noreturn kthread_exit(long result)
+void kthread_do_exit(struct kthread *kthread, long result)
 {
-	struct kthread *kthread = to_kthread(current);
 	kthread->result = result;
 	if (!list_empty(&kthread->affinity_node)) {
 		mutex_lock(&kthread_affinity_lock);
@@ -333,9 +304,7 @@ void __noreturn kthread_exit(long result)
 			kthread->preferred_affinity = NULL;
 		}
 	}
-	do_exit(0);
 }
-EXPORT_SYMBOL(kthread_exit);
 
 /**
  * kthread_complete_and_exit - Exit the current kthread.
@@ -683,7 +652,7 @@ void kthread_set_per_cpu(struct task_struct *k, int cpu)
 
 bool kthread_is_per_cpu(struct task_struct *p)
 {
-	struct kthread *kthread = __to_kthread(p);
+	struct kthread *kthread = tsk_is_kthread(p);
 	if (!kthread)
 		return false;
 
-- 
2.47.3


--weeg7swa4awjafyy--

