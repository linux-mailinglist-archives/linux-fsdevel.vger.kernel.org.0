Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C39229C8BC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Oct 2020 20:24:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1829879AbgJ0TWj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Oct 2020 15:22:39 -0400
Received: from casper.infradead.org ([90.155.50.34]:54138 "EHLO
        casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1829872AbgJ0TWh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Oct 2020 15:22:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=NzpIIqIcA9kIWM1rNUUZAYccak4Xft/KknnnsnaUpi4=; b=l7T3pkfrU3ho6RbaY04z7OeCLr
        O5tJw40wPa9EsoPPSoQrngTZTI3WH/t3Hb2ok1rc0GNfwTjkd9Fb5OMt9FerK1uucghKU8FSiQb+D
        Sc91dBMQ/iwMARdogGWpadgk/doN2a/otSdxXfUw43vvy4Kc6/I5HXAGNXwtVpq2cickx8qn6kHvk
        lltjtXCAMVQDqijYvAfX7+YLk8HRvJrhhQpzYi2zk7UjyfBNQGGHpCnUlRY3RXatsOnUjyZ9mb5zJ
        IWx209SdHBtu6U55Z/9zdeaXHLUA2AMpOlBh0FHa+VJYAWEgk3ndkR8Dr3HdXzJS0SADUlajRrbEg
        gQi6cv8g==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kXUY9-0006DW-WE; Tue, 27 Oct 2020 19:22:30 +0000
Date:   Tue, 27 Oct 2020 19:22:29 +0000
From:   Christoph Hellwig <hch@infradead.org>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tejun Heo <tj@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        clang-built-linux@googlegroups.com
Subject: Re: [PATCH v2] seq_file: fix clang warning for NULL pointer
 arithmetic
Message-ID: <20201027192229.GA22829@infradead.org>
References: <20201027145252.3976138-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201027145252.3976138-1-arnd@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> diff --git a/fs/kernfs/file.c b/fs/kernfs/file.c
> index f277d023ebcd..eafeb8bf4fe4 100644
> --- a/fs/kernfs/file.c
> +++ b/fs/kernfs/file.c
> @@ -121,10 +121,10 @@ static void *kernfs_seq_start(struct seq_file *sf, loff_t *ppos)
>  		return next;
>  	} else {
>  		/*
> -		 * The same behavior and code as single_open().  Returns
> -		 * !NULL if pos is at the beginning; otherwise, NULL.
> +		 * The same behavior and code as single_open().  Continues
> +		 * if pos is at the beginning; otherwise, EOF.
>  		 */
> -		return NULL + !*ppos;
> +		return *ppos ? SEQ_OPEN_SINGLE : SEQ_OPEN_EOF;

Why the somewhat obsfucating unary expression instead of a good
old if?

e.g.

		return next;
	}
	if (*ppos)
		retun SEQ_OPEN_SINGLE;
	return NULL;


>  		++*ppos;
> -		return NULL;
> +		return SEQ_OPEN_EOF;

I don't think SEQ_OPEN_EOF is all that useful.  NULL is the documented
end case already.

> diff --git a/include/linux/seq_file.h b/include/linux/seq_file.h
> index 813614d4b71f..26f0758b6551 100644
> --- a/include/linux/seq_file.h
> +++ b/include/linux/seq_file.h
> @@ -37,6 +37,9 @@ struct seq_operations {
>  
>  #define SEQ_SKIP 1
>  
> +#define SEQ_OPEN_EOF	(void *)0
> +#define SEQ_OPEN_SINGLE	(void *)1

I think SEQ_OPEN_SINGLE also wants a comment documenting it.
AFAICS the reason for it is that ->start needs to return something
non-NULL for the seq_file code to make progress, and there is nothing
better for the single_open case.
