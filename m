Return-Path: <linux-fsdevel+bounces-42963-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 074EFA4C7FC
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Mar 2025 17:47:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4AAAA3ADA73
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Mar 2025 16:45:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B509225CC70;
	Mon,  3 Mar 2025 16:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AZ+TbZb1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 297422566CC
	for <linux-fsdevel@vger.kernel.org>; Mon,  3 Mar 2025 16:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741019469; cv=none; b=b6PA8L1bbKFDVy4AtJuOH1LTjKb9Y4P7tjYV01elE50fjWWMNKx/7g3jkTac282CUmDiW2v/rYvJzAaA4LJZETvitpsI4s98+nKanVHa/HRxGa8CVFeyOKWoD5f0NUfNXkVmLXyG2cU81NpBcp2JI73DFvgJLYuOQCpd4xTK+AE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741019469; c=relaxed/simple;
	bh=OBXpWDsR7o4dKf8NkhRON4PwL/H6iQiwplPc25GckEo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qhX3Cs4XNldRvG+TlCrXICRdWth1vCAA9g4ldfGwyRyHHvHAlIatXygxmGx+gD3I9CltazDcDor+V/uiymxet93qcrIhl3hF5e2zfw6Wtt5mqy9mubfGT7/MiPMm6SIOqMbWQUAW/S0VhN2KOykx6tgeeR/P4pm9+JGwx8+PVA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AZ+TbZb1; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741019465;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VusPlBbKEOGpL4wS1BqoWY6CYb2f4HQ+/wIDh8p+vAo=;
	b=AZ+TbZb1tiNAxhTzbGbH4cMY8FhyfQhjRT4+Agg2q8F4inMcps5znp7kHLuJzhp2cyz856
	ftyOazxDOfVEBHy3Bq6wUaLIYGjaq6mP+VjHbk80ok05Fu0rBpMuPk0VcDCvf3vzZAW5jy
	wc54jCaQ6Wn16t9wWzjjzwH6j0wjGUI=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-354-o3g_2AdPM060c-YwQ-bKYA-1; Mon, 03 Mar 2025 11:30:42 -0500
X-MC-Unique: o3g_2AdPM060c-YwQ-bKYA-1
X-Mimecast-MFC-AGG-ID: o3g_2AdPM060c-YwQ-bKYA_1741019441
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4394040fea1so22860845e9.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 03 Mar 2025 08:30:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741019441; x=1741624241;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VusPlBbKEOGpL4wS1BqoWY6CYb2f4HQ+/wIDh8p+vAo=;
        b=LsoyuEJ1dVJFdfLf+D98mSCVeSYvQyclPrFbbwobZobinTrV7+j685HylZbiQ8hif5
         oJ7iNfv+Azp/Uderjct/K2NMnq9jeoJBO+8BCr1y0wSsP/jxl7ruUIq8v4bnImzxBLRN
         OJbvhrS1fXFHwL3XwzBu2UsU5MUKWtZ4MNM2g6dkxiclTjq1FJ+TkWY7uOg3fYdf7ug+
         xfSbZcd/l34ZHhIHFwSppyXb82wieBsk0GC/l41ntzva+aEgWtFm2XgQ8/HEq5xSSEwq
         v8dBuw8Ad0cNPtV7nNDCk4Usfu7G5GAWx3iOwUoNt56iGuB/LjVxeM8qbxDr4K1q7o0t
         QwCQ==
X-Forwarded-Encrypted: i=1; AJvYcCXANFaUb+m1s5Yxz9HskN4DDOWTmIN6XUlig4ve2ZJWqpNqfJqHlWJUKI43KmpR3HjIXQBsZpRBe/MccINh@vger.kernel.org
X-Gm-Message-State: AOJu0YzIZpJJiiWuBZo55GvFzftpUw9/qcwp1DojHaiNVi/qOvRyMYGx
	NyUDXazBqV2+MBxLxDCO5KXbGB8RywtJ6BYXvNNYQWtVeBN9Yv845HKke5+PHK/JBVCt/gCO4gq
	90nLduz0xOImXyxhjQ0/oRfm41ySalKpfNKcNdTrwS9vKZZmiomKaP6f9qHyNew8=
X-Gm-Gg: ASbGncu4TpTnSEv8HJjj8eCiwJgUJmMlO28COUZnIsGDMC2ttB2dC3oXI7TZW0GHw1a
	ZEwvr5557H2il3MlF0/X4i4Ez64doAPbRQCNzdTu4GLg98WjSZId/BkZaNBTP+j7mxJqdb7MuB3
	ho7+yo/3f2Kehq9GOflcu7wvEMJc6T5KkjUx8d3cVk9z9QnAWgeziwLjwO8RhNnAsu0woGTzmKF
	tvoZSYptzhaQ0vLldMONjR0G3Y23Ga9buvC9+Sc+8fZ2gry+DS3OIjD0BLAJdd+b8LqH8MWUlPW
	vJ99QQ0RHB7KPKVdPbuAvTAfo6CtDuWkrR3o+zihUqcGNbFQfyHY/CK2Kt4WyexYQQyj+0BEAC/
	E
X-Received: by 2002:a05:600c:26c6:b0:43b:bb72:1dce with SMTP id 5b1f17b1804b1-43bbb721f8fmr44417305e9.5.1741019441207;
        Mon, 03 Mar 2025 08:30:41 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF6XV9dtRCnC9UYnKtk79gh146334CB5ZefECKJp7wi6xxTybGeqstnFZTU3vfWQysm8+TPqw==
X-Received: by 2002:a05:600c:26c6:b0:43b:bb72:1dce with SMTP id 5b1f17b1804b1-43bbb721f8fmr44417035e9.5.1741019440886;
        Mon, 03 Mar 2025 08:30:40 -0800 (PST)
Received: from localhost (p200300cbc7349600af274326a2162bfb.dip0.t-ipconnect.de. [2003:cb:c734:9600:af27:4326:a216:2bfb])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-43bc1b5db02sm42954325e9.19.2025.03.03.08.30.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Mar 2025 08:30:40 -0800 (PST)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux-doc@vger.kernel.org,
	cgroups@vger.kernel.org,
	linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org,
	linux-api@vger.kernel.org,
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
	Dave Hansen <dave.hansen@linux.intel.com>,
	Muchun Song <muchun.song@linux.dev>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Jann Horn <jannh@google.com>
Subject: [PATCH v3 10/20] bit_spinlock: __always_inline (un)lock functions
Date: Mon,  3 Mar 2025 17:30:03 +0100
Message-ID: <20250303163014.1128035-11-david@redhat.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250303163014.1128035-1-david@redhat.com>
References: <20250303163014.1128035-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The compiler might decide that it is a smart idea to not inline
bit_spin_lock(), primarily when a couple of functions in the same file end
up calling it. Especially when used in RMAP map/unmap code next, the
compiler sometimes decides to not inline, which is then observable in
some micro-benchmarks.

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
2.48.1


