Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AE5C3556D4
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Apr 2021 16:41:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243401AbhDFOlv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 6 Apr 2021 10:41:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233070AbhDFOlu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 6 Apr 2021 10:41:50 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9F7FC06174A;
        Tue,  6 Apr 2021 07:41:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=hUzYdafqUkSxFBGuJk6UxNp58JgCVIdROY5vKcDr6wA=; b=wPjWHq41ZvqO32+B7eUb9ZrmeW
        s9oNrb7TrioJQD0G2zwsaoSdYeh68OUYdKMN9FRzkhuC6XDTlb7cUP8iDM9h+kzEqhdel6Qquh6a4
        D8xlMpik29gkqvJ3HedOv4YiXYWSO0LfCTVEmj30bQ/HB/cX+Qym4iJ5iKcT+PY8+DqjPCnZbtoKf
        sMUHn0OvfwGnI9wEOn5z8+CI5Me/lQNZzba+/MfoUAMlh7ydgj8d5VBGKLNVZhdJWTMHxBM0Qzik6
        w/AV8hh5CTqhCakqb7JKv3Sl5WMx4Qff79xd5RQmJ2X3T97BxvtumXl6bpN0fszPXKlw/LUnbCZny
        Jqlt3KeA==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lTmsQ-00Cx9o-RR; Tue, 06 Apr 2021 14:40:27 +0000
Date:   Tue, 6 Apr 2021 15:40:22 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     "Kirill A. Shutemov" <kirill@shutemov.name>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-cachefs@redhat.com, linux-afs@lists.infradead.org
Subject: Re: [PATCH v6 01/27] mm: Introduce struct folio
Message-ID: <20210406144022.GR2531743@casper.infradead.org>
References: <20210331184728.1188084-1-willy@infradead.org>
 <20210331184728.1188084-2-willy@infradead.org>
 <20210406122918.h5dsnbjhmwpfasf4@box.shutemov.name>
 <20210406124807.GO2531743@casper.infradead.org>
 <20210406143150.GA3082513@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210406143150.GA3082513@infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Apr 06, 2021 at 03:31:50PM +0100, Christoph Hellwig wrote:
> > > As Christoph, I'm not a fan of this :/
> > 
> > What would you prefer?
> 
> Looking at your full folio series on git.infradead.org, there are a
> total of 12 references to non-page members of struct folio, assuming
> my crude grep that expects a folio to be named folio did not miss any.

Hmm ... I count more in the filesystems:

fs/afs/dir.c:   struct afs_vnode *dvnode = AFS_FS_I(folio->page.mapping->host);
fs/afs/dir.c:   _enter("{%lu},%zu,%zu", folio->page.index, offset, length);
fs/afs/file.c:  _enter("{%lu},%zu,%zu", folio->page.index, offset, length);
fs/afs/write.c:         folio->page.index);
fs/befs/linuxvfs.c:     struct inode *inode = folio->page.mapping->host;
fs/btrfs/disk-io.c:     tree = &BTRFS_I(folio->page.mapping->host)->io_tree;
fs/btrfs/disk-io.c:             btrfs_warn(BTRFS_I(folio->page.mapping->host)->root->fs_info,
fs/btrfs/extent_io.c:   struct btrfs_inode *inode = BTRFS_I(folios[0]->page.mapping->host);
fs/btrfs/file.c:                if (folio->page.mapping != inode->i_mapping) {
fs/btrfs/free-space-cache.c:                    if (folio->page.mapping != inode->i_mapping) {
fs/btrfs/inode.c:               if (folio->page.mapping != mapping) {
fs/btrfs/inode.c:       struct btrfs_inode *inode = BTRFS_I(folio->page.mapping->host);
fs/buffer.c:    spin_lock(&folio->page.mapping->private_lock);
fs/buffer.c:    spin_unlock(&folio->page.mapping->private_lock);
fs/buffer.c:    block_in_file = (sector_t)folio->page.index <<
fs/ceph/addr.c:              mapping->host, folio, folio->page.index);
fs/ceph/addr.c:      mapping->host, folio, folio->page.index,
fs/ceph/addr.c: folio->page.private = (unsigned long)snapc;
fs/ceph/addr.c: inode = folio->page.mapping->host;
fs/ceph/addr.c:              inode, folio, folio->page.index, offset, length);
fs/ceph/addr.c:      inode, folio, folio->page.index);
fs/cifs/file.c: struct cifsInodeInfo *cifsi = CIFS_I(folio->page.mapping->host);
fs/ext4/inode.c:        struct inode *inode = folio->page.mapping->host;
fs/f2fs/data.c: struct inode *inode = folio->page.mapping->host;
fs/fuse/dir.c:  int err = fuse_readlink_page(folio->page.mapping->host, &folio->page);
fs/gfs2/aops.c: struct gfs2_sbd *sdp = GFS2_SB(folio->page.mapping->host);
fs/iomap/buffered-io.c: unsigned int nr_blocks = i_blocks_per_folio(folio->page.mapping->host,
fs/iomap/buffered-io.c: struct inode *inode = folio->page.mapping->host;
fs/iomap/buffered-io.c: BUG_ON(folio->page.index);
fs/iomap/buffered-io.c:         gfp_t gfp = mapping_gfp_constraint(folio->page.mapping,
fs/iomap/buffered-io.c: struct inode *inode = folio->page.mapping->host;
fs/iomap/buffered-io.c: struct inode *inode = folio->page.mapping->host;
fs/iomap/buffered-io.c: trace_iomap_releasepage(folio->page.mapping->host, folio_offset(folio),
fs/iomap/buffered-io.c: trace_iomap_invalidatepage(folio->page.mapping->host, offset, len);
fs/jffs2/file.c:        struct inode *inode = folio->page.mapping->host;
fs/mpage.c:     struct inode *inode = folio->page.mapping->host;
fs/mpage.c:             gfp = readahead_gfp_mask(folio->page.mapping);
fs/mpage.c:             gfp = mapping_gfp_constraint(folio->page.mapping, GFP_KERNEL);
fs/mpage.c:     block_in_file = (sector_t)folio->page.index << (PAGE_SHIFT - blkbits);
fs/mpage.c:             prefetchw(&folio->page.flags);
fs/nfs/file.c:  nfs_fscache_invalidate_page(&folio->page, folio->page.mapping->host);
fs/nfs/fscache.c:                nfs_i_fscache(inode), folio, folio->page.index,
fs/nfs/fscache.c:                folio->page.flags, inode);
fs/reiserfs/inode.c:    struct inode *inode = folio->page.mapping->host;
fs/remap_range.c:       if (folio1->page.index > folio2->page.index)
fs/ubifs/file.c:        struct inode *inode = folio->page.mapping->host;
fs/xfs/xfs_aops.c:      struct inode            *inode = folio->page.mapping->host;

(I didn't go through my whole series and do the conversion from
folio->page.x to folio->x yet)

