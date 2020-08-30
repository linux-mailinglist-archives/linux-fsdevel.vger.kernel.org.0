Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63891256B09
	for <lists+linux-fsdevel@lfdr.de>; Sun, 30 Aug 2020 03:22:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728510AbgH3BWS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 29 Aug 2020 21:22:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728246AbgH3BWR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 29 Aug 2020 21:22:17 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E22B4C061573;
        Sat, 29 Aug 2020 18:21:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=aiqIIVHmY3wPsZLF3CW081k8n4tXc4QrcWEWsn8FuuE=; b=sPAlVSgZookYSkFDWpVCPgmpfg
        cS07a3oX5FX+TbbXFEinQRq7cHwCBWSbNow0NMjH83vTr7ajEwNa97aO8qcqeoB4suuvxoq0VnWum
        njuvX3paolsMGgMxMo703BZLH0ZEd81HdxyCzpVMGQ4PVEFU8ES27rA1XzA3pFldSm5rzKSXE7j7s
        JUcSv38r7Hol/Cpjh/zTDnyQSqQoAuRnVsjPsmEzte+/yxQY1aKe5Rb72uQT+1TMCcjtkSOiPTYzI
        o8eyOHHNIkL4bx2GtwA7i4I8jm0aOC0+q3MC+jxqiJ/dGrMNXR1YLQ4D1AOFvStPRXhF3op2LbtZ8
        eDNOlFUA==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kCC2Z-0004nW-1w; Sun, 30 Aug 2020 01:21:51 +0000
Date:   Sun, 30 Aug 2020 02:21:51 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fat: Avoid oops when bdi->io_pages==0
Message-ID: <20200830012151.GW14765@casper.infradead.org>
References: <87ft85osn6.fsf@mail.parknet.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87ft85osn6.fsf@mail.parknet.co.jp>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Aug 30, 2020 at 09:59:41AM +0900, OGAWA Hirofumi wrote:
> On one system, there was bdi->io_pages==0. This seems to be the bug of
> a driver somewhere, and should fix it though. Anyway, it is better to
> avoid the divide-by-zero Oops.
> 
> So this check it.
> 
> Signed-off-by: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
> Cc: <stable@vger.kernel.org>
> ---
>  fs/fat/fatent.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/fat/fatent.c b/fs/fat/fatent.c
> index f7e3304..98a1c4f 100644
> --- a/fs/fat/fatent.c	2020-08-30 06:52:47.251564566 +0900
> +++ b/fs/fat/fatent.c	2020-08-30 06:54:05.838319213 +0900
> @@ -660,7 +660,7 @@ static void fat_ra_init(struct super_blo
>  	if (fatent->entry >= ent_limit)
>  		return;
>  
> -	if (ra_pages > sb->s_bdi->io_pages)
> +	if (sb->s_bdi->io_pages && ra_pages > sb->s_bdi->io_pages)
>  		ra_pages = rounddown(ra_pages, sb->s_bdi->io_pages);

Wait, rounddown?  ->io_pages is supposed to be the maximum number of
pages to readahead.  Shouldn't this be max() instead of rounddown()?

