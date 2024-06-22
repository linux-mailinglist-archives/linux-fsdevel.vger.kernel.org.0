Return-Path: <linux-fsdevel+bounces-22187-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 934B0913621
	for <lists+linux-fsdevel@lfdr.de>; Sat, 22 Jun 2024 23:25:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9273D1C21572
	for <lists+linux-fsdevel@lfdr.de>; Sat, 22 Jun 2024 21:25:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 308D9745E2;
	Sat, 22 Jun 2024 21:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nH0pb/u0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA1BF3BBF6;
	Sat, 22 Jun 2024 21:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719091543; cv=none; b=U+g0IlNqUGbpEBClhan0zxMe0DoXrRD/nCMR6jM40ANBWF6Ul6FRqu+vzeAsqBwMJq64C/9pG1LoBzPFQ/c3Qq//AajrKGrgYs3T0G5ycIFoPiCGRjSJcxUVjXTt+nJtY74/S1vw/OFcZ2FzhDmzvA8gWn2+yUXeE68DJ/GJ0Mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719091543; c=relaxed/simple;
	bh=h6FMOtSKkGDhdf9lYD/GY9k7wwwJrwD6Z6EaCUubBkQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P+zQOmh3FUwi9I7ZPYT5rekRNWCM5vLqNEPz6PoNdfBPlhKmgKfB+LzzqiweqxRv2p9Stui9yBYPowTQ8ttdpHV7LrrYmwsZiAbPH/8VEe3dvEci8i6oW4WbqGsujFlMNchQfq0NCDwi7Ew7NjMzZVQmos/KcS+MhlQlR8u2jiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nH0pb/u0; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-52cdf2c7454so1025503e87.1;
        Sat, 22 Jun 2024 14:25:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719091539; x=1719696339; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=C6Zft8pLJviHYqr+MieCC3DJ6BjX9zML7gsqsO3c1RM=;
        b=nH0pb/u0Z27Eu4SrPky06f8tQehFB4YWLceaWz/T6qk+OL1BXthZ6kG2+5M1KjjauB
         6lV9+orFjC323xOqM68dpPgOQCfSKoocqfOXoFxFsHRequbGRpvkB+kpd+U8gB1meXbq
         6Yuw1ZuIhpbSSEnoukuPqQsLXvK4Q6IInXxqeozRGFQGfIGuA+4nCN6Rhv3AGGJKT5bb
         s3QIYGWQeED3NXErnKw2OB47ZdZKPqZHmxpkS1leQCAZ/gpwyFqpllSR6JaI5FxwEHZx
         0ufg4o/fGF5Wc4bU6owWIB5e/YARIoW2jkIOFRboV9GGaYmPD0IaIBIFtT1gA/+huQSd
         NM5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719091539; x=1719696339;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C6Zft8pLJviHYqr+MieCC3DJ6BjX9zML7gsqsO3c1RM=;
        b=FRcpuWC3oI65DQtndsSj1mBsEM6XK0pFza99i/wsszTeO8hFfGFrTONsUKmg7J9dX/
         8/Eyh2tyfyjoQwPXODUoCAU9vSZGDn+i4nqG/fDjqJVnyQ1r5+UpwgXdx+v1DsKqDTVQ
         6LcOwi0ANi+EwnmHZh7zGNrqEmm/SKlw4Nq/KenMOqOmMmjhKlm3gK+HLoLzGuMSfbS4
         poDHy3nboh1ZkxPv++RsdsqPRBTEqko7EjG67ged6prPXfj66uxIhyDxcKVf8TAJD/nu
         IkRht2NyUrxUlYdTx2osjpzcbBy9KrXr8A03M7lvSiaUgq9Pr1a/KVTTcjFYRLSHNaez
         DoLg==
X-Forwarded-Encrypted: i=1; AJvYcCXRj9B31YNStEShTGOrot7XVJR9lxLqhtwpcnKyrKjLvGWcoCByQ5bdAy6PbNEU5j10UN6h2ZctGmvkgVPkwXMl2ubBG+NQzSZBVtImjSfUbKYXQ/xLK+flc+N5KNtEplI10CjmojMZs9yMuKbvXjTiyF+mwwMgwU8Q1zHYTd0qzjeqHrtpbjUAaYuB8/hQHyimujm4O5KraPznCPaTFvRH3nLh9mHQhwqh8hQ=
X-Gm-Message-State: AOJu0YxfeezzlSuB82eYYXCUno1KKvzi3JU0qNrnwtGQiJCO/pEIhZM8
	jqSod8rie0yo2DA+WHk3ehB+cfENAD6c/EiDzPTCOz4CWl8SdZ1m
