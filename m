Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D72F53AB58C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Jun 2021 16:09:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231536AbhFQOME (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Jun 2021 10:12:04 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:33778 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230507AbhFQOME (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Jun 2021 10:12:04 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 0C2331FD68;
        Thu, 17 Jun 2021 14:09:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1623938995; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BkqQiO9KSRkh5HLhqz7NulrNPfY6/VvozJpBVz8MwPo=;
        b=jNPWz1UpsZsq6nqeGeyraszV0WlKT77iXcScMQ3vsX2YsxoiGIn9ppDE3kHTL+k1rtBgnm
        HLeZM5ZjeXPyO/r53Uz82M2ewRLp3MKO3+0oiO1Q/9p/ssPNWSejkTA8jLNebwJ/RUEjo6
        y6Qe6oFVHOxuwnuht3HjcgKaQRlq84g=
Received: from suse.cz (unknown [10.100.224.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 8A9EEA3BBA;
        Thu, 17 Jun 2021 14:09:54 +0000 (UTC)
Date:   Thu, 17 Jun 2021 16:09:54 +0200
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
        linux-fsdevel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH RFCv4 2/4] lib/vsprintf.c: make '%pD' print full path for
 file
Message-ID: <YMtXshP8G4RZvr4m@alley>
References: <20210615154952.2744-1-justin.he@arm.com>
 <20210615154952.2744-3-justin.he@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210615154952.2744-3-justin.he@arm.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue 2021-06-15 23:49:50, Jia He wrote:
> Previously, the specifier '%pD' is for printing dentry name of struct
> file. It may not be perfect (by default it only prints one component.)
> 
> As suggested by Linus at [1]:
> A dentry has a parent, but at the same time, a dentry really does
> inherently have "one name" (and given just the dentry pointers, you
> can't show mount-related parenthood, so in many ways the "show just
> one name" makes sense for "%pd" in ways it doesn't necessarily for
> "%pD"). But while a dentry arguably has that "one primary component",
> a _file_ is certainly not exclusively about that last component.
> 
> Hence change the behavior of '%pD' to print full path of that file.
> 
> Precision is never going to be used with %p (or any of its kernel
> extensions) if -Wformat is turned on.
> .
> 
> [1] https://lore.kernel.org/lkml/CAHk-=wimsMqGdzik187YWLb-ru+iktb4MYbMQG1rnZ81dXYFVg@mail.gmail.com/
> 
> Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
> Signed-off-by: Jia He <justin.he@arm.com>

> --- a/lib/vsprintf.c
> +++ b/lib/vsprintf.c
> @@ -920,13 +921,41 @@ char *dentry_name(char *buf, char *end, const struct dentry *d, struct printf_sp
>  }
>  
>  static noinline_for_stack
> -char *file_dentry_name(char *buf, char *end, const struct file *f,
> +char *file_d_path_name(char *buf, char *end, const struct file *f,
>  			struct printf_spec spec, const char *fmt)
>  {
> +	const struct path *path;
> +	char *p;
> +	int prepend_len, reserved_size, dpath_len;
> +
>  	if (check_pointer(&buf, end, f, spec))
>  		return buf;
>  
> -	return dentry_name(buf, end, f->f_path.dentry, spec, fmt);
> +	path = &f->f_path;
> +	if (check_pointer(&buf, end, path, spec))
> +		return buf;
> +
> +	p = d_path_unsafe(path, buf, end - buf, &prepend_len);
> +
> +	/* Calculate the full d_path length, ignoring the tail '\0' */
> +	dpath_len = end - buf - prepend_len - 1;
> +
> +	reserved_size = max_t(int, dpath_len, spec.field_width);

"reserved_size" is kind of confusing. "dpath_widen_len" or just "widen_len"
look much more obvious.

The below comments are not bad. But they still made me thing about it
more than I wanted ;-) I wonder if it following is better:

> +	/* case 1: no space at all, forward the buf with reserved size */
> +	if (buf >= end)
> +		return buf + reserved_size;

	/* Case 1: Already started past the buffer. Just forward @buf. */
	if (buf >= end)
		return buf + widen_len;

> +
> +	/*
> +	 * case 2: small scratch space for long d_path name. The space
> +	 * [buf,end] has been filled with truncated string. Hence use the
> +	 * full dpath_len for further string widening.
> +	 */
> +	if (prepend_len < 0)
> +		return widen_string(buf + dpath_len, dpath_len, end, spec);

	/*
	 * Case 2: The entire remaining space of the buffer filled by
	 * the truncated path. Still need to get moved right when
	 * the filed width is greather than the full path length.
	 */
	if (prepend_len < 0)
		return widen_string(buf + dpath_len, dpath_len, end, spec);

> +	/* case3: space is big enough */
> +	return string_nocheck(buf, end, p, spec);

	/*
	 * Case 3: The full path is printed at the end of the buffer.
	 * Print it at the right location in the same buffer.
	 */
	return string_nocheck(buf, end, p, spec);
>  }
>  #ifdef CONFIG_BLOCK
>  static noinline_for_stack

In each case, I am happy that it was possible to simplify the logic.
I got lost several times in the previous version.

Best Regards,
Petr
