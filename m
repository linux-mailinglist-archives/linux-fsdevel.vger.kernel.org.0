Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C396524C09D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Aug 2020 16:29:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728105AbgHTO3x (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 Aug 2020 10:29:53 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:53967 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728053AbgHTO3t (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 Aug 2020 10:29:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1597933787;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=f5byA5dDpaDRXFEHi0ndzlVzvKvR1BaFn36iJu3R+aM=;
        b=g2p7H5/W/+2+tnzf+1JGQBH5OBfRiEep2tOpoFPogiWcVssd7J+09KE/6G6EO/SShs5fvM
        +XAHtEmlGK/XvN2vEfRuVPpqruvJMrOQ0mvf7+zLck89LcYDnpNSifV1gIjPlZt9duA+P5
        UPNhc+/ONQkl7HcGcYeFAwgtMg7NrxQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-393-0GcKOQCYOzuU6yrCo-a_Qw-1; Thu, 20 Aug 2020 10:29:43 -0400
X-MC-Unique: 0GcKOQCYOzuU6yrCo-a_Qw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E22948030B3;
        Thu, 20 Aug 2020 14:29:41 +0000 (UTC)
Received: from horse.redhat.com (ovpn-116-182.rdu2.redhat.com [10.10.116.182])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BEA401B47B;
        Thu, 20 Aug 2020 14:29:35 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 480C5220CD1; Thu, 20 Aug 2020 10:29:35 -0400 (EDT)
Date:   Thu, 20 Aug 2020 10:29:35 -0400
From:   Vivek Goyal <vgoyal@redhat.com>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvdimm@lists.01.org, virtio-fs@redhat.com, miklos@szeredi.hu,
        stefanha@redhat.com, dgilbert@redhat.com, dan.j.williams@intel.com,
        Vishal L Verma <vishal.l.verma@intel.com>,
        "Weiny, Ira" <ira.weiny@intel.com>
Subject: Re: [PATCH v3 02/18] dax: Create a range version of
 dax_layout_busy_page()
Message-ID: <20200820142935.GA859152@redhat.com>
References: <20200819221956.845195-1-vgoyal@redhat.com>
 <20200819221956.845195-3-vgoyal@redhat.com>
 <20200820125855.GL1902@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200820125855.GL1902@quack2.suse.cz>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Aug 20, 2020 at 02:58:55PM +0200, Jan Kara wrote:
[..]
> >  /**
> > - * dax_layout_busy_page - find first pinned page in @mapping
> > + * dax_layout_busy_page_range - find first pinned page in @mapping
> >   * @mapping: address space to scan for a page with ref count > 1
> 
> Please document additional function arguments in the kernel-doc comment.
> 
> Otherwise the patch looks good so feel free to add:
> 
> Reviewed-by: Jan Kara <jack@suse.cz>
> 
> after fixing this nit.
> 

Hi Jan

Thanks for the review. Here is the updated patch. I also captured your
Reviewed-by.


From 3f81f769be9419ffc5a788833339ed439dbcd48e Mon Sep 17 00:00:00 2001
From: Vivek Goyal <vgoyal@redhat.com>
Date: Tue, 3 Mar 2020 14:58:21 -0500
Subject: [PATCH 02/20] dax: Create a range version of dax_layout_busy_page()

virtiofs device has a range of memory which is mapped into file inodes
using dax. This memory is mapped in qemu on host and maps different
sections of real file on host. Size of this memory is limited
(determined by administrator) and depending on filesystem size, we will
soon reach a situation where all the memory is in use and we need to
reclaim some.

As part of reclaim process, we will need to make sure that there are
no active references to pages (taken by get_user_pages()) on the memory
range we are trying to reclaim. I am planning to use
dax_layout_busy_page() for this. But in current form this is per inode
and scans through all the pages of the inode.

We want to reclaim only a portion of memory (say 2MB page). So we want
to make sure that only that 2MB range of pages do not have any
references  (and don't want to unmap all the pages of inode).

Hence, create a range version of this function named
dax_layout_busy_page_range() which can be used to pass a range which
needs to be unmapped.

Cc: Dan Williams <dan.j.williams@intel.com>
Cc: linux-nvdimm@lists.01.org
Cc: Jan Kara <jack@suse.cz>
Cc: Vishal L Verma <vishal.l.verma@intel.com>
Cc: "Weiny, Ira" <ira.weiny@intel.com>
Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
Reviewed-by: Jan Kara <jack@suse.cz>
---
 fs/dax.c            |   29 +++++++++++++++++++++++------
 include/linux/dax.h |    6 ++++++
 2 files changed, 29 insertions(+), 6 deletions(-)

Index: redhat-linux/fs/dax.c
===================================================================
--- redhat-linux.orig/fs/dax.c	2020-08-20 14:04:41.995676669 +0000
+++ redhat-linux/fs/dax.c	2020-08-20 14:15:20.072676669 +0000
@@ -559,8 +559,11 @@ fallback:
 }
 
 /**
- * dax_layout_busy_page - find first pinned page in @mapping
+ * dax_layout_busy_page_range - find first pinned page in @mapping
  * @mapping: address space to scan for a page with ref count > 1
+ * @start: Starting offset. Page containing 'start' is included.
+ * @end: End offset. Page containing 'end' is included. If 'end' is LLONG_MAX,
+ *       pages from 'start' till the end of file are included.
  *
  * DAX requires ZONE_DEVICE mapped pages. These pages are never
  * 'onlined' to the page allocator so they are considered idle when
@@ -573,12 +576,15 @@ fallback:
  * to be able to run unmap_mapping_range() and subsequently not race
  * mapping_mapped() becoming true.
  */
-struct page *dax_layout_busy_page(struct address_space *mapping)
+struct page *dax_layout_busy_page_range(struct address_space *mapping,
+					loff_t start, loff_t end)
 {
-	XA_STATE(xas, &mapping->i_pages, 0);
 	void *entry;
 	unsigned int scanned = 0;
 	struct page *page = NULL;
+	pgoff_t start_idx = start >> PAGE_SHIFT;
+	pgoff_t end_idx;
+	XA_STATE(xas, &mapping->i_pages, start_idx);
 
 	/*
 	 * In the 'limited' case get_user_pages() for dax is disabled.
@@ -589,6 +595,11 @@ struct page *dax_layout_busy_page(struct
 	if (!dax_mapping(mapping) || !mapping_mapped(mapping))
 		return NULL;
 
+	/* If end == LLONG_MAX, all pages from start to till end of file */
+	if (end == LLONG_MAX)
+		end_idx = ULONG_MAX;
+	else
+		end_idx = end >> PAGE_SHIFT;
 	/*
 	 * If we race get_user_pages_fast() here either we'll see the
 	 * elevated page count in the iteration and wait, or
@@ -596,15 +607,15 @@ struct page *dax_layout_busy_page(struct
 	 * against is no longer mapped in the page tables and bail to the
 	 * get_user_pages() slow path.  The slow path is protected by
 	 * pte_lock() and pmd_lock(). New references are not taken without
-	 * holding those locks, and unmap_mapping_range() will not zero the
+	 * holding those locks, and unmap_mapping_pages() will not zero the
 	 * pte or pmd without holding the respective lock, so we are
 	 * guaranteed to either see new references or prevent new
 	 * references from being established.
 	 */
-	unmap_mapping_range(mapping, 0, 0, 0);
+	unmap_mapping_pages(mapping, start_idx, end_idx - start_idx + 1, 0);
 
 	xas_lock_irq(&xas);
-	xas_for_each(&xas, entry, ULONG_MAX) {
+	xas_for_each(&xas, entry, end_idx) {
 		if (WARN_ON_ONCE(!xa_is_value(entry)))
 			continue;
 		if (unlikely(dax_is_locked(entry)))
@@ -625,6 +636,12 @@ struct page *dax_layout_busy_page(struct
 	xas_unlock_irq(&xas);
 	return page;
 }
+EXPORT_SYMBOL_GPL(dax_layout_busy_page_range);
+
+struct page *dax_layout_busy_page(struct address_space *mapping)
+{
+	return dax_layout_busy_page_range(mapping, 0, LLONG_MAX);
+}
 EXPORT_SYMBOL_GPL(dax_layout_busy_page);
 
 static int __dax_invalidate_entry(struct address_space *mapping,
Index: redhat-linux/include/linux/dax.h
===================================================================
--- redhat-linux.orig/include/linux/dax.h	2020-08-20 14:04:42.014676669 +0000
+++ redhat-linux/include/linux/dax.h	2020-08-20 14:04:56.867676669 +0000
@@ -141,6 +141,7 @@ int dax_writeback_mapping_range(struct a
 		struct dax_device *dax_dev, struct writeback_control *wbc);
 
 struct page *dax_layout_busy_page(struct address_space *mapping);
+struct page *dax_layout_busy_page_range(struct address_space *mapping, loff_t start, loff_t end);
 dax_entry_t dax_lock_page(struct page *page);
 void dax_unlock_page(struct page *page, dax_entry_t cookie);
 #else
@@ -170,6 +171,11 @@ static inline struct page *dax_layout_bu
 {
 	return NULL;
 }
+
+static inline struct page *dax_layout_busy_page_range(struct address_space *mapping, pgoff_t start, pgoff_t nr_pages)
+{
+	return NULL;
+}
 
 static inline int dax_writeback_mapping_range(struct address_space *mapping,
 		struct dax_device *dax_dev, struct writeback_control *wbc)

