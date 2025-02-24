Return-Path: <linux-fsdevel+bounces-42472-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D85BA428A9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Feb 2025 18:02:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8306C189B85C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Feb 2025 17:00:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ACBF267737;
	Mon, 24 Feb 2025 16:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YIUuoDs2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70E182676F9
	for <linux-fsdevel@vger.kernel.org>; Mon, 24 Feb 2025 16:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740416203; cv=none; b=uVE/oVzbDxkegPvGHS6hBWdnMwai1pWWtD85lfJA26rGHExILSHfBH8fIYk3UY2SbIDix3GNrQOwS7VptrjgL1h3SubZR+koVi25Y+vDdLtDEzl1/uWXeccIM7GYWAcTZtd+5CcLCjIXRE8meseUlWVMkPDnwGUEfFU5LhoOO1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740416203; c=relaxed/simple;
	bh=5WNM/6QDOH2Ize7Cdhhh3450CUV7Ph/XvN+jjna0q/k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZOLXh4yQAlsS6nkSagCgPfOZ2mcIW1Pt0oGt01/ELcYKg6+Zvx+MX/izJslxt9f727DXd3mc/+M8g4gJuGezZX1U1S3RV4nZsYSuMbkT/nofkZV6fBBFmaAsyDy5jpRUcZXPsdhV6mOmmMlsG+/Lp9PlcneZ4g/5TrPu6LQnYgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YIUuoDs2; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740416200;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hjQ9M+/7gFJUkrRnlhRJAIZPqjntNNCFGRlUUDQiAps=;
	b=YIUuoDs24/lXrOIOjzD5uGKOQiyKE8m2aidpEOweRsSGBd6cJVzWzjJc6cEGJn+5RcYlgo
	GQxJmcsjEq0pJLTm2ohOtewRPjnIivIolhWKqhBm2U9FIc4/YjANYcX0YhhBYvJv7fzC6z
	mj1FdhcCZbgn7BLzU2G958SJywR3rWw=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-124-GpJkwC2eMgqtTJX8L4nR1Q-1; Mon, 24 Feb 2025 11:56:38 -0500
X-MC-Unique: GpJkwC2eMgqtTJX8L4nR1Q-1
X-Mimecast-MFC-AGG-ID: GpJkwC2eMgqtTJX8L4nR1Q_1740416197
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-38f255d44acso2001196f8f.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Feb 2025 08:56:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740416197; x=1741020997;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hjQ9M+/7gFJUkrRnlhRJAIZPqjntNNCFGRlUUDQiAps=;
        b=oZ1MpHQFSdEbgMigjp2GURzU8QK06/v1Hm1xizXVhEaGxTAeWfAXc7YbdJUpSkFgdO
         Nj487E0y0zwCyfkElXQahFfcRuGz3pYR8Hpxs50UUr8J/Vd1ivXorEnQ45KUwKKxEe2Y
         UgxLwpnbeQZ3+CRhQKpvGvVa/zKI572eeB0U5awkenFepqby2sHFovR+KVmKOOubRppy
         wzpQJbWdBCZ1SGbU796Ww3IOVg0FIdJVqmvD2z94/btU0AiShfGU9beawfRcWU3qn2HR
         zJShwschsL0TgYSkIuHdesw5HgXy7t2KadfWJy4FpKZ/1TNqXlV8GS5lIomNUbBOLf/T
         ICJA==
X-Forwarded-Encrypted: i=1; AJvYcCUPvKC/T2uYYxkw6JtC4utN/AEsLq3ZHgy50B7boPwnH2hLYKeH5AN/Pl/56Kl4zdrLCpgkkLUP91WcwrwG@vger.kernel.org
X-Gm-Message-State: AOJu0YzQ0P/QkZyZAhVvwTtAOpS5U6/h6LpPA+knqWkWsyvFazoVdv97
	0FFcJZdxoTrzIUancIlA/+CLeuHOwwavy0i4Nkjmqa4+fJ4ZDk3iiq59xF+Fd42q/zaYNP/0HgK
	bZQINwzj+tAnFqLtLiI2FnH6aEDvGSOSuXHr3cjCqL/YqX6s0qdSHGzSAbswai2Y=
