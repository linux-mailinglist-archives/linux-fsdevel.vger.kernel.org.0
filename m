Return-Path: <linux-fsdevel+bounces-43527-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AA11A57DB0
	for <lists+linux-fsdevel@lfdr.de>; Sat,  8 Mar 2025 20:14:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4354B3AC15C
	for <lists+linux-fsdevel@lfdr.de>; Sat,  8 Mar 2025 19:14:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 131F21F5823;
	Sat,  8 Mar 2025 19:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="e3B6Cf0V"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-bc0a.mail.infomaniak.ch (smtp-bc0a.mail.infomaniak.ch [45.157.188.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C20741A7AF7
	for <linux-fsdevel@vger.kernel.org>; Sat,  8 Mar 2025 19:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.157.188.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741461261; cv=none; b=omamBrSjlScLr2UyPLwqYev8cZJINUWvpl+Ns4lbx3cpAVMAiL4fqU2T8f36rErUHYZX+Syj5r56xObPEr/uuM8dluQN40IAYv7bjGwQ53x+G71kKDwN1VW0n3pKYBYW/Ye/hjeIWk2LWlZm9750SHXGSACGhHRsFIvHCSGZhvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741461261; c=relaxed/simple;
	bh=JSNXoEQit0Z/Oyj1uX1W9pTmor8TMXpeVtzsF4dtlpo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jWdqwiXMOeMab3Zv1ZriVeZv1ixkJ9cT4lReh+n7ajiYcfCnK2gBpkOHL3JX4dJBgm0HXkpSmKbhoMl3WhAM3mtGpfv5Rze4mdjtHBKbhkmMLWMlI2uaMntBtf5j0RERypkwhBCfHcm8ZJmUU0NfiIhUY9QvZDngsAfJ9kz7HM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=e3B6Cf0V; arc=none smtp.client-ip=45.157.188.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-3-0000.mail.infomaniak.ch (smtp-3-0000.mail.infomaniak.ch [10.4.36.107])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4Z9CWX1Nd4zSZR;
	Sat,  8 Mar 2025 20:14:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1741461256;
	bh=N1eYJbJHUkEiOxGlavmDPX6lyxlSYmNiwfc+thPWz1c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=e3B6Cf0VXZBq+740rw2gsKdI+JZEp+dFiZ6D3hPNbnQJX8hxpwyHCKy6XLF8ytcbP
	 uVQ/Ew+sycDTKgS+pWNfe1je6VKvLNyYCTfH/nQSVtf/3DseCEz8UTUqeBaN4TifxK
	 g6chji34t9mLnHVhZoPSDlKo0WIQbwOm0CJ4DcAk=
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4Z9CWW1bM5zrf5;
	Sat,  8 Mar 2025 20:14:15 +0100 (CET)
Date: Sat, 8 Mar 2025 20:14:14 +0100
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Tingmao Wang <m@maowtm.org>, 
	=?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>, Jan Kara <jack@suse.cz>, linux-security-module@vger.kernel.org, 
	Matthew Bobrowski <repnop@google.com>, linux-fsdevel@vger.kernel.org, 
	Tycho Andersen <tycho@tycho.pizza>, Christian Brauner <brauner@kernel.org>, 
	Kees Cook <kees@kernel.org>, Jeff Xu <jeffxu@google.com>, 
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>, Francis Laniel <flaniel@linux.microsoft.com>, 
	Matthieu Buffet <matthieu@buffet.re>, Song Liu <song@kernel.org>
Subject: Re: [RFC PATCH 0/9] Landlock supervise: a mechanism for interactive
 permission requests
Message-ID: <20250308.ahjooV7Ohpho@digikod.net>
References: <cover.1741047969.git.m@maowtm.org>
 <20250304.Choo7foe2eoj@digikod.net>
 <f6ef02c3-ad22-4dc6-b584-93276509dbeb@maowtm.org>
 <CAOQ4uxjz4tGmW3DH3ecBvXEnacQexgM86giXKqoHFGzwzT33bA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxjz4tGmW3DH3ecBvXEnacQexgM86giXKqoHFGzwzT33bA@mail.gmail.com>
X-Infomaniak-Routing: alpha

On Thu, Mar 06, 2025 at 06:07:35PM +0100, Amir Goldstein wrote:
> On Thu, Mar 6, 2025 at 3:57 AM Tingmao Wang <m@maowtm.org> wrote:
> >
> > On 3/4/25 19:48, Mickaël Salaün wrote:
> >
> > > Thanks for this RFC, this is very promising!
> >
> > Hi Mickaël - thanks for the prompt review and for your support! I have
> > read your replies and have some thoughts already, but I kept getting
> > distracted by other stuff and so haven't had much chance to express
> > them.  I will address some first today and some more over the weekend.
> >
> > > Another interesting use case is to trace programs and get an
> > > unprivileged "permissive" mode to quickly create sandbox policies.
> >
> > Yes that would also be a good use. I thought of this initially but was
> > thinking "I guess you can always do that with audit" but if we have
> > landlock supervise maybe that would be an easier thing for tools to
> > build upon...?
> >
> > > As discussed, I was thinking about whether or not it would be possible
> > > to use the fanotify interface (e.g. fanotify_init(), fanotify FD...),
> > > but looking at your code, I think it would mostly increase complexity.
> > > There are also the issue with the Landlock semantic (e.g. access rights)
> > > which does not map 1:1 to the fanotify one.  A last thing is that
> > > fanotify is deeply tied to the VFS.  So, unless someone has a better
> > > idea, let's continue with your approach.
> >
> > That sounds sensible - I will keep going with the current direction of a
> > landlock-specific uapi. (happy to revisit should other people have
> > suggestions)
> >
> 
> w.r.t sharing infrastructure with fanotify, I only looked briefly at
> your patches
> and I have only a vague familiarity with landlock, so I cannot yet form an
> opinion whether this is a good idea, but I wanted to give you a few more
> data points about fanotify that seem relevant.
> 
> 1. There is already some intersection of fanotify and audit lsm via the
> fanotify_response_info_audit_rule extension for permission
> events, so it's kind of a precedent of using fanotify to aid an lsm
> 
> 2. See this fan_pre_modify-wip branch [1] and specifically commit
>   "fanotify: introduce directory entry pre-modify permission events"
> I do have an intention to add create/delete/rename permission events.
> Note that the new fsnotify hooks are added in to do_ vfs helpers, not very
> far from the security_path_ lsm hooks, but not exactly in the same place
> because we want to fsnotify hooks to be before taking vfs locks, to allow
> listener to write to filesystem from event context.
> There are different semantics than just ALLOW/DENY that you need,
> therefore, only if we move the security_path_ hooks outside the
> vfs locks, our use cases could use the same hooks
> 
> 3. There is a recent attempt to add BPF filter to fanotify [2]
> which is driven among other things from the long standing requirement
> to add subtree filtering to fanotify watches.
> The challenge with all the attempt to implement a subtree filter so far,
> is that adding vfs performance overhead for all the users in the system
> is unacceptable.
> 
> IIUC, landlock rule set can already express a subtree filter (?),

Yes, Landlock uses a set of inode tags and a path walk to identify
hierarchies.

> so it is intriguing to know if there is room for some integration on this
> aspect, but my guess is that landlock mostly uses subtree filter
> after filtering by specific pids (?), so it can avoid the performance
> overhead of a subtree filter on most of the users in the system.

Landlock domains are indeed enforced for a set of specific tasks.

> 
> Hope this information is useful.

Yes, thanks for the explanations.  We should definitely take inspiration
from fanotify but I don't think it would be a good fit for Landlock: the
semantic of access rights is (and will) be different, and more
importantly it is not only to supervise filesystem accesses.

> 
> Thanks,
> Amir.
> 
> [1] https://github.com/amir73il/linux/commits/fan_pre_modify-wip/
> [2] https://lore.kernel.org/linux-fsdevel/20241122225958.1775625-1-song@kernel.org/

