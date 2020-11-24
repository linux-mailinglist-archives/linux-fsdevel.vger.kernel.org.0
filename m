Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 999802C1DE0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Nov 2020 07:10:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729450AbgKXGIM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Nov 2020 01:08:12 -0500
Received: from mga05.intel.com ([192.55.52.43]:21151 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729436AbgKXGIL (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Nov 2020 01:08:11 -0500
IronPort-SDR: ICaA16cn1+bjeTk8rTrQvus1leZ5p+xVkHr1OPV7Ua9tr063k+pDWrIcZwUM10KnGCIJO9/V1/
 RwtNHSJYGutw==
X-IronPort-AV: E=McAfee;i="6000,8403,9814"; a="256605368"
X-IronPort-AV: E=Sophos;i="5.78,365,1599548400"; 
   d="scan'208";a="256605368"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2020 22:08:11 -0800
IronPort-SDR: nxOA9JzerR2df98ZEZCOtQOv4YxKKey5Z+ptd/fz+0d5s84KFhcL2FX9m4me8mvLGLPHx9Zpgh
 v8YxPHFT6dWg==
X-IronPort-AV: E=Sophos;i="5.78,365,1599548400"; 
   d="scan'208";a="402819429"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2020 22:08:10 -0800
From:   ira.weiny@intel.com
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Ira Weiny <ira.weiny@intel.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
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
        Brian King <brking@us.ibm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        Kirti Wankhede <kwankhede@nvidia.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 13/17] drivers/target: Convert to mem*_page()
Date:   Mon, 23 Nov 2020 22:07:51 -0800
Message-Id: <20201124060755.1405602-14-ira.weiny@intel.com>
X-Mailer: git-send-email 2.28.0.rc0.12.gb6a658bd00c9
In-Reply-To: <20201124060755.1405602-1-ira.weiny@intel.com>
References: <20201124060755.1405602-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Ira Weiny <ira.weiny@intel.com>

Remove the kmap/mem*()/kunmap patter and use the new mem*_page()
functions.

Cc: "Martin K. Petersen" <martin.petersen@oracle.com>
Signed-off-by: Ira Weiny <ira.weiny@intel.com>
---
 drivers/target/target_core_rd.c        |  6 ++----
 drivers/target/target_core_transport.c | 10 +++-------
 2 files changed, 5 insertions(+), 11 deletions(-)

diff --git a/drivers/target/target_core_rd.c b/drivers/target/target_core_rd.c
index bf936bbeccfe..30bf0fcae519 100644
--- a/drivers/target/target_core_rd.c
+++ b/drivers/target/target_core_rd.c
@@ -18,6 +18,7 @@
 #include <linux/scatterlist.h>
 #include <linux/slab.h>
 #include <linux/spinlock.h>
+#include <linux/pagemap.h>
 #include <scsi/scsi_proto.h>
 
 #include <target/target_core_base.h>
@@ -117,7 +118,6 @@ static int rd_allocate_sgl_table(struct rd_dev *rd_dev, struct rd_dev_sg_table *
 				sizeof(struct scatterlist));
 	struct page *pg;
 	struct scatterlist *sg;
-	unsigned char *p;
 
 	while (total_sg_needed) {
 		unsigned int chain_entry = 0;
@@ -159,9 +159,7 @@ static int rd_allocate_sgl_table(struct rd_dev *rd_dev, struct rd_dev_sg_table *
 			sg_assign_page(&sg[j], pg);
 			sg[j].length = PAGE_SIZE;
 
-			p = kmap(pg);
-			memset(p, init_payload, PAGE_SIZE);
-			kunmap(pg);
+			memset_page(pg, init_payload, 0, PAGE_SIZE);
 		}
 
 		page_offset += sg_per_table;
diff --git a/drivers/target/target_core_transport.c b/drivers/target/target_core_transport.c
index ff26ab0a5f60..4fec5c728344 100644
--- a/drivers/target/target_core_transport.c
+++ b/drivers/target/target_core_transport.c
@@ -22,6 +22,7 @@
 #include <linux/module.h>
 #include <linux/ratelimit.h>
 #include <linux/vmalloc.h>
+#include <linux/pagemap.h>
 #include <asm/unaligned.h>
 #include <net/sock.h>
 #include <net/tcp.h>
@@ -1689,15 +1690,10 @@ int target_submit_cmd_map_sgls(struct se_cmd *se_cmd, struct se_session *se_sess
 		 */
 		if (!(se_cmd->se_cmd_flags & SCF_SCSI_DATA_CDB) &&
 		     se_cmd->data_direction == DMA_FROM_DEVICE) {
-			unsigned char *buf = NULL;
 
 			if (sgl)
-				buf = kmap(sg_page(sgl)) + sgl->offset;
-
-			if (buf) {
-				memset(buf, 0, sgl->length);
-				kunmap(sg_page(sgl));
-			}
+				memzero_page(sg_page(sgl), sgl->offset,
+					     sgl->length);
 		}
 
 		rc = transport_generic_map_mem_to_cmd(se_cmd, sgl, sgl_count,
-- 
2.28.0.rc0.12.gb6a658bd00c9

