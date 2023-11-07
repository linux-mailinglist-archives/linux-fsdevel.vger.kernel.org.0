Return-Path: <linux-fsdevel+bounces-2312-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C6FB7E49F6
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Nov 2023 21:37:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BDD4B1C20C9A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Nov 2023 20:37:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D4E731A78;
	Tue,  7 Nov 2023 20:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Xk8zz9b3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 664382C860
	for <linux-fsdevel@vger.kernel.org>; Tue,  7 Nov 2023 20:37:23 +0000 (UTC)
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEAE610D0
	for <linux-fsdevel@vger.kernel.org>; Tue,  7 Nov 2023 12:37:22 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-6b709048d8eso5237407b3a.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 07 Nov 2023 12:37:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1699389442; x=1699994242; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vaEivRGYQgWty+lkiDpJ6XgknaKLFgZ+tZbiPi4ULqE=;
        b=Xk8zz9b3Lfb8DBOsXsc6j86GBeVy3szLMGvHJEbJR5h5/p8fBXndB8VbaZEm+r5qtk
         fZ8i1Cpwi6uLWAyQv2sw+iy7BQYzKn07JIuZwyZ+nPLnl5ndivgZV7TMo7EuX+o5URB1
         ZHSl6F5j15ajmZA25R/UTBcr4+TJq0hUMfN78=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699389442; x=1699994242;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vaEivRGYQgWty+lkiDpJ6XgknaKLFgZ+tZbiPi4ULqE=;
        b=BgqRRe3e078r3zgxqV6XG31SsGhfCTeDmi+acjPcFkG8FI4vWvmDf5+s4c8bejNrXC
         J6jn7Wt702L0EVgoBvaWadwHJUDRzl7Y/9Pch40jit4hvPjHaWucWTK3q54WM/6J/NN5
         nVDUus2AtkaDPqpIEWOJupkClkAJ5NYqRSGKjYywMkDEMmw1AC4ddN8G/Z463xh8WGVJ
         TY0+gdLGzjLewV9kKy2D8Jp0zs00VmDKNB1MyxHstVTjdTObXrOGH44fkRP1rIyGUozq
         G3ErHDmbZTS8/wnLsPsxUZgPkDBzjaX5oNItFnSClrGLr+MIuDrlz5tsPijW5ScHhIyB
         WXbQ==
X-Gm-Message-State: AOJu0Yy7zTujSpw1MsiKpFBcF5LtGTiWvHgaLX6B+khiVVm7gRDtCLL1
	7Yf0OQOVx+sgstsaugr4+ffNIw==
X-Google-Smtp-Source: AGHT+IE+1gfPggREs0LKHC4iwp9aPM5a+Hkng8JZERX1SSzCn3TpDE0hw34nJeMnxNX73PXMAinopw==
X-Received: by 2002:a05:6a21:9988:b0:181:98d6:6afd with SMTP id ve8-20020a056a21998800b0018198d66afdmr126141pzb.41.1699389442297;
        Tue, 07 Nov 2023 12:37:22 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id a8-20020a17090a740800b0026801e06ac1sm219553pjg.30.2023.11.07.12.37.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Nov 2023 12:37:21 -0800 (PST)
Date: Tue, 7 Nov 2023 12:37:21 -0800
From: Kees Cook <keescook@chromium.org>
To: Josh Triplett <josh@joshtriplett.org>
Cc: Eric Biederman <ebiederm@xmission.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>, linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fs/exec.c: Add fast path for ENOENT on PATH search
 before allocating mm
Message-ID: <202311071236.71CDE62@keescook>
References: <5c7333ea4bec2fad1b47a8fa2db7c31e4ffc4f14.1663334978.git.josh@joshtriplett.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5c7333ea4bec2fad1b47a8fa2db7c31e4ffc4f14.1663334978.git.josh@joshtriplett.org>

On Fri, Sep 16, 2022 at 02:41:30PM +0100, Josh Triplett wrote:
> Currently, execve allocates an mm and parses argv and envp before
> checking if the path exists. However, the common case of a $PATH search
> may have several failed calls to exec before a single success. Do a
> filename lookup for the purposes of returning ENOENT before doing more
> expensive operations.
> 
> This does not create a TOCTTOU race, because this can only happen if the
> file didn't exist at some point during the exec call, and that point is
> permitted to be when we did our lookup.
> 
> To measure performance, I ran 2000 fork and execvpe calls with a
> seven-element PATH in which the file was found in the seventh directory
> (representative of the common case as /usr/bin is the seventh directory
> on my $PATH), as well as 2000 fork and execve calls with an absolute
> path to an existing binary. I recorded the minimum time for each, to
> eliminate noise from context switches and similar.
> 
> Without fast-path:
> fork/execvpe: 49876ns
> fork/execve:  32773ns
> 
> With fast-path:
> fork/execvpe: 36890ns
> fork/execve:  32069ns
> 
> The cost of the additional lookup seems to be in the noise for a
> successful exec, but it provides a 26% improvement for the path search
> case by speeding up the six failed execs.
> 
> Signed-off-by: Josh Triplett <josh@joshtriplett.org>
> ---
> 
> Discussed this at Plumbers with Kees Cook; turned out to be even more of
> a win than anticipated.
> 
>  fs/exec.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/fs/exec.c b/fs/exec.c
> index 9a5ca7b82bfc..fe786aeb2f1b 100644
> --- a/fs/exec.c
> +++ b/fs/exec.c
> @@ -1881,6 +1881,16 @@ static int do_execveat_common(int fd, struct filename *filename,
>  	if (IS_ERR(filename))
>  		return PTR_ERR(filename);
>  
> +	/* Fast-path ENOENT for $PATH search failures, before we alloc an mm or
> +	 * parse arguments. */
> +	if (fd == AT_FDCWD && flags == 0 && filename->name[0] == '/') {
> +		struct path path;
> +		retval = filename_lookup(AT_FDCWD, filename, 0, &path, NULL);
> +		if (retval == -ENOENT)

Oh, actually, I see the 0-day problem. This should be:

		if (retval < 0)

> +			goto out_ret;
> +		path_put(&path);

Otherwise this put will happen for an non-successful lookup that wans't
ENOENT. I've fixed this in my tree.

-Kees

> +	}
> +
>  	/*
>  	 * We move the actual failure in case of RLIMIT_NPROC excess from
>  	 * set*uid() to execve() because too many poorly written programs
> -- 
> 2.37.2
> 

-- 
Kees Cook

