Return-Path: <linux-fsdevel+bounces-36450-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B91299E3AAF
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Dec 2024 13:59:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 79DEA28357D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Dec 2024 12:59:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C056D20C023;
	Wed,  4 Dec 2024 12:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L1MFR3wp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FF0C20B7EE
	for <linux-fsdevel@vger.kernel.org>; Wed,  4 Dec 2024 12:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733316929; cv=none; b=sswPlNhYMyGcopVNfpNZYvlvpUTSQ6fbd+lwFCAxUdFW8bcWOY66Kb/Ym9RM8XfF+LVcqSqRw+yMq/x/aetKrj4SQJdw6X8KYYCqrzLVXkEWvM2V/qRh1UiPs8vC9gzVIokLUeyJSSkJC9SJJKdUJoGNKdY8n40Xs63PjA5X0sM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733316929; c=relaxed/simple;
	bh=uRjaOZTjHUvybJWAv9vGsJi33hCxx6hpGz/B8OQ605Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jnTQgitynwSkECW810x4yanGuXvCsnsqF8DY+EB2uQJI4NQHoUILURu54nMCDkegLEf7TVSm4KfUT5ccK4irWpz16Dl7pV9Xe4N5H2ZLUfAS7ldUco3C1zhSZNRO4f2cxrK1x9/LSeZ942j+LQNviqXbmuuuuSbSAw2Kubcj8qI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=L1MFR3wp; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733316926;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QMLpjiP43p31BywTFNffjh3NzCBHssnVGTYWU2BwGcs=;
	b=L1MFR3wpxcV/woNa0Zy01CNEt6DrB3JVd7u4D56T/aeRj8PjUWj/m45fANd7oGkPqMPA8c
	GMyYHfkRgceZSbK/QHx/4+DRbIwtJGABz3UFZtJCPauuhy3LVbqSXm6BvmmBUpR35tmrQT
	9UD6KBowp1AdB1+hkupOSSaZcwe73H8=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-658-tEXyXShvObm7RunkX5zvUA-1; Wed, 04 Dec 2024 07:55:25 -0500
X-MC-Unique: tEXyXShvObm7RunkX5zvUA-1
X-Mimecast-MFC-AGG-ID: tEXyXShvObm7RunkX5zvUA
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-434a37a57dfso55382465e9.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 04 Dec 2024 04:55:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733316924; x=1733921724;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QMLpjiP43p31BywTFNffjh3NzCBHssnVGTYWU2BwGcs=;
        b=VQ0wmemF+CjdKxt4tEAqdWb1FhSRmlQYCij/XqZxGtWilyJO3Qrc3mXrIZXR20zwF2
         RxKvPedBCRj+WxfCQWgDPJPGgahCSDxIX1L9pAd1ZoOjDeVUTgFtmrSDBl2Jd8ZlpmB1
         ePfx8n49BjS4cy8w62p1so6pN3FIQiI9QOtMtWawH6n1rK5f9uURR4oROSXKbMX4HJO+
         CLMeUO87kLZY0lcuY82fgRVuPq5t1wipQ79GfP/7BqZJaydn7/xtlwdeL1/Yx463+wq5
         2KGle406cePRsITyUlDbjqhvAqY4VnsKQdhQfr6VX9RlY3HylQOUhTF7clXpk4YiHHFN
         +Mqw==
X-Forwarded-Encrypted: i=1; AJvYcCUwl5D0TziHAyeImEZCJI7bR7vRwXIqPDUXfPIVsc2+d8ZgmCtrxblQOSg2GUS5qjWdvekHRmSCeh+VVsgO@vger.kernel.org
X-Gm-Message-State: AOJu0YwYh0gK3YN/8pqLMUSExzW/jZOMnS+UCHfnoODyMvngHviBTM/a
	lS0ze4FkEjdJBm8ELIGrIW05KGuxN+syx4yH2p8IsnHPf1VbsPj4a4o/up2GZxQbcTsXT8MBFtv
	GsQyx+GTT5ClsixqLSPVW69xJwX+T9ciKmUF1ox+P185opCH5ZGfh4Uwrrae6mSI=
X-Gm-Gg: ASbGnctu2aw9V1YUCEmHyFs18R2NLnFpKOwIwwqMEpqc1Jtg4w7pvaUc7bbm3zoqhix
	Aa19rOl/l96giW17XzGveSAlw7LUj23DFHoVnbNj8c2ckxdodo2Rjr7pMzUbgv971BxMpEMzFDR
	GauALpZUKYwETjle7XlvTPb634RZWDJ759RaQgi2gmGwts+3tHVyINrrhRkCQ+Upa57G/zzXOOU
	e54VoUKy1CmFBL8xVC4bQQckizZ0hh3jFcOqW0RA3C/y2MFcUgnvzglYeUQC01I516M9iVgsOFl
	wNFXsC5OfBjxg1UAKkqljWh3EJpFemc4BYs=
X-Received: by 2002:a05:600c:1910:b0:434:a962:2aa2 with SMTP id 5b1f17b1804b1-434d0a178d4mr49286465e9.33.1733316924452;
        Wed, 04 Dec 2024 04:55:24 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFFzA2SYKI5zve6AhLcTcIqYEQR+M/xeFfejA5VMHPdifDyO5ycBtXVIAK8EC4IQe7u0N0Ewg==
X-Received: by 2002:a05:600c:1910:b0:434:a962:2aa2 with SMTP id 5b1f17b1804b1-434d0a178d4mr49286335e9.33.1733316924087;
        Wed, 04 Dec 2024 04:55:24 -0800 (PST)
Received: from localhost (p200300cbc70be10038d68aa111b0a20a.dip0.t-ipconnect.de. [2003:cb:c70b:e100:38d6:8aa1:11b0:a20a])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-434d52c0bc7sm23531055e9.35.2024.12.04.04.55.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Dec 2024 04:55:22 -0800 (PST)
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
Subject: [PATCH v2 12/12] s390/kdump: virtio-mem kdump support (CONFIG_PROC_VMCORE_DEVICE_RAM)
Date: Wed,  4 Dec 2024 13:54:43 +0100
Message-ID: <20241204125444.1734652-13-david@redhat.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241204125444.1734652-1-david@redhat.com>
References: <20241204125444.1734652-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
index 0077969170e8..c230bad7f5cc 100644
--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -240,6 +240,7 @@ config S390
 	select MODULES_USE_ELF_RELA
 	select NEED_DMA_MAP_STATE	if PCI
 	select NEED_PER_CPU_EMBED_FIRST_CHUNK
+	select NEED_PROC_VMCORE_DEVICE_RAM if PROC_VMCORE
 	select NEED_SG_DMA_LENGTH	if PCI
 	select OLD_SIGACTION
 	select OLD_SIGSUSPEND3
diff --git a/arch/s390/kernel/crash_dump.c b/arch/s390/kernel/crash_dump.c
index cd0c93a8fb8b..f699df2a2b11 100644
--- a/arch/s390/kernel/crash_dump.c
+++ b/arch/s390/kernel/crash_dump.c
@@ -508,6 +508,19 @@ static int get_mem_chunk_cnt(void)
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
@@ -520,14 +533,8 @@ static void loads_init(Elf64_Phdr *phdr, bool os_info_has_vm)
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
@@ -537,6 +544,22 @@ static bool os_info_has_vm(void)
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
2.47.1


