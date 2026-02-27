Return-Path: <linux-fsdevel+bounces-78708-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6EukNgeCoWkUtgQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78708-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Feb 2026 12:37:43 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 77A141B6A84
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Feb 2026 12:37:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A4F943043069
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Feb 2026 11:37:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66F893EFD0D;
	Fri, 27 Feb 2026 11:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="c2bIMXxs";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="+QPFFNE9";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="c2bIMXxs";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="+QPFFNE9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B14E33A1E6C
	for <linux-fsdevel@vger.kernel.org>; Fri, 27 Feb 2026 11:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772192261; cv=none; b=JzTMpurnmJMwapZAgj1FUz0QsVXfr+oZqGtBFcLcfyoquNqctuA9wKsGCH8wym4abvF7obw0y2RyD6JPgJlgkN9iV5a8s0gaCn0IyVcMW5OCzynHHniEA2QLq7zTnCajRFCWT618KNuvHuXOvW0m10HzPqXwmQCxUIRHfBxXzKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772192261; c=relaxed/simple;
	bh=OMwwyt6UugQRlIcy+UH0m2T0u/+6OjVCgzPQVsLkEHU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jmjBqmsAlRzwaHrwfsqz2wVP9liBjhJpchWzbBiKvF1VclO/7AJPa3HenftgRNsexR937uiIe9wMfAxjNE9AIxVjw+OSI0e0Do3tmTQEUhN8OsH1iwAcQVBeeGk8LbBvtCKMQoSYDbJy8JKAAxfO6cHghfXccEHArZ9ALf08ytA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=c2bIMXxs; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=+QPFFNE9; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=c2bIMXxs; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=+QPFFNE9; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 0EBD75BDF8;
	Fri, 27 Feb 2026 11:37:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1772192258; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+X4fgpfDrgOhU4ghCol/Vq0PcVN1+Gjhbbnr6+ASR9g=;
	b=c2bIMXxsGVcCNyiju2yLzeIwp/V2ky8hoAZ3QEUkSujc6ayuYPPmwndfsK0pdk39aznV/Z
	9XqZzv2uJ3OuAKWchUAdV0wQUeI+RzVvBsDFnYe/lX0oBX9zddeSkte0N83aAGs0uUbrEz
	YMsEpAB5/DoKnKLij0sg/MB2ixSWlBM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1772192258;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+X4fgpfDrgOhU4ghCol/Vq0PcVN1+Gjhbbnr6+ASR9g=;
	b=+QPFFNE9NS7JS5ZWK2muggEZJTK7QKjDAUK1Xe2Zt2LOTXZskSGdI0aw2pNmpiA8rWDcwY
	DhAigLoJ1WxbVqDA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=c2bIMXxs;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=+QPFFNE9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1772192258; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+X4fgpfDrgOhU4ghCol/Vq0PcVN1+Gjhbbnr6+ASR9g=;
	b=c2bIMXxsGVcCNyiju2yLzeIwp/V2ky8hoAZ3QEUkSujc6ayuYPPmwndfsK0pdk39aznV/Z
	9XqZzv2uJ3OuAKWchUAdV0wQUeI+RzVvBsDFnYe/lX0oBX9zddeSkte0N83aAGs0uUbrEz
	YMsEpAB5/DoKnKLij0sg/MB2ixSWlBM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1772192258;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+X4fgpfDrgOhU4ghCol/Vq0PcVN1+Gjhbbnr6+ASR9g=;
	b=+QPFFNE9NS7JS5ZWK2muggEZJTK7QKjDAUK1Xe2Zt2LOTXZskSGdI0aw2pNmpiA8rWDcwY
	DhAigLoJ1WxbVqDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F38963EA69;
	Fri, 27 Feb 2026 11:37:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id iKlgOwGCoWnaMgAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 27 Feb 2026 11:37:37 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id B6B21A06D4; Fri, 27 Feb 2026 12:37:33 +0100 (CET)
Date: Fri, 27 Feb 2026 12:37:33 +0100
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
	Chuck Lever <chuck.lever@oracle.com>, "Darrick J. Wong" <djwong@kernel.org>
Subject: Re: [PATCH v8 02/17] fs: Add case sensitivity flags to file_kattr
Message-ID: <6fw3nxspwmbkyyobefnxe6piza4nmpfqx5pg5btjh6zisuqie3@i22cjwsgobtj>
References: <20260217214741.1928576-1-cel@kernel.org>
 <20260217214741.1928576-3-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260217214741.1928576-3-cel@kernel.org>
