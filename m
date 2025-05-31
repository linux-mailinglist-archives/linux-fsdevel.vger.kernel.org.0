Return-Path: <linux-fsdevel+bounces-50255-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BF22AC9A20
	for <lists+linux-fsdevel@lfdr.de>; Sat, 31 May 2025 10:47:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CFD601665A5
	for <lists+linux-fsdevel@lfdr.de>; Sat, 31 May 2025 08:47:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1A982367A3;
	Sat, 31 May 2025 08:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="MHgeFy2R"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-42ab.mail.infomaniak.ch (smtp-42ab.mail.infomaniak.ch [84.16.66.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2D25BE5E
	for <linux-fsdevel@vger.kernel.org>; Sat, 31 May 2025 08:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.16.66.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748681239; cv=none; b=rN2VFkHXvzWrcdEY2aRTAXYaTy010833RIY3ZA/szqVDUyxSeeHnri109E7RaoSNWkIfIBoDMx/sZxOeXzA10Me0C6HxSpFeqDDXb9i1dzU5hwnXcEOzrLhYOGOPmCUzE8Ufru10EjWIq9baboMWapFOclpjva/662O+g9S9+c0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748681239; c=relaxed/simple;
	bh=sYZi93/yPJO5ZF2q+Up42YMESADN6on5s2Xc31n4Fx0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=buuc5cWCzByjzbQ1stCgVaAS7PzYhtSPJqFU34f6sIwspQ5p2dYPcJEFnkgCp2QU2SDtxkCd3SkZLjR6GZsXJvTUmbwKFXdCfWlyMAza2wJHqCdl//WXQWa3OgKsY371BymyamnFjBsoeJ5G9dRKIsME5Rr0cs0BnvoQJBfeWm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=MHgeFy2R; arc=none smtp.client-ip=84.16.66.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-4-0001.mail.infomaniak.ch (smtp-4-0001.mail.infomaniak.ch [10.7.10.108])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4b8YRt6G19zLCp;
	Sat, 31 May 2025 10:39:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1748680746;
	bh=y9YddgqwimNGVoqG1X5gr78LYtkCAqMi4STBWfmUjbE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MHgeFy2RsPFQaevV4qfTD4etw8+KjwqF5O9K9KIIRslX+FZuZZL3A9ukvGh6Sir6L
	 qf7IXhkZ+lyJSXGs18geyFYGwx1uF7GnNXGjrRJu83/2+pIHjk2XWGJOjH1aXmou6h
	 EwTkDw21Ciw/s8+snsFhgd/2UysyFgtH7Q+rFTRM=
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4b8YRs69dkz43W;
	Sat, 31 May 2025 10:39:05 +0200 (CEST)
Date: Sat, 31 May 2025 10:39:02 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Song Liu <song@kernel.org>, Jan Kara <jack@suse.cz>, 
	bpf@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, kernel-team@meta.com, andrii@kernel.org, eddyz87@gmail.com, 
	ast@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev, brauner@kernel.org, 
	kpsingh@kernel.org, mattbobrowski@google.com, amir73il@gmail.com, repnop@google.com, 
	jlayton@kernel.org, josef@toxicpanda.com, gnoack@google.com, 
	Tingmao Wang <m@maowtm.org>
Subject: Re: [PATCH bpf-next 3/4] bpf: Introduce path iterator
Message-ID: <20250531.nie3chiew9Nu@digikod.net>
References: <20250529183536.GL2023217@ZenIV>
 <CAPhsuW7LFP0ddFg_oqkDyO9s7DZX89GFQBOnX=4n5mV=VCP5oA@mail.gmail.com>
 <20250529201551.GN2023217@ZenIV>
 <CAPhsuW5DP1x_wyzT1aYjpj3hxUs4uB8vdK9iEp=+i46QLotiOg@mail.gmail.com>
 <20250529214544.GO2023217@ZenIV>
 <CAPhsuW5oXZVEaMwNpSF74O7wZ_f2Qr_44pu9L4_=LBwdW5T9=w@mail.gmail.com>
 <20250529231018.GP2023217@ZenIV>
 <CAPhsuW6-J+NUe=jX51wGVP=nMFjETu+1LUTsWZiBa1ckwq7b+w@mail.gmail.com>
 <20250530.euz5beesaSha@digikod.net>
 <20250530184348.GQ2023217@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250530184348.GQ2023217@ZenIV>
X-Infomaniak-Routing: alpha

On Fri, May 30, 2025 at 07:43:48PM +0100, Al Viro wrote:
> On Fri, May 30, 2025 at 02:20:39PM +0200, Mickaël Salaün wrote:
> 
> > Without access to mount_lock, what would be the best way to fix this
> > Landlock issue while making it backportable?
> > 
> > > 
> > > If we update path_parent in this patchset with choose_mountpoint(),
> > > and use it in Landlock, we will close this race condition, right?
> > 
> > choose_mountpoint() is currently private, but if we add a new filesystem
> > helper, I think the right approach would be to expose follow_dotdot(),
> > updating its arguments with public types.  This way the intermediates
> > mount points will not be exposed, RCU optimization will be leveraged,
> > and usage of this new helper will be simplified.
> 
> IMO anything that involves struct nameidata should remain inside
> fs/namei.c - something public might share helpers with it, but that's
> it.  We had more than enough pain on changes in there, and I'm pretty
> sure that we are not done yet; in the area around atomic_open, but not
> only there.  Parts of that are still too subtle, IMO - it got a lot
> better over the years, but I would really prefer to avoid the need
> to bring more code into analysis for any further massage.
> 
> Are you sure that follow_dotdot() behaviour is what you really want?
> 
> Note that it's not quite how the pathname resolution works.  There we
> have the result of follow_dotdot() fed to step_into(), and that changes
> things.  Try this:
> 
> mkdir /tmp/foo
> mkdir /tmp/foo/bar
> cd /tmp/foo/bar
> mount -t tmpfs none /tmp/foo
> touch /tmp/foo/x
> ls -Uldi . .. /tmp/foo ../.. /tmp ../x
> 
> and think about the results.  Traversing .. is basically "follow_up as much
> as possible, then to parent, then follow_down as much as possible" and
> the last part (../x) explains why we do it that way.
> 
> Which objects would you want to iterate through when dealing with the
> current directory in the experiment above?  Simulation of pathwalk
> would have the root of overmounting filesystem as the second object
> visited; follow_dotdot() would yield the directory overmounted by
> that instead.
> 
> I'm not saying that either behaviour is right for your case - just that
> they are not identical and it's something that needs to be consciously
> chosen.

Thanks, this helps. I didn't though about this semantic difference.  We
don't want the handle_dots() semantic (which call follow_dotdot() and
step_into()), only the (backward) pathwalk one which is equivalent to
follow_dotdot().  I'll add Landlock tests for this specific scenario.

