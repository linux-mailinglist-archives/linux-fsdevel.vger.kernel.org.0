Return-Path: <linux-fsdevel+bounces-26411-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F2B1959117
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Aug 2024 01:21:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DDD34B23B1C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Aug 2024 23:21:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 793171C9DD4;
	Tue, 20 Aug 2024 23:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RfIOKBY/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 554AC1C8FC2
	for <linux-fsdevel@vger.kernel.org>; Tue, 20 Aug 2024 23:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724196088; cv=none; b=ktkzTezSWif0UZlx0h0Z6YWd1urde2/EISOHdcoec+xNlUNPgUA1fKelAt7WcBON2JglZITkRIl+vcT1PyJrUW+YMFEX7sxVDkTTYrB1zL3eY9hPvm7fcRaHkPaz8bqTxwsclFN8a36F/NK17jNMmtUDCuq5mv7IgpKyUudzEus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724196088; c=relaxed/simple;
	bh=J0AzZjY++lVaELd9SlHmM+WmZKF2PT/cunGaBNDmsAE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ae+FpafCWjaU9s8d6GQc2IcCoJXTQcNhavcE3Piv6WM9bsl3OOkyCziea5i/GUAIayfknZ+1Ery4IQJYiQ+DjAUZk+xJ+M9AsZTgu3JkytVTIfRvcSsGlHtL/oPGLGqaQVHevFt+sqV16HuqHAQD6ZM4AvzPfyk3ndPhpqbkLh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RfIOKBY/; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724196086;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=i1WfTcBSz40dFfs4YPek5T5SHQcjJbpn4yprFOLb05E=;
	b=RfIOKBY/8ZzBMJnIXQ3D8Y5GdiHSvmGOv7+clK9buSUMyufLHdNkGVc/bx3UijrYweIoIp
	c393GPuztF6AW3TU3L2NKwFeZyTLQBQlpp3scaHCEbvvoovHJLUK1yv2l2YiOKKriEVUYs
	/CBzFyZhPgumYXbQEf6ybxRXFCQb2MM=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-515-qlsSCgy2P9econK9DfSahQ-1; Tue,
 20 Aug 2024 19:21:23 -0400
X-MC-Unique: qlsSCgy2P9econK9DfSahQ-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EBEED1955D48;
	Tue, 20 Aug 2024 23:21:19 +0000 (UTC)
Received: from warthog.procyon.org.uk.com (unknown [10.42.28.30])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 8A1AE1955E8C;
	Tue, 20 Aug 2024 23:21:14 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <christian@brauner.io>
Cc: David Howells <dhowells@redhat.com>,
	Pankaj Raghav <p.raghav@samsung.com>,
	Jeff Layton <jlayton@kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	netfs@lists.linux.dev,
	linux-afs@lists.infradead.org,
	linux-cifs@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	ceph-devel@vger.kernel.org,
	v9fs@lists.linux.dev,
	linux-erofs@lists.ozlabs.org,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Marc Dionne <marc.dionne@auristor.com>
Subject: [PATCH 1/4] mm: Fix missing folio invalidation calls during truncation
Date: Wed, 21 Aug 2024 00:20:55 +0100
Message-ID: <20240820232105.3792638-2-dhowells@redhat.com>
In-Reply-To: <20240820232105.3792638-1-dhowells@redhat.com>
References: <20240820232105.3792638-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

When AS_RELEASE_ALWAYS is set on a mapping, the ->release_folio() and
->invalidate_folio() calls should be invoked even if PG_private and
PG_private_2 aren't set.  This is used by netfslib to keep track of the
point above which reads can be skipped in favour of just zeroing pagecache
locally.

There are a couple of places in truncation in which invalidation is only
called when folio_has_private() is true.  Fix these to check
folio_needs_release() instead.

Without this, the generic/075 and generic/112 xfstests (both fsx-based
tests) fail with minimum folio size patches applied[1].

Fixes: b4fa966f03b7 ("mm, netfs, fscache: stop read optimisation when folio removed from pagecache")
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Matthew Wilcox (Oracle) <willy@infradead.org>
cc: Pankaj Raghav <p.raghav@samsung.com>
cc: Jeff Layton <jlayton@kernel.org>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: linux-afs@lists.infradead.org
cc: netfs@lists.linux.dev
cc: linux-mm@kvack.org
cc: linux-fsdevel@vger.kernel.org
Link: https://lore.kernel.org/r/20240815090849.972355-1-kernel@pankajraghav.com/ [1]
---
 mm/truncate.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/truncate.c b/mm/truncate.c
index 4d61fbdd4b2f..0668cd340a46 100644
--- a/mm/truncate.c
+++ b/mm/truncate.c
@@ -157,7 +157,7 @@ static void truncate_cleanup_folio(struct folio *folio)
 	if (folio_mapped(folio))
 		unmap_mapping_folio(folio);
 
-	if (folio_has_private(folio))
+	if (folio_needs_release(folio))
 		folio_invalidate(folio, 0, folio_size(folio));
 
 	/*
@@ -219,7 +219,7 @@ bool truncate_inode_partial_folio(struct folio *folio, loff_t start, loff_t end)
 	if (!mapping_inaccessible(folio->mapping))
 		folio_zero_range(folio, offset, length);
 
-	if (folio_has_private(folio))
+	if (folio_needs_release(folio))
 		folio_invalidate(folio, offset, length);
 	if (!folio_test_large(folio))
 		return true;


