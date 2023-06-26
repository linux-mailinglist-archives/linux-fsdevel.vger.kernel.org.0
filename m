Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE56673EF4B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jun 2023 01:30:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229724AbjFZXaR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Jun 2023 19:30:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbjFZXaQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Jun 2023 19:30:16 -0400
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C91DC1991
        for <linux-fsdevel@vger.kernel.org>; Mon, 26 Jun 2023 16:30:14 -0700 (PDT)
Received: by mail-oi1-x22c.google.com with SMTP id 5614622812f47-39ca48cd4c6so2797313b6e.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 26 Jun 2023 16:30:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20221208.gappssmtp.com; s=20221208; t=1687822214; x=1690414214;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pIFsN2elWZC5RqViV1mbnouEvdYpsztruO1AICvp7AE=;
        b=x62up01QN61j8uRDxz5+FQdVAIz4y5nE7af1TY1P6HUsA8oRbu2KL5BdSvzt4zsimY
         q0xyw5eF/2C4e4Jflz/eOnqHI6nEqIwnvBAJPvAGi0ulO4nAe5EzJrdufGs9TEMsxWvH
         vZs34YLgDNK/0PQmZiOPakarhsOs6gtF1LsMCu8HxHF34dqM1920OHH2zqLFfFuEKsjR
         h6glMEWDE51bc2/JU5JpEKbQVfmu2CTf4s9dwn4ogd7qA4pldpwiivy9X1uyJmkCGvS9
         ro0NeDMgmkuHJ2V0qnJcMlHSeJbdgGNuRwVIkTM2ndk40U1wP8cKBuAAAeWzQw4a1nQZ
         6SBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687822214; x=1690414214;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pIFsN2elWZC5RqViV1mbnouEvdYpsztruO1AICvp7AE=;
        b=DlaADH86bfJDlewPJAHqotEszY2xtSPCNIbcA/+mzetSkY0DgtmCuUT12zUk/fLeXF
         9mL6N9l9AN9VsHmwtUT1K/RLW7LPYWO1ovB1ocMjHibSvndouygprvTgDtY27NH6UHwM
         9nLFdAQccifl+pzDEojr2BigXUvt+PWsn/6zs5y5+XqibR8OMkSH79akdu4+Tzeade6V
         hRv6/skj9VNspCbni/Dk7bldAWZ1Qlq6O7uOdVvO1P4Wr/R5aASxB52hdpup66vpPZx/
         vAIbKtnqJu7vwwrPjmwno55+1iSC4wpqrrkkmXeVJh3+bOnhiWMgl650sIIi7V6MgX2p
         01yg==
X-Gm-Message-State: AC+VfDw4MhWbuY9shXY5V22ihfiDCh9d49krkLN5y9aSOGO43yuXDvzh
        +UnLMbQQIZxVvHHiZNQciE4TeA==
X-Google-Smtp-Source: ACHHUZ58Ld9NBRiv6cF5YroDnkul8epKv/2ZkL5s7qwM1op4ejFcZXkw7gUcAKrwKUEsgdWbGxULYQ==
X-Received: by 2002:a54:4186:0:b0:3a1:a5a7:ec58 with SMTP id 6-20020a544186000000b003a1a5a7ec58mr8996933oiy.0.1687822214105;
        Mon, 26 Jun 2023 16:30:14 -0700 (PDT)
Received: from dread.disaster.area (pa49-186-94-37.pa.vic.optusnet.com.au. [49.186.94.37])
        by smtp.gmail.com with ESMTPSA id j3-20020a635943000000b00553b546a638sm4563860pgm.67.2023.06.26.16.30.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jun 2023 16:30:13 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
        (envelope-from <david@fromorbit.com>)
        id 1qDver-00Gc0G-1Q;
        Tue, 27 Jun 2023 09:30:09 +1000
Date:   Tue, 27 Jun 2023 09:30:09 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Marcelo Tosatti <mtosatti@redhat.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Frederic Weisbecker <frederic@kernel.org>,
        Valentin Schneider <vschneid@redhat.com>,
        Leonardo Bras <leobras@redhat.com>,
        Yair Podemsky <ypodemsk@redhat.com>, P J P <ppandit@redhat.com>
Subject: Re: [PATCH] fs/buffer.c: remove per-CPU buffer_head lookup cache
Message-ID: <ZJofgZ/EHR8kFtth@dread.disaster.area>
References: <ZJnTRfHND0Wi4YcU@tpad>
 <ZJndTjktg17nulcs@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZJndTjktg17nulcs@casper.infradead.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jun 26, 2023 at 07:47:42PM +0100, Matthew Wilcox wrote:
> On Mon, Jun 26, 2023 at 03:04:53PM -0300, Marcelo Tosatti wrote:
> > Upon closer investigation, it was found that in current codebase, lookup_bh_lru
> > is slower than __find_get_block_slow:
> > 
> >  114 ns per __find_get_block
> >  68 ns per __find_get_block_slow
> > 
> > So remove the per-CPU buffer_head caching.
> 
> LOL.  That's amazing.  I can't even see why it's so expensive.  The
> local_irq_disable(), perhaps?  Your test case is the best possible
> one for lookup_bh_lru() where you're not even doing the copy.

I think it's even simpler than that.

i.e. the lookaside cache is being missed, so it's a pure cost and
the code is always having to call __find_get_block_slow() anyway.
Peeking at 16 buffers to not find a match is just as expensive as
walking 3-4 tree levels in an Xarray to find the buffer in the first
place....

IMO, this is an example of how lookaside caches are only a benefit
if the working set of items largely fits in the lookaside cache and
the cache lookup itself is much, much slower than a lookaside cache
miss.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
