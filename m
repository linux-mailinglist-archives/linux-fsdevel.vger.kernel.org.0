Return-Path: <linux-fsdevel+bounces-31041-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AA60F991251
	for <lists+linux-fsdevel@lfdr.de>; Sat,  5 Oct 2024 00:28:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC5791C22E75
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Oct 2024 22:28:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 359D21B4F26;
	Fri,  4 Oct 2024 22:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="cmfKJI/7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFB8B140E34;
	Fri,  4 Oct 2024 22:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728080894; cv=none; b=T8fNC23up4zzymgOzsLN8ifvexu5MJwY0NtceyintrT3E576FTvy74dB7QRRfnfzJ8zTpczWepbQAgnv0bI33Aak5JghAePNOaVNPm8clHB/+u7Af1xHT1XXLsy1CscSdKzjCHrahWFT3cak+g8/h90XIECkYPXvlMkEbciGEJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728080894; c=relaxed/simple;
	bh=1gv0odzWOvkjk6X2IHkIqlfeI9JgRBx4p55HyuQ22po=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m3rinGoRA9wKE93HQQeLP69AfhvCj2S9ZOQefWbNEq6gj0cSEF8sh9syjgmK+M8+pG/0kBA5b0VkbMfCfxmQqYhOaM6jmDBQAHpa7naKxmXS49RwBFJyeXKg+CVncIra5mQRwCdhllhupNAoF/zdRxsyQ7r1z+tNAf2ANASoqBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=cmfKJI/7; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=4TeFbJreJhhr2F+XDO4Y9bSx72bBZDuZjyZm5w8kduU=; b=cmfKJI/72ZSwTU2Ahx5CNacGEu
	gOg2vmevsOxGfNkCYfQfeNWEtYGrTGZ0LxhpVXymI5N71Q/QOuVhRQC3BcbwbMUJrtA6CwNm8YMjq
	FegJ7zvIrp+WG5yIurgDpbKsLCV76er93KIocskBExooKkcTlh+H9RW8OkXtP4fNg9E31bfDMfl7l
	hOyv/TppFn6nkTvRUBlQIJJxu/JXvYq29+xXkkCz9ZAHUYDEKWAVWJXDaietwOg306h+IvYA2BFih
	s8VDRoszPvUdQGx1tGyUzMJKQZ443uRL7SLajS+tng2Tn8kwi71IO1Ouy8nvUVjTCD7yTuVb0BgIR
	APqT6z7g==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1swqmR-00000000tkc-2AP0;
	Fri, 04 Oct 2024 22:28:11 +0000
Date: Fri, 4 Oct 2024 23:28:11 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>,
	Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org
Subject: Re: [PATCH 1/4] ovl: do not open non-data lower file for fsync
Message-ID: <20241004222811.GU4017910@ZenIV>
References: <20241004102342.179434-1-amir73il@gmail.com>
 <20241004102342.179434-2-amir73il@gmail.com>
 <20241004221625.GR4017910@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241004221625.GR4017910@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Fri, Oct 04, 2024 at 11:16:25PM +0100, Al Viro wrote:
> On Fri, Oct 04, 2024 at 12:23:39PM +0200, Amir Goldstein wrote:
> > ovl_fsync() with !datasync opens a backing file from the top most dentry
> > in the stack, checks if this dentry is non-upper and skips the fsync.
> > 
> > In case of an overlay dentry stack with lower data and lower metadata
> > above it, but without an upper metadata above it, the backing file is
> > opened from the top most lower metadata dentry and never used.
> > 
> > Fix the helper ovl_real_fdget_meta() to return an empty struct fd in
> > that case to avoid the unneeded backing file open.
> 
> Umm...  Won't that screw the callers of ovl_real_fd()?
> 
> I mean, here
> 
> > @@ -395,7 +397,7 @@ static int ovl_fsync(struct file *file, loff_t start, loff_t end, int datasync)
> >  		return ret;
> >  
> >  	ret = ovl_real_fdget_meta(file, &real, !datasync);
> > -	if (ret)
> > +	if (ret || fd_empty(real))
> >  		return ret;
> >  
> 
> you are taking account of that, but what of e.g.
>         ret = ovl_real_fdget(file, &real);
>         if (ret)
>                 return ret;
> 
>         /*
>          * Overlay file f_pos is the master copy that is preserved
>          * through copy up and modified on read/write, but only real
>          * fs knows how to SEEK_HOLE/SEEK_DATA and real fs may impose
>          * limitations that are more strict than ->s_maxbytes for specific
>          * files, so we use the real file to perform seeks.
>          */
>         ovl_inode_lock(inode);
>         fd_file(real)->f_pos = file->f_pos;
> in ovl_llseek()?  Get ovl_real_fdget_meta() called by ovl_real_fdget() and
> have it return 0 with NULL in fd_file(real), and you've got an oops right
> there, don't you?

I see... so you rely upon that thing never happening when the last argument of
ovl_real_fdget_meta() is false, including the call from ovl_real_fdget().

I still don't like the calling conventions, TBH.  Let me think a bit...

