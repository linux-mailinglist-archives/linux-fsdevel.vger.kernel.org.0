Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F735314C6F
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Feb 2021 11:05:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231365AbhBIKE1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 9 Feb 2021 05:04:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231250AbhBIKCA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 9 Feb 2021 05:02:00 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37A1EC061786
        for <linux-fsdevel@vger.kernel.org>; Tue,  9 Feb 2021 02:01:20 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id y8so22681109ede.6
        for <linux-fsdevel@vger.kernel.org>; Tue, 09 Feb 2021 02:01:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Ahe/88oDGLp2JKa7aUpgG0hTDRSR52Nw5wU2PH5TQN8=;
        b=VRSPeA2UOfn1ZHevjh3mhpVVGTu5RXY4/uLvMzYCF2+9qehACcp0dWyUuKcU7fXxdq
         SH6N2E0sLvRjtBCdtdzGcQghNb3ORdMVo6iYuB4RyXpdxdipLLeQfP+QYyjGgC40CQU6
         a4xpujcX88eyRoVl7nOImVLiGOKxHe359s/ok=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Ahe/88oDGLp2JKa7aUpgG0hTDRSR52Nw5wU2PH5TQN8=;
        b=kEqhv/NdYYyKS7ZDHMWMNIUwTy7lT6C1FvNebegqI+a9twtPEsGc8/MXSRUnafqiA4
         hsiT48yIhoBeuR2faQ9o6P875ChhEsF2Lka/YHDSVxBRVo2E/PBsomlvLDnFWi1/ndyW
         CkZrTL6KXLQ0jlgWtnTtzPfcHArfE2jQZhMR4DApgVE6/opgQOmOeiAFfr8Glf+xkX1S
         F318IpPqWx/z7GNldITigRHY82UNEUM8Pl/D0M2RGedgEIaTNzTKEW0RU3gvAdu6gerS
         NSXBxC2hnyK4e6zu4EjBAh8g/Yd0qQLd0V6Ellt8far8ZWHe2wOudCCagfgYzXTnn3qr
         ZscQ==
X-Gm-Message-State: AOAM531Pc9FQ2W/cw453VeStQLyizFHkYYJ5iDQz73SjKzVhiM0kvfTE
        eH3FP1ZuS1g2coT83a5C38md+A==
X-Google-Smtp-Source: ABdhPJzdOIiuw6jzhZ8qEruOgYOnKANwOJwRc0ME7gBZpZ+BSxcudwxDoIDCLg0UCRZZzA6I+bPBTw==
X-Received: by 2002:a05:6402:281:: with SMTP id l1mr2161407edv.252.1612864878928;
        Tue, 09 Feb 2021 02:01:18 -0800 (PST)
Received: from miu.piliscsaba.redhat.com (catv-86-101-169-67.catv.broadband.hu. [86.101.169.67])
        by smtp.gmail.com with ESMTPSA id l5sm9588846edv.50.2021.02.09.02.01.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Feb 2021 02:01:18 -0800 (PST)
Date:   Tue, 9 Feb 2021 11:01:15 +0100
From:   Miklos Szeredi <miklos@szeredi.hu>
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Qian Cai <cai@lca.pw>, Hugh Dickins <hughd@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Linux-MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Amir Goldstein <amir73il@gmail.com>
Subject: Re: Possible deadlock in fuse write path (Was: Re: [PATCH 0/4] Some
 more lock_page work..)
Message-ID: <20210209100115.GB1208880@miu.piliscsaba.redhat.com>
References: <4794a3fa3742a5e84fb0f934944204b55730829b.camel@lca.pw>
 <CAHk-=wh9Eu-gNHzqgfvUAAiO=vJ+pWnzxkv+tX55xhGPFy+cOw@mail.gmail.com>
 <20201015151606.GA226448@redhat.com>
 <20201015195526.GC226448@redhat.com>
 <CAHk-=wj0vjx0jzaq5Gha-SmDKc3Hnog5LKX0eJZkudBvEQFAUA@mail.gmail.com>
 <CAJfpegtAstEo+nYgT81swYZWdziaZP_40QGAXcTORqYwgeWNUA@mail.gmail.com>
 <20201020204226.GA376497@redhat.com>
 <CAJfpegsi8UFiYyPrPbQob2x4X7NKSnciEz-a=5YZtFCgY0wL6w@mail.gmail.com>
 <20201021201249.GB442437@redhat.com>
 <CAJfpegsaLrbJ7bjJVBC3=vLzWZcF+GtTpGjVKYYOE3mjKyuVAw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJfpegsaLrbJ7bjJVBC3=vLzWZcF+GtTpGjVKYYOE3mjKyuVAw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Vivek,

