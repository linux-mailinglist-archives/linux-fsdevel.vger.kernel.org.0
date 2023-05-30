Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06CB57168E7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 May 2023 18:11:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233387AbjE3QLf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 30 May 2023 12:11:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231256AbjE3QLd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 30 May 2023 12:11:33 -0400
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2A0C13D
        for <linux-fsdevel@vger.kernel.org>; Tue, 30 May 2023 09:10:17 -0700 (PDT)
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-626117a8610so15885286d6.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 30 May 2023 09:10:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685463017; x=1688055017;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Irk/8GUWmwLYWfm2Lio5fOal+y0GOgImfVphQa7iGfs=;
        b=bN9dGcZ1hdC6k34rh5scm2sIehbYfy2UpFHrLcy9BSFdZIanrCm4ij8HefvoLZjCK2
         y74M76O/XBZ9KdYUA9dHmyO+cuqlCsPHCA6lXWs36JIG5JtueaMyjTQDNp/MRprzDb3L
         KrBB6NVThOg3NSeERkVzBWZaem/gd05Xdi65EARLC2dDWfkskqyY82B7lU4cTl5iUgre
         NsfqcEH+hbgl9vJOQyWyEhXC8LRAA5KwwX4AVMLhloVB7KMGVbrqVHjrP3dty5djqSZf
         PZCV9w3nLF2ppxaai72aQsp712k8W36hgu5ls+l9sz+z4lk/ukGfHy7czpzQNzIB/3+1
         V+zA==
X-Gm-Message-State: AC+VfDzGfAHKZCJ+JkTINd+PhcYTKWeH5LjZuypT8bSC8Cik7FAwGkhl
        P1+QO9XgNhemOM6njdOtZn7j
X-Google-Smtp-Source: ACHHUZ56MECtsjcewLbFVxD7Rkez1npKixqOW82Zsid/kEpDsAmjiM2JZkfOYT0pMaVRxjwqyQggQQ==
X-Received: by 2002:ad4:5b8d:0:b0:625:af4b:4162 with SMTP id 13-20020ad45b8d000000b00625af4b4162mr2721624qvp.14.1685463016980;
        Tue, 30 May 2023 09:10:16 -0700 (PDT)
Received: from localhost (pool-68-160-166-30.bstnma.fios.verizon.net. [68.160.166.30])
        by smtp.gmail.com with ESMTPSA id w20-20020a0562140b3400b0062381fa97c5sm898935qvj.92.2023.05.30.09.10.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 May 2023 09:10:16 -0700 (PDT)
Date:   Tue, 30 May 2023 12:10:15 -0400
From:   Mike Snitzer <snitzer@kernel.org>
To:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Dave Kleikamp <shaggy@kernel.org>,
        jfs-discussion@lists.sourceforge.net, Song Liu <song@kernel.org>,
        dm-devel@redhat.com, Christoph Hellwig <hch@lst.de>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Matthew Wilcox <willy@infradead.org>, cluster-devel@redhat.com,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Ming Lei <ming.lei@redhat.com>, linux-raid@vger.kernel.org,
        Bob Peterson <rpeterso@redhat.com>,
        Mikulas Patocka <mpatocka@redhat.com>,
        linux-block@vger.kernel.org,
        Damien Le Moal <damien.lemoal@wdc.com>, gouhao@uniontech.com,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v6 16/20] dm-crypt: check if adding pages to clone bio
 fails
Message-ID: <ZHYf5+ocDL0hsud6@redhat.com>
References: <cover.1685461490.git.johannes.thumshirn@wdc.com>
 <e1c7ed59e2d2b69567ef2d9925fa997ecb7b4822.1685461490.git.johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e1c7ed59e2d2b69567ef2d9925fa997ecb7b4822.1685461490.git.johannes.thumshirn@wdc.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, May 30 2023 at 11:49P -0400,
Johannes Thumshirn <johannes.thumshirn@wdc.com> wrote:

> Check if adding pages to clone bio fails and if it does retry with
> reclaim. This mirrors the behaviour of page allocation in
> crypt_alloc_buffer().

Nope.

> This way we can mark bio_add_pages as __must_check.
> 
> Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>

The above patch header doesn't reflect the code.

I also think __bio_add_page should be used, like my racey reply to
Mikulas vs your v6 patchbomb said, please see:
https://listman.redhat.com/archives/dm-devel/2023-May/054388.html

Thanks,
Mike

> ---
>  drivers/md/dm-crypt.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/md/dm-crypt.c b/drivers/md/dm-crypt.c
> index 8b47b913ee83..0dd231e61757 100644
> --- a/drivers/md/dm-crypt.c
> +++ b/drivers/md/dm-crypt.c
> @@ -1693,7 +1693,10 @@ static struct bio *crypt_alloc_buffer(struct dm_crypt_io *io, unsigned int size)
>  
>  		len = (remaining_size > PAGE_SIZE) ? PAGE_SIZE : remaining_size;
>  
> -		bio_add_page(clone, page, len, 0);
> +		if (!bio_add_page(clone, page, len, 0)) {
> +			WARN_ONCE(1, "Adding page to bio failed\n");
> +			return NULL;
> +		}
>  
>  		remaining_size -= len;
>  	}
> -- 
> 2.40.1
> 
> --
> dm-devel mailing list
> dm-devel@redhat.com
> https://listman.redhat.com/mailman/listinfo/dm-devel
> 
