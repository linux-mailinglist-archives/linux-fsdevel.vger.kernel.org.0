Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E900E2C1DE3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Nov 2020 07:10:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729488AbgKXGIP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Nov 2020 01:08:15 -0500
Received: from mga06.intel.com ([134.134.136.31]:47294 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729472AbgKXGIN (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Nov 2020 01:08:13 -0500
IronPort-SDR: N6CajM/9X0OWyIN8QWFV+9WRFPRMRJC3i+rOXweeiG7w/2G/dGdiqL4Y9lbDtTscdx7K8SlwSX
 HuTi+hyfePLg==
X-IronPort-AV: E=McAfee;i="6000,8403,9814"; a="233504045"
X-IronPort-AV: E=Sophos;i="5.78,365,1599548400"; 
   d="scan'208";a="233504045"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2020 22:08:13 -0800
IronPort-SDR: kXiqK5kkYEw8PWEc8T5dcga78jp44smEtUsFyYb5/zY3t6D9fGe2JMFe6RVWipJ+wdBOUf7mQ/
 xM1WmOGTetfg==
X-IronPort-AV: E=Sophos;i="5.78,365,1599548400"; 
   d="scan'208";a="478391608"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2020 22:08:13 -0800
From:   ira.weiny@intel.com
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Ira Weiny <ira.weiny@intel.com>,
        Kirti Wankhede <kwankhede@nvidia.com>,
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
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 17/17] samples: Use memcpy_to/from_page()
Date:   Mon, 23 Nov 2020 22:07:55 -0800
Message-Id: <20201124060755.1405602-18-ira.weiny@intel.com>
X-Mailer: git-send-email 2.28.0.rc0.12.gb6a658bd00c9
In-Reply-To: <20201124060755.1405602-1-ira.weiny@intel.com>
References: <20201124060755.1405602-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Ira Weiny <ira.weiny@intel.com>

Remove kmap/mem*()/kunmap pattern and use memcpy_to/from_page()

Cc: Kirti Wankhede <kwankhede@nvidia.com>
Signed-off-by: Ira Weiny <ira.weiny@intel.com>
---
 samples/vfio-mdev/mbochs.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/samples/vfio-mdev/mbochs.c b/samples/vfio-mdev/mbochs.c
index e03068917273..54fe04f63c66 100644
--- a/samples/vfio-mdev/mbochs.c
+++ b/samples/vfio-mdev/mbochs.c
@@ -30,6 +30,7 @@
 #include <linux/iommu.h>
 #include <linux/sysfs.h>
 #include <linux/mdev.h>
+#include <linux/pagemap.h>
 #include <linux/pci.h>
 #include <linux/dma-buf.h>
 #include <linux/highmem.h>
@@ -442,7 +443,6 @@ static ssize_t mdev_access(struct mdev_device *mdev, char *buf, size_t count,
 	struct device *dev = mdev_dev(mdev);
 	struct page *pg;
 	loff_t poff;
-	char *map;
 	int ret = 0;
 
 	mutex_lock(&mdev_state->ops_lock);
@@ -479,12 +479,10 @@ static ssize_t mdev_access(struct mdev_device *mdev, char *buf, size_t count,
 		pos -= MBOCHS_MMIO_BAR_OFFSET;
 		poff = pos & ~PAGE_MASK;
 		pg = __mbochs_get_page(mdev_state, pos >> PAGE_SHIFT);
-		map = kmap(pg);
 		if (is_write)
-			memcpy(map + poff, buf, count);
+			memcpy_to_page(pg, poff, buf, count);
 		else
-			memcpy(buf, map + poff, count);
-		kunmap(pg);
+			memcpy_from_page(buf, pg, poff, count);
 		put_page(pg);
 
 	} else {
-- 
2.28.0.rc0.12.gb6a658bd00c9

