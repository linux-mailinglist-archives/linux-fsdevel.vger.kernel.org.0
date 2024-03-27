Return-Path: <linux-fsdevel+bounces-15464-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D06AB88EDE8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Mar 2024 19:13:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DD657B2B5A4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Mar 2024 18:00:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4281152171;
	Wed, 27 Mar 2024 17:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BsqsimYB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61DE81514D7
	for <linux-fsdevel@vger.kernel.org>; Wed, 27 Mar 2024 17:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711562160; cv=none; b=omHfFAjHn5/fe+WHr4T0GVD9RMqDGMJayNVuyQwVtViEUMP+JnWWCrw9f8RsJuUl1y2vEQEpqoHMVZCyDoqnqSl9lz4/axZp9o4ePshG/gurouwGTnuoojpwz/7BLf7LOHQBzeasEesHH+FqGX2OWEyHujIiNWQ8H1tgBI31V1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711562160; c=relaxed/simple;
	bh=NPhvozRKEg9kfHBXKt48lnApC6KVUGFOSrrqbu9Hq/8=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=uutz6umMunyrpIyGHWSx4bRg/xSEQwUbIH3MFANziwKP+i+Pr6Nz3YOpiqHZR+gBnB3JKuaKR+CR+Q0rSrPHwSxslSYehfjbdhqG4u130dPKw6RFz+Z7dR4pXKGeJH9tXnU/Lulg/K+34PUPhsB2Hsw5RxYLPiETuSmnBj1owBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BsqsimYB; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711562157;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SuhewvNUfoJvZQzmhzwfMCeMaHKTh082FqaMnijMnf4=;
	b=BsqsimYBv1UAbll3H/FQAD2IrIGdXXYtNFnpuI+z2yXqJS6dgNaJvu7Ib4+NBJzPCFkb3k
	MI7vSuriTV4Jxgm4y6cxVfnNQSsLyBS0vgrO/q2wZPA2MkDs/3jYsglNTiPgpy9JtEEH+G
	7Fn8VitYzbxaXuKv5bCGvuRyNARL7ps=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-187-3HLvNSycN1CY-_0DA3XqSg-1; Wed, 27 Mar 2024 13:55:53 -0400
X-MC-Unique: 3HLvNSycN1CY-_0DA3XqSg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 440148007A2;
	Wed, 27 Mar 2024 17:55:52 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.146])
	by smtp.corp.redhat.com (Postfix) with ESMTP id F0D7F2024517;
	Wed, 27 Mar 2024 17:55:49 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <2318298.1711551844@warthog.procyon.org.uk>
References: <2318298.1711551844@warthog.procyon.org.uk>
To: dhowells@redhat.com
Cc: Matthew Wilcox <willy@infradead.org>,
    Miklos Szeredi <miklos@szeredi.hu>,
    Trond Myklebust <trond.myklebust@hammerspace.com>,
    Christoph Hellwig <hch@lst.de>,
    Andrew Morton <akpm@linux-foundation.org>,
    Alexander Viro <viro@zeniv.linux.org.uk>,
    Christian Brauner <brauner@kernel.org>,
    Jeff Layton <jlayton@kernel.org>, linux-mm@kvack.org,
    linux-fsdevel@vger.kernel.org, netfs@lists.linux.dev,
    v9fs@lists.linux.dev, linux-afs@lists.infradead.org,
    ceph-devel@vger.kernel.org, linux-cifs@vger.kernel.org,
    linux-nfs@vger.kernel.org, devel@lists.orangefs.org,
    linux-kernel@vger.kernel.org
Subject: [RFC PATCH v2] mm, netfs: Provide a means of invalidation without using launder_folio
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2506006.1711562145.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 27 Mar 2024 17:55:45 +0000
Message-ID: <2506007.1711562145@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4

mm, netfs: Provide a means of invalidation without using launder_folio

Implement a replacement for launder_folio.  The key feature of
invalidate_inode_pages2() is that it locks each folio individually, unmaps
it to prevent mmap'd accesses interfering and calls the ->launder_folio()
address_space op to flush it.  This has problems: firstly, each folio is
written individually as one or more small writes; secondly, adjacent folio=
s
cannot be added so easily into the laundry; thirdly, it's yet another op t=
o
implement.

