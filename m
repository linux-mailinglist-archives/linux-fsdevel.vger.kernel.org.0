Return-Path: <linux-fsdevel+bounces-48176-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B85EAABC1D
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 May 2025 09:55:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A2A82503D89
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 May 2025 07:55:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94214215F5C;
	Tue,  6 May 2025 07:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S2bvm077"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D48452033A;
	Tue,  6 May 2025 07:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746516846; cv=none; b=BA4bzr1tma1k5AnQEaC3HGxy0MAkfkLIGdTy1ixFX7Yh6yC5/A9ptUWE6JlHr4mDcXfhj6Oz5m9JwSLCGEU7w2V7bV8wJvX0yV9cH7LG6+aHGhEAwpX9a0BROtseh7uQVfzxYRDNvFQF79w/fF7HT9hA+kCxWgNZbW2az7WNzIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746516846; c=relaxed/simple;
	bh=d9IiQ8Qjo0tqUnrKW/3eICy/RDOPsZnxBXE+q+64nqs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j9is5gWBMWFHKkF1I4Nn4KAMwaW8cR8VnWYEWW7U1Us6TPqkgEUO3VQIqQfHqTr92CLzATitV6LwiJW5DKEgOMqrQlyc7bMbTEHrZown5XLpcNCBhmvFwmoGKxR1NGiKYjMd0w23b/I3NBG+sZwTyjBE0B7bioKYwWJNRdjbhKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S2bvm077; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BC0FC4CEE4;
	Tue,  6 May 2025 07:34:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746516845;
	bh=d9IiQ8Qjo0tqUnrKW/3eICy/RDOPsZnxBXE+q+64nqs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=S2bvm077AEBpwpjElh8A0pxs3b/rebZU0Otu3ammcbnYh1aGhsMpn8pXkv8cFEEY6
	 BiCmEj0LFdj+u4xXX6bD6/PJVGnZkOe6xQj6iYbl5CGBbI1gLtKXGPhPuOoNj8Yqtw
	 U5Qmd7k4R9mUduH+QjVRQ9mzq2Bafr/9pzFb69hKWX9J10CH1cspYq5KiJD+AcCAZ+
	 drGJ3KKohO7iu+VHOgwv123iB1++jIWM37aqln9TD3dY48Vfgr+f3Qt9tQH9NLGhD5
	 vIQoXGIuhqlCYI7jTaZi1bT58buoTH3Q7JRpkS/RLQYFMO/fRF7K/DkZYycp7Qg1XR
	 blL+jv9RzpAbw==
Date: Tue, 6 May 2025 09:33:58 +0200
From: Christian Brauner <brauner@kernel.org>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: alexander@mihalicyn.com, bluca@debian.org, daan.j.demeyer@gmail.com, 
	davem@davemloft.net, david@readahead.eu, edumazet@google.com, horms@kernel.org, 
	jack@suse.cz, jannh@google.com, kuba@kernel.org, lennart@poettering.net, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, me@yhndnzj.com, 
	netdev@vger.kernel.org, oleg@redhat.com, pabeni@redhat.com, viro@zeniv.linux.org.uk, 
	zbyszek@in.waw.pl
Subject: Re: [PATCH RFC v3 00/10] coredump: add coredump socket
Message-ID: <20250506-umtriebe-rhabarber-161f1fcffe56@brauner>
References: <20250505-work-coredump-socket-v3-0-e1832f0e1eae@kernel.org>
 <20250505183303.14126-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250505183303.14126-1-kuniyu@amazon.com>

> > The coredump socket is located in the initial network namespace.
> 
> I understand this is a reasonable decision to avoid complicated
> path management in the mount ns but keep connectivity from any
> namespace.

Yes, path lookup would not just be horrid it would also require playing
around with credentials and current->fs. The beauty in this
implementation is that its the crash dumping process itself which does
everything.

> > To bind
> > the coredump socket userspace must hold CAP_SYS_ADMIN in the initial
> > user namespace. Listening and reading can happen from whatever
> > unprivileged context is necessary to safely process coredumps.
> > 
> > When a task coredumps it opens a client socket in the initial network
> > namespace and connects to the coredump socket. For now only tasks that
> > are acctually coredumping are allowed to connect to the initial coredump
> > socket.
> 
> This can be controlled by BPF (cgroup sockops or LSM) if a user
> really cares about spam clients.
> 
> I think how to set up coredump is userspace responsibility.

I'll reply to that in the other thread so we don't have millions of
branch points.

> > - Since unix_stream_connect() runs bpf programs during connect it's
> >   possible to even redirect or multiplex coredumps to other sockets.
> 
> If the socket is in a cgroup, yes, and even if not, BPF LSM can
> reject some requests.

Indeed. I've outlined that in an earlier version as well.

> > - The coredump server should mark itself as non-dumpable.
> >   To capture coredumps for the coredump server itself a bpf program
> >   should be run at connect to redirect it to another socket in
> >   userspace. This can be useful for debugging crashing coredump servers.
> > 
> > - A container coredump server in a separate network namespace can simply
> >   bind to linuxafsk/coredump.socket and systemd-coredump fowards
> >   coredumps to the container.
> 
> I think the name should be also configurable in non-initial netns.

I don't see a good reason for this. We can always relax that later if we
have to. The fixed address keeps the coredump setup very very dumb and
simple.

