Return-Path: <linux-fsdevel+bounces-3916-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DC8907F9CF1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Nov 2023 10:55:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95D92281251
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Nov 2023 09:55:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A4451798E;
	Mon, 27 Nov 2023 09:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OqLFFtgk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6401AE1;
	Mon, 27 Nov 2023 01:54:55 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-6b20a48522fso3037549b3a.1;
        Mon, 27 Nov 2023 01:54:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701078894; x=1701683694; darn=vger.kernel.org;
        h=in-reply-to:subject:cc:to:from:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=5TzpQLD2R8M7hAu/TyXug/Z5uSqY3uH4C9snuUtPp9Y=;
        b=OqLFFtgkx9mrvL1Jja/deIg8BpYqX6iIkhwAshCxvlbXhAKGcNK0eb9y8Stby2iOLx
         ljCc8s+vl/ZtD5GU+sywRUiNj4Szw1oXJUsJLGJ1MyQdYxrXguSXsy0iYnEbfbQau0JQ
         DJWAdz4y/v+iTgXgkRRfLsgGZXSvXe8dm6l9PHVQVTJc9fjPY13D07vkmPebDEsIb8Ae
         NXZXpnvMMlcfudimwXkFjp+OZBh6u8/g78LmLSXZRA7e23/vjNlt7EbZGrMTtHteP8S6
         la3kCNWfUxZVm+UYvl5hcds6hgBsDLDDPQSLL+nNJgYH/7bJEp1vLmJTEwlGLCIAUBgy
         hzSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701078894; x=1701683694;
        h=in-reply-to:subject:cc:to:from:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5TzpQLD2R8M7hAu/TyXug/Z5uSqY3uH4C9snuUtPp9Y=;
        b=qJhLOdjt5HpiMjcXUPQVUoPXOQ0int8vceAiDx0HRGAmOrcf7Ibao/JPJDQvvoO7Bk
         mtL9ES6K67VMV0zluwle7yGubfofWLnFktFVc2OoNSKbRCUqayD8gFw6YBMlfmY/wbdq
         euB/rGb6reH0OPu47fHrR1gIvr29nmlx8z1NU7H3q4r+S4VF6AppWsLwZdC76hh5iV0h
         tFCFeQ2g4y8/m1LhI0yuQfecHnQpWLWIN0Fp+fFXWC1Hcup5WDTjsOIW+nxng3JdjJ1q
         ZXgKQwjtd1ArqKVhn44Psc7riWxrpwCeYDymcyqzIwJKxIwFvZLpFWZ7WxBvgZJ+Ks7C
         ao+A==
X-Gm-Message-State: AOJu0YwNBDuIPgqkde2tde2UIvS2tm+pZK6g4quZ/cYDgN3VqctyCuKa
	ue5fmorOg6zNuAB7NcjWZ8unWBF508Y=
X-Google-Smtp-Source: AGHT+IH0mz3BK0MKSjmo5CAK05QKAl5fsVDjekIVFK8CwW2Qg5Tmklg5KexyZMtjYl7OBzOJXbXlIw==
X-Received: by 2002:a05:6a00:4c8f:b0:6c4:ac49:89a3 with SMTP id eb15-20020a056a004c8f00b006c4ac4989a3mr10639010pfb.14.1701078893791;
        Mon, 27 Nov 2023 01:54:53 -0800 (PST)
Received: from dw-tp ([49.205.218.89])
        by smtp.gmail.com with ESMTPSA id n29-20020a056a000d5d00b006c4d2479c1asm6851067pfv.219.2023.11.27.01.54.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Nov 2023 01:54:53 -0800 (PST)
Date: Mon, 27 Nov 2023 15:24:49 +0530
Message-Id: <87plzvr05y.fsf@doe.com>
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Christoph Hellwig <hch@lst.de>, Christian Brauner <brauner@kernel.org>
Cc: "Darrick J. Wong" <djwong@kernel.org>, Chandan Babu R <chandan.babu@oracle.com>, Zhang Yi <yi.zhang@huaweicloud.com>, linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 08/13] iomap: move the iomap_sector sector calculation out of iomap_add_to_ioend
In-Reply-To: <20231126124720.1249310-9-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

Christoph Hellwig <hch@lst.de> writes:

> The calculation in iomap_sector is pretty trivial and most of the time
> iomap_add_to_ioend only callers either iomap_can_add_to_ioend or
> iomap_alloc_ioend from a single invocation.
>
> Calculate the sector in the two lower level functions and stop passing it
> from iomap_add_to_ioend and update the iomap_alloc_ioend argument passing
> order to match that of iomap_add_to_ioend.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  fs/iomap/buffered-io.c | 22 ++++++++++------------
>  1 file changed, 10 insertions(+), 12 deletions(-)

Straight forward change. Looks good to me, please feel free to add - 
(small nit below on naming style convention)

Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>

>
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index 7f86d2f90e3863..329e2c342f1c64 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -1666,9 +1666,8 @@ iomap_submit_ioend(struct iomap_writepage_ctx *wpc, struct iomap_ioend *ioend,
>  	return 0;
>  }
>  
> -static struct iomap_ioend *
> -iomap_alloc_ioend(struct inode *inode, struct iomap_writepage_ctx *wpc,
> -		loff_t offset, sector_t sector, struct writeback_control *wbc)
> +static struct iomap_ioend *iomap_alloc_ioend(struct iomap_writepage_ctx *wpc,
> +		struct writeback_control *wbc, struct inode *inode, loff_t pos)
>  {
>  	struct iomap_ioend *ioend;
>  	struct bio *bio;
> @@ -1676,7 +1675,7 @@ iomap_alloc_ioend(struct inode *inode, struct iomap_writepage_ctx *wpc,
>  	bio = bio_alloc_bioset(wpc->iomap.bdev, BIO_MAX_VECS,
>  			       REQ_OP_WRITE | wbc_to_write_flags(wbc),
>  			       GFP_NOFS, &iomap_ioend_bioset);
> -	bio->bi_iter.bi_sector = sector;
> +	bio->bi_iter.bi_sector = iomap_sector(&wpc->iomap, pos);
>  	wbc_init_bio(wbc, bio);
>  
>  	ioend = container_of(bio, struct iomap_ioend, io_inline_bio);
> @@ -1685,9 +1684,9 @@ iomap_alloc_ioend(struct inode *inode, struct iomap_writepage_ctx *wpc,
>  	ioend->io_flags = wpc->iomap.flags;
>  	ioend->io_inode = inode;
>  	ioend->io_size = 0;
> -	ioend->io_offset = offset;
> +	ioend->io_offset = pos;
>  	ioend->io_bio = bio;
> -	ioend->io_sector = sector;
> +	ioend->io_sector = bio->bi_iter.bi_sector;
>  
>  	wpc->nr_folios = 0;
>  	return ioend;
> @@ -1716,8 +1715,7 @@ iomap_chain_bio(struct bio *prev)
>  }
>  
>  static bool
> -iomap_can_add_to_ioend(struct iomap_writepage_ctx *wpc, loff_t offset,
> -		sector_t sector)
> +iomap_can_add_to_ioend(struct iomap_writepage_ctx *wpc, loff_t offset)

Not sure which style you would like to keep in fs/iomap/.
Should the function name be in the same line as "static bool" or in the next line?
For previous function you made the function name definition in the same
line. Or is the naming style irrelevant for fs/iomap/?

-ritesh

