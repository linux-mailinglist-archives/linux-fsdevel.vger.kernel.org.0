Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90D1A2DAD2B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Dec 2020 13:29:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729237AbgLOMZk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Dec 2020 07:25:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729244AbgLOMZa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Dec 2020 07:25:30 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B52E2C06179C
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Dec 2020 04:24:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=fCNkYUOGOXavF8dupj/77VAPgW2sf5YLkvQsHJzVbDo=; b=Ev8Jf02RNWQjKVfexNvOUqha+B
        EI974vTjzWc42ds5uOW3GBJ34BsNPfhAhzs5dU5kUKD40hu2bPWUT6GarnuNg7MfzkVQCfY0J75Tm
        ympx9jl/4F+lszm1pTof4IH7pb18q31Ws7urICLnza2je80C5PlnADYGeve1fQl9JoHnafWgRf09f
        5AXFIMOX4aZIEeZVpx0IuZn7k0zkyfX6zdLBYSq3UvTA73TMMRZL0gvFDAYpn0R8QRxVerSRMSRcm
        9S0it0IECZb/cHVZpalN/uzp3e7BriA1dRzTESEax187QFcWJHdjp/pLfqEnax1yQ9gfi01gCE+g2
        t8CwGyvQ==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kp9Nn-0003EH-Rr; Tue, 15 Dec 2020 12:24:47 +0000
Date:   Tue, 15 Dec 2020 12:24:47 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-fsdevel@vger.kernel.org, torvalds@linux-foundation.org,
        viro@zeniv.linux.org.uk
Subject: Re: [PATCH 2/4] fs: add support for LOOKUP_NONBLOCK
Message-ID: <20201215122447.GQ2443@casper.infradead.org>
References: <20201214191323.173773-1-axboe@kernel.dk>
 <20201214191323.173773-3-axboe@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201214191323.173773-3-axboe@kernel.dk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Dec 14, 2020 at 12:13:22PM -0700, Jens Axboe wrote:
> +++ b/fs/namei.c
> @@ -686,6 +686,8 @@ static bool try_to_unlazy(struct nameidata *nd)
>  	BUG_ON(!(nd->flags & LOOKUP_RCU));
>  
>  	nd->flags &= ~LOOKUP_RCU;
> +	if (nd->flags & LOOKUP_NONBLOCK)
> +		goto out1;

If we try a walk in a non-blocking context, it fails, then we punt to
a thread, do we want to prohibit that thread trying an RCU walk first?
I can see arguments both ways -- this may only be a temporary RCU walk
failure, or we may never be able to RCU walk this path.

