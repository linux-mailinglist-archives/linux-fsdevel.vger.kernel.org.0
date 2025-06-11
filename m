Return-Path: <linux-fsdevel+bounces-51338-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 520C2AD5AEE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Jun 2025 17:46:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F008518842C3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Jun 2025 15:42:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 075D71DE891;
	Wed, 11 Jun 2025 15:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="ng74j9lQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-bc0a.mail.infomaniak.ch (smtp-bc0a.mail.infomaniak.ch [45.157.188.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDB4C1DE3A5
	for <linux-fsdevel@vger.kernel.org>; Wed, 11 Jun 2025 15:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.157.188.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749656545; cv=none; b=GaIkq/k3NN+TOnum+oEhurAH4J6bvTlvjlY+ps8cNBZ/nknGf+9ykZ9TbJy5UvihK3hI94Bk+3Zz9g8D+r0Id5xvo9oy0OaVS9zNpsEkKVt7l1jPEziZ+3Wl8LNRLqcdM4QPQGHuWsdqgb7MNL9yXqNHYIXyLJJ32vxZumAYaDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749656545; c=relaxed/simple;
	bh=ioO3hNxPGeFPNa5Dj0Y1Ac/kXyZI+FCLfoSP26I/0zg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sKjpP9iOqHWTFSTDSSPQHXkAee1uv6bozwCKUOeZEi1dR3ITgWVX51rGLopEJMapJmSqP1DVocOGhpYgxGovpMMY9IG7nqk6dzjaT5NPl6LkluWABKaUgrJQzzdx1Q/A5T6y2oYcaN8MzioqjXiKiWHXB9PLr3Y4ZWtt1VrKLXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=ng74j9lQ; arc=none smtp.client-ip=45.157.188.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-3-0001.mail.infomaniak.ch (smtp-3-0001.mail.infomaniak.ch [10.4.36.108])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4bHVK31fsszGrJ;
	Wed, 11 Jun 2025 17:42:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1749656535;
	bh=XuuN/g9Cip9+rlNBlmxCYRns/lSpStRWBT4apK7M81Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ng74j9lQSQ9YmZybW55MxcLniGl4bKLh+P247kFAkEcxTV/RePcLDF4e8WmJHTbj5
	 0fcNVhi/shlKKd8ZYVh6So4amaJmxEORoQPHVIAnZI/PwQNw3/hOErnMJN/Ne0LlNN
	 9cqArzbYSzfH8vpOsL6gLpJbnItZq8i+aKvWSlr8=
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4bHVK234ZSzlYN;
	Wed, 11 Jun 2025 17:42:14 +0200 (CEST)
Date: Wed, 11 Jun 2025 17:42:13 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Song Liu <song@kernel.org>
Cc: NeilBrown <neil@brown.name>, Jan Kara <jack@suse.cz>, 
	bpf@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, kernel-team@meta.com, andrii@kernel.org, eddyz87@gmail.com, 
	ast@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev, 
	viro@zeniv.linux.org.uk, brauner@kernel.org, kpsingh@kernel.org, mattbobrowski@google.com, 
	amir73il@gmail.com, repnop@google.com, jlayton@kernel.org, josef@toxicpanda.com, 
	gnoack@google.com, m@maowtm.org
Subject: Re: [PATCH v3 bpf-next 1/5] namei: Introduce new helper function
 path_walk_parent()
Message-ID: <20250611.Bee1Iohoh4We@digikod.net>
References: <20250606213015.255134-1-song@kernel.org>
 <20250606213015.255134-2-song@kernel.org>
 <174959847640.608730.1496017556661353963@noble.neil.brown.name>
 <CAPhsuW6oet8_LbL+6mVi7Lc4U_8i7O-PN5F1zOm5esV52sBu0A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPhsuW6oet8_LbL+6mVi7Lc4U_8i7O-PN5F1zOm5esV52sBu0A@mail.gmail.com>
X-Infomaniak-Routing: alpha

On Tue, Jun 10, 2025 at 05:56:01PM -0700, Song Liu wrote:
> Hi Neil,
> 
> Thanks for your suggestion! It does look like a good solution.
> 
> On Tue, Jun 10, 2025 at 4:34 PM NeilBrown <neil@brown.name> wrote:
> 
> > The above looks a lot like follow_dotdot().  This is good because it
> > means that it is likely correct.  But it is bad because it means there
> > are two copies of essentially the same code - making maintenance harder.
> >
> > I think it would be good to split the part that you want out of
> > follow_dotdot() and use that.  Something like the following.
> >
> > You might need a small wrapper in landlock which would, for example,
> > pass LOOKUP_BENEATH and replace path->dentry with the parent on success.
> >
> > NeilBrown
> >
> > diff --git a/fs/namei.c b/fs/namei.c
> > index 4bb889fc980b..b81d07b4417b 100644
> > --- a/fs/namei.c
> > +++ b/fs/namei.c
> > @@ -2048,36 +2048,65 @@ static struct dentry *follow_dotdot_rcu(struct nameidata *nd)
> >         return nd->path.dentry;
> >  }
> >
> > -static struct dentry *follow_dotdot(struct nameidata *nd)
> > +/**
> > + * path_walk_parent - Find the parent of the given struct path
> > + * @path  - The struct path to start from
> > + * @root  - A struct path which serves as a boundary not to be crosses
> > + * @flags - Some LOOKUP_ flags
> > + *
> > + * Find and return the dentry for the parent of the given path (mount/dentry).
> > + * If the given path is the root of a mounted tree, it is first updated to
> > + * the mount point on which that tree is mounted.
> > + *
> > + * If %LOOKUP_NO_XDEV is given, then *after* the path is updated to a new mount,
> > + * the error EXDEV is returned.
> > + * If no parent can be found, either because the tree is not mounted or because
> > + * the @path matches the @root, then @path->dentry is returned unless @flags
> > + * contains %LOOKUP_BENEATH, in which case -EXDEV is returned.
> > + *
> > + * Returns: either an ERR_PTR() or the chosen parent which will have had the
> > + * refcount incremented.
> > + */
> > +struct dentry *path_walk_parent(struct path *path, struct path *root, int flags)
> 
> We can probably call this __path_walk_parent() and make it static.
> 
> Then we can add an exported path_walk_parent() that calls
> __path_walk_parent() and adds extra logic.
> 
> If this looks good to folks, I can draft v4 based on this idea.

This looks good but it would be better if we could also do a full path
walk within RCU when possible.

> 
> Thanks,
> Song
> 
> [...]
> 

