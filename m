Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C678F3BDE52
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Jul 2021 22:17:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230168AbhGFUTz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 6 Jul 2021 16:19:55 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:34324 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229935AbhGFUTy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 6 Jul 2021 16:19:54 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 9685D223E0;
        Tue,  6 Jul 2021 20:17:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1625602634; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QjOkqaqS9Mc62kHwL04HlFP/WEEBj3YxWlKHc9Vz7+c=;
        b=WcGTgYrWtGAWbGCprPxb8nBWHYE6VTyrKHA6lAMblogq9btdtirzssBUKw7bO0IAlhpsJX
        qs7fYSRAmR65XIqvssb6xBTLr6luGjy2/GiaCUpYOwTBK8tcOmxCn9ldwGs1RAPcCyHeVz
        uMKpNJGK6bNwbgofCzdGMYw6hXO5Cuc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1625602634;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QjOkqaqS9Mc62kHwL04HlFP/WEEBj3YxWlKHc9Vz7+c=;
        b=6/cxGFNCGZ8m/MyHZG3yt2wVN7hCA69mTf04TblzsxJzYFtikzxe9tOBCJKTECrUn714Hu
        v9DmLvEkz+nJxHAQ==
Received: from quack2.suse.cz (unknown [10.163.43.118])
        by relay2.suse.de (Postfix) with ESMTP id 550ABA3B98;
        Tue,  6 Jul 2021 20:17:14 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 2A47D1E62D6; Tue,  6 Jul 2021 22:17:14 +0200 (CEST)
Date:   Tue, 6 Jul 2021 22:17:14 +0200
From:   Jan Kara <jack@suse.cz>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Jan Kara <jack@suse.cz>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        "Darrick J. Wong" <djwong@kernel.org>, linux-ext4@vger.kernel.org,
        linux-mm@kvack.org, Christoph Hellwig <hch@infradead.org>
Subject: Re: [GIT PULL] Hole puch vs page cache filling races fixes for
 5.14-rc1
Message-ID: <20210706201714.GD17149@quack2.suse.cz>
References: <20210630172529.GB13951@quack2.suse.cz>
 <CAHk-=whuUxfoYj=dRnzRybg_sOdFPMDx_t06Lz936Pgnh6QCTQ@mail.gmail.com>
 <20210701161941.GA29014@quack2.suse.cz>
 <CAHk-=wiELnOWPLj2g2_JFxEquRXP2GikONXjyeSjv-Mque0Aaw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="u3/rZRmxL6MmkK24"
Content-Disposition: inline
In-Reply-To: <CAHk-=wiELnOWPLj2g2_JFxEquRXP2GikONXjyeSjv-Mque0Aaw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--u3/rZRmxL6MmkK24
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu 01-07-21 11:04:28, Linus Torvalds wrote:
> On Thu, Jul 1, 2021 at 9:19 AM Jan Kara <jack@suse.cz> wrote:
> >
> > That being said I don't expect the optimization to matter too much
> > because in do_read_fault() we first call do_fault_around() which will
> > exactly map pages that are already in cache and uptodate
> 
> Yeah, I think that ends up saving the situation.
> 
> > So do you think the optimization is still worth it despite
> > do_fault_around()?
> 
> I suspect it doesn't matter that much for performance as you say due
> to any filesystem that cares about performance having the "map_pages"
> function pointing to filemap_map_pages, but I reacted to it just from
> looking at the patch, and it just seems conceptually wrong. Taking the
> lock in a situation where it's not actually needed will just cause
> problems later when somebody decides that the lock protects something
> else entirely.

OK, I did some experiments and indeed in my totally unscientific boot and
compile tests I've seen ~90% of page faults to not get to filemap_fault()
(they were either anon memory or satisfied with filemap_map_pages()). From
the remaining 10% which got to filemap_fault() about 95% already had a page
in the page cache (so the optimization would help) - usually because we
were doing a write fault. So the optimization seems worth it.  I've added
attached patch on top of the series which implements the optimization you
suggested. I've also pushed out the complete series to

git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git hole_punch_fixes

so that people can see the whole picture. Review is welcome!

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

--u3/rZRmxL6MmkK24
Content-Type: text/x-patch; charset=us-ascii
Content-Disposition: attachment; filename="0001-mm-Acquire-invalidate_lock-in-filemap_fault-only-whe.patch"

