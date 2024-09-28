Return-Path: <linux-fsdevel+bounces-30303-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03631989180
	for <lists+linux-fsdevel@lfdr.de>; Sat, 28 Sep 2024 23:14:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8FE76285E42
	for <lists+linux-fsdevel@lfdr.de>; Sat, 28 Sep 2024 21:14:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CB31186616;
	Sat, 28 Sep 2024 21:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g9tqavMY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB4FC18454E;
	Sat, 28 Sep 2024 21:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727558068; cv=none; b=ZUU5QgHo4I/1dUkA6x4z7dy/0vU7IHZo8CNH2TlC5J5RP7uIckxthaYpBo8KMls1jZt9CMVqlRjVNGp6l/HxC+oOXEwPR4aCydQTSnfMsAGJyB3iZoqxGapXxzHMDx8e0r2ls1FnMMz22p0sRFOeWdsF7iuswoHozPepnkij/Ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727558068; c=relaxed/simple;
	bh=jktDOh0pQJ6Jkqsq+yKW1qQ5mo20RTE6ds51doxTD2g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bK9BJ5hpGNTo4Y9ie7e2MM+45cK5udPexRhlLkOcyLv5Bfn/doZA6Cs5lxIQaYs8QSbPuNZkoSDrewTnaaTqeuYA4fz4utizlFn4Jf9Q60KqEX2kw+43AmaQ0y5zsb64yUOsSEx46ZGeyuV6a54VcGcl8FzTIrMVsq1rnZYUXB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g9tqavMY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F384C4CEC3;
	Sat, 28 Sep 2024 21:14:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727558067;
	bh=jktDOh0pQJ6Jkqsq+yKW1qQ5mo20RTE6ds51doxTD2g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=g9tqavMYyNMNsLQ90Hv8A7KbaPkFXwEzrTr5sUcx3Go75HmSrEM5AGbS3oGkbdlel
	 B6eeA9RvWWVqPZh9Wyg+F2ooAJEJP2A9vmlOpz3KGgnUCCaozlOpVXmu34F4CSTbVW
	 VYi3AeJ+So0qIkRNXn0E4ZMxj7wF4lRw5UT4Z9kANXoElsoElSAq/nMKw4C30aQ1eq
	 FyUyaqsM2A7JG0XC1b589UzBaWfIb8SBg8crnH5eMbtpFnuBXzJZorS5YemcfRe1yg
	 2gYtwluBB821Xd++PBJbJ5ISoXfK7xESIT3aL16deLWzsV9vCOeNQKEJ+OF0s25yqT
	 cS+Ic0n7Zt0/Q==
Date: Sat, 28 Sep 2024 14:14:27 -0700
From: Kees Cook <kees@kernel.org>
To: Yafang Shao <laoar.shao@gmail.com>
Cc: akpm@linux-foundation.org, torvalds@linux-foundation.org,
	alx@kernel.org, justinstitt@google.com, ebiederm@xmission.com,
	alexei.starovoitov@gmail.com, rostedt@goodmis.org,
	catalin.marinas@arm.com, penguin-kernel@i-love.sakura.ne.jp,
	linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, audit@vger.kernel.org,
	linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
	bpf@vger.kernel.org, netdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v7 5/8] mm/util: Fix possible race condition in kstrdup()
Message-ID: <202409281411.3C42A3703C@keescook>
References: <20240817025624.13157-1-laoar.shao@gmail.com>
 <20240817025624.13157-6-laoar.shao@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240817025624.13157-6-laoar.shao@gmail.com>

On Sat, Aug 17, 2024 at 10:56:21AM +0800, Yafang Shao wrote:
> In kstrdup(), it is critical to ensure that the dest string is always
> NUL-terminated. However, potential race condidtion can occur between a
> writer and a reader.
> 
> Consider the following scenario involving task->comm:
> 
>     reader                    writer
> 
>   len = strlen(s) + 1;
>                              strlcpy(tsk->comm, buf, sizeof(tsk->comm));
>   memcpy(buf, s, len);
> 
> In this case, there is a race condition between the reader and the
> writer. The reader calculate the length of the string `s` based on the
> old value of task->comm. However, during the memcpy(), the string `s`
> might be updated by the writer to a new value of task->comm.
> 
> If the new task->comm is larger than the old one, the `buf` might not be
> NUL-terminated. This can lead to undefined behavior and potential
> security vulnerabilities.
> 
> Let's fix it by explicitly adding a NUL-terminator.

So, I'm fine with adding this generally, but I'm not sure we can
construct these helpers to be universally safe against the strings
changing out from under them. This situation is distinct to the 'comm'
member, so I'd like to focus on helpers around 'comm' access behaving in
a reliable fashion.

-Kees

> 
> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> ---
>  mm/util.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/util.c b/mm/util.c
> index 983baf2bd675..4542d8a800d9 100644
> --- a/mm/util.c
> +++ b/mm/util.c
> @@ -62,8 +62,14 @@ char *kstrdup(const char *s, gfp_t gfp)
>  
>  	len = strlen(s) + 1;
>  	buf = kmalloc_track_caller(len, gfp);
> -	if (buf)
> +	if (buf) {
>  		memcpy(buf, s, len);
> +		/* During memcpy(), the string might be updated to a new value,
> +		 * which could be longer than the string when strlen() is
> +		 * called. Therefore, we need to add a null termimator.
> +		 */
> +		buf[len - 1] = '\0';
> +	}
>  	return buf;
>  }
>  EXPORT_SYMBOL(kstrdup);
> -- 
> 2.43.5
> 

-- 
Kees Cook

