Return-Path: <linux-fsdevel+bounces-78710-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6KkkJhODoWkUtgQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78710-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Feb 2026 12:42:11 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C2DB71B6B30
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Feb 2026 12:42:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8569A3004DB9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Feb 2026 11:42:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 185FA3F0740;
	Fri, 27 Feb 2026 11:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="cSjyoIKI";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="elIMZTPm";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="cSjyoIKI";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="elIMZTPm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DC6A3EF0C5
	for <linux-fsdevel@vger.kernel.org>; Fri, 27 Feb 2026 11:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772192518; cv=none; b=TPoYliUvbC6cZ3DW/gxS9nE6qgNgwg/jiIeqRoaOhiQV2xTzGuXgrUDjHRRn9zguVSjWDJxt1F8eUrhaytOZT1i6F/YT79U9/JhPxtWUItZM+MEXTobGIRsADapnSUmcPaQBj7LezxRrfYqRduT+kH6so3a7xE6+vnSpg2WfXT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772192518; c=relaxed/simple;
	bh=LbrigWaHvmkMXMNudVpLJL8UB+jaWE2b0Ata+HOOfgM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sHQCW0OULXWqm1axDVXzhnoU3+59WLnXzahO6wbCAU0oLuemvLNpAIlC3WZjF9fdVlSS9IpJaVQATR3lza1ID+0LDggf58V5cShPYJlSFlt9d1qldx0X5ZrNnPDWvuQDExF82sgWEACnJtbJa1n4Y+TWhOw5pvwdPetHuY6XnQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=cSjyoIKI; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=elIMZTPm; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=cSjyoIKI; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=elIMZTPm; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 6206C5BDF8;
	Fri, 27 Feb 2026 11:41:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1772192515; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qG12wiRKgOO8u6RwbR07pPBNuzGPcHJrzObmSnVBirc=;
	b=cSjyoIKIty/awpt3O32urHzlZlUQu2NaAOCW3XksWm06aD8kLLEbgmOTr5URu6RiHklbOV
	wz8Y6pd1irWDENggWsYsFyP2uZCrCML9OYgv5zcZFBrQC5o9kAf9ZWABGYuSN93xShGila
	XXe3DT7f14Wjq1L9DW+TX1hcWY9QPBY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1772192515;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qG12wiRKgOO8u6RwbR07pPBNuzGPcHJrzObmSnVBirc=;
	b=elIMZTPm3jz519UETh+ceoCo6aCdtsSYUoDF6WEAj6aLwLnTy/GO7sekbaWUo80Br4+FkE
	Fqb1EIr3jYh3qBDg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1772192515; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qG12wiRKgOO8u6RwbR07pPBNuzGPcHJrzObmSnVBirc=;
	b=cSjyoIKIty/awpt3O32urHzlZlUQu2NaAOCW3XksWm06aD8kLLEbgmOTr5URu6RiHklbOV
	wz8Y6pd1irWDENggWsYsFyP2uZCrCML9OYgv5zcZFBrQC5o9kAf9ZWABGYuSN93xShGila
	XXe3DT7f14Wjq1L9DW+TX1hcWY9QPBY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1772192515;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qG12wiRKgOO8u6RwbR07pPBNuzGPcHJrzObmSnVBirc=;
	b=elIMZTPm3jz519UETh+ceoCo6aCdtsSYUoDF6WEAj6aLwLnTy/GO7sekbaWUo80Br4+FkE
	Fqb1EIr3jYh3qBDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 480063EA69;
	Fri, 27 Feb 2026 11:41:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id FE2REQODoWmSNwAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 27 Feb 2026 11:41:55 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 0D67EA06D4; Fri, 27 Feb 2026 12:41:55 +0100 (CET)
Date: Fri, 27 Feb 2026 12:41:55 +0100
From: Jan Kara <jack@suse.cz>
To: Chuck Lever <cel@kernel.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
	linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org, linux-cifs@vger.kernel.org, 
	linux-nfs@vger.kernel.org, linux-api@vger.kernel.org, 
	linux-f2fs-devel@lists.sourceforge.net, hirofumi@mail.parknet.co.jp, linkinjeon@kernel.org, 
	sj1557.seo@samsung.com, yuezhang.mo@sony.com, almaz.alexandrovich@paragon-software.com, 
	slava@dubeyko.com, glaubitz@physik.fu-berlin.de, frank.li@vivo.com, tytso@mit.edu, 
	adilger.kernel@dilger.ca, cem@kernel.org, sfrench@samba.org, pc@manguebit.org, 
	ronniesahlberg@gmail.com, sprasad@microsoft.com, trondmy@kernel.org, anna@kernel.org, 
	jaegeuk@kernel.org, chao@kernel.org, hansg@kernel.org, senozhatsky@chromium.org, 
	Chuck Lever <chuck.lever@oracle.com>
Subject: Re: [PATCH v8 03/17] fat: Implement fileattr_get for case sensitivity
Message-ID: <ua7rmlnvbfiadpxeynekbabwqebhcop3rhaxji7s3mgnwzhhtd@frz77j6wm2eg>
References: <20260217214741.1928576-1-cel@kernel.org>
 <20260217214741.1928576-4-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260217214741.1928576-4-cel@kernel.org>
