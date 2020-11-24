Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 304652C1DE8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Nov 2020 07:10:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729519AbgKXGIZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Nov 2020 01:08:25 -0500
Received: from mga01.intel.com ([192.55.52.88]:19536 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729446AbgKXGIM (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Nov 2020 01:08:12 -0500
IronPort-SDR: t8Cd/D38h5O7O4iGwmPBo1xW6SCsRP51veIaWGbKw5b8zo251aLgYehy17WrQYba8DHIEMgb3E
 RVikmEi5017w==
X-IronPort-AV: E=McAfee;i="6000,8403,9814"; a="190018273"
X-IronPort-AV: E=Sophos;i="5.78,365,1599548400"; 
   d="scan'208";a="190018273"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2020 22:08:12 -0800
IronPort-SDR: qNw+swS2DnlAHVnC/90HMteyfrwtLJ4aJjU5/rJICAXxM7SUh0B0LW4TtqxJ5wrZ53ZhGJXSTj
 Bm8/GhwrlpRQ==
X-IronPort-AV: E=Sophos;i="5.78,365,1599548400"; 
   d="scan'208";a="432504175"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2020 22:08:11 -0800
From:   ira.weiny@intel.com
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Ira Weiny <ira.weiny@intel.com>, Brian King <brking@us.ibm.com>,
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
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        Kirti Wankhede <kwankhede@nvidia.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 14/17] drivers/scsi: Use memcpy_to_page()
Date:   Mon, 23 Nov 2020 22:07:52 -0800
Message-Id: <20201124060755.1405602-15-ira.weiny@intel.com>
X-Mailer: git-send-email 2.28.0.rc0.12.gb6a658bd00c9
In-Reply-To: <20201124060755.1405602-1-ira.weiny@intel.com>
References: <20201124060755.1405602-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Ira Weiny <ira.weiny@intel.com>

Remove kmap/mem*()/kunmap pattern and use memcpy_to_page()

Cc: Brian King <brking@us.ibm.com>
Signed-off-by: Ira Weiny <ira.weiny@intel.com>
---
 drivers/scsi/ipr.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/drivers/scsi/ipr.c b/drivers/scsi/ipr.c
index b0aa58d117cc..3cdd8db24270 100644
--- a/drivers/scsi/ipr.c
+++ b/drivers/scsi/ipr.c
@@ -3912,7 +3912,6 @@ static int ipr_copy_ucode_buffer(struct ipr_sglist *sglist,
 {
 	int bsize_elem, i, result = 0;
 	struct scatterlist *sg;
-	void *kaddr;
 
 	/* Determine the actual number of bytes per element */
 	bsize_elem = PAGE_SIZE * (1 << sglist->order);
@@ -3923,10 +3922,7 @@ static int ipr_copy_ucode_buffer(struct ipr_sglist *sglist,
 			buffer += bsize_elem) {
 		struct page *page = sg_page(sg);
 
-		kaddr = kmap(page);
-		memcpy(kaddr, buffer, bsize_elem);
-		kunmap(page);
-
+		memcpy_to_page(page, 0, buffer, bsize_elem);
 		sg->length = bsize_elem;
 
 		if (result != 0) {
@@ -3938,10 +3934,7 @@ static int ipr_copy_ucode_buffer(struct ipr_sglist *sglist,
 	if (len % bsize_elem) {
 		struct page *page = sg_page(sg);
 
-		kaddr = kmap(page);
-		memcpy(kaddr, buffer, len % bsize_elem);
-		kunmap(page);
-
+		memcpy_to_page(page, 0, buffer, len % bsize_elem);
 		sg->length = len % bsize_elem;
 	}
 
-- 
2.28.0.rc0.12.gb6a658bd00c9

