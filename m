Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C588F482D70
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Jan 2022 02:32:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231322AbiACBcd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 2 Jan 2022 20:32:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230110AbiACBcc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 2 Jan 2022 20:32:32 -0500
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26859C061761
        for <linux-fsdevel@vger.kernel.org>; Sun,  2 Jan 2022 17:32:32 -0800 (PST)
Received: by mail-qt1-x82d.google.com with SMTP id z9so29075760qtj.9
        for <linux-fsdevel@vger.kernel.org>; Sun, 02 Jan 2022 17:32:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version;
        bh=asS1ao6kszozXWmZX1tUAjlHFyfy+Rk58KfLP/5PHqQ=;
        b=BjrOMM6CVIpHGjlWjLaI6P6vezPcNIYDCzfF0JSjI8sWNEVxT30ZRlunzGmKlsCQGc
         SWIM1EFvk93zzvKcotWFDpUtu4rMaA3DyJBYdITShfFfruweXf87Ub1qARP/IueTv1O6
         QZXsZj8LcY36F9X+xhmtAw562WvtWQXBbWpO6kdB/HULQG+8H/jBuTEKlk38QDJxXJ//
         9Wrm5Iy9DfWqoQyhfTY2hV3qI14A1Z/cY+Iz77X8uYgqOQohklsXnYVD1c9mkkHD83Bj
         h4zmEugf8NPqwBqimBAYFiSx03I/oP+5/2yviRBSUgtHyVA3ttEIPU4eLj1QDWBSmKkt
         SJTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version;
        bh=asS1ao6kszozXWmZX1tUAjlHFyfy+Rk58KfLP/5PHqQ=;
        b=bCLY0CO9IpHzx5rmRPo0XP6cI7yvOpa81qo1fkblmv/8wmbnQqiPPnK+IX/q6Sy+Jt
         Qs8nCLZFENgCnprqWI20F+ERVTMN37bR2XwQlGKdK7WlvEmWfteAvlCAuJ6agIPYyu1o
         xdvETBH7AC2pDzMfNcXi60XsZTp96FVyUjDIaCHipQQMYg2EYEIGR4Dt1+0zquvZGwIM
         MXJUPa9bw7MFdqG4BVgZm1kXudb0Aq7JQpKx+H1ZXhqgwpIB32H7ghcpsVmYjPjYNwXm
         yVffeeQIJA9+nriJ6IzpXTQLQxo7Aaq3FqOFXDAnxNxqeOTh4XZEOESMdYpbV+N6waLR
         PgHw==
X-Gm-Message-State: AOAM5329p3CVxiafqm9MbXGVg6yndssVeOwEr14HPEyoZVn1jj9Fjl/i
        tW/rsqDhmsi0HkSYq4F9U7VtJQ==
X-Google-Smtp-Source: ABdhPJxt7LbKzifdA3sqsQv1QbTSNHpJ8zAgofcXu7hxSP6zvtWwIFvpJKOtQjlpFJ5eoNjc0xEV2w==
X-Received: by 2002:ac8:4e4d:: with SMTP id e13mr37845415qtw.293.1641173551110;
        Sun, 02 Jan 2022 17:32:31 -0800 (PST)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id f12sm27365602qtj.93.2022.01.02.17.32.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Jan 2022 17:32:30 -0800 (PST)
Date:   Sun, 2 Jan 2022 17:32:28 -0800 (PST)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.anvils
To:     Matthew Wilcox <willy@infradead.org>
cc:     Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@infradead.org>, Jan Kara <jack@suse.cz>,
        William Kucharski <william.kucharski@oracle.com>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH next 1/3] truncate,shmem: Fix data loss when hole punched in
 folio
Message-ID: <43bf0e3-6ad8-9f67-7296-786c7b3b852f@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

As reported before in
https://lore.kernel.org/lkml/alpine.LSU.2.11.2011160128001.1206@eggly.anvils/
shmem_undo_range() mods sometimes caused good data to be zeroed when
running my tmpfs swapping loads.  Only the ext4-on-loop0-on-tmpfs mount
was seen to suffer, and that is mounted with "-o discard": which punches
holes in the underlying tmpfs file.

shmem_undo_range() partial_end handling was wrong: if (lend + 1) aligned
to page but not to folio, the second shmem_get_folio() could be skipped,
then the whole of that folio punched out instead of treated partially.

