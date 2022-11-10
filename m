Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCC2B624B2B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Nov 2022 21:06:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231426AbiKJUGl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Nov 2022 15:06:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230407AbiKJUGk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Nov 2022 15:06:40 -0500
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C24472C67A
        for <linux-fsdevel@vger.kernel.org>; Thu, 10 Nov 2022 12:06:38 -0800 (PST)
Received: by mail-pg1-x52c.google.com with SMTP id v3so2642648pgh.4
        for <linux-fsdevel@vger.kernel.org>; Thu, 10 Nov 2022 12:06:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qAlpSiWPFJC6v5OKKunr5qvlqoVrXquKYjzcoe1SyVc=;
        b=s9HF6LHGTF6eKfCzsKX9FWUdVKeTMh/pkFaFPKYT0H/d4OcOkPXr+0PLIQfX6kQ8cC
         Q64JtYebCdaU4ruWo7vOG4vxzCvbf/2RKLE1KNtbitWQ8USo0uklGuWav/4tDaTlFs6W
         J6Y4kL0unkMwatSWRT7ksIKS8SVHxhP1XKVRgR1T1zWDYn6jIqZIsJGf7oOlihyXVFbd
         0fJb0UlwvmxM7pKZs3I6/RrzXuReRbcfrXYqhpPSmf2PKsS1vNFDHltDDL3yKYYAvjar
         0KJ9USRBIJHcvcJeqnyACzk9N+VJy0yc4DTHiyUqXB49s0LJfIJy8GxXJG4zJMQkeMSU
         tXrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qAlpSiWPFJC6v5OKKunr5qvlqoVrXquKYjzcoe1SyVc=;
        b=AnR8cYa/rPSmjEn95haqTf1H20oo5TTA4WvIqloLMciWl/4oqo/j2IPM4QWs8W3Ffc
         3/0rLa20OHM50Y7QRNrt/i9N755Px4qkFuGzGNFXzRvP+/TmmDoPBAMMyqW9wJLWkg/q
         Q0oHyTAG8njUKJwOGuorAMlDEg3+NewS13kKS4kVTzE00E1P5ye5QOLkLFitMdw4oAgP
         c0OyAMBMgl7h9WIAAg/hsciaZAOUOzxwLaBcv2mDQHYAJMUxGz9vzNbh53vwWxi/aPBo
         Z9CW3TThFGTJSmhmFUzGqpGJvrNNPlWObDVUt6/SkJsI/h6scPMENuAntbw8NuNCzI5C
         ui4Q==
X-Gm-Message-State: ACrzQf0QnNXAfqRn5nYLUA6OuuVOFb67SNkldv2HJOsS0YKW8uxdMPbc
        6HIOQ6g8rMRAykYGvG0GA70gTw==
X-Google-Smtp-Source: AMsMyM5mFyfKXM8lYQiQhk8wd0EOlRpGOMeyUwap0ARCZELHfNLQu3vKFpmelexnZtvDHcT8xi35cA==
X-Received: by 2002:a63:ff45:0:b0:46a:e818:b622 with SMTP id s5-20020a63ff45000000b0046ae818b622mr3140651pgk.550.1668110797941;
        Thu, 10 Nov 2022 12:06:37 -0800 (PST)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id d15-20020a170902cecf00b001871461688esm69853plg.175.2022.11.10.12.06.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Nov 2022 12:06:37 -0800 (PST)
Date:   Thu, 10 Nov 2022 20:06:33 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Chao Peng <chao.p.peng@linux.intel.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-api@vger.kernel.org,
        linux-doc@vger.kernel.org, qemu-devel@nongnu.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>,
        Hugh Dickins <hughd@google.com>,
        Jeff Layton <jlayton@kernel.org>,
        "J . Bruce Fields" <bfields@fieldses.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>, Mike Rapoport <rppt@kernel.org>,
        Steven Price <steven.price@arm.com>,
        "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
        Vlastimil Babka <vbabka@suse.cz>,
        Vishal Annapurve <vannapurve@google.com>,
        Yu Zhang <yu.c.zhang@linux.intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        luto@kernel.org, jun.nakajima@intel.com, dave.hansen@intel.com,
        ak@linux.intel.com, david@redhat.com, aarcange@redhat.com,
        ddutile@redhat.com, dhildenb@redhat.com,
        Quentin Perret <qperret@google.com>, tabba@google.com,
        Michael Roth <michael.roth@amd.com>, mhocko@suse.com,
        Muchun Song <songmuchun@bytedance.com>, wei.w.wang@intel.com
