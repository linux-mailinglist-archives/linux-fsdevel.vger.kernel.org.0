Return-Path: <linux-fsdevel+bounces-24910-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86CF3946773
	for <lists+linux-fsdevel@lfdr.de>; Sat,  3 Aug 2024 06:44:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B44728273C
	for <lists+linux-fsdevel@lfdr.de>; Sat,  3 Aug 2024 04:44:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0F165336D;
	Sat,  3 Aug 2024 04:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="INU3RSq7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54318101D4;
	Sat,  3 Aug 2024 04:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722660265; cv=none; b=Yk7rrpFmla7VTpgq6QQYpUWB41vkflWeYFpCYHN4/7vB8c8aIuSMjtDpl6PkbngrKb5pyqlZexr4SBWI3IORMfAUfJdXo67fstE6zEx1krAtUgixLMlYsb0cJ6nr3lzgoFzNDxLznxkUkK+8wc2LH/TT8zi58ydzlV0v/5pM+b8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722660265; c=relaxed/simple;
	bh=oxHjW/NGG3FqFkJ/RzqDHvMm6gRJSiu0sTkETRFlacw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=onoM9a/wXb01jkv4mi0iiqIS9j2fSnACwO/xUTtTUqsoXbOZC2UZO/cTJA+VSyB3VqaOxLYDcsMEgfoVioxfc5e8zTO5c0EUVCN0j4eBj2CLjlvVbmvYyFqKmPhHgabn6Qi72u/1pL0p81fCkfvWj9PxEYGfyIlSAiDmr1z1UNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=INU3RSq7; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3683f56b9bdso4512571f8f.1;
        Fri, 02 Aug 2024 21:44:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722660261; x=1723265061; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1ICRUvIRcSpRjDV05yUvg8MY83qskWqfaY+XnFnSEMU=;
        b=INU3RSq7riNl8IcgmSaak3DC/Q+lQhgGsEUwqpicElicVizxfZsE4FlcsNz42DrM2+
         EFZh+idZH6BQBjnRFCJOqyt++O4p5PVfv3OquOrU9pyDmPZK9MC1qViLDGQ63InQzBfL
         V5Yz7bHKemNHfJAX2omVJ9mBDZ+4P7LSpPQh0lni95vNHRgJrvEIiESH93xTDkyo9cP1
         cMDuaHmdK5PO4057W6ue2AIBASpnn9/tM3Bbr692Dx/8hfuDOYTgw24qRq3fi54WhJLO
         Ro/T/3Kca7vY9MeN26WvXuPrQAHVs2Gx+PBVtWJ7n2csVJy9RlGhT9LI04rTvbrXDRc2
         mUsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722660261; x=1723265061;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1ICRUvIRcSpRjDV05yUvg8MY83qskWqfaY+XnFnSEMU=;
        b=Uixr78nFdRBoGPq6z7bOuAixq0/jqaB4ZMtK/FGEWG8xU0DCNT7+SiWH4d3zy6sWN5
         DmVbOT3OwWf/3hWWYT2XgRxVTpkTdib+uiNnvWqaBwOB/XzM2lCR6P4gTatDhIYXympZ
         kFMd38F8YDBi43diEHQ1/vW9i3ICPSM38t9GFDwdvAp5C7uco9nuGkB7d6W0M/SVROg+
         7SoO2zYN7qCgHGxl62I9AFTmy3Eo8X+sz1URu9/Z4aE4njz9kzMgihFuOsjOeO5O7Ojm
         YRHiD6Ia37Msz6gj5qHnhk2jqE8ailM4nJzogjyhHilWCbaVfYxdez6F69U8BQwbNWRi
         JBDw==
X-Forwarded-Encrypted: i=1; AJvYcCXF7uC0qNmbMldCGcZWhnigz3SN5boAD00uqK5l8FiP9kqrv6M9N3DACD4WgERsgh+nEQIN8ome+iRSIpPjTjGLopEztpsOd9viG+DiCerbJONNrTibbOY/CwuSdS3Q2ktU2BNqVCr8eH76fg==
X-Gm-Message-State: AOJu0Yw6QLyVS686mG1gdMc9k+WrXs/iw5u4qUH+I71VXmE5lKyzy04H
	/oZCOWfwbriwSjYn2SBUngeqjZKPYYBWqj1a8iHFpvAtYlB4ZAwl
