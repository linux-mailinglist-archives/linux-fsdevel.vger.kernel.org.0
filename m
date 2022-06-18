Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95AB35505D3
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 Jun 2022 17:40:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230476AbiFRPkm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 18 Jun 2022 11:40:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230133AbiFRPkl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 18 Jun 2022 11:40:41 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EC45DEC7
        for <linux-fsdevel@vger.kernel.org>; Sat, 18 Jun 2022 08:40:40 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id bo5so6605587pfb.4
        for <linux-fsdevel@vger.kernel.org>; Sat, 18 Jun 2022 08:40:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=ZLkY3cE0IUeApUIuHPY9ssOzsJj7BWsw1rKtZAvtB3E=;
        b=UvYb0kVZX8vyP6UmcplMqJuibAjFAm5M25NW9RgJwH4vETr1ZSvBuJop9iQp+X5JZU
         QahWd9yRsjrlMHIx/7ARFUWpQL1di363Rg7FvRIJ6XpZqos+ZWaP7/fYPth1cC9+aOSF
         6paS50qFICJGzQ15tb6wRoz+yraLMOWpheKA27jNa7Zy2JmuNZveoLIT6C8qIAid3G8K
         mmebT3BgwU3rhZR7iXPPtpBZ6asK3L+jqFTMae9XzJ+evgKyHhQ9AyXapfNazaScVAID
         ADhM45r2qBmiYRQyPcZ3Xwv3tlQE2Qzpc3zLGjQxXByImhVgo4MfwJfAQ75doaT47JZL
         ROSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ZLkY3cE0IUeApUIuHPY9ssOzsJj7BWsw1rKtZAvtB3E=;
        b=IH3JvqXNm9H7mkjaTs6pGfAzgLL5lsgy+mhR1fW5j5LHjnlJIStYS9Z/pfqfxZ75TJ
         V5VmS0C+/U/QUv4De/cpTqgEuDHpCJHlFcb3EXneSImBeog+HXTiynCc0Uab2215Tq4u
         Ee5ghbL9EezwZ1tF7xXSaE7KY+0/A4Pynz020jd9tQzl+73UHfunCUBrvJCD37NTJI0Y
         8cdLmYMhM6e5/vrGvzXaSV44w71GsBQbx82lM/RuREBOvsamb8Lt20P5qRHn1A7Sx4td
         vCMuGVfHU4ifJRf3V1BQsdvrhWJdw5HRq3nES2uUjmBHVJsb27kvVgbO16PtUwHOA1yJ
         1Edg==
X-Gm-Message-State: AJIora9Q59Xm4DAP2srRq2gFGNeeATf0lq5HBu7wbG9wMbPdfS6mFS1a
        kqY/xInwibS5CiDk2lAWtevUB0yI5xwrrg==
X-Google-Smtp-Source: AGRyM1vYbrhaR1R0IeWMRO5TTF0Fbx5p3dXm1+r4+DHfZAsEm9bRHbCt5fDAVuIZ+jlJWRBeU1jZhQ==
X-Received: by 2002:a05:6a00:248b:b0:51c:4f53:a932 with SMTP id c11-20020a056a00248b00b0051c4f53a932mr15441243pfv.51.1655566839949;
        Sat, 18 Jun 2022 08:40:39 -0700 (PDT)
Received: from [192.168.1.100] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id iy12-20020a170903130c00b0016a0db8c5b4sm2186312plb.156.2022.06.18.08.40.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 18 Jun 2022 08:40:39 -0700 (PDT)
Message-ID: <c5577e09-a48e-cf5e-926a-433ef2f33974@kernel.dk>
Date:   Sat, 18 Jun 2022 09:40:38 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH RFC] iov_iter: import single segments iovecs as ITER_UBUF
Content-Language: en-US
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
References: <b3e19eb1-18c4-8599-b68d-bf28673237d1@kernel.dk>
 <Yq3s/K31CxG/H+lJ@ZenIV>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <Yq3s/K31CxG/H+lJ@ZenIV>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 6/18/22 9:19 AM, Al Viro wrote:
> On Sat, Jun 18, 2022 at 08:08:08AM -0600, Jens Axboe wrote:
>> Using an ITER_UBUF is more efficient than an ITER_IOV, and for the single
>> segment case, there's no reason to use an ITER_IOV when an ITER_UBUF will
>> do. Experimental data collected shows that ~2/3rds of iovec imports are
>> single segments, from applications using readv/writev or recvmsg/sendmsg
>> that are iovec based.
>>
>> Explicitly check for nr_segs == 1 and import those as ubuf rather than
>> iovec based iterators.
> 
> Hadn't we'd been through that before?   There is infinibarf code that
> assumes ITER_IOVEC for what its ->write_iter() gets (and yes, that's
> the one that has ->write() with different semantics).

This is why it's an RFC... Would like to do something about that!

> And I wouldn't bet a dime on all ->sendmsg() and ->recvmsg() being
> flavour-agnostic either...

FWIW, the liburing regressions tests do have sendmsg/recvmsg and at
least basic stuff works. Haven't looked at all deeper on whether this is
always the case.

-- 
Jens Axboe

