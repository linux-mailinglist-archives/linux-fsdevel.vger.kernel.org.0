Return-Path: <linux-fsdevel+bounces-32903-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A354D9B07CE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Oct 2024 17:19:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F9C41F27F89
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Oct 2024 15:19:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1760D21F4C8;
	Fri, 25 Oct 2024 15:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fV8sShoH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A5DC2064EA
	for <linux-fsdevel@vger.kernel.org>; Fri, 25 Oct 2024 15:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729869208; cv=none; b=iLzuPugtMIe7SKbWTz791oWQLrcLQ3Pa7l+3OQlDhUdUiVe5bn7pJHwL9r3qotdVit3qcUmIRhHH2X2/ZFNr5+nWA5OZCIia4OMxFG9wDvGYKlfXILvpMXwmzoCSMLpq1/gTSjW/jxJczROLf9iMFxT9AjcnrcqEpCpG2ZnAevA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729869208; c=relaxed/simple;
	bh=l8Vke+v1qJcY3Kdt2qKC4wrsbTNgJAV880fY1X1hrJ8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uSrpAjSXA1XYG6VowqgaiqwySkRUENkyqv47k4SGN75ebP/mQrHLMulzfpJehNm2TooS2LiA/PpthqZDnWCQeYiHxBTHUCHh8ZuqhE7ShXgTocTYM5URRAuYt5bq9qU+M63vn+VmaPCn/0cAKvhWm3vaCcRbGACrO+o4fURYBmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fV8sShoH; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729869205;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=duV64aDOzPCg70Erai+k0MR4CZFFfLJs/Tny3PQhGqo=;
	b=fV8sShoHgU/jozjRmozK4yNYnpO+0KFeLSxrXxiNi0Tq7LFgTYHcTSUab70sk6SXf7IQf/
	N+DUbsfRAs93j03QFl/JJuF899s2zAhGA4GaNyLSHIbihPcSXZssbJCofyHixmbNST32q6
	4jIivLsqbjxtyYpRGeAdlcHWR/diVOY=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-44-_q3EKHFQNEmGt7K_9EZzAQ-1; Fri,
 25 Oct 2024 11:13:19 -0400
X-MC-Unique: _q3EKHFQNEmGt7K_9EZzAQ-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 750F61956096;
	Fri, 25 Oct 2024 15:13:17 +0000 (UTC)
Received: from t14s.redhat.com (unknown [10.22.65.27])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 27021300018D;
	Fri, 25 Oct 2024 15:13:08 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org,
	linux-s390@vger.kernel.org,
	virtualization@lists.linux.dev,
	kvm@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	kexec@lists.infradead.org,
	David Hildenbrand <david@redhat.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Baoquan He <bhe@redhat.com>,
	Vivek Goyal <vgoyal@redhat.com>,
	Dave Young <dyoung@redhat.com>,
	Thomas Huth <thuth@redhat.com>,
	Cornelia Huck <cohuck@redhat.com>,
	Janosch Frank <frankja@linux.ibm.com>,
	Claudio Imbrenda <imbrenda@linux.ibm.com>,
	Eric Farman <farman@linux.ibm.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v1 11/11] s390/kdump: virtio-mem kdump support (CONFIG_PROC_VMCORE_DEVICE_RAM)
Date: Fri, 25 Oct 2024 17:11:33 +0200
Message-ID: <20241025151134.1275575-12-david@redhat.com>
In-Reply-To: <20241025151134.1275575-1-david@redhat.com>
References: <20241025151134.1275575-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Let's add support for including virtio-mem device RAM in the crash dump,
setting NEED_PROC_VMCORE_DEVICE_RAM, and implementing
elfcorehdr_fill_device_ram_ptload_elf64().

To avoid code duplication, factor out the code to fill a PT_LOAD entry.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 arch/s390/Kconfig             |  1 +
 arch/s390/kernel/crash_dump.c | 39 ++++++++++++++++++++++++++++-------
 2 files changed, 32 insertions(+), 8 deletions(-)

diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
index d339fe4fdedf..d80450d957a9 100644
--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -230,6 +230,7 @@ config S390
 	select MODULES_USE_ELF_RELA
 	select NEED_DMA_MAP_STATE	if PCI
 	select NEED_PER_CPU_EMBED_FIRST_CHUNK
+	select NEED_PROC_VMCORE_DEVICE_RAM if PROC_VMCORE
 	select NEED_SG_DMA_LENGTH	if PCI
 	select OLD_SIGACTION
 	select OLD_SIGSUSPEND3
diff --git a/arch/s390/kernel/crash_dump.c b/arch/s390/kernel/crash_dump.c
index edae13416196..97b9e71b734d 100644
--- a/arch/s390/kernel/crash_dump.c
+++ b/arch/s390/kernel/crash_dump.c
@@ -497,6 +497,19 @@ static int get_mem_chunk_cnt(void)
 	return cnt;
 }
 
+static void fill_ptload(Elf64_Phdr *phdr, unsigned long paddr,
+		unsigned long vaddr, unsigned long size)
+{
+	phdr->p_type = PT_LOAD;
+	phdr->p_vaddr = vaddr;
+	phdr->p_offset = paddr;
+	phdr->p_paddr = paddr;
+	phdr->p_filesz = size;
+	phdr->p_memsz = size;
+	phdr->p_flags = PF_R | PF_W | PF_X;
+	phdr->p_align = PAGE_SIZE;
+}
+
 /*
  * Initialize ELF loads (new kernel)
  */
@@ -509,14 +522,8 @@ static void loads_init(Elf64_Phdr *phdr, bool os_info_has_vm)
 	if (os_info_has_vm)
 		old_identity_base = os_info_old_value(OS_INFO_IDENTITY_BASE);
 	for_each_physmem_range(idx, &oldmem_type, &start, &end) {
-		phdr->p_type = PT_LOAD;
-		phdr->p_vaddr = old_identity_base + start;
-		phdr->p_offset = start;
-		phdr->p_paddr = start;
-		phdr->p_filesz = end - start;
-		phdr->p_memsz = end - start;
-		phdr->p_flags = PF_R | PF_W | PF_X;
-		phdr->p_align = PAGE_SIZE;
+		fill_ptload(phdr, start, old_identity_base + start,
+			    end - start);
 		phdr++;
 	}
 }
@@ -526,6 +533,22 @@ static bool os_info_has_vm(void)
 	return os_info_old_value(OS_INFO_KASLR_OFFSET);
 }
 
+#ifdef CONFIG_PROC_VMCORE_DEVICE_RAM
+/*
+ * Fill PT_LOAD for a physical memory range owned by a device and detected by
+ * its device driver.
+ */
+void elfcorehdr_fill_device_ram_ptload_elf64(Elf64_Phdr *phdr,
+		unsigned long long paddr, unsigned long long size)
+{
+	unsigned long old_identity_base = 0;
+
+	if (os_info_has_vm())
+		old_identity_base = os_info_old_value(OS_INFO_IDENTITY_BASE);
+	fill_ptload(phdr, paddr, old_identity_base + paddr, size);
+}
+#endif
+
 /*
  * Prepare PT_LOAD type program header for kernel image region
  */
-- 
2.46.1


