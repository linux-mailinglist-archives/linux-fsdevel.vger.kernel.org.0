Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4ECEE3D5A64
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jul 2021 15:33:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233671AbhGZMwj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Jul 2021 08:52:39 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:41124 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230421AbhGZMwi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Jul 2021 08:52:38 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 400AC1FE8D;
        Mon, 26 Jul 2021 13:33:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1627306386; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=k5UcEjJxBMV/bkLye4nV+hqaWSEY92/oNqvr5MMGiU8=;
        b=RedvTherUATMd7Vt0N4o3h1uqsZ3NaN4CCWCgxVJV3eLumuT4Akj2wAmZBgiQlUl4kGKi4
        wBGPYS4o4uE5Xw+Zi8vrGoWDHrWWUZ5VDbHu34rdM0afbFuiVAIlMsZSJ0O6Yvb78TReSg
        JbFNueofdDpxrygGq4kfP5DrKinYcjs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1627306386;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=k5UcEjJxBMV/bkLye4nV+hqaWSEY92/oNqvr5MMGiU8=;
        b=PFrzuyYE1rqEiF/ZEUPnK2NXuLnDPDYO7ho1/sb55h0enK4mj/BTWGw45L8ZZ9TjjOtmL+
        4hNnAxsnfKJBPtDw==
Received: from quack2.suse.cz (unknown [10.100.200.198])
        by relay2.suse.de (Postfix) with ESMTP id 3324CA3B8B;
        Mon, 26 Jul 2021 13:33:06 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 1198F1E3B13; Mon, 26 Jul 2021 15:33:06 +0200 (CEST)
Date:   Mon, 26 Jul 2021 15:33:06 +0200
From:   Jan Kara <jack@suse.cz>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jan Kara <jack@suse.com>,
        Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 1/4] ext2: make ext2_iomap_ops available unconditionally
Message-ID: <20210726133306.GD20621@quack2.suse.cz>
References: <20210720133341.405438-1-hch@lst.de>
 <20210720133341.405438-2-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210720133341.405438-2-hch@lst.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue 20-07-21 15:33:38, Christoph Hellwig wrote:
> ext2_iomap_ops will be used for the FIEMAP support going forward,
> so make it available unconditionally.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext2/inode.c | 5 -----
>  1 file changed, 5 deletions(-)
> 
> diff --git a/fs/ext2/inode.c b/fs/ext2/inode.c
> index dadb121beb22..3e9a04770f49 100644
> --- a/fs/ext2/inode.c
> +++ b/fs/ext2/inode.c
> @@ -799,7 +799,6 @@ int ext2_get_block(struct inode *inode, sector_t iblock,
>  
>  }
>  
> -#ifdef CONFIG_FS_DAX
>  static int ext2_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
>  		unsigned flags, struct iomap *iomap, struct iomap *srcmap)
>  {
> @@ -852,10 +851,6 @@ const struct iomap_ops ext2_iomap_ops = {
>  	.iomap_begin		= ext2_iomap_begin,
>  	.iomap_end		= ext2_iomap_end,
>  };
> -#else
> -/* Define empty ops for !CONFIG_FS_DAX case to avoid ugly ifdefs */
> -const struct iomap_ops ext2_iomap_ops;
> -#endif /* CONFIG_FS_DAX */
>  
>  int ext2_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
>  		u64 start, u64 len)
> -- 
> 2.30.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
