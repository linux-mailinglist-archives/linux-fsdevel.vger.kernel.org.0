Return-Path: <linux-fsdevel+bounces-64924-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 416C3BF6AC9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Oct 2025 15:10:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C1675601BC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Oct 2025 13:06:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8A63334371;
	Tue, 21 Oct 2025 13:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TmVm6iiF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CAE82F49E3;
	Tue, 21 Oct 2025 13:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761051946; cv=none; b=f88tqZV8ZzDQATP139FGexUBFz4mdzWYL+YvnzHhspRfzwhxLiSl+syqI7y6QbLKlMeVPHAU43UQRvS9Unuts2iDCjQ2bgvxwliuuX2xhMv6JBHpnQeJmiOj2vF7d0L/vmkBljKm7Pn79uYh7k4sTE4hApFdbR+NSDrZZvfHqhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761051946; c=relaxed/simple;
	bh=2j2nO3EgyZKblgDRpc+2rhG8AcAKEEabgVHZG2MOf3o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q7dpufJTOk4UOWTY2JF2WS2za+Mh87kBTMnXb/ng9fcTVz81Tuyxt6hPfywLLIOKAtbjg8y9hqZXGO4Whqhnos70l2YXJgK68cuLvEjwFsjySwkHgzFbwuvIVvw66Je8S2fStuBjdqGEM3lB8gjZS9wGxgC/gZGsVxzsesHTveo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TmVm6iiF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FDC7C4CEF1;
	Tue, 21 Oct 2025 13:05:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761051945;
	bh=2j2nO3EgyZKblgDRpc+2rhG8AcAKEEabgVHZG2MOf3o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TmVm6iiFaz6anEm3kd0My8ZIfUCldrigV+ZcegItWYdxZrA9XcebcFYT1MscZ+Bfk
	 VEdyNailQh9YtaHUbFy98sCS778OwbHwgxhCuVIyUlL+RnCqrZV+wlUXkxus8vkmmH
	 wTfZRmnd8ZoxO8NFhXD2KkWxbPWgLkHE43O/4dn2DzKF/G6XO5nLBrRIOLmsOs063A
	 aVdE8UKPA/mxr3ZwMDkZNOeVf35jw4VyuWcbrzlcnDe5R/JkHHiQSUHe90cjFoE6KX
	 A+IPfDmrVlX+aH3+RJDyQNAHVobVFUrcgzbB98Z/822kUNM/+WUfAraNn3ZSsrvcz2
	 tJXHoYFb+417g==
Date: Tue, 21 Oct 2025 15:05:35 +0200
From: Christian Brauner <brauner@kernel.org>
To: Askar Safin <safinaskar@gmail.com>, 
	Christoph Hellwig <hch@infradead.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Linus Torvalds <torvalds@linux-foundation.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>, 
	Jens Axboe <axboe@kernel.dk>, Andy Shevchenko <andy.shevchenko@gmail.com>, 
	Aleksa Sarai <cyphar@cyphar.com>, 
	Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>, Julian Stecklina <julian.stecklina@cyberus-technology.de>, 
	Gao Xiang <hsiangkao@linux.alibaba.com>, Art Nikpal <email2tema@gmail.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Alexander Graf <graf@amazon.com>, Rob Landley <rob@landley.net>, 
	Lennart Poettering <mzxreary@0pointer.de>, linux-arch@vger.kernel.org, linux-block@vger.kernel.org, 
	initramfs@vger.kernel.org, linux-api@vger.kernel.org, linux-doc@vger.kernel.org, 
	Michal Simek <monstr@monstr.eu>, Luis Chamberlain <mcgrof@kernel.org>, 
	Kees Cook <kees@kernel.org>, Thorsten Blum <thorsten.blum@linux.dev>, 
	Heiko Carstens <hca@linux.ibm.com>, Arnd Bergmann <arnd@arndb.de>, Dave Young <dyoung@redhat.com>, 
	Christophe Leroy <christophe.leroy@csgroup.eu>, Krzysztof Kozlowski <krzk@kernel.org>, 
	Borislav Petkov <bp@alien8.de>, Jessica Clarke <jrtc27@jrtc27.com>, 
	Nicolas Schichan <nschichan@freebox.fr>, David Disseldorp <ddiss@suse.de>, patches@lists.linux.dev
Subject: Re: [PATCH v3 0/3] initrd: remove half of classic initrd support
Message-ID: <20251021-bannmeile-arkaden-ae2ea9264b85@brauner>
References: <20251017060956.1151347-1-safinaskar@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251017060956.1151347-1-safinaskar@gmail.com>

On Fri, Oct 17, 2025 at 06:09:53AM +0000, Askar Safin wrote:
> Intro
> ====
> This patchset removes half of classic initrd (initial RAM disk) support,
> i. e. linuxrc code path, which was deprecated in 2020.
> Initramfs still stays, RAM disk itself (brd) still stays.
> And other half of initrd stays, too.
> init/do_mounts* are listed in VFS entry in
> MAINTAINERS, so I think this patchset should go through VFS tree.
> I tested the patchset on 8 (!!!) archs in Qemu (see details below).
> If you still use initrd, see below for workaround.
> 
> In 2020 deprecation notice was put to linuxrc initrd code path.
> In v1 I tried to remove initrd
> fully, but Nicolas Schichan reported that he still uses
> other code path (root=/dev/ram0 one) on million devices [4].
> root=/dev/ram0 code path did not contain deprecation notice.

Without Acks or buy-in from other maintainers this is not a change we
can just do given that a few people already piped up and expressed
reservations that this would be doable for them.

@Christoph, you marked this as deprecated years ago.
What's your take on this?

