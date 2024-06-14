Return-Path: <linux-fsdevel+bounces-21710-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 55975908BA9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Jun 2024 14:29:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5BEBD1C25B17
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Jun 2024 12:29:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0F3B1991B9;
	Fri, 14 Jun 2024 12:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="OCXJ+COK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 273F4198840;
	Fri, 14 Jun 2024 12:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718368162; cv=none; b=VZVV+MZ7ikMaWofyIHwU9gtTVpeEPPfJx7bDhO7AW3sl+73PqK0acPLZPvrChZqgOILdE6xe47c5SVdqS4pOyuqACLSKnBDu3drNtsCwuVvfGu6OhzwdY8DNauZI/2P0D7vNjPQS6up+7Kfom+P+Ou40w8BEd2YFbDWmSESIpGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718368162; c=relaxed/simple;
	bh=cBmpqiI4smYWZBQIHnTdgHbfzxQKIz6BboeBUIk/BBE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lAlldUrUEeOK+pbPjKd/zhw49nF0q3xsRSag2NMNkmU26r2lSGyZm4lziDaDlB/RlVa1HA6nop82mvRTOn68bbonbuw8B+/mdLKUuEzT9qRkLKM5GTlancHqtlDGlLP8x/zw7OA8bRk9d3Hs5vYj4PLKuVOIYnniLTgyqOhVeEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b=OCXJ+COK; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1718368156;
	bh=7O5o/6HkAr/0K4wsEW3vA0ECN5IMlfvMhmIkuXxjohA=;
	h=From:To:Cc:Subject:Date:From;
	b=OCXJ+COKRCZZcN3OHnZ69GN6ZwN/MzaovDVJGHxI2Z0z/Ep+ZZE32twF1yqXY8M4w
	 otnL7hJAJwNkxcykbkSrQKJE0LI/r0WvhiTqoRj8APOWpTfHPnjhirEPxwYPaiA+3b
	 QsCzipD/+ygtbTjEHvS3s7GkhMWAg3tzr65xQxKh9FEt0cBLMNAR45J6ffoAy6P+Jf
	 nHo7NqXMswJirnlEFuCH+cMTP5oMREv3XrA5BCj2b9kzmBFRn6YULce1lcIuNPA6xF
	 JhK5smGOGp1C0gEGB5HHclieK5jRlcXQ+PQMfVTqQeYY9mqSWOq8P3Iy+l+4VE84RP
	 MunDRQHjL3lyA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4W0z9R3h4jz4wcl;
	Fri, 14 Jun 2024 22:29:15 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: <linuxppc-dev@lists.ozlabs.org>
Cc: linux-fsdevel@vger.kernel.org,
	brauner@kernel.org,
	aik@amd.com,
	paulus@samba.org,
	torvalds@linux-foundation.org,
	kvm@vger.kernel.org,
	tpearson@raptorengineering.com,
	sbhat@linux.ibm.com
Subject: [PATCH] KVM: PPC: Book3S HV: Prevent UAF in kvm_spapr_tce_attach_iommu_group()
Date: Fri, 14 Jun 2024 22:29:10 +1000
Message-ID: <20240614122910.3499489-1-mpe@ellerman.id.au>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Al reported a possible use-after-free (UAF) in kvm_spapr_tce_attach_iommu_group().

It looks up `stt` from tablefd, but then continues to use it after doing
fdput() on the returned fd. After the fdput() the tablefd is free to be
closed by another thread. The close calls kvm_spapr_tce_release() and
then release_spapr_tce_table() (via call_rcu()) which frees `stt`.

Although there are calls to rcu_read_lock() in
kvm_spapr_tce_attach_iommu_group() they are not sufficient to prevent
the UAF, because `stt` is used outside the locked regions.

