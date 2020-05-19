Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D37A1DA088
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 May 2020 21:08:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726502AbgESTI2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 May 2020 15:08:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726059AbgESTI2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 May 2020 15:08:28 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EB71C08C5C0
        for <linux-fsdevel@vger.kernel.org>; Tue, 19 May 2020 12:08:28 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id ci21so92273pjb.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 19 May 2020 12:08:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=RmcIN7oDiRdqjbFzFUgxoG77VNtHMuczcjZzgJlogEA=;
        b=eoXzf9hXQ06zaKJUBvPgE2YZz9h1zQ80EA6b8QroqlmFdCJ0ZIMsDkTGrDlydw01rB
         ugyyTWz/NAmL2pyTZewiWZvEDazJmNUa4/96mQ68GCyfX0PYPUG0XCKQE/IKw4p5VwP8
         cQ14sWK6koJ4BAyNNmA9lLIHrLuBQAEZ2EnyA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=RmcIN7oDiRdqjbFzFUgxoG77VNtHMuczcjZzgJlogEA=;
        b=GFwO2Q/4WqZqv0tEifRS1xsyBy6VmiLD17GTRe0cQ/8nx0HSq4FFegTY1cEg7sJJ+u
         2o8pRDJ2oEyU1747BrkwFluEGMr4WcIUvvKgunfBuT7zbs6BxVc/im95SrDdv3fe4Xpe
         327dAPvcqqgSXx3DHsd5D+2bR5EqoLzbLmFlq/4NSyJFbo2l5EcdUQC7WqDANNqkp7/d
         TG8FvLjKvw3m5gPWaQ/r9aNhrNg5wUPXfagcoaXoAZhLp9tKZ49YN9gJwjyIWU5E4WpX
         9S1leoMVeCmQHxRB3iKyh88SezM6PGiMaDXNtRiCGimAtcXndzao1EVyoMsJP++729An
         iAzg==
X-Gm-Message-State: AOAM530iuQg1axx5vQUDvn4p4OzsjaWPYntjGfTbyZmbRwayY8H6dT+R
        euGXbTE89yWCMBUnEsUtIzjl3w==
X-Google-Smtp-Source: ABdhPJwqEuEaq7kQpGUMeXthnwkUMJ6lgjSjG02qTXaI4b20dLAWrgvQRGgcnWVI0iaYLj+dy+rw8A==
X-Received: by 2002:a17:90a:31c8:: with SMTP id j8mr1149298pjf.178.1589915307800;
        Tue, 19 May 2020 12:08:27 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id i12sm245353pjk.37.2020.05.19.12.08.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2020 12:08:26 -0700 (PDT)
Date:   Tue, 19 May 2020 12:08:25 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>, Jann Horn <jannh@google.com>,
        Greg Ungerer <gerg@linux-m68k.org>,
        Rob Landley <rob@landley.net>,
        Bernd Edlinger <bernd.edlinger@hotmail.de>,
        linux-fsdevel@vger.kernel.org, Al Viro <viro@ZenIV.linux.org.uk>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        linux-security-module@vger.kernel.org,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Andy Lutomirski <luto@amacapital.net>
Subject: Re: [PATCH v2 6/8] exec/binfmt_script: Don't modify bprm->buf and
 then return -ENOEXEC
Message-ID: <202005191144.E3112135@keescook>
References: <87h7wujhmz.fsf@x220.int.ebiederm.org>
 <87sgga6ze4.fsf@x220.int.ebiederm.org>
 <87v9l4zyla.fsf_-_@x220.int.ebiederm.org>
 <877dx822er.fsf_-_@x220.int.ebiederm.org>
 <874ksczru6.fsf_-_@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <874ksczru6.fsf_-_@x220.int.ebiederm.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, May 18, 2020 at 07:33:21PM -0500, Eric W. Biederman wrote:
> 
> The return code -ENOEXEC serves to tell search_binary_handler that it
> should continue searching for the binfmt to handle a given file.  This
> makes return -ENOEXEC with a bprm->buf that is needed to continue the
> search problematic.
> 
> The current binfmt_script manages to escape problems as it closes and
> clears bprm->file before return -ENOEXEC with bprm->buf modified.
> This prevents search_binary_handler from looping as it explicitly
> handles a NULL bprm->file.
> 
> I plan on moving all of the bprm->file managment into fs/exec.c and out
> of the binary handlers so this will become a problem.
> 
> Move closing bprm->file and the test for BINPRM_PATH_INACCESSIBLE
> down below the last return of -ENOEXEC.
> 
> Introduce i_sep and i_end to track the end of the first argument and
> the end of the parameters respectively.  Using those, constification
> of all char * pointers, and the helpers next_terminator and
> next_non_spacetab guarantee the parameter parsing will not modify
> bprm->buf.

I'm quite pleased this could be implemented using the existing helpers!
It seems Linus and I were on the right track with these. :)

