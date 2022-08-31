Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C9A05A7BEB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Aug 2022 13:06:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229950AbiHaLGt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 31 Aug 2022 07:06:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbiHaLGr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 31 Aug 2022 07:06:47 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C9F2A2206;
        Wed, 31 Aug 2022 04:06:46 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 218171F924;
        Wed, 31 Aug 2022 11:06:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1661944005; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fC4OsrDuMtbzIR8fy3GPw0L2C+sIfBr0jgJX1os99Vs=;
        b=Qvi5DTM5JTCd/NhhRucaM9fjv9H1gMQRnFZifm0fcH5/Xd2AD+glMerR3xN6Af1vymjs37
        McgUNgIZiP+PbSEmML7vWDdbzNqyTVabCvNvXGd3CgQEeYsemdMnmFdvijhoaaI5ly/N5z
        TTHLyoO0zjGfiiY/k+Y//YDI9sNI5Qg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1661944005;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fC4OsrDuMtbzIR8fy3GPw0L2C+sIfBr0jgJX1os99Vs=;
        b=Jb/2ggDXSejJB0kon6Yb0PMewboZVPK+kdjnLZyvZfHqaRQZxPMdVhN7IbMNRN5bpPnSk3
        EFf+NCtBc1SHbeAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0B77913A7C;
        Wed, 31 Aug 2022 11:06:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 3h/IAsVAD2NudAAAMHmgww
        (envelope-from <jack@suse.cz>); Wed, 31 Aug 2022 11:06:45 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id A1524A067B; Wed, 31 Aug 2022 13:06:44 +0200 (CEST)
Date:   Wed, 31 Aug 2022 13:06:44 +0200
From:   Jan Kara <jack@suse.cz>
To:     Zhang Yi <yi.zhang@huawei.com>
Cc:     linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, cluster-devel@redhat.com,
        ntfs3@lists.linux.dev, ocfs2-devel@oss.oracle.com,
        reiserfs-devel@vger.kernel.org, jack@suse.cz, tytso@mit.edu,
        akpm@linux-foundation.org, axboe@kernel.dk,
        viro@zeniv.linux.org.uk, rpeterso@redhat.com, agruenba@redhat.com,
        almaz.alexandrovich@paragon-software.com, mark@fasheh.com,
        dushistov@mail.ru, hch@infradead.org, chengzhihao1@huawei.com,
        yukuai3@huawei.com
Subject: Re: [PATCH 12/14] fs/buffer: remove ll_rw_block() helper
Message-ID: <20220831110644.id62rsymhziex2ch@quack3>
References: <20220831072111.3569680-1-yi.zhang@huawei.com>
 <20220831072111.3569680-13-yi.zhang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220831072111.3569680-13-yi.zhang@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 31-08-22 15:21:09, Zhang Yi wrote:
