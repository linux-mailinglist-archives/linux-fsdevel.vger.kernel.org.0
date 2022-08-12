Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8EB659177C
	for <lists+linux-fsdevel@lfdr.de>; Sat, 13 Aug 2022 01:00:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235252AbiHLXAX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 12 Aug 2022 19:00:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234527AbiHLXAV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 12 Aug 2022 19:00:21 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40C1128709
        for <linux-fsdevel@vger.kernel.org>; Fri, 12 Aug 2022 16:00:20 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id bh13so1933173pgb.4
        for <linux-fsdevel@vger.kernel.org>; Fri, 12 Aug 2022 16:00:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=pUNWkjszMYZBFHroYs6rd5N4Fu75mFK6lm079OKJfbw=;
        b=OBoh4QL9dNHnWIhTale1OJxVwy9QLsmWe0VqGHE6v9FfWqZ64XnP34avtT0Q54c3Mb
         kWOzDrPK2HIuQZmvUwG5lCNYwroiOl1TmusXrkGhRYaLXBnSBCOeoW1+aWS+18taEIov
         VQvorfcYsfy49x/8ClIr23LIuDAnTPF8PCdMFRkMv1YJaDyiBJCgtc9gkDkj5gmFYAzE
         d8FUddaGRxhJWDv+q4+1Bob+Z3fa1NgL7q56HNnKsmRHma712o/ACQtzN9UeubDfWNMN
         h1pIIsXMlKbS8YULKM+8L/kpyZcpyk/xpOVQsO49Rn3WC+fx+sAFUTWmorrho6nDXllU
         FEyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=pUNWkjszMYZBFHroYs6rd5N4Fu75mFK6lm079OKJfbw=;
        b=3sPE6UIqPd/+H7yqdu2I7Jb5fuW6zJHMAIgHoJvEly5KS6WJufl6TEmYgXYziJW+Y0
         S6+oUlThTLbEhApfPfR3tCuYJMGyVaF9NJyBZGUcopFtZwZ8aFjswjxXhjGCgP7TQBvz
         6rsG5qfPuyeWcd6e4AtOaGhohf8J+A7/zYzonePz55wfv3dvfeTpnJ0ObWO3lIVDaY0l
         6JOPErGEgZ49zFEukb33n0D3vGB5UUkppf5N74bwGGL0ddW2pvw2zIxmi5elYZCCmlbk
         NS5x1huQjT/WrdroueXjpql04YCNBXt1tvZRy9Numuf7DyvVfuzrteKDE8aUZWM61kc4
         U4zw==
X-Gm-Message-State: ACgBeo0cpqnJ7VnhsPY0quEdd16tqrJ0GGGcmBcztohx/fffWfuOLVri
        2suN3MRYvIevcteuCTICPkCzlNImnh4EOw==
X-Google-Smtp-Source: AA6agR7Vr48zlj57DBqPlIRW0ba5Ne9nYim2sIjAYqqFP4Rl660T7yUBFmfS/tZVcKR3Mb3DIQZp5A==
X-Received: by 2002:a65:6bca:0:b0:420:712f:ab98 with SMTP id e10-20020a656bca000000b00420712fab98mr4850132pgw.350.1660345219685;
        Fri, 12 Aug 2022 16:00:19 -0700 (PDT)
Received: from [192.168.1.100] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id q8-20020a170902788800b0016d6420691asm2268554pll.207.2022.08.12.16.00.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Aug 2022 16:00:19 -0700 (PDT)
Message-ID: <8773ef66-e6a4-ed64-71ed-837cac5341f5@kernel.dk>
Date:   Fri, 12 Aug 2022 17:00:18 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH] fs: don't randomized kiocb fields
Content-Language: en-US
To:     Keith Busch <kbusch@fb.com>, io-uring@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, Keith Busch <kbusch@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
References: <20220812225633.3287847-1-kbusch@fb.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20220812225633.3287847-1-kbusch@fb.com>
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

On 8/12/22 4:56 PM, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> This is a size sensitive structure and randomizing can introduce extra
> padding that breaks io_uring's fixed size expectations. There are few
> fields here as it is, half of which need a fixed order to optimally
> pack, so the randomization isn't providing much.

I'll add the link to the previous discussion as well in the commit:

Link: https://lore.kernel.org/io-uring/b6f508ca-b1b2-5f40-7998-e4cff1cf7212@kernel.dk/

as it's pretty useful for context.

-- 
Jens Axboe

