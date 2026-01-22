Return-Path: <linux-fsdevel+bounces-75162-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +CnMIAGfcmm/ngAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75162-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 23:04:49 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 019566E09D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 23:04:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F400D3022919
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 22:04:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15DB439CEEA;
	Thu, 22 Jan 2026 22:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G7kIQZSr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 191D62517AC;
	Thu, 22 Jan 2026 22:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769119462; cv=none; b=QOGt8lDKvtHPaCCeoz+u5msPyS0qJIVcDKKVB7oiW5bzroM1I4HVv8UJVDW5DaXv7SqGGjoLqk9ktysomyCpWn7QuzASXXURmwra6cqd7A8hk42bfAH9NQ0i/mzOegR+iimts1z0jjKu7gaPtxNsHevHRUTw0GVxxfbgTBwg/Qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769119462; c=relaxed/simple;
	bh=rNt18OKEZslrDWFTYLSKyNaeJ0L6uX3jup7SCZjqnpA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YCyB1+DjEzrQ46HEtP2JsHWynvcDUK+z3URWGdwOiHRYH1p3t5kOU9l3GPxu5IuZTu/FuR/moE2slxldwVgFp0iqRiOSt5bDT73XA65yEN4q1s2HF43qsLSulnxxuqr/Ts0ShAbLynb28P9QsN/7xaXT7Kf6eOBdfs9lXOPA/RM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G7kIQZSr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F10CC116C6;
	Thu, 22 Jan 2026 22:04:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769119461;
	bh=rNt18OKEZslrDWFTYLSKyNaeJ0L6uX3jup7SCZjqnpA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=G7kIQZSrZSfzg/76EGOOXzKN9KXH8SVSDDiO183lHPs79El3vgOvKoMoTZ5jE0Zqo
	 ZwCLSZ/Fht0MffLcE25utPz20FypUtoztSKzn5gjGHIAcjfC13vnzlxZffwsqbbi2+
	 lxDgpfV0sfmdxPQw59AdIQoyR1Wi0a2zAtfjWNioMXaG0gRkRyn4b7Zx1Xspmn+hag
	 OfKljWZbvVxAa7RmvlzezHxA0311KQVQBlmrudjz/061n/aSxp85vDaCPRa/IgY2Q1
	 h6TykSofydk8FOWoBaPDIpRxy11+M7lnqrwBCvg9a139ZhTyLlfePexkv4/I3i+ucK
	 Yj6w+iB8PCeDw==
Date: Thu, 22 Jan 2026 14:04:20 -0800
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
Subject: Re: [PATCH 11/11] fsverity: use a hashtable to find the fsverity_info
Message-ID: <20260122220420.GI5910@frogsfrogsfrogs>
References: <20260122082214.452153-1-hch@lst.de>
 <20260122082214.452153-12-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260122082214.452153-12-hch@lst.de>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-75162-lists,linux-fsdevel=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,lst.de:email]
X-Rspamd-Queue-Id: 019566E09D
X-Rspamd-Action: no action

On Thu, Jan 22, 2026 at 09:22:07AM +0100, Christoph Hellwig wrote:
> Use the kernel's resizable hash table to find the fsverity_info.  This

Oh is that what the 'r' stands for?  I thought it was rcu.  Maybe it's
both. :P

> way file systems that want to support fsverity don't have to bloat
> every inode in the system with an extra pointer.  The tradeoff is that
> looking up the fsverity_info is a bit more expensive now, but the main
> operations are still dominated by I/O and hashing overhead.
> 
> Because insertation into the hash table now happens before S_VERITY is
> set, fsverity just becomes a barrier and a flag check and doesn't have
> to look up the fsverity_info at all, so there is only one two two

"one two two" <confused>?

