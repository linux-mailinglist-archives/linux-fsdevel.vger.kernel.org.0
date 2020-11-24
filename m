Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECB132C1DDA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Nov 2020 07:10:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729407AbgKXGIJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Nov 2020 01:08:09 -0500
Received: from mga01.intel.com ([192.55.52.88]:19536 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729352AbgKXGIJ (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Nov 2020 01:08:09 -0500
IronPort-SDR: geVYEDrceckE63TiQ+F09/PWTBA1H0KorKtiDXB8rjthEIrk+wtqItL5xSTBZ9V/8+5cRWJk04
 5NsgheQjWpRA==
X-IronPort-AV: E=McAfee;i="6000,8403,9814"; a="190018255"
X-IronPort-AV: E=Sophos;i="5.78,365,1599548400"; 
   d="scan'208";a="190018255"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2020 22:08:08 -0800
IronPort-SDR: 6A3FRQDZPACcFAIZnE7ekmb80a3WtXBzNicKSPp2urUQ0L3+ACQ+pyFW78Rgd1bGhbuGXgX/OA
 xW9/+TJNKiKA==
X-IronPort-AV: E=Sophos;i="5.78,365,1599548400"; 
   d="scan'208";a="370270493"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2020 22:08:06 -0800
From:   ira.weiny@intel.com
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Ira Weiny <ira.weiny@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Dave Hansen <dave.hansen@intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Christoph Hellwig <hch@infradead.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Eric Biggers <ebiggers@kernel.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Patrik Jakobsson <patrik.r.jakobsson@gmail.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Howells <dhowells@redhat.com>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Steve French <sfrench@samba.org>,
        Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <yuchao0@huawei.com>,
        Nicolas Pitre <nico@fluxnic.net>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Brian King <brking@us.ibm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        Kirti Wankhede <kwankhede@nvidia.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 08/17] fs/hfsplus: Convert to mem*_page()
Date:   Mon, 23 Nov 2020 22:07:46 -0800
Message-Id: <20201124060755.1405602-9-ira.weiny@intel.com>
X-Mailer: git-send-email 2.28.0.rc0.12.gb6a658bd00c9
In-Reply-To: <20201124060755.1405602-1-ira.weiny@intel.com>
References: <20201124060755.1405602-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Ira Weiny <ira.weiny@intel.com>

Remove the pattern of kmap/mem*/kunmap in favor of the new mem*_page()
functions which handle the kmap'ing correctly for us.

Signed-off-by: Ira Weiny <ira.weiny@intel.com>
---
 fs/hfsplus/bnode.c | 53 +++++++++++++---------------------------------
 1 file changed, 15 insertions(+), 38 deletions(-)

diff --git a/fs/hfsplus/bnode.c b/fs/hfsplus/bnode.c
index 177fae4e6581..c4347b1cb36f 100644
--- a/fs/hfsplus/bnode.c
+++ b/fs/hfsplus/bnode.c
@@ -29,14 +29,12 @@ void hfs_bnode_read(struct hfs_bnode *node, void *buf, int off, int len)
 	off &= ~PAGE_MASK;
 
 	l = min_t(int, len, PAGE_SIZE - off);
-	memcpy(buf, kmap(*pagep) + off, l);
-	kunmap(*pagep);
+	memcpy_from_page(buf, *pagep, off, l);
 
 	while ((len -= l) != 0) {
 		buf += l;
 		l = min_t(int, len, PAGE_SIZE);
-		memcpy(buf, kmap(*++pagep), l);
-		kunmap(*pagep);
+		memcpy_from_page(buf, *++pagep, 0, l);
 	}
 }
 
@@ -82,16 +80,14 @@ void hfs_bnode_write(struct hfs_bnode *node, void *buf, int off, int len)
 	off &= ~PAGE_MASK;
 
 	l = min_t(int, len, PAGE_SIZE - off);
-	memcpy(kmap(*pagep) + off, buf, l);
+	memcpy_to_page(*pagep, off, buf, l);
 	set_page_dirty(*pagep);
-	kunmap(*pagep);
 
 	while ((len -= l) != 0) {
 		buf += l;
 		l = min_t(int, len, PAGE_SIZE);
-		memcpy(kmap(*++pagep), buf, l);
+		memcpy_to_page(*++pagep, 0, buf, l);
 		set_page_dirty(*pagep);
-		kunmap(*pagep);
 	}
 }
 
