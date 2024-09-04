Return-Path: <linux-fsdevel+bounces-28467-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0490796B037
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Sep 2024 06:58:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 94436B23538
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Sep 2024 04:58:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5410783CC1;
	Wed,  4 Sep 2024 04:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oPHeJ14O"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B691081AB6
	for <linux-fsdevel@vger.kernel.org>; Wed,  4 Sep 2024 04:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725425914; cv=none; b=e5bu+p8Zvi9MhXqsWf79mq0zg8gP5fhdjfc9UTdPyaJeomFbntGX0s1P9mrYUHrCg5C1U7EKZ6yHW9ObIYg4wCKinqU2Jb4AQyiTcqIUegXdcxGiXoFRefK3LvU1Adtjjdob3ytO+0/4VQdq4lm0sA/1e3CVaNTWLYqX8OWyAAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725425914; c=relaxed/simple;
	bh=WHcb9EzuvBLgowDYaNy5EbNrAQVJ55Twf/5kTivsSjU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=adV9HXcJ8zIRNhI2L1OY7fFXxcAD8n7LY0nODi01qUN2dn94ekErqg7wUW/dbvinfORy0L+w9a6O5kvCPLiXcToKCRPu0XaU27nLCbaDNpbafgzjJPRyMJjjXjaMjLhN9XpXt8qfGtwQ3gbcEoeNG1n8Yr/IXqcOitVSaVmTHdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oPHeJ14O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11595C4CEC2;
	Wed,  4 Sep 2024 04:58:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725425914;
	bh=WHcb9EzuvBLgowDYaNy5EbNrAQVJ55Twf/5kTivsSjU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oPHeJ14OxBR+9GwTsUuPU5o72QTm+7Z9vmZjLP+Ju2fYRvJHLFAqw7q0x9moGOrOU
	 Xhe24R5S83jxOMpTLOCKUzfL6ythgcMVPtdbP9lnq4A+O7CfuiPaa+i3pjrqU6ptjQ
	 22Umch8ThXQDlcwMQAF2eKfHZRK5yrA5cUTiBqk9xhsWp8UsjYtFBkzzmJ0dXhsmwZ
	 Xj67ngPF2xf2lIFhIhN2lPXNfltUHcoqgtuucoLAm0kIdsgqzz/3xM6tWbgQscE84+
	 dPRJetwsWJiSKVkDmHFqXrQa3fyR6xHSJ9T8SlrL8Mg1l8RcaPb9I9bqxEx8qRnOti
	 yUOJL3DQwkxzg==
Date: Wed, 4 Sep 2024 07:55:48 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Christian Brauner <brauner@kernel.org>
Cc: Vlastimil Babka <vbabka@suse.cz>, Jens Axboe <axboe@kernel.dk>,
	Jann Horn <jannh@google.com>,
	Linus Torvalds <torvalds@linux-foundation.org>, linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 04/15] slab: port kmem_cache_create_rcu() to struct
 kmem_cache_args
Message-ID: <ZtfoVBL1fERjdl06@kernel.org>
References: <20240903-work-kmem_cache_args-v2-0-76f97e9a4560@kernel.org>
 <20240903-work-kmem_cache_args-v2-4-76f97e9a4560@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240903-work-kmem_cache_args-v2-4-76f97e9a4560@kernel.org>

On Tue, Sep 03, 2024 at 04:20:45PM +0200, Christian Brauner wrote:
> Port kmem_cache_create_rcu() to struct kmem_cache_args.
> 
> Signed-off-by: Christian Brauner <brauner@kernel.org>

Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

> ---
>  mm/slab_common.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/mm/slab_common.c b/mm/slab_common.c
> index ac0832dac01e..da62ed30f95d 100644
> --- a/mm/slab_common.c
> +++ b/mm/slab_common.c
> @@ -481,9 +481,13 @@ struct kmem_cache *kmem_cache_create_rcu(const char *name, unsigned int size,
>  					 unsigned int freeptr_offset,
>  					 slab_flags_t flags)
>  {
> -	return do_kmem_cache_create_usercopy(name, size, freeptr_offset, 0,
> -					     flags | SLAB_TYPESAFE_BY_RCU, 0, 0,
> -					     NULL);
> +	struct kmem_cache_args kmem_args = {
> +		.freeptr_offset		= freeptr_offset,
> +		.use_freeptr_offset	= true,
> +	};
> +
> +	return __kmem_cache_create_args(name, size, &kmem_args,
> +					flags | SLAB_TYPESAFE_BY_RCU);
>  }
>  EXPORT_SYMBOL(kmem_cache_create_rcu);
>  
> 
> -- 
> 2.45.2
> 

-- 
Sincerely yours,
Mike.

