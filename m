Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3DA52AA6CE
	for <lists+linux-fsdevel@lfdr.de>; Sat,  7 Nov 2020 18:08:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727218AbgKGRIQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 7 Nov 2020 12:08:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726021AbgKGRIQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 7 Nov 2020 12:08:16 -0500
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FAABC0613CF
        for <linux-fsdevel@vger.kernel.org>; Sat,  7 Nov 2020 09:08:16 -0800 (PST)
Received: by mail-qv1-xf41.google.com with SMTP id 13so2025222qvr.5
        for <linux-fsdevel@vger.kernel.org>; Sat, 07 Nov 2020 09:08:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=fKy0LpeHsg6BslNULkInom8HrfOt19qae6yN9HaQSM4=;
        b=F/nMhRJwqXsJ03U3zJ7H24RE+e21YludQADd7TUZ7h/jgkjkLZvuv1fTmWQ/EYCeBO
         w3S2z9uIFdB6wW60kuC76BgJBL8BpDxHaU4hqg+DoTzw6zj7sgaO4bM29+ZG7dbZMA7u
         fO9L5u1UXIwmXJ7iSXdEqg+qx3iF9HL2vnid9GINmamXb5N7vd6SEQSmPK/euO32MhGn
         WRW/+6S9cs72AzQn1V4PZhnke7s4NtfCOL0WyaKH5qJzpH1J3Y4uiUPZCo4vH6JPZDIl
         yX7sc4u2e6/AqNUSNzJ3R2RpgRmjzZNYnTL/gJ68gFqjPWllQQkTsCG5Heed85YnlKiR
         oAOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=fKy0LpeHsg6BslNULkInom8HrfOt19qae6yN9HaQSM4=;
        b=UiVtIOSIiYZJjGLHLmCfark4R4jgPS5h7bNE1sX47B5qef4RR4c4DUIRUD1ys43Pgj
         hFG4UWm2QrT7jahW17DwET9MKMm6KkO0/HdtA4Ot7t41ILFnp/x8LKcstLFoICZIaYxc
         YMpNQrydTJS3m0/HeL6ePIOHvNJwmPTj8pJcKsmdnWNzqzsTBoazzfRd1w8S3cRhzQAd
         BROUgAjp2aOLO9ffULAAnwyvzmrTPUyWbt0Kj1exlzFt9ngghaOpV+usz30B7iPlNRik
         czKMymsi4WqE+eNJHwDHN4N17rkH6g6AiHNnpgaf5tl5PGLcs2upKKrP1b16vsxRMm5W
         n9PA==
X-Gm-Message-State: AOAM532MocrdtXYjwTkx7DQFf7xUZz2UlZeZZWJ/wuiwijFBz/Vg9O8D
        AerZuoxXrBLJlBpHZt/r4FfREjkClAHr
X-Google-Smtp-Source: ABdhPJyr23Wi6Y2V0RZXCNx7hFsvCIJ+YG9xiahNJCb+eB3izU5InXz4zEL6dogCohn+/K2DfWgH1A==
X-Received: by 2002:ad4:5381:: with SMTP id i1mr6899653qvv.21.1604768895470;
        Sat, 07 Nov 2020 09:08:15 -0800 (PST)
Received: from moria.home.lan (c-73-219-103-14.hsd1.vt.comcast.net. [73.219.103.14])
        by smtp.gmail.com with ESMTPSA id h12sm2705172qta.94.2020.11.07.09.08.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Nov 2020 09:08:14 -0800 (PST)
Date:   Sat, 7 Nov 2020 12:08:13 -0500
From:   Kent Overstreet <kent.overstreet@gmail.com>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, hch@lst.de
Subject: Re: [PATCH 1/4] pagevec: Allow pagevecs to be different sizes
Message-ID: <20201107170813.GD3365678@moria.home.lan>
References: <20201106080815.GC31585@lst.de>
 <20201106123040.28451-1-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201106123040.28451-1-willy@infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Nov 06, 2020 at 12:30:37PM +0000, Matthew Wilcox (Oracle) wrote:
