Return-Path: <linux-fsdevel+bounces-52543-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EB605AE3F8F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jun 2025 14:19:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2FCB6189A95F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jun 2025 12:15:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78186256C9B;
	Mon, 23 Jun 2025 12:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="EBtTz4D7";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="agQuUpmX";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="EBtTz4D7";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="agQuUpmX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C279256C83
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Jun 2025 12:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750680412; cv=none; b=bnZyG8JXN54qcikDjiL26TAouH6zVBQixvEar4Cf0INW6EL5Zdfq/u80LNV3LBG6kWgUcQ2D1BHUzyHChyvhNEMhLdJdZ3pyzX1aF4/s7ZTWeguVqlzduxCLS9X40Zy1pjOx1fQWfeesWsh2WvFPvwFYk9jEer+xy+Du5xUsO2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750680412; c=relaxed/simple;
	bh=eRBpge3Uo6AkmH+3p+XhL0aABDcQ4Dvlv2Wuqfuxqc8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DYcZ61oktJ3d3K1tfBi8kF6DGCq0fEBQkshYGokKIikg9YbqQ60iBI6fyTTnc0AbsDF39p0Q4EKCxHHrCsV/A94ouqLzl1xt48+WtMsd3Ew42Cl1caBWl2r1Txi218zMETjjelhJY8RnoYFFjaUpL7LwbXU3lsGmAUJTZUYOqiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=EBtTz4D7; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=agQuUpmX; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=EBtTz4D7; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=agQuUpmX; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 6DDB61F385;
	Mon, 23 Jun 2025 12:06:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1750680409; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TTuhtGZ/LP0xSob7zcIuPgURB+LZRPEtKbMFQM6z2o4=;
	b=EBtTz4D7UsIm/BCJumqOqKQDoVL/Ktr2V48oJw2mmRhOVBUBEUBwxAhsVheTy9ZKrblZXU
	Zm8GSl354E31Nui9MOmRcbXiaVqgPqC7UTkoPM7PJKNnLXj2qGZ+ItUzpYo4ElNK6RCUp9
	ylgFzxish584VEfh8xKbA1syOCGEgug=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1750680409;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TTuhtGZ/LP0xSob7zcIuPgURB+LZRPEtKbMFQM6z2o4=;
	b=agQuUpmXYhhdz+QzBIHIk6vVln/BtFvm241AlVXzbutmU6HPo/VXlUbXidtVQCGsxpHyUK
	w0SWhdCY8h4Ka3AA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=EBtTz4D7;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=agQuUpmX
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1750680409; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TTuhtGZ/LP0xSob7zcIuPgURB+LZRPEtKbMFQM6z2o4=;
	b=EBtTz4D7UsIm/BCJumqOqKQDoVL/Ktr2V48oJw2mmRhOVBUBEUBwxAhsVheTy9ZKrblZXU
	Zm8GSl354E31Nui9MOmRcbXiaVqgPqC7UTkoPM7PJKNnLXj2qGZ+ItUzpYo4ElNK6RCUp9
	ylgFzxish584VEfh8xKbA1syOCGEgug=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1750680409;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TTuhtGZ/LP0xSob7zcIuPgURB+LZRPEtKbMFQM6z2o4=;
	b=agQuUpmXYhhdz+QzBIHIk6vVln/BtFvm241AlVXzbutmU6HPo/VXlUbXidtVQCGsxpHyUK
	w0SWhdCY8h4Ka3AA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 370B313485;
	Mon, 23 Jun 2025 12:06:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id hwVqDVlDWWg6OwAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 23 Jun 2025 12:06:49 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 611C4A0951; Mon, 23 Jun 2025 14:06:43 +0200 (CEST)
Date: Mon, 23 Jun 2025 14:06:43 +0200
From: Jan Kara <jack@suse.cz>
To: Christian Brauner <brauner@kernel.org>
Cc: Jeff Layton <jlayton@kernel.org>, Chuck Lever <chuck.lever@oracle.com>, 
	Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org
Subject: Re: [PATCH 8/9] fhandle, pidfs: support open_by_handle_at() purely
 based on file handle
Message-ID: <ipk5yr7xxdmesql6wqzlbs734jjvn3had5vzqrck6e2ke4zanu@6sotvp4bd5lu>
References: <20250623-work-pidfs-fhandle-v1-0-75899d67555f@kernel.org>
 <20250623-work-pidfs-fhandle-v1-8-75899d67555f@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250623-work-pidfs-fhandle-v1-8-75899d67555f@kernel.org>
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_SEVEN(0.00)[8];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,oracle.com,suse.cz,gmail.com,ffwll.ch,vger.kernel.org];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 6DDB61F385
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Score: -4.01

