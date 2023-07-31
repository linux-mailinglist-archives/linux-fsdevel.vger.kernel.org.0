Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 065247699F8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 Jul 2023 16:46:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232705AbjGaOqH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 31 Jul 2023 10:46:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230107AbjGaOqG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 31 Jul 2023 10:46:06 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A665B6;
        Mon, 31 Jul 2023 07:46:05 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 199CF1F854;
        Mon, 31 Jul 2023 14:46:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1690814764; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XPdIQm6lw+iMDcuyergAy0WqRBg61RsIM13C6k5yY04=;
        b=OgD+1tFLQbf02OGazL3QZNSeqvVKobiVUeaL6F12nJxNVpRJClI4G+JKgIJ4NZVHGZtuM0
        tIUuNWKsvNT8Uxu2ljZVUnpw7ZwXldyObS8XKIEmXlKA5sMP6R/aUEla258P0RxKiiUY2K
        Th3bdJ97Q25pNBw4heNtI8BgtKuUQDk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1690814764;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XPdIQm6lw+iMDcuyergAy0WqRBg61RsIM13C6k5yY04=;
        b=v0B6MyyuwFONgjvOCUy4haXJjwH9hbPB01oPAIkQx6V7OojJxIGkazXChJfeQXSLXp0mTx
        SKO/f3jSZWcflAAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0AACE133F7;
        Mon, 31 Jul 2023 14:46:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id z7+PAizJx2TBYAAAMHmgww
        (envelope-from <jack@suse.cz>); Mon, 31 Jul 2023 14:46:04 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 94121A069C; Mon, 31 Jul 2023 16:46:03 +0200 (CEST)
Date:   Mon, 31 Jul 2023 16:46:03 +0200
From:   Jan Kara <jack@suse.cz>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        David Sterba <dsterba@suse.com>, linux-fsdevel@vger.kernel.org,
        Pankaj Raghav <p.raghav@samsung.com>,
        Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        ntfs3@lists.linux.dev, Theodore Tso <tytso@mit.edu>,
        Jan Kara <jack@suse.com>, linux-ext4@vger.kernel.org
Subject: Re: [PATCH 7/7] buffer: Remove set_bh_page()
Message-ID: <20230731144603.4ehtpamxbhhd7fv5@quack3>
References: <20230713035512.4139457-1-willy@infradead.org>
 <20230713035512.4139457-8-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230713035512.4139457-8-willy@infradead.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 13-07-23 04:55:12, Matthew Wilcox (Oracle) wrote:
> With all users converted to folio_set_bh(), remove this function.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Sure. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/buffer.c                 | 15 ---------------
>  include/linux/buffer_head.h |  2 --
>  2 files changed, 17 deletions(-)
> 
> diff --git a/fs/buffer.c b/fs/buffer.c
> index 587e4d4af9de..f0563ebae75f 100644
> --- a/fs/buffer.c
> +++ b/fs/buffer.c
> @@ -1539,21 +1539,6 @@ void invalidate_bh_lrus_cpu(void)
>  	bh_lru_unlock();
>  }
>  
> -void set_bh_page(struct buffer_head *bh,
> -		struct page *page, unsigned long offset)
> -{
> -	bh->b_page = page;
> -	BUG_ON(offset >= PAGE_SIZE);
> -	if (PageHighMem(page))
> -		/*
> -		 * This catches illegal uses and preserves the offset:
> -		 */
> -		bh->b_data = (char *)(0 + offset);
> -	else
> -		bh->b_data = page_address(page) + offset;
> -}
> -EXPORT_SYMBOL(set_bh_page);
> -
>  void folio_set_bh(struct buffer_head *bh, struct folio *folio,
>  		  unsigned long offset)
>  {
> diff --git a/include/linux/buffer_head.h b/include/linux/buffer_head.h
> index a7377877ff4e..06566aee94ca 100644
> --- a/include/linux/buffer_head.h
> +++ b/include/linux/buffer_head.h
> @@ -194,8 +194,6 @@ void buffer_check_dirty_writeback(struct folio *folio,
>  void mark_buffer_dirty(struct buffer_head *bh);
>  void mark_buffer_write_io_error(struct buffer_head *bh);
>  void touch_buffer(struct buffer_head *bh);
> -void set_bh_page(struct buffer_head *bh,
> -		struct page *page, unsigned long offset);
>  void folio_set_bh(struct buffer_head *bh, struct folio *folio,
>  		  unsigned long offset);
>  bool try_to_free_buffers(struct folio *);
> -- 
> 2.39.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
