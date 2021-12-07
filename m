Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37CC946BEE6
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Dec 2021 16:11:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238903AbhLGPNz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Dec 2021 10:13:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238716AbhLGPNh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Dec 2021 10:13:37 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E19AFC061D72;
        Tue,  7 Dec 2021 07:10:06 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 67BF1B817F8;
        Tue,  7 Dec 2021 15:10:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CDE9C341D2;
        Tue,  7 Dec 2021 15:09:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638889804;
        bh=FYa5JWso4Ayhhd4BQ27/FnDrynmPXfLG/fOT+65DJ0w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=I9gzWhvK/FYT2PYEG178pAkC16VSobPxyBczNZxEKldDeSXLSpmwtG0Q+/W2O5InQ
         P5fSM3kWT2flbgBi41bVhiGaFYzaxvGTXCpSlv7P6TMSgkvl1c/SbPWLm9QGZ0G74Q
         Vs2QE3X/HMlVXtQLxAsshpJitizMrlz8LN6sSMOzCFs6muyZ4+Js/2gFxiHynHL2Vs
         eiIoehTvNbno6BwJp8DPCPiiUT5xnVPcgXe1ielq6y9wO/HnNczYnB8/D2lS9OPvd7
         FzsXsddPtMiC32sQLlPPYhh/5mEBCwh3tsuJC48oWfiD0DjG4uN4nj77kWLegSz51n
         drHJxG0SBdpeg==
From:   Arnd Bergmann <arnd@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>, Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Guenter Roeck <groeck@chromium.org>,
        Kees Cook <keescook@chromium.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        kernel test robot <lkp@intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tejun Heo <tj@kernel.org>, kernelci@groups.io,
        linux-fsdevel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        llvm@lists.linux.dev
Subject: [RFC 2/3] headers: introduce linux/struct_types.h
Date:   Tue,  7 Dec 2021 16:09:26 +0100
Message-Id: <20211207150927.3042197-3-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20211207150927.3042197-1-arnd@kernel.org>
References: <20211207150927.3042197-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

Deeply nested recursive header includes cause a large compile-time
overhead for parsing an excessive amount of macros and inline functions,
and they cause rebuilding large parts of the kernel when a minor header
gets modified.

Most of the indirect header inclusions are done in order to import
type definitions for embedding structures within larger structures,
but most files that reference the larger structures do not care about
the interfaces that operate on the embedded structures.

Working towards a cleaner header structure, start by moving the most
commonly embedded structures into a single header file that itself
has only a minimum set of indirect includes. At this moment, this
include structures for

 - locking
 - timers
 - work queues
 - waitqueues
 - rcu
 - xarray
 - kobject
 - bio_vec

With these, we can build most of the high-level structures (mm,
task, device, skbuff, ...) while needing very few other headers,
and in particular avoiding the inclusion of large headers like
linux/mm.h, linux/sched.h or linux/spinlock.h that are fairly
expensive to parse.

Once there is consensus on the basic approach, we can start with
patches that replace excessive indirect includes from other headers
and just use this one instead where possible. There are some
tradeoffs to consider regarding how far we take this one, as
it is a departure from how we've always done it, but it's also
the most promising approach in my mind.

I have stopped short of including 'struct device' along with the
rest, since that seemed a little too big, but it is also a
structure that gets embedded in many places. On the other hand,
separatig the xarray, kobject and bio_vec structures from their
headers did seem to be clear wins. Alternatively, those could be
moved into newly added individual headers.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/alpha/include/asm/spinlock_types.h       |   2 +-
 arch/arm/include/asm/spinlock_types.h         |   2 +-
 arch/arm64/include/asm/spinlock_types.h       |   2 +-
 arch/csky/include/asm/spinlock_types.h        |   2 +-
 arch/hexagon/include/asm/spinlock_types.h     |   2 +-
 arch/ia64/include/asm/spinlock_types.h        |   2 +-
 .../include/asm/simple_spinlock_types.h       |   2 +-
 arch/powerpc/include/asm/spinlock_types.h     |   2 +-
 arch/riscv/include/asm/spinlock_types.h       |   2 +-
 arch/s390/include/asm/spinlock_types.h        |   2 +-
 arch/sh/include/asm/spinlock_types.h          |   2 +-
 arch/xtensa/include/asm/spinlock_types.h      |   2 +-
 include/linux/bitops.h                        |   6 -
 include/linux/bits.h                          |   6 +
 include/linux/bvec.h                          |  18 -
 include/linux/completion.h                    |  17 -
 include/linux/cpumask.h                       |   3 -
 include/linux/hrtimer.h                       |  32 --
 include/linux/kobject.h                       |  18 -
 include/linux/kref.h                          |   4 -
 include/linux/mutex.h                         |  51 --
 include/linux/osq_lock.h                      |   8 -
 include/linux/percpu-rwsem.h                  |  11 -
 include/linux/pid.h                           |   9 -
 include/linux/rcu_sync.h                      |   9 -
 include/linux/rcuwait.h                       |  12 -
 include/linux/refcount.h                      |  12 -
 include/linux/rtmutex.h                       |   8 +-
 include/linux/rwbase_rt.h                     |   5 -
 include/linux/rwlock_types.h                  |  19 -
 include/linux/rwsem.h                         |  40 --
 include/linux/seqlock.h                       |  31 --
 include/linux/spinlock_types.h                |  21 -
 include/linux/spinlock_types_raw.h            |  21 +-
 include/linux/spinlock_types_up.h             |   2 +-
 include/linux/struct_types.h                  | 483 ++++++++++++++++++
 include/linux/swait.h                         |  12 -
 include/linux/timer.h                         |  16 +-
 include/linux/timerqueue.h                    |  12 +-
 include/linux/wait.h                          |  29 --
 include/linux/workqueue.h                     |  27 -
 include/linux/xarray.h                        |  23 -
 42 files changed, 506 insertions(+), 483 deletions(-)
 create mode 100644 include/linux/struct_types.h

diff --git a/arch/alpha/include/asm/spinlock_types.h b/arch/alpha/include/asm/spinlock_types.h
index 1d5716bc060b..7cd2515169cf 100644
--- a/arch/alpha/include/asm/spinlock_types.h
+++ b/arch/alpha/include/asm/spinlock_types.h
@@ -2,7 +2,7 @@
 #ifndef _ALPHA_SPINLOCK_TYPES_H
 #define _ALPHA_SPINLOCK_TYPES_H
 
-#ifndef __LINUX_SPINLOCK_TYPES_H
+#ifndef __LINUX_STRUCT_TYPES_H
 # error "please don't include this file directly"
 #endif
 
diff --git a/arch/arm/include/asm/spinlock_types.h b/arch/arm/include/asm/spinlock_types.h
index 5976958647fe..104ebab73185 100644
--- a/arch/arm/include/asm/spinlock_types.h
+++ b/arch/arm/include/asm/spinlock_types.h
@@ -2,7 +2,7 @@
 #ifndef __ASM_SPINLOCK_TYPES_H
 #define __ASM_SPINLOCK_TYPES_H
 
-#ifndef __LINUX_SPINLOCK_TYPES_H
+#ifndef __LINUX_STRUCT_TYPES_H
 # error "please don't include this file directly"
 #endif
 
diff --git a/arch/arm64/include/asm/spinlock_types.h b/arch/arm64/include/asm/spinlock_types.h
index 18782f0c4721..f2bba81671e0 100644
--- a/arch/arm64/include/asm/spinlock_types.h
+++ b/arch/arm64/include/asm/spinlock_types.h
@@ -5,7 +5,7 @@
 #ifndef __ASM_SPINLOCK_TYPES_H
 #define __ASM_SPINLOCK_TYPES_H
 
-#if !defined(__LINUX_SPINLOCK_TYPES_H) && !defined(__ASM_SPINLOCK_H)
+#if !defined(__LINUX_STRUCT_TYPES_H) && !defined(__ASM_SPINLOCK_H)
 # error "please don't include this file directly"
 #endif
 
