Return-Path: <linux-fsdevel+bounces-52334-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D125AE1E66
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Jun 2025 17:21:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 284974A7D00
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Jun 2025 15:21:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DEE62C2AAB;
	Fri, 20 Jun 2025 15:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WTEY9Jda"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8360C2BFC80
	for <linux-fsdevel@vger.kernel.org>; Fri, 20 Jun 2025 15:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750432898; cv=none; b=OMIgOoWAQyzQjqkVYUeSHHH53XIrZh25Sn2E/fBxaiqLHFDWM85Kr4TNVSWIkoub5VsIqhqgIX6PiXaRFDQt3AEy4/vG4udp/9fS2T8qEsC/oMJ6IogNsMBlg1xUkQ+Iid+Mj3g/f17DxcmFndHkv87lG9Fik+LIhI7DSG6ciPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750432898; c=relaxed/simple;
	bh=ZNWN/AxMaZjDkqYItb81+abo5OAMF8kgmVW0rCZAtm4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HbLrWn152NLWApJaT5+qV0FBSDaLCGOTmVIa342MfcgSJNrwOI5P6X8zNSo3qS6tGwBto329+jQM6Nskc/NQuYFLdDw7wXZeJX5QtP/Pn8RKHCzV+F3v32+y4tloirpgQO4XT5HU8dpqCpLPoQcSjMQYPocELnCA2a23v7hjxbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WTEY9Jda; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750432893;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1piPOxakbi96QGxUT4kGXjaUgIRXevFIE11NPL1+hPc=;
	b=WTEY9Jda+F6vMXRkB266xZ7vAQ05+UYQXYqwP7Nwyx80ZimJyR6rYdRYVR/+vumwPZzau+
	kkXFlcOZ3KiuyyBVPh6gLDdGlLpOwDsA8/v5T02ty4yEoDVRqed+92Tm08dJEL9S0KoMkM
	XsaEyUY4PYfIQyckFfegqcmvh/kM0Ws=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-187-ZR31HbT_OUOBoqp6M_jmoQ-1; Fri, 20 Jun 2025 11:21:31 -0400
X-MC-Unique: ZR31HbT_OUOBoqp6M_jmoQ-1
X-Mimecast-MFC-AGG-ID: ZR31HbT_OUOBoqp6M_jmoQ_1750432891
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-235dd77d11fso19956965ad.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 20 Jun 2025 08:21:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750432888; x=1751037688;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1piPOxakbi96QGxUT4kGXjaUgIRXevFIE11NPL1+hPc=;
        b=dLcfnmHidy0VkQaoKN0EbSlpOW3iOH0N7oTAhTTXHCObdcdpHnkM/cm072qI5YqnsV
         CXQoFJ7/47cv9QAW/ttY1OaxtclA+Jy7tHSn/Go2UucX4EHuWtecXq2nhraMsylnp6ZW
         Xs1d3RchKBO9iJJv3CAzhoNurP8zxN8z0TvRuCWSgF1jF/LWUpa5NAAwnMyahYyBQ3yP
         HvklM5tAZnnCqIJYaVNsTthfA9x/KuBugI1NC7+jgUWkX4qHrIdYc0sQezmoSj2uKZoT
         CF+GbE421QemuSEyfknlLIiz4953SF220w2V/HSIbPDRH3DjjZnmfEug/h8ngWJPc95q
         cLuw==
X-Forwarded-Encrypted: i=1; AJvYcCU/ZVNMPGxn6N5A9HpBrzIROxq8OmNwwXbzxA9KtVi2Acg/K1oDDT/O0jKBby4YKLECSiZizJVLhapwC+Pp@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4y7V5hC+FgNsrR9M9J+CLbm6hyuezjyC/MaO9e7nMF0eFE1ZT
	amZ1har9NqLgE4UrR82nZcbAX27AoHe42FiydgsCOx1CBYuChM7vRMihSGBXoFuP0wjt2K2qwey
	QPEbrVtOLQl/Wcj9AfzisIefkJ5wfZ8GuA0h8V6x9L4EVl9XzuxgDR7jucxRvjM+Gxe4=
