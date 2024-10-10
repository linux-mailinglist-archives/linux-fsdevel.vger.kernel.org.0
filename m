Return-Path: <linux-fsdevel+bounces-31512-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E530C997D27
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Oct 2024 08:24:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A46FA285735
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Oct 2024 06:24:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABDA91A3A80;
	Thu, 10 Oct 2024 06:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="uNDHpbgk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C86AB1A0731;
	Thu, 10 Oct 2024 06:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728541475; cv=none; b=RGHZv1F9EuJ2PDU6IuJznhkycSPE9c9yWido8l33q/nf+q/F6JNmDBd70krHIHVgm8KLYyggcK3hHKat5zRsdYnYn+VylXHAv7bpbF4euz/GDhIkio5wD9ehMf9BG2woNZmd8gvqcxiqvXyWnEwbXnR3Feri9cEqD3ThBHeYTOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728541475; c=relaxed/simple;
	bh=M1pNevWEIqXXclY0XMWmxwReI9M6IUcCjETbN7GlI98=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=adOCA3z9/gWmmyHiC0f1zNrrVW/V7GnjIeWrouMgHndrX7gx2PR6+fjx2wyWlbs1rsVj02EBzbK28KnkfD2PYCeJwzMXHqK3wKnIL0k4GvVaAk+tJocaky+qW5hIoi8wSaEJL9+Y/z4m7qdF2WwQWmVmu9rWBg/6VggWriMtz64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=uNDHpbgk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA350C4CEC6;
	Thu, 10 Oct 2024 06:24:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728541474;
	bh=M1pNevWEIqXXclY0XMWmxwReI9M6IUcCjETbN7GlI98=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uNDHpbgklhLrpHNYKZOsHNu6PIs8UvQ17rdUv9wYJ55k7Xmtz/rW48Nxa73ijUe5b
	 ssjzXGRDr+gBU82vKDbYx4qVFidm+nRRWYhqwHwBab/DTxbu2FZrhZdR70a7/bN1Mm
	 zEIu6RtVEkK1PffZh7NOxbvLco9EAFiixqUJV4Nk=
Date: Thu, 10 Oct 2024 08:24:31 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Aleksa Sarai <cyphar@cyphar.com>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Arnd Bergmann <arnd@arndb.de>, Shuah Khan <shuah@kernel.org>,
	Kees Cook <kees@kernel.org>, Florian Weimer <fweimer@redhat.com>,
	Mark Rutland <mark.rutland@arm.com>, linux-kernel@vger.kernel.org,
	linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-arch@vger.kernel.org, linux-kselftest@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH RFC v3 03/10] openat2: explicitly return -E2BIG for
 (usize > PAGE_SIZE)
Message-ID: <2024101010-heaving-overhung-a067@gregkh>
References: <20241010-extensible-structs-check_fields-v3-0-d2833dfe6edd@cyphar.com>
 <20241010-extensible-structs-check_fields-v3-3-d2833dfe6edd@cyphar.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241010-extensible-structs-check_fields-v3-3-d2833dfe6edd@cyphar.com>

On Thu, Oct 10, 2024 at 07:40:36AM +1100, Aleksa Sarai wrote:
> While we do currently return -EFAULT in this case, it seems prudent to
> follow the behaviour of other syscalls like clone3. It seems quite
> unlikely that anyone depends on this error code being EFAULT, but we can
> always revert this if it turns out to be an issue.
> 
> Cc: <stable@vger.kernel.org> # v5.6+
> Fixes: fddb5d430ad9 ("open: introduce openat2(2) syscall")
> Signed-off-by: Aleksa Sarai <cyphar@cyphar.com>
> ---
>  fs/open.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/fs/open.c b/fs/open.c
> index 22adbef7ecc2..30bfcddd505d 100644
> --- a/fs/open.c
> +++ b/fs/open.c
> @@ -1458,6 +1458,8 @@ SYSCALL_DEFINE4(openat2, int, dfd, const char __user *, filename,
>  
>  	if (unlikely(usize < OPEN_HOW_SIZE_VER0))
>  		return -EINVAL;
> +	if (unlikely(usize > PAGE_SIZE))
> +		return -E2BIG;
>  
>  	err = copy_struct_from_user(&tmp, sizeof(tmp), how, usize);
>  	if (err)
> 
> -- 
> 2.46.1

Why isn't this just sent as a normal fix to be included now and not
burried in a RFC series?

thanks,

greg k-h

