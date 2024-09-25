Return-Path: <linux-fsdevel+bounces-30127-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 119DF98691D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Sep 2024 00:20:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9853281707
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Sep 2024 22:20:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C109015886D;
	Wed, 25 Sep 2024 22:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="NBuUHBmy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEDB51D5AD7;
	Wed, 25 Sep 2024 22:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727302802; cv=none; b=LgNvpj11pxv2InbKbKmUt7Et5q8U2MlD9seuS/x4dJkxtwDuHXXNQy9BBK06AuILZGbUrV93Z8gNz/gb9szYBcdU8UWXQL7yE3j8hD8ymP1mKmh23Ba/IJXpYfgUhDREhnIJ1aI8PbhhkRSPOb/Xgnw/dOqRTEEHBQC6PR7CwLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727302802; c=relaxed/simple;
	bh=s78h0173WLdiElXUzH/zkrkjOjV1fOTiw7HNSPdE8hY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D9PNxXRhMsXOyhR68oDxJVTwmVnrcIJsPrZqYwpobzn40KMHefQsExJ5LWtn68TXnt5zn75jJQbTBg/EEWXwy62KRHe1sevpyzBX6LbJxPah9OJbcpCO12uv7r77StJ71/5P4SWp8oc5hN6/Z9HQn8IM/hAgPkvpeyYzolIqZ+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=NBuUHBmy; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=SmnFNMM8r4+SKRmCJmiHPJZBBfyoGvE4LjZ0UsKbny0=; b=NBuUHBmypm5kfiaTOaedhUX/ih
	OXII39eh2LPgQdC5A9uFYkWzo9arhKu2RheeAn688GNImLXeOek5E7KTf2OB8tEdSG32WjvNbsqrq
	8kureE29PMkgCXdius7B79JLx7RoppW805oB7vOM1vSorgzK9ry+DPLXTEmBA03Y/dyQWyC7RTHIU
	3n7HqvCsR2SWO3G/LKCXcMCG5OXHtcD9u1orPSLcB7mzO3nzz5VDfONDlyGtUEM+M3qNnMVu5gdmu
	refbRl8KtBBVbrxsT542jO43vTmijGXAbtrYe7cG0ayIOzXAytjM4aWRmdamFrdZRPQpqNwOZ0f2v
	uHn4iKtg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1staMW-0000000FWIN-3siv;
	Wed, 25 Sep 2024 22:19:56 +0000
Date: Wed, 25 Sep 2024 23:19:56 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: NeilBrown <neilb@suse.de>
Cc: Jeff Layton <jlayton@kernel.org>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>,
	Olga Kornievskaia <okorniev@redhat.com>, linux-nfs@vger.kernel.org
Subject: Re: [PATCH - RFC] VFS: disable new delegations during
 delegation-breaking operations
Message-ID: <20240925221956.GM3550746@ZenIV>
References: <172646129988.17050.4729474250083101679@noble.neil.brown.name>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <172646129988.17050.4729474250083101679@noble.neil.brown.name>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Mon, Sep 16, 2024 at 02:34:59PM +1000, NeilBrown wrote:

> @@ -5011,7 +5012,8 @@ int do_renameat2(int olddfd, struct filename *from, int newdfd,
>  	struct path old_path, new_path;
>  	struct qstr old_last, new_last;
>  	int old_type, new_type;
> -	struct inode *delegated_inode = NULL;
> +	struct inode *delegated_inode_old = NULL;
> +	struct inode *delegated_inode_new = NULL;
>  	unsigned int lookup_flags = 0, target_flags = LOOKUP_RENAME_TARGET;
>  	bool should_retry = false;
>  	int error = -EINVAL;
> @@ -5118,7 +5120,8 @@ int do_renameat2(int olddfd, struct filename *from, int newdfd,
>  	rd.new_dir	   = new_path.dentry->d_inode;
>  	rd.new_dentry	   = new_dentry;
>  	rd.new_mnt_idmap   = mnt_idmap(new_path.mnt);
> -	rd.delegated_inode = &delegated_inode;
> +	rd.delegated_inode_old = &delegated_inode_old;
> +	rd.delegated_inode_new = &delegated_inode_new;
>  	rd.flags	   = flags;
>  	error = vfs_rename(&rd);
>  exit5:
> @@ -5128,9 +5131,14 @@ int do_renameat2(int olddfd, struct filename *from, int newdfd,
>  exit3:
>  	unlock_rename(new_path.dentry, old_path.dentry);
>  exit_lock_rename:
> -	if (delegated_inode) {
> -		error = break_deleg_wait(&delegated_inode);
> -		if (!error)
> +	if (delegated_inode_old) {
> +		error = break_deleg_wait(&delegated_inode_old, error);
> +		if (error == -EWOULDBLOCK)
> +			goto retry_deleg;

Won't that goto leak a reference to delegated_inode_new?

> +	}
> +	if (delegated_inode_new) {
> +		error = break_deleg_wait(&delegated_inode_new, error);
> +		if (error == -EWOULDBLOCK)
>  			goto retry_deleg;
>  	}
>  	mnt_drop_write(old_path.mnt);

> -static inline int break_deleg_wait(struct inode **delegated_inode)
> +static inline int break_deleg_wait(struct inode **delegated_inode, int ret)
>  {
> -	int ret;
> -
> -	ret = break_deleg(*delegated_inode, O_WRONLY);
> -	iput(*delegated_inode);
> -	*delegated_inode = NULL;
> +	if (ret == -EWOULDBLOCK) {
> +		ret = break_deleg(*delegated_inode, O_WRONLY);
> +		if (ret == 0)
> +			ret = -EWOULDBLOCK;
> +	}
> +	if (ret != -EWOULDBLOCK) {
> +		atomic_dec(&(*delegated_inode)->i_flctx->flc_deleg_blockers);
> +		iput(*delegated_inode);
> +		*delegated_inode = NULL;
> +	}
>  	return ret;
>  }

