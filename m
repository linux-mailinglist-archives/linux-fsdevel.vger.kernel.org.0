Return-Path: <linux-fsdevel+bounces-8627-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E67A9839CEE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jan 2024 00:10:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D6E77B2407C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Jan 2024 23:10:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64DE853E2A;
	Tue, 23 Jan 2024 23:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="O1nssBkc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 498F2210F6
	for <linux-fsdevel@vger.kernel.org>; Tue, 23 Jan 2024 23:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706051419; cv=none; b=iEZlRDIX9X/n7qjoljdNkQVleTOWr+6UQedauhOoLPkh6w/AHpw6lW/IcEi6rEknjpP0R+W5Q31NRCM4QXeM6cdgNVoMOB9yhycaK8YQHublroXuq7hsKpO/rCpGWcdSGI5VyM6XBemNmY6PvAXokCMhepZoYs79ZdiBoSLEwrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706051419; c=relaxed/simple;
	bh=6Lrv5xwMfaDaPsl1VCKPLCnIY6z/5ht1dxDtK8LPTm4=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=eMi9eTZ8P2wL/7HbvQpeOMkA7dGCpyEVRC/UMrx6/hKsJRwiFBoGxhY8yw1RVz9Frk0w7rfSeM0Sl4BM2issNurjmdKsWCZl0OaElmfqBVkJcIShU4rtRGtYKjlyvsKlvQbgeA444SavhPFPAZWDcFcBK2qwuNE5jj+D7gU2OTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=O1nssBkc; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dbf618042daso6312493276.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 23 Jan 2024 15:10:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706051417; x=1706656217; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=oXyU4pkvCRYAyA2TUvsUC8dh5sAPzBBH4qagn6tOpF0=;
        b=O1nssBkcERP8HuhOfwNn0vUzKmXVyfovdquN26R/RqtuCtHs4lbLLYf0FEFka3ba1l
         l4qd8TAShqCSlMRjozCdOopTxWnplFUMF11Q3uZvlQ9S/KAiCRDNx+SU+4mLaFzfTv/w
         DSPnPrzw37OFUkBxNR0dyQJOOx8pSn5Rv2hmYVxixdEOre8L0jvkc9cFWu2z3AVi2GNn
         x4GYNIvO+Wr9dl6aMcO/QC66BMmErtSY0ZDdmy0uWqK0/aLnu0+QoZ7QS+4k4qdMk8AC
         HXeyNmgjoVPTvPVOjeD5GhEn+/d5xXADZ1viPwn4av184uQLBBRuv+5vCsP5OyIjgB89
         8Fzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706051417; x=1706656217;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oXyU4pkvCRYAyA2TUvsUC8dh5sAPzBBH4qagn6tOpF0=;
        b=KlwbwuRI9+BmUbSd7KF97XuBV9Ho0oUXA4jm/91tVi4wBJuFfcS8FmTOkkc+7VaayJ
         WxpBVqC42r915M4beXcacNupsC3tJ0zpt/vyWdRahFaR3WVSMw7KyXboY6fldWjQwPC0
         3tGS1uNtyXzq8keMAE9APCmxLF5/c/qob4FbK48Q9TXVOpHCFx5NCobDk2nBYnDpQp/V
         viP81EqPe2ZJoR2G/UfAs5Wjp/dThR/ZU7D54mkgMfel4ab8uP33wlAbQyBCtbBMKm8J
         7nkVQGOE7UHgoV9lzO0kiqJUHAyinq4oGeCwdmKUfvw2/VQLLtQiZ14lR+D8qUrlzg4i
         dSSQ==
X-Gm-Message-State: AOJu0Yz0Padcsiok5R7SK0K4P+tF3sjqE46sA/Oj7gH9twyt1R5CS09F
	IK1F6Swfw75fzCk+h1y3XJwqsBFTouthFw59CbZUs8zY4qBL8cwpsUIEKzZnzv6s1ZSIfmGdcE0
	ilg==
X-Google-Smtp-Source: AGHT+IEgxI304pcV7zFy8N/84TxapaHhJhR9pXZLWhwJ6Iatmm8yKLxxB6dJA4KRTnvXodtXbWXNbbtsUkg=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:8fc3:c34f:d407:388])
 (user=surenb job=sendgmr) by 2002:a05:6902:218b:b0:dc2:5456:d9ac with SMTP id
 dl11-20020a056902218b00b00dc25456d9acmr377765ybb.5.1706051417317; Tue, 23 Jan
 2024 15:10:17 -0800 (PST)
Date: Tue, 23 Jan 2024 15:10:12 -0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
Message-ID: <20240123231014.3801041-1-surenb@google.com>
Subject: [PATCH v2 1/3] mm: make vm_area_struct anon_name field RCU-safe
From: Suren Baghdasaryan <surenb@google.com>
To: akpm@linux-foundation.org
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz, 
	dchinner@redhat.com, casey@schaufler-ca.com, ben.wolsieffer@hefring.com, 
	paulmck@kernel.org, david@redhat.com, avagin@google.com, 
	usama.anjum@collabora.com, peterx@redhat.com, hughd@google.com, 
	ryan.roberts@arm.com, wangkefeng.wang@huawei.com, Liam.Howlett@Oracle.com, 
	yuzhao@google.com, axelrasmussen@google.com, lstoakes@gmail.com, 
	talumbau@google.com, willy@infradead.org, vbabka@suse.cz, 
	mgorman@techsingularity.net, jhubbard@nvidia.com, vishal.moola@gmail.com, 
	mathieu.desnoyers@efficios.com, dhowells@redhat.com, jgg@ziepe.ca, 
	sidhartha.kumar@oracle.com, andriy.shevchenko@linux.intel.com, 
	yangxingui@huawei.com, keescook@chromium.org, sj@kernel.org, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org, kernel-team@android.com, surenb@google.com