X-Google-Smtp-Source: AGHT+IFzjexPZTqvRksg9lDcuh7zjBlEesoiGpX2Rw0RDHwqQB7xwGBQAn6ofFV9AuM8DNQ+ftddzw==
X-Received: by 2002:a5d:5d86:0:b0:36b:c126:fe6d with SMTP id ffacd0b85a97d-36bc127010cmr2117052f8f.24.1722660261127;
        Fri, 02 Aug 2024 21:44:21 -0700 (PDT)
Received: from f (cst-prg-90-207.cust.vodafone.cz. [46.135.90.207])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36bbd06fbfdsm3323307f8f.106.2024.08.02.21.44.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Aug 2024 21:44:20 -0700 (PDT)
Date: Sat, 3 Aug 2024 06:44:11 +0200
From: Mateusz Guzik <mjguzik@gmail.com>
To: Jeff Layton <jlayton@kernel.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Andrew Morton <akpm@linux-foundation.org>, Josef Bacik <josef@toxicpanda.com>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC 3/4] lockref: rework CMPXCHG_LOOP to handle
 contention better
Message-ID: <r6gyrzb265f5w6sev6he3ctfjjh7wfhktzwxyylwwkeopkzkpj@fo3yp2lkgp7l>
References: <20240802-openfast-v1-0-a1cff2a33063@kernel.org>
 <20240802-openfast-v1-3-a1cff2a33063@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240802-openfast-v1-3-a1cff2a33063@kernel.org>

On Fri, Aug 02, 2024 at 05:45:04PM -0400, Jeff Layton wrote:
> In a later patch, we want to change the open(..., O_CREAT) codepath to
> avoid taking the inode->i_rwsem for write when the dentry already exists.
> When we tested that initially, the performance devolved significantly
> due to contention for the parent's d_lockref spinlock.
> 
> There are two problems with lockrefs today: First, once any concurrent
> task takes the spinlock, they all end up taking the spinlock, which is
> much more costly than a single cmpxchg operation. The second problem is
> that once any task fails to cmpxchg 100 times, it falls back to the
> spinlock. The upshot there is that even moderate contention can cause a
> fallback to serialized spinlocking, which worsens performance.
> 
> This patch changes CMPXCHG_LOOP in 2 ways:
> 
> First, change the loop to spin instead of falling back to a locked
> codepath when the spinlock is held. Once the lock is released, allow the
> task to continue trying its cmpxchg loop as before instead of taking the
> lock. Second, don't allow the cmpxchg loop to give up after 100 retries.
> Just continue infinitely.
> 
> This greatly reduces contention on the lockref when there are large
> numbers of concurrent increments and decrements occurring.
> 

This was already tried by me and it unfortunately can reduce performance.

Key problem is that in some corner cases the lock can be continuously
held and be queued on, making the fast path always fail and making all
the spins actively waste time (and notably pull on the cacheline).

See this for more details:
https://lore.kernel.org/oe-lkp/lv7ykdnn2nrci3orajf7ev64afxqdw2d65bcpu2mfaqbkvv4ke@hzxat7utjnvx/

However, I *suspect* in the case you are optimizing here (open + O_CREAT
of an existing file) lockref on the parent can be avoided altogether
with some hackery and that's what should be done here.

When it comes to lockref in vfs in general, most uses can be elided with
some hackery (see the above thread) which is in early WIP (the LSMs are
a massive headache).

For open calls which *do* need to take a real ref the hackery does not
help of course.

This is where I think decoupling ref from the lock is the best way
forward. For that to work the dentry must hang around after the last
unref (already done thanks to RCU and dput even explicitly handles that
already!) and there needs to be a way to block new refs atomically --
can be done with cmpxchg from a 0-ref state to a flag blocking new refs
coming in. I have that as a WIP as well.


> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>  lib/lockref.c | 85 ++++++++++++++++++++++-------------------------------------
>  1 file changed, 32 insertions(+), 53 deletions(-)
> 
> diff --git a/lib/lockref.c b/lib/lockref.c
> index 2afe4c5d8919..b76941043fe9 100644
> --- a/lib/lockref.c
> +++ b/lib/lockref.c
> @@ -8,22 +8,25 @@
>   * Note that the "cmpxchg()" reloads the "old" value for the
>   * failure case.
>   */
> -#define CMPXCHG_LOOP(CODE, SUCCESS) do {					\
> -	int retry = 100;							\
> -	struct lockref old;							\
> -	BUILD_BUG_ON(sizeof(old) != 8);						\
> -	old.lock_count = READ_ONCE(lockref->lock_count);			\
> -	while (likely(arch_spin_value_unlocked(old.lock.rlock.raw_lock))) {  	\
> -		struct lockref new = old;					\
> -		CODE								\
> -		if (likely(try_cmpxchg64_relaxed(&lockref->lock_count,		\
> -						 &old.lock_count,		\
> -						 new.lock_count))) {		\
> -			SUCCESS;						\
> -		}								\
> -		if (!--retry)							\
> -			break;							\
> -	}									\
> +#define CMPXCHG_LOOP(CODE, SUCCESS) do {						\
> +	struct lockref old;								\
> +	BUILD_BUG_ON(sizeof(old) != 8);							\
> +	old.lock_count = READ_ONCE(lockref->lock_count);				\
> +	for (;;) {									\
> +		struct lockref new = old;						\
> +											\
> +		if (likely(arch_spin_value_unlocked(old.lock.rlock.raw_lock))) {	\
> +			CODE								\
> +			if (likely(try_cmpxchg64_relaxed(&lockref->lock_count,		\
> +							 &old.lock_count,		\
> +							 new.lock_count))) {		\
> +				SUCCESS;						\
> +			}								\
> +		} else {								\
> +			cpu_relax();							\
> +			old.lock_count = READ_ONCE(lockref->lock_count);		\
> +		}									\
> +	}										\
>  } while (0)
>  
>  #else
> @@ -46,10 +49,8 @@ void lockref_get(struct lockref *lockref)
>  	,
>  		return;
>  	);
> -
> -	spin_lock(&lockref->lock);
> -	lockref->count++;
> -	spin_unlock(&lockref->lock);
> +	/* should never get here */
> +	WARN_ON_ONCE(1);
>  }
>  EXPORT_SYMBOL(lockref_get);
>  
> @@ -60,8 +61,6 @@ EXPORT_SYMBOL(lockref_get);
>   */
>  int lockref_get_not_zero(struct lockref *lockref)
>  {
> -	int retval;
> -
>  	CMPXCHG_LOOP(
>  		new.count++;
>  		if (old.count <= 0)
> @@ -69,15 +68,9 @@ int lockref_get_not_zero(struct lockref *lockref)
>  	,
>  		return 1;
>  	);
> -
> -	spin_lock(&lockref->lock);
> -	retval = 0;
> -	if (lockref->count > 0) {
> -		lockref->count++;
> -		retval = 1;
> -	}
> -	spin_unlock(&lockref->lock);
> -	return retval;
> +	/* should never get here */
> +	WARN_ON_ONCE(1);
> +	return -1;
>  }
>  EXPORT_SYMBOL(lockref_get_not_zero);
>  
> @@ -88,8 +81,6 @@ EXPORT_SYMBOL(lockref_get_not_zero);
>   */
>  int lockref_put_not_zero(struct lockref *lockref)
>  {
> -	int retval;
> -
>  	CMPXCHG_LOOP(
>  		new.count--;
>  		if (old.count <= 1)
> @@ -97,15 +88,9 @@ int lockref_put_not_zero(struct lockref *lockref)
>  	,
>  		return 1;
>  	);
> -
> -	spin_lock(&lockref->lock);
> -	retval = 0;
> -	if (lockref->count > 1) {
> -		lockref->count--;
> -		retval = 1;
> -	}
> -	spin_unlock(&lockref->lock);
> -	return retval;
> +	/* should never get here */
> +	WARN_ON_ONCE(1);
> +	return -1;
>  }
>  EXPORT_SYMBOL(lockref_put_not_zero);
>  
> @@ -125,6 +110,8 @@ int lockref_put_return(struct lockref *lockref)
>  	,
>  		return new.count;
>  	);
> +	/* should never get here */
> +	WARN_ON_ONCE(1);
>  	return -1;
>  }
>  EXPORT_SYMBOL(lockref_put_return);
> @@ -171,8 +158,6 @@ EXPORT_SYMBOL(lockref_mark_dead);
>   */
>  int lockref_get_not_dead(struct lockref *lockref)
>  {
> -	int retval;
> -
>  	CMPXCHG_LOOP(
>  		new.count++;
>  		if (old.count < 0)
> @@ -180,14 +165,8 @@ int lockref_get_not_dead(struct lockref *lockref)
>  	,
>  		return 1;
>  	);
> -
> -	spin_lock(&lockref->lock);
> -	retval = 0;
> -	if (lockref->count >= 0) {
> -		lockref->count++;
> -		retval = 1;
> -	}
> -	spin_unlock(&lockref->lock);
> -	return retval;
> +	/* should never get here */
> +	WARN_ON_ONCE(1);
> +	return -1;
>  }
>  EXPORT_SYMBOL(lockref_get_not_dead);
> 
> -- 
> 2.45.2
> 

