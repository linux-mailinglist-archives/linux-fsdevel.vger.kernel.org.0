Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4915231D409
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Feb 2021 03:50:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230303AbhBQCtU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 Feb 2021 21:49:20 -0500
Received: from mga07.intel.com ([134.134.136.100]:54788 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230202AbhBQCtR (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 Feb 2021 21:49:17 -0500
IronPort-SDR: L5ltZkMao/PfGH3NdmtXzFHU/FTbz8wMyFT5JcMd1lQdRgzcQm5rd0WIgS8B2uUuZ12CfQ51FI
 pTHMU5hEAO/g==
X-IronPort-AV: E=McAfee;i="6000,8403,9897"; a="247152616"
X-IronPort-AV: E=Sophos;i="5.81,184,1610438400"; 
   d="scan'208";a="247152616"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2021 18:48:40 -0800
IronPort-SDR: 7LMwaSuAxpeIYaM9e2fldnuMCr5WKaInfh70R5O7PfuPDkkggVYmcgga50ZtHU+2yMuRQivAN3
 O3wNXnpQcNAg==
X-IronPort-AV: E=Sophos;i="5.81,184,1610438400"; 
   d="scan'208";a="384922343"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2021 18:48:39 -0800
From:   ira.weiny@intel.com
To:     David Sterba <dsterba@suse.cz>
Cc:     Ira Weiny <ira.weiny@intel.com>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 4/4] fs/btrfs: Convert block context kmap's to kmap_local_page()
Date:   Tue, 16 Feb 2021 18:48:26 -0800
Message-Id: <20210217024826.3466046-5-ira.weiny@intel.com>
X-Mailer: git-send-email 2.28.0.rc0.12.gb6a658bd00c9
In-Reply-To: <20210217024826.3466046-1-ira.weiny@intel.com>
References: <20210217024826.3466046-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Ira Weiny <ira.weiny@intel.com>

btrfsic_read_block() (which calls kmap()) and
btrfsic_release_block_ctx() (which calls kunmap()) are always called
within a single thread of execution.

Therefore the mappings created within these calls can be a thread local
mapping.

Convert the kmap() of bloc_ctx->pagev to kmap_local_page().  Luckily the
unmap loops backwards through the array pointer so no adjustment needs
to be made to the unmapping order.

Signed-off-by: Ira Weiny <ira.weiny@intel.com>
---
 fs/btrfs/check-integrity.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/check-integrity.c b/fs/btrfs/check-integrity.c
index 726eb894be8b..1ff9e19508a7 100644
--- a/fs/btrfs/check-integrity.c
+++ b/fs/btrfs/check-integrity.c
@@ -1558,7 +1558,7 @@ static void btrfsic_release_block_ctx(struct btrfsic_block_data_ctx *block_ctx)
 		while (num_pages > 0) {
 			num_pages--;
 			if (block_ctx->datav[num_pages]) {
-				kunmap(block_ctx->pagev[num_pages]);
+				kunmap_local(block_ctx->datav[num_pages]);
 				block_ctx->datav[num_pages] = NULL;
 			}
 			if (block_ctx->pagev[num_pages]) {
@@ -1637,7 +1637,7 @@ static int btrfsic_read_block(struct btrfsic_state *state,
 		i = j;
 	}
 	for (i = 0; i < num_pages; i++)
-		block_ctx->datav[i] = kmap(block_ctx->pagev[i]);
+		block_ctx->datav[i] = kmap_local_page(block_ctx->pagev[i]);
 
 	return block_ctx->len;
 }
-- 
2.28.0.rc0.12.gb6a658bd00c9

