Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6F8E3A8A69
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Jun 2021 22:45:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230162AbhFOUrP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Jun 2021 16:47:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229931AbhFOUrP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Jun 2021 16:47:15 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DC89C061574;
        Tue, 15 Jun 2021 13:45:09 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id o3so54696wri.8;
        Tue, 15 Jun 2021 13:45:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VE207lPfdUU1vdDTSrM11CcavJCEtwoThcBRq6TFIc4=;
        b=lNrHff6JWckSOpBDE7msUsGZ0K9DVqGgAJZLrwpmNsVG2NBfSbsQy2HrFgbf952/+k
         qo9lRhnylHPECHwS0MmjaAx46vQsVoG9sH41V8K+RsKBKgoVIXwjZMTb/lQGnxgGJ20F
         P6c2er0RnwVBIBTMTrwMJ9I+z7DRO81v7U86IwQN4FXjmHNvpiOdb1OOVGslPxC4sSKO
         kZrofGZLqZ6JeKkVCnhGH4KC2FuEymp4Ni/+oYwNaNUX6RUEdR663iIyrYGxhfpCqNnu
         2IgpJ7qgipNkxirIrrAPkhxxbiIppCckXIeoNXo38Q0ArCChMg76jhm787CUI3QVa3wC
         Wx8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VE207lPfdUU1vdDTSrM11CcavJCEtwoThcBRq6TFIc4=;
        b=WkoEqkZHESkEiAlq1GL+Jq6TnKWFXdjjBSeZCrVU1F+dMwRcUfTFldivkDWG7/6YYv
         efIEHu4vuuzIRncmv3khxBcC5yIOUhK4Vl5sp0f0J0laE4et6oEmPsafAu0dZYk6zLDu
         rOk6HDPJrUnZ4YPGYdKx/pT6LLypbJkaLMObsaTQS5iK2fiHg2e+9kj9fs2D4t66SXjn
         RTN0zWZT5TKbMpBudPwSGHBhT1YoCl9LFg9DY5m4znxSYIoQl9IlizVhmu4x7g98BtTm
         quThb6kNt/LRhkBiNpkuOYSQSaVhePl+N3yPr+rVCeN6tNySsEVcf6jJdekUNFONnvD+
         MQew==
X-Gm-Message-State: AOAM533ro57RPfW+zs9abb0FNJdAhQRjBHpOiAwc2szst+UKUCxT4ha3
        0FKKWw3G9xdsEPssT+mCPmer8jS44HtFlyt745A=
X-Google-Smtp-Source: ABdhPJzaqBprmAJqm6tWkIIUx4sUTURC+2TDO9vGuILsGB/STIsySaJXaXQwneGvxESwpQy71ewDtp+5F3TnbIoO/8I=
X-Received: by 2002:adf:e401:: with SMTP id g1mr1047164wrm.415.1623789908069;
 Tue, 15 Jun 2021 13:45:08 -0700 (PDT)
MIME-Version: 1.0
References: <20210615154952.2744-1-justin.he@arm.com> <20210615154952.2744-3-justin.he@arm.com>
In-Reply-To: <20210615154952.2744-3-justin.he@arm.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 15 Jun 2021 23:44:51 +0300
Message-ID: <CAHp75Vdu=_qgOeQJsR=60aJ-2y3RgurTO=gqKgxmcVZKq1eUYw@mail.gmail.com>
Subject: Re: [PATCH RFCv4 2/4] lib/vsprintf.c: make '%pD' print full path for file
To:     Jia He <justin.he@arm.com>
Cc:     Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Jonathan Corbet <corbet@lwn.net>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Eric Biggers <ebiggers@google.com>,
        "Ahmed S. Darwish" <a.darwish@linutronix.de>,
        Linux Documentation List <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 15, 2021 at 6:54 PM Jia He <justin.he@arm.com> wrote:
>
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

print the full

>
> Precision is never going to be used with %p (or any of its kernel
> extensions) if -Wformat is turned on.
> .
>
> [1] https://lore.kernel.org/lkml/CAHk-=wimsMqGdzik187YWLb-ru+iktb4MYbMQG1rnZ81dXYFVg@mail.gmail.com/

Put it as a Link: tag?

