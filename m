Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D7C05A7B7A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Aug 2022 12:39:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229804AbiHaKjP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 31 Aug 2022 06:39:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbiHaKjO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 31 Aug 2022 06:39:14 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E94E1B6029;
        Wed, 31 Aug 2022 03:39:13 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 80EC221A53;
        Wed, 31 Aug 2022 10:39:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1661942352; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=D/VhxrZABrIw51+gKZ04o+QPEhbTuW7VzunFJgXY7yw=;
        b=a2l6ug+zy4ZO2ZBVuqwRZaCOsD/JBDgWm4vBtnS2p4VqXzNejQqdVXaA/ST/D8KXLkez6H
        QOwXmD2rKYG9+RchfM74zflc74h5E6tozat9dxBD/V6GGio2IrhB4UuYlHiBQA8GuKpc6B
        IX9BBGsSV8qYc3kxPvDVJkw1V7ApYT4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1661942352;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=D/VhxrZABrIw51+gKZ04o+QPEhbTuW7VzunFJgXY7yw=;
        b=DvvoP4FgqltN7TSp0W4JepFamZL4CCI+xGGNoE56kVvT+VDjiBB8cQOdGEfQEqyIWhezcr
        evs/qv/17UFQOJAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6549613A7C;
        Wed, 31 Aug 2022 10:39:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id aB+rGFA6D2M7aAAAMHmgww
        (envelope-from <jack@suse.cz>); Wed, 31 Aug 2022 10:39:12 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id E49DCA067B; Wed, 31 Aug 2022 12:39:11 +0200 (CEST)
Date:   Wed, 31 Aug 2022 12:39:11 +0200
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
Subject: Re: [PATCH 01/14] fs/buffer: remove __breadahead_gfp()
Message-ID: <20220831103911.ubrkxc3yf46bdme3@quack3>
References: <20220831072111.3569680-1-yi.zhang@huawei.com>
 <20220831072111.3569680-2-yi.zhang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220831072111.3569680-2-yi.zhang@huawei.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 31-08-22 15:20:58, Zhang Yi wrote:
> No one use __breadahead_gfp() and sb_breadahead_unmovable() any more,
> remove them.
> 
> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/buffer.c                 | 11 -----------
>  include/linux/buffer_head.h |  8 --------
>  2 files changed, 19 deletions(-)
> 
> diff --git a/fs/buffer.c b/fs/buffer.c
> index 55e762a58eb6..a0b70b3239f3 100644
> --- a/fs/buffer.c
> +++ b/fs/buffer.c
> @@ -1348,17 +1348,6 @@ void __breadahead(struct block_device *bdev, sector_t block, unsigned size)
>  }
>  EXPORT_SYMBOL(__breadahead);
>  
> -void __breadahead_gfp(struct block_device *bdev, sector_t block, unsigned size,
> -		      gfp_t gfp)
> -{
> -	struct buffer_head *bh = __getblk_gfp(bdev, block, size, gfp);
> -	if (likely(bh)) {
> -		ll_rw_block(REQ_OP_READ | REQ_RAHEAD, 1, &bh);
> -		brelse(bh);
> -	}
> -}
> -EXPORT_SYMBOL(__breadahead_gfp);
> -
>  /**
>   *  __bread_gfp() - reads a specified block and returns the bh
>   *  @bdev: the block_device to read from
> diff --git a/include/linux/buffer_head.h b/include/linux/buffer_head.h
> index 089c9ade4325..c3863c417b00 100644
> --- a/include/linux/buffer_head.h
> +++ b/include/linux/buffer_head.h
> @@ -214,8 +214,6 @@ struct buffer_head *__getblk_gfp(struct block_device *bdev, sector_t block,
>  void __brelse(struct buffer_head *);
>  void __bforget(struct buffer_head *);
>  void __breadahead(struct block_device *, sector_t block, unsigned int size);
> -void __breadahead_gfp(struct block_device *, sector_t block, unsigned int size,
> -		  gfp_t gfp);
>  struct buffer_head *__bread_gfp(struct block_device *,
>  				sector_t block, unsigned size, gfp_t gfp);
>  void invalidate_bh_lrus(void);
> @@ -340,12 +338,6 @@ sb_breadahead(struct super_block *sb, sector_t block)
>  	__breadahead(sb->s_bdev, block, sb->s_blocksize);
>  }
>  
> -static inline void
> -sb_breadahead_unmovable(struct super_block *sb, sector_t block)
> -{
> -	__breadahead_gfp(sb->s_bdev, block, sb->s_blocksize, 0);
> -}
> -
>  static inline struct buffer_head *
>  sb_getblk(struct super_block *sb, sector_t block)
>  {
> -- 
> 2.31.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
