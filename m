Return-Path: <linux-fsdevel+bounces-42961-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CAFA1A4C7CE
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Mar 2025 17:43:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B68A11626EC
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Mar 2025 16:43:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FF74254AE8;
	Mon,  3 Mar 2025 16:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HLrd6VZ4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7798253337
	for <linux-fsdevel@vger.kernel.org>; Mon,  3 Mar 2025 16:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741019464; cv=none; b=jWLM2DKaTLRnIJ8EJgSJdsXT0ZWs2yeiVOdiqWUrzxJVpqkzKmEtzy4xZWZESlA8FY+REdLdxQO5PAiWgohVIUMNiJnlfyQs7EEeyIQZOAm/LXl6SYnm+hKTnXsKTLwCXdoCb/jVlvMEDU//7nAN+sVO+NFHqClJ5gfmuNj75SE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741019464; c=relaxed/simple;
	bh=zwBWJQNiZElGf+tnFTiOyJan5xAOzuwmBeeeOxUUAKM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pqb8eH/H/c5xu9wd4eJ7OLYXtK3lQe0tzxvrGchusqAgPnakCXFYN5Wsd36l0twxT6HeC6Zh62kNPiYhcDnR8k7QrhIv7mE1Oviz83lAcg+m+15qnVUksiagwDkEc3+VqPMPxi6iXK66+eWkIZyw/lPmUHSvC5pyHSLzEPieaNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HLrd6VZ4; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741019461;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=azxC6HZJ9nBU2F+f5yWV4gQ6J7sT6YtNWxk4WN8FkrY=;
	b=HLrd6VZ4uWdwgWcUC3CgfXxFXzftjDnqs3+n9BJz9EboyCFSRPG0zR3h2A47TADTR6dxE/
	c+BeqSSh+rpjTeeGg7qJqAlq5abJ8J+5cgf1e/LVBK9aAL7AuwbTUUHPKj7ATNOA0MrgOC
	x7H0bkjRUf4aTy/P7VEwjX2pj4hhWcQ=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-453-RlriwmnnO9eKAqmshRTOnw-1; Mon, 03 Mar 2025 11:30:53 -0500
X-MC-Unique: RlriwmnnO9eKAqmshRTOnw-1
X-Mimecast-MFC-AGG-ID: RlriwmnnO9eKAqmshRTOnw_1741019452
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-390e003c1easo2108086f8f.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 03 Mar 2025 08:30:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741019452; x=1741624252;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=azxC6HZJ9nBU2F+f5yWV4gQ6J7sT6YtNWxk4WN8FkrY=;
        b=izrYkljFjAcbfJ1CT44LU3yYcsouKREPrcAStmfHph+ZWO75kewmneC8Ir173Qu6ee
         4TmE5qb1cCexUCGVoyuY8DkhHbhsXas6/w96z58zhQoAkR4T0iHIz0VFKdlpH9hqP1rT
         Z0J2sXCgr0uL8LtvYTJJU7F/tEsjaEo3iiOzakSVBYZBhMFCmmUXaifOYTx2Oqdp6WTZ
         QR/dHUaGjGqnZSGLj4dAAXGf/39KeHfsonMszOszcYdTWYqyrtkpc80UwMpvKAtFal6F
         Tjik4VjG35gK1/WDQk3CAXI6ZSVpwlC+WNvnYulU2zdy+FehCNtkGhnbj6urzc9EN6+D
         XUZg==
X-Forwarded-Encrypted: i=1; AJvYcCWuyesVXLqt2PfQFEbO/NqWtEgpy3NbAr4Q5u36dITDIW1IQucfFjAPOf3Yv1iHq7M28//Dr6YrnwQqzF0u@vger.kernel.org
X-Gm-Message-State: AOJu0Yx10u5E1T4kAg0OWeFM6ALAoM7NZ2udxwLGqgQJP32AdldjhRDH
	9urPsTv3O37lC12a4B9TMS7Vcp8FXl1WT0usP/uDWV9cErzUBhrrESBl8XPw48hK9PMZXbBlUB8
	yF7ZEEkeoJN2KJdLx3GdGEtJhevoL8I+OwzQ62T7y4E48KjdSqnpmCV4HxLhGjTY=
X-Gm-Gg: ASbGncvKHTEbjebQxnYA/JJ7sEKNHogkVyx5/xUMgdYA9GgijMUUbVqGKmzNv622uhi
	CFLUWitS9yf7s+axtDioTafliwxFK4zIr9nRmes2QLVvzS3SWDD3tp+3wfwisZ3PA1mQnMNOjD4
	1I8wi7mkX42F2PzoI8CDtVKt0ap6z5VsPaDaJ5TYtl71C9GeNMB5y0hvCIr0Hkky3zGukYi/3S8
	bU5LwY9OvSDaj0ERT5ofypniVthK9P/TSwiwCaIpbxzbtlO5wpYL5F0YVAUGfjo8yadTWyE0RTY
	ISxlGBaKWDCMuOGJobwGJZgSgzG8Q2+gt2j006Z5RV8OucvVUuPYImFy2YXS8cmUjfRudiisFx3
	h
X-Received: by 2002:a05:600c:5585:b0:43b:bedc:fcf6 with SMTP id 5b1f17b1804b1-43bbedcfe47mr44358445e9.1.1741019451746;
        Mon, 03 Mar 2025 08:30:51 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFzQb6PWhSpsnKcZbPTy2ai+36EkVbTPhZ8phSQIWx5xoPi2ki+HFSKpKKxfbHb4k7pKztumg==
X-Received: by 2002:a05:600c:5585:b0:43b:bedc:fcf6 with SMTP id 5b1f17b1804b1-43bbedcfe47mr44358005e9.1.1741019451351;
        Mon, 03 Mar 2025 08:30:51 -0800 (PST)
Received: from localhost (p200300cbc7349600af274326a2162bfb.dip0.t-ipconnect.de. [2003:cb:c734:9600:af27:4326:a216:2bfb])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-43b736f74e8sm172202265e9.7.2025.03.03.08.30.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Mar 2025 08:30:50 -0800 (PST)
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
Subject: [PATCH v3 15/20] mm: CONFIG_NO_PAGE_MAPCOUNT to prepare for not maintain per-page mapcounts in large folios
Date: Mon,  3 Mar 2025 17:30:08 +0100
Message-ID: <20250303163014.1128035-16-david@redhat.com>
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
 mm/Kconfig | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/mm/Kconfig b/mm/Kconfig
index 4034a0441f650..e4bdcf11d1b86 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -881,8 +881,25 @@ config READ_ONLY_THP_FOR_FS
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
+	  EXPERIMENTAL because the impact of some changes is still unclear.
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


