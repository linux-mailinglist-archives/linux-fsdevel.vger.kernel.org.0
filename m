Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 413C01F07BF
	for <lists+linux-fsdevel@lfdr.de>; Sat,  6 Jun 2020 17:52:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728078AbgFFPwa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 6 Jun 2020 11:52:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727100AbgFFPw3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 6 Jun 2020 11:52:29 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E378C03E96A;
        Sat,  6 Jun 2020 08:52:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=9Knot+Lv+Z0XYiseAFBiA62c5+NhkBbKX/gLTI08qrs=; b=BIkLwIVPjTQ4Z6dLUSwN9BNF2d
        jF6fhDw7QKtkUY0qVUNSVq9AuL8hjm+dtqFVaVANc6f6TM0lnrILTlyCzv0Zn5AN1XdlGt9cdBwHi
        zD4X30KKbBKG0kzETQ6drLgJ3Xm5yfjabYFhl168BExjPSZP8wck4zfkTJ/uEj0mPlieD9rGrnMG6
        oHS20QVWiOO4dubZEecydxU8HQa8CKlZjNY5CeOYhnFTWlNFS18HJHQ5PEw6bzRyrREoU/dHDX3lo
        5nr4gMAxgOOu45lOty30n8+bLPrmT9YJXIxJAyFMEXFkjOBDaMyZrsiHZP9xz4cTJdqHnZJglVMc5
        Y9vIXEPQ==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jhb7I-0001SV-JG; Sat, 06 Jun 2020 15:52:16 +0000
Date:   Sat, 6 Jun 2020 08:52:16 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Scott Branden <scott.branden@broadcom.com>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Wolfram Sang <wsa@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        David Brown <david.brown@linaro.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Shuah Khan <shuah@kernel.org>, bjorn.andersson@linaro.org,
        Shuah Khan <skhan@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Mimi Zohar <zohar@linux.ibm.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        Olof Johansson <olof@lixom.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Colin Ian King <colin.king@canonical.com>,
        Kees Cook <keescook@chromium.org>,
        Takashi Iwai <tiwai@suse.de>, linux-kselftest@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH v7 1/8] fs: introduce kernel_pread_file* support
Message-ID: <20200606155216.GP19604@bombadil.infradead.org>
References: <20200606050458.17281-1-scott.branden@broadcom.com>
 <20200606050458.17281-2-scott.branden@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200606050458.17281-2-scott.branden@broadcom.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jun 05, 2020 at 10:04:51PM -0700, Scott Branden wrote:
> -int kernel_read_file(struct file *file, void **buf, loff_t *size,
> -		     loff_t max_size, enum kernel_read_file_id id)
> -{
> -	loff_t i_size, pos;
> +int kernel_pread_file(struct file *file, void **buf, loff_t *size,
> +		      loff_t pos, loff_t max_size,
> +		      enum kernel_pread_opt opt,
> +		      enum kernel_read_file_id id)
> +{
> +	loff_t alloc_size;
> +	loff_t buf_pos;
> +	loff_t read_end;
> +	loff_t i_size;
>  	ssize_t bytes = 0;
>  	int ret;
>  

Look, it's not your fault, but this is a great example of how we end
up with atrocious interfaces.  Someone comes along and implements a
simple DWIM interface that solves their problem.  Then somebody else
adds a slight variant that solves their problem, and so on and so on,
and we end up with this bonkers API where the arguments literally change
meaning depending on other arguments.

> @@ -950,21 +955,31 @@ int kernel_read_file(struct file *file, void **buf, loff_t *size,
>  		ret = -EINVAL;
>  		goto out;
>  	}
> -	if (i_size > SIZE_MAX || (max_size > 0 && i_size > max_size)) {
> +
> +	/* Default read to end of file */
> +	read_end = i_size;
> +
> +	/* Allow reading partial portion of file */
> +	if ((opt == KERNEL_PREAD_PART) &&
> +	    (i_size > (pos + max_size)))
> +		read_end = pos + max_size;
> +
> +	alloc_size = read_end - pos;
> +	if (i_size > SIZE_MAX || (max_size > 0 && alloc_size > max_size)) {
>  		ret = -EFBIG;
>  		goto out;

... like that.

I think what we actually want is:

ssize_t vmap_file_range(struct file *, loff_t start, loff_t end, void **bufp);
void vunmap_file_range(struct file *, void *buf);

If end > i_size, limit the allocation to i_size.  Returns the number
of bytes allocated, or a negative errno.  Writes the pointer allocated
to *bufp.  Internally, it should use the page cache to read in the pages
(taking appropriate reference counts).  Then it maps them using vmap()
instead of copying them to a private vmalloc() array.

kernel_read_file() can be converted to use this API.  The users will
need to be changed to call kernel_read_end(struct file *file, void *buf)
instead of vfree() so it can call allow_write_access() for them.

vmap_file_range() has a lot of potential uses.  I'm surprised we don't
have it already, to be honest.