> 
> So, in this version of patchset I remove deprecated code path,
> i. e. linuxrc one, while keeping other, i. e. root=/dev/ram0 one.
> 
> Also I put deprecation notice to remaining code path, i. e. to
> root=/dev/ram0 one. I plan to send patches for full removal
> of initrd after one year, i. e. in September 2026 (of course,
> initramfs will still work).
> 
> Also, I tried to make this patchset small to make sure it
> can be reverted easily. I plan to send cleanups later.
> 
> Details
> ====
> Other user-visible changes:
> 
> - Removed kernel command line parameters "load_ramdisk" and
> "prompt_ramdisk", which did nothing and were deprecated
> - Removed /proc/sys/kernel/real-root-dev . It was used
> for initrd only
> - Command line parameters "noinitrd" and "ramdisk_start=" are deprecated
> 
> This patchset is based on v6.18-rc1.
> 
> Testing
> ====
> I tested my patchset on many architectures in Qemu using my Rust
> program, heavily based on mkroot [1].
> 
> I used the following cross-compilers:
> 
> aarch64-linux-musleabi
> armv4l-linux-musleabihf
> armv5l-linux-musleabihf
> armv7l-linux-musleabihf
> i486-linux-musl
> i686-linux-musl
> mips-linux-musl
> mips64-linux-musl
> mipsel-linux-musl
> powerpc-linux-musl
> powerpc64-linux-musl
> powerpc64le-linux-musl
> riscv32-linux-musl
> riscv64-linux-musl
> s390x-linux-musl
> sh4-linux-musl
> sh4eb-linux-musl
> x86_64-linux-musl
> 
> taken from this directory [2].
> 
> So, as you can see, there are 18 triplets, which correspond to 8 subdirs in arch/.
> 
> For every triplet I tested that:
> - Initramfs still works (both builtin and external)
> - Direct boot from disk still works
> - Remaining initrd code path (root=/dev/ram0) still works
> 
> Workaround
> ====
> If "retain_initrd" is passed to kernel, then initramfs/initrd,
> passed by bootloader, is retained and becomes available after boot
> as read-only magic file /sys/firmware/initrd [3].
> 
> No copies are involved. I. e. /sys/firmware/initrd is simply
> a reference to original blob passed by bootloader.
> 
> This works even if initrd/initramfs is not recognized by kernel
> in any way, i. e. even if it is not valid cpio archive, nor
> a fs image supported by classic initrd.
> 
> This works both with my patchset and without it.
> 
> This means that you can emulate classic initrd so:
> link builtin initramfs to kernel; in /init in this initramfs
> copy /sys/firmware/initrd to some file in / and loop-mount it.
> 
> This is even better than classic initrd, because:
> - You can use fs not supported by classic initrd, for example erofs
> - One copy is involved (from /sys/firmware/initrd to some file in /)
> as opposed to two when using classic initrd
> 
> Still, I don't recommend using this workaround, because
> I want everyone to migrate to proper modern initramfs.
> But still you can use this workaround if you want.
> 
> Also: it is not possible to directly loop-mount
> /sys/firmware/initrd . Theoretically kernel can be changed
> to allow this (and/or to make it writable), but I think nobody needs this.
> And I don't want to implement this.
> 
> On Qemu's -initrd and GRUB's initrd
> ====
> Don't panic, this patchset doesn't remove initramfs
> (which is used by nearly all Linux distros). And I don't
> have plans to remove it.
> 
> Qemu's -initrd option and GRUB's initrd command refer
> to initrd bootloader mechanism, which is used to
> load both initrd and (external) initramfs.
> 
> So, if you use Qemu's -initrd or GRUB's initrd,
> then you likely use them to pass initramfs, and thus
> you are safe.
> 
> v1: https://lore.kernel.org/lkml/20250913003842.41944-1-safinaskar@gmail.com/
> 
> v1 -> v2 changes:
> - A lot. I removed most patches, see cover letter for details
> 
> v2: https://lore.kernel.org/lkml/20251010094047.3111495-1-safinaskar@gmail.com/
> 
> v2 -> v3 changes:
> - Commit messages
> - Expanded docs for "noinitrd"
> - Added link to /sys/firmware/initrd workaround to pr_warn
> 
> [1] https://github.com/landley/toybox/tree/master/mkroot
> [2] https://landley.net/toybox/downloads/binaries/toolchains/latest
> [3] https://lore.kernel.org/all/20231207235654.16622-1-graf@amazon.com/
> [4] https://lore.kernel.org/lkml/20250918152830.438554-1-nschichan@freebox.fr/
> 
> Askar Safin (3):
>   init: remove deprecated "load_ramdisk" and "prompt_ramdisk" command
>     line parameters
>   initrd: remove deprecated code path (linuxrc)
>   init: remove /proc/sys/kernel/real-root-dev
> 
>  .../admin-guide/kernel-parameters.txt         |  12 +-
>  Documentation/admin-guide/sysctl/kernel.rst   |   6 -
>  arch/arm/configs/neponset_defconfig           |   2 +-
>  fs/init.c                                     |  14 ---
>  include/linux/init_syscalls.h                 |   1 -
>  include/linux/initrd.h                        |   2 -
>  include/uapi/linux/sysctl.h                   |   1 -
>  init/do_mounts.c                              |  11 +-
>  init/do_mounts.h                              |  18 +--
>  init/do_mounts_initrd.c                       | 107 ++----------------
>  init/do_mounts_rd.c                           |  24 +---
>  11 files changed, 23 insertions(+), 175 deletions(-)
> 
> 
> base-commit: 3a8660878839faadb4f1a6dd72c3179c1df56787
> -- 
> 2.47.3
> 