Instead, use the invalidate lock to cause anyone wanting to add a folio to
the inode to wait, then unmap all the folios if we have mmaps, then,
conditionally, use ->writepages() to flush any dirty data back and then
discard all pages.

The invalidate lock prevents ->read_iter(), ->write_iter() and faulting
through mmap all from adding pages for the duration.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Matthew Wilcox <willy@infradead.org>
cc: Miklos Szeredi <miklos@szeredi.hu>
cc: Trond Myklebust <trond.myklebust@hammerspace.com>
cc: Christoph Hellwig <hch@lst.de>
cc: Andrew Morton <akpm@linux-foundation.org>
cc: Alexander Viro <viro@zeniv.linux.org.uk>
cc: Christian Brauner <brauner@kernel.org>
cc: Jeff Layton <jlayton@kernel.org>
cc: linux-mm@kvack.org
cc: linux-fsdevel@vger.kernel.org
cc: netfs@lists.linux.dev
cc: v9fs@lists.linux.dev
cc: linux-afs@lists.infradead.org
cc: ceph-devel@vger.kernel.org
cc: linux-cifs@vger.kernel.org
cc: linux-nfs@vger.kernel.org
cc: devel@lists.orangefs.org
---
 include/linux/pagemap.h |    1 +
 mm/filemap.c            |   48 ++++++++++++++++++++++++++++++++++++++++++=
++++++
 2 files changed, 49 insertions(+)

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 2df35e65557d..4eb3d4177a53 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -40,6 +40,7 @@ int filemap_fdatawait_keep_errors(struct address_space *=
mapping);
 int filemap_fdatawait_range(struct address_space *, loff_t lstart, loff_t=
 lend);
 int filemap_fdatawait_range_keep_errors(struct address_space *mapping,
 		loff_t start_byte, loff_t end_byte);
+int filemap_invalidate_inode(struct inode *inode, bool flush);
 =

 static inline int filemap_fdatawait(struct address_space *mapping)
 {
diff --git a/mm/filemap.c b/mm/filemap.c
index 25983f0f96e3..98f439bedb44 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -4134,6 +4134,54 @@ bool filemap_release_folio(struct folio *folio, gfp=
_t gfp)
 }
 EXPORT_SYMBOL(filemap_release_folio);
 =

+/**
+ * filemap_invalidate_inode - Invalidate/forcibly write back an inode's p=
agecache
+ * @inode: The inode to flush
+ * @flush: Set to write back rather than simply invalidate.
+ *
+ * Invalidate all the folios on an inode, possibly writing them back firs=
t.
+ * Whilst the operation is undertaken, the invalidate lock is held to pre=
vent
+ * new folios from being installed.
+ */
+int filemap_invalidate_inode(struct inode *inode, bool flush)
+{
+	struct address_space *mapping =3D inode->i_mapping;
+
+	if (!mapping || !mapping->nrpages)
+		goto out;
+
+	/* Prevent new folios from being added to the inode. */
+	filemap_invalidate_lock(mapping);
+
+	if (!mapping->nrpages)
+		goto unlock;
+
+	/* Assume there are probably PTEs only if there are mmaps. */
+	if (unlikely(!RB_EMPTY_ROOT(&mapping->i_mmap.rb_root)))
+		unmap_mapping_pages(mapping, 0, ULONG_MAX, false);
+
+	/* Write back the data if we're asked to. */
+	if (flush) {
+		struct writeback_control wbc =3D {
+			.sync_mode	=3D WB_SYNC_ALL,
+			.nr_to_write	=3D LONG_MAX,
+			.range_start	=3D 0,
+			.range_end	=3D LLONG_MAX,
+		};
+
+		filemap_fdatawrite_wbc(mapping, &wbc);
+	}
+
+	/* Wait for writeback to complete on all folios and discard. */
+	truncate_inode_pages_range(mapping, 0, LLONG_MAX);
+
+unlock:
+	filemap_invalidate_unlock(mapping);
+out:
+	return filemap_check_errors(mapping);
+}
+EXPORT_SYMBOL(filemap_invalidate_inode);
+
 #ifdef CONFIG_CACHESTAT_SYSCALL
 /**
  * filemap_cachestat() - compute the page cache statistics of a mapping


