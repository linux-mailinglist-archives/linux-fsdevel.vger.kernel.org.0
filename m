Return-Path: <linux-fsdevel+bounces-43397-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46AB7A55D45
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Mar 2025 02:44:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8832616AC41
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Mar 2025 01:44:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E653415B54C;
	Fri,  7 Mar 2025 01:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="MmhLpXCF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95539143748
	for <linux-fsdevel@vger.kernel.org>; Fri,  7 Mar 2025 01:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741311843; cv=none; b=oW6XDrLOovvuVP4/rOsyir+q+9SerUO17I8ygexFm85JqojONB78xrJ/ImeyYYLbAH5+8UUPWKfoREzOx/g+m0HiInDFUhVzLxokPU4KsfevAHY+AO8sYJpZj82Y9aABNCb7sjmvPsF5kLBfa+IPGog/zoGShNJwk0GvPjgHGLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741311843; c=relaxed/simple;
	bh=Mhok/zgjlVu0PlG+Gcd//AggRxc17WGf5ySm1zSUbOo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WF45PaAx9a2oiJkYhq0lcDdWQj8vhsQMN2QMC4vIbmzDfMF/A+Rv4t70GZCMcF77PkwNe5jYZXfZAbSdzSJUx0Djcbhj+ldN/JLPJ/yBolBGpNs6s6JkJTZCNmo9om0za4/zCk0jCyP99cc8p+FiJNqgGcCuUsZ5SblPq+wRTb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=MmhLpXCF; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 6 Mar 2025 20:43:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1741311829;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=H79nZv8dkq+G8rEaXQpyb/bsRjDzTOrL1NcJhXAv2sE=;
	b=MmhLpXCFV9MRNh2dnN8pS5L6GWV5OkzyhpvHEsAW3pEeRysN1tF1BlxudX3N7r/VRJL0xU
	T1yNCAZOeYzC238JBbTSlKzVR+5Mo2FvfMxjmLjVfSFSi4xP/U7K3jdj0jbdxPqaeJ93Oj
	9LeRvYFS3CMBMfkq37Lr7gXlqZOGcZ4=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Luis Chamberlain <mcgrof@kernel.org>
Cc: brauner@kernel.org, hare@suse.de, willy@infradead.org, 
	david@fromorbit.com, djwong@kernel.org, kbusch@kernel.org, john.g.garry@oracle.com, 
	hch@lst.de, ritesh.list@gmail.com, linux-fsdevel@vger.kernel.org, 
	linux-block@vger.kernel.org, gost.dev@samsung.com, p.raghav@samsung.com, da.gomez@samsung.com, 
	kernel@pankajraghav.com
Subject: Re: [PATCH] bdev: add back PAGE_SIZE block size validation for
 sb_set_blocksize()
Message-ID: <4lf6tj4dd4uziypukbfumw7ypd2t5gnxrnessylb7q4h6nwuiy@dpifjujhd5d7>
References: <20250305015301.1610092-1-mcgrof@kernel.org>
 <bgqqfjiumcr5csde4qzom2vs2ktnneok3gdffvu6tlyc3ih7x3@tioflbnatc5w>
 <Z8pBkuPn3kwf1Jvm@bombadil.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z8pBkuPn3kwf1Jvm@bombadil.infradead.org>
X-Migadu-Flow: FLOW_OUT

