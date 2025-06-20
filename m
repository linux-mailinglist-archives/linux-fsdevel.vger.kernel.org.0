Return-Path: <linux-fsdevel+bounces-52307-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BEF8CAE1618
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Jun 2025 10:33:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7CABD19E6894
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Jun 2025 08:32:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D77A238140;
	Fri, 20 Jun 2025 08:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tNJsdDEu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80A9B30E84F;
	Fri, 20 Jun 2025 08:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750408290; cv=none; b=ixX5JPVGFBXGdyQFavQF2l2qM3e61TBvodMpDwO7t8qb4QLCdPGE5GpPs7uCmRXNOmgGbo0D3R+IJGydaC3tDfrUSr10kOLBFvnDCpBA3Wh/b33aiITZlUgDFKpOgdWoAxNno/7lr0px5hEHjyicK4zIs7XYUzG7hTBMi1DDjHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750408290; c=relaxed/simple;
	bh=Bhu2W2Zp0blQzM5tWuUNkvTkKuqo41pZEk+2ifIlZgw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cUWRNwKdv6HGG4QOHCXy/InEOcRwHQpGd6hAILf8Sw/EQLIzhdn1nR+Znh8Q9bmMKmWH4BAMTMc/zNXVvWyC+d8+8Kv72fHWlht/4LfXIe3LxtYixxACDHsFqCEMcgtMWe0hr2a3E4Bj/p2Au7BYNPG25nx9Y8eMEjb9ReboBC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tNJsdDEu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A50CC4CEE3;
	Fri, 20 Jun 2025 08:31:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750408290;
	bh=Bhu2W2Zp0blQzM5tWuUNkvTkKuqo41pZEk+2ifIlZgw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tNJsdDEualaroLs6cNc/FDnBC0ZDCzgl7Seo0MRUcyRryD8iggojfPlU6rNhjS7nw
	 BWtBoU5RIEL8sRLABuFd+FzR7xoMqAuleDTdiGy9pJSe9kBVC7elXMJNhXlo7kkt7/
	 RpAKYlYea16J8HyTzQJXY/P4rRkI5Gqi07GqhFP3rqe6hvbVSrtintLAfcrKbae5tR
	 lwy6LiLkrQI+VfgD2E3qlzh4s3rbfvuqnh30ONY/O8XlFFkHPsQSGb7mpBFszWSqH+
	 h2CDrZDZhZRZLf5aZvHkFzsiJyA7GrdhBn8qIkCtcCZcWlxwbb5BgkynGb3x/Ao8fd
	 dZiQHdyVv2yUQ==
Date: Fri, 20 Jun 2025 11:31:19 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Shivank Garg <shivankg@amd.com>
Cc: david@redhat.com, akpm@linux-foundation.org, brauner@kernel.org,
	paul@paul-moore.com, viro@zeniv.linux.org.uk, seanjc@google.com,
	vbabka@suse.cz, willy@infradead.org, pbonzini@redhat.com,
	tabba@google.com, afranji@google.com, ackerleytng@google.com,
	jack@suse.cz, hch@infradead.org, cgzones@googlemail.com,
	ira.weiny@intel.com, roypat@amazon.co.uk,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: Re: [PATCH V2] fs: export anon_inode_make_secure_inode() and fix
 secretmem LSM bypass
Message-ID: <aFUcV-zbJYzAdYig@kernel.org>
References: <20250620070328.803704-3-shivankg@amd.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250620070328.803704-3-shivankg@amd.com>

On Fri, Jun 20, 2025 at 07:03:30AM +0000, Shivank Garg wrote:
> Export anon_inode_make_secure_inode() to allow KVM guest_memfd to create
> anonymous inodes with proper security context. This replaces the current
> pattern of calling alloc_anon_inode() followed by
> inode_init_security_anon() for creating security context manually.
> 
> This change also fixes a security regression in secretmem where the
> S_PRIVATE flag was not cleared after alloc_anon_inode(), causing
> LSM/SELinux checks to be bypassed for secretmem file descriptors.
> 
> As guest_memfd currently resides in the KVM module, we need to export this
> symbol for use outside the core kernel. In the future, guest_memfd might be
> moved to core-mm, at which point the symbols no longer would have to be
> exported. When/if that happens is still unclear.
> 
> Fixes: 2bfe15c52612 ("mm: create security context for memfd_secret inodes")
> Suggested-by: David Hildenbrand <david@redhat.com>
> Suggested-by: Mike Rapoport <rppt@kernel.org>
> Signed-off-by: Shivank Garg <shivankg@amd.com>

Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

