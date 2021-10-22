Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF1524373CC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Oct 2021 10:43:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232306AbhJVIpr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Oct 2021 04:45:47 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:37882 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231991AbhJVIpr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Oct 2021 04:45:47 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 36A742199D;
        Fri, 22 Oct 2021 08:43:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1634892209; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7MPkk1brJOSm3Yjvf8eNKc5Xgdk5rE0s6Q0mFNwK3L0=;
        b=ZMgBrFjusXhaQPvK4lMGfW8pXzkvKAK+UxUiULhKMhxkYb1mTnk8Zdhzg1GwrOyWIxHWkc
        kdzWCb2bwehDGt+xBCWTiTp1Z9JGCXx54IVfYNFRC8zcgnQsdXrl0eKT+yqI5o61q0bhxm
        wUn3zesrnmC1osXdKtqdsHWOaulzil0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1634892209;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7MPkk1brJOSm3Yjvf8eNKc5Xgdk5rE0s6Q0mFNwK3L0=;
        b=TPdYz8+hWK/Ce1UG2jCycUaJtBnbYQH4tCu3Vq3bhGRhGxbe9zhN1RiuqAVr+EUmo9Rxpz
        5D5RHngYDLqEVaBA==
Received: from quack2.suse.cz (unknown [10.100.224.230])
        by relay2.suse.de (Postfix) with ESMTP id 2849BA3B83;
        Fri, 22 Oct 2021 08:43:29 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id B2C731E11B6; Fri, 22 Oct 2021 10:43:25 +0200 (CEST)
Date:   Fri, 22 Oct 2021 10:43:25 +0200
From:   Jan Kara <jack@suse.cz>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>, Jan Kara <jack@suse.cz>,
        linux-mtd@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH 2/5] mtd: call bdi_unregister explicitly
Message-ID: <20211022084325.GC1026@quack2.suse.cz>
References: <20211021124441.668816-1-hch@lst.de>
 <20211021124441.668816-3-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211021124441.668816-3-hch@lst.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 21-10-21 14:44:38, Christoph Hellwig wrote:
> Call bdi_unregister explicitly instead of relying on the automatic
> unregistration.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  drivers/mtd/mtdcore.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/mtd/mtdcore.c b/drivers/mtd/mtdcore.c
> index c8fd7f758938b..c904e23c82379 100644
> --- a/drivers/mtd/mtdcore.c
> +++ b/drivers/mtd/mtdcore.c
> @@ -2409,6 +2409,7 @@ static void __exit cleanup_mtd(void)
>  	if (proc_mtd)
>  		remove_proc_entry("mtd", NULL);
>  	class_unregister(&mtd_class);
> +	bdi_unregister(mtd_bdi);
>  	bdi_put(mtd_bdi);
>  	idr_destroy(&mtd_idr);
>  }
> -- 
> 2.30.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