diff --git a/arch/csky/include/asm/spinlock_types.h b/arch/csky/include/asm/spinlock_types.h
index 8ff0f6ff3a00..bb1fb62426aa 100644
--- a/arch/csky/include/asm/spinlock_types.h
+++ b/arch/csky/include/asm/spinlock_types.h
@@ -3,7 +3,7 @@
 #ifndef __ASM_CSKY_SPINLOCK_TYPES_H
 #define __ASM_CSKY_SPINLOCK_TYPES_H
 
-#ifndef __LINUX_SPINLOCK_TYPES_H
+#ifndef __LINUX_STRUCT_TYPES_H
 # error "please don't include this file directly"
 #endif
 
diff --git a/arch/hexagon/include/asm/spinlock_types.h b/arch/hexagon/include/asm/spinlock_types.h
index 19d233497ba5..086f15d76833 100644
--- a/arch/hexagon/include/asm/spinlock_types.h
+++ b/arch/hexagon/include/asm/spinlock_types.h
@@ -8,7 +8,7 @@
 #ifndef _ASM_SPINLOCK_TYPES_H
 #define _ASM_SPINLOCK_TYPES_H
 
-#ifndef __LINUX_SPINLOCK_TYPES_H
+#ifndef __LINUX_STRUCT_TYPES_H
 # error "please don't include this file directly"
 #endif
 
diff --git a/arch/ia64/include/asm/spinlock_types.h b/arch/ia64/include/asm/spinlock_types.h
index 6e345fefcdca..3bbddc8b04d3 100644
--- a/arch/ia64/include/asm/spinlock_types.h
+++ b/arch/ia64/include/asm/spinlock_types.h
@@ -2,7 +2,7 @@
 #ifndef _ASM_IA64_SPINLOCK_TYPES_H
 #define _ASM_IA64_SPINLOCK_TYPES_H
 
-#ifndef __LINUX_SPINLOCK_TYPES_H
+#ifndef __LINUX_STRUCT_TYPES_H
 # error "please don't include this file directly"
 #endif
 
diff --git a/arch/powerpc/include/asm/simple_spinlock_types.h b/arch/powerpc/include/asm/simple_spinlock_types.h
index 0f3cdd8faa95..4afc9cb919c5 100644
--- a/arch/powerpc/include/asm/simple_spinlock_types.h
+++ b/arch/powerpc/include/asm/simple_spinlock_types.h
@@ -2,7 +2,7 @@
 #ifndef _ASM_POWERPC_SIMPLE_SPINLOCK_TYPES_H
 #define _ASM_POWERPC_SIMPLE_SPINLOCK_TYPES_H
 
-#ifndef __LINUX_SPINLOCK_TYPES_H
+#ifndef __LINUX_STRUCT_TYPES_H
 # error "please don't include this file directly"
 #endif
 
diff --git a/arch/powerpc/include/asm/spinlock_types.h b/arch/powerpc/include/asm/spinlock_types.h
index c5d742f18021..2264b4047799 100644
--- a/arch/powerpc/include/asm/spinlock_types.h
+++ b/arch/powerpc/include/asm/spinlock_types.h
@@ -2,7 +2,7 @@
 #ifndef _ASM_POWERPC_SPINLOCK_TYPES_H
 #define _ASM_POWERPC_SPINLOCK_TYPES_H
 
-#ifndef __LINUX_SPINLOCK_TYPES_H
+#ifndef __LINUX_STRUCT_TYPES_H
 # error "please don't include this file directly"
 #endif
 
diff --git a/arch/riscv/include/asm/spinlock_types.h b/arch/riscv/include/asm/spinlock_types.h
index f398e7638dd6..e3c2fec0fa41 100644
--- a/arch/riscv/include/asm/spinlock_types.h
+++ b/arch/riscv/include/asm/spinlock_types.h
@@ -6,7 +6,7 @@
 #ifndef _ASM_RISCV_SPINLOCK_TYPES_H
 #define _ASM_RISCV_SPINLOCK_TYPES_H
 
-#ifndef __LINUX_SPINLOCK_TYPES_H
+#ifndef __LINUX_STRUCT_TYPES_H
 # error "please don't include this file directly"
 #endif
 
diff --git a/arch/s390/include/asm/spinlock_types.h b/arch/s390/include/asm/spinlock_types.h
index a2bbfd7df85f..1f48a5f0e591 100644
--- a/arch/s390/include/asm/spinlock_types.h
+++ b/arch/s390/include/asm/spinlock_types.h
@@ -2,7 +2,7 @@
 #ifndef __ASM_SPINLOCK_TYPES_H
 #define __ASM_SPINLOCK_TYPES_H
 
-#ifndef __LINUX_SPINLOCK_TYPES_H
+#ifndef __LINUX_STRUCT_TYPES_H
 # error "please don't include this file directly"
 #endif
 
diff --git a/arch/sh/include/asm/spinlock_types.h b/arch/sh/include/asm/spinlock_types.h
index e82369f286a2..8ec6d822057b 100644
--- a/arch/sh/include/asm/spinlock_types.h
+++ b/arch/sh/include/asm/spinlock_types.h
@@ -2,7 +2,7 @@
 #ifndef __ASM_SH_SPINLOCK_TYPES_H
 #define __ASM_SH_SPINLOCK_TYPES_H
 
-#ifndef __LINUX_SPINLOCK_TYPES_H
+#ifndef __LINUX_STRUCT_TYPES_H
 # error "please don't include this file directly"
 #endif
 
diff --git a/arch/xtensa/include/asm/spinlock_types.h b/arch/xtensa/include/asm/spinlock_types.h
index 64c9389254f1..33e43b619392 100644
--- a/arch/xtensa/include/asm/spinlock_types.h
+++ b/arch/xtensa/include/asm/spinlock_types.h
@@ -2,7 +2,7 @@
 #ifndef __ASM_SPINLOCK_TYPES_H
 #define __ASM_SPINLOCK_TYPES_H
 
-#if !defined(__LINUX_SPINLOCK_TYPES_H) && !defined(__ASM_SPINLOCK_H)
+#if !defined(__LINUX_STRUCT_TYPES_H) && !defined(__ASM_SPINLOCK_H)
 # error "please don't include this file directly"
 #endif
 
diff --git a/include/linux/bitops.h b/include/linux/bitops.h
index 7aaed501f768..d7dbc762c45f 100644
--- a/include/linux/bitops.h
+++ b/include/linux/bitops.h
@@ -15,12 +15,6 @@
 #  define aligned_byte_mask(n) (~0xffUL << (BITS_PER_LONG - 8 - 8*(n)))
 #endif
 
-#define BITS_PER_TYPE(type)	(sizeof(type) * BITS_PER_BYTE)
-#define BITS_TO_LONGS(nr)	__KERNEL_DIV_ROUND_UP(nr, BITS_PER_TYPE(long))
-#define BITS_TO_U64(nr)		__KERNEL_DIV_ROUND_UP(nr, BITS_PER_TYPE(u64))
-#define BITS_TO_U32(nr)		__KERNEL_DIV_ROUND_UP(nr, BITS_PER_TYPE(u32))
-#define BITS_TO_BYTES(nr)	__KERNEL_DIV_ROUND_UP(nr, BITS_PER_TYPE(char))
-
 extern unsigned int __sw_hweight8(unsigned int w);
 extern unsigned int __sw_hweight16(unsigned int w);
 extern unsigned int __sw_hweight32(unsigned int w);
diff --git a/include/linux/bits.h b/include/linux/bits.h
index 87d112650dfb..bae942e9427e 100644
--- a/include/linux/bits.h
+++ b/include/linux/bits.h
@@ -13,6 +13,12 @@
 #define BIT_ULL_WORD(nr)	((nr) / BITS_PER_LONG_LONG)
 #define BITS_PER_BYTE		8
 
