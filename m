Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56F4870ABFE
	for <lists+linux-fsdevel@lfdr.de>; Sun, 21 May 2023 04:24:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229561AbjEUCQq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 20 May 2023 22:16:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231341AbjEUCQg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 20 May 2023 22:16:36 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CFA71A1
        for <linux-fsdevel@vger.kernel.org>; Sat, 20 May 2023 19:14:02 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-64d3bc502ddso2158700b3a.0
        for <linux-fsdevel@vger.kernel.org>; Sat, 20 May 2023 19:14:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20221208.gappssmtp.com; s=20221208; t=1684635241; x=1687227241;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=D0HTUTVII4fxTKBozzDqklgx75P7vTi92gxCFUArFBI=;
        b=d4LuRN+9/KOP3Rq8YsS98JgLktAuZw3pyKuhOtPtGw0tRBYXbaWqO8WRXGzXzW2ks1
         EEGSTRrZ/B2nA2PjVp4kjM36TJ4PE2NehIvWX2oovqiQciUAmwwE31dDJuzsuB8jw6fC
         4IYuaBovxVQahcfFHoP13zVloKO+dTT2i9ypglKD1kvtcEGyAw7qendBwGC0Kpa4ETRd
         TWR6OdXVHpLA23XpMDmBAcaDAPDzqcSW68WipcPS0buhUo2k/mQSG9VXfLboDNT3/Tc4
         +eqrR9BkPZmqZXduiUMxEM9IneNJiEAjRnWM1Ie4tOxaw6pN5+grtIpj+4fJWdmN7qDd
         m0dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684635241; x=1687227241;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D0HTUTVII4fxTKBozzDqklgx75P7vTi92gxCFUArFBI=;
        b=W/2gZUWh1d4ziCO297y+DM+EHiPZovqoDDHEZxu41vHxrzLfhkeqRPMB/Bv+pHNHHY
         wsXm8p/kMWB7xBoqrCAtM+4mwM71Zp0N+APSCWINQQO2IJ9+Yw18QSf/u5sj/kFgodp4
         KnbgW0dqO7zEeL4PyTuD90pzCn0mospwBVveImf6629DhVKoNk6X+8/yH9doZxzEIgHV
         7WjePvpEZBN8DCmzJ82VMF0qXYXmk5klKFz8/SGjDc96Uh1o/f5dRDHmnYT1LSdBor88
         UZD0EW3hifkmIjeUwD9VN46t7Xlwl1o3nWk86Ml9W01x8DL7ObsQqctcRLupgtJcgwzq
         9VzQ==
X-Gm-Message-State: AC+VfDxq2zNgOzobMU8NffrBh+KbDY1oMbddRtDB3T1Vo+A3Gw/OfMPa
        86bAAvayr8RDhajUb1FkmKun2jwDioWl2mqMiB0=
X-Google-Smtp-Source: ACHHUZ6MUhdHVNdO9/lDWeegjMtjDh9q+Zu0iaWMbWtTen1TdwGU/CGyI2cI1iljO1fIVH4B10dgpA==
X-Received: by 2002:a05:6a00:2d90:b0:64c:e899:dcd1 with SMTP id fb16-20020a056a002d9000b0064ce899dcd1mr8860356pfb.5.1684635241301;
        Sat, 20 May 2023 19:14:01 -0700 (PDT)
Received: from dread.disaster.area (pa49-179-0-188.pa.nsw.optusnet.com.au. [49.179.0.188])
        by smtp.gmail.com with ESMTPSA id x1-20020aa784c1000000b006352a6d56ebsm1833914pfn.119.2023.05.20.19.14.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 May 2023 19:14:00 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
        (envelope-from <david@fromorbit.com>)
        id 1q0Ya5-001y6c-26;
        Sun, 21 May 2023 12:13:57 +1000
Date:   Sun, 21 May 2023 12:13:57 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        Wang Yugui <wangyugui@e16-tech.com>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J . Wong" <djwong@kernel.org>
Subject: Re: [PATCH 1/3] filemap: Allow __filemap_get_folio to allocate large
 folios