On Mon 23-06-25 11:01:30, Christian Brauner wrote:
> Various filesystems such as pidfs (and likely drm in the future) have a
> use-case to support opening files purely based on the handle without
> having to require a file descriptor to another object. That's especially
> the case for filesystems that don't do any lookup whatsoever and there's
> zero relationship between the objects. Such filesystems are also
> singletons that stay around for the lifetime of the system meaning that
> they can be uniquely identified and accessed purely based on the file
> handle type. Enable that so that userspace doesn't have to allocate an
> object needlessly especially if they can't do that for whatever reason.
> 
> Signed-off-by: Christian Brauner <brauner@kernel.org>

Hmm, maybe we should predefine some invalid fd value userspace should pass
when it wants to "autopick" fs root? Otherwise defining more special fd
values like AT_FDCWD would become difficult in the future. Or we could just
define that FILEID_PIDFS file handles *always* ignore the fd value and
auto-pick the root.

								Honza

> ---
>  fs/fhandle.c | 19 +++++++++++++++++--
>  fs/pidfs.c   |  5 ++++-
>  2 files changed, 21 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/fhandle.c b/fs/fhandle.c
> index ab4891925b52..20d6477b5a9e 100644
> --- a/fs/fhandle.c
> +++ b/fs/fhandle.c
> @@ -173,7 +173,7 @@ SYSCALL_DEFINE5(name_to_handle_at, int, dfd, const char __user *, name,
>  	return err;
>  }
>  
> -static int get_path_anchor(int fd, struct path *root)
> +static int get_path_anchor(int fd, struct path *root, int handle_type)
>  {
>  	if (fd >= 0) {
>  		CLASS(fd, f)(fd);
> @@ -193,6 +193,21 @@ static int get_path_anchor(int fd, struct path *root)
>  		return 0;
>  	}
>  
> +	/*
> +	 * Only autonomous handles can be decoded without a file
> +	 * descriptor.
> +	 */
> +	if (!(handle_type & FILEID_IS_AUTONOMOUS))
> +		return -EOPNOTSUPP;
> +
> +	switch (handle_type & ~FILEID_USER_FLAGS_MASK) {
> +	case FILEID_PIDFS:
> +		pidfs_get_root(root);
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
>  	return 0;
>  }
>  
> @@ -347,7 +362,7 @@ static int handle_to_path(int mountdirfd, struct file_handle __user *ufh,
>  	    FILEID_USER_FLAGS(f_handle.handle_type) & ~FILEID_VALID_USER_FLAGS)
>  		return -EINVAL;
>  
> -	retval = get_path_anchor(mountdirfd, &ctx.root);
> +	retval = get_path_anchor(mountdirfd, &ctx.root, f_handle.handle_type);
>  	if (retval)
>  		return retval;
>  
> diff --git a/fs/pidfs.c b/fs/pidfs.c
> index 1b7bd14366dc..ea50a6afc325 100644
> --- a/fs/pidfs.c
> +++ b/fs/pidfs.c
> @@ -747,7 +747,7 @@ static int pidfs_encode_fh(struct inode *inode, u32 *fh, int *max_len,
>  
>  	*max_len = 2;
>  	*(u64 *)fh = pid->ino;
> -	return FILEID_KERNFS;
> +	return FILEID_PIDFS;
>  }
>  
>  static int pidfs_ino_find(const void *key, const struct rb_node *node)
> @@ -802,6 +802,8 @@ static struct dentry *pidfs_fh_to_dentry(struct super_block *sb,
>  		return NULL;
>  
>  	switch (fh_type) {
> +	case FILEID_PIDFS:
> +		fallthrough;
>  	case FILEID_KERNFS:
>  		pid_ino = *(u64 *)fid;
>  		break;
> @@ -860,6 +862,7 @@ static const struct export_operations pidfs_export_operations = {
>  	.fh_to_dentry	= pidfs_fh_to_dentry,
>  	.open		= pidfs_export_open,
>  	.permission	= pidfs_export_permission,
> +	.flags		= EXPORT_OP_AUTONOMOUS_HANDLES,
>  };
>  
>  static int pidfs_init_inode(struct inode *inode, void *data)
> 
> -- 
> 2.47.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

