Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52EA8482D71
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Jan 2022 02:34:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231324AbiACBeJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 2 Jan 2022 20:34:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230110AbiACBeJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 2 Jan 2022 20:34:09 -0500
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D11BC061761
        for <linux-fsdevel@vger.kernel.org>; Sun,  2 Jan 2022 17:34:08 -0800 (PST)
Received: by mail-qk1-x72b.google.com with SMTP id de30so30049100qkb.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 02 Jan 2022 17:34:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version;
        bh=PiokhK5vm6t1FngCPHje/kH9JSRiznv1PXUqe2mn9nU=;
        b=ZZg5oPjU+IOX3lG0g19Q1tZ/0PUV0sB/r7uA/E3QanqmedTQ/Dt8JJWvGQz1aTlEkT
         yItEdtxxcBrehZmXoxAwfjc0ILD6eG9wzOZnIfGCDZ1iRiaZST9lItcVVxz0ufN+AXWU
         lCtNUV0WwRwO1qwI9ZEV3gdsvwUJCJKCcc9gwvDFQiL6be9tLtZTv5G4YmaFKKtFAjGM
         uPsZAsbfd4WgLYmKMqJ5j77P2aoeiJI5cIHUbY++IbUP/uM3HEmNP0CW5tmoJn/yUhdl
         hDHr+iXH6uhPxHFUrwnFsiZkyJBzX2EkmKQQmg29wjACI/MIXEcFyDQsoa0ThiNOJ/LX
         FEeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version;
        bh=PiokhK5vm6t1FngCPHje/kH9JSRiznv1PXUqe2mn9nU=;
        b=6ycs7ZNfvrH+6+dDVA/jmmAql6m/eFcjdr6YCUWHMUaRjREGoiKx3hg0etefXilZCp
         BhOHZn35FLpygpzovP7t6H/nhsP1tlN29ZDlRYwS2TJxOWtdlJiNuNArrdm+4ZvP4jqm
         AuL+FOCnkFmcihdw8kNyKOe1Vi213YZkyNVrmV5+uoXhFvb2c+J1GvKleRdlpY2FF+c3
         j9Ln8LrodEbdK5H+61+Se/wFQ8FBAbn2eWnWPJ4Mrh4+Elg0GmQ1KO77Tu8Qk4ZuV8oS
         KTPJjocyTUujRs6V9V5CV9H+fE4vykaWhZU6Q0gNrzJP7poENP/ad2AOSCeTOWMYeXfM
         mueg==
X-Gm-Message-State: AOAM532ghpsyucN+5l5OGjzdLb4VJWPlwV6MTE4hcA9yx/5eJRQP2f3c
        lKl1in+j/7BWIN5G31KfrbxDzA==
X-Google-Smtp-Source: ABdhPJzDwiUdvEF84FGbRjFyOE63LRPTQzrSoXa5QXj+lO/f/TPMozsBrj0zcm4Brg0pzeMMK4vK4Q==
X-Received: by 2002:a05:620a:2013:: with SMTP id c19mr30288941qka.700.1641173647399;
        Sun, 02 Jan 2022 17:34:07 -0800 (PST)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id bm25sm27152395qkb.4.2022.01.02.17.34.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Jan 2022 17:34:07 -0800 (PST)
Date:   Sun, 2 Jan 2022 17:34:05 -0800 (PST)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.anvils
To:     Matthew Wilcox <willy@infradead.org>
cc:     Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@infradead.org>, Jan Kara <jack@suse.cz>,
        William Kucharski <william.kucharski@oracle.com>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH next 2/3] shmem: Fix data loss when folio truncated
Message-ID: <24d53dac-d58d-6bb9-82af-c472922e4a31@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

xfstests generic 098 214 263 286 412 used to pass on huge tmpfs (well,
three of those _require_odirect, enabled by a shmem_direct_IO() stub),
but still fail even with the partial_end fix.

