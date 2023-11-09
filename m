Return-Path: <linux-fsdevel+bounces-2526-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9C747E6CAD
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Nov 2023 15:54:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DACA21C20314
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Nov 2023 14:54:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11EF11DDD3;
	Thu,  9 Nov 2023 14:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fjA1Mhds"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53D6A1D522
	for <linux-fsdevel@vger.kernel.org>; Thu,  9 Nov 2023 14:54:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DC67C433C7;
	Thu,  9 Nov 2023 14:54:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699541678;
	bh=mfWHThLJ350mdRMESa2Hjvev8DXWqdeVctWQlOfbDbA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fjA1Mhds+/LSxsVsYI05MORS7SePcLhXo7Zil4er9i2Tu6vHqi94akP9j+bVYOhPO
	 +iFAilmB5R9+mQvDffs9pQrrFr/PoihCGJscp0M8zYCDYrI36Lwqnnd7ORUz/3b7JN
	 dfHPeqgOutkLH59Uu0b8omcj538nqDcXJsOAXRDrb3Kv5mZyXGikTqXpaR1wkXCGfF
	 0s5mbBhmN9nno6jNn3S4XJrfYZD9UNTFx3rp6+tlRFg2vODrBFQIp4cHgm8EiiQRlM
	 Cgg+hkn2goRM1qSC17aNhAzdLZxzVverLfWEQtPGidnwkjZnDKK7Gqy+TELMfsfcb1
	 zrj83SvVEzUew==
Date: Thu, 9 Nov 2023 15:54:34 +0100
From: Christian Brauner <brauner@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 10/22] fast_dput(): new rules for refcount
Message-ID: <20231109-aufwiegen-triest-8a95b1a96b40@brauner>
References: <20231109061932.GA3181489@ZenIV>
 <20231109062056.3181775-1-viro@zeniv.linux.org.uk>
 <20231109062056.3181775-10-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231109062056.3181775-10-viro@zeniv.linux.org.uk>

On Thu, Nov 09, 2023 at 06:20:44AM +0000, Al Viro wrote:
> Currently the "need caller to do more work" path in fast_dput()
> has refcount decremented, then, with ->d_lock held and
> refcount verified to have reached 0 fast_dput() forcibly resets
> the refcount to 1.
> 
> Move that resetting refcount to 1 into the callers; later in
> the series it will be massaged out of existence.
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---

Ok, this is safe to do because of

[PATCH 09/22] fast_dput(): handle underflows gracefully
https://lore.kernel.org/linux-fsdevel/20231109062056.3181775-9-viro@zeniv.linux.org.uk

as return false from fast_dput() now always means refcount is zero.

Reviewed-by: Christian Brauner <brauner@kernel.org>

>  fs/dcache.c | 9 ++-------
>  1 file changed, 2 insertions(+), 7 deletions(-)
> 
> diff --git a/fs/dcache.c b/fs/dcache.c
> index e02b3c81bc02..9a3eeee02500 100644
> --- a/fs/dcache.c
> +++ b/fs/dcache.c
> @@ -847,13 +847,6 @@ static inline bool fast_dput(struct dentry *dentry)
>  		spin_unlock(&dentry->d_lock);
>  		return true;
>  	}
> -
> -	/*
> -	 * Re-get the reference we optimistically dropped. We hold the
> -	 * lock, and we just tested that it was zero, so we can just
> -	 * set it to 1.
> -	 */
> -	dentry->d_lockref.count = 1;
>  	return false;
>  }
>  
> @@ -896,6 +889,7 @@ void dput(struct dentry *dentry)
>  		}
>  
>  		/* Slow case: now with the dentry lock held */
> +		dentry->d_lockref.count = 1;
>  		rcu_read_unlock();
>  
>  		if (likely(retain_dentry(dentry))) {
> @@ -930,6 +924,7 @@ void dput_to_list(struct dentry *dentry, struct list_head *list)
>  		return;
>  	}
>  	rcu_read_unlock();
> +	dentry->d_lockref.count = 1;
>  	if (!retain_dentry(dentry))
>  		__dput_to_list(dentry, list);
>  	spin_unlock(&dentry->d_lock);
> -- 
> 2.39.2
> 

