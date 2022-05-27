Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14811535DF0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 May 2022 12:09:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237394AbiE0KJu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 27 May 2022 06:09:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240588AbiE0KJt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 27 May 2022 06:09:49 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 382C11271AE
        for <linux-fsdevel@vger.kernel.org>; Fri, 27 May 2022 03:09:48 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id g20so4803540edj.10
        for <linux-fsdevel@vger.kernel.org>; Fri, 27 May 2022 03:09:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=kxPnNMX0kfNK6RZbtSAzMK61GhUb48rVr91aOjS8Jjc=;
        b=h5W7HRgSZNk8u8hbAiuGGYO10XuAvVBiFkq2Gxujroxf31neQT2/IL6g5CJMVwE8IQ
         7KhsJVaWKNA7k1BtIGki4RP1HVauP6t8l0030grKhUP2PW3wABSRitieIXLD6yzRG2ZS
         /h2yqqCQ4/DjY7olA/t6oFBHSywNfXVubG0hVLTJoFn4LFZQ0TV2QwrFCOIKQwIvtL/h
         mc8UBWTZtiq+cvEbxaCJHLYNj3lhJi3mTQnTOLtFkyn6ZKL53+9UZR7uRWCurrIluYHk
         u3yQGotWq+fw1RDk5F4GWWlE4erx+u93BZmbhBULeqWyZnGIbEQ5Bef5j0VRRmOZBsB6
         UvQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=kxPnNMX0kfNK6RZbtSAzMK61GhUb48rVr91aOjS8Jjc=;
        b=gzbJZefe2uTEPKkjRs11iNxMMuvV1N9AilWtYf7YUV32/NtwUNLkjdFsNKOAbnrnNl
         UG41G/Xmnr68beGi1mobj/xyEm6boTXdr5oinsvGMgnJlJq26ITlw1XhSkSwqajsx//A
         IoLAxlXH4s+nIXZ2RhX0ZWpqp9s5K/Glls33RcrIsazZPIWIxweeAB8uvPSLyf5afr7n
         qaubN+81o6vhFH1XTpfm1usvEwiqo3mRoYzJ+Zyix2ZGRVWVm/M4CSRqyuCyf4fMDTVx
         7OGrr22hVNRVhaDVO4ychfgPl2iBaEeRIRFPYa8BlOuDHKblLeA7zOgKwmpRGNEiYmMl
         kvow==
X-Gm-Message-State: AOAM533Yabx6TjUUrVc38B0XcKz+h2v0Y7QaqZRzfYZt3vTB3TX6EO2v
        +8zZcRRM0Cqt/Dbb86NxJ7A=
X-Google-Smtp-Source: ABdhPJzsV+fjW8ANeSPoG4PYCg6JwNCJK/usm8tOpV0eq/aG89ade6LjbxyBEwEVgIngM0jJPVJ0XQ==
X-Received: by 2002:a05:6402:ea1:b0:42b:2c59:503 with SMTP id h33-20020a0564020ea100b0042b2c590503mr36277449eda.9.1653646186813;
        Fri, 27 May 2022 03:09:46 -0700 (PDT)
Received: from gmail.com (563BA16F.dsl.pool.telekom.hu. [86.59.161.111])
        by smtp.gmail.com with ESMTPSA id cd26-20020a170906b35a00b006fee526ed72sm1297847ejb.217.2022.05.27.03.09.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 May 2022 03:09:46 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Fri, 27 May 2022 12:09:44 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Samuel Neves <sneves@dei.uc.pt>
Cc:     Jens Axboe <axboe@kernel.dk>, Matthew Wilcox <willy@infradead.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@lst.de>, linux-fsdevel@vger.kernel.org,
        x86@kernel.org
Subject: Re: [RFC] what to do with IOCB_DSYNC?
Message-ID: <YpCjaL9QuuCB23A5@gmail.com>
References: <6ea33ba8-c5a3-a1e7-92d2-da8744662ed9@kernel.dk>
 <YouYvxEl1rF2QO5K@zeniv-ca.linux.org.uk>
 <0343869c-c6d1-5e7c-3bcb-f8d6999a2e04@kernel.dk>
 <YoueZl4Zx0WUH3CS@zeniv-ca.linux.org.uk>
 <6594c360-0c7c-412f-29c9-377ddda16937@kernel.dk>
 <f74235f7-8c55-8def-9a3f-bc5bacd7ee3c@kernel.dk>
 <YoutEnMCVdwlzboT@casper.infradead.org>
 <ef4d18ee-1c3e-2bd6-eff5-344a0359884d@kernel.dk>
 <2ae13aa9-f180-0c71-55db-922c0f18dc1b@kernel.dk>
 <Yo+S4JtT6fjwO5GL@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yo+S4JtT6fjwO5GL@zx2c4.com>
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


* Jason A. Donenfeld <Jason@zx2c4.com> wrote:

> On Mon, May 23, 2022 at 10:03:45AM -0600, Jens Axboe wrote:
> > clear_user()
> > 32	~96MB/sec
> > 64	195MB/sec
> > 128	386MB/sec
> > 1k	2.7GB/sec
> > 4k	7.8GB/sec
> > 16k	14.8GB/sec
> > 
> > copy_from_zero_page()
> > 32	~96MB/sec
> > 64	193MB/sec
> > 128	383MB/sec
> > 1k	2.9GB/sec
> > 4k	9.8GB/sec
> > 16k	21.8GB/sec
> 
> Just FYI, on x86, Samuel Neves proposed some nice clear_user()
> performance improvements that were forgotten about:
> 
> https://lore.kernel.org/lkml/20210523180423.108087-1-sneves@dei.uc.pt/
> https://lore.kernel.org/lkml/Yk9yBcj78mpXOOLL@zx2c4.com/
> 
> Hoping somebody picks this up at some point...

Those ~2x speedup numbers are indeed looking very nice:

| After this patch, on a Skylake CPU, these are the
| before/after figures:
|
| $ dd if=/dev/zero of=/dev/null bs=1024k status=progress
| 94402248704 bytes (94 GB, 88 GiB) copied, 6 s, 15.7 GB/s
|
| $ dd if=/dev/zero of=/dev/null bs=1024k status=progress
| 446476320768 bytes (446 GB, 416 GiB) copied, 15 s, 29.8 GB/s

Patch fell through the cracks & it doesn't apply anymore:

  checking file arch/x86/lib/usercopy_64.c
  Hunk #2 FAILED at 17.
  1 out of 2 hunks FAILED

Would be nice to re-send it.

Thanks,

	Ingo
