Return-Path: <linux-fsdevel+bounces-60970-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 254F6B53CF0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Sep 2025 22:09:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 701871CC6A7B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Sep 2025 20:09:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01083267B89;
	Thu, 11 Sep 2025 20:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="f/V518Vo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6025A2571D7
	for <linux-fsdevel@vger.kernel.org>; Thu, 11 Sep 2025 20:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757621168; cv=none; b=ktgHqdxsZG7Ymx6eSFloGYrLYsZeKdCH6cZmvM0a/PnSE4ept4s3jyeeMlvNooLhEIrOQh4e+LLGYxdmVLc/NMk/g36sES1OF4TyjTwCuLBqsMy5HvgWrCSgD3rxDGI6g2s3Eby/HtI0w4Z7n+aCJm4ZAsfofcTuoVMj/mxGwZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757621168; c=relaxed/simple;
	bh=w/6JIQWCyM9gOXVqM8B7e8dxLVkea++Qcaj0TbcEfCc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I9lVsaVg+HvlPIIMh7+24EKGgMDCef5YYEbhsLYWhg31yFX3Mlta5B5t7M9Dx1ODSQN8hzIiIF1ra//ErdPoIn2sZZn+hHIOWgfHTadSO7jUGz9TfeCvH4XC34i3TloPO+lf4HMNgnelcFHQmJTBTshzOCAKaZFYit+xMl4mB0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=f/V518Vo; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=vWXL5HzngriRPjT0mo9z6S0meIUUjeB94ITVImznMyM=; b=f/V518Vowpp7sctuIv0rPTjy+C
	higbJBYHBLGGV5ZC6gHWYGkKZYSqE1wk58RY5UySXzxLqUnFzEqmVIjS92j/WB652KTqGHFQopzi0
	OjYNy+gvTehCIfkvPk2tlgrOxxx4UDBIZhri7aPrhRjB5GV5HSltKQa2XzYRTd9DFFYis07EqFkFs
	lL566w4LOmHFqFYwZysjqDxvM6dNf/ZAgQQF+HvBfQZRMMORBWw4qU+MgEApzgpKMtOqYvKfEbTui
	pWbVS8B/jWzbtMWGyz/zV1+y7+ZtAWngkqlBg43Ik/47+ob3pKEvQ/fowINH575auI1+exM14H++F
	jWL5lNnQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uwnYN-00000004zmZ-2ilT;
	Thu, 11 Sep 2025 20:05:59 +0000
Date: Thu, 11 Sep 2025 21:05:59 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: neil@brown.name
Cc: Christian Brauner <brauner@kernel.org>,
	Amir Goldstein <amir73il@gmail.com>,
	Jeff Layton <jlayton@kernel.org>, Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 1/7] VFS/ovl: add lookup_one_positive_killable()
Message-ID: <20250911200559.GW39973@ZenIV>
References: <20250909044637.705116-1-neilb@ownmail.net>
 <20250909044637.705116-2-neilb@ownmail.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250909044637.705116-2-neilb@ownmail.net>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Tue, Sep 09, 2025 at 02:43:15PM +1000, NeilBrown wrote:

> Note that instead of always getting an exclusive lock, ovl now only gets
> a shared lock, and only sometimes.  The exclusive lock was never needed.

what it is the locking environment in callers and what stabilizes
that list hanging off rdd, seeing that you now run through it without
having dir held exclusive?

> -	int err;
> +	int err = 0;
>  	struct dentry *dentry, *dir = path->dentry;
>  	const struct cred *old_cred;
>  
>  	old_cred = ovl_override_creds(rdd->dentry->d_sb);
>  
> -	err = down_write_killable(&dir->d_inode->i_rwsem);
> -	if (!err) {
> -		while (rdd->first_maybe_whiteout) {
> -			struct ovl_cache_entry *p =
> -				rdd->first_maybe_whiteout;
> -			rdd->first_maybe_whiteout = p->next_maybe_whiteout;
> -			dentry = lookup_one(mnt_idmap(path->mnt),
> -					    &QSTR_LEN(p->name, p->len), dir);
> -			if (!IS_ERR(dentry)) {
> -				p->is_whiteout = ovl_is_whiteout(dentry);
> -				dput(dentry);
> -			}
> +	while (rdd->first_maybe_whiteout) {
> +		struct ovl_cache_entry *p =
> +			rdd->first_maybe_whiteout;
> +		rdd->first_maybe_whiteout = p->next_maybe_whiteout;
> +		dentry = lookup_one_positive_killable(mnt_idmap(path->mnt),
> +						      &QSTR_LEN(p->name, p->len),
> +						      dir);
> +		if (!IS_ERR(dentry)) {
> +			p->is_whiteout = ovl_is_whiteout(dentry);
> +			dput(dentry);
> +		} else if (PTR_ERR(dentry) == -EINTR) {
> +			err = -EINTR;
> +			break;
>  		}
> -		inode_unlock(dir->d_inode);
>  	}
>  	ovl_revert_creds(old_cred);
>  
> diff --git a/include/linux/namei.h b/include/linux/namei.h
> index 5d085428e471..551a1a01e5e7 100644
> --- a/include/linux/namei.h
> +++ b/include/linux/namei.h
> @@ -80,6 +80,9 @@ struct dentry *lookup_one_unlocked(struct mnt_idmap *idmap,
>  struct dentry *lookup_one_positive_unlocked(struct mnt_idmap *idmap,
>  					    struct qstr *name,
>  					    struct dentry *base);
> +struct dentry *lookup_one_positive_killable(struct mnt_idmap *idmap,
> +					    struct qstr *name,
> +					    struct dentry *base);
>  
>  extern int follow_down_one(struct path *);
>  extern int follow_down(struct path *path, unsigned int flags);
> -- 
> 2.50.0.107.gf914562f5916.dirty
> 