Message-ID: <ZGl+ZeaCB+7D23xj@dread.disaster.area>
References: <20230520163603.1794256-1-willy@infradead.org>
 <20230520163603.1794256-2-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230520163603.1794256-2-willy@infradead.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, May 20, 2023 at 05:36:01PM +0100, Matthew Wilcox (Oracle) wrote:
> Allow callers of __filemap_get_folio() to specify a preferred folio
> order in the FGP flags.  This is only honoured in the FGP_CREATE path;
> if there is already a folio in the page cache that covers the index,
> we will return it, no matter what its order is.  No create-around is
> attempted; we will only create folios which start at the specified index.
> Unmodified callers will continue to allocate order 0 folios.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>  include/linux/pagemap.h | 29 ++++++++++++++++++++++++---
>  mm/filemap.c            | 44 ++++++++++++++++++++++++++++-------------
>  mm/folio-compat.c       |  2 +-
>  mm/readahead.c          | 13 ------------
>  4 files changed, 57 insertions(+), 31 deletions(-)
> 
> diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
> index a56308a9d1a4..f4d05beb64eb 100644
> --- a/include/linux/pagemap.h
> +++ b/include/linux/pagemap.h
> @@ -466,6 +466,19 @@ static inline void *detach_page_private(struct page *page)
>  	return folio_detach_private(page_folio(page));
>  }
>  
> +/*
> + * There are some parts of the kernel which assume that PMD entries
> + * are exactly HPAGE_PMD_ORDER.  Those should be fixed, but until then,
> + * limit the maximum allocation order to PMD size.  I'm not aware of any
> + * assumptions about maximum order if THP are disabled, but 8 seems like
> + * a good order (that's 1MB if you're using 4kB pages)
> + */
> +#ifdef CONFIG_TRANSPARENT_HUGEPAGE
> +#define MAX_PAGECACHE_ORDER	HPAGE_PMD_ORDER
> +#else
> +#define MAX_PAGECACHE_ORDER	8
> +#endif
> +
>  #ifdef CONFIG_NUMA
>  struct folio *filemap_alloc_folio(gfp_t gfp, unsigned int order);
>  #else
> @@ -505,14 +518,24 @@ pgoff_t page_cache_prev_miss(struct address_space *mapping,
>  #define FGP_NOWAIT		0x00000020
>  #define FGP_FOR_MMAP		0x00000040
>  #define FGP_STABLE		0x00000080
> +#define FGP_ORDER(fgp)		((fgp) >> 26)	/* top 6 bits */
>  
>  #define FGP_WRITEBEGIN		(FGP_LOCK | FGP_WRITE | FGP_CREAT | FGP_STABLE)
>  
> +static inline unsigned fgp_order(size_t size)
> +{
> +	unsigned int shift = ilog2(size);
> +
> +	if (shift <= PAGE_SHIFT)
> +		return 0;
> +	return (shift - PAGE_SHIFT) << 26;
> +}

Doesn't check for being larger than MAX_PAGECACHE_ORDER.

Also: naming. FGP_ORDER(fgp) to get the order stored in the fgp,
fgp_order(size) to get the order from the IO length.

Both are integers, the compiler is not going to tell us when we get
them the wrong way around, and it's impossible to determine which
one is right just from looking at the code.

Perhaps fgp_order_from_flags(fgp) and fgp_order_from_length(size)?

Also, why put the order in the high bits? Shifting integers up into
unaligned high bits is prone to sign extension issues and overflows.
e.g.  fgp_flags is passed around the filemap functions as a signed
integer, so using the high bit in a shifted value that is unsigned
seems like a recipe for unexpected sign extension bugs on
extraction.

Hence I'd much prefer low bits are used for this sort of integer
encoding (i.e. uses masks instead of shifts for extraction), and
that flags fields -always- use unsigned variables so high bit
usage doesn't unexpected do the wrong thing....

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
