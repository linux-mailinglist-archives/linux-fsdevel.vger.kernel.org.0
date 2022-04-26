Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0144250F04A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Apr 2022 07:39:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244828AbiDZFm4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 Apr 2022 01:42:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244479AbiDZFma (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 26 Apr 2022 01:42:30 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28112326ED
        for <linux-fsdevel@vger.kernel.org>; Mon, 25 Apr 2022 22:39:21 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id bj12-20020a056a02018c00b003a9eebaad34so10375097pgb.10
        for <linux-fsdevel@vger.kernel.org>; Mon, 25 Apr 2022 22:39:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=75ck2E1viXT4HNKGmhZGUqApOq35yGNlgD3kbgrzKrw=;
        b=j/6W1Jv8f36ZodhL68vNcySdndUH2oV1c5OzKpRXYolTLJgwBi7OaIg/S/yKMnJp+b
         lqqaZUm1JBr3oQixRNwaNTgB81/saUAppnPAjz68yxAbmgh4igyoOQ92n9+HzD+TEgqv
         ajW2TFBTyLuEXXVz0pJuHgyUGpGRZnhkjtQoBS+4am6LkE8kl60VYw6Q/6q6/jo9xQNu
         GX4i53uLVaKJIRtdwjxSSMxM+nKgqH6qhEODIoJjq5XuOby3Ip1qDLu+YxucaAIrUMzY
         Psb6biLd1G6xVSJaPjnJffEREeUS4oL482CYqW+UsriFD7QsTwFn/nDOVqJKFywwwAfj
         8XNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=75ck2E1viXT4HNKGmhZGUqApOq35yGNlgD3kbgrzKrw=;
        b=M4js1QDX3TdxfoxZqMvNlxtBeIBvS2AOEjBiOt1+mtPG/6DzPQJUF4FC/Biw0+gVmh
         b5t6jsLYny5zXbKdQ6XYp2bVKgo2Q4zsAODs8WBe6+M+BmtLiYTURXhXw+E9kd5fHcUN
         AhfEh51luyKUO6Nfe3yj+WCXL+unrksNflsWZeDXMPEyqrCmJbhr4tee2B9Tkz5Xux/6
         6e9kiVquRGKB86FM01Ybkb6pECVAZQQCU+lPhFJTHgl5bLKq08r0p9arH0SZn4IH5C90
         MVck6VZZ2GkN60pzuVZTXdJdXV7EKBAMnX6yAdVurnGPbPhqbn+BrJeSEVgvg/4dDldS
         KSjA==
X-Gm-Message-State: AOAM532NPHe+Euht83lmecI+zz09vrUrHircj/90E4xlUHXve8+RpXY1
        Oi59xigblPpSQNy/rnkdFzpejhLRyvag78DH
X-Google-Smtp-Source: ABdhPJz+02KDDV9V68suFOiQPkifF2E9mLN9n/bWhK+6QOZ7ZJ3fdHfj/Lkck5hrYAftknNAaw0TdY1+WqYFvIkS
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2327])
 (user=yosryahmed job=sendgmr) by 2002:a17:902:9881:b0:158:f258:c3c3 with SMTP
 id s1-20020a170902988100b00158f258c3c3mr21548367plp.7.1650951560612; Mon, 25
 Apr 2022 22:39:20 -0700 (PDT)
Date:   Tue, 26 Apr 2022 05:39:00 +0000
In-Reply-To: <20220426053904.3684293-1-yosryahmed@google.com>
Message-Id: <20220426053904.3684293-3-yosryahmed@google.com>
Mime-Version: 1.0
References: <20220426053904.3684293-1-yosryahmed@google.com>
X-Mailer: git-send-email 2.36.0.rc2.479.g8af0fa9b8e-goog
Subject: [PATCH v3 2/6] KVM: mmu: add a helper to account page table pages
 used by KVM.
From:   Yosry Ahmed <yosryahmed@google.com>
To:     Sean Christopherson <seanjc@google.com>,
        Huacai Chen <chenhuacai@kernel.org>,
        Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
        Anup Patel <anup@brainfault.org>,
        Atish Patra <atishp@atishpatra.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        James Morse <james.morse@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
        Marc Zyngier <maz@kernel.org>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     linux-mips@vger.kernel.org, kvm@vger.kernel.org,
        kvm-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kvmarm@lists.cs.columbia.edu, Yosry Ahmed <yosryahmed@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add a helper to account pages used by KVM for page tables as pagetable
stats. This function will be used by subsequent patches in different
archs.

Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
---
 include/linux/kvm_host.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 252ee4a61b58..54cc4634053c 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -2221,6 +2221,15 @@ static inline void kvm_handle_signal_exit(struct kvm_vcpu *vcpu)
 }
 #endif /* CONFIG_KVM_XFER_TO_GUEST_WORK */
 
+/*
+ * If nr > 1, we assume virt is the address of the first page of a block of
+ * pages that were allocated together (i.e accounted together).
+ */
+static inline void kvm_account_pgtable_pages(void *virt, int nr)
+{
+	mod_lruvec_page_state(virt_to_page(virt), NR_SECONDARY_PAGETABLE, nr);
+}
+
 /*
  * This defines how many reserved entries we want to keep before we
  * kick the vcpu to the userspace to avoid dirty ring full.  This
-- 
2.36.0.rc2.479.g8af0fa9b8e-goog

