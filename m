Return-Path: <linux-fsdevel+bounces-52053-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CAE81ADF1EE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Jun 2025 17:55:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31D2B3BE418
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Jun 2025 15:54:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF7D72F0C5D;
	Wed, 18 Jun 2025 15:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="I1Dwi2Sl";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="8q158R3q";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="N02d8wrE";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="zG2QNNIr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B195C2F0C44
	for <linux-fsdevel@vger.kernel.org>; Wed, 18 Jun 2025 15:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750261919; cv=none; b=haZWcP7X5ezmOYRIWpZZgg6VF5dKC8cmQAJbvUVA7Zj6AKktm8qJ0Sq1CcpVrNyk8DRw5f1YzbWVVxGygu3DVaFBSx6PUuk+OAYKT9wEUhubWPHA4sSJhI9uSw6NK6+CHZRFh88izJiOF1BJh0J0ujzGb+RBr5An9Zzvp/c4k8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750261919; c=relaxed/simple;
	bh=IRtN+C4MaJ4BXC4TU1mTp+0mnH4Mq2+erd7ASTUs7SA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZxIvZILaAQ0Oxee2UuUzlYMOLM2wVU1pZNS/HtcWkgXdWyKsz8s/ez7dLkNVSk+Mj4yaVnrJFCMQ/Z3Kc5q0DIm1r5enNiFJGwiogls9ku0qu1iE/TXh/NYVMEh8e3gXj5fkslyTFDwYshfsMqBXKItnbBwHhtMRrQWTt2ekViY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=I1Dwi2Sl; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=8q158R3q; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=N02d8wrE; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=zG2QNNIr; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C68181F7BD;
	Wed, 18 Jun 2025 15:51:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1750261916; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7UqDQB1zAPllsLbnD6/8g+1Q56+FK8bOCj8Iq/HNUGM=;
	b=I1Dwi2SlTcs0s2Yov8Iic3S8Er5qpDzRDXtZtuUp60cl9mFhEBkPrawhDU8P5kQVWAMVHM
	JMTsoPey2HmDBwd0YiJ45c7lEzfvFy2ttdLJFNiDI0ZI7kTKLF0lMD8FJDZRlXv99xtjE4
	O8U5NqwyMswwp4r+2+wFXYesQB0vhO4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1750261916;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7UqDQB1zAPllsLbnD6/8g+1Q56+FK8bOCj8Iq/HNUGM=;
	b=8q158R3qAcYMUvUWbKFqsdTnaVxzu5kyFuPBh3D3iVSYEOQnfRD855+xhnUY5YYLg7LinK
	Cp2uolNwXYH5uzAA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=N02d8wrE;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=zG2QNNIr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1750261915; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7UqDQB1zAPllsLbnD6/8g+1Q56+FK8bOCj8Iq/HNUGM=;
	b=N02d8wrEFrKgtTby4DHEznyb8gxITSZQ/V+He23Ft356gUk/TgDb0TM57mSz5zPvjYI/EW
	sjLv1vz6R1nMH9j3vh0YG5H7BR3XaWxjBGtHXZOoN+YqBUJSBQ9cS2naNuoQRvHAHruqv+
	OAt0jBziN66uZstyaLHzgNCRQUzX1rI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1750261915;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7UqDQB1zAPllsLbnD6/8g+1Q56+FK8bOCj8Iq/HNUGM=;
	b=zG2QNNIrwTjKHIMjRpam9gXUIpjoFn6tK9+QuQpTH85ycYQS2mJNDEbxH4uxo0rincfWq4
	b/gRdydAs17oOdDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B3DB613A3F;
	Wed, 18 Jun 2025 15:51:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 2HKiK5vgUmgNGgAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 18 Jun 2025 15:51:55 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 56AA4A09DC; Wed, 18 Jun 2025 17:51:55 +0200 (CEST)
Date: Wed, 18 Jun 2025 17:51:55 +0200
From: Jan Kara <jack@suse.cz>
To: alexjlzheng@gmail.com
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Jinliang Zheng <alexjlzheng@tencent.com>, Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH] fs: fix the missing export of vfs_statx() and
 vfs_fstatat()
Message-ID: <z6fahv4cjyelnqry3wozfktorwiyokh5vxg6d34iiblp4wimpu@uq3of5u7d65r>
References: <20250618121429.188696-1-alexjlzheng@tencent.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250618121429.188696-1-alexjlzheng@tencent.com>
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
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.cz:+];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email]
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: C68181F7BD
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Score: -4.01


CCed Christoph who was the original author of the patch.

On Wed 18-06-25 20:14:29, alexjlzheng@gmail.com wrote:
> From: Jinliang Zheng <alexjlzheng@tencent.com>
> 
> After commit 09f1bde4017e ("fs: move vfs_fstatat out of line"), the two
> symbols vfs_statx() and vfs_fstatat() are no longer visible to the kernel
> module.
> 
> The above patches does not explain why the export of these two symbols is
> stopped, and exporting these two kernel symbols does not affect the
> functionality of the above patch.
> 
> In fact, getting the length of a file in a kernel module is a useful
> operation. For example, some kernel modules used for security hardening may
> need to know the length of a file in order to read it into memory for
> verification.
> 
> There is no reason to prohibit kernel module developers from doing this.
> So this patch fixes that by reexporting vfs_statx() and vfs_fstatat().
> 
> Fixes: 09f1bde4017e ("fs: move vfs_fstatat out of line")
> Signed-off-by: Jinliang Zheng <alexjlzheng@tencent.com>

Well, we don't export symbols just because they might be useful. Usually we
require *in tree* users of the interface to export a symbol. You apparently
have an out of tree module that was using these functions and 09f1bde4017e
broke it. Keeping things out of tree is your choice but why should we care
and support you in working outside of a community?

								Honza

> ---
>  fs/stat.c          | 4 +++-
>  include/linux/fs.h | 2 ++
>  2 files changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/stat.c b/fs/stat.c
> index f95c1dc3eaa4..e844a1a076d7 100644
> --- a/fs/stat.c
> +++ b/fs/stat.c
> @@ -338,7 +338,7 @@ static int vfs_statx_fd(int fd, int flags, struct kstat *stat,
>   *
>   * 0 will be returned on success, and a -ve error code if unsuccessful.
>   */
> -static int vfs_statx(int dfd, struct filename *filename, int flags,
> +int vfs_statx(int dfd, struct filename *filename, int flags,
>  	      struct kstat *stat, u32 request_mask)
>  {
>  	struct path path;
> @@ -361,6 +361,7 @@ static int vfs_statx(int dfd, struct filename *filename, int flags,
>  	}
>  	return error;
>  }
> +EXPORT_SYMBOL(vfs_statx);
>  
>  int vfs_fstatat(int dfd, const char __user *filename,
>  			      struct kstat *stat, int flags)
> @@ -377,6 +378,7 @@ int vfs_fstatat(int dfd, const char __user *filename,
>  
>  	return ret;
>  }
> +EXPORT_SYMBOL(vfs_fstatat);
>  
>  #ifdef __ARCH_WANT_OLD_STAT
>  
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index b085f161ed22..c9497da6b459 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -3550,6 +3550,8 @@ extern const struct inode_operations simple_symlink_inode_operations;
>  
>  extern int iterate_dir(struct file *, struct dir_context *);
>  
> +int vfs_statx(int dfd, struct filename *filename, int flags,
> +		struct kstat *stat, u32 request_mask);
>  int vfs_fstatat(int dfd, const char __user *filename, struct kstat *stat,
>  		int flags);
>  int vfs_fstat(int fd, struct kstat *stat);
> -- 
> 2.49.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

