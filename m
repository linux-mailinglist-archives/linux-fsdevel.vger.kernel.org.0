Return-Path: <linux-fsdevel+bounces-45262-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AEC12A7553A
	for <lists+linux-fsdevel@lfdr.de>; Sat, 29 Mar 2025 09:47:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5391E3B08D7
	for <lists+linux-fsdevel@lfdr.de>; Sat, 29 Mar 2025 08:46:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18CE719006F;
	Sat, 29 Mar 2025 08:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GVCpCfSa"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76DC0440C;
	Sat, 29 Mar 2025 08:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743238021; cv=none; b=sLEJzAAcDP6BrU6yTmuCW4n9bkzxwl+RPV2P9BPyAxup06RApIrq1yx8cIiNiuGa7KlTFjDh082uNZ0tFGUGB8WPN0zYBaIe+TIWzl6epBoE+tGGd3ODzm72wjF+AWBOSDaT/LHN9lLqZ67Skq6afd//YRwXKTCxhInN4IqF1V8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743238021; c=relaxed/simple;
	bh=o63oO3H6a4iLbXjldUgL5HZ/mW/dfiOJ6BfjX1DMWe4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XkBoDYPWWQjO5AiuxcCkXATTb/Jhi+tdcwJZKdLXaCVtpaw+pdZdu0VmeWrRCJzIgrHz4qvqcFIqFGRTZVyMNys0+/86pe5C57TYuwP++XTvko7rdzOvVXnecxWh392uQN84AXIl+2qpSfsNFUa87myTPllhU42vrH5+qmU7IxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GVCpCfSa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2464C4CEE2;
	Sat, 29 Mar 2025 08:46:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743238021;
	bh=o63oO3H6a4iLbXjldUgL5HZ/mW/dfiOJ6BfjX1DMWe4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GVCpCfSacXTOXE/YI5xLq8i/U4zc1ItATsvRtUqtjxewNDR7PyhQ9bTbSIKG0xrbI
	 mvlN03bh3/M107SQ9RIHexBFKg+/EE/3yKCuMgnALHX6Eu9v6bJe0iW+LEdhE+y0kB
	 8Rh3ODMnxA//UE/9oxfHLFHKjWan2eOtMzow3busQgl9O6mNkDHQDbMwvqIaFsZM7I
	 ioI8zoFRhVwcZSuPTGgQcbP1AUzevcV8eAT/JNbgtzcr8j9nVHtzo90sslumOTF0uw
	 oAEriIE6BHfo27jwLD1MenmBoH/b2n3znO9PWocnqZKClVgK1+7iFMlC/GYqHoXOVP
	 xxjbd6HjKD8tQ==
Date: Sat, 29 Mar 2025 09:46:55 +0100
From: Christian Brauner <brauner@kernel.org>
To: linux-fsdevel@vger.kernel.org, jack@suse.cz
Cc: linux-kernel@vger.kernel.org, 
	James Bottomley <James.Bottomley@hansenpartnership.com>, mcgrof@kernel.org, hch@infradead.org, david@fromorbit.com, 
	rafael@kernel.org, djwong@kernel.org, pavel@kernel.org, peterz@infradead.org, 
	mingo@redhat.com, will@kernel.org, boqun.feng@gmail.com
Subject: Re: [PATCH v2 6/6] super: add filesystem freezing helpers for
 suspend and hibernate
Message-ID: <20250329-ungeduldig-umgezogen-615a0f997e2b@brauner>
References: <20250329-work-freeze-v2-0-a47af37ecc3d@kernel.org>
 <20250329-work-freeze-v2-6-a47af37ecc3d@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250329-work-freeze-v2-6-a47af37ecc3d@kernel.org>

On Sat, Mar 29, 2025 at 09:42:19AM +0100, Christian Brauner wrote:
> Allow the power subsystem to support filesystem freeze for
> suspend and hibernate.
> 
> Signed-off-by: Christian Brauner <brauner@kernel.org>
> ---
>  fs/super.c         | 55 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/fs.h |  2 ++
>  2 files changed, 57 insertions(+)
> 
> diff --git a/fs/super.c b/fs/super.c
> index 666a2a16df87..4364b763e91f 100644
> --- a/fs/super.c
> +++ b/fs/super.c
> @@ -1176,6 +1176,61 @@ void emergency_thaw_all(void)
>  	}
>  }
>  
> +static inline bool get_active_super(struct super_block *sb)
> +{
> +	bool active;

Typo on my end. This is ofc bool active = false;
And fixed.

> +
> +	if (super_lock_excl(sb)) {
> +		active = atomic_inc_not_zero(&sb->s_active);
> +		super_unlock_excl(sb);
> +	}
> +	return active;
> +}
> +
> +static void filesystems_freeze_callback(struct super_block *sb, void *unused)
> +{
> +	if (!sb->s_op->freeze_fs && !sb->s_op->freeze_super)
> +		return;
> +
> +	if (!get_active_super(sb))
> +		return;
> +
> +	if (sb->s_op->freeze_super)
> +		sb->s_op->freeze_super(sb, FREEZE_MAY_NEST | FREEZE_HOLDER_KERNEL);
> +	else
> +		freeze_super(sb, FREEZE_MAY_NEST | FREEZE_HOLDER_KERNEL);
> +
> +	deactivate_super(sb);
> +}
> +
> +void filesystems_freeze(bool hibernate)
> +{
> +	__iterate_supers(filesystems_freeze_callback, NULL,
> +			 SUPER_ITER_UNLOCKED | SUPER_ITER_REVERSE);
> +}
> +
> +static void filesystems_thaw_callback(struct super_block *sb, void *unused)
> +{
> +	if (!sb->s_op->freeze_fs && !sb->s_op->freeze_super)
> +		return;
> +
> +	if (!get_active_super(sb))
> +		return;
> +
> +	if (sb->s_op->thaw_super)
> +		sb->s_op->thaw_super(sb, FREEZE_MAY_NEST | FREEZE_HOLDER_KERNEL);
> +	else
> +		thaw_super(sb, FREEZE_MAY_NEST | FREEZE_HOLDER_KERNEL);
> +
> +	deactivate_super(sb);
> +}
> +
> +void filesystems_thaw(bool hibernate)
> +{
> +	__iterate_supers(filesystems_thaw_callback, NULL,
> +			 SUPER_ITER_UNLOCKED | SUPER_ITER_REVERSE);
> +}
> +
>  static DEFINE_IDA(unnamed_dev_ida);
>  
>  /**
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index c475fa874055..29bd28491eff 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -3518,6 +3518,8 @@ extern void drop_super_exclusive(struct super_block *sb);
>  extern void iterate_supers(void (*f)(struct super_block *, void *), void *arg);
>  extern void iterate_supers_type(struct file_system_type *,
>  			        void (*)(struct super_block *, void *), void *);
> +void filesystems_freeze(bool hibernate);
> +void filesystems_thaw(bool hibernate);
>  
>  extern int dcache_dir_open(struct inode *, struct file *);
>  extern int dcache_dir_close(struct inode *, struct file *);
> 
> -- 
> 2.47.2
> 

