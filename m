Return-Path: <linux-fsdevel+bounces-62996-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 626DDBA87C3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Sep 2025 10:58:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 18EC3166B10
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Sep 2025 08:58:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A37D2C11E8;
	Mon, 29 Sep 2025 08:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X1YchQLO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0CAA2C11CC;
	Mon, 29 Sep 2025 08:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759136298; cv=none; b=KWISyi8ZvtdqL+k2zGVoolFBkYYO0DrAUepMM0Mt97tST0ia6ZamCZFKrF3O37NUsefqzqXF0Cn5SGKKtxn0glW+n/n3bjuqBlwlnELC3D9hdyu182wWFD6NTtb/3yFIs6xvYBW+2kGWoJPv9gAWE+l3irmQ2totYA8QqAtxikE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759136298; c=relaxed/simple;
	bh=KKtfQv+cuHP6H8rI4a/ROM2JYxSKY9RA5KwmcdtydAk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eA/UKXRPUX7+R10wlbY5JSZzcuD+TwI2FByMPYE6roKh96dRcGv2huQJqKTp6LPFGD0JRaQTG57WvVw70Losho+Auwpda7rm9660w8HTUq1OpPStdz+Ilfu5lO2TI4Rz1gvW6ruPR2Nus+Jx6mRMHbwga44BMZw8EKMcBxfyJGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X1YchQLO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C14F1C4CEF4;
	Mon, 29 Sep 2025 08:58:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759136298;
	bh=KKtfQv+cuHP6H8rI4a/ROM2JYxSKY9RA5KwmcdtydAk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=X1YchQLOihanVT4uCbywldNbgBl5cAaM3lDCmrO35arVZpf47BdXJEOxVEG1BL/Ej
	 DiGC5mZ+U/F5TCntuY43/TsfcBukwTS3hUQ6lD5aRi3sGCtkxKjwqK6ZlymNbYygT9
	 Ir8zPepgxe/weiNBMVWTJZJmx1rQP1MlgjJWT6Q2rdKFuCalwVyIOH2ZNwGxelaIyx
	 pEts9CvHgBr2+E3u10dWffu/zRhuv2StooEOAjZDR3C/nqhQ606BGvHWzAK2hISvRM
	 2FZF/C8ADCfbNObIHnLuYJYpqh4ZaqBprYrMvGl+gBJmj4Y/t6kRIeDeECNGHrHrX7
	 m1Kcs64qxGNzw==
Date: Mon, 29 Sep 2025 10:58:14 +0200
From: Christian Brauner <brauner@kernel.org>
To: Deepanshu Kartikey <kartikey406@gmail.com>
Cc: viro@zeniv.linux.org.uk, jack@suse.cz, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzbot+9eefe09bedd093f156c2@syzkaller.appspotmail.com
Subject: Re: [PATCH v2] nsfs: handle inode number mismatches gracefully in
 file handles
Message-ID: <20250929-musizieren-toxikologie-7b7674306977@brauner>
References: <20250924115058.1262851-1-kartikey406@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250924115058.1262851-1-kartikey406@gmail.com>

On Wed, Sep 24, 2025 at 05:20:58PM +0530, Deepanshu Kartikey wrote:
> Replace VFS_WARN_ON_ONCE() with graceful error handling when file
> handles contain inode numbers that don't match the actual namespace
> inode. This prevents userspace from triggering kernel warnings by
> providing malformed file handles to open_by_handle_at().
> 
> The issue occurs when userspace provides a file handle with valid
> namespace type and ID that successfully locates a namespace, but
> specifies an incorrect inode number. Previously, this would trigger
> VFS_WARN_ON_ONCE() when comparing the real inode number against the
> provided value.
> 
> Since file handle data is user-controllable, inode number mismatches
> should be treated as invalid input rather than kernel consistency
> errors. Handle this case by returning NULL to indicate the file
> handle is invalid, rather than warning about what is essentially
> user input validation.
> 
> Reported-by: syzbot+9eefe09bedd093f156c2@syzkaller.appspotmail.com
> Suggested-by: Jan Kara <jack@suse.cz>
> Reviewed-by: Jan Kara <jack@suse.cz>
> Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>
> ---
>  fs/nsfs.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> Changes in v2:
> - Handle all inode number mismatches, not just zero, as suggested by Jan Kara
> - Replace warning with graceful error handling for better architecture
> 
> diff --git a/fs/nsfs.c b/fs/nsfs.c
> index 32cb8c835a2b..002d424d9fa6 100644
> --- a/fs/nsfs.c
> +++ b/fs/nsfs.c
> @@ -490,8 +490,9 @@ static struct dentry *nsfs_fh_to_dentry(struct super_block *sb, struct fid *fh,
>  
>  		VFS_WARN_ON_ONCE(ns->ns_id != fid->ns_id);
>  		VFS_WARN_ON_ONCE(ns->ops->type != fid->ns_type);
> -		VFS_WARN_ON_ONCE(ns->inum != fid->ns_inum);
> -
> +		/* Someone is playing games and passing invalid file handles? */
> +		if (ns->inum != fid->ns_inum)
> +			return NULL;
>  		if (!refcount_inc_not_zero(&ns->count))
>  			return NULL;
>  	}
> -- 
> 2.43.0
> 

That seems sane although I have considered to relax the decoding part in
the future. IOW, the kernel must always return the file handle with all
fields filled in. But userspace may be allowed to specify just the
->ns_id and leave both ->inum and ->ns_type zero. This is based on a
patch for next cycled "unified nstree". Anyway, thanks for the fix.

