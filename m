Return-Path: <linux-fsdevel+bounces-71828-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DBF77CD6786
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Dec 2025 16:05:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E534430CECCD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Dec 2025 15:01:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72A0F320A1A;
	Mon, 22 Dec 2025 15:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="PBq8bao2";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="AfR+7BPY";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="I1Dngh0w";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="UER1f8ES"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EB6531ED67
	for <linux-fsdevel@vger.kernel.org>; Mon, 22 Dec 2025 15:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766415682; cv=none; b=WiU1pDkHbC89aA7NA1ASE4WcydFvvWlvpM0rjaq62p7lcKAyr1VP0wyAtzDxxHNzY0O16/WEJ6RATn+IOpD/mKBnS95JznbnMglrXC/PDCqpiP/Naoztnf+yC5swNWZA6Sh+Ilv2N2QHbzd3xgYxiZ/oHydvFCNngwB3uvAUbW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766415682; c=relaxed/simple;
	bh=SZdQECnAuh3evi5qEo98CncBOOT5aJFsfafebtH24xo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DW3lSa/vtr/EL2ovHQodOQuazUekGDCoFnWnsMSLO91DyPyqy9Voygy2TDPcpIF97ZIEow1XaaFb/cf8hUuKxq+6s+Dd2dSIJMb5fBxJXNVm0DZbxfgYiBw411iSmrcmrLgvKYrSEaQQ02xS+oVIBWkgZjS3pED4QLwOCejg+rU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=PBq8bao2; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=AfR+7BPY; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=I1Dngh0w; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=UER1f8ES; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 4721A336A9;
	Mon, 22 Dec 2025 15:01:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1766415672; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/4+Tyu8tctXsQondAS9xaAdXgKieYmZ4xcN5I5GwVHk=;
	b=PBq8bao2ufYtkjqAs92m6higCGY5Kg9/t0RvXWcFJBpxXzO7Byb18mjzkGgkUN1QTvVaUg
	oAkGjwvSqsFHaCGuSx+0LZjVQsFDxyxaD1PLNE6BqMEz6uZjfErn8TMExfXrrhTRqLi+fM
	jMn7tVUNbYUrjHbVKX0i5E3Lxq6XMWo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1766415672;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/4+Tyu8tctXsQondAS9xaAdXgKieYmZ4xcN5I5GwVHk=;
	b=AfR+7BPYyKDR4IACLknj76He/9T3+LCT82QoPHTb5y3/69sbYDDUrChUEV0Wn7gPKKK8SL
	69xAM84ssswarUCw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=I1Dngh0w;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=UER1f8ES
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1766415671; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/4+Tyu8tctXsQondAS9xaAdXgKieYmZ4xcN5I5GwVHk=;
	b=I1Dngh0wG11P/29NCvf0BZvwBNUALZBK+ub1bgmqI5nfiKuFdYFQ1L76hqs5gEHUWhDDCO
	srcQBAm+zmN6nWKQRotBcHrRdLss4Rmft1zl/ldgYrVpPU3C3XlI5rIrhVcNGtqSvOvgWR
	12FebBT7XpJjoNUQRn8nJp/PkEbXgvo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1766415671;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/4+Tyu8tctXsQondAS9xaAdXgKieYmZ4xcN5I5GwVHk=;
	b=UER1f8ESdqa4Ii8TK8pgsnKa6ccmoB2cY2Mfydbta40+9T2ExYiFZG7oc2IhZfCiDL/Hew
	yp7BD6Aqw3fWgnCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 37DA71364B;
	Mon, 22 Dec 2025 15:01:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id C62cDTddSWm1BwAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 22 Dec 2025 15:01:11 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id C298BA09CB; Mon, 22 Dec 2025 16:01:10 +0100 (CET)
Date: Mon, 22 Dec 2025 16:01:10 +0100
From: Jan Kara <jack@suse.cz>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: brauner@kernel.org, linux-api@vger.kernel.org, 
	linux-ext4@vger.kernel.org, jack@suse.cz, linux-xfs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, gabriel@krisman.be, hch@lst.de, amir73il@gmail.com
