Return-Path: <linux-fsdevel+bounces-75154-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qBoaDyeVcmksmQAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75154-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 22:22:47 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 439336DB5D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 22:22:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id AE11630091EA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 21:22:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C68A3BFE27;
	Thu, 22 Jan 2026 21:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PtelV9A+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B325C3BFE53;
	Thu, 22 Jan 2026 21:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769116953; cv=none; b=DneEapncicktxAHQaTDarK2k/wiBHLap7AUsKaWpUqwJtcZbc5dpPV3/7IpVklWgaOjia7w/R3mKzUdM3xzbAeJecUXWae7lFohczKwQdYyScnCSPSV7x3+NXZ1GbqCbBY71bEo5lqO2bVey2MU3F0SZncIL0NPRRrkL/XRXswU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769116953; c=relaxed/simple;
	bh=B+jnuGYgQo83TrhiEfEXS+wVSPnlTv4IH6jqS1kNwwI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o7OLoNDyVAW499Xju17MORIvG1sDRtMrTnFQga04PGjwy3TZrk3xk8arQtjlgpZYXpN4W5BvP4DuexHMrFZUMFuXUJq3WlplNowAI99DmgA8t2SmT0yf+/Dhk+98CdNgncznYnWoKpAdTWej4irMmeMuQIqCd8Cm1QP9Oa+18/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PtelV9A+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17FF9C116C6;
	Thu, 22 Jan 2026 21:22:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769116952;
	bh=B+jnuGYgQo83TrhiEfEXS+wVSPnlTv4IH6jqS1kNwwI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PtelV9A+J6P1rl+oOlYGbsHZ1fooIwtDLA3d0XEZZWPBHtbSj578s/6UAKEgNugZ0
	 cBClTHW6w0IXU6JUah0jpSzRp3z0dWJCW/MYuxFeX6V2L0ug3+a1S+SKgXudxqh3Td
	 qFWHU1W/15F2YIBxVD3sxAP0jm4vafSiJdUWGawkMJEc9cyIcPd9eZtAEueGlspy8F
	 Ut/yCcWedetrpag13j9fULX75iJYVfUKdcKPV90id87aoc4f3jx79morkytLrwWoSi
	 diRmPhYFaPwboREXO3QUmGbvUmuUXCyraEhrThedai1tvbAF0nufYNEtS3QBTN0eoU
	 63NX5HmxrcMRw==
Date: Thu, 22 Jan 2026 13:22:31 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Eric Biggers <ebiggers@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	David Sterba <dsterba@suse.com>, Theodore Ts'o <tytso@mit.edu>,
	Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
	Andrey Albershteyn <aalbersh@redhat.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org,
	linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
	fsverity@lists.linux.dev
Subject: Re: [PATCH 02/11] fs,fsverity: clear out fsverity_info from common
 code
Message-ID: <20260122212231.GB5910@frogsfrogsfrogs>
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
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-75154-lists,linux-fsdevel=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[djwong@kernel.org,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lst.de:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 439336DB5D
X-Rspamd-Action: no action

On Thu, Jan 22, 2026 at 09:21:58AM +0100, Christoph Hellwig wrote:
> Directly remove the fsverity_info from the hash and free it from
> clear_inode instead of requiring file systems to handle it.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Also seems like a reasonable hoist, so
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D

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
> 

