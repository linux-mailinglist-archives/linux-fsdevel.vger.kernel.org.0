Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E55B59EDB8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Aug 2022 22:47:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233775AbiHWUrv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 Aug 2022 16:47:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233386AbiHWUre (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 Aug 2022 16:47:34 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8559F13E27;
        Tue, 23 Aug 2022 13:42:10 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 8D8C91F8A4;
        Tue, 23 Aug 2022 20:42:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1661287328;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5Z1+5HwGzB5SEc0qPWicNuIJp37/qrfI8QMkqNpAi48=;
        b=ZjFBwJwyPcjRSyXI46DAXq1bvm4Ds/dHT7sQGPczmeOkCMcodctHZJBQJEfvlhgBru3sZJ
        GSrkdfs2mHGZKqxSDa6SqDr5ly/osZnskuQVy3PkgYBJAufR+LBxVv1u+NgGR1v2P2lSh8
        0TadMPVQpPhof+TgS/OdsWOE+822q+Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1661287328;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5Z1+5HwGzB5SEc0qPWicNuIJp37/qrfI8QMkqNpAi48=;
        b=+AIGGJhj3lIAbyl/6JU4uqYNvr3OX2vxqirob3MG+10/0iRclHETj+L5cEzx/Bc8hYEI4r
        wim9kxuudHNWZIAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4A28613A89;
        Tue, 23 Aug 2022 20:42:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 8+EbEaA7BWPMCQAAMHmgww
        (envelope-from <dsterba@suse.cz>); Tue, 23 Aug 2022 20:42:08 +0000
Date:   Tue, 23 Aug 2022 22:36:54 +0200
From:   David Sterba <dsterba@suse.cz>
To:     "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        linux-nilfs@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/7] btrfs: Convert end_compressed_writeback() to use
 filemap_get_folios()
Message-ID: <20220823203654.GS13489@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
        "Vishal Moola (Oracle)" <vishal.moola@gmail.com>,
        linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        linux-nilfs@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20220816175246.42401-1-vishal.moola@gmail.com>
 <20220816175246.42401-4-vishal.moola@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220816175246.42401-4-vishal.moola@gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_SOFTFAIL,
        SUSPICIOUS_RECIPS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 16, 2022 at 10:52:42AM -0700, Vishal Moola (Oracle) wrote:
> Converted function to use folios throughout. This is in preparation for
> the removal of find_get_pages_contig(). Now also supports large folios.
> 
> Since we may receive more than nr_pages pages, nr_pages may underflow.
> Since nr_pages > 0 is equivalent to index <= end_index, we replaced it
> with this check instead.
> 
> Also this function does not care about the pages being contiguous so we
> can just use filemap_get_folios() to be more efficient.
> 
> Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>

With minor comments

Acked-by: David Sterba <dsterba@suse.com>

> --- a/fs/btrfs/compression.c
> +++ b/fs/btrfs/compression.c
> @@ -8,6 +8,7 @@
>  #include <linux/file.h>
>  #include <linux/fs.h>
>  #include <linux/pagemap.h>
> +#include <linux/pagevec.h>
>  #include <linux/highmem.h>
>  #include <linux/kthread.h>
>  #include <linux/time.h>
> @@ -339,8 +340,7 @@ static noinline void end_compressed_writeback(struct inode *inode,
>  	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
>  	unsigned long index = cb->start >> PAGE_SHIFT;
>  	unsigned long end_index = (cb->start + cb->len - 1) >> PAGE_SHIFT;
> -	struct page *pages[16];
> -	unsigned long nr_pages = end_index - index + 1;
> +	struct folio_batch fbatch;
>  	const int errno = blk_status_to_errno(cb->status);
>  	int i;
>  	int ret;
> @@ -348,24 +348,22 @@ static noinline void end_compressed_writeback(struct inode *inode,
>  	if (errno)
>  		mapping_set_error(inode->i_mapping, errno);
>  
> -	while (nr_pages > 0) {
> -		ret = find_get_pages_contig(inode->i_mapping, index,
> -				     min_t(unsigned long,
> -				     nr_pages, ARRAY_SIZE(pages)), pages);
> +	folio_batch_init(&fbatch);
> +	while (index <= end_index) {
> +		ret = filemap_get_folios(inode->i_mapping, &index, end_index,
> +				&fbatch);
> +
>  		if (ret == 0) {
> -			nr_pages -= 1;
> -			index += 1;
> -			continue;
> +			return;
>  		}

Please drop { } around single statement

>  		for (i = 0; i < ret; i++) {
> +			struct folio *folio = fbatch.folios[i];

And add a newline after declaration.

>  			if (errno)
> -				SetPageError(pages[i]);
> -			btrfs_page_clamp_clear_writeback(fs_info, pages[i],
> +				folio_set_error(folio);
> +			btrfs_page_clamp_clear_writeback(fs_info, &folio->page,
>  							 cb->start, cb->len);
> -			put_page(pages[i]);
>  		}
> -		nr_pages -= ret;
> -		index += ret;
> +		folio_batch_release(&fbatch);
>  	}
>  	/* the inode may be gone now */
>  }
> -- 
> 2.36.1
