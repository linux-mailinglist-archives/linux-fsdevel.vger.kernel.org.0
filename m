Return-Path: <linux-fsdevel+bounces-63310-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B298BB4913
	for <lists+linux-fsdevel@lfdr.de>; Thu, 02 Oct 2025 18:37:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D489B3BF5CA
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Oct 2025 16:37:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC63B264F9F;
	Thu,  2 Oct 2025 16:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="Ld+8kkUZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6FBB26560A;
	Thu,  2 Oct 2025 16:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759423013; cv=none; b=roC5El7L02/FC2W/W8G+TmGKFO3MbiyZ4FaYgJqM3ks9N1O+RIYktm5cpP5mlBr89h1N24JNnU8xXPINM7RJKrQnYH93bQpsZGAxLsm1WVVlNe7qfPkxwISU339phPEBIIlzokESd+uteY6w+hg/F2zjZZoPjFSOZnZNB8XQFDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759423013; c=relaxed/simple;
	bh=HPYjs3+DKqm3QLFjB/1aMSh6BHeQhnERuZHceBXD3G8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cxZ1N5MK8zCTNbWPtEAC5A7NnTWWeIJ5lg75DI6eRGtP+9yrS7P7d7QYII/yZf20YukFMTCtGPRpYIIDU8xg+J8465QaJv2g4vOS5K9ppo0V9pupQEtd9epDYFgFFsrjJBxpAatyVLtTGUpjODByv7A6UJZOwm2Js8TCIPeNsm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=Ld+8kkUZ; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=nRpCP/3Hu8Q00omayx/+TrgJVAUQBO+wNfNVX7hCJAs=; b=Ld+8kkUZOpmhbvcVKRXhKyCVlm
	lBSNqZkefsYjfwCmtNsWttcOZr8TwEMEsgRNBhc5xR800s82PVblySSLP9x9oRDsdxEkFl6yA0OIS
	lNRz5HoE2vIpTspToDafLnuzNukm4nqsDl417V8exSr8M5kdy6o6FgZEGWsbLXKYoyMT1IX2vKyY1
	q5y27jl2bay/cAWCC03JwFXrnV11C0imlWqw0/3E83YkUWjWD4A5DHYxTEFwuv7blkO0GFBLLKZi9
	mPchaVz0Q+WgpSYzFfberSsAj47SJJXYbIdXDRKzSDDDMkNrPJTiT/ftt7bl+ylnbJR2/RQHxZ3xY
	1X+ysjGQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v4MIT-00000003TKZ-13UH;
	Thu, 02 Oct 2025 16:36:49 +0000
Date: Thu, 2 Oct 2025 17:36:49 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Jan Kara <jack@suse.cz>
Cc: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org,
	Deepanshu Kartikey <kartikey406@gmail.com>,
	syzbot+1d79ebe5383fc016cf07@syzkaller.appspotmail.com,
	stable@vger.kernel.org
Subject: Re: [PATCH] vfs: Don't leak disconnected dentries on umount
Message-ID: <20251002163649.GO39973@ZenIV>
References: <20251002155506.10755-2-jack@suse.cz>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251002155506.10755-2-jack@suse.cz>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Thu, Oct 02, 2025 at 05:55:07PM +0200, Jan Kara wrote:

> diff --git a/fs/dcache.c b/fs/dcache.c
> index 65cc11939654..3ec21f9cedba 100644
> --- a/fs/dcache.c
> +++ b/fs/dcache.c
> @@ -2557,6 +2557,8 @@ struct dentry *d_alloc_parallel(struct dentry *parent,
>  	spin_lock(&parent->d_lock);
>  	new->d_parent = dget_dlock(parent);
>  	hlist_add_head(&new->d_sib, &parent->d_children);
> +	if (parent->d_flags & DCACHE_DISCONNECTED)
> +		new->d_flags |= DCACHE_DISCONNECTED;
>  	spin_unlock(&parent->d_lock);

Not a good place for that |=, IMO...

