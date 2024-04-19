Return-Path: <linux-fsdevel+bounces-17278-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 922A98AA807
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Apr 2024 07:45:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF2321C21D8E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Apr 2024 05:45:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7227DBA39;
	Fri, 19 Apr 2024 05:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="vLuEm5IE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-8fac.mail.infomaniak.ch (smtp-8fac.mail.infomaniak.ch [83.166.143.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8403748E
	for <linux-fsdevel@vger.kernel.org>; Fri, 19 Apr 2024 05:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.166.143.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713505496; cv=none; b=tShKhKWb4ADrznBz1X0cfxwoZ39+KPrfJ72qkNAKCbRBtMIgFTnHlehCN2qOOHI+v5abrDbQ6sWnCDHcT5AT0mWuMvmrSzuIRKJJrEfwWgsdI7B2CNg7K4+nrQqj6/nrMbClBKXbQP+jk7d24DBaDM1oIuPd7qBh39wN5wlsNxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713505496; c=relaxed/simple;
	bh=HiOBK7WUQ6+SjYvixQuMMDXV3kp8/XrvDxzSXfPw2e4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q9OOVs6f3xVXxfd/kMYtQj6Rj04yI90ZEEkfABuCCm55JtfkQkNTHYNkiWosPbWNLf4mfXkXeq4G0fEks30tG1dPE4FKiiiZeDr1Vp6aEKTC2yqZ1x2jtd8zafY1jvmqjh0TiOcK0OZiHQLoamhCFswdBwl0ljROhb2oYlBVwTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=vLuEm5IE; arc=none smtp.client-ip=83.166.143.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-4-0001.mail.infomaniak.ch (smtp-4-0001.mail.infomaniak.ch [10.7.10.108])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4VLNrX5w6Pz6VR;
	Fri, 19 Apr 2024 07:44:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
	s=20191114; t=1713505484;
	bh=HiOBK7WUQ6+SjYvixQuMMDXV3kp8/XrvDxzSXfPw2e4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vLuEm5IEN4ZwdMSRY+qfI8nywAqenJEHNxsREsunn8OYHlsPeuSY2EbdDw7VamVJl
	 ckAAXqyCP9c7V+YSET8Nf10PXDEG3G8mDjrhs24itI6QqM8zi+YHyBvXNqTXcTdRrJ
	 vayIGh5++qKhXZk2MKhIXR5ApiVPXpHyn3HTRbKg=
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4VLNrX1TNxz1TD;
	Fri, 19 Apr 2024 07:44:44 +0200 (CEST)
Date: Thu, 18 Apr 2024 22:44:43 -0700
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>
Cc: linux-security-module@vger.kernel.org, Jeff Xu <jeffxu@google.com>, 
	Arnd Bergmann <arnd@arndb.de>, Jorge Lucangeli Obes <jorgelo@chromium.org>, 
	Allen Webb <allenwebb@google.com>, Dmitry Torokhov <dtor@google.com>, 
	Paul Moore <paul@paul-moore.com>, Konstantin Meskhidze <konstantin.meskhidze@huawei.com>, 
	Matt Bobrowski <repnop@google.com>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v14 08/12] selftests/landlock: Exhaustive test for the
 IOCTL allow-list
Message-ID: <20240418.dezuw1Ohg0ca@digikod.net>
References: <20240405214040.101396-1-gnoack@google.com>
 <20240405214040.101396-9-gnoack@google.com>
 <20240412.soo4theeseeY@digikod.net>
 <ZiEQXXXJnSiHrK1R@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZiEQXXXJnSiHrK1R@google.com>
X-Infomaniak-Routing: alpha