X-Spam-Flag: NO
X-Spam-Score: -4.01
X-Spam-Level: 
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-78708-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,suse.cz:email,suse.cz:dkim,oracle.com:email,suse.com:email];
	DMARC_NA(0.00)[suse.cz];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[zeniv.linux.org.uk,kernel.org,suse.cz,vger.kernel.org,lists.sourceforge.net,mail.parknet.co.jp,samsung.com,sony.com,paragon-software.com,dubeyko.com,physik.fu-berlin.de,vivo.com,mit.edu,dilger.ca,samba.org,manguebit.org,gmail.com,microsoft.com,chromium.org,oracle.com];
	RCPT_COUNT_TWELVE(0.00)[34];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 77A141B6A84
X-Rspamd-Action: no action

On Tue 17-02-26 16:47:26, Chuck Lever wrote:
> From: Chuck Lever <chuck.lever@oracle.com>
> 
> Enable upper layers such as NFSD to retrieve case sensitivity
> information from file systems by adding FS_XFLAG_CASEFOLD and
> FS_XFLAG_CASENONPRESERVING flags.
> 
> Filesystems report case-insensitive or case-nonpreserving behavior
> by setting these flags directly in fa->fsx_xflags. The default
> (flags unset) indicates POSIX semantics: case-sensitive and
> case-preserving. These flags are read-only; userspace cannot set
> them via ioctl.
> 
> Case sensitivity information is exported to userspace via the
> fa_xflags field in the FS_IOC_FSGETXATTR ioctl and file_getattr()
> system call.
> 
> Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/file_attr.c           | 4 ++++
>  include/linux/fileattr.h | 3 ++-
>  include/uapi/linux/fs.h  | 7 +++++++
>  3 files changed, 13 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/file_attr.c b/fs/file_attr.c
> index 42aa511111a0..5d9a7ed159fb 100644
> --- a/fs/file_attr.c
> +++ b/fs/file_attr.c
> @@ -37,6 +37,8 @@ void fileattr_fill_xflags(struct file_kattr *fa, u32 xflags)
>  		fa->flags |= FS_PROJINHERIT_FL;
>  	if (fa->fsx_xflags & FS_XFLAG_VERITY)
>  		fa->flags |= FS_VERITY_FL;
> +	if (fa->fsx_xflags & FS_XFLAG_CASEFOLD)
> +		fa->flags |= FS_CASEFOLD_FL;
>  }
>  EXPORT_SYMBOL(fileattr_fill_xflags);
>  
> @@ -67,6 +69,8 @@ void fileattr_fill_flags(struct file_kattr *fa, u32 flags)
>  		fa->fsx_xflags |= FS_XFLAG_PROJINHERIT;
>  	if (fa->flags & FS_VERITY_FL)
>  		fa->fsx_xflags |= FS_XFLAG_VERITY;
> +	if (fa->flags & FS_CASEFOLD_FL)
> +		fa->fsx_xflags |= FS_XFLAG_CASEFOLD;
>  }
>  EXPORT_SYMBOL(fileattr_fill_flags);
>  
> diff --git a/include/linux/fileattr.h b/include/linux/fileattr.h
> index 3780904a63a6..58044b598016 100644
> --- a/include/linux/fileattr.h
> +++ b/include/linux/fileattr.h
> @@ -16,7 +16,8 @@
>  
>  /* Read-only inode flags */
>  #define FS_XFLAG_RDONLY_MASK \
> -	(FS_XFLAG_PREALLOC | FS_XFLAG_HASATTR | FS_XFLAG_VERITY)
> +	(FS_XFLAG_PREALLOC | FS_XFLAG_HASATTR | FS_XFLAG_VERITY | \
> +	 FS_XFLAG_CASEFOLD | FS_XFLAG_CASENONPRESERVING)
>  
>  /* Flags to indicate valid value of fsx_ fields */
>  #define FS_XFLAG_VALUES_MASK \
> diff --git a/include/uapi/linux/fs.h b/include/uapi/linux/fs.h
> index 70b2b661f42c..2fa003575e8b 100644
> --- a/include/uapi/linux/fs.h
> +++ b/include/uapi/linux/fs.h
> @@ -254,6 +254,13 @@ struct file_attr {
>  #define FS_XFLAG_DAX		0x00008000	/* use DAX for IO */
>  #define FS_XFLAG_COWEXTSIZE	0x00010000	/* CoW extent size allocator hint */
>  #define FS_XFLAG_VERITY		0x00020000	/* fs-verity enabled */
> +/*
> + * Case handling flags (read-only, cannot be set via ioctl).
> + * Default (neither set) indicates POSIX semantics: case-sensitive
> + * lookups and case-preserving storage.
> + */
> +#define FS_XFLAG_CASEFOLD	0x00040000	/* case-insensitive lookups */
> +#define FS_XFLAG_CASENONPRESERVING 0x00080000	/* case not preserved */
>  #define FS_XFLAG_HASATTR	0x80000000	/* no DIFLAG for this	*/
>  
>  /* the read-only stuff doesn't really belong here, but any other place is
> -- 
> 2.53.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

