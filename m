Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1AA492855EA
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Oct 2020 03:07:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727269AbgJGBH3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 6 Oct 2020 21:07:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:40740 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727254AbgJGBHY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 6 Oct 2020 21:07:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1602032843;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8PSJcheqUDDToEl8LyLenCmOLYWMUxgCUNnl1drojhw=;
        b=IOyzJ/wOCbW4HGjSmT/KdHIo+R+ANRQpLKMTRGCIHbzjTiLzzlDtW/q50XKkgF8W6Hcmal
        mJMIIfovkydvLFPLc1lO8VKCN+NSCqBEfxGPlKqWw/VJWHHg0neAXEN6HD4sTY1BR6b/x0
        djlX5Q38Zl6QL5w72+WOWHZLRFwiIh8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-447-HUx6P1GsOLGRZdvH5bgm_w-1; Tue, 06 Oct 2020 21:07:19 -0400
X-MC-Unique: HUx6P1GsOLGRZdvH5bgm_w-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 62944803F5D;
        Wed,  7 Oct 2020 01:07:17 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-119-161.rdu2.redhat.com [10.10.119.161])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A1F955D9D2;
        Wed,  7 Oct 2020 01:07:13 +0000 (UTC)
From:   jglisse@redhat.com
To:     linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Tejun Heo <tj@kernel.org>, Jan Kara <jack@suse.cz>,
        Josef Bacik <josef@toxicpanda.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 03/14] fs: directly use a_ops->freepage() instead of a local copy of it.
Date:   Tue,  6 Oct 2020 21:05:52 -0400
Message-Id: <20201007010603.3452458-4-jglisse@redhat.com>
In-Reply-To: <20201007010603.3452458-1-jglisse@redhat.com>
References: <20201007010603.3452458-1-jglisse@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Jérôme Glisse <jglisse@redhat.com>

Coccinelle is confuse with function pointer, convert to directly
use a_ops->freepage() to be nice to coccinelle.

Signed-off-by: Jérôme Glisse <jglisse@redhat.com>
Cc: linux-fsdevel@vger.kernel.org
Cc: linux-mm@kvack.org
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Tejun Heo <tj@kernel.org>
Cc: Jan Kara <jack@suse.cz>
Cc: Josef Bacik <josef@toxicpanda.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
---
 mm/filemap.c | 12 ++++--------
 mm/vmscan.c  |  7 ++-----
 2 files changed, 6 insertions(+), 13 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index 2cdbbffc55522..ba892599a2717 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -242,11 +242,8 @@ void __delete_from_page_cache(struct page *page, void *shadow)
 static void page_cache_free_page(struct address_space *mapping,
 				struct page *page)
 {
-	void (*freepage)(struct page *);
-
-	freepage = mapping->a_ops->freepage;
-	if (freepage)
-		freepage(page);
+	if (mapping->a_ops->freepage)
+		mapping->a_ops->freepage(page);
 
 	if (PageTransHuge(page) && !PageHuge(page)) {
 		page_ref_sub(page, HPAGE_PMD_NR);
@@ -790,7 +787,6 @@ EXPORT_SYMBOL(file_write_and_wait_range);
 int replace_page_cache_page(struct page *old, struct page *new, gfp_t gfp_mask)
 {
 	struct address_space *mapping = old->mapping;
-	void (*freepage)(struct page *) = mapping->a_ops->freepage;
 	pgoff_t offset = old->index;
 	XA_STATE(xas, &mapping->i_pages, offset);
 	unsigned long flags;
@@ -819,8 +815,8 @@ int replace_page_cache_page(struct page *old, struct page *new, gfp_t gfp_mask)
 	if (PageSwapBacked(new))
 		__inc_lruvec_page_state(new, NR_SHMEM);
 	xas_unlock_irqrestore(&xas, flags);
-	if (freepage)
-		freepage(old);
+	if (mapping->a_ops->freepage)
+		mapping->a_ops->freepage(old);
 	put_page(old);
 
 	return 0;
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 466fc3144fffc..6db869339073d 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -903,9 +903,6 @@ static int __remove_mapping(struct address_space *mapping, struct page *page,
 		xa_unlock_irqrestore(&mapping->i_pages, flags);
 		put_swap_page(page, swap);
 	} else {
-		void (*freepage)(struct page *);
-
-		freepage = mapping->a_ops->freepage;
 		/*
 		 * Remember a shadow entry for reclaimed file cache in
 		 * order to detect refaults, thus thrashing, later on.
@@ -928,8 +925,8 @@ static int __remove_mapping(struct address_space *mapping, struct page *page,
 		__delete_from_page_cache(page, shadow);
 		xa_unlock_irqrestore(&mapping->i_pages, flags);
 
-		if (freepage != NULL)
-			freepage(page);
+		if (mapping->a_ops->freepage != NULL)
+			mapping->a_ops->freepage(page);
 	}
 
 	return 1;
-- 
2.26.2

