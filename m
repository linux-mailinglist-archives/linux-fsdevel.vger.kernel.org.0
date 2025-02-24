Return-Path: <linux-fsdevel+bounces-42467-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CC17A428BA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Feb 2025 18:03:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 12F0C17C64E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Feb 2025 16:59:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49F3C266EFA;
	Mon, 24 Feb 2025 16:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LBMist0L"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 927D8266B5E
	for <linux-fsdevel@vger.kernel.org>; Mon, 24 Feb 2025 16:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740416193; cv=none; b=O/TTgbFgylvb8uQhzo9WO+LbwIE2vNSVylPkZ3OEZ+LJS3Q1/QejzSeuL9N+lT6Wbh7uEU3ujL+3SaQq9UPwvFk99a8ZWagoSP32a/VAV5+6eRPus6I1voxTyjcEQhvGuFQ7oHz1ieutp85fwb1Jf57qqDfYdslEx8pR48QTQC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740416193; c=relaxed/simple;
	bh=OBXpWDsR7o4dKf8NkhRON4PwL/H6iQiwplPc25GckEo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fKoydOpjjDzc53xwQ7db3GruCtdb+qIMToRYqfBSFhksvnInT/LNJm0/AdAcmELS6kQrpB2ExE0h3GbN9ehP9XAxR2++5CHb+QvLpvSQFctSbu23MnYelgyDwyi6Bx7EJtrgmrVNZlzSn8TvXCkLXopc6RH09tRm+3Od+6L+ksI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LBMist0L; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740416190;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VusPlBbKEOGpL4wS1BqoWY6CYb2f4HQ+/wIDh8p+vAo=;
	b=LBMist0LYmdA9fBGuQ6Yj7DoshgdJyrm1CpbYFb23A3MXD30xyJhpkyRhQEg9tqXKXyuCO
	YIkV3X5BP2oK1B8kNmit0fia1beoKa/1suJytFMRE0rRww5RAcWc/HxReSNIWWrfcbfkcf
	+NJ8w4XgccTmKwXZP2xmek74LgjKQ38=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-635-6Ye50xSqOIu6Mf3UrI0sXQ-1; Mon, 24 Feb 2025 11:56:27 -0500
X-MC-Unique: 6Ye50xSqOIu6Mf3UrI0sXQ-1
X-Mimecast-MFC-AGG-ID: 6Ye50xSqOIu6Mf3UrI0sXQ_1740416186
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4398a60b61fso23729505e9.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Feb 2025 08:56:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740416186; x=1741020986;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VusPlBbKEOGpL4wS1BqoWY6CYb2f4HQ+/wIDh8p+vAo=;
        b=BR6nx75LyqHDSeZooOzCcUJp/DwAotK8Z8TS7KZwYflybxW/7I3Uf6p/0As4rspXQm
         5AP8GEgcjZKnBeZ7Pc6F05Vi5mLY2+3uNohZH/4WmCMSXK8RyVF0sWrQyCTI7/0DBkyr
         8Kl7Dgf3ty4/lqd/jU1n5ZfdBIhn7tXdOzkUkif8n/FPrepPeeHai2uaBM6tjgxtke75
         tU1FmbSFTxAyPWNK9yhLrTrWExWY/t3hoSusx/fMAfcnUnQy6qJkfPYx5aADwyK6tpbb
         do0H+y4oVjvFFbgmNrn4NrgvBqkhO5hSUdswu3I0rSg5n7AVkygu+fmY/2TlIH2wNlKb
         k65A==
X-Forwarded-Encrypted: i=1; AJvYcCWPFHS5jCI10Zk4vUjVGXG8rNbR3TaESUJOVutNgvujbnJ5oK/gIoKQDDtuCLgk7cgxJ7AcqZ1dym2Rorn+@vger.kernel.org
X-Gm-Message-State: AOJu0YwoC3jHIfh5I9a/iIC7Z4cTn11NiVJmDsqM5HyDsKSOLo6k9yA/
	vcevKq8bD7/ylxVF872jJFUe6UhzXZoyXsimCBSgNh4yiKH23Bw9tVhQmDqoRSKK0l7WwT7RG0U
	iEWyPDA5GvYcr8zhQElbNZWyD+qXPz7r0h6aN3+kgWK4k060msQ5YDFnvZQ1950A=
X-Gm-Gg: ASbGncvOgtmrNGOdS9gf39627ZiQYGXpXENRfp45TZsY5vWgeOxL4NSUzCzMoBX+0xJ
	Dvp3TjCsvCNpTzWneCXTUrqfQcAgB4xvPR8zpe0g3bOELFqBcTWmc4oN+Zjrq+SmNIdh8c6k3Io
	o2LOvDN/C7nD/RRgcCkoi1h/NdjdI9pilD9TSIaQ0mL5IzUGAnFsP6EFigP202q/NLmvUW9e/mx
	ehsUIG5i3t8Q+eviGWAb+n4aXh4K3WNHs3dE4xoESCRXmTDp086a5BDQgF+a66YjIPP/TFlVAMn
	sdIsWvlAdGpENe8vwbt1F9SIeTVdH5gDr0gQssCv8g==
X-Received: by 2002:a05:600c:4f43:b0:439:9828:c425 with SMTP id 5b1f17b1804b1-43ab0f2db61mr336625e9.7.1740416186361;
        Mon, 24 Feb 2025 08:56:26 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHWfaIC9jLsYbcLXi3Fdeg1qCi0/sJNUC8bLA+3qaJ5mWtkIjQvv3YtNjkQQj/btQBGxQxPlw==
X-Received: by 2002:a05:600c:4f43:b0:439:9828:c425 with SMTP id 5b1f17b1804b1-43ab0f2db61mr336445e9.7.1740416185910;
        Mon, 24 Feb 2025 08:56:25 -0800 (PST)
Received: from localhost (p4ff234b6.dip0.t-ipconnect.de. [79.242.52.182])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-439b030b347sm111391345e9.26.2025.02.24.08.56.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Feb 2025 08:56:25 -0800 (PST)
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
Subject: [PATCH v2 10/20] bit_spinlock: __always_inline (un)lock functions
Date: Mon, 24 Feb 2025 17:55:52 +0100
Message-ID: <20250224165603.1434404-11-david@redhat.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250224165603.1434404-1-david@redhat.com>
References: <20250224165603.1434404-1-david@redhat.com>
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


