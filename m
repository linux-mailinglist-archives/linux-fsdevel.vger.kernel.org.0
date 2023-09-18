Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35EB77A456D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Sep 2023 11:04:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237157AbjIRJEG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 Sep 2023 05:04:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238768AbjIRJDn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 Sep 2023 05:03:43 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29407D1;
        Mon, 18 Sep 2023 02:03:35 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id C91D1219C3;
        Mon, 18 Sep 2023 09:03:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1695027813; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IC0SUrYAdgtUMCLwxcZUGJH7Iwy4fhSRwoJTp5TcPCo=;
        b=aoItDb6YbEgvE+Bx7FTmvVFbsBAva7Jv7lvPl9LLm38kfLzYnj2y8iU5rn6JkUS8JhlMGf
        H/KzZiJRCo6XT4NMHBkRyzhRYBsFth6q5wIQtg2025Pp3cNZsT7RsetzqsjfspQIfeMHWw
        T1gB3b4lGaOZVMRoV3BqkWZoEkTBbKA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1695027813;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IC0SUrYAdgtUMCLwxcZUGJH7Iwy4fhSRwoJTp5TcPCo=;
        b=fR9Hnrsr0PCeEFgrTwHaR3lHdc8qzvLQfDAi6kJOcXCapzUY+p1hD6mbKF6h9PtrMPbuNZ
        U4hK84gRWnxzRpDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BC5C913480;
        Mon, 18 Sep 2023 09:03:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id KGr0LWUSCGWxCgAAMHmgww
        (envelope-from <jack@suse.cz>); Mon, 18 Sep 2023 09:03:33 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 5B10FA0759; Mon, 18 Sep 2023 11:03:33 +0200 (CEST)
Date:   Mon, 18 Sep 2023 11:03:33 +0200
From:   Jan Kara <jack@suse.cz>
To:     Chunhai Guo <guochunhai@vivo.com>
Cc:     jack@suse.cz, brauner@kernel.org, viro@zeniv.linux.org.uk,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fs-writeback: do not requeue a clean inode having
 skipped pages
Message-ID: <20230918090333.ymwsnjt2d7wpghtu@quack3>
References: <20230916045131.957929-1-guochunhai@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230916045131.957929-1-guochunhai@vivo.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri 15-09-23 22:51:31, Chunhai Guo wrote:
> When writing back an inode and performing an fsync on it concurrently, a
> deadlock issue may arise as shown below. In each writeback iteration, a
> clean inode is requeued to the wb->b_dirty queue due to non-zero
> pages_skipped, without anything actually being written. This causes an
> infinite loop and prevents the plug from being flushed, resulting in a
> deadlock. We now avoid requeuing the clean inode to prevent this issue.
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

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
> index 969ce991b0b0..c1af01b2c42d 100644
> --- a/fs/fs-writeback.c
> +++ b/fs/fs-writeback.c
> @@ -1535,10 +1535,15 @@ static void requeue_inode(struct inode *inode, struct bdi_writeback *wb,
>  
>  	if (wbc->pages_skipped) {
>  		/*
> -		 * writeback is not making progress due to locked
> -		 * buffers. Skip this inode for now.
> +		 * Writeback is not making progress due to locked buffers.
> +		 * Skip this inode for now. Although having skipped pages
> +		 * is odd for clean inodes, it can happen for some
> +		 * filesystems so handle that gracefully.
>  		 */
> -		redirty_tail_locked(inode, wb);
> +		if (inode->i_state & I_DIRTY_ALL)
> +			redirty_tail_locked(inode, wb);
> +		else
> +			inode_cgwb_move_to_attached(inode, wb);
>  		return;
>  	}
>  
> -- 
> 2.25.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