>
> Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
> Signed-off-by: Jia He <justin.he@arm.com>
> ---
>  Documentation/core-api/printk-formats.rst |  5 +--
>  lib/vsprintf.c                            | 37 ++++++++++++++++++++---
>  2 files changed, 36 insertions(+), 6 deletions(-)
>
> diff --git a/Documentation/core-api/printk-formats.rst b/Documentation/core-api/printk-formats.rst
> index f063a384c7c8..95ba14dc529b 100644
> --- a/Documentation/core-api/printk-formats.rst
> +++ b/Documentation/core-api/printk-formats.rst
> @@ -408,12 +408,13 @@ dentry names
>  ::
>
>         %pd{,2,3,4}
> -       %pD{,2,3,4}
> +       %pD
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
> index f0c35d9b65bf..9d3166332726 100644
> --- a/lib/vsprintf.c
> +++ b/lib/vsprintf.c
> @@ -27,6 +27,7 @@
>  #include <linux/string.h>
>  #include <linux/ctype.h>
>  #include <linux/kernel.h>

> +#include <linux/dcache.h>

I know that this is an arbitrary order, but can you keep it after ctype.h?

>  #include <linux/kallsyms.h>
>  #include <linux/math64.h>
>  #include <linux/uaccess.h>
> @@ -920,13 +921,41 @@ char *dentry_name(char *buf, char *end, const struct dentry *d, struct printf_sp
>  }
>
>  static noinline_for_stack
> -char *file_dentry_name(char *buf, char *end, const struct file *f,
> +char *file_d_path_name(char *buf, char *end, const struct file *f,
>                         struct printf_spec spec, const char *fmt)
>  {
> +       const struct path *path;
> +       char *p;
> +       int prepend_len, reserved_size, dpath_len;
> +
>         if (check_pointer(&buf, end, f, spec))
>                 return buf;
>
> -       return dentry_name(buf, end, f->f_path.dentry, spec, fmt);
> +       path = &f->f_path;
> +       if (check_pointer(&buf, end, path, spec))
> +               return buf;
> +
> +       p = d_path_unsafe(path, buf, end - buf, &prepend_len);
> +
> +       /* Calculate the full d_path length, ignoring the tail '\0' */
> +       dpath_len = end - buf - prepend_len - 1;
> +
> +       reserved_size = max_t(int, dpath_len, spec.field_width);
> +
> +       /* case 1: no space at all, forward the buf with reserved size */

Case 1:

> +       if (buf >= end)
> +               return buf + reserved_size;
> +
> +       /*
> +        * case 2: small scratch space for long d_path name. The space

Case 2:

> +        * [buf,end] has been filled with truncated string. Hence use the
> +        * full dpath_len for further string widening.
> +        */
> +       if (prepend_len < 0)
> +               return widen_string(buf + dpath_len, dpath_len, end, spec);
> +
> +       /* case3: space is big enough */

Case 3:

> +       return string_nocheck(buf, end, p, spec);
>  }
>  #ifdef CONFIG_BLOCK
>  static noinline_for_stack
> @@ -2296,7 +2325,7 @@ early_param("no_hash_pointers", no_hash_pointers_enable);
>   * - 'a[pd]' For address types [p] phys_addr_t, [d] dma_addr_t and derivatives
>   *           (default assumed to be phys_addr_t, passed by reference)
>   * - 'd[234]' For a dentry name (optionally 2-4 last components)
> - * - 'D[234]' Same as 'd' but for a struct file
> + * - 'D' For full path name of a struct file
>   * - 'g' For block_device name (gendisk + partition number)
>   * - 't[RT][dt][r]' For time and date as represented by:
>   *      R    struct rtc_time
> @@ -2395,7 +2424,7 @@ char *pointer(const char *fmt, char *buf, char *end, void *ptr,
>         case 'C':
>                 return clock(buf, end, ptr, spec, fmt);
>         case 'D':
> -               return file_dentry_name(buf, end, ptr, spec, fmt);
> +               return file_d_path_name(buf, end, ptr, spec, fmt);
>  #ifdef CONFIG_BLOCK
>         case 'g':
>                 return bdev_name(buf, end, ptr, spec, fmt);
> --
> 2.17.1
>


-- 
With Best Regards,
Andy Shevchenko
