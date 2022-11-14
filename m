Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 170CC627AF3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Nov 2022 11:49:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235933AbiKNKta (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Nov 2022 05:49:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229816AbiKNKt3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Nov 2022 05:49:29 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 449F21B9C6;
        Mon, 14 Nov 2022 02:49:29 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id E16871FE67;
        Mon, 14 Nov 2022 10:49:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1668422967; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Ubo9RUeILLOZCFhRqSz41sUmP7donszofRssChRT+mk=;
        b=FCJdYm9kzAhz4vYOrsAtx1I3ezNTwuYj9tisurbURs8GMQMuDY7MNqoKTq9Jo2s46wmDM4
        KLXrTSl6G1mjhcXykUIOgXNTJL65jcU/3xY8IYjqW7Cb2ICxqU9GCpKor69sgQtUVpUD1D
        pbWbo6t4OX6sRFdseSr8R25qMN9mhpg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1668422967;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Ubo9RUeILLOZCFhRqSz41sUmP7donszofRssChRT+mk=;
        b=927zvK6sEulfOA+/7LmlwmEuhq43kTGhclLO5y7m/oMptFQXPkIWgf9Yn+PvAO20O14a4E
        315hsx4OV89dt4Cg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D284013A8C;
        Mon, 14 Nov 2022 10:49:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id o0VfMzcdcmOqZgAAMHmgww
        (envelope-from <jack@suse.cz>); Mon, 14 Nov 2022 10:49:27 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 65ECAA0709; Mon, 14 Nov 2022 11:49:27 +0100 (CET)
Date:   Mon, 14 Nov 2022 11:49:27 +0100
From:   Jan Kara <jack@suse.cz>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Namjae Jeon <linkinjeon@kernel.org>,
        Sungjong Seo <sj1557.seo@samsung.com>,
        Jan Kara <jack@suse.com>,
        OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
        Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>,
        Dave Kleikamp <shaggy@kernel.org>,
        Bob Copeland <me@bobcopeland.com>,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        jfs-discussion@lists.sourceforge.net,
        linux-karma-devel@lists.sourceforge.net, linux-mm@kvack.org
Subject: Re: [PATCH 2/9] ext2: remove ->writepage
Message-ID: <20221114104927.k5x4i4uanxskfs6m@quack3>
References: <20221113162902.883850-1-hch@lst.de>
 <20221113162902.883850-3-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221113162902.883850-3-hch@lst.de>
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun 13-11-22 17:28:55, Christoph Hellwig wrote:
> ->writepage is a very inefficient method to write back data, and only
> used through write_cache_pages or a a fallback when no ->migrate_folio
> method is present.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks good! Feel free to add:

Acked-by: Jan Kara <jack@suse.cz>

								Honza
> ---
>  fs/ext2/inode.c | 6 ------
>  1 file changed, 6 deletions(-)
> 
> diff --git a/fs/ext2/inode.c b/fs/ext2/inode.c
> index 918ab2f9e4c05..3b2e3e1e0fa25 100644
> --- a/fs/ext2/inode.c
> +++ b/fs/ext2/inode.c
> @@ -869,11 +869,6 @@ int ext2_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
>  	return ret;
>  }
>  
> -static int ext2_writepage(struct page *page, struct writeback_control *wbc)
> -{
> -	return block_write_full_page(page, ext2_get_block, wbc);
> -}
> -
>  static int ext2_read_folio(struct file *file, struct folio *folio)
>  {
>  	return mpage_read_folio(folio, ext2_get_block);
> @@ -948,7 +943,6 @@ const struct address_space_operations ext2_aops = {
>  	.invalidate_folio	= block_invalidate_folio,
>  	.read_folio		= ext2_read_folio,
>  	.readahead		= ext2_readahead,
> -	.writepage		= ext2_writepage,
>  	.write_begin		= ext2_write_begin,
>  	.write_end		= ext2_write_end,
>  	.bmap			= ext2_bmap,
> -- 
> 2.30.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
