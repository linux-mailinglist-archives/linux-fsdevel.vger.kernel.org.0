Return-Path: <linux-fsdevel+bounces-7455-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C31082521A
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Jan 2024 11:35:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A650FB2437E
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Jan 2024 10:35:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A7652D7BA;
	Fri,  5 Jan 2024 10:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NPm0YL6S"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81E482D792
	for <linux-fsdevel@vger.kernel.org>; Fri,  5 Jan 2024 10:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704450829;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zwQeRErFiP9ALDlhlMD7G5tnPyyzVuVb4LWP16+Hv2E=;
	b=NPm0YL6SAXmNX4TSvJZc4i+sdbyBWubGd6xYhKyjYuMYU1U8BV+mklLHqUJHS8/Rb3I4rp
	3q4vrvV2cpruWXsog1QhRD54epKdIVgPCHkPoJgF6mIHoF/RaO2p6NJz/lmouXuK2/gNkX
	C+1EtZd4Oi9GNSuFNoH5XRqlJt8erqU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-652-APlWCB4HOHWJeQR4MKcRbA-1; Fri, 05 Jan 2024 05:33:44 -0500
X-MC-Unique: APlWCB4HOHWJeQR4MKcRbA-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9BC5A833944;
	Fri,  5 Jan 2024 10:33:43 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (unknown [10.72.116.129])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 19A3B492BC6;
	Fri,  5 Jan 2024 10:33:35 +0000 (UTC)
From: Baoquan He <bhe@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: akpm@linux-foundation.org,
	kexec@lists.infradead.org,
	hbathini@linux.ibm.com,
	arnd@arndb.de,
	ignat@cloudflare.com,
	eric_devolder@yahoo.com,
	viro@zeniv.linux.org.uk,
	ebiederm@xmission.com,
	x86@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org,
	linux-fsdevel@vger.kernel.org,
	Baoquan He <bhe@redhat.com>
Subject: [PATCH 4/5] crash: remove dependency of FA_DUMP on CRASH_DUMP
Date: Fri,  5 Jan 2024 18:33:04 +0800
Message-ID: <20240105103305.557273-5-bhe@redhat.com>
In-Reply-To: <20240105103305.557273-1-bhe@redhat.com>
References: <20240105103305.557273-1-bhe@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9

In kdump kernel, /proc/vmcore is an elf file which maps the crashed kernel's
read_from_oldmemmemory content. Its elf header is constructed in 1st kernel and passed
to kdump kernel via elfcorehdr_addr. Config CRASH_DUMP enables the code
of 1st kernel's old memory accessing in different architectures.

Currently, config FA_DUMP has dependency on CRASH_DUMP because fadump
needs access global variable 'elfcorehdr_addr' to judge if it's in
kdump kernel within function is_kdump_kernel(). In kernel/crash_dump.c,
variable 'elfcorehdr_addr' is defined, and function setup_elfcorehdr()
is used to parse kernel parameter 'elfcorehdr' to fetch the passed
value of elfcorehdr_addr. With the need of accessing elfcorehdr_addr,
FA_DUMP doesn't have to depends on CRASH_DUMP.

To remove the dependency of FA_DUMP on CRASH_DUMP to avoid confusion,
rename kernel/crash_dump.c to kernel/elfcorehdr.c, and build it when
CONFIG_VMCORE_INFO is ebabled. With this, FA_DUMP doesn't need to depend
on CRASH_DUMP.

In file included from kernel/vmcore_info.c:25:
kernel/kexec_internal.h:11:54: warning: ‘struct kexec_segment’ declared inside parameter list will not be visible outside of this definition or declaration
   11 | int kimage_load_segment(struct kimage *image, struct kexec_segment *segment);
      |                                                      ^~~~~~~~~~~~~

Signed-off-by: Baoquan He <bhe@redhat.com>
---
 arch/powerpc/Kconfig                  | 1 -
 kernel/Makefile                       | 3 +--
 kernel/{crash_dump.c => elfcorehdr.c} | 0
 kernel/kexec_internal.h               | 2 ++
 4 files changed, 3 insertions(+), 3 deletions(-)
 rename kernel/{crash_dump.c => elfcorehdr.c} (100%)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index d391e8cddf6c..22a04891c68d 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -691,7 +691,6 @@ config FA_DUMP
 	depends on PPC64 && (PPC_RTAS || PPC_POWERNV)
 	select VMCORE_INFO
 	select CRASH_RESERVE
-	select CRASH_DUMP
 	help
 	  A robust mechanism to get reliable kernel crash dump with
 	  assistance from firmware. This approach does not use kexec,
diff --git a/kernel/Makefile b/kernel/Makefile
index 08980e5c2080..25ac9345ef79 100644
--- a/kernel/Makefile
+++ b/kernel/Makefile
@@ -68,7 +68,7 @@ obj-$(CONFIG_MODULE_SIG_FORMAT) += module_signature.o
 obj-$(CONFIG_KALLSYMS) += kallsyms.o
 obj-$(CONFIG_KALLSYMS_SELFTEST) += kallsyms_selftest.o
 obj-$(CONFIG_BSD_PROCESS_ACCT) += acct.o
-obj-$(CONFIG_VMCORE_INFO) += vmcore_info.o
+obj-$(CONFIG_VMCORE_INFO) += vmcore_info.o elfcorehdr.o
 obj-$(CONFIG_CRASH_RESERVE) += crash_reserve.o
 obj-$(CONFIG_KEXEC_CORE) += kexec_core.o
 obj-$(CONFIG_KEXEC) += kexec.o
@@ -120,7 +120,6 @@ obj-$(CONFIG_PERF_EVENTS) += events/
 
 obj-$(CONFIG_USER_RETURN_NOTIFIER) += user-return-notifier.o
 obj-$(CONFIG_PADATA) += padata.o
-obj-$(CONFIG_CRASH_DUMP) += crash_dump.o
 obj-$(CONFIG_JUMP_LABEL) += jump_label.o
 obj-$(CONFIG_CONTEXT_TRACKING) += context_tracking.o
 obj-$(CONFIG_TORTURE_TEST) += torture.o
diff --git a/kernel/crash_dump.c b/kernel/elfcorehdr.c
similarity index 100%
rename from kernel/crash_dump.c
rename to kernel/elfcorehdr.c
diff --git a/kernel/kexec_internal.h b/kernel/kexec_internal.h
index 74da1409cd14..2595defe8c0d 100644
--- a/kernel/kexec_internal.h
+++ b/kernel/kexec_internal.h
@@ -4,6 +4,8 @@
 
 #include <linux/kexec.h>
 
+struct kexec_segment;
+
 struct kimage *do_kimage_alloc_init(void);
 int sanity_check_segment_list(struct kimage *image);
 void kimage_free_page_list(struct list_head *list);
-- 
2.41.0


