Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26FEC243C10
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Aug 2020 16:59:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726648AbgHMO7r (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Aug 2020 10:59:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726167AbgHMO7q (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Aug 2020 10:59:46 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFF41C061757;
        Thu, 13 Aug 2020 07:59:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=bkGaimRn3HJQX0Qg2ziFOPhLu2C68xbsc3XQPYev/dg=; b=t0CsZonkeoUp0y/iRINU8iRTgr
        IW3+ZMhz0P0Gb40zcA1vKgdneumsETwE8HC6IK8tXdXccdVAxlLfavDBwtiN9T4AaorCigeYOdoLS
        q2rG8Ad+bfogm1/BYWbJSXTF6A/Eu0swwEv1IxMTnFaX8WchVEkZOiCGgn9OyC6gLhs0e639e4FFy
        nqthiQDNo5308HqSMcOVW9plWWZSwfDvofyOrpOqFgOA170rVwCCUDGUvfg77VR8aO4E5ur3FF6L/
        OfNcF2nXsyzfzzxVgmRHF6mcrizlvmNMzQfVGyqdkEmoqQsxOmGl9KaOcwGQ1RNZGGHxA1B2WltY3
        RNB/t6rg==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k6Ehh-00061x-Ju; Thu, 13 Aug 2020 14:59:41 +0000
Date:   Thu, 13 Aug 2020 15:59:41 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     hch@lst.de, viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH] proc: use vmalloc for our kernel buffer
Message-ID: <20200813145941.GJ17456@casper.infradead.org>
References: <20200813145305.805730-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200813145305.805730-1-josef@toxicpanda.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Aug 13, 2020 at 10:53:05AM -0400, Josef Bacik wrote:
> +/**
> + * vmemdup_user - duplicate memory region from user space and NUL-terminate

vmemdup_user_nul()

> +void *vmemdup_user_nul(const void __user *src, size_t len)
> +{
> +	void *p;
> +
> +	p = kvmalloc(len, GFP_USER);

len+1, shirley?

> +	if (!p)
> +		return ERR_PTR(-ENOMEM);
> +
> +	if (copy_from_user(p, src, len)) {
> +		kvfree(p);
> +		return ERR_PTR(-EFAULT);
> +	}

I think you forgot

        p[len] = '\0';

> +	return p;
> +}
> +EXPORT_SYMBOL(vmemdup_user_nul);
> +
>  /**
>   * strndup_user - duplicate an existing string from user space
>   * @s: The string to duplicate
> -- 
> 2.24.1
> 