+#define BITS_PER_TYPE(type)	(sizeof(type) * BITS_PER_BYTE)
+#define BITS_TO_LONGS(nr)	__KERNEL_DIV_ROUND_UP(nr, BITS_PER_TYPE(long))
+#define BITS_TO_U64(nr)		__KERNEL_DIV_ROUND_UP(nr, BITS_PER_TYPE(u64))
+#define BITS_TO_U32(nr)		__KERNEL_DIV_ROUND_UP(nr, BITS_PER_TYPE(u32))
+#define BITS_TO_BYTES(nr)	__KERNEL_DIV_ROUND_UP(nr, BITS_PER_TYPE(char))
+
 /*
  * Create a contiguous bitmask starting at bit position @l and ending at
  * position @h. For example
diff --git a/include/linux/bvec.h b/include/linux/bvec.h
index 35c25dff651a..74863e68e115 100644
--- a/include/linux/bvec.h
+++ b/include/linux/bvec.h
@@ -17,24 +17,6 @@
 
 struct page;
 
-/**
- * struct bio_vec - a contiguous range of physical memory addresses
- * @bv_page:   First page associated with the address range.
- * @bv_len:    Number of bytes in the address range.
- * @bv_offset: Start of the address range relative to the start of @bv_page.
- *
- * The following holds for a bvec if n * PAGE_SIZE < bv_offset + bv_len:
- *
- *   nth_page(@bv_page, n) == @bv_page + n
- *
- * This holds because page_is_mergeable() checks the above property.
- */
-struct bio_vec {
-	struct page	*bv_page;
-	unsigned int	bv_len;
-	unsigned int	bv_offset;
-};
-
 struct bvec_iter {
 	sector_t		bi_sector;	/* device address in 512 byte
 						   sectors */
diff --git a/include/linux/completion.h b/include/linux/completion.h
index 51d9ab079629..29917878e650 100644
--- a/include/linux/completion.h
+++ b/include/linux/completion.h
@@ -11,23 +11,6 @@
 
 #include <linux/swait.h>
 
-/*
- * struct completion - structure used to maintain state for a "completion"
- *
- * This is the opaque structure used to maintain the state for a "completion".
- * Completions currently use a FIFO to queue threads that have to wait for
- * the "completion" event.
- *
- * See also:  complete(), wait_for_completion() (and friends _timeout,
- * _interruptible, _interruptible_timeout, and _killable), init_completion(),
- * reinit_completion(), and macros DECLARE_COMPLETION(),
- * DECLARE_COMPLETION_ONSTACK().
- */
-struct completion {
-	unsigned int done;
-	struct swait_queue_head wait;
-};
-
 #define init_completion_map(x, m) init_completion(x)
 static inline void complete_acquire(struct completion *x) {}
 static inline void complete_release(struct completion *x) {}
diff --git a/include/linux/cpumask.h b/include/linux/cpumask.h
index 64dae70d31f5..d0333b7b958e 100644
--- a/include/linux/cpumask.h
+++ b/include/linux/cpumask.h
@@ -13,9 +13,6 @@
 #include <linux/atomic.h>
 #include <linux/bug.h>
 
-/* Don't assign or return these: may not be this big! */
-typedef struct cpumask { DECLARE_BITMAP(bits, NR_CPUS); } cpumask_t;
-
 /**
  * cpumask_bits - get the bits in a cpumask
  * @maskp: the struct cpumask *
diff --git a/include/linux/hrtimer.h b/include/linux/hrtimer.h
index 0ee140176f10..a60d7eda9709 100644
--- a/include/linux/hrtimer.h
+++ b/include/linux/hrtimer.h
@@ -94,38 +94,6 @@ enum hrtimer_restart {
 #define HRTIMER_STATE_INACTIVE	0x00
 #define HRTIMER_STATE_ENQUEUED	0x01
 
-/**
- * struct hrtimer - the basic hrtimer structure
- * @node:	timerqueue node, which also manages node.expires,
- *		the absolute expiry time in the hrtimers internal
- *		representation. The time is related to the clock on
- *		which the timer is based. Is setup by adding
- *		slack to the _softexpires value. For non range timers
- *		identical to _softexpires.
- * @_softexpires: the absolute earliest expiry time of the hrtimer.
- *		The time which was given as expiry time when the timer
- *		was armed.
- * @function:	timer expiry callback function
- * @base:	pointer to the timer base (per cpu and per clock)
- * @state:	state information (See bit values above)
- * @is_rel:	Set if the timer was armed relative
- * @is_soft:	Set if hrtimer will be expired in soft interrupt context.
- * @is_hard:	Set if hrtimer will be expired in hard interrupt context
- *		even on RT.
- *
- * The hrtimer structure must be initialized by hrtimer_init()
- */
-struct hrtimer {
-	struct timerqueue_node		node;
-	ktime_t				_softexpires;
-	enum hrtimer_restart		(*function)(struct hrtimer *);
-	struct hrtimer_clock_base	*base;
-	u8				state;
-	u8				is_rel;
-	u8				is_soft;
-	u8				is_hard;
-};
-
 /**
  * struct hrtimer_sleeper - simple sleeper structure
  * @timer:	embedded timer structure
diff --git a/include/linux/kobject.h b/include/linux/kobject.h
index c740062b4b1a..9d33cf8a468f 100644
--- a/include/linux/kobject.h
+++ b/include/linux/kobject.h
@@ -61,24 +61,6 @@ enum kobject_action {
 	KOBJ_UNBIND,
 };
 
-struct kobject {
-	const char		*name;
-	struct list_head	entry;
-	struct kobject		*parent;
-	struct kset		*kset;
-	struct kobj_type	*ktype;
-	struct kernfs_node	*sd; /* sysfs directory entry */
-	struct kref		kref;
-#ifdef CONFIG_DEBUG_KOBJECT_RELEASE
-	struct delayed_work	release;
-#endif
-	unsigned int state_initialized:1;
-	unsigned int state_in_sysfs:1;
-	unsigned int state_add_uevent_sent:1;
-	unsigned int state_remove_uevent_sent:1;
-	unsigned int uevent_suppress:1;
-};
-
 extern __printf(2, 3)
 int kobject_set_name(struct kobject *kobj, const char *name, ...);
 extern __printf(2, 0)
diff --git a/include/linux/kref.h b/include/linux/kref.h
index d32e21a2538c..d926b2ec2d14 100644
--- a/include/linux/kref.h
+++ b/include/linux/kref.h
@@ -16,10 +16,6 @@
 #include <linux/spinlock.h>
 #include <linux/refcount.h>
 
-struct kref {
-	refcount_t refcount;
-};
-
 #define KREF_INIT(n)	{ .refcount = REFCOUNT_INIT(n), }
 
 /**
diff --git a/include/linux/mutex.h b/include/linux/mutex.h
index 8f226d460f51..e8e0a352128b 100644
--- a/include/linux/mutex.h
+++ b/include/linux/mutex.h
@@ -31,50 +31,6 @@
 #endif
 
 #ifndef CONFIG_PREEMPT_RT
-
-/*
- * Simple, straightforward mutexes with strict semantics:
- *
- * - only one task can hold the mutex at a time
- * - only the owner can unlock the mutex
- * - multiple unlocks are not permitted
- * - recursive locking is not permitted
- * - a mutex object must be initialized via the API
- * - a mutex object must not be initialized via memset or copying
- * - task may not exit with mutex held
- * - memory areas where held locks reside must not be freed
- * - held mutexes must not be reinitialized
- * - mutexes may not be used in hardware or software interrupt
- *   contexts such as tasklets and timers
- *
- * These semantics are fully enforced when DEBUG_MUTEXES is
- * enabled. Furthermore, besides enforcing the above rules, the mutex
- * debugging code also implements a number of additional features
- * that make lock debugging easier and faster:
- *
- * - uses symbolic names of mutexes, whenever they are printed in debug output
- * - point-of-acquire tracking, symbolic lookup of function names
- * - list of all locks held in the system, printout of them
- * - owner tracking
- * - detects self-recursing locks and prints out all relevant info
- * - detects multi-task circular deadlocks and prints out all affected
- *   locks and tasks (and only those tasks)
- */
-struct mutex {
-	atomic_long_t		owner;
-	raw_spinlock_t		wait_lock;
-#ifdef CONFIG_MUTEX_SPIN_ON_OWNER
-	struct optimistic_spin_queue osq; /* Spinner MCS lock */
-#endif
-	struct list_head	wait_list;
-#ifdef CONFIG_DEBUG_MUTEXES
-	void			*magic;
-#endif
-#ifdef CONFIG_DEBUG_LOCK_ALLOC
-	struct lockdep_map	dep_map;
-#endif
-};
-
 #ifdef CONFIG_DEBUG_MUTEXES
 
 #define __DEBUG_MUTEX_INITIALIZER(lockname)				\
