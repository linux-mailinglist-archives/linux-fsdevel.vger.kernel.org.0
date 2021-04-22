Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 802B4367669
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Apr 2021 02:41:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244014AbhDVAkl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Apr 2021 20:40:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344046AbhDVAjw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Apr 2021 20:39:52 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02AF4C06138B
        for <linux-fsdevel@vger.kernel.org>; Wed, 21 Apr 2021 17:39:18 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id c6so32665735qtc.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 21 Apr 2021 17:39:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=7i3jgTFMgSvDDCvaM/z3dZrqsQ7aoX20W1+zrU4bC9A=;
        b=cYmtc9W0OisFwodZq+YMaQ5sdbzZ/dQA3o03OF3rzbtnjrJU7alFKYG+oCHrfcyqzu
         kqD//2oRwaiOSkrEikSGLP4Z/xoOFm2vGexS/FdGw0ODgbaP/v9HEXOeXxeT4STG/DZu
         xj1uXLAAlfjhE1NkzxuDcYRLZ8aWdH7hwtvsBJsF/0IP47cTo8mwajMlw5g51ymOIeT/
         J+di8TSFsA/30iBnurEbpjMPKJ1fvziHdujGmsGazeWJd2YZVgU8Q8ISgc7Wczn8rMXE
         qcuEYVkffuhPSfe5sghURh8aRX6EolLzfur43tAgomfo8XqpXmudWHThAwG42MDpIgaz
         bWlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=7i3jgTFMgSvDDCvaM/z3dZrqsQ7aoX20W1+zrU4bC9A=;
        b=Q2TuGgvo8Y4WpnIzeqwliUBidUN68qBmSOvgJj/P8+N1kmf2Nx76tNRJlzXkBkI8mt
         Y0caTB8ji236vrcNe3jzflyyfTytO9pqvXIzhylfzF5YNvMfBUTwDXLjFCLJoFBDrZQE
         SNMsS/1S7b5bxRVRQp9Tu1361WRVm8DyZ0DixpfklrBEfeyhjDTzAp/iT6P31VbrqxM3
         hHAY0Iriz9i7tAzv3VbDM69y3orA2buRj2sP9kBvFKRP3ybWvW6q+n2LPDmHOmb6Rl65
         mT/g7Knshhn8KEoaDrYaGu96AgckIb4hDFfZYlcQtIV+B1iMI95PQWFG/c9TJk7OSqXN
         58Cw==
X-Gm-Message-State: AOAM532SQCsN69d3CtClsHt22ARZ3tLjAwtxfHOAb7brM0IPVEDVzZVj
        AHE2ij6fRW7VmTaW2BPDShm6yA==
X-Google-Smtp-Source: ABdhPJxyK80llc+AABNVsntc/Os39N9486kEwBMS9LuEx4w7eCu0ZjsQZO2CgxQ+NLgYQ2hVhC1Deg==
X-Received: by 2002:a05:622a:1449:: with SMTP id v9mr531639qtx.324.1619051957003;
        Wed, 21 Apr 2021 17:39:17 -0700 (PDT)
Received: from eggly.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id a30sm1269538qtn.4.2021.04.21.17.39.15
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Wed, 21 Apr 2021 17:39:16 -0700 (PDT)
Date:   Wed, 21 Apr 2021 17:39:14 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     Andrew Morton <akpm@linux-foundation.org>
cc:     Hugh Dickins <hughd@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        William Kucharski <william.kucharski@oracle.com>,
        Christoph Hellwig <hch@lst.de>, Jan Kara <jack@suse.cz>,
        Dave Chinner <dchinner@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: [PATCH 2/2] mm/filemap: fix mapping_seek_hole_data on THP & 32-bit
In-Reply-To: <alpine.LSU.2.11.2104211723580.3299@eggly.anvils>
Message-ID: <alpine.LSU.2.11.2104211737410.3299@eggly.anvils>
References: <alpine.LSU.2.11.2104211723580.3299@eggly.anvils>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

No problem on 64-bit without huge pages, but xfstests generic/285
and other SEEK_HOLE/SEEK_DATA tests have regressed on huge tmpfs,
and on 32-bit architectures, with the new mapping_seek_hole_data().
Several different bugs turned out to need fixing.

u64 casts added to stop unfortunate sign-extension when shifting
(and let's use shifts throughout, rather than mixed with * and /).

Use round_up() when advancing pos, to stop assuming that pos was
already THP-aligned when advancing it by THP-size.  (But I believe
this use of round_up() assumes that any THP must be THP-aligned:
true while tmpfs enforces that alignment, and is the only fs with
FS_THP_SUPPORT; but might need to be generalized in the future?
If I try to generalize it right now, I'm sure to get it wrong!)

Use xas_set() when iterating away from a THP, so that xa_index stays
in synch with start, instead of drifting away to return bogus offset.

Check start against end to avoid wrapping 32-bit xa_index to 0 (and
to handle these additional cases, seek_data or not, it's easier to
break the loop than goto: so rearrange exit from the function).

Fixes: 41139aa4c3a3 ("mm/filemap: add mapping_seek_hole_data")
Signed-off-by: Hugh Dickins <hughd@google.com>
---

 mm/filemap.c |   23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

--- 5.12-rc8/mm/filemap.c	2021-02-26 19:42:39.812156085 -0800
+++ linux/mm/filemap.c	2021-04-20 23:20:20.509464440 -0700
@@ -2671,8 +2671,8 @@ unsigned int seek_page_size(struct xa_st
 loff_t mapping_seek_hole_data(struct address_space *mapping, loff_t start,
 		loff_t end, int whence)
 {
-	XA_STATE(xas, &mapping->i_pages, start >> PAGE_SHIFT);
-	pgoff_t max = (end - 1) / PAGE_SIZE;
+	XA_STATE(xas, &mapping->i_pages, (u64)start >> PAGE_SHIFT);
+	pgoff_t max = (u64)(end - 1) >> PAGE_SHIFT;
 	bool seek_data = (whence == SEEK_DATA);
 	struct page *page;
 
@@ -2681,7 +2681,8 @@ loff_t mapping_seek_hole_data(struct add
 
 	rcu_read_lock();
 	while ((page = find_get_entry(&xas, max, XA_PRESENT))) {
-		loff_t pos = xas.xa_index * PAGE_SIZE;
+		loff_t pos = (u64)xas.xa_index << PAGE_SHIFT;
+		unsigned int seek_size;
 
 		if (start < pos) {
 			if (!seek_data)
@@ -2689,25 +2690,25 @@ loff_t mapping_seek_hole_data(struct add
 			start = pos;
 		}
 
-		pos += seek_page_size(&xas, page);
+		seek_size = seek_page_size(&xas, page);
+		pos = round_up((u64)pos + 1, seek_size);
 		start = page_seek_hole_data(&xas, mapping, page, start, pos,
 				seek_data);
 		if (start < pos)
 			goto unlock;
+		if (start >= end)
+			break;
+		if (seek_size > PAGE_SIZE)
+			xas_set(&xas, (u64)pos >> PAGE_SHIFT);
 		if (!xa_is_value(page))
 			put_page(page);
 	}
-	rcu_read_unlock();
-
 	if (seek_data)
-		return -ENXIO;
-	goto out;
-
+		start = -ENXIO;
 unlock:
 	rcu_read_unlock();
-	if (!xa_is_value(page))
+	if (page && !xa_is_value(page))
 		put_page(page);
-out:
 	if (start > end)
 		return end;
 	return start;
