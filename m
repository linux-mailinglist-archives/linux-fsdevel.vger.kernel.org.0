Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA04F650485
	for <lists+linux-fsdevel@lfdr.de>; Sun, 18 Dec 2022 20:47:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230427AbiLRTrJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 18 Dec 2022 14:47:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbiLRTrI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 18 Dec 2022 14:47:08 -0500
Received: from nautica.notk.org (ipv6.notk.org [IPv6:2001:41d0:1:7a93::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DDC355A2;
        Sun, 18 Dec 2022 11:47:06 -0800 (PST)
Received: by nautica.notk.org (Postfix, from userid 108)
        id 33EE4C01D; Sun, 18 Dec 2022 20:47:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1671392837; bh=Yu3PGd7/R0vNpUqHyhroP64tzfAp/2f6p+c45XHWGyo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sjkJqnkxzqA0kr0fL1xuo1sL/rP2NFZg4xG1hhlNkmCULZ0uPIuj4uU/OTDcvuqjj
         vQT9ceEYolAYoLdBOCsn9mcAptMqcZSLTokucGEtuHrnmmEJa6sd4t0Kkw8HUbsbzg
         O02maKONKpYCul+LZYbt2MLsWVE62fdUEkHAIvkl+3hsdh9G+ojWOtO4zP6OJ4WiZ+
         rhPs4zKX2XmwfD1J8HcGXbQFBLaXqf9xXghT3IAdgL4w/TBBXqULmwAfiCs/tx3/8P
         Tqb24sOmdZGpmDNgLjbzFdyGuOzjjkTX96nHB5HiGwpiGlJY3CBXjc9QmdcciXhI7m
         VVdoLIgRxj4sg==
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
Received: from odin.codewreck.org (localhost [127.0.0.1])
        by nautica.notk.org (Postfix) with ESMTPS id 32E47C009;
        Sun, 18 Dec 2022 20:47:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1671392836; bh=Yu3PGd7/R0vNpUqHyhroP64tzfAp/2f6p+c45XHWGyo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SmgJqAMVCUcHsTFWdwG1Sv43aZ+Oncsdi0p+RYThslGjfadRWU3s7YHmQwmslCxjT
         zU5SagpmLAZhphkzI53IPBjp3iGl2wqtm2n/7mtg6vg10JM/wX642WFYVHQ2yX2qNn
         AOyXl0FtWckAG8J0tiWUEM39dSd9MjL3KFgWYscba5/iQJZAciEjUjgchUzyAYyJqv
         q2Q/GvJVYFxCfqx1XtvBe3COXmCOHZKCocO5XNRzNTMRTy+7xhbIYDh395WPl9ctv8
         t+/jThkywrAy0uD2366wstQNkjjZZjrA/0ti9Ms87HwOX0+4ovY/1bddZgLHmg34P2
         5Vzna0MrkOrmg==
Received: from localhost (odin.codewreck.org [local])
        by odin.codewreck.org (OpenSMTPD) with ESMTPA id 1ccad86e;
        Sun, 18 Dec 2022 19:46:58 +0000 (UTC)
Date:   Mon, 19 Dec 2022 04:46:43 +0900
From:   asmadeus@codewreck.org
To:     ron minnich <rminnich@gmail.com>
Cc:     evanhensbergen@icloud.com, Eric Van Hensbergen <ericvh@gmail.com>,
        Christian Schoenebeck <linux_oss@crudebyte.com>,
        v9fs-developer@lists.sourceforge.net,
        Latchesar Ionkov <lucho@ionkov.net>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 1/6] Adjust maximum MSIZE to account for p9 header
Message-ID: <Y59uIwoECw0yHhf1@codewreck.org>
References: <20221217185210.1431478-1-evanhensbergen@icloud.com>
 <20221217185210.1431478-2-evanhensbergen@icloud.com>
 <4530979.Ltmge6kleC@silver>
 <CAFkjPTmoQvzaSsSOAgM9_0+knudWsdi8=TnMOTXZj05hT6tneQ@mail.gmail.com>
 <51FD8D16-4070-4DCF-AEB5-11640A82762E@icloud.com>
 <CAP6exY+BF+1fjjUKX20vvbTZXiZ2gxUN3zc8+ZaHTY-aX6fRFQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAP6exY+BF+1fjjUKX20vvbTZXiZ2gxUN3zc8+ZaHTY-aX6fRFQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

ron minnich wrote on Sun, Dec 18, 2022 at 08:50:18AM -0800:
> it's fine. tbh, I doubt the fact that you were fetching 31 vs 32 pages
> mattered as much as the fact that you weren't fetching *4k at a time* :-)

Yes, I think we can just blanket this as +4k and it wouldn't change
much; I've been using 1MB+4k for rdma in previous tests...

We still aren't doing things 4k at a time with this though, I'd suggest
rounding down the rsize > msize check in p9_client_read_once():

        if (!rsize || rsize > clnt->msize - P9_IOHDRSZ)
                rsize = clnt->msize - P9_IOHDRSZ;

to something that's better aligned; for some reason I thought we had
that already.  . . but thinking again the sizes are probably driven by
the cache and will be 4k multiples already?

> > -#define DEFAULT_MSIZE (128 * 1024)
> > +/* DEFAULT MSIZE = 32 pages worth of payload + P9_HDRSZ +
> > + * room for write (16 extra) or read (11 extra) operands.
> > + */
> > +
> > +#define DEFAULT_MSIZE ((128 * 1024) + P9_HDRSZ + 16)

There's P9_IOHDRSZ for that ;)

But I guess with the comment it doesn't matter much either way.

-- 
Dominique