X-Gm-Gg: ASbGncsCRT5+mt4XH9gyP5GdWrx5+q3+PWx3A1OG67IS30rsgHIx07tAjvuS9TTxxH/
	M3XJBg+HNt4egra/qS8wQeXDOE1YVa1/1AlBeuvvudExYHigwFrPQUGeH1hb+gnTeoxpPGP21Wk
	t4jinIARXwyM+DE6XryoIEJvVvJDUiIUDI7l5KMwL6gJ+i602DA5VdXNGDhr2yX2DSfwS4Y2DpN
	SeC1L8waeZf7KOi4txQCRu/zAP3roWzjeOFiFaJWZJMTGaIg+RxoAJ6DfKsjR4HdQvVBwdJYAHU
	sUbwE731F95W0bS7fhwpURGpSgejIMsfYM539Jublg==
X-Received: by 2002:a05:600c:154b:b0:439:9f19:72ab with SMTP id 5b1f17b1804b1-43aa6d14bf5mr34158695e9.23.1740416197417;
        Mon, 24 Feb 2025 08:56:37 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHJ9sKTQ3EBTX4dQr6LdeGl2B92vuZUpZDHC83nbKU72kdYMMOPYVrf72peoEztlZbl1dnGRA==
X-Received: by 2002:a05:600c:154b:b0:439:9f19:72ab with SMTP id 5b1f17b1804b1-43aa6d14bf5mr34158365e9.23.1740416197028;
        Mon, 24 Feb 2025 08:56:37 -0800 (PST)
Received: from localhost (p4ff234b6.dip0.t-ipconnect.de. [79.242.52.182])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-439b02d519dsm109604025e9.11.2025.02.24.08.56.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Feb 2025 08:56:35 -0800 (PST)
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
Subject: [PATCH v2 15/20] mm: CONFIG_NO_PAGE_MAPCOUNT to prepare for not maintain per-page mapcounts in large folios
Date: Mon, 24 Feb 2025 17:55:57 +0100
Message-ID: <20250224165603.1434404-16-david@redhat.com>
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

We're close to the finishing line: let's introduce a new
CONFIG_NO_PAGE_MAPCOUNT config option where we will incrementally remove
any dependencies on per-page mapcounts in large folios. Once that's
done, we'll stop maintaining the per-page mapcounts with this
config option enabled.

CONFIG_NO_PAGE_MAPCOUNT will be EXPERIMENTAL for now, as we'll have to
learn about some of the real world impact of some of the implications.

As writing "!CONFIG_NO_PAGE_MAPCOUNT" is really nasty, let's introduce
a helper config option "CONFIG_PAGE_MAPCOUNT" that expresses the
negation.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/Kconfig | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/mm/Kconfig b/mm/Kconfig
index af72fe92f96b0..64bb80a281dd9 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -889,8 +889,26 @@ config READ_ONLY_THP_FOR_FS
 	  support of file THPs will be developed in the next few release
 	  cycles.
 
+config NO_PAGE_MAPCOUNT
+	bool "No per-page mapcount (EXPERIMENTAL)"
+	help
+	  Do not maintain per-page mapcounts for pages part of larger
+	  allocations, such as transparent huge pages.
+
+	  When this config option is enabled, some interfaces that relied on
+	  this information will rely on less-precise per-allocation information
+	  instead: for example, using the average per-page mapcount in such
+	  a large allocation instead of the per-page mapcount.
+
+	  EXPERIMENTAL because the severity of some of the implications first
+	  have to be understood properly.
+
 endif # TRANSPARENT_HUGEPAGE
 
+# simple helper to make the code a bit easier to read
+config PAGE_MAPCOUNT
+	def_bool !NO_PAGE_MAPCOUNT
+
 #
 # The architecture supports pgtable leaves that is larger than PAGE_SIZE
 #
-- 
2.48.1


