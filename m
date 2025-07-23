Return-Path: <linux-fsdevel+bounces-55788-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6445DB0EDA9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Jul 2025 10:52:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F43418948F8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Jul 2025 08:52:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26A5127CCE7;
	Wed, 23 Jul 2025 08:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SUyciycp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8034FAD23;
	Wed, 23 Jul 2025 08:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753260749; cv=none; b=MeIlixjLwFjdaCKpZqpnNqEbn6Pb7zPGR0nXbI9gboA8HTF/pEWZkbXrVal2qK/2oZgoMq/RGIYd/BmND3Elqo87wefOyGYOD5wZa25bQJGh322kOe7VpytUh/jUBdeFD+m9hQLMSQmPGICZrTBju7w4uxtLd3JqUM45VYQn6Gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753260749; c=relaxed/simple;
	bh=bR8zspkfynarmrhPiCAmxK+pcaJU4QZYwrepOzgiypo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BE0TVSULE2a1wFz1uGFUZ/R5Nojx3YhkjOrVRKGchhzG8wVIQQG3PuuXF9LjUne0iNMHfVzddfg8e6Y/lZgBCNwYcaLgYDt4BRiTrdqD+7Zu69x6lQZz4PC/PNepn87wuWbj65pTbN4RaqR2vVS06N/Wh6TcmFvLsm1KFQlogVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SUyciycp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD81CC4CEE7;
	Wed, 23 Jul 2025 08:52:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753260749;
	bh=bR8zspkfynarmrhPiCAmxK+pcaJU4QZYwrepOzgiypo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SUyciycpHuLjmy6gOd6vyRqMwyC4wgfzI7VanweEw2K+/9pDf0VQbL1L1L7WdntuS
	 CY7wB5Go00E5qF+Gzm4yU6uklrBD5strC5bztFTSjr1DLBlTEBaFh0vIck/xMz5oXR
	 OjZMFJY/ZH4VtuIMSM59h0mr7+JKIA4JR9n/2wVJbNdwZVQApt2qN+cBQlg/3IbQjd
	 FcrV41yt2o8EW5CxOY/W8egn4aBJtAbMYs5LlcmmI94rLMwU4bM956C3cR+UwH8Uz3
	 n5KLEWFdQW+Risc6LGlBQhKMXhiOx0nzTxh4drb9do5YP6p1BcZuAI1jYfZFA8Bu9E
	 ngZCpLsVfAdhg==
Date: Wed, 23 Jul 2025 10:52:23 +0200
From: Christian Brauner <brauner@kernel.org>
To: Eric Biggers <ebiggers@kernel.org>
Cc: Jeff Layton <jlayton@kernel.org>, Jan Kara <jack@suse.com>, 
	Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>, Josef Bacik <josef@toxicpanda.com>, 
	"Theodore Y. Ts'o" <tytso@mit.edu>, linux-fsdevel@vger.kernel.org, linux-fscrypt@vger.kernel.org, 
	fsverity@lists.linux.dev
Subject: Re: [PATCH v3 07/13] fs: drop i_crypt_info from struct inode
Message-ID: <20250723-parzelle-jemals-68737b8fb072@brauner>
References: <20250722-work-inode-fscrypt-v3-0-bdc1033420a0@kernel.org>
 <20250722-work-inode-fscrypt-v3-7-bdc1033420a0@kernel.org>
 <20250722201945.GD111676@quark>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250722201945.GD111676@quark>

On Tue, Jul 22, 2025 at 01:19:45PM -0700, Eric Biggers wrote:
> On Tue, Jul 22, 2025 at 09:27:25PM +0200, Christian Brauner wrote:
> > @@ -799,12 +799,11 @@ void fscrypt_put_encryption_info(struct inode *inode)
> >  {
> >  	struct fscrypt_inode_info **crypt_info;
> >  
> > -	if (inode->i_sb->s_op->i_fscrypt)
> > +	if (inode->i_sb->s_op->i_fscrypt) {
> >  		crypt_info = fscrypt_addr(inode);
> > -	else
> > -		crypt_info = &inode->i_crypt_info;
> > -	put_crypt_info(*crypt_info);
> > -	*crypt_info = NULL;
> > +		put_crypt_info(*crypt_info);
> > +		*crypt_info = NULL;
> > +	}
> >  }
> 
> This could use an IS_ENCRYPTED(inode) check at the beginning, to
> minimize the overhead on unencrypted files.  Before we just loaded
> inode:i_crypt_info, but now that accessing the fscrypt_inode_info will
> be more expensive it would be worthwhile to check IS_ENCRYPTED() first.

Done.

> 
> >  static inline struct fscrypt_inode_info *
> > @@ -232,15 +224,14 @@ fscrypt_get_inode_info(const struct inode *inode)
> >  {
> >  	/*
> >  	 * Pairs with the cmpxchg_release() in fscrypt_setup_encryption_info().
> > -	 * I.e., another task may publish ->i_crypt_info concurrently, executing
> > +	 * I.e., another task may publish ->i_fscrypt_info concurrently, executing
> >  	 * a RELEASE barrier.  We need to use smp_load_acquire() here to safely
> >  	 * ACQUIRE the memory the other task published.
> >  	 */
> >  
> >  	if (inode->i_sb->s_op->i_fscrypt)
> >  		return smp_load_acquire(fscrypt_addr(inode));
> > -
> > -	return smp_load_acquire(&inode->i_crypt_info);
> > +	return NULL;
> 
> The conditional here shouldn't be needed, since this should be called
> only on filesystems that support encryption.  Did you find a case where
> it isn't?

Ok, if that can't happen let's still place a VFS_WARN_ON_ONCE() here so
we catch bugs when CONFIG_DEBUG_VFS is set.

