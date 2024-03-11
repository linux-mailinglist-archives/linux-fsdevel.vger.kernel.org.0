Return-Path: <linux-fsdevel+bounces-14128-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CAF3878092
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Mar 2024 14:26:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB344280DEB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Mar 2024 13:26:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3361B3FB97;
	Mon, 11 Mar 2024 13:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mwnzFCBi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EAF73DB8C;
	Mon, 11 Mar 2024 13:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710163535; cv=none; b=iYG6RknG8Nk847c/g3aSjAcdgducdeqD4vRj3FRlZR+lXwBjgCHYgWdFX4enX9B5rWFjBCNRk73FTylfZL3P4b3cHBdlcbyb0Z0SzIu1PPNhGNXy+WaS42P6NpnJgpoL8g/8boEe2KQaP1JIMrPt0CfgbjWpkTFXHajhP9pXbEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710163535; c=relaxed/simple;
	bh=jh8C6IjONAEpPE4pAsXlSyxFvnZp3C+OGYnPtDHDRvc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ESxvVKSrJeLoiTyerbUyHbMjPIHtOetXnESNk7+9vvn0ISbsoHe4ariCY+ODYo3iszu0IuVCyUd1n/P49dRzgZ/3USKYKOvL/a1o72rbZWJfgNpOKCRHi1taTjZlmf0Ok9375DFtqOUeU/mWYeia2SQsTKl4lf6KoVCTa94mowQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mwnzFCBi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3576C43399;
	Mon, 11 Mar 2024 13:25:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710163534;
	bh=jh8C6IjONAEpPE4pAsXlSyxFvnZp3C+OGYnPtDHDRvc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mwnzFCBihdfY9Ihc3IM0WK90QEfkRpoBbEPuzpQkaEEC0Jj8COOjxpEvekRrHvxmR
	 +6mEHXdRwONRkxuADlDvopuPjObUeoCSHoJJp2j7LrTwfxLZqVI4JgfoBIuq294nnM
	 d4Ex8ityqr0hPVqj5oOMCAN0gQWk0Szb32qrnWFlBPSed91O159o56hiSGaML9Ohse
	 pn6F3fThSqBTh3Di/XTHGAsnJp0iABPPzR5dpVcQaT94JFSpBGjKgiu7CYhBW/4NM+
	 RNtqP1Iw0+KtulPI3eQnHEbUJzhdbKY0z5bi0X8NV7niBDDK9t1FlRb3ttUP3eUN/V
	 WNhasm8XnjpZg==
Date: Mon, 11 Mar 2024 14:25:28 +0100
From: Christian Brauner <brauner@kernel.org>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Luis Henriques <lhenriques@suse.de>, Theodore Ts'o <tytso@mit.edu>, 
	Andreas Dilger <adilger.kernel@dilger.ca>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>, linux-ext4@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] ovl: fix the parsing of empty string mount
 parameters
Message-ID: <20240311-weltmeere-gesiegt-798c4201c3f8@brauner>
References: <20240307160225.23841-1-lhenriques@suse.de>
 <20240307160225.23841-4-lhenriques@suse.de>
 <CAJfpegtQSi0GFzUEDqdeOAq7BN2KvDV8i3oBFvPOCKfJJOBd2g@mail.gmail.com>
 <87le6p6oqe.fsf@suse.de>
 <CAJfpeguN9nMJGJzx8sgwP=P9rJFVkYF5rVZOi_wNu7mj_jfBsA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJfpeguN9nMJGJzx8sgwP=P9rJFVkYF5rVZOi_wNu7mj_jfBsA@mail.gmail.com>

On Mon, Mar 11, 2024 at 11:53:03AM +0100, Miklos Szeredi wrote:
> On Mon, 11 Mar 2024 at 11:34, Luis Henriques <lhenriques@suse.de> wrote:
> >
> > Miklos Szeredi <miklos@szeredi.hu> writes:
> >
> > > On Thu, 7 Mar 2024 at 19:17, Luis Henriques <lhenriques@suse.de> wrote:
> > >>
> > >> This patch fixes the usage of mount parameters that are defined as strings
> > >> but which can be empty.  Currently, only 'lowerdir' parameter is in this
> > >> situation for overlayfs.  But since userspace can pass it in as 'flag'
> > >> type (when it doesn't have a value), the parsing will fail because a
> > >> 'string' type is assumed.
> > >
> > > I don't really get why allowing a flag value instead of an empty
> > > string value is fixing anything.
> > >
> > > It just makes the API more liberal, but for what gain?
> >
> > The point is that userspace may be passing this parameter as a flag and
> > not as a string.  I came across this issue with ext4, by doing something
> > as simple as:
> >
> >     mount -t ext4 -o usrjquota= /dev/sda1 /mnt/
> >
> > (actually, the trigger was fstest ext4/053)
> >
> > The above mount should succeed.  But it fails because 'usrjquota' is set
> > to a 'flag' type, not 'string'.
> 
> The above looks like a misparsing, since the equals sign clearly
> indicates that this is not a flag.

Yeah, so with that I do agree. But have you read my reply to the other
thread? I'd like to hear your thoughs on that. The problem is that
mount(8) currently does:

fsconfig(3, FSCONFIG_SET_FLAG, "usrjquota", NULL, 0) = -1 EINVAL (Invalid argument)

for both -o usrjquota and -o usrjquota=

So we need a clear contract with userspace or the in-kernel solution
proposed here. I see the following options:

(1) Userspace must know that mount options such as "usrjquota" that can
    have no value must be specified as "usrjquota=" when passed to
    mount(8). This in turn means we need to tell Karel to update
    mount(8) to recognize this and infer from "usrjquota=" that it must
    be passed as FSCONFIG_SET_STRING.

(2) We use the proposed in-kernel solution where relevant filesystems
    get the ability to declare this both as a string or as a flag value
    in their parameter parsing code. That's not a VFS generic thing.
    It's a per-fs thing.

(3) We burden mount(8) with knowing what mount options are string
    options that are allowed to be empty. This is clearly the least
    preferable one, imho.

(4) We add a sentinel such as "usrjquota=default" or
    "usrjquota=auto" as a VFS level keyword.

In any case, we need to document what we want:

https://github.com/brauner/man-pages-md/blob/main/fsconfig.md

