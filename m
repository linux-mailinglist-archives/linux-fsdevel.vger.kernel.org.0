Return-Path: <linux-fsdevel+bounces-21197-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8993F90037B
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Jun 2024 14:26:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A544DB229A7
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Jun 2024 12:26:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35B31198846;
	Fri,  7 Jun 2024 12:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RGp9aHPF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F12F196DA5
	for <linux-fsdevel@vger.kernel.org>; Fri,  7 Jun 2024 12:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717763060; cv=none; b=sQ5rwa0dkumQfmUZShglPGpykAq/ZPVLNuBZ0iaZJOWx9N9wg+wnMeqVKZA0yIJKmhY45VvRHauxpnXe0crihnMqRh25RMEGoVDHtpSyPH6n0YxqfuHLc04NJlERgkS+hvgR+U79XQNxh6vaMe7MfssrGcqUdbulxILeM42Ebws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717763060; c=relaxed/simple;
	bh=aM9gkPNW3QwA9rEu3NxyfkEZn/hZo8E1WPrx4kQC32g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uSJqUUNvj9zZhSw8+RubTx+Vmo2XZeUSIOsEa4MtOTyNAIBSkk31EIGJimuMgqSlSGxQ0Ml6S5wwqhVgLBje4hc+Pk2Q2J6Td+6EQd/IkP76y/di79QSANxPNhLftFIDIeURSWwYXaOCU8w+USAQ+WnuITcKEECswHDZXvluO5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RGp9aHPF; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717763058;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IlZ3OfYfLTtJDLF62yb3XVghB10LN2zpLPX8h3wsziU=;
	b=RGp9aHPFv/VxK5QegxmQLZPXUMWlx9aJohvPV9MJ6Xr+HtQ/5PGuEgV1nsoN/b6jRnIYd5
	/dwFIvGtsZyww1WZYIHqZ2Jlj4/2vadvUGRcTuFWYcARHVDUPk8/tJf9NLcs1MrAZFCJCo
	b/rtMJH5LyL8bECzvze3JcqsOW8oSI8=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-637-Ohcn_-66MiOtK0ykrtlcjQ-1; Fri,
 07 Jun 2024 08:24:14 -0400
X-MC-Unique: Ohcn_-66MiOtK0ykrtlcjQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8FE221C05129;
	Fri,  7 Jun 2024 12:24:13 +0000 (UTC)
Received: from t14s.fritz.box (unknown [10.39.192.109])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 3A45F492BCD;
	Fri,  7 Jun 2024 12:24:11 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org,
	linux-doc@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	David Hildenbrand <david@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH v1 6/6] Documentation/admin-guide/mm/pagemap.rst: drop "Using pagemap to do something useful"
Date: Fri,  7 Jun 2024 14:23:57 +0200
Message-ID: <20240607122357.115423-7-david@redhat.com>
In-Reply-To: <20240607122357.115423-1-david@redhat.com>
References: <20240607122357.115423-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10

That example was added in 2008. In 2015, we restricted access to the
PFNs in the pagemap to CAP_SYS_ADMIN, making that approach quite less
usable.

It's 2024 now, and using that racy and low-lewel mechanism to calculate the
USS should not be considered a good example anymore. /proc/$pid/smaps
and /proc/$pid/smaps_rollup can do a much better job without any of
that low-level handling.

Let's just drop that example.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 Documentation/admin-guide/mm/pagemap.rst | 21 ---------------------
 1 file changed, 21 deletions(-)

diff --git a/Documentation/admin-guide/mm/pagemap.rst b/Documentation/admin-guide/mm/pagemap.rst
index f5f065c67615d..f2817a8015962 100644
--- a/Documentation/admin-guide/mm/pagemap.rst
+++ b/Documentation/admin-guide/mm/pagemap.rst
@@ -173,27 +173,6 @@ LRU related page flags
 The page-types tool in the tools/mm directory can be used to query the
 above flags.
 
-Using pagemap to do something useful
-====================================
-
-The general procedure for using pagemap to find out about a process' memory
-usage goes like this:
-
- 1. Read ``/proc/pid/maps`` to determine which parts of the memory space are
-    mapped to what.
- 2. Select the maps you are interested in -- all of them, or a particular
-    library, or the stack or the heap, etc.
- 3. Open ``/proc/pid/pagemap`` and seek to the pages you would like to examine.
- 4. Read a u64 for each page from pagemap.
- 5. Open ``/proc/kpagecount`` and/or ``/proc/kpageflags``.  For each PFN you
-    just read, seek to that entry in the file, and read the data you want.
-
-For example, to find the "unique set size" (USS), which is the amount of
-memory that a process is using that is not shared with any other process,
-you can go through every map in the process, find the PFNs, look those up
-in kpagecount, and tally up the number of pages that are only referenced
-once.
-
 Exceptions for Shared Memory
 ============================
 
-- 
2.45.2


