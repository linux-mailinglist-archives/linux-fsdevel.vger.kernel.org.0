Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AA202FC9C2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Jan 2021 05:08:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726672AbhATEHc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Jan 2021 23:07:32 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:42819 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729162AbhATEH0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Jan 2021 23:07:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611115560;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AywvAsEXQ6QfOLvyJDQnLT2m8SbrEucZASIOkJ5VmEo=;
        b=f+QPaZznXs5t6FOr10cGKw9/x2RQWMQTDSsKCiEtETaRWlcKpjw6zZKavGJ87CdeiGVG2J
        gh/jY7UoPdHvJe7Lxd7N2BYBnpuc7usnpz8QZA4QuLTPMc/T+zv+T1MAq3/tTzzwQtry3g
        ugRu3VXvMzM7kzJ5P5nJ2JBUNw4p8yM=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-439-hxDNGuoJNNKQHHRvbzRgJg-1; Tue, 19 Jan 2021 23:05:56 -0500
X-MC-Unique: hxDNGuoJNNKQHHRvbzRgJg-1
Received: by mail-pl1-f199.google.com with SMTP id y5so15573592plr.19
        for <linux-fsdevel@vger.kernel.org>; Tue, 19 Jan 2021 20:05:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=AywvAsEXQ6QfOLvyJDQnLT2m8SbrEucZASIOkJ5VmEo=;
        b=QQOCSDiHViBOg7W3TBDP4xOoU9Jhw5LaVSPEC8RG5GKazsOJmrL6OWB8rG6kQndeQf
         Gs9f+KW5GQ1HXbhH7arUb4MzltsMLoQwyRvoV4KJ9ZqOl9ck3IWPEhdw/6b8AJnW8gKU
         xm/LgphpOCLTATToFILWmTMe2zgiYmO8toeJfxj33Lc/dMQbb07zMIZ7GluiizkkxHIq
         Rs96WSlsSLwrJ35pzsP3UaXkROV8/9wdJDTlT9BXfsbLBwvczxsWrAQHwN0iG+l4pz/s
         ohdNoj+bIyQ/xEhfa5+vRNmL6VManubF2dzqKsP4IAtRiIC2g3UiwQqiH7okorV9Umo/
         tUzA==
X-Gm-Message-State: AOAM531O/MVWDT5ifE7hGX4JjAE6WhMmj8a2C3azpFr/+sLU0+DTV/w7
        1/rPCeKR7yRduJqdanxXTTapyfkPaOiVWEI1aaPlfWpgI4H49fGHeRln8HC4Z5GH2o5rlE03wOD
        YmxVc4V29bFnutuswhPoFI8AjlA==
X-Received: by 2002:a17:90b:e15:: with SMTP id ge21mr3208215pjb.185.1611115555706;
        Tue, 19 Jan 2021 20:05:55 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy5B+6ZbSBY1zlOxNMrxAtroVhw7sy9A1mX+YBi99MEWpF7mf2MGUtrtchq7Pagy87yB/CGug==
X-Received: by 2002:a17:90b:e15:: with SMTP id ge21mr3208199pjb.185.1611115555492;
        Tue, 19 Jan 2021 20:05:55 -0800 (PST)
Received: from xiangao.remote.csb ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id kr9sm454363pjb.0.2021.01.19.20.05.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jan 2021 20:05:55 -0800 (PST)
Date:   Wed, 20 Jan 2021 12:05:44 +0800
From:   Gao Xiang <hsiangkao@redhat.com>
To:     Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Cc:     linux-block@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 31/37] eros: use bio_init_fields in data
Message-ID: <20210120040544.GC2601261@xiangao.remote.csb>
References: <20210119050631.57073-1-chaitanya.kulkarni@wdc.com>
 <20210119050631.57073-32-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210119050631.57073-32-chaitanya.kulkarni@wdc.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Chaitanya,

(drop in-person Cc..)

On Mon, Jan 18, 2021 at 09:06:25PM -0800, Chaitanya Kulkarni wrote:

...it would be nice if you could update the subject line to
"erofs: use bio_init_fields xxxx"

The same to the following patch [RFC PATCH 32/37]... Also, IMHO,
these two patches could be merged as one patch if possible,
although just my own thoughts.

Thanks,
Gao Xiang

> Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
> ---
>  fs/erofs/data.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/erofs/data.c b/fs/erofs/data.c
> index ea4f693bee22..15f3a3f01fa3 100644
> --- a/fs/erofs/data.c
> +++ b/fs/erofs/data.c
> @@ -220,10 +220,8 @@ static inline struct bio *erofs_read_raw_page(struct bio *bio,
>  
>  		bio = bio_alloc(GFP_NOIO, nblocks);
>  
> -		bio->bi_end_io = erofs_readendio;
> -		bio_set_dev(bio, sb->s_bdev);
> -		bio->bi_iter.bi_sector = (sector_t)blknr <<
> -			LOG_SECTORS_PER_BLOCK;
> +		bio_init_fields(bio, sb->s_bdev, (sector_t)blknr <<
> +			LOG_SECTORS_PER_BLOCK, NULL, erofs_readendio, 0, 0);
>  		bio->bi_opf = REQ_OP_READ | (ra ? REQ_RAHEAD : 0);
>  	}
>  
> -- 
> 2.22.1
> 

