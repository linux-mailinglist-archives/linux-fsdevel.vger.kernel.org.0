Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C7EF295364
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Oct 2020 22:12:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392480AbgJUUM5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Oct 2020 16:12:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:44202 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2410408AbgJUUM5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Oct 2020 16:12:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603311175;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=964n0K2ZaeC604fAipWNw7BvFsuaGZbCGx0+HtMBvXE=;
        b=AWUXuKzkY3MnEsvjt5FuSaiCZ5EPeGQRt+xCe6MpY7QyV70zEfv+4DUdW8zj73Po4SZAw5
        rLw9M7BKfzRJQ6MU1hbKSG8mMYUEVxxGiSDjeda4t8mJjT98iTV40OoJEfuNMHIQniSzxH
        PA/PIjyoQw3+vfsypkRD5zVnkWSsx/I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-412-PkiA8aZ0NFCaZHl09_Ht5A-1; Wed, 21 Oct 2020 16:12:52 -0400
X-MC-Unique: PkiA8aZ0NFCaZHl09_Ht5A-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DEE1810A0B81;
        Wed, 21 Oct 2020 20:12:50 +0000 (UTC)
Received: from horse.redhat.com (ovpn-116-107.rdu2.redhat.com [10.10.116.107])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1C2EA6EF62;
        Wed, 21 Oct 2020 20:12:50 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 76E17222F9C; Wed, 21 Oct 2020 16:12:49 -0400 (EDT)
Date:   Wed, 21 Oct 2020 16:12:49 -0400
From:   Vivek Goyal <vgoyal@redhat.com>
To:     Miklos Szeredi <miklos@szeredi.hu>
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
Message-ID: <20201021201249.GB442437@redhat.com>
References: <CAHk-=wgkD+sVx3cHAAzhVO5orgksY=7i8q6mbzwBjN0+4XTAUw@mail.gmail.com>
 <4794a3fa3742a5e84fb0f934944204b55730829b.camel@lca.pw>
 <CAHk-=wh9Eu-gNHzqgfvUAAiO=vJ+pWnzxkv+tX55xhGPFy+cOw@mail.gmail.com>
 <20201015151606.GA226448@redhat.com>
 <20201015195526.GC226448@redhat.com>
 <CAHk-=wj0vjx0jzaq5Gha-SmDKc3Hnog5LKX0eJZkudBvEQFAUA@mail.gmail.com>
 <CAJfpegtAstEo+nYgT81swYZWdziaZP_40QGAXcTORqYwgeWNUA@mail.gmail.com>
 <20201020204226.GA376497@redhat.com>
 <CAJfpegsi8UFiYyPrPbQob2x4X7NKSnciEz-a=5YZtFCgY0wL6w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJfpegsi8UFiYyPrPbQob2x4X7NKSnciEz-a=5YZtFCgY0wL6w@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Oct 21, 2020 at 09:40:26AM +0200, Miklos Szeredi wrote:
> On Tue, Oct 20, 2020 at 10:42 PM Vivek Goyal <vgoyal@redhat.com> wrote:
> 
> > As you said, for the full page WRITE, we can probably mark it
> > page uptodate write away and drop page lock (Keep reference and
> > send WRITE request to fuse server). For the partial page write this will
> > not work and there seem to be atleast two options.
> >
> > A. Either we read the page back from disk first and mark it uptodate.
> >
> > B. Or we keep track of such partial writes and block any further
> >    reads/readpage/direct_IO on these pages till partial write is
> >    complete. After that looks like page will be left notuptodate
> >    in page cache and reader will read it from disk. We are doing
> >    something similar for tracking writeback requests. It is much
> >    more complicated though and we probably can design something
> >    simpler for these writethrough/synchronous writes.
> >
> > I am assuming that A. will lead to performance penalty for short
> > random writes.
> 
> C.  Keep partial tail page locked.  If write involves a partial and
> head AND tail page, then read head page first.  I think that would be
> a good compromise between performance and simplicity.
> 
> WDYT?

