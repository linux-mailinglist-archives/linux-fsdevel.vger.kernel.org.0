Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39A8F49C3C4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Jan 2022 07:42:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236376AbiAZGms (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Jan 2022 01:42:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236263AbiAZGmn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Jan 2022 01:42:43 -0500
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93CEAC06161C
        for <linux-fsdevel@vger.kernel.org>; Tue, 25 Jan 2022 22:42:43 -0800 (PST)
Received: by mail-pg1-x536.google.com with SMTP id p125so20382365pga.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 25 Jan 2022 22:42:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=0ofuiDQxT3viLHxb0SsXLCvrM+uOJBkwjSJ8TanyCGI=;
        b=NSictfKEBnOoZC55NLB6SdZ0LVDTTW+TIVcMxFVdoxgS9KsTUzsiPV8pKLovLcd7L2
         dv6dCOCXNBDMJQneaXVP1kC3SKFWVWmjfjHun+ifEfHN99c7AacvwDfBCvIuiu2uQV1c
         Cf48QexiTeu/T7oDxgQsJdJ9qp8Wr4uArrL7k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0ofuiDQxT3viLHxb0SsXLCvrM+uOJBkwjSJ8TanyCGI=;
        b=i1eqDIDdHhV3d7Wbnz0HnF+cufxBxGmTmYOgH85CkRvd+9cMhus6h7vxcsV+FLCqfT
         ooAcdXZh9INd3riI51DII3KFwL8+LUMY+X5tEtl6XEqUUzeowxGcQzKC8+qdr+DLgAqP
         1U97b44s0oxYkEH4glE7nnn3AQT9eXb3zpqn34SCmQrLZqCCSA61Fpf3mqYrYO2mToFf
         zNBIWcIR4QIrklPpvzgJkbU1ORm3TSnPsOzpVcKbEIR+G0fqtyjTG5dmq05PmJUPUytQ
         dq0Awln6TgOt5zMjeBIaB41SLZ3Id5EE+98B+dXh2vo1di3cMQczvRLSOuh1xqJBRGGd
         JY9A==
X-Gm-Message-State: AOAM530p+bVpoXzWdPdrD01vC2XT53XKXe0ZlDWbD91FqgfCYBOPROMa
        gdKBrdBTU0z4sN4IVcFg5WZttQ==
X-Google-Smtp-Source: ABdhPJyE1srlWbFIBCylAE+gwhA+uGdMAIYjm6odIm46bv4p5aqwZ+FkWDDGqz2YD4Gs2lQ52tFNcw==
X-Received: by 2002:a63:b905:: with SMTP id z5mr17918282pge.245.1643179363112;
        Tue, 25 Jan 2022 22:42:43 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id pc7sm2200755pjb.0.2022.01.25.22.42.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jan 2022 22:42:42 -0800 (PST)
Date:   Tue, 25 Jan 2022 22:42:41 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Ariadne Conill <ariadne@dereferenced.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Eric Biederman <ebiederm@xmission.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH] fs/exec: require argv[0] presence in do_execveat_common()
Message-ID: <202201252241.7309AE568F@keescook>
References: <20220126043947.10058-1-ariadne@dereferenced.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220126043947.10058-1-ariadne@dereferenced.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jan 26, 2022 at 04:39:47AM +0000, Ariadne Conill wrote:
> The first argument to argv when used with execv family of calls is
> required to be the name of the program being executed, per POSIX.
> 
> By validating this in do_execveat_common(), we can prevent execution
> of shellcode which invokes execv(2) family syscalls with argc < 1,
> a scenario which is disallowed by POSIX, thus providing a mitigation
> against CVE-2021-4034 and similar bugs in the future.
> 
> The use of -EFAULT for this case is similar to other systems, such
> as FreeBSD and OpenBSD.
> 
> Interestingly, Michael Kerrisk opened an issue about this in 2008,
> but there was no consensus to support fixing this issue then.
> Hopefully now that CVE-2021-4034 shows practical exploitative use
> of this bug in a shellcode, we can reconsider.
> 
> Signed-off-by: Ariadne Conill <ariadne@dereferenced.org>

Yup. Agreed. For context:
https://www.qualys.com/2022/01/25/cve-2021-4034/pwnkit.txt

> ---
>  fs/exec.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/exec.c b/fs/exec.c
> index 79f2c9483302..de0b832473ed 100644
> --- a/fs/exec.c
> +++ b/fs/exec.c
> @@ -1897,8 +1897,10 @@ static int do_execveat_common(int fd, struct filename *filename,
>  	}
>  
>  	retval = count(argv, MAX_ARG_STRINGS);
> -	if (retval < 0)
> +	if (retval < 1) {
> +		retval = -EFAULT;
>  		goto out_free;
> +	}

There shouldn't be anything legitimate actually doing this in userspace.

-Kees

>  	bprm->argc = retval;
>  
>  	retval = count(envp, MAX_ARG_STRINGS);
> -- 
> 2.34.1
> 

-- 
Kees Cook