@@ -112,15 +108,13 @@ void hfs_bnode_clear(struct hfs_bnode *node, int off, int len)
 	off &= ~PAGE_MASK;
 
 	l = min_t(int, len, PAGE_SIZE - off);
-	memset(kmap(*pagep) + off, 0, l);
+	memzero_page(*pagep, off, l);
 	set_page_dirty(*pagep);
-	kunmap(*pagep);
 
 	while ((len -= l) != 0) {
 		l = min_t(int, len, PAGE_SIZE);
-		memset(kmap(*++pagep), 0, l);
+		memzero_page(*++pagep, 0, l);
 		set_page_dirty(*pagep);
-		kunmap(*pagep);
 	}
 }
 
@@ -142,17 +136,13 @@ void hfs_bnode_copy(struct hfs_bnode *dst_node, int dst,
 
 	if (src == dst) {
 		l = min_t(int, len, PAGE_SIZE - src);
-		memcpy(kmap(*dst_page) + src, kmap(*src_page) + src, l);
-		kunmap(*src_page);
+		memcpy_page(*dst_page, src, *src_page, src, l);
 		set_page_dirty(*dst_page);
-		kunmap(*dst_page);
 
 		while ((len -= l) != 0) {
 			l = min_t(int, len, PAGE_SIZE);
-			memcpy(kmap(*++dst_page), kmap(*++src_page), l);
-			kunmap(*src_page);
+			memcpy_page(*++dst_page, 0, *++src_page, 0, l);
 			set_page_dirty(*dst_page);
-			kunmap(*dst_page);
 		}
 	} else {
 		void *src_ptr, *dst_ptr;
@@ -202,21 +192,16 @@ void hfs_bnode_move(struct hfs_bnode *node, int dst, int src, int len)
 
 		if (src == dst) {
 			while (src < len) {
-				memmove(kmap(*dst_page), kmap(*src_page), src);
-				kunmap(*src_page);
+				memmove_page(*dst_page, 0, *src_page, 0, src);
 				set_page_dirty(*dst_page);
-				kunmap(*dst_page);
 				len -= src;
 				src = PAGE_SIZE;
 				src_page--;
 				dst_page--;
 			}
 			src -= len;
-			memmove(kmap(*dst_page) + src,
-				kmap(*src_page) + src, len);
-			kunmap(*src_page);
+			memmove_page(*dst_page, src, *src_page, src, len);
 			set_page_dirty(*dst_page);
-			kunmap(*dst_page);
 		} else {
 			void *src_ptr, *dst_ptr;
 
@@ -251,19 +236,13 @@ void hfs_bnode_move(struct hfs_bnode *node, int dst, int src, int len)
 
 		if (src == dst) {
 			l = min_t(int, len, PAGE_SIZE - src);
-			memmove(kmap(*dst_page) + src,
-				kmap(*src_page) + src, l);
-			kunmap(*src_page);
+			memmove_page(*dst_page, src, *src_page, src, l);
 			set_page_dirty(*dst_page);
-			kunmap(*dst_page);
 
 			while ((len -= l) != 0) {
 				l = min_t(int, len, PAGE_SIZE);
-				memmove(kmap(*++dst_page),
-					kmap(*++src_page), l);
-				kunmap(*src_page);
+				memmove_page(*++dst_page, 0, *++src_page, 0, l);
 				set_page_dirty(*dst_page);
-				kunmap(*dst_page);
 			}
 		} else {
 			void *src_ptr, *dst_ptr;
@@ -593,14 +572,12 @@ struct hfs_bnode *hfs_bnode_create(struct hfs_btree *tree, u32 num)
 	}
 
 	pagep = node->page;
-	memset(kmap(*pagep) + node->page_offset, 0,
-	       min_t(int, PAGE_SIZE, tree->node_size));
+	memzero_page(*pagep, node->page_offset,
+		     min_t(int, PAGE_SIZE, tree->node_size));
 	set_page_dirty(*pagep);
-	kunmap(*pagep);
 	for (i = 1; i < tree->pages_per_bnode; i++) {
-		memset(kmap(*++pagep), 0, PAGE_SIZE);
+		memzero_page(*++pagep, 0, PAGE_SIZE);
 		set_page_dirty(*pagep);
-		kunmap(*pagep);
 	}
 	clear_bit(HFS_BNODE_NEW, &node->flags);
 	wake_up(&node->lock_wq);
-- 
2.28.0.rc0.12.gb6a658bd00c9