From 347157fb9dfaf5a7d10e723c773affe147cdff34 Mon Sep 17 00:00:00 2001
From: Jan Kara <jack@suse.cz>
Date: Tue, 6 Jul 2021 16:45:42 +0200
Subject: [PATCH] mm: Acquire invalidate_lock in filemap_fault() only when
 creating pages

We don't need to acquire invalidate_lock in filemap_fault() when the
page is already in the page cache and uptodate since the existence of
the page itself (and its page lock) protect from races with
invalidation. This is rather common situation especially for write
faults (for read faults filemap_map_pages() generally handles this
situation). So let's avoid the unnecessary invalidate_lock acquisition
for this fast path.

Reported-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Jan Kara <jack@suse.cz>
---
 mm/filemap.c | 37 +++++++++++++++++++++++++++++--------
 1 file changed, 29 insertions(+), 8 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index b8e9bccecd9f..82269aaa715e 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -3030,6 +3030,7 @@ vm_fault_t filemap_fault(struct vm_fault *vmf)
 	pgoff_t max_off;
 	struct page *page;
 	vm_fault_t ret = 0;
+	bool mapping_locked = false;
 
 	max_off = DIV_ROUND_UP(i_size_read(inode), PAGE_SIZE);
 	if (unlikely(offset >= max_off))
@@ -3053,12 +3054,16 @@ vm_fault_t filemap_fault(struct vm_fault *vmf)
 		fpin = do_sync_mmap_readahead(vmf);
 	}
 
-	/*
-	 * See comment in filemap_create_page() why we need invalidate_lock
-	 */
-	filemap_invalidate_lock_shared(mapping);
 	if (!page) {
 retry_find:
+		/*
+		 * See comment in filemap_create_page() why we need
+		 * invalidate_lock
+		 */
+		if (!mapping_locked) {
+			filemap_invalidate_lock_shared(mapping);
+			mapping_locked = true;
+		}
 		page = pagecache_get_page(mapping, offset,
 					  FGP_CREAT|FGP_FOR_MMAP,
 					  vmf->gfp_mask);
@@ -3068,6 +3073,9 @@ vm_fault_t filemap_fault(struct vm_fault *vmf)
 			filemap_invalidate_unlock_shared(mapping);
 			return VM_FAULT_OOM;
 		}
+	} else if (unlikely(!PageUptodate(page))) {
+		filemap_invalidate_lock_shared(mapping);
+		mapping_locked = true;
 	}
 
 	if (!lock_page_maybe_drop_mmap(vmf, page, &fpin))
@@ -3085,8 +3093,20 @@ vm_fault_t filemap_fault(struct vm_fault *vmf)
 	 * We have a locked page in the page cache, now we need to check
 	 * that it's up-to-date. If not, it is going to be due to an error.
 	 */
-	if (unlikely(!PageUptodate(page)))
+	if (unlikely(!PageUptodate(page))) {
+		/*
+		 * The page was in cache and uptodate and now it is not.
+		 * Strange but possible since we didn't hold the page lock all
+		 * the time. Let's drop everything get the invalidate lock and
+		 * try again.
+		 */
+		if (!mapping_locked) {
+			unlock_page(page);
+			put_page(page);
+			goto retry_find;
+		}
 		goto page_not_uptodate;
+	}
 
 	/*
 	 * We've made it this far and we had to drop our mmap_lock, now is the
@@ -3097,6 +3117,8 @@ vm_fault_t filemap_fault(struct vm_fault *vmf)
 		unlock_page(page);
 		goto out_retry;
 	}
+	if (mapping_locked)
+		filemap_invalidate_unlock_shared(mapping);
 
 	/*
 	 * Found the page and have a reference on it.
@@ -3106,11 +3128,9 @@ vm_fault_t filemap_fault(struct vm_fault *vmf)
 	if (unlikely(offset >= max_off)) {
 		unlock_page(page);
 		put_page(page);
-		filemap_invalidate_unlock_shared(mapping);
 		return VM_FAULT_SIGBUS;
 	}
 
-	filemap_invalidate_unlock_shared(mapping);
 	vmf->page = page;
 	return ret | VM_FAULT_LOCKED;
 
@@ -3141,7 +3161,8 @@ vm_fault_t filemap_fault(struct vm_fault *vmf)
 	 */
 	if (page)
 		put_page(page);
-	filemap_invalidate_unlock_shared(mapping);
+	if (mapping_locked)
+		filemap_invalidate_unlock_shared(mapping);
 	if (fpin)
 		fput(fpin);
 	return ret | VM_FAULT_RETRY;
-- 
2.26.2


--u3/rZRmxL6MmkK24--
