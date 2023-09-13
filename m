Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBF5079E265
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Sep 2023 10:42:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239039AbjIMImc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 Sep 2023 04:42:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239018AbjIMIma (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 Sep 2023 04:42:30 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D89A1199F;
        Wed, 13 Sep 2023 01:42:26 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCC5DC433C7;
        Wed, 13 Sep 2023 08:42:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694594546;
        bh=W+VUSozvNXeGpFMvMp4FfznnkGX7JB/VmlgBW0qQOqk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nZlNAPdNm06tIDx0KabaxN+MPiCm8if7HJhr/hlkFyg2hkx37e3IKEFI5qFTcp+3Q
         hJBy/+sJcEVU/ggVjRTovtV+aIJKzfibN21RQ2rt4XOp27OwmvKjiJ8plTndMV3pMS
         xXHo/ENipz8NW+ToAjj87pxJrSvqm1dJSZCr3EXHWXUobkr+v6qUf93lRpkVHasQGF
         OIRXwkpAp5xhQxk9f7q828uwSewVpGbZ4Aksz0WzWGnct7ISPETTR7agV/pIghPMye
         g6vIMeLOcbDd8+U7dHNz8UdOqRb6h4+ziuWHKU8FroSXFGgtb+/FJbd9vzuOFw1Mc4
         eqVZg3nAQa1jg==
Date:   Wed, 13 Sep 2023 10:42:21 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Chunhai Guo <guochunhai@vivo.com>
Cc:     viro@zeniv.linux.org.uk, chao@kernel.org, jaegeuk@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jan Kara <jack@suse.cz>
Subject: Re: [PATCH] fs-writeback: writeback_sb_inodes: Do not increase
 'total_wrote' when nothing is written
Message-ID: <20230913-spionieren-goldschatz-3d15c1ce2743@brauner>
References: <20230912142043.283495-1-guochunhai@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230912142043.283495-1-guochunhai@vivo.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

[+Cc Jan]

On Tue, Sep 12, 2023 at 08:20:43AM -0600, Chunhai Guo wrote:
> I am encountering a deadlock issue as shown below. There is a commit
> 344150999b7f ("f2fs: fix to avoid potential deadlock") can fix this issue.
> However, from log analysis, it appears that this is more likely a fake
> progress issue similar to commit 68f4c6eba70d ("fs-writeback:
> writeback_sb_inodes: Recalculate 'wrote' according skipped pages"). In each
> writeback iteration, nothing is written, while writeback_sb_inodes()
> increases 'total_wrote' each time, causing an infinite loop. This patch
> fixes this issue by not increasing 'total_wrote' when nothing is written.
> 
>     wb_writeback        fsync (inode-Y)
> blk_start_plug(&plug)
> for (;;) {
>   iter i-1: some reqs with page-X added into plug->mq_list // f2fs node page-X with PG_writeback
>                         filemap_fdatawrite
>                           __filemap_fdatawrite_range // write inode-Y with sync_mode WB_SYNC_ALL
>                            do_writepages
>                             f2fs_write_data_pages
>                              __f2fs_write_data_pages // wb_sync_req[DATA]++ for WB_SYNC_ALL
>                               f2fs_write_cache_pages
>                                f2fs_write_single_data_page
>                                 f2fs_do_write_data_page
>                                  f2fs_outplace_write_data
>                                   f2fs_update_data_blkaddr
>                                    f2fs_wait_on_page_writeback
>                                      wait_on_page_writeback // wait for f2fs node page-X
>   iter i:
>     progress = __writeback_inodes_wb(wb, work)
>     . writeback_sb_inodes
>     .   __writeback_single_inode // write inode-Y with sync_mode WB_SYNC_NONE
>     .   . do_writepages
>     .   .   f2fs_write_data_pages
>     .   .   .  __f2fs_write_data_pages // skip writepages due to (wb_sync_req[DATA]>0)
>     .   .   .   wbc->pages_skipped += get_dirty_pages(inode) // wbc->pages_skipped = 1
>     .   if (!(inode->i_state & I_DIRTY_ALL)) // i_state = I_SYNC | I_SYNC_QUEUED
>     .    total_wrote++;  // total_wrote = 1
>     .   requeue_inode // requeue inode-Y to wb->b_dirty queue due to non-zero pages_skipped
>     if (progress) // progress = 1
>       continue;
>   iter i+1:
>       queue_io
>       // similar process with iter i, infinite for-loop !
> }
> blk_finish_plug(&plug)   // flush plug won't be called
> 
> Signed-off-by: Chunhai Guo <guochunhai@vivo.com>
> ---
>  fs/fs-writeback.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
> index 969ce991b0b0..54cdee906be9 100644
> --- a/fs/fs-writeback.c
> +++ b/fs/fs-writeback.c
> @@ -1820,6 +1820,7 @@ static long writeback_sb_inodes(struct super_block *sb,
>  		struct inode *inode = wb_inode(wb->b_io.prev);
>  		struct bdi_writeback *tmp_wb;
>  		long wrote;
> +		bool is_dirty_before;
>  
>  		if (inode->i_sb != sb) {
>  			if (work->sb) {
> @@ -1881,6 +1882,7 @@ static long writeback_sb_inodes(struct super_block *sb,
>  			continue;
>  		}
>  		inode->i_state |= I_SYNC;
> +		is_dirty_before = inode->i_state & I_DIRTY_ALL;
>  		wbc_attach_and_unlock_inode(&wbc, inode);
>  
>  		write_chunk = writeback_chunk_size(wb, work);
> @@ -1918,7 +1920,7 @@ static long writeback_sb_inodes(struct super_block *sb,
>  		 */
>  		tmp_wb = inode_to_wb_and_lock_list(inode);
>  		spin_lock(&inode->i_lock);
> -		if (!(inode->i_state & I_DIRTY_ALL))
> +		if (!(inode->i_state & I_DIRTY_ALL) && is_dirty_before)
>  			total_wrote++;
>  		requeue_inode(inode, tmp_wb, &wbc);
>  		inode_sync_complete(inode);
> -- 
> 2.25.1
> 
