Return-Path: <linux-fsdevel+bounces-63600-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 308A4BC5359
	for <lists+linux-fsdevel@lfdr.de>; Wed, 08 Oct 2025 15:30:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E7204404148
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Oct 2025 13:30:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3BCA2853F3;
	Wed,  8 Oct 2025 13:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ERiBPC4R";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="0+d2kfBV";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ERiBPC4R";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="0+d2kfBV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71410284B4C
	for <linux-fsdevel@vger.kernel.org>; Wed,  8 Oct 2025 13:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759930217; cv=none; b=PxE1g6YQ71dF6rCZOBCxy8lSKQglfY+gXR7jDIDJAq/aDLr805AMTw4mwXpRfzv8HKv3VQqCKLwVS5SG/L8DBwVUlEzy+YalTAq6LpBVEcyhbYNaQVSBQT7lGhuwWL/E1yy2WPKvzeX2xZuakQeVOf48aiRkkhljF8Sx8e+OZ8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759930217; c=relaxed/simple;
	bh=JAV9YNPTJurVRSBklkA9ylzWGRvSqkYzD3mUthW0wWo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VWWQHbTZ1nAP0PAJ2eBo95KbLNGhMini5UOTuNJgP1IK67KZ0nOQd5cbmaRKxL19+vIKrBnG4w7mIbSU0B6XjAsHbmmdezPyLoEi2RyW7MLl/uG0Zz//8HiLjifKQhaiCbOq3Qp9O5PHHZW2kYl8s2O1+bfRa123p+YXcwr4JD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ERiBPC4R; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=0+d2kfBV; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ERiBPC4R; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=0+d2kfBV; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 8981E1F749;
	Wed,  8 Oct 2025 13:30:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1759930213; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=T4rnDYwaSQNqffCBVJUKVYTPRoYetxR8JIPOFMBsmtg=;
	b=ERiBPC4RHBqbylSDV6TWYvLUFzeSds1Uz7ve+VOnDT5B37Xgn3nevZOHPs2oIXYCtg1S2X
	TwHYODL5Y1Bram6MvzBkK1wCt3bY/SbVByXSGpclmYOVxv9Rs9jm4lX6uHlkn5PiiZkkJ1
	PFn4ITk0Sr2IVtudlOPwYgQQDav45/4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1759930213;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=T4rnDYwaSQNqffCBVJUKVYTPRoYetxR8JIPOFMBsmtg=;
	b=0+d2kfBVguqcbBDwoQ1Snm0NMTrB+hUH1QnxOG7CIP4X4Xl2Q1WEHamaX1v/sGrBtvRxau
	VYssNojel5GbIoBg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=ERiBPC4R;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=0+d2kfBV
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1759930213; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=T4rnDYwaSQNqffCBVJUKVYTPRoYetxR8JIPOFMBsmtg=;
	b=ERiBPC4RHBqbylSDV6TWYvLUFzeSds1Uz7ve+VOnDT5B37Xgn3nevZOHPs2oIXYCtg1S2X
	TwHYODL5Y1Bram6MvzBkK1wCt3bY/SbVByXSGpclmYOVxv9Rs9jm4lX6uHlkn5PiiZkkJ1
	PFn4ITk0Sr2IVtudlOPwYgQQDav45/4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1759930213;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=T4rnDYwaSQNqffCBVJUKVYTPRoYetxR8JIPOFMBsmtg=;
	b=0+d2kfBVguqcbBDwoQ1Snm0NMTrB+hUH1QnxOG7CIP4X4Xl2Q1WEHamaX1v/sGrBtvRxau
	VYssNojel5GbIoBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 73A6013693;
	Wed,  8 Oct 2025 13:30:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id N2Y3HGVn5mirUQAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 08 Oct 2025 13:30:13 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 16B70A0AB6; Wed,  8 Oct 2025 15:30:13 +0200 (CEST)
Date: Wed, 8 Oct 2025 15:30:13 +0200
From: Jan Kara <jack@suse.cz>
To: Andrey Albershteyn <aalbersh@redhat.com>
Cc: linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org, Jan Kara <jack@suse.cz>, 
	Jiri Slaby <jirislaby@kernel.org>, Christian Brauner <brauner@kernel.org>, 
	Arnd Bergmann <arnd@arndb.de>, Andrey Albershteyn <aalbersh@kernel.org>
Subject: Re: [PATCH 2/2] fs: return EOPNOTSUPP from file_setattr/file_getattr
 syscalls
Message-ID: <l6nkfnblncs4qjubnbqbol6xddmt5jsbmqb7s4n76owg2co4br@f2mntpq2vszu>
References: <20251008-eopnosupp-fix-v1-0-5990de009c9f@kernel.org>
 <20251008-eopnosupp-fix-v1-2-5990de009c9f@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251008-eopnosupp-fix-v1-2-5990de009c9f@kernel.org>
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 8981E1F749
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.cz:dkim,suse.cz:email,suse.com:email];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Spam-Score: -4.01

On Wed 08-10-25 14:44:18, Andrey Albershteyn wrote:
> These syscalls call to vfs_fileattr_get/set functions which return
> ENOIOCTLCMD if filesystem doesn't support setting file attribute on an
> inode. For syscalls EOPNOTSUPP would be more appropriate return error.
> 
> Signed-off-by: Andrey Albershteyn <aalbersh@kernel.org>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/file_attr.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/fs/file_attr.c b/fs/file_attr.c
> index 460b2dd21a85..5e3e2aba97b5 100644
> --- a/fs/file_attr.c
> +++ b/fs/file_attr.c
> @@ -416,6 +416,8 @@ SYSCALL_DEFINE5(file_getattr, int, dfd, const char __user *, filename,
>  	}
>  
>  	error = vfs_fileattr_get(filepath.dentry, &fa);
> +	if (error == -ENOIOCTLCMD)
> +		error = -EOPNOTSUPP;
>  	if (error)
>  		return error;
>  
> @@ -483,6 +485,8 @@ SYSCALL_DEFINE5(file_setattr, int, dfd, const char __user *, filename,
>  	if (!error) {
>  		error = vfs_fileattr_set(mnt_idmap(filepath.mnt),
>  					 filepath.dentry, &fa);
> +		if (error == -ENOIOCTLCMD)
> +			error = -EOPNOTSUPP;
>  		mnt_drop_write(filepath.mnt);
>  	}
>  
> 
> -- 
> 2.51.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

