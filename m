Return-Path: <linux-fsdevel+bounces-52533-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 570DEAE3E02
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jun 2025 13:34:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 732C63B35BE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jun 2025 11:34:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A731243956;
	Mon, 23 Jun 2025 11:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="MqvfjEhh";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="2x6+ktP/";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="MqvfjEhh";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="2x6+ktP/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 779F22417F2
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Jun 2025 11:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750678458; cv=none; b=fvwTEQyl1Ssbcz3xDcQrhUFf/DP322nHKxsDDQ2Ww5/Qe6pKnCbm1CYm68+I5FSm/hCactcONO+bz+Mwlotxcb+gjVjVjJKFy2WFoB78BO9ce9kaKTqrEB/MWhDXV++kvaw/uTIRwkyLBdPghkqxiSCHBuFtZpnwz9XRA7NPaa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750678458; c=relaxed/simple;
	bh=di076/TilxNq0DT/xVaiyKa/wQFPdXTotSLMQWNsK5g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QkmOQaFcQ/6SVBs2ib4yEMY9Ptrlo5PWecRRtWZMHTqPCJVyAtpCLDdVYehfGrZXyJ9KP6G/7yf3QSeX6mSdA+nX+lCVGSuqCeVwVVRXZkacSBaCb5GJDmufMuVFetqU9/v+wSXvdxKXKoYHLCJB+CUNmKebpVVtUdhqET3xXkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=MqvfjEhh; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=2x6+ktP/; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=MqvfjEhh; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=2x6+ktP/; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id AE8EE1F385;
	Mon, 23 Jun 2025 11:34:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1750678455; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vTuhOjTNkL8n8m15wqPPe9fPt8Ny6Ruwe2KNjLJ0cb4=;
	b=MqvfjEhhgdB7ZsMisUhb1id12BQSeUJAkgd3IqE6ob0ikABDEzOrvPMAlZqiqc+dmMesdr
	bsUQ3q4SZUZ9qLqvSRa1nf0pgqMyPcr+xMaQN8d0GH3XEwsOUwSlki0bk+AeS4PRt6ZzuE
	RMOPs9qBIDo2WmwtYAAqC7lwlUSWRyI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1750678455;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vTuhOjTNkL8n8m15wqPPe9fPt8Ny6Ruwe2KNjLJ0cb4=;
	b=2x6+ktP/zklfMuqIkH09oxtI2ItG0eEsC73kZDP9I/6XNiDyUUeIyotnMJEqevaDF/yVHS
	qdhc7Ky5LKqU7VDQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1750678455; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vTuhOjTNkL8n8m15wqPPe9fPt8Ny6Ruwe2KNjLJ0cb4=;
	b=MqvfjEhhgdB7ZsMisUhb1id12BQSeUJAkgd3IqE6ob0ikABDEzOrvPMAlZqiqc+dmMesdr
	bsUQ3q4SZUZ9qLqvSRa1nf0pgqMyPcr+xMaQN8d0GH3XEwsOUwSlki0bk+AeS4PRt6ZzuE
	RMOPs9qBIDo2WmwtYAAqC7lwlUSWRyI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1750678455;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vTuhOjTNkL8n8m15wqPPe9fPt8Ny6Ruwe2KNjLJ0cb4=;
	b=2x6+ktP/zklfMuqIkH09oxtI2ItG0eEsC73kZDP9I/6XNiDyUUeIyotnMJEqevaDF/yVHS
	qdhc7Ky5LKqU7VDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A442B13A27;
	Mon, 23 Jun 2025 11:34:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id BP0UKLc7WWipMQAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 23 Jun 2025 11:34:15 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 5E77DA2A00; Mon, 23 Jun 2025 13:34:11 +0200 (CEST)
Date: Mon, 23 Jun 2025 13:34:11 +0200
From: Jan Kara <jack@suse.cz>
To: Christian Brauner <brauner@kernel.org>
Cc: Jeff Layton <jlayton@kernel.org>, Chuck Lever <chuck.lever@oracle.com>, 
	Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org
Subject: Re: [PATCH 3/9] fhandle: rename to get_path_anchor()
Message-ID: <l4acom75s36xl27suc7vzkcsmw34oxeohwnmvtp33j2jwrx4wv@r7n6n2apv4ty>
References: <20250623-work-pidfs-fhandle-v1-0-75899d67555f@kernel.org>
 <20250623-work-pidfs-fhandle-v1-3-75899d67555f@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250623-work-pidfs-fhandle-v1-3-75899d67555f@kernel.org>
X-Spam-Flag: NO
X-Spam-Score: -3.80
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,oracle.com,suse.cz,gmail.com,ffwll.ch,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:email]
X-Spam-Level: 

On Mon 23-06-25 11:01:25, Christian Brauner wrote:
> Rename as we're going to expand the function in the next step. The path
> just serves as the anchor tying the decoding to the filesystem.
> 
> Signed-off-by: Christian Brauner <brauner@kernel.org>

OK. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/fhandle.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/fhandle.c b/fs/fhandle.c
> index 73f56f8e7d5d..d8d32208c621 100644
> --- a/fs/fhandle.c
> +++ b/fs/fhandle.c
> @@ -168,7 +168,7 @@ SYSCALL_DEFINE5(name_to_handle_at, int, dfd, const char __user *, name,
>  	return err;
>  }
>  
> -static int get_path_from_fd(int fd, struct path *root)
> +static int get_path_anchor(int fd, struct path *root)
>  {
>  	if (fd == AT_FDCWD) {
>  		struct fs_struct *fs = current->fs;
> @@ -338,7 +338,7 @@ static int handle_to_path(int mountdirfd, struct file_handle __user *ufh,
>  	    FILEID_USER_FLAGS(f_handle.handle_type) & ~FILEID_VALID_USER_FLAGS)
>  		return -EINVAL;
>  
> -	retval = get_path_from_fd(mountdirfd, &ctx.root);
> +	retval = get_path_anchor(mountdirfd, &ctx.root);
>  	if (retval)
>  		return retval;
>  
> 
> -- 
> 2.47.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

