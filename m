Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29454547F13
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Jun 2022 07:46:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234988AbiFMFiv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 13 Jun 2022 01:38:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236447AbiFMFie (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 13 Jun 2022 01:38:34 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF0CAFD1C;
        Sun, 12 Jun 2022 22:37:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=yp9JrU6zBzJaajQeIlP0lIblv6A5iD96YhS/6T2BaJk=; b=Y/73mhRjxh+61P5DLuz7lHovuq
        M1/hC+K2lvahuhqkr8BptlKW2A+SI1Y8T3ZNEopswkuOV+Wt+ZlpkKSS3DJtCIm1mFUOnu1BwcFIf
        LdKEB2IQ0KC/Js87SKRnBky++ypliWGmpIXhfO2qF7aF586BTl9Pl98CjUs+VxEn9UvLjrikEnxbL
        AV6uhep3+E8hgHTmCYl9KMNkULkv4vGti7/qF9lD62v6KktovyOpPW3QwoK4SWW8HDVfefoxBXGWB
        MQwh0eUHnpEN8fNeNRN80eLYB1/EjMrE/VL414q54BRa24sjkbaiAqEkqOCmukvBYyA6Urw1CLH/P
        GwBe1V3A==;
Received: from [2001:4bb8:180:36f6:f125:c38b:d3d6:ae6c] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o0clY-001V5w-1n; Mon, 13 Jun 2022 05:37:32 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.com>,
        Dave Kleikamp <shaggy@kernel.org>,
        Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Cc:     linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, jfs-discussion@lists.sourceforge.net,
        ntfs3@lists.linux.dev
Subject: [PATCH 5/6] fs: don't call ->writepage from __mpage_writepage
Date:   Mon, 13 Jun 2022 07:37:14 +0200
Message-Id: <20220613053715.2394147-6-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220613053715.2394147-1-hch@lst.de>
References: <20220613053715.2394147-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

All callers of mpage_writepage use block_write_full_page as their
->writepage implementation when called from mpage_writepages
(although for ntfs3 this is obsfucated a bit).

Just call block_write_full_page directly instead of going through
the ->writepage indirection.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/mpage.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/mpage.c b/fs/mpage.c
index 31a97a0acf5f5..a354ef2b4b4eb 100644
--- a/fs/mpage.c
+++ b/fs/mpage.c
@@ -624,7 +624,7 @@ static int __mpage_writepage(struct page *page, struct writeback_control *wbc,
 	/*
 	 * The caller has a ref on the inode, so *mapping is stable
 	 */
-	ret = mapping->a_ops->writepage(page, wbc);
+	ret = block_write_full_page(page, mpd->get_block, wbc);
 	mapping_set_error(mapping, ret);
 out:
 	mpd->bio = bio;
-- 
2.30.2

