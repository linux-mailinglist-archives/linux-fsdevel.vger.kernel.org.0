Return-Path: <linux-fsdevel+bounces-42659-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E84BEA45889
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Feb 2025 09:39:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE1B3173ECF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Feb 2025 08:39:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9479217F31;
	Wed, 26 Feb 2025 08:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qJ1Uq39K"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 582F05028C
	for <linux-fsdevel@vger.kernel.org>; Wed, 26 Feb 2025 08:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740559133; cv=none; b=gB/jHT3/vUwssNImYWAhKsVn1LWrC3WoxVmXgiOwKfvlSLWFFaiZtAkX7grAnfxFVeMCwhXNvZMavwVU+KDlhzBSFPoPJr6TUgdDblBuOmqVaK3pa/bQXp9VVlqhs7v/CNZpYroWco0w7tvXnGjbcyAx6qGUvwDFd1JMtPkScsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740559133; c=relaxed/simple;
	bh=D8MPa96M4Ym++c4j3BMexZuechOgXCIWGJPBDpzlqPQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ncCvDnlunPrkVsggi1YNgSp1MPNy+lXuPEjq8X0t3kjUbjMJywqioI2XiYx+gp1f56Eq1ZVdiyzlCtGTghLziMd8ea7LW8Lm/5MPiM9hZsacyw4K0JJR8TABtK4rWf/Pvqi5gtohQ5F+C6J9R+UXasOz6O7iYWgkWkJqokpewIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qJ1Uq39K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 615B6C4CED6;
	Wed, 26 Feb 2025 08:38:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740559132;
	bh=D8MPa96M4Ym++c4j3BMexZuechOgXCIWGJPBDpzlqPQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qJ1Uq39KgYwIcLLC5OACpP4NRvA+zSgJ8zrAhcZmtQCl4hR1jqRK62GYIdhh/ddl/
	 usTrjV6IwBq0bg9cApZ9M2Gha43MR04ocO+/w6B82NyACyQ4eVC9H652hVTbiMEdM+
	 Tdk5NFb3R72J8sQwD7NvHww01aK+LC+mkx0wGIw+FD5cvUcSbuqtZ1EmnE/4xUrpaD
	 AdjXJ97+u+MpLarw9Mp4osHaoTsW91NlTe3OgTggii8nxWffxwm2Ytu25A8/J47KDf
	 T6vO5yvfSNafV8SQM9YwVmgjiobjlfAo4lpQvL7fGL0Mv2YARuPekjo3ObeWRzvv99
	 Rq0Q1FwZzTJyg==
Date: Wed, 26 Feb 2025 09:38:49 +0100
From: Christian Brauner <brauner@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, 
	Linus Torvalds <torvalds@linux-foundation.org>, Neil Brown <neilb@suse.de>, Miklos Szeredi <miklos@szeredi.hu>, 
	Jan Kara <jack@suse.cz>
Subject: Re: [PATCH 14/21] hostfs: don't bother with ->d_op
Message-ID: <20250226-umher-sangen-ea0cfddec253@brauner>
References: <20250224141444.GX1977892@ZenIV>
 <20250224212051.1756517-1-viro@zeniv.linux.org.uk>
 <20250224212051.1756517-14-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250224212051.1756517-14-viro@zeniv.linux.org.uk>

On Mon, Feb 24, 2025 at 09:20:44PM +0000, Al Viro wrote:
> All we have there is ->d_delete equal to always_delete_dentry() and we
> want that for all dentries on that things.  Setting DCACHE_DONTCACHE in
> ->s_d_flags will do just that.
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---

Reviewed-by: Christian Brauner <brauner@kernel.org>

>  fs/hostfs/hostfs_kern.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/hostfs/hostfs_kern.c b/fs/hostfs/hostfs_kern.c
> index a0e0563a29d7..52479205cefe 100644
> --- a/fs/hostfs/hostfs_kern.c
> +++ b/fs/hostfs/hostfs_kern.c
> @@ -920,7 +920,7 @@ static int hostfs_fill_super(struct super_block *sb, struct fs_context *fc)
>  	sb->s_blocksize_bits = 10;
>  	sb->s_magic = HOSTFS_SUPER_MAGIC;
>  	sb->s_op = &hostfs_sbops;
> -	set_default_d_op(sb, &simple_dentry_operations);
> +	sb->s_d_flags = DCACHE_DONTCACHE;
>  	sb->s_maxbytes = MAX_LFS_FILESIZE;
>  	err = super_setup_bdi(sb);
>  	if (err)
> -- 
> 2.39.5
> 

