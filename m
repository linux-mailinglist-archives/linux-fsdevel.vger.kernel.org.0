Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4334C7734EC
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Aug 2023 01:25:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230167AbjHGXZI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 7 Aug 2023 19:25:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230115AbjHGXZH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 Aug 2023 19:25:07 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21A5A136
        for <linux-fsdevel@vger.kernel.org>; Mon,  7 Aug 2023 16:25:05 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d07cb52a768so5432830276.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 07 Aug 2023 16:25:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691450704; x=1692055504;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=iwb23aAhSO8tTiEFGOvNlQCsoOox6vBjb8gCypJE4mI=;
        b=R4PwviCR8DjVobdiirsmlaUW+2G2OreWXDR1oudY0WdYIlf/tRBxovHV7VVaY5H2D7
         s6z9nsA/hZZOzOlAXwj0GlLszUfPpUcqxoVPBkJopNIVm5p7oN0Kjjk8CNCU0uvTetel
         32HvbTwQx+uTw/DQ0hiV2GccLkJL/LCqkzOCOWamh7kng72/soRCwM6up6P8iJdnPSBO
         x/GLCUjk6m180XrAeVCUYgLoKf2lX03dUyg16yLerbR/XPy1Dd0ljJbOlBwH8tdW8OEH
         2D0Guisqm80uErrMhMIOa5wS5t40qQeuRJl0ljw9a+5siKs8Y3hopoVBYIWmqvB1hWx2
         ivOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691450704; x=1692055504;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iwb23aAhSO8tTiEFGOvNlQCsoOox6vBjb8gCypJE4mI=;
        b=H7JrFf9No+cp5aVfJR13ey8BFfJWFPIjQuTO8ffcipOI2z9AuaXSTwnnSffJCrO7M4
         /YCgBnW1z1xjXG5KiSFFA/fKxo9CxirEgd4L1LCHpzGO4HwrH+1vJYDYkchTuLfLC8X5
         4PywvmxqaVdWDM71VkeSwxYH1pRBTgWtMsEUc8PUw9gFlK4LVidnI6UtG5mjyHBfj4Fj
         yVh5Ih0h8b1qPZjTvr+50YNr5GgsZgZ5aENRTT33+M/eZ2nR4FBZtSbWmMV1XxymOfWF
         hzyNb6Rn4PGqfBqvzb83dgUgf4B8m1O40sZvadEL0FSXC8F+3twnZm/YoPwjhhWWnhug
         0EuQ==
X-Gm-Message-State: AOJu0YyhesdaGTdFMCeSiv8LULkJBh56iucZcJH3XhYVNrxhhdn0tpX9
        ubC1orx4xRtHxWIibbM5ypPY+yuTpxi3JuEYiA==
X-Google-Smtp-Source: AGHT+IFETd5g4M85TFzvRFwf955/8WReyRF2E8l7BIM0KMZjnxLWho58vfoUb+v3YvXkNVl+0ZtvnZ9xmC/A9UkLTg==
X-Received: from ackerleytng-ctop.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:13f8])
 (user=ackerleytng job=sendgmr) by 2002:a25:445:0:b0:d4c:2a34:aeab with SMTP
 id 66-20020a250445000000b00d4c2a34aeabmr47419ybe.11.1691450704306; Mon, 07
 Aug 2023 16:25:04 -0700 (PDT)
Date:   Mon, 07 Aug 2023 23:25:02 +0000
In-Reply-To: <20230718234512.1690985-29-seanjc@google.com> (message from Sean
 Christopherson on Tue, 18 Jul 2023 16:45:11 -0700)
Mime-Version: 1.0
Message-ID: <diqzleem306p.fsf@ackerleytng-ctop.c.googlers.com>
Subject: Re: [RFC PATCH v11 28/29] KVM: selftests: Add basic selftest for guest_memfd()
From:   Ackerley Tng <ackerleytng@google.com>
To:     Sean Christopherson <seanjc@google.com>
Cc:     pbonzini@redhat.com, maz@kernel.org, oliver.upton@linux.dev,
        chenhuacai@kernel.org, mpe@ellerman.id.au, anup@brainfault.org,
        paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, seanjc@google.com, willy@infradead.org,
        akpm@linux-foundation.org, paul@paul-moore.com, jmorris@namei.org,
        serge@hallyn.com, kvm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
        linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, chao.p.peng@linux.intel.com,
        tabba@google.com, jarkko@kernel.org, yu.c.zhang@linux.intel.com,
        vannapurve@google.com, mail@maciej.szmigiero.name, vbabka@suse.cz,
        david@redhat.com, qperret@google.com, michael.roth@amd.com,
        wei.w.wang@intel.com, liam.merwick@oracle.com,
        isaku.yamahata@gmail.com, kirill.shutemov@linux.intel.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Sean Christopherson <seanjc@google.com> writes:

