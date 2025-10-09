Return-Path: <linux-fsdevel+bounces-63674-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9D2FBCA5C9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 09 Oct 2025 19:21:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34EAE422ACD
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Oct 2025 17:20:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFE28242D98;
	Thu,  9 Oct 2025 17:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="alKIHtB9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 086841397;
	Thu,  9 Oct 2025 17:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760030443; cv=none; b=hFbNdhh9o0QmoT039U1PT+ngwQtb37abhGQA7eXY6AgKCL4NlJmXwXiqt+fl9QsPx3/dOUjnhXEKjUrHEXleQaU2BWu+gzt10yUGtL3h8VV/5iE4Tuqp1nbwLsxU/LUmR1s9jloBYFCPJhiVvm3QiY3xMkOIj2iDAoPPC/eQ3NA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760030443; c=relaxed/simple;
	bh=LGpuHVtlJHOtOzyhHJiq0Xwe/InnzAHPK+F4MPKq0bY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I8Nr7fVaCkBb8eY/B0/KDqpDRlOSvQ+3bv9w1cl5HFfm/6OUsSyCRNXbW9PixbxBNAqfLyFXIP72vmS7dmQCr7f38BHMYQxk9FlWXBwIQHQROjfbf21GqDgC5eSlicM44fwq8upq37teH7OEOsnY2tr1wGWe6OHMkHOmYcP5xGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=alKIHtB9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7715AC4CEF8;
	Thu,  9 Oct 2025 17:20:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760030442;
	bh=LGpuHVtlJHOtOzyhHJiq0Xwe/InnzAHPK+F4MPKq0bY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=alKIHtB9futz0Wsw4qAadtGnBfvCh2AGA8AsUCWpiNxAjp9hjTdt0UX/JRBAol4OP
	 DXpx/JH5EnHcfP1qe13xuCgFY4aT5RpyOFpP07ZzMCkZlTviztpF+FAlf4LmZK0mWg
	 KGciAxsoLY4JLrweY2fbwIIJvW6Vbg53CnCknL/+WRmYmc153WXBkqULmGKuu0FWyE
	 Ffs90pF63b84qERcEYrD1A5Ggx/yN9W0uD2ovNZ6AIg7OR5cWxWJ5X/TwEwM3KhnJZ
	 48whl2PHToFhcf8nb4fuYnd/84h6v5PCRvXYT5lyQTFFuLJpiJV3QIdMwkt9e4yg4j
	 eLhiDRNclujVw==
Date: Thu, 9 Oct 2025 10:20:41 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Andrey Albershteyn <aalbersh@redhat.com>
Cc: linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
	Jan Kara <jack@suse.cz>, Jiri Slaby <jirislaby@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Andrey Albershteyn <aalbersh@kernel.org>
Subject: Re: [PATCH 2/2] fs: return EOPNOTSUPP from file_setattr/file_getattr
 syscalls
Message-ID: <20251009172041.GA6174@frogsfrogsfrogs>
References: <20251008-eopnosupp-fix-v1-0-5990de009c9f@kernel.org>
 <20251008-eopnosupp-fix-v1-2-5990de009c9f@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251008-eopnosupp-fix-v1-2-5990de009c9f@kernel.org>

On Wed, Oct 08, 2025 at 02:44:18PM +0200, Andrey Albershteyn wrote:
> These syscalls call to vfs_fileattr_get/set functions which return
> ENOIOCTLCMD if filesystem doesn't support setting file attribute on an
> inode. For syscalls EOPNOTSUPP would be more appropriate return error.
> 
> Signed-off-by: Andrey Albershteyn <aalbersh@kernel.org>
> ---
>  fs/file_attr.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/fs/file_attr.c b/fs/file_attr.c
> index 460b2dd21a85..5e3e2aba97b5 100644
> --- a/fs/file_attr.c
> +++ b/fs/file_attr.c
> @@ -416,6 +416,8 @@ SYSCALL_DEFINE5(file_getattr, int, dfd, const char __user *, filename,
>  	}
>  
>  	error = vfs_fileattr_get(filepath.dentry, &fa);
> +	if (error == -ENOIOCTLCMD)

Hrm.  Back in 6.17, XFS would return ENOTTY if you called ->fileattr_get
on a special file:

int
xfs_fileattr_get(
	struct dentry		*dentry,
	struct file_kattr	*fa)
{
	struct xfs_inode	*ip = XFS_I(d_inode(dentry));

	if (d_is_special(dentry))
		return -ENOTTY;
	...
}

Given that there are other fileattr_[gs]et implementations out there
that might return ENOTTY (e.g. fuse servers and other externally
maintained filesystems), I think both syscall functions need to check
for that as well:

	if (error == -ENOIOCTLCMD || error == -ENOTTY)
		return -EOPNOTSUPP;

--D

> +		error = -EOPNOTSUPP;
>  	if (error)
>  		return error;
>  
> @@ -483,6 +485,8 @@ SYSCALL_DEFINE5(file_setattr, int, dfd, const char __user *, filename,
>  	if (!error) {
>  		error = vfs_fileattr_set(mnt_idmap(filepath.mnt),
>  					 filepath.dentry, &fa);
> +		if (error == -ENOIOCTLCMD)
> +			error = -EOPNOTSUPP;
>  		mnt_drop_write(filepath.mnt);
>  	}
>  
> 
> -- 
> 2.51.0
> 
> 

