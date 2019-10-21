Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 819F0DF2CE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Oct 2019 18:19:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729867AbfJUQSw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Oct 2019 12:18:52 -0400
Received: from mx2.suse.de ([195.135.220.15]:39986 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728521AbfJUQSw (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Oct 2019 12:18:52 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 65BC2AC48;
        Mon, 21 Oct 2019 16:18:49 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 93DD61E4AA2; Mon, 21 Oct 2019 18:18:48 +0200 (CEST)
Date:   Mon, 21 Oct 2019 18:18:48 +0200
From:   Jan Kara <jack@suse.cz>
To:     Matthew Bobrowski <mbobrowski@mbobrowski.org>
Cc:     tytso@mit.edu, jack@suse.cz, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        hch@infradead.org, david@fromorbit.com, darrick.wong@oracle.com
Subject: Re: [PATCH v5 12/12] ext4: introduce direct I/O write using iomap
 infrastructure
Message-ID: <20191021161848.GI25184@quack2.suse.cz>
References: <cover.1571647178.git.mbobrowski@mbobrowski.org>
 <c3438dad66a34a7d4e7509a5dd64c2326340a52a.1571647180.git.mbobrowski@mbobrowski.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c3438dad66a34a7d4e7509a5dd64c2326340a52a.1571647180.git.mbobrowski@mbobrowski.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon 21-10-19 20:20:20, Matthew Bobrowski wrote:
> This patch introduces a new direct I/O write path which makes use of
> the iomap infrastructure.
> 
> All direct I/O writes are now passed from the ->write_iter() callback
> through to the new direct I/O handler ext4_dio_write_iter(). This
> function is responsible for calling into the iomap infrastructure via
> iomap_dio_rw().
> 
> Code snippets from the existing direct I/O write code within
> ext4_file_write_iter() such as, checking whether the I/O request is
> unaligned asynchronous I/O, or whether the write will result in an
> overwrite have effectively been moved out and into the new direct I/O
> ->write_iter() handler.
> 
> The block mapping flags that are eventually passed down to
> ext4_map_blocks() from the *_get_block_*() suite of routines have been
> taken out and introduced within ext4_iomap_alloc().
> 
> For inode extension cases, ext4_handle_inode_extension() is
> effectively the function responsible for performing such metadata
> updates. This is called after iomap_dio_rw() has returned so that we
> can safely determine whether we need to potentially truncate any
> allocated blocks that may have been prepared for this direct I/O
> write. We don't perform the inode extension, or truncate operations
> from the ->end_io() handler as we don't have the original I/O 'length'
> available there. The ->end_io() however is responsible fo converting
> allocated unwritten extents to written extents.
> 
> In the instance of a short write, we fallback and complete the
> remainder of the I/O using buffered I/O via
> ext4_buffered_write_iter().
> 
> The existing buffer_head direct I/O implementation has been removed as
> it's now redundant.
> 
> Signed-off-by: Matthew Bobrowski <mbobrowski@mbobrowski.org>
> ---
>  fs/ext4/ext4.h    |   3 -
>  fs/ext4/extents.c |   4 +-
>  fs/ext4/file.c    | 236 ++++++++++++++++++--------
>  fs/ext4/inode.c   | 411 +++++-----------------------------------------
>  4 files changed, 207 insertions(+), 447 deletions(-)

The patch looks good to me! You can add:

Reviewed-by: Jan Kara <jack@suse.cz>

One nitpick below:

> +	if (extend) {
> +		ret = ext4_handle_inode_extension(inode, ret, offset, count);
> +
> +		/*
> +		 * We may have failed to remove the inode from the orphan list
> +		 * in the case that the i_disksize got update due to delalloc
> +		 * writeback while the direct I/O was running. We need to make
> +		 * sure we remove it from the orphan list as if we've
> +		 * prematurely popped it onto the list.
> +		 */
> +		if (!list_empty(&EXT4_I(inode)->i_orphan)) {
> +			handle = ext4_journal_start(inode, EXT4_HT_INODE, 2);
> +			if (IS_ERR(handle)) {
> +				ret = PTR_ERR(handle);
> +				if (inode->i_nlink)
> +					ext4_orphan_del(NULL, inode);
> +				goto out;
> +			}
> +
> +			if (inode->i_nlink)

This check can be joined with the list_empty() check above to save us from
unnecessarily starting a transaction. Also I was wondering whether it would
not make more sense have this orphan handling bit also in
ext4_handle_inode_extension(). ext4_dax_write_iter() doesn't strictly
need it (as for DAX i_disksize cannot currently change while
ext4_dax_write_iter() is running) but it would look more robust to me for
the future users and it certainly doesn't hurt ext4_dax_write_iter() case.

> +				ext4_orphan_del(handle, inode);
> +			ext4_journal_stop(handle);
> +		}
> +	}

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
