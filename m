Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 595D32854D8
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Oct 2020 01:14:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727420AbgJFXJm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 6 Oct 2020 19:09:42 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:17919 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725972AbgJFXJl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 6 Oct 2020 19:09:41 -0400
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5f7cf9280000>; Tue, 06 Oct 2020 16:09:28 -0700
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 6 Oct
 2020 23:09:37 +0000
Received: from rcampbell-dev.nvidia.com (10.124.1.5) by mail.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server id 15.0.1473.3 via Frontend
 Transport; Tue, 6 Oct 2020 23:09:37 +0000
From:   Ralph Campbell <rcampbell@nvidia.com>
To:     <linux-mm@kvack.org>, <linux-xfs@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>, <linux-nvdimm@lists.01.org>,
        <linux-kernel@vger.kernel.org>, <linux-ext4@vger.kernel.org>
CC:     Dan Williams <dan.j.williams@intel.com>,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Theodore Ts'o <tytso@mit.edu>, Christoph Hellwig <hch@lst.de>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Ralph Campbell" <rcampbell@nvidia.com>
Subject: [PATCH] ext4/xfs: add page refcount helper
Date:   Tue, 6 Oct 2020 16:09:30 -0700
Message-ID: <20201006230930.3908-1-rcampbell@nvidia.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1602025768; bh=E0cxvA4vU4/wkdnPscc9MTh2dGOKgzOFQvaQ+2UKi60=;
        h=From:To:CC:Subject:Date:Message-ID:X-Mailer:MIME-Version:
         X-NVConfidentiality:Content-Transfer-Encoding:Content-Type;
        b=AUgsYXGQGWBxrale+BYRsfEFTPAuUyQI9CuVa7/Ku4eOaD9ZGr7Do59J4s5qsUqml
         1MEW+PGQbtMbc9CvXgvtAT05KeB/s2DypJO3A+zcXX3cc1XOOiBRpjQ3K9scBIH6US
         z9RE9nEow7wQvFNvKV1cgXz/ZpsmTm/g+fzVYXtugLdA3TSQP+ABXddyx0hka75ziw
         Jo6BbL0r7BCL7iD6Hi4ovmO8nA03mPrueqlCz3ynhmyfboKR8IatKcaxFkHKChe7Ke
         0uDowqYmCT2Lp6wBnVK3P7Bluv/nZQVVo6beZ00BDkqWegnPQFtLT2v30XS7vdH7Um
         epFTlUr1gBk5Q==
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

There are several places where ZONE_DEVICE struct pages assume a reference
count =3D=3D 1 means the page is idle and free. Instead of open coding this=
,
add a helper function to hide this detail.

Signed-off-by: Ralph Campbell <rcampbell@nvidia.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---

I'm resending this as a separate patch since I think it is ready to
merge. Originally, this was part of an RFC and is unchanged from v3:
https://lore.kernel.org/linux-mm/20201001181715.17416-1-rcampbell@nvidia.co=
m

It applies cleanly to linux-5.9.0-rc7-mm1 but doesn't really
depend on anything, just simple merge conflicts when applied to
other trees.
I'll let the various maintainers decide which tree and when to merge.
It isn't urgent since it is a clean up patch.

 fs/dax.c            |  4 ++--
 fs/ext4/inode.c     |  5 +----
 fs/xfs/xfs_file.c   |  4 +---
 include/linux/dax.h | 10 ++++++++++
 4 files changed, 14 insertions(+), 9 deletions(-)

diff --git a/fs/dax.c b/fs/dax.c
index 5b47834f2e1b..85c63f735909 100644
--- a/fs/dax.c
+++ b/fs/dax.c
@@ -358,7 +358,7 @@ static void dax_disassociate_entry(void *entry, struct =
address_space *mapping,
 	for_each_mapped_pfn(entry, pfn) {
 		struct page *page =3D pfn_to_page(pfn);
=20
-		WARN_ON_ONCE(trunc && page_ref_count(page) > 1);
+		WARN_ON_ONCE(trunc && !dax_layout_is_idle_page(page));
 		WARN_ON_ONCE(page->mapping && page->mapping !=3D mapping);
 		page->mapping =3D NULL;
 		page->index =3D 0;
@@ -372,7 +372,7 @@ static struct page *dax_busy_page(void *entry)
 	for_each_mapped_pfn(entry, pfn) {
 		struct page *page =3D pfn_to_page(pfn);
=20
-		if (page_ref_count(page) > 1)
+		if (!dax_layout_is_idle_page(page))
 			return page;
 	}
 	return NULL;
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 771ed8b1fadb..132620cbfa13 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -3937,10 +3937,7 @@ int ext4_break_layouts(struct inode *inode)
 		if (!page)
 			return 0;
=20
-		error =3D ___wait_var_event(&page->_refcount,
-				atomic_read(&page->_refcount) =3D=3D 1,
-				TASK_INTERRUPTIBLE, 0, 0,
-				ext4_wait_dax_page(ei));
+		error =3D dax_wait_page(ei, page, ext4_wait_dax_page);
 	} while (error =3D=3D 0);
=20
 	return error;
diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
index 3d1b95124744..a5304aaeaa3a 100644
--- a/fs/xfs/xfs_file.c
+++ b/fs/xfs/xfs_file.c
@@ -749,9 +749,7 @@ xfs_break_dax_layouts(
 		return 0;
=20
 	*retry =3D true;
-	return ___wait_var_event(&page->_refcount,
-			atomic_read(&page->_refcount) =3D=3D 1, TASK_INTERRUPTIBLE,
-			0, 0, xfs_wait_dax_page(inode));
+	return dax_wait_page(inode, page, xfs_wait_dax_page);
 }
=20
 int
diff --git a/include/linux/dax.h b/include/linux/dax.h
index b52f084aa643..8909a91cd381 100644
--- a/include/linux/dax.h
+++ b/include/linux/dax.h
@@ -243,6 +243,16 @@ static inline bool dax_mapping(struct address_space *m=
apping)
 	return mapping->host && IS_DAX(mapping->host);
 }
=20
+static inline bool dax_layout_is_idle_page(struct page *page)
+{
+	return page_ref_count(page) =3D=3D 1;
+}
+
+#define dax_wait_page(_inode, _page, _wait_cb)				\
+	___wait_var_event(&(_page)->_refcount,				\
+		dax_layout_is_idle_page(_page),				\
+		TASK_INTERRUPTIBLE, 0, 0, _wait_cb(_inode))
+
 #ifdef CONFIG_DEV_DAX_HMEM_DEVICES
 void hmem_register_device(int target_nid, struct resource *r);
 #else
--=20
2.20.1