X-Gm-Gg: ASbGncs0lhXQbNYr62FrkUGCl6+yJ5A9O4OYub+Va0WpOqYFwdEy4rlfF/4sduM3grH
	O0YI/o6jBgXTXAs4AXr0ok2lE6HCHo1E7+OrQt9f7Zy0Tkmw0RGAoWf3jezc1RRozHLB1JO+UO3
	tWezIy85NsSaP5ecn77TFzjYOiQVki3tBXzhdKacTUGWOIoozDXtRoLtuS/OnOdY5Jr2n2ABdDx
	N4RlFrzDkTBnfLS1TxOFcgno/jBJ5M/zxvcYu3YUbbZJMYpwh5IbWAOBRSLdSIfLXdj7+ua+tRO
	v9HHWBwGnIhZHw==
X-Received: by 2002:a17:903:190:b0:234:a139:11ec with SMTP id d9443c01a7336-237d984a18fmr50957595ad.20.1750432888047;
        Fri, 20 Jun 2025 08:21:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFHMf9ipqas4ZoIOxL+ed9Gpq19+KmR3P+/FSP36axXmOC4aoNGQ0v43oHa0/JQOyNO6xRu2A==
X-Received: by 2002:a17:903:190:b0:234:a139:11ec with SMTP id d9443c01a7336-237d984a18fmr50956885ad.20.1750432887366;
        Fri, 20 Jun 2025 08:21:27 -0700 (PDT)
Received: from x1.local ([85.131.185.92])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b31f118ea01sm1932013a12.5.2025.06.20.08.21.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jun 2025 08:21:26 -0700 (PDT)
Date: Fri, 20 Jun 2025 11:21:19 -0400
From: Peter Xu <peterx@redhat.com>
To: Nikita Kalyazin <kalyazin@amazon.com>
Cc: akpm@linux-foundation.org, pbonzini@redhat.com, shuah@kernel.org,
	viro@zeniv.linux.org.uk, brauner@kernel.org, muchun.song@linux.dev,
	hughd@google.com, kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, jack@suse.cz,
	lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com,
	jannh@google.com, ryan.roberts@arm.com, david@redhat.com,
	jthoughton@google.com, graf@amazon.de, jgowans@amazon.com,
	roypat@amazon.co.uk, derekmn@amazon.com, nsaenz@amazon.es,
	xmarcalx@amazon.com
Subject: Re: [PATCH v3 1/6] mm: userfaultfd: generic continue for non
 hugetlbfs
Message-ID: <aFV8bz0GjPVe-IeZ@x1.local>
References: <20250404154352.23078-1-kalyazin@amazon.com>
 <20250404154352.23078-2-kalyazin@amazon.com>
 <aEiwHjl4tsUt98sh@x1.local>
 <36d96316-fd9b-4755-bb35-d1a2cea7bb7e@amazon.com>
 <aEl9CNGLY0Sil7nq@x1.local>
 <2097f155-c459-40e1-93e8-3d501ae66b42@amazon.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2097f155-c459-40e1-93e8-3d501ae66b42@amazon.com>

Hi, Nikita,

On Fri, Jun 20, 2025 at 01:00:24PM +0100, Nikita Kalyazin wrote:
> Thanks for explaining that.  I played a bit with it myself and it appears to
> be working for the MISSING mode for both shmem and guest_memfd.  Attaching

[1]

> my sketch below.  Please let me know if this is how you see it.
> 
> I found that arguments and return values are significantly different between
> the two request types, which may be a bit confusing, although we do not
> expect many callers of those.

Indeed.  Actually since I didn't yet get your reply, early this week I gave
it a shot, and then I found the same thing that it'll be nice to keep the
type checks all over the places.  It'll also be awkward if we want to add
MISSING into the picture with the current req() interface (btw, IIUC you
meant MINOR above, not MISSING).

Please have a look at what I came up with.  I didn't yet got a chance to
post it, but it did compile all fine and pass the smoke tests here.  Feel
free to take it over if you think that makes sense to you, or I can also
post it officially after some more tests.

So, ultimately I introduced a vm_uffd_ops to keep all the type checks.  I
don't think I like the uffd_copy() interfacing too much, but it should
still be the minimum changeset I can think of to generalize shmem as an
userfault user / module, and finally drop "linux/shmem_fs.h" inclusion in
the last patch.

It's also unfortunate that hugetlb won't be able to already use the API,
similar to why we have hugetlb's fault() to BUG() and hard-coded it in
handle_mm_fault().  However it'll at least start to use the rest API all
fine, so as to generalize some hugetlb checks.