Here's an updated patch with a header comment containing all the gory details.
It's basically your patch, but it's missing your S-o-b.  If you are fine with
it, can you please provide one?

The only change I made was to clear PG_uptodate on write error, otherwise I
think the patch is fine.

Splitting the request might cause a performance regression in some cases (lots
of unaligned writes that spill over a page boundary) but I don't have a better
idea at this moment.

Thanks,
Miklos
----

Date: Wed, 21 Oct 2020 16:12:49 -0400
From: Vivek Goyal <vgoyal@redhat.com>
Subject: fuse: fix write deadlock

There are two modes for write(2) and friends in fuse:

a) write through (update page cache, send sync WRITE request to userspace)

b) buffered write (update page cache, async writeout later)

The write through method kept all the page cache pages locked that were
used for the request.  Keeping more than one page locked is deadlock prone
and Qian Cai demonstrated this with trinity fuzzing.

The reason for keeping the pages locked is that concurrent mapped reads
shouldn't try to pull possibly stale data into the page cache.

For full page writes, the easy way to fix this is to make the cached page
be the authoritative source by marking the page PG_uptodate immediately.
After this the page can be safely unlocked, since mapped/cached reads will
take the written data from the cache.

Concurrent mapped writes will now cause data in the original WRITE request
to be updated; this however doesn't cause any data inconsistency and this
scenario should be exceedingly rare anyway.

If the WRITE request returns with an error in the above case, currently the
page is not marked uptodate; this means that a concurrent read will always
read consistent data.  After this patch the page is uptodate between
writing to the cache and receiving the error: there's window where a cached
read will read the wrong data.  While theoretically this could be a
regression, it is unlikely to be one in practice, since this is normal for
buffered writes.

In case of a partial page write to an already uptodate page the locking is
also unnecessary, with the above caveats.

Partial write of a not uptodate page still needs to be handled.  One way
would be to read the complete page before doing the write.  This is not
possible, since it might break filesystems that don't expect any READ
requests when the file was opened O_WRONLY.

The other solution is to serialize the synchronous write with reads from
the partial pages.  The easiest way to do this is to keep the partial pages
locked.  The problem is that a write() may involve two such pages (one head
and one tail).  This patch fixes it by only locking the partial tail page.
If there's a partial head page as well, then split that off as a separate
WRITE request.

Reported-by: Qian Cai <cai@lca.pw>
Fixes: ea9b9907b82a ("fuse: implement perform_write")
Cc: <stable@vger.kernel.org> # v2.6.26
Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 fs/fuse/file.c   |   25 +++++++++++++++----------
 fs/fuse/fuse_i.h |    1 +
 2 files changed, 16 insertions(+), 10 deletions(-)

--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -1117,17 +1117,12 @@ static ssize_t fuse_send_write_pages(str
 	count = ia->write.out.size;
 	for (i = 0; i < ap->num_pages; i++) {
 		struct page *page = ap->pages[i];
+		bool page_locked = ap->page_locked && (i == ap->num_pages - 1);
 
-		if (!err && !offset && count >= PAGE_SIZE)
-			SetPageUptodate(page);
-
-		if (count > PAGE_SIZE - offset)
-			count -= PAGE_SIZE - offset;
-		else
-			count = 0;
-		offset = 0;
-
-		unlock_page(page);
+		if (err)
+			ClearPageUptodate(page);
+		if (page_locked)
+			unlock_page(page);
 		put_page(page);
 	}
 
@@ -1191,6 +1186,16 @@ static ssize_t fuse_fill_write_pages(str
 		if (offset == PAGE_SIZE)
 			offset = 0;
 
+		/* If we copied full page, mark it uptodate */
+		if (tmp == PAGE_SIZE)
+			SetPageUptodate(page);
+
+		if (PageUptodate(page)) {
+			unlock_page(page);
+		} else {
+			ap->page_locked = true;
+			break;
+		}
 		if (!fc->big_writes)
 			break;
 	} while (iov_iter_count(ii) && count < fc->max_write &&
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -277,6 +277,7 @@ struct fuse_args_pages {
 	struct page **pages;
 	struct fuse_page_desc *descs;
 	unsigned int num_pages;
+	bool page_locked;
 };
 
 #define FUSE_ARGS(args) struct fuse_args args = {}
