Return-Path: <linux-fsdevel+bounces-35577-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D0BB9D5F4D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Nov 2024 13:54:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A58541F22936
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Nov 2024 12:54:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC55A1DE2CB;
	Fri, 22 Nov 2024 12:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="q1YLnlE6";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="u8bt4flB";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="q1YLnlE6";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="u8bt4flB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D5F71D63FD
	for <linux-fsdevel@vger.kernel.org>; Fri, 22 Nov 2024 12:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732280041; cv=none; b=U2kRs7sXNOmK5iSnld0/+AS1d2Inv1fFGxxvB/0vYAZGxuYSkxnF7rrx4nSKWUaq6BEEB4AkPBE3dQ8L3azr+yVPu0sinW8SuzKWVBkSMq1L6sFetPbSyjhx4b1a4eJXo4JrEg02JTeXml4CksTzz8MXkrTjcD1gZUQEnUxVzgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732280041; c=relaxed/simple;
	bh=Ln9kDFBrAvoBMxXhIAw4ZQjxeVEcJJbsIOGc4PdO1fg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CsXfuWDmxr61REDY5WTM/xuBwGcVzJ1qaEsFsTYH27vNf9lAdg15CmIDYKRB2/4ldT+7oSi7wDaR+yS7ORf9IhbfxqJd7x7kDt3JdddJry9qpR7R8eYh5eW5Os2/FpOSb01IbGPLGbwvWn8q9BauKxNradqPay3eRv3v5Ui9IL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=q1YLnlE6; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=u8bt4flB; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=q1YLnlE6; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=u8bt4flB; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 64F83211D2;
	Fri, 22 Nov 2024 12:53:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1732280031; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sH5pPDxx+GlWxHOKAzSWWklcB0r6qlo5132DFqTaJoI=;
	b=q1YLnlE66MP3hG+YPnjuHsh/3BpvGo8DOm4A3fKevDs2FQ0l54StTZFw5DpSJWPwX9BAfP
	QUyeql/JWPRBNYVVwLpQ/A1k3VsJiDPzftF5Ox0czJQCksP/9Pu9E3C3S7dD1egEeWPxuP
	wD6HeehMUvFW18S89LKQKIBpr0+s+88=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1732280031;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sH5pPDxx+GlWxHOKAzSWWklcB0r6qlo5132DFqTaJoI=;
	b=u8bt4flB61xI/g1O+Ks/hhQ/olbqBJ9iC0criIKBwp+KDcjqpavscHZYUzsNTRRd/xzlTz
	Nl3643qk4stGxoBQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=q1YLnlE6;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=u8bt4flB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1732280031; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sH5pPDxx+GlWxHOKAzSWWklcB0r6qlo5132DFqTaJoI=;
	b=q1YLnlE66MP3hG+YPnjuHsh/3BpvGo8DOm4A3fKevDs2FQ0l54StTZFw5DpSJWPwX9BAfP
	QUyeql/JWPRBNYVVwLpQ/A1k3VsJiDPzftF5Ox0czJQCksP/9Pu9E3C3S7dD1egEeWPxuP
	wD6HeehMUvFW18S89LKQKIBpr0+s+88=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1732280031;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sH5pPDxx+GlWxHOKAzSWWklcB0r6qlo5132DFqTaJoI=;
	b=u8bt4flB61xI/g1O+Ks/hhQ/olbqBJ9iC0criIKBwp+KDcjqpavscHZYUzsNTRRd/xzlTz
	Nl3643qk4stGxoBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4F3F6138A7;
	Fri, 22 Nov 2024 12:53:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id JydSE99+QGeeTAAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 22 Nov 2024 12:53:51 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 06E5BA08B5; Fri, 22 Nov 2024 13:53:42 +0100 (CET)
Date: Fri, 22 Nov 2024 13:53:42 +0100
From: Jan Kara <jack@suse.cz>
To: Christoph Hellwig <hch@lst.de>
Cc: Al Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Jens Axboe <axboe@kernel.dk>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 2/2] fs: require FMODE_WRITE for F_SET_RW_HINT
Message-ID: <20241122125342.vmmjokiilvnuifuf@quack3>
References: <20241122122931.90408-1-hch@lst.de>
 <20241122122931.90408-3-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241122122931.90408-3-hch@lst.de>
X-Rspamd-Queue-Id: 64F83211D2
X-Spam-Score: -4.01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lst.de:email,suse.com:email,suse.cz:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Fri 22-11-24 13:29:25, Christoph Hellwig wrote:
> F_SET_RW_HINT controls the placement of written file data.  A read-only
> fd should not allow for that.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Here I'm not so sure. Firstly, since you are an owner this doesn't add any
additional practical restriction. Secondly, you are not changing anything
on disk, just IO hints in memory... Thirdly, we generally don't require
writeable fd even to do file attribute changes (like with fchmod, fchown,
etc.).  So although the check makes some sense, it seems to be mostly
inconsistent with how we treat similar stuff.

								Honza
> ---
>  fs/fcntl.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/fs/fcntl.c b/fs/fcntl.c
> index 7fc6190da342..12f60c42743a 100644
> --- a/fs/fcntl.c
> +++ b/fs/fcntl.c
> @@ -377,6 +377,8 @@ static long fcntl_set_rw_hint(struct file *file, unsigned int cmd,
>  
>  	if (!inode_owner_or_capable(file_mnt_idmap(file), inode))
>  		return -EPERM;
> +	if (!(file->f_mode & FMODE_WRITE))
> +		return -EBADF;
>  
>  	if (copy_from_user(&hint, argp, sizeof(hint)))
>  		return -EFAULT;
> -- 
> 2.45.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

