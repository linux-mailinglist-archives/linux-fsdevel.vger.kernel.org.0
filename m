Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EABB3A6AC0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Jun 2021 17:44:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234182AbhFNPqR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Jun 2021 11:46:17 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:59546 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233460AbhFNPqP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Jun 2021 11:46:15 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 58E7D21968;
        Mon, 14 Jun 2021 15:44:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1623685451; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VvWPMMKGb6QeJC7xSsQXJqGHc92mzTSW08o2BVwjGkk=;
        b=i7Q8UR245p8+LnTGqOUh2n5r+KijfyOOQjQG98On3geSI5g5WBf82Mn01cWw8Ye7TLYJon
        2ATFXtnuWN+D5IU+h4rcC7hIear7Twqgrn9tRC9dO2FU1AaMI7J0A/q/ZwcfpcEkYBtsL/
        69XIKjKGBgaBZ/Gib411EUnl7sio8RI=
Received: from suse.cz (unknown [10.100.216.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 3FB6FA3B96;
        Mon, 14 Jun 2021 15:44:11 +0000 (UTC)
Date:   Mon, 14 Jun 2021 17:44:10 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Jia He <justin.he@arm.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Jonathan Corbet <corbet@lwn.net>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Eric Biggers <ebiggers@google.com>,
        "Ahmed S. Darwish" <a.darwish@linutronix.de>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH RFCv3 3/3] lib/test_printf: add test cases for '%pD'
Message-ID: <YMd5StgkBINLlb8E@alley>
References: <20210611155953.3010-1-justin.he@arm.com>
 <20210611155953.3010-4-justin.he@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210611155953.3010-4-justin.he@arm.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri 2021-06-11 23:59:53, Jia He wrote:
> After the behaviour of specifier '%pD' is changed to print full path
> of struct file, the related test cases are also updated.
> 
> Given the string is prepended from the end of the buffer, the check
> of "wrote beyond the nul-terminator" should be skipped.
> 
> Signed-off-by: Jia He <justin.he@arm.com>
> ---
>  lib/test_printf.c | 26 +++++++++++++++++++++++++-
>  1 file changed, 25 insertions(+), 1 deletion(-)
> 
> diff --git a/lib/test_printf.c b/lib/test_printf.c
> index ec0d5976bb69..3632bd6cf906 100644
> --- a/lib/test_printf.c
> +++ b/lib/test_printf.c
> @@ -78,7 +80,7 @@ do_test(int bufsize, const char *expect, int elen,
>  		return 1;
>  	}
>  
> -	if (memchr_inv(test_buffer + written + 1, FILL_CHAR, BUF_SIZE + PAD_SIZE - (written + 1))) {
> +	if (!is_prepend_buf && memchr_inv(test_buffer + written + 1, FILL_CHAR, BUF_SIZE + PAD_SIZE - (written + 1))) {
>  		pr_warn("vsnprintf(buf, %d, \"%s\", ...) wrote beyond the nul-terminator\n",
>  			bufsize, fmt);
>  		return 1;
> @@ -496,6 +498,27 @@ dentry(void)
>  	test("  bravo/alfa|  bravo/alfa", "%12pd2|%*pd2", &test_dentry[2], 12, &test_dentry[2]);
>  }
>  
> +static struct vfsmount test_vfsmnt = {};
> +
> +static struct file test_file __initdata = {
> +	.f_path = { .dentry = &test_dentry[2],
> +		    .mnt = &test_vfsmnt,
> +	},
> +};
> +
> +static void __init
> +f_d_path(void)
> +{
> +	test("(null)", "%pD", NULL);
> +	test("(efault)", "%pD", PTR_INVALID);
> +
> +	is_prepend_buf = true;
> +	test("/bravo/alfa   |/bravo/alfa   ", "%-14pD|%*pD", &test_file, -14, &test_file);
> +	test("   /bravo/alfa|   /bravo/alfa", "%14pD|%*pD", &test_file, 14, &test_file);
> +	test("   /bravo/alfa|/bravo/alfa   ", "%14pD|%-14pD", &test_file, &test_file);

Please, add more test for scenarios when the path does not fit into
the buffer or when there are no limitations, ...

I still have to think about is_prepend_buf hack.


> +	is_prepend_buf = false;
> +}
> +
>  static void __init
>  struct_va_format(void)
>  {

Best Regards,
PEtr
