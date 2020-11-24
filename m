Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D0172C1DD2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Nov 2020 07:10:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729335AbgKXGIF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Nov 2020 01:08:05 -0500
Received: from mga01.intel.com ([192.55.52.88]:19536 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729310AbgKXGIE (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Nov 2020 01:08:04 -0500
IronPort-SDR: GnRriJyQry2B0NO9IiCpkpOsHTpAJ86AQlnGYejkyL4tR0aA51AwjM7fiO30E98Sqk8dbmGkIX
 3PeEnBETmf9w==
X-IronPort-AV: E=McAfee;i="6000,8403,9814"; a="190018235"
X-IronPort-AV: E=Sophos;i="5.78,365,1599548400"; 
   d="scan'208";a="190018235"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2020 22:08:04 -0800
IronPort-SDR: dQbxu2ciemBqIAkRNgzNeyXnHV5s5Yt4XMctgTN4x2VNjHrcVOCGAP2F6qaMJNl/acBH2AeYEu
 Q+75it+DWKaA==
X-IronPort-AV: E=Sophos;i="5.78,365,1599548400"; 
   d="scan'208";a="536356331"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2020 22:08:03 -0800
From:   ira.weiny@intel.com
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Ira Weiny <ira.weiny@intel.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Dave Hansen <dave.hansen@intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Christoph Hellwig <hch@infradead.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Eric Biggers <ebiggers@kernel.org>,
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
Subject: [PATCH 02/17] drivers/firmware_loader: Use new memcpy_[to|from]_page()
Date:   Mon, 23 Nov 2020 22:07:40 -0800
Message-Id: <20201124060755.1405602-3-ira.weiny@intel.com>
X-Mailer: git-send-email 2.28.0.rc0.12.gb6a658bd00c9
In-Reply-To: <20201124060755.1405602-1-ira.weiny@intel.com>
References: <20201124060755.1405602-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Ira Weiny <ira.weiny@intel.com>

Too many users are using kmap_*() incorrectly and a common pattern is
for them to kmap/mempcy/kunmap.  Change these calls to use the newly
lifted memcpy_[to|from]_page() calls.

Cc: Luis Chamberlain <mcgrof@kernel.org>
Signed-off-by: Ira Weiny <ira.weiny@intel.com>
---
 drivers/base/firmware_loader/fallback.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/base/firmware_loader/fallback.c b/drivers/base/firmware_loader/fallback.c
index 4dec4b79ae06..dc93dc307d18 100644
--- a/drivers/base/firmware_loader/fallback.c
+++ b/drivers/base/firmware_loader/fallback.c
@@ -10,6 +10,7 @@
 #include <linux/sysctl.h>
 #include <linux/vmalloc.h>
 #include <linux/module.h>
+#include <linux/pagemap.h>
 
 #include "fallback.h"
 #include "firmware.h"
@@ -317,19 +318,17 @@ static void firmware_rw(struct fw_priv *fw_priv, char *buffer,
 			loff_t offset, size_t count, bool read)
 {
 	while (count) {
-		void *page_data;
 		int page_nr = offset >> PAGE_SHIFT;
 		int page_ofs = offset & (PAGE_SIZE-1);
 		int page_cnt = min_t(size_t, PAGE_SIZE - page_ofs, count);
 
-		page_data = kmap(fw_priv->pages[page_nr]);
-
 		if (read)
-			memcpy(buffer, page_data + page_ofs, page_cnt);
+			memcpy_from_page(buffer, fw_priv->pages[page_nr],
+					 page_ofs, page_cnt);
 		else
-			memcpy(page_data + page_ofs, buffer, page_cnt);
+			memcpy_to_page(fw_priv->pages[page_nr], page_ofs,
+				       buffer, page_cnt);
 
-		kunmap(fw_priv->pages[page_nr]);
 		buffer += page_cnt;
 		offset += page_cnt;
 		count -= page_cnt;
-- 
2.28.0.rc0.12.gb6a658bd00c9

