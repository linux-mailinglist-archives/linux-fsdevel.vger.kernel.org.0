Return-Path: <linux-fsdevel+bounces-59909-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 32126B3EFDD
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Sep 2025 22:51:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AFFC51A85080
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Sep 2025 20:51:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA9EC274FD9;
	Mon,  1 Sep 2025 20:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="gLK6PNaB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CCBF272E71
	for <linux-fsdevel@vger.kernel.org>; Mon,  1 Sep 2025 20:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756759834; cv=none; b=HTUsE38MqZbdpU6+FhOU5zjImeKJ7fNTmRd2+zAJCMPCwm+B7/ZdOHGtcUQ1jmqugGKT6E5orNxztMTeXE3AyFD/1JQ9BD34mesSutmuVBYIL1famE7M7VIO01dk4p+67zLenjRaVCi5DTqRkmU4gLMi2Mo0rlvubfOOC7u5tFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756759834; c=relaxed/simple;
	bh=t7XT6CEbh7zjmSeSWCr8ZD1olx5I3kyEJDSmUA/OyVg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=noVGIL/w0Xqti7xG9LqzYjVwG84WOQIWAjfQluAgLJA2zcym2PQoq1Q/Lu0OCIZyNHsbdaeP6oFGuAsVLcp6wh3BgMmHCoV9ONjwFvV0xjD6xm9orJ2wwUYw+oJP18m3fWERUgjADWUedr5I6w/M/v6o8NSK+6XImIQit5yQt90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=gLK6PNaB; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-b040df389easo360505366b.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 01 Sep 2025 13:50:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1756759829; x=1757364629; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1tn78QatM6psXy56nBwVEP8sZrX8rAS66Lkst08QtRU=;
        b=gLK6PNaBOzEjiJLFIBBwG8cqcduLvvio1BVX1TRz97HZpLz9lDaGp6o0CD3qN/XB0q
         o/4OqHjiotjvrZYa+wf1FTUJ8T65cXLA2ScYnw1k6ZfioDI0BVxJMkB4l2BCYUDrINot
         rmGggpiREPYta3Rs+GBXRkuEORhN0RuXWt76fjtcuZwGzdUSA40Ub2CnGPEY1pgVwIwy
         g3WN3zz1o1T4EQhtfHqnjvl4hZSvCvSp9sAY7YPaEFPIITppvKBoXQTFmhX4Sm0Diq1/
         Kue/GBW55svAnQzp1ap83FKsFfc/YTmbN03CxMqbS5Bk4md+DNIOT2bJHkpTTYkEtN8w
         9Eew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756759829; x=1757364629;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1tn78QatM6psXy56nBwVEP8sZrX8rAS66Lkst08QtRU=;
        b=CupsWVLpKGeyBI+rGvT1AWEmX8Qeo0Qqw7G7K6V2Vzv9om1K6z6/2aqWdEOO2bXZLn
         cnfD/+ScWo8/QUyY4O/NfVtGrO7cRu3MARai2ZOiGhlYSjpKhtJoDqwP4YN/EkhQQY7V
         zmSzB0vWSLN5UAl29qIPmglj812Tb4bLeAiog3BD5e2taOfVn49u+8x7Knmo2gQx9K5T
         KJT6IFy9h6hBcyor3LhQMM++2vjeS/4lBEkYq6wjMeVv6qvp/PehuYsoZoiMLy31drVi
         zKOhViNVCuaRLT24pah5kCoh2nskdbfc7U6/T510DOCwN16eSJvSjYnnZiOF8SScJ5/N
         BIog==
X-Forwarded-Encrypted: i=1; AJvYcCXGWi3jaGJJUFVKAoaXG6ytyroHx6guoOx3FXRAdq+uL02UEHNW/7AzknYiRbQhM06gc288/Pop1f9V4vaD@vger.kernel.org
X-Gm-Message-State: AOJu0Yyti6q4jzgryIc+Cv2Im3ZuPDJ9GDEifU/RJAYvbee8v+WnBUSJ
	KEoki4r+adeJvRG9cGD+hxsHyDb8HofiBxlUhnqL1IPlbNstLGTMJ6oGS/fJ+4+8KrI=
X-Gm-Gg: ASbGncvZDqk7gE1vBRc0zLBIuHuCGwR39Jpn0PZEnqC+mV/wXxTAbxLV9SUMrKij/9a
	8BDsdThv8iEqtzA00WSAHDZc4wWEEEar0Xt/6OhIqBUJKmBpqkjp//kRT0jqNP5uqht10KWJuFo
	CzwnE1052ziCIg/Glxb/a3Ky275vGuLXmLFCBcLptsNltdggJNJIrD0rBOSUrAVZOegn9gTcxOv
	8tmjYfz4Qmz8DADVrWgMJuDkjGAgOr8Zk0VkOMn2GNxWkzcKreHYuDKQANxdgi1eSXtYXWU6Afa
	SwKp7327iXJv/HBl+PA/mT2ji/W0HTcLYg0jsWoKUUMr7KxITCBpV2wRMt44O6PT0OADfVb8Fym
	e1W3BYcAAko1GrCznKjTrFwpZBGzF22F/zsWNTuETLZUsfggLzzxRO23H/C6Nr1U+lGWTOcTgUp
	/FKJuDJav397iVOOZ0dK8ZjtAIeVXK9+JK
X-Google-Smtp-Source: AGHT+IF8f2IkqJ53snw7rUXbJM+rbFqtblA8YnCowS1e50uvKMXTh+/K+YqxtlkXHOf7uiwvUXJSGA==
X-Received: by 2002:a17:907:1c81:b0:aff:a36:e6e with SMTP id a640c23a62f3a-b01f20c705cmr970127566b.57.1756759829377;
        Mon, 01 Sep 2025 13:50:29 -0700 (PDT)
