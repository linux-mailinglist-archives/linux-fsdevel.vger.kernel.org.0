Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 764CD758947
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Jul 2023 01:49:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231196AbjGRXtz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Jul 2023 19:49:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230216AbjGRXtQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Jul 2023 19:49:16 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3990F1FC6
        for <linux-fsdevel@vger.kernel.org>; Tue, 18 Jul 2023 16:48:46 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-cac213f9264so6070883276.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 18 Jul 2023 16:48:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689724125; x=1692316125;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=YutdMElGbp9P5hSkuCpmC8VJ7V3PNb+s/AjU6M3aOE8=;
        b=fv5PAifQ+IqLg5YCZqVv/8UfhbcgYKQcYF3VY0+jp+9AW0GEauEM9c/l2th/BfOtRm
         CQiXDrdFVD2W7gdnkrgGNuk1FWqnXZCui5KNHEJZNKFbYGE3o6y6cS/CRv3k2n8pR5iS
         sMPjf4zdwa9albkzvFhGKioR2FBoJS58rCVLaVO5jIXG18PShPMZQfFotlM0oiS44ak5
         wH72KK42j+tXvl9XbOo8Q688HudYyAAS7uwccxs/g6IQguY5eI+gDO5TZMYBuh3X4bOG
         jik8MJDjJL4Dv3zLF48fb1grV3qG4y91bzqSazr3bySPVvnzIDpkEov2LrTDdj61DR8b
         pWpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689724125; x=1692316125;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YutdMElGbp9P5hSkuCpmC8VJ7V3PNb+s/AjU6M3aOE8=;
        b=cmYt423wasKvbmLAQ3OoWviPaQEHnUspBdvkGqMTPM1m/oVKB6HosNo2TJ8lJ9V2Ka
         TIQ2UpgbdcIF3US0vjI6WlQV64kZbTY8rWqQmGxGoslVC7In7pmIgtdL85fwJ4CEEdBG
         MPItC0J2mHiytbXGYo4/xsSXfNBDl7OJvE796oY8bWcJ+A7k0BxhrqRP5GsKOzxFOrqU
         elthNQ1fFrUS90Tegey2H1uG9rBjkgBBKsp8sNXAy+2wEBDgAWj65zRtyGFykEJGYx/A
         VnNPZ9KIUxdkHSkmI6KgE6rKXaVSrQ48/r2ufmtMP1vlmraUVB7aKkUvIKMNe8ztO3Jp
         9n4g==
X-Gm-Message-State: ABy/qLYNFEE0XirutUNdgePg5axjz6mx/4BcMX0SOhzmJ2EUe9USW9B0
        9tdN+IXX3qcw9I8ls8WJGassFXtRkzQ=
X-Google-Smtp-Source: APBJJlEBqRkJLxPhHZfq9dzn/bDkdLKPNX43lLfClkxec0b9fruWECEDkqvu4RpyrQH11Geekj2aMuiEVrw=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a25:ab04:0:b0:bfe:ea69:91b4 with SMTP id
 u4-20020a25ab04000000b00bfeea6991b4mr11891ybi.4.1689724125035; Tue, 18 Jul
 2023 16:48:45 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Tue, 18 Jul 2023 16:44:50 -0700
In-Reply-To: <20230718234512.1690985-1-seanjc@google.com>
Mime-Version: 1.0
References: <20230718234512.1690985-1-seanjc@google.com>
X-Mailer: git-send-email 2.41.0.255.g8b1d071c50-goog
Message-ID: <20230718234512.1690985-8-seanjc@google.com>
Subject: [RFC PATCH v11 07/29] KVM: Add KVM_EXIT_MEMORY_FAULT exit
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
        Yu Zhang <yu.c.zhang@linux.intel.com>,
        Vishal Annapurve <vannapurve@google.com>,
        Ackerley Tng <ackerleytng@google.com>,
        Maciej Szmigiero <mail@maciej.szmigiero.name>,
        Vlastimil Babka <vbabka@suse.cz>,
        David Hildenbrand <david@redhat.com>,
        Quentin Perret <qperret@google.com>,
        Michael Roth <michael.roth@amd.com>,
        Wang <wei.w.wang@intel.com>,
        Liam Merwick <liam.merwick@oracle.com>,
        Isaku Yamahata <isaku.yamahata@gmail.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Chao Peng <chao.p.peng@linux.intel.com>