On Thu, Apr 18, 2024 at 02:21:49PM +0200, Günther Noack wrote:
> On Fri, Apr 12, 2024 at 05:18:06PM +0200, Mickaël Salaün wrote:
> > On Fri, Apr 05, 2024 at 09:40:36PM +0000, Günther Noack wrote:
> > > +static int ioctl_error(int fd, unsigned int cmd)
> > > +{
> > > +	char buf[1024]; /* sufficiently large */
> > 
> > Could we shrink a bit this buffer?
> 
> Shrunk to 128.
> 
> I'm also zeroing the buffer now, which was missing before,
> to make the behaviour deterministic.
> 
> 
> > > +	int res = ioctl(fd, cmd, &buf);
> > > +
> > > +	if (res < 0)
> > > +		return errno;
> > > +
> > > +	return 0;
> > > +}
> 
> 
> > > +TEST_F_FORK(layout1, blanket_permitted_ioctls)
> > > +{
> > > +   [...]
> > > +	/*
> > > +	 * Checks permitted commands.
> > > +	 * These ones may return errors, but should not be blocked by Landlock.
> > > +	 */
> > > +	EXPECT_NE(EACCES, ioctl_error(fd, FIOCLEX));
> > > +	EXPECT_NE(EACCES, ioctl_error(fd, FIONCLEX));
> > > +	EXPECT_NE(EACCES, ioctl_error(fd, FIONBIO));
> > > +	EXPECT_NE(EACCES, ioctl_error(fd, FIOASYNC));
> > > +	EXPECT_NE(EACCES, ioctl_error(fd, FIOQSIZE));
> > > +	EXPECT_NE(EACCES, ioctl_error(fd, FIFREEZE));
> > > +	EXPECT_NE(EACCES, ioctl_error(fd, FITHAW));
> > > +	EXPECT_NE(EACCES, ioctl_error(fd, FS_IOC_FIEMAP));
> > > +	EXPECT_NE(EACCES, ioctl_error(fd, FIGETBSZ));
> > > +	EXPECT_NE(EACCES, ioctl_error(fd, FICLONE));
> > > +	EXPECT_NE(EACCES, ioctl_error(fd, FICLONERANGE));
> > > +	EXPECT_NE(EACCES, ioctl_error(fd, FIDEDUPERANGE));
> > > +	EXPECT_NE(EACCES, ioctl_error(fd, FS_IOC_GETFSUUID));
> > > +	EXPECT_NE(EACCES, ioctl_error(fd, FS_IOC_GETFSSYSFSPATH));
> > 
> > Could we check for ENOTTY instead of !EACCES? /dev/null should be pretty
> > stable.
> 
> The expected results are all over the place, unfortunately.
> When I tried it, I got this:
> 
>         EXPECT_EQ(0, ioctl_error(fd, FIOCLEX));
>         EXPECT_EQ(0, ioctl_error(fd, FIONCLEX));
>         EXPECT_EQ(0, ioctl_error(fd, FIONBIO));
>         EXPECT_EQ(0, ioctl_error(fd, FIOASYNC));
>         EXPECT_EQ(ENOTTY, ioctl_error(fd, FIOQSIZE));
>         EXPECT_EQ(EPERM, ioctl_error(fd, FIFREEZE));
>         EXPECT_EQ(EPERM, ioctl_error(fd, FITHAW));
>         EXPECT_EQ(EOPNOTSUPP, ioctl_error(fd, FS_IOC_FIEMAP));
>         EXPECT_EQ(0, ioctl_error(fd, FIGETBSZ));
>         EXPECT_EQ(EBADF, ioctl_error(fd, FICLONE));
>         EXPECT_EQ(EXDEV, ioctl_error(fd, FICLONERANGE));  // <----
>         EXPECT_EQ(EINVAL, ioctl_error(fd, FIDEDUPERANGE));
>         EXPECT_EQ(0, ioctl_error(fd, FS_IOC_GETFSUUID));
>         EXPECT_EQ(ENOTTY, ioctl_error(fd, FS_IOC_GETFSSYSFSPATH));
> 
> I find this difficult to read and it distracts from the main point, which
> is that we got past the Landlock check which would have returned an EACCES.

OK

> 
> I spotted an additional problem with FICLONERANGE -- when we pass a
> zero-initialized buffer to that IOCTL, it'll interpret some of these zeros
> to refer to file descriptor 0 (stdin)... and what that means is not
> controlled by the test - the error code can change depending on what that
> FD is.  (I don't want to start filling in all these structs individually.)

I'm OK with your approach as long as the tests are deterministic,
whatever FD 0 is (or not), and as long at they don't have an impact on
FD 0.  To make it more generic and to avoid side effects, I think we
should (always) close FD 0 in ioctl_error() (and explain the reason).

> 
> The only thing that really matters to us is that the result is not EACCES
> (==> we have gotten past the Landlock policy check).  Testing the exact
> behaviour of all of these IOCTLs is maybe stepping too much on the turf of
> these IOCTL implementations and making the test more brittle towards
> cahnges unrelated to Landlock than they need to be [1].
> 
> So, if you are OK with that, I would prefer to keep these checks using
> EXPECT_NE(EACCES, ...).

Yes, it looks good.

> 
> —Günther
> 
> [1] https://abseil.io/resources/swe-book/html/ch12.html has a discussion on
>     why to avoid brittle tests (written about Google, but applicable here
>     as well, IMHO)
> 

