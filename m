Return-Path: <linux-fsdevel+bounces-3165-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A08DF7F07F4
	for <lists+linux-fsdevel@lfdr.de>; Sun, 19 Nov 2023 18:00:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 30777B209D2
	for <lists+linux-fsdevel@lfdr.de>; Sun, 19 Nov 2023 17:00:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C596A18040;
	Sun, 19 Nov 2023 17:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 913AA1FCC;
	Sun, 19 Nov 2023 08:59:51 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 635671007;
	Sun, 19 Nov 2023 09:00:37 -0800 (PST)
Received: from e121798.cable.virginm.net (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 36E813F6C4;
	Sun, 19 Nov 2023 08:59:46 -0800 (PST)
From: Alexandru Elisei <alexandru.elisei@arm.com>
To: catalin.marinas@arm.com,
	will@kernel.org,
	oliver.upton@linux.dev,
	maz@kernel.org,
	james.morse@arm.com,
	suzuki.poulose@arm.com,
	yuzenghui@huawei.com,
	arnd@arndb.de,
	akpm@linux-foundation.org,
	mingo@redhat.com,
	peterz@infradead.org,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	bristot@redhat.com,
	vschneid@redhat.com,
	mhiramat@kernel.org,
	rppt@kernel.org,
	hughd@google.com
Cc: pcc@google.com,
	steven.price@arm.com,
	anshuman.khandual@arm.com,
	vincenzo.frascino@arm.com,
	david@redhat.com,
	eugenis@google.com,
	kcc@google.com,
	hyesoo.yu@samsung.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	kvmarm@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-arch@vger.kernel.org,
	linux-mm@kvack.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH RFC v2 25/27] KVM: arm64: Disable MTE if tag storage is enabled
Date: Sun, 19 Nov 2023 16:57:19 +0000
Message-Id: <20231119165721.9849-26-alexandru.elisei@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231119165721.9849-1-alexandru.elisei@arm.com>
References: <20231119165721.9849-1-alexandru.elisei@arm.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

KVM allows MTE enabled VMs to be created when the backing VMA does not have
MTE enabled.  Without changes to how KVM allocates memory for a VM, it is
impossible at the moment to discern when the corresponding tag storage
needs to be reserved.

For now, disable MTE in KVM if tag storage is enabled.

Signed-off-by: Alexandru Elisei <alexandru.elisei@arm.com>
---
 arch/arm64/kvm/arm.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
index e5f75f1f1085..5b33c532c62a 100644
--- a/arch/arm64/kvm/arm.c
+++ b/arch/arm64/kvm/arm.c
@@ -29,6 +29,7 @@
 #include <linux/uaccess.h>
 #include <asm/ptrace.h>
 #include <asm/mman.h>
+#include <asm/mte_tag_storage.h>
 #include <asm/tlbflush.h>
 #include <asm/cacheflush.h>
 #include <asm/cpufeature.h>
@@ -86,7 +87,8 @@ int kvm_vm_ioctl_enable_cap(struct kvm *kvm,
 		break;
 	case KVM_CAP_ARM_MTE:
 		mutex_lock(&kvm->lock);
-		if (!system_supports_mte() || kvm->created_vcpus) {
+		if (!system_supports_mte() || tag_storage_enabled() ||
+		    kvm->created_vcpus) {
 			r = -EINVAL;
 		} else {
 			r = 0;
@@ -279,7 +281,7 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
 		r = 1;
 		break;
 	case KVM_CAP_ARM_MTE:
-		r = system_supports_mte();
+		r = system_supports_mte() && !tag_storage_enabled();
 		break;
 	case KVM_CAP_STEAL_TIME:
 		r = kvm_arm_pvtime_supported();
-- 
2.42.1


