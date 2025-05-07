Return-Path: <linux-fsdevel+bounces-48357-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E30CEAADDE3
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 May 2025 14:00:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E71943AA49B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 May 2025 11:59:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 202AD258CF7;
	Wed,  7 May 2025 11:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="LuVxiMyu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-bc0e.mail.infomaniak.ch (smtp-bc0e.mail.infomaniak.ch [45.157.188.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07ECB233145
	for <linux-fsdevel@vger.kernel.org>; Wed,  7 May 2025 11:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.157.188.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746619181; cv=none; b=owkxGquRblaYLQmRdiG3opPFIOG5ZJga+NVwBioXMIuxrz42whHGuf3Pk2fFLNBp8X7x/lWCmpe/l2jGMtQxwPx3XgBGPo+mPCpnILi7LjbkV6E99Dr5dH7pty8XxSkhMEy9EHZuAt6VktEmpJIjZEYmXTjGgzvYKB7/HEEbeiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746619181; c=relaxed/simple;
	bh=uEzum5nF+PqoNqWvpTR6AVRrPhNnN62R1oXqODBSJjk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f0gRQSa3uL6Lb84OioNsfxK6gxJVbuLljC/NpE03ZiPP+d7kTmcqNHvxCENF6CcHGaz0kh2QRJACht4fEd06Tcl4uSv+3ZHrNA8tjOCR5PE7uGTW8uyop2tNpjzMNiLV5CLlgMojXR62DDncRBBQxItJvQl1RXqh4HlNUj5ofR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=LuVxiMyu; arc=none smtp.client-ip=45.157.188.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-3-0001.mail.infomaniak.ch (smtp-3-0001.mail.infomaniak.ch [10.4.36.108])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4Zstqq3mW7zZdQ;
	Wed,  7 May 2025 13:50:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1746618631;
	bh=6bNZjWeXM1bJfsmZDx17ViRiBQiCQa2YXEftr1jlh/0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LuVxiMyuDShtoyGX/ntkRyXvVvBSrY9NULDxOYqcY7rlMWOtrKbVbC/rE8DiFFXuM
	 YauOCY1zCOna9NmCgIXqs+69CmHLLjzlJedZmWmfc0GSaUNOv53fvP2eLyTvOFVmYP
	 7IwZYXuZ3KmPyxR61j4FNbNuV9spXEEYzN4FbL00=
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4Zstqn3hkjzZWb;
	Wed,  7 May 2025 13:50:29 +0200 (CEST)
Date: Wed, 7 May 2025 13:50:28 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Jann Horn <jannh@google.com>
Cc: Christian Brauner <brauner@kernel.org>, 
	Kuniyuki Iwashima <kuniyu@amazon.com>, alexander@mihalicyn.com, bluca@debian.org, 
	daan.j.demeyer@gmail.com, davem@davemloft.net, david@readahead.eu, edumazet@google.com, 
	horms@kernel.org, jack@suse.cz, kuba@kernel.org, lennart@poettering.net, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, me@yhndnzj.com, 
	netdev@vger.kernel.org, oleg@redhat.com, pabeni@redhat.com, viro@zeniv.linux.org.uk, 
	zbyszek@in.waw.pl
Subject: Re: [PATCH RFC v3 08/10] net, pidfs, coredump: only allow
 coredumping tasks to connect to coredump socket
Message-ID: <20250507.phoyeu7Ao9ja@digikod.net>
References: <20250505193828.21759-1-kuniyu@amazon.com>
 <20250505194451.22723-1-kuniyu@amazon.com>
 <CAG48ez2YRJxDmAZEOSWVvCyz0fkHN2NaC=_mLzcLibVKVOWqHw@mail.gmail.com>
 <20250506-zertifikat-teint-d866c715291a@brauner>
 <CAG48ez25gm3kgrS_q3jPiN0k6+-AMbNG4p9MPAD4E1WByc=VBA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAG48ez25gm3kgrS_q3jPiN0k6+-AMbNG4p9MPAD4E1WByc=VBA@mail.gmail.com>
X-Infomaniak-Routing: alpha

On Tue, May 06, 2025 at 04:51:25PM +0200, Jann Horn wrote:
> On Tue, May 6, 2025 at 9:39 AM Christian Brauner <brauner@kernel.org> wrote:
> > > ("a kernel socket" is not necessarily the same as "a kernel socket
> > > intended for core dumping")
> >
> > Indeed. The usermodehelper is a kernel protocol. Here it's the task with
> > its own credentials that's connecting to a userspace socket. Which makes
> > this very elegant because it's just userspace IPC. No one is running
> > around with kernel credentials anywhere.
> 
> To be clear: I think your current patch is using special kernel
> privileges in one regard, because kernel_connect() bypasses the
> security_socket_connect() security hook. I think it is a good thing
> that it bypasses security hooks in this way; I think we wouldn't want
> LSMs to get in the way of this special connect(), since the task in
> whose context the connect() call happens is not in control of this
> connection; the system administrator is the one who decided that this
> connect() should happen on core dumps. It is kind of inconsistent
> though that that separate security_unix_stream_connect() LSM hook will
> still be invoked in this case, and we might have to watch out to make
> sure that LSMs won't end up blocking such connections... which I think
> is related to what Mickael was saying on the other thread.

Right

> Landlock
> currently doesn't filter abstract connections at that hook, so for now

Landlock implements this hook since Linux 6.12 and can deny connections
from a sandboxed process to a peer outside the sandbox:
https://docs.kernel.org/userspace-api/landlock.html#ipc-scoping
I was worried that security_unix_stream_connect() would be called with
the task's credential, which would block coredumps from sandboxed tasks.
This would also apply to other LSMs.

> this would only be relevant for SELinux and Smack. I guess those are
> maybe less problematic in this regard because they work on full-system
> policies rather than app-specific policies; but still, with the
> current implementation, SELinux/Smack policies would need to be
> designed to allow processes to connect to the core dumping socket to
> make core dumping work.

