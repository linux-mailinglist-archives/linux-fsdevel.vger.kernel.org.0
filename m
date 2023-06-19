Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45F6D735100
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jun 2023 11:56:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231152AbjFSJ4P (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 19 Jun 2023 05:56:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230469AbjFSJ4I (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 19 Jun 2023 05:56:08 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B18E7E77;
        Mon, 19 Jun 2023 02:56:06 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 422ED1F38A;
        Mon, 19 Jun 2023 09:56:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1687168565; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hjSIn/gl7eGaq16iD3zKNds5FKdXaWAXy03foKwXdXA=;
        b=iyUnxx0G+hifGpfNQU1q/8CW0Z6azO7T88n3M4sjs6fb9UNJABk2dZjwuP+9Bm8w27gvgZ
        zjJ45j/aJK3nkuQKEO7GzkncTcsU4gJfhOZwO6NDDOIzkFYGufecw/J2Dv2KgNe9C/59SX
        fWulkdHPd58FHJiSEoHfTrbHatluQc4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1687168565;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hjSIn/gl7eGaq16iD3zKNds5FKdXaWAXy03foKwXdXA=;
        b=VjXJ8b32ZLLPMd2YU/s+D+sxyFhGw26RTgODDJZS82t5iIY52NEERkUnuP5HOE6HMbTXIw
        6LsvITHbDbJYI6Cw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2F36F138E8;
        Mon, 19 Jun 2023 09:56:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Lnt8CzUmkGTANgAAMHmgww
        (envelope-from <jack@suse.cz>); Mon, 19 Jun 2023 09:56:05 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id BB61FA0755; Mon, 19 Jun 2023 11:56:04 +0200 (CEST)
Date:   Mon, 19 Jun 2023 11:56:04 +0200
From:   Jan Kara <jack@suse.cz>
To:     Bean Huo <beanhuo@iokpp.de>
Cc:     viro@zeniv.linux.org.uk, brauner@kernel.org,
        akpm@linux-foundation.org, jack@suse.cz, jack@suse.com,
        tytso@mit.edu, adilger.kernel@dilger.ca, mark@fasheh.com,
        jlbec@evilplan.org, joseph.qi@linux.alibaba.com,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, ocfs2-devel@oss.oracle.com,
        beanhuo@micron.com
Subject: Re: [PATCH v1 2/5] fs/buffer.c: convert block_commit_write to return
 void
Message-ID: <20230619095604.uknf7uovnn2az2wu@quack3>
References: <20230618213250.694110-1-beanhuo@iokpp.de>
 <20230618213250.694110-3-beanhuo@iokpp.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230618213250.694110-3-beanhuo@iokpp.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun 18-06-23 23:32:47, Bean Huo wrote:
> From: Bean Huo <beanhuo@micron.com>
> 
> block_commit_write() always returns 0, this patch changes it to
> return void.
> 
> Signed-off-by: Bean Huo <beanhuo@micron.com>

Looks good to me but you'll need to reorder this patch at the end of the
patch series to avoid breaking compilation in the middle of the series.
Otherwise feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/buffer.c                 | 11 +++++------
>  include/linux/buffer_head.h |  2 +-
>  2 files changed, 6 insertions(+), 7 deletions(-)
> 
> diff --git a/fs/buffer.c b/fs/buffer.c
> index b88bb7ec38be..fa09cf94f771 100644
> --- a/fs/buffer.c
> +++ b/fs/buffer.c
> @@ -2116,7 +2116,7 @@ int __block_write_begin(struct page *page, loff_t pos, unsigned len,
>  }
>  EXPORT_SYMBOL(__block_write_begin);
>  
> -int block_commit_write(struct page *page, unsigned int from, unsigned int to)
> +void block_commit_write(struct page *page, unsigned int from, unsigned int to)
>  {
>  	unsigned block_start, block_end;
>  	int partial = 0;
> @@ -2151,7 +2151,6 @@ int block_commit_write(struct page *page, unsigned int from, unsigned int to)
>  	 */
>  	if (!partial)
>  		SetPageUptodate(page);
> -	return 0;
>  }
>  EXPORT_SYMBOL(block_commit_write);
>  
> @@ -2577,11 +2576,11 @@ int block_page_mkwrite(struct vm_area_struct *vma, struct vm_fault *vmf,
>  		end = PAGE_SIZE;
>  
>  	ret = __block_write_begin(page, 0, end, get_block);
> -	if (!ret)
> -		ret = block_commit_write(page, 0, end);
> -
> -	if (unlikely(ret < 0))
> +	if (unlikely(ret))
>  		goto out_unlock;
> +
> +	block_commit_write(page, 0, end);
> +
>  	set_page_dirty(page);
>  	wait_for_stable_page(page);
>  	return 0;
> diff --git a/include/linux/buffer_head.h b/include/linux/buffer_head.h
> index 1520793c72da..873653d2f1aa 100644
> --- a/include/linux/buffer_head.h
> +++ b/include/linux/buffer_head.h
> @@ -284,7 +284,7 @@ int cont_write_begin(struct file *, struct address_space *, loff_t,
>  			unsigned, struct page **, void **,
>  			get_block_t *, loff_t *);
>  int generic_cont_expand_simple(struct inode *inode, loff_t size);
> -int block_commit_write(struct page *page, unsigned from, unsigned to);
> +void block_commit_write(struct page *page, unsigned int from, unsigned int to);
>  int block_page_mkwrite(struct vm_area_struct *vma, struct vm_fault *vmf,
>  				get_block_t get_block);
>  /* Convert errno to return value from ->page_mkwrite() call */
> -- 
> 2.34.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
