Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8E8DD17A110
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Mar 2020 09:17:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725937AbgCEIR3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 5 Mar 2020 03:17:29 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:35250 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725844AbgCEIR3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 5 Mar 2020 03:17:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=80VMoypOttLGJz2ACFUkcQqEpE/2pX7u5DfeBd4BIKM=; b=TahdvC+pgEDEPCY2AMtm5KCuH7
        ZwC0OIMEGuQVRo9Q9YojvmQl4rEPsO5icUOUUdB922YifTJJXjGaySPiflZLGEkl1bYMH5Kz/tSc5
        95/kQtm2w/DJGDTqB5qMi96dQ4eC75pKTrTJZWt5ATvXENrmlIosonApnioHmaiCg096Qml8cDM7I
        7o3loisPgGkapLTISVn4R61f4uMeZDVqIu5Ff3hi5pka/frUWMqddmCPnXBlCcuWW0TFZfIC2p4Mj
        +FLN7YKXRo/KuxHxiCUkdjwBOacaOz3t0fZQorvv+MHoYNhWJPu2gJW8Xj6ERS6WPJft+Bp61g2Wt
        p9WqiEIQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j9lh1-0003lz-Eq; Thu, 05 Mar 2020 08:17:19 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id AB0023035D4;
        Thu,  5 Mar 2020 09:15:18 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 7081120D3014D; Thu,  5 Mar 2020 09:17:17 +0100 (CET)
Date:   Thu, 5 Mar 2020 09:17:17 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     akpm@linux-foundation.org, broonie@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-next@vger.kernel.org, mhocko@suse.cz,
        mm-commits@vger.kernel.org, sfr@canb.auug.org.au,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        walter-zh.wu@mediatek.com, dvyukov@google.com
Subject: Re: mmotm 2020-03-03-22-28 uploaded (warning: objtool:)
Message-ID: <20200305081717.GT2596@hirez.programming.kicks-ass.net>
References: <20200304062843.9yA6NunM5%akpm@linux-foundation.org>
 <cd1c6bd2-3db3-0058-f3b4-36b2221544a0@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cd1c6bd2-3db3-0058-f3b4-36b2221544a0@infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Mar 04, 2020 at 09:34:49AM -0800, Randy Dunlap wrote:
> On 3/3/20 10:28 PM, akpm@linux-foundation.org wrote:
> > The mm-of-the-moment snapshot 2020-03-03-22-28 has been uploaded to
> > 
> >    http://www.ozlabs.org/~akpm/mmotm/
> > 
> > mmotm-readme.txt says
> > 
> > README for mm-of-the-moment:
> > 
> > http://www.ozlabs.org/~akpm/mmotm/
> > 
> > This is a snapshot of my -mm patch queue.  Uploaded at random hopefully
> > more than once a week.
> > 
> > You will need quilt to apply these patches to the latest Linus release (5.x
> > or 5.x-rcY).  The series file is in broken-out.tar.gz and is duplicated in
> > http://ozlabs.org/~akpm/mmotm/series
> 
> on x86_64:
> 
> mm/kasan/common.o: warning: objtool: kasan_report()+0x13: call to report_enabled() with UACCESS enabled

I used next/master instead, and found the below broken commit
responsible for this.

---

commit 97f4ea76d4f40a401b84825f038710c9a96ec294
Author: Walter Wu <walter-zh.wu@mediatek.com>
Date:   Wed Mar 4 22:31:15 2020 +1100

    kasan: detect negative size in memory operation function
    
    Patch series "fix the missing underflow in memory operation function", v4.
    
    The patchset helps to produce a KASAN report when size is negative in
    memory operation functions.  It is helpful for programmer to solve an
    undefined behavior issue.  Patch 1 based on Dmitry's review and
    suggestion, patch 2 is a test in order to verify the patch 1.
    
    [1]https://bugzilla.kernel.org/show_bug.cgi?id=199341
    [2]https://lore.kernel.org/linux-arm-kernel/20190927034338.15813-1-walter-zh.wu@mediatek.com/
    
    This patch (of 2):
    
    KASAN missed detecting size is a negative number in memset(), memcpy(),
    and memmove(), it will cause out-of-bounds bug.  So needs to be detected
    by KASAN.
    
    If size is a negative number, then it has a reason to be defined as
    out-of-bounds bug type.  Casting negative numbers to size_t would indeed
    turn up as a large size_t and its value will be larger than ULONG_MAX/2,
    so that this can qualify as out-of-bounds.
    
    KASAN report is shown below:
    
     BUG: KASAN: out-of-bounds in kmalloc_memmove_invalid_size+0x70/0xa0
     Read of size 18446744073709551608 at addr ffffff8069660904 by task cat/72
    
     CPU: 2 PID: 72 Comm: cat Not tainted 5.4.0-rc1-next-20191004ajb-00001-gdb8af2f372b2-dirty #1
     Hardware name: linux,dummy-virt (DT)
     Call trace:
      dump_backtrace+0x0/0x288
      show_stack+0x14/0x20
      dump_stack+0x10c/0x164
      print_address_description.isra.9+0x68/0x378
      __kasan_report+0x164/0x1a0
      kasan_report+0xc/0x18
      check_memory_region+0x174/0x1d0
      memmove+0x34/0x88
      kmalloc_memmove_invalid_size+0x70/0xa0
    
    [1] https://bugzilla.kernel.org/show_bug.cgi?id=199341
    
    Link: http://lkml.kernel.org/r/20191112065302.7015-1-walter-zh.wu@mediatek.com
    Signed-off-by: Walter Wu <walter-zh.wu@mediatek.com>
    Reported-by: kernel test robot <lkp@intel.com>
    Reported-by: Dmitry Vyukov <dvyukov@google.com>
    Suggested-by: Dmitry Vyukov <dvyukov@google.com>
    Reviewed-by: Dmitry Vyukov <dvyukov@google.com>
    Reviewed-by: Andrey Ryabinin <aryabinin@virtuozzo.com>
    Cc: Alexander Potapenko <glider@google.com>
    Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
    Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>

