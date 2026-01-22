Return-Path: <linux-fsdevel+bounces-74999-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SMZMLPTtcWlKZwAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-74999-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 10:29:24 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DF7264898
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 10:29:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BBD2D567A06
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 09:23:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FFCD364EBE;
	Thu, 22 Jan 2026 09:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="xCFSu/Zp";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="uAi3BOKd";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="xCFSu/Zp";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="uAi3BOKd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D1C53624DB
	for <linux-fsdevel@vger.kernel.org>; Thu, 22 Jan 2026 09:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769073795; cv=none; b=DjWD7KjJXpzQJlTXbiO+BvG0eZRFz9dh7QbGi9Jcu87WGOKe6xxFirMlnZk3hVx5ZizzC3AYk0ZmvjcBbRp9SgefGeGvwPCjvMnS20wPPKoJBgVGLmp8zeAlLiKiJYJ489fWO7xA3gjrkEs2nWpwGBTYleMIg5E/URu6oy3f/ZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769073795; c=relaxed/simple;
	bh=7ElgnauMWjCC1ACsvCYYc3v8oa61s035AcGSVaJmKhg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qiwqv2wFmK7dYoWOq2c4ajTl0FFQgn/8c/1Ed6Jq4/S6kc4oSjvWOe3IzW69SVCp2T494CipC9ldTDBt9Z1yOggXE8jBfPgSBwKjtmRH2bWwolvGfKoPXev/g+Gdt7zH2OnR57QfvoWsHkbUmY9Rpdq6Pw3YnVUiog3b0UKzw6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=xCFSu/Zp; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=uAi3BOKd; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=xCFSu/Zp; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=uAi3BOKd; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 2788E5BD13;
	Thu, 22 Jan 2026 09:23:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1769073785; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mU2Ks98F5J+AbPp8AUVSHb8mtwCciz++x0FIFFNKyxI=;
	b=xCFSu/Zpyn+/2VG1Gp9/FliKrefPraGT574m11SLEJCk2gTW92CCpasEPDaGdxCE6eUKD2
	gWz94q7otNJHJ9lfk7lgxrUWZiyQOB521V47RJYpOaB3t0BK1qVLOsdNj1Oda81HiRhrFs
	QoX8L+Nx65Fwj9PqeF9tvwAM8YpO/Cs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1769073785;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mU2Ks98F5J+AbPp8AUVSHb8mtwCciz++x0FIFFNKyxI=;
	b=uAi3BOKd2uuFDcGW4kLYdDgozzz8l0JN8Hj8gGcCTdq5Pln5nu0eiERtI16C33dFYiFhe0
	zJZQKSTMfH8UuzCg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1769073785; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mU2Ks98F5J+AbPp8AUVSHb8mtwCciz++x0FIFFNKyxI=;
	b=xCFSu/Zpyn+/2VG1Gp9/FliKrefPraGT574m11SLEJCk2gTW92CCpasEPDaGdxCE6eUKD2
	gWz94q7otNJHJ9lfk7lgxrUWZiyQOB521V47RJYpOaB3t0BK1qVLOsdNj1Oda81HiRhrFs
	QoX8L+Nx65Fwj9PqeF9tvwAM8YpO/Cs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1769073785;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mU2Ks98F5J+AbPp8AUVSHb8mtwCciz++x0FIFFNKyxI=;
	b=uAi3BOKd2uuFDcGW4kLYdDgozzz8l0JN8Hj8gGcCTdq5Pln5nu0eiERtI16C33dFYiFhe0
	zJZQKSTMfH8UuzCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8C4BF13930;
	Thu, 22 Jan 2026 09:23:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id DoA7InjscWnkEAAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 22 Jan 2026 09:23:04 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id AA13CA082E; Thu, 22 Jan 2026 10:15:12 +0100 (CET)