Rename same_page to same_folio (like in truncate.c), and rely on that
instead of partial_end: fewer variables, less confusion.  And considering
an off-by-one in setting same_folio initially, pointed to an off-by-one
in the second shmem_get_folio(): it should be on (lend >> PAGE_SHIFT) not
end - which had caused no data loss, but could split folio unnecessarily.

And apply these same fixes in truncate_inode_pages_range().

Fixes: 8842c9c23524 ("truncate,shmem: Handle truncates that split large folios")
Signed-off-by: Hugh Dickins <hughd@google.com>
---

 mm/shmem.c    |   16 ++++++----------
 mm/truncate.c |   15 +++++++--------
 2 files changed, 13 insertions(+), 18 deletions(-)

--- next-20211224/mm/shmem.c
+++ hughd1/mm/shmem.c
@@ -908,10 +908,10 @@ static void shmem_undo_range(struct inod
 	struct folio_batch fbatch;
 	pgoff_t indices[PAGEVEC_SIZE];
 	struct folio *folio;
+	bool same_folio;
 	long nr_swaps_freed = 0;
 	pgoff_t index;
 	int i;
-	bool partial_end;
 
 	if (lend == -1)
 		end = -1;	/* unsigned, so actually very big */
@@ -947,18 +947,14 @@ static void shmem_undo_range(struct inod
 		index++;
 	}
 
-	partial_end = ((lend + 1) % PAGE_SIZE) > 0;
+	same_folio = (lstart >> PAGE_SHIFT) == (lend >> PAGE_SHIFT);
 	shmem_get_folio(inode, lstart >> PAGE_SHIFT, &folio, SGP_READ);
 	if (folio) {
-		bool same_page;
-
-		same_page = lend < folio_pos(folio) + folio_size(folio);
-		if (same_page)
-			partial_end = false;
+		same_folio = lend < folio_pos(folio) + folio_size(folio);
 		folio_mark_dirty(folio);
 		if (!truncate_inode_partial_folio(folio, lstart, lend)) {
 			start = folio->index + folio_nr_pages(folio);
-			if (same_page)
+			if (same_folio)
 				end = folio->index;
 		}
 		folio_unlock(folio);
@@ -966,8 +962,8 @@ static void shmem_undo_range(struct inod
 		folio = NULL;
 	}
 
-	if (partial_end)
-		shmem_get_folio(inode, end, &folio, SGP_READ);
+	if (!same_folio)
+		shmem_get_folio(inode, lend >> PAGE_SHIFT, &folio, SGP_READ);
 	if (folio) {
 		folio_mark_dirty(folio);
 		if (!truncate_inode_partial_folio(folio, lstart, lend))
--- next-20211224/mm/truncate.c
+++ hughd1/mm/truncate.c
@@ -347,8 +347,8 @@ void truncate_inode_pages_range(struct a
 	pgoff_t		indices[PAGEVEC_SIZE];
 	pgoff_t		index;
 	int		i;
-	struct folio *	folio;
-	bool partial_end;
+	struct folio	*folio;
+	bool		same_folio;
 
 	if (mapping_empty(mapping))
 		goto out;
@@ -385,12 +385,10 @@ void truncate_inode_pages_range(struct a
 		cond_resched();
 	}
 
-	partial_end = ((lend + 1) % PAGE_SIZE) > 0;
+	same_folio = (lstart >> PAGE_SHIFT) == (lend >> PAGE_SHIFT);
 	folio = __filemap_get_folio(mapping, lstart >> PAGE_SHIFT, FGP_LOCK, 0);
 	if (folio) {
-		bool same_folio = lend < folio_pos(folio) + folio_size(folio);
-		if (same_folio)
-			partial_end = false;
+		same_folio = lend < folio_pos(folio) + folio_size(folio);
 		if (!truncate_inode_partial_folio(folio, lstart, lend)) {
 			start = folio->index + folio_nr_pages(folio);
 			if (same_folio)
@@ -401,8 +399,9 @@ void truncate_inode_pages_range(struct a
 		folio = NULL;
 	}
 
-	if (partial_end)
-		folio = __filemap_get_folio(mapping, end, FGP_LOCK, 0);
+	if (!same_folio)
+		folio = __filemap_get_folio(mapping, lend >> PAGE_SHIFT,
+						FGP_LOCK, 0);
 	if (folio) {
 		if (!truncate_inode_partial_folio(folio, lstart, lend))
 			end = folio->index;
