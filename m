Return-Path: <linux-fsdevel+bounces-40943-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 95A12A296C7
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Feb 2025 17:54:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 85B641881E4B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Feb 2025 16:53:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BED8B1FCF66;
	Wed,  5 Feb 2025 16:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="KLN1TJR7";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="0Hu15Kiq";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="KLN1TJR7";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="0Hu15Kiq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D9B01FC0E9
	for <linux-fsdevel@vger.kernel.org>; Wed,  5 Feb 2025 16:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738774349; cv=none; b=QQUe7YuOsYhmvvtWyRp6CV6QTz5xTDCpyq2xsTFOrsXUHQ0rFZerHcB6+uFMD0iJif7QgW+Lmt3ToqNW96k+40lAr5HQ2STTkRiGyliP2KWd8VLRwF84MQ0QZcZPYCfTspJpFy1RMcqigBvOc6Ke3beFIW7OJ9HVF+IBgNaGD8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738774349; c=relaxed/simple;
	bh=KJwlz8O6bAhpAPlwo01efq3HFSJzAYMDZgS5mR4HToI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h0QYw8C11RNmvrzp8VlK+KNjpnBl2/VXL6Xn+I+rjLMW5yD+NgBaOBCkk13JFy8POTSjkp+KtBDyVWNUpEljEt+zYbEp3lZlo63UiOowBf5MhhRTK2E71CQQ4pS4RcFvakN8ILlWgTj+vtFp/23V+PK3l5JxpBup/2O1Qet33qg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=KLN1TJR7; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=0Hu15Kiq; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=KLN1TJR7; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=0Hu15Kiq; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 4D6961F7E0;
	Wed,  5 Feb 2025 16:52:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1738774345; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XZgEuxPbdi3STYJgtio3g9upsWzsqSzVqtT2we+YBRQ=;
	b=KLN1TJR71IBxljor6od2NTf3r8yu+gzt66zjkc+OVzb+hCYS9kZdJnWS2t5h37HSEorOt4
	cXvO7T8y3mCBkGwLEV7ezbndb0Dvy7A5plH0SubikdDLiprhChnfTdJGKbgiIjEY0yiiWN
	+b9pF/BVk/4n8srmwnVHBlrUQCFCTqg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1738774345;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XZgEuxPbdi3STYJgtio3g9upsWzsqSzVqtT2we+YBRQ=;
	b=0Hu15KiqNMlgsx56HmkgCN54ZSI+nsAn/f/BOcNOIUhOWIyauDB8zQkcixEssagdu58KTZ
	jLCXkKTpnOWB5fAA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1738774345; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XZgEuxPbdi3STYJgtio3g9upsWzsqSzVqtT2we+YBRQ=;
	b=KLN1TJR71IBxljor6od2NTf3r8yu+gzt66zjkc+OVzb+hCYS9kZdJnWS2t5h37HSEorOt4
	cXvO7T8y3mCBkGwLEV7ezbndb0Dvy7A5plH0SubikdDLiprhChnfTdJGKbgiIjEY0yiiWN
	+b9pF/BVk/4n8srmwnVHBlrUQCFCTqg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1738774345;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XZgEuxPbdi3STYJgtio3g9upsWzsqSzVqtT2we+YBRQ=;
	b=0Hu15KiqNMlgsx56HmkgCN54ZSI+nsAn/f/BOcNOIUhOWIyauDB8zQkcixEssagdu58KTZ
	jLCXkKTpnOWB5fAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3CFCE13694;
	Wed,  5 Feb 2025 16:52:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 7ZDhDkmXo2fzPQAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 05 Feb 2025 16:52:25 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id BC62AA28E9; Wed,  5 Feb 2025 17:52:24 +0100 (CET)
Date: Wed, 5 Feb 2025 17:52:24 +0100
From: Jan Kara <jack@suse.cz>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Alex Williamson <alex.williamson@redhat.com>, Linus Torvalds <torvalds@linux-foundation.org>, 
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 2/3] fsnotify: disable notification by default for all
 pseudo files
Message-ID: <ksgym4id7zj22vz2sn6bdysx57jxsut37tipw4celi5xm2iidu@u2x5gu5uonli>
References: <20250203223205.861346-1-amir73il@gmail.com>
 <20250203223205.861346-3-amir73il@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250203223205.861346-3-amir73il@gmail.com>
X-Spam-Score: -3.80
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-0.999];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.com:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Level: 

