Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0BD15BCE0C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Sep 2022 16:07:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229974AbiISOHU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 19 Sep 2022 10:07:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229800AbiISOHT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 19 Sep 2022 10:07:19 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FC5A2A96B;
        Mon, 19 Sep 2022 07:07:17 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id z6so15222113wrq.1;
        Mon, 19 Sep 2022 07:07:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=YXNF1eeJdEtiOCDMApu1aTa4cq1v+j0kBy8KOQgfBnk=;
        b=oaxDRmZm3EH5wm6Y+tU36AwvIrfC5GeWTORlVYezYCi02jw/MPyKCicCR33lxmBU3x
         kOl72OQmEVXBTwqITumXQRBI3B0y3zvGyKh/Az2kxlZxCvuvsSsYd8jcDsnQ/FjWHok9
         fCLYAX6ePcwj1xA8/YiaAZAHOpjxFrSw8CR2tcokCS3auYKVfltLtICSjNidsJm36b1d
         K/fzd3vxfpeL1/cjgvyoxq1ZR5xAFNYPBnT0D2tpzZrMLwYav3hjvDfvgAn6s9uKtBNh
         rWHxkX+QxDixlswFa0WTvaWKn+SGDxElwfrpV8kkMTjDxPlJym+tqPIqYEFSUfq+pUgg
         w3og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=YXNF1eeJdEtiOCDMApu1aTa4cq1v+j0kBy8KOQgfBnk=;
        b=zdvFlBUAbBISK7TZRFi24Arms0tzH42/Pn5AwxPXIng3ltdXE/awAjUipPhKhdBo20
         U9aSYQX5vLfPKP8SAHQb13HFB01ym+ua0e10so6P20C+Yyw1uEMVNb34njCdJm2arcFt
         rzwhcdyBizSO+kPRxg3NNFAMW/ru/GcYBNrCSWGBXo/6hBEDjDLUOwGA2p8rwMFUx5MU
         7g+H1k/JET4uipIW/+MzouOXYw0OEZNMFJrsU2AJ6K8uuR0s5pdr9HlXvuewYc6OW+4A
         AwRE90w6kahAfd3JjlJEbgEvOQ+jrLZMscUHglvBN7J/tY9ACamhpJ/YvoR81Uar03g4
         PTTQ==
X-Gm-Message-State: ACrzQf1cM++P3CuI0n3bK36/hQb2ERHZeE3icx2yDuO1Pa3YUfoIKc0a
        cLLdysTMIC5gSUqxsgKIkQY=
X-Google-Smtp-Source: AMsMyM7IP75I4AeKIIz2EizbyHZjLlOZkU3sJcsB1i5CDXWq+LcLl3KhxgoZ5qunqvywQS8gRfHvYg==
X-Received: by 2002:a5d:5a15:0:b0:228:cd90:ccd with SMTP id bq21-20020a5d5a15000000b00228cd900ccdmr11565325wrb.658.1663596435657;
        Mon, 19 Sep 2022 07:07:15 -0700 (PDT)
Received: from wedsonaf-dev ([81.2.152.129])
        by smtp.gmail.com with ESMTPSA id m17-20020adfe951000000b0022afddab5dfsm4160217wrn.7.2022.09.19.07.07.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Sep 2022 07:07:15 -0700 (PDT)
Date:   Mon, 19 Sep 2022 15:07:12 +0100
From:   Wedson Almeida Filho <wedsonaf@gmail.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Konstantin Shelekhin <k.shelekhin@yadro.com>, ojeda@kernel.org,
        alex.gaynor@gmail.com, ark.email@gmail.com,
        bjorn3_gh@protonmail.com, bobo1239@web.de, bonifaido@gmail.com,
        boqun.feng@gmail.com, davidgow@google.com, dev@niklasmohrin.de,
        dsosnowski@dsosnowski.pl, foxhlchen@gmail.com, gary@garyguo.net,
        geofft@ldpreload.com, gregkh@linuxfoundation.org,
        jarkko@kernel.org, john.m.baublitz@gmail.com,
        leseulartichaut@gmail.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, m.falkowski@samsung.com,
        me@kloenk.de, milan@mdaverde.com, mjmouse9999@gmail.com,
        patches@lists.linux.dev, rust-for-linux@vger.kernel.org,
        thesven73@gmail.com, torvalds@linux-foundation.org,
        viktor@v-gar.de, Andreas Hindborg <andreas.hindborg@wdc.com>