> Add a selftest to verify the basic functionality of guest_memfd():
>
> <snip>

Here's one more test:

From 72dc6836f01bdd613d64d4c6a4f2af8f2b777ba2 Mon Sep 17 00:00:00 2001
From: Ackerley Tng <ackerleytng@google.com>
Date: Tue, 1 Aug 2023 18:02:50 +0000
Subject: [PATCH] KVM: selftests: Add tests - invalid inputs for
 KVM_CREATE_GUEST_MEMFD

Test that invalid inputs for KVM_CREATE_GUEST_MEMFD, such as
non-page-aligned page size and invalid flags, are rejected by the
KVM_CREATE_GUEST_MEMFD with EINVAL

Signed-off-by: Ackerley Tng <ackerleytng@google.com>
---
 tools/testing/selftests/kvm/guest_memfd_test.c  | 17 +++++++++++++++++
 .../selftests/kvm/include/kvm_util_base.h       | 11 +++++++++--
 2 files changed, 26 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/kvm/guest_memfd_test.c b/tools/testing/selftests/kvm/guest_memfd_test.c
index eb93c608a7e0..ad20f11b2d2c 100644
--- a/tools/testing/selftests/kvm/guest_memfd_test.c
+++ b/tools/testing/selftests/kvm/guest_memfd_test.c
@@ -90,6 +90,21 @@ static void test_fallocate(int fd, size_t page_size, size_t total_size)
 	TEST_ASSERT(!ret, "fallocate to restore punched hole should succeed");
 }
 
+static void test_create_guest_memfd_invalid(struct kvm_vm *vm, size_t page_size)
+{
+	int fd;
+
+	/* Non-page-aligned page_size */
+	fd = __vm_create_guest_memfd(vm, 1, 0);
+	ASSERT_EQ(fd, -1);
+	ASSERT_EQ(errno, EINVAL);
+
+	/* Invalid flags */
+	fd = __vm_create_guest_memfd(vm, page_size, 99);
+	ASSERT_EQ(fd, -1);
+	ASSERT_EQ(errno, EINVAL);
+}
+
 
 int main(int argc, char *argv[])
 {
@@ -103,6 +118,8 @@ int main(int argc, char *argv[])
 
 	vm = vm_create_barebones();
 
+	test_create_guest_memfd_invalid(vm, page_size);
+
 	fd = vm_create_guest_memfd(vm, total_size, 0);
 
 	test_file_read_write(fd);
diff --git a/tools/testing/selftests/kvm/include/kvm_util_base.h b/tools/testing/selftests/kvm/include/kvm_util_base.h
index 39b38c75b99c..8bdfadd72349 100644
--- a/tools/testing/selftests/kvm/include/kvm_util_base.h
+++ b/tools/testing/selftests/kvm/include/kvm_util_base.h
@@ -474,7 +474,8 @@ static inline uint64_t vm_get_stat(struct kvm_vm *vm, const char *stat_name)
 }
 
 void vm_create_irqchip(struct kvm_vm *vm);
-static inline int vm_create_guest_memfd(struct kvm_vm *vm, uint64_t size,
+
+static inline int __vm_create_guest_memfd(struct kvm_vm *vm, uint64_t size,
 					uint64_t flags)
 {
 	struct kvm_create_guest_memfd gmem = {
@@ -482,7 +483,13 @@ static inline int vm_create_guest_memfd(struct kvm_vm *vm, uint64_t size,
 		.flags = flags,
 	};
 
-	int fd = __vm_ioctl(vm, KVM_CREATE_GUEST_MEMFD, &gmem);
+	return __vm_ioctl(vm, KVM_CREATE_GUEST_MEMFD, &gmem);
+}
+
+static inline int vm_create_guest_memfd(struct kvm_vm *vm, uint64_t size,
+					uint64_t flags)
+{
+	int fd = __vm_create_guest_memfd(vm, size, flags);
 
 	TEST_ASSERT(fd >= 0, KVM_IOCTL_ERROR(KVM_CREATE_GUEST_MEMFD, fd));
 	return fd;
-- 
2.41.0.640.ga95def55d0-goog

