Return-Path: <linux-fsdevel+bounces-54012-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 80EABAFA071
	for <lists+linux-fsdevel@lfdr.de>; Sat,  5 Jul 2025 16:22:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DAEF15631C3
	for <lists+linux-fsdevel@lfdr.de>; Sat,  5 Jul 2025 14:22:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB6BD1C5F14;
	Sat,  5 Jul 2025 14:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="BFh5yelu";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="GKZkG0WD";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="VaDbk7Ag";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="AeEJV4mK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97C711CFBA
	for <linux-fsdevel@vger.kernel.org>; Sat,  5 Jul 2025 14:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751725356; cv=none; b=fo8GtJFXPCpg385FTw7828HKZ8ePCDWdM89Q1Xink96qaFZ3q61Dk89rpm8h9XQAIRD4KqagiBtcs7GAnsinPtiijOXQRPoIjxobvK2Ta1JNwPO8yuSTqwv4WrYUnCrouPQfwg8/5bGoFpwqTEkHjqRijejzlVbRrKtMnPGVPa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751725356; c=relaxed/simple;
	bh=6CewbhSS+JexZixu3HuQD6G9PxNyWzWn++L5Z+bOUew=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R/n6F6l45ODa/jzOaMikW8koLcl08gWfUePuNKuN5U25lBaMGM5o46NiTObrNxFXDwDBqLmzusNx9y7V0ZMoqK0dLgltN0gbU9CCPrU/okKJ4uKIJCex4/ldM8hpgRNNx58Q7DCw5SHJB2vYDh2ErYsIqxzjT5QPF/WuPH2Dwcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=BFh5yelu; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=GKZkG0WD; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=VaDbk7Ag; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=AeEJV4mK; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 998D81F798;
	Sat,  5 Jul 2025 14:22:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1751725352;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NxucWLiaNbw9usA42d/nN1Wy9b4fZMmPPheshHd9sA8=;
	b=BFh5yelufY405JA+OJmJ6/XG1EeWc4aaBFGrkGKjYVSQguoZuQXu7g9+enZ5nCecKolYaV
	tNCG38iyywsqppPMAvfXhRSTKcexh/XRDTkxIOk4lrwg7woPUo5T8y+afGuAG8ePcM2xPm
	TG1+tKwRhyXQc566UBRw+DhEjGXFZkk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1751725352;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NxucWLiaNbw9usA42d/nN1Wy9b4fZMmPPheshHd9sA8=;
	b=GKZkG0WD7CxgnGMURxJxO8RGPw3kkvEBhLZHEecxJ67nFT82QAFh2UdnLjZ5e8jo+2g++T
	2xJKMBoNBs05sPCQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1751725351;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NxucWLiaNbw9usA42d/nN1Wy9b4fZMmPPheshHd9sA8=;
	b=VaDbk7Aghn3sjSSvNFEcYhBQ0e5uHKnM5F38srOtwwzpRlNfyIKL0xX6KB6VWl8i7RUKQo
	C6ks/KXKJxzItew7GINuLe7n/fw8xF18fTuqtR3qyer3ur75WHDUh1vbC5BHOkuPM7znO9
	/YQjh+XCjPTALKO5GNIDIlepronE1kw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1751725351;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NxucWLiaNbw9usA42d/nN1Wy9b4fZMmPPheshHd9sA8=;
	b=AeEJV4mKC6Y7K1sLUQQPVksnkz5OtSEMS5QYbrFwv0j2WN+vJnqLuabTkhBlxQp+UFU4Ry
	/H5tGXYmeHGGsZAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5FA1E13757;
	Sat,  5 Jul 2025 14:22:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id cz7XFic1aWiIYAAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Sat, 05 Jul 2025 14:22:31 +0000
Date: Sat, 5 Jul 2025 16:22:30 +0200
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz
Subject: Re: [PATCH v4 5/6] btrfs: implement shutdown ioctl
Message-ID: <20250705142230.GC4453@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1751589725.git.wqu@suse.com>
 <5ff44de2d9d7f8c2e59fa3a5fe68d5bb4c71a111.1751589725.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5ff44de2d9d7f8c2e59fa3a5fe68d5bb4c71a111.1751589725.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-0.997];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_ALL(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo,suse.cz:replyto,twin.jikos.cz:mid];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 
X-Spam-Score: -4.00

