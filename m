Return-Path: <linux-fsdevel+bounces-27912-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A24B2964C62
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 19:01:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0B221B26AB5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 17:01:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CD9D1B9B56;
	Thu, 29 Aug 2024 16:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aYsXXYHp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22CA91B8EA5
	for <linux-fsdevel@vger.kernel.org>; Thu, 29 Aug 2024 16:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724950720; cv=none; b=tf1YZLyTHikdT+sm7is6p+0eUSIg1ntxYAMNHTly9A8ndvhYyGBdiaaSwEjjmMQfx9zpBRggv4tsVNyRkviBba5sSxTek4EXIqzmGfnoHlknpjLa0fBkUuzWPgslrtsBm0q1DPsCODTlyxuEnwugp8GKHppgilnWnWfuvOjvOTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724950720; c=relaxed/simple;
	bh=RBX78qpxhtQxekqwvy5pTTwYJ9L9zkw4ydpyf0vXszo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bKGnK9VZboNKi/GTY1olUBe9BezI2OdS8aCGbatxET6CZ2XpmV6o0eEI7wGPj8WoZVoIHN6rK7hXJQxpedtz3MPJpo5zMv0nstkJz0unP+43iIzSFs6UIF3rDA+Wd1nOx57eMTDIY3dKOaW08HooxOD/tWnYYi3NU8lM9NRt0uE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aYsXXYHp; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724950718;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=z6SjsdX5+d4w13f2Yod61hus7319jekbv8gEFkX5n/A=;
	b=aYsXXYHp0kqdI3wPB5Gw9L7jrNQOVtvzp54AWUE4qGKBnYlMpBFFlAT1JPiRqrwkNbVtAG
	/fGl1iJER7HVBMDWH56e1yeludrsN/4cspytzYrj6PpXyfVeVY+KT/ORk8/4PBgkQDqbJ8
	F+4SKDiOE7768j1S5iv9ackhEIDNrFk=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-608-_x1Mv_w9P1eDEEfjyaDX-g-1; Thu,
 29 Aug 2024 12:58:34 -0400
X-MC-Unique: _x1Mv_w9P1eDEEfjyaDX-g-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E0E2419792FA;
	Thu, 29 Aug 2024 16:58:31 +0000 (UTC)
Received: from t14s.redhat.com (unknown [10.39.193.245])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 3B8EB1955F21;
	Thu, 29 Aug 2024 16:58:23 +0000 (UTC)
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
Subject: [PATCH v1 11/17] mm: CONFIG_NO_PAGE_MAPCOUNT to prepare for not maintain per-page mapcounts in large folios
Date: Thu, 29 Aug 2024 18:56:14 +0200
Message-ID: <20240829165627.2256514-12-david@redhat.com>
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
 mm/Kconfig | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/mm/Kconfig b/mm/Kconfig
index 0877be8c50b6c..73cfacbd1cc6a 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -878,8 +878,28 @@ config READ_ONLY_THP_FOR_FS
 	  support of file THPs will be developed in the next few release
 	  cycles.
 
+config NO_PAGE_MAPCOUNT
+	bool "No per-page mapcount (EXPERIMENTAL)"
+	depends on TRANSPARENT_HUGEPAGE && MM_ID
+	help
+	  Do not maintain per-page mapcounts for pages part of larger
+	  allocations, such as transparent huge pages.
+
+	  When this config option is enabled, some interfaces that relied on
+	  this information will rely on less-precise per-folio information
+	  instead: for example, using the average per-page mapcount in such
+	  a large allocation instead of the per-page mapcount.
+
+	  EXPERIMENTAL because the severity of some of the implications first
+	  have to be understood properly.
+
 endif # TRANSPARENT_HUGEPAGE
 
+# simple helper to make the code a bit easier to read
+config PAGE_MAPCOUNT
+	def_bool y
+	depends on !NO_PAGE_MAPCOUNT
+
 #
 # The architecture supports pgtable leaves that is larger than PAGE_SIZE
 #
-- 
2.46.0