The shmem definition looks like this:

static const vm_uffd_ops shmem_uffd_ops = {
	.uffd_features	= 	__VM_UFFD_FLAGS,
	.uffd_ioctls	= 	BIT(_UFFDIO_COPY) |
				BIT(_UFFDIO_ZEROPAGE) |
				BIT(_UFFDIO_WRITEPROTECT) |
				BIT(_UFFDIO_CONTINUE) |
				BIT(_UFFDIO_POISON),
	.uffd_get_folio	=	shmem_uffd_get_folio,
	.uffd_copy	=	shmem_mfill_atomic_pte,
};

Then guest-memfd can set (1) VM_UFFD_MINOR, (2) _UFFDIO_CONTINUE and
provide uffd_get_folio() for supporting MINOR.

Let me know what do you think.

Thanks,

===8<===
From ca500177de122d32194f8bf4589faceeaaae2c0c Mon Sep 17 00:00:00 2001
From: Peter Xu <peterx@redhat.com>
Date: Thu, 12 Jun 2025 11:51:58 -0400
Subject: [PATCH 1/4] mm: Introduce vm_uffd_ops API

Introduce a generic userfaultfd API for vm_operations_struct, so that one
vma, especially when as a module, can support userfaults without modifying
the core files.  More importantly, when the module can be compiled out of
the kernel.

So, instead of having core mm referencing modules that may not ever exist,
we need to have modules opt-in on core mm hooks instead.

After this API applied, if a module wants to support userfaultfd, the
module should only need to touch its own file and properly define
vm_uffd_ops, instead of changing anything in core mm.

Note that such API will not work for anonymous. Core mm will process
anonymous memory separately for userfault operations like before.

This patch only introduces the API alone so that we can start to move
existing users over but without breaking them.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/linux/mm.h            | 71 +++++++++++++++++++++++++++++++++++
 include/linux/userfaultfd_k.h | 12 ------
 2 files changed, 71 insertions(+), 12 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 98a606908307..8dfd83f01d3d 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -576,6 +576,70 @@ struct vm_fault {
 					 */
 };
 
+#ifdef CONFIG_USERFAULTFD
+/* A combined operation mode + behavior flags. */
+typedef unsigned int __bitwise uffd_flags_t;
+
+enum mfill_atomic_mode {
+	MFILL_ATOMIC_COPY,
+	MFILL_ATOMIC_ZEROPAGE,
+	MFILL_ATOMIC_CONTINUE,
+	MFILL_ATOMIC_POISON,
+	NR_MFILL_ATOMIC_MODES,
+};
+
+/* VMA userfaultfd operations */
+typedef struct {
+	/**
+	 * @uffd_features: features supported in bitmask.
+	 *
+	 * When the ops is defined, the driver must set non-zero features
+	 * to be a subset (or all) of: VM_UFFD_MISSING|WP|MINOR.
+	 */
+	unsigned long uffd_features;
+	/**
+	 * @uffd_ioctls: ioctls supported in bitmask.
+	 *
+	 * Userfaultfd ioctls supported by the module.  Below will always
+	 * be supported by default whenever a module provides vm_uffd_ops:
+	 *
+	 *   _UFFDIO_API, _UFFDIO_REGISTER, _UFFDIO_UNREGISTER, _UFFDIO_WAKE
+	 *
+	 * The module needs to provide all the rest optionally supported
+	 * ioctls.  For example, when VM_UFFD_MISSING was supported,
+	 * _UFFDIO_COPY must be supported as ioctl, while _UFFDIO_ZEROPAGE
+	 * is optional.
+	 */
+	unsigned long uffd_ioctls;
+	/**
+	 * uffd_get_folio: Handler to resolve UFFDIO_CONTINUE request.
+	 *
+	 * @inode: the inode for folio lookup
+	 * @pgoff: the pgoff of the folio
+	 * @folio: returned folio pointer
+	 *
+	 * Return: zero if succeeded, negative for errors.
+	 */
+	int (*uffd_get_folio)(struct inode *inode, pgoff_t pgoff,
+			      struct folio **folio);
+	/**
+	 * uffd_copy: Handler to resolve UFFDIO_COPY|ZEROPAGE request.
+	 *
+	 * @dst_pmd: target pmd to resolve page fault
+	 * @dst_vma: target vma
+	 * @dst_addr: target virtual address
+	 * @src_addr: source address to copy from
+	 * @flags: userfaultfd request flags
+	 * @foliop: previously allocated folio
+	 *
+	 * Return: zero if succeeded, negative for errors.
+	 */
+	int (*uffd_copy)(pmd_t *dst_pmd, struct vm_area_struct *dst_vma,
+			 unsigned long dst_addr, unsigned long src_addr,
+			 uffd_flags_t flags, struct folio **foliop);
+} vm_uffd_ops;
+#endif
+
 /*
  * These are the virtual MM functions - opening of an area, closing and
  * unmapping it (needed to keep files on disk up-to-date etc), pointer
@@ -653,6 +717,13 @@ struct vm_operations_struct {
 	 */
 	struct page *(*find_special_page)(struct vm_area_struct *vma,
 					  unsigned long addr);
