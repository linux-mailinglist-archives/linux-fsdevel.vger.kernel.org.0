Return-Path: <linux-fsdevel+bounces-50238-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 681AFAC95C2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 May 2025 20:44:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 33F217A8C4B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 May 2025 18:42:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9F6C278E5D;
	Fri, 30 May 2025 18:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="YtET+WyT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E72D8320B;
	Fri, 30 May 2025 18:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748630636; cv=none; b=Gc6pCvp4WjEWC2SdxX/1LPHk1YIUW35NgZXXu4c5j4h7xAcqHdJltaMkJreiCpbyYR056QMek5GHfILLZQZlhd1KOxOXq/l38pEBiiycP/RLIC6mJhJTcALw4f3W+A4/apkPnLiPHjxzQaMKDdlO4ypqVylBzjQVBoIbfrFQPdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748630636; c=relaxed/simple;
	bh=O+SOo4fXh2RonK93tHTCVEAKSrP185mJpn7EfvVyTgc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lm4RgT91pIiWJJhgULUH1l20RdwhM32C6Y8dc8zlco7KNjhKaUr0uzkbxiOQ8yGFJfwC4SG9xr5tX3jea3XxAraMQid7aZSjYkNlFX+IOqPoOvRtguDwDsqX/Kyc/XxgRP4GRJVYWPTXbt0LpCrvK+w9uSXpUesdxHgsFnKMKy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=YtET+WyT; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description;
	bh=A0DFkEBJ3eSjhNRerzJHHjxcP9CBhGkX6phH4Ii4B4A=; b=YtET+WyTM2zCgHOb/JxEESVMcn
	SWbIrAWpEYHsVk3SGfqwaCOZxOfXYw1fbZIB/Kl7VuKvm82MxWueaEI4d2JFuTS7/yog0UHUQ5+Qj
	PdMbIrXP9G4SeSzULJOKHqkV7SI1VyeVgTYDOsbFkhrWjpSXfzPdxYhbVjz8E9NiUwuFvHT+MBTNO
	2eP5ZO8lS/8Xmfv52UX5Sb6ydTCHdQ7CnHjeLJ4yYs9p8r41Vy/fUlIfFVQcQHaicX9Dm8ZD9RDon
	2nw7SajENa1LaHyKeLjezzOUEJVqzaPEVKo1l+pnKNm5sn7cQfs0otm+rBkS+Oq+NdCAHwzu5gOeT
	kR3B0GIA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uL4ho-0000000EoyD-2uvT;
	Fri, 30 May 2025 18:43:48 +0000
Date: Fri, 30 May 2025 19:43:48 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
Cc: Song Liu <song@kernel.org>, Jan Kara <jack@suse.cz>,
	bpf@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org,
	kernel-team@meta.com, andrii@kernel.org, eddyz87@gmail.com,
	ast@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev,
	brauner@kernel.org, kpsingh@kernel.org, mattbobrowski@google.com,
	amir73il@gmail.com, repnop@google.com, jlayton@kernel.org,
	josef@toxicpanda.com, gnoack@google.com,
	Tingmao Wang <m@maowtm.org>
Subject: Re: [PATCH bpf-next 3/4] bpf: Introduce path iterator
Message-ID: <20250530184348.GQ2023217@ZenIV>
References: <CAPhsuW5pAvH3E1dVa85Kx2QsUSheSLobEMg-b0mOdtyfm7s4ug@mail.gmail.com>
 <20250529183536.GL2023217@ZenIV>
 <CAPhsuW7LFP0ddFg_oqkDyO9s7DZX89GFQBOnX=4n5mV=VCP5oA@mail.gmail.com>
 <20250529201551.GN2023217@ZenIV>
 <CAPhsuW5DP1x_wyzT1aYjpj3hxUs4uB8vdK9iEp=+i46QLotiOg@mail.gmail.com>
 <20250529214544.GO2023217@ZenIV>
 <CAPhsuW5oXZVEaMwNpSF74O7wZ_f2Qr_44pu9L4_=LBwdW5T9=w@mail.gmail.com>
 <20250529231018.GP2023217@ZenIV>
 <CAPhsuW6-J+NUe=jX51wGVP=nMFjETu+1LUTsWZiBa1ckwq7b+w@mail.gmail.com>
 <20250530.euz5beesaSha@digikod.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250530.euz5beesaSha@digikod.net>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Fri, May 30, 2025 at 02:20:39PM +0200, Mickaël Salaün wrote:

> Without access to mount_lock, what would be the best way to fix this
> Landlock issue while making it backportable?
> 
> > 
> > If we update path_parent in this patchset with choose_mountpoint(),
> > and use it in Landlock, we will close this race condition, right?
> 
> choose_mountpoint() is currently private, but if we add a new filesystem
> helper, I think the right approach would be to expose follow_dotdot(),
> updating its arguments with public types.  This way the intermediates
> mount points will not be exposed, RCU optimization will be leveraged,
> and usage of this new helper will be simplified.

IMO anything that involves struct nameidata should remain inside
fs/namei.c - something public might share helpers with it, but that's
it.  We had more than enough pain on changes in there, and I'm pretty
sure that we are not done yet; in the area around atomic_open, but not
only there.  Parts of that are still too subtle, IMO - it got a lot
better over the years, but I would really prefer to avoid the need
to bring more code into analysis for any further massage.

Are you sure that follow_dotdot() behaviour is what you really want?

Note that it's not quite how the pathname resolution works.  There we
have the result of follow_dotdot() fed to step_into(), and that changes
things.  Try this:

mkdir /tmp/foo
mkdir /tmp/foo/bar
cd /tmp/foo/bar
mount -t tmpfs none /tmp/foo
touch /tmp/foo/x
ls -Uldi . .. /tmp/foo ../.. /tmp ../x

and think about the results.  Traversing .. is basically "follow_up as much
as possible, then to parent, then follow_down as much as possible" and
the last part (../x) explains why we do it that way.

Which objects would you want to iterate through when dealing with the
current directory in the experiment above?  Simulation of pathwalk
would have the root of overmounting filesystem as the second object
visited; follow_dotdot() would yield the directory overmounted by
that instead.

I'm not saying that either behaviour is right for your case - just that
they are not identical and it's something that needs to be consciously
chosen.

