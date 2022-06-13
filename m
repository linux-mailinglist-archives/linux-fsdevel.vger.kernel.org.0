Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1F7B5492D7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Jun 2022 18:31:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356114AbiFMLtv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 13 Jun 2022 07:49:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356404AbiFMLtC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 13 Jun 2022 07:49:02 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24547240B8;
        Mon, 13 Jun 2022 03:53:04 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 1C97B1F8AB;
        Mon, 13 Jun 2022 10:53:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1655117583; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XqTpxE8yxYYRD/ZdpkztnOS2u2fkB5g/9Dmp+zple7w=;
        b=SUSZ8nM3O4EyRpbT5YkFU0clddDZEOrRDp7kMrJTnNsatDMQYu6Jdf8atSklUx8PMJvjok
        ZZmOd5Fylbz2Vn7bGUmt1/2cci8ItL0gMon9ieGf8p1zgynEt4q/fFHToDQdxk+aAgUN4P
        zzOJ/CkyJqeWhUedpVtWXdeiXDyxqBE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1655117583;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XqTpxE8yxYYRD/ZdpkztnOS2u2fkB5g/9Dmp+zple7w=;
        b=86VBSlEwzD3hC55rA05ME4jXwgF4tz+a4fJiTsnx25nzTsv9kQ8GiUfY1EZyIuzDNwksJK
        mTvFTSRvEvEBr6CA==
Received: from quack3.suse.cz (unknown [10.163.28.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 095632C141;
        Mon, 13 Jun 2022 10:53:03 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id A3C1CA0634; Mon, 13 Jun 2022 12:53:02 +0200 (CEST)
Date:   Mon, 13 Jun 2022 12:53:02 +0200
From:   Jan Kara <jack@suse.cz>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.com>,
        Dave Kleikamp <shaggy@kernel.org>,
        Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, jfs-discussion@lists.sourceforge.net,
        ntfs3@lists.linux.dev
Subject: Re: [PATCH 5/6] fs: don't call ->writepage from __mpage_writepage
Message-ID: <20220613105302.pmtqxjbfwmtzkgjh@quack3.lan>
References: <20220613053715.2394147-1-hch@lst.de>
 <20220613053715.2394147-6-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220613053715.2394147-6-hch@lst.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon 13-06-22 07:37:14, Christoph Hellwig wrote:
> All callers of mpage_writepage use block_write_full_page as their
> ->writepage implementation when called from mpage_writepages
> (although for ntfs3 this is obsfucated a bit).
> 
> Just call block_write_full_page directly instead of going through
> the ->writepage indirection.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Yeah, ntfs3 is not completely obvious but I agree we should not get to the
non-trivial case of ntfs_writepage() from mpage_writepages() now. Feel free
to add:

Reviewed-by: Jan Kara <jack@suse.cz>

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
