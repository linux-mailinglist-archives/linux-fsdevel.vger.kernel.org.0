Return-Path: <linux-fsdevel+bounces-5364-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E764180AC49
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Dec 2023 19:41:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 66AF4B207E6
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Dec 2023 18:41:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0F134CB25
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Dec 2023 18:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="YkbkK2zP";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="RLVKw5uf";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="YkbkK2zP";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="RLVKw5uf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2a07:de40:b251:101:10:150:64:1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB1D4A3
	for <linux-fsdevel@vger.kernel.org>; Fri,  8 Dec 2023 10:27:45 -0800 (PST)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 2918E21C99;
	Fri,  8 Dec 2023 18:27:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1702060064; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tHJoUWonJib9YrsPZlf9HbgVnJChizzt4Ju+t5NLGfM=;
	b=YkbkK2zPAIh5mRiBYA9TU3Lkx/cGePhOkg9KvoH+SEAY9LRoAVUm5dkQ7BPpFp8dnyfjDi
	k1lwF0fkzbrWjkXjhMFRJ07nFawOfbet5QclKiDi71IvSokNHAKOpnmAzX8JBg/1TiB2K9
	5TNXC7BFIx83l8En0i8RGyt57dfZa10=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1702060064;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tHJoUWonJib9YrsPZlf9HbgVnJChizzt4Ju+t5NLGfM=;
	b=RLVKw5ufmTFLSbQZD+QulplXpS9U0TDsIuLKf0QF5nAULP2BcrbXjVMa8DmxemuFGm5L5j
	AkyMDo1OxGdquVCA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1702060064; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tHJoUWonJib9YrsPZlf9HbgVnJChizzt4Ju+t5NLGfM=;
	b=YkbkK2zPAIh5mRiBYA9TU3Lkx/cGePhOkg9KvoH+SEAY9LRoAVUm5dkQ7BPpFp8dnyfjDi
	k1lwF0fkzbrWjkXjhMFRJ07nFawOfbet5QclKiDi71IvSokNHAKOpnmAzX8JBg/1TiB2K9
	5TNXC7BFIx83l8En0i8RGyt57dfZa10=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1702060064;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tHJoUWonJib9YrsPZlf9HbgVnJChizzt4Ju+t5NLGfM=;
	b=RLVKw5ufmTFLSbQZD+QulplXpS9U0TDsIuLKf0QF5nAULP2BcrbXjVMa8DmxemuFGm5L5j
	AkyMDo1OxGdquVCA==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 175DB138FF;
	Fri,  8 Dec 2023 18:27:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id J02tBSBgc2WNXQAAn2gu4w
	(envelope-from <jack@suse.cz>); Fri, 08 Dec 2023 18:27:44 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 7EDD6A07DC; Fri,  8 Dec 2023 19:27:43 +0100 (CET)
Date: Fri, 8 Dec 2023 19:27:43 +0100
From: Jan Kara <jack@suse.cz>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Jeff Layton <jlayton@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>, Christoph Hellwig <hch@lst.de>,
	David Howells <dhowells@redhat.com>, Jens Axboe <axboe@kernel.dk>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 1/4] fs: use splice_copy_file_range() inline helper
Message-ID: <20231208182743.sbouwm6wzqrlqle7@quack3>
References: <20231207123825.4011620-1-amir73il@gmail.com>
 <20231207123825.4011620-2-amir73il@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231207123825.4011620-2-amir73il@gmail.com>
X-Spam-Level: 
X-Spam-Score: -3.80
X-Spamd-Result: default: False [-2.80 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCPT_COUNT_SEVEN(0.00)[11];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.com:email];
	 FREEMAIL_TO(0.00)[gmail.com];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Flag: NO
X-Spam-Level: 
X-Spam-Score: -2.80
Authentication-Results: smtp-out1.suse.de;
	none

