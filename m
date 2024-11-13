Return-Path: <linux-fsdevel+bounces-34625-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E3239C6CE2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Nov 2024 11:31:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 785BFB243A7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Nov 2024 10:22:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4852B1FBCA6;
	Wed, 13 Nov 2024 10:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ih3MwP4I"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FCC51FBC95;
	Wed, 13 Nov 2024 10:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731493334; cv=none; b=g9R6WNv2+FoQqA7t6hJkNSYiVi+ZiCslLdmF8cGvqtijrcFMbmrG2FlemroKq3wMn8mrzu2yU7IemrfkDdEZImB6vb0qk3wJ8veQi5A3RjwyfGWzdcWyj2boCslRAdwMDPXL4HqQPA+ug1SUcrb/e5BT5TO7VKdNijvv1g8LuQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731493334; c=relaxed/simple;
	bh=bT3AvCqjBcCd0NVLxpcDY8LCVWeB8yiyYDP1SIlQBtI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B972kW9jU7YsYByvBz7rWMSZE6VZsU+FPy0nNArDh+dDI7khWixLOBgISvHWNJ6MM0vU4Yw++ckyDPpGNv+8/586mJIijYxmUC1nQQguFD4bbGDyJMmswZbKfv20MR5QcAD5NVLRoWfc79MECet0N9WU/b+A6bRpiNWvT7l18Ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ih3MwP4I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA551C4CECD;
	Wed, 13 Nov 2024 10:22:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731493334;
	bh=bT3AvCqjBcCd0NVLxpcDY8LCVWeB8yiyYDP1SIlQBtI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ih3MwP4I2gfc2bBZbggLAF5x6bidt/U41gzwloc2iwo7+gDsp5JhG4dzksT0CE0tj
	 YfzNuQfnT3jvtR/YcHmk3HPbqWnzH+oXlqgdSDG1EdRkBt3UJ0wI6hnP7Z32DV0hyC
	 IXt0Ea5gqCTcgDoJ489BbtOn9sH/3TfUWsbzCKPjwB4HIDJZNU5cVva2mq68Sl18z5
	 qnfA70lWtfXM6epzuK3esSaQjJ72cC0dJvPRV7Z5p+JrToImWIY31anEkYbLBE+r66
	 o0f06adqj1jaWPND9RaQvFiY+3DZfY4s/qzKvt99D7qtMb/ngaer6k5RU3105H/l+6
	 jHOZU2/9/Knmg==
Date: Wed, 13 Nov 2024 11:22:09 +0100
From: Christian Brauner <brauner@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, Jan Kara <jack@suse.cz>, 
	Jens Axboe <axboe@kernel.dk>, Stefan Berger <stefanb@linux.ibm.com>, 
	Tyler Hicks <code@tyhicks.com>, ecryptfs@vger.kernel.org, Miklos Szeredi <miklos@szeredi.hu>, 
	Amir Goldstein <amir73il@gmail.com>, linux-unionfs@vger.kernel.org
Subject: Re: [PATCH 4/5] fs: Simplify getattr interface function checking
 AT_GETATTR_NOSEC flag
Message-ID: <20241113-utensil-unteilbar-cfed225308c6@brauner>
References: <20241112202118.GA3387508@ZenIV>
 <20241112202552.3393751-1-viro@zeniv.linux.org.uk>
 <20241112202552.3393751-4-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241112202552.3393751-4-viro@zeniv.linux.org.uk>

On Tue, Nov 12, 2024 at 08:25:51PM +0000, Al Viro wrote:
> From: Stefan Berger <stefanb@linux.ibm.com>
> 
> Commit 8a924db2d7b5 ("fs: Pass AT_GETATTR_NOSEC flag to getattr interface
> function")' introduced the AT_GETATTR_NOSEC flag to ensure that the
> call paths only call vfs_getattr_nosec if it is set instead of vfs_getattr.
> Now, simplify the getattr interface functions of filesystems where the flag
> AT_GETATTR_NOSEC is checked.
> 
> There is only a single caller of inode_operations getattr function and it
> is located in fs/stat.c in vfs_getattr_nosec. The caller there is the only
> one from which the AT_GETATTR_NOSEC flag is passed from.
> 
> Two filesystems are checking this flag in .getattr and the flag is always
> passed to them unconditionally from only vfs_getattr_nosec:
> 
> - ecryptfs:  Simplify by always calling vfs_getattr_nosec in
>              ecryptfs_getattr. From there the flag is passed to no other
>              function and this function is not called otherwise.
> 
> - overlayfs: Simplify by always calling vfs_getattr_nosec in
>              ovl_getattr. From there the flag is passed to no other
>              function and this function is not called otherwise.
> 
> The query_flags in vfs_getattr_nosec will mask-out AT_GETATTR_NOSEC from
> any caller using AT_STATX_SYNC_TYPE as mask so that the flag is not
> important inside this function. Also, since no filesystem is checking the
> flag anymore, remove the flag entirely now, including the BUG_ON check that
> never triggered.
> 
> The net change of the changes here combined with the original commit is
> that ecryptfs and overlayfs do not call vfs_getattr but only
> vfs_getattr_nosec.
> 
> Fixes: 8a924db2d7b5 ("fs: Pass AT_GETATTR_NOSEC flag to getattr interface function")
> Reported-by: Al Viro <viro@zeniv.linux.org.uk>
> Closes: https://lore.kernel.org/linux-fsdevel/20241101011724.GN1350452@ZenIV/T/#u
> Cc: Tyler Hicks <code@tyhicks.com>
> Cc: ecryptfs@vger.kernel.org
> Cc: Miklos Szeredi <miklos@szeredi.hu>
> Cc: Amir Goldstein <amir73il@gmail.com>
> Cc: linux-unionfs@vger.kernel.org
> Cc: Christian Brauner <brauner@kernel.org>
> Cc: linux-fsdevel@vger.kernel.org
> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---

Reviewed-by: Christian Brauner <brauner@kernel.org>

