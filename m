Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E06C7AAE1C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Sep 2023 11:33:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233207AbjIVJdS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Sep 2023 05:33:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233050AbjIVJdF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Sep 2023 05:33:05 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD648192;
        Fri, 22 Sep 2023 02:32:35 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B0F7C433C9;
        Fri, 22 Sep 2023 09:32:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695375155;
        bh=vwZUAYeEfWwnaGPU+f55fpprOAGYNnTdXdHwaC6Ti5o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=o9nXd2ERc/xNm7w0xvgZ+jg3uIJWBrEPTC/DuLDyeLQ2YVjNrOfjXaCb5QoLcXhOQ
         s1yRC7V6cI8Gv0op5YlxFtha2SFI+Gs5PMt/+4yEo9dLmGjdlJbngdoYb/yDveICei
         SL4Jf1YHttuw0WFbBVRKI1FjVXO1bHFaJ/dCTHA6NGz9mUe6PglwaVqVwjKWo97lEr
         uGmtucbm6STBFJ37LXVZh9RAz7h3m0M6LsJ3X3hbbebUGAcM/q46hRo4yCB6F0Cml2
         Q0jWXfW8jwWbgfYj8SCtNd5UhVXZL3ElDucO33i1B/6qbThCgKSjihp+5NfHv8K4Pl
         ql2vtkPWxGuNg==
Date:   Fri, 22 Sep 2023 10:32:27 +0100
From:   Simon Horman <horms@kernel.org>
To:     David Howells <dhowells@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>,
        Christian Brauner <christian@brauner.io>,
        David Laight <David.Laight@aculab.com>,
        Matthew Wilcox <willy@infradead.org>,
        Jeff Layton <jlayton@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-mm@kvack.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 05/11] iov_iter: Convert iterate*() to inline funcs
Message-ID: <20230922093227.GV224399@kernel.org>
References: <20230920222231.686275-1-dhowells@redhat.com>
 <20230920222231.686275-6-dhowells@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230920222231.686275-6-dhowells@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Sep 20, 2023 at 11:22:25PM +0100, David Howells wrote:

...

> @@ -312,23 +192,29 @@ size_t _copy_to_iter(const void *addr, size_t bytes, struct iov_iter *i)
>  		return 0;
>  	if (user_backed_iter(i))
>  		might_fault();
> -	iterate_and_advance(i, bytes, base, len, off,
> -		copyout(base, addr + off, len),
> -		memcpy(base, addr + off, len)
> -	)
> -
> -	return bytes;
> +	return iterate_and_advance(i, bytes, (void *)addr,
> +				   copy_to_user_iter, memcpy_to_iter);
>  }
>  EXPORT_SYMBOL(_copy_to_iter);
>  
>  #ifdef CONFIG_ARCH_HAS_COPY_MC
> -static int copyout_mc(void __user *to, const void *from, size_t n)
> -{
> -	if (access_ok(to, n)) {
> -		instrument_copy_to_user(to, from, n);
> -		n = copy_mc_to_user((__force void *) to, from, n);
> +static __always_inline
> +size_t copy_to_user_iter_mc(void __user *iter_to, size_t progress,
> +			    size_t len, void *from, void *priv2)
> +{
> +	if (access_ok(iter_to, len)) {
> +		from += progress;
> +		instrument_copy_to_user(iter_to, from, len);
> +		len = copy_mc_to_user(iter_to, from, len);

Hi David,

Sparse complains a bit about the line above, perhaps the '(__force void *)'
should be retained from the old code?

 lib/iov_iter.c:208:39: warning: incorrect type in argument 1 (different address spaces)
 lib/iov_iter.c:208:39:    expected void *to
 lib/iov_iter.c:208:39:    got void [noderef] __user *iter_to

>  	}
> -	return n;
> +	return len;
> +}
> +
> +static __always_inline
> +size_t memcpy_to_iter_mc(void *iter_to, size_t progress,
> +			 size_t len, void *from, void *priv2)
> +{
> +	return copy_mc_to_kernel(iter_to, from + progress, len);
>  }
>  
>  /**

...
