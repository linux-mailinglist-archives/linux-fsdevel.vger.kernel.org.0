Return-Path: <linux-fsdevel+bounces-55245-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 710B1B08BFB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Jul 2025 13:51:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A79995874B0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Jul 2025 11:51:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 506D729ACF5;
	Thu, 17 Jul 2025 11:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Feiav8ox"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28EA6288CAC;
	Thu, 17 Jul 2025 11:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752753108; cv=none; b=rSgcrUNMNuIXjdMg8bRhIeRNTzq1DIaN5Hhgx6/JYVzUqyAPL+IQ5KoC44eneIZ23CVPOZhclmvWFkWVLy7zSyfwAjRbLZqTOfgpbLGJHInjepn5sO+NT1j6YoBmbCR45G1iTVB5tJxkUpHxDRAQpYEH84Q2KAC/kg0FyUli7UQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752753108; c=relaxed/simple;
	bh=HWTwHuYnPjwPmJ/O9bhuAv400Qv6HoPaXQYposSwp8w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jfpzik7NsU3l7WtBjHVl8kQG5ym/v/H3d0aE8YVXlIOiORgfYlvgIIqpWyPyOT4G9wlmKhim4j3VZ+L+8ITO8j4x1Zrt+aAv9eCca1wx6PjHUcFGUsHxW/693cdatI68F+yab88PPbo/pSFWwC1/oO7h9RWArGkfU7AeQgQK3OM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Feiav8ox; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-747e41d5469so1068426b3a.3;
        Thu, 17 Jul 2025 04:51:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752753106; x=1753357906; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cvlXNSigLEMAeSIy8MtqtPGaeEZ4kSFld0I+8PCL18w=;
        b=Feiav8oxe3vbACAXLSn4A7q1PmUzWRUlcwrwZkpm6dPvyJ5YT7lGUAdsTsQQJ3wPKM
         ZyfcXzlOtTzi/Y0IRfZwtBHuo/PBT2HHqkJtSelqD61uct3KG0vgG66Ox+wflB8nOxbd
         YJ2ysbp8Nb47kIvRCLh5f8fILc/auzO0DyqMuOj+Dy8jb8yHu8xo26dk1eS/C8et9cS5
         uzRFz/D15EXCqIVaLMsGdirmaXgJrEIvZ93zuAiThzP6YBG4/fIizwPKUaPuq0NMQKyj
         kPSyhKOPPEj1kRP+pQCS7EVyNAeRSvCq7P+sh36xRzeFVKhnt6w0cyGP7nhaDrOujqV8
         2E1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752753106; x=1753357906;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cvlXNSigLEMAeSIy8MtqtPGaeEZ4kSFld0I+8PCL18w=;
        b=IrlIZromA1ks6CTtrsFXtlAgEp0kctPXzUs+yKO9DnjHUskzfNI0QgsyUWMhe8XcKg
         DbDFFkeWYXv3lMlYP61fXhIx8m1GkjtjxKCrGPegUYgzXT/tBGtQY9KmOqAxr4DfjbS2
         tXSVESJ9DEMPU7Tb4eDtgOQmKomFSw7hgsBWuIpcdPASuG3Sh+GS0OQ/IKzl3oC6Rcnj
         NnizRWJ0i5tUX36VsWNu6vGWo5Lcp+U5Tz5kZmDdHIUE+qSOhba/exw2djcI4M+pk5U4
         IfoS77zZHD/0XphEqhV/C/B/lod3jHTRGvD2XaLBdpi/2HI6aRy7Gq+t2ZKmM3R0XTcw
         zk2w==
X-Forwarded-Encrypted: i=1; AJvYcCU81ghLLGJt4RYgor0lG1KaWGsj/kJQRC/wYYeslnj/6yz9goQlAr7zopt7apBd7st1GCvRnQ3OPAYvfnP7@vger.kernel.org, AJvYcCUB2wRgf4xnRsG3tmkbuC05UHKwc49mnEjHb/8AlPh4GqvmdfyapLsTekVVkLCqijL5dMzc97OAMHq2/OD6@vger.kernel.org
X-Gm-Message-State: AOJu0YyMQJyc/Fj2kfhY3HFVy17wJgB+pssY4kKZ+VioyMggXpblOmE5
	MfZLt916E1oFpmqPRFXfTbD/xWPrIXX6Q2ioKmIymGApAtFULdj2TY4r
