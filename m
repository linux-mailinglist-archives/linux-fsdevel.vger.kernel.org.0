Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 564593448EC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Mar 2021 16:12:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231520AbhCVPML (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 22 Mar 2021 11:12:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231610AbhCVPLs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 22 Mar 2021 11:11:48 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB101C061574;
        Mon, 22 Mar 2021 08:11:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=bWwMeij2Q8Z9ckhvEzwYdMKKVhuReAFZwXY42M3v8pY=; b=QHqf9Jaql6xFxojr6GQ10Pc+Ky
        paGncHPofAK6gMSBgB8PRlS0ehBLiHboidWgEfGYtoHUT/b6kuUO4Vn+sgEKa/ujftotzKrvZHmKD
        fCFC5LyTKeURZmUJGe2JaFVbvvshYWCPzkZaWKKMpnSPw5eXD2/tKD0QA0FkszkGpiP7LtkE0r+bE
        TPnttew8YgKRrnuN3tMCWCVxZhNhXKGBTGqh55ogenVyzY9Cj2KcSl9xY5A8toUI85HST5cTlJgzP
        DYoOlm4Um3Pt1SOR0bPDmoYyPBm2RT56CbK9J+4I6ltVKRtdZRHY7OU3ewp4XzHyyvn4Mb9etVrws
        QbiUk2mQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lOMDE-008h9j-JS; Mon, 22 Mar 2021 15:11:29 +0000
Date:   Mon, 22 Mar 2021 15:11:24 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Mikulas Patocka <mpatocka@redhat.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Jens Axboe <axboe@kernel.dk>, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org
Subject: Re: [PATCH] buffer: a small optimization in grow_buffers
Message-ID: <20210322151124.GP1719932@casper.infradead.org>
References: <alpine.LRH.2.02.2103221002360.19948@file01.intranet.prod.int.rdu2.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LRH.2.02.2103221002360.19948@file01.intranet.prod.int.rdu2.redhat.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Mar 22, 2021 at 10:05:05AM -0400, Mikulas Patocka wrote:
> This patch replaces a loop with a "tzcnt" instruction.

Are you sure that's an optimisation?  The loop would execute very few
times under normal circumstances (a maximum of three times on x86).
Some numbers would be nice.

> Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
> 
> Index: linux-2.6/fs/buffer.c
> ===================================================================
> --- linux-2.6.orig/fs/buffer.c
> +++ linux-2.6/fs/buffer.c

Are ... are you still using CVS?!

> @@ -1020,11 +1020,7 @@ grow_buffers(struct block_device *bdev,
>  	pgoff_t index;
>  	int sizebits;
>  
> -	sizebits = -1;
> -	do {
> -		sizebits++;
> -	} while ((size << sizebits) < PAGE_SIZE);
> -
> +	sizebits = PAGE_SHIFT - __ffs(size);
>  	index = block >> sizebits;
>  
>  	/*
> 