This new KVM exit allows userspace to handle memory-related errors. It
indicates an error happens in KVM at guest memory range [gpa, gpa+size).
The flags includes additional information for userspace to handle the
error. Currently bit 0 is defined as 'private memory' where '1'
indicates error happens due to private memory access and '0' indicates
error happens due to shared memory access.

When private memory is enabled, this new exit will be used for KVM to
exit to userspace for shared <-> private memory conversion in memory
encryption usage. In such usage, typically there are two kind of memory
conversions:
  - explicit conversion: happens when guest explicitly calls into KVM
    to map a range (as private or shared), KVM then exits to userspace
    to perform the map/unmap operations.
  - implicit conversion: happens in KVM page fault handler where KVM
    exits to userspace for an implicit conversion when the page is in a
    different state than requested (private or shared).

Suggested-by: Sean Christopherson <seanjc@google.com>
Co-developed-by: Yu Zhang <yu.c.zhang@linux.intel.com>
Signed-off-by: Yu Zhang <yu.c.zhang@linux.intel.com>
Signed-off-by: Chao Peng <chao.p.peng@linux.intel.com>
Reviewed-by: Fuad Tabba <tabba@google.com>
Tested-by: Fuad Tabba <tabba@google.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 Documentation/virt/kvm/api.rst | 22 ++++++++++++++++++++++
 include/uapi/linux/kvm.h       |  8 ++++++++
 2 files changed, 30 insertions(+)

diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
index c0ddd3035462..34d4ce66e0c8 100644
--- a/Documentation/virt/kvm/api.rst
+++ b/Documentation/virt/kvm/api.rst
@@ -6700,6 +6700,28 @@ array field represents return values. The userspace should update the return
 values of SBI call before resuming the VCPU. For more details on RISC-V SBI
 spec refer, https://github.com/riscv/riscv-sbi-doc.
 
+::
+
+		/* KVM_EXIT_MEMORY_FAULT */
+		struct {
+  #define KVM_MEMORY_EXIT_FLAG_PRIVATE	(1ULL << 3)
+			__u64 flags;
+			__u64 gpa;
+			__u64 size;
+		} memory;
+
+If exit reason is KVM_EXIT_MEMORY_FAULT then it indicates that the VCPU has
+encountered a memory error which is not handled by KVM kernel module and
+userspace may choose to handle it. The 'flags' field indicates the memory
+properties of the exit.
+
+ - KVM_MEMORY_EXIT_FLAG_PRIVATE - indicates the memory error is caused by
+   private memory access when the bit is set. Otherwise the memory error is
+   caused by shared memory access when the bit is clear.
+
+'gpa' and 'size' indicate the memory range the error occurs at. The userspace
+may handle the error and return to KVM to retry the previous memory access.
+
 ::
 
     /* KVM_EXIT_NOTIFY */
diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
index 4d4b3de8ac55..6c6ed214b6ac 100644
--- a/include/uapi/linux/kvm.h
+++ b/include/uapi/linux/kvm.h
@@ -274,6 +274,7 @@ struct kvm_xen_exit {
 #define KVM_EXIT_RISCV_SBI        35
 #define KVM_EXIT_RISCV_CSR        36
 #define KVM_EXIT_NOTIFY           37
+#define KVM_EXIT_MEMORY_FAULT     38
 
 /* For KVM_EXIT_INTERNAL_ERROR */
 /* Emulate instruction failed. */
@@ -520,6 +521,13 @@ struct kvm_run {
 #define KVM_NOTIFY_CONTEXT_INVALID	(1 << 0)
 			__u32 flags;
 		} notify;
+		/* KVM_EXIT_MEMORY_FAULT */
+		struct {
+#define KVM_MEMORY_EXIT_FLAG_PRIVATE	(1ULL << 3)
+			__u64 flags;
+			__u64 gpa;
+			__u64 size;
+		} memory;
 		/* Fix the size of the union. */
 		char padding[256];
 	};
-- 
2.41.0.255.g8b1d071c50-goog

