Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5557378F31
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 May 2021 15:52:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241073AbhEJNeZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 10 May 2021 09:34:25 -0400
Received: from mx2.suse.de ([195.135.220.15]:54872 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1351299AbhEJNGF (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 10 May 2021 09:06:05 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1620651899; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=r+dkjtuAgModTRQouMOB5Z+3WY5XlrN+33t9O5HaW10=;
        b=hlDpLi5JEUYkAF7+AsBE9LixfIfDYb2xEnkF9UD1Qpc6U9arlt5UbWV1fpat+lrE0QWdVC
        ewmtHRqOWHcZomMoifZdBCJ9iNWgP58yQvN+tz2IoKYsZ1z3fCysuhWzhnbjnLGTKr0FLi
        LN8AzmiflWsIhz6lezxNuDXmXRH//cs=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id D404DB034;
        Mon, 10 May 2021 13:04:58 +0000 (UTC)
Date:   Mon, 10 May 2021 15:04:57 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Jia He <justin.he@arm.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Jonathan Corbet <corbet@lwn.net>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@ftp.linux.org.uk>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ira Weiny <ira.weiny@intel.com>,
        Eric Biggers <ebiggers@google.com>,
        "Ahmed S. Darwish" <a.darwish@linutronix.de>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH RFC 2/3] lib/vsprintf.c: make %pD print full path for file
Message-ID: <YJkveb46BoFbXi0q@alley>
References: <20210508122530.1971-1-justin.he@arm.com>
 <20210508122530.1971-3-justin.he@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210508122530.1971-3-justin.he@arm.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat 2021-05-08 20:25:29, Jia He wrote:
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
> Hence "file_dentry_name()" simply shouldn't use "dentry_name()" at all.
> Despite that shared code origin, and despite that similar letter
> choice (lower-vs-upper case), a dentry and a file really are very
> different from a name standpoint.
> 
> diff --git a/lib/vsprintf.c b/lib/vsprintf.c
> index f0c35d9b65bf..8220ab1411c5 100644
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
> @@ -923,10 +924,17 @@ static noinline_for_stack
>  char *file_dentry_name(char *buf, char *end, const struct file *f,
>  			struct printf_spec spec, const char *fmt)
>  {
> +	const struct path *path = &f->f_path;

This dereferences @f before it is checked by check_pointer().

> +	char *p;
> +	char tmp[128];
> +
>  	if (check_pointer(&buf, end, f, spec))
>  		return buf;
>  
> -	return dentry_name(buf, end, f->f_path.dentry, spec, fmt);
> +	p = d_path_fast(path, (char *)tmp, 128);
> +	buf = string(buf, end, p, spec);

Is 128 a limit of the path or just a compromise, please?

d_path_fast() limits the size of the buffer so we could use @buf
directly. We basically need to imitate what string_nocheck() does:

     + the length is limited by min(spec.precision, end-buf);
     + the string need to get shifted by widen_string()

We already do similar thing in dentry_name(). It might look like:

char *file_dentry_name(char *buf, char *end, const struct file *f,
			struct printf_spec spec, const char *fmt)
{
	const struct path *path;
	int lim, len;
	char *p;

	if (check_pointer(&buf, end, f, spec))
		return buf;

	path = &f->f_path;
	if (check_pointer(&buf, end, path, spec))
		return buf;

	lim = min(spec.precision, end - buf);
	p = d_path_fast(path, buf, lim);
	if (IS_ERR(p))
		return err_ptr(buf, end, p, spec);

	len = strlen(buf);
	return widen_string(buf + len, len, end, spec);
}

Note that the code is _not_ even compile tested. It might include
some ugly mistake.

> +
> +	return buf;
>  }
>  #ifdef CONFIG_BLOCK
>  static noinline_for_stack
> @@ -2296,7 +2304,7 @@ early_param("no_hash_pointers", no_hash_pointers_enable);
>   * - 'a[pd]' For address types [p] phys_addr_t, [d] dma_addr_t and derivatives
>   *           (default assumed to be phys_addr_t, passed by reference)
>   * - 'd[234]' For a dentry name (optionally 2-4 last components)
> - * - 'D[234]' Same as 'd' but for a struct file
> + * - 'D' Same as 'd' but for a struct file

It is not really the same. We should make it clear that it prints
the full path:

+   * - 'D' Same as 'd' but for a struct file; prints full path with
+       the mount-related parenthood

>   * - 'g' For block_device name (gendisk + partition number)
>   * - 't[RT][dt][r]' For time and date as represented by:
>   *      R    struct rtc_time
> -- 
> 2.17.1

Best Regards,
Petr
