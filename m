Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32218718E9C
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Jun 2023 00:37:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230272AbjEaWhH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 31 May 2023 18:37:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230267AbjEaWhF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 31 May 2023 18:37:05 -0400
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com [IPv6:2001:4860:4864:20::2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B398F193
        for <linux-fsdevel@vger.kernel.org>; Wed, 31 May 2023 15:37:02 -0700 (PDT)
Received: by mail-oa1-x2f.google.com with SMTP id 586e51a60fabf-19f8af9aa34so300200fac.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 31 May 2023 15:37:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20221208.gappssmtp.com; s=20221208; t=1685572622; x=1688164622;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=n3rg9Z09BIl1aIQXz+8gKGwERErjA3Juhruo9wqB2U8=;
        b=wiX6dI4YQSE++dSI7EaUMDXFauekYMtpXk1nx5uvMyo25lrfQV5e1AHiqUl7vtZsLM
         IMsq1Z5rdgpxryXDQhmnhU6BFy28pl/Iq9YtSyYwXYAcruYkWNkt+idLzDGSUr3FKl5P
         71TZQmlrc+8IX5Yr3GC2L31c13tTWeaseGd8GHnF4nTP4gHfGL9GdiqTtVrRnTBPX75w
         rNqYxEQM0IHHwuhf+2DOFuAeL1Rj0RWSYjbBRij29aY9ImveoAP+ZDW+DAQgL+Nrskc1
         zy8HdL5xcRs5rA3RogSXnzYu4aaVp7d7YXAaBJhIgs7D1bBPAkB/rkpyaOArHbaD1136
         cQVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685572622; x=1688164622;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n3rg9Z09BIl1aIQXz+8gKGwERErjA3Juhruo9wqB2U8=;
        b=AnGWXMXFQfeyijqIZRaZlX/orhMs/rJ8mliaev+J4e0Dmm8ppB0IxnzitrUDM2wdKd
         VADuK8sNRb5yL58Pl+Xjv2Xy+XwjeuTo1zEaw/orOUOx+7/7rrDcOjzu8drucoe1Z7UT
         0rESiV5kOtfdaUCOanHTpYvnO3R04gUyWZLGFcY9ih5xilTNzPeK/BzUXwvPWNGb9lUx
         rvEHfOXXh1Ml1i+oNYG50m8dbGGwsF+wmp8SuZ+8gHDRv2VkcG9IvAaDB7iaNU5zjLpM
         MwX85/QFt6UROizb/TJzvLVgu51aYBXX8le/OhmN/EYnPxKO7fX0Y0GVJ8hm0R9Q+hlE
         en3A==
X-Gm-Message-State: AC+VfDypPMZyeQjv9/FRieRdU0ged+KUQzGm5TuS0qxQ/uSlZ/swETVR
        hICGyyMi4QTJ2DVZahYL68U8mA==
X-Google-Smtp-Source: ACHHUZ7R3wjvNkmWSbL60I9ylavOeUTJY88g1+p1PDiLJE+SHWNaI13IUYsVS+xjUDM8kOkAj2iUNQ==
X-Received: by 2002:a05:6808:1496:b0:398:2f85:ff7f with SMTP id e22-20020a056808149600b003982f85ff7fmr6512900oiw.50.1685572621938;
        Wed, 31 May 2023 15:37:01 -0700 (PDT)
Received: from dread.disaster.area (pa49-179-0-188.pa.nsw.optusnet.com.au. [49.179.0.188])
        by smtp.gmail.com with ESMTPSA id e12-20020a170902784c00b001b034fafaefsm1948337pln.38.2023.05.31.15.37.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 May 2023 15:37:01 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
        (envelope-from <david@fromorbit.com>)
        id 1q4UR9-006HGI-0M;
        Thu, 01 Jun 2023 08:36:59 +1000
Date:   Thu, 1 Jun 2023 08:36:59 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Hannes Reinecke <hare@suse.de>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Ming Lei <ming.lei@redhat.com>, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        dm-devel@redhat.com, Song Liu <song@kernel.org>,
        linux-raid@vger.kernel.org, Mike Snitzer <snitzer@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Dave Kleikamp <shaggy@kernel.org>,
        jfs-discussion@lists.sourceforge.net, cluster-devel@redhat.com,
        Bob Peterson <rpeterso@redhat.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Mikulas Patocka <mpatocka@redhat.com>, gouha7@uniontech.com
Subject: Re: [PATCH v7 19/20] fs: iomap: use bio_add_folio_nofail where
 possible
Message-ID: <ZHfMC86ktyLtIxNb@dread.disaster.area>
References: <cover.1685532726.git.johannes.thumshirn@wdc.com>
 <58fa893c24c67340a63323f09a179fefdca07f2a.1685532726.git.johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <58fa893c24c67340a63323f09a179fefdca07f2a.1685532726.git.johannes.thumshirn@wdc.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, May 31, 2023 at 04:50:42AM -0700, Johannes Thumshirn wrote:
> When the iomap buffered-io code can't add a folio to a bio, it allocates a
> new bio and adds the folio to that one. This is done using bio_add_folio(),
> but doesn't check for errors.
> 
> As adding a folio to a newly created bio can't fail, use the newly
> introduced bio_add_folio_nofail() function.
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> ---
>  fs/iomap/buffered-io.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index 063133ec77f4..0edab9deae2a 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -312,7 +312,7 @@ static loff_t iomap_readpage_iter(const struct iomap_iter *iter,
>  			ctx->bio->bi_opf |= REQ_RAHEAD;
>  		ctx->bio->bi_iter.bi_sector = sector;
>  		ctx->bio->bi_end_io = iomap_read_end_io;
> -		bio_add_folio(ctx->bio, folio, plen, poff);
> +		bio_add_folio_nofail(ctx->bio, folio, plen, poff);
>  	}
>  
>  done:
> @@ -539,7 +539,7 @@ static int iomap_read_folio_sync(loff_t block_start, struct folio *folio,
>  
>  	bio_init(&bio, iomap->bdev, &bvec, 1, REQ_OP_READ);
>  	bio.bi_iter.bi_sector = iomap_sector(iomap, block_start);
> -	bio_add_folio(&bio, folio, plen, poff);
> +	bio_add_folio_nofail(&bio, folio, plen, poff);
>  	return submit_bio_wait(&bio);
>  }
>  
> @@ -1582,7 +1582,7 @@ iomap_add_to_ioend(struct inode *inode, loff_t pos, struct folio *folio,
>  
>  	if (!bio_add_folio(wpc->ioend->io_bio, folio, len, poff)) {
>  		wpc->ioend->io_bio = iomap_chain_bio(wpc->ioend->io_bio);
> -		bio_add_folio(wpc->ioend->io_bio, folio, len, poff);
> +		bio_add_folio_nofail(wpc->ioend->io_bio, folio, len, poff);
>  	}

We lose adjacent page merging with this change.

We've had performance regressions in the past that have been
attributed to either the page allocator not handing out sequential
adjacent pages for sequential writes and/or bios not merging
adjacent pages. Some hardware is much more performant when it only
has to do a single large DMA instead of (potentially) hundreds of
single page DMAs for the same amount of data...

What performance regression testing has been done on this change?

-Dave.
-- 
Dave Chinner
david@fromorbit.com
