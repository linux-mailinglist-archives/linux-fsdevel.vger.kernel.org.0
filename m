Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50F042855E5
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Oct 2020 03:07:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727302AbgJGBHa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 6 Oct 2020 21:07:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:26932 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726096AbgJGBHV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 6 Oct 2020 21:07:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1602032839;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=X/41onueuJaBmlgLF2k54MrGEllrmeOjrbwZrRsLnD4=;
        b=hboAE3pZkXv/Ggj4MUcsDppHq6s0S+7fXfsI+TialuY0ob0NV1nNXsHvON9rSAOLLq7O8S
        keLXf1A6cn7zKrthwmqlSJ5oBmsR2NC8uHyKAArY1/UChnkG6p0E1AKUEMayWAuJCwCWV7
        6eiiZXHrjtjlvnIych6II+rY/pJPjCc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-441-GVpge7PTMHyeQWqL6v_Zgw-1; Tue, 06 Oct 2020 21:07:15 -0400
X-MC-Unique: GVpge7PTMHyeQWqL6v_Zgw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7D74310BBEC0;
        Wed,  7 Oct 2020 01:07:13 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-119-161.rdu2.redhat.com [10.10.119.161])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 645DC5D9D2;
        Wed,  7 Oct 2020 01:07:12 +0000 (UTC)
From:   jglisse@redhat.com
To:     linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Tejun Heo <tj@kernel.org>, Jan Kara <jack@suse.cz>,
        Josef Bacik <jbacik@fb.com>
Subject: [PATCH 02/14] fs: define filler_t as a function pointer type
Date:   Tue,  6 Oct 2020 21:05:51 -0400
Message-Id: <20201007010603.3452458-3-jglisse@redhat.com>
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

Coccinelle is confuse by filler_t not being a regular function pointer
type. As they are no reason to define filler_t as a non pointer type
redefine it as a function pointer type and update function prototype
accordingly.

Signed-off-by: Jérôme Glisse <jglisse@redhat.com>
Cc: linux-mm@kvack.org
Cc: linux-fsdevel@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>
Cc: Jan Kara <jack@suse.cz>
Cc: Josef Bacik <jbacik@fb.com>
---
 fs/nfs/dir.c            | 2 +-
 fs/nfs/symlink.c        | 4 ++--
 include/linux/pagemap.h | 6 +++---
 mm/filemap.c            | 5 ++---
 mm/readahead.c          | 2 +-
 5 files changed, 9 insertions(+), 10 deletions(-)

diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index cb52db9a0cfb7..da1fe71ae810d 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -740,7 +740,7 @@ static
 struct page *get_cache_page(nfs_readdir_descriptor_t *desc)
 {
 	return read_cache_page(desc->file->f_mapping, desc->page_index,
-			nfs_readdir_filler, desc);
+			(filler_t)nfs_readdir_filler, desc);
 }
 
 /*
diff --git a/fs/nfs/symlink.c b/fs/nfs/symlink.c
index 25ba299fdac2e..76691d94ae5f8 100644
--- a/fs/nfs/symlink.c
+++ b/fs/nfs/symlink.c
@@ -66,8 +66,8 @@ static const char *nfs_get_link(struct dentry *dentry,
 		err = ERR_PTR(nfs_revalidate_mapping(inode, inode->i_mapping));
 		if (err)
 			return err;
-		page = read_cache_page(&inode->i_data, 0, nfs_symlink_filler,
-				inode);
+		page = read_cache_page(&inode->i_data, 0,
+				(filler_t)nfs_symlink_filler, inode);
 		if (IS_ERR(page))
 			return ERR_CAST(page);
 	}
diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 7de11dcd534d6..9acfc605b3bc3 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -264,7 +264,7 @@ static inline gfp_t readahead_gfp_mask(struct address_space *x)
 	return mapping_gfp_mask(x) | __GFP_NORETRY | __GFP_NOWARN;
 }
 
-typedef int filler_t(void *, struct page *);
+typedef int (*filler_t)(void *, struct page *);
 
 pgoff_t page_cache_next_miss(struct address_space *mapping,
 			     pgoff_t index, unsigned long max_scan);
@@ -425,11 +425,11 @@ static inline struct page *grab_cache_page(struct address_space *mapping,
 }
 
 extern struct page * read_cache_page(struct address_space *mapping,
-				pgoff_t index, filler_t *filler, void *data);
+				pgoff_t index, filler_t filler, void *data);
 extern struct page * read_cache_page_gfp(struct address_space *mapping,
 				pgoff_t index, gfp_t gfp_mask);
 extern int read_cache_pages(struct address_space *mapping,
-		struct list_head *pages, filler_t *filler, void *data);
+		struct list_head *pages, filler_t filler, void *data);
 
 static inline struct page *read_mapping_page(struct address_space *mapping,
 				pgoff_t index, void *data)
diff --git a/mm/filemap.c b/mm/filemap.c
index 99c49eeae71b8..2cdbbffc55522 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2942,8 +2942,7 @@ static struct page *wait_on_page_read(struct page *page)
 }
 
 static struct page *do_read_cache_page(struct address_space *mapping,
-				pgoff_t index,
-				int (*filler)(void *, struct page *),
+				pgoff_t index, filler_t filler,
 				void *data,
 				gfp_t gfp)
 {
@@ -3064,7 +3063,7 @@ static struct page *do_read_cache_page(struct address_space *mapping,
  */
 struct page *read_cache_page(struct address_space *mapping,
 				pgoff_t index,
-				int (*filler)(void *, struct page *),
+				filler_t filler,
 				void *data)
 {
 	return do_read_cache_page(mapping, index, filler, data,
diff --git a/mm/readahead.c b/mm/readahead.c
index 3c9a8dd7c56c8..cd67c9cfa931a 100644
--- a/mm/readahead.c
+++ b/mm/readahead.c
@@ -87,7 +87,7 @@ static void read_cache_pages_invalidate_pages(struct address_space *mapping,
  * Returns: %0 on success, error return by @filler otherwise
  */
 int read_cache_pages(struct address_space *mapping, struct list_head *pages,
-			int (*filler)(void *, struct page *), void *data)
+			filler_t filler, void *data)
 {
 	struct page *page;
 	int ret = 0;
-- 
2.26.2

