Return-Path: <linux-fsdevel+bounces-14187-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 98981878FFF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Mar 2024 09:51:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 340591F21BF4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Mar 2024 08:51:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18D0B77F15;
	Tue, 12 Mar 2024 08:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GkTfJF0x"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65B876997B;
	Tue, 12 Mar 2024 08:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710233458; cv=none; b=bMm4eYorRAKv8drpXfxIJLrm+t+tVIAwra9At5Ado5qcHqyOQO7+ZTH6JPfQ1HVSAOrw8TaNfKfezxQR8AnQuS5+u9ZWYxQ/ZiVehohk6OBJTDHLyooYUA6wydcvmUpfSL1kmeKNwYCnn44O55gvaZxzz1ztpY1oyOCBjIX2zJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710233458; c=relaxed/simple;
	bh=UkEHwkFP0GJ42KgigzEfzH5VwwhLCveVEoSZfymiQ7Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r59yekzAP2gr7C15HvzRvxvdq3+Ysx4YQGpAtEh89XpCXZrCtB0jxuwlimIfYEcTuxx43mL8S5pMEgx/iKpyRRfg7Lutb/h/v0Dd3eE6DoS28oyVtwc0aRkWgPKMU395o1I0B/E1/MHkYp2LHUWIwxWCmqbe5K5aD9L0z32Lvmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GkTfJF0x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEC3EC433C7;
	Tue, 12 Mar 2024 08:50:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710233457;
	bh=UkEHwkFP0GJ42KgigzEfzH5VwwhLCveVEoSZfymiQ7Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GkTfJF0x5UxRgfSyApu4CDiDhrydZ3Zrc4DOd5q55HaVgK7X6kzKBcCWgc/oGyF80
	 OwBnxAh/BNFL52qSaDo5H6jvVtoTm7pNGMoW5IjEyBaGgvYz4zuTXkYwZiAbu60cR1
	 Oz2eZYI00wzaFViL+zuME5oxOv9bvtjPejiH6qAP3LBXtYibsYqG7pcYiZh8jd0lqR
	 KHnrLnU1UavaZOvzTDiw3M7K1eR7RFML0kApzy32kIZW9SZ0dVO1PA/uTizKLyKRg9
	 rjC6sHtQphD5LTZ4PUp4zxxG4VwlFLyknhRX6owfpn0r/C3t+4u/CIbVNdTxLIyxm6
	 byTbLk3UW5xkQ==
Date: Tue, 12 Mar 2024 09:50:46 +0100
From: Christian Brauner <brauner@kernel.org>
To: Jan Kara <jack@suse.cz>
Cc: Miklos Szeredi <miklos@szeredi.hu>, 
	Luis Henriques <lhenriques@suse.de>, Theodore Ts'o <tytso@mit.edu>, 
	Andreas Dilger <adilger.kernel@dilger.ca>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Amir Goldstein <amir73il@gmail.com>, linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-unionfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] ovl: fix the parsing of empty string mount
 parameters
Message-ID: <20240312-gaukeln-mehrpolig-8e8fb77f221d@brauner>
References: <20240307160225.23841-1-lhenriques@suse.de>
 <20240307160225.23841-4-lhenriques@suse.de>
 <CAJfpegtQSi0GFzUEDqdeOAq7BN2KvDV8i3oBFvPOCKfJJOBd2g@mail.gmail.com>
 <87le6p6oqe.fsf@suse.de>
 <CAJfpeguN9nMJGJzx8sgwP=P9rJFVkYF5rVZOi_wNu7mj_jfBsA@mail.gmail.com>
 <20240311-weltmeere-gesiegt-798c4201c3f8@brauner>
 <CAJfpegsn-jMY2J8Wd2Q9qmZFqxR6fAwZ4auoK+-uyxaK+F-0rw@mail.gmail.com>
 <20240311180127.4qdr6ln2xf6vviu3@quack3>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240311180127.4qdr6ln2xf6vviu3@quack3>

On Mon, Mar 11, 2024 at 07:01:27PM +0100, Jan Kara wrote:
> On Mon 11-03-24 15:39:39, Miklos Szeredi wrote:
> > On Mon, 11 Mar 2024 at 14:25, Christian Brauner <brauner@kernel.org> wrote:
> > 
> > > Yeah, so with that I do agree. But have you read my reply to the other
> > > thread? I'd like to hear your thoughs on that. The problem is that
> > > mount(8) currently does:
> > >
> > > fsconfig(3, FSCONFIG_SET_FLAG, "usrjquota", NULL, 0) = -1 EINVAL (Invalid argument)
> > >
> > > for both -o usrjquota and -o usrjquota=
> > 
> > For "-o usrjquota" this seems right.
> > 
> > For "-o usrjquota=" it doesn't.  Flags should never have that "=", so
> > this seems buggy in more than one ways.
> > 
> > > So we need a clear contract with userspace or the in-kernel solution
> > > proposed here. I see the following options:
> > >
> > > (1) Userspace must know that mount options such as "usrjquota" that can
> > >     have no value must be specified as "usrjquota=" when passed to
> > >     mount(8). This in turn means we need to tell Karel to update
> > >     mount(8) to recognize this and infer from "usrjquota=" that it must
> > >     be passed as FSCONFIG_SET_STRING.
> > 
> > Yes, this is what I'm thinking.  Of course this only works if there
> > are no backward compatibility issues, if "-o usrjquota" worked in the
> > past and some systems out there relied on this, then this is not
> > sufficient.
> 
> No, "-o usrjquota" never worked and I'm inclined to keep refusing this
> variant as IMHO it is confusing.

Tbh, I'm not too sure that having empty string options was a good idea
even though it can be useful. I think it would've been better if we had
used a specific phantom value to signify this. But yes, I just filed an
issue on util-linux to get this fixed. I think we should also
util-linux and Karel's up for handling this.

> 
> > > In any case, we need to document what we want:
> > >
> > > https://github.com/brauner/man-pages-md/blob/main/fsconfig.md
> > 
> > What's the plan with these?  It would be good if "man fsconfig" would
> > finally work.
> 
> Yes, merging these into official manpages would be nice.

I'll try to get around to it.

