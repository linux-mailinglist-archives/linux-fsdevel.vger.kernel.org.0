Return-Path: <linux-fsdevel+bounces-41659-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F0FEA344D8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Feb 2025 16:09:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B30AA1897420
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Feb 2025 15:00:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DF72241684;
	Thu, 13 Feb 2025 14:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iP24EfKu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CB3726B097;
	Thu, 13 Feb 2025 14:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739458603; cv=none; b=CQJpogPwPcxvv4G26u42Q4qj44/MzJ5wuXTHvDuOf38U1thEVULlk3E3XQYMWyqpQAyGOrMHJv32hUHkj9DSAyBdMmj1I+Mh/YMvv+Zoz6QkSYIa69U6xaZnwYAWZhIr4PED/HQ9DXqolGF4QwTQ+n0kaaeDMtgsi0quWkFqO1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739458603; c=relaxed/simple;
	bh=1c+8kd6RcCKre+0HsXei01s42nKKjeClsDrJF/DX180=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J2sD00OyFAQZA9eA7JnyqyQ4VV/nsFELI7YvabXYF5k8ZzfRk6qz0Pg6cBpmHoXF6VAAtkhstz1t/IIuSpQ/eAyz8NR9lbi+lybDHOySvZG+t9ru53DgWBHH138gdAuC9k1KoqxgqZi5odNGMRxyr4kPbYVAXMCB59KK5oQHIuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iP24EfKu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59BDAC4CED1;
	Thu, 13 Feb 2025 14:56:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739458602;
	bh=1c+8kd6RcCKre+0HsXei01s42nKKjeClsDrJF/DX180=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iP24EfKu6fDycnZNKLaIdiIAbJyaTBdhhzW3raL6Kjl30uXTw7Jyc/zWZ3kDJ9W7C
	 LqVhnR+gwbkmlm9M+B5SqPEFuRYDxoyGFALjD8knWVh/X+gDBPJuqr87DlbQhDDKcQ
	 VfyHteUOw9m/XZ6OuPOM75UmfWDG7i+dqrvA/nNpyfY9knM2PDPkWlrCzl8uwzLG9e
	 0fXOFAopCWqhBiAqdX7Wq6NMJMhGmc395DnUF3Py/UYCokLs7wm7w9M29kdjx7PDQ9
	 ppKiteIYc+d8jikrPu4NGUBrfYzbu9LYlPwFvUKaW+ABHzjZxEmPGMxJI76VgOBPu/
	 FR8yBJmaDRe6w==
Date: Thu, 13 Feb 2025 15:56:35 +0100
From: Christian Brauner <brauner@kernel.org>
To: Jeff Layton <jlayton@kernel.org>
Cc: Zicheng Qu <quzicheng@huawei.com>, 
	Linus Torvalds <torvalds@linux-foundation.org>, axboe@kernel.dk, joel.granados@kernel.org, tglx@linutronix.de, 
	viro@zeniv.linux.org.uk, hch@lst.de, len.brown@intel.com, pavel@ucw.cz, 
	pengfei.xu@intel.com, rafael@kernel.org, tanghui20@huawei.com, zhangqiao22@huawei.com, 
	judy.chenhui@huawei.com, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, linux-pm@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 0/2] acct: don't allow access to internal filesystems
Message-ID: <20250213-fehlgriff-filmt-1dfdd558ab78@brauner>
References: <20250210-unordnung-petersilie-90e37411db18@brauner>
 <20250211-work-acct-v1-0-1c16aecab8b3@kernel.org>
 <c780964d17b908846f07d01f4020be7bc784ec8b.camel@kernel.org>
 <20250212-giert-spannend-8893f1eaba7d@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250212-giert-spannend-8893f1eaba7d@brauner>

On Wed, Feb 12, 2025 at 12:16:44PM +0100, Christian Brauner wrote:
> On Tue, Feb 11, 2025 at 01:56:41PM -0500, Jeff Layton wrote:
> > On Tue, 2025-02-11 at 18:15 +0100, Christian Brauner wrote:
> > > In [1] it was reported that the acct(2) system call can be used to
> > > trigger a NULL deref in cases where it is set to write to a file that
> > > triggers an internal lookup.
> > > 
> > > This can e.g., happen when pointing acct(2) to /sys/power/resume. At the
> > > point the where the write to this file happens the calling task has
> > > already exited and called exit_fs() but an internal lookup might be
> > > triggered through lookup_bdev(). This may trigger a NULL-deref
> > > when accessing current->fs.
> > > 
> > > This series does two things:
> > > 
> > > - Reorganize the code so that the the final write happens from the
> > >   workqueue but with the caller's credentials. This preserves the
> > >   (strange) permission model and has almost no regression risk.
> > > 
> > > - Block access to kernel internal filesystems as well as procfs and
> > >   sysfs in the first place.
> > > 
> > > This api should stop to exist imho.
> > > 
> > 
> > I wonder who uses it these days, and what would we suggest they replace
> > it with? Maybe syscall auditing?
> 
> Someone pointed me to atop but that also works without it. Since this is
> a privileged api I think the natural candidate to replace all of this is
> bpf. I'm pretty sure that it's relatively straightforward to get a lot
> more information out of it than with acct(2) and it will probably be
> more performant too.
> 
> Without any limitations as it is right now, acct(2) can easily lockup
> the system quite easily by pointing it to various things in sysfs and
> I'm sure it can be abused in other ways. So I wouldn't enable it.

And I totally forgot about taskstats via Netlink:
https://www.kernel.org/doc/Documentation/accounting/taskstats.txt
include/uapi/linux/taskstats.h