generic/098 output mismatch shows actual data loss:
    --- tests/generic/098.out
    +++ /home/hughd/xfstests/results//generic/098.out.bad
    @@ -4,9 +4,7 @@
     wrote 32768/32768 bytes at offset 262144
     XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
     File content after remount:
    -0000000 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
    -*
    -0400000 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
    +0000000 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
    ...

The problem here is that shmem_getpage(,,,SGP_READ) intentionally
supplies NULL page beyond EOF, and truncation and eviction intentionally
lower i_size before shmem_undo_range() is called: so a whole folio got
truncated instead of being treated partially.

That could be solved by adding yet another SGP_mode to select the
required behaviour, but it's cleaner just to handle cache and then swap
in shmem_get_folio() - renamed here to shmem_get_partial_folio(), given
an easier interface, and moved next to its sole user, shmem_undo_range().

We certainly do not want to read data back from swap when evicting an
inode: i_size preset to 0 still ensures that.  Nor do we want to zero
folio data when evicting: truncate_inode_partial_folio()'s check for
length == folio_size(folio) already ensures that.

Fixes: 8842c9c23524 ("truncate,shmem: Handle truncates that split large folios")
Signed-off-by: Hugh Dickins <hughd@google.com>
---

 mm/shmem.c |   39 ++++++++++++++++++++++++---------------
 1 file changed, 24 insertions(+), 15 deletions(-)

--- hughd1/mm/shmem.c
+++ hughd2/mm/shmem.c
@@ -151,19 +151,6 @@ int shmem_getpage(struct inode *inode, p
 		mapping_gfp_mask(inode->i_mapping), NULL, NULL, NULL);
 }
 
-static int shmem_get_folio(struct inode *inode, pgoff_t index,
-		struct folio **foliop, enum sgp_type sgp)
-{
-	struct page *page = NULL;
-	int ret = shmem_getpage(inode, index, &page, sgp);
-
-	if (page)
-		*foliop = page_folio(page);
-	else
-		*foliop = NULL;
-	return ret;
-}
-
 static inline struct shmem_sb_info *SHMEM_SB(struct super_block *sb)
 {
 	return sb->s_fs_info;
@@ -894,6 +881,28 @@ void shmem_unlock_mapping(struct address
 	}
 }
 
+static struct folio *shmem_get_partial_folio(struct inode *inode, pgoff_t index)
+{
+	struct folio *folio;
+	struct page *page;
+
+	/*
+	 * At first avoid shmem_getpage(,,,SGP_READ): that fails
+	 * beyond i_size, and reports fallocated pages as holes.
+	 */
+	folio = __filemap_get_folio(inode->i_mapping, index,
+					FGP_ENTRY | FGP_LOCK, 0);
+	if (!folio || !xa_is_value(folio))
+		return folio;
+	/*
+	 * But read a page back from swap if any of it is within i_size
+	 * (although in some cases this is just a waste of time).
+	 */
+	page = NULL;
+	shmem_getpage(inode, index, &page, SGP_READ);
+	return page ? page_folio(page) : NULL;
+}
+
 /*
  * Remove range of pages and swap entries from page cache, and free them.
  * If !unfalloc, truncate or punch hole; if unfalloc, undo failed fallocate.
@@ -948,7 +957,7 @@ static void shmem_undo_range(struct inod
 	}
 
 	same_folio = (lstart >> PAGE_SHIFT) == (lend >> PAGE_SHIFT);
-	shmem_get_folio(inode, lstart >> PAGE_SHIFT, &folio, SGP_READ);
+	folio = shmem_get_partial_folio(inode, lstart >> PAGE_SHIFT);
 	if (folio) {
 		same_folio = lend < folio_pos(folio) + folio_size(folio);
 		folio_mark_dirty(folio);
@@ -963,7 +972,7 @@ static void shmem_undo_range(struct inod
 	}
 
 	if (!same_folio)
-		shmem_get_folio(inode, lend >> PAGE_SHIFT, &folio, SGP_READ);
+		folio = shmem_get_partial_folio(inode, lend >> PAGE_SHIFT);
 	if (folio) {
 		folio_mark_dirty(folio);
 		if (!truncate_inode_partial_folio(folio, lstart, lend))
