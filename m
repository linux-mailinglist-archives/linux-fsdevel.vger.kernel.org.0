Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AC2041B2E7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Sep 2021 17:26:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241455AbhI1P17 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Sep 2021 11:27:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241536AbhI1P1z (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Sep 2021 11:27:55 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AF4EC061745
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Sep 2021 08:26:16 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id r18so8758408edv.12
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Sep 2021 08:26:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Pg/mtu5yozr2x1jrcOGG+SVWTte5P1ucJOdu2abhCt0=;
        b=JYSCPm6wCFgAuU35U8vQZtdKrwCMQTp77htxFbkFVipxBiZAHnj/t66PZ0H6MCZfhF
         sGZVZ+gF4YgB9VwsDmqwcsGeF34vSMNndkp1q4h5mMml9ssTBpjaxdcsbIrqSPP6Hk8Q
         vKUW7uTblLjy/FvD85+K5W7Q6hiEDkcZlli34=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Pg/mtu5yozr2x1jrcOGG+SVWTte5P1ucJOdu2abhCt0=;
        b=5MqvToX8prMy0Oo0SvoH/UYWMxwP4Cymi/ZLn3jJjly1hEjUjYhVK3eeeZidgLQrJH
         HjvTAJPD4U+rdYTPZTomP3bcYsu5TMLIe0E27tkmvWwtodgCUVEVJ5Dt220AmhOE655c
         ejPyLg5nHq00f3s3CuczLKdpaggs5nHPQE3vLg9o38vHPJCw4VtLsoo9cvJQiEnZBv6j
         JqoVw2I4Nc5UM3sbvNnLmnTs9H3h7KuELmt04++uTXAspa024yRq0Do2rTQ0NcEBTADO
         96RrO87keHlsXi1qnxoP0KhpFcTH7rT9+zTYBvPJGu8OgH8Ej2csAt3uD5KyxbJ3L+JC
         SRrA==
X-Gm-Message-State: AOAM530o3t+3UTG2+13IJS8C9VCTzPCg7Sf35Jhwcox5ip2utgW2HZRg
        6l2mHMhXdiRSLs6Sz3LJFk8SGw==
X-Google-Smtp-Source: ABdhPJx3GbxU3BLtYAcwh/eZmQrqRFvHHLm8Bx+CQDdnWx+JnDl+HkpnEnBLFs5+F1RmTumZ/x67mQ==
X-Received: by 2002:a17:906:dc0d:: with SMTP id yy13mr7571497ejb.88.1632842739726;
        Tue, 28 Sep 2021 08:25:39 -0700 (PDT)
Received: from miu.piliscsaba.redhat.com (catv-86-101-169-16.catv.broadband.hu. [86.101.169.16])
        by smtp.gmail.com with ESMTPSA id e28sm4027456ejy.119.2021.09.28.08.25.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Sep 2021 08:25:38 -0700 (PDT)
Date:   Tue, 28 Sep 2021 17:25:36 +0200
From:   Miklos Szeredi <miklos@szeredi.hu>
To:     chenguanyou <chenguanyou@xiaomi.com>
Cc:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Ed Tsai <ed.tsai@mediatek.com>,
        chenguanyou <chenguanyou9338@gmail.com>,
        Stanley Chu =?utf-8?B?KOacseWOn+mZnik=?= 
        <stanley.chu@mediatek.com>
Subject: Re: [PATCH] [fuse] alloc_page nofs avoid deadlock
Message-ID: <YVMz8E1Lg/GZQcjw@miu.piliscsaba.redhat.com>
References: <20210603125242.31699-1-chenguanyou@xiaomi.com>
 <CAJfpegsEkRnU26Vvo4BTQUmx89Hahp6=RTuyEcPm=rqz8icwUQ@mail.gmail.com>
 <1fabb91167a86990f4723e9036a0e006293518f4.camel@mediatek.com>
 <CAJfpegsOSWZpKHqDNE_B489dGCzLr-RVAhimVOsFkxJwMYmj9A@mail.gmail.com>
 <07c5f2f1e10671bc462f88717f84aae9ee1e4d2b.camel@mediatek.com>
 <CAJfpegvAJS=An+hyAshkNcTS8A2TM28V2UP4SYycXUw3awOR+g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJfpegvAJS=An+hyAshkNcTS8A2TM28V2UP4SYycXUw3awOR+g@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Sep 24, 2021 at 09:52:35AM +0200, Miklos Szeredi wrote:
> On Fri, 24 Sept 2021 at 05:52, Ed Tsai <ed.tsai@mediatek.com> wrote:
> >
> > On Wed, 2021-08-18 at 17:24 +0800, Miklos Szeredi wrote:
> > > On Tue, 13 Jul 2021 at 04:42, Ed Tsai <ed.tsai@mediatek.com> wrote:
> > > >
> > > > On Tue, 2021-06-08 at 17:30 +0200, Miklos Szeredi wrote:
> > > > > On Thu, 3 Jun 2021 at 14:52, chenguanyou <
> > > > > chenguanyou9338@gmail.com>
> > > > > wrote:
> > > > > >
> > > > > > ABA deadlock
> > > > > >
> > > > > > PID: 17172 TASK: ffffffc0c162c000 CPU: 6 COMMAND: "Thread-21"
> > > > > > 0 [ffffff802d16b400] __switch_to at ffffff8008086a4c
> > > > > > 1 [ffffff802d16b470] __schedule at ffffff80091ffe58
> > > > > > 2 [ffffff802d16b4d0] schedule at ffffff8009200348
> > > > > > 3 [ffffff802d16b4f0] bit_wait at ffffff8009201098
> > > > > > 4 [ffffff802d16b510] __wait_on_bit at ffffff8009200a34
> > > > > > 5 [ffffff802d16b5b0] inode_wait_for_writeback at
> > > > > > ffffff800830e1e8
> > > > > > 6 [ffffff802d16b5e0] evict at ffffff80082fb15c
> > > > > > 7 [ffffff802d16b620] iput at ffffff80082f9270
> > > > > > 8 [ffffff802d16b680] dentry_unlink_inode at ffffff80082f4c90
> > > > > > 9 [ffffff802d16b6a0] __dentry_kill at ffffff80082f1710
> > > > > > 10 [ffffff802d16b6d0] shrink_dentry_list at ffffff80082f1c34
> > > > > > 11 [ffffff802d16b750] prune_dcache_sb at ffffff80082f18a8
> > > > > > 12 [ffffff802d16b770] super_cache_scan at ffffff80082d55ac
> > > > > > 13 [ffffff802d16b860] shrink_slab at ffffff8008266170
> > > > > > 14 [ffffff802d16b900] shrink_node at ffffff800826b420
> > > > > > 15 [ffffff802d16b980] do_try_to_free_pages at ffffff8008268460
> > > > > > 16 [ffffff802d16ba60] try_to_free_pages at ffffff80082680d0
> > > > > > 17 [ffffff802d16bbe0] __alloc_pages_nodemask at
> > > > > > ffffff8008256514
> > > > > > 18 [ffffff802d16bc60] fuse_copy_fill at ffffff8008438268
> > > > > > 19 [ffffff802d16bd00] fuse_dev_do_read at ffffff8008437654
> > > > > > 20 [ffffff802d16bdc0] fuse_dev_splice_read at ffffff8008436f40
> > > > > > 21 [ffffff802d16be60] sys_splice at ffffff8008315d18
> > > > > > 22 [ffffff802d16bff0] __sys_trace at ffffff8008084014
> > > > > >
> > > > > > PID: 9652 TASK: ffffffc0c9ce0000 CPU: 4 COMMAND:
> > > > > > "kworker/u16:8"
> > > > > > 0 [ffffff802e793650] __switch_to at ffffff8008086a4c
> > > > > > 1 [ffffff802e7936c0] __schedule at ffffff80091ffe58
> > > > > > 2 [ffffff802e793720] schedule at ffffff8009200348
> > > > > > 3 [ffffff802e793770] __fuse_request_send at ffffff8008435760
> > > > > > 4 [ffffff802e7937b0] fuse_simple_request at ffffff8008435b14
> > > > > > 5 [ffffff802e793930] fuse_flush_times at ffffff800843a7a0
> > > > > > 6 [ffffff802e793950] fuse_write_inode at ffffff800843e4dc
> > > > > > 7 [ffffff802e793980] __writeback_single_inode at
> > > > > > ffffff8008312740
> > > > > > 8 [ffffff802e793aa0] writeback_sb_inodes at ffffff80083117e4
> > > > > > 9 [ffffff802e793b00] __writeback_inodes_wb at ffffff8008311d98
> > > > > > 10 [ffffff802e793c00] wb_writeback at ffffff8008310cfc
> > > > > > 11 [ffffff802e793d00] wb_workfn at ffffff800830e4a8
> > > > > > 12 [ffffff802e793d90] process_one_work at ffffff80080e4fac
> > > > > > 13 [ffffff802e793e00] worker_thread at ffffff80080e5670
> > > > > > 14 [ffffff802e793e60] kthread at ffffff80080eb650
> > > > >
> > > > > The issue is real.
> > > > >
> > > > > The fix, however, is not the right one.  The fundamental problem
> > > > > is
> > > > > that fuse_write_inode() blocks on a request to userspace.
> > > > >
> > > > > This is the same issue that fuse_writepage/fuse_writepages
> > > > > face.  In
> > > > > that case the solution was to copy the page contents to a
> > > > > temporary
> > > > > buffer and return immediately as if the writeback already
> > > > > completed.
> > > > >
> > > > > Something similar needs to be done here: send the FUSE_SETATTR
> > > > > request
> > > > > asynchronously and return immediately from
> > > > > fuse_write_inode().  The
> > > > > tricky part is to make sure that multiple time updates for the
> > > > > same
> > > > > inode aren't mixed up...
> > > > >
> > > > > Thanks,
> > > > > Miklos
> > > >
> > > > Dear Szeredi,
> > > >
> > > > Writeback thread calls fuse_write_inode() and wait for user Daemon
> > > > to
> > > > complete this write inode request. The user daemon will
> > > > alloc_page()
> > > > after taking this request, and a deadlock could happen when we try
> > > > to
> > > > shrink dentry list under memory pressure.
> > > >
> > > > We (Mediatek) glad to work on this issue for mainline and also LTS.
> > > > So
> > > > another problem is that we should not change the protocol or
> > > > feature
> > > > for stable kernel.
> > > >
> > > > Use GFP_NOFS | __GFP_HIGHMEM can really avoid this by skip the
> > > > dentry
> > > > shirnker. It works but degrade the alloc_page success rate. In a
> > > > more
> > > > fundamental way, we could cache the contents and return
> > > > immediately.
> > > > But how to ensure the request will be done successfully, e.g.,
> > > > always
> > > > retry if it fails from daemon.
> > >
> > > Key is where the the dirty metadata is flushed.  To prevent deadlock
> > > it must not be flushed from memory reclaim, so must make sure that it
> > > is flushed on close(2) and munmap(2) and not dirtied after that.
> > >
> > > I'm working on this currently and hope to get it ready for the next
> > > merge window.
> > >
> > > Thanks,
> > > Miklos
> >
> > Hi Miklos,
> >
> > I'm not sure whether it has already been resolved in mainline.
> > If it still WIP, please cc me on future emails.
> 
> Hi,
> 
> This is taking a bit longer, unfortunately, but I already have
> something in testing and currently cleaning it up for review.  Hope to
> post a series today or early next week.


Here's a minimal patch.  It's been through some iterations and some testing, but
more review and testing is definitely welcome.

Chenguanyou, can you please verify that it fixes the deadlock?

Thanks,
Miklos

---
From: Miklos Szeredi <mszeredi@redhat.com>
Subject: fuse: make sure reclaim doesn't write the inode

In writeback cache mode mtime/ctime updates are cached, and flushed to the
server using the ->write_inode() callback.

Closing the file will result in a dirty inode being immediately written,
but in other cases the inode can remain dirty after all references are
dropped.  This result in the inode being written back from reclaim, which
can deadlock on a regular allocation while the request is being served.

The usual mechanisms (GFP_NOFS/PF_MEMALLOC*) don't work for FUSE, because
serving a request involves unrelated userspace process(es).

Instead do the same as for dirty pages: make sure the inode is written
before the last reference is gone.

 - fuse_vma_close(): flush times in addition to the dirty pages

 - fallocate(2)/copy_file_range(2): these call file_update_time() or
   file_modified(), so flush the inode before returning from the call

 - unlink(2), link(2) and rename(2): these call fuse_update_ctime(), so
   flush the ctime directly from this helper

Reported-by: chenguanyou <chenguanyou@xiaomi.com>
Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 fs/fuse/dir.c    |    8 ++++++++
 fs/fuse/file.c   |   24 +++++++++++++++++++++---
 fs/fuse/fuse_i.h |    1 +
 3 files changed, 30 insertions(+), 3 deletions(-)

--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -738,12 +738,20 @@ static int fuse_symlink(struct user_name
 	return create_new_entry(fm, &args, dir, entry, S_IFLNK);
 }
 
+void fuse_flush_time_update(struct inode *inode)
+{
+	int err = sync_inode_metadata(inode, 1);
+
+	mapping_set_error(inode->i_mapping, err);
+}
+
 void fuse_update_ctime(struct inode *inode)
 {
 	fuse_invalidate_attr(inode);
 	if (!IS_NOCMTIME(inode)) {
 		inode->i_ctime = current_time(inode);
 		mark_inode_dirty_sync(inode);
+		fuse_flush_time_update(inode);
 	}
 }
 
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -1847,6 +1847,17 @@ int fuse_write_inode(struct inode *inode
 	struct fuse_file *ff;
 	int err;
 
+	/*
+	 * Inode is always written before the last reference is dropped and
+	 * hence this should not be reached from reclaim.
+	 *
+	 * Writing back the inode from reclaim can deadlock if the request
+	 * processing itself needs an allocation.  Allocations triggering
+	 * reclaim while serving a request can't be prevented, because it can
+	 * involve any number of unrelated userspace processes.
+	 */
+	WARN_ON(wbc->for_reclaim);
+
 	ff = __fuse_write_file_get(fi);
 	err = fuse_flush_times(inode, ff);
 	if (ff)
@@ -2339,12 +2350,15 @@ static int fuse_launder_page(struct page
 }
 
 /*
- * Write back dirty pages now, because there may not be any suitable
- * open files later
+ * Write back dirty data/metadata now (there may not be any suitable
+ * open files later for data)
  */
 static void fuse_vma_close(struct vm_area_struct *vma)
 {
-	filemap_write_and_wait(vma->vm_file->f_mapping);
+	int err;
+
+	err = write_inode_now(vma->vm_file->f_mapping->host, 1);
+	mapping_set_error(vma->vm_file->f_mapping, err);
 }
 
 /*
@@ -3001,6 +3015,8 @@ static long fuse_file_fallocate(struct f
 	if (lock_inode)
 		inode_unlock(inode);
 
+	fuse_flush_time_update(inode);
+
 	return err;
 }
 
@@ -3110,6 +3126,8 @@ static ssize_t __fuse_copy_file_range(st
 	inode_unlock(inode_out);
 	file_accessed(file_in);
 
+	fuse_flush_time_update(inode_out);
+
 	return err;
 }
 
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -1145,6 +1145,7 @@ int fuse_allow_current_process(struct fu
 
 u64 fuse_lock_owner_id(struct fuse_conn *fc, fl_owner_t id);
 
+void fuse_flush_time_update(struct inode *inode);
 void fuse_update_ctime(struct inode *inode);
 
 int fuse_update_attributes(struct inode *inode, struct file *file);
