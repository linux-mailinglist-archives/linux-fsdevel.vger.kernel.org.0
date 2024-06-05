Return-Path: <linux-fsdevel+bounces-21050-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08C758FD180
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Jun 2024 17:22:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91A6B28162D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Jun 2024 15:21:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE75218F2D5;
	Wed,  5 Jun 2024 15:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZUEEVJxl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 158CE61FF3;
	Wed,  5 Jun 2024 15:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717600827; cv=none; b=YmzgjC1fE5mqvwDJnFx3GLQgIunBuhzJ/6pM+R4xNyPiTXnTzjqA7yi2W5ZaiqWPmNeGI0kBgMCm2vj2KnsOkaNXUOuQDMtw0mscvRhpcsfFazG/5YAsdzek5zNrpvy1PjM8mmTWsRGTeVSacdogxkrNBg0StEDW4qHdyzHaPPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717600827; c=relaxed/simple;
	bh=kLFvvFXxCp6uMBhhZVSLA1pq3N21yC6KX4ZzJiuU3Zg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bfo2+GAWy1JHBTYUP/ubeBks6rHagmDImJg4jpQJPdSUNZt8mhJtx6vOZlQvh0OtIVxKBMfHqf3/yDiymgih06IrRZm+J2o4owN01emBprjt8yC54leD/VtXk3FLuVqOc75y6EtwWMj+0nTgeu9hgEykM1GhXTWFxhD1HCwtDLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZUEEVJxl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C664DC32781;
	Wed,  5 Jun 2024 15:20:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717600824;
	bh=kLFvvFXxCp6uMBhhZVSLA1pq3N21yC6KX4ZzJiuU3Zg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZUEEVJxlx1qQCYLnpV6duFKUiYFKI4Q3Vn6QnpvrcD0+Y9hkti1TPx/QMaLtYcHsa
	 DeevvGQ3Hi6leIRR4Pz6iq6+kewaiOeMdWl+hxmD8LcV6QG89X/a3KgU0ut/sidyWa
	 x5JwQXlOfDj7WKONzqFz4UqvnPcMW60f+DM04R2Ow1AZGN8B5GanMYJJc0n/Fm3Hb0
	 tfuBeKfZThmQKOITBnSzuw+0jOz6/7Adl+8h0sVprly6mnJfNvdTbL3ZzMRL4RygeT
	 uspFJWD1yF1LUbtg6rvIc/vNLQYICRBgBeVK5VrdApVdJJpPLyCeB5iVaGGfhelIUr
	 9Fg4LYRmnr/+Q==
Date: Wed, 5 Jun 2024 17:20:19 +0200
From: Christian Brauner <brauner@kernel.org>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: viro@zeniv.linux.org.uk, jack@suse.cz, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, axboe@kernel.dk, daclash@linux.microsoft.com
Subject: Re: [HACK PATCH] fs: dodge atomic in putname if ref == 1
Message-ID: <20240605-zeitraffer-fachzeitschrift-e74730507b59@brauner>
References: <20240604132448.101183-1-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240604132448.101183-1-mjguzik@gmail.com>

On Tue, Jun 04, 2024 at 03:24:48PM +0200, Mateusz Guzik wrote:
> The struct used to be refcounted with regular inc/dec ops, atomic usage
> showed up in commit 03adc61edad4 ("audit,io_uring: io_uring openat
> triggers audit reference count underflow").
> 
> If putname spots a count of 1 there is no legitimate way of anyone to
> bump it and these modifications are low traffic (names are not heavily)
> shared, thus one can do a load first and if the value of 1 is found the
> atomic can be elided -- this is the last reference..
> 
> When performing a failed open this reduces putname on the profile from
> ~1.60% to ~0.2% and bumps the syscall rate by just shy of 1% (the
> discrepancy is due to now bigger stalls elsewhere).

I suspect you haven't turned audit on in general because that would give
you performance impact in a bunch of places. Can't we just do something
where we e.g., use plain refcounts if audit isn't turned on?
(audit_dummy_context() or whatever it's called).

> 
> Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
> ---
> 
> This is a lazy hack.
> 
> The race is only possible with io_uring which has a dedicated entry
> point, thus a getname variant which takes it into account could store
> the need to use atomics as a flag in struct filename. To that end
> getname could take a boolean indicating this, fronted with some inlines
> and the current entry point renamed to __getname_flags to hide it.
> 
> Option B is to add a routine which "upgrades" to atomics after getname
> returns, but that's a littly fishy vs audit_reusename.
> 
> At the end of the day all spots which modify the ref could branch on the
> atomics flag.
> 
> I opted to not do it since the hack below undoes the problem for me.
> 
> I'm not going to fight for this hack though, it is merely a placeholder
> until someone(tm) fixes things.
> 
> If the hack is considered a no-go and the appraoch described above is
> considered fine, I can submit a patch some time this month to sort it
> out, provided someone tells me how to name a routine which grabs a ref
> -- the op is currently opencoded and "getname" allocates instead of
> merely refing. would "refname" do it?
> 
>  fs/namei.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/namei.c b/fs/namei.c
> index 37fb0a8aa09a..f9440bdb21d0 100644
> --- a/fs/namei.c
> +++ b/fs/namei.c
> @@ -260,11 +260,13 @@ void putname(struct filename *name)
>  	if (IS_ERR(name))
>  		return;
>  
> -	if (WARN_ON_ONCE(!atomic_read(&name->refcnt)))
> -		return;
> +	if (unlikely(atomic_read(&name->refcnt) != 1)) {
> +		if (WARN_ON_ONCE(!atomic_read(&name->refcnt)))
> +			return;
>  
> -	if (!atomic_dec_and_test(&name->refcnt))
> -		return;
> +		if (!atomic_dec_and_test(&name->refcnt))
> +			return;
> +	}
>  
>  	if (name->name != name->iname) {
>  		__putname(name->name);
> -- 
> 2.39.2
> 

