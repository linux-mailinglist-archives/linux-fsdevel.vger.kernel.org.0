Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DF212AF8B9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Nov 2020 20:10:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726157AbgKKTKP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 11 Nov 2020 14:10:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726101AbgKKTKP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 11 Nov 2020 14:10:15 -0500
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7D40C0613D1
        for <linux-fsdevel@vger.kernel.org>; Wed, 11 Nov 2020 11:10:14 -0800 (PST)
Received: by mail-qk1-x72f.google.com with SMTP id t191so2796230qka.4
        for <linux-fsdevel@vger.kernel.org>; Wed, 11 Nov 2020 11:10:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition;
        bh=cH6LNs9+cy6NhhojxHn+bJDceuxIsC3lzgFjv7Z9HHA=;
        b=ZVAL0rCtGLF+9e546YLqKRAxr8EVypwfUht9RdBC2dBa4vpFk2fdPl0kEvRCWXfbVC
         qgf6Ia6FbOgYTkPS+VEhp1fOXejujTD0e1p6Zv+GjWkHTjL6b2FrDXZI29/IFedTEUDL
         Uw5WFdcyDbzJi/FVV44FTPiNwj9ytoKkSekzulV9xeE4mZ1+CEjiEG9kQIQg1p74+HUO
         lkaonQEla0IaykDU5OwfsgzQrdHvuDSRjCFlmF+JB4Q7/nVAAnBMz583IHk7aP4o2Z6l
         hHAWnLuPa6wXquTPMv7jb7kR7sksPIExiB+8i2swll3btHL/SrFUNYr9mkulLONT74H+
         Udww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition;
        bh=cH6LNs9+cy6NhhojxHn+bJDceuxIsC3lzgFjv7Z9HHA=;
        b=NebzOQT3u8t4gRAKd8mQS5e8kSwBe7791besJeyPUBxixsxTsgjFs5mA3DsdBfn6f2
         baoVEe4GDpPJT1Lel5z8tUZrM9wJwM/G8HTgE5ehmOY9Eme8mS6v6Lija4AWODWaMs0B
         z/zhPhKHGy0hxwK9jqkg8wbUrYohodOvON2FqvwDoONHtkippSXKKV3L7fxdUpiGIO3O
         +NBOxWxn59FSkrWHDUQ6wqH5Ypbzd55jLATgYeLkBfHAaFlBUgh9I5zDI3iFlCubuZ5x
         /RPi0DAfM3qjvreFPl2P/RqqBo/sGpPdT/DdRsOyyVz8SLSY3UYGwe8aPHvxcIB9AV3N
         4QrQ==
X-Gm-Message-State: AOAM532VmOAZ59zrf322C/KiUiqh7n75IqKjLLZMYTA4KxZGjFTqLtAR
        OswPXs8Q5YDOF1rVud9e93Ga/XtgzMwj
X-Google-Smtp-Source: ABdhPJzacAtM5omJEG/IfRfFTS1qoxSGRTJecF81Eo3GtC5VDYwaDUBrNvBqJb0vgIF6uiZswAblag==
X-Received: by 2002:a37:73c6:: with SMTP id o189mr26369469qkc.216.1605121813719;
        Wed, 11 Nov 2020 11:10:13 -0800 (PST)
Received: from moria.home.lan (c-73-219-103-14.hsd1.vt.comcast.net. [73.219.103.14])
        by smtp.gmail.com with ESMTPSA id q28sm3111493qkn.39.2020.11.11.11.10.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2020 11:10:13 -0800 (PST)
Date:   Wed, 11 Nov 2020 14:10:11 -0500
From:   Kent Overstreet <kent.overstreet@gmail.com>
To:     linux-fsdevel@vger.kernel.org, Dave Chinner <david@fromorbit.com>,
        Matthew Wilcox <willy@infradead.org>
Subject: DIO & page cache coherency locking + deadlock prevention
Message-ID: <20201111191011.GE3365678@moria.home.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Background: for bcachefs I've been trying to solve the dio page cache coherency
problem. In short, existing filesystems to varying degrees have a problem with
operations that modify file data while bypassing the page cache, because while
we can shoot down/invalidate regions of the page cache just fine, and the inode
lock will prevent reads and writes from syscalls from pulling those pages back
into the page cache - page faults are a different story.

And where this gets really tricky is that direct IO via gup() invokes the page
fault handler, meaning that if the page fault handler is taking the same lock
that the dio write path is using to prevent the pages it invalidated from being
faulted back in - and it kinda has to - oops, deadlock.

The standard approach to these kinds of deadlocks is to check for a lock
ordering violation when taking the 2nd/additional locks, and then if there is a
lock ordering violation and trylock fails - drop and retake locks in the correct
order, and unwind and retry from the top because whatever state we had locked
may have changed.

This means on lock ordering violation the fault handler has to tell the dio
write code that's calling gup() that it has to re-shoot down the page cache and
retry.

I finally got around to implementing all this for bcachefs, and it turned out to
be a lot less nasty than I expected - and I've got it passing a torture test
that tries to hit this deadlock, where I've got 3 different processes all doing
dio writes to one file from a buffer that's mapped from the next processes's
file.