Hi Miklos,

Sounds good. I refined this idea little bit more to avoid read
completely. We can add read later if it benefits in certain
situations.

D. If one does a partial page write of a page which is not uptodate, then
   keep page locked and do not try to send multiple pages in that write.
   If page is uptodate, then release page lock and continue to add more
   pages to same request.

IOW, if head page is partial (and it is not uptodate), we will just
send first WRITE with head page. Rest of the pages will go in second
WRITE and tail page could be locked if it was a partial write and
page was not uptodate. Please have a look at attached patch.

I still some concerns though with error handling. Not sure what to
do about it.

1. What happens if WRITE fails. If we are writing a full page and we
  already marked it as Uptodate (And not dirty), then we have page
  cache in page where we wrote data but could not send it to disk
  (and did not mark dirty as well). So if a user reads the page
  back it might get cache copy or get old copy from disk (if page
  cache copy was released).

2. What happens if it is a partial page write to an Uptodate page
  in cache and that WRITE fails. Now we have same error scenario
  as 1. In fact this is true for even current code and not
  necessarily a new scenario.

3. Current code marks a page Uptodate upon WRITE completion if
   it was full page WRITE. What if page was uptodate to begin
   with and write fails. So current code will not mark it
   Uptodate but it is already uptodate and we have same problem as 1.

Apart from above, there are some other concerns as well.

So with this patch, if a page is Uptodate we drop lock and send WRITE.
Otherwise we keep page lock and send WRITE. This should probably be
fine from read or fault read point of view. Given we are holding inode
lock, that means write path is not a problem as well. But

What if page is redirtied through a write mapping
-------------------------------------------------
If page is redirtied through writable mmap, then two writes for same
page can go in any order. But in synchronous write we are carrying
pointer to page cache page, so it probably does not matter. We will
just write same data twice.

What about races with direct_IO read
------------------------------------
If a WRITE is in progress, it is probably not marked dirty so
generic_file_read_iter() will probably not block on
filemap_write_and_wait_range() and continue mapping->a_ops->direct_IO().
And that means it can read previous disk data before this WRITE is
complete. 

Hopefully that's not a concern becase we have not returned write()
success to user space. So any parallel direct I/O probably should
not assume any order of operation.

So primary concern with this patch seems to be error handling if fuse
WRITE fails.

---
 fs/fuse/file.c   |   28 ++++++++++++++++++----------
 fs/fuse/fuse_i.h |    1 +
 2 files changed, 19 insertions(+), 10 deletions(-)

Index: redhat-linux/fs/fuse/file.c
===================================================================
--- redhat-linux.orig/fs/fuse/file.c	2020-10-21 11:41:43.983166360 -0400
+++ redhat-linux/fs/fuse/file.c	2020-10-21 15:16:24.151166360 -0400
@@ -1106,17 +1106,15 @@ static ssize_t fuse_send_write_pages(str
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
+		/* TODO: What if an error happened and it was a full page
+		 * write. Should we mark it dirty now so that it is written
+		 * back later. Otherwise we have a page in page cache which
+		 * is not marked dirty and it is not synced to disk either.
+		 */
+		if (page_locked)
+			unlock_page(page);
 		put_page(page);
 	}
 
@@ -1180,6 +1178,16 @@ static ssize_t fuse_fill_write_pages(str
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
Index: redhat-linux/fs/fuse/fuse_i.h
===================================================================
--- redhat-linux.orig/fs/fuse/fuse_i.h	2020-10-20 15:18:59.471971851 -0400
+++ redhat-linux/fs/fuse/fuse_i.h	2020-10-21 14:39:53.701166360 -0400
@@ -275,6 +275,7 @@ struct fuse_args_pages {
 	struct page **pages;
 	struct fuse_page_desc *descs;
 	unsigned int num_pages;
+	bool page_locked;
 };
 
 #define FUSE_ARGS(args) struct fuse_args args = {}