Subject: Re: [PATCH v9 12/27] rust: add `kernel` crate
Message-ID: <Yyh3kFUvt2aMh4nq@wedsonaf-dev>
References: <20220805154231.31257-13-ojeda@kernel.org>
 <Yu5Bex9zU6KJpcEm@yadro.com>
 <CANiq72=3j2NM2kS8iw14G6MnGirb0=O6XQyCsY9vVgsZ1DfLaQ@mail.gmail.com>
 <Yu6BXwtPZwYPIDT6@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yu6BXwtPZwYPIDT6@casper.infradead.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Aug 06, 2022 at 03:57:35PM +0100, Matthew Wilcox wrote:
> On Sat, Aug 06, 2022 at 01:22:52PM +0200, Miguel Ojeda wrote:
> > On Sat, Aug 6, 2022 at 12:25 PM Konstantin Shelekhin
> > <k.shelekhin@yadro.com> wrote:
> > >
> > > I sense possible problems here. It's common for a kernel code to pass
> > > flags during memory allocations.
> > 
> > Yes, of course. We will support this, but how exactly it will look
> > like, to what extent upstream Rust's `alloc` could support our use
> > cases, etc. has been on discussion for a long time.
> > 
> > For instance, see https://github.com/Rust-for-Linux/linux/pull/815 for
> > a potential extension trait approach with no allocator carried on the
> > type that Andreas wrote after a discussion in the last informal call:
> > 
> >     let a = Box::try_new_atomic(101)?;
> 
> Something I've been wondering about for a while is ...
> 
> struct task_struct {
> ...
> +	gfp_t gfp_flags;
> ...
> };

For GFP_ATOMIC, we could use preempt_count except that it isn't always
enabled. Conveniently, it is already separated out into its own config.
How do people feel about removing CONFIG_PREEMPT_COUNT and having the
count always enabled?

We would then have a way to reliably detect when we are in atomic
context and we could catch other scenarios beyond allocation. For
example, I recently noticed that the following code (as a minimal
reproduction) does _not_ lead to a deadlock when CONFIG_PREEMPT=n:

rcu_read_lock();
synchronize_rcu();

Boqun explained to me that the reason is that synchronize_rcu() is not
supposed to be called from an rcu read-side critical section and the
current implementation takes advantage of this fact plus there is no way
to detect if we're in atomic context. This is all well and good, but if
one makes this mistake, the result is a potential user-after-free.
Always having preempt_count would allow us to behave differently here --
this is another conversation but at least we'll have to option to choose
what to do. (And it seems to me that detecting this and deadlocking or
BUG'ing would be preferable over the alternative [CC'ing Kees].)

Anyway, objections to a patch series that would amount to the changes
below?

Thanks,
-Wedson

diff --git a/arch/arm/include/asm/assembler.h b/arch/arm/include/asm/assembler.h
index 90fbe4a3f9c8..c88c932dba5b 100644
--- a/arch/arm/include/asm/assembler.h
+++ b/arch/arm/include/asm/assembler.h
@@ -224,7 +224,6 @@ THUMB(	fpreg	.req	r7	)
 /*
  * Increment/decrement the preempt count.
  */