So, I'm posting the code to see if there's any interest in having this locking
for other filesystems. In my bcachefs tree I've got this all in fs/bcachefs/,
minus adding one entry to task_struct so we can pass info from the dio write
path to the fault handler. But if this is of interest to other filesystems it
needs to be in generic code in filemap.c, for obvious reasons.

The code below is on top of the existing bcachefs code that implements
ei_pagecache_lock, all it adds is the deadlock detection/handling but it should
be enough to show the general approach:


commit 2872719261668fa9f0cffe04f4895686c8207778
Author: Kent Overstreet <kent.overstreet@gmail.com>
Date:   Wed Nov 11 12:33:12 2020 -0500

    bcachefs: Deadlock prevention for ei_pagecache_lock

diff --git a/fs/bcachefs/fs-io.c b/fs/bcachefs/fs-io.c
index 1eb69ed38b..0278e7c156 100644
--- a/fs/bcachefs/fs-io.c
+++ b/fs/bcachefs/fs-io.c
@@ -35,6 +35,22 @@
 #include <trace/events/bcachefs.h>
 #include <trace/events/writeback.h>
 
+static inline struct address_space *faults_disabled_mapping(void)
+{
+	return (void *) (((unsigned long) current->faults_disabled_mapping) & (~0UL << 1));
+}
+
+static inline void set_fdm_dropped_locks(void)
+{
+	current->faults_disabled_mapping =
+		(void *) (((unsigned long) current->faults_disabled_mapping)|1);
+}
+
+static inline bool fdm_dropped_locks(void)
+{
+	return ((unsigned long) current->faults_disabled_mapping) & 1;
+}
+
 struct quota_res {
 	u64				sectors;
 };
@@ -493,10 +509,35 @@ static void bch2_set_page_dirty(struct bch_fs *c,
 vm_fault_t bch2_page_fault(struct vm_fault *vmf)
 {
 	struct file *file = vmf->vma->vm_file;
+	struct address_space *mapping = file->f_mapping;
+	struct address_space *fdm = faults_disabled_mapping();
 	struct bch_inode_info *inode = file_bch_inode(file);
 	int ret;
 
+	if (fdm == mapping)
+		return VM_FAULT_SIGBUS;
+
+	/* Lock ordering: */
+	if (fdm > mapping) {
+		struct bch_inode_info *fdm_host = to_bch_ei(fdm->host);
+
+		if (bch2_pagecache_add_tryget(&inode->ei_pagecache_lock))
+			goto got_lock;
+
+		bch2_pagecache_block_put(&fdm_host->ei_pagecache_lock);
+
+		bch2_pagecache_add_get(&inode->ei_pagecache_lock);
+		bch2_pagecache_add_put(&inode->ei_pagecache_lock);
+
+		bch2_pagecache_block_get(&fdm_host->ei_pagecache_lock);
+
+		/* Signal that lock has been dropped: */
+		set_fdm_dropped_locks();
+		return VM_FAULT_SIGBUS;
+	}
+
 	bch2_pagecache_add_get(&inode->ei_pagecache_lock);
+got_lock:
 	ret = filemap_fault(vmf);
 	bch2_pagecache_add_put(&inode->ei_pagecache_lock);
 
@@ -1742,14 +1783,16 @@ static long bch2_dio_write_loop(struct dio_write *dio)
 	struct bio *bio = &dio->op.wbio.bio;
 	struct bvec_iter_all iter;
 	struct bio_vec *bv;
-	unsigned unaligned;
-	bool sync = dio->sync;
+	unsigned unaligned, iter_count;
+	bool sync = dio->sync, dropped_locks;
 	long ret;
 
 	if (dio->loop)
 		goto loop;
 
 	while (1) {
+		iter_count = dio->iter.count;
+
 		if (kthread)
 			kthread_use_mm(dio->mm);
 		BUG_ON(current->faults_disabled_mapping);
@@ -1757,13 +1800,34 @@ static long bch2_dio_write_loop(struct dio_write *dio)
 
 		ret = bio_iov_iter_get_pages(bio, &dio->iter);
 
+		dropped_locks = fdm_dropped_locks();
+
 		current->faults_disabled_mapping = NULL;
 		if (kthread)
 			kthread_unuse_mm(dio->mm);
 
+		/*
+		 * If the fault handler returned an error but also signalled
+		 * that it dropped & retook ei_pagecache_lock, we just need to
+		 * re-shoot down the page cache and retry:
+		 */
+		if (dropped_locks && ret)
+			ret = 0;
+
 		if (unlikely(ret < 0))
 			goto err;
 
+		if (unlikely(dropped_locks)) {
+			ret = write_invalidate_inode_pages_range(mapping,
+					req->ki_pos,
+					req->ki_pos + iter_count - 1);
+			if (unlikely(ret))
+				goto err;
+
+			if (!bio->bi_iter.bi_size)
+				continue;
+		}
+
 		unaligned = bio->bi_iter.bi_size & (block_bytes(c) - 1);
 		bio->bi_iter.bi_size -= unaligned;
 		iov_iter_revert(&dio->iter, unaligned);
