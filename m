Return-Path: <linux-fsdevel+bounces-37050-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3629A9ECAEF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Dec 2024 12:17:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 32EF0169CBF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Dec 2024 11:17:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24D032210E6;
	Wed, 11 Dec 2024 11:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DrgH+9bR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74B0F211A3F;
	Wed, 11 Dec 2024 11:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733915823; cv=none; b=Is+PFfGymX3WjK7PH8fTpf1KtkacqV0LJ2BWUVnlGnXyw37TzcEFjFGwEHHVeYjM+YGB9g+8FP5uQm39M7jmse+50TfI22kiYhozDAzmx2pizl5LpnXvgjlpS4mRstvFmahbTfxsYg97tN1bD0NBPHzUpGHB/mJbRQhmjd46Rlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733915823; c=relaxed/simple;
	bh=RWQvKxK778lZKMCtWE1Y0Fcnd9xRZ4AvvPHkrWLTkIk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kHV+/nprBLC7QvNrEXJjDn0EJa0utTNuOTWL1mIYgFuyfgs6Qbs7+0v8YwlCUBgJVixLGZCSFdxjA31Ed+Y8WwNL2NtMcKttqqKYZamIKwvUhceRBYCMyBIIrwU5L/ITo0uBGpqCThwoJ0fS6nIZ0eHTkjO2GLjwccTwtcmbL98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DrgH+9bR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACE83C4CEDD;
	Wed, 11 Dec 2024 11:17:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733915823;
	bh=RWQvKxK778lZKMCtWE1Y0Fcnd9xRZ4AvvPHkrWLTkIk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DrgH+9bR/buDmC50NE8whjR3HRu1h13ieIyEUOh3Fme/phqmeL8E70yqwY/tpX0RM
	 pApgKHIj4GtJBWXgE1NKhkXnTGj9wrUQ0QfR9n0i9nZBJu2XmOJxA7spxhbm7bSZt1
	 mUTgSjDY2XyoBnP60zp8G2+phw021l6d3GKpXnGaHi9z9xd3J+iGsBQiq/QtvWQvoW
	 0JNtLbJnRZQ3iMmM8kP+WXPU/fglS2LCua0beYwkc65vGlM3zV0zSUZp+4QqKinP7J
	 d6IDPg+Ga5rUE+fk7wM2o2ntzKWC0pmjP+NQwJIUgPAowyrgLZMCcyTsMMw+wTIECn
	 F+hUnnJIX1FKg==
Date: Wed, 11 Dec 2024 12:16:59 +0100
From: Christian Brauner <brauner@kernel.org>
To: James Bottomley <James.Bottomley@hansenpartnership.com>
Cc: linux-fsdevel@vger.kernel.org, linux-efi@vger.kernel.org, 
	Ard Biesheuvel <ardb@kernel.org>, Jeremy Kerr <jk@ozlabs.org>
Subject: Re: [PATCH 6/6] efivarfs: fix error on write to new variable leaving
 remnants
Message-ID: <20241211-krabben-tresor-9f9c504e5bd7@brauner>
References: <20241210170224.19159-1-James.Bottomley@HansenPartnership.com>
 <20241210170224.19159-7-James.Bottomley@HansenPartnership.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241210170224.19159-7-James.Bottomley@HansenPartnership.com>

On Tue, Dec 10, 2024 at 12:02:24PM -0500, James Bottomley wrote:
> Make variable cleanup go through the fops release mechanism and use
> zero inode size as the indicator to delete the file.  Since all EFI
> variables must have an initial u32 attribute, zero size occurs either
> because the update deleted the variable or because an unsuccessful
> write after create caused the size never to be set in the first place.
> 
> Even though this fixes the bug that a create either not followed by a
> write or followed by a write that errored would leave a remnant file
> for the variable, the file will appear momentarily globally visible
> until the close of the fd deletes it.  This is safe because the normal
> filesystem operations will mediate any races; however, it is still
> possible for a directory listing at that instant between create and
> close contain a variable that doesn't exist in the EFI table.
> 
> Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>
> ---
>  fs/efivarfs/file.c | 31 ++++++++++++++++++++++---------
>  1 file changed, 22 insertions(+), 9 deletions(-)
> 
> diff --git a/fs/efivarfs/file.c b/fs/efivarfs/file.c
> index 23c51d62f902..edf363f395f5 100644
> --- a/fs/efivarfs/file.c
> +++ b/fs/efivarfs/file.c
> @@ -38,22 +38,24 @@ static ssize_t efivarfs_file_write(struct file *file,
>  
>  	bytes = efivar_entry_set_get_size(var, attributes, &datasize,
>  					  data, &set);
> -	if (!set && bytes) {
> +	if (!set) {
>  		if (bytes == -ENOENT)
>  			bytes = -EIO;
>  		goto out;
>  	}
>  
> +	inode_lock(inode);
>  	if (bytes == -ENOENT) {
> -		drop_nlink(inode);
> -		d_delete(file->f_path.dentry);
> -		dput(file->f_path.dentry);
> +		/*
> +		 * zero size signals to release that the write deleted
> +		 * the variable
> +		 */
> +		i_size_write(inode, 0);
>  	} else {
> -		inode_lock(inode);
>  		i_size_write(inode, datasize + sizeof(attributes));
>  		inode_set_mtime_to_ts(inode, inode_set_ctime_current(inode));
> -		inode_unlock(inode);
>  	}
> +	inode_unlock(inode);
>  
>  	bytes = count;
>  
> @@ -106,8 +108,19 @@ static ssize_t efivarfs_file_read(struct file *file, char __user *userbuf,
>  	return size;
>  }
>  
> +static int efivarfs_file_release(struct inode *inode, struct file *file)
> +{
> +	if (i_size_read(inode) == 0) {
> +		drop_nlink(inode);
> +		d_delete(file->f_path.dentry);
> +		dput(file->f_path.dentry);
> +	}

Without wider context the dput() looks UAF-y as __fput() will do:

struct dentry *dentry = file->f_path.dentry;
if (file->f_op->release)
        file->f_op->release(inode, file);
dput(dentry);

Is there an extra reference on file->f_path.dentry taken somewhere?

