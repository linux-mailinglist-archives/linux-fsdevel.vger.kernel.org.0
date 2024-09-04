Return-Path: <linux-fsdevel+bounces-28479-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F43F96B06A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Sep 2024 07:19:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0CDB6B2344B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Sep 2024 05:19:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE97982899;
	Wed,  4 Sep 2024 05:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s0UuoRft"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E59C823C3
	for <linux-fsdevel@vger.kernel.org>; Wed,  4 Sep 2024 05:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725427136; cv=none; b=j6PjjATLsaFsUbTmtS7ADcS/uOK3ryHQgTdTp+kqfncSEx4gjStotKMe1j2MpYjKGZ9oW+lde6MYvGtx34FExeFzEEFgvCpKUC4cJt0+OK+OFmB4Vk0qQVGk57Ahag2LUCtHz8hyb2fH2P8QOGlMJf9bKdpuA+0QShid27MflMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725427136; c=relaxed/simple;
	bh=oSa5MkUfVUGc4lGYcNLkbNhyI4gxtWrjnDAQ5Dr6a2I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pnoaR1M2qKToqu4ChdVRuukvysIZ8ET9cIs4ZA2e3EhRRmNT5CXxCt+kRMwaMA5gYM84D64c8ZKfUQPl7YmT/hvmybEHHfaS1AdRCfD2eQLjJobak/Uop7l8nVnwmZHLjHOjjcniC91gCO/H3+zXvTp3B622E1YciRrZS8w80Kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s0UuoRft; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36314C4CEC2;
	Wed,  4 Sep 2024 05:18:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725427135;
	bh=oSa5MkUfVUGc4lGYcNLkbNhyI4gxtWrjnDAQ5Dr6a2I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=s0UuoRftw6qb1bDtSkV2PDdIJNLfWztU6J7s4OTaJnC+J+5YqXk4gwOP11Qhr3fJY
	 WrfYyZIKanqWQQWZO7Ck+NyKxXye1z7OjVWduMxDugHVb21S8h93xDa6CFEataHSMH
	 afrF4tdWfvlAZyUh+rBcWgxwMggo/2mL5nlbFYT/l0emLjAPEga72vtFpvHLPPtoXV
	 7n8pKYN8VDkASTToTV2dTpwhU/2ilI3PedRO40a32nNk+XUH0ULmAHEX2EZoB52XY/
	 4ZGTiQgPgNps+mQIHUUppVEw1PsSWH3Lv/P4wwVPcoW+8mr7ULMs4ITGh77/2l78WX
	 gmFWWo5VdGOTg==
Date: Wed, 4 Sep 2024 08:16:09 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Christian Brauner <brauner@kernel.org>
Cc: Vlastimil Babka <vbabka@suse.cz>, Jens Axboe <axboe@kernel.dk>,
	Jann Horn <jannh@google.com>,
	Linus Torvalds <torvalds@linux-foundation.org>, linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 15/15] io_uring: port to struct kmem_cache_args
Message-ID: <ZtftGVxxKqb3F4uU@kernel.org>
References: <20240903-work-kmem_cache_args-v2-0-76f97e9a4560@kernel.org>
 <20240903-work-kmem_cache_args-v2-15-76f97e9a4560@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240903-work-kmem_cache_args-v2-15-76f97e9a4560@kernel.org>

On Tue, Sep 03, 2024 at 04:20:56PM +0200, Christian Brauner wrote:
> Port req_cachep to struct kmem_cache_args.
> 
> Signed-off-by: Christian Brauner <brauner@kernel.org>

Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

> ---
>  io_uring/io_uring.c | 14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)
> 
> diff --git a/io_uring/io_uring.c b/io_uring/io_uring.c
> index 3942db160f18..d9d721d1424e 100644
> --- a/io_uring/io_uring.c
> +++ b/io_uring/io_uring.c
> @@ -3638,6 +3638,11 @@ SYSCALL_DEFINE2(io_uring_setup, u32, entries,
>  
>  static int __init io_uring_init(void)
>  {
> +	struct kmem_cache_args kmem_args = {
> +		.useroffset = offsetof(struct io_kiocb, cmd.data),
> +		.usersize = sizeof_field(struct io_kiocb, cmd.data),
> +	};
> +
>  #define __BUILD_BUG_VERIFY_OFFSET_SIZE(stype, eoffset, esize, ename) do { \
>  	BUILD_BUG_ON(offsetof(stype, ename) != eoffset); \
>  	BUILD_BUG_ON(sizeof_field(stype, ename) != esize); \
> @@ -3722,12 +3727,9 @@ static int __init io_uring_init(void)
>  	 * range, and HARDENED_USERCOPY will complain if we haven't
>  	 * correctly annotated this range.
>  	 */
> -	req_cachep = kmem_cache_create_usercopy("io_kiocb",
> -				sizeof(struct io_kiocb), 0,
> -				SLAB_HWCACHE_ALIGN | SLAB_PANIC |
> -				SLAB_ACCOUNT | SLAB_TYPESAFE_BY_RCU,
> -				offsetof(struct io_kiocb, cmd.data),
> -				sizeof_field(struct io_kiocb, cmd.data), NULL);
> +	req_cachep = kmem_cache_create("io_kiocb", sizeof(struct io_kiocb), &kmem_args,
> +				SLAB_HWCACHE_ALIGN | SLAB_PANIC | SLAB_ACCOUNT |
> +				SLAB_TYPESAFE_BY_RCU);
>  	io_buf_cachep = KMEM_CACHE(io_buffer,
>  					  SLAB_HWCACHE_ALIGN | SLAB_PANIC | SLAB_ACCOUNT);
>  
> 
> -- 
> 2.45.2
> 

-- 
Sincerely yours,
Mike.

