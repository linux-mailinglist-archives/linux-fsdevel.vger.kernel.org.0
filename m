Return-Path: <linux-fsdevel+bounces-51440-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AC22AD6EA1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Jun 2025 13:08:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 510261895C44
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Jun 2025 11:08:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6FD123AB81;
	Thu, 12 Jun 2025 11:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="BxHiCzsJ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="NHfwxrKX";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="yXWtmN9F";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="M1X21LPa"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83D0317A2EA
	for <linux-fsdevel@vger.kernel.org>; Thu, 12 Jun 2025 11:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749726508; cv=none; b=eFo0bXrBJcwplDC/8smvoy53NTruIWTsdNSZyovR4frUNwmCRNzf6H3nSduytke64Lt44ixxU+GO7RAkzbvkoDgBvEziKQ8qWxEj4tmBsz71xD/RHxF/9c2tgVr8kPU4/AsflwCRohHa9FOJ/eD3rscysRwvrchfLkuz/l6gQ6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749726508; c=relaxed/simple;
	bh=VUEQpMDxv5SdbtacnxAkIpRyc25HgnZCQ6NI+Dql1P4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oSZgJD8G/7twq6MrJtlddjrYj7cp82uI/UT9skaIjUsQU6fPUDL7GVm3hJS+oZL7VdSP6koDQ2n8NhKMAfh6yaxza4w0/oGEgQstpWPYwqCd15cXjA/kf9g0Uvbukx1eXPBtEkJe4nChu0iGTO3RA9DjdVyYUx/7/bRe1Jeh7bQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=BxHiCzsJ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=NHfwxrKX; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=yXWtmN9F; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=M1X21LPa; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 93DF821209;
	Thu, 12 Jun 2025 11:08:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1749726504; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kfgn7WSHdn26zjp9M0F4QsAyunZl5LBrO/4tS3XYles=;
	b=BxHiCzsJm+uz7PD7nMWCaswHuP1+qJtAq7VeXApmfnnG5G8LvqY4rJ5qLnetVfEsxPht4R
	p4szA8+FOuIfIDbZ3PFhk8ul3gO+uNgxdB/RGdO0JhzZPSD9OClGZNyIpGRVVBCez4Xy05
	aqG85WO+tioctnxfHRoOa/Z12/dX0Ts=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1749726504;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kfgn7WSHdn26zjp9M0F4QsAyunZl5LBrO/4tS3XYles=;
	b=NHfwxrKXFUSnuAdIzOy3ou0iNy5Ljntrj2GWAsF4IE2pNqjBTz0cw+9I0kQ0yF1jitW6ic
	Zw1GsEZq6y0kylAw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1749726503; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kfgn7WSHdn26zjp9M0F4QsAyunZl5LBrO/4tS3XYles=;
	b=yXWtmN9Fn3wWmN4nS7Xld8bsW0MdUT2d2w/vZkxklHkwglOc1CKm25tvtjNX2R5XpbDzPq
	yUuauNzsZAVz/QwEi2g1FOFgxJuiGv6iTn7QguxMKUfwsMk5g4qPhBGAa+mGft0ObUX18D
	fjmuXtilH/qcW26s60qG956RbXAGUE4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1749726503;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kfgn7WSHdn26zjp9M0F4QsAyunZl5LBrO/4tS3XYles=;
	b=M1X21LPafXDC2lfhPZ7t4cKNTHiPrF3o8a0W3i5mjm4Md9w2MHU/UGpE4vT7pFwRDDsmsd
	2AbiOyZRIf90dPCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 89483139E2;
	Thu, 12 Jun 2025 11:08:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id d+Z5ISe1SmiJXgAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 12 Jun 2025 11:08:23 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 52263A099E; Thu, 12 Jun 2025 13:08:19 +0200 (CEST)
Date: Thu, 12 Jun 2025 13:08:19 +0200
From: Jan Kara <jack@suse.cz>
To: Luis Henriques <luis@igalia.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kernel-dev@igalia.com
Subject: Re: [PATCH] fs: drop assert in file_seek_cur_needs_f_lock
Message-ID: <tsevuodksvhftqyobfu6ana5ibbbdtbqo46j5r3hir5kvmpozo@g3vcsirgdioe>
References: <87tt4u4p4h.fsf@igalia.com>
 <20250612094101.6003-1-luis@igalia.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250612094101.6003-1-luis@igalia.com>
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,igalia.com:email,suse.com:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -3.80

On Thu 12-06-25 10:41:01, Luis Henriques wrote:
> The assert in function file_seek_cur_needs_f_lock() can be triggered very
> easily because, as Jan Kara suggested, the file reference may get
> incremented after checking it with fdget_pos().
> 
> Fixes: da06e3c51794 ("fs: don't needlessly acquire f_lock")
> Signed-off-by: Luis Henriques <luis@igalia.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza
> ---
> Hi Christian,
> 
> It wasn't clear whether you'd be queueing this fix yourself.  Since I don't
> see it on vfs.git, I decided to explicitly send the patch so that it doesn't
> slip through the cracks.
> 
> Cheers,
> -- 
> Luis
> 
>  fs/file.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/fs/file.c b/fs/file.c
> index 3a3146664cf3..075f07bdc977 100644
> --- a/fs/file.c
> +++ b/fs/file.c
> @@ -1198,8 +1198,6 @@ bool file_seek_cur_needs_f_lock(struct file *file)
>  	if (!(file->f_mode & FMODE_ATOMIC_POS) && !file->f_op->iterate_shared)
>  		return false;
>  
> -	VFS_WARN_ON_ONCE((file_count(file) > 1) &&
> -			 !mutex_is_locked(&file->f_pos_lock));
>  	return true;
>  }
>  
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

