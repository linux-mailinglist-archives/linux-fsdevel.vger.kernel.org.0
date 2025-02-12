Return-Path: <linux-fsdevel+bounces-41575-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CFEBA324A5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Feb 2025 12:17:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0AC2A167B83
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Feb 2025 11:17:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F32A20ADE0;
	Wed, 12 Feb 2025 11:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XdrPTOgU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 774CA201260;
	Wed, 12 Feb 2025 11:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739359012; cv=none; b=jLeYSr+4sedl8Q/W9wNE5F7VZrKhg7GCMslHDsCPk99E4wOx8RIQE2deEsoq6OI0ft/gWJ8+UBmuevtcm513tk8rnm2kwEzGXFUrsSqJIvx0ZxbpatCpfBQXJPDnUs67H7ct5hvK6df2WxWbLjxEMqSJBJulPfGv4lPUpbDjtdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739359012; c=relaxed/simple;
	bh=JWsrM6Tcs+C9f+X8PVgHyMjnM9oD4EdsAg4asrUaRs8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aN4qo0CsBcY6pgDlJV2tFPiU0juaP3UEjxsk7Mgeuu+xoEM6l7jhTZ7PtBqs38gL2VvK1F29zrY/BeXKpeCzbNpL3/bu3X3GxhdB9lgGdOyyQzVPLyM7yOGPy0uBYv6M1Z8Dmg+DwttYAn6eYRpCZfBB5JBAwVLOWMZtc9i7c3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XdrPTOgU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 850B9C4CEDF;
	Wed, 12 Feb 2025 11:16:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739359011;
	bh=JWsrM6Tcs+C9f+X8PVgHyMjnM9oD4EdsAg4asrUaRs8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XdrPTOgUPTRYAb9XnRKvfjHMPiC89ZEiduHxoz0NJnI4GQVJiol0rv9oBOdpvoFJR
	 p+VnuStLAkDMk7yhzb+ULDoK1ItVa7cTgbwxMQjzW2EAe2oT+WkhjuFa02DwQSFN47
	 3uYA9g72SheD+ASXImFYR+guVxPx9r8fBwGJY97r6IsgOABfdXdDypW39nMTW8HkTW
	 /Irzkqu31/F1cAmyAwdoT+HWRbcBWvnhstMmKve8fnxIOrGOXSO4YHgwwHzYv3YIht
	 sbBJ4oD01v+2sEtm/BR052Ksbq9O8N7p67wamWwjxLSDnrByAKv1kLNkn/tlNVpHnl
	 leISBHzu7+t8w==
Date: Wed, 12 Feb 2025 12:16:44 +0100
From: Christian Brauner <brauner@kernel.org>
To: Jeff Layton <jlayton@kernel.org>
Cc: Zicheng Qu <quzicheng@huawei.com>, 
	Linus Torvalds <torvalds@linux-foundation.org>, axboe@kernel.dk, joel.granados@kernel.org, tglx@linutronix.de, 
	viro@zeniv.linux.org.uk, hch@lst.de, len.brown@intel.com, pavel@ucw.cz, 
	pengfei.xu@intel.com, rafael@kernel.org, tanghui20@huawei.com, zhangqiao22@huawei.com, 
	judy.chenhui@huawei.com, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, linux-pm@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 0/2] acct: don't allow access to internal filesystems
Message-ID: <20250212-giert-spannend-8893f1eaba7d@brauner>
References: <20250210-unordnung-petersilie-90e37411db18@brauner>
 <20250211-work-acct-v1-0-1c16aecab8b3@kernel.org>
 <c780964d17b908846f07d01f4020be7bc784ec8b.camel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c780964d17b908846f07d01f4020be7bc784ec8b.camel@kernel.org>

On Tue, Feb 11, 2025 at 01:56:41PM -0500, Jeff Layton wrote:
> On Tue, 2025-02-11 at 18:15 +0100, Christian Brauner wrote:
> > In [1] it was reported that the acct(2) system call can be used to
> > trigger a NULL deref in cases where it is set to write to a file that
> > triggers an internal lookup.
> > 
> > This can e.g., happen when pointing acct(2) to /sys/power/resume. At the
> > point the where the write to this file happens the calling task has
> > already exited and called exit_fs() but an internal lookup might be
> > triggered through lookup_bdev(). This may trigger a NULL-deref
> > when accessing current->fs.
> > 
> > This series does two things:
> > 
> > - Reorganize the code so that the the final write happens from the
> >   workqueue but with the caller's credentials. This preserves the
> >   (strange) permission model and has almost no regression risk.
> > 
> > - Block access to kernel internal filesystems as well as procfs and
> >   sysfs in the first place.
> > 
> > This api should stop to exist imho.
> > 
> 
> I wonder who uses it these days, and what would we suggest they replace
> it with? Maybe syscall auditing?

Someone pointed me to atop but that also works without it. Since this is
a privileged api I think the natural candidate to replace all of this is
bpf. I'm pretty sure that it's relatively straightforward to get a lot
more information out of it than with acct(2) and it will probably be
more performant too.

Without any limitations as it is right now, acct(2) can easily lockup
the system quite easily by pointing it to various things in sysfs and
I'm sure it can be abused in other ways. So I wouldn't enable it.

> 
> config BSD_PROCESS_ACCT
>         bool "BSD Process Accounting"
>         depends on MULTIUSER
>         help
>           If you say Y here, a user level program will be able to instruct the
>           kernel (via a special system call) to write process accounting
>           information to a file: whenever a process exits, information about
>           that process will be appended to the file by the kernel.  The
>           information includes things such as creation time, owning user,
>           command name, memory usage, controlling terminal etc. (the complete
>           list is in the struct acct in <file:include/linux/acct.h>).  It is
>           up to the user level program to do useful things with this
>           information.  This is generally a good idea, so say Y.
> 
> Maybe at least time to replace that last sentence and make this default
> to 'n'?

I agree.

> 
> > Link: https://lore.kernel.org/r/20250127091811.3183623-1-quzicheng@huawei.com [1]
> > 
> > Signed-off-by: Christian Brauner <brauner@kernel.org>
> > ---
> > Christian Brauner (2):
> >       acct: perform last write from workqueue
> >       acct: block access to kernel internal filesystems
> > 
> >  kernel/acct.c | 134 ++++++++++++++++++++++++++++++++++++----------------------
> >  1 file changed, 84 insertions(+), 50 deletions(-)
> > ---
> > base-commit: af69e27b3c8240f7889b6c457d71084458984d8e
> > change-id: 20250211-work-acct-a6d8e92a5fe0
> > 
> 
> -- 
> Jeff Layton <jlayton@kernel.org>

