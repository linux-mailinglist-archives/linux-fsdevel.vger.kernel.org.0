Return-Path: <linux-fsdevel+bounces-25266-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7B8694A578
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Aug 2024 12:28:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 762FE281627
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Aug 2024 10:28:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B85EA1DE84A;
	Wed,  7 Aug 2024 10:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YcrbRqsE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 128051DD3AB;
	Wed,  7 Aug 2024 10:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723026519; cv=none; b=KTNO3+R2aIYewsp0Q8vU+8mZce2uplbUNwAd+iZ3I1JfnSNIaZvQwsHUOfpwQeGSzCt9XbqZMg6+TPyuKD2Of7AL8qrzh+oUTlTqF+aqjwc+7VeqeEOzJBcezN/CkqknTY3zuhX4FoYJQTBwkpnYuoj61wR35m2AQnheOxXyWng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723026519; c=relaxed/simple;
	bh=mrPosrvepEZaagd8JuvbguOPcd4q5Unm+C80YUqdVN8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cVNcCUOnIXRBmqxzSqKCQuVn04tMbk2Zyt7uY+n8IIc4nezmmEIvsBPMALCC6oU+khyC4YHRkMn88KQZidMyVPXxe/UbEQHxGg8faoWxapuPdcAxzc08TMI97oFfFMCkKVWibV6/4Tk3suDYkM2JAueekDF8av7c2+mh10HFrew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YcrbRqsE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 874E9C32782;
	Wed,  7 Aug 2024 10:28:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723026518;
	bh=mrPosrvepEZaagd8JuvbguOPcd4q5Unm+C80YUqdVN8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YcrbRqsEEeMrYWMB+O0b9dyfzEMR2aAty0tcF4d3owiZcFAdBXS5evrB0udVu0UNv
	 0l1JMtIsT9rXMYFjPeoeONBYf5g53sQUdaZ1T1jl554Pz1TYKrLfzzj/q9MRSxJnW4
	 YVkq2fVNpW5ADUn6wsYhzzbIPhAqixg6lOM82/wmd+nI/GJvx8NvRPt3OC6MYHpHhy
	 jzHh2weuIxrjOuIrJWu5Ap+CxBH7Gs8cWiWRVxImdOPkpMsOjLDN9U26CAElYOHrNm
	 5YfTfU0nr/4lI6RMJBlEn56kwK940EsKPiUoVzg9pqnBd6TTUbxYNm9mot3njB42H+
	 U3JwLbL/O58tg==
Date: Wed, 7 Aug 2024 12:28:33 +0200
From: Christian Brauner <brauner@kernel.org>
To: viro@kernel.org
Cc: linux-fsdevel@vger.kernel.org, amir73il@gmail.com, bpf@vger.kernel.org, 
	cgroups@vger.kernel.org, kvm@vger.kernel.org, netdev@vger.kernel.org, 
	torvalds@linux-foundation.org
Subject: Re: [PATCH 16/39] convert __bpf_prog_get() to CLASS(fd, ...)
Message-ID: <20240807-wollust-entgleisen-e0ae07e6ae57@brauner>
References: <20240730050927.GC5334@ZenIV>
 <20240730051625.14349-1-viro@kernel.org>
 <20240730051625.14349-16-viro@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240730051625.14349-16-viro@kernel.org>

On Tue, Jul 30, 2024 at 01:16:02AM GMT, viro@kernel.org wrote:
> From: Al Viro <viro@zeniv.linux.org.uk>
> 
> Irregularity here is fdput() not in the same scope as fdget();
> just fold ____bpf_prog_get() into its (only) caller and that's
> it...
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---
>  kernel/bpf/syscall.c | 32 +++++++++++---------------------
>  1 file changed, 11 insertions(+), 21 deletions(-)
> 
> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index 3093bf2cc266..c5b252c0faa8 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -2407,18 +2407,6 @@ int bpf_prog_new_fd(struct bpf_prog *prog)
>  				O_RDWR | O_CLOEXEC);
>  }
>  
> -static struct bpf_prog *____bpf_prog_get(struct fd f)
> -{
> -	if (!fd_file(f))
> -		return ERR_PTR(-EBADF);
> -	if (fd_file(f)->f_op != &bpf_prog_fops) {
> -		fdput(f);
> -		return ERR_PTR(-EINVAL);
> -	}
> -
> -	return fd_file(f)->private_data;
> -}
> -
>  void bpf_prog_add(struct bpf_prog *prog, int i)
>  {
>  	atomic64_add(i, &prog->aux->refcnt);
> @@ -2474,20 +2462,22 @@ bool bpf_prog_get_ok(struct bpf_prog *prog,
>  static struct bpf_prog *__bpf_prog_get(u32 ufd, enum bpf_prog_type *attach_type,
>  				       bool attach_drv)
>  {
> -	struct fd f = fdget(ufd);
> +	CLASS(fd, f)(ufd);
>  	struct bpf_prog *prog;
>  
> -	prog = ____bpf_prog_get(f);
> -	if (IS_ERR(prog))
> +	if (fd_empty(f))
> +		return ERR_PTR(-EBADF);
> +	if (fd_file(f)->f_op != &bpf_prog_fops)
> +		return ERR_PTR(-EINVAL);
> +
> +	prog = fd_file(f)->private_data;
> +	if (IS_ERR(prog))	// can that actually happen?
>  		return prog;

With or without that removed:

Reviewed-by: Christian Brauner <brauner@kernel.org>

