Return-Path: <linux-fsdevel+bounces-43524-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CD48A57D8D
	for <lists+linux-fsdevel@lfdr.de>; Sat,  8 Mar 2025 19:57:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1EEFA3A9DB1
	for <lists+linux-fsdevel@lfdr.de>; Sat,  8 Mar 2025 18:57:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE282197A76;
	Sat,  8 Mar 2025 18:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="k/JDseeW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-8fa9.mail.infomaniak.ch (smtp-8fa9.mail.infomaniak.ch [83.166.143.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92596DDAD
	for <linux-fsdevel@vger.kernel.org>; Sat,  8 Mar 2025 18:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.166.143.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741460226; cv=none; b=f+Xx5K95Q0/4RfDp6KjfGIjz2OS06oc+Fqa6hx2ZnVhLMXeu3OqUeiS08SgHVoWTuS5a2zgqsqPnuutBEWK7Qi4xt6FmTrh3dwgz4rlNxzINfnKgAAoWyzudrxmJcEvsV3Ze/5PEomEYYV3UnI8gcDnwx/8h/p6IGJkMs+35Zao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741460226; c=relaxed/simple;
	bh=wh7NMuVU/yeJzdTWiZ9PoAv+sFHlABIYCbgQhOV7TIo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rNINhO+Nh1f6dRAgHwGSfEgciqMXLcrkg4dSyqbsstEapKRNKarQXpVKjrBAJPT2EfSJusEaNok7dOwIq8r2LvUHv91ZqFrnv9T7zLV5UlbzAZQZFwpgFLkAG4OjPtSZ6vT35V45m+CYGqFjvrE81LN9ZsCDnC/C8gtA7mHR7LE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=k/JDseeW; arc=none smtp.client-ip=83.166.143.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-4-0001.mail.infomaniak.ch (unknown [IPv6:2001:1600:7:10:40ca:feff:fe05:1])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4Z9C7f0MkyzTqY;
	Sat,  8 Mar 2025 19:57:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1741460221;
	bh=XYCSheedmEb88n/QdCp4PW7LeCxkFSk6I5N6pk+GSbA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=k/JDseeW1ho0TNElASkEPkR0kTvxiDpgsfffLpBay0nnxLGuphlJXAombq9a+vLt2
	 pLE3hf492YE0Kqmdd4tt5jfw3utvXd9FCx65HxrWjx6ld5AujnNCxh7AD7nQzjIr+r
	 MXu7+L6z55q02+v4KcFC1A4dmYETlNnmIamrzdB8=
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4Z9C7d0JLyzk3x;
	Sat,  8 Mar 2025 19:57:01 +0100 (CET)
Date: Sat, 8 Mar 2025 19:57:00 +0100
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Tingmao Wang <m@maowtm.org>
Cc: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>, 
	Jan Kara <jack@suse.cz>, linux-security-module@vger.kernel.org, 
	Amir Goldstein <amir73il@gmail.com>, Matthew Bobrowski <repnop@google.com>, 
	linux-fsdevel@vger.kernel.org, Tycho Andersen <tycho@tycho.pizza>, 
	Christian Brauner <brauner@kernel.org>, Kees Cook <kees@kernel.org>, Jeff Xu <jeffxu@google.com>, 
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>, Francis Laniel <flaniel@linux.microsoft.com>, 
	Matthieu Buffet <matthieu@buffet.re>
Subject: Re: [RFC PATCH 0/9] Landlock supervise: a mechanism for interactive
 permission requests
Message-ID: <20250308.uCiaz4Thah7O@digikod.net>
References: <cover.1741047969.git.m@maowtm.org>
 <20250304.Choo7foe2eoj@digikod.net>
 <f6ef02c3-ad22-4dc6-b584-93276509dbeb@maowtm.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f6ef02c3-ad22-4dc6-b584-93276509dbeb@maowtm.org>
X-Infomaniak-Routing: alpha

On Thu, Mar 06, 2025 at 02:57:13AM +0000, Tingmao Wang wrote:
> On 3/4/25 19:48, Mickaël Salaün wrote:
> 
> > Thanks for this RFC, this is very promising!
> 
> Hi Mickaël - thanks for the prompt review and for your support! I have read
> your replies and have some thoughts already, but I kept getting distracted
> by other stuff and so haven't had much chance to express them.  I will
> address some first today and some more over the weekend.
> 
> > Another interesting use case is to trace programs and get an
> > unprivileged "permissive" mode to quickly create sandbox policies.
> 
> Yes that would also be a good use. I thought of this initially but was
> thinking "I guess you can always do that with audit" but if we have landlock
> supervise maybe that would be an easier thing for tools to build upon...?

Both approaches are valuable.  The supervisor one would be unprivileged,
could get access to more information including O_PATH FD's, but it is
much slower and relies on user space monitoring code.

> 
> > As discussed, I was thinking about whether or not it would be possible
> > to use the fanotify interface (e.g. fanotify_init(), fanotify FD...),
> > but looking at your code, I think it would mostly increase complexity.
> > There are also the issue with the Landlock semantic (e.g. access rights)
> > which does not map 1:1 to the fanotify one.  A last thing is that
> > fanotify is deeply tied to the VFS.  So, unless someone has a better
> > idea, let's continue with your approach.
> 
> That sounds sensible - I will keep going with the current direction of a
> landlock-specific uapi. (happy to revisit should other people have
> suggestions)
> 
> > Android's SDCardFS is another example of such use.
> 
> Interesting - seems like it was deprecated for reasons unrelated to security
> though.

Yes, Android first used FUSE, then SDCardFS, then FUSE again, but the
goal has been the same:
https://source.android.com/docs/core/storage/scoped

> 
> > One of the main suggestion would be to align with the audit patch series
> > semantic and the defined "blockers":
> > https://lore.kernel.org/all/20250131163059.1139617-1-mic@digikod.net/
> > I'll send another series soon.
> 
> I will have a read of the existing audit series - are you planning
> significant changes to it in the next one?

Not significant changes but still some that hook changes that might
require a rebase.  I just sent v6, you'll find it applied here:
https://web.git.kernel.org/pub/scm/linux/kernel/git/mic/linux.git/log/?h=next

