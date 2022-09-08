Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 972925B1A37
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Sep 2022 12:40:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229835AbiIHKk6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 8 Sep 2022 06:40:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231401AbiIHKkX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 8 Sep 2022 06:40:23 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 878ADDE95;
        Thu,  8 Sep 2022 03:40:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 35957B82081;
        Thu,  8 Sep 2022 10:40:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FC9EC433D6;
        Thu,  8 Sep 2022 10:40:18 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="R2x7as69"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1662633617;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rFzERdNNevrC+dk5O0IGfVsywNHRk4Kr/4Iz4sKvyFU=;
        b=R2x7as69171ubBp4DXHyPH5dNEtKL1fThjg4C23BsMj+Ix+CEKWCtLVFyy2viH++S5N3qh
        +zsCkLP9NujW8j5Saf+aiK1L1DxYhbvPenVcKQGShRRbE3f7mBpk1RRekR3brCNtw+rAXK
        I42Z07n3fVUXAdXnDzXss1rk1ltP0cQ=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 738b55e3 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Thu, 8 Sep 2022 10:40:16 +0000 (UTC)
Date:   Thu, 8 Sep 2022 12:40:14 +0200
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Eric Biggers <ebiggers@kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Andrew Lutomirski <luto@kernel.org>,
        Theodore Ts'o <tytso@mit.edu>,
        zhongguohua <zhongguohua1@huawei.com>,
        "Guozihua (Scott)" <guozihua@huawei.com>,
        linux-fsdevel@vger.kernel.org
Subject: Re: Inquiry about the removal of flag O_NONBLOCK on /dev/random
Message-ID: <YxnGjppJ7ayDD/dQ@zx2c4.com>
References: <Ytj3RnGtWqg18bxO@sol.localdomain>
 <YtksefZvcFiugeC1@zx2c4.com>
 <29c4a3ec-f23f-f17f-da49-7d79ad88e284@huawei.com>
 <Yt/LPr0uJVheDuuW@zx2c4.com>
 <4a794339-7aaa-8951-8d24-9bc8a79fa9f3@huawei.com>
 <761e849c-3b9d-418e-eb68-664f09b3c661@huawei.com>
 <CAHmME9qBs0EpBBrragaXFJJ+yKEfBdWGkkZp7T60vq8m8x+RdA@mail.gmail.com>
 <YxiWmiLP11UxyTzs@zx2c4.com>
 <efb1e667-d63a-ddb1-d003-f8ba5d506c29@huawei.com>
 <Yxm7OKZxT7tXsTgx@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Yxm7OKZxT7tXsTgx@zx2c4.com>
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hey Al,

I'm CC'ing you into this thread, as you might have an opinion on the
matter. I also have a few odd questions and observations about
implementing this now that we use iters.

On Thu, Sep 08, 2022 at 11:51:52AM +0200, Jason A. Donenfeld wrote:
> The question now before us is whether to bring back the behavior that
> was there pre-5.6, or to keep the behavior that has existed since 5.6.
> Accidental regressions like this (I assume it was accidental, at least)
> that are unnoticed for so long tend to ossify and become the new
> expected behavior. It's been around 2.5 years since 5.6, and this is the
> first report of breakage. But the fact that it does break things for you
> *is* still significant.
> 
> If this was just something you noticed during idle curiosity but doesn't
> have a real impact on anything, then I'm inclined to think we shouldn't
> go changing the behavior /again/ after 2.5 years. But it sounds like
> actually you have a real user space in a product that stopped working
> when you tried to upgrade the kernel from 4.4 to one >5.6. If this is
> the case, then this sounds truly like a userspace-breaking regression,
> which we should fix by restoring the old behavior. Can you confirm this
> is the case? And in the meantime, I'll prepare a patch for restoring
> that old behavior.

The tl;dr of the thread is that kernels before 5.6 would return -EAGAIN
when reading from /dev/random during early boot if the fd was opened
with O_NONBLOCK. Some refactoring done 2.5 years ago evidently removed
this, and so we're now getting a report that this might have broken
something. One question is whether to fix the regression, or if 2.5
years is time enough for ossification. But assuming it should be fixed,
I started looking into implementing that.

The most straight forward approach to directly handle the regression
would be just doing this:

diff --git a/drivers/char/random.c b/drivers/char/random.c
index 79d7d4e4e582..09c944dce7ff 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -1347,6 +1347,9 @@ static ssize_t random_read_iter(struct kiocb *kiocb, struct iov_iter *iter)
 {
 	int ret;

+	if (!crng_ready() && (kiocb->ki_filp->f_flags & O_NONBLOCK))
+		return -EAGAIN;
+
 	ret = wait_for_random_bytes();
 	if (ret != 0)
 		return ret;

So that works. But then I started looking at the other knobs in kiocb
and in the fmode interface in general and landed in a world of
confusion. There are a few other things that might be done:

- Also check `kiocb->ki_flags & IOCB_NOWAIT`.
- Also check `kiocb->ki_flags & IOCB_NOIO`.
- Set the `FMODE_NOWAIT` when declaring the file.
- Other weird aio things?

Do any of these make sense to do?

I started playing with userspace programs to try and trigger some of
those ki_flags, and I saw that the preadv2(2) syscall has the RWF_NOWAIT
flag, so I coded that up and nothing happened. I went grepping and found
some things:

In linux/fs.h:
    #define IOCB_NOWAIT             (__force int) RWF_NOWAIT
so these are intended to be the same. That seems reflected too in
overlayfs/file.c:
    if (ifl & IOCB_NOWAIT)
        flags |= RWF_NOWAIT;
Then later in linux/fs.h, it seems like RWF_NOWAIT is *also* enabling
IOCB_NOIO:
    if (flags & RWF_NOWAIT) {
        if (!(ki->ki_filp->f_mode & FMODE_NOWAIT))
            return -EOPNOTSUPP;
        kiocb_flags |= IOCB_NOIO;
    }
    kiocb_flags |= (__force int) (flags & RWF_SUPPORTED);
But then most of the places involved with IOCB_NOIO are also checking
IOCB_NOWAIT at the same time. Except for one place in filemap?

So it's not really clear to me what the intended behavior is of these,
and I'm wondering if we're hitting another no_llseek-like redundancy
again here, or if something else is up. Or, more likely, I'm just
overwhelmed by the undocumented subtleties here.

Jason
