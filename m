Return-Path: <linux-fsdevel+bounces-27910-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 590BC964C5A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 19:00:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 022371F23868
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 17:00:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7C3A1B8EA0;
	Thu, 29 Aug 2024 16:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b1APO7w8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5F5E1B5EC0
	for <linux-fsdevel@vger.kernel.org>; Thu, 29 Aug 2024 16:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724950703; cv=none; b=oFufLtS3+pCBPTTYDL8cZ4rYIQfHy3juYdHmZmTbBWWWHOHif/xEt+mjbpZhJCmum0TmpzDc7ri4qlauqXAK8GgNILf6SS3Z9CP3VFzx7K/847ki8Rr4ZZwtL8k5XGyjXzH5GBJ0P7aaImcQwp8VCWiSiHMi4Oo2jVgN9FlCgjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724950703; c=relaxed/simple;
	bh=UuijIfSkIYxacK7S1A3ExjdxI/m7orsRsHG6HPl7Su4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Uhm3UnNfsWz/8NrAM8ymXt2Ji3reHIPWN+Slwxrc3jqz8HTjoe0iKYInJidDeiR8ErHPC3ACrXI7/1O4ZavpLw3bcgeG0+OOYwtFw/mURfGy014EAM1afGy2Qgm2IsszuGRCU2WHVQlYl0krpelVko79g0FKuTTNyEcXAwL3ja0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=b1APO7w8; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724950700;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UScoC5uAD98XoEORkSS5jabd7Wa591naPepP4SsdqqM=;
	b=b1APO7w8Lqgw4d/9gY+tm4R8XJGo4sDhdUdu5sh4DLObD2nv3nS8rtNRprpwd8NtDN+5We
	7BcKEojS9uXHplv/IA35+ZLFjxi9B0ZLnai/oILQmZqGMNKYKPwId4EUM+oo07MJOd/NB6
	gPDCgyACIXcZZAJPzfIgYGiSH2Po9y8=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-627-7nh5CtHIOOCFSuu-GrSw3g-1; Thu,
 29 Aug 2024 12:58:17 -0400
X-MC-Unique: 7nh5CtHIOOCFSuu-GrSw3g-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C41D8191379F;
	Thu, 29 Aug 2024 16:58:14 +0000 (UTC)
Received: from t14s.redhat.com (unknown [10.39.193.245])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id AB5951955F66;
	Thu, 29 Aug 2024 16:58:03 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org,
	cgroups@vger.kernel.org,
	x86@kernel.org,
	linux-fsdevel@vger.kernel.org,
	David Hildenbrand <david@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Tejun Heo <tj@kernel.org>,
	Zefan Li <lizefan.x@bytedance.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Andy Lutomirski <luto@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>
Subject: [PATCH v1 09/17] bit_spinlock: __always_inline (un)lock functions
Date: Thu, 29 Aug 2024 18:56:12 +0200
Message-ID: <20240829165627.2256514-10-david@redhat.com>
In-Reply-To: <20240829165627.2256514-1-david@redhat.com>
References: <20240829165627.2256514-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

The compiler might decide that it is a smart idea to not inline
bit_spin_lock(), primarily when a couple of functions in the same file end
up calling it. Especially when used in RMAP context, this can negatively
affect fork() performance, where each additional function call is
noticeable.

Let's simply flag all lock/unlock functions as __always_inline;
arch_test_and_set_bit_lock() and friends are already tagged like that
(but not test_and_set_bit_lock() for some reason).

If ever a problem, we could split it into a fast and a slow path, and
only force the fast path to be inlined. But there is nothing
particularly "big" here.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 include/linux/bit_spinlock.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/linux/bit_spinlock.h b/include/linux/bit_spinlock.h
index bbc4730a6505c..c0989b5b0407f 100644
--- a/include/linux/bit_spinlock.h
+++ b/include/linux/bit_spinlock.h
@@ -13,7 +13,7 @@
  * Don't use this unless you really need to: spin_lock() and spin_unlock()
  * are significantly faster.
  */
-static inline void bit_spin_lock(int bitnum, unsigned long *addr)
+static __always_inline void bit_spin_lock(int bitnum, unsigned long *addr)
 {
 	/*
 	 * Assuming the lock is uncontended, this never enters
@@ -38,7 +38,7 @@ static inline void bit_spin_lock(int bitnum, unsigned long *addr)
 /*
  * Return true if it was acquired
  */
-static inline int bit_spin_trylock(int bitnum, unsigned long *addr)
+static __always_inline int bit_spin_trylock(int bitnum, unsigned long *addr)
 {
 	preempt_disable();
 #if defined(CONFIG_SMP) || defined(CONFIG_DEBUG_SPINLOCK)
@@ -54,7 +54,7 @@ static inline int bit_spin_trylock(int bitnum, unsigned long *addr)
 /*
  *  bit-based spin_unlock()
  */
-static inline void bit_spin_unlock(int bitnum, unsigned long *addr)
+static __always_inline void bit_spin_unlock(int bitnum, unsigned long *addr)
 {
 #ifdef CONFIG_DEBUG_SPINLOCK
 	BUG_ON(!test_bit(bitnum, addr));
@@ -71,7 +71,7 @@ static inline void bit_spin_unlock(int bitnum, unsigned long *addr)
  *  non-atomic version, which can be used eg. if the bit lock itself is
  *  protecting the rest of the flags in the word.
  */
-static inline void __bit_spin_unlock(int bitnum, unsigned long *addr)
+static __always_inline void __bit_spin_unlock(int bitnum, unsigned long *addr)
 {
 #ifdef CONFIG_DEBUG_SPINLOCK
 	BUG_ON(!test_bit(bitnum, addr));
-- 
2.46.0


