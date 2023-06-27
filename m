Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39FFC73EFE0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jun 2023 02:52:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229501AbjF0Awh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Jun 2023 20:52:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjF0Awg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Jun 2023 20:52:36 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0681D173E
        for <linux-fsdevel@vger.kernel.org>; Mon, 26 Jun 2023 17:52:34 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id 41be03b00d2f7-517ab9a4a13so3061742a12.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 26 Jun 2023 17:52:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20221208.gappssmtp.com; s=20221208; t=1687827154; x=1690419154;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ryIgHmsxKbcUplDve5SF6jrFgRG7g0+BvN6IyPF7cjU=;
        b=Fjlv8dsycijP8Ftk+h4CTLvESS1SXtt7Vfbhug1oYtUrRVOwsIvit9I/0+dAV0CJ/g
         +/NxSJ0rKKvX77CHt+Gf8kp7FIOuDNHtQg89UA+rPpaxbIM9S656mRks5jdsCApLtHVf
         Iulv8Y4i7pk2v8GMxTrMxKWOE7QM9GhFOhkNxZ7W1yjl8mDM6JFc5LjNhFq0c/uInCFO
         CJhqD257jPqBgbFRv5VALAFF6DT7rRe1OH4PIqIHM4Ql5jXgifCUhQSUPb5x3h4h/7mV
         1YPV0aXAd8QiC4Nvljwp2kmA59G9YBGrfeVQl2NMBnG6i7pjK0TPwGO9aAWG/XkORFmG
         qqoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687827154; x=1690419154;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ryIgHmsxKbcUplDve5SF6jrFgRG7g0+BvN6IyPF7cjU=;
        b=aKIxqVRLumEXT6/Bdl+yFr8A0633aq2Vm4scBdzs+iMwLN/dLlnUH+uhkP998App/E
         4QKBwKld4o/BMBD9e/VKCwAIK/W3ZAp9ReEnJhokPEyS6T1Vk1uYkYMQ0/xX3QgbW4xI
         K6QzlrFRAG2UDWxS895TwKQ1EmIF1y33MLNqqTAkQNCWAZCZQm5vn6Vtujw3Ie40FAv9
         BgseznIO5xtkJ8Yabuqn+cn+R8PM2ozlfJ1ZZ+uyJg+ftX4HdlmUneWBYSrU7rCk6uKv
         AONt41o7iMnjQwY/woNOxn20nTS8yfIpwqLTgbXeoe5upBmiUe0zQaoQ1wmCEdPbtcsV
         3zwA==
X-Gm-Message-State: AC+VfDzHPyxJJKoU0IVR/VBEfgrooCd7zO5ohhdH643rA4idBqaR4gAA
        Q93yiBy1OCoQep336qgsxx/A9A==
X-Google-Smtp-Source: ACHHUZ7VJubfQ1j3any7oukdH5Ex6/ON903nuYp23JmVKrnnIhWWp745yjYaU9mvfrt1KkocKhnTHQ==
X-Received: by 2002:a05:6a20:12cc:b0:126:d0e2:3fb4 with SMTP id v12-20020a056a2012cc00b00126d0e23fb4mr7397129pzg.56.1687827154328;
        Mon, 26 Jun 2023 17:52:34 -0700 (PDT)
Received: from dread.disaster.area (pa49-186-94-37.pa.vic.optusnet.com.au. [49.186.94.37])
        by smtp.gmail.com with ESMTPSA id x21-20020aa793b5000000b00673e652985esm2911677pff.44.2023.06.26.17.52.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jun 2023 17:52:33 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
        (envelope-from <david@fromorbit.com>)
        id 1qDwwZ-00GdH2-0w;
        Tue, 27 Jun 2023 10:52:31 +1000
Date:   Tue, 27 Jun 2023 10:52:31 +1000
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
Message-ID: <ZJoyz3ho7eR1ljHV@dread.disaster.area>
References: <ZJnTRfHND0Wi4YcU@tpad>
 <ZJndTjktg17nulcs@casper.infradead.org>
 <ZJofgZ/EHR8kFtth@dread.disaster.area>
 <ZJoppezn+EiLQvUm@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZJoppezn+EiLQvUm@casper.infradead.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 27, 2023 at 01:13:25AM +0100, Matthew Wilcox wrote:
> On Tue, Jun 27, 2023 at 09:30:09AM +1000, Dave Chinner wrote:
> > On Mon, Jun 26, 2023 at 07:47:42PM +0100, Matthew Wilcox wrote:
> > > On Mon, Jun 26, 2023 at 03:04:53PM -0300, Marcelo Tosatti wrote:
> > > > Upon closer investigation, it was found that in current codebase, lookup_bh_lru
> > > > is slower than __find_get_block_slow:
> > > > 
> > > >  114 ns per __find_get_block
> > > >  68 ns per __find_get_block_slow
> > > > 
> > > > So remove the per-CPU buffer_head caching.
> > > 
> > > LOL.  That's amazing.  I can't even see why it's so expensive.  The
> > > local_irq_disable(), perhaps?  Your test case is the best possible
> > > one for lookup_bh_lru() where you're not even doing the copy.
> > 
> > I think it's even simpler than that.
> > 
> > i.e. the lookaside cache is being missed, so it's a pure cost and
> > the code is always having to call __find_get_block_slow() anyway.
> 
> How does that happen?
> 
> __find_get_block(struct block_device *bdev, sector_t block, unsigned size)
> {
>         struct buffer_head *bh = lookup_bh_lru(bdev, block, size);
> 
>         if (bh == NULL) {
>                 /* __find_get_block_slow will mark the page accessed */
>                 bh = __find_get_block_slow(bdev, block);
>                 if (bh)
>                         bh_lru_install(bh);
> 
> The second (and all subsequent) calls to __find_get_block() should find
> the BH in the LRU.
> 
> > IMO, this is an example of how lookaside caches are only a benefit
> > if the working set of items largely fits in the lookaside cache and
> > the cache lookup itself is much, much slower than a lookaside cache
> > miss.
> 
> But the test code he posted always asks for the same buffer each time.
> So it should find it in the lookaside cache?

Oh.

	for (i = 0; ....) {
		bh = __find_get_block(bdev, 1, 512);

That's a '1' being passed to __find_get_block, not 'i'.

/me goes and gets more coffee.

Maybe it's CONFIG_PREEMPT_RT=y doing something to the locks that
isn't obvious here...

-Dave.
-- 
Dave Chinner
david@fromorbit.com
