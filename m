Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E42C28A4B1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Aug 2019 19:34:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726674AbfHLReE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Aug 2019 13:34:04 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:58528 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726267AbfHLReE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Aug 2019 13:34:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=S7OxrYIMYsN/W+LCGLpx5eZGJ38yfnWGIGCyNhp6UUs=; b=siMt8ySyjx8VBRwG9UBLi9/9Q
        eIb2vh9FVKtsyto60QRv/soDWmLheyImHtVNWCTCsOAjn+g3q4wksfWYxRSHEfZ6WIwGnts20pFFb
        DleAN4say0ePpI4hO/xxlxbtaYjGav12UZcd4E7fnGV4db0tza9Om0sKNjOO1zpvig2fyWvQOT3k+
        osaWOz1a5c/p946nTJXF1+1Pf1L0pmNuM3Oy/56p6Crxtk4xdzfHsf9Z/5YCRc3NNPsHqinMtHhMd
        Sr+SV+CLdX3J9s2m4G1hvrr+3RhG32WogKbPYeECTD6lGCgrYTqNU9i/yEkGT8DJgu2WfQrtmEmJ8
        TjV45CCeA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hxECp-0000x8-Jr; Mon, 12 Aug 2019 17:34:03 +0000
Date:   Mon, 12 Aug 2019 10:34:03 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Matthew Bobrowski <mbobrowski@mbobrowski.org>
Cc:     linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        jack@suse.cz, tytso@mit.edu, riteshh@linux.ibm.com
Subject: Re: [PATCH 4/5] ext4: introduce direct IO write code path using
 iomap infrastructure
Message-ID: <20190812173403.GD24564@infradead.org>
References: <cover.1565609891.git.mbobrowski@mbobrowski.org>
 <581c3a2da89991e7ce5862d93dcfb23e1dc8ddc8.1565609891.git.mbobrowski@mbobrowski.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <581c3a2da89991e7ce5862d93dcfb23e1dc8ddc8.1565609891.git.mbobrowski@mbobrowski.org>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> +	if (error) {
> +		if (offset + size > i_size_read(inode))
> +			ext4_truncate_failed_write(inode);
> +
> +		/*
> +		 * The inode may have been placed onto the orphan list
> +		 * as a result of an extension. However, an error may
> +		 * have been encountered prior to being able to
> +		 * complete the write operation. Perform any necessary
> +		 * clean up in this case.
> +		 */
> +		if (!list_empty(&EXT4_I(inode)->i_orphan)) {
> +			handle = ext4_journal_start(inode, EXT4_HT_INODE, 2);
> +			if (IS_ERR(handle)) {
> +				if (inode->i_nlink)
> +					ext4_orphan_del(NULL, inode);
> +				return PTR_ERR(handle);
> +			}
> +
> +			if (inode->i_nlink)
> +				ext4_orphan_del(handle, inode);
> +			ext4_journal_stop(handle);
> +		}
> +		return error;

I'd split this branch into a separate function just to keep the
end_io handler tidy.

> +	if (ret == -EIOCBQUEUED && (unaligned_aio || extend))
> +		inode_dio_wait(inode);
> +
> +	if (ret >= 0 && iov_iter_count(from)) {
> +		overwrite ? inode_unlock_shared(inode) : inode_unlock(inode);
> +		return ext4_buffered_write_iter(iocb, from);
> +	}
> +out:
> +	overwrite ? inode_unlock_shared(inode) : inode_unlock(inode);
> +	return ret;

the ? : expression here is weird.

I'd write this as:

	if (overwrite)
		inode_unlock_shared(inode);
	else
		inode_unlock(inode);

	if (ret >= 0 && iov_iter_count(from))
		return ext4_buffered_write_iter(iocb, from);
	return ret;

and handle the only place we jump to the current out label manually,
as that always does an exclusive unlock anyway.

> +		if (IS_DAX(inode)) {
> +			ret = ext4_map_blocks(handle, inode, &map,
> +					      EXT4_GET_BLOCKS_CREATE_ZERO);
> +		} else {
> +			/*
> +			 * DAX and direct IO are the only two
> +			 * operations currently supported with
> +			 * IOMAP_WRITE.
> +			 */
> +			WARN_ON(!(flags & IOMAP_DIRECT));
> +			if (round_down(offset, i_blocksize(inode)) >=
> +			    i_size_read(inode)) {
> +				ret = ext4_map_blocks(handle, inode, &map,
> +						      EXT4_GET_BLOCKS_CREATE);
> +			} else if (!ext4_test_inode_flag(inode,
> +							 EXT4_INODE_EXTENTS)) {
> +				/*
> +				 * We cannot fill holes in indirect
> +				 * tree based inodes as that could
> +				 * expose stale data in the case of a
> +				 * crash. Use magic error code to
> +				 * fallback to buffered IO.
> +				 */
> +				ret = ext4_map_blocks(handle, inode, &map, 0);
> +				if (ret == 0)
> +					ret = -ENOTBLK;
> +			} else {
> +				ret = ext4_map_blocks(handle, inode, &map,
> +						      EXT4_GET_BLOCKS_IO_CREATE_EXT);
> +			}
> +		}

I think this could be simplified down to something like:

		int flags = 0;

		...

		/*
		 * DAX and direct IO are the only two operations currently
		 * supported with IOMAP_WRITE.
		 */
		WARN_ON(!IS_DAX(inode) && !(flags & IOMAP_DIRECT));

		if (IS_DAX(inode))
			flags = EXT4_GET_BLOCKS_CREATE_ZERO;
		else if (round_down(offset, i_blocksize(inode)) >=
				i_size_read(inode)) {
			flags = EXT4_GET_BLOCKS_CREATE;
		else if (ext4_test_inode_flag(inode, EXT4_INODE_EXTENTS))
			flags = EXT4_GET_BLOCKS_IO_CREATE_EXT;

		/*
		 * We cannot fill holes in indirect tree based inodes as that
		 * could expose stale data in the case of a crash.  Use the
		 * magic error code to fallback to buffered IO.
		 */
		if (!flags && !ret)
			ret = -ENOTBLK;


> @@ -3601,6 +3631,8 @@ static int ext4_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
>  static int ext4_iomap_end(struct inode *inode, loff_t offset, loff_t length,
>  			  ssize_t written, unsigned flags, struct iomap *iomap)
>  {
> +	if (flags & IOMAP_DIRECT && written == 0)
> +		return -ENOTBLK;

This probably wants a comment, too.  But do we actually ever end up
here?
