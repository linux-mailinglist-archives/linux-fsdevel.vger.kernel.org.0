Return-Path: <linux-fsdevel+bounces-51342-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 24F63AD5C17
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Jun 2025 18:26:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1F663A6789
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Jun 2025 16:26:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E4B91EE035;
	Wed, 11 Jun 2025 16:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D7/DJ0Hq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 080321E5B7E;
	Wed, 11 Jun 2025 16:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749659191; cv=none; b=GNRAosWMB5CCxwiTkTqEr4pozB2X8IV0le5GfDAqRLEH0EpWbDKGP3hIlZVCxvqBXY4uXX+CTlkUmqtGXJ/IjrOTMqjLr4AVm1/YKb7l5ehSOptcd/rKr5G6ApDLGajonhipuirtJjW8hLX1McPF/4VRdDo/Du4irSlerPr+NDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749659191; c=relaxed/simple;
	bh=rA8dODhAt/uUC//Z3tuOg3Vt6MfeVRuex9l8SlI4yIQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pFEjTFSJdBB5q3Xzn8+/npQKWSHt/2roFAl7D/bM0QqQs00MoAEsyi/xagLC1lhH0+0+pGe8paYRsWQGifc4r5bZxPRmqFmywwBNcEuZ/7SzCpVDYgDU6/h+2oy2s+21hAnwVajuMd+ZikZfC1hQ9x6tnOBTjWgV9tm+Y3pO5dE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D7/DJ0Hq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 793F9C4CEE3;
	Wed, 11 Jun 2025 16:26:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749659190;
	bh=rA8dODhAt/uUC//Z3tuOg3Vt6MfeVRuex9l8SlI4yIQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=D7/DJ0Hq6F1ARg3g8k56lIyy4ONTSOIVEmNeNnBcwwMiwOSVa7fxs+tZj1jSG48HF
	 A/xxuV67mjvHZsbVXpaNKFYVAUdpYhqg/OF1psmvRaRiYJ6wLXlLcw5+WIRC8GVIMp
	 qSqtpTeCcK+/PIuhaQmn5+tV02F8RfFG8SYaeWRN/1IOFNK3SdRqLMs9akb1PU/vIl
	 wyWjz6GNh+ea8xV8h+hY5r+pj20Jn0+b3O4oINNGF1nZy2o5acgalu18Hk65mPElpn
	 rk1CUImWLHEWT1sVBM9uM3tBtQDV4FlEYRzE4Y+vNrltYvbLMIo7Sxir6dYUSBmnIu
	 AvYtms3sRoeFQ==
Date: Wed, 11 Jun 2025 09:26:29 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, jack@suse.cz,
	linux-kernel@vger.kernel.org,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	mcgrof@kernel.org, hch@infradead.org, david@fromorbit.com,
	rafael@kernel.org, pavel@kernel.org, peterz@infradead.org,
	mingo@redhat.com, will@kernel.org, boqun.feng@gmail.com
Subject: Re: [PATCH v2 1/6] super: remove pointless s_root checks
Message-ID: <20250611162629.GE6138@frogsfrogsfrogs>
References: <20250329-work-freeze-v2-0-a47af37ecc3d@kernel.org>
 <20250329-work-freeze-v2-1-a47af37ecc3d@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250329-work-freeze-v2-1-a47af37ecc3d@kernel.org>

On Sat, Mar 29, 2025 at 09:42:14AM +0100, Christian Brauner wrote:
> The locking guarantees that the superblock is alive and sb->s_root is
> still set. Remove the pointless check.
> 
> Signed-off-by: Christian Brauner <brauner@kernel.org>
> ---
>  fs/super.c | 19 ++++++-------------
>  1 file changed, 6 insertions(+), 13 deletions(-)
> 
> diff --git a/fs/super.c b/fs/super.c
> index 97a17f9d9023..dc14f4bf73a6 100644
> --- a/fs/super.c
> +++ b/fs/super.c
> @@ -930,8 +930,7 @@ void iterate_supers(void (*f)(struct super_block *, void *), void *arg)
>  
>  		locked = super_lock_shared(sb);
>  		if (locked) {
> -			if (sb->s_root)
> -				f(sb, arg);
> +			f(sb, arg);
>  			super_unlock_shared(sb);
>  		}
>  
> @@ -967,11 +966,8 @@ void iterate_supers_type(struct file_system_type *type,
>  		spin_unlock(&sb_lock);
>  
>  		locked = super_lock_shared(sb);
> -		if (locked) {
> -			if (sb->s_root)
> -				f(sb, arg);
> -			super_unlock_shared(sb);
> -		}
> +		if (locked)
> +			f(sb, arg);

Hey Christian,

I might be trying to be the second(?) user of iterate_supers_type[1]. :)

This change removes the call to super_unlock_shared, which means that
iterate_supers_type returns with the super_lock(s) still held.  I'm
guessing that this is a bug and not an intentional change to require the
callback to call super_unlock_shared, right?

--D

[1] https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux.git/commit/?h=health-monitoring&id=3ae9b1d43dcdeaa38e93dc400d1871872ba0e27f

>  
>  		spin_lock(&sb_lock);
>  		if (p)
> @@ -991,18 +987,15 @@ struct super_block *user_get_super(dev_t dev, bool excl)
>  
>  	spin_lock(&sb_lock);
>  	list_for_each_entry(sb, &super_blocks, s_list) {
> -		if (sb->s_dev ==  dev) {
> +		if (sb->s_dev == dev) {
>  			bool locked;
>  
>  			sb->s_count++;
>  			spin_unlock(&sb_lock);
>  			/* still alive? */
>  			locked = super_lock(sb, excl);
> -			if (locked) {
> -				if (sb->s_root)
> -					return sb;
> -				super_unlock(sb, excl);
> -			}
> +			if (locked)
> +				return sb; /* caller will drop */
>  			/* nope, got unmounted */
>  			spin_lock(&sb_lock);
>  			__put_super(sb);
> 
> -- 
> 2.47.2
> 
> 

