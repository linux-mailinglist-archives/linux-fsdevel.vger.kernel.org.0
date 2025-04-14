Return-Path: <linux-fsdevel+bounces-46399-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C151CA887D1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Apr 2025 17:54:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CCFAE17925C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Apr 2025 15:54:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E7EF27F744;
	Mon, 14 Apr 2025 15:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hLYfVlrQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6933F27F72B;
	Mon, 14 Apr 2025 15:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744646078; cv=none; b=uhIdAiEmb7pEd0Lw7xmDq15vR4qskJfa5TVX5XKCcKfxFIe5MiSiSCcEveR9KPFLZr7OaY/ClxmDHnqUWGyGDzqoC+mDlkVOXv+xKvx/bku4ZytvcIznwJBcaL5LcrikZ6EF96PEiEN+FKMG+hy1T4OgeqDgRK0htMjRDdRBFK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744646078; c=relaxed/simple;
	bh=o7Sn3LssoZFdLf/2WQFJxlbEOZh5vKlFF2621SYwp34=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P1lEoNpsJH+gjo8AaHEecEPk8AWGTgkYEaDvUclCmX8fdHsjFVPPY7afyTZQtXPz5IwuCl9BNeUJI9F0CUkSJUj1tSi++maO5Py+udJMKHpsTUtxjk4RSktg/8dmb8TLhtBWwvIcXHmzDrM2csa+4onEjzLFLStkaowSIm+XGvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hLYfVlrQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 427D7C4CEE2;
	Mon, 14 Apr 2025 15:54:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744646077;
	bh=o7Sn3LssoZFdLf/2WQFJxlbEOZh5vKlFF2621SYwp34=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hLYfVlrQYepHQWesioVCpm42zHOJLSshh+LpFpzd2GUO5z1O33z14rPTbYsGJpLAp
	 G2IF4aybBPOph7yY2k4uEUlzAvuAGg5lYGly2ZEMOD9HvYy0CEkRRzPe0+YLlGeZGp
	 7h4iuqLOg+k5eP523aJlKDrs5Mz7Ay24OXkcNAgnod2BprHZ/2EPo2lWX5vnd0L7DI
	 +NvIOlycB2jUYg17fsEtUtl4ck/ZbofxXVwIrZDiWW6LYis8B8aOH2iEEPjnd1XlPi
	 e8Bxu73vwu3FxmpKutjvRbvR9o+s9imX00ps23+7ziXlxPv45jCYR2W2daOUwP7I2x
	 Nfipbhz2YEAxQ==
Date: Mon, 14 Apr 2025 17:54:33 +0200
From: Christian Brauner <brauner@kernel.org>
To: NeilBrown <neilb@suse.de>
Cc: Vlastimil Babka <vbabka@suse.cz>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
	linux-nfs@vger.kernel.org
Subject: Re: [PATCH 1/2] VFS: change kern_path_locked() and
 user_path_locked_at() to never return negative dentry
Message-ID: <20250414-unecht-geklagt-028caecfeb95@brauner>
References: <20250217003020.3170652-1-neilb@suse.de>
 <20250217003020.3170652-2-neilb@suse.de>
 <20250414-wendung-halbe-e81e952285cc@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250414-wendung-halbe-e81e952285cc@brauner>

On Mon, Apr 14, 2025 at 01:01:53PM +0200, Christian Brauner wrote:
> > diff --git a/kernel/audit_watch.c b/kernel/audit_watch.c
> > index 7f358740e958..367eaf2c78b7 100644
> > --- a/kernel/audit_watch.c
> > +++ b/kernel/audit_watch.c
> > @@ -350,11 +350,10 @@ static int audit_get_nd(struct audit_watch *watch, struct path *parent)
> >  	struct dentry *d = kern_path_locked(watch->path, parent);
> >  	if (IS_ERR(d))
> >  		return PTR_ERR(d);
> > -	if (d_is_positive(d)) {
> > -		/* update watch filter fields */
> > -		watch->dev = d->d_sb->s_dev;
> > -		watch->ino = d_backing_inode(d)->i_ino;
> > -	}
> > +	/* update watch filter fields */
> > +	watch->dev = d->d_sb->s_dev;
> > +	watch->ino = d_backing_inode(d)->i_ino;
> > +
> >  	inode_unlock(d_backing_inode(parent->dentry));
> >  	dput(d);
> >  	return 0;
> > @@ -419,10 +418,11 @@ int audit_add_watch(struct audit_krule *krule, struct list_head **list)
> >  	/* caller expects mutex locked */
> >  	mutex_lock(&audit_filter_mutex);
> >  
> > -	if (ret) {
> > +	if (ret && ret != -ENOENT) {
> >  		audit_put_watch(watch);
> >  		return ret;
> >  	}
> > +	ret = 0;
> 
> So this is broken.
> 
> If kern_path_locked() fails due to a negative dentry and returns ENOENT
> it will have already called path_put() and @parent_path is invalid.
> 
> But right after this audit does:
> 
> >  
> >  	/* either find an old parent or attach a new one */
> >  	parent = audit_find_parent(d_backing_inode(parent_path.dentry));
> 
> and then later on calls path_put() again. So this is a UAF. We need to
> fix this.
> 
> This used to work before because kern_path_locked() return a path with a
> negative dentry.

*returned the parent path even if the looked up dentry was negative