> lookups per I/O operation depending on the file system and lookups
> in the ioctl path that is not performance critical.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  fs/btrfs/btrfs_inode.h       |  4 --
>  fs/btrfs/inode.c             |  3 --
>  fs/btrfs/verity.c            |  2 -
>  fs/ext4/ext4.h               |  4 --
>  fs/ext4/super.c              |  3 --
>  fs/ext4/verity.c             |  2 -
>  fs/f2fs/f2fs.h               |  3 --
>  fs/f2fs/super.c              |  3 --
>  fs/f2fs/verity.c             |  2 -
>  fs/verity/enable.c           | 30 ++++++++------
>  fs/verity/fsverity_private.h | 17 ++++----
>  fs/verity/open.c             | 75 ++++++++++++++++++++++-------------
>  fs/verity/verify.c           |  4 +-
>  include/linux/fsverity.h     | 77 +++++++++++-------------------------
>  14 files changed, 100 insertions(+), 129 deletions(-)
> 
> diff --git a/fs/btrfs/btrfs_inode.h b/fs/btrfs/btrfs_inode.h
> index 73602ee8de3f..55c272fe5d92 100644
> --- a/fs/btrfs/btrfs_inode.h
> +++ b/fs/btrfs/btrfs_inode.h
> @@ -339,10 +339,6 @@ struct btrfs_inode {
>  
>  	struct rw_semaphore i_mmap_lock;
>  
> -#ifdef CONFIG_FS_VERITY
> -	struct fsverity_info *i_verity_info;
> -#endif
> -
>  	struct inode vfs_inode;
>  };
>  
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index 67c64efc5099..93b2ce75fb06 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -8097,9 +8097,6 @@ static void init_once(void *foo)
>  	struct btrfs_inode *ei = foo;
>  
>  	inode_init_once(&ei->vfs_inode);
> -#ifdef CONFIG_FS_VERITY
> -	ei->i_verity_info = NULL;
> -#endif
>  }
>  
>  void __cold btrfs_destroy_cachep(void)
> diff --git a/fs/btrfs/verity.c b/fs/btrfs/verity.c
> index c152bef71e8b..cd96fac4739f 100644
> --- a/fs/btrfs/verity.c
> +++ b/fs/btrfs/verity.c
> @@ -795,8 +795,6 @@ static int btrfs_write_merkle_tree_block(struct file *file, const void *buf,
>  }
>  
>  const struct fsverity_operations btrfs_verityops = {
> -	.inode_info_offs         = (int)offsetof(struct btrfs_inode, i_verity_info) -
> -				   (int)offsetof(struct btrfs_inode, vfs_inode),

Ugliness, get thee gone! ;)

>  	.begin_enable_verity     = btrfs_begin_enable_verity,
>  	.end_enable_verity       = btrfs_end_enable_verity,
>  	.get_verity_descriptor   = btrfs_get_verity_descriptor,

<snip>

