Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4100C1C3794
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 May 2020 13:04:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728614AbgEDLEQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 4 May 2020 07:04:16 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:29205 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728616AbgEDLEH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 4 May 2020 07:04:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588590243;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rsTdEgsyypdyRB9o18FwxbdIncnKg1Ww1Dhq95WU8LI=;
        b=htP7lQCfuaHfN4zewgP6h78MpsBntc7Cx5n5t0ChyheFBUmE7xncPiiLAkfz/f5IJ36PKY
        8P3Eq8Djq+P1O1RCOT6/Eek/5LWbqY9/tTm7dV2l2ncDjPYV8Bu318OzFMzIhGdCKSyS69
        9HpbHCnWJKQ7nvvzaFb4tJntAXMPP+g=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-475-rWQAbg66Mwq65a3dAOPVWw-1; Mon, 04 May 2020 07:04:01 -0400
X-MC-Unique: rWQAbg66Mwq65a3dAOPVWw-1
Received: by mail-wr1-f71.google.com with SMTP id g7so10520387wrw.18
        for <linux-fsdevel@vger.kernel.org>; Mon, 04 May 2020 04:04:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rsTdEgsyypdyRB9o18FwxbdIncnKg1Ww1Dhq95WU8LI=;
        b=CmzGOt9RKs2FBkRV/U5Nlt1n16+Z1Rmi71LLKYERttHXs70c4Owh8tRI7WpTUSY3C/
         jJrdtwuS6dHeW6Qklj6Ao1KiBQiHK4oFpYBPTXbqqlz25tCijn2DtFTLbPuMJx/yA/l1
         rCZiBc+o+5wfOAUBaFQcj8mhAH4DDS+XxSK6XL1xPDxENmN1X2Y4VDLg5v0ou+JzoNO4
         sP9lIzYKB5Ma/93IF2dNEs4x8jyEEGJYw17UogXVoznIXfncknh8MdiwLlF6giScVO8m
         yW9FG/1W4uySWu2yLB4/ulbqSlpB+eBOOyCZFGjUq/aPt2WZlnozyX/Z0Xvkjz6UxVR8
         MJbQ==
X-Gm-Message-State: AGi0Pub8Km35QWKUsrp9/6rldz39Dqd3tFhNT9ZuWJWZ+fUDJ6VIUUL+
        pHnqWR/7R0WCJL6zCHZmRfxLHbvYEyKFgrL397evsGZUlPCHYIDPBiwmuuWf4CHQ1gZ92vvZRFN
        I6c9BSBNdOe3GQgkrFJDPWXuQpQ==
X-Received: by 2002:a1c:a9c3:: with SMTP id s186mr13928089wme.89.1588590240243;
        Mon, 04 May 2020 04:04:00 -0700 (PDT)
X-Google-Smtp-Source: APiQypI40Kl2O1Zs9u7xdk4chjTFUgOIeVTTMpFgh5XD+4FOR/YLz9o0UcJ/VIKtHj6/P8ehdEPo3A==
X-Received: by 2002:a1c:a9c3:: with SMTP id s186mr13928039wme.89.1588590239488;
        Mon, 04 May 2020 04:03:59 -0700 (PDT)
Received: from localhost.localdomain.com ([194.230.155.213])
        by smtp.gmail.com with ESMTPSA id a13sm10885750wrv.67.2020.05.04.04.03.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2020 04:03:58 -0700 (PDT)
From:   Emanuele Giuseppe Esposito <eesposit@redhat.com>
To:     kvm@vger.kernel.org
Cc:     Christian Borntraeger <borntraeger@de.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Jim Mattson <jmattson@google.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
        kvm-ppc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Emanuele Giuseppe Esposito <eesposit@redhat.com>
Subject: [PATCH v2 5/5] kvm_main: replace debugfs with stats_fs
Date:   Mon,  4 May 2020 13:03:44 +0200
Message-Id: <20200504110344.17560-6-eesposit@redhat.com>
X-Mailer: git-send-email 2.25.2
In-Reply-To: <20200504110344.17560-1-eesposit@redhat.com>
References: <20200504110344.17560-1-eesposit@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Use stats_fs API instead of debugfs to create sources and add values.

This also requires to change all architecture files to replace the old
debugfs_entries with stats_fs_vcpu_entries and statsfs_vm_entries.

The files/folders name and organization is kept unchanged, and a symlink
in sys/kernel/debugfs/kvm is left for backward compatibility.

Signed-off-by: Emanuele Giuseppe Esposito <eesposit@redhat.com>
---
 arch/arm64/kvm/Kconfig          |   1 +
 arch/arm64/kvm/guest.c          |   2 +-
 arch/mips/kvm/Kconfig           |   1 +
 arch/mips/kvm/mips.c            |   2 +-
 arch/powerpc/kvm/Kconfig        |   1 +
 arch/powerpc/kvm/book3s.c       |   6 +-
 arch/powerpc/kvm/booke.c        |   8 +-
 arch/s390/kvm/Kconfig           |   1 +
 arch/s390/kvm/kvm-s390.c        |  16 +-
 arch/x86/include/asm/kvm_host.h |   2 +-
 arch/x86/kvm/Kconfig            |   1 +
 arch/x86/kvm/Makefile           |   2 +-
 arch/x86/kvm/debugfs.c          |  64 -------
 arch/x86/kvm/stats_fs.c         |  56 ++++++
 arch/x86/kvm/x86.c              |   6 +-
 include/linux/kvm_host.h        |  39 +---
 virt/kvm/arm/arm.c              |   2 +-
 virt/kvm/kvm_main.c             | 314 ++++----------------------------
 18 files changed, 142 insertions(+), 382 deletions(-)
 delete mode 100644 arch/x86/kvm/debugfs.c
 create mode 100644 arch/x86/kvm/stats_fs.c

