Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96D87548B96
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Jun 2022 18:10:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354278AbiFMLcE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 13 Jun 2022 07:32:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355210AbiFMLax (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 13 Jun 2022 07:30:53 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4979A41997;
        Mon, 13 Jun 2022 03:46:52 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id E7BB421D73;
        Mon, 13 Jun 2022 10:46:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1655117210; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9D4LOgTRI6f8VNdDcls0w5x8mnJwI93bl+ycJ6sjsC4=;
        b=Bpm0Q6U8QbyeXOfR3l+Bb6BF+MAecgp+oNatjUaaVxt7qP708uexjMBZWCGyWLsfIOZFGX
        6jS46bbjkex9hEULZZwfFWHh0B87lxiP28OPbYCwxj5TrWdAgyID+DxElk3aW6hoA7GAkQ
        VrrbyMb554Kfx4olzIdGBXOb2OOz3x4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1655117210;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9D4LOgTRI6f8VNdDcls0w5x8mnJwI93bl+ycJ6sjsC4=;
        b=Tqql0ADCuLk5NfS41NVndCiy75JS/KRScqvTHZgWFvE8DzXzmhIgnPbO/a8jOX+Obw0YAs
        HSu2pqV650JLf2Ag==
Received: from quack3.suse.cz (unknown [10.163.28.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id CCB732C141;
        Mon, 13 Jun 2022 10:46:50 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 830CAA0634; Mon, 13 Jun 2022 12:46:47 +0200 (CEST)
Date:   Mon, 13 Jun 2022 12:46:47 +0200
From:   Jan Kara <jack@suse.cz>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.com>,
        Dave Kleikamp <shaggy@kernel.org>,
        Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, jfs-discussion@lists.sourceforge.net,
        ntfs3@lists.linux.dev
Subject: Re: [PATCH 1/6] ntfs3: refactor ntfs_writepages
Message-ID: <20220613104647.wjt27tqijdou3vm4@quack3.lan>
References: <20220613053715.2394147-1-hch@lst.de>
 <20220613053715.2394147-2-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220613053715.2394147-2-hch@lst.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon 13-06-22 07:37:10, Christoph Hellwig wrote:
> Handle the resident case with an explicit generic_writepages call instead
> of using the obscure overload that makes mpage_writepages with a NULL
> get_block do the same thing.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Yeah, much more obvious :). Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ntfs3/inode.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/ntfs3/inode.c b/fs/ntfs3/inode.c
> index be4ebdd8048b0..28c09c25b823d 100644
> --- a/fs/ntfs3/inode.c
> +++ b/fs/ntfs3/inode.c
> @@ -851,12 +851,10 @@ static int ntfs_writepage(struct page *page, struct writeback_control *wbc)
>  static int ntfs_writepages(struct address_space *mapping,
>  			   struct writeback_control *wbc)
>  {
> -	struct inode *inode = mapping->host;
> -	struct ntfs_inode *ni = ntfs_i(inode);
>  	/* Redirect call to 'ntfs_writepage' for resident files. */
> -	get_block_t *get_block = is_resident(ni) ? NULL : &ntfs_get_block;
> -
> -	return mpage_writepages(mapping, wbc, get_block);
> +	if (is_resident(ntfs_i(mapping->host)))
> +		return generic_writepages(mapping, wbc);
> +	return mpage_writepages(mapping, wbc, ntfs_get_block);
>  }
>  
>  static int ntfs_get_block_write_begin(struct inode *inode, sector_t vbn,
> -- 
> 2.30.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
