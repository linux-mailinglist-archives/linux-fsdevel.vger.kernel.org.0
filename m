Return-Path: <linux-fsdevel+bounces-36267-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 548B59E06CE
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Dec 2024 16:22:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13B55285CA9
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Dec 2024 15:22:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20B5B209F26;
	Mon,  2 Dec 2024 15:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="aCFpRKPO";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="fwoPAxQh";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="aCFpRKPO";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="fwoPAxQh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E3E3209678;
	Mon,  2 Dec 2024 15:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733152719; cv=none; b=QfFMOrcOBTz5y/tntoizCwB1sILjL0E60LIVn1Lz2J/hFsJftbC1J7vvaBcs2TcZ61M4veDn+tX09W2tW/P2gLZtTkqDgzB1BkpJe0n/6oDVI/YQ+cr1wuHRDLwgBZ9hk7mGUzOsDRsxPOiK0YOQ3LYSB4iKGU8AOqo0uKr8bxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733152719; c=relaxed/simple;
	bh=SgsSmK9NWw0xV2OOm4IRpZ7+16GqHms9f3Sqxy5UWyA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EkZA0d8aTqaikoqzB63S2yJYNVCJNLzlCl1/Mn2VT+bMnBZ2JHgpL+KaDj9ZbOS+HZ/oVqFM5OKLJ0mR0T28W/Tij9ENOS7blHsO3VA8e/izuwEawRrQ7hwI9ISuyL6/65sU9RukEMT1Kh9YXaPBfTxY9TmRN41it8lqj89aa50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=aCFpRKPO; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=fwoPAxQh; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=aCFpRKPO; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=fwoPAxQh; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 60F502117B;
	Mon,  2 Dec 2024 15:18:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1733152713; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XPyf2VI3G581l719J1pdyBBm+90iMdhJbVJiT9hNX7k=;
	b=aCFpRKPOAbgFhPvvG1dEL9RfHsBDOPWrX3vEeff+Upvwy53FzF2DE02cCQm4OtY5PUpRop
	gRcAQoRskYO4GGnxBKYLdttJK/Co1QqMXXarFkpZVVH59wJCEO3IRTapmsVtEQkZP+uwuQ
	K6A+XsV/8symM9w5V4LuHF6Eg8ViTRY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1733152713;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XPyf2VI3G581l719J1pdyBBm+90iMdhJbVJiT9hNX7k=;
	b=fwoPAxQhcizH1HkN7CJWJVRxgznPdKgYBzydfwZ0VS9U+H0mt1/1wVuI6jm3Gxjf3n2Pu7
	d4+MzU3sFyjXXjDA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1733152713; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XPyf2VI3G581l719J1pdyBBm+90iMdhJbVJiT9hNX7k=;
	b=aCFpRKPOAbgFhPvvG1dEL9RfHsBDOPWrX3vEeff+Upvwy53FzF2DE02cCQm4OtY5PUpRop
	gRcAQoRskYO4GGnxBKYLdttJK/Co1QqMXXarFkpZVVH59wJCEO3IRTapmsVtEQkZP+uwuQ
	K6A+XsV/8symM9w5V4LuHF6Eg8ViTRY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1733152713;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XPyf2VI3G581l719J1pdyBBm+90iMdhJbVJiT9hNX7k=;
	b=fwoPAxQhcizH1HkN7CJWJVRxgznPdKgYBzydfwZ0VS9U+H0mt1/1wVuI6jm3Gxjf3n2Pu7
	d4+MzU3sFyjXXjDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4EAD2139C2;
	Mon,  2 Dec 2024 15:18:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 8cQxE8nPTWenLgAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 02 Dec 2024 15:18:33 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 9F877A075D; Mon,  2 Dec 2024 16:18:27 +0100 (CET)
Date: Mon, 2 Dec 2024 16:18:27 +0100
From: Jan Kara <jack@suse.cz>
To: Christian Brauner <brauner@kernel.org>
Cc: Erin Shepherd <erin.shepherd@e43.eu>,
	Amir Goldstein <amir73il@gmail.com>,
	Jeff Layton <jlayton@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
	Chuck Lever <chuck.lever@oracle.com>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-nfs@vger.kernel.org
