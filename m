Return-Path: <linux-fsdevel+bounces-45084-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 01B23A7174A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Mar 2025 14:19:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 32643189D2EF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Mar 2025 13:18:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DEBE1E5721;
	Wed, 26 Mar 2025 13:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VRNgEyT/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4AC42AEF1;
	Wed, 26 Mar 2025 13:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742995072; cv=none; b=cDnpkweMC5ZejCSpCG4AWz6L8ARC+kpc2dFP4uNRWMPut31N+pJvPjnDPjSTiI7tJqGPyKAN9F8PY3fPyyxzrL6wEMAh0sg/u+ac06PGrMXt2jarjLoASARsHlHQjGXwzEXbNgKpbkFX2/LQqgmEeE0xtNf3rh3E1pBmW+oHvvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742995072; c=relaxed/simple;
	bh=u6B+JSQulI0fVNk3PCX4i2VVVJkDWBYCzJOwNDhwteE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XlsZmdqiErKfvC3fXWcJ61PNW73lBB6tV/BKNt9D06lEH7iEKs//eENpfZrwKzU6tmzeAt0cjMB+hYVoEh9P9pfCLpW8X7JPnr6xWwU9f2SvnD8f2mWVrvk/juBIOiaoQM2VBar4G5DKm/IXtveyyXtCvcXo4esnuwJnveHlYKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VRNgEyT/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07CC3C4CEE2;
	Wed, 26 Mar 2025 13:17:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742995072;
	bh=u6B+JSQulI0fVNk3PCX4i2VVVJkDWBYCzJOwNDhwteE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VRNgEyT/fTEoE2t7yZ8ukvU7/kpfRQSd9/j0iM81hlvWxPaWwFMNonL8LjUwz15vr
	 p/7BSumSn1Y92wc15k1iAOXdDFZc1Jyx3NaB61uszjhvjOzOBmp6gHoahcIwqfvV9h
	 4mWFkjJMCX3eHkh7W12n9/JpnbWy1Dk3TZ1Qq43254JOhQoAsX1xJSriV/nXP2FwSz
	 pjoT4xtED5VRDTq5T1PyuLjN6PJCeKz1nS4iFdgdf/4tuBunMt7EOwqXLqZULgwnl7
	 jcQ+ucFPN8CYURypp/LTOf+5GnhChW7D1JI9GPw3GmHGJsN8g//fn9JuBKrgWDqDpW
	 /081VST8404uQ==
Date: Wed, 26 Mar 2025 14:17:49 +0100
From: Christian Brauner <brauner@kernel.org>
To: Luis Chamberlain <mcgrof@kernel.org>
Cc: jack@suse.cz, hch@infradead.org, James.Bottomley@hansenpartnership.com, 
	david@fromorbit.com, rafael@kernel.org, djwong@kernel.org, pavel@kernel.org, 
	song@kernel.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	gost.dev@samsung.com
Subject: Re: [RFC 2/6] fs: add iterate_supers_excl() and
 iterate_supers_reverse_excl()
Message-ID: <20250326-abzeichen-charmant-ccd775ddcaea@brauner>
References: <20250326112220.1988619-1-mcgrof@kernel.org>
 <20250326112220.1988619-3-mcgrof@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250326112220.1988619-3-mcgrof@kernel.org>

