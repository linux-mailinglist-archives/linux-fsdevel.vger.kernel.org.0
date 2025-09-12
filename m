Return-Path: <linux-fsdevel+bounces-61007-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E0EE4B54519
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Sep 2025 10:20:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A1BB189062F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Sep 2025 08:20:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 382D52D7DD8;
	Fri, 12 Sep 2025 08:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YoAdT8CJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71FC12D739C;
	Fri, 12 Sep 2025 08:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757665208; cv=none; b=EN2VkutKcaxxTaDEoWUd1pfT4aaGRzSgPVCIjs1UHV411eWGze1PlFfuI0PR1BNt1O39A4eL/IDUsWDUcqVEDoK8b/Klgc6AcHS8AB6dQ29SyjdL1aSNjJCgk5q4/8yVoiBY69jd7q7Y0X+Sielfl4qi+rkB5c4kAk5F+YVcV4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757665208; c=relaxed/simple;
	bh=OOusLVxnKHKzYYpqIszKMcMpYFoufzRxkmlgmDbuoAE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RIl/z+PTsAoK11LpN2Fbr1CKXLGKIR4GbKS5EZ93sIpgOvs7+nZySzJR5VFeMMuR/XoRu+X6wPJdQ3+k5CHXVrkmSqy3YNx7682ZXhwyTLtE9kBcWsVxQSUNpsSozeytQqPP40lUsqOZMq+vMw4zqTWPR/RDzGMf0qDxOlVsR9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YoAdT8CJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53489C4CEF4;
	Fri, 12 Sep 2025 08:20:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757665208;
	bh=OOusLVxnKHKzYYpqIszKMcMpYFoufzRxkmlgmDbuoAE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YoAdT8CJrYPBnrdP51NjrTWIRu+cXQR39oCZb/t/2jvT1bIJM9VXgbYW0tSIkbYrL
	 NVMqDCnH8Dj8VBDVUAgtyQTvh/3MoRpno+6fCQoZSAox46ONzWRZJp1ktv5Lp5bhzi
	 r9+106OXqgmFfl4iT7miTolwEFwmk1NdK/6Cdi2nBGnzY98SjgBObq8DEg7wHqVRms
	 7AhZQLM74buaIeh3rrJVvSHBVOu3bHROqsVjaM45tLQQ8qPm3HTbOPAXBwytOq7FnC
	 ofuKpTvPGQmC535taTMphjBBwAhRG1wg8Y14FaNzd9xz43E+4693r1aCn97d5Bj/T5
	 ZXJ9rbbMWyWoQ==
Date: Fri, 12 Sep 2025 10:19:57 +0200
From: Christian Brauner <brauner@kernel.org>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
	Josef Bacik <josef@toxicpanda.com>, Jeff Layton <jlayton@kernel.org>, Mike Yuan <me@yhndnzj.com>, 
	Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>, Lennart Poettering <mzxreary@0pointer.de>, 
	Daan De Meyer <daan.j.demeyer@gmail.com>, Aleksa Sarai <cyphar@cyphar.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Chuck Lever <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, 
	netdev@vger.kernel.org
Subject: Re: [PATCH 27/32] nsfs: support file handles
Message-ID: <20250912-wirsing-karibus-7f6a98621dd1@brauner>
References: <20250910-work-namespace-v1-0-4dd56e7359d8@kernel.org>
 <20250910-work-namespace-v1-27-4dd56e7359d8@kernel.org>
 <CAOQ4uxgtQQa-jzsnTBxgUTPzgtCiAaH8X6ffMqd+1Y5Jjy0dmQ@mail.gmail.com>
 <20250911-werken-raubzug-64735473739c@brauner>
 <CAOQ4uxgMgzOjz4E-4kJFJAz3Dpd=Q6vXoGrhz9F0=mb=4XKZqA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxgMgzOjz4E-4kJFJAz3Dpd=Q6vXoGrhz9F0=mb=4XKZqA@mail.gmail.com>

On Thu, Sep 11, 2025 at 01:36:28PM +0200, Amir Goldstein wrote:
> On Thu, Sep 11, 2025 at 11:31 AM Christian Brauner <brauner@kernel.org> wrote:
> >
> > On Wed, Sep 10, 2025 at 07:21:22PM +0200, Amir Goldstein wrote:
> > > On Wed, Sep 10, 2025 at 4:39 PM Christian Brauner <brauner@kernel.org> wrote:
> > > >
> > > > A while ago we added support for file handles to pidfs so pidfds can be
> > > > encoded and decoded as file handles. Userspace has adopted this quickly
> > > > and it's proven very useful.
> > >
> > > > Pidfd file handles are exhaustive meaning
> > > > they don't require a handle on another pidfd to pass to
> > > > open_by_handle_at() so it can derive the filesystem to decode in.
> > > >
> > > > Implement the exhaustive file handles for namespaces as well.
> > >
> > > I think you decide to split the "exhaustive" part to another patch,
> > > so better drop this paragraph?
> >
> > Yes, good point. I've dont that.
> >
> > > I am missing an explanation about the permissions for
> > > opening these file handles.
> > >
> > > My understanding of the code is that the opener needs to meet one of
> > > the conditions:
> > > 1. user has CAP_SYS_ADMIN in the userns owning the opened namespace
> > > 2. current task is in the opened namespace
> >
> > Yes.
> >
> > >
> > > But I do not fully understand the rationale behind the 2nd condition,
> > > that is, when is it useful?
> >
> > A caller is always able to open a file descriptor to it's own set of
> > namespaces. File handles will behave the same way.
> >
> 
> I understand why it's safe, and I do not object to it at all,
> I just feel that I do not fully understand the use case of how ns file handles
> are expected to be used.
> A process can always open /proc/self/ns/mnt
> What's the use case where a process may need to open its own ns by handle?
> 
> I will explain. For CAP_SYS_ADMIN I can see why keeping handles that
> do not keep an elevated refcount of ns object could be useful in the same
> way that an NFS client keeps file handles without keeping the file object alive.
> 
> But if you do not have CAP_SYS_ADMIN and can only open your own ns
> by handle, what is the application that could make use of this?
> and what's the benefit of such application keeping a file handle instead of
> ns fd?

A process is not always able to open /proc/self/ns/. That requires
procfs to be mounted and for /proc/self/ or /proc/self/ns/ to not be
overmounted. However, they can derive a namespace fd from their own
pidfd. And that also always works if it's their own namespace.

There's no need to introduce unnecessary behavioral differences between
/proc/self/ns/, pidfd-derived namespace fs, and file-handle-derived
namespace fds. That's just going to be confusing.

The other thing is that there are legitimate use-case for encoding your
own namespace. For example, you might store file handles to your set of
namespaces in a file on-disk so you can verify when you get rexeced that
they're still valid and so on. This is akin to the pidfd use-case.

Or just plainly for namespace comparison reasons where you keep a file
handle to your own namespaces and can then easily check against others.

