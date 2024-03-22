Return-Path: <linux-fsdevel+bounces-15086-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E53D886E67
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Mar 2024 15:23:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B0B1E1C212C3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Mar 2024 14:23:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21B6D482F3;
	Fri, 22 Mar 2024 14:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BFRATKRa"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 770F0481DA;
	Fri, 22 Mar 2024 14:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711117367; cv=none; b=XNNDRG8clDinZbqOK161TYPOK9mo18Xxyfln/gpl0p3VQvbCQIc0Dx5afokiwKlpkeN2Se8GevS0P9n8t/EW0T/n8V26bw3ExhRmkXNf5IzwaeTe8bt+eypopBosaSZxSr+vPnwJlhuKZx0RmYR63oxeiuuLfzXK+Y1NYeNPNk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711117367; c=relaxed/simple;
	bh=01ClvOef7pl8q6vj3Abu8siOW4aLSir0hSmFQ18dsPI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hSxFbZefj4aItbFZJvrrAZQfBLxrpRC1zhh8uJp0jMsALHbYTXo4MCRYi6XWHj0qpN9ZoWQ4VMQgM3f6gXYfofcNhHVSBTsAYskt1T/si90595og/K5S5VK3rjdfR5N9fGv/3tT5kdp4NMIqPp9Jn5yStuIRg6rHSpziSBpybc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BFRATKRa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 437DCC43390;
	Fri, 22 Mar 2024 14:22:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711117367;
	bh=01ClvOef7pl8q6vj3Abu8siOW4aLSir0hSmFQ18dsPI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BFRATKRa8zQIBIFByQzXl7mn7+cFk9SEvLmiWgmEgbo/uSWGLXNnS/PUv0mgp7NUy
	 kgZAb2thNHf9pi7RKuknYCxUbEHFYvipPX4tyca7rRymWBbrp9VWP1a/ERT2IZHi0F
	 fLgxFARf/Kq4B4ZTyfhS5yL3HRdRCFfXPrdsFWw7/6nhXOKTL4K4EEjC4p60Uz+Avi
	 1TQj4LUNZAIduy0nPaLj6FRTcVGfKp4CdJubctg7qL7wHQmPiM1SEa/G1qrw17n+qJ
	 0+cYtRTJ0l4zKQbnKMYjc/LvmIcBrup7k+KG4inuBV97l7yBqmxcTjX9UUrg4/f/Wu
	 Hh6Ncv46JN8mg==
Date: Fri, 22 Mar 2024 15:22:41 +0100
From: Christian Brauner <brauner@kernel.org>
To: Luis Henriques <lhenriques@suse.de>, 
	Miklos Szeredi <miklos@szeredi.hu>, Jan Kara <jack@suse.cz>
Cc: Theodore Ts'o <tytso@mit.edu>, 
	Andreas Dilger <adilger.kernel@dilger.ca>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Amir Goldstein <amir73il@gmail.com>, linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-unionfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] ovl: fix the parsing of empty string mount
 parameters
Message-ID: <20240322-ortseinfahrt-gespeichert-9fc21a98aa39@brauner>
References: <20240307160225.23841-1-lhenriques@suse.de>
 <20240307160225.23841-4-lhenriques@suse.de>
 <CAJfpegtQSi0GFzUEDqdeOAq7BN2KvDV8i3oBFvPOCKfJJOBd2g@mail.gmail.com>
 <87le6p6oqe.fsf@suse.de>
 <CAJfpeguN9nMJGJzx8sgwP=P9rJFVkYF5rVZOi_wNu7mj_jfBsA@mail.gmail.com>
 <20240311-weltmeere-gesiegt-798c4201c3f8@brauner>
 <CAJfpegsn-jMY2J8Wd2Q9qmZFqxR6fAwZ4auoK+-uyxaK+F-0rw@mail.gmail.com>
 <20240312-orten-erbsen-2105c134762e@brauner>
 <87h6hbhhcj.fsf@brahms.olymp>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87h6hbhhcj.fsf@brahms.olymp>

On Tue, Mar 12, 2024 at 10:31:08AM +0000, Luis Henriques wrote:
> Christian Brauner <brauner@kernel.org> writes:
> 
> > On Mon, Mar 11, 2024 at 03:39:39PM +0100, Miklos Szeredi wrote:
> >> On Mon, 11 Mar 2024 at 14:25, Christian Brauner <brauner@kernel.org> wrote:
> >> 
> >> > Yeah, so with that I do agree. But have you read my reply to the other
> >> > thread? I'd like to hear your thoughs on that. The problem is that
> >> > mount(8) currently does:
> >> >
> >> > fsconfig(3, FSCONFIG_SET_FLAG, "usrjquota", NULL, 0) = -1 EINVAL (Invalid argument)
> >> >
> >> > for both -o usrjquota and -o usrjquota=
> >> 
> >> For "-o usrjquota" this seems right.
> >> 
> >> For "-o usrjquota=" it doesn't.  Flags should never have that "=", so
> >> this seems buggy in more than one ways.
> >> 
> >> > So we need a clear contract with userspace or the in-kernel solution
> >> > proposed here. I see the following options:
> >> >
> >> > (1) Userspace must know that mount options such as "usrjquota" that can
> >> >     have no value must be specified as "usrjquota=" when passed to
> >> >     mount(8). This in turn means we need to tell Karel to update
> >> >     mount(8) to recognize this and infer from "usrjquota=" that it must
> >> >     be passed as FSCONFIG_SET_STRING.
> >> 
> >> Yes, this is what I'm thinking.  Of course this only works if there
> >> are no backward compatibility issues, if "-o usrjquota" worked in the
> >> past and some systems out there relied on this, then this is not
> >> sufficient.
> >
> > Ok, I spoke to Karel and filed:
> >
> > https://github.com/util-linux/util-linux/issues/2837

This is now merged as of today and backported to at least util-linux
2.40 which is the current release.
https://github.com/util-linux/util-linux/pull/2849

If your distros ship 2.39 and won't upgrade to 2.40 for a while it might
be worth cherry-picking that fix.