Subject: Re: [PATCH v9 4/8] KVM: Use gfn instead of hva for mmu_notifier_retry
Message-ID: <Y21ZyTdIHSe4HLkU@google.com>
References: <20221025151344.3784230-1-chao.p.peng@linux.intel.com>
 <20221025151344.3784230-5-chao.p.peng@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221025151344.3784230-5-chao.p.peng@linux.intel.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Oct 25, 2022, Chao Peng wrote:
> @@ -715,15 +715,9 @@ static void kvm_mmu_notifier_change_pte(struct mmu_notifier *mn,
>  	kvm_handle_hva_range(mn, address, address + 1, pte, kvm_set_spte_gfn);
>  }
>  
> -void kvm_mmu_invalidate_begin(struct kvm *kvm, unsigned long start,
> -			      unsigned long end)
> +static inline

Don't tag static functions with "inline" unless they're in headers, in which case
the inline is effectively required.  In pretty much every scenario, the compiler
can do a better job of optimizing inline vs. non-inline, i.e. odds are very good
the compiler would inline this helper anyways, and if not, there would likely be
a good reason not to inline it.

It'll be a moot point in this case (more below), but this would also reduce the
line length and avoid the wrap.

> void update_invalidate_range(struct kvm *kvm, gfn_t start,
> +							    gfn_t end)

I appreciate the effort to make this easier to read, but making such a big divergence
from the kernel's preferred formatting is often counter-productive, e.g. I blinked a
few times when first reading this code.

Again, moot point this time (still below ;-) ), but for future reference, better
options are to either let the line poke out or simply wrap early to get the
bundling of parameters that you want, e.g.

  static inline void update_invalidate_range(struct kvm *kvm, gfn_t start, gfn_t end)

or 

  static inline void update_invalidate_range(struct kvm *kvm,
					     gfn_t start, gfn_t end)