diff --git a/arch/arm64/kvm/Kconfig b/arch/arm64/kvm/Kconfig
index 449386d76441..8c125387b673 100644
--- a/arch/arm64/kvm/Kconfig
+++ b/arch/arm64/kvm/Kconfig
@@ -23,6 +23,7 @@ config KVM
 	depends on OF
 	# for TASKSTATS/TASK_DELAY_ACCT:
 	depends on NET && MULTIUSER
+	imply STATS_FS
 	select MMU_NOTIFIER
 	select PREEMPT_NOTIFIERS
 	select HAVE_KVM_CPU_RELAX_INTERCEPT
diff --git a/arch/arm64/kvm/guest.c b/arch/arm64/kvm/guest.c
index 8417b200bec9..235ed44e4353 100644
--- a/arch/arm64/kvm/guest.c
+++ b/arch/arm64/kvm/guest.c
@@ -29,7 +29,7 @@
 
 #include "trace.h"
 
-struct kvm_stats_debugfs_item debugfs_entries[] = {
+struct stats_fs_value stats_fs_vcpu_entries[] = {
 	VCPU_STAT("halt_successful_poll", halt_successful_poll),
 	VCPU_STAT("halt_attempted_poll", halt_attempted_poll),
 	VCPU_STAT("halt_poll_invalid", halt_poll_invalid),
diff --git a/arch/mips/kvm/Kconfig b/arch/mips/kvm/Kconfig
index b91d145aa2d5..19d14e979e5f 100644
--- a/arch/mips/kvm/Kconfig
+++ b/arch/mips/kvm/Kconfig
@@ -19,6 +19,7 @@ config KVM
 	tristate "Kernel-based Virtual Machine (KVM) support"
 	depends on HAVE_KVM
 	depends on MIPS_FP_SUPPORT
+	imply STATS_FS
 	select EXPORT_UASM
 	select PREEMPT_NOTIFIERS
 	select KVM_GENERIC_DIRTYLOG_READ_PROTECT
diff --git a/arch/mips/kvm/mips.c b/arch/mips/kvm/mips.c
index fdf1c14d9205..a47d21f35444 100644
--- a/arch/mips/kvm/mips.c
+++ b/arch/mips/kvm/mips.c
@@ -39,7 +39,7 @@
 #define VECTORSPACING 0x100	/* for EI/VI mode */
 #endif
 
-struct kvm_stats_debugfs_item debugfs_entries[] = {
+struct stats_fs_value stats_fs_vcpu_entries[] = {
 	VCPU_STAT("wait", wait_exits),
 	VCPU_STAT("cache", cache_exits),
 	VCPU_STAT("signal", signal_exits),
diff --git a/arch/powerpc/kvm/Kconfig b/arch/powerpc/kvm/Kconfig
index 12885eda324e..feb5e110ebb0 100644
--- a/arch/powerpc/kvm/Kconfig
+++ b/arch/powerpc/kvm/Kconfig
@@ -19,6 +19,7 @@ if VIRTUALIZATION
 
 config KVM
 	bool
+	imply STATS_FS
 	select PREEMPT_NOTIFIERS
 	select HAVE_KVM_EVENTFD
 	select HAVE_KVM_VCPU_ASYNC_IOCTL
diff --git a/arch/powerpc/kvm/book3s.c b/arch/powerpc/kvm/book3s.c
index 37508a356f28..76222ab148da 100644
--- a/arch/powerpc/kvm/book3s.c
+++ b/arch/powerpc/kvm/book3s.c
@@ -38,7 +38,7 @@
 
 /* #define EXIT_DEBUG */
 
-struct kvm_stats_debugfs_item debugfs_entries[] = {
+struct stats_fs_value stats_fs_vcpu_entries[] = {
 	VCPU_STAT("exits", sum_exits),
 	VCPU_STAT("mmio", mmio_exits),
 	VCPU_STAT("sig", signal_exits),
@@ -66,6 +66,10 @@ struct kvm_stats_debugfs_item debugfs_entries[] = {
 	VCPU_STAT("pthru_all", pthru_all),
 	VCPU_STAT("pthru_host", pthru_host),
 	VCPU_STAT("pthru_bad_aff", pthru_bad_aff),
+	{ NULL }
+};
+
+struct stats_fs_value stats_fs_vm_entries[] = {
 	VM_STAT("largepages_2M", num_2M_pages, .mode = 0444),
 	VM_STAT("largepages_1G", num_1G_pages, .mode = 0444),
 	{ NULL }
diff --git a/arch/powerpc/kvm/booke.c b/arch/powerpc/kvm/booke.c
index c2984cb6dfa7..b14c07786cc8 100644
--- a/arch/powerpc/kvm/booke.c
+++ b/arch/powerpc/kvm/booke.c
@@ -35,7 +35,12 @@
 
 unsigned long kvmppc_booke_handlers;
 
-struct kvm_stats_debugfs_item debugfs_entries[] = {
+struct stats_fs_value stats_fs_vm_entries[] = {
+	VM_STAT("remote_tlb_flush", remote_tlb_flush),
+	{ NULL }
+};
+
+struct stats_fs_value stats_fs_vcpu_entries[] = {
 	VCPU_STAT("mmio", mmio_exits),
 	VCPU_STAT("sig", signal_exits),
 	VCPU_STAT("itlb_r", itlb_real_miss_exits),
@@ -54,7 +59,6 @@ struct kvm_stats_debugfs_item debugfs_entries[] = {
 	VCPU_STAT("halt_wakeup", halt_wakeup),
 	VCPU_STAT("doorbell", dbell_exits),
 	VCPU_STAT("guest doorbell", gdbell_exits),
-	VM_STAT("remote_tlb_flush", remote_tlb_flush),
 	{ NULL }
 };
 
diff --git a/arch/s390/kvm/Kconfig b/arch/s390/kvm/Kconfig
index def3b60f1fe8..4e912ffcde78 100644
--- a/arch/s390/kvm/Kconfig
+++ b/arch/s390/kvm/Kconfig
@@ -20,6 +20,7 @@ config KVM
 	def_tristate y
 	prompt "Kernel-based Virtual Machine (KVM) support"
 	depends on HAVE_KVM
+	imply STATS_FS
 	select PREEMPT_NOTIFIERS
 	select HAVE_KVM_CPU_RELAX_INTERCEPT
 	select HAVE_KVM_VCPU_ASYNC_IOCTL
diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index dbeb7da07f18..f2f090b78529 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -57,7 +57,16 @@
 #define VCPU_IRQS_MAX_BUF (sizeof(struct kvm_s390_irq) * \
 			   (KVM_MAX_VCPUS + LOCAL_IRQS))
 
-struct kvm_stats_debugfs_item debugfs_entries[] = {
+struct stats_fs_value stats_fs_vm_entries[] = {
+	VM_STAT("inject_float_mchk", inject_float_mchk),
+	VM_STAT("inject_io", inject_io),
+	VM_STAT("inject_pfault_done", inject_pfault_done),
+	VM_STAT("inject_service_signal", inject_service_signal),
+	VM_STAT("inject_virtio", inject_virtio),
+	{ NULL }
+};
+
+struct stats_fs_value stats_fs_vcpu_entries[] = {
 	VCPU_STAT("userspace_handled", exit_userspace),
 	VCPU_STAT("exit_null", exit_null),
 	VCPU_STAT("exit_validity", exit_validity),
@@ -95,18 +104,13 @@ struct kvm_stats_debugfs_item debugfs_entries[] = {
 	VCPU_STAT("inject_ckc", inject_ckc),
 	VCPU_STAT("inject_cputm", inject_cputm),
 	VCPU_STAT("inject_external_call", inject_external_call),
-	VM_STAT("inject_float_mchk", inject_float_mchk),
 	VCPU_STAT("inject_emergency_signal", inject_emergency_signal),
-	VM_STAT("inject_io", inject_io),
 	VCPU_STAT("inject_mchk", inject_mchk),
-	VM_STAT("inject_pfault_done", inject_pfault_done),
 	VCPU_STAT("inject_program", inject_program),
 	VCPU_STAT("inject_restart", inject_restart),
-	VM_STAT("inject_service_signal", inject_service_signal),
 	VCPU_STAT("inject_set_prefix", inject_set_prefix),
 	VCPU_STAT("inject_stop_signal", inject_stop_signal),
 	VCPU_STAT("inject_pfault_init", inject_pfault_init),
-	VM_STAT("inject_virtio", inject_virtio),
 	VCPU_STAT("instruction_epsw", instruction_epsw),
 	VCPU_STAT("instruction_gs", instruction_gs),
 	VCPU_STAT("instruction_io_other", instruction_io_other),
diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 42a2d0d3984a..6a04f590963f 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -35,7 +35,7 @@
 #include <asm/kvm_vcpu_regs.h>
 #include <asm/hyperv-tlfs.h>
 
-#define __KVM_HAVE_ARCH_VCPU_DEBUGFS
+#define __KVM_HAVE_ARCH_VCPU_STATS_FS
 
 #define KVM_MAX_VCPUS 288
 #define KVM_SOFT_MAX_VCPUS 240
diff --git a/arch/x86/kvm/Kconfig b/arch/x86/kvm/Kconfig
index d8154e0684b6..834b8f4790a7 100644
--- a/arch/x86/kvm/Kconfig
+++ b/arch/x86/kvm/Kconfig
@@ -25,6 +25,7 @@ config KVM
 	# for TASKSTATS/TASK_DELAY_ACCT:
 	depends on NET && MULTIUSER
 	depends on X86_LOCAL_APIC
+	imply STATS_FS
 	select PREEMPT_NOTIFIERS
 	select MMU_NOTIFIER
 	select HAVE_KVM_IRQCHIP
diff --git a/arch/x86/kvm/Makefile b/arch/x86/kvm/Makefile
index a789759b7261..18285a382eba 100644
--- a/arch/x86/kvm/Makefile
+++ b/arch/x86/kvm/Makefile
@@ -11,7 +11,7 @@ kvm-$(CONFIG_KVM_ASYNC_PF)	+= $(KVM)/async_pf.o
 
 kvm-y			+= x86.o emulate.o i8259.o irq.o lapic.o \
 			   i8254.o ioapic.o irq_comm.o cpuid.o pmu.o mtrr.o \
-			   hyperv.o debugfs.o mmu/mmu.o mmu/page_track.o
+			   hyperv.o stats_fs.o mmu/mmu.o mmu/page_track.o
 
 kvm-intel-y		+= vmx/vmx.o vmx/vmenter.o vmx/pmu_intel.o vmx/vmcs12.o vmx/evmcs.o vmx/nested.o
 kvm-amd-y		+= svm/svm.o svm/vmenter.o svm/pmu.o svm/nested.o svm/avic.o svm/sev.o
diff --git a/arch/x86/kvm/debugfs.c b/arch/x86/kvm/debugfs.c
deleted file mode 100644
index 018aebce33ff..000000000000
--- a/arch/x86/kvm/debugfs.c
+++ /dev/null
@@ -1,64 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-/*
- * Kernel-based Virtual Machine driver for Linux
- *
- * Copyright 2016 Red Hat, Inc. and/or its affiliates.
- */
-#include <linux/kvm_host.h>
-#include <linux/debugfs.h>
-#include "lapic.h"
-
-static int vcpu_get_timer_advance_ns(void *data, u64 *val)
-{
-	struct kvm_vcpu *vcpu = (struct kvm_vcpu *) data;
-	*val = vcpu->arch.apic->lapic_timer.timer_advance_ns;
-	return 0;
-}
-
-DEFINE_SIMPLE_ATTRIBUTE(vcpu_timer_advance_ns_fops, vcpu_get_timer_advance_ns, NULL, "%llu\n");
-
-static int vcpu_get_tsc_offset(void *data, u64 *val)
-{
-	struct kvm_vcpu *vcpu = (struct kvm_vcpu *) data;
-	*val = vcpu->arch.tsc_offset;
-	return 0;
-}
-
-DEFINE_SIMPLE_ATTRIBUTE(vcpu_tsc_offset_fops, vcpu_get_tsc_offset, NULL, "%lld\n");
-
-static int vcpu_get_tsc_scaling_ratio(void *data, u64 *val)
-{
-	struct kvm_vcpu *vcpu = (struct kvm_vcpu *) data;
-	*val = vcpu->arch.tsc_scaling_ratio;
-	return 0;
-}
-
-DEFINE_SIMPLE_ATTRIBUTE(vcpu_tsc_scaling_fops, vcpu_get_tsc_scaling_ratio, NULL, "%llu\n");
-
-static int vcpu_get_tsc_scaling_frac_bits(void *data, u64 *val)
-{
-	*val = kvm_tsc_scaling_ratio_frac_bits;
-	return 0;
-}
-
-DEFINE_SIMPLE_ATTRIBUTE(vcpu_tsc_scaling_frac_fops, vcpu_get_tsc_scaling_frac_bits, NULL, "%llu\n");
-
-void kvm_arch_create_vcpu_debugfs(struct kvm_vcpu *vcpu)
-{
-	debugfs_create_file("tsc-offset", 0444, vcpu->debugfs_dentry, vcpu,
-			    &vcpu_tsc_offset_fops);
-
-	if (lapic_in_kernel(vcpu))
-		debugfs_create_file("lapic_timer_advance_ns", 0444,
-				    vcpu->debugfs_dentry, vcpu,
-				    &vcpu_timer_advance_ns_fops);
-
-	if (kvm_has_tsc_control) {
-		debugfs_create_file("tsc-scaling-ratio", 0444,
-				    vcpu->debugfs_dentry, vcpu,
-				    &vcpu_tsc_scaling_fops);
-		debugfs_create_file("tsc-scaling-ratio-frac-bits", 0444,
-				    vcpu->debugfs_dentry, vcpu,
-				    &vcpu_tsc_scaling_frac_fops);
-	}
-}
diff --git a/arch/x86/kvm/stats_fs.c b/arch/x86/kvm/stats_fs.c
new file mode 100644
index 000000000000..f2ac6ed8b01b
--- /dev/null
+++ b/arch/x86/kvm/stats_fs.c
@@ -0,0 +1,56 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Kernel-based Virtual Machine driver for Linux
+ *
+ * Copyright 2016 Red Hat, Inc. and/or its affiliates.
+ */
+#include <linux/kvm_host.h>
+#include <linux/stats_fs.h>
+#include "lapic.h"
+
+#define VCPU_ARCH_STATS_FS(n, s, x, ...)					\
+			{ n, offsetof(struct s, x), .aggr_kind = STATS_FS_SUM,	\
+			  ##__VA_ARGS__ }
+
+struct stats_fs_value stats_fs_vcpu_tsc_offset[] = {
+	VCPU_ARCH_STATS_FS("tsc-offset", kvm_vcpu_arch, tsc_offset,
+			   .type = STATS_FS_S64, .mode = 0444),
+	{ NULL }
+};
+
+struct stats_fs_value stats_fs_vcpu_arch_lapic_timer[] = {
+	VCPU_ARCH_STATS_FS("lapic_timer_advance_ns", kvm_timer, timer_advance_ns,
+			   .type = STATS_FS_U64, .mode = 0444),
+	{ NULL }
+};
+
+struct stats_fs_value stats_fs_vcpu_arch_tsc_ratio[] = {
+	VCPU_ARCH_STATS_FS("tsc-scaling-ratio", kvm_vcpu_arch, tsc_scaling_ratio,
+			   .type = STATS_FS_U64, .mode = 0444),
+	{ NULL }
+};
+
+struct stats_fs_value stats_fs_vcpu_arch_tsc_frac[] = {
+	{ "tsc-scaling-ratio-frac-bits", 0, .type = STATS_FS_U64, .mode = 0444 },
+	{ NULL } /* base is &kvm_tsc_scaling_ratio_frac_bits */
+};
+
+void kvm_arch_create_vcpu_stats_fs(struct kvm_vcpu *vcpu)
+{
+	stats_fs_source_add_values(vcpu->stats_fs_src, stats_fs_vcpu_tsc_offset,
+				   &vcpu->arch);
+
+	if (lapic_in_kernel(vcpu))
+		stats_fs_source_add_values(vcpu->stats_fs_src,
+					   stats_fs_vcpu_arch_lapic_timer,
+					   &vcpu->arch.apic->lapic_timer);
+
+	if (kvm_has_tsc_control) {
+		stats_fs_source_add_values(vcpu->stats_fs_src,
+					   stats_fs_vcpu_arch_tsc_ratio,
+					   &vcpu->arch);
+		stats_fs_source_add_values(vcpu->stats_fs_src,
+					   stats_fs_vcpu_arch_tsc_frac,
+					   &kvm_tsc_scaling_ratio_frac_bits);
+	}
+}
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 35723dafedeb..01fed7ac2e49 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -190,7 +190,7 @@ static u64 __read_mostly host_xss;
 u64 __read_mostly supported_xss;
 EXPORT_SYMBOL_GPL(supported_xss);
 
-struct kvm_stats_debugfs_item debugfs_entries[] = {
+struct stats_fs_value stats_fs_vcpu_entries[] = {
 	VCPU_STAT("pf_fixed", pf_fixed),
 	VCPU_STAT("pf_guest", pf_guest),
 	VCPU_STAT("tlb_flush", tlb_flush),
@@ -217,6 +217,10 @@ struct kvm_stats_debugfs_item debugfs_entries[] = {
 	VCPU_STAT("nmi_injections", nmi_injections),
 	VCPU_STAT("req_event", req_event),
 	VCPU_STAT("l1d_flush", l1d_flush),
+	{ NULL }
+};
+
+struct stats_fs_value stats_fs_vm_entries[] = {
 	VM_STAT("mmu_shadow_zapped", mmu_shadow_zapped),
 	VM_STAT("mmu_pte_write", mmu_pte_write),
 	VM_STAT("mmu_pte_updated", mmu_pte_updated),
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 3845f857ef7b..1282799aa46e 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -27,6 +27,7 @@
 #include <linux/refcount.h>
 #include <linux/nospec.h>
 #include <asm/signal.h>
+#include <linux/stats_fs.h>
 
 #include <linux/kvm.h>
 #include <linux/kvm_para.h>
@@ -318,7 +319,7 @@ struct kvm_vcpu {
 	bool preempted;
 	bool ready;
 	struct kvm_vcpu_arch arch;
-	struct dentry *debugfs_dentry;
+	struct stats_fs_source *stats_fs_src;
 };
 
 static inline int kvm_vcpu_exiting_guest_mode(struct kvm_vcpu *vcpu)
@@ -498,8 +499,7 @@ struct kvm {
 	long tlbs_dirty;
 	struct list_head devices;
 	u64 manual_dirty_log_protect;
-	struct dentry *debugfs_dentry;
-	struct kvm_stat_data **debugfs_stat_data;
+	struct stats_fs_source *stats_fs_src;
 	struct srcu_struct srcu;
 	struct srcu_struct irq_srcu;
 	pid_t userspace_pid;
@@ -880,8 +880,8 @@ int kvm_arch_vcpu_create(struct kvm_vcpu *vcpu);
 void kvm_arch_vcpu_postcreate(struct kvm_vcpu *vcpu);
 void kvm_arch_vcpu_destroy(struct kvm_vcpu *vcpu);
 
-#ifdef __KVM_HAVE_ARCH_VCPU_DEBUGFS
-void kvm_arch_create_vcpu_debugfs(struct kvm_vcpu *vcpu);
+#ifdef __KVM_HAVE_ARCH_VCPU_STATS_FS
+void kvm_arch_create_vcpu_stats_fs(struct kvm_vcpu *vcpu);
 #endif
 
 int kvm_arch_hardware_enable(void);
@@ -1110,33 +1110,14 @@ static inline bool kvm_is_error_gpa(struct kvm *kvm, gpa_t gpa)
 	return kvm_is_error_hva(hva);
 }
 
-enum kvm_stat_kind {
-	KVM_STAT_VM,
-	KVM_STAT_VCPU,
-};
-
-struct kvm_stat_data {
-	struct kvm *kvm;
-	struct kvm_stats_debugfs_item *dbgfs_item;
-};
-
-struct kvm_stats_debugfs_item {
-	const char *name;
-	int offset;
-	enum kvm_stat_kind kind;
-	int mode;
-};
-
-#define KVM_DBGFS_GET_MODE(dbgfs_item)                                         \
-	((dbgfs_item)->mode ? (dbgfs_item)->mode : 0644)
-
 #define VM_STAT(n, x, ...) 													\
-	{ n, offsetof(struct kvm, stat.x), KVM_STAT_VM, ## __VA_ARGS__ }
+	{ n, offsetof(struct kvm, stat.x), STATS_FS_U64, STATS_FS_SUM, ## __VA_ARGS__ }
 #define VCPU_STAT(n, x, ...)												\
-	{ n, offsetof(struct kvm_vcpu, stat.x), KVM_STAT_VCPU, ## __VA_ARGS__ }
+	{ n, offsetof(struct kvm_vcpu, stat.x), STATS_FS_U64, STATS_FS_SUM, ## __VA_ARGS__ }
 
-extern struct kvm_stats_debugfs_item debugfs_entries[];
-extern struct dentry *kvm_debugfs_dir;
+extern struct stats_fs_value stats_fs_vcpu_entries[];
+extern struct stats_fs_value stats_fs_vm_entries[];
+extern struct stats_fs_source *kvm_stats_fs_dir;
 
 #if defined(CONFIG_MMU_NOTIFIER) && defined(KVM_ARCH_WANT_MMU_NOTIFIER)
 static inline int mmu_notifier_retry(struct kvm *kvm, unsigned long mmu_seq)
diff --git a/virt/kvm/arm/arm.c b/virt/kvm/arm/arm.c
index 48d0ec44ad77..4171f92fa473 100644
--- a/virt/kvm/arm/arm.c
+++ b/virt/kvm/arm/arm.c
@@ -140,7 +140,7 @@ int kvm_arch_init_vm(struct kvm *kvm, unsigned long type)
 	return ret;
 }
 
-int kvm_arch_create_vcpu_debugfs(struct kvm_vcpu *vcpu)
+int kvm_arch_create_vcpu_stats_fs(struct kvm_vcpu *vcpu)
 {
 	return 0;
 }
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 74bdb7bf3295..093150125bc2 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -25,6 +25,7 @@
 #include <linux/vmalloc.h>
 #include <linux/reboot.h>
 #include <linux/debugfs.h>
+#include <linux/stats_fs.h>
 #include <linux/highmem.h>
 #include <linux/file.h>
 #include <linux/syscore_ops.h>
@@ -109,11 +110,8 @@ static struct kmem_cache *kvm_vcpu_cache;
 static __read_mostly struct preempt_ops kvm_preempt_ops;
 static DEFINE_PER_CPU(struct kvm_vcpu *, kvm_running_vcpu);
 
-struct dentry *kvm_debugfs_dir;
-EXPORT_SYMBOL_GPL(kvm_debugfs_dir);
-
-static int kvm_debugfs_num_entries;
-static const struct file_operations stat_fops_per_vm;
+struct stats_fs_source *kvm_stats_fs_dir;
+EXPORT_SYMBOL_GPL(kvm_stats_fs_dir);
 
 static long kvm_vcpu_ioctl(struct file *file, unsigned int ioctl,
 			   unsigned long arg);
@@ -356,6 +354,8 @@ static void kvm_vcpu_init(struct kvm_vcpu *vcpu, struct kvm *kvm, unsigned id)
 
 void kvm_vcpu_destroy(struct kvm_vcpu *vcpu)
 {
+	stats_fs_source_revoke(vcpu->stats_fs_src);
+	stats_fs_source_put(vcpu->stats_fs_src);
 	kvm_arch_vcpu_destroy(vcpu);
 
 	/*
@@ -601,52 +601,27 @@ static void kvm_free_memslots(struct kvm *kvm, struct kvm_memslots *slots)
 	kvfree(slots);
 }
 
-static void kvm_destroy_vm_debugfs(struct kvm *kvm)
+static void kvm_destroy_vm_stats_fs(struct kvm *kvm)
 {
-	int i;
-
-	if (!kvm->debugfs_dentry)
-		return;
-
-	debugfs_remove_recursive(kvm->debugfs_dentry);
-
-	if (kvm->debugfs_stat_data) {
-		for (i = 0; i < kvm_debugfs_num_entries; i++)
-			kfree(kvm->debugfs_stat_data[i]);
-		kfree(kvm->debugfs_stat_data);
-	}
+	stats_fs_source_remove_subordinate(kvm_stats_fs_dir, kvm->stats_fs_src);
+	stats_fs_source_revoke(kvm->stats_fs_src);
+	stats_fs_source_put(kvm->stats_fs_src);
 }
 
-static int kvm_create_vm_debugfs(struct kvm *kvm, int fd)
+static int kvm_create_vm_stats_fs(struct kvm *kvm, int fd)
 {
 	char dir_name[ITOA_MAX_LEN * 2];
-	struct kvm_stat_data *stat_data;
-	struct kvm_stats_debugfs_item *p;
 
-	if (!debugfs_initialized())
+	if (!stats_fs_initialized())
 		return 0;
 
 	snprintf(dir_name, sizeof(dir_name), "%d-%d", task_pid_nr(current), fd);
-	kvm->debugfs_dentry = debugfs_create_dir(dir_name, kvm_debugfs_dir);
+	kvm->stats_fs_src = stats_fs_source_create(dir_name);
+	stats_fs_source_add_subordinate(kvm_stats_fs_dir, kvm->stats_fs_src);
 
-	kvm->debugfs_stat_data = kcalloc(kvm_debugfs_num_entries,
-					 sizeof(*kvm->debugfs_stat_data),
-					 GFP_KERNEL_ACCOUNT);
-	if (!kvm->debugfs_stat_data)
-		return -ENOMEM;
+	stats_fs_source_add_values(kvm->stats_fs_src, stats_fs_vm_entries, kvm);
 
-	for (p = debugfs_entries; p->name; p++) {
-		stat_data = kzalloc(sizeof(*stat_data), GFP_KERNEL_ACCOUNT);
-		if (!stat_data)
-			return -ENOMEM;
-
-		stat_data->kvm = kvm;
-		stat_data->dbgfs_item = p;
-		kvm->debugfs_stat_data[p - debugfs_entries] = stat_data;
-		debugfs_create_file(p->name, KVM_DBGFS_GET_MODE(p),
-				    kvm->debugfs_dentry, stat_data,
-				    &stat_fops_per_vm);
-	}
+	stats_fs_source_add_values(kvm->stats_fs_src, stats_fs_vcpu_entries, NULL);
 	return 0;
 }
 
@@ -783,7 +758,7 @@ static void kvm_destroy_vm(struct kvm *kvm)
 	struct mm_struct *mm = kvm->mm;
 
 	kvm_uevent_notify_change(KVM_EVENT_DESTROY_VM, kvm);
-	kvm_destroy_vm_debugfs(kvm);
+	kvm_destroy_vm_stats_fs(kvm);
 	kvm_arch_sync_events(kvm);
 	mutex_lock(&kvm_lock);
 	list_del(&kvm->vm_list);
@@ -2946,7 +2921,6 @@ static int kvm_vcpu_release(struct inode *inode, struct file *filp)
 {
 	struct kvm_vcpu *vcpu = filp->private_data;
 
-	debugfs_remove_recursive(vcpu->debugfs_dentry);
 	kvm_put_kvm(vcpu->kvm);
 	return 0;
 }
@@ -2970,19 +2944,22 @@ static int create_vcpu_fd(struct kvm_vcpu *vcpu)
 	return anon_inode_getfd(name, &kvm_vcpu_fops, vcpu, O_RDWR | O_CLOEXEC);
 }
 
-static void kvm_create_vcpu_debugfs(struct kvm_vcpu *vcpu)
+static void kvm_create_vcpu_stats_fs(struct kvm_vcpu *vcpu)
 {
-#ifdef __KVM_HAVE_ARCH_VCPU_DEBUGFS
 	char dir_name[ITOA_MAX_LEN * 2];
 
-	if (!debugfs_initialized())
+	if (!stats_fs_initialized())
 		return;
 
 	snprintf(dir_name, sizeof(dir_name), "vcpu%d", vcpu->vcpu_id);
-	vcpu->debugfs_dentry = debugfs_create_dir(dir_name,
-						  vcpu->kvm->debugfs_dentry);
 
-	kvm_arch_create_vcpu_debugfs(vcpu);
+	vcpu->stats_fs_src = stats_fs_source_create(dir_name);
+	stats_fs_source_add_subordinate(vcpu->kvm->stats_fs_src, vcpu->stats_fs_src);
+
+	stats_fs_source_add_values(vcpu->stats_fs_src, stats_fs_vcpu_entries, vcpu);
+
+#ifdef __KVM_HAVE_ARCH_VCPU_STATS_FS
+	kvm_arch_create_vcpu_stats_fs(vcpu);
 #endif
 }
 
@@ -3031,8 +3008,6 @@ static int kvm_vm_ioctl_create_vcpu(struct kvm *kvm, u32 id)
 	if (r)
 		goto vcpu_free_run_page;
 
-	kvm_create_vcpu_debugfs(vcpu);
-
 	mutex_lock(&kvm->lock);
 	if (kvm_get_vcpu_by_id(kvm, id)) {
 		r = -EEXIST;
@@ -3061,11 +3036,11 @@ static int kvm_vm_ioctl_create_vcpu(struct kvm *kvm, u32 id)
 
 	mutex_unlock(&kvm->lock);
 	kvm_arch_vcpu_postcreate(vcpu);
+	kvm_create_vcpu_stats_fs(vcpu);
 	return r;
 
 unlock_vcpu_destroy:
 	mutex_unlock(&kvm->lock);
-	debugfs_remove_recursive(vcpu->debugfs_dentry);
 	kvm_arch_vcpu_destroy(vcpu);
 vcpu_free_run_page:
 	free_page((unsigned long)vcpu->run);
@@ -3839,7 +3814,7 @@ static int kvm_dev_ioctl_create_vm(unsigned long type)
 	 * cases it will be called by the final fput(file) and will take
 	 * care of doing kvm_put_kvm(kvm).
 	 */
-	if (kvm_create_vm_debugfs(kvm, r) < 0) {
+	if (kvm_create_vm_stats_fs(kvm, r) < 0) {
 		put_unused_fd(r);
 		fput(file);
 		return -ENOMEM;
@@ -4295,214 +4270,6 @@ struct kvm_io_device *kvm_io_bus_get_dev(struct kvm *kvm, enum kvm_bus bus_idx,
 }
 EXPORT_SYMBOL_GPL(kvm_io_bus_get_dev);
 
-static int kvm_debugfs_open(struct inode *inode, struct file *file,
-			   int (*get)(void *, u64 *), int (*set)(void *, u64),
-			   const char *fmt)
-{
-	struct kvm_stat_data *stat_data = (struct kvm_stat_data *)
-					  inode->i_private;
-
-	/* The debugfs files are a reference to the kvm struct which
-	 * is still valid when kvm_destroy_vm is called.
-	 * To avoid the race between open and the removal of the debugfs
-	 * directory we test against the users count.
-	 */
-	if (!refcount_inc_not_zero(&stat_data->kvm->users_count))
-		return -ENOENT;
-
-	if (simple_attr_open(inode, file, get,
-		    KVM_DBGFS_GET_MODE(stat_data->dbgfs_item) & 0222
-		    ? set : NULL,
-		    fmt)) {
-		kvm_put_kvm(stat_data->kvm);
-		return -ENOMEM;
-	}
-
-	return 0;
-}
-
-static int kvm_debugfs_release(struct inode *inode, struct file *file)
-{
-	struct kvm_stat_data *stat_data = (struct kvm_stat_data *)
-					  inode->i_private;
-
-	simple_attr_release(inode, file);
-	kvm_put_kvm(stat_data->kvm);
-
-	return 0;
-}
-
-static int kvm_get_stat_per_vm(struct kvm *kvm, size_t offset, u64 *val)
-{
-	*val = *(ulong *)((void *)kvm + offset);
-
-	return 0;
-}
-
-static int kvm_clear_stat_per_vm(struct kvm *kvm, size_t offset)
-{
-	*(ulong *)((void *)kvm + offset) = 0;
-
-	return 0;
-}
-
-static int kvm_get_stat_per_vcpu(struct kvm *kvm, size_t offset, u64 *val)
-{
-	int i;
-	struct kvm_vcpu *vcpu;
-
-	*val = 0;
-
-	kvm_for_each_vcpu(i, vcpu, kvm)
-		*val += *(u64 *)((void *)vcpu + offset);
-
-	return 0;
-}
-
-static int kvm_clear_stat_per_vcpu(struct kvm *kvm, size_t offset)
-{
-	int i;
-	struct kvm_vcpu *vcpu;
-
-	kvm_for_each_vcpu(i, vcpu, kvm)
-		*(u64 *)((void *)vcpu + offset) = 0;
-
-	return 0;
-}
-
-static int kvm_stat_data_get(void *data, u64 *val)
-{
-	int r = -EFAULT;
-	struct kvm_stat_data *stat_data = (struct kvm_stat_data *)data;
-
-	switch (stat_data->dbgfs_item->kind) {
-	case KVM_STAT_VM:
-		r = kvm_get_stat_per_vm(stat_data->kvm,
-					stat_data->dbgfs_item->offset, val);
-		break;
-	case KVM_STAT_VCPU:
-		r = kvm_get_stat_per_vcpu(stat_data->kvm,
-					  stat_data->dbgfs_item->offset, val);
-		break;
-	}
-
-	return r;
-}
-
-static int kvm_stat_data_clear(void *data, u64 val)
-{
-	int r = -EFAULT;
-	struct kvm_stat_data *stat_data = (struct kvm_stat_data *)data;
-
-	if (val)
-		return -EINVAL;
-
-	switch (stat_data->dbgfs_item->kind) {
-	case KVM_STAT_VM:
-		r = kvm_clear_stat_per_vm(stat_data->kvm,
-					  stat_data->dbgfs_item->offset);
-		break;
-	case KVM_STAT_VCPU:
-		r = kvm_clear_stat_per_vcpu(stat_data->kvm,
-					    stat_data->dbgfs_item->offset);
-		break;
-	}
-
-	return r;
-}
-
-static int kvm_stat_data_open(struct inode *inode, struct file *file)
-{
-	__simple_attr_check_format("%llu\n", 0ull);
-	return kvm_debugfs_open(inode, file, kvm_stat_data_get,
-				kvm_stat_data_clear, "%llu\n");
-}
-
-static const struct file_operations stat_fops_per_vm = {
-	.owner = THIS_MODULE,
-	.open = kvm_stat_data_open,
-	.release = kvm_debugfs_release,
-	.read = simple_attr_read,
-	.write = simple_attr_write,
-	.llseek = no_llseek,
-};
-
-static int vm_stat_get(void *_offset, u64 *val)
-{
-	unsigned offset = (long)_offset;
-	struct kvm *kvm;
-	u64 tmp_val;
-
-	*val = 0;
-	mutex_lock(&kvm_lock);
-	list_for_each_entry(kvm, &vm_list, vm_list) {
-		kvm_get_stat_per_vm(kvm, offset, &tmp_val);
-		*val += tmp_val;
-	}
-	mutex_unlock(&kvm_lock);
-	return 0;
-}
-
-static int vm_stat_clear(void *_offset, u64 val)
-{
-	unsigned offset = (long)_offset;
-	struct kvm *kvm;
-
-	if (val)
-		return -EINVAL;
-
-	mutex_lock(&kvm_lock);
-	list_for_each_entry(kvm, &vm_list, vm_list) {
-		kvm_clear_stat_per_vm(kvm, offset);
-	}
-	mutex_unlock(&kvm_lock);
-
-	return 0;
-}
-
-DEFINE_SIMPLE_ATTRIBUTE(vm_stat_fops, vm_stat_get, vm_stat_clear, "%llu\n");
-
-static int vcpu_stat_get(void *_offset, u64 *val)
-{
-	unsigned offset = (long)_offset;
-	struct kvm *kvm;
-	u64 tmp_val;
-
-	*val = 0;
-	mutex_lock(&kvm_lock);
-	list_for_each_entry(kvm, &vm_list, vm_list) {
-		kvm_get_stat_per_vcpu(kvm, offset, &tmp_val);
-		*val += tmp_val;
-	}
-	mutex_unlock(&kvm_lock);
-	return 0;
-}
-
-static int vcpu_stat_clear(void *_offset, u64 val)
-{
-	unsigned offset = (long)_offset;
-	struct kvm *kvm;
-
-	if (val)
-		return -EINVAL;
-
-	mutex_lock(&kvm_lock);
-	list_for_each_entry(kvm, &vm_list, vm_list) {
-		kvm_clear_stat_per_vcpu(kvm, offset);
-	}
-	mutex_unlock(&kvm_lock);
-
-	return 0;
-}
-
-DEFINE_SIMPLE_ATTRIBUTE(vcpu_stat_fops, vcpu_stat_get, vcpu_stat_clear,
-			"%llu\n");
-
-static const struct file_operations *stat_fops[] = {
-	[KVM_STAT_VCPU] = &vcpu_stat_fops,
-	[KVM_STAT_VM]   = &vm_stat_fops,
-};
-
 static void kvm_uevent_notify_change(unsigned int type, struct kvm *kvm)
 {
 	struct kobj_uevent_env *env;
@@ -4537,34 +4304,32 @@ static void kvm_uevent_notify_change(unsigned int type, struct kvm *kvm)
 	}
 	add_uevent_var(env, "PID=%d", kvm->userspace_pid);
 
-	if (!IS_ERR_OR_NULL(kvm->debugfs_dentry)) {
+	if (!IS_ERR_OR_NULL(kvm->stats_fs_src->source_dentry)) {
 		char *tmp, *p = kmalloc(PATH_MAX, GFP_KERNEL_ACCOUNT);
 
 		if (p) {
-			tmp = dentry_path_raw(kvm->debugfs_dentry, p, PATH_MAX);
+			tmp = dentry_path_raw(kvm->stats_fs_src->source_dentry, p, PATH_MAX);
 			if (!IS_ERR(tmp))
 				add_uevent_var(env, "STATS_PATH=%s", tmp);
 			kfree(p);
 		}
 	}
+
 	/* no need for checks, since we are adding at most only 5 keys */
 	env->envp[env->envp_idx++] = NULL;
 	kobject_uevent_env(&kvm_dev.this_device->kobj, KOBJ_CHANGE, env->envp);
 	kfree(env);
 }
 
-static void kvm_init_debug(void)
+static void kvm_init_stats_fs(void)
 {
-	struct kvm_stats_debugfs_item *p;
+	kvm_stats_fs_dir = stats_fs_source_create("kvm");
+	/* symlink to debugfs */
+	debugfs_create_symlink("kvm", NULL, "/sys/kernel/stats_fs/kvm");
+	stats_fs_source_register(kvm_stats_fs_dir);
 
-	kvm_debugfs_dir = debugfs_create_dir("kvm", NULL);
-
-	kvm_debugfs_num_entries = 0;
-	for (p = debugfs_entries; p->name; ++p, kvm_debugfs_num_entries++) {
-		debugfs_create_file(p->name, KVM_DBGFS_GET_MODE(p),
-				    kvm_debugfs_dir, (void *)(long)p->offset,
-				    stat_fops[p->kind]);
-	}
+	stats_fs_source_add_values(kvm_stats_fs_dir, stats_fs_vcpu_entries, NULL);
+	stats_fs_source_add_values(kvm_stats_fs_dir, stats_fs_vm_entries, NULL);
 }
 
 static int kvm_suspend(void)
@@ -4738,7 +4503,7 @@ int kvm_init(void *opaque, unsigned vcpu_size, unsigned vcpu_align,
 	kvm_preempt_ops.sched_in = kvm_sched_in;
 	kvm_preempt_ops.sched_out = kvm_sched_out;
 
-	kvm_init_debug();
+	kvm_init_stats_fs();
 
 	r = kvm_vfio_ops_init();
 	WARN_ON(r);
@@ -4767,7 +4532,8 @@ EXPORT_SYMBOL_GPL(kvm_init);
 
 void kvm_exit(void)
 {
-	debugfs_remove_recursive(kvm_debugfs_dir);
+	stats_fs_source_revoke(kvm_stats_fs_dir);
+	stats_fs_source_put(kvm_stats_fs_dir);
 	misc_deregister(&kvm_dev);
 	kmem_cache_destroy(kvm_vcpu_cache);
 	kvm_async_pf_deinit();
-- 
2.25.2