On Thu 07-12-23 14:38:22, Amir Goldstein wrote:
> generic_copy_file_range() is just a wrapper around splice_file_range().
> Move the wrapper to splice.h and rename it to splice_copy_file_range().
> 
> Suggested-by: Christoph Hellwig <hch@lst.de>
> Link: https://lore.kernel.org/linux-fsdevel/20231204083849.GC32438@lst.de/
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ceph/file.c         |  4 ++--
>  fs/fuse/file.c         |  5 +++--
>  fs/nfs/nfs4file.c      |  5 +++--
>  fs/read_write.c        | 34 ----------------------------------
>  fs/smb/client/cifsfs.c |  5 +++--
>  fs/splice.c            |  2 +-
>  include/linux/fs.h     |  3 ---
>  include/linux/splice.h |  8 ++++++++
>  8 files changed, 20 insertions(+), 46 deletions(-)
> 
> diff --git a/fs/ceph/file.c b/fs/ceph/file.c
> index f11de6e1f1c1..d380d9dad0e0 100644
> --- a/fs/ceph/file.c
> +++ b/fs/ceph/file.c
> @@ -3090,8 +3090,8 @@ static ssize_t ceph_copy_file_range(struct file *src_file, loff_t src_off,
>  				     len, flags);
>  
>  	if (ret == -EOPNOTSUPP || ret == -EXDEV)
> -		ret = generic_copy_file_range(src_file, src_off, dst_file,
> -					      dst_off, len, flags);
> +		ret = splice_copy_file_range(src_file, src_off, dst_file,
> +					     dst_off, len);
>  	return ret;
>  }
>  
> diff --git a/fs/fuse/file.c b/fs/fuse/file.c
> index a660f1f21540..148a71b8b4d0 100644
> --- a/fs/fuse/file.c
> +++ b/fs/fuse/file.c
> @@ -19,6 +19,7 @@
>  #include <linux/uio.h>
>  #include <linux/fs.h>
>  #include <linux/filelock.h>
> +#include <linux/splice.h>
>  
>  static int fuse_send_open(struct fuse_mount *fm, u64 nodeid,
>  			  unsigned int open_flags, int opcode,
> @@ -3195,8 +3196,8 @@ static ssize_t fuse_copy_file_range(struct file *src_file, loff_t src_off,
>  				     len, flags);
>  
>  	if (ret == -EOPNOTSUPP || ret == -EXDEV)
> -		ret = generic_copy_file_range(src_file, src_off, dst_file,
> -					      dst_off, len, flags);
> +		ret = splice_copy_file_range(src_file, src_off, dst_file,
> +					     dst_off, len);
>  	return ret;
>  }
>  
> diff --git a/fs/nfs/nfs4file.c b/fs/nfs/nfs4file.c
> index 02788c3c85e5..e238abc78a13 100644
> --- a/fs/nfs/nfs4file.c
> +++ b/fs/nfs/nfs4file.c
> @@ -10,6 +10,7 @@
>  #include <linux/mount.h>
>  #include <linux/nfs_fs.h>
>  #include <linux/nfs_ssc.h>
> +#include <linux/splice.h>
>  #include "delegation.h"
>  #include "internal.h"
>  #include "iostat.h"
> @@ -195,8 +196,8 @@ static ssize_t nfs4_copy_file_range(struct file *file_in, loff_t pos_in,
>  	ret = __nfs4_copy_file_range(file_in, pos_in, file_out, pos_out, count,
>  				     flags);
>  	if (ret == -EOPNOTSUPP || ret == -EXDEV)
> -		ret = generic_copy_file_range(file_in, pos_in, file_out,
> -					      pos_out, count, flags);
> +		ret = splice_copy_file_range(file_in, pos_in, file_out,
> +					     pos_out, count);
>  	return ret;
>  }
>  
> diff --git a/fs/read_write.c b/fs/read_write.c
> index 01a14570015b..97a9d5c7ad96 100644
> --- a/fs/read_write.c
> +++ b/fs/read_write.c
> @@ -1396,40 +1396,6 @@ COMPAT_SYSCALL_DEFINE4(sendfile64, int, out_fd, int, in_fd,
>  }
>  #endif
>  
> -/**
> - * generic_copy_file_range - copy data between two files
> - * @file_in:	file structure to read from
> - * @pos_in:	file offset to read from
> - * @file_out:	file structure to write data to
> - * @pos_out:	file offset to write data to
> - * @len:	amount of data to copy
> - * @flags:	copy flags
> - *
> - * This is a generic filesystem helper to copy data from one file to another.
> - * It has no constraints on the source or destination file owners - the files
> - * can belong to different superblocks and different filesystem types. Short
> - * copies are allowed.
> - *
> - * This should be called from the @file_out filesystem, as per the
> - * ->copy_file_range() method.
> - *
> - * Returns the number of bytes copied or a negative error indicating the
> - * failure.
> - */
> -
> -ssize_t generic_copy_file_range(struct file *file_in, loff_t pos_in,
> -				struct file *file_out, loff_t pos_out,
> -				size_t len, unsigned int flags)
> -{
> -	/* May only be called from within ->copy_file_range() methods */
> -	if (WARN_ON_ONCE(flags))
> -		return -EINVAL;
> -
> -	return splice_file_range(file_in, &pos_in, file_out, &pos_out,
> -				 min_t(size_t, len, MAX_RW_COUNT));
> -}
> -EXPORT_SYMBOL(generic_copy_file_range);
> -
>  /*
>   * Performs necessary checks before doing a file copy
>   *
> diff --git a/fs/smb/client/cifsfs.c b/fs/smb/client/cifsfs.c
> index ea3a7a668b45..ee461bf0ef63 100644
> --- a/fs/smb/client/cifsfs.c
> +++ b/fs/smb/client/cifsfs.c
> @@ -25,6 +25,7 @@
>  #include <linux/freezer.h>
>  #include <linux/namei.h>
>  #include <linux/random.h>
> +#include <linux/splice.h>
>  #include <linux/uuid.h>
>  #include <linux/xattr.h>
>  #include <uapi/linux/magic.h>
> @@ -1362,8 +1363,8 @@ static ssize_t cifs_copy_file_range(struct file *src_file, loff_t off,
>  	free_xid(xid);
>  
>  	if (rc == -EOPNOTSUPP || rc == -EXDEV)
> -		rc = generic_copy_file_range(src_file, off, dst_file,
> -					     destoff, len, flags);
> +		rc = splice_copy_file_range(src_file, off, dst_file,
> +					    destoff, len);
>  	return rc;
>  }
>  
> diff --git a/fs/splice.c b/fs/splice.c
> index 7cda013e5a1e..24bd93f8e4c3 100644
> --- a/fs/splice.c
> +++ b/fs/splice.c
> @@ -1243,7 +1243,7 @@ EXPORT_SYMBOL(do_splice_direct);
>   * @len:	number of bytes to splice
>   *
>   * Description:
> - *    For use by generic_copy_file_range() and ->copy_file_range() methods.
> + *    For use by ->copy_file_range() methods.
>   *    Like do_splice_direct(), but vfs_copy_file_range() already holds
>   *    start_file_write() on @out file.
>   *
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index 04422a0eccdd..900d0cd55b50 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -2090,9 +2090,6 @@ extern ssize_t vfs_read(struct file *, char __user *, size_t, loff_t *);
>  extern ssize_t vfs_write(struct file *, const char __user *, size_t, loff_t *);
>  extern ssize_t vfs_copy_file_range(struct file *, loff_t , struct file *,
>  				   loff_t, size_t, unsigned int);
> -extern ssize_t generic_copy_file_range(struct file *file_in, loff_t pos_in,
> -				       struct file *file_out, loff_t pos_out,
> -				       size_t len, unsigned int flags);
>  int __generic_remap_file_range_prep(struct file *file_in, loff_t pos_in,
>  				    struct file *file_out, loff_t pos_out,
>  				    loff_t *len, unsigned int remap_flags,
> diff --git a/include/linux/splice.h b/include/linux/splice.h
> index 49532d5dda52..b92c4676c59b 100644
> --- a/include/linux/splice.h
> +++ b/include/linux/splice.h
> @@ -89,6 +89,14 @@ long do_splice_direct(struct file *in, loff_t *ppos, struct file *out,
>  long splice_file_range(struct file *in, loff_t *ppos, struct file *out,
>  		       loff_t *opos, size_t len);
>  
> +static inline long splice_copy_file_range(struct file *in, loff_t pos_in,
> +					  struct file *out, loff_t pos_out,
> +					  size_t len)
> +{
> +	return splice_file_range(in, &pos_in, out, &pos_out,
> +				      min_t(size_t, len, MAX_RW_COUNT));
> +}
> +
>  extern long do_tee(struct file *in, struct file *out, size_t len,
>  		   unsigned int flags);
>  extern ssize_t splice_to_socket(struct pipe_inode_info *pipe, struct file *out,
> -- 
> 2.34.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

