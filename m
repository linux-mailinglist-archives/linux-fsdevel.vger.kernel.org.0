Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 415D8AA8D8
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Sep 2019 18:23:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726626AbfIEQXu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 5 Sep 2019 12:23:50 -0400
Received: from verein.lst.de ([213.95.11.211]:50105 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726008AbfIEQXt (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 5 Sep 2019 12:23:49 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 17F2468B05; Thu,  5 Sep 2019 18:23:44 +0200 (CEST)
Date:   Thu, 5 Sep 2019 18:23:44 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Goldwyn Rodrigues <rgoldwyn@suse.de>
Cc:     linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        darrick.wong@oracle.com, hch@lst.de, linux-xfs@vger.kernel.org,
        Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: Re: [PATCH 04/15] btrfs: Add a simple buffered iomap write
Message-ID: <20190905162344.GA22450@lst.de>
References: <20190905150650.21089-1-rgoldwyn@suse.de> <20190905150650.21089-5-rgoldwyn@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190905150650.21089-5-rgoldwyn@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> Most of the code is "inspired" by
> fs/btrfs/file.c. To keep the size small, all removals are in
> following patches.

Wouldn't it be better to massage the existing code into a form where you
can fairly easily switch over to iomap?  That is start refactoring the
code into helpers that are mostly reusable and then just have a patch
switching over.  That helps reviewing what actually changes.  It's
also what we did for XFS.


> +		if (!ordered) {
> +			break;
> +		}

No need for the braces.

> +static void btrfs_buffered_page_done(struct inode *inode, loff_t pos,
> +		unsigned copied, struct page *page,
> +		struct iomap *iomap)
> +{
> +	if (!page)
> +		return;
> +	SetPageUptodate(page);
> +	ClearPageChecked(page);
> +	set_page_dirty(page);
> +	get_page(page);
> +}

Thіs looks really strange.  Can you explain me why you need the
manual dirtying and SetPageUptodate, and an additional page refcount
here?

> +	if (ret < 0) {
> +		/*
> +		 * Space allocation failed. Let's check if we can
> +		 * continue I/O without allocations
> +		 */
> +		if ((BTRFS_I(inode)->flags & (BTRFS_INODE_NODATACOW |
> +						BTRFS_INODE_PREALLOC)) &&
> +				check_can_nocow(BTRFS_I(inode), pos,
> +					&write_bytes) > 0) {
> +			bi->nocow = true;
> +			/*
> +			 * our prealloc extent may be smaller than
> +			 * write_bytes, so scale down.
> +			 */
> +			bi->reserved_bytes = round_up(write_bytes +
> +					sector_offset,
> +					fs_info->sectorsize);
> +		} else {
> +			goto error;
> +		}

Maybe move the goto into the inverted if so you can reduce indentation
by one level?

> +		} else {
> +			u64 __pos = round_down(pos + written, fs_info->sectorsize);

Line over > 80 characters, and a somewhat odd variabke name.

> +	if (bi->nocow) {
> +		struct btrfs_root *root = BTRFS_I(inode)->root;
> +		btrfs_end_write_no_snapshotting(root);
> +		if (written > 0) {
> +			u64 start = round_down(pos, fs_info->sectorsize);
> +			u64 end = round_up(pos + written, fs_info->sectorsize) - 1;

Line > 80 chars.

> +			set_extent_bit(&BTRFS_I(inode)->io_tree, start, end,
> +					EXTENT_NORESERVE, NULL, NULL, GFP_NOFS);
> +		}
> +
> +	}
> +	btrfs_delalloc_release_extents(BTRFS_I(inode), bi->reserved_bytes,
> +			true);
> +
> +	if (written < fs_info->nodesize)
> +		btrfs_btree_balance_dirty(fs_info);
> +
> +	extent_changeset_free(bi->data_reserved);
> +	kfree(bi);
> +	return ret;
> +}

> +static const struct iomap_ops btrfs_buffered_iomap_ops = {
> +	.iomap_begin            = btrfs_buffered_iomap_begin,
> +	.iomap_end              = btrfs_buffered_iomap_end,
> +};
> +
> +size_t btrfs_buffered_iomap_write(struct kiocb *iocb, struct iov_iter *from)
> +{
> +	ssize_t written;
> +	struct inode *inode = file_inode(iocb->ki_filp);
> +	written = iomap_file_buffered_write(iocb, from, &btrfs_buffered_iomap_ops);

no empty line after the variable declarations?  Also this adds a > 80
character line.

> +	if (written > 0)
> +		iocb->ki_pos += written;

I wonder if we should fold the ki_pos update into
iomap_file_buffered_write.  But the patch looks fine even without that.

Also any reason to not name this function btrfs_buffered_write and
keep it in file.c with the rest of the write code?


