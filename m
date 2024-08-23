Return-Path: <linux-fsdevel+bounces-26988-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 95B9A95D76D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Aug 2024 22:17:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C8B721C21845
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Aug 2024 20:17:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E360199231;
	Fri, 23 Aug 2024 20:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L/kJOHsZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16AA91991CE
	for <linux-fsdevel@vger.kernel.org>; Fri, 23 Aug 2024 20:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724443721; cv=none; b=WYpuipIDVSrMxXo8Lj1O7P/GiWdw90REu/EDpCWRjgusg+935stmaL9yuFyYyCXFJLsy9b2g9meH4pTPvewHa1VFmrzqcd48J3aXx/t1/gstJpIZ4cu1iw7pHcsPihRjcavyOTt1UWS+w17NFonLoVUKCenv4t213KPpsQ/k85M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724443721; c=relaxed/simple;
	bh=J0AzZjY++lVaELd9SlHmM+WmZKF2PT/cunGaBNDmsAE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fUcB+VJQLsmcCjb/gZAlhL8397AMzIyFHOFXG67/SSVgdxAs5jxhiggQxKIgMxiNm/l+JAyjpV2qz6Woo3lMDgnGRYTYDzJ/gDMNbjNwKGiCtuFrEQc1briAtoJUqPMKIpku22/5IpTQQu+EpSUJRwCQvq2QLZ3Ptdoc7cLQ7Jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=L/kJOHsZ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724443719;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=i1WfTcBSz40dFfs4YPek5T5SHQcjJbpn4yprFOLb05E=;
	b=L/kJOHsZsQjcBYhWZ5zShuljoNGt/gMYdhm/Z9Gs/8ffJFAN4lQZbFZ3ukbzhPrP5P36Mn
	MKDFF1nnHCSuViSbfl6XxbF7nplwaIFEVBK95Refn2db7/tSJpcztWhx+yIt6Zw5EG4MP3
	MkZi/XuXHKVT0T9j3ksF1f/2zhBcBRo=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-459-Djwg1nHIPVOepKsh7DLV1g-1; Fri,
 23 Aug 2024 16:08:37 -0400
X-MC-Unique: Djwg1nHIPVOepKsh7DLV1g-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A790219560A2;
	Fri, 23 Aug 2024 20:08:34 +0000 (UTC)
Received: from warthog.procyon.org.uk.com (unknown [10.42.28.30])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 7292D3001FE5;
	Fri, 23 Aug 2024 20:08:29 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <christian@brauner.io>,
	Steve French <sfrench@samba.org>
Cc: David Howells <dhowells@redhat.com>,
	Pankaj Raghav <p.raghav@samsung.com>,
	Paulo Alcantara <pc@manguebit.com>,
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
Subject: [PATCH 1/9] mm: Fix missing folio invalidation calls during truncation
Date: Fri, 23 Aug 2024 21:08:09 +0100
Message-ID: <20240823200819.532106-2-dhowells@redhat.com>
In-Reply-To: <20240823200819.532106-1-dhowells@redhat.com>
References: <20240823200819.532106-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

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