With an artifcial delay after the fdput() and a userspace program which
triggers the race, KASAN detects the UAF:

  BUG: KASAN: slab-use-after-free in kvm_spapr_tce_attach_iommu_group+0x298/0x720 [kvm]
  Read of size 4 at addr c000200027552c30 by task kvm-vfio/2505
  CPU: 54 PID: 2505 Comm: kvm-vfio Not tainted 6.10.0-rc3-next-20240612-dirty #1
  Hardware name: 8335-GTH POWER9 0x4e1202 opal:skiboot-v6.5.3-35-g1851b2a06 PowerNV
  Call Trace:
    dump_stack_lvl+0xb4/0x108 (unreliable)
    print_report+0x2b4/0x6ec
    kasan_report+0x118/0x2b0
    __asan_load4+0xb8/0xd0
    kvm_spapr_tce_attach_iommu_group+0x298/0x720 [kvm]
    kvm_vfio_set_attr+0x524/0xac0 [kvm]
    kvm_device_ioctl+0x144/0x240 [kvm]
    sys_ioctl+0x62c/0x1810
    system_call_exception+0x190/0x440
    system_call_vectored_common+0x15c/0x2ec
  ...
  Freed by task 0:
   ...
   kfree+0xec/0x3e0
   release_spapr_tce_table+0xd4/0x11c [kvm]
   rcu_core+0x568/0x16a0
   handle_softirqs+0x23c/0x920
   do_softirq_own_stack+0x6c/0x90
   do_softirq_own_stack+0x58/0x90
   __irq_exit_rcu+0x218/0x2d0
   irq_exit+0x30/0x80
   arch_local_irq_restore+0x128/0x230
   arch_local_irq_enable+0x1c/0x30
   cpuidle_enter_state+0x134/0x5cc
   cpuidle_enter+0x6c/0xb0
   call_cpuidle+0x7c/0x100
   do_idle+0x394/0x410
   cpu_startup_entry+0x60/0x70
   start_secondary+0x3fc/0x410
   start_secondary_prolog+0x10/0x14

Fix it by delaying the fdput() until `stt` is no longer in use, which
is effectively the entire function. To keep the patch minimal add a call
to fdput() at each of the existing return paths. Future work can convert
the function to goto or __cleanup style cleanup.

With the fix in place the test case no longer triggers the UAF.

Reported-by: Al Viro <viro@zeniv.linux.org.uk>
Closes: https://lore.kernel.org/all/20240610024437.GA1464458@ZenIV/
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/kvm/book3s_64_vio.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

I'll plan to merge this via the powerpc/fixes tree, unless anyone thinks otherwise.

cheers

diff --git a/arch/powerpc/kvm/book3s_64_vio.c b/arch/powerpc/kvm/book3s_64_vio.c
index b569ebaa590e..3ff3de9a52ac 100644
--- a/arch/powerpc/kvm/book3s_64_vio.c
+++ b/arch/powerpc/kvm/book3s_64_vio.c
@@ -130,14 +130,16 @@ long kvm_spapr_tce_attach_iommu_group(struct kvm *kvm, int tablefd,
 	}
 	rcu_read_unlock();
 
-	fdput(f);
-
-	if (!found)
+	if (!found) {
+		fdput(f);
 		return -EINVAL;
+	}
 
 	table_group = iommu_group_get_iommudata(grp);
-	if (WARN_ON(!table_group))
+	if (WARN_ON(!table_group)) {
+		fdput(f);
 		return -EFAULT;
+	}
 
 	for (i = 0; i < IOMMU_TABLE_GROUP_MAX_TABLES; ++i) {
 		struct iommu_table *tbltmp = table_group->tables[i];
@@ -158,8 +160,10 @@ long kvm_spapr_tce_attach_iommu_group(struct kvm *kvm, int tablefd,
 			break;
 		}
 	}
-	if (!tbl)
+	if (!tbl) {
+		fdput(f);
 		return -EINVAL;
+	}
 
 	rcu_read_lock();
 	list_for_each_entry_rcu(stit, &stt->iommu_tables, next) {
@@ -170,6 +174,7 @@ long kvm_spapr_tce_attach_iommu_group(struct kvm *kvm, int tablefd,
 			/* stit is being destroyed */
 			iommu_tce_table_put(tbl);
 			rcu_read_unlock();
+			fdput(f);
 			return -ENOTTY;
 		}
 		/*
@@ -177,6 +182,7 @@ long kvm_spapr_tce_attach_iommu_group(struct kvm *kvm, int tablefd,
 		 * its KVM reference counter and can return.
 		 */
 		rcu_read_unlock();
+		fdput(f);
 		return 0;
 	}
 	rcu_read_unlock();
@@ -184,6 +190,7 @@ long kvm_spapr_tce_attach_iommu_group(struct kvm *kvm, int tablefd,
 	stit = kzalloc(sizeof(*stit), GFP_KERNEL);
 	if (!stit) {
 		iommu_tce_table_put(tbl);
+		fdput(f);
 		return -ENOMEM;
 	}
 
@@ -192,6 +199,7 @@ long kvm_spapr_tce_attach_iommu_group(struct kvm *kvm, int tablefd,
 
 	list_add_rcu(&stit->next, &stt->iommu_tables);
 
+	fdput(f);
 	return 0;
 }
 
-- 
2.45.1


