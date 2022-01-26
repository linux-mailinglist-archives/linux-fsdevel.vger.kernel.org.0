Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B641449D326
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Jan 2022 21:09:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229981AbiAZUJK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Jan 2022 15:09:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbiAZUJJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Jan 2022 15:09:09 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A59DCC06161C
        for <linux-fsdevel@vger.kernel.org>; Wed, 26 Jan 2022 12:09:09 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id b15so590332plg.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 26 Jan 2022 12:09:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=0AM6jAhygFdYam0w1plbFIPS+oA8KN5gbbX1Aawy0Yc=;
        b=V+TBAmvIKTAiWCAK7WjvLps7Es/Z6nzpnlzRMvlKGM8AusvtUuZTH4QOceHyu1x+aK
         +vZpUyFxeMBQ7XOFZzT9RbNqIFyLzlK/XJPxeTBt1o4MBdSGqkZPlS34LKsLsvesD7Fq
         T6vNkaJPx90pd3vUbOsWyJQKka+d2tayLQs1E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0AM6jAhygFdYam0w1plbFIPS+oA8KN5gbbX1Aawy0Yc=;
        b=FC7ooxMi5tPBsOyZPgrihddCiFyaxsTODJ0AYxdZ876aFyxgOu/ilkXERd6kWQxjnW
         jif/tICt+JGu9esjEZDWQrQdfljIKEPXBvLETUNjlBc2ZQAuZRZZT6JGKgtTUs0FhUaR
         MseAS3h+ZmxaVvgJUvM19Z6fBPoDtLnhD3d2RL/PWs1rvwoTKiaiNnn225bcvKLsKPwr
         y46f0mvcBhgzzce9lzDporS4A9f3L3cVKDiPoH4aES81tmFuZnlOHhP54hAd4K96Kqvv
         qYONbP6CwyNAVJegAW8q4Xb65ULQBJxoecL+NVCPor2A32PAtIXs2OW0BTG2rToJwNJz
         l7HQ==
X-Gm-Message-State: AOAM530/tMYcCsL9fy2kvCk8xJOYF9TCJW4ambtPVSYh/LGI5NQFM7FN
        rCT1ZIwk5ebt58tD8d51aAWnAw==
X-Google-Smtp-Source: ABdhPJxulSs3+ojCUhwadjvGOqwtb8zlV+3OgGb7YcJU19djANq4qP9I3tlXzq6Bdt+5z3pysKlPSQ==
X-Received: by 2002:a17:903:2003:: with SMTP id s3mr567853pla.97.1643227749198;
        Wed, 26 Jan 2022 12:09:09 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id nm14sm79262pjb.32.2022.01.26.12.09.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jan 2022 12:09:08 -0800 (PST)
Date:   Wed, 26 Jan 2022 12:09:08 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Ariadne Conill <ariadne@dereferenced.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Eric Biederman <ebiederm@xmission.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH v2] fs/exec: require argv[0] presence in
 do_execveat_common()
Message-ID: <202201261202.EC027EB@keescook>
References: <20220126114447.25776-1-ariadne@dereferenced.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220126114447.25776-1-ariadne@dereferenced.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jan 26, 2022 at 11:44:47AM +0000, Ariadne Conill wrote:
> In several other operating systems, it is a hard requirement that the
> first argument to execve(2) be the name of a program, thus prohibiting
> a scenario where argc < 1.  POSIX 2017 also recommends this behaviour,
> but it is not an explicit requirement[0]:
> 
>     The argument arg0 should point to a filename string that is
>     associated with the process being started by one of the exec
>     functions.
> 
> To ensure that execve(2) with argc < 1 is not a useful gadget for
> shellcode to use, we can validate this in do_execveat_common() and
> fail for this scenario, effectively blocking successful exploitation
> of CVE-2021-4034 and similar bugs which depend on this gadget.
> 
> The use of -EFAULT for this case is similar to other systems, such
> as FreeBSD, OpenBSD and Solaris.  QNX uses -EINVAL for this case.
> 
> Interestingly, Michael Kerrisk opened an issue about this in 2008[1],
> but there was no consensus to support fixing this issue then.
> Hopefully now that CVE-2021-4034 shows practical exploitative use
> of this bug in a shellcode, we can reconsider.
> 
> [0]: https://pubs.opengroup.org/onlinepubs/9699919799/functions/exec.html
> [1]: https://bugzilla.kernel.org/show_bug.cgi?id=8408
> 
> Changes from v1:
> - Rework commit message significantly.
> - Make the argv[0] check explicit rather than hijacking the error-check
>   for count().
> 
> Signed-off-by: Ariadne Conill <ariadne@dereferenced.org>
> ---
>  fs/exec.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/fs/exec.c b/fs/exec.c
> index 79f2c9483302..e52c41991aab 100644
> --- a/fs/exec.c
> +++ b/fs/exec.c
> @@ -1899,6 +1899,10 @@ static int do_execveat_common(int fd, struct filename *filename,
>  	retval = count(argv, MAX_ARG_STRINGS);
>  	if (retval < 0)
>  		goto out_free;
> +	if (retval == 0) {
> +		retval = -EFAULT;
> +		goto out_free;
> +	}
>  	bprm->argc = retval;
>  
>  	retval = count(envp, MAX_ARG_STRINGS);
> -- 
> 2.34.1

Okay, so, the dangerous condition is userspace iterating through envp
when it thinks it's iterating argv.

Assuming it is not okay to break valgrind's test suite:
https://sources.debian.org/src/valgrind/1:3.18.1-1/none/tests/execve.c/?hl=22#L22
we cannot reject a NULL argv (test will fail), and we cannot mutate
argc=0 into argc=1 (test will enter infinite loop).

Perhaps we need to reject argv=NULL when envp!=NULL, and add a
pr_warn_once() about using a NULL argv?

I note that glibc already warns about NULL argv:
argc0.c:7:3: warning: null argument where non-null required (argument 2)
[-Wnonnull]
    7 |   execve(argv[0], NULL, envp);
      |   ^~~~~~

in the future we could expand this to only looking at argv=NULL?

-- 
Kees Cook
