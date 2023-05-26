Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B35A711B55
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 May 2023 02:36:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241330AbjEZAgL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 25 May 2023 20:36:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239876AbjEZAgJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 25 May 2023 20:36:09 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A305B1B0
        for <linux-fsdevel@vger.kernel.org>; Thu, 25 May 2023 17:36:07 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id 41be03b00d2f7-5346d150972so146949a12.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 25 May 2023 17:36:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20221208.gappssmtp.com; s=20221208; t=1685061367; x=1687653367;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tJ9LyPTo053T3fijbdEEeajXM5b0nc+MBS0L4hj1F/Y=;
        b=TDAx+dt6pUfaSHJbf2NrRNpfsbscdpyE5E6JoZa4h0wMlat3WMbVhXEVYxqXvIp4Zn
         L/ZBdVhL4QzPQv2jjXt8wN5XNqHmUFaTb11tEOuzMiAEG/1IDCVoWbTQpGMwPMcaueNA
         vPVPOhjA71jC4smZBdAUDi9GcD9+MBWOLfpKX+2KH6wZwt3Ox8zXjLhJZl0aCXBjRLV7
         +1l5X6FhTRJmRgnmpLGr6XxF0d063vavFNvcrtoXsJt+uyXUooiUl4Ro2iGW+9UF3IQn
         JmcWT/NDBMtg9GGqV/PiUmXYkvwGfMgammbN0RNn5tBb+i9p2JitRx2i/1E2zO8ct7vE
         FC7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685061367; x=1687653367;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tJ9LyPTo053T3fijbdEEeajXM5b0nc+MBS0L4hj1F/Y=;
        b=XvbwEsJS7KLUz3MPxynzTN9ML9Pm9XFQuaHqmUWuICXysPSNuGK5xb4ZFMWwrR7dEH
         Hlv1b+/1rNeg8B4Ob3//4II+7ayLvINixbr2WS50gTed3kRExKnZuXzQ2cNiKSjBhodU
         rqZ+VDwIenKD4Ycv6nfoxzKUnkKg8HtGlRKb3cIuf3/7ymtLTwS3SI3Ww4vMlQfYgTnh
         kUYGeT9UdV4+XafKwjLw039IQp3di/WgOb55dUzt9tlA0VCxwAW/paByi1iHcrC2aWYj
         mH1xxbbEHK+Ed90fVS/95qi0CkoJ4PC/N43roKLkUXfAaCjFk2p5vOfSpySUlJdyCNhw
         YkkQ==
X-Gm-Message-State: AC+VfDzyFjCr7jHzbxbIqsTr63Ed+T84SzhieEhVmGztMxOl+Eni4d2d
        IU/tZrFJQxyL81acJ7hASz1F8I2SZq2Jv9iGYz4=
X-Google-Smtp-Source: ACHHUZ45T530Np/DKkM/YX0mFC5+v2YjaZ7Ka9v14tyOEH74llzKzA6gQNPz0SE1MkCc9RKZ+f8wxQ==
X-Received: by 2002:a17:902:d511:b0:1af:cbb6:61ff with SMTP id b17-20020a170902d51100b001afcbb661ffmr589592plg.64.1685061367017;
        Thu, 25 May 2023 17:36:07 -0700 (PDT)
Received: from dread.disaster.area (pa49-179-0-188.pa.nsw.optusnet.com.au. [49.179.0.188])
        by smtp.gmail.com with ESMTPSA id y16-20020a17090264d000b00194caf3e975sm1979063pli.208.2023.05.25.17.36.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 May 2023 17:36:06 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
        (envelope-from <david@fromorbit.com>)
        id 1q2LR5-003vd3-20;
        Fri, 26 May 2023 10:36:03 +1000
Date:   Fri, 26 May 2023 10:36:03 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Kent Overstreet <kent.overstreet@linux.dev>
Cc:     linux-kernel@vger.kernel.org, axboe@kernel.dk,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH 5/7] block: Rework bio_for_each_folio_all()
Message-ID: <ZG/+88/G+hX5DyCX@dread.disaster.area>
References: <20230525214822.2725616-1-kent.overstreet@linux.dev>
 <20230525214822.2725616-6-kent.overstreet@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230525214822.2725616-6-kent.overstreet@linux.dev>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, May 25, 2023 at 05:48:20PM -0400, Kent Overstreet wrote:
> This reimplements bio_for_each_folio_all() on top of the newly-reworked
> bvec_iter_all, and since it's now trivial we also provide
> bio_for_each_folio.
> 
> Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
> Cc: Matthew Wilcox <willy@infradead.org>
> Cc: linux-block@vger.kernel.org
> ---
>  fs/crypto/bio.c        |  9 +++--
>  fs/iomap/buffered-io.c | 14 ++++---
>  fs/verity/verify.c     |  9 +++--
>  include/linux/bio.h    | 91 +++++++++++++++++++++---------------------
>  include/linux/bvec.h   | 15 +++++--
>  5 files changed, 75 insertions(+), 63 deletions(-)
....
> diff --git a/include/linux/bio.h b/include/linux/bio.h
> index f86c7190c3..7ced281734 100644
> --- a/include/linux/bio.h
> +++ b/include/linux/bio.h
> @@ -169,6 +169,42 @@ static inline void bio_advance(struct bio *bio, unsigned int nbytes)
>  #define bio_for_each_segment(bvl, bio, iter)				\
>  	__bio_for_each_segment(bvl, bio, iter, (bio)->bi_iter)
>  
> +struct folio_vec {
> +	struct folio	*fv_folio;
> +	size_t		fv_offset;
> +	size_t		fv_len;
> +};

Can we drop the "fv_" variable prefix here? It's just unnecessary
verbosity when we know we have a folio_vec structure. i.e fv->folio
is easier to read and type than fv->fv_folio...

Hmmm, this is probably not a good name considering "struct pagevec" is
something completely different - the equivalent is "struct
folio_batch" but I can see this being confusing for people who
largely expect some symmetry between page<->folio naming
conventions...

Also, why is this in bio.h and not in a mm/folio related header
file?

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
