Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5DD2DAAD3E
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Sep 2019 22:42:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391702AbfIEUmO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 5 Sep 2019 16:42:14 -0400
Received: from mx2.suse.de ([195.135.220.15]:34192 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388260AbfIEUmO (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 5 Sep 2019 16:42:14 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 5DD30AF03;
        Thu,  5 Sep 2019 20:42:12 +0000 (UTC)
Date:   Thu, 5 Sep 2019 15:42:10 -0500
From:   Goldwyn Rodrigues <rgoldwyn@suse.de>
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        darrick.wong@oracle.com, linux-xfs@vger.kernel.org,
        Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: Re: [PATCH 04/15] btrfs: Add a simple buffered iomap write
Message-ID: <20190905204210.eb3gadoux3ih353q@fiona>
References: <20190905150650.21089-1-rgoldwyn@suse.de>
 <20190905150650.21089-5-rgoldwyn@suse.de>
 <20190905162344.GA22450@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190905162344.GA22450@lst.de>
User-Agent: NeoMutt/20180716
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 18:23 05/09, Christoph Hellwig wrote:
> > Most of the code is "inspired" by
> > fs/btrfs/file.c. To keep the size small, all removals are in
> > following patches.
> 
> Wouldn't it be better to massage the existing code into a form where you
> can fairly easily switch over to iomap?  That is start refactoring the
> code into helpers that are mostly reusable and then just have a patch
> switching over.  That helps reviewing what actually changes.  It's
> also what we did for XFS.
> 

Well that is how I had started, but it was getting ugly. Besides, I was
moving everything to a new iomap.c file. So, I think I will change the
relevant code in place and then try to move it to iomap.c, depending
on how big the file is..

No wonder I was not getting any reviews from the btrfs developers!

> 
> > +		if (!ordered) {
> > +			break;
> > +		}
> 
> No need for the braces.
> 
> > +static void btrfs_buffered_page_done(struct inode *inode, loff_t pos,
> > +		unsigned copied, struct page *page,
> > +		struct iomap *iomap)
> > +{
> > +	if (!page)
> > +		return;
> > +	SetPageUptodate(page);
> > +	ClearPageChecked(page);
> > +	set_page_dirty(page);
> > +	get_page(page);
> > +}
> 
> Thіs looks really strange.  Can you explain me why you need the
> manual dirtying and SetPageUptodate, and an additional page refcount
> here?

It was a part btrfs code which is carried forward. Yes, we don't need
the page dirtying and uptodate since iomap does it for us.

> 
> > +	if (ret < 0) {
> > +		/*
> > +		 * Space allocation failed. Let's check if we can
> > +		 * continue I/O without allocations
> > +		 */
> > +		if ((BTRFS_I(inode)->flags & (BTRFS_INODE_NODATACOW |
> > +						BTRFS_INODE_PREALLOC)) &&
> > +				check_can_nocow(BTRFS_I(inode), pos,
> > +					&write_bytes) > 0) {
> > +			bi->nocow = true;
> > +			/*
> > +			 * our prealloc extent may be smaller than
> > +			 * write_bytes, so scale down.
> > +			 */
> > +			bi->reserved_bytes = round_up(write_bytes +
> > +					sector_offset,
> > +					fs_info->sectorsize);
> > +		} else {
> > +			goto error;
> > +		}
> 
> Maybe move the goto into the inverted if so you can reduce indentation
> by one level?
> 
> > +		} else {
> > +			u64 __pos = round_down(pos + written, fs_info->sectorsize);
> 
> Line over > 80 characters, and a somewhat odd variabke name.
> 
> > +	if (bi->nocow) {
> > +		struct btrfs_root *root = BTRFS_I(inode)->root;
> > +		btrfs_end_write_no_snapshotting(root);
> > +		if (written > 0) {
> > +			u64 start = round_down(pos, fs_info->sectorsize);
> > +			u64 end = round_up(pos + written, fs_info->sectorsize) - 1;
> 
> Line > 80 chars.
> 
> > +			set_extent_bit(&BTRFS_I(inode)->io_tree, start, end,
> > +					EXTENT_NORESERVE, NULL, NULL, GFP_NOFS);
> > +		}
> > +
> > +	}
> > +	btrfs_delalloc_release_extents(BTRFS_I(inode), bi->reserved_bytes,
> > +			true);
> > +
> > +	if (written < fs_info->nodesize)
> > +		btrfs_btree_balance_dirty(fs_info);
> > +
> > +	extent_changeset_free(bi->data_reserved);
> > +	kfree(bi);
> > +	return ret;
> > +}
> 
> > +static const struct iomap_ops btrfs_buffered_iomap_ops = {
> > +	.iomap_begin            = btrfs_buffered_iomap_begin,
> > +	.iomap_end              = btrfs_buffered_iomap_end,
> > +};
> > +
> > +size_t btrfs_buffered_iomap_write(struct kiocb *iocb, struct iov_iter *from)
> > +{
> > +	ssize_t written;
> > +	struct inode *inode = file_inode(iocb->ki_filp);
> > +	written = iomap_file_buffered_write(iocb, from, &btrfs_buffered_iomap_ops);
> 
> no empty line after the variable declarations?  Also this adds a > 80
> character line.
> 
> > +	if (written > 0)
> > +		iocb->ki_pos += written;
> 
> I wonder if we should fold the ki_pos update into
> iomap_file_buffered_write.  But the patch looks fine even without that.
> 
> Also any reason to not name this function btrfs_buffered_write and
> keep it in file.c with the rest of the write code?
> 

Yes, I should focus on what it should be called eventually as opposed to
the transition.

-- 
Goldwyn
