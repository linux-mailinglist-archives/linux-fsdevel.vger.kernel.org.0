Return-Path: <linux-fsdevel+bounces-7456-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B403A82521B
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Jan 2024 11:35:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 52F851F25433
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Jan 2024 10:35:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74DA42DF94;
	Fri,  5 Jan 2024 10:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UCSA6pXU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D2912DF8E
	for <linux-fsdevel@vger.kernel.org>; Fri,  5 Jan 2024 10:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704450834;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=i2HBs3OFSUIo1mUaqHX6XKawGogz4cRNe54pAihhNU4=;
	b=UCSA6pXU0qwSLJdPNNZN+7ImjCbRj9KIMqI23INBYntq2hh1BSSTLT8IJbqkjRXJOJBI9z
	p5QBuuPUX/vAMnonG6idf6nyMDbHxgREklKSOI2VD/Yp8xULUHGBet6n+hO/UTS/IJ6CU2
	GvRCJQhsOv2YiC16CVnUR+mcI0h+cmw=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-277-Rb3lS4pWNTu-90VMiNhIEg-1; Fri,
 05 Jan 2024 05:33:51 -0500
X-MC-Unique: Rb3lS4pWNTu-90VMiNhIEg-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id ED01F3C02786;
	Fri,  5 Jan 2024 10:33:49 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (unknown [10.72.116.129])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 40706492BC6;
	Fri,  5 Jan 2024 10:33:43 +0000 (UTC)
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
	Baoquan He <bhe@redhat.com>,
	kernel test robot <lkp@intel.com>
Subject: [PATCH 5/5] crash: clean up CRASH_DUMP
Date: Fri,  5 Jan 2024 18:33:05 +0800
Message-ID: <20240105103305.557273-6-bhe@redhat.com>
In-Reply-To: <20240105103305.557273-1-bhe@redhat.com>
References: <20240105103305.557273-1-bhe@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9


By splitting CRASH_CORE into CRASH_RESERVE and VMCORE_INFO, and cleaning
up the dependency of FA_DMUMP on CRASH_DUMP, now we can rearrange CRASH_DUMP
to depend on KEXEC_CORE, and select CRASH_RESERVE and VMCORE_INFO.

KEXEC_CORE won't select CRASH_RESERVE and VMCORE_INFO any more because
KEXEC_CORE enables codes which allocate control pages, copy
kexec/kdump segments, and prepare for switching. These codes are shared
by both kexec_load and kexec_file_load, and by both kexec reboot and
kdump.

Doing this to make codes and the corresponding config items more
logical.

PROC_KCORE -----------> VMCORE_INFO

           |----------> VMCORE_INFO
FA_DUMP----|
           |----------> CRASH_RESERVE

                                                ---->VMCORE_INFO
                                               /
                                               |---->CRASH_RESERVE
KEXEC      --|                                /|
             |--> KEXEC_CORE--> CRASH_DUMP-->/-|---->PROC_VMCORE
KEXEC_FILE --|                               \ |
                                               \---->CRASH_HOTPLUG

KEXEC      --|
             |--> KEXEC_CORE--> kexec reboot
KEXEC_FILE --|

Previously, LKP reported a building error. When investigating, it can't
be resolved reasonablly with the present messy kdump config items. With
the prepartory patches and chaneg at above, the LKP reported issue can
be solved now.

Signed-off-by: Baoquan He <bhe@redhat.com>
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202312182200.Ka7MzifQ-lkp@intel.com/
---
 kernel/Kconfig.kexec | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/kernel/Kconfig.kexec b/kernel/Kconfig.kexec
index 8faf27043432..6c34e63c88ff 100644
--- a/kernel/Kconfig.kexec
+++ b/kernel/Kconfig.kexec
@@ -9,8 +9,6 @@ config VMCORE_INFO
 	bool
 
 config KEXEC_CORE
-	select VMCORE_INFO
-	select CRASH_RESERVE
 	bool
 
 config KEXEC_ELF
@@ -99,8 +97,11 @@ config KEXEC_JUMP
 
 config CRASH_DUMP
 	bool "kernel crash dumps"
+	default y
 	depends on ARCH_SUPPORTS_CRASH_DUMP
-	select KEXEC_CORE
+	depends on KEXEC_CORE
+	select VMCORE_INFO
+	select CRASH_RESERVE
 	help
 	  Generate crash dump after being started by kexec.
 	  This should be normally only set in special crash dump kernels
-- 
2.41.0