> 
> Only modify bprm->buf to terminate the strings i_arg and i_name with
> '\0' for passing to copy_strings_kernel.
> 
> When replacing loops with next_non_spacetab and next_terminator care
> has been take that the logic of the parsing code (short of replacing
> characters by '\0') remains the same.

Ah, interesting. As in, bprm->buf must not be modified unless the binfmt
handler is going to succeed. I think this requirement should be
documented in the binfmt struct header file.

> [...]
> diff --git a/fs/binfmt_script.c b/fs/binfmt_script.c
> index 8d718d8fd0fe..85e0ef86eb11 100644
> --- a/fs/binfmt_script.c
> +++ b/fs/binfmt_script.c
> @@ -71,39 +56,48 @@ static int load_script(struct linux_binprm *bprm)
>  	 * parse them on its own.
>  	 */
>  	buf_end = bprm->buf + sizeof(bprm->buf) - 1;
> -	cp = strnchr(bprm->buf, sizeof(bprm->buf), '\n');
> -	if (!cp) {
> -		cp = next_non_spacetab(bprm->buf + 2, buf_end);
> -		if (!cp)
> +	i_end = strnchr(bprm->buf, sizeof(bprm->buf), '\n');
> +	if (!i_end) {
> +		i_end = next_non_spacetab(bprm->buf + 2, buf_end);
> +		if (!i_end)
>  			return -ENOEXEC; /* Entire buf is spaces/tabs */
>  		/*
>  		 * If there is no later space/tab/NUL we must assume the
>  		 * interpreter path is truncated.
>  		 */
> -		if (!next_terminator(cp, buf_end))
> +		if (!next_terminator(i_end, buf_end))
>  			return -ENOEXEC;
> -		cp = buf_end;
> +		i_end = buf_end;
>  	}
> -	/* NUL-terminate the buffer and any trailing spaces/tabs. */
> -	*cp = '\0';
> -	while (cp > bprm->buf) {
> -		cp--;
> -		if ((*cp == ' ') || (*cp == '\t'))
> -			*cp = '\0';
> -		else
> -			break;
> -	}
> -	for (cp = bprm->buf+2; (*cp == ' ') || (*cp == '\t'); cp++);
> -	if (*cp == '\0')
> +	/* Trim any trailing spaces/tabs from i_end */
> +	while (spacetab(i_end[-1]))
> +		i_end--;
> +
> +	/* Skip over leading spaces/tabs */
> +	i_name = next_non_spacetab(bprm->buf+2, i_end);
> +	if (!i_name || (i_name == i_end))
>  		return -ENOEXEC; /* No interpreter name found */
> -	i_name = cp;
> +
> +	/* Is there an optional argument? */
>  	i_arg = NULL;
> -	for ( ; *cp && (*cp != ' ') && (*cp != '\t'); cp++)
> -		/* nothing */ ;
> -	while ((*cp == ' ') || (*cp == '\t'))
> -		*cp++ = '\0';
> -	if (*cp)
> -		i_arg = cp;
> +	i_sep = next_terminator(i_name, i_end);
> +	if (i_sep && (*i_sep != '\0'))
> +		i_arg = next_non_spacetab(i_sep, i_end);
> +
> +	/*
> +	 * If the script filename will be inaccessible after exec, typically
> +	 * because it is a "/dev/fd/<fd>/.." path against an O_CLOEXEC fd, give
> +	 * up now (on the assumption that the interpreter will want to load
> +	 * this file).
> +	 */
> +	if (bprm->interp_flags & BINPRM_FLAGS_PATH_INACCESSIBLE)
> +		return -ENOENT;
> +
> +	/* Release since we are not mapping a binary into memory. */
> +	allow_write_access(bprm->file);
> +	fput(bprm->file);
> +	bprm->file = NULL;
> +
>  	/*
>  	 * OK, we've parsed out the interpreter name and
>  	 * (optional) argument.
> @@ -121,7 +115,9 @@ static int load_script(struct linux_binprm *bprm)
>  	if (retval < 0)
>  		return retval;
>  	bprm->argc++;
> +	*((char *)i_end) = '\0';
>  	if (i_arg) {
> +		*((char *)i_sep) = '\0';
>  		retval = copy_strings_kernel(1, &i_arg, bprm);
>  		if (retval < 0)
>  			return retval;

I think this is all correct, though I'm always suspicious of my visual
inspection of string parsers. ;)

I had a worry the \n was not handled correctly in some case. I.e. before
any \n was converted into \0, and so next_terminator() didn't need to
consider \n separately. (next_non_spacetab() doesn't care since \n and \0
are both not ' ' nor '\t'.) For next_terminator(), though, I was worried
there was a case where *i_end == '\n', and next_terminator()
will return NULL instead of "last" due to *last being '\n' instead of
'\0', causing a problem, but you're using the adjusted i_end so I think
it's correct. And you've handled i_name == i_end.

I will see if I can find my testing scripts I used when commit
b5372fe5dc84 originally landed to double-check... until then:

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
