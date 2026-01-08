Return-Path: <linux-fsdevel+bounces-72818-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F6F6D047AB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 08 Jan 2026 17:42:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A7A0531D51A7
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Jan 2026 15:33:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4FDD38BDB8;
	Thu,  8 Jan 2026 11:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eCncCDjY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8209F280309
	for <linux-fsdevel@vger.kernel.org>; Thu,  8 Jan 2026 11:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767870130; cv=none; b=qcIZKlHc3ZuJw+7jrWkk6GZnL3YYQCPympRBGl9XdrGO9cxOr2mOvcHGE1IMBucAEYYSHZv2qqT0ih8DHQ0Z7iPcTyf/nJB8mqNLh/EdTw8ZQqtGmkQvVW6wU8jU34sc40uwryWAzAWlXPOqHrGthc6BSNNnTfdifSZTtG+wK5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767870130; c=relaxed/simple;
	bh=wlRnRPt4YeXXugs2/RcXFUI+P/gybF/wTcAweyrKZxw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nxiAClDUjsAlG0BRrAREkZTF5nXug1eC1XplHnXNUMsy8WBn0tLced7rENJkpufiyWjWohYAFB+tMzQPtr0xd2wqSb8y3LEXzTLlaZykKIdZzFZxHA5c1yBQp9lkaNR2hgZzPwwjk8HHwLdQXy403IDEKB79A2vH2UwG4PETXJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eCncCDjY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6710CC116C6;
	Thu,  8 Jan 2026 11:02:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767870127;
	bh=wlRnRPt4YeXXugs2/RcXFUI+P/gybF/wTcAweyrKZxw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eCncCDjY3clfjWR80mOiOaZJKShcMtMHaFu4YlrmVHER6Tbs0a4qh2fUyTCgggLpP
	 faV3qKxyPByF9Z5s9CVcVZvYlwxtNSUSWOvwwlsuIYV3WRhE69T44zoyadh3atRJYx
	 wU+KlyIRthKM1U9dxESsVjqo6eOYaC3sJY7rym7nOoR/OTML5pXeqCQssbfBNeg9gC
	 C90/dFpzS6RE7K3rquKT5aXTpkZrH1ozeQt/dp+vCl52YZq8XS6b0rCCRovzoOsj+I
	 vW769WXcZpDowRD1JOj1DlHx0F0KQxiHn71ze1KVaMC1KSS7b3czZoVxxvsb4LiyEr
	 BqEnvpxXHaW5w==
Date: Thu, 8 Jan 2026 12:02:01 +0100
From: Christian Brauner <brauner@kernel.org>
To: Colin Walters <walters@verbum.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>, 
	Gao Xiang <hsiangkao@linux.alibaba.com>, linux-fsdevel@vger.kernel.org, Jan Kara <jack@suse.cz>, 
	Jeff Layton <jlayton@kernel.org>, Amir Goldstein <amir73il@gmail.com>, 
	Lennart Poettering <lennart@poettering.net>, Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>, 
	Josef Bacik <josef@toxicpanda.com>
Subject: Re: [PATCH 3/3] fs: add immutable rootfs
Message-ID: <20260108-protokollieren-melone-de2f17539209@brauner>
References: <20260102-work-immutable-rootfs-v1-0-f2073b2d1602@kernel.org>
 <20260102-work-immutable-rootfs-v1-3-f2073b2d1602@kernel.org>
 <f6bef901-b9a6-4882-83d1-9c5c34402351@linux.alibaba.com>
 <20260107024727.GM1712166@ZenIV>
 <20260107-gebahnt-hinfort-4f6bde731e0e@brauner>
 <c118f890-31d8-4330-a146-8a2e7dd47817@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c118f890-31d8-4330-a146-8a2e7dd47817@app.fastmail.com>

On Wed, Jan 07, 2026 at 11:33:29AM -0500, Colin Walters wrote:
> 
> 
> On Wed, Jan 7, 2026, at 5:52 AM, Christian Brauner wrote:
> > On Wed, Jan 07, 2026 at 02:47:27AM +0000, Al Viro wrote:
> >> On Wed, Jan 07, 2026 at 10:28:23AM +0800, Gao Xiang wrote:
> >> 
> >> > Just one random suggestion.  Regardless of Al's comments,
> >> > if we really would like to expose a new visible type to
> >> > userspace,   how about giving it a meaningful name like
> >> > emptyfs or nullfs (I know it could have other meanings
> >> > in other OSes) from its tree hierarchy to avoid the
> >> > ambiguous "rootfs" naming, especially if it may be
> >> > considered for mounting by users in future potential use
> >> > cases?
> >> 
> >> *boggle*
> >> 
> >> _what_ potential use cases?  "This here directory is empty and
> >> it'll stay empty and anyone trying to create stuff in it will
> >> get an error; oh, and we want it to be a mount boundary, for
> >> some reason"?
> >> 
> >> IDGI...
> >
> > It's not a completely crazy idea. I thought about this as well. You
> > could e.g. use it to overmount and hide other directories - like procfs
> > overmounting or sysfs overmounting or hiding stuff in /etc where
> > currently tmpfs is used. But tmpfs is not ideal because you don't get
> > the reliable immutability guarantees.
> 
> Yeah, there's e.g. `/usr/share/empty` that is intended for things like that as a canonical bind mount source.
> 
> I also like this idea (though bikeshed I'd call it "emptyfs") but if we generalize it beyond just the current case, it probably needs to support configuring things like permissions (some cases may want 0700, others 0755 etc.)

We can start with the basic right now where it's not mountable from
userspace and then make it mountable from userspace later.

