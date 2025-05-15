Return-Path: <linux-fsdevel+bounces-49113-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A29DAB824D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 May 2025 11:17:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DEB9C1B62A43
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 May 2025 09:17:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37CC5297A54;
	Thu, 15 May 2025 09:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PvW+7QrB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B3F0296157;
	Thu, 15 May 2025 09:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747300630; cv=none; b=D4WOD9FjXArHG/F8F3CaiIvbSv8F4uekaofkBxOfHvImxbloaiQIaxo62ILjSEYbAY12j+oxFKPLqdU4Dpp0QApJMjhyZFjoGRiXYByrX5EUcnOpX735rRtDYxA3zeE5cPyT6Ja/tvaCc4EJORhOfDmZfkB90xss9UPCmPXxnf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747300630; c=relaxed/simple;
	bh=aKQNALUFKpA2c4teux9nQkxq26FnVN2RV1olH/ka2YY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IVugZFwPfpnMVHyE3PaOHoFjN/gNdXFonOcVKhQy2sYqGq/aOjQTux1YBtLfJWv+V8zjMWjvXaJ3Xrk/7s5rChGSeqcqFtYu5YdMMwKPNcqhKxow+7ORlJEQOFd8O2ViUUJDJb00PwTzQ7A4rks9T91IJRMEwAYxOc/kdeO3+YU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PvW+7QrB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B5D8C4CEE7;
	Thu, 15 May 2025 09:17:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747300630;
	bh=aKQNALUFKpA2c4teux9nQkxq26FnVN2RV1olH/ka2YY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PvW+7QrBpbaH1XvqgG1/WZJhwkEwQcUSE+3Zgyyg24vHg+ddHxR5NL3P8qimfaJpq
	 OvZM0nToS7P80zCPFEYV8LZPFIxuhWzieT2pM220FEntTCgU7VmR5y4rnN5eit+4TR
	 2uZ3/VU/5F1I8Bu0HJopTyPCvJEXLh0QZCH1+5oCmA2LpoBxKT92DvvNTiHlIHqIQQ
	 iul6qyI7i8/M0QSQek6LYND3yMotZrM06qvd1X3sd/L4K4TJiA380due5ZjEdRM/hi
	 5e8dg6WhP3ZngSb3umZpEfVKjWtXJVMBEH6oFMmpy3e8D2NCb8fHlp3YTAoBBuOkk+
	 FMzqKmMmALJOg==
Date: Thu, 15 May 2025 11:17:03 +0200
From: Christian Brauner <brauner@kernel.org>
To: linux-fsdevel@vger.kernel.org, Jann Horn <jannh@google.com>, 
	Daniel Borkmann <daniel@iogearbox.net>, Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: Eric Dumazet <edumazet@google.com>, Oleg Nesterov <oleg@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Daan De Meyer <daan.j.demeyer@gmail.com>, David Rheinsberg <david@readahead.eu>, 
	Jakub Kicinski <kuba@kernel.org>, Jan Kara <jack@suse.cz>, 
	Lennart Poettering <lennart@poettering.net>, Luca Boccassi <bluca@debian.org>, Mike Yuan <me@yhndnzj.com>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	linux-security-module@vger.kernel.org, Alexander Mikhalitsyn <alexander@mihalicyn.com>
Subject: Re: [PATCH v7 0/9] coredump: add coredump socket
Message-ID: <20250515-ameisen-abmarsch-37b698f99847@brauner>
References: <20250515-work-coredump-socket-v7-0-0a1329496c31@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250515-work-coredump-socket-v7-0-0a1329496c31@kernel.org>

On Thu, May 15, 2025 at 12:03:33AM +0200, Christian Brauner wrote:
> Coredumping currently supports two modes:
> 
> (1) Dumping directly into a file somewhere on the filesystem.
> (2) Dumping into a pipe connected to a usermode helper process
>     spawned as a child of the system_unbound_wq or kthreadd.
> 
> For simplicity I'm mostly ignoring (1). There's probably still some
> users of (1) out there but processing coredumps in this way can be
> considered adventurous especially in the face of set*id binaries.
> 
> The most common option should be (2) by now. It works by allowing
> userspace to put a string into /proc/sys/kernel/core_pattern like:
> 
>         |/usr/lib/systemd/systemd-coredump %P %u %g %s %t %c %h
> 
> The "|" at the beginning indicates to the kernel that a pipe must be
> used. The path following the pipe indicator is a path to a binary that
> will be spawned as a usermode helper process. Any additional parameters
> pass information about the task that is generating the coredump to the
> binary that processes the coredump.
> 
> In the example core_pattern shown above systemd-coredump is spawned as a
> usermode helper. There's various conceptual consequences of this
> (non-exhaustive list):
> 
> - systemd-coredump is spawned with file descriptor number 0 (stdin)
>   connected to the read-end of the pipe. All other file descriptors are
>   closed. That specifically includes 1 (stdout) and 2 (stderr). This has
>   already caused bugs because userspace assumed that this cannot happen
>   (Whether or not this is a sane assumption is irrelevant.).
> 
> - systemd-coredump will be spawned as a child of system_unbound_wq. So
>   it is not a child of any userspace process and specifically not a
>   child of PID 1. It cannot be waited upon and is in a weird hybrid
>   upcall which are difficult for userspace to control correctly.
> 
> - systemd-coredump is spawned with full kernel privileges. This
>   necessitates all kinds of weird privilege dropping excercises in
>   userspace to make this safe.
> 
> - A new usermode helper has to be spawned for each crashing process.
> 
> This series adds a new mode:
> 
> (3) Dumping into an abstract AF_UNIX socket.

s/abstract//
Forgot to remove that. Fixed in-tree.

