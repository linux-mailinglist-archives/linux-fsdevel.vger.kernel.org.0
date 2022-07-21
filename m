Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0835757D3B2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Jul 2022 20:56:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233273AbiGUS4Z (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Jul 2022 14:56:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231520AbiGUS4Y (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Jul 2022 14:56:24 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 204EB88F06
        for <linux-fsdevel@vger.kernel.org>; Thu, 21 Jul 2022 11:56:24 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 0075C22DA8;
        Thu, 21 Jul 2022 18:55:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1658429724; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1Xf7ug7pGV7b7Kd61htUYjEtK4ETD1DmsM9csVHSmWE=;
        b=i3vhn5/jsZyXLF0BRjN4t6JaamyAqcz0pc0wUq7fDtwOP0e+/pSdIw+zmrl7nguI7UyS2R
        IuQs1/5gXeDVGJf4WFmwAWZ+EnJdGex/PdqH/NKGihWVFmEBLq7z4i1n9WQMHT6Yoowjrx
        SRRE9egWZEnvP2nRKA984lupyjGB5AE=
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id C0C452C141;
        Thu, 21 Jul 2022 18:55:23 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id EA983DA83C; Thu, 21 Jul 2022 20:50:29 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>, Ira Weiny <ira.weiny@intel.com>,
        "Fabio M . De Francesco" <fmdefrancesco@gmail.com>
Subject: [PATCH v2] affs: use memcpy_to_zero and remove replace kmap_atomic()
Date:   Thu, 21 Jul 2022 20:50:24 +0200
Message-Id: <20220721185024.5789-1-dsterba@suse.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220712222744.24783-1-dsterba@suse.com>
References: <20220712222744.24783-1-dsterba@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The use of kmap() is being deprecated in favor of kmap_local_page()
where it is feasible. For kmap around a memcpy there's a convenience
helper memcpy_to_page, use it.

CC: Ira Weiny <ira.weiny@intel.com>
CC: Fabio M. De Francesco <fmdefrancesco@gmail.com>
Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/affs/file.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/fs/affs/file.c b/fs/affs/file.c
index cd00a4c68a12..45a21729f358 100644
--- a/fs/affs/file.c
+++ b/fs/affs/file.c
@@ -526,7 +526,6 @@ affs_do_readpage_ofs(struct page *page, unsigned to, int create)
 	struct inode *inode = page->mapping->host;
 	struct super_block *sb = inode->i_sb;
 	struct buffer_head *bh;
-	char *data;
 	unsigned pos = 0;
 	u32 bidx, boff, bsize;
 	u32 tmp;
@@ -545,9 +544,7 @@ affs_do_readpage_ofs(struct page *page, unsigned to, int create)
 			return PTR_ERR(bh);
 		tmp = min(bsize - boff, to - pos);
 		BUG_ON(pos + tmp > to || tmp > bsize);
-		data = kmap_atomic(page);
-		memcpy(data + pos, AFFS_DATA(bh) + boff, tmp);
-		kunmap_atomic(data);
+		memcpy_to_page(page, pos, AFFS_DATA(bh) + boff, tmp);
 		affs_brelse(bh);
 		bidx++;
 		pos += tmp;
-- 
2.36.1

