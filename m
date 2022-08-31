Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C08605A7C12
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Aug 2022 13:16:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231140AbiHaLQS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 31 Aug 2022 07:16:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbiHaLQR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 31 Aug 2022 07:16:17 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BEB0BD2B5;
        Wed, 31 Aug 2022 04:16:16 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id E78B521C15;
        Wed, 31 Aug 2022 11:16:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1661944574; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MRx8k6tf8EVQNjQIGFIame1sUsAVK8et6tEwceGHhl8=;
        b=fcAZulnTmQlOSJvI1I+O69n65WHnKJQoTQni0s3w0evX2OjfFfA1lUD3THM8aQ6sZy6buX
        sUI1QMIH53X9RNqtvnDe+cg+u3DjTpdXbtH3rf89ToZFCL1len1mAcbiGYQD+0jv4AkOLs
        uiCCa9V5KYewjz5kRySfD3uPQiNEd4U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1661944574;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MRx8k6tf8EVQNjQIGFIame1sUsAVK8et6tEwceGHhl8=;
        b=nwJRLnbywsNsLJBX+JGxDAcgG32zFks8rfoSXE7B10XV49QHCPI6z6DuG9+e4PJVIjbxaD
        BGMQPW8vEnBKu8Bw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D2EED13A7C;
        Wed, 31 Aug 2022 11:16:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 6ZF7M/5CD2OpeAAAMHmgww
        (envelope-from <jack@suse.cz>); Wed, 31 Aug 2022 11:16:14 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 66DF7A067B; Wed, 31 Aug 2022 13:16:14 +0200 (CEST)
Date:   Wed, 31 Aug 2022 13:16:14 +0200
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
Subject: Re: [PATCH 14/14] fs/buffer: remove bh_submit_read() helper
Message-ID: <20220831111614.z5pfchnj5mzqug6s@quack3>
References: <20220831072111.3569680-1-yi.zhang@huawei.com>
 <20220831072111.3569680-15-yi.zhang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220831072111.3569680-15-yi.zhang@huawei.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 31-08-22 15:21:11, Zhang Yi wrote:
> bh_submit_read() has no user anymore, just remove it.
> 
> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/buffer.c                 | 25 -------------------------
>  include/linux/buffer_head.h |  1 -
>  2 files changed, 26 deletions(-)
> 
> diff --git a/fs/buffer.c b/fs/buffer.c
> index d1d09e2dacc2..fa7c2dbcef4c 100644
> --- a/fs/buffer.c
> +++ b/fs/buffer.c
> @@ -3029,31 +3029,6 @@ void __bh_read_batch(struct buffer_head *bhs[],
>  }
>  EXPORT_SYMBOL(__bh_read_batch);
>  
> -/**
> - * bh_submit_read - Submit a locked buffer for reading
> - * @bh: struct buffer_head
> - *
> - * Returns zero on success and -EIO on error.
> - */
> -int bh_submit_read(struct buffer_head *bh)
> -{
> -	BUG_ON(!buffer_locked(bh));
> -
> -	if (buffer_uptodate(bh)) {
> -		unlock_buffer(bh);
> -		return 0;
> -	}
> -
> -	get_bh(bh);
> -	bh->b_end_io = end_buffer_read_sync;
> -	submit_bh(REQ_OP_READ, bh);
> -	wait_on_buffer(bh);
> -	if (buffer_uptodate(bh))
> -		return 0;
> -	return -EIO;
> -}
> -EXPORT_SYMBOL(bh_submit_read);
> -
>  void __init buffer_init(void)
>  {
>  	unsigned long nrpages;
> diff --git a/include/linux/buffer_head.h b/include/linux/buffer_head.h
> index 1c93ff8c8f51..576f3609ac4e 100644
> --- a/include/linux/buffer_head.h
> +++ b/include/linux/buffer_head.h
> @@ -230,7 +230,6 @@ int submit_bh(blk_opf_t, struct buffer_head *);
>  void write_boundary_block(struct block_device *bdev,
>  			sector_t bblock, unsigned blocksize);
>  int bh_uptodate_or_lock(struct buffer_head *bh);
> -int bh_submit_read(struct buffer_head *bh);
>  int __bh_read(struct buffer_head *bh, blk_opf_t op_flags, bool wait);
>  void __bh_read_batch(struct buffer_head *bhs[],
>  		     int nr, blk_opf_t op_flags, bool force_lock);
> -- 
> 2.31.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
