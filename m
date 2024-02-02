Return-Path: <linux-fsdevel+bounces-10022-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C3682847181
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Feb 2024 14:55:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 66356B26B6D
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Feb 2024 13:55:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6074140774;
	Fri,  2 Feb 2024 13:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="USFhHO2M"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B99447768;
	Fri,  2 Feb 2024 13:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706882103; cv=none; b=O4rfXVV6eK+w2EOXhynP2wjgoe/IqpLX5VlL7qADh+dt2ZNRjZMyraV7U6MADaDQ9EGKsza2oG2NwMUkmNcLRIytZYtLSWdejsYDm/uqboVplWSwP0xuzCEcV0dE6MluNxBbZSCT2hXa6b32hqVXd8X+B6Sa4tpt0UV/JZ+zAi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706882103; c=relaxed/simple;
	bh=3gfdmmL80AhuSpEGaaiz6sd1MPS7nGrFfwPRsqc+AqU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lj8Vv327UjNjlSpqlw6Xt6qNEHTTgZV9jcI33q1lx06CzCw1+C+f0P1pv6F/AngTvuOoQkKQEmsuJCcslDfPfYuvkxKmV90VdhsbCHYtCgWxdBC1EMxfAcvF/4W0ThoBaUO4QmQXI7RHxaYq62sdqr69HI/5wF8q1F0K037viB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=USFhHO2M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C776C43399;
	Fri,  2 Feb 2024 13:55:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706882102;
	bh=3gfdmmL80AhuSpEGaaiz6sd1MPS7nGrFfwPRsqc+AqU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=USFhHO2MtVC76x5PfqrmLV7b5msbnZGyXwCvvX0WFLSaHUAsiTivEVsQ4jERSJ/cL
	 s/YJ0kiTzhfB709TZZLNPkzB9E/Py3gsj0Lnm3TPrOVD2pG6QGkkm2YIp29ilkKied
	 lnr0lM7Kl4/X2mYdMBczI3iFfmyr0xpcCRmWN/6oo2NuBNZfyaFBFL/04sq6bk9xqC
	 hpvP0U3/XHag8k7AfrJb5NU8NfUQj8sWVyQkxNO2QR0d3beARftRT4Y4R0XgUICeTI
	 JTFlSG2gMq9wM2OITYNm2+J/LphldDaN5ZIqckChQSjR91z377Z3qzYIYusNFwtBQA
	 WAbQ8i5OYG3IQ==
Date: Fri, 2 Feb 2024 14:54:57 +0100
From: Christian Brauner <brauner@kernel.org>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Al Viro <viro@zeniv.linux.org.uk>, 
	Stefan Berger <stefanb@linux.ibm.com>, Mimi Zohar <zohar@linux.ibm.com>, linux-unionfs@vger.kernel.org, 
	linux-integrity@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 2/2] fs: remove the inode argument to ->d_real() method
Message-ID: <20240202-hemmung-perspektive-d84b93c25b00@brauner>
References: <20240202110132.1584111-1-amir73il@gmail.com>
 <20240202110132.1584111-3-amir73il@gmail.com>
 <CAJfpeguhrTkNYny1xmJxwOg8m5syhti1FDhJmMucwiY6BZ6eLg@mail.gmail.com>
 <CAOQ4uxhcQfR6QP=oESUvhcwXh+vwBJUL+N1_XDZ5sFGk61HWGg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxhcQfR6QP=oESUvhcwXh+vwBJUL+N1_XDZ5sFGk61HWGg@mail.gmail.com>

On Fri, Feb 02, 2024 at 02:41:16PM +0200, Amir Goldstein wrote:
> On Fri, Feb 2, 2024 at 2:19 PM Miklos Szeredi <miklos@szeredi.hu> wrote:
> >
> > On Fri, 2 Feb 2024 at 12:01, Amir Goldstein <amir73il@gmail.com> wrote:
> >
> > > diff --git a/Documentation/filesystems/locking.rst b/Documentation/filesystems/locking.rst
> > > index d5bf4b6b7509..453039a2e49b 100644
> > > --- a/Documentation/filesystems/locking.rst
> > > +++ b/Documentation/filesystems/locking.rst
> > > @@ -29,7 +29,7 @@ prototypes::
> > >         char *(*d_dname)((struct dentry *dentry, char *buffer, int buflen);
> > >         struct vfsmount *(*d_automount)(struct path *path);
> > >         int (*d_manage)(const struct path *, bool);
> > > -       struct dentry *(*d_real)(struct dentry *, const struct inode *);
> > > +       struct dentry *(*d_real)(struct dentry *, int type);
> >
> > Why not use the specific enum type for the argument?
> 
> No reason, we can do enum d_real_type.

Fwiw, I'm happy to just change this. No need to resend as far as I'm concerned.

