Return-Path: <linux-fsdevel+bounces-47341-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D685A9C4E2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Apr 2025 12:13:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD465923450
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Apr 2025 10:12:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC8A123D29E;
	Fri, 25 Apr 2025 10:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fj+Hk1Kv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53A1423D28D;
	Fri, 25 Apr 2025 10:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745575961; cv=none; b=ivfw7bO8UJuh2oF++6ang/O7eTA0wx2fS3iRkIenPUnHMtVWXC4PaEYB+0TRsFDlFjL+bZ9dE/pqFE0AQXJsffd5NzN55xCgCU64B5X+DRa65uj1rDMwwZvOQ/MUxCaTxshLARqtiJxyXFNbSEsH0vdN6GXokXkehsvXye5xJko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745575961; c=relaxed/simple;
	bh=qLRL3tz3bGlZqKv46BMBI+UsLgxjoZOrWLlfjPKojQY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RsoVePuCY3Zeo7RayYOp37or2LreR4VamlwYCueuxAbRi55fmTfuQT8bycEDJhaGOE9/iS2S2vCxGivM5BPQ528mipqJDkFSrfYKWCovCrkym2GJWkIf222ewo6hOa9YbpBDWQPB5r4e4sm4V6etnfhXDgs35XSovU8jKu6TZaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fj+Hk1Kv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B88DBC4CEEA;
	Fri, 25 Apr 2025 10:12:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745575960;
	bh=qLRL3tz3bGlZqKv46BMBI+UsLgxjoZOrWLlfjPKojQY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Fj+Hk1KvO6V+UiHyFnqoAQOd+HxtoH/0RJAVc4y7SFuJ4fsQH2AsRBN7flzJinxJ8
	 DfPyWpSWy3S/RB+TRNEygqKhEmeRORBAcwXZzI5T81ropmoRFQNfBWKoB+VNwX/y5Y
	 XKLuisclBZxI2vAQXjhP2jtHfjxI8wudI9DNOS9VhhcjiovCX0zzDUIM0x/meRnBiL
	 E7HjxrW79any7qT+0LzAlN2kzJG/iGc4apBOuv7hymbHt/bCYjfT3uBPHANaZMLmVp
	 aU3GdvxQ5SKIOhh7iP1QgVQ7DL4iqlJGco+tY/YN2IdQXcIAg0c0MQMrKqiSCLpHLM
	 j3E0524xn21Qg==
Date: Fri, 25 Apr 2025 12:12:36 +0200
From: Christian Brauner <brauner@kernel.org>
To: Heiko Carstens <hca@linux.ibm.com>, Christoph Hellwig <hch@lst.de>
Cc: gregkh@linuxfoundation.org, rafael@kernel.org, dakr@kernel.org, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>, Xiao Ni <xni@redhat.com>
Subject: Re: [PATCH] devtmpfs: don't use vfs_getattr_nosec to query i_mode
Message-ID: <20250425-stehlen-koexistieren-c0f650dcccec@brauner>
References: <20250423045941.1667425-1-hch@lst.de>
 <20250425100304.7180Ea5-hca@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250425100304.7180Ea5-hca@linux.ibm.com>

On Fri, Apr 25, 2025 at 12:03:04PM +0200, Heiko Carstens wrote:
> On Wed, Apr 23, 2025 at 06:59:41AM +0200, Christoph Hellwig wrote:
> > The recent move of the bdev_statx call to the low-level vfs_getattr_nosec
> > helper caused it being used by devtmpfs, which leads to deadlocks in
> > md teardown due to the block device lookup and put interfering with the
> > unusual lifetime rules in md.
> > 
> > But as handle_remove only works on inodes created and owned by devtmpfs
> > itself there is no need to use vfs_getattr_nosec vs simply reading the
> > mode from the inode directly.  Switch to that to avoid the bdev lookup
> > or any other unintentional side effect.
> > 
> > Reported-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> > Reported-by: Xiao Ni <xni@redhat.com>
> > Fixes: 777d0961ff95 ("fs: move the bdex_statx call to vfs_getattr_nosec")
> > Signed-off-by: Christoph Hellwig <hch@lst.de>
> > Tested-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> > Tested-by: Xiao Ni <xni@redhat.com>
> > ---
> >  drivers/base/devtmpfs.c | 20 ++++++++------------
> >  1 file changed, 8 insertions(+), 12 deletions(-)
> 
> ...
> 
> > @@ -330,11 +329,8 @@ static int handle_remove(const char *nodename, struct device *dev)
> >  	if (IS_ERR(dentry))
> >  		return PTR_ERR(dentry);
> >  
> > -	p.mnt = parent.mnt;
> > -	p.dentry = dentry;
> > -	err = vfs_getattr(&p, &stat, STATX_TYPE | STATX_MODE,
> > -			  AT_STATX_SYNC_AS_STAT);
> > -	if (!err && dev_mynode(dev, d_inode(dentry), &stat)) {
> > +	inode = d_inode(dentry);
> > +	if (dev_mynode(dev, inode)) {
> 
> clang rightfully complains:
> 
>     CC      drivers/base/devtmpfs.o
>       drivers/base/devtmpfs.c:333:6: warning: variable 'err' is used uninitialized whenever 'if' condition is false [-Wsometimes-uninitialized]
>         333 |         if (dev_mynode(dev, inode)) {
>             |             ^~~~~~~~~~~~~~~~~~~~~~
>       drivers/base/devtmpfs.c:358:9: note: uninitialized use occurs here
>         358 |         return err;
>             |                ^~~
>       drivers/base/devtmpfs.c:333:2: note: remove the 'if' if its condition is always true
>         333 |         if (dev_mynode(dev, inode)) {
>             |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~
>       drivers/base/devtmpfs.c:326:9: note: initialize the variable 'err' to silence this warning
>         326 |         int err;
>             |                ^
>             |                 = 0
> 
> That is: if dev_mynode(dev, inode) is not true some random value will be returned.

Don't bother resending, Christoph.
I've already fixed this with int err = 0 in the tree.

