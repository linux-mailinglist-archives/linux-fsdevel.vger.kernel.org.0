Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD681627B13
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Nov 2022 11:52:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235493AbiKNKwR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Nov 2022 05:52:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229933AbiKNKwQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Nov 2022 05:52:16 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72E4F19298;
        Mon, 14 Nov 2022 02:52:15 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 2EDFD1FE6D;
        Mon, 14 Nov 2022 10:52:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1668423134; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=clcJq84x09/0lcWlLPOIuK2xM1hHOs9iOojMYOjosj8=;
        b=lQu2Pjy3pcp9uwaKFc3jgFAkHtcCek0sMnlUAE6BmF19YIti5i9HZ/q7Nk10ciS9BlKNeN
        FEU74NgEx7LkiqMQJKzQMvpI9eKeD8eRtQGzkDBgiysrujSGACB7sdURignxiBCVcTV4aW
        9GVrMofKVCVgS53i4KFkqjdnrD/gQ3Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1668423134;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=clcJq84x09/0lcWlLPOIuK2xM1hHOs9iOojMYOjosj8=;
        b=r4V7upTQYSfV/3yRbELgnAsYzoLI4t9YZUR2mEvVSkpz2isJwNzAuGEbJHWIJKKfSWt4OX
        9Z6E2DqrJ96wkmBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1F7F713A8C;
        Mon, 14 Nov 2022 10:52:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id SPauB94dcmNDaAAAMHmgww
        (envelope-from <jack@suse.cz>); Mon, 14 Nov 2022 10:52:14 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 76E40A0709; Mon, 14 Nov 2022 11:52:13 +0100 (CET)
Date:   Mon, 14 Nov 2022 11:52:13 +0100
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
Subject: Re: [PATCH 9/9] udf: remove ->writepage
Message-ID: <20221114105213.v5gby6zngz6y6med@quack3>
References: <20221113162902.883850-1-hch@lst.de>
 <20221113162902.883850-10-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221113162902.883850-10-hch@lst.de>
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun 13-11-22 17:29:02, Christoph Hellwig wrote:
> ->writepage is a very inefficient method to write back data, and only
> used through write_cache_pages or a a fallback when no ->migrate_folio
> method is present.
> 
> Set ->migrate_folio to the generic buffer_head based helper, and remove
> the ->writepage implementation in extfat.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks good. Feel free to add:

Acked-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/udf/inode.c | 7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)
> 
> diff --git a/fs/udf/inode.c b/fs/udf/inode.c
> index dce6ae9ae306c..0246b1b86fb91 100644
> --- a/fs/udf/inode.c
> +++ b/fs/udf/inode.c
> @@ -182,11 +182,6 @@ static void udf_write_failed(struct address_space *mapping, loff_t to)
>  	}
>  }
>  
> -static int udf_writepage(struct page *page, struct writeback_control *wbc)
> -{
> -	return block_write_full_page(page, udf_get_block, wbc);
> -}
> -
>  static int udf_writepages(struct address_space *mapping,
>  			struct writeback_control *wbc)
>  {
> @@ -239,12 +234,12 @@ const struct address_space_operations udf_aops = {
>  	.invalidate_folio = block_invalidate_folio,
>  	.read_folio	= udf_read_folio,
>  	.readahead	= udf_readahead,
> -	.writepage	= udf_writepage,
>  	.writepages	= udf_writepages,
>  	.write_begin	= udf_write_begin,
>  	.write_end	= generic_write_end,
>  	.direct_IO	= udf_direct_IO,
>  	.bmap		= udf_bmap,
> +	.migrate_folio	= buffer_migrate_folio,
>  };
>  
>  /*
> -- 
> 2.30.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