On Wed, Mar 26, 2025 at 04:22:16AM -0700, Luis Chamberlain wrote:
> There are use cases where we wish to traverse the superblock list
> but also capture errors, and in which case we want to avoid having
> our callers issue a lock themselves since we can do the locking for
> the callers. Provide a iterate_supers_excl() which calls a function
> with the write lock held. If an error occurs we capture it and
> propagate it.
> 
> Likewise there are use cases where we wish to traverse the superblock
> list but in reverse order. The new iterate_supers_reverse_excl() helpers
> does this but also also captures any errors encountered.
> 
> Reviewed-by: Jan Kara <jack@suse.cz>
> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
> ---
>  fs/super.c         | 91 ++++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/fs.h |  2 +
>  2 files changed, 93 insertions(+)
> 
> diff --git a/fs/super.c b/fs/super.c
> index 117bd1bfe09f..9995546cf159 100644
> --- a/fs/super.c
> +++ b/fs/super.c
> @@ -945,6 +945,97 @@ void iterate_supers(void (*f)(struct super_block *, void *), void *arg)
>  	spin_unlock(&sb_lock);
>  }
>  
> +/**
> + *	iterate_supers_excl - exclusively call func for all active superblocks
> + *	@f: function to call
> + *	@arg: argument to pass to it
> + *
> + *	Scans the superblock list and calls given function, passing it
> + *	locked superblock and given argument. Returns 0 unless an error
> + *	occurred on calling the function on any superblock.
> + */
> +int iterate_supers_excl(int (*f)(struct super_block *, void *), void *arg)
> +{
> +	struct super_block *sb, *p = NULL;
> +	int error = 0;
> +
> +	spin_lock(&sb_lock);
> +	list_for_each_entry(sb, &super_blocks, s_list) {
> +		if (hlist_unhashed(&sb->s_instances))
> +			continue;
> +		sb->s_count++;
> +		spin_unlock(&sb_lock);
> +
> +		down_write(&sb->s_umount);
> +		if (sb->s_root && (sb->s_flags & SB_BORN)) {
> +			error = f(sb, arg);
> +			if (error) {
> +				up_write(&sb->s_umount);
> +				spin_lock(&sb_lock);
> +				__put_super(sb);
> +				break;
> +			}
> +		}
> +		up_write(&sb->s_umount);

This is wrong. Both the reverse and the regular iterator need to wait
for the superblock to be born or die:

void iterate_supers_excl(void (*f)(struct super_block *, void *), void *arg)
{
	struct super_block *sb, *p = NULL;

	spin_lock(&sb_lock);
	list_for_each_entry{_reverse}(sb, &super_blocks, s_list) {
		bool locked;

		sb->s_count++;
		spin_unlock(&sb_lock);

		locked = super_lock(sb);
		if (locked) {
			if (sb->s_root)
				f(sb, arg);
			super_unlock(sb);
		}

		spin_lock(&sb_lock);
		if (p)
			__put_super(p);
		p = sb;
	}
	if (p)
		__put_super(p);
	spin_unlock(&sb_lock);
}

> +
> +		spin_lock(&sb_lock);
> +		if (p)
> +			__put_super(p);
> +		p = sb;
> +	}
> +	if (p)
> +		__put_super(p);
> +	spin_unlock(&sb_lock);
> +
> +	return error;
> +}
> +
> +/**
> + *	iterate_supers_reverse_excl - exclusively calls func in reverse order
> + *	@f: function to call
> + *	@arg: argument to pass to it
> + *
> + *	Scans the superblock list and calls given function, passing it
> + *	locked superblock and given argument, in reverse order, and holding
> + *	the s_umount write lock. Returns if an error occurred.
> + */
> +int iterate_supers_reverse_excl(int (*f)(struct super_block *, void *),
> +					 void *arg)
> +{
> +	struct super_block *sb, *p = NULL;
> +	int error = 0;
> +
> +	spin_lock(&sb_lock);
> +	list_for_each_entry_reverse(sb, &super_blocks, s_list) {
> +		if (hlist_unhashed(&sb->s_instances))
> +			continue;
> +		sb->s_count++;
> +		spin_unlock(&sb_lock);
> +
> +		down_write(&sb->s_umount);
> +		if (sb->s_root && (sb->s_flags & SB_BORN)) {
> +			error = f(sb, arg);
> +			if (error) {
> +				up_write(&sb->s_umount);
> +				spin_lock(&sb_lock);
> +				__put_super(sb);
> +				break;
> +			}
> +		}
> +		up_write(&sb->s_umount);
> +
> +		spin_lock(&sb_lock);
> +		if (p)
> +			__put_super(p);
> +		p = sb;
> +	}
> +	if (p)
> +		__put_super(p);
> +	spin_unlock(&sb_lock);
> +
> +	return error;
> +}
> +
>  /**
>   *	iterate_supers_type - call function for superblocks of given type
>   *	@type: fs type
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index 1d9a9c557e1a..da17fd74961c 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -3538,6 +3538,8 @@ extern struct file_system_type *get_fs_type(const char *name);
>  extern void drop_super(struct super_block *sb);
>  extern void drop_super_exclusive(struct super_block *sb);
>  extern void iterate_supers(void (*)(struct super_block *, void *), void *);
> +extern int iterate_supers_excl(int (*f)(struct super_block *, void *), void *arg);
> +extern int iterate_supers_reverse_excl(int (*)(struct super_block *, void *), void *);
>  extern void iterate_supers_type(struct file_system_type *,
>  			        void (*)(struct super_block *, void *), void *);
>  
> -- 
> 2.47.2
> 