X-Gm-Gg: ASbGnct8svvBwlrsSTJlr6c/lkYy+MDF6Sjgt67J17wLkzDmHtauT9ip80UMkVFanO7
	QTxppj0NXNBQbv24OxT0gaY65qEKNdpT3LyvBHfO9eh3B/FWrXXmYh7TbmcR9wvdZDczQRI1jE0
	5K+Gv+lecji742IkETZGltyZqfV2L0k4PyvV6PV7SWR5Xg1bRqfsYNuolqff2+f5paT3Ce6RH8a
	hxOUz4ZS7wXsjlxxSWO6ZvPEY4uUzrf1KJK4/MkA1g/J89Eqq5zv3o/1TayCVlkmOx+RJCFegu1
	qwOocXv3XbUUIC1H8RpmCJcXqKV7IS8QHFO9j1LMswtsMNpMr3pzLSp/hEJxRB/YAyGEM00h+B6
	BDuRlfrRIRjBq9op8XeHSMaG0R6/0rCOht7hk0XJgftCRm7Xmhab/jlxS3U5WWHLlknVK44setW
	A=
X-Google-Smtp-Source: AGHT+IGpBmRr5AQccX/4ntree00JtSYJWYSQI4KDs870IcP83rclj8RnoHtYhpnZEbO9Pbufo8R5dQ==
X-Received: by 2002:a05:6a00:4b0a:b0:73f:f816:dd78 with SMTP id d2e1a72fcca58-757250819fbmr8825638b3a.15.1752753106121;
        Thu, 17 Jul 2025 04:51:46 -0700 (PDT)
Received: from SIQOL-WIN-0002-DARSHAN.localdomain ([27.57.176.233])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74eb9f1d507sm16067374b3a.83.2025.07.17.04.51.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jul 2025 04:51:45 -0700 (PDT)
From: Darshan Rathod <darshanrathod475@gmail.com>
To: Benjamin LaHaise <bcrl@kvack.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	linux-aio@kvack.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Darshan Rathod <darshanrathod475@gmail.com>
Subject: [PATCH] fs/aio: Use unsigned int instead of plain unsigned
Date: Thu, 17 Jul 2025 11:51:37 +0000
Message-ID: <20250717115138.31860-1-darshanrathod475@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch performs a code style cleanup throughout the AIO implementation in fs/aio.c.

All instances of the shorthand type `unsigned` have been replaced with the more explicit `unsigned int`.

While functionally identical, this change improves code clarity and brings it into alignment with the preferred Linux kernel coding style.

The modifications have been applied consistently to:
- Structure member definitions (e.g., `struct aio_ring`, `kioctx`)
- Function parameters and local variables
- Syscall definition macros (SYSCALL_DEFINE2)

This is purely a stylistic modification and introduces no functional change.

Signed-off-by: Darshan Rathod <darshanrathod475@gmail.com>
---
 fs/aio.c | 75 ++++++++++++++++++++++++++++----------------------------
 1 file changed, 38 insertions(+), 37 deletions(-)

