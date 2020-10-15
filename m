Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03EFB28F9C6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Oct 2020 21:55:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391995AbgJOTze (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Oct 2020 15:55:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:44907 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2391993AbgJOTze (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Oct 2020 15:55:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1602791732;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9X3PMCyT4ofhfgWOQyMoMGDvdGLXd6WWzgGuqPn6yd0=;
        b=KAfANeA5kf62vrywuR96wBxdozaDbs4PJdTo9q8qhBAYRfejnejCia79CCwzMRGZuRxFBx
        oCHBHtg85v5pHNnIkeiDkb8uGdqqMoph3TN8A/KyH7VmHyt4tl9eKS3HsZu05ifsDtwVU+
        yYMsxJgCzcl1mSHI9yjnRf5UlsHaT3g=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-61-QTiMQOBlN2SVNqqaGYpiFA-1; Thu, 15 Oct 2020 15:55:29 -0400
X-MC-Unique: QTiMQOBlN2SVNqqaGYpiFA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7C97A884D84;
        Thu, 15 Oct 2020 19:55:27 +0000 (UTC)
Received: from horse.redhat.com (ovpn-116-118.rdu2.redhat.com [10.10.116.118])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DB47E6EF67;
        Thu, 15 Oct 2020 19:55:26 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 5F8E7223B17; Thu, 15 Oct 2020 15:55:26 -0400 (EDT)
Date:   Thu, 15 Oct 2020 15:55:26 -0400
From:   Vivek Goyal <vgoyal@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Miklos Szeredi <miklos@szeredi.hu>
Cc:     Qian Cai <cai@lca.pw>, Hugh Dickins <hughd@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Linux-MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Amir Goldstein <amir73il@gmail.com>
Subject: Re: Possible deadlock in fuse write path (Was: Re: [PATCH 0/4] Some
 more lock_page work..)
Message-ID: <20201015195526.GC226448@redhat.com>
References: <CAHk-=wgkD+sVx3cHAAzhVO5orgksY=7i8q6mbzwBjN0+4XTAUw@mail.gmail.com>
 <4794a3fa3742a5e84fb0f934944204b55730829b.camel@lca.pw>
 <CAHk-=wh9Eu-gNHzqgfvUAAiO=vJ+pWnzxkv+tX55xhGPFy+cOw@mail.gmail.com>
 <20201015151606.GA226448@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201015151606.GA226448@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Oct 15, 2020 at 11:16:06AM -0400, Vivek Goyal wrote:
> On Wed, Oct 14, 2020 at 07:44:16PM -0700, Linus Torvalds wrote:
> > On Wed, Oct 14, 2020 at 6:48 PM Qian Cai <cai@lca.pw> wrote:
> > >
> > > While on this topic, I just want to bring up a bug report that we are chasing an
> > > issue that a process is stuck in the loop of wait_on_page_bit_common() for more
> > > than 10 minutes before I gave up.
> > 
> > Judging by call trace, that looks like a deadlock rather than a missed wakeup.
> > 
> > The trace isn't reliable, but I find it suspicious that the call trace
> > just before the fault contains that
> > "iov_iter_copy_from_user_atomic()".
> > 
> > IOW, I think you're in fuse_fill_write_pages(), which has allocated
> > the page, locked it, and then it takes a page fault.
> > 
> > And the page fault waits on a page that is locked.
> > 
> > This is a classic deadlock.
> > 
> > The *intent* is that iov_iter_copy_from_user_atomic() returns zero,
> > and you retry without the page lock held.
> > 
> > HOWEVER.
> > 
> > That's not what fuse actually does. Fuse will do multiple pages, and
> > it will unlock only the _last_ page. It keeps the other pages locked,
> > and puts them in an array:
> > 
> >                 ap->pages[ap->num_pages] = page;
> > 
> > And after the iov_iter_copy_from_user_atomic() fails, it does that
> > "unlock" and repeat.
> > 
> > But while the _last_ page was unlocked, the *previous* pages are still
> > locked in that array. Deadlock.
> > 
> > I really don't think this has anything at all to do with page locking,
> > and everything to do with fuse_fill_write_pages() having a deadlock if
> > the source of data is a mmap of one of the pages it is trying to write
> > to (just with an offset, so that it's not the last page).
> > 
> > See a similar code sequence in generic_perform_write(), but notice how
> > that code only has *one* page that it locks, and never holds an array
> > of pages around over that iov_iter_fault_in_readable() thing.
> 
> Indeed. This is a deadlock in fuse. Thanks for the analysis. I can now
> trivially reproduce it with following program.

I am wondering how should I fix this issue. Is it enough that I drop
the page lock (but keep the reference) inside the loop. And once copying
from user space is done, acquire page locks for all pages (Attached
a patch below).

Or dropping page lock means that there are no guarantees that this
page did not get written back and removed from address space and
a new page has been placed at same offset. Does that mean I should
instead be looking up page cache again after copying from user
space is done. 

---
 fs/fuse/file.c |   20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

Index: redhat-linux/fs/fuse/file.c
===================================================================
--- redhat-linux.orig/fs/fuse/file.c	2020-10-15 14:11:23.464720742 -0400
+++ redhat-linux/fs/fuse/file.c	2020-10-15 15:23:17.716569698 -0400
@@ -1117,7 +1117,7 @@ static ssize_t fuse_fill_write_pages(str
 	struct fuse_conn *fc = get_fuse_conn(mapping->host);
 	unsigned offset = pos & (PAGE_SIZE - 1);
 	size_t count = 0;
-	int err;
+	int err, i;
 
 	ap->args.in_pages = true;
 	ap->descs[0].offset = offset;
@@ -1155,6 +1155,14 @@ static ssize_t fuse_fill_write_pages(str
 			goto again;
 		}
 
+		/*
+		 * Unlock page but retain reference count. Unlock is requied
+		 * otherwise it is possible that next loop iteration tries
+		 * to fault in page (source address) we have lock on and we
+		 * will deadlock. So drop lock but keep a reference on the
+		 * page. Re-acquire page lock after breaking out of the loop
+		 */
+		unlock_page(page);
 		err = 0;
 		ap->pages[ap->num_pages] = page;
 		ap->descs[ap->num_pages].length = tmp;
@@ -1171,7 +1179,15 @@ static ssize_t fuse_fill_write_pages(str
 	} while (iov_iter_count(ii) && count < fc->max_write &&
 		 ap->num_pages < max_pages && offset == 0);
 
-	return count > 0 ? count : err;
+	if (count <= 0)
+		return err;
+
+	for (i = 0; i < ap->num_pages; i++) {
+		/* Take page lock */
+		lock_page(ap->pages[i]);
+	}
+
+	return count;
 }
 
 static inline unsigned int fuse_wr_pages(loff_t pos, size_t len,