On Mon 03-02-25 23:32:04, Amir Goldstein wrote:
> Most pseudo files are not applicable for fsnotify events at all,
> let alone to the new pre-content events.
> 
> Disable notifications to all files allocated with alloc_file_pseudo()
> and enable legacy inotify events for the specific cases of pipe and
> socket, which have known users of inotify events.
> 
> Pre-content events are also kept disabled for sockets and pipes.
> 
> Fixes: 20bf82a898b6 ("mm: don't allow huge faults for files with pre content watches")
> Reported-by: Alex Williamson <alex.williamson@redhat.com>
> Closes: https://lore.kernel.org/linux-fsdevel/20250131121703.1e4d00a7.alex.williamson@redhat.com/
> Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
> Link: https://lore.kernel.org/linux-fsdevel/CAHk-=wi2pThSVY=zhO=ZKxViBj5QCRX-=AS2+rVknQgJnHXDFg@mail.gmail.com/
> Tested-by: Alex Williamson <alex.williamson@redhat.com>
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/file_table.c | 11 +++++++++++
>  fs/open.c       |  4 ++--
>  fs/pipe.c       |  6 ++++++
>  net/socket.c    |  5 +++++
>  4 files changed, 24 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/file_table.c b/fs/file_table.c
> index f0291a66f9db4..35b93da6c5cb1 100644
> --- a/fs/file_table.c
> +++ b/fs/file_table.c
> @@ -375,7 +375,13 @@ struct file *alloc_file_pseudo(struct inode *inode, struct vfsmount *mnt,
>  	if (IS_ERR(file)) {
>  		ihold(inode);
>  		path_put(&path);
> +		return file;
>  	}
> +	/*
> +	 * Disable all fsnotify events for pseudo files by default.
> +	 * They may be enabled by caller with file_set_fsnotify_mode().
> +	 */
> +	file_set_fsnotify_mode(file, FMODE_NONOTIFY);
>  	return file;
>  }
>  EXPORT_SYMBOL(alloc_file_pseudo);
> @@ -400,6 +406,11 @@ struct file *alloc_file_pseudo_noaccount(struct inode *inode,
>  		return file;
>  	}
>  	file_init_path(file, &path, fops);
> +	/*
> +	 * Disable all fsnotify events for pseudo files by default.
> +	 * They may be enabled by caller with file_set_fsnotify_mode().
> +	 */
> +	file_set_fsnotify_mode(file, FMODE_NONOTIFY);
>  	return file;
>  }
>  EXPORT_SYMBOL_GPL(alloc_file_pseudo_noaccount);
> diff --git a/fs/open.c b/fs/open.c
> index 3fcbfff8aede8..1be20de9f283a 100644
> --- a/fs/open.c
> +++ b/fs/open.c
> @@ -936,8 +936,8 @@ static int do_dentry_open(struct file *f,
>  
>  	/*
>  	 * Set FMODE_NONOTIFY_* bits according to existing permission watches.
> -	 * If FMODE_NONOTIFY was already set for an fanotify fd, this doesn't
> -	 * change anything.
> +	 * If FMODE_NONOTIFY mode was already set for an fanotify fd or for a
> +	 * pseudo file, this call will not change the mode.
>  	 */
>  	file_set_fsnotify_mode_from_watchers(f);
>  	error = fsnotify_open_perm(f);
> diff --git a/fs/pipe.c b/fs/pipe.c
> index 94b59045ab44b..ce1af7592780d 100644
> --- a/fs/pipe.c
> +++ b/fs/pipe.c
> @@ -960,6 +960,12 @@ int create_pipe_files(struct file **res, int flags)
>  	res[1] = f;
>  	stream_open(inode, res[0]);
>  	stream_open(inode, res[1]);
> +	/*
> +	 * Disable permission and pre-content events, but enable legacy
> +	 * inotify events for legacy users.
> +	 */
> +	file_set_fsnotify_mode(res[0], FMODE_NONOTIFY_PERM);
> +	file_set_fsnotify_mode(res[1], FMODE_NONOTIFY_PERM);
>  	return 0;
>  }
>  
> diff --git a/net/socket.c b/net/socket.c
> index 262a28b59c7f0..28bae5a942341 100644
> --- a/net/socket.c
> +++ b/net/socket.c
> @@ -479,6 +479,11 @@ struct file *sock_alloc_file(struct socket *sock, int flags, const char *dname)
>  	sock->file = file;
>  	file->private_data = sock;
>  	stream_open(SOCK_INODE(sock), file);
> +	/*
> +	 * Disable permission and pre-content events, but enable legacy
> +	 * inotify events for legacy users.
> +	 */
> +	file_set_fsnotify_mode(file, FMODE_NONOTIFY_PERM);
>  	return file;
>  }
>  EXPORT_SYMBOL(sock_alloc_file);
> -- 
> 2.34.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

