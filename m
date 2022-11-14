Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D825B628B4B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Nov 2022 22:25:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236919AbiKNVZf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Nov 2022 16:25:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236505AbiKNVZe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Nov 2022 16:25:34 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A50BE18B37;
        Mon, 14 Nov 2022 13:25:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=SLrGqAA2/wVAICCZp3ez3qec5hzvLwGpIffVQ+e9GvE=; b=o1doCigl7enF/EvIvsZR0Fblwc
        p88/Tm9Si95Nm6IXD9LX1avKbBNz2rkXLLYbtDk7eFD6/GZ8fAPTwJtIdsOOpEgxo0FR537zDvEQ/
        KPEwaTLehyNogpwFiW509IkGyE+eBALhqC96szeBTYGbGm82MfJyZIo4sWxRHlc0YT+13cEGdv5a/
        hG1KD0a5C19im0b6JfjBQrSqMNnrKcoExKWM3j3dLcccUkq1StFe9bkMEehUMB+G1vuaQiEUsYw1Q
        358mFOhjDn4llzBAa7bPGWFtnVAO9TeTZgKqiS/2ysGmI5GouXjfzPwfSPeqOX44kp2PAny9STWj5
        9wCoHRYg==;
Received: from [2601:1c2:d80:3110::a2e7]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ougxG-0056Lt-OY; Mon, 14 Nov 2022 21:25:22 +0000
Message-ID: <fd7ebc60-811e-588a-5c55-ee540796f058@infradead.org>
Date:   Mon, 14 Nov 2022 13:25:22 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v2] fs: do not update freeing inode io_list
Content-Language: en-US
To:     Svyatoslav Feldsherov <feldsherov@google.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Lukas Czerner <lczerner@redhat.com>,
        Theodore Ts'o <tytso@mit.edu>, Jan Kara <jack@suse.cz>
Cc:     syzbot+6ba92bd00d5093f7e371@syzkaller.appspotmail.com,
        oferz@google.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221114192129.zkmubc6pmruuzkc7@quack3>
 <20221114212155.221829-1-feldsherov@google.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20221114212155.221829-1-feldsherov@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi--

Please see a small nit below.

On 11/14/22 13:21, Svyatoslav Feldsherov wrote:
> After commit cbfecb927f42 ("fs: record I_DIRTY_TIME even if inode
> already has I_DIRTY_INODE") writeiback_single_inode can push inode with
> I_DIRTY_TIME set to b_dirty_time list. In case of freeing inode with
> I_DIRTY_TIME set this can happened after deletion of inode io_list at
> evict. Stack trace is following.
> 
> evict
> fat_evict_inode
> fat_truncate_blocks
> fat_flush_inodes
> writeback_inode
> sync_inode_metadata(inode, sync=0)
> writeback_single_inode(inode, wbc) <- wbc->sync_mode == WB_SYNC_NONE
> 
> This will lead to use after free in flusher thread.
> 
> Similar issue can be triggered if writeback_single_inode in the
> stack trace update inode->io_list. Add explicit check to avoid it.
> 
> Fixes: cbfecb927f42 ("fs: record I_DIRTY_TIME even if inode already has I_DIRTY_INODE")
> Reported-by: syzbot+6ba92bd00d5093f7e371@syzkaller.appspotmail.com
> Signed-off-by: Svyatoslav Feldsherov <feldsherov@google.com>
> ---
>  V1 -> V2: 
>  - address review comments
>  - skip inode_cgwb_move_to_attached for freeing inode 
> 
>  fs/fs-writeback.c | 30 +++++++++++++++++++-----------
>  1 file changed, 19 insertions(+), 11 deletions(-)
> 
> diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
> index 443f83382b9b..c4aea096689c 100644
> --- a/fs/fs-writeback.c
> +++ b/fs/fs-writeback.c
> @@ -1712,18 +1712,26 @@ static int writeback_single_inode(struct inode *inode,
>  	wb = inode_to_wb_and_lock_list(inode);
>  	spin_lock(&inode->i_lock);
>  	/*
> -	 * If the inode is now fully clean, then it can be safely removed from
> -	 * its writeback list (if any).  Otherwise the flusher threads are
> -	 * responsible for the writeback lists.
> +	 * If the inode is freeing, it's io_list shoudn't be updated

	                            its

> +	 * as it can be finally deleted at this moment.
>  	 */
> -	if (!(inode->i_state & I_DIRTY_ALL))
> -		inode_cgwb_move_to_attached(inode, wb);
> -	else if (!(inode->i_state & I_SYNC_QUEUED)) {
> -		if ((inode->i_state & I_DIRTY))
> -			redirty_tail_locked(inode, wb);
> -		else if (inode->i_state & I_DIRTY_TIME) {
> -			inode->dirtied_when = jiffies;
> -			inode_io_list_move_locked(inode, wb, &wb->b_dirty_time);
> +	if (!(inode->i_state & I_FREEING)) {
> +		/*
> +		 * If the inode is now fully clean, then it can be safely
> +		 * removed from its writeback list (if any). Otherwise the
> +		 * flusher threads are responsible for the writeback lists.
> +		 */
> +		if (!(inode->i_state & I_DIRTY_ALL))
> +			inode_cgwb_move_to_attached(inode, wb);
> +		else if (!(inode->i_state & I_SYNC_QUEUED)) {
> +			if ((inode->i_state & I_DIRTY))
> +				redirty_tail_locked(inode, wb);
> +			else if (inode->i_state & I_DIRTY_TIME) {
> +				inode->dirtied_when = jiffies;
> +				inode_io_list_move_locked(inode,
> +							  wb,
> +							  &wb->b_dirty_time);
> +			}
>  		}
>  	}
>  

-- 
~Randy
