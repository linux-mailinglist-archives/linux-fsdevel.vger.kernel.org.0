Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A165C23FEC5
	for <lists+linux-fsdevel@lfdr.de>; Sun,  9 Aug 2020 16:25:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726229AbgHIOZ0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 9 Aug 2020 10:25:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726070AbgHIOZZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 9 Aug 2020 10:25:25 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B81BCC061756;
        Sun,  9 Aug 2020 07:25:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=c6SFV8Ta3BhV757/++za2izKKvmyWv19dAZeDgn4xos=; b=Szz8TMv4A5c1Y/Gz/gcli9sIKE
        qoxNWkxlm1xeFztebJWXne0gL+WPRFzhrNSKGweYcsTNP4PTZh4921EINXgDzLaabUq7pHg0Tcuvj
        DPWyJQpGt6hv55pIDfyXwRV8X/HbtS5M80rFoalK83dCnJN8AfccFo/2ksmSbRB9zMMglW0+tsNhT
        hlcv5OZwEeuQneMR3LtNdvNpsWcKBH2iEs9C18m0XxCXdslemY0WqFrejIjmR8zw97pTzmcSl3C0F
        LKLYHmECoXVFyxsOs2fXzFH4vcnmuZiWbqUEadJ/okKjnKnZ5FIdnUO0aYtvwKtWXf0PT5gA2xnYo
        7xzoh5tQ==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k4mGI-0000QT-O9; Sun, 09 Aug 2020 14:25:22 +0000
Date:   Sun, 9 Aug 2020 15:25:22 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: Very slow qemu device access
Message-ID: <20200809142522.GI17456@casper.infradead.org>
References: <20200807174416.GF17456@casper.infradead.org>
 <20200809024005.GC2134904@T590>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200809024005.GC2134904@T590>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Aug 09, 2020 at 10:40:05AM +0800, Ming Lei wrote:
> Hello Matthew,
> 
> On Fri, Aug 07, 2020 at 06:44:16PM +0100, Matthew Wilcox wrote:
> > 
> > Everything starts going very slowly after this commit:
> > 
> > commit 37f4a24c2469a10a4c16c641671bd766e276cf9f (refs/bisect/bad)
> > Author: Ming Lei <ming.lei@redhat.com>
> > Date:   Tue Jun 30 22:03:57 2020 +0800
> > 
> >     blk-mq: centralise related handling into blk_mq_get_driver_tag
> 
> Yeah, the above is one known bad commit, which is reverted in
> 4e2f62e566b5 ("Revert "blk-mq: put driver tag when this request is completed")
> 
> Finally the fixed patch of 'blk-mq: centralise related handling into blk_mq_get_driver_tag'
> is merged as 568f27006577 ("blk-mq: centralise related handling into blk_mq_get_driver_tag").
> 
> So please test either 4e2f62e566b5 or 568f27006577 and see if there is
> such issue.

4e2f62e566b5 is good
568f27006577 is bad

As before, the stack points to the tag code:

# cat /proc/9986/stack
[<0>] blk_mq_get_tag+0x109/0x250
[<0>] __blk_mq_alloc_request+0x67/0xf0
[<0>] blk_mq_submit_bio+0xee/0x560
[<0>] submit_bio_noacct+0x3a3/0x410
[<0>] submit_bio+0x33/0xf0

It's not nice to leave these little landmines in the git history for
bisect to fall into ;-(
