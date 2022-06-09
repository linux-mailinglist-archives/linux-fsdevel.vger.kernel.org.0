Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 654635452FB
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Jun 2022 19:31:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344972AbiFIRbY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Jun 2022 13:31:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344847AbiFIRbX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Jun 2022 13:31:23 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0708523CCFD;
        Thu,  9 Jun 2022 10:31:20 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 977FF1FEBF;
        Thu,  9 Jun 2022 17:31:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1654795879; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7tKV3fosHA0ovCWHaUSEHmM/GS0HGXppzSqUsTLCZaU=;
        b=ChJxJKhoUmWt7htAN7/HVo8ascgSHvj5di7vHEaEjwWicJP7utjPzhuycDwjuZFV64T97p
        0qcF9f4TNfYp3+d/6bLswFFccG/ppqFoD6pZdWAzPP2fqaOCnZWl1YVyY3ze1RqHspSilM
        zOwWBwGyk/ACGBClS9RfoF20eRQQwhM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1654795879;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7tKV3fosHA0ovCWHaUSEHmM/GS0HGXppzSqUsTLCZaU=;
        b=mwo6kTKQ7+/HZNlswVwvxMxYNzdMbWvu7YepBvG4hr5sUhPTTe1VCrmdmfXo/XQzGVyft8
        2sx9boi4uho6RWBw==
Received: from quack3.suse.cz (unknown [10.163.28.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 8386A2C141;
        Thu,  9 Jun 2022 17:31:19 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 2FFAFA0633; Thu,  9 Jun 2022 19:31:19 +0200 (CEST)
Date:   Thu, 9 Jun 2022 19:31:19 +0200
From:   Jan Kara <jack@suse.cz>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.com>,
        Dave Kleikamp <shaggy@kernel.org>, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        jfs-discussion@lists.sourceforge.net
Subject: Re: [PATCH 4/5] fs: don't call ->writepage from __mpage_writepage
Message-ID: <20220609173119.b34yp6ey6ybokfdl@quack3.lan>
References: <20220608150451.1432388-1-hch@lst.de>
 <20220608150451.1432388-5-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220608150451.1432388-5-hch@lst.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 08-06-22 17:04:50, Christoph Hellwig wrote:
> All callers of mpage_writepage use block_write_full_page as their
> ->writepage implementation, so hard code that.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Similarly here NTFS (fs/ntfs3/) seems to have some non-trivial stuff besides
block_write_full_page()...

								Honza

> ---
>  fs/mpage.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/mpage.c b/fs/mpage.c
> index 31a97a0acf5f5..a354ef2b4b4eb 100644
> --- a/fs/mpage.c
> +++ b/fs/mpage.c
> @@ -624,7 +624,7 @@ static int __mpage_writepage(struct page *page, struct writeback_control *wbc,
>  	/*
>  	 * The caller has a ref on the inode, so *mapping is stable
>  	 */
> -	ret = mapping->a_ops->writepage(page, wbc);
> +	ret = block_write_full_page(page, mpd->get_block, wbc);
>  	mapping_set_error(mapping, ret);
>  out:
>  	mpd->bio = bio;
> -- 
> 2.30.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