>  {
> -	/*
> -	 * The count increase must become visible at unlock time as no
> -	 * spte can be established without taking the mmu_lock and
> -	 * count is also read inside the mmu_lock critical section.
> -	 */
> -	kvm->mmu_invalidate_in_progress++;
>  	if (likely(kvm->mmu_invalidate_in_progress == 1)) {
>  		kvm->mmu_invalidate_range_start = start;
>  		kvm->mmu_invalidate_range_end = end;
> @@ -744,6 +738,28 @@ void kvm_mmu_invalidate_begin(struct kvm *kvm, unsigned long start,
>  	}
>  }
>  
> +static void mark_invalidate_in_progress(struct kvm *kvm, gfn_t start, gfn_t end)

Splitting the helpers this way yields a weird API overall, e.g. it's possible
(common, actually) to have an "end" without a "begin".

Taking the range in the "end" is also dangerous/misleading/imbalanced, because _if_
there are multiple ranges in a batch, each range would need to be unwound
independently, e.g. the invocation of the "end" helper in
kvm_mmu_notifier_invalidate_range_end() is flat out wrong, it just doesn't cause
problems because KVM doesn't (currently) try to unwind regions (and probably never
will, but that's beside the point).

Rather than shunt what is effectively the "begin" into a separate helper, provide
three separate APIs, e.g. begin, range_add, end.  That way, begin+end don't take a
range and thus are symmetrical, always paired, and can't screw up unwinding since
they don't have a range to unwind.

It'll require three calls in every case, but that's not the end of the world since
none of these flows are super hot paths.

> +{
> +	/*
> +	 * The count increase must become visible at unlock time as no
> +	 * spte can be established without taking the mmu_lock and
> +	 * count is also read inside the mmu_lock critical section.
> +	 */
> +	kvm->mmu_invalidate_in_progress++;

This should invalidate (ha!) mmu_invalidate_range_{start,end}, and then WARN in
mmu_invalidate_retry() if the range isn't valid.  And the "add" helper should
WARN if mmu_invalidate_in_progress == 0.

> +}
> +
> +static bool kvm_mmu_handle_gfn_range(struct kvm *kvm, struct kvm_gfn_range *range)

"handle" is waaaay too generic.  Just match kvm_unmap_gfn_range() and call it
kvm_mmu_unmap_gfn_range().  This is a local function so it's unlikely to collide
with arch code, now or in the future.

> +{
> +	update_invalidate_range(kvm, range->start, range->end);
> +	return kvm_unmap_gfn_range(kvm, range);
> +}

Overall, this?  Compile tested only...

---
 arch/x86/kvm/mmu/mmu.c   |  8 +++++---
 include/linux/kvm_host.h | 33 +++++++++++++++++++++------------
 virt/kvm/kvm_main.c      | 30 +++++++++++++++++++++---------
 3 files changed, 47 insertions(+), 24 deletions(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 93c389eaf471..d4b373e3e524 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -4259,7 +4259,7 @@ static bool is_page_fault_stale(struct kvm_vcpu *vcpu,
 		return true;
 
 	return fault->slot &&
-	       mmu_invalidate_retry_hva(vcpu->kvm, mmu_seq, fault->hva);
+	       mmu_invalidate_retry_gfn(vcpu->kvm, mmu_seq, fault->gfn);
 }
 
 static int direct_page_fault(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault)
@@ -6098,7 +6098,9 @@ void kvm_zap_gfn_range(struct kvm *kvm, gfn_t gfn_start, gfn_t gfn_end)
 
 	write_lock(&kvm->mmu_lock);
 
-	kvm_mmu_invalidate_begin(kvm, gfn_start, gfn_end);
+	kvm_mmu_invalidate_begin(kvm);
+
+	kvm_mmu_invalidate_range_add(kvm, gfn_start, gfn_end);
 
 	flush = kvm_rmap_zap_gfn_range(kvm, gfn_start, gfn_end);
 
@@ -6112,7 +6114,7 @@ void kvm_zap_gfn_range(struct kvm *kvm, gfn_t gfn_start, gfn_t gfn_end)
 		kvm_flush_remote_tlbs_with_address(kvm, gfn_start,
 						   gfn_end - gfn_start);
 
-	kvm_mmu_invalidate_end(kvm, gfn_start, gfn_end);
+	kvm_mmu_invalidate_end(kvm);
 
 	write_unlock(&kvm->mmu_lock);
 }
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index e6e66c5e56f2..29aa6d6827cc 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -778,8 +778,8 @@ struct kvm {
 	struct mmu_notifier mmu_notifier;
 	unsigned long mmu_invalidate_seq;
 	long mmu_invalidate_in_progress;
-	unsigned long mmu_invalidate_range_start;
-	unsigned long mmu_invalidate_range_end;
+	gfn_t mmu_invalidate_range_start;
+	gfn_t mmu_invalidate_range_end;
 #endif
 	struct list_head devices;
 	u64 manual_dirty_log_protect;
@@ -1378,10 +1378,9 @@ void kvm_mmu_free_memory_cache(struct kvm_mmu_memory_cache *mc);
 void *kvm_mmu_memory_cache_alloc(struct kvm_mmu_memory_cache *mc);
 #endif
 
-void kvm_mmu_invalidate_begin(struct kvm *kvm, unsigned long start,
-			      unsigned long end);
-void kvm_mmu_invalidate_end(struct kvm *kvm, unsigned long start,
-			    unsigned long end);
+void kvm_mmu_invalidate_begin(struct kvm *kvm);
+void kvm_mmu_invalidate_range_add(struct kvm *kvm, gfn_t start, gfn_t end);
+void kvm_mmu_invalidate_end(struct kvm *kvm);
 
 long kvm_arch_dev_ioctl(struct file *filp,
 			unsigned int ioctl, unsigned long arg);
@@ -1952,9 +1951,9 @@ static inline int mmu_invalidate_retry(struct kvm *kvm, unsigned long mmu_seq)
 	return 0;
 }
 
-static inline int mmu_invalidate_retry_hva(struct kvm *kvm,
+static inline int mmu_invalidate_retry_gfn(struct kvm *kvm,
 					   unsigned long mmu_seq,
-					   unsigned long hva)
+					   gfn_t gfn)
 {
 	lockdep_assert_held(&kvm->mmu_lock);
 	/*
@@ -1963,10 +1962,20 @@ static inline int mmu_invalidate_retry_hva(struct kvm *kvm,
 	 * that might be being invalidated. Note that it may include some false
 	 * positives, due to shortcuts when handing concurrent invalidations.
 	 */
-	if (unlikely(kvm->mmu_invalidate_in_progress) &&
-	    hva >= kvm->mmu_invalidate_range_start &&
-	    hva < kvm->mmu_invalidate_range_end)
-		return 1;
+	if (unlikely(kvm->mmu_invalidate_in_progress)) {
+		/*
+		 * Dropping mmu_lock after bumping mmu_invalidate_in_progress
+		 * but before updating the range is a KVM bug.
+		 */
+		if (WARN_ON_ONCE(kvm->mmu_invalidate_range_start == INVALID_GPA ||
+				 kvm->mmu_invalidate_range_end == INVALID_GPA))
+			return 1;
+
+		if (gfn >= kvm->mmu_invalidate_range_start &&
+		    gfn < kvm->mmu_invalidate_range_end)
+			return 1;
+	}
+
 	if (kvm->mmu_invalidate_seq != mmu_seq)
 		return 1;
 	return 0;
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 43bbe4fde078..e9e03b979f77 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -540,9 +540,7 @@ static void kvm_mmu_notifier_invalidate_range(struct mmu_notifier *mn,
 
 typedef bool (*hva_handler_t)(struct kvm *kvm, struct kvm_gfn_range *range);
 
-typedef void (*on_lock_fn_t)(struct kvm *kvm, unsigned long start,
-			     unsigned long end);
-
+typedef void (*on_lock_fn_t)(struct kvm *kvm);
 typedef void (*on_unlock_fn_t)(struct kvm *kvm);
 
 struct kvm_hva_range {
@@ -628,7 +626,8 @@ static __always_inline int __kvm_handle_hva_range(struct kvm *kvm,
 				locked = true;
 				KVM_MMU_LOCK(kvm);
 				if (!IS_KVM_NULL_FN(range->on_lock))
-					range->on_lock(kvm, range->start, range->end);
+					range->on_lock(kvm);
+
 				if (IS_KVM_NULL_FN(range->handler))
 					break;
 			}
@@ -715,8 +714,7 @@ static void kvm_mmu_notifier_change_pte(struct mmu_notifier *mn,
 	kvm_handle_hva_range(mn, address, address + 1, pte, kvm_set_spte_gfn);
 }
 
-void kvm_mmu_invalidate_begin(struct kvm *kvm, unsigned long start,
-			      unsigned long end)
+void kvm_mmu_invalidate_begin(struct kvm *kvm)
 {
 	/*
 	 * The count increase must become visible at unlock time as no
@@ -724,6 +722,15 @@ void kvm_mmu_invalidate_begin(struct kvm *kvm, unsigned long start,
 	 * count is also read inside the mmu_lock critical section.
 	 */
 	kvm->mmu_invalidate_in_progress++;
+
+	kvm->mmu_invalidate_range_start = INVALID_GPA;
+	kvm->mmu_invalidate_range_end = INVALID_GPA;
+}
+
+void kvm_mmu_invalidate_range_add(struct kvm *kvm, gfn_t start, gfn_t end)
+{
+	WARN_ON_ONCE(!kvm->mmu_invalidate_in_progress);
+
 	if (likely(kvm->mmu_invalidate_in_progress == 1)) {
 		kvm->mmu_invalidate_range_start = start;
 		kvm->mmu_invalidate_range_end = end;
@@ -744,6 +751,12 @@ void kvm_mmu_invalidate_begin(struct kvm *kvm, unsigned long start,
 	}
 }
 
+static bool kvm_mmu_unmap_gfn_range(struct kvm *kvm, struct kvm_gfn_range *range)
+{
+	kvm_mmu_invalidate_range_add(kvm, range->start, range->end);
+	return kvm_unmap_gfn_range(kvm, range);
+}
+
 static int kvm_mmu_notifier_invalidate_range_start(struct mmu_notifier *mn,
 					const struct mmu_notifier_range *range)
 {
@@ -752,7 +765,7 @@ static int kvm_mmu_notifier_invalidate_range_start(struct mmu_notifier *mn,
 		.start		= range->start,
 		.end		= range->end,
 		.pte		= __pte(0),
-		.handler	= kvm_unmap_gfn_range,
+		.handler	= kvm_mmu_unmap_gfn_range,
 		.on_lock	= kvm_mmu_invalidate_begin,
 		.on_unlock	= kvm_arch_guest_memory_reclaimed,
 		.flush_on_ret	= true,
@@ -791,8 +804,7 @@ static int kvm_mmu_notifier_invalidate_range_start(struct mmu_notifier *mn,
 	return 0;
 }
 
-void kvm_mmu_invalidate_end(struct kvm *kvm, unsigned long start,
-			    unsigned long end)
+void kvm_mmu_invalidate_end(struct kvm *kvm)
 {
 	/*
 	 * This sequence increase will notify the kvm page fault that

base-commit: d663b8a285986072428a6a145e5994bc275df994
-- 