Received: from raven.intern.cm-ag (p200300dc6f1d0f00023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f1d:f00:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afefcbd9090sm937339066b.69.2025.09.01.13.50.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Sep 2025 13:50:29 -0700 (PDT)
From: Max Kellermann <max.kellermann@ionos.com>
To: akpm@linux-foundation.org,
	david@redhat.com,
	axelrasmussen@google.com,
	yuanchu@google.com,
	willy@infradead.org,
	hughd@google.com,
	mhocko@suse.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com,
	vbabka@suse.cz,
	rppt@kernel.org,
	surenb@google.com,
	vishal.moola@gmail.com,
	linux@armlinux.org.uk,
	James.Bottomley@HansenPartnership.com,
	deller@gmx.de,
	agordeev@linux.ibm.com,
	gerald.schaefer@linux.ibm.com,
	hca@linux.ibm.com,
	gor@linux.ibm.com,
	borntraeger@linux.ibm.com,
	svens@linux.ibm.com,
	davem@davemloft.net,
	andreas@gaisler.com,
	dave.hansen@linux.intel.com,
	luto@kernel.org,
	peterz@infradead.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	x86@kernel.org,
	hpa@zytor.com,
	chris@zankel.net,
	jcmvbkbc@gmail.com,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz,
	weixugc@google.com,
	baolin.wang@linux.alibaba.com,
	rientjes@google.com,
	shakeel.butt@linux.dev,
	max.kellermann@ionos.com,
	thuth@redhat.com,
	broonie@kernel.org,
	osalvador@suse.de,
	jfalempe@redhat.com,
	mpe@ellerman.id.au,
	nysal@linux.ibm.com,
	linux-arm-kernel@lists.infradead.org,
	linux-parisc@vger.kernel.org,
	linux-s390@vger.kernel.org,
	sparclinux@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v6 01/12] mm: constify shmem related test functions for improved const-correctness
Date: Mon,  1 Sep 2025 22:50:10 +0200
Message-ID: <20250901205021.3573313-2-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250901205021.3573313-1-max.kellermann@ionos.com>
References: <20250901205021.3573313-1-max.kellermann@ionos.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We select certain test functions which either invoke each other,
functions that are already const-ified, or no further functions.

It is therefore relatively trivial to const-ify them, which
provides a basis for further const-ification further up the call
stack.

Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
Reviewed-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Acked-by: David Hildenbrand <david@redhat.com>
---
 include/linux/mm.h       | 8 ++++----
 include/linux/shmem_fs.h | 4 ++--
 mm/shmem.c               | 6 +++---
 3 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index cd14298bb958..18deb14cb1f5 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -979,11 +979,11 @@ static inline void vma_iter_set(struct vma_iterator *vmi, unsigned long addr)
  * The vma_is_shmem is not inline because it is used only by slow
  * paths in userfault.
  */
-bool vma_is_shmem(struct vm_area_struct *vma);
-bool vma_is_anon_shmem(struct vm_area_struct *vma);
+bool vma_is_shmem(const struct vm_area_struct *vma);
+bool vma_is_anon_shmem(const struct vm_area_struct *vma);
 #else
-static inline bool vma_is_shmem(struct vm_area_struct *vma) { return false; }
-static inline bool vma_is_anon_shmem(struct vm_area_struct *vma) { return false; }
+static inline bool vma_is_shmem(const struct vm_area_struct *vma) { return false; }
+static inline bool vma_is_anon_shmem(const struct vm_area_struct *vma) { return false; }
 #endif
 
 int vma_is_stack_for_current(struct vm_area_struct *vma);
diff --git a/include/linux/shmem_fs.h b/include/linux/shmem_fs.h
index 6d0f9c599ff7..0e47465ef0fd 100644
--- a/include/linux/shmem_fs.h
+++ b/include/linux/shmem_fs.h
@@ -99,9 +99,9 @@ extern unsigned long shmem_get_unmapped_area(struct file *, unsigned long addr,
 		unsigned long len, unsigned long pgoff, unsigned long flags);
 extern int shmem_lock(struct file *file, int lock, struct ucounts *ucounts);
 #ifdef CONFIG_SHMEM
-bool shmem_mapping(struct address_space *mapping);
+bool shmem_mapping(const struct address_space *mapping);
 #else
-static inline bool shmem_mapping(struct address_space *mapping)
+static inline bool shmem_mapping(const struct address_space *mapping)
 {
 	return false;
 }
diff --git a/mm/shmem.c b/mm/shmem.c
index 640fecc42f60..2df26f4d6e60 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -275,18 +275,18 @@ static const struct vm_operations_struct shmem_vm_ops;
 static const struct vm_operations_struct shmem_anon_vm_ops;
 static struct file_system_type shmem_fs_type;
 
-bool shmem_mapping(struct address_space *mapping)
+bool shmem_mapping(const struct address_space *mapping)
 {
 	return mapping->a_ops == &shmem_aops;
 }
 EXPORT_SYMBOL_GPL(shmem_mapping);
 
-bool vma_is_anon_shmem(struct vm_area_struct *vma)
+bool vma_is_anon_shmem(const struct vm_area_struct *vma)
 {
 	return vma->vm_ops == &shmem_anon_vm_ops;
 }
 
-bool vma_is_shmem(struct vm_area_struct *vma)
+bool vma_is_shmem(const struct vm_area_struct *vma)
 {
 	return vma_is_anon_shmem(vma) || vma->vm_ops == &shmem_vm_ops;
 }
-- 
2.47.2