X-Google-Smtp-Source: AGHT+IECbzq+U/SVXHnSyj2ETUHoANLCckvXgZJp4glNyBnnGOCtTtYX8Bcu6dTMGuZxqkbN/WljYg==
X-Received: by 2002:ac2:434d:0:b0:52c:d590:6ca7 with SMTP id 2adb3069b0e04-52ce18329b0mr513553e87.19.1719091538609;
        Sat, 22 Jun 2024 14:25:38 -0700 (PDT)
Received: from f (cst-prg-87-23.cust.vodafone.cz. [46.135.87.23])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7247895dddsm22840866b.108.2024.06.22.14.25.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Jun 2024 14:25:37 -0700 (PDT)
Date: Sat, 22 Jun 2024 23:25:27 +0200
From: Mateusz Guzik <mjguzik@gmail.com>
To: Xi Ruoyao <xry111@xry111.site>
Cc: Christian Brauner <brauner@kernel.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Alejandro Colomar <alx@kernel.org>, 
	Arnd Bergmann <arnd@arndb.de>, Huacai Chen <chenhuacai@loongson.cn>, 
	Xuerui Wang <kernel@xen0n.name>, Jiaxun Yang <jiaxun.yang@flygoat.com>, 
	Icenowy Zheng <uwu@icenowy.me>, linux-fsdevel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-arch@vger.kernel.org, loongarch@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org
Subject: Re: [PATCH] vfs: Add AT_EMPTY_PATH_NOCHECK as unchecked AT_EMPTY_PATH
Message-ID: <kslf3yc7wnwhxzv5cejaqf52bdr6yxqaqphtjl7d4iaph23y6v@ssyq7vrdwx56>
References: <20240622105621.7922-1-xry111@xry111.site>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240622105621.7922-1-xry111@xry111.site>

+cc Linus

On Sat, Jun 22, 2024 at 06:56:08PM +0800, Xi Ruoyao wrote:
> It's cheap to check if the path is empty in the userspace, but expensive
> to check if a userspace string is empty from the kernel.  So using statx
> and AT_EMPTY_PATH to implement fstat is slower than a "native" fstat
> call.  But for arch/loongarch fstat does not exist so we have to use
> statx, and on all 32-bit architectures we must use statx after 2037.
> And seccomp also cannot audit AT_EMPTY_PATH properly because it cannot
> check if path is empty.
> 
> To resolve these issues, add a relaxed version of AT_EMPTY_PATH: it does
> not check if the path is empty, but just assumes the path is empty and
> then behaves like AT_EMPTY_PATH.
> 
> Link: https://sourceware.org/pipermail/libc-alpha/2023-September/151364.html
> Link: https://lore.kernel.org/loongarch/599df4a3-47a4-49be-9c81-8e21ea1f988a@xen0n.name/

imo the thing to do is to add fstat for your arch and add fstatx for
everyone.

My argument for fstatx specifically is that Rust uses statx instead of
fstat and is growing in popularity.

To sum up the problem: stat and statx met with "" + AT_EMPTY_PATH have
more work to do than fstat and its hypotethical statx counterpart:
- buf alloc/free for the path
- userspace access (very painful on x86_64 + SMAP)
- lockref acquire/release

(and other things concerning lookup itself which I'm going to ignore
here)

Your patch avoids the peek at userspace, but the other overhead remains.
In particular the lockref cycle, apart from adding work single-threaded,
adds avoidable serialization against other threads issuing stat(x) on
the same file. iow your patch still leaves performance on the table and
I don't think it is necessary.

