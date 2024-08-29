Return-Path: <linux-fsdevel+bounces-27803-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 614959642DB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 13:18:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D65841F23150
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 11:18:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44470190496;
	Thu, 29 Aug 2024 11:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="BpL8AwJj";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="IJjfXb59";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="qEyZu7Tr";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="wOXoTiVg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E30729474;
	Thu, 29 Aug 2024 11:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724930283; cv=none; b=msXNx5lGFtbPOtiFVoa29wlPo6dTMUSqbA9md3o4pdGzmT5l5quAqjpWc/kiyxzvPLr20Xnb11DLr/3pCLryKbxvFfLpUdQFXlh+K7a9XGbujUYT5xjIpXRFlB3/jvKyjTudTlGomuYcHeZXaLj/cgxqXTFD1yqk1BmB98Pa0UQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724930283; c=relaxed/simple;
	bh=/PwGxbIVR+NNi8MVB+lEH0f0kwNGHAH5RR5iiYcu7UQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wu4f5Iq2ia9u+g495vicAuc8KuZ1fIPv8RLzRLFSgnvK/G0mTP22H+v44lNz2ovUeRxISMP6y5ij6ziKdGulCLmQ3fjWPqTvU4HR0Oe9qtfJLXRos2yN2Lq4rJLCVSYsXMjfxfC1pK1nmuwS4ytBF1saUCzAJdBZQWug6aW4+zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=BpL8AwJj; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=IJjfXb59; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=qEyZu7Tr; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=wOXoTiVg; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E113B1F381;
	Thu, 29 Aug 2024 11:17:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1724930279; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0VbUZDZQwysdju52Mc/Prv655x840ugcPnmGGooE7sA=;
	b=BpL8AwJj59PVb3dhbuAZcXAjX8r2rxJ9g24wzvJyYcCP8rcssgGm+TQ1F/jPcroXo8/1Pe
	YFaWVlj+m3K8aJzagPO/sgbHGzwOgf77v29MtpIbF81CyRhDulQI8AqfQMI1X1eq2MRMEQ
	qxYA+mrzUrcwHcpOu0i3EBzjVQZYm8Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1724930279;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0VbUZDZQwysdju52Mc/Prv655x840ugcPnmGGooE7sA=;
	b=IJjfXb59ZkfzJRClFLr8yRG/1v10ufGm7twMC3KAPEhATFAMD3EU3uf3jkn53dLAd5NWrE
	yG7ZNyvNZbjKBMAQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=qEyZu7Tr;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=wOXoTiVg
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1724930277; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0VbUZDZQwysdju52Mc/Prv655x840ugcPnmGGooE7sA=;
	b=qEyZu7TrP7Uxt5l0A9md+zJ+QViU0Edmm8HTIxAFOAzjzz+vO869cxaF1zblg/0eqyiS2A
	0Rphkh3+budjfwfAVVTYsY9OSXdIk/4LGLQc9cYMeNJidhJApLgqSgWKFLZxRiz7lDHbPq
	x7gvXFQD7DWz24DgDrltYMV7+LBPjhc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1724930277;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0VbUZDZQwysdju52Mc/Prv655x840ugcPnmGGooE7sA=;
	b=wOXoTiVgrQNH+YEaJYYhfy98Z6l5wjLMOT/1w232L0/67UTfdCGUFxPiSrijSvddshI62Y
	wBL+JVxhD/lc/oDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D5B9A139B0;
	Thu, 29 Aug 2024 11:17:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id g30sNOVY0GZ9FgAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 29 Aug 2024 11:17:57 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 87F0AA0965; Thu, 29 Aug 2024 13:17:53 +0200 (CEST)
Date: Thu, 29 Aug 2024 13:17:53 +0200
From: Jan Kara <jack@suse.cz>
To: Josef Bacik <josef@toxicpanda.com>
Cc: kernel-team@fb.com, linux-fsdevel@vger.kernel.org, jack@suse.cz,
	amir73il@gmail.com, brauner@kernel.org, linux-xfs@vger.kernel.org,
	gfs2@lists.linux.dev, linux-bcachefs@vger.kernel.org,
	"Darrick J. Wong" <djwong@kernel.org>,
	Dave Chinner <david@fromorbit.com>,
	Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH v4 16/16] xfs: add pre-content fsnotify hook for write
 faults
Message-ID: <20240829111753.3znmdajndwwfwh6n@quack3>
References: <cover.1723670362.git.josef@toxicpanda.com>
 <631039816bbac737db351e3067520e85a8774ba1.1723670362.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <631039816bbac737db351e3067520e85a8774ba1.1723670362.git.josef@toxicpanda.com>
X-Rspamd-Queue-Id: E113B1F381
X-Spam-Level: 
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_COUNT_THREE(0.00)[3];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,toxicpanda.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:dkim];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_CC(0.00)[fb.com,vger.kernel.org,suse.cz,gmail.com,kernel.org,lists.linux.dev,fromorbit.com,infradead.org];
	DKIM_TRACE(0.00)[suse.cz:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.01
X-Spam-Flag: NO

On Wed 14-08-24 17:25:34, Josef Bacik wrote:
> xfs has it's own handling for write faults, so we need to add the
> pre-content fsnotify hook for this case.  Reads go through filemap_fault
> so they're handled properly there.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Looks good to me but it would be great to get explicit ack from some XFS
guy...  Some selection CCed :)

								Honza

> ---
>  fs/xfs/xfs_file.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
> index 4cdc54dc9686..e61c4c389d7d 100644
> --- a/fs/xfs/xfs_file.c
> +++ b/fs/xfs/xfs_file.c
> @@ -1283,6 +1283,10 @@ xfs_write_fault(
>  	unsigned int		lock_mode = XFS_MMAPLOCK_SHARED;
>  	vm_fault_t		ret;
>  
> +	ret = filemap_maybe_emit_fsnotify_event(vmf);
> +	if (unlikely(ret))
> +		return ret;
> +
>  	sb_start_pagefault(inode->i_sb);
>  	file_update_time(vmf->vma->vm_file);
>  
> -- 
> 2.43.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