diff --git a/include/linux/kasan.h b/include/linux/kasan.h
index 5cde9e7c2664..31314ca7c635 100644
--- a/include/linux/kasan.h
+++ b/include/linux/kasan.h
@@ -190,7 +190,7 @@ void kasan_init_tags(void);
 
 void *kasan_reset_tag(const void *addr);
 
-void kasan_report(unsigned long addr, size_t size,
+bool kasan_report(unsigned long addr, size_t size,
 		bool is_write, unsigned long ip);
 
 #else /* CONFIG_KASAN_SW_TAGS */
diff --git a/mm/kasan/common.c b/mm/kasan/common.c
index 6aa51723b92b..c798b12323d7 100644
--- a/mm/kasan/common.c
+++ b/mm/kasan/common.c
@@ -105,7 +105,8 @@ EXPORT_SYMBOL(__kasan_check_write);
 #undef memset
 void *memset(void *addr, int c, size_t len)
 {
-	check_memory_region((unsigned long)addr, len, true, _RET_IP_);
+	if (!check_memory_region((unsigned long)addr, len, true, _RET_IP_))
+		return NULL;
 
 	return __memset(addr, c, len);
 }
@@ -114,8 +115,9 @@ void *memset(void *addr, int c, size_t len)
 #undef memmove
 void *memmove(void *dest, const void *src, size_t len)
 {
-	check_memory_region((unsigned long)src, len, false, _RET_IP_);
-	check_memory_region((unsigned long)dest, len, true, _RET_IP_);
+	if (!check_memory_region((unsigned long)src, len, false, _RET_IP_) ||
+	    !check_memory_region((unsigned long)dest, len, true, _RET_IP_))
+		return NULL;
 
 	return __memmove(dest, src, len);
 }
@@ -124,8 +126,9 @@ void *memmove(void *dest, const void *src, size_t len)
 #undef memcpy
 void *memcpy(void *dest, const void *src, size_t len)
 {
-	check_memory_region((unsigned long)src, len, false, _RET_IP_);
-	check_memory_region((unsigned long)dest, len, true, _RET_IP_);
+	if (!check_memory_region((unsigned long)src, len, false, _RET_IP_) ||
+	    !check_memory_region((unsigned long)dest, len, true, _RET_IP_))
+		return NULL;
 
 	return __memcpy(dest, src, len);
 }
@@ -634,12 +637,20 @@ void kasan_free_shadow(const struct vm_struct *vm)
 #endif
 
 extern void __kasan_report(unsigned long addr, size_t size, bool is_write, unsigned long ip);
+extern bool report_enabled(void);
 
-void kasan_report(unsigned long addr, size_t size, bool is_write, unsigned long ip)
+bool kasan_report(unsigned long addr, size_t size, bool is_write, unsigned long ip)
 {
-	unsigned long flags = user_access_save();
+	unsigned long flags;
+
+	if (likely(!report_enabled()))
+		return false;
+
+	flags = user_access_save();
 	__kasan_report(addr, size, is_write, ip);
 	user_access_restore(flags);
+
+	return true;
 }
 
 #ifdef CONFIG_MEMORY_HOTPLUG
diff --git a/mm/kasan/generic.c b/mm/kasan/generic.c
index 616f9dd82d12..56ff8885fe2e 100644
--- a/mm/kasan/generic.c
+++ b/mm/kasan/generic.c
@@ -173,17 +173,18 @@ static __always_inline bool check_memory_region_inline(unsigned long addr,
 	if (unlikely(size == 0))
 		return true;
 
+	if (unlikely(addr + size < addr))
+		return !kasan_report(addr, size, write, ret_ip);
+
 	if (unlikely((void *)addr <
 		kasan_shadow_to_mem((void *)KASAN_SHADOW_START))) {
-		kasan_report(addr, size, write, ret_ip);
-		return false;
+		return !kasan_report(addr, size, write, ret_ip);
 	}
 
 	if (likely(!memory_is_poisoned(addr, size)))
 		return true;
 
-	kasan_report(addr, size, write, ret_ip);
-	return false;
+	return !kasan_report(addr, size, write, ret_ip);
 }
 
 bool check_memory_region(unsigned long addr, size_t size, bool write,
diff --git a/mm/kasan/generic_report.c b/mm/kasan/generic_report.c
index 2d97efd4954f..e200acb2d292 100644
--- a/mm/kasan/generic_report.c
+++ b/mm/kasan/generic_report.c
@@ -110,6 +110,17 @@ static const char *get_wild_bug_type(struct kasan_access_info *info)
 
 const char *get_bug_type(struct kasan_access_info *info)
 {
+	/*
+	 * If access_size is a negative number, then it has reason to be
+	 * defined as out-of-bounds bug type.
+	 *
+	 * Casting negative numbers to size_t would indeed turn up as
+	 * a large size_t and its value will be larger than ULONG_MAX/2,
+	 * so that this can qualify as out-of-bounds.
+	 */
+	if (info->access_addr + info->access_size < info->access_addr)
+		return "out-of-bounds";
+
 	if (addr_has_shadow(info->access_addr))
 		return get_shadow_bug_type(info);
 	return get_wild_bug_type(info);
diff --git a/mm/kasan/kasan.h b/mm/kasan/kasan.h
index 3a083274628e..e8f37199d885 100644
--- a/mm/kasan/kasan.h
+++ b/mm/kasan/kasan.h
@@ -153,7 +153,7 @@ bool check_memory_region(unsigned long addr, size_t size, bool write,
 void *find_first_bad_addr(void *addr, size_t size);
 const char *get_bug_type(struct kasan_access_info *info);
 
-void kasan_report(unsigned long addr, size_t size,
+bool kasan_report(unsigned long addr, size_t size,
 		bool is_write, unsigned long ip);
 void kasan_report_invalid_free(void *object, unsigned long ip);
 
diff --git a/mm/kasan/report.c b/mm/kasan/report.c
index 5ef9f24f566b..cf5c17d5e361 100644
--- a/mm/kasan/report.c
+++ b/mm/kasan/report.c
@@ -446,7 +446,7 @@ static void print_shadow_for_address(const void *addr)
 	}
 }
 
-static bool report_enabled(void)
+bool report_enabled(void)
 {
 	if (current->kasan_depth)
 		return false;
@@ -478,9 +478,6 @@ void __kasan_report(unsigned long addr, size_t size, bool is_write, unsigned lon
 	void *untagged_addr;
 	unsigned long flags;
 
-	if (likely(!report_enabled()))
-		return;
-
 	disable_trace_on_warning();
 
 	tagged_addr = (void *)addr;
diff --git a/mm/kasan/tags.c b/mm/kasan/tags.c
index 0e987c9ca052..25b7734e7013 100644
--- a/mm/kasan/tags.c
+++ b/mm/kasan/tags.c
@@ -86,6 +86,9 @@ bool check_memory_region(unsigned long addr, size_t size, bool write,
 	if (unlikely(size == 0))
 		return true;
 
+	if (unlikely(addr + size < addr))
+		return !kasan_report(addr, size, write, ret_ip);
+
 	tag = get_tag((const void *)addr);
 
 	/*
@@ -111,15 +114,13 @@ bool check_memory_region(unsigned long addr, size_t size, bool write,
 	untagged_addr = reset_tag((const void *)addr);
 	if (unlikely(untagged_addr <
 			kasan_shadow_to_mem((void *)KASAN_SHADOW_START))) {
-		kasan_report(addr, size, write, ret_ip);
-		return false;
+		return !kasan_report(addr, size, write, ret_ip);
 	}
 	shadow_first = kasan_mem_to_shadow(untagged_addr);
 	shadow_last = kasan_mem_to_shadow(untagged_addr + size - 1);
 	for (shadow = shadow_first; shadow <= shadow_last; shadow++) {
 		if (*shadow != tag) {
-			kasan_report(addr, size, write, ret_ip);
-			return false;
+			return !kasan_report(addr, size, write, ret_ip);
 		}
 	}
 
diff --git a/mm/kasan/tags_report.c b/mm/kasan/tags_report.c
index 969ae08f59d7..1d412760551a 100644
--- a/mm/kasan/tags_report.c
+++ b/mm/kasan/tags_report.c
@@ -36,6 +36,17 @@
 
 const char *get_bug_type(struct kasan_access_info *info)
 {
+	/*
+	 * If access_size is a negative number, then it has reason to be
+	 * defined as out-of-bounds bug type.
+	 *
+	 * Casting negative numbers to size_t would indeed turn up as
+	 * a large size_t and its value will be larger than ULONG_MAX/2,
+	 * so that this can qualify as out-of-bounds.
+	 */
+	if (info->access_addr + info->access_size < info->access_addr)
+		return "out-of-bounds";
+
 #ifdef CONFIG_KASAN_SW_TAGS_IDENTIFY
 	struct kasan_alloc_meta *alloc_meta;
 	struct kmem_cache *cache;