+#ifdef CONFIG_USERFAULTFD
+	/*
+	 * Userfaultfd related ops.  Modules need to define this to support
+	 * userfaultfd.
+	 */
+	const vm_uffd_ops *userfaultfd_ops;
+#endif
 };
 
 #ifdef CONFIG_NUMA_BALANCING
diff --git a/include/linux/userfaultfd_k.h b/include/linux/userfaultfd_k.h
index ccad58602846..e79c724b3b95 100644
--- a/include/linux/userfaultfd_k.h
+++ b/include/linux/userfaultfd_k.h
@@ -80,18 +80,6 @@ struct userfaultfd_ctx {
 
 extern vm_fault_t handle_userfault(struct vm_fault *vmf, unsigned long reason);
 
-/* A combined operation mode + behavior flags. */
-typedef unsigned int __bitwise uffd_flags_t;
-
-/* Mutually exclusive modes of operation. */
-enum mfill_atomic_mode {
-	MFILL_ATOMIC_COPY,
-	MFILL_ATOMIC_ZEROPAGE,
-	MFILL_ATOMIC_CONTINUE,
-	MFILL_ATOMIC_POISON,
-	NR_MFILL_ATOMIC_MODES,
-};
-
 #define MFILL_ATOMIC_MODE_BITS (const_ilog2(NR_MFILL_ATOMIC_MODES - 1) + 1)
 #define MFILL_ATOMIC_BIT(nr) BIT(MFILL_ATOMIC_MODE_BITS + (nr))
 #define MFILL_ATOMIC_FLAG(nr) ((__force uffd_flags_t) MFILL_ATOMIC_BIT(nr))
-- 
2.49.0


From a7094b86d3308e91ac7ab785b7d71ae6cc4739f4 Mon Sep 17 00:00:00 2001
From: Peter Xu <peterx@redhat.com>
Date: Wed, 11 Jun 2025 10:18:23 -0400
Subject: [PATCH 2/4] mm/shmem: Support vm_uffd_ops API

Add support for the new vm_uffd_ops API for shmem.  Note that this only
introduces the support, the API is not yet used by core mm.

Cc: Hugh Dickins <hughd@google.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 mm/shmem.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/mm/shmem.c b/mm/shmem.c
index 0bc30dafad90..bd0a29000318 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -3151,6 +3151,13 @@ static inline struct inode *shmem_get_inode(struct mnt_idmap *idmap,
 #endif /* CONFIG_TMPFS_QUOTA */
 
 #ifdef CONFIG_USERFAULTFD
+
+static int shmem_uffd_get_folio(struct inode *inode, pgoff_t pgoff,
+				struct folio **folio)
+{
+	return shmem_get_folio(inode, pgoff, 0, folio, SGP_NOALLOC);
+}
+
 int shmem_mfill_atomic_pte(pmd_t *dst_pmd,
 			   struct vm_area_struct *dst_vma,
 			   unsigned long dst_addr,
@@ -5194,6 +5201,19 @@ static int shmem_error_remove_folio(struct address_space *mapping,
 	return 0;
 }
 
+#ifdef CONFIG_USERFAULTFD
+static const vm_uffd_ops shmem_uffd_ops = {
+	.uffd_features	= 	__VM_UFFD_FLAGS,
+	.uffd_ioctls	= 	BIT(_UFFDIO_COPY) |
+				BIT(_UFFDIO_ZEROPAGE) |
+				BIT(_UFFDIO_WRITEPROTECT) |
+				BIT(_UFFDIO_CONTINUE) |
+				BIT(_UFFDIO_POISON),
+	.uffd_get_folio	=	shmem_uffd_get_folio,
+	.uffd_copy	=	shmem_mfill_atomic_pte,
+};
+#endif
+
 static const struct address_space_operations shmem_aops = {
 	.dirty_folio	= noop_dirty_folio,
 #ifdef CONFIG_TMPFS
@@ -5296,6 +5316,9 @@ static const struct vm_operations_struct shmem_vm_ops = {
 	.set_policy     = shmem_set_policy,
 	.get_policy     = shmem_get_policy,
 #endif
+#ifdef CONFIG_USERFAULTFD
+	.userfaultfd_ops = &shmem_uffd_ops,
+#endif
 };
 
 static const struct vm_operations_struct shmem_anon_vm_ops = {
@@ -5305,6 +5328,9 @@ static const struct vm_operations_struct shmem_anon_vm_ops = {
 	.set_policy     = shmem_set_policy,
 	.get_policy     = shmem_get_policy,
 #endif
+#ifdef CONFIG_USERFAULTFD
+	.userfaultfd_ops = &shmem_uffd_ops,
+#endif
 };
 
 int shmem_init_fs_context(struct fs_context *fc)
-- 
2.49.0


From fab8f8312982619ca80299d6cf35d5661cf61911 Mon Sep 17 00:00:00 2001
From: Peter Xu <peterx@redhat.com>
Date: Wed, 11 Jun 2025 10:18:40 -0400
Subject: [PATCH 3/4] mm/hugetlb: Support vm_uffd_ops API

Add support for the new vm_uffd_ops API for hugetlb.  Note that this only
introduces the support, the API is not yet used by core mm.

Cc: Muchun Song <muchun.song@linux.dev>
Cc: Oscar Salvador <osalvador@suse.de>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 mm/hugetlb.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 3d61ec17c15a..b9e473fab871 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -5459,6 +5459,22 @@ static vm_fault_t hugetlb_vm_op_fault(struct vm_fault *vmf)
 	return 0;
 }
 
+#ifdef CONFIG_USERFAULTFD
+static const vm_uffd_ops hugetlb_uffd_ops = {
+	.uffd_features	= 	__VM_UFFD_FLAGS,
+	/* _UFFDIO_ZEROPAGE not supported */
+	.uffd_ioctls	= 	BIT(_UFFDIO_COPY) |
+				BIT(_UFFDIO_WRITEPROTECT) |
+				BIT(_UFFDIO_CONTINUE) |
+				BIT(_UFFDIO_POISON),
+	/*
+	 * Hugetlbfs still has its own hard-coded handler in userfaultfd,
+	 * due to limitations similar to vm_operations_struct.fault().
+	 * TODO: generalize it to use the API functions.
+	 */
+};
+#endif
+
 /*
  * When a new function is introduced to vm_operations_struct and added
  * to hugetlb_vm_ops, please consider adding the function to shm_vm_ops.
@@ -5472,6 +5488,9 @@ const struct vm_operations_struct hugetlb_vm_ops = {
 	.close = hugetlb_vm_op_close,
 	.may_split = hugetlb_vm_op_split,
 	.pagesize = hugetlb_vm_op_pagesize,
+#ifdef CONFIG_USERFAULTFD
+	.userfaultfd_ops = &hugetlb_uffd_ops,
+#endif
 };
 
 static pte_t make_huge_pte(struct vm_area_struct *vma, struct folio *folio,
-- 
2.49.0


From de6ac50b189dc16b2d5759f67b32d528a6c9ccde Mon Sep 17 00:00:00 2001
From: Peter Xu <peterx@redhat.com>
Date: Thu, 12 Jun 2025 11:55:08 -0400
Subject: [PATCH 4/4] mm: Apply vm_uffd_ops API to core mm

This patch completely moves the old userfaultfd core to use the new
vm_uffd_ops API.  After this change, existing file systems will start to
use the new API for userfault operations.

When at it, moving vma_can_userfault() into mm/userfaultfd.c instead,
because it's getting too big.  It's only used in slow paths so it shouldn't
be an issue.

This will also remove quite some hard-coded checks for either shmem or
hugetlbfs.  Now all the old checks should still work but with vm_uffd_ops.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/linux/shmem_fs.h      |  14 -----
 include/linux/userfaultfd_k.h |  46 ++++----------
 mm/shmem.c                    |   2 +-
 mm/userfaultfd.c              | 115 +++++++++++++++++++++++++---------
 4 files changed, 101 insertions(+), 76 deletions(-)

diff --git a/include/linux/shmem_fs.h b/include/linux/shmem_fs.h
index 6d0f9c599ff7..2f5b7b295cf6 100644
--- a/include/linux/shmem_fs.h
+++ b/include/linux/shmem_fs.h
@@ -195,20 +195,6 @@ static inline pgoff_t shmem_fallocend(struct inode *inode, pgoff_t eof)
 extern bool shmem_charge(struct inode *inode, long pages);
 extern void shmem_uncharge(struct inode *inode, long pages);
 
-#ifdef CONFIG_USERFAULTFD
-#ifdef CONFIG_SHMEM
-extern int shmem_mfill_atomic_pte(pmd_t *dst_pmd,
-				  struct vm_area_struct *dst_vma,
-				  unsigned long dst_addr,
-				  unsigned long src_addr,
-				  uffd_flags_t flags,
-				  struct folio **foliop);
-#else /* !CONFIG_SHMEM */
-#define shmem_mfill_atomic_pte(dst_pmd, dst_vma, dst_addr, \
-			       src_addr, flags, foliop) ({ BUG(); 0; })
-#endif /* CONFIG_SHMEM */
-#endif /* CONFIG_USERFAULTFD */
-
 /*
  * Used space is stored as unsigned 64-bit value in bytes but
  * quota core supports only signed 64-bit values so use that
diff --git a/include/linux/userfaultfd_k.h b/include/linux/userfaultfd_k.h
index e79c724b3b95..4e56ad423a4a 100644
--- a/include/linux/userfaultfd_k.h
+++ b/include/linux/userfaultfd_k.h
@@ -85,9 +85,14 @@ extern vm_fault_t handle_userfault(struct vm_fault *vmf, unsigned long reason);
 #define MFILL_ATOMIC_FLAG(nr) ((__force uffd_flags_t) MFILL_ATOMIC_BIT(nr))
 #define MFILL_ATOMIC_MODE_MASK ((__force uffd_flags_t) (MFILL_ATOMIC_BIT(0) - 1))
 
+static inline enum mfill_atomic_mode uffd_flags_get_mode(uffd_flags_t flags)
+{
+	return (enum mfill_atomic_mode)(flags & MFILL_ATOMIC_MODE_MASK);
+}
+
 static inline bool uffd_flags_mode_is(uffd_flags_t flags, enum mfill_atomic_mode expected)
 {
-	return (flags & MFILL_ATOMIC_MODE_MASK) == ((__force uffd_flags_t) expected);
+	return uffd_flags_get_mode(flags) == expected;
 }
 
 static inline uffd_flags_t uffd_flags_set_mode(uffd_flags_t flags, enum mfill_atomic_mode mode)
@@ -196,41 +201,16 @@ static inline bool userfaultfd_armed(struct vm_area_struct *vma)
 	return vma->vm_flags & __VM_UFFD_FLAGS;
 }
 
-static inline bool vma_can_userfault(struct vm_area_struct *vma,
-				     unsigned long vm_flags,
-				     bool wp_async)
+static inline const vm_uffd_ops *vma_get_uffd_ops(struct vm_area_struct *vma)
 {
-	vm_flags &= __VM_UFFD_FLAGS;
-
-	if (vma->vm_flags & VM_DROPPABLE)
-		return false;
-
-	if ((vm_flags & VM_UFFD_MINOR) &&
-	    (!is_vm_hugetlb_page(vma) && !vma_is_shmem(vma)))
-		return false;
-
-	/*
-	 * If wp async enabled, and WP is the only mode enabled, allow any
-	 * memory type.
-	 */
-	if (wp_async && (vm_flags == VM_UFFD_WP))
-		return true;
-
-#ifndef CONFIG_PTE_MARKER_UFFD_WP
-	/*
-	 * If user requested uffd-wp but not enabled pte markers for
-	 * uffd-wp, then shmem & hugetlbfs are not supported but only
-	 * anonymous.
-	 */
-	if ((vm_flags & VM_UFFD_WP) && !vma_is_anonymous(vma))
-		return false;
-#endif
-
-	/* By default, allow any of anon|shmem|hugetlb */
-	return vma_is_anonymous(vma) || is_vm_hugetlb_page(vma) ||
-	    vma_is_shmem(vma);
+	if (vma->vm_ops && vma->vm_ops->userfaultfd_ops)
+		return vma->vm_ops->userfaultfd_ops;
+	return NULL;
 }
 
+bool vma_can_userfault(struct vm_area_struct *vma,
+		       unsigned long vm_flags, bool wp_async);
+
 static inline bool vma_has_uffd_without_event_remap(struct vm_area_struct *vma)
 {
 	struct userfaultfd_ctx *uffd_ctx = vma->vm_userfaultfd_ctx.ctx;
diff --git a/mm/shmem.c b/mm/shmem.c
index bd0a29000318..4d71fc7be358 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -3158,7 +3158,7 @@ static int shmem_uffd_get_folio(struct inode *inode, pgoff_t pgoff,
 	return shmem_get_folio(inode, pgoff, 0, folio, SGP_NOALLOC);
 }
 
-int shmem_mfill_atomic_pte(pmd_t *dst_pmd,
+static int shmem_mfill_atomic_pte(pmd_t *dst_pmd,
 			   struct vm_area_struct *dst_vma,
 			   unsigned long dst_addr,
 			   unsigned long src_addr,
diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index 879505c6996f..61783ff2d335 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -14,12 +14,48 @@
 #include <linux/userfaultfd_k.h>
 #include <linux/mmu_notifier.h>
 #include <linux/hugetlb.h>
-#include <linux/shmem_fs.h>
 #include <asm/tlbflush.h>
 #include <asm/tlb.h>
 #include "internal.h"
 #include "swap.h"
 
+bool vma_can_userfault(struct vm_area_struct *vma,
+		       unsigned long vm_flags, bool wp_async)
+{
+	unsigned long supported;
+
+	if (vma->vm_flags & VM_DROPPABLE)
+		return false;
+
+	vm_flags &= __VM_UFFD_FLAGS;
+
+#ifndef CONFIG_PTE_MARKER_UFFD_WP
+	/*
+	 * If user requested uffd-wp but not enabled pte markers for
+	 * uffd-wp, then any file system (like shmem or hugetlbfs) are not
+	 * supported but only anonymous.
+	 */
+	if ((vm_flags & VM_UFFD_WP) && !vma_is_anonymous(vma))
+		return false;
+#endif
+	/*
+	 * If wp async enabled, and WP is the only mode enabled, allow any
+	 * memory type.
+	 */
+	if (wp_async && (vm_flags == VM_UFFD_WP))
+		return true;
+
+	if (vma_is_anonymous(vma))
+		/* Anonymous has no page cache, MINOR not supported */
+		supported = VM_UFFD_MISSING | VM_UFFD_WP;
+	else if (vma_get_uffd_ops(vma))
+		supported = vma_get_uffd_ops(vma)->uffd_features;
+	else
+		return false;
+
+	return !(vm_flags & (~supported));
+}
+
 static __always_inline
 bool validate_dst_vma(struct vm_area_struct *dst_vma, unsigned long dst_end)
 {
@@ -384,11 +420,15 @@ static int mfill_atomic_pte_continue(pmd_t *dst_pmd,
 {
 	struct inode *inode = file_inode(dst_vma->vm_file);
 	pgoff_t pgoff = linear_page_index(dst_vma, dst_addr);
+	const vm_uffd_ops *uffd_ops = vma_get_uffd_ops(dst_vma);
 	struct folio *folio;
 	struct page *page;
 	int ret;
 
-	ret = shmem_get_folio(inode, pgoff, 0, &folio, SGP_NOALLOC);
+	if (WARN_ON_ONCE(!uffd_ops || !uffd_ops->uffd_get_folio))
+		return -EINVAL;
+
+	ret = uffd_ops->uffd_get_folio(inode, pgoff, &folio);
 	/* Our caller expects us to return -EFAULT if we failed to find folio */
 	if (ret == -ENOENT)
 		ret = -EFAULT;
@@ -504,18 +544,6 @@ static __always_inline ssize_t mfill_atomic_hugetlb(
 	u32 hash;
 	struct address_space *mapping;
 
-	/*
-	 * There is no default zero huge page for all huge page sizes as
-	 * supported by hugetlb.  A PMD_SIZE huge pages may exist as used
-	 * by THP.  Since we can not reliably insert a zero page, this
-	 * feature is not supported.
-	 */
-	if (uffd_flags_mode_is(flags, MFILL_ATOMIC_ZEROPAGE)) {
-		up_read(&ctx->map_changing_lock);
-		uffd_mfill_unlock(dst_vma);
-		return -EINVAL;
-	}
-
 	src_addr = src_start;
 	dst_addr = dst_start;
 	copied = 0;
@@ -686,14 +714,55 @@ static __always_inline ssize_t mfill_atomic_pte(pmd_t *dst_pmd,
 			err = mfill_atomic_pte_zeropage(dst_pmd,
 						 dst_vma, dst_addr);
 	} else {
-		err = shmem_mfill_atomic_pte(dst_pmd, dst_vma,
-					     dst_addr, src_addr,
-					     flags, foliop);
+		const vm_uffd_ops *uffd_ops = vma_get_uffd_ops(dst_vma);
+
+		if (WARN_ON_ONCE(!uffd_ops || !uffd_ops->uffd_copy)) {
+			err = -EINVAL;
+		} else {
+			err = uffd_ops->uffd_copy(dst_pmd, dst_vma,
+						  dst_addr, src_addr,
+						  flags, foliop);
+		}
 	}
 
 	return err;
 }
 
+static inline bool
+vma_uffd_ops_supported(struct vm_area_struct *vma, uffd_flags_t flags)
+{
+	enum mfill_atomic_mode mode = uffd_flags_get_mode(flags);
+	const vm_uffd_ops *uffd_ops;
+	unsigned long uffd_ioctls;
+
+	if ((flags & MFILL_ATOMIC_WP) && !(vma->vm_flags & VM_UFFD_WP))
+		return false;
+
+	/* Anonymous supports everything except CONTINUE */
+	if (vma_is_anonymous(vma))
+		return mode != MFILL_ATOMIC_CONTINUE;
+
+	uffd_ops = vma_get_uffd_ops(vma);
+	if (!uffd_ops)
+		return false;
+
+	uffd_ioctls = uffd_ops->uffd_ioctls;
+	switch (mode) {
+	case MFILL_ATOMIC_COPY:
+		return uffd_ioctls & BIT(_UFFDIO_COPY);
+	case MFILL_ATOMIC_ZEROPAGE:
+		return uffd_ioctls & BIT(_UFFDIO_ZEROPAGE);
+	case MFILL_ATOMIC_CONTINUE:
+		if (!(vma->vm_flags & VM_SHARED))
+			return false;
+		return uffd_ioctls & BIT(_UFFDIO_CONTINUE);
+	case MFILL_ATOMIC_POISON:
+		return uffd_ioctls & BIT(_UFFDIO_POISON);
+	default:
+		return false;
+	}
+}
+
 static __always_inline ssize_t mfill_atomic(struct userfaultfd_ctx *ctx,
 					    unsigned long dst_start,
 					    unsigned long src_start,
@@ -752,11 +821,7 @@ static __always_inline ssize_t mfill_atomic(struct userfaultfd_ctx *ctx,
 	    dst_vma->vm_flags & VM_SHARED))
 		goto out_unlock;
 
-	/*
-	 * validate 'mode' now that we know the dst_vma: don't allow
-	 * a wrprotect copy if the userfaultfd didn't register as WP.
-	 */
-	if ((flags & MFILL_ATOMIC_WP) && !(dst_vma->vm_flags & VM_UFFD_WP))
+	if (!vma_uffd_ops_supported(dst_vma, flags))
 		goto out_unlock;
 
 	/*
@@ -766,12 +831,6 @@ static __always_inline ssize_t mfill_atomic(struct userfaultfd_ctx *ctx,
 		return  mfill_atomic_hugetlb(ctx, dst_vma, dst_start,
 					     src_start, len, flags);
 
-	if (!vma_is_anonymous(dst_vma) && !vma_is_shmem(dst_vma))
-		goto out_unlock;
-	if (!vma_is_shmem(dst_vma) &&
-	    uffd_flags_mode_is(flags, MFILL_ATOMIC_CONTINUE))
-		goto out_unlock;
-
 	while (src_addr < src_start + len) {
 		pmd_t dst_pmdval;
 
-- 
2.49.0


-- 
Peter Xu


