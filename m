Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 491F22C1DDD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Nov 2020 07:10:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729428AbgKXGIK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Nov 2020 01:08:10 -0500
Received: from mga09.intel.com ([134.134.136.24]:46773 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729392AbgKXGIK (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Nov 2020 01:08:10 -0500
IronPort-SDR: tSukXnsy5ujVf6P5I2Qes+gmtFQamP/tFM3ZqLsx8prryjz7t96AJ3lB3OlYkJFJfxeedLPFEJ
 oTpxHyzxpU7Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9814"; a="172052674"
X-IronPort-AV: E=Sophos;i="5.78,365,1599548400"; 
   d="scan'208";a="172052674"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2020 22:08:08 -0800
IronPort-SDR: dPkuJ3cNpwAQdF4IO+jQMXzUYsWknEpJ9XFX9SluvT2WJYgM+NOtXoIN5Iiym2a6VoF/+lWsq2
 rgtY2MOcyv9g==
X-IronPort-AV: E=Sophos;i="5.78,365,1599548400"; 
   d="scan'208";a="343047661"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2020 22:08:07 -0800
From:   ira.weiny@intel.com
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Ira Weiny <ira.weiny@intel.com>, Jaegeuk Kim <jaegeuk@kernel.org>,
        Chao Yu <yuchao0@huawei.com>,
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
        Nicolas Pitre <nico@fluxnic.net>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Brian King <brking@us.ibm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        Kirti Wankhede <kwankhede@nvidia.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 09/17] fs/f2fs: Remove f2fs_copy_page()
Date:   Mon, 23 Nov 2020 22:07:47 -0800
Message-Id: <20201124060755.1405602-10-ira.weiny@intel.com>
X-Mailer: git-send-email 2.28.0.rc0.12.gb6a658bd00c9
In-Reply-To: <20201124060755.1405602-1-ira.weiny@intel.com>
References: <20201124060755.1405602-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Ira Weiny <ira.weiny@intel.com>

The new common function memcpy_page() provides this exactly
functionality.  Remove the local f2fs_copy_page() and call memcpy_page()
instead.

Cc: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: Chao Yu <yuchao0@huawei.com>
Signed-off-by: Ira Weiny <ira.weiny@intel.com>
---
 fs/f2fs/f2fs.h | 10 ----------
 fs/f2fs/file.c |  3 ++-
 2 files changed, 2 insertions(+), 11 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index cb700d797296..546dba7d7cc2 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -2428,16 +2428,6 @@ static inline struct page *f2fs_pagecache_get_page(
 	return pagecache_get_page(mapping, index, fgp_flags, gfp_mask);
 }
 
-static inline void f2fs_copy_page(struct page *src, struct page *dst)
-{
-	char *src_kaddr = kmap(src);
-	char *dst_kaddr = kmap(dst);
-
-	memcpy(dst_kaddr, src_kaddr, PAGE_SIZE);
-	kunmap(dst);
-	kunmap(src);
-}
-
 static inline void f2fs_put_page(struct page *page, int unlock)
 {
 	if (!page)
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index ee861c6d9ff0..c38aa186a7c6 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -17,6 +17,7 @@
 #include <linux/uaccess.h>
 #include <linux/mount.h>
 #include <linux/pagevec.h>
+#include <linux/pagemap.h>
 #include <linux/uio.h>
 #include <linux/uuid.h>
 #include <linux/file.h>
@@ -1234,7 +1235,7 @@ static int __clone_blkaddrs(struct inode *src_inode, struct inode *dst_inode,
 				f2fs_put_page(psrc, 1);
 				return PTR_ERR(pdst);
 			}
-			f2fs_copy_page(psrc, pdst);
+			memcpy_page(psrc, 0, pdst, 0, PAGE_SIZE);
 			set_page_dirty(pdst);
 			f2fs_put_page(pdst, 1);
 			f2fs_put_page(psrc, 1);
-- 
2.28.0.rc0.12.gb6a658bd00c9