-#ifdef CONFIG_PREEMPT_COUNT
 	.macro	inc_preempt_count, ti, tmp
 	ldr	\tmp, [\ti, #TI_PREEMPT]	@ get preempt count
 	add	\tmp, \tmp, #1			@ increment it
@@ -241,16 +240,6 @@ THUMB(	fpreg	.req	r7	)
 	get_thread_info \ti
 	dec_preempt_count \ti, \tmp
 	.endm
-#else
-	.macro	inc_preempt_count, ti, tmp
-	.endm
-
-	.macro	dec_preempt_count, ti, tmp
-	.endm
-
-	.macro	dec_preempt_count_ti, ti, tmp
-	.endm
-#endif
 
 #define USERL(l, x...)				\
 9999:	x;					\
diff --git a/arch/arm/kernel/iwmmxt.S b/arch/arm/kernel/iwmmxt.S
index d2b4ac06e4ed..ecdeaa4d5190 100644
--- a/arch/arm/kernel/iwmmxt.S
+++ b/arch/arm/kernel/iwmmxt.S
@@ -95,9 +95,7 @@ ENTRY(iwmmxt_task_enable)
 	mov	r2, r2				@ cpwait
 	bl	concan_save
 
-#ifdef CONFIG_PREEMPT_COUNT
 	get_thread_info r10
-#endif
 4:	dec_preempt_count r10, r3
 	ret	r9				@ normal exit from exception
 
diff --git a/arch/xtensa/kernel/entry.S b/arch/xtensa/kernel/entry.S
index 272fff587907..8ad94e13d0f0 100644
--- a/arch/xtensa/kernel/entry.S
+++ b/arch/xtensa/kernel/entry.S
@@ -832,7 +832,7 @@ ENTRY(debug_exception)
 	 * preemption if we have HW breakpoints to preserve DEBUGCAUSE.DBNUM
 	 * meaning.
 	 */
-#if defined(CONFIG_PREEMPT_COUNT) && defined(CONFIG_HAVE_HW_BREAKPOINT)
+#if defined(CONFIG_HAVE_HW_BREAKPOINT)
 	GET_THREAD_INFO(a2, a1)
 	l32i	a3, a2, TI_PRE_COUNT
 	addi	a3, a3, 1
diff --git a/drivers/gpu/drm/i915/Kconfig.debug b/drivers/gpu/drm/i915/Kconfig.debug
index 47e845353ffa..811f34dbb80b 100644
--- a/drivers/gpu/drm/i915/Kconfig.debug
+++ b/drivers/gpu/drm/i915/Kconfig.debug
@@ -22,7 +22,6 @@ config DRM_I915_DEBUG
 	depends on EXPERT # only for developers
 	depends on !COMPILE_TEST # never built by robots
 	select DEBUG_FS
-	select PREEMPT_COUNT
 	select I2C_CHARDEV
 	select STACKDEPOT
 	select DRM_DP_AUX_CHARDEV
diff --git a/drivers/gpu/drm/i915/i915_utils.h b/drivers/gpu/drm/i915/i915_utils.h
index c10d68cdc3ca..93686bdb9707 100644
--- a/drivers/gpu/drm/i915/i915_utils.h
+++ b/drivers/gpu/drm/i915/i915_utils.h
@@ -293,8 +293,7 @@ wait_remaining_ms_from_jiffies(unsigned long timestamp_jiffies, int to_wait_ms)
 						   (Wmax))
 #define wait_for(COND, MS)		_wait_for((COND), (MS) * 1000, 10, 1000)
 
-/* If CONFIG_PREEMPT_COUNT is disabled, in_atomic() always reports false. */
-#if defined(CONFIG_DRM_I915_DEBUG) && defined(CONFIG_PREEMPT_COUNT)
+#if defined(CONFIG_DRM_I915_DEBUG)
 # define _WAIT_FOR_ATOMIC_CHECK(ATOMIC) WARN_ON_ONCE((ATOMIC) && !in_atomic())
 #else
 # define _WAIT_FOR_ATOMIC_CHECK(ATOMIC) do { } while (0)
diff --git a/include/linux/bit_spinlock.h b/include/linux/bit_spinlock.h
index bbc4730a6505..1e03d54b0b6f 100644
--- a/include/linux/bit_spinlock.h
+++ b/include/linux/bit_spinlock.h
@@ -90,10 +90,8 @@ static inline int bit_spin_is_locked(int bitnum, unsigned long *addr)
 {
 #if defined(CONFIG_SMP) || defined(CONFIG_DEBUG_SPINLOCK)
 	return test_bit(bitnum, addr);
-#elif defined CONFIG_PREEMPT_COUNT
-	return preempt_count();
 #else
-	return 1;
+	return preempt_count();
 #endif
 }
 