On Thu, Mar 06, 2025 at 04:45:06PM -0800, Luis Chamberlain wrote:
> On Thu, Mar 06, 2025 at 01:39:49PM -0500, Kent Overstreet wrote:
> > On Tue, Mar 04, 2025 at 05:53:01PM -0800, Luis Chamberlain wrote:
> > > The commit titled "block/bdev: lift block size restrictions to 64k"
> > > lifted the block layer's max supported block size to 64k inside the
> > > helper blk_validate_block_size() now that we support large folios.
> > > However in lifting the block size we also removed the silly use
> > > cases many filesystems have to use sb_set_blocksize() to *verify*
> > > that the block size < PAGE_SIZE. The call to sb_set_blocksize() can
> > > happen in-kernel given mkfs utilities *can* create for example an
> > > ext4 32k block size filesystem on x86_64, the issue we want to prevent
> > > is mounting it on x86_64 unless the filesystem supports LBS.
> > > 
> > > While, we could argue that such checks should be filesystem specific,
> > > there are much more users of sb_set_blocksize() than LBS enabled
> > > filesystem on linux-next, so just do the easier thing and bring back
> > > the PAGE_SIZE check for sb_set_blocksize() users.
> > > 
> > > This will ensure that tests such as generic/466 when run in a loop
> > > against say, ext4, won't try to try to actually mount a filesystem with
> > > a block size larger than your filesystem supports given your PAGE_SIZE
> > > and in the worst case crash.
> > > 
> > > Cc: Kent Overstreet <kent.overstreet@linux.dev>
> > > Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
> > 
> > bcachefs doesn't use sb_set_blocksize() - but it appears it should, and
> > it does also support bs > ps in -next.
> > 
> > Can we get a proper helper for lbs filesystems?
> 
> What do you think of this last recommention I had?

Perfect :)

> 
> diff --git a/block/bdev.c b/block/bdev.c
> index 3bd948e6438d..4844d1e27b6f 100644
> --- a/block/bdev.c
> +++ b/block/bdev.c
> @@ -181,6 +181,8 @@ EXPORT_SYMBOL(set_blocksize);
>  
>  int sb_set_blocksize(struct super_block *sb, int size)
>  {
> +	if (!(sb->s_type->fs_flags & FS_LBS) && size > PAGE_SIZE)
> +		return 0;
>  	if (set_blocksize(sb->s_bdev_file, size))
>  		return 0;
>  	/* If we get here, we know size is validated */
> diff --git a/fs/bcachefs/fs.c b/fs/bcachefs/fs.c
> index 90ade8f648d9..e99e378d68ea 100644
> --- a/fs/bcachefs/fs.c
> +++ b/fs/bcachefs/fs.c
> @@ -2396,7 +2396,7 @@ static struct file_system_type bcache_fs_type = {
>  	.name			= "bcachefs",
>  	.init_fs_context	= bch2_init_fs_context,
>  	.kill_sb		= bch2_kill_sb,
> -	.fs_flags		= FS_REQUIRES_DEV | FS_ALLOW_IDMAP,
> +	.fs_flags		= FS_REQUIRES_DEV | FS_ALLOW_IDMAP | FS_LBS,
>  };
>  
>  MODULE_ALIAS_FS("bcachefs");
> diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
> index d92d7a07ea89..3d8b80165d48 100644
> --- a/fs/xfs/xfs_super.c
> +++ b/fs/xfs/xfs_super.c
> @@ -2118,7 +2118,8 @@ static struct file_system_type xfs_fs_type = {
>  	.init_fs_context	= xfs_init_fs_context,
>  	.parameters		= xfs_fs_parameters,
>  	.kill_sb		= xfs_kill_sb,
> -	.fs_flags		= FS_REQUIRES_DEV | FS_ALLOW_IDMAP | FS_MGTIME,
> +	.fs_flags		= FS_REQUIRES_DEV | FS_ALLOW_IDMAP | FS_MGTIME |
> +				  FS_LBS,
>  };
>  MODULE_ALIAS_FS("xfs");
>  
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index 2c3b2f8a621f..16d17bd82be0 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -2616,6 +2616,7 @@ struct file_system_type {
>  #define FS_DISALLOW_NOTIFY_PERM	16	/* Disable fanotify permission events */
>  #define FS_ALLOW_IDMAP         32      /* FS has been updated to handle vfs idmappings. */
>  #define FS_MGTIME		64	/* FS uses multigrain timestamps */
> +#define FS_LBS			128	/* FS supports LBS */
>  #define FS_RENAME_DOES_D_MOVE	32768	/* FS will handle d_move() during rename() internally. */
>  	int (*init_fs_context)(struct fs_context *);
>  	const struct fs_parameter_spec *parameters;

