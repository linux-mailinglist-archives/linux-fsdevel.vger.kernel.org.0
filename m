Return-Path: <linux-fsdevel+bounces-22302-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 988FE9161EE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Jun 2024 11:08:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 553322876BD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Jun 2024 09:08:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A05514A600;
	Tue, 25 Jun 2024 09:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GeZpWotb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C62114A4D9
	for <linux-fsdevel@vger.kernel.org>; Tue, 25 Jun 2024 09:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719306461; cv=none; b=ngw/LVqUoCy8iXGRJWY7JvDWotKJOfq5MzXeKS/ROR82ZCR+WG5Mho0wZkzS4XDzOcH8Ckff5k7/8YBhJt/XeSeVDLp3AYoFDmlGXa7PU55oppKKvLc0J4kG+H/4SjBgaUkNXf+JF3UDdk0qCm9BDjegolhevVvDI6AMBChJ7XU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719306461; c=relaxed/simple;
	bh=1BihIDrfzGB5v0YeXyfxenhxGR0GaRUHyvLdE67BmLg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TplHQoD5hiGg3t7lPGrFpym69TWGps5Qcz/QoD2/kqKWH5eemhFs1bLdrj2cOGvD5UmQR76e7hSL5c8zSac7P4pWMMg8DIFuWtM5ZmCXfTrgAl3QDRyW7Fa792nsrDgHIhBVYKnJ7+rftd6ciz4r2+MXeQSIoGHvWs7TbVFerF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GeZpWotb; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719306458;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ptlUNcO5mIabfV9LABSh8DDvNkvRbhBbpL84ksizTYg=;
	b=GeZpWotbxJk/LzgrA76qKXgThF0wuKflgKGfLvVoHmnF6cU2MBM0FxKLuYICrzAwZ39BS6
	X8Zx/BszpnbjlpMMwMOSGstaTqHhqQ8jTfqW/n1+eev7FmJ6XT+J2+L4g0qmg2cYy3aj66
	NghayF/fZWMKKlJNqKkV7SMIxE4qMtc=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-589-yOuNp3xGN_WdXUTuwYLdhg-1; Tue,
 25 Jun 2024 05:07:35 -0400
X-MC-Unique: yOuNp3xGN_WdXUTuwYLdhg-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 397DE19560AD;
	Tue, 25 Jun 2024 09:07:33 +0000 (UTC)
Received: from gshan-thinkpadx1nanogen2.remote.csb (unknown [10.67.24.180])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7A8801956087;
	Tue, 25 Jun 2024 09:07:25 +0000 (UTC)
From: Gavin Shan <gshan@redhat.com>
To: linux-mm@kvack.org
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	david@redhat.com,
	djwong@kernel.org,
	willy@infradead.org,
	akpm@linux-foundation.org,
	hughd@google.com,
	torvalds@linux-foundation.org,
	zhenyzha@redhat.com,
	shan.gavin@gmail.com
Subject: [PATCH 3/4] mm/readahead: Limit page cache size in page_cache_ra_order()
Date: Tue, 25 Jun 2024 19:06:45 +1000
Message-ID: <20240625090646.1194644-4-gshan@redhat.com>
In-Reply-To: <20240625090646.1194644-1-gshan@redhat.com>
References: <20240625090646.1194644-1-gshan@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

In page_cache_ra_order(), the maximal order of the page cache to be
allocated shouldn't be larger than MAX_PAGECACHE_ORDER. Otherwise,
it's possible the large page cache can't be supported by xarray when
the corresponding xarray entry is split.

For example, HPAGE_PMD_ORDER is 13 on ARM64 when the base page size
is 64KB. The PMD-sized page cache can't be supported by xarray.

Suggested-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Gavin Shan <gshan@redhat.com>
---
 mm/readahead.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/mm/readahead.c b/mm/readahead.c
index c1b23989d9ca..817b2a352d78 100644
--- a/mm/readahead.c
+++ b/mm/readahead.c
@@ -503,11 +503,11 @@ void page_cache_ra_order(struct readahead_control *ractl,
 
 	limit = min(limit, index + ra->size - 1);
 
-	if (new_order < MAX_PAGECACHE_ORDER) {
+	if (new_order < MAX_PAGECACHE_ORDER)
 		new_order += 2;
-		new_order = min_t(unsigned int, MAX_PAGECACHE_ORDER, new_order);
-		new_order = min_t(unsigned int, new_order, ilog2(ra->size));
-	}
+
+	new_order = min_t(unsigned int, MAX_PAGECACHE_ORDER, new_order);
+	new_order = min_t(unsigned int, new_order, ilog2(ra->size));
 
 	/* See comment in page_cache_ra_unbounded() */
 	nofs = memalloc_nofs_save();
-- 
2.45.1


