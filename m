Return-Path: <linux-fsdevel+bounces-49237-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B5569AB9A32
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 May 2025 12:32:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 42DDC5002A3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 May 2025 10:32:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18B2C233D9C;
	Fri, 16 May 2025 10:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Q5FwqsCu";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="zPr4ETf7";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Q5FwqsCu";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="zPr4ETf7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00EEB481C4
	for <linux-fsdevel@vger.kernel.org>; Fri, 16 May 2025 10:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747391526; cv=none; b=jASA705TVfJOClEwgcrOCyS7dZ8qDbhWDnLtUtgX7ZV0EhLqQfm+cd5H6oUUkAhdKjkBrWMeHxIy42+bJDax/DDUhku2VsWHkhUX/8j9B6F63Uu6R1x5OQz8YpLNuMbodki5npd4vXLcmjtzEG63fTBOmnBkv5LReKL9APyCYwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747391526; c=relaxed/simple;
	bh=Y6itP7Kh2dIc69u5d6PKjEC5APhDujvVRHjoJJoRjZw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eMsqriuRlE+2AP+zq8fQ8HBhXtZ5YWH3x/zKxeQ0USlJzJ8mOrZ5wKnH/NvptC6nN7DNoZKzMBZlqd2WvtHB7zVgiyoP3C9N29xJJjpeDIOZWDzwiqTsnJ0+znv6+0uXYG2MHwfWktV00Ud9lesm9yCrq6vSUEDMCAv0i9DJi24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Q5FwqsCu; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=zPr4ETf7; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Q5FwqsCu; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=zPr4ETf7; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 25533218B8;
	Fri, 16 May 2025 10:32:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1747391523; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Mxnb1geN517pevzpOjZliU3PBMZrTHg/aQoTFkapi0Y=;
	b=Q5FwqsCufDChGJ5Ehc6EZzwwM/ZDphg2wt7gThyIWdtYpbRYIBdX0FaqDvh96cGDL2pBgu
	wO8jSyVxZdmtQqL6H5ISImo7CfmuktlYr+JRtc7ijhb/+yMisqTzPXlzQu09ankUFGdto4
	q6Z9tmvErpEpgabXmuZyEpzwwQYIBmE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1747391523;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Mxnb1geN517pevzpOjZliU3PBMZrTHg/aQoTFkapi0Y=;
	b=zPr4ETf7RJtJ3TuezENhO7tXFg9K+iEPbt/oRuYP+oDesI9mfbqO4sZMMs8RyeQO1bUkWc
	U6b5QLiee5tQ/LDA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1747391523; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Mxnb1geN517pevzpOjZliU3PBMZrTHg/aQoTFkapi0Y=;
	b=Q5FwqsCufDChGJ5Ehc6EZzwwM/ZDphg2wt7gThyIWdtYpbRYIBdX0FaqDvh96cGDL2pBgu
	wO8jSyVxZdmtQqL6H5ISImo7CfmuktlYr+JRtc7ijhb/+yMisqTzPXlzQu09ankUFGdto4
	q6Z9tmvErpEpgabXmuZyEpzwwQYIBmE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1747391523;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Mxnb1geN517pevzpOjZliU3PBMZrTHg/aQoTFkapi0Y=;
	b=zPr4ETf7RJtJ3TuezENhO7tXFg9K+iEPbt/oRuYP+oDesI9mfbqO4sZMMs8RyeQO1bUkWc
	U6b5QLiee5tQ/LDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 190C513411;
	Fri, 16 May 2025 10:32:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id lYYZBiMUJ2jUAgAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 16 May 2025 10:32:03 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id C788AA09DD; Fri, 16 May 2025 12:31:58 +0200 (CEST)
Date: Fri, 16 May 2025 12:31:58 +0200
From: Jan Kara <jack@suse.cz>
To: Zizhi Wo <wozizhi@huaweicloud.com>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, yangerkun@huawei.com
Subject: Re: [PATCH] fs: Rename the parameter of mnt_get_write_access()
Message-ID: <vtfnncganindq4q7t4icfaujkgejlbd7repvurpjx6nwf6i7zp@hr44m22ij4qf>
References: <20250516032147.3350598-1-wozizhi@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250516032147.3350598-1-wozizhi@huaweicloud.com>
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,huawei.com:email]
X-Spam-Score: -3.80

On Fri 16-05-25 11:21:47, Zizhi Wo wrote:
> From: Zizhi Wo <wozizhi@huawei.com>
> 
> Rename the parameter in mnt_get_write_access() from "m" to "mnt" for
> consistency between declaration and implementation.
> 
> Signed-off-by: Zizhi Wo <wozizhi@huawei.com>

I'm sorry but this is just a pointless churn. I agree the declaration and
implementation should better be consistent (although in this particular
case it isn't too worrying) but it's much easier (and with much lower
chance to cause conflicts) to just fixup the declaration.

								Honza

> ---
>  fs/namespace.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/fs/namespace.c b/fs/namespace.c
> index 1b466c54a357..b1b679433ab3 100644
> --- a/fs/namespace.c
> +++ b/fs/namespace.c
> @@ -483,7 +483,7 @@ static int mnt_is_readonly(struct vfsmount *mnt)
>   */
>  /**
>   * mnt_get_write_access - get write access to a mount without freeze protection
> - * @m: the mount on which to take a write
> + * @mnt: the mount on which to take a write
>   *
>   * This tells the low-level filesystem that a write is about to be performed to
>   * it, and makes sure that writes are allowed (mnt it read-write) before
> @@ -491,13 +491,13 @@ static int mnt_is_readonly(struct vfsmount *mnt)
>   * frozen. When the write operation is finished, mnt_put_write_access() must be
>   * called. This is effectively a refcount.
>   */
> -int mnt_get_write_access(struct vfsmount *m)
> +int mnt_get_write_access(struct vfsmount *mnt)
>  {
> -	struct mount *mnt = real_mount(m);
> +	struct mount *m = real_mount(mnt);
>  	int ret = 0;
>  
>  	preempt_disable();
> -	mnt_inc_writers(mnt);
> +	mnt_inc_writers(m);
>  	/*
>  	 * The store to mnt_inc_writers must be visible before we pass
>  	 * MNT_WRITE_HOLD loop below, so that the slowpath can see our
> @@ -505,7 +505,7 @@ int mnt_get_write_access(struct vfsmount *m)
>  	 */
>  	smp_mb();
>  	might_lock(&mount_lock.lock);
> -	while (READ_ONCE(mnt->mnt.mnt_flags) & MNT_WRITE_HOLD) {
> +	while (READ_ONCE(m->mnt.mnt_flags) & MNT_WRITE_HOLD) {
>  		if (!IS_ENABLED(CONFIG_PREEMPT_RT)) {
>  			cpu_relax();
>  		} else {
> @@ -530,8 +530,8 @@ int mnt_get_write_access(struct vfsmount *m)
>  	 * read-only.
>  	 */
>  	smp_rmb();
> -	if (mnt_is_readonly(m)) {
> -		mnt_dec_writers(mnt);
> +	if (mnt_is_readonly(mnt)) {
> +		mnt_dec_writers(m);
>  		ret = -EROFS;
>  	}
>  	preempt_enable();
> -- 
> 2.39.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