diff --git a/fs/aio.c b/fs/aio.c
index 793b7b15ec4b..7c487516fd93 100644
--- a/fs/aio.c
+++ b/fs/aio.c
@@ -54,16 +54,16 @@
 #define AIO_RING_COMPAT_FEATURES	1
 #define AIO_RING_INCOMPAT_FEATURES	0
 struct aio_ring {
-	unsigned	id;	/* kernel internal index number */
-	unsigned	nr;	/* number of io_events */
-	unsigned	head;	/* Written to by userland or under ring_lock
+	unsigned int	id;	/* kernel internal index number */
+	unsigned int	nr;	/* number of io_events */
+	unsigned int	head;	/* Written to by userland or under ring_lock
 				 * mutex by aio_read_events_ring(). */
-	unsigned	tail;
+	unsigned int	tail;
 
-	unsigned	magic;
-	unsigned	compat_features;
-	unsigned	incompat_features;
-	unsigned	header_length;	/* size of aio_ring */
+	unsigned int	magic;
+	unsigned int	compat_features;
+	unsigned int	incompat_features;
+	unsigned int	header_length;	/* size of aio_ring */
 
 
 	struct io_event		io_events[];
@@ -84,7 +84,7 @@ struct kioctx_table {
 };
 
 struct kioctx_cpu {
-	unsigned		reqs_available;
+	unsigned int		reqs_available;
 };
 
 struct ctx_rq_wait {
@@ -106,7 +106,7 @@ struct kioctx {
 	 * For percpu reqs_available, number of slots we move to/from global
 	 * counter at a time:
 	 */
-	unsigned		req_batch;
+	unsigned int		req_batch;
 	/*
 	 * This is what userspace passed to io_setup(), it's not used for
 	 * anything but counting against the global max_reqs quota.
@@ -114,10 +114,10 @@ struct kioctx {
 	 * The real limit is nr_events - 1, which will be larger (see
 	 * aio_setup_ring())
 	 */
-	unsigned		max_reqs;
+	unsigned int		max_reqs;
 
 	/* Size of ringbuffer, in units of struct io_event */
-	unsigned		nr_events;
+	unsigned int		nr_events;
 
 	unsigned long		mmap_base;
 	unsigned long		mmap_size;
@@ -155,15 +155,15 @@ struct kioctx {
 	} ____cacheline_aligned_in_smp;
 
 	struct {
-		unsigned	tail;
-		unsigned	completed_events;
+		unsigned int	tail;
+		unsigned int	completed_events;
 		spinlock_t	completion_lock;
 	} ____cacheline_aligned_in_smp;
 
 	struct folio		*internal_folios[AIO_RING_PAGES];
 	struct file		*aio_ring_file;
 
-	unsigned		id;
+	unsigned int		id;
 };
 
 /*
@@ -299,7 +299,7 @@ static int __init aio_setup(void)
 		panic("Failed to create aio fs mount.");
 
 	kiocb_cachep = KMEM_CACHE(aio_kiocb, SLAB_HWCACHE_ALIGN|SLAB_PANIC);
-	kioctx_cachep = KMEM_CACHE(kioctx,SLAB_HWCACHE_ALIGN|SLAB_PANIC);
+	kioctx_cachep = KMEM_CACHE(kioctx, SLAB_HWCACHE_ALIGN|SLAB_PANIC);
 	aio_sysctl_init();
 	return 0;
 }
@@ -666,7 +666,7 @@ static void free_ioctx_users(struct percpu_ref *ref)
 
 static int ioctx_add_table(struct kioctx *ctx, struct mm_struct *mm)
 {
-	unsigned i, new_nr;
+	unsigned int i, new_nr;
 	struct kioctx_table *table, *old;
 	struct aio_ring *ring;
 
@@ -717,7 +717,7 @@ static int ioctx_add_table(struct kioctx *ctx, struct mm_struct *mm)
 	}
 }
 
-static void aio_nr_sub(unsigned nr)
+static void aio_nr_sub(unsigned int nr)
 {
 	spin_lock(&aio_nr_lock);
 	if (WARN_ON(aio_nr - nr > aio_nr))
@@ -730,7 +730,7 @@ static void aio_nr_sub(unsigned nr)
 /* ioctx_alloc
  *	Allocates and initializes an ioctx.  Returns an ERR_PTR if it failed.
  */
-static struct kioctx *ioctx_alloc(unsigned nr_events)
+static struct kioctx *ioctx_alloc(unsigned int nr_events)
 {
 	struct mm_struct *mm = current->mm;
 	struct kioctx *ctx;
@@ -931,7 +931,7 @@ void exit_aio(struct mm_struct *mm)
 	kfree(table);
 }
 
-static void put_reqs_available(struct kioctx *ctx, unsigned nr)
+static void put_reqs_available(struct kioctx *ctx, unsigned int nr)
 {
 	struct kioctx_cpu *kcpu;
 	unsigned long flags;
@@ -982,10 +982,10 @@ static bool __get_reqs_available(struct kioctx *ctx)
  *	from aio_get_req() (the we're out of events case).  It must be
  *	called holding ctx->completion_lock.
  */
-static void refill_reqs_available(struct kioctx *ctx, unsigned head,
-                                  unsigned tail)
+static void refill_reqs_available(struct kioctx *ctx, unsigned int head,
+				  unsigned int tail)
 {
-	unsigned events_in_ring, completed;
+	unsigned int events_in_ring, completed;
 
 	/* Clamp head since userland can write to it. */
 	head %= ctx->nr_events;
@@ -1016,7 +1016,7 @@ static void user_refill_reqs_available(struct kioctx *ctx)
 	spin_lock_irq(&ctx->completion_lock);
 	if (ctx->completed_events) {
 		struct aio_ring *ring;
-		unsigned head;
+		unsigned int head;
 
 		/* Access of ring->head may race with aio_read_events_ring()
 		 * here, but that's okay since whether we read the old version
@@ -1078,7 +1078,7 @@ static struct kioctx *lookup_ioctx(unsigned long ctx_id)
 	struct mm_struct *mm = current->mm;
 	struct kioctx *ctx, *ret = NULL;
 	struct kioctx_table *table;
-	unsigned id;
+	unsigned int id;
 
 	if (get_user(id, &ring->id))
 		return NULL;
@@ -1123,7 +1123,7 @@ static void aio_complete(struct aio_kiocb *iocb)
 	struct kioctx	*ctx = iocb->ki_ctx;
 	struct aio_ring	*ring;
 	struct io_event	*ev_page, *event;
-	unsigned tail, pos, head, avail;
+	unsigned int tail, pos, head, avail;
 	unsigned long	flags;
 
 	/*
@@ -1219,7 +1219,7 @@ static long aio_read_events_ring(struct kioctx *ctx,
 				 struct io_event __user *event, long nr)
 {
 	struct aio_ring *ring;
-	unsigned head, tail, pos;
+	unsigned int head, tail, pos;
 	long ret = 0;
 	int copy_ret;
 
@@ -1370,16 +1370,16 @@ static long read_events(struct kioctx *ctx, long min_nr, long nr,
  *	Create an aio_context capable of receiving at least nr_events.
  *	ctxp must not point to an aio_context that already exists, and
  *	must be initialized to 0 prior to the call.  On successful
- *	creation of the aio_context, *ctxp is filled in with the resulting 
+ *	creation of the aio_context, *ctxp is filled in with the resulting
  *	handle.  May fail with -EINVAL if *ctxp is not initialized,
- *	if the specified nr_events exceeds internal limits.  May fail 
- *	with -EAGAIN if the specified nr_events exceeds the user's limit 
+ *	if the specified nr_events exceeds internal limits.  May fail
+ *	with -EAGAIN if the specified nr_events exceeds the user's limit
  *	of available events.  May fail with -ENOMEM if insufficient kernel
  *	resources are available.  May fail with -EFAULT if an invalid
  *	pointer is passed for ctxp.  Will fail with -ENOSYS if not
  *	implemented.
  */
-SYSCALL_DEFINE2(io_setup, unsigned, nr_events, aio_context_t __user *, ctxp)
+SYSCALL_DEFINE2(io_setup, unsigned int, nr_events, aio_context_t __user *, ctxp)
 {
 	struct kioctx *ioctx = NULL;
 	unsigned long ctx;
@@ -1392,7 +1392,7 @@ SYSCALL_DEFINE2(io_setup, unsigned, nr_events, aio_context_t __user *, ctxp)
 	ret = -EINVAL;
 	if (unlikely(ctx || nr_events == 0)) {
 		pr_debug("EINVAL: ctx %lu nr_events %u\n",
-		         ctx, nr_events);
+			 ctx, nr_events);
 		goto out;
 	}
 
@@ -1410,7 +1410,7 @@ SYSCALL_DEFINE2(io_setup, unsigned, nr_events, aio_context_t __user *, ctxp)
 }
 
 #ifdef CONFIG_COMPAT
-COMPAT_SYSCALL_DEFINE2(io_setup, unsigned, nr_events, u32 __user *, ctx32p)
+COMPAT_SYSCALL_DEFINE2(io_setup, unsigned int, nr_events, u32 __user *, ctx32p)
 {
 	struct kioctx *ioctx = NULL;
 	unsigned long ctx;
@@ -1423,7 +1423,7 @@ COMPAT_SYSCALL_DEFINE2(io_setup, unsigned, nr_events, u32 __user *, ctx32p)
 	ret = -EINVAL;
 	if (unlikely(ctx || nr_events == 0)) {
 		pr_debug("EINVAL: ctx %lu nr_events %u\n",
-		         ctx, nr_events);
+			 ctx, nr_events);
 		goto out;
 	}
 
@@ -1443,7 +1443,7 @@ COMPAT_SYSCALL_DEFINE2(io_setup, unsigned, nr_events, u32 __user *, ctx32p)
 #endif
 
 /* sys_io_destroy:
- *	Destroy the aio_context specified.  May cancel any outstanding 
+ *	Destroy the aio_context specified.  May cancel any outstanding
  *	AIOs and block on completion.  Will fail with -ENOSYS if not
  *	implemented.  May fail with -EINVAL if the context pointed to
  *	is invalid.
@@ -1453,6 +1453,7 @@ SYSCALL_DEFINE1(io_destroy, aio_context_t, ctx)
 	struct kioctx *ioctx = lookup_ioctx(ctx);
 	if (likely(NULL != ioctx)) {
 		struct ctx_rq_wait wait;
+
 		int ret;
 
 		init_completion(&wait.comp);
@@ -1784,7 +1785,7 @@ static int aio_poll_cancel(struct kiocb *iocb)
 	return 0;
 }
 
-static int aio_poll_wake(struct wait_queue_entry *wait, unsigned mode, int sync,
+static int aio_poll_wake(struct wait_queue_entry *wait, unsigned int mode, int sync,
 		void *key)
 {
 	struct poll_iocb *req = container_of(wait, struct poll_iocb, wait);
@@ -1805,7 +1806,7 @@ static int aio_poll_wake(struct wait_queue_entry *wait, unsigned mode, int sync,
 	 *   2. The completion work must not have already been scheduled.
 	 *   3. ctx_lock must not be busy.  We have to use trylock because we
 	 *	already hold the waitqueue lock, so this inverts the normal
-	 *	locking order.  Use irqsave/irqrestore because not all
+	 *	locking order.	Use irqsave/irqrestore because not all
 	 *	filesystems (e.g. fuse) call this function with IRQs disabled,
 	 *	yet IRQs have to be disabled before ctx_lock is obtained.
 	 */
-- 
2.43.0


