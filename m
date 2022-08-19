Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 432C3599AC2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Aug 2022 13:18:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348479AbiHSLQX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 19 Aug 2022 07:16:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348328AbiHSLQW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 19 Aug 2022 07:16:22 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BF82D5DF3;
        Fri, 19 Aug 2022 04:16:21 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id r4so5243290edi.8;
        Fri, 19 Aug 2022 04:16:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=itseYdGoOoNrZ4b7CTSPCW7acA5mJKihiu6lV8OPi8o=;
        b=o062D1xyt9gEqH+QMY//Eh8mTGWyMmvkY/6jUfPPECOrx9pl6afdiJnQq32Zt+9s8z
         I2jKDjNhLhlWsuRTFsKvZyfOCtKSwGGvA6NmeLEMxYFMXR54Obvw4fuISrA5uCA6P6cy
         CDZ43d73oP6/zpEm2zwAY22cx0OtuJv1BtzUi4W7miNG6EL8oNtWuCBHPGTnAeMCdSry
         rklm38uL35QRtZON09u1J+UOCfCgCqLmzFOG0fjvqE8R8ZF8FQ56pncpn+x2SjXF0iiG
         ZV52+wx27/7u8YcQGCEatev34SNvRjsEP/XYoSmxv6V7k3G3slBWNP3LwaegiREwBn8S
         JBVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=itseYdGoOoNrZ4b7CTSPCW7acA5mJKihiu6lV8OPi8o=;
        b=TPTcIeBeKCIGerWJpgSmvWNa9ApFr6lq5KNJdJ/N8quPhsqa67qPX1160VcIB/ufTF
         t09CDMWzwSqi8DnMyQ1Pn4Wbhxi8vU2ZImvUCB04BE5zB/NavndX5aPM2gr36K+wBeYc
         gDlEtArmNOVPeIeExQs8PGI7jp4wnwOZwi3MjQH5s6WP0Kei+GTNuYMAHy3eJyPeVFHR
         /CbcHIc4l6yXzYEIgBucXEcVvhhDSWxUw5ifE0H6U3tTn3czCUs5x1JZhrdDmPfom12Y
         LlKU8a8l3VggRFE2KOhEEd3g4q/m4QOLqhWfEVjZj5LXzb4pecw3Mmw6p7E9Oiux7spO
         lTGQ==
X-Gm-Message-State: ACgBeo16UsyQYzcUUY54QnjFPfF9LfesLh+JS2WOMmyzsMpEnLXolJuR
        TgMU8Uey56AmodZRpF1agmHo7tK0Q7M=
X-Google-Smtp-Source: AA6agR7QEURtBcz9WghqlpLI+jUia82IkHOa3YUWxPiwM58VubLC/Ml8YjQn/NWyOuaKLm5plYECyw==
X-Received: by 2002:a05:6402:354e:b0:440:5398:cd65 with SMTP id f14-20020a056402354e00b004405398cd65mr5681684edd.43.1660907779067;
        Fri, 19 Aug 2022 04:16:19 -0700 (PDT)
Received: from localhost.localdomain (host-87-17-106-94.retail.telecomitalia.it. [87.17.106.94])
        by smtp.gmail.com with ESMTPSA id k21-20020a170906579500b0072fa24c2ecbsm2210091ejq.94.2022.08.19.04.16.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Aug 2022 04:16:17 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     linux-fscrypt@vger.kernel.org, Eric Biggers <ebiggers@kernel.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH] fs-verity: use memcpy_from_page()
Date:   Fri, 19 Aug 2022 13:16:15 +0200
Message-ID: <8113955.T7Z3S40VBb@localhost.localdomain>
In-Reply-To: <20220818223903.43710-1-ebiggers@kernel.org>
References: <20220818223903.43710-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Friday, August 19, 2022 12:39:03 AM CEST Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> Replace extract_hash() with the memcpy_from_page() helper function.
> 
> This is simpler, and it has the side effect of replacing the use of
> kmap_atomic() with its recommended replacement kmap_local_page().
> 
> Signed-off-by: Eric Biggers <ebiggers@google.com>
> ---
>  fs/verity/verify.c | 14 ++------------
>  1 file changed, 2 insertions(+), 12 deletions(-)
> 

It looks good to me...

Reviewed-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>

Thanks,

Fabio

> diff --git a/fs/verity/verify.c b/fs/verity/verify.c
> index 14e2fb49cff561..bde8c9b7d25f64 100644
> --- a/fs/verity/verify.c
> +++ b/fs/verity/verify.c
> @@ -39,16 +39,6 @@ static void hash_at_level(const struct merkle_tree_params 
*params,
>  		   (params->log_blocksize - params->log_arity);
>  }
>  
> -/* Extract a hash from a hash page */
> -static void extract_hash(struct page *hpage, unsigned int hoffset,
> -			 unsigned int hsize, u8 *out)
> -{
> -	void *virt = kmap_atomic(hpage);
> -
> -	memcpy(out, virt + hoffset, hsize);
> -	kunmap_atomic(virt);
> -}
> -
>  static inline int cmp_hashes(const struct fsverity_info *vi,
>  			     const u8 *want_hash, const u8 
*real_hash,
>  			     pgoff_t index, int level)
> @@ -129,7 +119,7 @@ static bool verify_page(struct inode *inode, const 
struct fsverity_info *vi,
>  		}
>  
>  		if (PageChecked(hpage)) {
> -			extract_hash(hpage, hoffset, hsize, 
_want_hash);
> +			memcpy_from_page(_want_hash, hpage, hoffset, 
hsize);
>  			want_hash = _want_hash;
>  			put_page(hpage);
>  			pr_debug_ratelimited("Hash page already 
checked, want %s:%*phN\n",
> @@ -158,7 +148,7 @@ static bool verify_page(struct inode *inode, const 
struct fsverity_info *vi,
>  		if (err)
>  			goto out;
>  		SetPageChecked(hpage);
> -		extract_hash(hpage, hoffset, hsize, _want_hash);
> +		memcpy_from_page(_want_hash, hpage, hoffset, hsize);
>  		want_hash = _want_hash;
>  		put_page(hpage);
>  		pr_debug("Verified hash page at level %d, now want %s:
%*phN\n",
> 
> base-commit: 568035b01cfb107af8d2e4bd2fb9aea22cf5b868
> -- 
> 2.37.1
> 
> 