If the flag is the way to go (I don't see why though), I would suggest
something like AT_NO_PATH and requring NULL as the path argument (or
some other predefined "there is nothing here" constant).

I wanted to type up a proposal for fstatx (+ patch) some time ago, but
some refactoring was needed to make it happen and put it on the back
burner.

Perhaps you would be willing to pick it up, assuming the vfs folk are
oke with it.

Regardless of what happens with statx or this patch you should probably
add fstat anyway.

If there are any other perf-sensitive syscalls which don't have their
fd-only variants they should be plugged to, but I can't think of
anything.

> ---
>  fs/namei.c                 | 8 +++++++-
>  fs/stat.c                  | 4 +++-
>  include/linux/namei.h      | 4 ++++
>  include/trace/misc/fs.h    | 1 +
>  include/uapi/linux/fcntl.h | 3 +++
>  5 files changed, 18 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/namei.c b/fs/namei.c
> index 37fb0a8aa09a..0c44a7ea5961 100644
> --- a/fs/namei.c
> +++ b/fs/namei.c
> @@ -147,7 +147,13 @@ getname_flags(const char __user *filename, int flags, int *empty)
>  	kname = (char *)result->iname;
>  	result->name = kname;
>  
> -	len = strncpy_from_user(kname, filename, EMBEDDED_NAME_MAX);
> +	if (!(flags & LOOKUP_EMPTY_NOCHECK))
> +		len = strncpy_from_user(kname, filename, EMBEDDED_NAME_MAX);
> +	else {
> +		len = 0;
> +		kname[0] = '\0';
> +	}
> +
>  	if (unlikely(len < 0)) {
>  		__putname(result);
>  		return ERR_PTR(len);
> diff --git a/fs/stat.c b/fs/stat.c
> index 70bd3e888cfa..53944d3287cd 100644
> --- a/fs/stat.c
> +++ b/fs/stat.c
> @@ -210,6 +210,8 @@ int getname_statx_lookup_flags(int flags)
>  		lookup_flags |= LOOKUP_AUTOMOUNT;
>  	if (flags & AT_EMPTY_PATH)
>  		lookup_flags |= LOOKUP_EMPTY;
> +	if (flags & AT_EMPTY_PATH_NOCHECK)
> +		lookup_flags |= LOOKUP_EMPTY | LOOKUP_EMPTY_NOCHECK;
>  
>  	return lookup_flags;
>  }
> @@ -237,7 +239,7 @@ static int vfs_statx(int dfd, struct filename *filename, int flags,
>  	int error;
>  
>  	if (flags & ~(AT_SYMLINK_NOFOLLOW | AT_NO_AUTOMOUNT | AT_EMPTY_PATH |
> -		      AT_STATX_SYNC_TYPE))
> +		      AT_STATX_SYNC_TYPE | AT_EMPTY_PATH_NOCHECK))
>  		return -EINVAL;
>  
>  retry:
> diff --git a/include/linux/namei.h b/include/linux/namei.h
> index 967aa9ea9f96..def6a8a1b531 100644
> --- a/include/linux/namei.h
> +++ b/include/linux/namei.h
> @@ -45,9 +45,13 @@ enum {LAST_NORM, LAST_ROOT, LAST_DOT, LAST_DOTDOT};
>  #define LOOKUP_IN_ROOT		0x100000 /* Treat dirfd as fs root. */
>  #define LOOKUP_CACHED		0x200000 /* Only do cached lookup */
>  #define LOOKUP_LINKAT_EMPTY	0x400000 /* Linkat request with empty path. */
> +
>  /* LOOKUP_* flags which do scope-related checks based on the dirfd. */
>  #define LOOKUP_IS_SCOPED (LOOKUP_BENEATH | LOOKUP_IN_ROOT)
>  
> +/* If this is set, LOOKUP_EMPTY must be set as well. */
> +#define LOOKUP_EMPTY_NOCHECK	0x800000 /* Consider path empty. */
> +
>  extern int path_pts(struct path *path);
>  
>  extern int user_path_at_empty(int, const char __user *, unsigned, struct path *, int *empty);
> diff --git a/include/trace/misc/fs.h b/include/trace/misc/fs.h
> index 738b97f22f36..24aec7ed6b0b 100644
> --- a/include/trace/misc/fs.h
> +++ b/include/trace/misc/fs.h
> @@ -119,4 +119,5 @@
>  		{ LOOKUP_NO_XDEV,	"NO_XDEV" }, \
>  		{ LOOKUP_BENEATH,	"BENEATH" }, \
>  		{ LOOKUP_IN_ROOT,	"IN_ROOT" }, \
> +		{ LOOKUP_EMPTY_NOCHECK,	"EMPTY_NOCHECK" }, \
>  		{ LOOKUP_CACHED,	"CACHED" })
> diff --git a/include/uapi/linux/fcntl.h b/include/uapi/linux/fcntl.h
> index c0bcc185fa48..aa2f68d80820 100644
> --- a/include/uapi/linux/fcntl.h
> +++ b/include/uapi/linux/fcntl.h
> @@ -113,6 +113,9 @@
>  #define AT_STATX_DONT_SYNC	0x4000	/* - Don't sync attributes with the server */
>  
>  #define AT_RECURSIVE		0x8000	/* Apply to the entire subtree */
> +#define AT_EMPTY_PATH_NOCHECK	0x10000	/* Like AT_EMPTY_PATH, but the path
> +                                           is not checked and it's just
> +                                           assumed to be empty */
>  
>  /* Flags for name_to_handle_at(2). We reuse AT_ flag space to save bits... */
>  #define AT_HANDLE_FID		AT_REMOVEDIR	/* file handle is needed to
> -- 
> 2.45.2
> 

