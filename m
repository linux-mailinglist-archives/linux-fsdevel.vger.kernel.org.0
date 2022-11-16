Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12A7662CDF1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Nov 2022 23:43:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234376AbiKPWnb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Nov 2022 17:43:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234202AbiKPWnQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Nov 2022 17:43:16 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 119B06BDC8
        for <linux-fsdevel@vger.kernel.org>; Wed, 16 Nov 2022 14:43:15 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id gw22so1627pjb.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 16 Nov 2022 14:43:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Wf2gFJO0eZI55pjXm8OYjMYkGLte7QuRao7+IuvSaqE=;
        b=D2amVl9V9KQfzLW2zaIS23IBouuPji7hB+OAx+ZhW9BBCDB5OKBikMdNxb0VPTDxJj
         csClJ0YRCWBC/mBx5CM8cmRfxBeg4UGIi36VQSyP9C8PzSygpHTtXYMcx806fNdiiKsi
         DAssScFkYAwJ1pFNUcIn3ZWqN1hBHz6LpWnys=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wf2gFJO0eZI55pjXm8OYjMYkGLte7QuRao7+IuvSaqE=;
        b=I8D8nK5HEHVqpSrAtVUQGypWCog4pK//KkyaVVOyhTjwRCXdOiZrHmaBqp5KxCN1ZC
         Yk9Sv0sxSfkKJ6sT2UNuw1u7kQjaXuTze4r0O4aBQTzlS7qF4RR2ZryLvOss7/ckrK5r
         0m/jTh6WP9YM/Xkw11S51bv1/zL58Bz6iYe6VAxQ6ce5BZfm3E3HwTb99tprHRI8YpL/
         0KVionJTfOQwMK5SvkPLX3EPzVvuywJy/J+kf2XoZ7++lpYJoo4P0ABhUTkV8IXEHp9e
         NWfToXENABxfsBENe7l4YyELH5C45wSnoS9B85ak8hcw6KN0eYNM3MKmYi8NZzBdf4Q3
         hxfw==
X-Gm-Message-State: ANoB5pkEED3UJnmw4+MOnpgeh3l+NZPMvZbOyTAU2EjU2vg7rB8IjdmS
        Fzl4bhOqsmc3CLKQnmosQ12XOkv0qG+Mfw==
X-Google-Smtp-Source: AA0mqf5VxV4Cbn3MvfOzCKh9TKzLZskissYVmNmiO/kVOhEqnlwi5i8J4bomSjPXRjnnkIIEn4wz5w==
X-Received: by 2002:a17:90b:3c42:b0:213:1ce7:d962 with SMTP id pm2-20020a17090b3c4200b002131ce7d962mr6007688pjb.63.1668638594628;
        Wed, 16 Nov 2022 14:43:14 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id a9-20020a170902710900b00183c6784704sm12680746pll.291.2022.11.16.14.43.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Nov 2022 14:43:14 -0800 (PST)
Date:   Wed, 16 Nov 2022 14:43:13 -0800
From:   Kees Cook <keescook@chromium.org>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Heiko Carstens <hca@linux.ibm.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Christoph =?iso-8859-1?Q?B=F6hmwalder?= 
        <christoph.boehmwalder@linbit.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Richard Weinberger <richard@nod.at>,
        "Darrick J . Wong" <djwong@kernel.org>,
        SeongJae Park <sj@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Helge Deller <deller@gmx.de>, netdev@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, loongarch@lists.linux.dev,
        linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-mmc@vger.kernel.org, linux-parisc@vger.kernel.org
Subject: Re: [PATCH v2 3/3] treewide: use get_random_u32_between() when
 possible
Message-ID: <202211161436.A45AD719A@keescook>
References: <20221114164558.1180362-1-Jason@zx2c4.com>
 <20221114164558.1180362-4-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221114164558.1180362-4-Jason@zx2c4.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Nov 14, 2022 at 05:45:58PM +0100, Jason A. Donenfeld wrote:
> -				(get_random_u32_below(1024) + 1) * PAGE_SIZE;
> +				get_random_u32_between(1, 1024 + 1) * PAGE_SIZE;

I really don't like "between". Can't this be named "inclusive" (and
avoid adding 1 everywhere, which seems ugly), or at least named
something less ambiguous?

> -		n = get_random_u32_below(100) + 1;
> +		n = get_random_u32_between(1, 101);

Because I find this much less readable. "Below 100" is clear: 0-99
inclusive, plus 1, so 1-100 inclusive. "Between 1 and 101" is not obvious
to me to mean: 1-100 inclusive.

These seem so much nicer:
	get_random_u32_inclusive(1, 1024)
	get_random_u32_inclusive(1, 100)

-- 
Kees Cook
