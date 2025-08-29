Return-Path: <linux-fsdevel+bounces-59634-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 28CDBB3B7C5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Aug 2025 11:53:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7F90A00774
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Aug 2025 09:53:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F3EB30505D;
	Fri, 29 Aug 2025 09:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YWjq6K2x"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5973285CA3
	for <linux-fsdevel@vger.kernel.org>; Fri, 29 Aug 2025 09:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756461188; cv=none; b=bRN23oo7afhLT/2KKHXS28/7dxVZrlA/Y0U4ZaFFP6gTrcfgMHljK0x558U9sZ09T/zxYQPzNUQriaE9lVRxkNhkhmm3IL/zUlp7kMD8NPUndxbHMmLqT88euhmhXAjKUEypZpW7QbuUtvYCngpkDeXfJwurjcgG9pb9tR8oiBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756461188; c=relaxed/simple;
	bh=N8z3VO9CV0CbW86OlNEzxXG8d4cXz0YouMpl8YLKS6I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=So4oeyKGmw7pVeIz7+lDjQ5tL68ou5okl9DqDr3tMnXSyoU+/uJxfksySxyBAuQwy7x3Uvm79z9l6INwpscRMxAeaH5/tycfX0u3nSGNWBN78vVcuhAnYthEkdxxQHd4nnRm4YcsakdNxJGkDzsXpkCot/ouUwxIoaC+Zt2AVtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YWjq6K2x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1863AC4CEF0;
	Fri, 29 Aug 2025 09:53:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756461188;
	bh=N8z3VO9CV0CbW86OlNEzxXG8d4cXz0YouMpl8YLKS6I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YWjq6K2xADDK/4KXksbbVvUVE1TLJwXvl1IdFc0/dkscJVv9pCTURe3AGCz72OKbg
	 nJQj0YaZ5esp42wWNW4YF9VbeqSuyRLwsP7xce1yfNO7pxOYKKBxNEZHX41fF35uSd
	 pOoHBZorAguviG4itT1LErEK6RH0q6Okk2uCbz0P1v5adkaiif9IyXXiOWE4ZUCixD
	 OvGX4/dYe9/h3Qq+gwSO1cUmh80Zha+Hj5Qk3LMARb9bDzWYkaEht2/hjeEjGEFHAT
	 Z1JFZEEEsW9V8X2uPRtWHegli5Zg9ViXKsU078sy12w2Hb39VHIJXsGvWWm7XN3V8T
	 Xb8r5utkcZnYA==
Date: Fri, 29 Aug 2025 11:53:04 +0200
From: Christian Brauner <brauner@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, jack@suse.cz, 
	torvalds@linux-foundation.org
Subject: Re: [PATCH v2 18/63] switch do_new_mount_fc() to fc_mount()
Message-ID: <20250829-einmal-wirbt-eb7bd9239c77@brauner>
References: <20250828230706.GA3340273@ZenIV>
 <20250828230806.3582485-1-viro@zeniv.linux.org.uk>
 <20250828230806.3582485-18-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250828230806.3582485-18-viro@zeniv.linux.org.uk>

On Fri, Aug 29, 2025 at 12:07:21AM +0100, Al Viro wrote:
> Prior to the call of do_new_mount_fc() the caller has just done successful
> vfs_get_tree().  Then do_new_mount_fc() does several checks on resulting
> superblock, and either does fc_drop_locked() and returns an error or
> proceeds to unlock the superblock and call vfs_create_mount().
> 
> The thing is, there's no reason to delay that unlock + vfs_create_mount() -
> the tests do not rely upon the state of ->s_umount and
> 	fc_drop_locked()
> 	put_fs_context()
> is equivalent to
> 	unlock ->s_umount
> 	put_fs_context()
> 
> Doing vfs_create_mount() before the checks allows us to move vfs_get_tree()
> from caller to do_new_mount_fc() and collapse it with vfs_create_mount()
> into an fc_mount() call.
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---

Reviewed-by: Christian Brauner <brauner@kernel.org>

>  fs/namespace.c | 29 ++++++++++++-----------------
>  1 file changed, 12 insertions(+), 17 deletions(-)
> 
> diff --git a/fs/namespace.c b/fs/namespace.c
> index 0474b3a93dbf..9b575c9eee0b 100644
> --- a/fs/namespace.c
> +++ b/fs/namespace.c
> @@ -3705,25 +3705,20 @@ static bool mount_too_revealing(const struct super_block *sb, int *new_mnt_flags
>  static int do_new_mount_fc(struct fs_context *fc, struct path *mountpoint,
>  			   unsigned int mnt_flags)
>  {
> -	struct vfsmount *mnt;
>  	struct pinned_mountpoint mp = {};
> -	struct super_block *sb = fc->root->d_sb;
> +	struct super_block *sb;
> +	struct vfsmount *mnt = fc_mount(fc);
>  	int error;
>  
> +	if (IS_ERR(mnt))
> +		return PTR_ERR(mnt);

Fwiw, I find this pattern where the variable is assigned by function
call at declaration time in the middle of other variables and then
immediately further below check for the error to be rather ugly. I'd
much rather just do:

  +	struct vfsmount *mnt;
   	int error;
   
	mnt = fc_mount(fc)
  +	if (IS_ERR(mnt))
  +		return PTR_ERR(mnt);

But anyway, I acknowledge the difference in taste here is really not
that important.

