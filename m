Return-Path: <linux-fsdevel+bounces-55790-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E3B1B0EDE7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Jul 2025 10:59:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3109C561CDF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Jul 2025 08:59:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E803E277C90;
	Wed, 23 Jul 2025 08:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QQYXvPdi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EBF427CCE7;
	Wed, 23 Jul 2025 08:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753261133; cv=none; b=K8eRGn3T4QkLoH4He77zGvTiwIOgRVkZa3TR4tp7SxzzDV9Ab4qlRhH9IgHzMnss2/93WUahX87r9+g4LTDX9/tzqh9ccdFPy7NE2CJ+TO6LDCcaOBXXZEyDl5Vf0VvyWFA1Ks2xM5/cuxiuBPwG+/6cz/T4S4EWLNqxraIUj/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753261133; c=relaxed/simple;
	bh=Jth7KSZbGKyZa4BDp+8Suo+8V3L6qR+kg170w9YMLYw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tb13J1lnh7XxWT1pLOGiXqNckcCx8SBCIFNpuMkOxh3FUcwrCzioekjSReKXgBdibiOWBh7bLoRdWFToutq6X2yS0qon8rvXwom9+avwhVRNmrPt/kguek3wGjbojAMzqogj5ZoRXMplz95AK2g8FAZEnYx+1VvuZ1jHT2qZSeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QQYXvPdi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CB08C4CEE7;
	Wed, 23 Jul 2025 08:58:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753261132;
	bh=Jth7KSZbGKyZa4BDp+8Suo+8V3L6qR+kg170w9YMLYw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QQYXvPdiuTZNTO9DLzAlIkMyXBz8hqFNP8HW6DbnkPaZwyUOSJWOcw+08X1DU/CTp
	 A5NCMJD16FlveBN4PwSRktw6kZGUCct0EGHeSD/eyQ7pNpSWFtVfIf5zG/tBLoV4A5
	 9JsesPzaSVOB6B20hcggDspCrQmk8yY5x1QMGMd8rorBr+C49FgFGstVe+LGU0eeCL
	 HAAEdmaP6ifgdFBxPkn2KI4bhK45bx3E9WE1jEX4ld9OapVTasj22knINmIfqLQzwF
	 aXm2A6lOKgczvxuvPfjnWU83huXyRteLnZSjR2I6X6jLPuZ1yZSiaMiKvgrwqZkuVz
	 bfy4gr9pe8t5g==
Date: Wed, 23 Jul 2025 10:58:47 +0200
From: Christian Brauner <brauner@kernel.org>
To: Eric Biggers <ebiggers@kernel.org>
Cc: Jeff Layton <jlayton@kernel.org>, Jan Kara <jack@suse.com>, 
	Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>, Josef Bacik <josef@toxicpanda.com>, 
	"Theodore Y. Ts'o" <tytso@mit.edu>, linux-fsdevel@vger.kernel.org, linux-fscrypt@vger.kernel.org, 
	fsverity@lists.linux.dev
Subject: Re: [PATCH v3 06/13] ceph: move fscrypt to filesystem inode
Message-ID: <20250723-umworben-rundgang-0e6ed3162db3@brauner>
References: <20250722-work-inode-fscrypt-v3-0-bdc1033420a0@kernel.org>
 <20250722-work-inode-fscrypt-v3-6-bdc1033420a0@kernel.org>
 <20250722201406.GC111676@quark>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250722201406.GC111676@quark>

On Tue, Jul 22, 2025 at 01:14:06PM -0700, Eric Biggers wrote:
> On Tue, Jul 22, 2025 at 09:27:24PM +0200, Christian Brauner wrote:
> > Move fscrypt data pointer into the filesystem's private inode and record
> > the offset from the embedded struct inode.
> > 
> > This will allow us to drop the fscrypt data pointer from struct inode
> > itself and move it into the filesystem's inode.
> > 
> > Signed-off-by: Christian Brauner <brauner@kernel.org>
> > ---
> >  fs/ceph/super.c       | 4 ++++
> >  include/linux/netfs.h | 6 ++++++
> >  2 files changed, 10 insertions(+)
> > 
> > diff --git a/fs/ceph/super.c b/fs/ceph/super.c
> > index 2b8438d8a324..540b32e746de 100644
> > --- a/fs/ceph/super.c
> > +++ b/fs/ceph/super.c
> > @@ -1039,6 +1039,10 @@ void ceph_umount_begin(struct super_block *sb)
> >  }
> >  
> >  static const struct super_operations ceph_super_ops = {
> > +#ifdef CONFIG_FS_ENCRYPTION
> > +	.i_fscrypt = offsetof(struct ceph_inode_info, netfs.i_fscrypt_info) -
> > +		     offsetof(struct ceph_inode_info, netfs.inode),
> > +#endif
> >  	.alloc_inode	= ceph_alloc_inode,
> >  	.free_inode	= ceph_free_inode,
> >  	.write_inode    = ceph_write_inode,
> > diff --git a/include/linux/netfs.h b/include/linux/netfs.h
> > index 065c17385e53..fda1321da861 100644
> > --- a/include/linux/netfs.h
> > +++ b/include/linux/netfs.h
> > @@ -57,6 +57,9 @@ typedef void (*netfs_io_terminated_t)(void *priv, ssize_t transferred_or_error);
> >   */
> >  struct netfs_inode {
> >  	struct inode		inode;		/* The VFS inode */
> > +#ifdef CONFIG_FS_ENCRYPTION
> > +	struct fscrypt_inode_info *i_fscrypt_info;
> > +#endif
> >  	const struct netfs_request_ops *ops;
> >  #if IS_ENABLED(CONFIG_FSCACHE)
> >  	struct fscache_cookie	*cache;
> > @@ -503,6 +506,9 @@ static inline void netfs_inode_init(struct netfs_inode *ctx,
> >  		ctx->zero_point = ctx->remote_i_size;
> >  		mapping_set_release_always(ctx->inode.i_mapping);
> >  	}
> > +#ifdef CONFIG_FS_ENCRYPTION
> > +	ctx->i_fscrypt_info = NULL;
> > +#endif
> 
> Why netfs_inode instead of ceph_inode_info?

If we add asserts that struct inode must be located at the beginning of
struct netfs_inode then I would feel comfortable doing that. I'll do
that.

