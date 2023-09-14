Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE05079F6E7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Sep 2023 03:57:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234461AbjINB5g (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 Sep 2023 21:57:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234222AbjINB4P (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 Sep 2023 21:56:15 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9A5926AD
        for <linux-fsdevel@vger.kernel.org>; Wed, 13 Sep 2023 18:55:54 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id d9443c01a7336-1c40ac5b6e7so2354745ad.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 13 Sep 2023 18:55:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694656554; x=1695261354; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=snuesVO7Pgb0vyCed2d5Ea1z3YHTBEL1EKVJI8LHRYQ=;
        b=2O7dffWA0dAR1kJz/tcUT9IFhJ9iQQW3d965flzVhFwv6jmKYCwEKI5nD1XYm6dOAx
         5JmEe9B/1X5drZCT/oKMc5xPt7I3gQdf+hRxIH69cSsBaGpWlnwl5CL2dbXIkaWhgpzu
         HNRdP55+OV753gayFnjJ4A/Yfxwj/alYoQ/VkkR+Nb5TZSoXWyo2x7CxKesFwsUb9PNX
         /bDCSKdrUbuGP+qfsITC/dzZZi5lk4LajgVBkw76blkYEYPIaAqknc158TnMeWgz6UHw
         BcDWqjP+1mcX2xxmYrDjOGmYmrwdmS+rXurV4c/dtSKs4EzyR7VAHdKehpP0dqmrkSWD
         xEag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694656554; x=1695261354;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=snuesVO7Pgb0vyCed2d5Ea1z3YHTBEL1EKVJI8LHRYQ=;
        b=lPIAV6xtviynMYjF0QMvIHqRHNmML+PtwnhtvO29xaPcGhhKEpxGEuPTP92u++qvRi
         LhGq7Q40bA5U7bfQEv3Xxh2FyfKNgMl/tE7stOXqZifT/+/6q6DA1VdLP1KhBb8yPXup
         FrIn4YNAtIz8onQFIFBkW5wW3pAk+BPOJ/gdFUoQ3JfZds7pxx+j9CfGiXT8oFsNz7wB
         Acf1A1UIO9UozBItDGJPan/wPf7q65Ehe8M7kTYSDprzsqE9anvTafHJmZs6SskwTD4S
         BGWYvHFLRKBjWpm1atxax2Qj3U/dtjr0A3ddlbh9BpBTHLa89mC7PjGcU9uQoxQWXjHP
         Sn4w==
X-Gm-Message-State: AOJu0YzyM7vDmkTWxaUoBFq1/iEvxIGs4GtXeVGbNgvLolk4IFE4H4WE
        mIvefRYU9SL/MYuCqSfTZzUUwPt0qkI=
X-Google-Smtp-Source: AGHT+IGilm0IehJXdYbDJdwfV4Q368JwTuC1tx+vxoEF5ebf3gbFa0uVyGZgeqLtkzJroDu6r4LDVxWZ5mo=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:902:6bca:b0:1b8:80c9:a98e with SMTP id
 m10-20020a1709026bca00b001b880c9a98emr149790plt.13.1694656554156; Wed, 13 Sep
 2023 18:55:54 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Wed, 13 Sep 2023 18:55:07 -0700
In-Reply-To: <20230914015531.1419405-1-seanjc@google.com>
Mime-Version: 1.0
References: <20230914015531.1419405-1-seanjc@google.com>
X-Mailer: git-send-email 2.42.0.283.g2d96d420d3-goog
Message-ID: <20230914015531.1419405-10-seanjc@google.com>
Subject: [RFC PATCH v12 09/33] KVM: Drop .on_unlock() mmu_notifier hook
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>, Marc Zyngier <maz@kernel.org>,
        Oliver Upton <oliver.upton@linux.dev>,
        Huacai Chen <chenhuacai@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Anup Patel <anup@brainfault.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Sean Christopherson <seanjc@google.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Paul Moore <paul@paul-moore.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>
Cc:     kvm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kvmarm@lists.linux.dev, linux-mips@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, kvm-riscv@lists.infradead.org,
        linux-riscv@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Chao Peng <chao.p.peng@linux.intel.com>,
        Fuad Tabba <tabba@google.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Anish Moorthy <amoorthy@google.com>,
        Yu Zhang <yu.c.zhang@linux.intel.com>,
        Isaku Yamahata <isaku.yamahata@intel.com>,
        Xu Yilun <yilun.xu@intel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Vishal Annapurve <vannapurve@google.com>,
        Ackerley Tng <ackerleytng@google.com>,
        Maciej Szmigiero <mail@maciej.szmigiero.name>,
        David Hildenbrand <david@redhat.com>,
        Quentin Perret <qperret@google.com>,
        Michael Roth <michael.roth@amd.com>,
        Wang <wei.w.wang@intel.com>,
        Liam Merwick <liam.merwick@oracle.com>,
        Isaku Yamahata <isaku.yamahata@gmail.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Drop the .on_unlock() mmu_notifer hook now that it's no longer used for
notifying arch code that memory has been reclaimed.  Adding .on_unlock()
and invoking it *after* dropping mmu_lock was a terrible idea, as doing so
resulted in .on_lock() and .on_unlock() having divergent and asymmetric
behavior, and set future developers up for failure, i.e. all but asked for
bugs where KVM relied using .on_unlock() to try to run a callback while
holding mmu_lock.

Opportunistically add a lockdep assertion in kvm_mmu_invalidate_end() to
guard against future bugs of this nature.

Reported-by: Isaku Yamahata <isaku.yamahata@intel.com>
Link: https://lore.kernel.org/all/20230802203119.GB2021422@ls.amr.corp.intel.com
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 virt/kvm/kvm_main.c | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 76d01de7838f..174de2789657 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -544,7 +544,6 @@ static inline struct kvm *mmu_notifier_to_kvm(struct mmu_notifier *mn)
 typedef bool (*gfn_handler_t)(struct kvm *kvm, struct kvm_gfn_range *range);
 
 typedef void (*on_lock_fn_t)(struct kvm *kvm);
-typedef void (*on_unlock_fn_t)(struct kvm *kvm);
 
 struct kvm_mmu_notifier_range {
 	/*
@@ -556,7 +555,6 @@ struct kvm_mmu_notifier_range {
 	union kvm_mmu_notifier_arg arg;
 	gfn_handler_t handler;
 	on_lock_fn_t on_lock;
-	on_unlock_fn_t on_unlock;
 	bool flush_on_ret;
 	bool may_block;
 };
@@ -663,11 +661,8 @@ static __always_inline kvm_mn_ret_t __kvm_handle_hva_range(struct kvm *kvm,
 	if (range->flush_on_ret && r.ret)
 		kvm_flush_remote_tlbs(kvm);
 
-	if (r.found_memslot) {
+	if (r.found_memslot)
 		KVM_MMU_UNLOCK(kvm);
-		if (!IS_KVM_NULL_FN(range->on_unlock))
-			range->on_unlock(kvm);
-	}
 
 	srcu_read_unlock(&kvm->srcu, idx);
 
@@ -687,7 +682,6 @@ static __always_inline int kvm_handle_hva_range(struct mmu_notifier *mn,
 		.arg		= arg,
 		.handler	= handler,
 		.on_lock	= (void *)kvm_null_fn,
-		.on_unlock	= (void *)kvm_null_fn,
 		.flush_on_ret	= true,
 		.may_block	= false,
 	};
@@ -706,7 +700,6 @@ static __always_inline int kvm_handle_hva_range_no_flush(struct mmu_notifier *mn
 		.end		= end,
 		.handler	= handler,
 		.on_lock	= (void *)kvm_null_fn,
-		.on_unlock	= (void *)kvm_null_fn,
 		.flush_on_ret	= false,
 		.may_block	= false,
 	};
@@ -811,7 +804,6 @@ static int kvm_mmu_notifier_invalidate_range_start(struct mmu_notifier *mn,
 		.end		= range->end,
 		.handler	= kvm_mmu_unmap_gfn_range,
 		.on_lock	= kvm_mmu_invalidate_begin,
-		.on_unlock	= (void *)kvm_null_fn,
 		.flush_on_ret	= true,
 		.may_block	= mmu_notifier_range_blockable(range),
 	};
@@ -856,6 +848,8 @@ static int kvm_mmu_notifier_invalidate_range_start(struct mmu_notifier *mn,
 
 void kvm_mmu_invalidate_end(struct kvm *kvm)
 {
+	lockdep_assert_held_write(&kvm->mmu_lock);
+
 	/*
 	 * This sequence increase will notify the kvm page fault that
 	 * the page that is going to be mapped in the spte could have
@@ -887,7 +881,6 @@ static void kvm_mmu_notifier_invalidate_range_end(struct mmu_notifier *mn,
 		.end		= range->end,
 		.handler	= (void *)kvm_null_fn,
 		.on_lock	= kvm_mmu_invalidate_end,
-		.on_unlock	= (void *)kvm_null_fn,
 		.flush_on_ret	= false,
 		.may_block	= mmu_notifier_range_blockable(range),
 	};
-- 
2.42.0.283.g2d96d420d3-goog

