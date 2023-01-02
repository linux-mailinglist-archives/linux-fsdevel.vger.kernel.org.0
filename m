Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D1A965B1DD
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Jan 2023 13:16:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232657AbjABMQ0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 Jan 2023 07:16:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjABMQZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Jan 2023 07:16:25 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68E25DB2;
        Mon,  2 Jan 2023 04:16:24 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 25A9E340CF;
        Mon,  2 Jan 2023 12:16:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1672661783; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lciet8dBeNbENoER71MTYvm/0HjOnWjldfsc9ARRDjA=;
        b=Z2NfHHv8LQE8LGsksDyHiOW7ia0MxN09WJmswZ/kTFOS9aQr05c15gzVV/IvmXU24Rwb14
        KGNk1inL0Kpw9jyq9NoyxsV2RaNf5qc5JQNdH0gSmdAdTCyaK0ev9XAYtOofDkyWz/bwCW
        Wp3j6L60XelvZ9arl4vmM28F0XQJ8wQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1672661783;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lciet8dBeNbENoER71MTYvm/0HjOnWjldfsc9ARRDjA=;
        b=4H/d29qLIAm2FxBDK6Y9UKKprqkrOYEYiJO0Koqjk75JTdj9yWFNV8XncwVRN6n+qczRl2
        2zu2+S4+7i/16qAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 09691139C8;
        Mon,  2 Jan 2023 12:16:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 5lpGAhfLsmMcCwAAMHmgww
        (envelope-from <jack@suse.cz>); Mon, 02 Jan 2023 12:16:23 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 2C671A073E; Mon,  2 Jan 2023 13:16:22 +0100 (CET)
Date:   Mon, 2 Jan 2023 13:16:22 +0100
From:   Jan Kara <jack@suse.cz>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Theodore Ts'o <tytso@mit.edu>, Jan Kara <jack@suse.com>,
        Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        Mark Fasheh <mark@fasheh.com>,
        Joel Becker <jlbec@evilplan.org>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        ntfs3@lists.linux.dev, ocfs2-devel@oss.oracle.com,
        linux-mm@kvack.org
Subject: Re: [PATCH 6/6] mm: remove generic_writepages
Message-ID: <20230102121622.4xq4mn6gvqa2ksjx@quack3>
References: <20221229161031.391878-1-hch@lst.de>
 <20221229161031.391878-7-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221229161031.391878-7-hch@lst.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 29-12-22 06:10:31, Christoph Hellwig wrote:
> Now that all external callers are gone, just fold it into do_writepages.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks good to me. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza


> ---
>  include/linux/writeback.h |  2 --
>  mm/page-writeback.c       | 53 +++++++++++----------------------------
>  2 files changed, 15 insertions(+), 40 deletions(-)
> 
> diff --git a/include/linux/writeback.h b/include/linux/writeback.h
> index 06f9291b6fd512..2554b71765e9d0 100644
> --- a/include/linux/writeback.h
> +++ b/include/linux/writeback.h
> @@ -369,8 +369,6 @@ bool wb_over_bg_thresh(struct bdi_writeback *wb);
>  typedef int (*writepage_t)(struct page *page, struct writeback_control *wbc,
>  				void *data);
>  
> -int generic_writepages(struct address_space *mapping,
> -		       struct writeback_control *wbc);
>  void tag_pages_for_writeback(struct address_space *mapping,
>  			     pgoff_t start, pgoff_t end);
>  int write_cache_pages(struct address_space *mapping,
> diff --git a/mm/page-writeback.c b/mm/page-writeback.c
> index ad608ef2a24365..dfeeceebba0ae0 100644
> --- a/mm/page-writeback.c
> +++ b/mm/page-writeback.c
> @@ -2526,12 +2526,8 @@ int write_cache_pages(struct address_space *mapping,
>  }
>  EXPORT_SYMBOL(write_cache_pages);
>  
> -/*
> - * Function used by generic_writepages to call the real writepage
> - * function and set the mapping flags on error
> - */
> -static int __writepage(struct page *page, struct writeback_control *wbc,
> -		       void *data)
> +static int writepage_cb(struct page *page, struct writeback_control *wbc,
> +		void *data)
>  {
>  	struct address_space *mapping = data;
>  	int ret = mapping->a_ops->writepage(page, wbc);
> @@ -2539,34 +2535,6 @@ static int __writepage(struct page *page, struct writeback_control *wbc,
>  	return ret;
>  }
>  
> -/**
> - * generic_writepages - walk the list of dirty pages of the given address space and writepage() all of them.
> - * @mapping: address space structure to write
> - * @wbc: subtract the number of written pages from *@wbc->nr_to_write
> - *
> - * This is a library function, which implements the writepages()
> - * address_space_operation.
> - *
> - * Return: %0 on success, negative error code otherwise
> - */
> -int generic_writepages(struct address_space *mapping,
> -		       struct writeback_control *wbc)
> -{
> -	struct blk_plug plug;
> -	int ret;
> -
> -	/* deal with chardevs and other special file */
> -	if (!mapping->a_ops->writepage)
> -		return 0;
> -
> -	blk_start_plug(&plug);
> -	ret = write_cache_pages(mapping, wbc, __writepage, mapping);
> -	blk_finish_plug(&plug);
> -	return ret;
> -}
> -
> -EXPORT_SYMBOL(generic_writepages);
> -
>  int do_writepages(struct address_space *mapping, struct writeback_control *wbc)
>  {
>  	int ret;
> @@ -2577,11 +2545,20 @@ int do_writepages(struct address_space *mapping, struct writeback_control *wbc)
>  	wb = inode_to_wb_wbc(mapping->host, wbc);
>  	wb_bandwidth_estimate_start(wb);
>  	while (1) {
> -		if (mapping->a_ops->writepages)
> +		if (mapping->a_ops->writepages) {
>  			ret = mapping->a_ops->writepages(mapping, wbc);
> -		else
> -			ret = generic_writepages(mapping, wbc);
> -		if ((ret != -ENOMEM) || (wbc->sync_mode != WB_SYNC_ALL))
> +		} else if (mapping->a_ops->writepage) {
> +			struct blk_plug plug;
> +
> +			blk_start_plug(&plug);
> +			ret = write_cache_pages(mapping, wbc, writepage_cb,
> +						mapping);
> +			blk_finish_plug(&plug);
> +		} else {
> +			/* deal with chardevs and other special files */
> +			ret = 0;
> +		}
> +		if (ret != -ENOMEM || wbc->sync_mode != WB_SYNC_ALL)
>  			break;
>  
>  		/*
> -- 
> 2.35.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