Date: Thu, 22 Jan 2026 10:15:12 +0100
From: Jan Kara <jack@suse.cz>
To: Christoph Hellwig <hch@lst.de>
Cc: Eric Biggers <ebiggers@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, David Sterba <dsterba@suse.com>, 
	Theodore Ts'o <tytso@mit.edu>, Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>, 
	Andrey Albershteyn <aalbersh@redhat.com>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
	linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org, linux-ext4@vger.kernel.org, 
	linux-f2fs-devel@lists.sourceforge.net, fsverity@lists.linux.dev
Subject: Re: [PATCH 02/11] fs,fsverity: clear out fsverity_info from common
 code
Message-ID: <izxwgrpegtwftqsuhv5pdodwttqsdyvzvfom3fj75msdxhjdul@yl7z3inr6fvr>
References: <20260122082214.452153-1-hch@lst.de>
 <20260122082214.452153-3-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260122082214.452153-3-hch@lst.de>
X-Spam-Flag: NO
X-Spam-Score: -3.80
X-Spam-Level: 
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.96 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lst.de:email,suse.com:email,dfw.mirrors.kernel.org:helo,dfw.mirrors.kernel.org:rdns];
	DMARC_NA(0.00)[suse.cz];
	RCPT_COUNT_TWELVE(0.00)[16];
	TAGGED_FROM(0.00)[bounces-74999-lists,linux-fsdevel=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jack@suse.cz,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 0DF7264898
X-Rspamd-Action: no action

On Thu 22-01-26 09:21:58, Christoph Hellwig wrote:
> Directly remove the fsverity_info from the hash and free it from
> clear_inode instead of requiring file systems to handle it.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks good to me. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/btrfs/inode.c         | 10 +++-------
>  fs/ext4/super.c          |  1 -
>  fs/f2fs/inode.c          |  1 -
>  fs/inode.c               |  9 +++++++++
>  fs/verity/open.c         |  3 +--
>  include/linux/fsverity.h | 26 ++------------------------
>  6 files changed, 15 insertions(+), 35 deletions(-)
> 
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index a2b5b440637e..67c64efc5099 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -34,7 +34,6 @@
>  #include <linux/sched/mm.h>
>  #include <linux/iomap.h>
>  #include <linux/unaligned.h>
> -#include <linux/fsverity.h>
>  #include "misc.h"
>  #include "ctree.h"
>  #include "disk-io.h"
> @@ -5571,11 +5570,8 @@ void btrfs_evict_inode(struct inode *inode)
>  
>  	trace_btrfs_inode_evict(inode);
>  
> -	if (!root) {
> -		fsverity_cleanup_inode(inode);
> -		clear_inode(inode);
> -		return;
> -	}
> +	if (!root)
> +		goto clear_inode;
>  
>  	fs_info = inode_to_fs_info(inode);
>  	evict_inode_truncate_pages(inode);
> @@ -5675,7 +5671,7 @@ void btrfs_evict_inode(struct inode *inode)
>  	 * to retry these periodically in the future.
>  	 */
>  	btrfs_remove_delayed_node(BTRFS_I(inode));
> -	fsverity_cleanup_inode(inode);
> +clear_inode:
>  	clear_inode(inode);
>  }
>  
> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> index 87205660c5d0..86131f4d8718 100644
> --- a/fs/ext4/super.c
> +++ b/fs/ext4/super.c
> @@ -1527,7 +1527,6 @@ void ext4_clear_inode(struct inode *inode)
>  		EXT4_I(inode)->jinode = NULL;
>  	}
>  	fscrypt_put_encryption_info(inode);
> -	fsverity_cleanup_inode(inode);
>  }
>  
>  static struct inode *ext4_nfs_get_inode(struct super_block *sb,
> diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
> index 38b8994bc1b2..ee332b994348 100644
> --- a/fs/f2fs/inode.c
> +++ b/fs/f2fs/inode.c
> @@ -1000,7 +1000,6 @@ void f2fs_evict_inode(struct inode *inode)
>  	}
>  out_clear:
>  	fscrypt_put_encryption_info(inode);
> -	fsverity_cleanup_inode(inode);
>  	clear_inode(inode);
>  }
>  
> diff --git a/fs/inode.c b/fs/inode.c
> index 379f4c19845c..38dbdfbb09ba 100644
> --- a/fs/inode.c
> +++ b/fs/inode.c
> @@ -14,6 +14,7 @@
>  #include <linux/cdev.h>
>  #include <linux/memblock.h>
>  #include <linux/fsnotify.h>
> +#include <linux/fsverity.h>
>  #include <linux/mount.h>
>  #include <linux/posix_acl.h>
>  #include <linux/buffer_head.h> /* for inode_has_buffers */
> @@ -773,6 +774,14 @@ void dump_mapping(const struct address_space *mapping)
>  
>  void clear_inode(struct inode *inode)
>  {
> +	/*
> +	 * Only IS_VERITY() inodes can have verity info, so start by checking
> +	 * for IS_VERITY() (which is faster than retrieving the pointer to the
> +	 * verity info).  This minimizes overhead for non-verity inodes.
> +	 */
> +	if (IS_ENABLED(CONFIG_FS_VERITY) && IS_VERITY(inode))
> +		fsverity_cleanup_inode(inode);
> +
>  	/*
>  	 * We have to cycle the i_pages lock here because reclaim can be in the
>  	 * process of removing the last page (in __filemap_remove_folio())
> diff --git a/fs/verity/open.c b/fs/verity/open.c
> index 2aa5eae5a540..090cb77326ee 100644
> --- a/fs/verity/open.c
> +++ b/fs/verity/open.c
> @@ -384,14 +384,13 @@ int __fsverity_file_open(struct inode *inode, struct file *filp)
>  }
>  EXPORT_SYMBOL_GPL(__fsverity_file_open);
>  
> -void __fsverity_cleanup_inode(struct inode *inode)
> +void fsverity_cleanup_inode(struct inode *inode)
>  {
>  	struct fsverity_info **vi_addr = fsverity_info_addr(inode);
>  
>  	fsverity_free_info(*vi_addr);
>  	*vi_addr = NULL;
>  }
> -EXPORT_SYMBOL_GPL(__fsverity_cleanup_inode);
>  
>  void __init fsverity_init_info_cache(void)
>  {
> diff --git a/include/linux/fsverity.h b/include/linux/fsverity.h
> index 86fb1708676b..ea1ed2e6c2f9 100644
> --- a/include/linux/fsverity.h
> +++ b/include/linux/fsverity.h
> @@ -179,26 +179,6 @@ int fsverity_get_digest(struct inode *inode,
>  /* open.c */
>  
>  int __fsverity_file_open(struct inode *inode, struct file *filp);
> -void __fsverity_cleanup_inode(struct inode *inode);
> -
> -/**
> - * fsverity_cleanup_inode() - free the inode's verity info, if present
> - * @inode: an inode being evicted
> - *
> - * Filesystems must call this on inode eviction to free the inode's verity info.
> - */
> -static inline void fsverity_cleanup_inode(struct inode *inode)
> -{
> -	/*
> -	 * Only IS_VERITY() inodes can have verity info, so start by checking
> -	 * for IS_VERITY() (which is faster than retrieving the pointer to the
> -	 * verity info).  This minimizes overhead for non-verity inodes.
> -	 */
> -	if (IS_VERITY(inode))
> -		__fsverity_cleanup_inode(inode);
> -	else
> -		VFS_WARN_ON_ONCE(*fsverity_info_addr(inode) != NULL);
> -}
>  
>  /* read_metadata.c */
>  
> @@ -250,10 +230,6 @@ static inline int __fsverity_file_open(struct inode *inode, struct file *filp)
>  	return -EOPNOTSUPP;
>  }
>  
> -static inline void fsverity_cleanup_inode(struct inode *inode)
> -{
> -}
> -
>  /* read_metadata.c */
>  
>  static inline int fsverity_ioctl_read_metadata(struct file *filp,
> @@ -331,4 +307,6 @@ static inline int fsverity_file_open(struct inode *inode, struct file *filp)
>  	return 0;
>  }
>  
> +void fsverity_cleanup_inode(struct inode *inode);
> +
>  #endif	/* _LINUX_FSVERITY_H */
> -- 
> 2.47.3
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

