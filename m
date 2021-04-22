Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17545368839
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Apr 2021 22:49:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239509AbhDVUtg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 22 Apr 2021 16:49:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239497AbhDVUtf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 22 Apr 2021 16:49:35 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28373C06174A
        for <linux-fsdevel@vger.kernel.org>; Thu, 22 Apr 2021 13:49:00 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id lt13so13125151pjb.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 22 Apr 2021 13:49:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=bR2kbdfapTwBu00MYDhOgJUb5mkcImnnOhrX139DRgA=;
        b=Kjz3sRR9igPIoYPoWrLfO3ghVY5woWH5jeiWDkZTtktCSeGesdMHB4wwilHwZAiL+g
         NEOGC1nVRCyNGOEUCMTkkp/KgY6WCTcd8eZa5BhXi28lFE21x2LMBXnbo4TJPTj+QGwD
         BA2ZaaEeRYglXew+Xo3PKxxSguRsJdnz5vZToN0MOjjW6+sFIop2oNER9IJKDVLoEJQd
         UrRIEY2D/2/Dpg4tS0nWYFlwJ9466BErCGCOxH6zlUS5V1HT9lNRvbpjIHBdIuNd0gMp
         uCkgny/HndIt02p9Oz6hXevhVroWCID6XJAbcObLYzd38ber7ogc6L+DkhhJ27I1+OI1
         4cTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=bR2kbdfapTwBu00MYDhOgJUb5mkcImnnOhrX139DRgA=;
        b=hQPDaeKdJlJfyQopwU+8l78KDYF5g5wWS+yiSxM5iJxLLyt3sbLW3N8QRdtsCouYyh
         sAkfMHGLK+3ULGxJzYL4F7ZPUHLdgYiivEC4kyYREDU3P4yhWfx5bJaPL/RZBuEGZF/f
         z7xyLBndn//6mSTrx6LdQp+/3HLCNWI5m3OUibdq9k+P3C4kXEX83O/JocjXdWOtkQiV
         b9wa/M+6rsztm3bTOGYgrV/V0cdiGsJsLzPP4bWmcpcWxuHwxRVuULIsS4LhwV9gCzlC
         wt94gVNT7hp/LhKvM6XZGYMTjY7RNvGwIPXQpxbuzCm8vBD6samm78WgBuIUvSVw3xRp
         o+1g==
X-Gm-Message-State: AOAM532zrbI04T+wIC3GD5lmWYBYT7+oIqexnsWsvWODyrOAS+TD6/G4
        3lhF3aY6A04PwOHfwIrarX71wQ==
X-Google-Smtp-Source: ABdhPJwi7i9LEeLrIgM50j5BAu+Matuql9UhJCD0KpBS6GPffrqTP8NgOGWa1YRFMCOqTGUlOH1nwQ==
X-Received: by 2002:a17:90b:1646:: with SMTP id il6mr1971668pjb.27.1619124539456;
        Thu, 22 Apr 2021 13:48:59 -0700 (PDT)
Received: from eggly.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id h18sm2482627pfv.158.2021.04.22.13.48.58
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Thu, 22 Apr 2021 13:48:59 -0700 (PDT)
Date:   Thu, 22 Apr 2021 13:48:57 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     Andrew Morton <akpm@linux-foundation.org>
cc:     Matthew Wilcox <willy@infradead.org>,
        Hugh Dickins <hughd@google.com>,
        William Kucharski <william.kucharski@oracle.com>,
        Christoph Hellwig <hch@lst.de>, Jan Kara <jack@suse.cz>,
        Dave Chinner <dchinner@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: [PATCH v2 2/2] mm/filemap: fix mapping_seek_hole_data on THP &
 32-bit
In-Reply-To: <alpine.LSU.2.11.2104221338410.1170@eggly.anvils>
Message-ID: <alpine.LSU.2.11.2104221347240.1170@eggly.anvils>
References: <alpine.LSU.2.11.2104211723580.3299@eggly.anvils> <alpine.LSU.2.11.2104211737410.3299@eggly.anvils> <20210422011631.GL3596236@casper.infradead.org> <alpine.LSU.2.11.2104212253000.4412@eggly.anvils>
 <alpine.LSU.2.11.2104221338410.1170@eggly.anvils>
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

u64 cast to stop losing bits when converting unsigned long to loff_t
(and let's use shifts throughout, rather than mixed with * and /).

Use round_up() when advancing pos, to stop assuming that pos was
already THP-aligned when advancing it by THP-size.  (This use of
round_up() assumes that any THP has THP-aligned index: true at present
and true going forward, but could be recoded to avoid the assumption.)

Use xas_set() when iterating away from a THP, so that xa_index stays
in synch with start, instead of drifting away to return bogus offset.

Check start against end to avoid wrapping 32-bit xa_index to 0 (and
to handle these additional cases, seek_data or not, it's easier to
break the loop than goto: so rearrange exit from the function).

Fixes: 41139aa4c3a3 ("mm/filemap: add mapping_seek_hole_data")
Signed-off-by: Hugh Dickins <hughd@google.com>
---
v2: Removed all but one of v1's u64 casts, as suggested my Matthew.
    Updated commit message on u64 cast and THP alignment, per Matthew.

Andrew, I'd have just sent a -fix.patch to remove the unnecessary u64s,
but need to reword the commit message: so please replace yesterday's
mm-filemap-fix-mapping_seek_hole_data-on-thp-32-bit.patch
by this one - thanks.

 mm/filemap.c |   21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

--- 5.12-rc8/mm/filemap.c	2021-02-26 19:42:39.812156085 -0800
+++ linux/mm/filemap.c	2021-04-21 22:58:03.699655576 -0700
@@ -2672,7 +2672,7 @@ loff_t mapping_seek_hole_data(struct add
 		loff_t end, int whence)
 {
 	XA_STATE(xas, &mapping->i_pages, start >> PAGE_SHIFT);
-	pgoff_t max = (end - 1) / PAGE_SIZE;
+	pgoff_t max = (end - 1) >> PAGE_SHIFT;
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
+		pos = round_up(pos + 1, seek_size);
 		start = page_seek_hole_data(&xas, mapping, page, start, pos,
 				seek_data);
 		if (start < pos)
 			goto unlock;
+		if (start >= end)
+			break;
+		if (seek_size > PAGE_SIZE)
+			xas_set(&xas, pos >> PAGE_SHIFT);
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