> Declaring a pagevec continues to create a pagevec which is the same size,
> but functions which manipulate pagevecs no longer rely on this.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>  include/linux/pagevec.h | 20 ++++++++++++++++----
>  mm/swap.c               |  8 ++++++++
>  2 files changed, 24 insertions(+), 4 deletions(-)
> 
> diff --git a/include/linux/pagevec.h b/include/linux/pagevec.h
> index 875a3f0d9dd2..ee5d3c4da8da 100644
> --- a/include/linux/pagevec.h
> +++ b/include/linux/pagevec.h
> @@ -18,9 +18,15 @@ struct page;
>  struct address_space;
>  
>  struct pagevec {
> -	unsigned char nr;
> -	bool percpu_pvec_drained;
> -	struct page *pages[PAGEVEC_SIZE];
> +	union {
> +		struct {
> +			unsigned char sz;
> +			unsigned char nr;
> +			bool percpu_pvec_drained;
This should probably be removed, it's only used by the swap code and I don't
think it belongs in the generic data structure. That would mean nr and size (and
let's please use more standard naming...) can be u32, not u8s.

> +			struct page *pages[PAGEVEC_SIZE];
> +		};
> +		void *__p[PAGEVEC_SIZE + 1];

What's up with this union?

> +	};
>  };
>  
>  void __pagevec_release(struct pagevec *pvec);
> @@ -41,6 +47,7 @@ static inline unsigned pagevec_lookup_tag(struct pagevec *pvec,
>  
>  static inline void pagevec_init(struct pagevec *pvec)
>  {
> +	pvec->sz = PAGEVEC_SIZE;
>  	pvec->nr = 0;
>  	pvec->percpu_pvec_drained = false;
>  }
> @@ -50,6 +57,11 @@ static inline void pagevec_reinit(struct pagevec *pvec)
>  	pvec->nr = 0;
>  }
>  
> +static inline unsigned pagevec_size(struct pagevec *pvec)
> +{
> +	return pvec->sz;
> +}
> +
>  static inline unsigned pagevec_count(struct pagevec *pvec)
>  {
>  	return pvec->nr;
> @@ -57,7 +69,7 @@ static inline unsigned pagevec_count(struct pagevec *pvec)
>  
>  static inline unsigned pagevec_space(struct pagevec *pvec)
>  {
> -	return PAGEVEC_SIZE - pvec->nr;
> +	return pvec->sz - pvec->nr;
>  }
>  
>  /*
> diff --git a/mm/swap.c b/mm/swap.c
> index 2ee3522a7170..d093fb30f038 100644
> --- a/mm/swap.c
> +++ b/mm/swap.c
> @@ -52,6 +52,7 @@ struct lru_rotate {
>  };
>  static DEFINE_PER_CPU(struct lru_rotate, lru_rotate) = {
>  	.lock = INIT_LOCAL_LOCK(lock),
> +	.pvec.sz = PAGEVEC_SIZE,
>  };
>  
>  /*
> @@ -70,6 +71,13 @@ struct lru_pvecs {
>  };
>  static DEFINE_PER_CPU(struct lru_pvecs, lru_pvecs) = {
>  	.lock = INIT_LOCAL_LOCK(lock),
> +	.lru_add.sz = PAGEVEC_SIZE,
> +	.lru_deactivate_file.sz = PAGEVEC_SIZE,
> +	.lru_deactivate.sz = PAGEVEC_SIZE,
> +	.lru_lazyfree.sz = PAGEVEC_SIZE,
> +#ifdef CONFIG_SMP
> +	.activate_page.sz = PAGEVEC_SIZE,
> +#endif
>  };
>  
>  /*
> -- 
> 2.28.0
> 
