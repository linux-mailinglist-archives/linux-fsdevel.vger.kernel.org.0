Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBE622C5481
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Nov 2020 14:08:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389860AbgKZNGv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 26 Nov 2020 08:06:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388291AbgKZNGv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 26 Nov 2020 08:06:51 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28C4DC0613D4;
        Thu, 26 Nov 2020 05:06:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=0Gv0fe8by51pBpJ9y/s+Bsc/pkGppT00OZEyWHEsCkc=; b=jDdN7hAOVm64LI4GLxtV8Xg4mQ
        Jhk3sYSO6NihDo6ErowuZ0lfW/FXxua0lGjFFXZ7hTshuIG02Qgh+ZtMvse28KRgXFa6YwznZ+zRM
        3SxJO9yOYalt/DOk9qnsxGmaq7Mm9pzMjycc3T8ZVi1jmSl4nMDZlkZJE3sN2+dyKPgpDMwt3zqvb
        SLuGPt5RBvuzIbdy43KrQgJ8FQup0kday2ag+tEAKT+U9PvPIbgh9dCIaX43s80gP5kUo5vBfWj55
        /k2Iy70DlOmB3z37Z9eoOo/XoZR8yNFXm3CeZynj7ahBX+ghuAT/JfcmZJ2vsfJVhk0COVF7tTO+/
        LxGu4YBQ==;
Received: from 089144198196.atnat0007.highway.a1.net ([89.144.198.196] helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kiGyo-0003va-9E; Thu, 26 Nov 2020 13:06:35 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Tejun Heo <tj@kernel.org>, Josef Bacik <josef@toxicpanda.com>,
        Coly Li <colyli@suse.de>, Mike Snitzer <snitzer@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jan Kara <jack@suse.cz>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        dm-devel@redhat.com, Jan Kara <jack@suse.com>,
        linux-block@vger.kernel.org, linux-bcache@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
Subject: merge struct block_device and struct hd_struct v3
Date:   Thu, 26 Nov 2020 14:03:38 +0100
Message-Id: <20201126130422.92945-1-hch@lst.de>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Jens,

this series cleans up our main per-device node data structure by merging
the block_device and hd_struct data structures that have the same scope,
but different life times.  The main effect (besides removing lots of
code) is that instead of having two device sizes that need complex
synchronization there is just one now.

Note that this now includes the previous "misc cleanups" series as I had
to fix up a thing in there with the changed patch ordering.

The first patch already is in 5.10-rc, but not in for-5.11/block

A git tree is available here:

    git://git.infradead.org/users/hch/block.git bdev-lookup

Gitweb:

    http://git.infradead.org/users/hch/block.git/shortlog/refs/heads/bdev-lookup

Changes since v2:
 - keep a reference to the whole device bdev from each partition bdev
   to simplify blkdev_get
 - drop a stale commen in freeze_bdev
 - fix an incorrect hunk that ignored error in thaw_bdev
 - add back a missing call to mapping_set_gfp_mask
 - misc typo fixes, comment and commit log improvements
 - keep using a global lock to synchronize gendisk lookup
 - do not call ->open for blk-cgroup configuration updates
 - drop a zram cleanup patch

Changes since v1:
 - spelling fixes
 - fix error unwinding in __alloc_disk_node
 - use bdev_is_partition in a few more places
 - don't send the RESIZE=1 uevent for hidden gendisks
 - rename __bdget_disk to disk_find_part
 - drop a bcache patch
 - some patch reordering
 - add more refactoring
 - use rcu protection to prevent racing with a disk going away
   in blkdev_get
 - split up some of the big patches into many small ones
 - clean up the freeze_bdev interface
