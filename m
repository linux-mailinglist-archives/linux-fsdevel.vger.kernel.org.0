Return-Path: <linux-fsdevel+bounces-46360-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C03E5A87E55
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Apr 2025 13:02:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 089363B494E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Apr 2025 11:01:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D025280A40;
	Mon, 14 Apr 2025 11:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RcRkUW8z"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7F6A27F4E1;
	Mon, 14 Apr 2025 11:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744628517; cv=none; b=XHquZGtH4tWwg0Q0TnMUtU0bxn4F+/HYri36Tb7ahaNB4tnq5hweWQM5WyGg0pRlHW37h/iICUDrrTUkVvqtlT4eJJvVlxqF1NPwHWVVJX86FTY/9T22QI8FrApHuJmgEv0GGD8gviHTUEE+fPZfjWCU2TEyhHs0lMzk6KWuAsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744628517; c=relaxed/simple;
	bh=PD40PSaJAYqjNUiP+RE2xMWbWxPku5ePjySEbG2IERE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DDfTrZ9tYHdR8/PaoSsIl4BH2UJDu9MT2OSZFjNRlCL3ZRMrsPftYT65JcMkClq14nS+JMCthZYuXgPrt6w4oN4D1KScKaQOGWel+DdTZLrtIsIW9EmEH5SbKk9ReW40Fl47FwyfUX6GmlZ7d2FzYkNdrB6eFgvEaQd59xIXcXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RcRkUW8z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6E16C4CEEB;
	Mon, 14 Apr 2025 11:01:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744628517;
	bh=PD40PSaJAYqjNUiP+RE2xMWbWxPku5ePjySEbG2IERE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RcRkUW8z0baeASnP/wcCQVxdoeIxF6BWvyQ4eY19sh6TfdVY+5ePgk5LA78DfXB2B
	 JNbJnMY2vhi9WkcKWLsvbNgEN6XlLw3FEJlePt+3R/eQsyr6FuZgttWgan919BNvsx
	 57kqVLH5NLcDm5g8I0P3WCv6yNo8wwq0gJ7Z1iFbugAr9DmBiK0quniQBgyxIyTh0C
	 EVejiUfNKMUVYOwdcVdWKggo8Z9XoebrGCt587v9q+hz6goqX+BXMBfHJ6ODRnTYV2
	 eX1H4JgAu7jyD36IzUjLy/8jbn3JcegZru1elHwxb17Tyc+mxosw0lEn2bXJXz3mna
	 oBGhPRtFNVHJA==
Date: Mon, 14 Apr 2025 13:01:53 +0200
From: Christian Brauner <brauner@kernel.org>
To: NeilBrown <neilb@suse.de>
Cc: Vlastimil Babka <vbabka@suse.cz>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
	linux-nfs@vger.kernel.org
Subject: Re: [PATCH 1/2] VFS: change kern_path_locked() and
 user_path_locked_at() to never return negative dentry
Message-ID: <20250414-wendung-halbe-e81e952285cc@brauner>
References: <20250217003020.3170652-1-neilb@suse.de>
 <20250217003020.3170652-2-neilb@suse.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250217003020.3170652-2-neilb@suse.de>

> diff --git a/kernel/audit_watch.c b/kernel/audit_watch.c
> index 7f358740e958..367eaf2c78b7 100644
> --- a/kernel/audit_watch.c
> +++ b/kernel/audit_watch.c
> @@ -350,11 +350,10 @@ static int audit_get_nd(struct audit_watch *watch, struct path *parent)
>  	struct dentry *d = kern_path_locked(watch->path, parent);
>  	if (IS_ERR(d))
>  		return PTR_ERR(d);
> -	if (d_is_positive(d)) {
> -		/* update watch filter fields */
> -		watch->dev = d->d_sb->s_dev;
> -		watch->ino = d_backing_inode(d)->i_ino;
> -	}
> +	/* update watch filter fields */
> +	watch->dev = d->d_sb->s_dev;
> +	watch->ino = d_backing_inode(d)->i_ino;
> +
>  	inode_unlock(d_backing_inode(parent->dentry));
>  	dput(d);
>  	return 0;
> @@ -419,10 +418,11 @@ int audit_add_watch(struct audit_krule *krule, struct list_head **list)
>  	/* caller expects mutex locked */
>  	mutex_lock(&audit_filter_mutex);
>  
> -	if (ret) {
> +	if (ret && ret != -ENOENT) {
>  		audit_put_watch(watch);
>  		return ret;
>  	}
> +	ret = 0;

So this is broken.

If kern_path_locked() fails due to a negative dentry and returns ENOENT
it will have already called path_put() and @parent_path is invalid.

But right after this audit does:

>  
>  	/* either find an old parent or attach a new one */
>  	parent = audit_find_parent(d_backing_inode(parent_path.dentry));

and then later on calls path_put() again. So this is a UAF. We need to
fix this.

This used to work before because kern_path_locked() return a path with a
negative dentry.