> ---
> The handling of the S_PRIVATE flag for these inodes was discussed
> extensively ([1], [2], [3]).
> 
> As per discussion [3] with Mike and Paul, KVM guest_memfd and secretmem
> result in user-visible file descriptors, so they should be subject to
> LSM/SELinux security policies rather than bypassing them with S_PRIVATE.
> 
> [1] https://lore.kernel.org/all/b9e5fa41-62fd-4b3d-bb2d-24ae9d3c33da@redhat.com
> [2] https://lore.kernel.org/all/cover.1748890962.git.ackerleytng@google.com
> [3] https://lore.kernel.org/all/aFOh8N_rRdSi_Fbc@kernel.org
> 
> V1->V2: Use EXPORT_SYMBOL_GPL_FOR_MODULES() since KVM is the only user.
> 
>  fs/anon_inodes.c   | 23 ++++++++++++++++++-----
>  include/linux/fs.h |  2 ++
>  mm/secretmem.c     |  9 +--------
>  3 files changed, 21 insertions(+), 13 deletions(-)
> 
> diff --git a/fs/anon_inodes.c b/fs/anon_inodes.c
> index e51e7d88980a..1d847a939f29 100644
> --- a/fs/anon_inodes.c
> +++ b/fs/anon_inodes.c
> @@ -98,14 +98,25 @@ static struct file_system_type anon_inode_fs_type = {
>  	.kill_sb	= kill_anon_super,
>  };
>  
> -static struct inode *anon_inode_make_secure_inode(
> -	const char *name,
> -	const struct inode *context_inode)
> +/**
> + * anon_inode_make_secure_inode - allocate an anonymous inode with security context
> + * @sb:		[in]	Superblock to allocate from
> + * @name:	[in]	Name of the class of the newfile (e.g., "secretmem")
> + * @context_inode:
> + *		[in]	Optional parent inode for security inheritance
> + *
> + * The function ensures proper security initialization through the LSM hook
> + * security_inode_init_security_anon().
> + *
> + * Return:	Pointer to new inode on success, ERR_PTR on failure.
> + */
> +struct inode *anon_inode_make_secure_inode(struct super_block *sb, const char *name,
> +					   const struct inode *context_inode)
>  {
>  	struct inode *inode;
>  	int error;
>  
> -	inode = alloc_anon_inode(anon_inode_mnt->mnt_sb);
> +	inode = alloc_anon_inode(sb);
>  	if (IS_ERR(inode))
>  		return inode;
>  	inode->i_flags &= ~S_PRIVATE;
> @@ -118,6 +129,7 @@ static struct inode *anon_inode_make_secure_inode(
>  	}
>  	return inode;
>  }
> +EXPORT_SYMBOL_GPL_FOR_MODULES(anon_inode_make_secure_inode, "kvm");
>  
>  static struct file *__anon_inode_getfile(const char *name,
>  					 const struct file_operations *fops,
> @@ -132,7 +144,8 @@ static struct file *__anon_inode_getfile(const char *name,
>  		return ERR_PTR(-ENOENT);
>  
>  	if (make_inode) {
> -		inode =	anon_inode_make_secure_inode(name, context_inode);
> +		inode =	anon_inode_make_secure_inode(anon_inode_mnt->mnt_sb,
> +						     name, context_inode);
>  		if (IS_ERR(inode)) {
>  			file = ERR_CAST(inode);
>  			goto err;
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index b085f161ed22..040c0036320f 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -3608,6 +3608,8 @@ extern int simple_write_begin(struct file *file, struct address_space *mapping,
>  extern const struct address_space_operations ram_aops;
>  extern int always_delete_dentry(const struct dentry *);
>  extern struct inode *alloc_anon_inode(struct super_block *);
> +struct inode *anon_inode_make_secure_inode(struct super_block *sb, const char *name,
> +					   const struct inode *context_inode);
>  extern int simple_nosetlease(struct file *, int, struct file_lease **, void **);
>  extern const struct dentry_operations simple_dentry_operations;
>  
> diff --git a/mm/secretmem.c b/mm/secretmem.c
> index 589b26c2d553..9a11a38a6770 100644
> --- a/mm/secretmem.c
> +++ b/mm/secretmem.c
> @@ -195,18 +195,11 @@ static struct file *secretmem_file_create(unsigned long flags)
>  	struct file *file;
>  	struct inode *inode;
>  	const char *anon_name = "[secretmem]";
> -	int err;
>  
> -	inode = alloc_anon_inode(secretmem_mnt->mnt_sb);
> +	inode = anon_inode_make_secure_inode(secretmem_mnt->mnt_sb, anon_name, NULL);
>  	if (IS_ERR(inode))
>  		return ERR_CAST(inode);
>  
> -	err = security_inode_init_security_anon(inode, &QSTR(anon_name), NULL);
> -	if (err) {
> -		file = ERR_PTR(err);
> -		goto err_free_inode;
> -	}
> -
>  	file = alloc_file_pseudo(inode, secretmem_mnt, "secretmem",
>  				 O_RDWR, &secretmem_fops);
>  	if (IS_ERR(file))
> -- 
> 2.43.0
> 

-- 
Sincerely yours,
Mike.

