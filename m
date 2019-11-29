Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3FE7B10D88B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Nov 2019 17:33:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727227AbfK2QdK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 29 Nov 2019 11:33:10 -0500
Received: from mga14.intel.com ([192.55.52.115]:61235 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727200AbfK2QdJ (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 29 Nov 2019 11:33:09 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Nov 2019 08:33:07 -0800
X-IronPort-AV: E=Sophos;i="5.69,257,1571727600"; 
   d="scan'208";a="261567546"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.157])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Nov 2019 08:33:07 -0800
From:   ira.weiny@intel.com
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-nfs@vger.kernel.org,
        linux-mm@kvack.org, Ira Weiny <ira.weiny@intel.com>,
        "Darrick J . Wong" <darrick.wong@oracle.com>
Subject: [PATCH V3 1/3] fs: Clean up mapping variable
Date:   Fri, 29 Nov 2019 08:32:58 -0800
Message-Id: <20191129163300.14749-2-ira.weiny@intel.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191129163300.14749-1-ira.weiny@intel.com>
References: <20191129163300.14749-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Ira Weiny <ira.weiny@intel.com>

The mapping variable is not directly used in these functions.  Just
remove the additional variable.

Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>
Signed-off-by: Ira Weiny <ira.weiny@intel.com>

---
Changes from V2:
	updated Reviews

 fs/f2fs/data.c      | 3 +--
 fs/iomap/swapfile.c | 3 +--
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index a034cd0ce021..9067c7e68992 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -3147,8 +3147,7 @@ int f2fs_migrate_page(struct address_space *mapping,
 /* Copied from generic_swapfile_activate() to check any holes */
 static int check_swap_activate(struct file *swap_file, unsigned int max)
 {
-	struct address_space *mapping = swap_file->f_mapping;
-	struct inode *inode = mapping->host;
+	struct inode *inode = swap_file->f_mapping->host;
 	unsigned blocks_per_page;
 	unsigned long page_no;
 	unsigned blkbits;
diff --git a/fs/iomap/swapfile.c b/fs/iomap/swapfile.c
index a648dbf6991e..80571add0180 100644
--- a/fs/iomap/swapfile.c
+++ b/fs/iomap/swapfile.c
@@ -140,8 +140,7 @@ int iomap_swapfile_activate(struct swap_info_struct *sis,
 		.sis = sis,
 		.lowest_ppage = (sector_t)-1ULL,
 	};
-	struct address_space *mapping = swap_file->f_mapping;
-	struct inode *inode = mapping->host;
+	struct inode *inode = swap_file->f_mapping->host;
 	loff_t pos = 0;
 	loff_t len = ALIGN_DOWN(i_size_read(inode), PAGE_SIZE);
 	loff_t ret;
-- 
2.21.0

