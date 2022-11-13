Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61EC162708D
	for <lists+linux-fsdevel@lfdr.de>; Sun, 13 Nov 2022 17:29:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235338AbiKMQ3h (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 13 Nov 2022 11:29:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235365AbiKMQ3a (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 13 Nov 2022 11:29:30 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E75610B50;
        Sun, 13 Nov 2022 08:29:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=5EEi8cInv3ks31I/nmTl0wJaf2VmtmozgKaSoblZ/nw=; b=1SbIPs1iFU+7TJOgzkiJf2RvBs
        2XzmwVKtUH+kZqH7A36H1Wbg+vKnJpDNlb6xKtvuTlKG0eGjPoQQYRvlscMAAocgvR6VMPofTIG2D
        C+y5XrFdah5UyaOY7msF15XC44ocxoaKSrFQ6FttO4KIK9nTS4cuGeLqvpIl9ulpzUdcM4c+JMwjM
        V8FaL9blLKhDvLC8WvpLfuXFxjXC9wudXB9FmyTMvzWE6wkwNl+IkzupEJSkEGn6t5dX2vBO8ZlRk
        HQdfmuqFBmta5GLulUNuImMueBME4ZGS+MBcQ/xhhfaXZ0G/j/xK5VJycJsTzRVisDdUNap2eB7Ql
        vz3UMr+A==;
Received: from 213-225-8-167.nat.highway.a1.net ([213.225.8.167] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ouFrH-00CJqO-HX; Sun, 13 Nov 2022 16:29:24 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Namjae Jeon <linkinjeon@kernel.org>,
        Sungjong Seo <sj1557.seo@samsung.com>,
        Jan Kara <jack@suse.com>,
        OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
        Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>,
        Dave Kleikamp <shaggy@kernel.org>,
        Bob Copeland <me@bobcopeland.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        jfs-discussion@lists.sourceforge.net,
        linux-karma-devel@lists.sourceforge.net, linux-mm@kvack.org
Subject: [PATCH 4/9] hfs: remove ->writepage
Date:   Sun, 13 Nov 2022 17:28:57 +0100
Message-Id: <20221113162902.883850-5-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221113162902.883850-1-hch@lst.de>
References: <20221113162902.883850-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

->writepage is a very inefficient method to write back data, and only
used through write_cache_pages or a a fallback when no ->migrate_folio
method is present.

Set ->migrate_folio to the generic buffer_head based helper, and stop
wiring up ->writepage for hfs_aops.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/hfs/inode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/hfs/inode.c b/fs/hfs/inode.c
index c4526f16355d5..16466a5e88b44 100644
--- a/fs/hfs/inode.c
+++ b/fs/hfs/inode.c
@@ -173,12 +173,12 @@ const struct address_space_operations hfs_aops = {
 	.dirty_folio	= block_dirty_folio,
 	.invalidate_folio = block_invalidate_folio,
 	.read_folio	= hfs_read_folio,
-	.writepage	= hfs_writepage,
 	.write_begin	= hfs_write_begin,
 	.write_end	= generic_write_end,
 	.bmap		= hfs_bmap,
 	.direct_IO	= hfs_direct_IO,
 	.writepages	= hfs_writepages,
+	.migrate_folio	= buffer_migrate_folio,
 };
 
 /*
-- 
2.30.2

