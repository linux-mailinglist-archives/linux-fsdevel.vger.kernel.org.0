Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBCD3709B43
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 May 2023 17:24:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232339AbjESPYF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 19 May 2023 11:24:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232333AbjESPYA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 19 May 2023 11:24:00 -0400
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C81FE19B
        for <linux-fsdevel@vger.kernel.org>; Fri, 19 May 2023 08:23:14 -0700 (PDT)
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-3f38711680dso16970651cf.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 19 May 2023 08:23:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684509794; x=1687101794;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KQivtLqNJRG8EpR/lUW7uy3izlo40t0jANCAkNQxEPE=;
        b=j9KQGHKdJ6zdfGmO1ltbwOm9iYfIJk4cGqlUjYMV+Aa81k9qFFrI9i3Vm7zO9Mbp+u
         rMZ3KUUilugXTZThb7yZw8iRQXK3mh9lAe7n6EVcbFVxdKf/xuKXIFwt0rd4jynyrS5n
         1eeipa+aLc6ZWh99G6rk4+jYDQYvULP1ZtOaDimGnh2wD9W4wkPNVjMa79v6YwMwOZT6
         2gSHp/931xqNKfoM2zvC0vKZw+891ADdfVHqC8WAcC8CkCKvwfOC2vOwFGzTjH2m2GPu
         CFrsePJPgHU1Ex6K1kA31zCqIrhiytU2EyppZoSAkUACXk8tCs54DjVpj5i9I+rmUP94
         e68Q==
X-Gm-Message-State: AC+VfDwAmgep+899BgrdKEDNR35jVq+rNWsJO4YgNQ7NKOQAvVxhtekq
        7zWfvZMuue1VSayBxoSFaYHq
X-Google-Smtp-Source: ACHHUZ5KZDF2WuE+iLnjFEJ4qmC2nD5mUZp17EvZzOJDdFPHVvmlXVoj6ey88vsNHzWaS5Y6xHhQeQ==
X-Received: by 2002:a05:622a:192:b0:3f5:92b:eff9 with SMTP id s18-20020a05622a019200b003f5092beff9mr3992630qtw.46.1684509793876;
        Fri, 19 May 2023 08:23:13 -0700 (PDT)
Received: from localhost (pool-68-160-166-30.bstnma.fios.verizon.net. [68.160.166.30])
        by smtp.gmail.com with ESMTPSA id b28-20020a05620a127c00b0075941df3365sm1164925qkl.52.2023.05.19.08.23.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 May 2023 08:23:13 -0700 (PDT)
Date:   Fri, 19 May 2023 11:23:12 -0400
From:   Mike Snitzer <snitzer@kernel.org>
To:     Sarthak Kukreti <sarthakkukreti@chromium.org>,
        Joe Thornber <ejt@redhat.com>
Cc:     dm-devel@redhat.com, linux-block@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Theodore Ts'o <tytso@mit.edu>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Jason Wang <jasowang@redhat.com>,
        Bart Van Assche <bvanassche@google.com>,
        Christoph Hellwig <hch@infradead.org>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Brian Foster <bfoster@redhat.com>,
        Alasdair Kergon <agk@redhat.com>
Subject: Re: [PATCH v7 4/5] dm-thin: Add REQ_OP_PROVISION support
Message-ID: <ZGeUYESOQsZkOQ1Q@redhat.com>
References: <20230518223326.18744-1-sarthakkukreti@chromium.org>
 <20230518223326.18744-5-sarthakkukreti@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230518223326.18744-5-sarthakkukreti@chromium.org>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, May 18 2023 at  6:33P -0400,
Sarthak Kukreti <sarthakkukreti@chromium.org> wrote:

> dm-thinpool uses the provision request to provision
> blocks for a dm-thin device. dm-thinpool currently does not
> pass through REQ_OP_PROVISION to underlying devices.
> 
> For shared blocks, provision requests will break sharing and copy the
> contents of the entire block. Additionally, if 'skip_block_zeroing'
> is not set, dm-thin will opt to zero out the entire range as a part
> of provisioning.
> 
> Signed-off-by: Sarthak Kukreti <sarthakkukreti@chromium.org>
> ---
>  drivers/md/dm-thin.c | 74 +++++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 70 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/md/dm-thin.c b/drivers/md/dm-thin.c
> index 2b13c949bd72..f1b68b558cf0 100644
> --- a/drivers/md/dm-thin.c
> +++ b/drivers/md/dm-thin.c
> @@ -1245,8 +1247,8 @@ static int io_overlaps_block(struct pool *pool, struct bio *bio)
>  
>  static int io_overwrites_block(struct pool *pool, struct bio *bio)
>  {
> -	return (bio_data_dir(bio) == WRITE) &&
> -		io_overlaps_block(pool, bio);
> +	return (bio_data_dir(bio) == WRITE) && io_overlaps_block(pool, bio) &&
> +	       bio_op(bio) != REQ_OP_PROVISION;
>  }
>  
>  static void save_and_set_endio(struct bio *bio, bio_end_io_t **save,
> @@ -1394,6 +1396,9 @@ static void schedule_zero(struct thin_c *tc, dm_block_t virt_block,
>  	m->data_block = data_block;
>  	m->cell = cell;
>  
> +	if (bio && bio_op(bio) == REQ_OP_PROVISION)
> +		m->bio = bio;
> +
>  	/*
>  	 * If the whole block of data is being overwritten or we are not
>  	 * zeroing pre-existing data, we can issue the bio immediately.

This doesn't seem like the best way to address avoiding passdown of
provision bios (relying on process_prepared_mapping's implementation
that happens to do the right thing if m->bio set).  Doing so cascades
into relying on complete_overwrite_bio() happening to _not_ actually
being specific to "overwrite" bios.

I don't have a better suggestion yet but will look closer.  Just think
this needs to be formalized a bit more rather than it happening to
"just work".

Cc'ing Joe to see what he thinks too.  This is something we can clean
up with a follow-on patch though, so not a show-stopper for this
series.

Mike
