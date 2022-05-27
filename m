Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4509535E25
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 May 2022 12:26:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350032AbiE0KZ7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 27 May 2022 06:25:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234079AbiE0KZ7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 27 May 2022 06:25:59 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0056F61295
        for <linux-fsdevel@vger.kernel.org>; Fri, 27 May 2022 03:25:57 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id gi33so7917522ejc.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 27 May 2022 03:25:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ZCzKx/HY0X/xtRmnKEGtxVXaMKlqjGwxMl14qIIXnx0=;
        b=HGaef/di1cJqwqCjrGZlw5lsDEk0XeaHfs9PNRk6qcwIZGxVYsi/RX6YtP9yEkT3Ll
         ZP7LHbdHDCtBnOfEEQDh7/C75/hdoSZvMzMSAmuS6O7or1xoK4Fp21VkRbLY+bH7l322
         laN4DN3fBmkOyKEQGakH3utTQb3lHZo2e2yOWWJtj2ePtWeQEV2grrcRHSCAYDiXn1Da
         hi43NvTSRahqKl8mhQ7E3lMcgMYWQZa96ij9UZClVl6nk/MQWkFvmv4ZZGVLBMrLs9qE
         PCDOdgbfz3lsFHZMdFIHc7gLM297ja/+JRyUMWGZWVlPJwr2HiV7d0vRMZYhKX5ZAySz
         dP9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=ZCzKx/HY0X/xtRmnKEGtxVXaMKlqjGwxMl14qIIXnx0=;
        b=3DgC2qh1LBYl6VETPH0qOxcoAy+2fQQQZObw2kFKvtp/LqOsnuXHWVsO984CeIAx6z
         FB0qVpIHHyavSjF0lsqZqPy85dZyPtwkZYTwK0tRWQRSVnRy4HIMMD6i1GOaE45drkCw
         vWs1ipY+9MQk9Cot7EisCyMP2AzjOrSXohuZJ6D6lh46HiL1pPrDyOmGTQFprfMFNkvC
         iUkk5FC5Vz5g4GjH5rNh1xPKHQn8oKdqdWYw54HotDOOhZTeb7dciNOAvlcncuVseybp
         Cgrmb1TQYWEvDD4g+jfeGcy3bY3FELkkcQPFtVcXEjs2Mn7LB3l+JLukgpdHtk5JZ+eC
         V0dQ==
X-Gm-Message-State: AOAM531mf1/YjgNIL4Aajb7zhb42Q8Ly/YMWgi2yxf959eMP43yHBsu+
        zkcM+LjjyEay+LO9qSgKtlo=
X-Google-Smtp-Source: ABdhPJzUl8J0WQ0lwwpZ0SuauX1plH1rjAiVmByjmQMriEHpD+2zSywoiDU+jLyq5Yl5gsZuueqQBg==
X-Received: by 2002:a17:907:97d1:b0:6f8:5aa9:6f16 with SMTP id js17-20020a17090797d100b006f85aa96f16mr37672181ejc.587.1653647156374;
        Fri, 27 May 2022 03:25:56 -0700 (PDT)
Received: from gmail.com (563BA16F.dsl.pool.telekom.hu. [86.59.161.111])
        by smtp.gmail.com with ESMTPSA id dv5-20020a170906b80500b006f3ef214dd1sm1308619ejb.55.2022.05.27.03.25.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 May 2022 03:25:55 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Fri, 27 May 2022 12:25:53 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Samuel Neves <sneves@dei.uc.pt>
Cc:     Jens Axboe <axboe@kernel.dk>, Matthew Wilcox <willy@infradead.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@lst.de>, linux-fsdevel@vger.kernel.org,
        x86@kernel.org
Subject: Re: [RFC] what to do with IOCB_DSYNC?
Message-ID: <YpCnMaT823RM3qU5@gmail.com>
References: <YouYvxEl1rF2QO5K@zeniv-ca.linux.org.uk>
 <0343869c-c6d1-5e7c-3bcb-f8d6999a2e04@kernel.dk>
 <YoueZl4Zx0WUH3CS@zeniv-ca.linux.org.uk>
 <6594c360-0c7c-412f-29c9-377ddda16937@kernel.dk>
 <f74235f7-8c55-8def-9a3f-bc5bacd7ee3c@kernel.dk>
 <YoutEnMCVdwlzboT@casper.infradead.org>
 <ef4d18ee-1c3e-2bd6-eff5-344a0359884d@kernel.dk>
 <2ae13aa9-f180-0c71-55db-922c0f18dc1b@kernel.dk>
 <Yo+S4JtT6fjwO5GL@zx2c4.com>
 <YpCjaL9QuuCB23A5@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YpCjaL9QuuCB23A5@gmail.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


* Ingo Molnar <mingo@kernel.org> wrote:

> 
> * Jason A. Donenfeld <Jason@zx2c4.com> wrote:
> 
> > On Mon, May 23, 2022 at 10:03:45AM -0600, Jens Axboe wrote:
> > > clear_user()
> > > 32	~96MB/sec
> > > 64	195MB/sec
> > > 128	386MB/sec
> > > 1k	2.7GB/sec
> > > 4k	7.8GB/sec
> > > 16k	14.8GB/sec
> > > 
> > > copy_from_zero_page()
> > > 32	~96MB/sec
> > > 64	193MB/sec
> > > 128	383MB/sec
> > > 1k	2.9GB/sec
> > > 4k	9.8GB/sec
> > > 16k	21.8GB/sec
> > 
> > Just FYI, on x86, Samuel Neves proposed some nice clear_user()
> > performance improvements that were forgotten about:
> > 
> > https://lore.kernel.org/lkml/20210523180423.108087-1-sneves@dei.uc.pt/
> > https://lore.kernel.org/lkml/Yk9yBcj78mpXOOLL@zx2c4.com/
> > 
> > Hoping somebody picks this up at some point...
> 
> Those ~2x speedup numbers are indeed looking very nice:
> 
> | After this patch, on a Skylake CPU, these are the
> | before/after figures:
> |
> | $ dd if=/dev/zero of=/dev/null bs=1024k status=progress
> | 94402248704 bytes (94 GB, 88 GiB) copied, 6 s, 15.7 GB/s
> |
> | $ dd if=/dev/zero of=/dev/null bs=1024k status=progress
> | 446476320768 bytes (446 GB, 416 GiB) copied, 15 s, 29.8 GB/s
> 
> Patch fell through the cracks & it doesn't apply anymore:
> 
>   checking file arch/x86/lib/usercopy_64.c
>   Hunk #2 FAILED at 17.
>   1 out of 2 hunks FAILED
> 
> Would be nice to re-send it.

Turns out Boris just sent a competing optimization to clear_user() 3 days ago:

  https://lore.kernel.org/r/YozQZMyQ0NDdD8cH@zn.tnic

Thanks,

	Ingo
