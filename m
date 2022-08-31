Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E5165A7C2C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Aug 2022 13:30:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230055AbiHaLaf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 31 Aug 2022 07:30:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbiHaLac (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 31 Aug 2022 07:30:32 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C59363FA09;
        Wed, 31 Aug 2022 04:30:31 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 6107A1F893;
        Wed, 31 Aug 2022 11:30:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1661945430; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5+rM2lTGNhrVO3gYxx12OLcCQeOaRRJa6UF4G+0StiQ=;
        b=04NEVHOFZri3hSNR2yS12QiAErrSKNGIA9ZWdZEGs7Sp+GMmDn3CLx//O24C3oq981u6BH
        XDSCXEG74YLC5kEtzFaJFMBtKHxaqs0vEc78hI/jUKXmgDZ81L366ack9Fuvy16u71GpbM
        05IOIyiOJ5FmVAb/ja2cMNkbFFCVmX8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1661945430;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5+rM2lTGNhrVO3gYxx12OLcCQeOaRRJa6UF4G+0StiQ=;
        b=Mz8bJYjnB3rmMLQHxxFP16ARjDoHDeBdyNwNgZJmdcnaQ3TpHNikSo7lV0y8w8pCUFOqIz
        Iqau2cagQXoKGJCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 08A861332D;
        Wed, 31 Aug 2022 11:30:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id L8viAVZGD2PhfgAAMHmgww
        (envelope-from <jack@suse.cz>); Wed, 31 Aug 2022 11:30:30 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 54102A067B; Wed, 31 Aug 2022 13:30:29 +0200 (CEST)
Date:   Wed, 31 Aug 2022 13:30:29 +0200
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
Subject: Re: [PATCH 02/14] fs/buffer: add some new buffer read helpers
Message-ID: <20220831113029.fsywbjzk4qw24qdc@quack3>
References: <20220831072111.3569680-1-yi.zhang@huawei.com>
 <20220831072111.3569680-3-yi.zhang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220831072111.3569680-3-yi.zhang@huawei.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 31-08-22 15:20:59, Zhang Yi wrote:
> Current ll_rw_block() helper is fragile because it assumes that locked
> buffer means it's under IO which is submitted by some other who hold
> the lock, it skip buffer if it failed to get the lock, so it's only
> safe on the readahead path. Unfortunately, now that most filesystems
> still use this helper mistakenly on the sync metadata read path. There
> is no guarantee that the one who hold the buffer lock always submit IO
> (e.g. buffer_migrate_folio_norefs() after commit 88dbcbb3a484 ("blkdev:
> avoid migration stalls for blkdev pages"), it could lead to false
> positive -EIO when submitting reading IO.
> 
> This patch add some friendly buffer read helpers to prepare replace
> ll_rw_block() and similar calls. We can only call bh_readahead_[]
> helpers for the readahead paths.
> 
> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>

This looks mostly good. Just a few small nits below.

> diff --git a/fs/buffer.c b/fs/buffer.c
> index a0b70b3239f3..a663191903ed 100644
> --- a/fs/buffer.c
> +++ b/fs/buffer.c
> @@ -3017,6 +3017,74 @@ int bh_uptodate_or_lock(struct buffer_head *bh)
>  }
>  EXPORT_SYMBOL(bh_uptodate_or_lock);
>  
> +/**
> + * __bh_read - Submit read for a locked buffer
> + * @bh: struct buffer_head
> + * @op_flags: appending REQ_OP_* flags besides REQ_OP_READ
> + * @wait: wait until reading finish
> + *
> + * Returns zero on success or don't wait, and -EIO on error.
> + */
> +int __bh_read(struct buffer_head *bh, blk_opf_t op_flags, bool wait)
> +{
> +	int ret = 0;
> +
> +	BUG_ON(!buffer_locked(bh));
> +
> +	if (buffer_uptodate(bh)) {
> +		unlock_buffer(bh);
> +		return ret;
> +	}
> +
> +	get_bh(bh);
> +	bh->b_end_io = end_buffer_read_sync;
> +	submit_bh(REQ_OP_READ | op_flags, bh);
> +	if (wait) {
> +		wait_on_buffer(bh);
> +		if (!buffer_uptodate(bh))
> +			ret = -EIO;
> +	}
> +	return ret;
> +}
> +EXPORT_SYMBOL(__bh_read);
> +
> +/**
> + * __bh_read_batch - Submit read for a batch of unlocked buffers
> + * @bhs: a batch of struct buffer_head
> + * @nr: number of this batch
> + * @op_flags: appending REQ_OP_* flags besides REQ_OP_READ
> + * @force_lock: force to get a lock on the buffer if set, otherwise drops any
> + *              buffer that cannot lock.
> + *
> + * Returns zero on success or don't wait, and -EIO on error.
> + */
> +void __bh_read_batch(struct buffer_head *bhs[],
> +		     int nr, blk_opf_t op_flags, bool force_lock)
> +{
> +	int i;
> +
> +	for (i = 0; i < nr; i++) {
> +		struct buffer_head *bh = bhs[i];
> +
> +		if (buffer_uptodate(bh))
> +			continue;
> +		if (!trylock_buffer(bh)) {
> +			if (!force_lock)
> +				continue;
> +			lock_buffer(bh);
> +		}

This would be a bit more efficient for the force_lock case like:

		if (force_lock)
			lock_buffer(bh);
		else
			if (!trylock_buffer(bh))
				continue;

> +		if (buffer_uptodate(bh)) {
> +			unlock_buffer(bh);
> +			continue;
> +		}
> +
> +		bh->b_end_io = end_buffer_read_sync;
> +		get_bh(bh);
> +		submit_bh(REQ_OP_READ | op_flags, bh);
> +	}
> +}
> +EXPORT_SYMBOL(__bh_read_batch);
> +
>  /**
>   * bh_submit_read - Submit a locked buffer for reading
>   * @bh: struct buffer_head
> diff --git a/include/linux/buffer_head.h b/include/linux/buffer_head.h
> index c3863c417b00..8a01c07c0418 100644
> --- a/include/linux/buffer_head.h
> +++ b/include/linux/buffer_head.h
> @@ -232,6 +232,9 @@ void write_boundary_block(struct block_device *bdev,
>  			sector_t bblock, unsigned blocksize);
>  int bh_uptodate_or_lock(struct buffer_head *bh);
>  int bh_submit_read(struct buffer_head *bh);
> +int __bh_read(struct buffer_head *bh, blk_opf_t op_flags, bool wait);
> +void __bh_read_batch(struct buffer_head *bhs[],
> +		     int nr, blk_opf_t op_flags, bool force_lock);
>  
>  extern int buffer_heads_over_limit;
>  
> @@ -399,6 +402,40 @@ static inline struct buffer_head *__getblk(struct block_device *bdev,
>  	return __getblk_gfp(bdev, block, size, __GFP_MOVABLE);
>  }
>  
> +static inline void bh_readahead(struct buffer_head *bh, blk_opf_t op_flags)
> +{
> +	if (trylock_buffer(bh))
> +		__bh_read(bh, op_flags, false);
> +}
> +
> +static inline void bh_read_nowait(struct buffer_head *bh, blk_opf_t op_flags)
> +{
> +	lock_buffer(bh);
> +	__bh_read(bh, op_flags, false);
> +}
> +
> +static inline int bh_read(struct buffer_head *bh, blk_opf_t op_flags)
> +{
> +	lock_buffer(bh);
> +	return __bh_read(bh, op_flags, true);
> +}

I would use bh_uptodate_or_lock() helper in the above two functions to
avoid locking the buffer in case it is already uptodate.

> +
> +static inline int bh_read_locked(struct buffer_head *bh, blk_opf_t op_flags)
> +{
> +	return __bh_read(bh, op_flags, true);
> +}

I would just drop this helper. Both ext2 and ocfs2 which use it can avoid
it very easily (by using bh_read()). 

> +
> +static inline void bh_read_batch(struct buffer_head *bhs[], int nr)
> +{
> +	__bh_read_batch(bhs, nr, 0, true);
> +}
> +
> +static inline void bh_readahead_batch(struct buffer_head *bhs[], int nr,
> +				      blk_opf_t op_flags)
> +{
> +	__bh_read_batch(bhs, nr, op_flags, false);
> +}
> +

It is more common to have number of elements in the array as the first
argument and the array as the second one in the kernel. So rather:

static inline void bh_read_batch(int nr, struct buffer_head *bhs[])

and similarly for bh_readahead_batch().

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
