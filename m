Return-Path: <linux-fsdevel+bounces-8390-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C772835B6D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Jan 2024 08:13:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 82A57281846
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Jan 2024 07:13:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A872EFBF3;
	Mon, 22 Jan 2024 07:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UsWEKk8r"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6881FBE1
	for <linux-fsdevel@vger.kernel.org>; Mon, 22 Jan 2024 07:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705907611; cv=none; b=V/Tyu+s7tLedbn4c1B6MSr7F/5btlW50xfYEbfg6H0MnCHs7vTSOY4asSGWa3KVliu3snX6ZG6Lo9FutNM67Ej3KYaWGL/heDhyQNpVYLxLxsiCQd9DYATfxDNfyKiAkR4hUF5ny1X5SZGNjtO3kSsFvCTbKNqCYZMDLtxqf9Oo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705907611; c=relaxed/simple;
	bh=6Lrv5xwMfaDaPsl1VCKPLCnIY6z/5ht1dxDtK8LPTm4=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=V9wsm3ztT9VWNqCjDNnus0HI32D6SbMDbj7T2N23snCHTD0FAPKOQKNajl0rnoagpZN1DmYSqps4LbM73GOUoZOpePJhVDV83BG6kssf1xAml3TUWb9FHtW2JWeQZs8IqoHoveKOpo0fkRTtJjnkr9CorbffkzlFDURbYvR05SU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UsWEKk8r; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-5f38d676cecso43397347b3.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 21 Jan 2024 23:13:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1705907608; x=1706512408; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=oXyU4pkvCRYAyA2TUvsUC8dh5sAPzBBH4qagn6tOpF0=;
        b=UsWEKk8rXs+hKbDWocKQBdrDKXKhfh7jxYSGJNpmt/g5n6Ib5Uh7cFCdtwF1uBsKIo
         6bV0X98CVkYYVLY2A8uEkBhzAv5kYDxH8nsK+7P9lARMQCWcL7k4auaMiQ0OacLPjz8J
         22aphKXRcuApyh1s4BwTpO8M++11answPeB7Z4GtcZP+d1V+0X+EfzxgcfhAzKXC7hxA
         lNlWWZp0M+PPptivUqVxF8iO+FulNtCQyaQO9LtolBByrN9Z+w9YkmQX+JaTn9O7VOAk
         IPNA3xX69jCFo65s2A7SJ9YqakfeYuAO2S3UNxVv3zeckadO/eSh7ZZ3CXtmsRdaqwlQ
         p5oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705907608; x=1706512408;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oXyU4pkvCRYAyA2TUvsUC8dh5sAPzBBH4qagn6tOpF0=;
        b=RU/Jpfw87vKaJOhuz05Bqx/lINjzsGl5CoNZCubGNyvYkvsqnOmp/XvpDVXGDkAVz+
         WjfNnqxFAHCoU4bys4HrLVT2zFv6RUKjisp7SPKVpeuvhT1FXkP+2NPKliwkpC85w4T5
         B5zlgn/7QCHYSaIq6XgJAbAdPRC3DLDmeq+NTrlpvRsscpBZ3nVrt4ubduDnvILAlgtV
         8zewiWbzLA5t2Jl5IcdE9eeOL32n4/3qmLPU4QuEc0CaKjV0M/SaciSrTj/IkvunHcqR
         eXNDS5MWNV7DisDEmsaoVFM2RG/uJCakzigQ3hY9QOfFAx8ISOTTosszByTivi2/vq/j
         VVrg==
X-Gm-Message-State: AOJu0YwiLEpPX5iTgqNKtZc3ezHz5iDwNlucJEmRkteuv5Yhwuup4MN9
	4BSufOOYMd01ejxG9L7bNh9ks4wL4mBjnQSOlQQ3AU6uZ6sPoXQkzxnlBmLWWMB0yBIIcojo95e
	g9Q==
X-Google-Smtp-Source: AGHT+IG8d1Gn9VWPvChN4p2/RHkaCghVVAROZ7VOgDGN0KGJpb0phlIzNaSwlCWzvJeInLF/vdqx3fCBkG0=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:4979:1d79:d572:5708])
 (user=surenb job=sendgmr) by 2002:a25:e90c:0:b0:dbe:49ca:eb03 with SMTP id
 n12-20020a25e90c000000b00dbe49caeb03mr1889847ybd.5.1705907608657; Sun, 21 Jan
 2024 23:13:28 -0800 (PST)
Date: Sun, 21 Jan 2024 23:13:22 -0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
Message-ID: <20240122071324.2099712-1-surenb@google.com>
Subject: [PATCH 1/3] mm: make vm_area_struct anon_name field RCU-safe
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
	yangxingui@huawei.com, keescook@chromium.org, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, kernel-team@android.com, 
	surenb@google.com
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


