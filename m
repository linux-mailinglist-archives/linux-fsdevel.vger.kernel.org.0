Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E5305989CF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Aug 2022 19:12:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345393AbiHRRCw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 Aug 2022 13:02:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345440AbiHRRAu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 Aug 2022 13:00:50 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7B3BC9E84
        for <linux-fsdevel@vger.kernel.org>; Thu, 18 Aug 2022 10:00:40 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id r141so1543742iod.4
        for <linux-fsdevel@vger.kernel.org>; Thu, 18 Aug 2022 10:00:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=lYKXgue+zNpIvfPSql7O+R7TEPDE0QJoKDwJiREWf7Y=;
        b=Yf1ObBTNqWoadaVv8CCeNUYTVV68c76B6bJj+OWtTMqEm6y9RVLZxi8pXcWODx7ozI
         ysK0w8bPJ3a3/qEWgxWHSf8bNRPyd+gQ7P8S6Vy+EiuTtxmLhLMP9IGRbIxjif5isELg
         CkB/mjrtD+rDJdFW9t9OnB0z1vy3zsqUsMw+O7MfuvbBQUojyYNprPOTHqsI050/FEBC
         0AUP1wXNqc+Dc8g1iMp63xR65paoeeLq/qNmRaUBSjL51/fm5ViMoCa1vMcMTpN2Hzka
         HZEvd1RftSYXrbo47FE9XPrlCNrx7zuzMGz7N92/ip6K6zZM5wea7ywlo58ZwoXdj0Nq
         rIcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=lYKXgue+zNpIvfPSql7O+R7TEPDE0QJoKDwJiREWf7Y=;
        b=GuntLJ3uxvvdi58YGUnSH/bajVsQ59YS+YIAnSgpJEGqY/oqGuLp30xroXRKgj20ij
         k3mu3XdMXoiap0JpJA5Het0V2OqFzM49HCUQRCRWZoIybN011hNKQgdBblvTwLUfEZa1
         MaP3GHjIzg+su3NUii9YHn/qQxgMySimkDYn9HMtAsk3bkDfgF4gCYtDZaMeSuxX5yWn
         oVuknV2Z+QVhOV8fo1XRD5AGYv4d8ucSNoUehvwTgv4gtHDItzQPeFNOLLIHDOKTTYeP
         KVYb0mSLI2igijTNV1qmk/Epl0RgwniWnh+szXJOtohntvkyJBBqVtZ5lQGES80I1Wrb
         3Pzw==
X-Gm-Message-State: ACgBeo0ytOXtTgogOwwzSFprTEABPuwnxwP0XW1IhIlss8beq+xBppsI
        5olZEVu9SQo3EdHJB254d20hpg==
X-Google-Smtp-Source: AA6agR5Qa8kN5z58ES35WCTjV5f+v9cONWrgP5RrInMX13yzSlj1T9r40gTJhrGdtS/rCxl6RfxTMA==
X-Received: by 2002:a6b:3b87:0:b0:688:9085:cae8 with SMTP id i129-20020a6b3b87000000b006889085cae8mr1861996ioa.118.1660842039991;
        Thu, 18 Aug 2022 10:00:39 -0700 (PDT)
Received: from [192.168.1.172] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id bp17-20020a056638441100b0034366d9ff20sm754283jab.160.2022.08.18.10.00.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Aug 2022 10:00:39 -0700 (PDT)
Message-ID: <b2865bd6-2346-8f4d-168b-17f06bbedbed@kernel.dk>
Date:   Thu, 18 Aug 2022 11:00:38 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: generic/471 regression with async buffered writes?
Content-Language: en-US
To:     "Darrick J. Wong" <djwong@kernel.org>,
        fstests <fstests@vger.kernel.org>
Cc:     io-uring@vger.kernel.org, kernel-team@fb.com, linux-mm@kvack.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        david@fromorbit.com, jack@suse.cz, hch@infradead.org,
        willy@infradead.org, Stefan Roesch <shr@fb.com>
References: <Yv5quvRMZXlDXED/@magnolia>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <Yv5quvRMZXlDXED/@magnolia>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 8/18/22 10:37 AM, Darrick J. Wong wrote:
> Hi everyone,
> 
> I noticed the following fstest failure on XFS on 6.0-rc1 that wasn't
> there in 5.19:
> 
> --- generic/471.out
> +++ generic/471.out.bad
> @@ -2,12 +2,10 @@
>  pwrite: Resource temporarily unavailable
>  wrote 8388608/8388608 bytes at offset 0
>  XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> -RWF_NOWAIT time is within limits.
> +pwrite: Resource temporarily unavailable
> +(standard_in) 1: syntax error
> +RWF_NOWAIT took  seconds
>  00000000:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
>  *
> -00200000:  bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb  ................
> -*
> -00300000:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> -*
>  read 8388608/8388608 bytes at offset 0
>  XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> 
> Is this related to the async buffered write changes, or should I keep
> looking?  AFAICT nobody else has mentioned problems with 471...

The test is just broken. It made some odd assumptions on what RWF_NOWAIT
means with buffered writes. There's been a discussion on it previously,
I'll see if I can find the links. IIRC, the tldr is that the test
doesn't really tie RWF_NOWAIT to whether we'll block or not.

-- 
Jens Axboe