Subject: Re: [PATCH 1/6] uapi: promote EFSCORRUPTED and EUCLEAN to errno.h
Message-ID: <vn6wnmfy2az6aecm43zmyttbnno2y7gm4jlria5vwe2ylwj3ka@m3jq5nm6yupa>
References: <176602332085.686273.7564676516217176769.stgit@frogsfrogsfrogs>
 <176602332146.686273.6355079912638580915.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <176602332146.686273.6355079912638580915.stgit@frogsfrogsfrogs>
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
	URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:email,suse.cz:dkim,suse.cz:email];
	ARC_NA(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DWL_DNSWL_BLOCKED(0.00)[suse.cz:dkim];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,suse.cz,krisman.be,lst.de,gmail.com];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:dkim,suse.cz:email,suse.com:email]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spam-Level: 
X-Rspamd-Queue-Id: 4721A336A9
X-Spam-Flag: NO
X-Spam-Score: -4.01

On Wed 17-12-25 18:02:56, Darrick J. Wong wrote:
> From: Darrick J. Wong <djwong@kernel.org>
> 
> Stop definining these privately and instead move them to the uapi
> errno.h so that they become canonical instead of copy pasta.
> 
> Cc: linux-api@vger.kernel.org
> Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  arch/alpha/include/uapi/asm/errno.h        |    2 ++
>  arch/mips/include/uapi/asm/errno.h         |    2 ++
>  arch/parisc/include/uapi/asm/errno.h       |    2 ++
>  arch/sparc/include/uapi/asm/errno.h        |    2 ++
>  fs/erofs/internal.h                        |    2 --
>  fs/ext2/ext2.h                             |    1 -
>  fs/ext4/ext4.h                             |    3 ---
>  fs/f2fs/f2fs.h                             |    3 ---
>  fs/minix/minix.h                           |    2 --
>  fs/udf/udf_sb.h                            |    2 --
>  fs/xfs/xfs_linux.h                         |    2 --
>  include/linux/jbd2.h                       |    3 ---
>  include/uapi/asm-generic/errno.h           |    2 ++
>  tools/arch/alpha/include/uapi/asm/errno.h  |    2 ++
>  tools/arch/mips/include/uapi/asm/errno.h   |    2 ++
>  tools/arch/parisc/include/uapi/asm/errno.h |    2 ++
>  tools/arch/sparc/include/uapi/asm/errno.h  |    2 ++
>  tools/include/uapi/asm-generic/errno.h     |    2 ++
>  18 files changed, 20 insertions(+), 18 deletions(-)
> 
> 
> diff --git a/arch/alpha/include/uapi/asm/errno.h b/arch/alpha/include/uapi/asm/errno.h
> index 3d265f6babaf0a..6791f6508632ee 100644
> --- a/arch/alpha/include/uapi/asm/errno.h
> +++ b/arch/alpha/include/uapi/asm/errno.h
> @@ -55,6 +55,7 @@
>  #define	ENOSR		82	/* Out of streams resources */
>  #define	ETIME		83	/* Timer expired */
>  #define	EBADMSG		84	/* Not a data message */
> +#define	EFSBADCRC	EBADMSG	/* Bad CRC detected */
>  #define	EPROTO		85	/* Protocol error */
>  #define	ENODATA		86	/* No data available */
>  #define	ENOSTR		87	/* Device not a stream */
> @@ -96,6 +97,7 @@
>  #define	EREMCHG		115	/* Remote address changed */
>  
>  #define	EUCLEAN		117	/* Structure needs cleaning */
> +#define	EFSCORRUPTED	EUCLEAN	/* Filesystem is corrupted */
>  #define	ENOTNAM		118	/* Not a XENIX named type file */
>  #define	ENAVAIL		119	/* No XENIX semaphores available */
>  #define	EISNAM		120	/* Is a named type file */
> diff --git a/arch/mips/include/uapi/asm/errno.h b/arch/mips/include/uapi/asm/errno.h
> index 2fb714e2d6d8fc..c01ed91b1ef44b 100644
> --- a/arch/mips/include/uapi/asm/errno.h
> +++ b/arch/mips/include/uapi/asm/errno.h
> @@ -50,6 +50,7 @@
>  #define EDOTDOT		73	/* RFS specific error */
>  #define EMULTIHOP	74	/* Multihop attempted */
>  #define EBADMSG		77	/* Not a data message */
> +#define EFSBADCRC	EBADMSG	/* Bad CRC detected */
>  #define ENAMETOOLONG	78	/* File name too long */
>  #define EOVERFLOW	79	/* Value too large for defined data type */
>  #define ENOTUNIQ	80	/* Name not unique on network */
> @@ -88,6 +89,7 @@
>  #define EISCONN		133	/* Transport endpoint is already connected */
>  #define ENOTCONN	134	/* Transport endpoint is not connected */
>  #define EUCLEAN		135	/* Structure needs cleaning */
> +#define EFSCORRUPTED	EUCLEAN	/* Filesystem is corrupted */
>  #define ENOTNAM		137	/* Not a XENIX named type file */
>  #define ENAVAIL		138	/* No XENIX semaphores available */
>  #define EISNAM		139	/* Is a named type file */
> diff --git a/arch/parisc/include/uapi/asm/errno.h b/arch/parisc/include/uapi/asm/errno.h
> index 8d94739d75c67c..8cbc07c1903e4c 100644
> --- a/arch/parisc/include/uapi/asm/errno.h
> +++ b/arch/parisc/include/uapi/asm/errno.h
> @@ -36,6 +36,7 @@
>  
>  #define	EDOTDOT		66	/* RFS specific error */
>  #define	EBADMSG		67	/* Not a data message */
> +#define	EFSBADCRC	EBADMSG	/* Bad CRC detected */
>  #define	EUSERS		68	/* Too many users */
>  #define	EDQUOT		69	/* Quota exceeded */
>  #define	ESTALE		70	/* Stale file handle */
> @@ -62,6 +63,7 @@
>  #define	ERESTART	175	/* Interrupted system call should be restarted */
>  #define	ESTRPIPE	176	/* Streams pipe error */
>  #define	EUCLEAN		177	/* Structure needs cleaning */
> +#define	EFSCORRUPTED	EUCLEAN	/* Filesystem is corrupted */
>  #define	ENOTNAM		178	/* Not a XENIX named type file */
>  #define	ENAVAIL		179	/* No XENIX semaphores available */
>  #define	EISNAM		180	/* Is a named type file */
> diff --git a/arch/sparc/include/uapi/asm/errno.h b/arch/sparc/include/uapi/asm/errno.h
> index 81a732b902ee38..4a41e7835fd5b8 100644
> --- a/arch/sparc/include/uapi/asm/errno.h
> +++ b/arch/sparc/include/uapi/asm/errno.h
> @@ -48,6 +48,7 @@
>  #define	ENOSR		74	/* Out of streams resources */
>  #define	ENOMSG		75	/* No message of desired type */
>  #define	EBADMSG		76	/* Not a data message */
> +#define	EFSBADCRC	EBADMSG	/* Bad CRC detected */
>  #define	EIDRM		77	/* Identifier removed */
>  #define	EDEADLK		78	/* Resource deadlock would occur */
>  #define	ENOLCK		79	/* No record locks available */
> @@ -91,6 +92,7 @@
>  #define	ENOTUNIQ	115	/* Name not unique on network */
>  #define	ERESTART	116	/* Interrupted syscall should be restarted */
>  #define	EUCLEAN		117	/* Structure needs cleaning */
> +#define	EFSCORRUPTED	EUCLEAN	/* Filesystem is corrupted */
>  #define	ENOTNAM		118	/* Not a XENIX named type file */
>  #define	ENAVAIL		119	/* No XENIX semaphores available */
>  #define	EISNAM		120	/* Is a named type file */
> diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
> index f7f622836198da..d06e99baf5d5ae 100644
> --- a/fs/erofs/internal.h
> +++ b/fs/erofs/internal.h
> @@ -541,6 +541,4 @@ long erofs_ioctl(struct file *filp, unsigned int cmd, unsigned long arg);
>  long erofs_compat_ioctl(struct file *filp, unsigned int cmd,
>  			unsigned long arg);
>  
> -#define EFSCORRUPTED    EUCLEAN         /* Filesystem is corrupted */
> -
>  #endif	/* __EROFS_INTERNAL_H */
> diff --git a/fs/ext2/ext2.h b/fs/ext2/ext2.h
> index cf97b76e9fd3e9..5e0c6c5fcb6cd6 100644
> --- a/fs/ext2/ext2.h
> +++ b/fs/ext2/ext2.h
> @@ -357,7 +357,6 @@ struct ext2_inode {
>   */
>  #define	EXT2_VALID_FS			0x0001	/* Unmounted cleanly */
>  #define	EXT2_ERROR_FS			0x0002	/* Errors detected */
> -#define	EFSCORRUPTED			EUCLEAN	/* Filesystem is corrupted */
>  
>  /*
>   * Mount flags
> diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
> index 56112f201cace7..62c091b52bacdf 100644
> --- a/fs/ext4/ext4.h
> +++ b/fs/ext4/ext4.h
> @@ -3938,7 +3938,4 @@ extern int ext4_block_write_begin(handle_t *handle, struct folio *folio,
>  				  get_block_t *get_block);
>  #endif	/* __KERNEL__ */
>  
> -#define EFSBADCRC	EBADMSG		/* Bad CRC detected */
> -#define EFSCORRUPTED	EUCLEAN		/* Filesystem is corrupted */
> -
>  #endif	/* _EXT4_H */
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index 20edbb99b814a7..9f3aa3c7f12613 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -5004,7 +5004,4 @@ static inline void f2fs_invalidate_internal_cache(struct f2fs_sb_info *sbi,
>  	f2fs_invalidate_compress_pages_range(sbi, blkaddr, len);
>  }
>  
> -#define EFSBADCRC	EBADMSG		/* Bad CRC detected */
> -#define EFSCORRUPTED	EUCLEAN		/* Filesystem is corrupted */
> -
>  #endif /* _LINUX_F2FS_H */
> diff --git a/fs/minix/minix.h b/fs/minix/minix.h
> index 2bfaf377f2086c..7e1f652f16d311 100644
> --- a/fs/minix/minix.h
> +++ b/fs/minix/minix.h
> @@ -175,6 +175,4 @@ static inline int minix_test_bit(int nr, const void *vaddr)
>  	__minix_error_inode((inode), __func__, __LINE__,	\
>  			    (fmt), ##__VA_ARGS__)
>  
> -#define EFSCORRUPTED	EUCLEAN		/* Filesystem is corrupted */
> -
>  #endif /* FS_MINIX_H */
> diff --git a/fs/udf/udf_sb.h b/fs/udf/udf_sb.h
> index 08ec8756b9487b..8399accc788dea 100644
> --- a/fs/udf/udf_sb.h
> +++ b/fs/udf/udf_sb.h
> @@ -55,8 +55,6 @@
>  #define MF_DUPLICATE_MD		0x01
>  #define MF_MIRROR_FE_LOADED	0x02
>  
> -#define EFSCORRUPTED EUCLEAN
> -
>  struct udf_meta_data {
>  	__u32	s_meta_file_loc;
>  	__u32	s_mirror_file_loc;
> diff --git a/fs/xfs/xfs_linux.h b/fs/xfs/xfs_linux.h
> index 4dd747bdbccab2..55064228c4d574 100644
> --- a/fs/xfs/xfs_linux.h
> +++ b/fs/xfs/xfs_linux.h
> @@ -121,8 +121,6 @@ typedef __u32			xfs_nlink_t;
>  
>  #define ENOATTR		ENODATA		/* Attribute not found */
>  #define EWRONGFS	EINVAL		/* Mount with wrong filesystem type */
> -#define EFSCORRUPTED	EUCLEAN		/* Filesystem is corrupted */
> -#define EFSBADCRC	EBADMSG		/* Bad CRC detected */
>  
>  #define __return_address __builtin_return_address(0)
>  
> diff --git a/include/linux/jbd2.h b/include/linux/jbd2.h
> index f5eaf76198f377..a53a00d36228ce 100644
> --- a/include/linux/jbd2.h
> +++ b/include/linux/jbd2.h
> @@ -1815,7 +1815,4 @@ static inline int jbd2_handle_buffer_credits(handle_t *handle)
>  
>  #endif	/* __KERNEL__ */
>  
> -#define EFSBADCRC	EBADMSG		/* Bad CRC detected */
> -#define EFSCORRUPTED	EUCLEAN		/* Filesystem is corrupted */
> -
>  #endif	/* _LINUX_JBD2_H */
> diff --git a/include/uapi/asm-generic/errno.h b/include/uapi/asm-generic/errno.h
> index cf9c51ac49f97e..92e7ae493ee315 100644
> --- a/include/uapi/asm-generic/errno.h
> +++ b/include/uapi/asm-generic/errno.h
> @@ -55,6 +55,7 @@
>  #define	EMULTIHOP	72	/* Multihop attempted */
>  #define	EDOTDOT		73	/* RFS specific error */
>  #define	EBADMSG		74	/* Not a data message */
> +#define	EFSBADCRC	EBADMSG	/* Bad CRC detected */
>  #define	EOVERFLOW	75	/* Value too large for defined data type */
>  #define	ENOTUNIQ	76	/* Name not unique on network */
>  #define	EBADFD		77	/* File descriptor in bad state */
> @@ -98,6 +99,7 @@
>  #define	EINPROGRESS	115	/* Operation now in progress */
>  #define	ESTALE		116	/* Stale file handle */
>  #define	EUCLEAN		117	/* Structure needs cleaning */
> +#define	EFSCORRUPTED	EUCLEAN	/* Filesystem is corrupted */
>  #define	ENOTNAM		118	/* Not a XENIX named type file */
>  #define	ENAVAIL		119	/* No XENIX semaphores available */
>  #define	EISNAM		120	/* Is a named type file */
> diff --git a/tools/arch/alpha/include/uapi/asm/errno.h b/tools/arch/alpha/include/uapi/asm/errno.h
> index 3d265f6babaf0a..6791f6508632ee 100644
> --- a/tools/arch/alpha/include/uapi/asm/errno.h
> +++ b/tools/arch/alpha/include/uapi/asm/errno.h
> @@ -55,6 +55,7 @@
>  #define	ENOSR		82	/* Out of streams resources */
>  #define	ETIME		83	/* Timer expired */
>  #define	EBADMSG		84	/* Not a data message */
> +#define	EFSBADCRC	EBADMSG	/* Bad CRC detected */
>  #define	EPROTO		85	/* Protocol error */
>  #define	ENODATA		86	/* No data available */
>  #define	ENOSTR		87	/* Device not a stream */
> @@ -96,6 +97,7 @@
>  #define	EREMCHG		115	/* Remote address changed */
>  
>  #define	EUCLEAN		117	/* Structure needs cleaning */
> +#define	EFSCORRUPTED	EUCLEAN	/* Filesystem is corrupted */
>  #define	ENOTNAM		118	/* Not a XENIX named type file */
>  #define	ENAVAIL		119	/* No XENIX semaphores available */
>  #define	EISNAM		120	/* Is a named type file */
> diff --git a/tools/arch/mips/include/uapi/asm/errno.h b/tools/arch/mips/include/uapi/asm/errno.h
> index 2fb714e2d6d8fc..c01ed91b1ef44b 100644
> --- a/tools/arch/mips/include/uapi/asm/errno.h
> +++ b/tools/arch/mips/include/uapi/asm/errno.h
> @@ -50,6 +50,7 @@
>  #define EDOTDOT		73	/* RFS specific error */
>  #define EMULTIHOP	74	/* Multihop attempted */
>  #define EBADMSG		77	/* Not a data message */
> +#define EFSBADCRC	EBADMSG	/* Bad CRC detected */
>  #define ENAMETOOLONG	78	/* File name too long */
>  #define EOVERFLOW	79	/* Value too large for defined data type */
>  #define ENOTUNIQ	80	/* Name not unique on network */
> @@ -88,6 +89,7 @@
>  #define EISCONN		133	/* Transport endpoint is already connected */
>  #define ENOTCONN	134	/* Transport endpoint is not connected */
>  #define EUCLEAN		135	/* Structure needs cleaning */
> +#define EFSCORRUPTED	EUCLEAN	/* Filesystem is corrupted */
>  #define ENOTNAM		137	/* Not a XENIX named type file */
>  #define ENAVAIL		138	/* No XENIX semaphores available */
>  #define EISNAM		139	/* Is a named type file */
> diff --git a/tools/arch/parisc/include/uapi/asm/errno.h b/tools/arch/parisc/include/uapi/asm/errno.h
> index 8d94739d75c67c..8cbc07c1903e4c 100644
> --- a/tools/arch/parisc/include/uapi/asm/errno.h
> +++ b/tools/arch/parisc/include/uapi/asm/errno.h
> @@ -36,6 +36,7 @@
>  
>  #define	EDOTDOT		66	/* RFS specific error */
>  #define	EBADMSG		67	/* Not a data message */
> +#define	EFSBADCRC	EBADMSG	/* Bad CRC detected */
>  #define	EUSERS		68	/* Too many users */
>  #define	EDQUOT		69	/* Quota exceeded */
>  #define	ESTALE		70	/* Stale file handle */
> @@ -62,6 +63,7 @@
>  #define	ERESTART	175	/* Interrupted system call should be restarted */
>  #define	ESTRPIPE	176	/* Streams pipe error */
>  #define	EUCLEAN		177	/* Structure needs cleaning */
> +#define	EFSCORRUPTED	EUCLEAN	/* Filesystem is corrupted */
>  #define	ENOTNAM		178	/* Not a XENIX named type file */
>  #define	ENAVAIL		179	/* No XENIX semaphores available */
>  #define	EISNAM		180	/* Is a named type file */
> diff --git a/tools/arch/sparc/include/uapi/asm/errno.h b/tools/arch/sparc/include/uapi/asm/errno.h
> index 81a732b902ee38..4a41e7835fd5b8 100644
> --- a/tools/arch/sparc/include/uapi/asm/errno.h
> +++ b/tools/arch/sparc/include/uapi/asm/errno.h
> @@ -48,6 +48,7 @@
>  #define	ENOSR		74	/* Out of streams resources */
>  #define	ENOMSG		75	/* No message of desired type */
>  #define	EBADMSG		76	/* Not a data message */
> +#define	EFSBADCRC	EBADMSG	/* Bad CRC detected */
>  #define	EIDRM		77	/* Identifier removed */
>  #define	EDEADLK		78	/* Resource deadlock would occur */
>  #define	ENOLCK		79	/* No record locks available */
> @@ -91,6 +92,7 @@
>  #define	ENOTUNIQ	115	/* Name not unique on network */
>  #define	ERESTART	116	/* Interrupted syscall should be restarted */
>  #define	EUCLEAN		117	/* Structure needs cleaning */
> +#define	EFSCORRUPTED	EUCLEAN	/* Filesystem is corrupted */
>  #define	ENOTNAM		118	/* Not a XENIX named type file */
>  #define	ENAVAIL		119	/* No XENIX semaphores available */
>  #define	EISNAM		120	/* Is a named type file */
> diff --git a/tools/include/uapi/asm-generic/errno.h b/tools/include/uapi/asm-generic/errno.h
> index cf9c51ac49f97e..92e7ae493ee315 100644
> --- a/tools/include/uapi/asm-generic/errno.h
> +++ b/tools/include/uapi/asm-generic/errno.h
> @@ -55,6 +55,7 @@
>  #define	EMULTIHOP	72	/* Multihop attempted */
>  #define	EDOTDOT		73	/* RFS specific error */
>  #define	EBADMSG		74	/* Not a data message */
> +#define	EFSBADCRC	EBADMSG	/* Bad CRC detected */
>  #define	EOVERFLOW	75	/* Value too large for defined data type */
>  #define	ENOTUNIQ	76	/* Name not unique on network */
>  #define	EBADFD		77	/* File descriptor in bad state */
> @@ -98,6 +99,7 @@
>  #define	EINPROGRESS	115	/* Operation now in progress */
>  #define	ESTALE		116	/* Stale file handle */
>  #define	EUCLEAN		117	/* Structure needs cleaning */
> +#define	EFSCORRUPTED	EUCLEAN	/* Filesystem is corrupted */
>  #define	ENOTNAM		118	/* Not a XENIX named type file */
>  #define	ENAVAIL		119	/* No XENIX semaphores available */
>  #define	EISNAM		120	/* Is a named type file */
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

