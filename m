Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABD3E5350F7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 May 2022 16:47:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245267AbiEZOrO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 26 May 2022 10:47:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347736AbiEZOrL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 26 May 2022 10:47:11 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CF1220BCC
        for <linux-fsdevel@vger.kernel.org>; Thu, 26 May 2022 07:47:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CFFD5B820F8
        for <linux-fsdevel@vger.kernel.org>; Thu, 26 May 2022 14:47:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6E6FC385A9;
        Thu, 26 May 2022 14:47:03 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="bR5QieuF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1653576422;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qlg0D7t6m5vNAARZb66/P3VDfiBplW1kc1c3tetuqvg=;
        b=bR5QieuF3jlsgoECQGnm07qptNbWLM21ZFebRW1bdk+QLO/tF8j/n37mMKZNj6jWqik3sv
        WPYzSxghhBQzYitbolGbTsE2xuUxvUJqE0rj99qgl7a4XxycV/7gwYAlBtR79XhH9bUhxP
        SfS8wa2VSKnQXPWJFcCZP6Ch8twyBJI=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 19c32fa6 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Thu, 26 May 2022 14:47:01 +0000 (UTC)
Date:   Thu, 26 May 2022 16:46:56 +0200
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@lst.de>, linux-fsdevel@vger.kernel.org,
        x86@kernel.org
Subject: Re: [RFC] what to do with IOCB_DSYNC?
Message-ID: <Yo+S4JtT6fjwO5GL@zx2c4.com>
References: <9c3a6ad4-cdb5-8e0d-9b01-c2825ea891ad@kernel.dk>
 <6ea33ba8-c5a3-a1e7-92d2-da8744662ed9@kernel.dk>
 <YouYvxEl1rF2QO5K@zeniv-ca.linux.org.uk>
 <0343869c-c6d1-5e7c-3bcb-f8d6999a2e04@kernel.dk>
 <YoueZl4Zx0WUH3CS@zeniv-ca.linux.org.uk>
 <6594c360-0c7c-412f-29c9-377ddda16937@kernel.dk>
 <f74235f7-8c55-8def-9a3f-bc5bacd7ee3c@kernel.dk>
 <YoutEnMCVdwlzboT@casper.infradead.org>
 <ef4d18ee-1c3e-2bd6-eff5-344a0359884d@kernel.dk>
 <2ae13aa9-f180-0c71-55db-922c0f18dc1b@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2ae13aa9-f180-0c71-55db-922c0f18dc1b@kernel.dk>
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, May 23, 2022 at 10:03:45AM -0600, Jens Axboe wrote:
> clear_user()
> 32	~96MB/sec
> 64	195MB/sec
> 128	386MB/sec
> 1k	2.7GB/sec
> 4k	7.8GB/sec
> 16k	14.8GB/sec
> 
> copy_from_zero_page()
> 32	~96MB/sec
> 64	193MB/sec
> 128	383MB/sec
> 1k	2.9GB/sec
> 4k	9.8GB/sec
> 16k	21.8GB/sec

Just FYI, on x86, Samuel Neves proposed some nice clear_user()
performance improvements that were forgotten about:

https://lore.kernel.org/lkml/20210523180423.108087-1-sneves@dei.uc.pt/
https://lore.kernel.org/lkml/Yk9yBcj78mpXOOLL@zx2c4.com/

Hoping somebody picks this up at some point...

Jason
