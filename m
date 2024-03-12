Return-Path: <linux-fsdevel+bounces-14186-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F274C878FF1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Mar 2024 09:48:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB2AC281395
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Mar 2024 08:48:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE2B077F21;
	Tue, 12 Mar 2024 08:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EWAKYj9H"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1507D77F0A;
	Tue, 12 Mar 2024 08:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710233278; cv=none; b=FDtTJOdkVn90V+P/2dRqVEV67wkQ471IykrA+MQHo5IyKx8tpBP1oavz/e2hwjStOinmFL8gILTVRCRyBZM5sxIyBRTESIjECqSdiIW3Vm9D8M2saUIvkdgdfPFhGhJvHHEJVeRdY8TMVuTLa8YNY5vwkvbAm9NIMND6bv5PZ/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710233278; c=relaxed/simple;
	bh=USx0cA5m8QHpw1Pr8TQY0RJPdw62miN7yco5K9ORroc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ErcfkoKr2o70Jkbr6FOA6bK/zNJt0b7UzIr30VCFAQ2xIGsrW2lz3/TTlJZc8TSa/L2F2L21Gddl/y5b8n4QW0N+WJp1G/JOP8BE8odr8yiXjiEVXmbaUGyPlXfvg88M/1hv/ZoJo9TKk/O1Xk46OxPmdUR42Q4ZZYdNIu+cSTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EWAKYj9H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D66D3C433F1;
	Tue, 12 Mar 2024 08:47:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710233277;
	bh=USx0cA5m8QHpw1Pr8TQY0RJPdw62miN7yco5K9ORroc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EWAKYj9H+Jl9xOXothDdY5tMH9XlzGG4elGZJeXi/nnLM/yVM/KEmOdv2iDrF/Urz
	 66jfhi5uf2BQm1imtI3BPT/Rdt0h1eP00J6xHGyNpbJgjqXrcvx18qyh270VBRWddy
	 lFh5TtVBKFUusVgjEyO5JVaEaE+LChqLJzoF+zSeas7zXX7jtgZWhg7y3Ojj4RwHmt
	 jrwzieTtOKzCXv4pE0qCqQW9EU4MNb1jWTG/8hzGK3XmkLuNelSUUNh5Qm52Z65N1V
	 tDH8K20rvOnEr96pQJV1W8ncB3+Oh8lbJK6qvBCzfQEA5wRE40OzA/5YWBrwkKGmmc
	 PUoY8wqM/HY4g==
Date: Tue, 12 Mar 2024 09:47:52 +0100
From: Christian Brauner <brauner@kernel.org>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Luis Henriques <lhenriques@suse.de>, Theodore Ts'o <tytso@mit.edu>, 
	Andreas Dilger <adilger.kernel@dilger.ca>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>, linux-ext4@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] ovl: fix the parsing of empty string mount
 parameters
Message-ID: <20240312-orten-erbsen-2105c134762e@brauner>
References: <20240307160225.23841-1-lhenriques@suse.de>
 <20240307160225.23841-4-lhenriques@suse.de>
 <CAJfpegtQSi0GFzUEDqdeOAq7BN2KvDV8i3oBFvPOCKfJJOBd2g@mail.gmail.com>
 <87le6p6oqe.fsf@suse.de>
 <CAJfpeguN9nMJGJzx8sgwP=P9rJFVkYF5rVZOi_wNu7mj_jfBsA@mail.gmail.com>
 <20240311-weltmeere-gesiegt-798c4201c3f8@brauner>
 <CAJfpegsn-jMY2J8Wd2Q9qmZFqxR6fAwZ4auoK+-uyxaK+F-0rw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJfpegsn-jMY2J8Wd2Q9qmZFqxR6fAwZ4auoK+-uyxaK+F-0rw@mail.gmail.com>

On Mon, Mar 11, 2024 at 03:39:39PM +0100, Miklos Szeredi wrote:
> On Mon, 11 Mar 2024 at 14:25, Christian Brauner <brauner@kernel.org> wrote:
> 
> > Yeah, so with that I do agree. But have you read my reply to the other
> > thread? I'd like to hear your thoughs on that. The problem is that
> > mount(8) currently does:
> >
> > fsconfig(3, FSCONFIG_SET_FLAG, "usrjquota", NULL, 0) = -1 EINVAL (Invalid argument)
> >
> > for both -o usrjquota and -o usrjquota=
> 
> For "-o usrjquota" this seems right.
> 
> For "-o usrjquota=" it doesn't.  Flags should never have that "=", so
> this seems buggy in more than one ways.
> 
> > So we need a clear contract with userspace or the in-kernel solution
> > proposed here. I see the following options:
> >
> > (1) Userspace must know that mount options such as "usrjquota" that can
> >     have no value must be specified as "usrjquota=" when passed to
> >     mount(8). This in turn means we need to tell Karel to update
> >     mount(8) to recognize this and infer from "usrjquota=" that it must
> >     be passed as FSCONFIG_SET_STRING.
> 
> Yes, this is what I'm thinking.  Of course this only works if there
> are no backward compatibility issues, if "-o usrjquota" worked in the
> past and some systems out there relied on this, then this is not
> sufficient.

Ok, I spoke to Karel and filed:

https://github.com/util-linux/util-linux/issues/2837

So this should get sorted soon.

> > https://github.com/brauner/man-pages-md/blob/main/fsconfig.md
> 
> What's the plan with these?  It would be good if "man fsconfig" would
> finally work.

Yeah, I have this on my todo list but it hasn't been high-prio for me
and it is just so so nice to update the manpages in markdown.

