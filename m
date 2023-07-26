Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67329762B12
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Jul 2023 08:03:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231803AbjGZGDP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Jul 2023 02:03:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231777AbjGZGDL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Jul 2023 02:03:11 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C9971982
        for <linux-fsdevel@vger.kernel.org>; Tue, 25 Jul 2023 23:03:10 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-3fd18b1d924so52072695e9.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 25 Jul 2023 23:03:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690351388; x=1690956188;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=a7DlYDzASdtB1auF6MGXd712hY08PNEA8Sc8ogncFWE=;
        b=uygFj9vzXO/Dt/eBXzd/8ASkC2IBDZvl2C96A/iVjWASbQz3lN7c6SFRBX4d6B1Oj5
         qG0rT5uSzi+RC4e2bRHJWpwgJr8eCkqwF2+wJpvsYxvSvw1eGrKsO8q0XGBV/MD1T1Fl
         PKzpgOSdIeCmRQL9BWn+6DY28yr1r/t+xl2KvJZUjtbugk6RL8k2hClysps3vXTY3jOi
         chyh/qI/Z3/igWnNEKOnaBsUCSOU2XTqgglTkkGLUutf6H3t3NV7h3GD82kgryQM0/eN
         jCbwDkE8tIAdvUciXj2myf8t1FHMT8ym3m3fvotfMGHvr5vZdDXmcXYkg3jutSjJFTA/
         y9gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690351388; x=1690956188;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a7DlYDzASdtB1auF6MGXd712hY08PNEA8Sc8ogncFWE=;
        b=a5N2eCSoMhf2V/NnmfJBZ+JJSlTq0CF7jEzLQ8Li+/m457vx3ijdCjGYiu1CUTWnLk
         Ym/6CVT2Q9yWOmIfxf1Iuy49HQ9UsGTCqnrhdRVVTv6tJYkzxvBfk4YLH7DI4OchepJA
         tuC29+FkWKCDtsVVIhlsoDEK8Pj5j/tM4JGiA7u+yzuNcjTr44iUvd2V1YFg0SPA5jnq
         TNcw8N1F6S5cRitHe+1APQ+wDRz2fn9SzgNzIxClTnN0WtbjK9t7Nn18UvC2UK60qwtf
         5FKTYUxG+EMAQe0ac974Eydy5skNsXQtFHpp6DWLF9Zqq2A9Hd3ivsH6hrMDydxJkpEp
         k1mA==
X-Gm-Message-State: ABy/qLZRi6gqgWeuOBmh1izRpxqdwJBw6G+/eeXkO5e5igjKNsXpCRa3
        yfq7qAvPPrPJsWCI7ARSP1U88Q==
X-Google-Smtp-Source: APBJJlFvo7VsS/C63g22gwEOfDJ6YOIq9GHt7yP68E/2suA/U58tj3MYmTlNyJew1cBo1cvwNpe5EQ==
X-Received: by 2002:a7b:c394:0:b0:3fb:a62d:1992 with SMTP id s20-20020a7bc394000000b003fba62d1992mr570581wmj.0.1690351388549;
        Tue, 25 Jul 2023 23:03:08 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id 17-20020a05600c231100b003fc0062f0f8sm1031520wmo.9.2023.07.25.23.03.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jul 2023 23:03:08 -0700 (PDT)
Date:   Wed, 26 Jul 2023 09:03:05 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Baoquan He <bhe@redhat.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Vivek Goyal <vgoyal@redhat.com>, akpm@linux-foundation.org,
        Dave Young <dyoung@redhat.com>, kexec@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] proc/vmcore: fix signedness bug in read_from_oldmem()
Message-ID: <c770613e-1f11-4bff-bc5f-9bc6f07a4da5@kadam.mountain>
References: <b55f7eed-1c65-4adc-95d1-6c7c65a54a6e@moroto.mountain>
 <ZMC1jU7ywPGt1QmO@MiWiFi-R3L-srv>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZMC1jU7ywPGt1QmO@MiWiFi-R3L-srv>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jul 26, 2023 at 01:56:29PM +0800, Baoquan He wrote:
> 
> Thanks for this fix. Just curious, this is found out by code exploring,
> or any breaking?

It's from static analysis, looking at when error codes are type promoted
to unsigned.  I pushed the Smatch check for this yesterday.

https://github.com/error27/smatch/commit/a2e6ca07e2ef83a72c9ffa3508af1398a6ecc7ed

regards,
dan carpenter

