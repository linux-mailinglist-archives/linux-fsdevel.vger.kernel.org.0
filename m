Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 225727167E8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 May 2023 17:51:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230375AbjE3Pvl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 30 May 2023 11:51:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232733AbjE3Pup (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 30 May 2023 11:50:45 -0400
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22F3FEC
        for <linux-fsdevel@vger.kernel.org>; Tue, 30 May 2023 08:49:56 -0700 (PDT)
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-75b1975ea18so262107485a.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 30 May 2023 08:49:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685461795; x=1688053795;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ef9UXKlo6HOEzGKOWoRQOx3X1Mv/S3dqqbfR/aqcj1E=;
        b=EMOA1rDYz+ZmDBe7askj85gnLKl1WSy1PmjV5GAzGZCATo5dvYS7iGKE5tKP4JqYAu
         wQD/mSR8byk30+Gnb57oXDgfd9yafYdpm68fCLRA2jBPlj4bgz9jevueP/ybAntM/NXa
         VaqczDvCZ8GLABGkMVT50NEw9zbQxVW72vYcGmxDv4IlvAWuZMV5c1W9pUj1TN2fbnPH
         NKJy1B1MKe2aDcN/PlmajRn36Yje1dXzXodikDg3MFwDc6ElKConpdRw/I0+z477irjr
         FMzc8pphXl+CVWVLnaYH40hBn8uRzJBkCPYRr53FjWVMt+0+WOFpK2uscmo+ow4ZFY/z
         6TLw==
X-Gm-Message-State: AC+VfDyiVqJ2cEwfTasfIpTegN9doBMRGP1tnrbyASNcNmj4NbFr+RWk
        1bUp7LPpSAGpEhETTraoeB4X
X-Google-Smtp-Source: ACHHUZ7pliMoFycu95ZOXiwcTabY+u351+caH9+LwJwAEUbICb4vYuE61O+IVefjdSw8mai/KPkDog==
X-Received: by 2002:a05:620a:8084:b0:75c:c99d:e416 with SMTP id ef4-20020a05620a808400b0075cc99de416mr2289656qkb.49.1685461794842;
        Tue, 30 May 2023 08:49:54 -0700 (PDT)
Received: from localhost (pool-68-160-166-30.bstnma.fios.verizon.net. [68.160.166.30])
        by smtp.gmail.com with ESMTPSA id a23-20020a05620a16d700b0075b053ab66bsm4135656qkn.50.2023.05.30.08.49.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 May 2023 08:49:54 -0700 (PDT)
Date:   Tue, 30 May 2023 11:49:53 -0400
From:   Mike Snitzer <snitzer@kernel.org>
To:     Mikulas Patocka <mpatocka@redhat.com>
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        "axboe @ kernel . dk" <axboe@kernel.dk>, shaggy@kernel.org,
        damien.lemoal@wdc.com, cluster-devel@redhat.com, kch@nvidia.com,
        agruenba@redhat.com, linux-mm@kvack.org,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        jfs-discussion@lists.sourceforge.net, willy@infradead.org,
        ming.lei@redhat.com, linux-block@vger.kernel.org, song@kernel.org,
        dm-devel@redhat.com, rpeterso@redhat.com,
        linux-fsdevel@vger.kernel.org, linux-raid@vger.kernel.org,
        hch@lst.de
Subject: Re: [PATCH v5 16/20] dm-crypt: check if adding pages to clone bio
 fails
Message-ID: <ZHYbIYxGbcXbpvIK@redhat.com>
References: <20230502101934.24901-1-johannes.thumshirn@wdc.com>
 <20230502101934.24901-17-johannes.thumshirn@wdc.com>
 <alpine.LRH.2.21.2305301045220.3943@file01.intranet.prod.int.rdu2.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LRH.2.21.2305301045220.3943@file01.intranet.prod.int.rdu2.redhat.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, May 30 2023 at 11:13P -0400,
Mikulas Patocka <mpatocka@redhat.com> wrote:

> 
> 
> On Tue, 2 May 2023, Johannes Thumshirn wrote:
> 
> > Check if adding pages to clone bio fails and if it does retry with
> > reclaim. This mirrors the behaviour of page allocation in
> > crypt_alloc_buffer().
> > 
> > This way we can mark bio_add_pages as __must_check.
> > 
> > Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
> > Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> > ---
> >  drivers/md/dm-crypt.c | 9 ++++++++-
> >  1 file changed, 8 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/md/dm-crypt.c b/drivers/md/dm-crypt.c
> > index 8b47b913ee83..b234dc089cee 100644
> > --- a/drivers/md/dm-crypt.c
> > +++ b/drivers/md/dm-crypt.c
> > @@ -1693,7 +1693,14 @@ static struct bio *crypt_alloc_buffer(struct dm_crypt_io *io, unsigned int size)
> >  
> >  		len = (remaining_size > PAGE_SIZE) ? PAGE_SIZE : remaining_size;
> >  
> > -		bio_add_page(clone, page, len, 0);
> > +		if (!bio_add_page(clone, page, len, 0)) {
> > +			mempool_free(page, &cc->page_pool);
> > +			crypt_free_buffer_pages(cc, clone);
> > +			bio_put(clone);
> > +			gfp_mask |= __GFP_DIRECT_RECLAIM;
> > +			goto retry;
> > +
> > +		}
> >  
> >  		remaining_size -= len;
> >  	}
> 
> Hi
> 
> I nack this. This just adds code that can't ever be executed.
> 
> dm-crypt already allocates enough entries in the vector (see "unsigned int 
> nr_iovecs = (size + PAGE_SIZE - 1) >> PAGE_SHIFT;"), so bio_add_page can't 
> fail.
> 
> If you want to add __must_check to bio_add_page, you should change the 
> dm-crypt code to:
> if (!bio_add_page(clone, page, len, 0)) {
> 	WARN(1, "this can't happen");
> 	return NULL;
> }
> and not write recovery code for a can't-happen case.

Thanks for the review Mikulas. But the proper way forward, in the
context of this patchset, is to simply change bio_add_page() to
__bio_add_page()

Subject becomes: "dm crypt: use __bio_add_page to add single page to clone bio"

And header can explain that "crypt_alloc_buffer() already allocates
enough entries in the clone bio's vector, so bio_add_page can't fail".

Mike
