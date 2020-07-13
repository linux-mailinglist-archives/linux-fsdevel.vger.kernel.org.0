Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86EC6219392
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Jul 2020 00:37:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725903AbgGHWhY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Jul 2020 18:37:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726196AbgGHWhY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Jul 2020 18:37:24 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FF6BC08C5DC
        for <linux-fsdevel@vger.kernel.org>; Wed,  8 Jul 2020 15:37:24 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id m22so34345pgv.9
        for <linux-fsdevel@vger.kernel.org>; Wed, 08 Jul 2020 15:37:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=q3UqSSyfIBC1rMGV9nALdXLQBVwoBmKfCFkzwkHahg8=;
        b=hr0vTbH1eQaQ1QoG8hJBW0VhUzgNK9r1JU5JPnbDRf7spnrKmRRaTpXgkfCXRgGT4e
         ttHdOXPDA7oT50viySeZXBWYZlf5vQXnoRWq6G7T3YreUxQQcwmYrXoNxo3TT51uMiV4
         2nnNWi7fxP2lbgQPd38h6FV3S7Ne+QtXv1WMORY++W0EhXFk0wNtaV5w9nP+rAqoggiZ
         gwX+RJBFBMEYzYW9vq+VU8asY5SAl0TOc4gndrjF5Mn6O5f1L5tJ2TYlPuai0iDT2Kdw
         Y1zGB/0UTFfXk1ZPoG97VKxJWFLHLb0Asuavx/6GM1V1AwwYWUF69q+DDRXVVxyhx84U
         9OfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=q3UqSSyfIBC1rMGV9nALdXLQBVwoBmKfCFkzwkHahg8=;
        b=l1KiofSW0M3lBRfhesJFoA2ivKhCIL7vE4ogI6LRuEh1paLXyuDeevcyWn/6MP4+nF
         kLUQX8Qls6onXSA3WrXRKAV2P2O458nZ0a2Kxx/rmVhfHWLbMVWWUkYPDvZHvrf/okPj
         flu7eusa6vOokqYxBzlxd8dERr5VjD3apWEqasDl3UNGkkW3IDiwfAyUG7p2YSS7469j
         cHfaH6aZKJiPx+3M8BDqyRyFyPzwVFxo6yHj5A9VursCDtmom1SL830nbwSMrpyk4fWP
         yocW5KkNLxkCIJElqmSs1/oApVs/zVkjTj3iymMoNPFMcPKJmLsjemrstMYVfrJjz5nR
         0qsg==
X-Gm-Message-State: AOAM533BIKmvcTDxw4rkC1sYQ312YxPC6u5NJwChy9d7pJfSQ+x7yMJE
        jgpaUfnODRmxpBbIfFWAQQuL2w==
X-Google-Smtp-Source: ABdhPJyKN5K8/iz33QUVfw+r+Vu8IJVeHNQDzaI5DOkexKvPwmp1jilnyQIzwi64s/K7n4mQx72hWA==
X-Received: by 2002:a63:380d:: with SMTP id f13mr49658491pga.16.1594247843851;
        Wed, 08 Jul 2020 15:37:23 -0700 (PDT)
Received: from [192.168.1.182] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id k2sm742530pgm.11.2020.07.08.15.37.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jul 2020 15:37:22 -0700 (PDT)
Subject: Re: [PATCH 1/2] fs: Abstract calling the kiocb completion function
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-aio@kvack.org, io-uring@vger.kernel.org,
        linux-kernel@vger.kernel.org, Kanchan Joshi <joshi.k@samsung.com>,
        Javier Gonzalez <javier.gonz@samsung.com>
References: <20200708222637.23046-1-willy@infradead.org>
 <20200708222637.23046-2-willy@infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <983baa4b-55c6-0988-9e43-6860937957b4@kernel.dk>
Date:   Wed, 8 Jul 2020 16:37:21 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200708222637.23046-2-willy@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 7/8/20 4:26 PM, Matthew Wilcox (Oracle) wrote:
> diff --git a/crypto/af_alg.c b/crypto/af_alg.c
> index b1cd3535c525..590dbbcd0e9f 100644
> --- a/crypto/af_alg.c
> +++ b/crypto/af_alg.c
> @@ -1045,7 +1045,7 @@ void af_alg_async_cb(struct crypto_async_request *_req, int err)
>  	af_alg_free_resources(areq);
>  	sock_put(sk);
>  
> -	iocb->ki_complete(iocb, err ? err : (int)resultlen, 0);
> +	complete_kiocb(iocb, err ? err : (int)resultlen, 0);

I'd prefer having it called kiocb_complete(), seems more in line with
what you'd expect in terms of naming for an exported interface.

-- 
Jens Axboe

