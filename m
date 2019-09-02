Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 82520A5E3E
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Sep 2019 01:45:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727854AbfIBXpO convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>); Mon, 2 Sep 2019 19:45:14 -0400
Received: from ozlabs.org ([203.11.71.1]:55925 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726849AbfIBXpO (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Sep 2019 19:45:14 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 46Mmsb27qjz9s7T;
        Tue,  3 Sep 2019 09:45:07 +1000 (AEST)
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Michal =?utf-8?Q?Such=C3=A1nek?= <msuchanek@suse.de>
Cc:     linuxppc-dev@lists.ozlabs.org,
        Madhavan Srinivasan <maddy@linux.vnet.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Paul Mackerras <paulus@samba.org>,
        Breno Leitao <leitao@debian.org>,
        Michael Neuling <mikey@neuling.org>,
        Diana Craciun <diana.craciun@nxp.com>,
        Firoz Khan <firoz.khan@linaro.org>,
        Hari Bathini <hbathini@linux.ibm.com>,
        Joel Stanley <joel@jms.id.au>, Arnd Bergmann <arnd@arndb.de>,
        Nicholas Piggin <npiggin@gmail.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Allison Randal <allison@lohutok.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
        linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v7 3/6] powerpc/perf: consolidate read_user_stack_32
In-Reply-To: <20190902102653.6d477e16@naga>
References: <cover.1567198491.git.msuchanek@suse.de> <ea3783a1640b707ef9ce4740562850ef1152829b.1567198491.git.msuchanek@suse.de> <87a7bntkum.fsf@mpe.ellerman.id.au> <877e6rtkhe.fsf@mpe.ellerman.id.au> <20190902102653.6d477e16@naga>
Date:   Tue, 03 Sep 2019 09:45:05 +1000
Message-ID: <87mufms1oe.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Michal Suchánek <msuchanek@suse.de> writes:
> On Mon, 02 Sep 2019 14:01:17 +1000
> Michael Ellerman <mpe@ellerman.id.au> wrote:
>> Michael Ellerman <mpe@ellerman.id.au> writes:
>> > Michal Suchanek <msuchanek@suse.de> writes:  
>> ...
>> >> @@ -295,6 +279,12 @@ static inline int current_is_64bit(void)
>> >>  }
>> >>  
>> >>  #else  /* CONFIG_PPC64 */
>> >> +static int read_user_stack_slow(void __user *ptr, void *buf, int nb)
>> >> +{
>> >> +	return 0;
>> >> +}
>> >> +#endif /* CONFIG_PPC64 */  
>> >
>> > Ending the PPC64 else case here, and then restarting it below with an
>> > ifndef means we end up with two parts of the file that define 32-bit
>> > code, with a common chunk in the middle, which I dislike.
>> >
>> > I'd rather you add the empty read_user_stack_slow() in the existing
>> > #else section and then move read_user_stack_32() below the whole ifdef
>> > PPC64/else/endif section.
>> >
>> > Is there some reason that doesn't work?  
>> 
>> Gah, I missed that you split the whole file later in the series. Any
>> reason you did it in two steps rather than moving patch 6 earlier in the
>> series?
>
> To make this patch readable.

But it's not very readable :)

You also retained the comment about the 32-bit behaviour which is now a
bit confusing, because the function is used on both 32 & 64-bit.

I think moving it as I suggested in my first reply makes for a better
diff, something like eg:

diff --git a/arch/powerpc/perf/callchain.c b/arch/powerpc/perf/callchain.c
index c84bbd4298a0..82c0f81b89a5 100644
--- a/arch/powerpc/perf/callchain.c
+++ b/arch/powerpc/perf/callchain.c
@@ -165,22 +165,6 @@ static int read_user_stack_64(unsigned long __user *ptr, unsigned long *ret)
 	return read_user_stack_slow(ptr, ret, 8);
 }
 
-static int read_user_stack_32(unsigned int __user *ptr, unsigned int *ret)
-{
-	if ((unsigned long)ptr > TASK_SIZE - sizeof(unsigned int) ||
-	    ((unsigned long)ptr & 3))
-		return -EFAULT;
-
-	pagefault_disable();
-	if (!__get_user_inatomic(*ret, ptr)) {
-		pagefault_enable();
-		return 0;
-	}
-	pagefault_enable();
-
-	return read_user_stack_slow(ptr, ret, 4);
-}
-
 static inline int valid_user_sp(unsigned long sp, int is_64)
 {
 	if (!sp || (sp & 7) || sp > (is_64 ? TASK_SIZE : 0x100000000UL) - 32)
@@ -295,27 +279,6 @@ static inline int current_is_64bit(void)
 }
 
 #else  /* CONFIG_PPC64 */
-/*
- * On 32-bit we just access the address and let hash_page create a
- * HPTE if necessary, so there is no need to fall back to reading
- * the page tables.  Since this is called at interrupt level,
- * do_page_fault() won't treat a DSI as a page fault.
- */
-static int read_user_stack_32(unsigned int __user *ptr, unsigned int *ret)
-{
-	int rc;
-
-	if ((unsigned long)ptr > TASK_SIZE - sizeof(unsigned int) ||
-	    ((unsigned long)ptr & 3))
-		return -EFAULT;
-
-	pagefault_disable();
-	rc = __get_user_inatomic(*ret, ptr);
-	pagefault_enable();
-
-	return rc;
-}
-
 static inline void perf_callchain_user_64(struct perf_callchain_entry_ctx *entry,
 					  struct pt_regs *regs)
 {
@@ -333,6 +296,11 @@ static inline int valid_user_sp(unsigned long sp, int is_64)
 	return 1;
 }
 
+static int read_user_stack_slow(void __user *ptr, void *buf, int nb)
+{
+	return 0;
+}
+
 #define __SIGNAL_FRAMESIZE32	__SIGNAL_FRAMESIZE
 #define sigcontext32		sigcontext
 #define mcontext32		mcontext
@@ -341,6 +309,33 @@ static inline int valid_user_sp(unsigned long sp, int is_64)
 
 #endif /* CONFIG_PPC64 */
 
+static int read_user_stack_32(unsigned int __user *ptr, unsigned int *ret)
+{
+	int rc;
+
+	if ((unsigned long)ptr > TASK_SIZE - sizeof(unsigned int) ||
+	    ((unsigned long)ptr & 3))
+		return -EFAULT;
+
+	pagefault_disable();
+	rc = __get_user_inatomic(*ret, ptr);
+	pagefault_enable();
+
+	/*
+	 * On 32-bit we just access the address and let hash_page() create a
+	 * HPTE if necessary, so there is no need to fall back to reading the
+	 * page tables. Since this is called at interrupt level, do_page_fault()
+	 * won't treat a DSI as a page fault.
+	 *
+	 * On 64-bit if the access faults we fall back to
+	 * read_user_stack_slow(), see the comment there for more details.
+	 */
+	if (IS_ENABLED(CONFIG_PPC64) && rc)
+		return read_user_stack_slow(ptr, ret, 4);
+
+	return rc;
+}
+
 /*
  * Layout for non-RT signal frames
  */


cheers
