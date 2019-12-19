Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5DEAF125D3A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Dec 2019 10:05:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726742AbfLSJFo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 19 Dec 2019 04:05:44 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:39638 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726648AbfLSJFo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 19 Dec 2019 04:05:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=+qkZEpX4RcdcWfgYWQS2CHSq7WS8Coalk20C2OpEt/I=; b=VqL6EbkGsbsATRxBAmx11ZLS6
        SU6hRkYX5RjiP3lvI0KR7QWYFYoqaLQQovwCpA41IxihQQKxoU50zuqROcMXByJMDqihmD0U3lQIM
        PwjcVTe33M5+zBkLuBhTizOsZyVyVb0TWhgYU1Ut5KHGP+XDYROqi5KnLbZmlTjn483liwffp5inA
        hh71HCfjqAQw4qmwqZNprrT1mcSkd+Cq4vJadTUusa8Ooxr+NXUtKqcP/gzuc15GJOJJHdx8iNedI
        PIi0KFdUfn2jgmQDx7wgRmpBhx0rKBEqzkejME/3j3vIo5B96Ysctzde41UHxODx5VwZKf6uCNAnf
        qH/LxaRZQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ihrkX-0001Bm-UA; Thu, 19 Dec 2019 09:05:38 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id CDE8A304C1B;
        Thu, 19 Dec 2019 10:04:11 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 48D762B0D9745; Thu, 19 Dec 2019 10:05:35 +0100 (CET)
Date:   Thu, 19 Dec 2019 10:05:35 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Davidlohr Bueso <dave@stgolabs.net>
Cc:     David Howells <dhowells@redhat.com>, linux-afs@lists.infradead.org,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] rxrpc: struct mutex cannot be used for
 rxrpc_call::user_mutex
Message-ID: <20191219090535.GV2844@hirez.programming.kicks-ass.net>
References: <157659672074.19580.11641288666811539040.stgit@warthog.procyon.org.uk>
 <20191218135047.GS2844@hirez.programming.kicks-ass.net>
 <20191218190833.ufpxjrvin5jvp3m5@linux-p48b>
 <20191218202801.wokf6hcvbafmjnkd@linux-p48b>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191218202801.wokf6hcvbafmjnkd@linux-p48b>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Dec 18, 2019 at 12:28:01PM -0800, Davidlohr Bueso wrote:
> Hmm so fyi __crash_kexec() is another one, but can be called in hard-irq, and
> it's extremely obvious that the trylock+unlock occurs in the same context.

Hurmph, that unlock 'never' happens if I read it right :-) Still,
something like the below ought to cure it I suppose.

> It would be nice to automate this...

Automate what exactly? We'll stick your WARN back in on the next round.


---
diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
index 15d70a90b50d..2faf2ec33032 100644
--- a/kernel/kexec_core.c
+++ b/kernel/kexec_core.c
@@ -47,6 +47,26 @@
 
 DEFINE_MUTEX(kexec_mutex);
 
+static void kexec_lock(void)
+{
+	/*
+	 * LOCK kexec_mutex		cmpxchg(&panic_cpu, INVALID, cpu)
+	 *   MB				  MB
+	 * panic_cpu == INVALID		kexec_mutex == LOCKED
+	 *
+	 * Ensures either we observe the cmpxchg, or crash_kernel() observes
+	 * our lock acquisition.
+	 */
+	mutex_lock(&kexec_mutex);
+	smp_mb();
+	atomic_cond_load_acquire(&panic_cpu, VAL == PANIC_CPU_INVALID);
+}
+
+static void kexec_unlock(void)
+{
+	mutex_unlock(&kexec_mutex);
+}
+
 /* Per cpu memory for storing cpu states in case of system crash. */
 note_buf_t __percpu *crash_notes;
 
@@ -937,24 +957,13 @@ int kexec_load_disabled;
  */
 void __noclone __crash_kexec(struct pt_regs *regs)
 {
-	/* Take the kexec_mutex here to prevent sys_kexec_load
-	 * running on one cpu from replacing the crash kernel
-	 * we are using after a panic on a different cpu.
-	 *
-	 * If the crash kernel was not located in a fixed area
-	 * of memory the xchg(&kexec_crash_image) would be
-	 * sufficient.  But since I reuse the memory...
-	 */
-	if (mutex_trylock(&kexec_mutex)) {
-		if (kexec_crash_image) {
-			struct pt_regs fixed_regs;
-
-			crash_setup_regs(&fixed_regs, regs);
-			crash_save_vmcoreinfo();
-			machine_crash_shutdown(&fixed_regs);
-			machine_kexec(kexec_crash_image);
-		}
-		mutex_unlock(&kexec_mutex);
+	if (kexec_crash_image) {
+		struct pt_regs fixed_regs;
+
+		crash_setup_regs(&fixed_regs, regs);
+		crash_save_vmcoreinfo();
+		machine_crash_shutdown(&fixed_regs);
+		machine_kexec(kexec_crash_image);
 	}
 }
 STACK_FRAME_NON_STANDARD(__crash_kexec);
@@ -973,7 +982,11 @@ void crash_kexec(struct pt_regs *regs)
 	if (old_cpu == PANIC_CPU_INVALID) {
 		/* This is the 1st CPU which comes here, so go ahead. */
 		printk_safe_flush_on_panic();
-		__crash_kexec(regs);
+		/*
+		 * Orders against kexec_lock(), see the comment there.
+		 */
+		if (!mutex_is_locked(&kexec_mutex))
+			__crash_kexec(regs);
 
 		/*
 		 * Reset panic_cpu to allow another panic()/crash_kexec()
@@ -987,10 +1000,10 @@ size_t crash_get_memory_size(void)
 {
 	size_t size = 0;
 
-	mutex_lock(&kexec_mutex);
+	kexec_lock();
 	if (crashk_res.end != crashk_res.start)
 		size = resource_size(&crashk_res);
-	mutex_unlock(&kexec_mutex);
+	kexec_unlock();
 	return size;
 }
 
@@ -1010,7 +1023,7 @@ int crash_shrink_memory(unsigned long new_size)
 	unsigned long old_size;
 	struct resource *ram_res;
 
-	mutex_lock(&kexec_mutex);
+	kexec_lock();
 
 	if (kexec_crash_image) {
 		ret = -ENOENT;
@@ -1048,7 +1061,7 @@ int crash_shrink_memory(unsigned long new_size)
 	insert_resource(&iomem_resource, ram_res);
 
 unlock:
-	mutex_unlock(&kexec_mutex);
+	kexec_unlock();
 	return ret;
 }
 
