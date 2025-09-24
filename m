Return-Path: <linux-fsdevel+bounces-62570-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29EDAB99A1F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Sep 2025 13:45:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 85C40323057
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Sep 2025 11:45:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3B3A2FFDDE;
	Wed, 24 Sep 2025 11:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Jh8c1K4S";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="C7vL6spw";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="MIpKcCJw";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="kN1hFlA+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24E362FE052
	for <linux-fsdevel@vger.kernel.org>; Wed, 24 Sep 2025 11:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758714290; cv=none; b=hbINYu9SlrNAidM0EcivChLdEvp/QhiR+moM7lLJ7qcbBgGNGAHpy8qf8C/rXEm7a/j63UNqtG3WhHvhiJ44EF44jvFzS26RtoN+E+byK7jYEkg/yaGIhutkVtRaSE8OK0sBmrZ7Wgwjo0N5M/VacgTnG4ZcT/hSL9rNOlfxrV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758714290; c=relaxed/simple;
	bh=ZF/2YJf/3hk1WnFFGmKp58iB33fSlI9ga1Ks8oQhQDE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VBdxM+3fGY+rP3jdLcnjCls5ssPzL+6VF/X1Dc+cSyK+33BBgzCsoRwziSNzDVjNZDGgqQmcv3d2U6ohmjefQlEHqDYBTt+sSaZCUWzTdEKMOVCZ0M91bEYyi0BfTbq8camZ2hXeFVe2bGlR8DvZPv/en4c6lbwZo844rp7xtbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Jh8c1K4S; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=C7vL6spw; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=MIpKcCJw; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=kN1hFlA+; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 34A9A339E6;
	Wed, 24 Sep 2025 11:44:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1758714283; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4K7nLBghDQ+hhXNa2jMGJw9MQn/kd43m81nuCAHG3rs=;
	b=Jh8c1K4S3uWfZtKGbEfX1f26/hWL/2WIAbJk39kA3nG0KNjSPPC7NGlB/t1Ao4xZw6zBtf
	lhgi1UO2XkMBuV39bplBbOhxfRltdV3OdQ+XTQqZlnqJuzX5CnQbF2VbXh+WD3XjZlkyls
	WZz+dNx0QUkaBMHEdfkW39FZFw5VmeM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1758714283;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4K7nLBghDQ+hhXNa2jMGJw9MQn/kd43m81nuCAHG3rs=;
	b=C7vL6spwXTX+BAa1MWnxNjRkEiqLl8ciZT+rX1B/6l72YcR+mxcnIfJKGnLFlhzRFKT51S
	swU2PHReuTXKWRDg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=MIpKcCJw;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=kN1hFlA+
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1758714282; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4K7nLBghDQ+hhXNa2jMGJw9MQn/kd43m81nuCAHG3rs=;
	b=MIpKcCJw6C3fNGBFTcAto1fC14pfBH7HhsyQc3KxYXVnG3oJdQ9JBTrdmKGon4qO4hW9kU
	tM07smMTR6GytOzwKjmNNoZKhcCGMJm3pxcSc+nd+aA/Y/ayz7QNX5ZD1KYAuIZP2cY0Qy
	utmbDcuklyQ92dFzNYK9ia69AwUgBTA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1758714282;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4K7nLBghDQ+hhXNa2jMGJw9MQn/kd43m81nuCAHG3rs=;
	b=kN1hFlA+DeA7ARQvzk9IgMKe/6BLzq6UMRHuk88nu22EA2jbjEpg/MV5kbEAPwwbFYRYB1
	skxwFFzcNZnsOODQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2915013ACB;
	Wed, 24 Sep 2025 11:44:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id MGHACarZ02hYQwAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 24 Sep 2025 11:44:42 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id D91ACA0A9A; Wed, 24 Sep 2025 13:44:41 +0200 (CEST)
Date: Wed, 24 Sep 2025 13:44:41 +0200
From: Jan Kara <jack@suse.cz>
To: Deepanshu Kartikey <kartikey406@gmail.com>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzbot+9eefe09bedd093f156c2@syzkaller.appspotmail.com
Subject: Re: [PATCH v2] nsfs: handle inode number mismatches gracefully in
 file handles
Message-ID: <2zwxsyxcz7qcm2fpbxjqfolik3he6kq4amtx4qrbsabsv7huoi@xjbd2sqhkysx>
References: <20250924113745.1262174-1-kartikey406@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250924113745.1262174-1-kartikey406@gmail.com>
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 34A9A339E6
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-2.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FREEMAIL_TO(0.00)[gmail.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	RCPT_COUNT_SEVEN(0.00)[7];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[9eefe09bedd093f156c2];
	DKIM_TRACE(0.00)[suse.cz:+];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email]
X-Spam-Score: -2.51

On Wed 24-09-25 17:07:45, Deepanshu Kartikey wrote:
> Replace VFS_WARN_ON_ONCE() with graceful error handling when file
> handles contain inode numbers that don't match the actual namespace
> inode. This prevents userspace from triggering kernel warnings by
> providing malformed file handles to open_by_handle_at().
> 
> The issue occurs when userspace provides a file handle with valid
> namespace type and ID that successfully locates a namespace, but
> specifies an incorrect inode number. Previously, this would trigger
> VFS_WARN_ON_ONCE() when comparing the real inode number against the
> provided value.
> 
> Since file handle data is user-controllable, inode number mismatches
> should be treated as invalid input rather than kernel consistency
> errors. Handle this case by returning NULL to indicate the file
> handle is invalid, rather than warning about what is essentially
> user input validation.
> 
> Changes in v2:
> - Handle all inode number mismatches, not just zero, as suggested by Jan Kara
> - Replace warning with graceful error handling for better architecture

This 'Changes' bit belongs below the diffstat (so that it doesn't get
included in git commit log). Otherwise looks good so feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> 
> Reported-by: syzbot+9eefe09bedd093f156c2@syzkaller.appspotmail.com
> Suggested-by: Jan Kara <jack@suse.cz>
> Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>
> ---
>  fs/nsfs.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/nsfs.c b/fs/nsfs.c
> index 32cb8c835a2b..002d424d9fa6 100644
> --- a/fs/nsfs.c
> +++ b/fs/nsfs.c
> @@ -490,8 +490,9 @@ static struct dentry *nsfs_fh_to_dentry(struct super_block *sb, struct fid *fh,
>  
>  		VFS_WARN_ON_ONCE(ns->ns_id != fid->ns_id);
>  		VFS_WARN_ON_ONCE(ns->ops->type != fid->ns_type);
> -		VFS_WARN_ON_ONCE(ns->inum != fid->ns_inum);
> -
> +		/* Someone is playing games and passing invalid file handles? */
> +		if (ns->inum != fid->ns_inum)
> +			return NULL;
>  		if (!refcount_inc_not_zero(&ns->count))
>  			return NULL;
>  	}
> -- 
> 2.43.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