On Fri, Jul 04, 2025 at 10:12:33AM +0930, Qu Wenruo wrote:
> The shutdown ioctl should follow the XFS one, which use magic number 'X',
> and ioctl number 125, with a u32 as flags.
> 
> For now btrfs don't distinguish DEFAULT and LOGFLUSH flags (just like
> f2fs), both will freeze the fs first (implies committing the current
> transaction), setting the SHUTDOWN flag and finally thaw the fs.
> 
> For NOLOGFLUSH flag, the freeze/thaw part is skipped thus the current
> transaction is aborted.
> 
> The new shutdown ioctl is hidden behind experimental features for more
> testing.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  fs/btrfs/ioctl.c           | 40 ++++++++++++++++++++++++++++++++++++++
>  include/uapi/linux/btrfs.h |  9 +++++++++
>  2 files changed, 49 insertions(+)
> 
> diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
> index 2f3b7be13bea..94eb7a8499db 100644
> --- a/fs/btrfs/ioctl.c
> +++ b/fs/btrfs/ioctl.c
> @@ -5194,6 +5194,36 @@ static int btrfs_ioctl_subvol_sync(struct btrfs_fs_info *fs_info, void __user *a
>  	return 0;
>  }
>  
> +#ifdef CONFIG_BTRFS_EXPERIMENTAL
> +static int btrfs_emergency_shutdown(struct btrfs_fs_info *fs_info, u32 flags)
> +{
> +	int ret = 0;
> +
> +	if (flags >= BTRFS_SHUTDOWN_FLAGS_LAST)
> +		return -EINVAL;
> +
> +	if (btrfs_is_shutdown(fs_info))
> +		return 0;
> +
> +	switch (flags) {
> +	case BTRFS_SHUTDOWN_FLAGS_LOGFLUSH:
> +	case BTRFS_SHUTDOWN_FLAGS_DEFAULT:
> +		ret = freeze_super(fs_info->sb, FREEZE_HOLDER_KERNEL, NULL);

Recently I've looked at scrub blocking filesystem freezing and it does
not work because it blocks on the semaphore taken in mnt_want_write,
also taken in freeze_super().

I have an idea for fix, basically pause scrub, undo mnt_want_write
and then call freeze_super. So we'll need that too for shutdown. Once
implemented the fixup would be to use btrfs_freeze_super callback here.

> +		if (ret)
> +			return ret;
> +		btrfs_force_shutdown(fs_info);
> +		ret = thaw_super(fs_info->sb, FREEZE_HOLDER_KERNEL, NULL);
> +		if (ret)
> +			return ret;
> +		break;
> +	case BTRFS_SHUTDOWN_FLAGS_NOLOGFLUSH:
> +		btrfs_force_shutdown(fs_info);
> +		break;
> +	}
> +	return ret;
> +}
> +#endif
> +
>  long btrfs_ioctl(struct file *file, unsigned int
>  		cmd, unsigned long arg)
>  {

> --- a/include/uapi/linux/btrfs.h
> +++ b/include/uapi/linux/btrfs.h
> @@ -1096,6 +1096,12 @@ enum btrfs_err_code {
>  	BTRFS_ERROR_DEV_RAID1C4_MIN_NOT_MET,
>  };
>  
> +/* Flags for IOC_SHUTDOWN, should match XFS' flags. */
> +#define BTRFS_SHUTDOWN_FLAGS_DEFAULT	0x0
> +#define BTRFS_SHUTDOWN_FLAGS_LOGFLUSH	0x1
> +#define BTRFS_SHUTDOWN_FLAGS_NOLOGFLUSH	0x2
> +#define BTRFS_SHUTDOWN_FLAGS_LAST	0x3
> +
>  #define BTRFS_IOC_SNAP_CREATE _IOW(BTRFS_IOCTL_MAGIC, 1, \
>  				   struct btrfs_ioctl_vol_args)
>  #define BTRFS_IOC_DEFRAG _IOW(BTRFS_IOCTL_MAGIC, 2, \
> @@ -1217,6 +1223,9 @@ enum btrfs_err_code {
>  #define BTRFS_IOC_SUBVOL_SYNC_WAIT _IOW(BTRFS_IOCTL_MAGIC, 65, \
>  					struct btrfs_ioctl_subvol_wait)
>  
> +/* Shutdown ioctl should follow XFS's interfaces, thus not using btrfs magic. */
> +#define BTRFS_IOC_SHUTDOWN	_IOR('X', 125, __u32)

In XFS it's

#define XFS_IOC_GOINGDOWN            _IOR ('X', 125, uint32_t)

It's right to use the same definition and ioctl value as this will
be a generic ioctl eventually, with 3 users at least. I like the name
SHUTDOWN better, ext4 also uses that.

