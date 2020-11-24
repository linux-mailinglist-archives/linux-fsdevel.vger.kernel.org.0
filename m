Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 192892C1DF3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Nov 2020 07:10:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729584AbgKXGIo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Nov 2020 01:08:44 -0500
Received: from mga12.intel.com ([192.55.52.136]:4491 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729351AbgKXGIH (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Nov 2020 01:08:07 -0500
IronPort-SDR: m7IXniPCvH7SWoAM2uOMWaY2cl3ahyGB3rY+pTYLi0uTe3/C1O7Uq/7H/OhlLilaVH0lIjhGTh
 rayQ9XZWNkow==
X-IronPort-AV: E=McAfee;i="6000,8403,9814"; a="151154775"
X-IronPort-AV: E=Sophos;i="5.78,365,1599548400"; 
   d="scan'208";a="151154775"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2020 22:08:06 -0800
IronPort-SDR: XOXk74SQJN6UfTfgRjtMy1UnoNMmGU+yZXHpoOMKvkhtW0wB0obE4fYMy99iOsVJC2pWlNBv/X
 KY4+D8/FHXRQ==
X-IronPort-AV: E=Sophos;i="5.78,365,1599548400"; 
   d="scan'208";a="534733453"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2020 22:08:06 -0800
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
Subject: [PATCH 06/17] fs/hfs: Convert to mem*_page() interface
Date:   Mon, 23 Nov 2020 22:07:44 -0800
Message-Id: <20201124060755.1405602-7-ira.weiny@intel.com>
X-Mailer: git-send-email 2.28.0.rc0.12.gb6a658bd00c9
In-Reply-To: <20201124060755.1405602-1-ira.weiny@intel.com>
References: <20201124060755.1405602-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Ira Weiny <ira.weiny@intel.com>

Where possible remove kmap/mem*/kunmap in favor of the new mem*_page()
calls.

Signed-off-by: Ira Weiny <ira.weiny@intel.com>
---
 fs/hfs/bnode.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/fs/hfs/bnode.c b/fs/hfs/bnode.c
index b63a4df7327b..56037ae5ba69 100644
--- a/fs/hfs/bnode.c
+++ b/fs/hfs/bnode.c
@@ -23,8 +23,7 @@ void hfs_bnode_read(struct hfs_bnode *node, void *buf,
 	off += node->page_offset;
 	page = node->page[0];
 
-	memcpy(buf, kmap(page) + off, len);
-	kunmap(page);
+	memcpy_from_page(buf, page, off, len);
 }
 
 u16 hfs_bnode_read_u16(struct hfs_bnode *node, int off)
@@ -65,8 +64,7 @@ void hfs_bnode_write(struct hfs_bnode *node, void *buf, int off, int len)
 	off += node->page_offset;
 	page = node->page[0];
 
-	memcpy(kmap(page) + off, buf, len);
-	kunmap(page);
+	memcpy_to_page(page, off, buf, len);
 	set_page_dirty(page);
 }
 
@@ -90,8 +88,7 @@ void hfs_bnode_clear(struct hfs_bnode *node, int off, int len)
 	off += node->page_offset;
 	page = node->page[0];
 
-	memset(kmap(page) + off, 0, len);
-	kunmap(page);
+	memzero_page(page, off, len);
 	set_page_dirty(page);
 }
 
@@ -108,9 +105,7 @@ void hfs_bnode_copy(struct hfs_bnode *dst_node, int dst,
 	src_page = src_node->page[0];
 	dst_page = dst_node->page[0];
 
-	memcpy(kmap(dst_page) + dst, kmap(src_page) + src, len);
-	kunmap(src_page);
-	kunmap(dst_page);
+	memcpy_page(dst_page, dst, src_page, src, len);
 	set_page_dirty(dst_page);
 }
 
-- 
2.28.0.rc0.12.gb6a658bd00c9

