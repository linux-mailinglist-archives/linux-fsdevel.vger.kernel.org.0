Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57FA67B668E
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Oct 2023 12:40:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231211AbjJCKkX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Oct 2023 06:40:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230215AbjJCKkW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Oct 2023 06:40:22 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 289B2AC;
        Tue,  3 Oct 2023 03:40:19 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id CE9C21F894;
        Tue,  3 Oct 2023 10:40:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1696329617; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=M6PgWNUdp2I+tMm+3+FKTqYAjGM29Ue5NKp79fJcKpc=;
        b=U9iHhg8IkTdd+RqhkifyKx0KAW3xF/NlkQqyB5U/WjEAxFCtDwMygMlO6Mq/xXFJjjLWIo
        Eg+zIr/9TlH8Hkp9nG1kjdh40Mhi3oUhpWVvf941EVtH16ln/bXpVpoUoH0ZjSeXjQGEaM
        Hh4aBspvQbq3XAM5b5lSv3BgDHJYCQY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1696329617;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=M6PgWNUdp2I+tMm+3+FKTqYAjGM29Ue5NKp79fJcKpc=;
        b=dApzyjurZT1FK2Dzk4HzaP6GGchOL0RbYbSZ/UEi13J0WiFz/BU1KCQL/M1h69n++96jz2
        Zs98vsv/dBLXQPDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BE025132D4;
        Tue,  3 Oct 2023 10:40:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id ayVKLpHvG2UIawAAMHmgww
        (envelope-from <jack@suse.cz>); Tue, 03 Oct 2023 10:40:17 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 3A508A07CB; Tue,  3 Oct 2023 12:40:17 +0200 (CEST)
Date:   Tue, 3 Oct 2023 12:40:17 +0200
From:   Jan Kara <jack@suse.cz>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     Jan Kara <jack@suse.com>, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        "Fabio M . De Francesco" <fmdefrancesco@gmail.com>
Subject: Re: [PATCH 02/10] ext2: Convert ext2_check_page to ext2_check_folio
Message-ID: <20231003104017.ohuyl3fv2mobif5u@quack3>
References: <20230921200746.3303942-1-willy@infradead.org>
 <20230921200746.3303942-2-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230921200746.3303942-2-willy@infradead.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 21-09-23 21:07:39, Matthew Wilcox (Oracle) wrote:
> Support in this function for large folios is limited to supporting
> filesystems with block size > PAGE_SIZE.  This new functionality will only
> be supported on machines without HIGHMEM, so the problem of kmap_local
> only being able to map a single page in the folio can be ignored.
> We will not use large folios for ext2 directories on HIGHMEM machines.

OK, but can we perhaps enforce this with some checks & error messages
instead of a silent failure? Like:

#ifdef CONFIG_HIGHMEM
	if (sb->s_blocksize > PAGE_SIZE)
		bail with error
#endif

somewhere in ext2_fill_super()? Or maybe force allocation of lowmem pages
when blocksize > PAGE_SIZE?

								Honza

> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>  fs/ext2/dir.c | 28 ++++++++++++++--------------
>  1 file changed, 14 insertions(+), 14 deletions(-)
> 
> diff --git a/fs/ext2/dir.c b/fs/ext2/dir.c
> index b335f17f682f..03867381eec2 100644
> --- a/fs/ext2/dir.c
> +++ b/fs/ext2/dir.c
> @@ -96,19 +96,19 @@ static void ext2_commit_chunk(struct page *page, loff_t pos, unsigned len)
>  	unlock_page(page);
>  }
>  
> -static bool ext2_check_page(struct page *page, int quiet, char *kaddr)
> +static bool ext2_check_folio(struct folio *folio, int quiet, char *kaddr)
>  {
> -	struct inode *dir = page->mapping->host;
> +	struct inode *dir = folio->mapping->host;
>  	struct super_block *sb = dir->i_sb;
>  	unsigned chunk_size = ext2_chunk_size(dir);
>  	u32 max_inumber = le32_to_cpu(EXT2_SB(sb)->s_es->s_inodes_count);
>  	unsigned offs, rec_len;
> -	unsigned limit = PAGE_SIZE;
> +	unsigned limit = folio_size(folio);
>  	ext2_dirent *p;
>  	char *error;
>  
> -	if ((dir->i_size >> PAGE_SHIFT) == page->index) {
> -		limit = dir->i_size & ~PAGE_MASK;
> +	if (dir->i_size < folio_pos(folio) + limit) {
> +		limit = offset_in_folio(folio, dir->i_size);
>  		if (limit & (chunk_size - 1))
>  			goto Ebadsize;
>  		if (!limit)
> @@ -132,7 +132,7 @@ static bool ext2_check_page(struct page *page, int quiet, char *kaddr)
>  	if (offs != limit)
>  		goto Eend;
>  out:
> -	SetPageChecked(page);
> +	folio_set_checked(folio);
>  	return true;
>  
>  	/* Too bad, we had an error */
> @@ -160,22 +160,22 @@ static bool ext2_check_page(struct page *page, int quiet, char *kaddr)
>  bad_entry:
>  	if (!quiet)
>  		ext2_error(sb, __func__, "bad entry in directory #%lu: : %s - "
> -			"offset=%lu, inode=%lu, rec_len=%d, name_len=%d",
> -			dir->i_ino, error, (page->index<<PAGE_SHIFT)+offs,
> +			"offset=%llu, inode=%lu, rec_len=%d, name_len=%d",
> +			dir->i_ino, error, folio_pos(folio) + offs,
>  			(unsigned long) le32_to_cpu(p->inode),
>  			rec_len, p->name_len);
>  	goto fail;
>  Eend:
>  	if (!quiet) {
>  		p = (ext2_dirent *)(kaddr + offs);
> -		ext2_error(sb, "ext2_check_page",
> +		ext2_error(sb, "ext2_check_folio",
>  			"entry in directory #%lu spans the page boundary"
> -			"offset=%lu, inode=%lu",
> -			dir->i_ino, (page->index<<PAGE_SHIFT)+offs,
> +			"offset=%llu, inode=%lu",
> +			dir->i_ino, folio_pos(folio) + offs,
>  			(unsigned long) le32_to_cpu(p->inode));
>  	}
>  fail:
> -	SetPageError(page);
> +	folio_set_error(folio);
>  	return false;
>  }
>  
> @@ -195,9 +195,9 @@ static void *ext2_get_page(struct inode *dir, unsigned long n,
>  
>  	if (IS_ERR(folio))
>  		return ERR_CAST(folio);
> -	page_addr = kmap_local_folio(folio, n & (folio_nr_pages(folio) - 1));
> +	page_addr = kmap_local_folio(folio, 0);
>  	if (unlikely(!folio_test_checked(folio))) {
> -		if (!ext2_check_page(&folio->page, quiet, page_addr))
> +		if (!ext2_check_folio(folio, quiet, page_addr))
>  			goto fail;
>  	}
>  	*page = &folio->page;
> -- 
> 2.40.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
