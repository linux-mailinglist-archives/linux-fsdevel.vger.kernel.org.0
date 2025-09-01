Return-Path: <linux-fsdevel+bounces-59817-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 25F9CB3E309
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Sep 2025 14:34:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 157C91A82F21
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Sep 2025 12:35:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0E6E341679;
	Mon,  1 Sep 2025 12:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="bg3wcAgF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7365229B2A
	for <linux-fsdevel@vger.kernel.org>; Mon,  1 Sep 2025 12:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756729840; cv=none; b=RnlkMP8FKV4TMTafmhBoTPzp2XJbHX5W701YDhRu+4vj9rDpvRiAZi8krpYE4+mgjp4M5iWuM+7GZgAR21BZFJRuIktoGRnS8ekmgGo8Ow0CtsZ27iXnxWWc8ETaMHkfKMZEb3LaUXU/+ct/iQuuxxD7qTCHYXdoXyxfe3ky9Ow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756729840; c=relaxed/simple;
	bh=v24uZZ9KVAxxo/0P71k6jf7BKwFIJrdpDNs1iZ9/YH8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LADvSjzt0YDX9+3zWTp9RFobZH3gcvMQP7z5CRzwzxkhWNE0yXrqjPPUA1G+G30MG7S6vlI55K5Yk+04HIWQyJEzE1bEI6CD3c6zH/cfKUMZ6DoxapefxwTjGR5SkX7XYwrqPP1suIrNn/DZhKqGwxow25PJivJ5lTJBoo+icUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=bg3wcAgF; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-6188b72b7caso4392845a12.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 01 Sep 2025 05:30:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1756729835; x=1757334635; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dKIQLUaaWXpeIWzcvUskrPePOLIqiIThIa1QtzzvUMQ=;
        b=bg3wcAgFvz6eccB+aOUXxMPDfC+OoWDE6CerXdrkTW1e/F5L12zGQtf53Mb6D2fd8C
         UBXLDuIN77FktIrntj1YljasfSdTqK+rtsZsfNBKTO9rwP/ddiHmcmgBkFUl8ppQgGj9
         u6uEpC2J8ErfOofMFZrQoiomYgRFi6Kd+yztu+9qmpKLjZ/L1aaLoPIiuZZL4KwRKZ/P
         WNBFbDxEUKkAdaWFGbxuJB8nuDdQbkQnXanRjih9qp1Fj98Lg347QbmCG6YNGo4QFxMD
         W5ulon3uX4L8ZIqCTkri1jduQKlH6HFQm6aMWekuXdwopIDkVRg08PheKUlOrpaq5n4i
         7izw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756729835; x=1757334635;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dKIQLUaaWXpeIWzcvUskrPePOLIqiIThIa1QtzzvUMQ=;
        b=hY+KPaEbmK8OZPRQwKhOudNMhUbjK2UXvO7dla6MOXsWD5dD9/puxGHVTteUCepa3C
         OTkRLKkdS9vJTVdImvaZGL2gvfvcY5FLnYSjwsZQyNRFpptN1+2U3DD/sQqsD3iw+AIj
         JyXAKIyIJtlN9syG7Pj5is8kxfmdohn2PHYloTAEoOVUfroNTzgxhqkCaUqkLX5+Up4j
         Zm6jTeUWKu0n/i5FHlLFdMmz3Rqzo+zevP9a43AGj4MHbuJ09V4uh7fc+CZtTVlT/29H
         w1b6DIUVEAK7XimstlhcyQyXCFs3OILFbBe9O8CKfgdJge+vteMkouEECdxrVOvxjz8b
         PG/g==
X-Forwarded-Encrypted: i=1; AJvYcCUvniBqfyldWzrrGwnyD7MjkN9i+23GPw7SFocEhUX+9VLFptYotuSJl80PGBK2NB81bLFeMW5O0jZtyiYD@vger.kernel.org
X-Gm-Message-State: AOJu0Ywq4+N508t9uqELZFOSt92ygsrp+wxFIb3neWgECIwi2hBfwY7j
	uxhDHGjjekorrQg36aH2/pBC/saSCQQfA19+gzEl3Q4LJtHIW78J2rCZVtqcraC7eVo=
X-Gm-Gg: ASbGncsMcXhICEE5+EQQsds14DzLqfiyj3xk2LDumrlJeq1eXtLc8XUyQRTGOV3hh5h
	a/5LP122/sBYs5aaTnAv+550goa8kiIyma6fcSsNo+pmsTuBgoaDFIeDSxX5HrujY8V093wHjB8
	cAKk4dIZHGPwvnubIPOedkNeO2aRYyWhVNgJPDEB64z2ygbcORuG7UcfWuIBzD2ceh2cgbIxlSC
	3YF8BcsZBU2IsrhoSp9j292jWx7wjXbBPyg+/1hgabjXG05LvygsBGygKlgkYRPNlY53928JpnS
	KpuEs64AA1U7GInUo/iyGMXF27GbQ70ZQy8GP9P6b0Yw0uAUyiXhc8zpoc0TI54tXVPNmPjo6w3
	dCTUSsSCeJ5W1Oi7O6m/AxsdDfthpAgzcgH/AZlFLPi1mkpjvZ1JoPZAA9ry9WLylhwf0zhO+Vt
	y2exXueLl+worsKUYKQ3ziHg==
X-Google-Smtp-Source: AGHT+IGDWKKpCY+gwaNyKUXSsMGebFFbg8AoojoUj/75zRe+ebpEqmLb7gpe5dy7vu7IufqwC7egRw==
X-Received: by 2002:a05:6402:505c:b0:615:78c6:7aed with SMTP id 4fb4d7f45d1cf-61d26ebcdffmr6326182a12.32.1756729835027;
        Mon, 01 Sep 2025 05:30:35 -0700 (PDT)
Received: from raven.intern.cm-ag (p200300dc6f1d0f00023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f1d:f00:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-61eaf5883b6sm255566a12.20.2025.09.01.05.30.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Sep 2025 05:30:34 -0700 (PDT)
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
Subject: [PATCH v5 01/12] mm: constify shmem related test functions for improved const-correctness
Date: Mon,  1 Sep 2025 14:30:17 +0200
Message-ID: <20250901123028.3383461-2-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250901123028.3383461-1-max.kellermann@ionos.com>
References: <20250901123028.3383461-1-max.kellermann@ionos.com>
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
index 640fecc42f60..d55bceaa1c80 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -275,18 +275,18 @@ static const struct vm_operations_struct shmem_vm_ops;
 static const struct vm_operations_struct shmem_anon_vm_ops;
 static struct file_system_type shmem_fs_type;
 
-bool shmem_mapping(struct address_space *mapping)
+bool shmem_mapping(const struct address_space *const mapping)
 {
 	return mapping->a_ops == &shmem_aops;
 }
 EXPORT_SYMBOL_GPL(shmem_mapping);
 
-bool vma_is_anon_shmem(struct vm_area_struct *vma)
+bool vma_is_anon_shmem(const struct vm_area_struct *const vma)
 {
 	return vma->vm_ops == &shmem_anon_vm_ops;
 }
 
-bool vma_is_shmem(struct vm_area_struct *vma)
+bool vma_is_shmem(const struct vm_area_struct *const vma)
 {
 	return vma_is_anon_shmem(vma) || vma->vm_ops == &shmem_vm_ops;
 }
-- 
2.47.2


