Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 725B33A4A9B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Jun 2021 23:29:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230348AbhFKVbQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Jun 2021 17:31:16 -0400
Received: from mail-ed1-f49.google.com ([209.85.208.49]:35834 "EHLO
        mail-ed1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229824AbhFKVbQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Jun 2021 17:31:16 -0400
Received: by mail-ed1-f49.google.com with SMTP id ba2so36905124edb.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 11 Jun 2021 14:29:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Yj/vp7a0ivkIMlD+voHVQNNmuERYkNcOuFUlb3V5+QU=;
        b=ajiSwjMERGP2Z/iuuXasSqjkJ8BYoaGXsEDLrPGqmodRD89SMCOkxYz/x8/F/ZhuL/
         dnUA5/b7MkoPeEu+KPcGzPOJ9WZp0F5iunGA8iq1RiGXSXBSPDh5gqdGF6JncWWT/ODj
         +470G9xNl22BhqGdGKor1/Y5eU0Epq5MuFRuo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Yj/vp7a0ivkIMlD+voHVQNNmuERYkNcOuFUlb3V5+QU=;
        b=JS9yjsPdgsD15oF1+Vz5KOPJrEimmO173EZEBo7WYPyLNKvwGoyxfp/UiKy71FOOom
         jW0U3ovaC8BO1YfvL+fFyhMu5j0rQn/YMgxNiYKH2mAEn8oWlB8d/SriAEXiinmYq0ZC
         fE+lOrzwmszHqfTVqyNWuCLCimM+LffRsEnCejqN8CvJQdxMtTuAWjZTRCEa6WsN7hvZ
         Ftt7hB6cyftoAekc/thzGPsFo65uyhHeDGdxACY1stdUTi8eXbA85ZbVqYwbOyXigN+5
         Ss/bBSTF3FwXeP3YCeVanhsljV0Kksvvj2M5GbdpGHOeeTGIjnGeRSbKxYi+KwiaeMQL
         i9Tw==
X-Gm-Message-State: AOAM530mrXAP8JgbGRAPP6lQh6c4FJSVIy9o9Faa1txdro/DO5XV8zNM
        i7GCzYDRqUKwBHDh8vD8uiucPQNsvEIZXw==
X-Google-Smtp-Source: ABdhPJwq53CQ9eBtPD8hVpIx6faEUJL9Vm6nZO2saTd2fFDa8JKoNUeDVbkS5vRIsoOdUY77vA6TTw==
X-Received: by 2002:a05:6402:61a:: with SMTP id n26mr5734045edv.220.1623446897185;
        Fri, 11 Jun 2021 14:28:17 -0700 (PDT)
Received: from [192.168.1.149] ([80.208.64.110])
        by smtp.gmail.com with ESMTPSA id f8sm2437137ejw.75.2021.06.11.14.28.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Jun 2021 14:28:16 -0700 (PDT)
Subject: Re: [PATCH RFCv3 2/3] lib/vsprintf.c: make %pD print full path for
 file
To:     Jia He <justin.he@arm.com>, Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Eric Biggers <ebiggers@google.com>,
        "Ahmed S. Darwish" <a.darwish@linutronix.de>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
References: <20210611155953.3010-1-justin.he@arm.com>
 <20210611155953.3010-3-justin.he@arm.com>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <35c35b55-3c58-59e8-532a-6cad34aff729@rasmusvillemoes.dk>
Date:   Fri, 11 Jun 2021 23:28:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210611155953.3010-3-justin.he@arm.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 11/06/2021 17.59, Jia He wrote:
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
> +static char *string_truncate(char *buf, char *end, const char *s,
> +			     u32 full_len, struct printf_spec spec)
> +{
> +	int lim = 0;
> +
> +	if (buf < end) {

See below, I think the sole caller guarantees this,

> +		if (spec.precision >= 0)
> +			lim = strlen(s) - min_t(int, spec.precision, strlen(s));
> +
> +		return widen_string(buf + full_len, full_len, end - lim, spec);
> +	}
> +
> +	return buf;

which is good because this would almost certainly be wrong (violating
the "always forward buf appropriately regardless of whether you wrote
something" rule).

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

If I'm reading this right, you're using buf as scratch space to write
however much of the path fits. Then [*]

> +	/* Minus 1 byte for '\0' */
> +	dpath_len = end - buf - prepend_len - 1;
> +
> +	reserved_size = max_t(int, dpath_len, spec.field_width);
> +
> +	/* no filling space at all */
> +	if (buf >= end || !buf)
> +		return buf + reserved_size;

Why the !buf check? The only way we can have that is the snprintf(NULL,
0, ...) case of asking how much space we'd need to malloc, right? In
which case end would be NULL+0 == NULL, so buf >= end automatically,
regardless of how much have been "printed" before %pD.

> +
> +	/* small space for long name */
> +	if (buf < end && prepend_len < 0)

So if we did an early return for buf >= end, we now know buf < end and
hence the first part here is redundant.

Anyway, as for [*]:

> +		return string_truncate(buf, end, p, dpath_len, spec);
> +
> +	/* space is enough */
> +	return string_nocheck(buf, end, p, spec);

Now you're passing p to string_truncate or string_nocheck, while p
points somewhere into buf itself. I can't convince myself that would be
safe. At the very least, it deserves a couple of comments.

Rasmus
