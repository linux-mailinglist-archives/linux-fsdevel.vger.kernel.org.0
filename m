Return-Path: <linux-fsdevel+bounces-14193-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF66E879236
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Mar 2024 11:35:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B6F92828D4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Mar 2024 10:35:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C1B578288;
	Tue, 12 Mar 2024 10:35:07 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from andre.telenet-ops.be (andre.telenet-ops.be [195.130.132.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3011C53E3C
	for <linux-fsdevel@vger.kernel.org>; Tue, 12 Mar 2024 10:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.130.132.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710239706; cv=none; b=bGrZscm3HJoMsxlLm7+INdGxbvT5hmFYTR2GKoQ3HPyXv6BMKaB/OoZgGd3qbyF8YgQI8enFNTmXf/kh8Vumkzj3QF+/oTgsQkdEjADDvhmD4GOGzaCWB8GvpNUbDaq4iMgB6a1ZCD0mBUwPHDPRLiuNlMPylSMks/EcSMPeOik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710239706; c=relaxed/simple;
	bh=XBc7Af1NkUozACweWiULsPD5xPfiFYsgN8mpnQ4+IEo=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=EcmmLGtstvuYu4gKRszhlg72eoy3oY2ZBOeaaWWviAVFOtwon/GDe/fM/vdywB3qkae8r8qVwGDLVdEn7KXXzxVMDjvPM/YeSdh/s5N1+U6O6CB5Hk2tQ/KDecCfqQmnbbPOfrAna89uDRoUogH1SS36/71PHzk3h9GCyOKuaFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=none smtp.mailfrom=linux-m68k.org; arc=none smtp.client-ip=195.130.132.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed80:76d0:2bff:fec8:549])
	by andre.telenet-ops.be with bizsmtp
	id xmb22B0020SSLxL01mb2E4; Tue, 12 Mar 2024 11:35:02 +0100
Received: from geert (helo=localhost)
	by ramsan.of.borg with local-esmtp (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1rjzTJ-003RY5-Tk;
	Tue, 12 Mar 2024 11:35:01 +0100
Date: Tue, 12 Mar 2024 11:35:01 +0100 (CET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Christian Brauner <brauner@kernel.org>
cc: linux-fsdevel@vger.kernel.org, 
    Linus Torvalds <torvalds@linux-foundation.org>, 
    Alexander Viro <viro@zeniv.linux.org.uk>, 
    Seth Forshee <sforshee@kernel.org>, Tycho Andersen <tycho@tycho.pizza>, 
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] pidfd: add pidfdfs
In-Reply-To: <20240213-vfs-pidfd_fs-v1-2-f863f58cfce1@kernel.org>
Message-ID: <71bc82f4-b2df-c813-3aba-107d95c67d33@linux-m68k.org>
References: <20240213-vfs-pidfd_fs-v1-0-f863f58cfce1@kernel.org> <20240213-vfs-pidfd_fs-v1-2-f863f58cfce1@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

 	Hi Christian,

On Tue, 13 Feb 2024, Christian Brauner wrote:
> This moves pidfds from the anonymous inode infrastructure to a tiny
> pseudo filesystem. This has been on my todo for quite a while as it will
> unblock further work that we weren't able to do simply because of the
> very justified limitations of anonymous inodes. Moving pidfds to a tiny
> pseudo filesystem allows:
>
> * statx() on pidfds becomes useful for the first time.
> * pidfds can be compared simply via statx() and then comparing inode
>  numbers.
> * pidfds have unique inode numbers for the system lifetime.
> * struct pid is now stashed in inode->i_private instead of
>  file->private_data. This means it is now possible to introduce
>  concepts that operate on a process once all file descriptors have been
>  closed. A concrete example is kill-on-last-close.
> * file->private_data is freed up for per-file options for pidfds.
> * Each struct pid will refer to a different inode but the same struct
>  pid will refer to the same inode if it's opened multiple times. In
>  contrast to now where each struct pid refers to the same inode. Even
>  if we were to move to anon_inode_create_getfile() which creates new
>  inodes we'd still be associating the same struct pid with multiple
>  different inodes.
> * Pidfds now go through the regular dentry_open() path which means that
>  all security hooks are called unblocking proper LSM management for
>  pidfds. In addition fsnotify hooks are called and allow for listening
>  to open events on pidfds.
>
> The tiny pseudo filesystem is not visible anywhere in userspace exactly
> like e.g., pipefs and sockfs. There's no lookup, there's no complex
> inode operations, nothing. Dentries and inodes are always deleted when
> the last pidfd is closed.
>
> The code is entirely optional and fairly small. If it's not selected we
> fallback to anonymous inodes. Heavily inspired by nsfs which uses a
> similar stashing mechanism just for namespaces.
>
> Signed-off-by: Christian Brauner <brauner@kernel.org>

Thanks for your patch, which is now commit cb12fd8e0dabb9a1
("pidfd: add pidfs") upstream.

> --- a/fs/Kconfig
> +++ b/fs/Kconfig
> @@ -174,6 +174,12 @@ source "fs/proc/Kconfig"
> source "fs/kernfs/Kconfig"
> source "fs/sysfs/Kconfig"
>
> +config FS_PIDFD
> +	bool "Pseudo filesystem for process file descriptors"
> +	depends on 64BIT

I think it would have been good if this dependency would have been
explained in the commit message.  I.e. why does this depend on 64BIT?

What is the risk this will not stay entirely optional?  I.e. can it
become a requirement for modern userspace, and thus be used as a stick
to kill support for 32-bit architectures?

> +	help
> +	  Pidfdfs implements advanced features for process file descriptors.
> +
> config TMPFS
> 	bool "Tmpfs virtual memory file system support (former shm fs)"
> 	depends on SHMEM

Gr{oetje,eeting}s,

 						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
 							    -- Linus Torvalds

