Return-Path: <linux-fsdevel+bounces-55745-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1326BB0E4A0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Jul 2025 22:14:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4752C567B0D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Jul 2025 20:14:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1B7A285071;
	Tue, 22 Jul 2025 20:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eK/UBjpi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50CC2284674;
	Tue, 22 Jul 2025 20:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753215253; cv=none; b=GvqCOIS7WQJdXitf4YxNbJPFSBvYF0kGb6jZYmcoAC65MiN5vXiLc4TRX3IjWkfJTB0qx8FgdirIU9aBsMEcanIC0JmyWPY2VP3x72vflUIu7SZkfty2RdoaqCAAHJqLqekBmfm0BMPUw1wsJzJgxnTSWvaSSwS04MX/KUxvoTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753215253; c=relaxed/simple;
	bh=tSl90GWDRVxHX+Fky0oJ1AnLu55k0xD9cyX4ItH/dCo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G9tl57tTsznpmV9Zv1CIePfTY/fg9rJirPFIknDLtzgEs3cye7hNN4z1O4ONC9ynoyoaypgnp/SIHEkAEAtgIJ69PVVJo8GrhwY9SNe4oICIklzyiiHOHuzNz5/TCLvfMBgqBmLRqeRh9nHA74ogHEsmKoW1Q7LyBHYGnqH/BVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eK/UBjpi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB9FEC4CEEB;
	Tue, 22 Jul 2025 20:14:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753215252;
	bh=tSl90GWDRVxHX+Fky0oJ1AnLu55k0xD9cyX4ItH/dCo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eK/UBjpieVawmQfSTj7Trvp4/LZjfrvGDbL6+Uby38H/HbiVi8MMEYpSJzjHokoPI
	 TiuMZkDfpYbUcfiMSJx1Z1Om+jPzpTJXnMKnXWAhhH25qslZDqeHjTTgEdoihWuW3h
	 kIlAGNf5ryY4/ZiYQ86N91vixyYZr24Up9XRZVj33/dGTpLZZneDWPKD2Ry4ARV4Fz
	 yugZVAMiQESmuTKiF6P/y7d7nUaNdgHLQvflLt6gibNLaYZKveqWInUugJnaZg+Edu
	 RGHykCucgFmJsu3QGg5zZXYb/95ZKs/cdUm91qb3RCIsTf6VJDiVdHbTTVxMs5R0R0
	 bbtsl8fSW91WA==
Date: Tue, 22 Jul 2025 13:14:06 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Christian Brauner <brauner@kernel.org>
Cc: Jeff Layton <jlayton@kernel.org>, Jan Kara <jack@suse.com>,
	Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	Josef Bacik <josef@toxicpanda.com>,
	"Theodore Y. Ts'o" <tytso@mit.edu>, linux-fsdevel@vger.kernel.org,
	linux-fscrypt@vger.kernel.org, fsverity@lists.linux.dev
Subject: Re: [PATCH v3 06/13] ceph: move fscrypt to filesystem inode
Message-ID: <20250722201406.GC111676@quark>
References: <20250722-work-inode-fscrypt-v3-0-bdc1033420a0@kernel.org>
 <20250722-work-inode-fscrypt-v3-6-bdc1033420a0@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250722-work-inode-fscrypt-v3-6-bdc1033420a0@kernel.org>

On Tue, Jul 22, 2025 at 09:27:24PM +0200, Christian Brauner wrote:
> Move fscrypt data pointer into the filesystem's private inode and record
> the offset from the embedded struct inode.
> 
> This will allow us to drop the fscrypt data pointer from struct inode
> itself and move it into the filesystem's inode.
> 
> Signed-off-by: Christian Brauner <brauner@kernel.org>
> ---
>  fs/ceph/super.c       | 4 ++++
>  include/linux/netfs.h | 6 ++++++
>  2 files changed, 10 insertions(+)
> 
> diff --git a/fs/ceph/super.c b/fs/ceph/super.c
> index 2b8438d8a324..540b32e746de 100644
> --- a/fs/ceph/super.c
> +++ b/fs/ceph/super.c
> @@ -1039,6 +1039,10 @@ void ceph_umount_begin(struct super_block *sb)
>  }
>  
>  static const struct super_operations ceph_super_ops = {
> +#ifdef CONFIG_FS_ENCRYPTION
> +	.i_fscrypt = offsetof(struct ceph_inode_info, netfs.i_fscrypt_info) -
> +		     offsetof(struct ceph_inode_info, netfs.inode),
> +#endif
>  	.alloc_inode	= ceph_alloc_inode,
>  	.free_inode	= ceph_free_inode,
>  	.write_inode    = ceph_write_inode,
> diff --git a/include/linux/netfs.h b/include/linux/netfs.h
> index 065c17385e53..fda1321da861 100644
> --- a/include/linux/netfs.h
> +++ b/include/linux/netfs.h
> @@ -57,6 +57,9 @@ typedef void (*netfs_io_terminated_t)(void *priv, ssize_t transferred_or_error);
>   */
>  struct netfs_inode {
>  	struct inode		inode;		/* The VFS inode */
> +#ifdef CONFIG_FS_ENCRYPTION
> +	struct fscrypt_inode_info *i_fscrypt_info;
> +#endif
>  	const struct netfs_request_ops *ops;
>  #if IS_ENABLED(CONFIG_FSCACHE)
>  	struct fscache_cookie	*cache;
> @@ -503,6 +506,9 @@ static inline void netfs_inode_init(struct netfs_inode *ctx,
>  		ctx->zero_point = ctx->remote_i_size;
>  		mapping_set_release_always(ctx->inode.i_mapping);
>  	}
> +#ifdef CONFIG_FS_ENCRYPTION
> +	ctx->i_fscrypt_info = NULL;
> +#endif

Why netfs_inode instead of ceph_inode_info?

- Eric

