Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0E642C1DF2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Nov 2020 07:10:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729597AbgKXGIo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Nov 2020 01:08:44 -0500
Received: from mga11.intel.com ([192.55.52.93]:16839 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729350AbgKXGIH (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Nov 2020 01:08:07 -0500
IronPort-SDR: ql3PJgIc1/hF/H/yQyQB86AgvBL50dKyqzz3AZm6KbMYi0XOzeZ0HG0Xu0FuNuigUhtLgDVrMc
 YTWa5uVnZSJA==
X-IronPort-AV: E=McAfee;i="6000,8403,9814"; a="168386490"
X-IronPort-AV: E=Sophos;i="5.78,365,1599548400"; 
   d="scan'208";a="168386490"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2020 22:08:06 -0800
IronPort-SDR: vMyWT9Ts1pPXRYY4Qgt5x6uvQzFmPU/ilBPC97n1U5c8nffZTKCsIj4piilnFL2QZZXR5XVNZs
 xaqdwBtAaXuw==
X-IronPort-AV: E=Sophos;i="5.78,365,1599548400"; 
   d="scan'208";a="327458680"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2020 22:08:05 -0800
From:   ira.weiny@intel.com
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Ira Weiny <ira.weiny@intel.com>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
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
        David Howells <dhowells@redhat.com>,
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
Subject: [PATCH 05/17] fs/btrfs: Convert to memzero_page()
Date:   Mon, 23 Nov 2020 22:07:43 -0800
Message-Id: <20201124060755.1405602-6-ira.weiny@intel.com>
X-Mailer: git-send-email 2.28.0.rc0.12.gb6a658bd00c9
In-Reply-To: <20201124060755.1405602-1-ira.weiny@intel.com>
References: <20201124060755.1405602-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Ira Weiny <ira.weiny@intel.com>

Remove the kmap/memset()/kunmap pattern and use the new memzero_page()
call where possible.

Cc: Chris Mason <clm@fb.com>
Cc: Josef Bacik <josef@toxicpanda.com>
Cc: David Sterba <dsterba@suse.com>
Signed-off-by: Ira Weiny <ira.weiny@intel.com>
---
 fs/btrfs/inode.c | 21 +++++----------------
 1 file changed, 5 insertions(+), 16 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index da58c58ef9aa..b0bcf9493236 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -590,17 +590,12 @@ static noinline int compress_file_range(struct async_chunk *async_chunk)
 		if (!ret) {
 			unsigned long offset = offset_in_page(total_compressed);
 			struct page *page = pages[nr_pages - 1];
-			char *kaddr;
 
 			/* zero the tail end of the last page, we might be
 			 * sending it down to disk
 			 */
-			if (offset) {
-				kaddr = kmap_atomic(page);
-				memset(kaddr + offset, 0,
-				       PAGE_SIZE - offset);
-				kunmap_atomic(kaddr);
-			}
+			if (offset)
+				memzero_page(page, offset, PAGE_SIZE - offset);
 			will_compress = 1;
 		}
 	}
@@ -6485,11 +6480,8 @@ static noinline int uncompress_inline(struct btrfs_path *path,
 	 * cover that region here.
 	 */
 
-	if (max_size + pg_offset < PAGE_SIZE) {
-		char *map = kmap(page);
-		memset(map + pg_offset + max_size, 0, PAGE_SIZE - max_size - pg_offset);
-		kunmap(page);
-	}
+	if (max_size + pg_offset < PAGE_SIZE)
+		memzero_page(page, pg_offset + max_size, PAGE_SIZE - max_size - pg_offset);
 	kfree(tmp);
 	return ret;
 }
@@ -8245,7 +8237,6 @@ vm_fault_t btrfs_page_mkwrite(struct vm_fault *vmf)
 	struct btrfs_ordered_extent *ordered;
 	struct extent_state *cached_state = NULL;
 	struct extent_changeset *data_reserved = NULL;
-	char *kaddr;
 	unsigned long zero_start;
 	loff_t size;
 	vm_fault_t ret;
@@ -8352,10 +8343,8 @@ vm_fault_t btrfs_page_mkwrite(struct vm_fault *vmf)
 		zero_start = PAGE_SIZE;
 
 	if (zero_start != PAGE_SIZE) {
-		kaddr = kmap(page);
-		memset(kaddr + zero_start, 0, PAGE_SIZE - zero_start);
+		memzero_page(page, zero_start, PAGE_SIZE - zero_start);
 		flush_dcache_page(page);
-		kunmap(page);
 	}
 	ClearPageChecked(page);
 	set_page_dirty(page);
-- 
2.28.0.rc0.12.gb6a658bd00c9

