Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C2D87516F9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Jul 2023 05:55:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233749AbjGMDzX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Jul 2023 23:55:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232133AbjGMDzW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Jul 2023 23:55:22 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F5BB1BF2;
        Wed, 12 Jul 2023 20:55:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=W0UYXwWjWGda5omCDxw1jAlh390Lk5TbGcfd3nEU6uE=; b=LRqHvclw5T4FaH8TRmIhenQus/
        ki6KdHGC98/kq7B7fdscjEH+dx/6NClTrk+nPnZo2txh+X0ura3Z57FPxOmRqZYaKu1IBBgBp3Stj
        udId/40CzjMN71gdsy9O489V0KjWEY3t+BDw6lWN2LSPPCsm63yiP3XRiIPA+tlDmsQy0B4CJ8sQA
        lErTqVmfPayPxj6jzEE1IkakDLp+7G/JhdTBnJ+4ErBpIGFFt78zD34/oRemUcsvy8HOKVxiEXnc8
        V8WL/M/E3P4RUIJU69kXS5jJRFWQe4iTfyPOqPenlw+PtcmmnAQICVsH3UnAfg4Ool8Na71sQyvDm
        NmA+BO0Q==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qJnQA-00HMrk-Gp; Thu, 13 Jul 2023 03:55:14 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        David Sterba <dsterba@suse.com>, linux-fsdevel@vger.kernel.org,
        Pankaj Raghav <p.raghav@samsung.com>,
        Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        ntfs3@lists.linux.dev, "Theodore Tso" <tytso@mit.edu>,
        Jan Kara <jack@suse.com>, linux-ext4@vger.kernel.org
Subject: [PATCH 4/7] migrate: Use folio_set_bh() instead of set_bh_page()
Date:   Thu, 13 Jul 2023 04:55:09 +0100
Message-Id: <20230713035512.4139457-5-willy@infradead.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230713035512.4139457-1-willy@infradead.org>
References: <20230713035512.4139457-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This function was converted before folio_set_bh() existed.  Catch
up to the new API.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 mm/migrate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/migrate.c b/mm/migrate.c
index af8557d78549..1363053894ce 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -773,7 +773,7 @@ static int __buffer_migrate_folio(struct address_space *mapping,
 
 	bh = head;
 	do {
-		set_bh_page(bh, &dst->page, bh_offset(bh));
+		folio_set_bh(bh, dst, bh_offset(bh));
 		bh = bh->b_this_page;
 	} while (bh != head);
 
-- 
2.39.2

