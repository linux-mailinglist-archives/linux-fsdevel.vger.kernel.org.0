Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E02E3B2AE5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Jun 2021 11:01:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230064AbhFXJDy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 24 Jun 2021 05:03:54 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:56832 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229918AbhFXJDw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 24 Jun 2021 05:03:52 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 04E8C1FD67;
        Thu, 24 Jun 2021 09:01:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1624525293; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gOxneZwjI52NGf5YtOkngslNEIWH7cmjZeAOERs/N1o=;
        b=qVGFmIBZsXtc/KT5jd285fvitzFu/HscGDU/99JWXqmysYTcbcTp9+7CHCAIoQ7Zd/SQN4
        +Pmf2DguX4xoL3fBRQ/m7U6Z6ksPr+Ksf1Khn7T7GuSn2N7GVrujAgMmsVGNcme+KhAQIX
        OmFu0wLVuZuu+Neo77oDGjco/guIs3A=
Received: from suse.cz (unknown [10.100.224.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 9C85AA3B91;
        Thu, 24 Jun 2021 09:01:32 +0000 (UTC)
Date:   Thu, 24 Jun 2021 11:01:31 +0200
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
        linux-fsdevel@vger.kernel.org,
        Matthew Wilcox <willy@infradead.org>,
        Christoph Hellwig <hch@infradead.org>, nd@arm.com
Subject: Re: [PATCH v2 2/4] lib/vsprintf.c: make '%pD' print the full path of
 file
Message-ID: <YNRJ61m6duXjpGrp@alley>
References: <20210623055011.22916-1-justin.he@arm.com>
 <20210623055011.22916-3-justin.he@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210623055011.22916-3-justin.he@arm.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 2021-06-23 13:50:09, Jia He wrote:
> Previously, the specifier '%pD' is for printing dentry name of struct
> file. It may not be perfect (by default it only prints one component.)
> 
> As suggested by Linus [1]:
> > A dentry has a parent, but at the same time, a dentry really does
> > inherently have "one name" (and given just the dentry pointers, you
> > can't show mount-related parenthood, so in many ways the "show just
> > one name" makes sense for "%pd" in ways it doesn't necessarily for
> > "%pD"). But while a dentry arguably has that "one primary component",
> > a _file_ is certainly not exclusively about that last component.
> 
> Hence change the behavior of '%pD' to print the full path of that file.
> 
> If someone invokes snprintf() with small but positive space,
> prepend_name_with_len() moves or truncates the string partially.

Does this comment belong to the 1st patch?
prepend_name_with_len() is not called in this patch.

> More
> than that, kasprintf() will pass NULL @buf and @end as the parameters,
> and @end - @buf can be negative in some case. Hence make it return at
> the very beginning with false in these cases.

Same here. file_d_path_name() does not return bool.

Well, please mention in the commit message that %pD uses the entire
given buffer as a scratch space. It might write something behind
the trailing '\0'.

It would make sense to warn about this also in
Documentation/core-api/printk-formats.rst. It is a bit non-standard
behavior.

> diff --git a/lib/vsprintf.c b/lib/vsprintf.c
> index f0c35d9b65bf..f4494129081f 100644
> --- a/lib/vsprintf.c
> +++ b/lib/vsprintf.c
> @@ -920,13 +921,44 @@ char *dentry_name(char *buf, char *end, const struct dentry *d, struct printf_sp
>  }
>  
>  static noinline_for_stack
> -char *file_dentry_name(char *buf, char *end, const struct file *f,
> +char *file_d_path_name(char *buf, char *end, const struct file *f,
>  			struct printf_spec spec, const char *fmt)
>  {
> +	char *p;
> +	const struct path *path;
> +	int prepend_len, widen_len, dpath_len;
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
> +	widen_len = max_t(int, dpath_len, spec.field_width);
> +
> +	/* Case 1: Already started past the buffer. Just forward @buf. */
> +	if (buf >= end)
> +		return buf + widen_len;
> +
> +	/*
> +	 * Case 2: The entire remaining space of the buffer filled by
> +	 * the truncated path. Still need to get moved right when
> +	 * the filled width is greather than the full path length.

s/filled/field/ ?

> +	 */
> +	if (prepend_len < 0)
> +		return widen_string(buf + dpath_len, dpath_len, end, spec);

Otherwise, it looks good to me.

Best Regards,
Petr