diff --git a/include/linux/lockdep.h b/include/linux/lockdep.h
index 1f1099dac3f0..a05e40dccb0a 100644
--- a/include/linux/lockdep.h
+++ b/include/linux/lockdep.h
@@ -600,16 +600,14 @@ do {									\
 
 #define lockdep_assert_preemption_enabled()				\
 do {									\
-	WARN_ON_ONCE(IS_ENABLED(CONFIG_PREEMPT_COUNT)	&&		\
-		     __lockdep_enabled			&&		\
+	WARN_ON_ONCE(__lockdep_enabled			&&		\
 		     (preempt_count() != 0		||		\
 		      !this_cpu_read(hardirqs_enabled)));		\
 } while (0)
 
 #define lockdep_assert_preemption_disabled()				\
 do {									\
-	WARN_ON_ONCE(IS_ENABLED(CONFIG_PREEMPT_COUNT)	&&		\
-		     __lockdep_enabled			&&		\
+	WARN_ON_ONCE(__lockdep_enabled			&&		\
 		     (preempt_count() == 0		&&		\
 		      this_cpu_read(hardirqs_enabled)));		\
 } while (0)
diff --git a/include/linux/page_ref.h b/include/linux/page_ref.h
index 2e677e6ad09f..4cddcb17489a 100644
--- a/include/linux/page_ref.h
+++ b/include/linux/page_ref.h
@@ -271,9 +271,7 @@ static inline bool folio_ref_try_add_rcu(struct folio *folio, int count)
 	 * context, so (on !SMP) we only need preemption to be disabled
 	 * and TINY_RCU does that for us.
 	 */
-# ifdef CONFIG_PREEMPT_COUNT
 	VM_BUG_ON(!in_atomic() && !irqs_disabled());
-# endif
 	VM_BUG_ON_FOLIO(folio_ref_count(folio) == 0, folio);
 	folio_ref_add(folio, count);
 #else
diff --git a/include/linux/preempt.h b/include/linux/preempt.h
index b4381f255a5c..77da73007375 100644
--- a/include/linux/preempt.h
+++ b/include/linux/preempt.h
@@ -56,8 +56,7 @@
 #define PREEMPT_DISABLED	(PREEMPT_DISABLE_OFFSET + PREEMPT_ENABLED)
 
 /*
- * Disable preemption until the scheduler is running -- use an unconditional
- * value so that it also works on !PREEMPT_COUNT kernels.
+ * Disable preemption until the scheduler is running.
  *
  * Reset by start_kernel()->sched_init()->init_idle()->init_idle_preempt_count().
  */
@@ -69,7 +68,6 @@
  *
  *    preempt_count() == 2*PREEMPT_DISABLE_OFFSET
  *
- * Note: PREEMPT_DISABLE_OFFSET is 0 for !PREEMPT_COUNT kernels.
  * Note: See finish_task_switch().
  */
 #define FORK_PREEMPT_COUNT	(2*PREEMPT_DISABLE_OFFSET + PREEMPT_ENABLED)
@@ -133,11 +131,7 @@ static __always_inline unsigned char interrupt_context_level(void)
 /*
  * The preempt_count offset after preempt_disable();
  */
-#if defined(CONFIG_PREEMPT_COUNT)
-# define PREEMPT_DISABLE_OFFSET	PREEMPT_OFFSET
-#else
-# define PREEMPT_DISABLE_OFFSET	0
-#endif
+#define PREEMPT_DISABLE_OFFSET	PREEMPT_OFFSET
 
 /*
  * The preempt_count offset after spin_lock()
@@ -154,7 +148,7 @@ static __always_inline unsigned char interrupt_context_level(void)
  *
  *  spin_lock_bh()
  *
- * Which need to disable both preemption (CONFIG_PREEMPT_COUNT) and
+ * Which need to disable both preemption and
  * softirqs, such that unlock sequences of:
  *
  *  spin_unlock();
@@ -196,8 +190,6 @@ extern void preempt_count_sub(int val);
 #define preempt_count_inc() preempt_count_add(1)
 #define preempt_count_dec() preempt_count_sub(1)
 
-#ifdef CONFIG_PREEMPT_COUNT
-
 #define preempt_disable() \
 do { \
 	preempt_count_inc(); \
@@ -263,27 +255,6 @@ do { \
 	__preempt_count_dec(); \
 } while (0)
 
-#else /* !CONFIG_PREEMPT_COUNT */
-
-/*
- * Even if we don't have any preemption, we need preempt disable/enable
- * to be barriers, so that we don't have things like get_user/put_user
- * that can cause faults and scheduling migrate into our preempt-protected
- * region.
- */
-#define preempt_disable()			barrier()
-#define sched_preempt_enable_no_resched()	barrier()
-#define preempt_enable_no_resched()		barrier()
-#define preempt_enable()			barrier()
-#define preempt_check_resched()			do { } while (0)
-
-#define preempt_disable_notrace()		barrier()
-#define preempt_enable_no_resched_notrace()	barrier()
-#define preempt_enable_notrace()		barrier()
-#define preemptible()				0
-
-#endif /* CONFIG_PREEMPT_COUNT */
-
 #ifdef MODULE
 /*
  * Modules have no business playing preemption tricks.
diff --git a/include/linux/uaccess.h b/include/linux/uaccess.h
index 47e5d374c7eb..8761b85c7874 100644
--- a/include/linux/uaccess.h
+++ b/include/linux/uaccess.h
@@ -225,9 +225,6 @@ static inline bool pagefault_disabled(void)
  *
  * This function should only be used by the fault handlers. Other users should
  * stick to pagefault_disabled().
- * Please NEVER use preempt_disable() to disable the fault handler. With
- * !CONFIG_PREEMPT_COUNT, this is like a NOP. So the handler won't be disabled.
- * in_atomic() will report different values based on !CONFIG_PREEMPT_COUNT.
  */
 #define faulthandler_disabled() (pagefault_disabled() || in_atomic())
 
diff --git a/kernel/Kconfig.preempt b/kernel/Kconfig.preempt
index c2f1fd95a821..3d2f7ded0fee 100644
--- a/kernel/Kconfig.preempt
+++ b/kernel/Kconfig.preempt
@@ -86,12 +86,8 @@ config PREEMPT_RT
 
 endchoice
 
-config PREEMPT_COUNT
-       bool
-
 config PREEMPTION
        bool
-       select PREEMPT_COUNT
 
 config PREEMPT_DYNAMIC
 	bool "Preemption behaviour defined on boot"
diff --git a/kernel/rcu/Kconfig.debug b/kernel/rcu/Kconfig.debug
index 1b0c41d490f0..34d395f007a7 100644
--- a/kernel/rcu/Kconfig.debug
+++ b/kernel/rcu/Kconfig.debug
@@ -122,7 +122,6 @@ config RCU_STRICT_GRACE_PERIOD
 	bool "Provide debug RCU implementation with short grace periods"
 	depends on DEBUG_KERNEL && RCU_EXPERT && NR_CPUS <= 4 && !TINY_RCU
 	default n
-	select PREEMPT_COUNT if PREEMPT=n
 	help
 	  Select this option to build an RCU variant that is strict about
 	  grace periods, making them as short as it can.  This limits
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 79aea7df4345..c21a83e7b534 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -2478,7 +2478,7 @@ static __latent_entropy void rcu_core(void)
 	WARN_ON_ONCE(!rdp->beenonline);
 
 	/* Report any deferred quiescent states if preemption enabled. */
-	if (IS_ENABLED(CONFIG_PREEMPT_COUNT) && (!(preempt_count() & PREEMPT_MASK))) {
+	if (!(preempt_count() & PREEMPT_MASK)) {
 		rcu_preempt_deferred_qs(current);
 	} else if (rcu_preempt_need_deferred_qs(current)) {
 		set_tsk_need_resched(current);
diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index 438ecae6bd7e..432aa6e6cff7 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -29,7 +29,7 @@ static bool rcu_rdp_is_offloaded(struct rcu_data *rdp)
 		  (IS_ENABLED(CONFIG_HOTPLUG_CPU) && lockdep_is_cpus_held()) ||
 		  rcu_lockdep_is_held_nocb(rdp) ||
 		  (rdp == this_cpu_ptr(&rcu_data) &&
-		   !(IS_ENABLED(CONFIG_PREEMPT_COUNT) && preemptible())) ||
+		   !preemptible()) ||
 		  rcu_current_is_nocb_kthread(rdp)),
 		"Unsafe read of RCU_NOCB offloaded state"
 	);
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index ee28253c9ac0..938f41569ae9 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -5111,8 +5111,7 @@ asmlinkage __visible void schedule_tail(struct task_struct *prev)
 	 * finish_task_switch() for details.
 	 *
 	 * finish_task_switch() will drop rq->lock() and lower preempt_count
-	 * and the preempt_enable() will end up enabling preemption (on
-	 * PREEMPT_COUNT kernels).
+	 * and the preempt_enable() will end up enabling preemption.
 	 */
 
 	finish_task_switch(prev);
@@ -9901,9 +9900,6 @@ void __cant_sleep(const char *file, int line, int preempt_offset)
 	if (irqs_disabled())
 		return;
 
-	if (!IS_ENABLED(CONFIG_PREEMPT_COUNT))
-		return;
-
 	if (preempt_count() > preempt_offset)
 		return;
 
@@ -9933,9 +9929,6 @@ void __cant_migrate(const char *file, int line)
 	if (is_migration_disabled(current))
 		return;
 
-	if (!IS_ENABLED(CONFIG_PREEMPT_COUNT))
-		return;
-
 	if (preempt_count() > 0)
 		return;
 
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index bcbe60d6c80c..3dd4c8ccc7b2 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -1230,7 +1230,6 @@ config PROVE_LOCKING
 	select DEBUG_RWSEMS
 	select DEBUG_WW_MUTEX_SLOWPATH
 	select DEBUG_LOCK_ALLOC
-	select PREEMPT_COUNT if !ARCH_NO_PREEMPT
 	select TRACE_IRQFLAGS
 	default n
 	help
@@ -1431,7 +1430,6 @@ config DEBUG_LOCKDEP
 
 config DEBUG_ATOMIC_SLEEP
 	bool "Sleep inside atomic section checking"
-	select PREEMPT_COUNT
 	depends on DEBUG_KERNEL
 	depends on !ARCH_NO_PREEMPT
 	help
diff --git a/mm/slub.c b/mm/slub.c
index 862dbd9af4f5..b01767226476 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -3106,19 +3106,15 @@ static void *__slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
 {
 	void *p;
 
-#ifdef CONFIG_PREEMPT_COUNT
 	/*
 	 * We may have been preempted and rescheduled on a different
 	 * cpu before disabling preemption. Need to reload cpu area
 	 * pointer.
 	 */
 	c = slub_get_cpu_ptr(s->cpu_slab);
-#endif
-
 	p = ___slab_alloc(s, gfpflags, node, addr, c);
-#ifdef CONFIG_PREEMPT_COUNT
 	slub_put_cpu_ptr(s->cpu_slab);
-#endif
+
 	return p;
 }
 
diff --git a/tools/testing/selftests/rcutorture/configs/rcu/SRCU-T b/tools/testing/selftests/rcutorture/configs/rcu/SRCU-T
index c70cf0405f24..e332b9b4d8c3 100644
--- a/tools/testing/selftests/rcutorture/configs/rcu/SRCU-T
+++ b/tools/testing/selftests/rcutorture/configs/rcu/SRCU-T
@@ -9,4 +9,3 @@ CONFIG_DEBUG_LOCK_ALLOC=y
 CONFIG_PROVE_LOCKING=y
 CONFIG_DEBUG_OBJECTS_RCU_HEAD=n
 CONFIG_DEBUG_ATOMIC_SLEEP=y
-#CHECK#CONFIG_PREEMPT_COUNT=y
diff --git a/tools/testing/selftests/rcutorture/configs/rcu/SRCU-U b/tools/testing/selftests/rcutorture/configs/rcu/SRCU-U
index bc9eeabaa1b1..fac0047579c2 100644
--- a/tools/testing/selftests/rcutorture/configs/rcu/SRCU-U
+++ b/tools/testing/selftests/rcutorture/configs/rcu/SRCU-U
@@ -7,4 +7,3 @@ CONFIG_PREEMPT_DYNAMIC=n
 CONFIG_RCU_TRACE=n
 CONFIG_DEBUG_LOCK_ALLOC=n
 CONFIG_DEBUG_OBJECTS_RCU_HEAD=n
-CONFIG_PREEMPT_COUNT=n
diff --git a/tools/testing/selftests/rcutorture/configs/rcu/TINY01 b/tools/testing/selftests/rcutorture/configs/rcu/TINY01
index 0953c52fcfd7..8363b0b546b7 100644
--- a/tools/testing/selftests/rcutorture/configs/rcu/TINY01
+++ b/tools/testing/selftests/rcutorture/configs/rcu/TINY01
@@ -11,4 +11,3 @@ CONFIG_RCU_TRACE=n
 #CHECK#CONFIG_RCU_STALL_COMMON=n
 CONFIG_DEBUG_LOCK_ALLOC=n
 CONFIG_DEBUG_OBJECTS_RCU_HEAD=n
-CONFIG_PREEMPT_COUNT=n
diff --git a/tools/testing/selftests/rcutorture/doc/TINY_RCU.txt b/tools/testing/selftests/rcutorture/doc/TINY_RCU.txt
index a75b16991a92..4c596905b6b2 100644
--- a/tools/testing/selftests/rcutorture/doc/TINY_RCU.txt
+++ b/tools/testing/selftests/rcutorture/doc/TINY_RCU.txt
@@ -4,7 +4,6 @@ This document gives a brief rationale for the TINY_RCU test cases.
 Kconfig Parameters:
 
 CONFIG_DEBUG_LOCK_ALLOC -- Do all three and none of the three.
-CONFIG_PREEMPT_COUNT
 CONFIG_RCU_TRACE
 
 The theory here is that randconfig testing will hit the other six possible
diff --git a/tools/testing/selftests/rcutorture/doc/TREE_RCU-kconfig.txt b/tools/testing/selftests/rcutorture/doc/TREE_RCU-kconfig.txt
index 42acb1a64ce1..9e851c80c5eb 100644
--- a/tools/testing/selftests/rcutorture/doc/TREE_RCU-kconfig.txt
+++ b/tools/testing/selftests/rcutorture/doc/TREE_RCU-kconfig.txt
@@ -42,7 +42,6 @@ CONFIG_64BIT
 
 	Used only to check CONFIG_RCU_FANOUT value, inspection suffices.
 
-CONFIG_PREEMPT_COUNT
 CONFIG_PREEMPT_RCU
 
 	Redundant with CONFIG_PREEMPT, ignore.
diff --git a/tools/testing/selftests/rcutorture/formal/srcu-cbmc/src/config.h b/tools/testing/selftests/rcutorture/formal/srcu-cbmc/src/config.h
index 283d7103334f..d0d485d48649 100644
--- a/tools/testing/selftests/rcutorture/formal/srcu-cbmc/src/config.h
+++ b/tools/testing/selftests/rcutorture/formal/srcu-cbmc/src/config.h
@@ -8,7 +8,6 @@
 #undef CONFIG_HOTPLUG_CPU
 #undef CONFIG_MODULES
 #undef CONFIG_NO_HZ_FULL_SYSIDLE
-#undef CONFIG_PREEMPT_COUNT
 #undef CONFIG_PREEMPT_RCU
 #undef CONFIG_PROVE_RCU
 #undef CONFIG_RCU_NOCB_CPU
