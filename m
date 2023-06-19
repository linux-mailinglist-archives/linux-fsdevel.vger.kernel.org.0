Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 943517350E8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jun 2023 11:52:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230259AbjFSJwf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 19 Jun 2023 05:52:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229916AbjFSJwe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 19 Jun 2023 05:52:34 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6CD6F3;
        Mon, 19 Jun 2023 02:52:32 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 838F8210E7;
        Mon, 19 Jun 2023 09:52:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1687168351; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DxIJDuuYClXmgqYM4N1lEgYI6VAbXG1zZ254H2n4+qw=;
        b=cfNES0tRgRt0IZv0nqHW23+HqATlwNpQKXeKBshiiYxpUWvkGCDRZ+Xv/27M4Oas5e7Am3
        SGaDzkXL1/aWl/XjXWpwAP3yJUyAa0getdW6KZzTkY31VyFlS0WWeYjvFZdOrGyi4BJ6js
        Kqe0majp2iBdXrYARIc++DT8QhLXOBE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1687168351;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DxIJDuuYClXmgqYM4N1lEgYI6VAbXG1zZ254H2n4+qw=;
        b=7kExUx51RD0vHom4H8oJKaZpf32mIjedU88Fjzph254nHGLgby4ShOkk2dzXoePKpxwLt0
        kRtpzEJMEkigAKDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6EB02138E8;
        Mon, 19 Jun 2023 09:52:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Esz8Gl8lkGQmNQAAMHmgww
        (envelope-from <jack@suse.cz>); Mon, 19 Jun 2023 09:52:31 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 059ABA0755; Mon, 19 Jun 2023 11:52:31 +0200 (CEST)
Date:   Mon, 19 Jun 2023 11:52:30 +0200
From:   Jan Kara <jack@suse.cz>
To:     Bean Huo <beanhuo@iokpp.de>
Cc:     viro@zeniv.linux.org.uk, brauner@kernel.org,
        akpm@linux-foundation.org, jack@suse.cz, jack@suse.com,
        tytso@mit.edu, adilger.kernel@dilger.ca, mark@fasheh.com,
        jlbec@evilplan.org, joseph.qi@linux.alibaba.com,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, ocfs2-devel@oss.oracle.com,
        beanhuo@micron.com
Subject: Re: [PATCH v1 1/5] fs/buffer: clean up block_commit_write
Message-ID: <20230619095230.undchckir57stooe@quack3>
References: <20230618213250.694110-1-beanhuo@iokpp.de>
 <20230618213250.694110-2-beanhuo@iokpp.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230618213250.694110-2-beanhuo@iokpp.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun 18-06-23 23:32:46, Bean Huo wrote:
> From: Bean Huo <beanhuo@micron.com>
> 
> Originally inode is used to get blksize, after commit 45bce8f3e343
> ("fs/buffer.c: make block-size be per-page and protected by the page lock"),
> __block_commit_write no longer uses this parameter inode, this patch is to
> remove inode and clean up block_commit_write.
> 
> Signed-off-by: Bean Huo <beanhuo@micron.com>

Nice! Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/buffer.c | 15 +++------------
>  1 file changed, 3 insertions(+), 12 deletions(-)
> 
> diff --git a/fs/buffer.c b/fs/buffer.c
> index a7fc561758b1..b88bb7ec38be 100644
> --- a/fs/buffer.c
> +++ b/fs/buffer.c
> @@ -2116,8 +2116,7 @@ int __block_write_begin(struct page *page, loff_t pos, unsigned len,
>  }
>  EXPORT_SYMBOL(__block_write_begin);
>  
> -static int __block_commit_write(struct inode *inode, struct page *page,
> -		unsigned from, unsigned to)
> +int block_commit_write(struct page *page, unsigned int from, unsigned int to)
>  {
>  	unsigned block_start, block_end;
>  	int partial = 0;
> @@ -2154,6 +2153,7 @@ static int __block_commit_write(struct inode *inode, struct page *page,
>  		SetPageUptodate(page);
>  	return 0;
>  }
> +EXPORT_SYMBOL(block_commit_write);
>  
>  /*
>   * block_write_begin takes care of the basic task of block allocation and
> @@ -2188,7 +2188,6 @@ int block_write_end(struct file *file, struct address_space *mapping,
>  			loff_t pos, unsigned len, unsigned copied,
>  			struct page *page, void *fsdata)
>  {
> -	struct inode *inode = mapping->host;
>  	unsigned start;
>  
>  	start = pos & (PAGE_SIZE - 1);
> @@ -2214,7 +2213,7 @@ int block_write_end(struct file *file, struct address_space *mapping,
>  	flush_dcache_page(page);
>  
>  	/* This could be a short (even 0-length) commit */
> -	__block_commit_write(inode, page, start, start+copied);
> +	block_commit_write(page, start, start+copied);
>  
>  	return copied;
>  }
> @@ -2535,14 +2534,6 @@ int cont_write_begin(struct file *file, struct address_space *mapping,
>  }
>  EXPORT_SYMBOL(cont_write_begin);
>  
> -int block_commit_write(struct page *page, unsigned from, unsigned to)
> -{
> -	struct inode *inode = page->mapping->host;
> -	__block_commit_write(inode,page,from,to);
> -	return 0;
> -}
> -EXPORT_SYMBOL(block_commit_write);
> -
>  /*
>   * block_page_mkwrite() is not allowed to change the file size as it gets
>   * called from a page fault handler when a page is first dirtied. Hence we must
> -- 
> 2.34.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
