Return-Path: <linux-fsdevel+bounces-1095-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76CC07D5495
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Oct 2023 17:01:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A83541C20C05
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Oct 2023 15:01:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED80129414;
	Tue, 24 Oct 2023 15:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gCgiTpzW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A66614ABF
	for <linux-fsdevel@vger.kernel.org>; Tue, 24 Oct 2023 15:00:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7F6BC433C8;
	Tue, 24 Oct 2023 15:00:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698159653;
	bh=1er9HDGuyZurPRrSEMxddQ3gFQVJxN7X/63TVQfVyDM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gCgiTpzW+N0zqUe1030TfPCtTzFbG2nIDdcPEgBtxnHx3Q4IcfKswjDuxXnOO/iLX
	 CpreOOIL3IF/282EdX3MV7RK3en1zf9Qx0KLe1qfjZaE9dHZgcA8bI2InlExVuP/Y8
	 LossIoICrvSkNYgqxTxj57G00NyG6zRFwn+nAqSzPWqonzLutkbcFaFQcTkwwTp7Wr
	 YTCz5/kNWXt0O7B7K63Lu1HqdMovwrvZ7bZjhs0jcOO8NAxdQubQVIXt8qXzYE6aEf
	 yrSnMPWRyyJl65YpTF39U90ePMG9hSQ+ljD6CZ+ZnIQCpPgqpMqD0its6wU319jJWT
	 Ei9hGlPoFSvZQ==
Date: Tue, 24 Oct 2023 08:00:53 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Matthew Wilcox <willy@infradead.org>,
	Ilya Dryomov <idryomov@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 1/3] filemap: add a per-mapping stable writes flag
Message-ID: <20231024150053.GY3195650@frogsfrogsfrogs>
References: <20231024064416.897956-1-hch@lst.de>
 <20231024064416.897956-2-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231024064416.897956-2-hch@lst.de>

On Tue, Oct 24, 2023 at 08:44:14AM +0200, Christoph Hellwig wrote:
> folio_wait_stable waits for writeback to finish before modifying the
> contents of a folio again, e.g. to support check summing of the data
> in the block integrity code.
> 
> Currently this behavior is controlled by the SB_I_STABLE_WRITES flag
> on the super_block, which means it is uniform for the entire file system.
> This is wrong for the block device pseudofs which is shared by all
> block devices, or file systems that can use multiple devices like XFS
> witht the RT subvolume or btrfs (although btrfs currently reimplements
> folio_wait_stable anyway).
> 
> Add a per-address_space AS_STABLE_WRITES flag to control the behavior
> in a more fine grained way.  The existing SB_I_STABLE_WRITES is kept
> to initialize AS_STABLE_WRITES to the existing default which covers
> most cases.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  fs/inode.c              |  2 ++
>  include/linux/pagemap.h | 17 +++++++++++++++++
>  mm/page-writeback.c     |  2 +-

For a hot second I wondered if we could get rid of SB_I_STABLE_WRITES
too, but then had an AHA moment when I saw that NFS also sets it.

This looks reasonable,
Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

>  3 files changed, 20 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/inode.c b/fs/inode.c
> index 84bc3c76e5ccb5..ae1a6410b53d7e 100644
> --- a/fs/inode.c
> +++ b/fs/inode.c
> @@ -215,6 +215,8 @@ int inode_init_always(struct super_block *sb, struct inode *inode)
>  	lockdep_set_class_and_name(&mapping->invalidate_lock,
>  				   &sb->s_type->invalidate_lock_key,
>  				   "mapping.invalidate_lock");
> +	if (sb->s_iflags & SB_I_STABLE_WRITES)
> +		mapping_set_stable_writes(mapping);
>  	inode->i_private = NULL;
>  	inode->i_mapping = mapping;
>  	INIT_HLIST_HEAD(&inode->i_dentry);	/* buggered by rcu freeing */
> diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
> index 351c3b7f93a14e..8c9608b217b000 100644
> --- a/include/linux/pagemap.h
> +++ b/include/linux/pagemap.h
> @@ -204,6 +204,8 @@ enum mapping_flags {
>  	AS_NO_WRITEBACK_TAGS = 5,
>  	AS_LARGE_FOLIO_SUPPORT = 6,
>  	AS_RELEASE_ALWAYS,	/* Call ->release_folio(), even if no private data */
> +	AS_STABLE_WRITES,	/* must wait for writeback before modifying
> +				   folio contents */
>  };
>  
>  /**
> @@ -289,6 +291,21 @@ static inline void mapping_clear_release_always(struct address_space *mapping)
>  	clear_bit(AS_RELEASE_ALWAYS, &mapping->flags);
>  }
>  
> +static inline bool mapping_stable_writes(const struct address_space *mapping)
> +{
> +	return test_bit(AS_STABLE_WRITES, &mapping->flags);
> +}
> +
> +static inline void mapping_set_stable_writes(struct address_space *mapping)
> +{
> +	set_bit(AS_STABLE_WRITES, &mapping->flags);
> +}
> +
> +static inline void mapping_clear_stable_writes(struct address_space *mapping)
> +{
> +	clear_bit(AS_STABLE_WRITES, &mapping->flags);
> +}
> +
>  static inline gfp_t mapping_gfp_mask(struct address_space * mapping)
>  {
>  	return mapping->gfp_mask;
> diff --git a/mm/page-writeback.c b/mm/page-writeback.c
> index b8d3d7040a506a..4656534b8f5cc6 100644
> --- a/mm/page-writeback.c
> +++ b/mm/page-writeback.c
> @@ -3110,7 +3110,7 @@ EXPORT_SYMBOL_GPL(folio_wait_writeback_killable);
>   */
>  void folio_wait_stable(struct folio *folio)
>  {
> -	if (folio_inode(folio)->i_sb->s_iflags & SB_I_STABLE_WRITES)
> +	if (mapping_stable_writes(folio_mapping(folio)))
>  		folio_wait_writeback(folio);
>  }
>  EXPORT_SYMBOL_GPL(folio_wait_stable);
> -- 
> 2.39.2
> 

