Return-Path: <linux-fsdevel+bounces-48447-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EB39DAAF38B
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 May 2025 08:16:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F2A21BC41B4
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 May 2025 06:16:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67CDF2139C4;
	Thu,  8 May 2025 06:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kdq2hmc6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7D40747F;
	Thu,  8 May 2025 06:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746684997; cv=none; b=TWPGj19rTgQsV4FryGpBSUDruhHIPFmTnbyw3PLjuicPExKxGJS17RgNAd7tQd+GV7C5D74iM2UTt34PewapeadK+ypRtr1wDo3uOXStBD5IZxEUVg31tXko1uNRkbov58Bm9PJiEBwxzEUyJbbCYdCCDSCqUyH1Psb/xtg07VI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746684997; c=relaxed/simple;
	bh=ZlBwZgLPxWSkt3MKaad6ggNW9bvZErmmOVPw7s8z1Vw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BJDa05CqNysrlpAaf7f1iWy4EBqkCN1J5f58MU4eC0w48Mmq26oIwvH0FV+S4FwfmK3+mlC50/G9wIe/ewddYsL9+28ewv5lvmXBSRUvtxWItNv0h3jd8/GDClMAXHY38CLrLv0PttcOB+gv/8Vzryi6rZtA3++KeEGXwmDUi6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kdq2hmc6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87ECAC4CEEB;
	Thu,  8 May 2025 06:16:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746684997;
	bh=ZlBwZgLPxWSkt3MKaad6ggNW9bvZErmmOVPw7s8z1Vw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kdq2hmc6yKLYxjN4wRYSL5M2SjNXWkz9ldEAJauMi4XNQ6rrzcjCxQNtdlOuITKN+
	 /7EMDg5ReERqc9cxqGXpGFs/Dx4AFOQpgepckMRMsEkZZJT0ciwm8RwbO7nhafEKbY
	 794tUXgiNlpCycVITbSsbkoI0R4shbBA28i3+D5jEmCUxK8ux9w7pnU/la3lT596Pg
	 ifvT6hzL9/WvUEdI52wViGgk7hkm5uWaDXDU5IWqfP6HIZnK2r0PAPwDL6Emuq+pg/
	 uipV8G3UjoGjdXHli6BHirFpTWQoWLFIRMJft/d/wxli7Ok8/VtUWSMWdTr4RXcTXr
	 0bQsTuGX4pH8A==
Date: Thu, 8 May 2025 08:16:29 +0200
From: Christian Brauner <brauner@kernel.org>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: alexander@mihalicyn.com, bluca@debian.org, daan.j.demeyer@gmail.com, 
	davem@davemloft.net, david@readahead.eu, edumazet@google.com, horms@kernel.org, 
	jack@suse.cz, jannh@google.com, kuba@kernel.org, lennart@poettering.net, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, me@yhndnzj.com, 
	netdev@vger.kernel.org, oleg@redhat.com, pabeni@redhat.com, viro@zeniv.linux.org.uk, 
	zbyszek@in.waw.pl
Subject: Re: [PATCH v4 04/11] net: reserve prefix
Message-ID: <20250508-vorboten-herein-4ee71336e6f7@brauner>
References: <20250507-work-coredump-socket-v4-4-af0ef317b2d0@kernel.org>
 <20250507224658.47266-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250507224658.47266-1-kuniyu@amazon.com>

On Wed, May 07, 2025 at 03:45:52PM -0700, Kuniyuki Iwashima wrote:
> From: Christian Brauner <brauner@kernel.org>
> Date: Wed, 07 May 2025 18:13:37 +0200
> > Add the reserved "linuxafsk/" prefix for AF_UNIX sockets and require
> > CAP_NET_ADMIN in the owning user namespace of the network namespace to
> > bind it. This will be used in next patches to support the coredump
> > socket but is a generally useful concept.
> 
> I really think we shouldn't reserve address and it should be
> configurable by users via core_pattern as with the other
> coredump types.
> 
> AF_UNIX doesn't support SO_REUSEPORT, so once the socket is
> dying, user can't start the new coredump listener until it's
> fully cleaned up, which adds unnecessary drawback.

This really doesn't matter.

> The semantic should be same with other types, and the todo
> for the coredump service is prepare file (file, process, socket)
> that can receive data and set its name to core_pattern.

We need to perform a capability check during bind() for the host's
coredump socket. Otherwise if the coredump server crashes an
unprivileged attacker can simply bind the address and receive all
coredumps from suid binaries.

This is also a problem for legitimate coredump server updates. To change
the coredump address the coredump server must first setup a new socket
and then update core_pattern and then shutdown the old coredump socket.

Now an unprivileged attacker can rebind the old coredump socket address
but there's still a crashing task that got scheduled out after it copied
the old coredump server address but before it connected to the coredump
server. The new server is now up and the old server's address has been
reused by the attacker. Now the crashing task gets scheduled back in and
connects to the unprivileged attacker and forwards its suid dump to the
attacker.

The name of the socket needs to be protected. This can be done by prefix
but the simplest way is what I did in my earlier version and to just use
a well-known name. The name really doesn't matter and all it adds is
potential for subtle bugs. I want the coredump code I have to maintain
to have as little moving parts as possible.

I'm happy to drop the patch to reserve the prefix as that seems to
bother you. But the coredump socket name won't be configurable. It'd be
good if we could just compromise here. Without the capability check on
bind we can just throw this all out as that's never going to be safe.

