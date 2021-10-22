Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F7B24373F5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Oct 2021 10:51:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232319AbhJVIx0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Oct 2021 04:53:26 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:39008 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231336AbhJVIxZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Oct 2021 04:53:25 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 9B89D21983;
        Fri, 22 Oct 2021 08:51:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1634892667; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3ksDUVgqu2ftprEqG94t5YEqIhESu4luf8I6VL1DNaI=;
        b=CQcAvWNESWel7EWMMd6TsJoRUGnMm2kiFiobu0/FbxUPn2c1igWXUdRQEsysDf/Y98CAMJ
        Z/GoDzTkg0iXlPPQVBq6M9LYaF8fG/gzSrfJQQhKNlvXkTw31Qum7yoZicJZWBYE7wOLrL
        uSEx4p0+zkP9feR/ttBHn+5DNbLniwU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1634892667;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3ksDUVgqu2ftprEqG94t5YEqIhESu4luf8I6VL1DNaI=;
        b=0mAIE+x7gXvCG2AbrrlMVUmzDJdK4g0TNfeujizgWuIqKH/rrFsTdZj6Wjc1agzQMCBi1F
        dDBoPS9/BzjnWRBQ==
Received: from quack2.suse.cz (unknown [10.100.224.230])
        by relay2.suse.de (Postfix) with ESMTP id 86A6AA3B83;
        Fri, 22 Oct 2021 08:51:07 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 45DFD1E11B6; Fri, 22 Oct 2021 10:51:07 +0200 (CEST)
Date:   Fri, 22 Oct 2021 10:51:07 +0200
From:   Jan Kara <jack@suse.cz>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>, Jan Kara <jack@suse.cz>,
        linux-mtd@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH 4/5] mm: don't automatically unregister bdis
Message-ID: <20211022085107.GE1026@quack2.suse.cz>
References: <20211021124441.668816-1-hch@lst.de>
 <20211021124441.668816-5-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211021124441.668816-5-hch@lst.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 21-10-21 14:44:40, Christoph Hellwig wrote:
> All BDI users now unregister explicitly.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  mm/backing-dev.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/mm/backing-dev.c b/mm/backing-dev.c
> index 8a46a0a4b72fa..768e9ae489f66 100644
> --- a/mm/backing-dev.c
> +++ b/mm/backing-dev.c
> @@ -965,8 +965,7 @@ static void release_bdi(struct kref *ref)
>  	struct backing_dev_info *bdi =
>  			container_of(ref, struct backing_dev_info, refcnt);
>  
> -	if (test_bit(WB_registered, &bdi->wb.state))
> -		bdi_unregister(bdi);
> +	WARN_ON_ONCE(test_bit(WB_registered, &bdi->wb.state));
>  	WARN_ON_ONCE(bdi->dev);
>  	wb_exit(&bdi->wb);
>  	kfree(bdi);
> -- 
> 2.30.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