> Now that all ll_rw_block() users has been replaced to new safe helpers,
> we just remove it here.
> 
> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/buffer.c                 | 63 +++----------------------------------
>  include/linux/buffer_head.h |  1 -
>  2 files changed, 4 insertions(+), 60 deletions(-)
> 
> diff --git a/fs/buffer.c b/fs/buffer.c
> index e14adc638bfe..d1d09e2dacc2 100644
> --- a/fs/buffer.c
> +++ b/fs/buffer.c
> @@ -152,7 +152,7 @@ static void __end_buffer_read_notouch(struct buffer_head *bh, int uptodate)
>  
>  /*
>   * Default synchronous end-of-IO handler..  Just mark it up-to-date and
> - * unlock the buffer. This is what ll_rw_block uses too.
> + * unlock the buffer.
>   */
>  void end_buffer_read_sync(struct buffer_head *bh, int uptodate)
>  {
> @@ -491,8 +491,8 @@ int inode_has_buffers(struct inode *inode)
>   * all already-submitted IO to complete, but does not queue any new
>   * writes to the disk.
>   *
> - * To do O_SYNC writes, just queue the buffer writes with ll_rw_block as
> - * you dirty the buffers, and then use osync_inode_buffers to wait for
> + * To do O_SYNC writes, just queue the buffer writes with write_dirty_buffer
> + * as you dirty the buffers, and then use osync_inode_buffers to wait for
>   * completion.  Any other dirty buffers which are not yet queued for
>   * write will not be flushed to disk by the osync.
>   */
> @@ -1807,7 +1807,7 @@ int __block_write_full_page(struct inode *inode, struct page *page,
>  		/*
>  		 * The page was marked dirty, but the buffers were
>  		 * clean.  Someone wrote them back by hand with
> -		 * ll_rw_block/submit_bh.  A rare case.
> +		 * write_dirty_buffer/submit_bh.  A rare case.
>  		 */
>  		end_page_writeback(page);
>  
> @@ -2714,61 +2714,6 @@ int submit_bh(blk_opf_t opf, struct buffer_head *bh)
>  }
>  EXPORT_SYMBOL(submit_bh);
>  
> -/**
> - * ll_rw_block: low-level access to block devices (DEPRECATED)
> - * @opf: block layer request operation and flags.
> - * @nr: number of &struct buffer_heads in the array
> - * @bhs: array of pointers to &struct buffer_head
> - *
> - * ll_rw_block() takes an array of pointers to &struct buffer_heads, and
> - * requests an I/O operation on them, either a %REQ_OP_READ or a %REQ_OP_WRITE.
> - * @opf contains flags modifying the detailed I/O behavior, most notably
> - * %REQ_RAHEAD.
> - *
> - * This function drops any buffer that it cannot get a lock on (with the
> - * BH_Lock state bit), any buffer that appears to be clean when doing a write
> - * request, and any buffer that appears to be up-to-date when doing read
> - * request.  Further it marks as clean buffers that are processed for
> - * writing (the buffer cache won't assume that they are actually clean
> - * until the buffer gets unlocked).
> - *
> - * ll_rw_block sets b_end_io to simple completion handler that marks
> - * the buffer up-to-date (if appropriate), unlocks the buffer and wakes
> - * any waiters. 
> - *
> - * All of the buffers must be for the same device, and must also be a
> - * multiple of the current approved size for the device.
> - */
> -void ll_rw_block(const blk_opf_t opf, int nr, struct buffer_head *bhs[])
> -{
> -	const enum req_op op = opf & REQ_OP_MASK;
> -	int i;
> -
> -	for (i = 0; i < nr; i++) {
> -		struct buffer_head *bh = bhs[i];
> -
> -		if (!trylock_buffer(bh))
> -			continue;
> -		if (op == REQ_OP_WRITE) {
> -			if (test_clear_buffer_dirty(bh)) {
> -				bh->b_end_io = end_buffer_write_sync;
> -				get_bh(bh);
> -				submit_bh(opf, bh);
> -				continue;
> -			}
> -		} else {
> -			if (!buffer_uptodate(bh)) {
> -				bh->b_end_io = end_buffer_read_sync;
> -				get_bh(bh);
> -				submit_bh(opf, bh);
> -				continue;
> -			}
> -		}
> -		unlock_buffer(bh);
> -	}
> -}
> -EXPORT_SYMBOL(ll_rw_block);
> -
>  void write_dirty_buffer(struct buffer_head *bh, blk_opf_t op_flags)
>  {
>  	lock_buffer(bh);
> diff --git a/include/linux/buffer_head.h b/include/linux/buffer_head.h
> index 8a01c07c0418..1c93ff8c8f51 100644
> --- a/include/linux/buffer_head.h
> +++ b/include/linux/buffer_head.h
> @@ -223,7 +223,6 @@ struct buffer_head *alloc_buffer_head(gfp_t gfp_flags);
>  void free_buffer_head(struct buffer_head * bh);
>  void unlock_buffer(struct buffer_head *bh);
>  void __lock_buffer(struct buffer_head *bh);
> -void ll_rw_block(blk_opf_t, int, struct buffer_head * bh[]);
>  int sync_dirty_buffer(struct buffer_head *bh);
>  int __sync_dirty_buffer(struct buffer_head *bh, blk_opf_t op_flags);
>  void write_dirty_buffer(struct buffer_head *bh, blk_opf_t op_flags);
> -- 
> 2.31.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