Subject: Re: [PATCH RFC v2 2/3] pidfs: remove 32bit inode number handling
Message-ID: <20241202151827.tmdvf6hyliyksz6o@quack3>
References: <20241129-work-pidfs-v2-0-61043d66fbce@kernel.org>
 <20241129-work-pidfs-v2-2-61043d66fbce@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241129-work-pidfs-v2-2-61043d66fbce@kernel.org>
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
	RCPT_COUNT_SEVEN(0.00)[10];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[e43.eu,gmail.com,kernel.org,zeniv.linux.org.uk,suse.cz,oracle.com,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:email,suse.com:email]
X-Spam-Flag: NO
X-Spam-Level: 

On Fri 29-11-24 14:02:24, Christian Brauner wrote:
> Now that we have a unified inode number handling model remove the custom
> ida-based allocation for 32bit.
> 
> Signed-off-by: Christian Brauner <brauner@kernel.org>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/pidfs.c | 46 +++++-----------------------------------------
>  1 file changed, 5 insertions(+), 41 deletions(-)
> 
> diff --git a/fs/pidfs.c b/fs/pidfs.c
> index 0bdd9c525b80895d33f2eae5e8e375788580072f..ff4f25078f3d983bce630e597adbb12262e5d727 100644
> --- a/fs/pidfs.c
> +++ b/fs/pidfs.c
> @@ -371,40 +371,6 @@ struct pid *pidfd_pid(const struct file *file)
>  
>  static struct vfsmount *pidfs_mnt __ro_after_init;
>  
> -#if BITS_PER_LONG == 32
> -/*
> - * Provide a fallback mechanism for 32-bit systems so processes remain
> - * reliably comparable by inode number even on those systems.
> - */
> -static DEFINE_IDA(pidfd_inum_ida);
> -
> -static int pidfs_inum(struct pid *pid, unsigned long *ino)
> -{
> -	int ret;
> -
> -	ret = ida_alloc_range(&pidfd_inum_ida, RESERVED_PIDS + 1,
> -			      UINT_MAX, GFP_ATOMIC);
> -	if (ret < 0)
> -		return -ENOSPC;
> -
> -	*ino = ret;
> -	return 0;
> -}
> -
> -static inline void pidfs_free_inum(unsigned long ino)
> -{
> -	if (ino > 0)
> -		ida_free(&pidfd_inum_ida, ino);
> -}
> -#else
> -static inline int pidfs_inum(struct pid *pid, unsigned long *ino)
> -{
> -	*ino = pid->ino;
> -	return 0;
> -}
> -#define pidfs_free_inum(ino) ((void)(ino))
> -#endif
> -
>  /*
>   * The vfs falls back to simple_setattr() if i_op->setattr() isn't
>   * implemented. Let's reject it completely until we have a clean
> @@ -456,7 +422,6 @@ static void pidfs_evict_inode(struct inode *inode)
>  
>  	clear_inode(inode);
>  	put_pid(pid);
> -	pidfs_free_inum(inode->i_ino);
>  }
>  
>  static const struct super_operations pidfs_sops = {
> @@ -482,17 +447,16 @@ static const struct dentry_operations pidfs_dentry_operations = {
>  
>  static int pidfs_init_inode(struct inode *inode, void *data)
>  {
> +	struct pid *pid = data;
> +
>  	inode->i_private = data;
>  	inode->i_flags |= S_PRIVATE;
>  	inode->i_mode |= S_IRWXU;
>  	inode->i_op = &pidfs_inode_operations;
>  	inode->i_fop = &pidfs_file_operations;
> -	/*
> -	 * Inode numbering for pidfs start at RESERVED_PIDS + 1. This
> -	 * avoids collisions with the root inode which is 1 for pseudo
> -	 * filesystems.
> -	 */
> -	return pidfs_inum(data, &inode->i_ino);
> +	inode->i_ino = pidfs_ino(pid->ino);
> +	inode->i_generation = pidfs_gen(pid->ino);
> +	return 0;
>  }
>  
>  static void pidfs_put_data(void *data)
> 
> -- 
> 2.45.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

