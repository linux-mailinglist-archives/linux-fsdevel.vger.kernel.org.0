Return-Path: <linux-fsdevel+bounces-34272-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EF8C99C43FD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Nov 2024 18:45:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AFB61281448
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Nov 2024 17:45:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45A9B1AA788;
	Mon, 11 Nov 2024 17:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="QdsIBHcq";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="AGOXF755";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="D6Fok6nx";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="OQCynE9Q"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C501454728;
	Mon, 11 Nov 2024 17:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731347048; cv=none; b=O4mL8y0VqB32WokSjbL9bOF9j6v/avMZRsCG0cSInUSdMEMglzhsP1LUoGLDFnqPUT8alIRF3r9+8vAvJtYi6aiVbtkRtqF+sc4MOYQpLsVN5zCigr3S2qQ48CFdoGszhscLKiGwDru9wLZo8ShDon+caLElPf3tsOyK+zqntJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731347048; c=relaxed/simple;
	bh=8msUvZ35GmffzXX36gtrgCsOR2MwdCn5l2jBjHagB/4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ax7Ck5wrPjw1w+HWPBUvgajoGx6WDSdC+tPRj7/BVbfE6w7AxNdqehdlgHZ3rGGsM/5TmXcFkYf/jYaNV+FkTS8rZTN4iLuNx5a5uj3k5yRZYu9HMELm8RDoKxW3ocTaoP3yzt7Lg1Xieg17SBloRjdPoURdc76Jeqm7n8sh1e0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=QdsIBHcq; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=AGOXF755; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=D6Fok6nx; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=OQCynE9Q; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E8CED1F45A;
	Mon, 11 Nov 2024 17:44:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1731347045; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iulAbIBsKSsrYbrGT4anAZkT71qiNIQcAAObAS/1gsk=;
	b=QdsIBHcqz1UtgYzt55dY5coH7df1IGw2RuI33vwE588muPYBnQeQqU4eb+eCTQFxT+K+nW
	hj65vWMAwQCfSOv2uAjRR01SuF0hH+fsFsZd+bHd4yQDfOQKrp1QZ2TzjxYIiq4UOe+Jbf
	cVpyA/RJlosJb2FzCBdzr3xjJGC78Vs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1731347045;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iulAbIBsKSsrYbrGT4anAZkT71qiNIQcAAObAS/1gsk=;
	b=AGOXF755K3pf3rbYEqpzHB4zS+swNJtn+giaMji1R2PS+lCTWx28vn4xlITwp+1Qoqyn9v
	idZ90L1izWjS4JDQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=D6Fok6nx;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=OQCynE9Q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1731347043; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iulAbIBsKSsrYbrGT4anAZkT71qiNIQcAAObAS/1gsk=;
	b=D6Fok6nxpOpKcp68zkOS4JNWcGJfXmQ2gI9TpheEBLwdnZ4bGl59gKwpIepR8SeluS0rX4
	KiPD3B8PewIIgH+zb2kzYw3jlkButydQdA7tk+jSbqwM2RuQ7BO/bVZH/KNPLhTUygKgYF
	vMjZKSLXINb6BZc+Rv9dPiMY5mT+zoU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1731347043;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iulAbIBsKSsrYbrGT4anAZkT71qiNIQcAAObAS/1gsk=;
	b=OQCynE9QDy3C0ucdQ+XYpMrzF7FMO0xI3n/76lw8NEagVPxB/eL/a+ODKWt61sKClfWYuD
	vAVQIBBMOuAtbiCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CEFAC137FB;
	Mon, 11 Nov 2024 17:44:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Ox16MmNCMmfBIgAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 11 Nov 2024 17:44:03 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 54766A0986; Mon, 11 Nov 2024 18:44:03 +0100 (CET)
Date: Mon, 11 Nov 2024 18:44:03 +0100
From: Jan Kara <jack@suse.cz>
To: Jeff Layton <jlayton@kernel.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Miklos Szeredi <miklos@szeredi.hu>, Ian Kent <raven@themaw.net>,
	Josef Bacik <josef@toxicpanda.com>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/3] fs: don't let statmount return empty strings
Message-ID: <20241111174403.qm7eqdl5pxwjhb3h@quack3>
References: <20241111-statmount-v4-0-2eaf35d07a80@kernel.org>
 <20241111-statmount-v4-1-2eaf35d07a80@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241111-statmount-v4-1-2eaf35d07a80@kernel.org>
X-Rspamd-Queue-Id: E8CED1F45A
X-Spam-Level: 
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	MISSING_XM_UA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_COUNT_THREE(0.00)[3];
	RCPT_COUNT_SEVEN(0.00)[9];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.01
X-Spam-Flag: NO

On Mon 11-11-24 10:09:55, Jeff Layton wrote:
> When one of the statmount_string() handlers doesn't emit anything to
> seq, the kernel currently sets the corresponding flag and emits an empty
> string.
> 
> Given that statmount() returns a mask of accessible fields, just leave
> the bit unset in this case, and skip any NULL termination. If nothing
> was emitted to the seq, then the EOVERFLOW and EAGAIN cases aren't
> applicable and the function can just return immediately.
> 
> Signed-off-by: Jeff Layton <jlayton@kernel.org>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/namespace.c | 15 +++++++++++----
>  1 file changed, 11 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/namespace.c b/fs/namespace.c
> index ba77ce1c6788dfe461814b5826fcbb3aab68fad4..28ad153b1fb6f49653c0a85d12da457c4650a87e 100644
> --- a/fs/namespace.c
> +++ b/fs/namespace.c
> @@ -5046,22 +5046,23 @@ static int statmount_string(struct kstatmount *s, u64 flag)
>  	size_t kbufsize;
>  	struct seq_file *seq = &s->seq;
>  	struct statmount *sm = &s->sm;
> +	u32 start = seq->count;
>  
>  	switch (flag) {
>  	case STATMOUNT_FS_TYPE:
> -		sm->fs_type = seq->count;
> +		sm->fs_type = start;
>  		ret = statmount_fs_type(s, seq);
>  		break;
>  	case STATMOUNT_MNT_ROOT:
> -		sm->mnt_root = seq->count;
> +		sm->mnt_root = start;
>  		ret = statmount_mnt_root(s, seq);
>  		break;
>  	case STATMOUNT_MNT_POINT:
> -		sm->mnt_point = seq->count;
> +		sm->mnt_point = start;
>  		ret = statmount_mnt_point(s, seq);
>  		break;
>  	case STATMOUNT_MNT_OPTS:
> -		sm->mnt_opts = seq->count;
> +		sm->mnt_opts = start;
>  		ret = statmount_mnt_opts(s, seq);
>  		break;
>  	default:
> @@ -5069,6 +5070,12 @@ static int statmount_string(struct kstatmount *s, u64 flag)
>  		return -EINVAL;
>  	}
>  
> +	/*
> +	 * If nothing was emitted, return to avoid setting the flag
> +	 * and terminating the buffer.
> +	 */
> +	if (seq->count == start)
> +		return ret;
>  	if (unlikely(check_add_overflow(sizeof(*sm), seq->count, &kbufsize)))
>  		return -EOVERFLOW;
>  	if (kbufsize >= s->bufsize)
> 
> -- 
> 2.47.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