> diff --git a/fs/verity/enable.c b/fs/verity/enable.c
> index c56c18e2605b..94c88c419054 100644
> --- a/fs/verity/enable.c
> +++ b/fs/verity/enable.c
> @@ -265,9 +265,24 @@ static int enable_verity(struct file *filp,
>  		goto rollback;
>  	}
>  
> +	/*
> +	 * Add the fsverity_info into the hash table before finishing the
> +	 * initialization so that we don't have to undo the enabling when memory
> +	 * allocation for the hash table fails.  This is safe because looking up
> +	 * the fsverity_info always first checks the S_VERITY flag on the inode,
> +	 * which will only be set at the very end of the ->end_enable_verity
> +	 * method.
> +	 */
> +	err = fsverity_set_info(vi);
> +	if (err)
> +		goto rollback;
> +
>  	/*
>  	 * Tell the filesystem to finish enabling verity on the file.
> -	 * Serialized with ->begin_enable_verity() by the inode lock.
> +	 * Serialized with ->begin_enable_verity() by the inode lock.  The file
> +	 * system needs to set the S_VERITY flag on the inode at the very end of
> +	 * the method, at which point the fsverity information can be accessed
> +	 * by other threads.
>  	 */
>  	inode_lock(inode);
>  	err = vops->end_enable_verity(filp, desc, desc_size, params.tree_size);
> @@ -275,19 +290,10 @@ static int enable_verity(struct file *filp,
>  	if (err) {
>  		fsverity_err(inode, "%ps() failed with err %d",
>  			     vops->end_enable_verity, err);
> -		fsverity_free_info(vi);
> +		fsverity_remove_info(vi);
>  	} else if (WARN_ON_ONCE(!IS_VERITY(inode))) {
> +		fsverity_remove_info(vi);
>  		err = -EINVAL;
> -		fsverity_free_info(vi);
> -	} else {
> -		/* Successfully enabled verity */
> -
> -		/*
> -		 * Readers can start using the inode's verity info immediately,
> -		 * so it can't be rolled back once set.  So don't set it until
> -		 * just after the filesystem has successfully enabled verity.
> -		 */
> -		fsverity_set_info(inode, vi);
>  	}
>  out:
>  	kfree(params.hashstate);
> diff --git a/fs/verity/fsverity_private.h b/fs/verity/fsverity_private.h
> index 9018b71b3b23..fc1ef334d12c 100644
> --- a/fs/verity/fsverity_private.h
> +++ b/fs/verity/fsverity_private.h
> @@ -11,6 +11,7 @@
>  #define pr_fmt(fmt) "fs-verity: " fmt
>  
>  #include <linux/fsverity.h>
> +#include <linux/rhashtable.h>
>  
>  /*
>   * Implementation limit: maximum depth of the Merkle tree.  For now 8 is plenty;
> @@ -63,13 +64,14 @@ struct merkle_tree_params {
>   * fsverity_info - cached verity metadata for an inode
>   *
>   * When a verity file is first opened, an instance of this struct is allocated
> - * and a pointer to it is stored in the file's in-memory inode.  It remains
> - * until the inode is evicted.  It caches information about the Merkle tree
> - * that's needed to efficiently verify data read from the file.  It also caches
> - * the file digest.  The Merkle tree pages themselves are not cached here, but
> - * the filesystem may cache them.
> + * and a pointer to it is stored in the global hash table, indexed by the inode
> + * pointer value.  It remains alive until the inode is evicted.  It caches
> + * information about the Merkle tree that's needed to efficiently verify data
> + * read from the file.  It also caches the file digest.  The Merkle tree pages
> + * themselves are not cached here, but the filesystem may cache them.
>   */
>  struct fsverity_info {
> +	struct rhash_head rhash_head;
>  	struct merkle_tree_params tree_params;
>  	u8 root_hash[FS_VERITY_MAX_DIGEST_SIZE];
>  	u8 file_digest[FS_VERITY_MAX_DIGEST_SIZE];
> @@ -127,9 +129,8 @@ int fsverity_init_merkle_tree_params(struct merkle_tree_params *params,
>  struct fsverity_info *fsverity_create_info(const struct inode *inode,
>  					   struct fsverity_descriptor *desc);
>  
> -void fsverity_set_info(struct inode *inode, struct fsverity_info *vi);
> -
> -void fsverity_free_info(struct fsverity_info *vi);
> +int fsverity_set_info(struct fsverity_info *vi);
> +void fsverity_remove_info(struct fsverity_info *vi);
>  
>  int fsverity_get_descriptor(struct inode *inode,
>  			    struct fsverity_descriptor **desc_ret);
> diff --git a/fs/verity/open.c b/fs/verity/open.c
> index 090cb77326ee..f1640f4d3d3b 100644
> --- a/fs/verity/open.c
> +++ b/fs/verity/open.c
> @@ -12,6 +12,14 @@
>  #include <linux/slab.h>
>  
>  static struct kmem_cache *fsverity_info_cachep;
> +static struct rhashtable fsverity_info_hash;
> +
> +static const struct rhashtable_params fsverity_info_hash_params = {
> +	.key_len		= sizeof(struct inode *),

	.key_len		= sizeof_field(struct fsverity_info, inode),

Perhaps?

> +	.key_offset		= offsetof(struct fsverity_info, inode),
> +	.head_offset		= offsetof(struct fsverity_info, rhash_head),
> +	.automatic_shrinking	= true,
> +};
>  
>  /**
>   * fsverity_init_merkle_tree_params() - initialize Merkle tree parameters
> @@ -170,6 +178,13 @@ static void compute_file_digest(const struct fsverity_hash_alg *hash_alg,
>  	desc->sig_size = sig_size;
>  }
>  
> +static void fsverity_free_info(struct fsverity_info *vi)
> +{
> +	kfree(vi->tree_params.hashstate);
> +	kvfree(vi->hash_block_verified);
> +	kmem_cache_free(fsverity_info_cachep, vi);
> +}
> +
>  /*
>   * Create a new fsverity_info from the given fsverity_descriptor (with optional
>   * appended builtin signature), and check the signature if present.  The
> @@ -241,33 +256,18 @@ struct fsverity_info *fsverity_create_info(const struct inode *inode,
>  	return ERR_PTR(err);
>  }
>  
> -void fsverity_set_info(struct inode *inode, struct fsverity_info *vi)
> +int fsverity_set_info(struct fsverity_info *vi)
>  {
> -	/*
> -	 * Multiple tasks may race to set the inode's verity info pointer, so
> -	 * use cmpxchg_release().  This pairs with the smp_load_acquire() in
> -	 * fsverity_get_info().  I.e., publish the pointer with a RELEASE
> -	 * barrier so that other tasks can ACQUIRE it.
> -	 */
> -	if (cmpxchg_release(fsverity_info_addr(inode), NULL, vi) != NULL) {
> -		/* Lost the race, so free the verity info we allocated. */
> -		fsverity_free_info(vi);
> -		/*
> -		 * Afterwards, the caller may access the inode's verity info
> -		 * directly, so make sure to ACQUIRE the winning verity info.
> -		 */
> -		(void)fsverity_get_info(inode);
> -	}
> +	return rhashtable_lookup_insert_fast(&fsverity_info_hash,
> +			&vi->rhash_head, fsverity_info_hash_params);
>  }
>  
> -void fsverity_free_info(struct fsverity_info *vi)
> +struct fsverity_info *__fsverity_get_info(const struct inode *inode)
>  {
> -	if (!vi)
> -		return;
> -	kfree(vi->tree_params.hashstate);
> -	kvfree(vi->hash_block_verified);
> -	kmem_cache_free(fsverity_info_cachep, vi);
> +	return rhashtable_lookup_fast(&fsverity_info_hash, &inode,
> +			fsverity_info_hash_params);

Hrm.  The rhashtable stores a pointer to the rhash_head, but now we're
returning that as if it were a fsverity_info pointer.  Can I be pedantic
and ask for a proper container_of() to avoid leaving a landmine if the
struct layout ever changes?

>  }
> +EXPORT_SYMBOL_GPL(__fsverity_get_info);
>  
>  static bool validate_fsverity_descriptor(struct inode *inode,
>  					 const struct fsverity_descriptor *desc,
> @@ -352,7 +352,7 @@ int fsverity_get_descriptor(struct inode *inode,
>  
>  static int ensure_verity_info(struct inode *inode)
>  {
> -	struct fsverity_info *vi = fsverity_get_info(inode);
> +	struct fsverity_info *vi = fsverity_get_info(inode), *found;
>  	struct fsverity_descriptor *desc;
>  	int err;
>  
> @@ -369,8 +369,18 @@ static int ensure_verity_info(struct inode *inode)
>  		goto out_free_desc;
>  	}
>  
> -	fsverity_set_info(inode, vi);
> -	err = 0;
> +	/*
> +	 * Multiple tasks may race to set the inode's verity info, in which case
> +	 * we might find an existing fsverity_info in the hash table.
> +	 */
> +	found = rhashtable_lookup_get_insert_fast(&fsverity_info_hash,
> +			&vi->rhash_head, fsverity_info_hash_params);
> +	if (found) {
> +		fsverity_free_info(vi);
> +		if (IS_ERR(found))
> +			err = PTR_ERR(found);
> +	}
> +
>  out_free_desc:
>  	kfree(desc);
>  	return err;
> @@ -384,16 +394,25 @@ int __fsverity_file_open(struct inode *inode, struct file *filp)
>  }
>  EXPORT_SYMBOL_GPL(__fsverity_file_open);
>  
> +void fsverity_remove_info(struct fsverity_info *vi)
> +{
> +	rhashtable_remove_fast(&fsverity_info_hash, &vi->rhash_head,
> +			fsverity_info_hash_params);
> +	fsverity_free_info(vi);
> +}
> +
>  void fsverity_cleanup_inode(struct inode *inode)
>  {
> -	struct fsverity_info **vi_addr = fsverity_info_addr(inode);
> +	struct fsverity_info *vi = fsverity_get_info(inode);
>  
> -	fsverity_free_info(*vi_addr);
> -	*vi_addr = NULL;
> +	if (vi)
> +		fsverity_remove_info(vi);
>  }
>  
>  void __init fsverity_init_info_cache(void)
>  {
> +	if (rhashtable_init(&fsverity_info_hash, &fsverity_info_hash_params))
> +		panic("failed to initialize fsverity hash\n");
>  	fsverity_info_cachep = KMEM_CACHE_USERCOPY(
>  					fsverity_info,
>  					SLAB_RECLAIM_ACCOUNT | SLAB_PANIC,
> diff --git a/fs/verity/verify.c b/fs/verity/verify.c
> index 74792cd8b037..4ae926528dd5 100644
> --- a/fs/verity/verify.c
> +++ b/fs/verity/verify.c
> @@ -323,9 +323,9 @@ fsverity_init_verification_context(struct fsverity_verification_context *ctx,
>  				   struct fsverity_info *vi)
>  {
>  	ctx->inode = inode;
> -	ctx->vi = vi;

Can this function drop its @vi argument?

> +	ctx->vi = fsverity_get_info(inode);
>  	ctx->num_pending = 0;
> -	if (vi->tree_params.hash_alg->algo_id == HASH_ALGO_SHA256 &&
> +	if (ctx->vi->tree_params.hash_alg->algo_id == HASH_ALGO_SHA256 &&
>  	    sha256_finup_2x_is_optimized())
>  		ctx->max_pending = 2;
>  	else
> diff --git a/include/linux/fsverity.h b/include/linux/fsverity.h
> index c044285b6aff..20282493402c 100644
> --- a/include/linux/fsverity.h
> +++ b/include/linux/fsverity.h
> @@ -30,13 +30,6 @@ struct fsverity_info;
>  
>  /* Verity operations for filesystems */
>  struct fsverity_operations {
> -	/**
> -	 * The offset of the pointer to struct fsverity_info in the
> -	 * filesystem-specific part of the inode, relative to the beginning of
> -	 * the common part of the inode (the 'struct inode').
> -	 */
> -	ptrdiff_t inode_info_offs;
> -
>  	/**
>  	 * Begin enabling verity on the given file.
>  	 *
> @@ -142,40 +135,6 @@ struct fsverity_operations {
>  };
>  
>  #ifdef CONFIG_FS_VERITY
> -
> -/*
> - * Returns the address of the verity info pointer within the filesystem-specific
> - * part of the inode.  (To save memory on filesystems that don't support
> - * fsverity, a field in 'struct inode' itself is no longer used.)
> - */
> -static inline struct fsverity_info **
> -fsverity_info_addr(const struct inode *inode)
> -{
> -	VFS_WARN_ON_ONCE(inode->i_sb->s_vop->inode_info_offs == 0);
> -	return (void *)inode + inode->i_sb->s_vop->inode_info_offs;
> -}
> -
> -static inline struct fsverity_info *fsverity_get_info(const struct inode *inode)
> -{
> -	/*
> -	 * Since this function can be called on inodes belonging to filesystems
> -	 * that don't support fsverity at all, and fsverity_info_addr() doesn't
> -	 * work on such filesystems, we have to start with an IS_VERITY() check.
> -	 * Checking IS_VERITY() here is also useful to minimize the overhead of
> -	 * fsverity_active() on non-verity files.
> -	 */
> -	if (!IS_VERITY(inode))
> -		return NULL;
> -
> -	/*
> -	 * Pairs with the cmpxchg_release() in fsverity_set_info().  I.e.,
> -	 * another task may publish the inode's verity info concurrently,
> -	 * executing a RELEASE barrier.  Use smp_load_acquire() here to safely
> -	 * ACQUIRE the memory the other task published.
> -	 */
> -	return smp_load_acquire(fsverity_info_addr(inode));
> -}
> -
>  /* enable.c */
>  
>  int fsverity_ioctl_enable(struct file *filp, const void __user *arg);
> @@ -204,11 +163,6 @@ void fsverity_enqueue_verify_work(struct work_struct *work);
>  
>  #else /* !CONFIG_FS_VERITY */
>  
> -static inline struct fsverity_info *fsverity_get_info(const struct inode *inode)
> -{
> -	return NULL;
> -}
> -
>  /* enable.c */
>  
>  static inline int fsverity_ioctl_enable(struct file *filp,
> @@ -289,18 +243,35 @@ static inline bool fsverity_verify_page(struct fsverity_info *vi,
>   * fsverity_active() - do reads from the inode need to go through fs-verity?
>   * @inode: inode to check
>   *
> - * This checks whether the inode's verity info has been set.
> - *
> - * Filesystems call this from ->readahead() to check whether the pages need to
> - * be verified or not.  Don't use IS_VERITY() for this purpose; it's subject to
> - * a race condition where the file is being read concurrently with
> - * FS_IOC_ENABLE_VERITY completing.  (S_VERITY is set before the verity info.)
> + * This checks whether the inode's verity info has been set, and reads need
> + * to verify the verity information.
>   *
>   * Return: true if reads need to go through fs-verity, otherwise false
>   */
>  static inline bool fsverity_active(const struct inode *inode)
>  {
> -	return fsverity_get_info(inode) != NULL;
> +	/*
> +	 * The memory barrier pairs with the try_cmpxchg in set_mask_bits used
> +	 * to set the S_VERITY bit in i_flags.
> +	 */
> +	smp_mb();
> +	return IS_ENABLED(CONFIG_FS_VERITY) && IS_VERITY(inode);
> +}
> +
> +/**
> + * fsverity_get_info - get fsverity information for an inode
> + * @inode: inode to operate on.
> + *
> + * This gets the fsverity_info for @inode if it exists.  Safe to call without
> + * knowin that a fsverity_info exist for @inode, including on file systems that
> + * do not support fsverity.
> + */
> +struct fsverity_info *__fsverity_get_info(const struct inode *inode);
> +static inline struct fsverity_info *fsverity_get_info(const struct inode *inode)
> +{
> +	if (!fsverity_active(inode))
> +		return NULL;
> +	return __fsverity_get_info(inode);
>  }
>  
>  /**
> -- 
> 2.47.3
> 
> 

