Return-Path: <linux-fsdevel+bounces-71330-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AC51CBDE7C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Dec 2025 13:56:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id CB67430120FB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Dec 2025 12:56:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 389B42857FA;
	Mon, 15 Dec 2025 12:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Izf1XZQq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29D901C3BF7;
	Mon, 15 Dec 2025 12:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765802286; cv=none; b=IY3FgHSDGyZksgp9l+F++W1OHbi9YyHrVfQ22Vk4YzcsN5spDxtlRq27n/jtJOfPfWufT0tTF4P+KIhpL3fQZFdYPGZp8+gyA5uLyrv3hhA46gMD4PNZk5fxqLhNIGiAxY9FwxWoxPxb6gcg5iDmSgeU2Fv1DCwjlJXctsKXyHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765802286; c=relaxed/simple;
	bh=Xiwt0F7uZg8asci0wopt7blyzkMs/Z1c1ZVQV24taE8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rdEfVlrs3T4jLhcAkrPTeaGLaGUvRp7OXYQSq5LvWIhUBF4uaI5r2C5TszHekdffnOk6pdXROsVCyFUTIzxCYftLTr04hOBRhuP191yPjZqwYTXMHb4GrAWdTADQJsTasjdbobNwGAKGmYMQHsCVpMth/foXeMZFqZbqdRK/VhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Izf1XZQq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99D73C4CEF5;
	Mon, 15 Dec 2025 12:38:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765802285;
	bh=Xiwt0F7uZg8asci0wopt7blyzkMs/Z1c1ZVQV24taE8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Izf1XZQqUXGQ9m1uFJavHM7TYM/1TxOw5krNCVjWI9t+iQJTi0S6oO1B/rTpu/+H+
	 jCj2NlwCflc8CyOzXYnniNnfSe0CiOhj/iKELmDDLcizX/T5+R9/Yov29Zwp0ogT8l
	 BFirJqRbzj/7cC0t6W0dKNoRyIiMqI+TJwP7ZXrwnFh8+zpAJxbl7NeQ88Nys3xIEX
	 5qfTv3MgxyGeidf6p/+1yrXiMXzWHf5LizG61DOH3LPAqiHcvo1eLfshpEQYghojue
	 DwQv69rkeXleu9DaWw1KUHx/U8wsjtcvGshR113fPEvrQ1BKHad+dpVcE/8jPqV4Y1
	 qG45VMXN6f3Ng==
Date: Mon, 15 Dec 2025 13:37:59 +0100
From: Christian Brauner <brauner@kernel.org>
To: Chuck Lever <cel@kernel.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org, 
	linux-ext4@vger.kernel.org, linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	hirofumi@mail.parknet.co.jp, almaz.alexandrovich@paragon-software.com, tytso@mit.edu, 
	adilger.kernel@dilger.ca, Volker.Lendecke@sernet.de, Chuck Lever <chuck.lever@oracle.com>
Subject: Re: [PATCH v2 1/6] fs: Add case sensitivity info to file_kattr
Message-ID: <20251215-genuss-neuer-1e3670000df7@brauner>
References: <20251211152116.480799-1-cel@kernel.org>
 <20251211152116.480799-2-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251211152116.480799-2-cel@kernel.org>

On Thu, Dec 11, 2025 at 10:21:11AM -0500, Chuck Lever wrote:
> From: Chuck Lever <chuck.lever@oracle.com>
> 
> Enable upper layers such as NFSD to retrieve case sensitivity
> information from file systems by adding a case_info field to struct
> file_kattr.
> 
> Add vfs_get_case_info() as a convenience helper for kernel
> consumers. If a filesystem does not provide a fileattr_get hook, it
> returns the default POSIX behavior (case-sensitive,
> case-preserving), which is correct for the majority of Linux
> file systems implementations.
> 
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---

Thanks for listening and plumbing this into file_attr() that seems a
much better place than statx().

>  fs/file_attr.c           | 31 +++++++++++++++++++++++++++++++
>  include/linux/fileattr.h | 23 +++++++++++++++++++++++
>  2 files changed, 54 insertions(+)
> 
> diff --git a/fs/file_attr.c b/fs/file_attr.c
> index 1dcec88c0680..609e890b5101 100644
> --- a/fs/file_attr.c
> +++ b/fs/file_attr.c
> @@ -94,6 +94,37 @@ int vfs_fileattr_get(struct dentry *dentry, struct file_kattr *fa)
>  }
>  EXPORT_SYMBOL(vfs_fileattr_get);
>  
> +/**
> + * vfs_get_case_info - retrieve case sensitivity info for a filesystem
> + * @dentry:	the object to retrieve from
> + * @case_info:	pointer to store result
> + *
> + * Call i_op->fileattr_get() to retrieve case sensitivity information.
> + * If the filesystem does not provide a fileattr_get hook, return
> + * the default POSIX behavior (case-sensitive, case-preserving).
> + *
> + * Return: 0 on success, or a negative error on failure.
> + */
> +int vfs_get_case_info(struct dentry *dentry, u32 *case_info)

Hm, I would much prefer if we followed the statx() model where we have
vfs_getattr{_nosec}() that always returns a struct kstat. So we should
only have vfs_fileattr_get() instead of the special-purpose
vfs_get_case_info() thing.

I guess the main reason you did this is so that you can set the default
without having to touch each filesystem that doesn't do file_attr.

So just move the default setup of case_info into vfs_fileattr_get()?
This way it's also available to other callers of this function such as
overlayfs and ecryptfs. And then just call that in nfsd.

Otherwise I have no complaints about the VFS part.

