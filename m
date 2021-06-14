Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6A443A6AA8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Jun 2021 17:41:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233600AbhFNPnF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Jun 2021 11:43:05 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:47792 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233299AbhFNPnE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Jun 2021 11:43:04 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 6C3FC1FD29;
        Mon, 14 Jun 2021 15:41:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1623685260; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pcfXMy3naJknj4EHPQE2nKwrn0Tl7Q3u9ixDcdLpWW0=;
        b=chFNhVyj9KYVBfbA5Sx/QK0PvYAsszItkhaiwHXPhu27YHz5EcBtcejfUVNskUxRC0GSKe
        qEHALB3pxQ7Bml6jsjqSsQhV1z07nyAvcGb1Iy2PIJbsonc1kXMOiRchGFstkaHw6ABpAI
        62cmA/XFpxbOr8Yo5qOXgb7b28EMoqY=
Received: from suse.cz (unknown [10.100.216.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 95EFBA3BCB;
        Mon, 14 Jun 2021 15:40:59 +0000 (UTC)
Date:   Mon, 14 Jun 2021 17:40:59 +0200
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
Subject: Re: [PATCH RFCv3 2/3] lib/vsprintf.c: make %pD print full path for
 file
Message-ID: <YMd4ixry8ztzlG/e@alley>
References: <20210611155953.3010-1-justin.he@arm.com>
 <20210611155953.3010-3-justin.he@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210611155953.3010-3-justin.he@arm.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri 2021-06-11 23:59:52, Jia He wrote:
> We have '%pD' for printing a filename. It may not be perfect (by
> default it only prints one component.)
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
> Things become more complicated when spec.precision and spec.field_width
> is added in. string_truncate() is to handle the small space case for
> '%pD' precision and field_width.
> 
> [1] https://lore.kernel.org/lkml/CAHk-=wimsMqGdzik187YWLb-ru+iktb4MYbMQG1rnZ81dXYFVg@mail.gmail.com/
> 
> Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
> Signed-off-by: Jia He <justin.he@arm.com>
> ---
>  Documentation/core-api/printk-formats.rst |  5 ++-
>  lib/vsprintf.c                            | 47 +++++++++++++++++++++--
>  2 files changed, 46 insertions(+), 6 deletions(-)
> 
> diff --git a/Documentation/core-api/printk-formats.rst b/Documentation/core-api/printk-formats.rst
> index f063a384c7c8..95ba14dc529b 100644
> --- a/Documentation/core-api/printk-formats.rst
> +++ b/Documentation/core-api/printk-formats.rst
> @@ -408,12 +408,13 @@ dentry names
>  ::
>  
>  	%pd{,2,3,4}
> -	%pD{,2,3,4}
> +	%pD
>  
>  For printing dentry name; if we race with :c:func:`d_move`, the name might
>  be a mix of old and new ones, but it won't oops.  %pd dentry is a safer
>  equivalent of %s dentry->d_name.name we used to use, %pd<n> prints ``n``
> -last components.  %pD does the same thing for struct file.
> +last components.  %pD prints full file path together with mount-related
> +parenthood.
>  
>  Passed by reference.
>  
> diff --git a/lib/vsprintf.c b/lib/vsprintf.c
> index f0c35d9b65bf..317b65280252 100644
> --- a/lib/vsprintf.c
> +++ b/lib/vsprintf.c
> @@ -27,6 +27,7 @@
>  #include <linux/string.h>
>  #include <linux/ctype.h>
>  #include <linux/kernel.h>
> +#include <linux/dcache.h>
>  #include <linux/kallsyms.h>
>  #include <linux/math64.h>
>  #include <linux/uaccess.h>
> @@ -601,6 +602,20 @@ char *widen_string(char *buf, int n, char *end, struct printf_spec spec)
>  }
>  
>  /* Handle string from a well known address. */

This comment is for widen_string().

string_truncate() functionality is far from obvious. It would deserve
it's own description, including description of each parammeter.

Well, do we really need it? See below.

> +static char *string_truncate(char *buf, char *end, const char *s,
> +			     u32 full_len, struct printf_spec spec)
> +{
> +	int lim = 0;
> +
> +	if (buf < end) {
> +		if (spec.precision >= 0)
> +			lim = strlen(s) - min_t(int, spec.precision, strlen(s));
> +
> +		return widen_string(buf + full_len, full_len, end - lim, spec);
> +	}
> +
> +	return buf;
> +}
>  static char *string_nocheck(char *buf, char *end, const char *s,
>  			    struct printf_spec spec)
>  {
> @@ -920,13 +935,37 @@ char *dentry_name(char *buf, char *end, const struct dentry *d, struct printf_sp
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
> +	/* Minus 1 byte for '\0' */
> +	dpath_len = end - buf - prepend_len - 1;
> +
> +	reserved_size = max_t(int, dpath_len, spec.field_width);
> +
> +	/* no filling space at all */
> +	if (buf >= end || !buf)
> +		return buf + reserved_size;
> +
> +	/* small space for long name */
> +	if (buf < end && prepend_len < 0)
> +		return string_truncate(buf, end, p, dpath_len, spec);

We need this only because we allowed to write the path behind
spec.field_width. Do I get it right?

> +
> +	/* space is enough */
> +	return string_nocheck(buf, end, p, spec);
>  }

It easy to get lost in all the computations, including the one
in string_truncate():

	dpath_len = end - buf - prepend_len - 1;
	reserved_size = max_t(int, dpath_len, spec.field_width);
and
	lim = strlen(s) - min_t(int, spec.precision, strlen(s));
	return widen_string(buf + full_len, full_len, end - lim, spec);

Please, add comments explaining the meaning of the variables a bit.
They should help to understand why it is done this way.


I tried another approach below. The main trick is that
max_len is limited by spec.field_width and spec.precision before calling
d_path_unsave():


	if (check_pointer(&buf, end, f, spec))
		return buf;

	path = &f->f_path;
	if (check_pointer(&buf, end, path, spec))
		return buf;

	max_len = end - buf;
	if (spec.field_width >= 0 && spec.field_width < max_len)
		max_len = spec.filed_width;
	if (spec.precision >= 0 && spec.precision < max_len)
		max_len = spec.precision;

	p = d_path_unsafe(path, buf, max_len, &prepend_len);

	/*
	 * The path has been printed from the end of the buffer.
	 * Process it like a normal string to handle "precission"
	 * and "width" effects. In the "worst" case, the string
	 * will stay as is.
	 */
	if (buf < end) {
		buf = string_nocheck(buf, end, p, spec);
		/* Return buf when output was limited or did fit in. */
		if (spec.field_width >= 0 || spec.precision >= 0 ||
		    prepend_len >= 0) {
			return buf;
		}
		/* Otherwise, add what was missing. Ignore tail '\0' */
		return buf - prepend_len - 1;
	}

	/*
	 * Nothing has been written to the buffer. Just count the length.
	 * I is fixed when field_with is defined. */
	if (spec.field_width >= 0)
		return buf + spec.field_width;

	/* Otherwise, use the length of the path. */
	dpath_len = max_len - prepend_len - 1;

	/* The path might still get limited by precision number. */
	if (spec.precision >= 0 && spec.precision < dpath_len)
		return buf + spec.precision;

	return buf + dpath_len;


Note that the above code is not even compile tested. There might be
off by one mistakes. Also, it is possible that I missed something.

Best Regards,
Petr
