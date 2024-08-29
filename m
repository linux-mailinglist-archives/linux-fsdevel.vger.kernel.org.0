Return-Path: <linux-fsdevel+bounces-27745-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42C6A9637F2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 03:46:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5CBF61C21C4D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 01:46:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F70124B28;
	Thu, 29 Aug 2024 01:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qqvKCwvC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0841D8814;
	Thu, 29 Aug 2024 01:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724895999; cv=none; b=VJnrqloohcqMNozCP3NKpR9wjoERWqN3N4Y87Ghh5vd+TDgWpwlzsatmvZ8MVcPMDjbJ9QKgGBvFcxdKKqOStAMXrM3K2ChoF6MDaRDtbq1LHFATjNMeb/BXvgM7EZhutwqr87+e+EeAKuxA7xU8nS2fn9ngSu9S/33FsqMuoPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724895999; c=relaxed/simple;
	bh=LBGvbU9Ahk60LnwOybNrMK4GrZQInCZs70x5HnonAfA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jFDQdyPoynUSJb6oYr2oqokaK8z8amzXGtAqCaDg3yDlskLPAN11tDkI9u9QNpsBWbt3/Md6TlMbK7a8U8NC2M2IBmxfnsZ1fBd/+JexB8yekuVsgJTjGWdn20YrtrkgCLQNXyx3mjVA6n8ReW1Ut6rdBobsQhpslqI2MbM+Fno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qqvKCwvC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68373C4CEC0;
	Thu, 29 Aug 2024 01:46:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724895998;
	bh=LBGvbU9Ahk60LnwOybNrMK4GrZQInCZs70x5HnonAfA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qqvKCwvC0zFHQSXoPyvNGaYcw2isNVHsbXu0whX1qATt7PLF1vTDHK7uM15j2bnCB
	 VOPTBM2QTWtZO+FNc/Nty3TjVKwPvwBOq1myGSAH1555GEm/5NvH9+JwL9tl3zXYOf
	 PzzXLHgpDls/ZDAXRyNmnshuWSHJLtLXory8t3cZyQzmJ/fUyJb3uArJvBGlbTvdvx
	 5XeCXOY7zHWsLrw/kv9FHssSpuOMKCTpLUvRoCigTDHat8HohZeZeSRG6vsx7vRWWf
	 hSKJb+rCW2cKHTJU3g284Bw2DM/IT2MAYDK53+9TuufLLcrC5ZFTSM11DHBPwa10lT
	 gKvosfxxT7vfA==
Date: Wed, 28 Aug 2024 18:46:37 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Jan Kara <jack@suse.cz>
Cc: Dave Chinner <david@fromorbit.com>,
	Christian Brauner <brauner@kernel.org>,
	Hongbo Li <lihongbo22@huawei.com>, viro@zeniv.linux.org.uk,
	gnoack@google.com, mic@digikod.net, linux-fsdevel@vger.kernel.org,
	linux-security-module@vger.kernel.org
Subject: Re: [RFC PATCH] fs: obtain the inode generation number from vfs
 directly
Message-ID: <20240829014637.GA6216@frogsfrogsfrogs>
References: <20240827014108.222719-1-lihongbo22@huawei.com>
 <20240827021300.GK6043@frogsfrogsfrogs>
 <1183f4ae-4157-4cda-9a56-141708c128fe@huawei.com>
 <20240827053712.GL6043@frogsfrogsfrogs>
 <20240827-abmelden-erbarmen-775c12ce2ae5@brauner>
 <20240827171148.GN6043@frogsfrogsfrogs>
 <Zs636Wi+UKAEU2F4@dread.disaster.area>
 <20240828155528.77lz5l7pmwj5sgsc@quack3>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240828155528.77lz5l7pmwj5sgsc@quack3>