@@ -132,13 +88,6 @@ extern bool mutex_is_locked(struct mutex *lock);
  */
 #include <linux/rtmutex.h>
 
-struct mutex {
-	struct rt_mutex_base	rtmutex;
-#ifdef CONFIG_DEBUG_LOCK_ALLOC
-	struct lockdep_map	dep_map;
-#endif
-};
-
 #define __MUTEX_INITIALIZER(mutexname)					\
 {									\
 	.rtmutex = __RT_MUTEX_BASE_INITIALIZER(mutexname.rtmutex)	\
diff --git a/include/linux/osq_lock.h b/include/linux/osq_lock.h
index 5581dbd3bd34..782136e5fcf6 100644
--- a/include/linux/osq_lock.h
+++ b/include/linux/osq_lock.h
@@ -12,14 +12,6 @@ struct optimistic_spin_node {
 	int cpu; /* encoded CPU # + 1 value */
 };
 
-struct optimistic_spin_queue {
-	/*
-	 * Stores an encoded value of the CPU # of the tail node in the queue.
-	 * If the queue is empty, then it's set to OSQ_UNLOCKED_VAL.
-	 */
-	atomic_t tail;
-};
-
 #define OSQ_UNLOCKED_VAL (0)
 
 /* Init macro and function. */
diff --git a/include/linux/percpu-rwsem.h b/include/linux/percpu-rwsem.h
index 5fda40f97fe9..b9f611997124 100644
--- a/include/linux/percpu-rwsem.h
+++ b/include/linux/percpu-rwsem.h
@@ -9,17 +9,6 @@
 #include <linux/rcu_sync.h>
 #include <linux/lockdep.h>
 
-struct percpu_rw_semaphore {
-	struct rcu_sync		rss;
-	unsigned int __percpu	*read_count;
-	struct rcuwait		writer;
-	wait_queue_head_t	waiters;
-	atomic_t		block;
-#ifdef CONFIG_DEBUG_LOCK_ALLOC
-	struct lockdep_map	dep_map;
-#endif
-};
-
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
 #define __PERCPU_RWSEM_DEP_MAP_INIT(lockname)	.dep_map = { .name = #lockname },
 #else
diff --git a/include/linux/pid.h b/include/linux/pid.h
index 343abf22092e..5ca6e1efaeeb 100644
--- a/include/linux/pid.h
+++ b/include/linux/pid.h
@@ -6,15 +6,6 @@
 #include <linux/wait.h>
 #include <linux/refcount.h>
 
-enum pid_type
-{
-	PIDTYPE_PID,
-	PIDTYPE_TGID,
-	PIDTYPE_PGID,
-	PIDTYPE_SID,
-	PIDTYPE_MAX,
-};
-
 /*
  * What is struct pid?
  *
diff --git a/include/linux/rcu_sync.h b/include/linux/rcu_sync.h
index 0027d4c8087c..c4f8a765481e 100644
--- a/include/linux/rcu_sync.h
+++ b/include/linux/rcu_sync.h
@@ -13,15 +13,6 @@
 #include <linux/wait.h>
 #include <linux/rcupdate.h>
 
-/* Structure to mediate between updaters and fastpath-using readers.  */
-struct rcu_sync {
-	int			gp_state;
-	int			gp_count;
-	wait_queue_head_t	gp_wait;
-
-	struct rcu_head		cb_head;
-};
-
 /**
  * rcu_sync_is_idle() - Are readers permitted to use their fastpaths?
  * @rsp: Pointer to rcu_sync structure to use for synchronization
diff --git a/include/linux/rcuwait.h b/include/linux/rcuwait.h
index 61c56cca95c4..4e8fdf939dd8 100644
--- a/include/linux/rcuwait.h
+++ b/include/linux/rcuwait.h
@@ -5,18 +5,6 @@
 #include <linux/rcupdate.h>
 #include <linux/sched/signal.h>
 
-/*
- * rcuwait provides a way of blocking and waking up a single
- * task in an rcu-safe manner.
- *
- * The only time @task is non-nil is when a user is blocked (or
- * checking if it needs to) on a condition, and reset as soon as we
- * know that the condition has succeeded and are awoken.
- */
-struct rcuwait {
-	struct task_struct __rcu *task;
-};
-
 #define __RCUWAIT_INITIALIZER(name)		\
 	{ .task = NULL, }
 
diff --git a/include/linux/refcount.h b/include/linux/refcount.h
index b8a6e387f8f9..63c7b8c9e4e8 100644
--- a/include/linux/refcount.h
+++ b/include/linux/refcount.h
@@ -100,18 +100,6 @@
 
 struct mutex;
 
-/**
- * typedef refcount_t - variant of atomic_t specialized for reference counts
- * @refs: atomic_t counter field
- *
- * The counter saturates at REFCOUNT_SATURATED and will not move once
- * there. This avoids wrapping the counter and causing 'spurious'
- * use-after-free bugs.
- */
-typedef struct refcount_struct {
-	atomic_t refs;
-} refcount_t;
-
 #define REFCOUNT_INIT(n)	{ .refs = ATOMIC_INIT(n), }
 #define REFCOUNT_MAX		INT_MAX
 #define REFCOUNT_SATURATED	(INT_MIN / 2)
diff --git a/include/linux/rtmutex.h b/include/linux/rtmutex.h
index 9deedfeec2b1..0b071bd6805d 100644
--- a/include/linux/rtmutex.h
+++ b/include/linux/rtmutex.h
@@ -15,17 +15,11 @@
 
 #include <linux/compiler.h>
 #include <linux/linkage.h>
-#include <linux/rbtree_types.h>
+#include <linux/struct_types.h>
 #include <linux/spinlock_types_raw.h>
 
 extern int max_lock_depth; /* for sysctl */
 
-struct rt_mutex_base {
-	raw_spinlock_t		wait_lock;
-	struct rb_root_cached   waiters;
-	struct task_struct	*owner;
-};
-
 #define __RT_MUTEX_BASE_INITIALIZER(rtbasename)				\
 {									\
 	.wait_lock = __RAW_SPIN_LOCK_UNLOCKED(rtbasename.wait_lock),	\
diff --git a/include/linux/rwbase_rt.h b/include/linux/rwbase_rt.h
index 1d264dd08625..7a0bec89974e 100644
--- a/include/linux/rwbase_rt.h
+++ b/include/linux/rwbase_rt.h
@@ -8,11 +8,6 @@
 #define READER_BIAS		(1U << 31)
 #define WRITER_BIAS		(1U << 30)
 
-struct rwbase_rt {
-	atomic_t		readers;
-	struct rt_mutex_base	rtmutex;
-};
-
 #define __RWBASE_INITIALIZER(name)				\
 {								\
 	.readers = ATOMIC_INIT(READER_BIAS),			\
diff --git a/include/linux/rwlock_types.h b/include/linux/rwlock_types.h
index 1948442e7750..8675a7b10688 100644
--- a/include/linux/rwlock_types.h
+++ b/include/linux/rwlock_types.h
@@ -22,17 +22,6 @@
  * portions Copyright 2005, Red Hat, Inc., Ingo Molnar
  * Released under the General Public License (GPL).
  */
-typedef struct {
-	arch_rwlock_t raw_lock;
-#ifdef CONFIG_DEBUG_SPINLOCK
-	unsigned int magic, owner_cpu;
-	void *owner;
-#endif
-#ifdef CONFIG_DEBUG_LOCK_ALLOC
-	struct lockdep_map dep_map;
-#endif
-} rwlock_t;
-
 #define RWLOCK_MAGIC		0xdeaf1eed
 
 #ifdef CONFIG_DEBUG_SPINLOCK
@@ -54,14 +43,6 @@ typedef struct {
 
 #include <linux/rwbase_rt.h>
 
-typedef struct {
-	struct rwbase_rt	rwbase;
-	atomic_t		readers;
-#ifdef CONFIG_DEBUG_LOCK_ALLOC
-	struct lockdep_map	dep_map;
-#endif
-} rwlock_t;
-
 #define __RWLOCK_RT_INITIALIZER(name)					\
 {									\
 	.rwbase = __RWBASE_INITIALIZER(name),				\
diff --git a/include/linux/rwsem.h b/include/linux/rwsem.h
index f9348769e558..462cda939c4e 100644
--- a/include/linux/rwsem.h
+++ b/include/linux/rwsem.h
@@ -32,39 +32,6 @@
 #include <linux/osq_lock.h>
 #endif
 
-/*
- * For an uncontended rwsem, count and owner are the only fields a task
- * needs to touch when acquiring the rwsem. So they are put next to each
- * other to increase the chance that they will share the same cacheline.
- *
- * In a contended rwsem, the owner is likely the most frequently accessed
- * field in the structure as the optimistic waiter that holds the osq lock
- * will spin on owner. For an embedded rwsem, other hot fields in the
- * containing structure should be moved further away from the rwsem to
- * reduce the chance that they will share the same cacheline causing
- * cacheline bouncing problem.
- */
-struct rw_semaphore {
-	atomic_long_t count;
-	/*
-	 * Write owner or one of the read owners as well flags regarding
-	 * the current state of the rwsem. Can be used as a speculative
-	 * check to see if the write owner is running on the cpu.
-	 */
-	atomic_long_t owner;
-#ifdef CONFIG_RWSEM_SPIN_ON_OWNER
-	struct optimistic_spin_queue osq; /* spinner MCS lock */
-#endif
-	raw_spinlock_t wait_lock;
-	struct list_head wait_list;
-#ifdef CONFIG_DEBUG_RWSEMS
-	void *magic;
-#endif
-#ifdef CONFIG_DEBUG_LOCK_ALLOC
-	struct lockdep_map	dep_map;
-#endif
-};
-
 /* In all implementations count != 0 means locked */
 static inline int rwsem_is_locked(struct rw_semaphore *sem)
 {
@@ -125,13 +92,6 @@ static inline int rwsem_is_contended(struct rw_semaphore *sem)
 
 #include <linux/rwbase_rt.h>
 
-struct rw_semaphore {
-	struct rwbase_rt	rwbase;
-#ifdef CONFIG_DEBUG_LOCK_ALLOC
-	struct lockdep_map	dep_map;
-#endif
-};
-
 #define __RWSEM_INITIALIZER(name)				\
 	{							\
 		.rwbase = __RWBASE_INITIALIZER(name),		\
diff --git a/include/linux/seqlock.h b/include/linux/seqlock.h
index 37ded6b8fee6..622cba2a45ff 100644
--- a/include/linux/seqlock.h
+++ b/include/linux/seqlock.h
@@ -38,37 +38,6 @@
  */
 #define KCSAN_SEQLOCK_REGION_MAX 1000
 
-/*
- * Sequence counters (seqcount_t)
- *
- * This is the raw counting mechanism, without any writer protection.
- *
- * Write side critical sections must be serialized and non-preemptible.
- *
- * If readers can be invoked from hardirq or softirq contexts,
- * interrupts or bottom halves must also be respectively disabled before
- * entering the write section.
- *
- * This mechanism can't be used if the protected data contains pointers,
- * as the writer can invalidate a pointer that a reader is following.
- *
- * If the write serialization mechanism is one of the common kernel
- * locking primitives, use a sequence counter with associated lock
- * (seqcount_LOCKNAME_t) instead.
- *
- * If it's desired to automatically handle the sequence counter writer
- * serialization and non-preemptibility requirements, use a sequential
- * lock (seqlock_t) instead.
- *
- * See Documentation/locking/seqlock.rst
- */
-typedef struct seqcount {
-	unsigned sequence;
-#ifdef CONFIG_DEBUG_LOCK_ALLOC
-	struct lockdep_map dep_map;
-#endif
-} seqcount_t;
-
 static inline void __seqcount_init(seqcount_t *s, const char *name,
 					  struct lock_class_key *key)
 {
diff --git a/include/linux/spinlock_types.h b/include/linux/spinlock_types.h
index 2dfa35ffec76..c1f481d334ae 100644
--- a/include/linux/spinlock_types.h
+++ b/include/linux/spinlock_types.h
@@ -14,20 +14,6 @@
 #ifndef CONFIG_PREEMPT_RT
 
 /* Non PREEMPT_RT kernels map spinlock to raw_spinlock */
-typedef struct spinlock {
-	union {
-		struct raw_spinlock rlock;
-
-#ifdef CONFIG_DEBUG_LOCK_ALLOC
-# define LOCK_PADSIZE (offsetof(struct raw_spinlock, dep_map))
-		struct {
-			u8 __padding[LOCK_PADSIZE];
-			struct lockdep_map dep_map;
-		};
-#endif
-	};
-} spinlock_t;
-
 #define ___SPIN_LOCK_INITIALIZER(lockname)	\
 	{					\
 	.raw_lock = __ARCH_SPIN_LOCK_UNLOCKED,	\
@@ -47,13 +33,6 @@ typedef struct spinlock {
 /* PREEMPT_RT kernels map spinlock to rt_mutex */
 #include <linux/rtmutex.h>
 
-typedef struct spinlock {
-	struct rt_mutex_base	lock;
-#ifdef CONFIG_DEBUG_LOCK_ALLOC
-	struct lockdep_map	dep_map;
-#endif
-} spinlock_t;
-
 #define __SPIN_LOCK_UNLOCKED(name)				\
 	{							\
 		.lock = __RT_MUTEX_BASE_INITIALIZER(name.lock),	\
diff --git a/include/linux/spinlock_types_raw.h b/include/linux/spinlock_types_raw.h
index 91cb36b65a17..f6a1737f2ab8 100644
--- a/include/linux/spinlock_types_raw.h
+++ b/include/linux/spinlock_types_raw.h
@@ -1,26 +1,7 @@
 #ifndef __LINUX_SPINLOCK_TYPES_RAW_H
 #define __LINUX_SPINLOCK_TYPES_RAW_H
 
-#include <linux/types.h>
-
-#if defined(CONFIG_SMP)
-# include <asm/spinlock_types.h>
-#else
-# include <linux/spinlock_types_up.h>
-#endif
-
-#include <linux/lockdep_types.h>
-
-typedef struct raw_spinlock {
-	arch_spinlock_t raw_lock;
-#ifdef CONFIG_DEBUG_SPINLOCK
-	unsigned int magic, owner_cpu;
-	void *owner;
-#endif
-#ifdef CONFIG_DEBUG_LOCK_ALLOC
-	struct lockdep_map dep_map;
-#endif
-} raw_spinlock_t;
+#include <linux/struct_types.h>
 
 #define SPINLOCK_MAGIC		0xdead4ead
 
diff --git a/include/linux/spinlock_types_up.h b/include/linux/spinlock_types_up.h
index c09b6407ae1b..5b0cf1d86105 100644
--- a/include/linux/spinlock_types_up.h
+++ b/include/linux/spinlock_types_up.h
@@ -1,7 +1,7 @@
 #ifndef __LINUX_SPINLOCK_TYPES_UP_H
 #define __LINUX_SPINLOCK_TYPES_UP_H
 
-#ifndef __LINUX_SPINLOCK_TYPES_H
+#ifndef __LINUX_STRUCT_TYPES_H
 # error "please don't include this file directly"
 #endif
 
diff --git a/include/linux/struct_types.h b/include/linux/struct_types.h
new file mode 100644
index 000000000000..5a06849fd347
--- /dev/null
+++ b/include/linux/struct_types.h
@@ -0,0 +1,483 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __LINUX_STRUCT_TYPES_H
+#define __LINUX_STRUCT_TYPES_H
+/*
+ * This header includes data structures that build on top of
+ * the plain types from linux/types.h and that are commonly
+ * embedded within other structures in the kernel.
+ *
+ * By keeping these in one place that has a minimum set of
+ * indirect includes, we can avoid deeply nested include
+ * hierarchies that slow down the build and cause frequent
+ * recompiles after header changes.
+ *
+ * Be careful about including further headers here.
+ */
+
+#include <linux/types.h>
+#include <linux/bits.h>
+#include <linux/threads.h>
+#include <linux/lockdep_types.h>
+#include <linux/rbtree_types.h>
+
+#if defined(CONFIG_SMP)
+# include <asm/spinlock_types.h>
+#else
+# include <linux/spinlock_types_up.h>
+#endif
+
+/**
+ * typedef refcount_t - variant of atomic_t specialized for reference counts
+ * @refs: atomic_t counter field
+ *
+ * The counter saturates at REFCOUNT_SATURATED and will not move once
+ * there. This avoids wrapping the counter and causing 'spurious'
+ * use-after-free bugs.
+ */
+typedef struct refcount_struct {
+	atomic_t refs;
+} refcount_t;
+
+struct kref {
+	refcount_t refcount;
+};
+
+typedef struct raw_spinlock {
+	arch_spinlock_t raw_lock;
+#ifdef CONFIG_DEBUG_SPINLOCK
+	unsigned int magic, owner_cpu;
+	void *owner;
+#endif
+#ifdef CONFIG_DEBUG_LOCK_ALLOC
+	struct lockdep_map dep_map;
+#endif
+} raw_spinlock_t;
+
+struct task_struct;
+struct rt_mutex_base {
+	raw_spinlock_t		wait_lock;
+	struct rb_root_cached   waiters;
+	struct task_struct	*owner;
+};
+
+#ifndef CONFIG_PREEMPT_RT
+/* Non PREEMPT_RT kernels map spinlock to raw_spinlock */
+typedef struct spinlock {
+	union {
+		struct raw_spinlock rlock;
+
+#ifdef CONFIG_DEBUG_LOCK_ALLOC
+# define LOCK_PADSIZE (offsetof(struct raw_spinlock, dep_map))
+		struct {
+			u8 __padding[LOCK_PADSIZE];
+			struct lockdep_map dep_map;
+		};
+#endif
+	};
+} spinlock_t;
+#else
+/* PREEMPT_RT kernels map spinlock to rt_mutex */
+typedef struct spinlock {
+	struct rt_mutex_base	lock;
+#ifdef CONFIG_DEBUG_LOCK_ALLOC
+	struct lockdep_map	dep_map;
+#endif
+} spinlock_t;
+#endif
+
+#ifndef CONFIG_PREEMPT_RT
+typedef struct {
+	arch_rwlock_t raw_lock;
+#ifdef CONFIG_DEBUG_SPINLOCK
+	unsigned int magic, owner_cpu;
+	void *owner;
+#endif
+#ifdef CONFIG_DEBUG_LOCK_ALLOC
+	struct lockdep_map dep_map;
+#endif
+} rwlock_t;
+#else
+struct rwbase_rt {
+	atomic_t		readers;
+	struct rt_mutex_base	rtmutex;
+};
+
+typedef struct {
+	struct rwbase_rt	rwbase;
+	atomic_t		readers;
+#ifdef CONFIG_DEBUG_LOCK_ALLOC
+	struct lockdep_map	dep_map;
+#endif
+} rwlock_t;
+#endif
+
+struct optimistic_spin_queue {
+	/*
+	 * Stores an encoded value of the CPU # of the tail node in the queue.
+	 * If the queue is empty, then it's set to OSQ_UNLOCKED_VAL.
+	 */
+	atomic_t tail;
+};
+
+#ifndef CONFIG_PREEMPT_RT
+/*
+ * Simple, straightforward mutexes with strict semantics:
+ *
+ * - only one task can hold the mutex at a time
+ * - only the owner can unlock the mutex
+ * - multiple unlocks are not permitted
+ * - recursive locking is not permitted
+ * - a mutex object must be initialized via the API
+ * - a mutex object must not be initialized via memset or copying
+ * - task may not exit with mutex held
+ * - memory areas where held locks reside must not be freed
+ * - held mutexes must not be reinitialized
+ * - mutexes may not be used in hardware or software interrupt
+ *   contexts such as tasklets and timers
+ *
+ * These semantics are fully enforced when DEBUG_MUTEXES is
+ * enabled. Furthermore, besides enforcing the above rules, the mutex
+ * debugging code also implements a number of additional features
+ * that make lock debugging easier and faster:
+ *
+ * - uses symbolic names of mutexes, whenever they are printed in debug output
+ * - point-of-acquire tracking, symbolic lookup of function names
+ * - list of all locks held in the system, printout of them
+ * - owner tracking
+ * - detects self-recursing locks and prints out all relevant info
+ * - detects multi-task circular deadlocks and prints out all affected
+ *   locks and tasks (and only those tasks)
+ */
+struct mutex {
+	atomic_long_t		owner;
+	raw_spinlock_t		wait_lock;
+#ifdef CONFIG_MUTEX_SPIN_ON_OWNER
+	struct optimistic_spin_queue osq; /* Spinner MCS lock */
+#endif
+	struct list_head	wait_list;
+#ifdef CONFIG_DEBUG_MUTEXES
+	void			*magic;
+#endif
+#ifdef CONFIG_DEBUG_LOCK_ALLOC
+	struct lockdep_map	dep_map;
+#endif
+};
+#else
+struct mutex {
+	struct rt_mutex_base	rtmutex;
+#ifdef CONFIG_DEBUG_LOCK_ALLOC
+	struct lockdep_map	dep_map;
+#endif
+};
+
+#endif
+
+/*
+ * Sequence counters (seqcount_t)
+ *
+ * This is the raw counting mechanism, without any writer protection.
+ *
+ * Write side critical sections must be serialized and non-preemptible.
+ *
+ * If readers can be invoked from hardirq or softirq contexts,
+ * interrupts or bottom halves must also be respectively disabled before
+ * entering the write section.
+ *
+ * This mechanism can't be used if the protected data contains pointers,
+ * as the writer can invalidate a pointer that a reader is following.
+ *
+ * If the write serialization mechanism is one of the common kernel
+ * locking primitives, use a sequence counter with associated lock
+ * (seqcount_LOCKNAME_t) instead.
+ *
+ * If it's desired to automatically handle the sequence counter writer
+ * serialization and non-preemptibility requirements, use a sequential
+ * lock (seqlock_t) instead.
+ *
+ * See Documentation/locking/seqlock.rst
+ */
+typedef struct seqcount {
+	unsigned sequence;
+#ifdef CONFIG_DEBUG_LOCK_ALLOC
+	struct lockdep_map dep_map;
+#endif
+} seqcount_t;
+
+typedef struct wait_queue_entry wait_queue_entry_t;
+
+typedef int (*wait_queue_func_t)(struct wait_queue_entry *wq_entry, unsigned mode, int flags, void *key);
+int default_wake_function(struct wait_queue_entry *wq_entry, unsigned mode, int flags, void *key);
+
+/* wait_queue_entry::flags */
+#define WQ_FLAG_EXCLUSIVE	0x01
+#define WQ_FLAG_WOKEN		0x02
+#define WQ_FLAG_BOOKMARK	0x04
+#define WQ_FLAG_CUSTOM		0x08
+#define WQ_FLAG_DONE		0x10
+#define WQ_FLAG_PRIORITY	0x20
+
+/*
+ * A single wait-queue entry structure:
+ */
+struct wait_queue_entry {
+	unsigned int		flags;
+	void			*private;
+	wait_queue_func_t	func;
+	struct list_head	entry;
+};
+
+struct wait_queue_head {
+	spinlock_t		lock;
+	struct list_head	head;
+};
+typedef struct wait_queue_head wait_queue_head_t;
+
+struct swait_queue_head {
+	raw_spinlock_t		lock;
+	struct list_head	task_list;
+};
+
+struct swait_queue {
+	struct task_struct	*task;
+	struct list_head	task_list;
+};
+
+struct timer_list {
+	/*
+	 * All fields that change during normal runtime grouped to the
+	 * same cacheline
+	 */
+	struct hlist_node	entry;
+	unsigned long		expires;
+	void			(*function)(struct timer_list *);
+	u32			flags;
+
+#ifdef CONFIG_LOCKDEP
+	struct lockdep_map	lockdep_map;
+#endif
+};
+
+struct timerqueue_node {
+	struct rb_node node;
+	ktime_t expires;
+};
+
+struct timerqueue_head {
+	struct rb_root_cached rb_root;
+};
+
+/**
+ * struct hrtimer - the basic hrtimer structure
+ * @node:	timerqueue node, which also manages node.expires,
+ *		the absolute expiry time in the hrtimers internal
+ *		representation. The time is related to the clock on
+ *		which the timer is based. Is setup by adding
+ *		slack to the _softexpires value. For non range timers
+ *		identical to _softexpires.
+ * @_softexpires: the absolute earliest expiry time of the hrtimer.
+ *		The time which was given as expiry time when the timer
+ *		was armed.
+ * @function:	timer expiry callback function
+ * @base:	pointer to the timer base (per cpu and per clock)
+ * @state:	state information (See bit values above)
+ * @is_rel:	Set if the timer was armed relative
+ * @is_soft:	Set if hrtimer will be expired in soft interrupt context.
+ * @is_hard:	Set if hrtimer will be expired in hard interrupt context
+ *		even on RT.
+ *
+ * The hrtimer structure must be initialized by hrtimer_init()
+ */
+struct hrtimer {
+	struct timerqueue_node		node;
+	ktime_t				_softexpires;
+	enum hrtimer_restart		(*function)(struct hrtimer *);
+	struct hrtimer_clock_base	*base;
+	u8				state;
+	u8				is_rel;
+	u8				is_soft;
+	u8				is_hard;
+};
+
+
+/*
+ * struct completion - structure used to maintain state for a "completion"
+ *
+ * This is the opaque structure used to maintain the state for a "completion".
+ * Completions currently use a FIFO to queue threads that have to wait for
+ * the "completion" event.
+ *
+ * See also:  complete(), wait_for_completion() (and friends _timeout,
+ * _interruptible, _interruptible_timeout, and _killable), init_completion(),
+ * reinit_completion(), and macros DECLARE_COMPLETION(),
+ * DECLARE_COMPLETION_ONSTACK().
+ */
+struct completion {
+	unsigned int done;
+	struct swait_queue_head wait;
+};
+
+struct work_struct;
+typedef void (*work_func_t)(struct work_struct *work);
+struct work_struct {
+	atomic_long_t data;
+	struct list_head entry;
+	work_func_t func;
+#ifdef CONFIG_LOCKDEP
+	struct lockdep_map lockdep_map;
+#endif
+};
+
+struct delayed_work {
+	struct work_struct work;
+	struct timer_list timer;
+
+	/* target workqueue and CPU ->timer uses to queue ->work */
+	struct workqueue_struct *wq;
+	int cpu;
+};
+
+struct rcu_work {
+	struct work_struct work;
+	struct rcu_head rcu;
+
+	/* target workqueue ->rcu uses to queue ->work */
+	struct workqueue_struct *wq;
+};
+
+/* Structure to mediate between updaters and fastpath-using readers.  */
+struct rcu_sync {
+	int			gp_state;
+	int			gp_count;
+	wait_queue_head_t	gp_wait;
+	struct rcu_head		cb_head;
+};
+
+/*
+ * rcuwait provides a way of blocking and waking up a single
+ * task in an rcu-safe manner.
+ *
+ * The only time @task is non-nil is when a user is blocked (or
+ * checking if it needs to) on a condition, and reset as soon as we
+ * know that the condition has succeeded and are awoken.
+ */
+struct rcuwait {
+	struct task_struct __rcu *task;
+};
+
+#ifndef CONFIG_PREEMPT_RT
+/*
+ * For an uncontended rwsem, count and owner are the only fields a task
+ * needs to touch when acquiring the rwsem. So they are put next to each
+ * other to increase the chance that they will share the same cacheline.
+ *
+ * In a contended rwsem, the owner is likely the most frequently accessed
+ * field in the structure as the optimistic waiter that holds the osq lock
+ * will spin on owner. For an embedded rwsem, other hot fields in the
+ * containing structure should be moved further away from the rwsem to
+ * reduce the chance that they will share the same cacheline causing
+ * cacheline bouncing problem.
+ */
+struct rw_semaphore {
+	atomic_long_t count;
+	/*
+	 * Write owner or one of the read owners as well flags regarding
+	 * the current state of the rwsem. Can be used as a speculative
+	 * check to see if the write owner is running on the cpu.
+	 */
+	atomic_long_t owner;
+#ifdef CONFIG_RWSEM_SPIN_ON_OWNER
+	struct optimistic_spin_queue osq; /* spinner MCS lock */
+#endif
+	raw_spinlock_t wait_lock;
+	struct list_head wait_list;
+#ifdef CONFIG_DEBUG_RWSEMS
+	void *magic;
+#endif
+#ifdef CONFIG_DEBUG_LOCK_ALLOC
+	struct lockdep_map	dep_map;
+#endif
+};
+#else
+struct rw_semaphore {
+	struct rwbase_rt	rwbase;
+#ifdef CONFIG_DEBUG_LOCK_ALLOC
+	struct lockdep_map	dep_map;
+#endif
+};
+#endif
+
+struct percpu_rw_semaphore {
+	struct rcu_sync		rss;
+	unsigned int __percpu	*read_count;
+	struct rcuwait		writer;
+	wait_queue_head_t	waiters;
+	atomic_t		block;
+#ifdef CONFIG_DEBUG_LOCK_ALLOC
+	struct lockdep_map	dep_map;
+#endif
+};
+
+/**
+ * struct xarray - The anchor of the XArray.
+ * @xa_lock: Lock that protects the contents of the XArray.
+ *
+ * To use the xarray, define it statically or embed it in your data structure.
+ * It is a very small data structure, so it does not usually make sense to
+ * allocate it separately and keep a pointer to it in your data structure.
+ *
+ * You may use the xa_lock to protect your own data structures as well.
+ */
+/*
+ * If all of the entries in the array are NULL, @xa_head is a NULL pointer.
+ * If the only non-NULL entry in the array is at index 0, @xa_head is that
+ * entry.  If any other entry in the array is non-NULL, @xa_head points
+ * to an @xa_node.
+ */
+struct xarray {
+	spinlock_t	xa_lock;
+/* private: The rest of the data structure is not to be used directly. */
+	gfp_t		xa_flags;
+	void __rcu *	xa_head;
+};
+
+/**
+ * struct bio_vec - a contiguous range of physical memory addresses
+ * @bv_page:   First page associated with the address range.
+ * @bv_len:    Number of bytes in the address range.
+ * @bv_offset: Start of the address range relative to the start of @bv_page.
+ *
+ * The following holds for a bvec if n * PAGE_SIZE < bv_offset + bv_len:
+ *
+ *   nth_page(@bv_page, n) == @bv_page + n
+ *
+ * This holds because page_is_mergeable() checks the above property.
+ */
+struct bio_vec {
+	struct page	*bv_page;
+	unsigned int	bv_len;
+	unsigned int	bv_offset;
+};
+typedef struct bio_vec skb_frag_t;
+
+/* Don't assign or return these: may not be this big! */
+typedef struct cpumask { DECLARE_BITMAP(bits, NR_CPUS); } cpumask_t;
+
+struct kobject {
+	const char		*name;
+	struct list_head	entry;
+	struct kobject		*parent;
+	struct kset		*kset;
+	struct kobj_type	*ktype;
+	struct kernfs_node	*sd; /* sysfs directory entry */
+	struct kref		kref;
+#ifdef CONFIG_DEBUG_KOBJECT_RELEASE
+	struct delayed_work	release;
+#endif
+	unsigned int state_initialized:1;
+	unsigned int state_in_sysfs:1;
+	unsigned int state_add_uevent_sent:1;
+	unsigned int state_remove_uevent_sent:1;
+	unsigned int uevent_suppress:1;
+};
+
+#endif /* __LINUX_STRUCT_TYPES_H */
diff --git a/include/linux/swait.h b/include/linux/swait.h
index 6a8c22b8c2a5..d7798752922d 100644
--- a/include/linux/swait.h
+++ b/include/linux/swait.h
@@ -38,18 +38,6 @@
  * wait queues in most cases.
  */
 
-struct task_struct;
-
-struct swait_queue_head {
-	raw_spinlock_t		lock;
-	struct list_head	task_list;
-};
-
-struct swait_queue {
-	struct task_struct	*task;
-	struct list_head	task_list;
-};
-
 #define __SWAITQUEUE_INITIALIZER(name) {				\
 	.task		= current,					\
 	.task_list	= LIST_HEAD_INIT((name).task_list),		\
diff --git a/include/linux/timer.h b/include/linux/timer.h
index fda13c9d1256..a562663d4947 100644
--- a/include/linux/timer.h
+++ b/include/linux/timer.h
@@ -7,21 +7,7 @@
 #include <linux/stddef.h>
 #include <linux/debugobjects.h>
 #include <linux/stringify.h>
-
-struct timer_list {
-	/*
-	 * All fields that change during normal runtime grouped to the
-	 * same cacheline
-	 */
-	struct hlist_node	entry;
-	unsigned long		expires;
-	void			(*function)(struct timer_list *);
-	u32			flags;
-
-#ifdef CONFIG_LOCKDEP
-	struct lockdep_map	lockdep_map;
-#endif
-};
+#include <linux/struct_types.h>
 
 #ifdef CONFIG_LOCKDEP
 /*
diff --git a/include/linux/timerqueue.h b/include/linux/timerqueue.h
index 93884086f392..d2a4e03ec3ec 100644
--- a/include/linux/timerqueue.h
+++ b/include/linux/timerqueue.h
@@ -4,17 +4,7 @@
 
 #include <linux/rbtree.h>
 #include <linux/ktime.h>
-
-
-struct timerqueue_node {
-	struct rb_node node;
-	ktime_t expires;
-};
-
-struct timerqueue_head {
-	struct rb_root_cached rb_root;
-};
-
+#include <linux/struct_types.h>
 
 extern bool timerqueue_add(struct timerqueue_head *head,
 			   struct timerqueue_node *node);
diff --git a/include/linux/wait.h b/include/linux/wait.h
index 2d0df57c9902..020bc1cf89a5 100644
--- a/include/linux/wait.h
+++ b/include/linux/wait.h
@@ -11,35 +11,6 @@
 #include <asm/current.h>
 #include <uapi/linux/wait.h>
 
-typedef struct wait_queue_entry wait_queue_entry_t;
-
-typedef int (*wait_queue_func_t)(struct wait_queue_entry *wq_entry, unsigned mode, int flags, void *key);
-int default_wake_function(struct wait_queue_entry *wq_entry, unsigned mode, int flags, void *key);
-
-/* wait_queue_entry::flags */
-#define WQ_FLAG_EXCLUSIVE	0x01
-#define WQ_FLAG_WOKEN		0x02
-#define WQ_FLAG_BOOKMARK	0x04
-#define WQ_FLAG_CUSTOM		0x08
-#define WQ_FLAG_DONE		0x10
-#define WQ_FLAG_PRIORITY	0x20
-
-/*
- * A single wait-queue entry structure:
- */
-struct wait_queue_entry {
-	unsigned int		flags;
-	void			*private;
-	wait_queue_func_t	func;
-	struct list_head	entry;
-};
-
-struct wait_queue_head {
-	spinlock_t		lock;
-	struct list_head	head;
-};
-typedef struct wait_queue_head wait_queue_head_t;
-
 struct task_struct;
 
 /*
diff --git a/include/linux/workqueue.h b/include/linux/workqueue.h
index 7fee9b6cfede..4e4eba8de156 100644
--- a/include/linux/workqueue.h
+++ b/include/linux/workqueue.h
@@ -18,7 +18,6 @@
 struct workqueue_struct;
 
 struct work_struct;
-typedef void (*work_func_t)(struct work_struct *work);
 void delayed_work_timer_fn(struct timer_list *t);
 
 /*
@@ -94,36 +93,10 @@ enum {
 	WORKER_DESC_LEN		= 24,
 };
 
-struct work_struct {
-	atomic_long_t data;
-	struct list_head entry;
-	work_func_t func;
-#ifdef CONFIG_LOCKDEP
-	struct lockdep_map lockdep_map;
-#endif
-};
-
 #define WORK_DATA_INIT()	ATOMIC_LONG_INIT((unsigned long)WORK_STRUCT_NO_POOL)
 #define WORK_DATA_STATIC_INIT()	\
 	ATOMIC_LONG_INIT((unsigned long)(WORK_STRUCT_NO_POOL | WORK_STRUCT_STATIC))
 
-struct delayed_work {
-	struct work_struct work;
-	struct timer_list timer;
-
-	/* target workqueue and CPU ->timer uses to queue ->work */
-	struct workqueue_struct *wq;
-	int cpu;
-};
-
-struct rcu_work {
-	struct work_struct work;
-	struct rcu_head rcu;
-
-	/* target workqueue ->rcu uses to queue ->work */
-	struct workqueue_struct *wq;
-};
-
 /**
  * struct workqueue_attrs - A struct for workqueue attributes.
  *
diff --git a/include/linux/xarray.h b/include/linux/xarray.h
index a91e3d90df8a..4f1e55074ef0 100644
--- a/include/linux/xarray.h
+++ b/include/linux/xarray.h
@@ -275,29 +275,6 @@ enum xa_lock_type {
 #define XA_FLAGS_ALLOC	(XA_FLAGS_TRACK_FREE | XA_FLAGS_MARK(XA_FREE_MARK))
 #define XA_FLAGS_ALLOC1	(XA_FLAGS_TRACK_FREE | XA_FLAGS_ZERO_BUSY)
 
-/**
- * struct xarray - The anchor of the XArray.
- * @xa_lock: Lock that protects the contents of the XArray.
- *
- * To use the xarray, define it statically or embed it in your data structure.
- * It is a very small data structure, so it does not usually make sense to
- * allocate it separately and keep a pointer to it in your data structure.
- *
- * You may use the xa_lock to protect your own data structures as well.
- */
-/*
- * If all of the entries in the array are NULL, @xa_head is a NULL pointer.
- * If the only non-NULL entry in the array is at index 0, @xa_head is that
- * entry.  If any other entry in the array is non-NULL, @xa_head points
- * to an @xa_node.
- */
-struct xarray {
-	spinlock_t	xa_lock;
-/* private: The rest of the data structure is not to be used directly. */
-	gfp_t		xa_flags;
-	void __rcu *	xa_head;
-};
-
 #define XARRAY_INIT(name, flags) {				\
 	.xa_lock = __SPIN_LOCK_UNLOCKED(name.xa_lock),		\
 	.xa_flags = flags,					\
-- 
2.29.2