X-Spam-Score: -3.80
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-78710-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,suse.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,suse.cz:email,suse.cz:dkim];
	DMARC_NA(0.00)[suse.cz];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[zeniv.linux.org.uk,kernel.org,suse.cz,vger.kernel.org,lists.sourceforge.net,mail.parknet.co.jp,samsung.com,sony.com,paragon-software.com,dubeyko.com,physik.fu-berlin.de,vivo.com,mit.edu,dilger.ca,samba.org,manguebit.org,gmail.com,microsoft.com,chromium.org,oracle.com];
	RCPT_COUNT_TWELVE(0.00)[33];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[suse.cz:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jack@suse.cz,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: C2DB71B6B30
X-Rspamd-Action: no action

On Tue 17-02-26 16:47:27, Chuck Lever wrote:
> From: Chuck Lever <chuck.lever@oracle.com>
> 
> Report FAT's case sensitivity behavior via the FS_XFLAG_CASEFOLD
> and FS_XFLAG_CASENONPRESERVING flags. FAT filesystems are
> case-insensitive by default.
> 
> MSDOS supports a 'nocase' mount option that enables case-sensitive
> behavior; check this option when reporting case sensitivity.
> 
> VFAT long filename entries preserve case; without VFAT, only
> uppercased 8.3 short names are stored. MSDOS with 'nocase' also
> preserves case since the name-formatting code skips upcasing when
> 'nocase' is set. Check both options when reporting case preservation.
> 
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>

Looks good to me from general POV. It would be good to get confirmation
from FAT maintainer you've got all the corner cases of FAT configuration
right :) Anyway, feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/fat/fat.h         |  3 +++
>  fs/fat/file.c        | 22 ++++++++++++++++++++++
>  fs/fat/namei_msdos.c |  1 +
>  fs/fat/namei_vfat.c  |  1 +
>  4 files changed, 27 insertions(+)
> 
> diff --git a/fs/fat/fat.h b/fs/fat/fat.h
> index 0d269dba897b..c5bcd1063f9c 100644
> --- a/fs/fat/fat.h
> +++ b/fs/fat/fat.h
> @@ -10,6 +10,8 @@
>  #include <linux/fs_context.h>
>  #include <linux/fs_parser.h>
>  
> +struct file_kattr;
> +
>  /*
>   * vfat shortname flags
>   */
> @@ -407,6 +409,7 @@ extern void fat_truncate_blocks(struct inode *inode, loff_t offset);
>  extern int fat_getattr(struct mnt_idmap *idmap,
>  		       const struct path *path, struct kstat *stat,
>  		       u32 request_mask, unsigned int flags);
> +int fat_fileattr_get(struct dentry *dentry, struct file_kattr *fa);
>  extern int fat_file_fsync(struct file *file, loff_t start, loff_t end,
>  			  int datasync);
>  
> diff --git a/fs/fat/file.c b/fs/fat/file.c
> index 124d9c5431c8..6823269a8604 100644
> --- a/fs/fat/file.c
> +++ b/fs/fat/file.c
> @@ -17,6 +17,7 @@
>  #include <linux/fsnotify.h>
>  #include <linux/security.h>
>  #include <linux/falloc.h>
> +#include <linux/fileattr.h>
>  #include "fat.h"
>  
>  static long fat_fallocate(struct file *file, int mode,
> @@ -396,6 +397,26 @@ void fat_truncate_blocks(struct inode *inode, loff_t offset)
>  	fat_flush_inodes(inode->i_sb, inode, NULL);
>  }
>  
> +int fat_fileattr_get(struct dentry *dentry, struct file_kattr *fa)
> +{
> +	struct msdos_sb_info *sbi = MSDOS_SB(dentry->d_sb);
> +
> +	/*
> +	 * FAT filesystems are case-insensitive by default. MSDOS
> +	 * supports a 'nocase' mount option for case-sensitive behavior.
> +	 *
> +	 * VFAT long filename entries preserve case. Without VFAT, only
> +	 * uppercased 8.3 short names are stored. MSDOS with 'nocase'
> +	 * also preserves case.
> +	 */
> +	if (!sbi->options.nocase)
> +		fa->fsx_xflags |= FS_XFLAG_CASEFOLD;
> +	if (!sbi->options.isvfat && !sbi->options.nocase)
> +		fa->fsx_xflags |= FS_XFLAG_CASENONPRESERVING;
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(fat_fileattr_get);
> +
>  int fat_getattr(struct mnt_idmap *idmap, const struct path *path,
>  		struct kstat *stat, u32 request_mask, unsigned int flags)
>  {
> @@ -573,5 +594,6 @@ EXPORT_SYMBOL_GPL(fat_setattr);
>  const struct inode_operations fat_file_inode_operations = {
>  	.setattr	= fat_setattr,
>  	.getattr	= fat_getattr,
> +	.fileattr_get	= fat_fileattr_get,
>  	.update_time	= fat_update_time,
>  };
> diff --git a/fs/fat/namei_msdos.c b/fs/fat/namei_msdos.c
> index 048c103b506a..4a3db08e51c0 100644
> --- a/fs/fat/namei_msdos.c
> +++ b/fs/fat/namei_msdos.c
> @@ -642,6 +642,7 @@ static const struct inode_operations msdos_dir_inode_operations = {
>  	.rename		= msdos_rename,
>  	.setattr	= fat_setattr,
>  	.getattr	= fat_getattr,
> +	.fileattr_get	= fat_fileattr_get,
>  	.update_time	= fat_update_time,
>  };
>  
> diff --git a/fs/fat/namei_vfat.c b/fs/fat/namei_vfat.c
> index 2acfe3123a72..18f4c316aa05 100644
> --- a/fs/fat/namei_vfat.c
> +++ b/fs/fat/namei_vfat.c
> @@ -1185,6 +1185,7 @@ static const struct inode_operations vfat_dir_inode_operations = {
>  	.rename		= vfat_rename2,
>  	.setattr	= fat_setattr,
>  	.getattr	= fat_getattr,
> +	.fileattr_get	= fat_fileattr_get,
>  	.update_time	= fat_update_time,
>  };
>  
> -- 
> 2.53.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

