Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B587661A0C
	for <lists+linux-fsdevel@lfdr.de>; Sun,  8 Jan 2023 22:33:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236101AbjAHVdN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 8 Jan 2023 16:33:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234113AbjAHVdM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 8 Jan 2023 16:33:12 -0500
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A61ADFD7
        for <linux-fsdevel@vger.kernel.org>; Sun,  8 Jan 2023 13:33:09 -0800 (PST)
Received: by mail-pf1-x436.google.com with SMTP id a30so4825715pfr.6
        for <linux-fsdevel@vger.kernel.org>; Sun, 08 Jan 2023 13:33:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QJgOaIuyYqhKXDJUJknk+fSZ5Pa0AYwz5MAMP9q3MIE=;
        b=I2mGiER04mQKKr/G1GEYZHSSxGAg6dDLnCDe+qVmEg1QRkSzL3EWBmZI79hAAnRDgR
         rE6fEEuTXrTLzyhYS6u41epGG5sJztaWCr0LDjVHcxG729WJOF2xxcxIm+AqiRhANw3C
         m+HGxBt2vRZn9t751ZjEIhuxOmNGSXzhn9VmFBw6N3+FS7E9u4rp4RkHudJiQ1KvTQDv
         r97ijCNsjdAOt+xGMUUJ0+Bx43BrcgfjbR1+c0igVuZSNYumj7idCIPGMd+QZQsp0XRY
         RJ5Evpls2A88+Ppm2DXkeYRXwpRKXMpzyOdY/pdGh/C2h1q0ahTRLRuCvlx7rZXdM7ek
         36oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QJgOaIuyYqhKXDJUJknk+fSZ5Pa0AYwz5MAMP9q3MIE=;
        b=aw+7GeL7H1Lf/MpgULdeqV0rtC2wHhEh3pxOfcIV22/2MjYBzpU+C8UeIzeaXaZbjT
         2ualF2n1CFsHHuVaZOKwswnGHGaPX/S9G8zt6FpOLIY4Vs/Q+ahawUenhgaIXmet9kEm
         BnwP6BdBYGv40CPen3M+D9GoLyYkqNEl59s/J/03JgPpRzbfxgS9BrbNr1H4GpIP2d7b
         ZI9TxCl60SKBKUE66kip9hJvDlO2BzKjUP9T9dHyKrOGba3Kbhq8sJgVSJ4gpt4FgkQ0
         WBenf+SPXARpVZoknJhX/qjeUb15yoGFW9/gfbIoAAbUNf1zWTTHLtMX2YQy2VNu63N3
         /3VA==
X-Gm-Message-State: AFqh2kroLc1uKDq/l71xDiqFO1Sa4swVuNkCJbxQr5L+bMkjrz7+qYlc
        5JzF5Y6g4TTJJpPBQxNGm0jTpw==
X-Google-Smtp-Source: AMrXdXuy9YBsvnTXDPu6eykrHHHCfyBjyJt/L4aFAuuIaBmxWa89uFX8ht1hQVCJwiApGqsjy0ZqRg==
X-Received: by 2002:a05:6a00:1c82:b0:587:4171:30c9 with SMTP id y2-20020a056a001c8200b00587417130c9mr3550129pfw.18.1673213589019;
        Sun, 08 Jan 2023 13:33:09 -0800 (PST)
Received: from dread.disaster.area (pa49-186-146-207.pa.vic.optusnet.com.au. [49.186.146.207])
        by smtp.gmail.com with ESMTPSA id a13-20020aa7970d000000b00582197fa7b4sm4631425pfg.7.2023.01.08.13.33.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Jan 2023 13:33:08 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1pEdHt-000kZs-Cn; Mon, 09 Jan 2023 08:33:05 +1100
Date:   Mon, 9 Jan 2023 08:33:05 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Andreas Gruenbacher <agruenba@redhat.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, cluster-devel@redhat.com,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [RFC v6 04/10] iomap: Add iomap_get_folio helper
Message-ID: <20230108213305.GO1971568@dread.disaster.area>
References: <20230108194034.1444764-1-agruenba@redhat.com>
 <20230108194034.1444764-5-agruenba@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230108194034.1444764-5-agruenba@redhat.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Jan 08, 2023 at 08:40:28PM +0100, Andreas Gruenbacher wrote:
> Add an iomap_get_folio() helper that gets a folio reference based on
> an iomap iterator and an offset into the address space.  Use it in
> iomap_write_begin().
> 
> Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
> Reviewed-by: Darrick J. Wong <djwong@kernel.org>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> ---
>  fs/iomap/buffered-io.c | 39 ++++++++++++++++++++++++++++++---------
>  include/linux/iomap.h  |  1 +
>  2 files changed, 31 insertions(+), 9 deletions(-)
> 
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index d4b444e44861..de4a8e5f721a 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -457,6 +457,33 @@ bool iomap_is_partially_uptodate(struct folio *folio, size_t from, size_t count)
>  }
>  EXPORT_SYMBOL_GPL(iomap_is_partially_uptodate);
>  
> +/**
> + * iomap_get_folio - get a folio reference for writing
> + * @iter: iteration structure
> + * @pos: start offset of write
> + *
> + * Returns a locked reference to the folio at @pos, or an error pointer if the
> + * folio could not be obtained.
> + */
> +struct folio *iomap_get_folio(struct iomap_iter *iter, loff_t pos)
> +{
> +	unsigned fgp = FGP_LOCK | FGP_WRITE | FGP_CREAT | FGP_STABLE | FGP_NOFS;
> +	struct folio *folio;
> +
> +	if (iter->flags & IOMAP_NOWAIT)
> +		fgp |= FGP_NOWAIT;
> +
> +	folio = __filemap_get_folio(iter->inode->i_mapping, pos >> PAGE_SHIFT,
> +			fgp, mapping_gfp_mask(iter->inode->i_mapping));
> +	if (folio)
> +		return folio;
> +
> +	if (iter->flags & IOMAP_NOWAIT)
> +		return ERR_PTR(-EAGAIN);
> +	return ERR_PTR(-ENOMEM);
> +}
> +EXPORT_SYMBOL_GPL(iomap_get_folio);

Hmmmm.

This is where things start to get complex. I have sent a patch to
fix a problem with iomap_zero_range() failing to zero cached dirty
pages over UNWRITTEN extents, and that requires making FGP_CREAT
optional. This is an iomap bug, and needs to be fixed in the core
iomap code:

https://lore.kernel.org/linux-xfs/20221201005214.3836105-1-david@fromorbit.com/

Essentially, we need to pass fgp flags to iomap_write_begin() need
so the callers can supply a 0 or FGP_CREAT appropriately. This
allows iomap_write_begin() to act only on pre-cached pages rather
than always instantiating a new page if one does not exist in cache.

This allows that iomap_write_begin() to return a NULL folio
successfully, and this is perfectly OK for callers that pass in fgp
= 0 as they are expected to handle a NULL folio return indicating
there was no cached data over the range...

Exposing the folio allocation as an external interface makes bug
fixes like this rather messy - it's taking a core abstraction (iomap
hides all the folio and page cache manipulations from the
filesystem) and punching a big hole in it by requiring filesystems
to actually allocation page cache folios on behalf of the iomap
core.

Given that I recently got major push-back for fixing an XFS-only bug
by walking the page cache directly instead of abstracting it via the
iomap core, punching an even bigger hole in the abstraction layer to
fix a GFS2-only problem is just as bad....

-Dave.
-- 
Dave Chinner
david@fromorbit.com