Content-Type: text/plain; charset="UTF-8"

For lockless /proc/pid/maps reading we have to ensure all the fields
used when generating the output are RCU-safe. The only pointer fields
in vm_area_struct which are used to generate that file's output are
vm_file and anon_name. vm_file is RCU-safe but anon_name is not. Make
anon_name RCU-safe as well.

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 include/linux/mm_inline.h | 10 +++++++++-
 include/linux/mm_types.h  |  3 ++-
 mm/madvise.c              | 30 ++++++++++++++++++++++++++----
 3 files changed, 37 insertions(+), 6 deletions(-)

diff --git a/include/linux/mm_inline.h b/include/linux/mm_inline.h
index f4fe593c1400..bbdb0ca857f1 100644
--- a/include/linux/mm_inline.h
+++ b/include/linux/mm_inline.h
@@ -389,7 +389,7 @@ static inline void dup_anon_vma_name(struct vm_area_struct *orig_vma,
 	struct anon_vma_name *anon_name = anon_vma_name(orig_vma);
 
 	if (anon_name)
-		new_vma->anon_name = anon_vma_name_reuse(anon_name);
+		rcu_assign_pointer(new_vma->anon_name, anon_vma_name_reuse(anon_name));
 }
 
 static inline void free_anon_vma_name(struct vm_area_struct *vma)
@@ -411,6 +411,8 @@ static inline bool anon_vma_name_eq(struct anon_vma_name *anon_name1,
 		!strcmp(anon_name1->name, anon_name2->name);
 }
 
+struct anon_vma_name *anon_vma_name_get_rcu(struct vm_area_struct *vma);
+
 #else /* CONFIG_ANON_VMA_NAME */
 static inline void anon_vma_name_get(struct anon_vma_name *anon_name) {}
 static inline void anon_vma_name_put(struct anon_vma_name *anon_name) {}
@@ -424,6 +426,12 @@ static inline bool anon_vma_name_eq(struct anon_vma_name *anon_name1,
 	return true;
 }
 
+static inline
+struct anon_vma_name *anon_vma_name_get_rcu(struct vm_area_struct *vma)
+{
+	return NULL;
+}
+
 #endif  /* CONFIG_ANON_VMA_NAME */
 
 static inline void init_tlb_flush_pending(struct mm_struct *mm)
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 8b611e13153e..bbe1223cd992 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -545,6 +545,7 @@ struct vm_userfaultfd_ctx {};
 
 struct anon_vma_name {
 	struct kref kref;
+	struct rcu_head rcu;
 	/* The name needs to be at the end because it is dynamically sized. */
 	char name[];
 };
@@ -699,7 +700,7 @@ struct vm_area_struct {
 	 * terminated string containing the name given to the vma, or NULL if
 	 * unnamed. Serialized by mmap_lock. Use anon_vma_name to access.
 	 */
-	struct anon_vma_name *anon_name;
+	struct anon_vma_name __rcu *anon_name;
 #endif
 #ifdef CONFIG_SWAP
 	atomic_long_t swap_readahead_info;
diff --git a/mm/madvise.c b/mm/madvise.c
index 912155a94ed5..0f222d464254 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -88,14 +88,15 @@ void anon_vma_name_free(struct kref *kref)
 {
 	struct anon_vma_name *anon_name =
 			container_of(kref, struct anon_vma_name, kref);
-	kfree(anon_name);
+	kfree_rcu(anon_name, rcu);
 }
 
 struct anon_vma_name *anon_vma_name(struct vm_area_struct *vma)
 {
 	mmap_assert_locked(vma->vm_mm);
 
-	return vma->anon_name;
+	return rcu_dereference_protected(vma->anon_name,
+		rwsem_is_locked(&vma->vm_mm->mmap_lock));
 }
 
 /* mmap_lock should be write-locked */
@@ -105,7 +106,7 @@ static int replace_anon_vma_name(struct vm_area_struct *vma,
 	struct anon_vma_name *orig_name = anon_vma_name(vma);
 
 	if (!anon_name) {
-		vma->anon_name = NULL;
+		rcu_assign_pointer(vma->anon_name, NULL);
 		anon_vma_name_put(orig_name);
 		return 0;
 	}
@@ -113,11 +114,32 @@ static int replace_anon_vma_name(struct vm_area_struct *vma,
 	if (anon_vma_name_eq(orig_name, anon_name))
 		return 0;
 
-	vma->anon_name = anon_vma_name_reuse(anon_name);
+	rcu_assign_pointer(vma->anon_name, anon_vma_name_reuse(anon_name));
 	anon_vma_name_put(orig_name);
 
 	return 0;
 }
+
+/*
+ * Returned anon_vma_name is stable due to elevated refcount but not guaranteed
+ * to be assigned to the original VMA after the call.
+ */
+struct anon_vma_name *anon_vma_name_get_rcu(struct vm_area_struct *vma)
+{
+	struct anon_vma_name __rcu *anon_name;
+
+	WARN_ON_ONCE(!rcu_read_lock_held());
+
+	anon_name = rcu_dereference(vma->anon_name);
+	if (!anon_name)
+		return NULL;
+
+	if (unlikely(!kref_get_unless_zero(&anon_name->kref)))
+		return NULL;
+
+	return anon_name;
+}
+
 #else /* CONFIG_ANON_VMA_NAME */
 static int replace_anon_vma_name(struct vm_area_struct *vma,
 				 struct anon_vma_name *anon_name)
-- 
2.43.0.429.g432eaa2c6b-goog