On Wed, Aug 28, 2024 at 05:55:28PM +0200, Jan Kara wrote:
> On Wed 28-08-24 15:38:49, Dave Chinner wrote:
> > On Tue, Aug 27, 2024 at 10:11:48AM -0700, Darrick J. Wong wrote:
> > > On Tue, Aug 27, 2024 at 11:22:17AM +0200, Christian Brauner wrote:
> > > > On Mon, Aug 26, 2024 at 10:37:12PM GMT, Darrick J. Wong wrote:
> > > > > On Tue, Aug 27, 2024 at 10:32:38AM +0800, Hongbo Li wrote:
> > > > > > 
> > > > > > 
> > > > > > On 2024/8/27 10:13, Darrick J. Wong wrote:
> > > > > > > On Tue, Aug 27, 2024 at 01:41:08AM +0000, Hongbo Li wrote:
> > > > > > > > Many mainstream file systems already support the GETVERSION ioctl,
> > > > > > > > and their implementations are completely the same, essentially
> > > > > > > > just obtain the value of i_generation. We think this ioctl can be
> > > > > > > > implemented at the VFS layer, so the file systems do not need to
> > > > > > > > implement it individually.
> > > > > > > 
> > > > > > > What if a filesystem never touches i_generation?  Is it ok to advertise
> > > > > > > a generation number of zero when that's really meaningless?  Or should
> > > > > > > we gate the generic ioctl on (say) whether or not the fs implements file
> > > > > > > handles and/or supports nfs?
> > > > > > 
> > > > > > This ioctl mainly returns the i_generation, and whether it has meaning is up
> > > > > > to the specific file system. Some tools will invoke IOC_GETVERSION, such as
> > > > > > `lsattr -v`(but if it's lattr, it won't), but users may not necessarily
> > > > > > actually use this value.
> > > > > 
> > > > > That's not how that works.  If the kernel starts exporting a datum,
> > > > > people will start using it, and then the expectation that it will
> > > > > *continue* to work becomes ingrained in the userspace ABI forever.
> > > > > Be careful about establishing new behaviors for vfat.
> > > > 
> > > > Is the meaning even the same across all filesystems? And what is the
> > > > meaning of this anyway? Is this described/defined for userspace
> > > > anywhere?
> > > 
> > > AFAICT there's no manpage so I guess we could return getrandom32() if we
> > > wanted to. ;)
> > > 
> > > But in seriousness, the usual four filesystems return i_generation.
> > 
> > We do? 
> > 
> > I thought we didn't expose it except via bulkstat (which requires
> > CAP_SYS_ADMIN in the initns).
> > 
> > /me goes looking
> > 
> > Ugh. Well, there you go. I've been living a lie for 20 years.
> > 
> > > That is changed every time an inumber gets reused so that anyone with an
> > > old file handle cannot accidentally open the wrong file.  In theory one
> > > could use GETVERSION to construct file handles
> > 
> > Not theory. We've been constructing XFS filehandles in -privileged-
> > userspace applications since the late 90s. Both DMAPI applications
> > (HSMs) and xfsdump do this in combination with bulkstat to retreive
> > the generation to enable full filesystem access without directory
> > traversal being necessary.
> > 
> > I was completely unaware that FS_IOC_GETVERSION was implemented by
> > XFS and so this information is available to unprivileged users...
> > 
> > > (if you do, UHLHAND!)
> > Not familiar with that acronym.

U Have Lost, Have A Nice Day!

> > 
> > > instead of using name_to_handle_at, which is why it's dangerous to
> > > implement GETVERSION for everyone without checking if i_generation makes
> > > sense.
> > 
> > Yup. If you have predictable generation numbers then it's trivial to
> > guess filehandles once you know the inode number. Exposing
> > generation numbers to unprivileged users allows them to determine if
> > the generation numbers are predictable. Determining patterns is
> > often as simple as a loop doing open(create); get inode number +
> > generation; unlink().
> 
> As far as VFS goes, we have always assumed that a valid file handles can be
> easily forged by unpriviledged userspace and hence all syscalls taking file
> handle are gated by CAP_DAC_READ_SEARCH capability check. That means
> userspace can indeed create a valid file handle but unless the process has
> sufficient priviledges to crawl the whole filesystem, VFS will not allow it
> to do anything special with it.
> 
> I don't know what XFS interfaces use file handles and what are the
> permission requirements there but effectively relying on a 32-bit cookie
> value for security seems like a rather weak security these days to me...

CAP_SYS_ADMIN.

--D

> 								Honza
> -- 
> Jan Kara <jack@suse.com>
> SUSE Labs, CR
> 

