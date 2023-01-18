Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95CDF67193F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Jan 2023 11:41:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230140AbjARKlH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 Jan 2023 05:41:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230125AbjARKj4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 Jan 2023 05:39:56 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D317183877;
        Wed, 18 Jan 2023 01:44:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=pFy30vhWl9l9ZgLMa817B3/6WEg0wrb2z/Np7E/EF8c=; b=UfEL4nxoIkflPHGo7FW/goZ6Ae
        xIpR/d0qI5IJrraY/1iGKXWGHdji2iuHKy5HnLQI8g45xl0egjQwt440BkyDBzLOtbS3WTE77JRoB
        YVbEr2AoQ50WmGx37VByiYGoCLP0d5MCV4wzb6443KaglnqflCP6aueRjRXiu9loX+HJZJVZbLoYZ
        7L8+14Vq+wI6LGjevGMbFYs4iFg/sLVFkhIO9VUWEW0VoKzm/xPjwyPDaa3qLJ2urhMKmMYcXaer+
        mXjsx+091criZqeGU7fbDpZee25pjlDMItJhPegKjbf5a4mRmpe2UFeAd60n54qiLHBmIq6wh9a1Q
        m2aDbOQw==;
Received: from 213-147-167-250.nat.highway.webapn.at ([213.147.167.250] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pI4z7-000A13-OH; Wed, 18 Jan 2023 09:43:59 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Hugh Dickins <hughd@google.com>
Cc:     linux-afs@lists.infradead.org, linux-btrfs@vger.kernel.org,
        linux-ext4@vger.kernel.org, cluster-devel@redhat.com,
        linux-mm@kvack.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-nilfs@vger.kernel.org
Subject: [PATCH 5/9] shmem: open code the page cache lookup in shmem_get_folio_gfp
Date:   Wed, 18 Jan 2023 10:43:25 +0100
Message-Id: <20230118094329.9553-6-hch@lst.de>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230118094329.9553-1-hch@lst.de>
References: <20230118094329.9553-1-hch@lst.de>
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

Use the very low level filemap_get_entry helper to look up the
entry in the xarray, and then:

 - don't bother locking the folio if only doing a userfault notification
 - open code locking the page and checking for truncation in a related
   code block

This will allow to eventually remove the FGP_ENTRY flag.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 mm/shmem.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index e9500fea43a8dc..769107f376562f 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -1856,12 +1856,10 @@ static int shmem_get_folio_gfp(struct inode *inode, pgoff_t index,
 	sbinfo = SHMEM_SB(inode->i_sb);
 	charge_mm = vma ? vma->vm_mm : NULL;
 
-	folio = __filemap_get_folio(mapping, index, FGP_ENTRY | FGP_LOCK, 0);
+	folio = filemap_get_entry(mapping, index);
 	if (folio && vma && userfaultfd_minor(vma)) {
-		if (!xa_is_value(folio)) {
-			folio_unlock(folio);
+		if (!xa_is_value(folio))
 			folio_put(folio);
-		}
 		*fault_type = handle_userfault(vmf, VM_UFFD_MINOR);
 		return 0;
 	}
@@ -1877,6 +1875,14 @@ static int shmem_get_folio_gfp(struct inode *inode, pgoff_t index,
 	}
 
 	if (folio) {
+		folio_lock(folio);
+
+		/* Has the page been truncated? */
+		if (unlikely(folio->mapping != mapping)) {
+			folio_unlock(folio);
+			folio_put(folio);
+			goto repeat;
+		}
 		if (sgp == SGP_WRITE)
 			folio_mark_accessed(folio);
 		if (folio_test_uptodate(folio))
-- 
2.39.0

