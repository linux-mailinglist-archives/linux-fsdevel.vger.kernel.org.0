Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5682B439954
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Oct 2021 16:53:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233370AbhJYOzb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 25 Oct 2021 10:55:31 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:43440 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233002AbhJYOz0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 25 Oct 2021 10:55:26 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 817CE1FD3A;
        Mon, 25 Oct 2021 14:53:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1635173583; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=14vlRFy8Pd1BNKQMHmPc+yvqhuG2k+CTVxOYOeA1kn0=;
        b=ACSuhGqQE5/IQmBwsizElcT0XULvOSPiT0QyHXewabgGef+94XmF/Y4tGw6A1tuaHSDlWD
        dMOSs7xBrno7BfZxl+4JZIS2ZoSaMgnp0Xd9umRWwqQ83sbI2Dwfok1M4l63lml+c19Z98
        eXGuUb4B+Y/t5NAhl9TSrpy6DYGXSwA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1635173583;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=14vlRFy8Pd1BNKQMHmPc+yvqhuG2k+CTVxOYOeA1kn0=;
        b=fL0mH+Lo8ohf+9tRmo3Aq68EdLMyP+e7nNEUe9/RCXySreKRR8vL/9fzkkZZLd11VDlDxi
        pJX0LNjRr23vtxCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 278F313C0B;
        Mon, 25 Oct 2021 14:53:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id xjWwAM/EdmG/CQAAMHmgww
        (envelope-from <rgoldwyn@suse.de>); Mon, 25 Oct 2021 14:53:03 +0000
Date:   Mon, 25 Oct 2021 09:53:01 -0500
From:   Goldwyn Rodrigues <rgoldwyn@suse.de>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org
Subject: Re: [RFC PATCH 0/5] Shared memory for shared extents
Message-ID: <20211025145301.hk627p2qcotxegrd@fiona>
References: <cover.1634933121.git.rgoldwyn@suse.com>
 <YXNoxZqKPkxZvr3E@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YXNoxZqKPkxZvr3E@casper.infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On  2:43 23/10, Matthew Wilcox wrote:
> On Fri, Oct 22, 2021 at 03:15:00PM -0500, Goldwyn Rodrigues wrote:
> > This is an attempt to reduce the memory footprint by using a shared
> > page(s) for shared extent(s) in the filesystem. I am hoping to start a
> > discussion to iron out the details for implementation.
> 
> When you say "Shared extents", you mean reflinks, which are COW, right?

Yes, shared extents are extents which are shared on disk by two or more
files. Yes, same as reflinks. Just to explain with an example:

If two files, f1 and f2 have shared extent(s), and both files are read. Each
file's mapping->i_pages will hold a copy of the contents of the shared
extent on disk. So, f1->mapping will have one copy and f2->mapping will
have another copy.

For reads (and only reads), if we use underlying device's mapping, we
can save on duplicate copy of the pages.

> A lot of what you say here confuses me because you talk about dirty
> shared pages, and that doesn't make any sense.  A write fault or
> call to write() should be intercepted by the filesystem in order to
> break the COW.  There's no such thing as a shared page which is dirty,
> or has been written back.


I am _not_ talking of writes at all here. However, just to clarify the
air: For a CoW environment,  if a write happens, it becomes the
filesystems responsibility to write it to a new device location. These
pages should still end up in inode's i_mapping, as it is done currently.
This also includes pages which are read before modifying/writing.
The filesystem will writeback these pages to a new device location.
My question in the end was if we should release these  pages
or perhaps move them to device's mapping once they are no
longer dirty - for subsequence reads.

> 
> You might (or might not!) choose to copy the pages from the shared
> extent to the inode when breaking the COW.  But you can't continue
> to share them!

Since a write goes through inode's i_mapping, it will go to a new device
location and will break the share. There is no change in this
phenomenon. What I am changing is only the "pure" reads from CoW
filesystems. IOW, there is an order to look pagecache for reads - 
1. inode->i_mapping->i_pages
2. inode->sb->s_bdev->bd_inode->i_mapping->i_pages (after file offset to
device).

This way reads from dirty pages will go through inode->i_mapping.

> 
> > Abstract
> > If mutiple files share an extent, reads from each of the files would
> > read individual page copies in the inode pagecache mapping, leading to
> > waste of memory. Instead add the read pages of the filesystem to
> > underlying device's bd_inode as opposed to file's inode mapping. The
> > cost is that file offset to device offset conversion happens early in
> > the read cycle.
> > 
> > Motivation:
> >  - Reduce memory usage for shared extents
> >  - Ease DAX implementation for shared extents
> >  - Reduce Container memory utilization
> > 
> > Implementation
> > In the read path, pages are read and added to the block_device's
> > inode's mapping as opposed to the inode's mapping. This is limited
> > to reads, while write's (and read before writes) still go through
> > inode's i_mapping. The path does check the inode's i_mapping before
> > falling back to block device's i_mapping to read pages which may be
> > dirty. The cost of the operation is file_to_device_offset() translation
> > on reads. The translation should return a valid value only in case
> > the file is CoW.
> > 
> > This also means that page->mapping may not point to file's mapping.
> > 
> > Questions:
> > 1. Are there security implications for performing this for read-only
> > pages? An alternate idea is to add a "struct fspage", which would be
> > pointed by file's mapping and would point to the block device's page.
> > Multiple files with shared extents have their own independent fspage
> > pointing to the same page mapped to block device's mapping.
> > Any security parameters, if required, would be in this structure. The
> > advantage of this approach is it would be more flexible with respect to
> > CoW when the page is dirtied after reads. With the current approach, a
> > read for write is an independent operation so we can end up with two
> > copies of the same page. This implementation got complicated too quickly.
> > 
> > 2. Should pages be dropped after writebacks (and clone_range) to avoid
> > duplicate copies?
> > 
> > Limitations:
> > 1. The filesystem have exactly one underlying device.
> > 2. Page size should be equal to filesystem block size
> > 
> > Goldwyn Rodrigues (5):
> >   mm: Use file parameter to determine bdi
> >   mm: Switch mapping to device mapping
> >   btrfs: Add sharedext mount option
> >   btrfs: Set s_bdev for btrfs super block
> >   btrfs: function to convert file offset to device offset
> > 
> >  fs/btrfs/ctree.h   |  1 +
> >  fs/btrfs/file.c    | 42 ++++++++++++++++++++++++++++++++++++++++--
> >  fs/btrfs/super.c   |  7 +++++++
> >  include/linux/fs.h |  7 ++++++-
> >  mm/filemap.c       | 34 ++++++++++++++++++++++++++--------
> >  mm/readahead.c     |  3 +++
> >  6 files changed, 83 insertions(+), 11 deletions(-)
> > 
> > -- 
> > 2.33.1
> > 

-- 
Goldwyn
