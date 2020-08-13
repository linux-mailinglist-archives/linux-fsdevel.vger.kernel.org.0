Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9761F2434FB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Aug 2020 09:31:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726072AbgHMHbU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Aug 2020 03:31:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726044AbgHMHbU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Aug 2020 03:31:20 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 291BCC061757;
        Thu, 13 Aug 2020 00:31:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ajCb1YweODRt8vtNgU7fmlorkYYs90KZ1F0rpuEPtl0=; b=YGeTingr3glZ1JMMusE7MilLak
        YI89fMIo2FLGBSdXX9JYBIDTA+JBbbgemHrKTM51+e4gaqUgQylwW6Ii779fE0k0948daKKAI2mHL
        t6r3HKOoxdEUctwqjLGL0tdfqoa1zbfNg5gLflFt+6j9xBojWz9Eaz8PAi7S78FTGfU/1j4oNnq4j
        jFnAjhC3driUp+OJ9ybAced0njDwxF8UujHre2BD53vEGAPhtJZqMWIfGGbF4rNFMkJOT3HsZOoUZ
        5COFx/sIkzxvnttM7QEXRjlJ2bEI+Q+z0ic/BFsDL9J0FrBmIiXW/E1Q5beEsiq+UsD4e+wyQ1w4r
        JIfVgb4A==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k67hj-00049n-W6; Thu, 13 Aug 2020 07:31:16 +0000
Date:   Thu, 13 Aug 2020 08:31:15 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Jacob Wen <jian.w.wen@oracle.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] block: insert a general SMP memory barrier before
 wake_up_bit()
Message-ID: <20200813073115.GA15436@infradead.org>
References: <20200813024438.13170-1-jian.w.wen@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200813024438.13170-1-jian.w.wen@oracle.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Aug 13, 2020 at 10:44:38AM +0800, Jacob Wen wrote:
> wake_up_bit() uses waitqueue_active() that needs the explicit smp_mb().

Sounds like the barrier should go into wake_up_bit then..

> 
> Signed-off-by: Jacob Wen <jian.w.wen@oracle.com>
> ---
>  fs/block_dev.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/fs/block_dev.c b/fs/block_dev.c
> index 0ae656e022fd..e74980848a2a 100644
> --- a/fs/block_dev.c
> +++ b/fs/block_dev.c
> @@ -1175,6 +1175,7 @@ static void bd_clear_claiming(struct block_device *whole, void *holder)
>  	/* tell others that we're done */
>  	BUG_ON(whole->bd_claiming != holder);
>  	whole->bd_claiming = NULL;
> +	smp_mb();
>  	wake_up_bit(&whole->bd_claiming, 0);
>  }
>  
> -- 
> 2.17.1
> 
---end quoted text---
