Return-Path: <linux-fsdevel+bounces-21937-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BD9E890F7AE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Jun 2024 22:41:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D68341C2140F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Jun 2024 20:41:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B527415A845;
	Wed, 19 Jun 2024 20:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VI8SD32Z"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 117151591F3;
	Wed, 19 Jun 2024 20:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718829677; cv=none; b=pkFx8TlA6ctYCa2c4u99mwx0nWr8MD6nJT/F7csiBXr8/8qi3PTqyaM41g5THk8hzTg1yiHUNCOSZ1k6qhyw2be6w/Zc+htmYijLC722US0u/cekkaruGbYwNmFJqHV2J2bQHkHyHvz2EjzA9ZWGF5DcM/uEBtUmeRam7SCd6DE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718829677; c=relaxed/simple;
	bh=hsAftkLN4fxN7Bc95o8vyB/YDSgQFr59/CdyR9siv4Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eC5Xkk4hEBqPINvD2oMmafksS2A0WILKk4fgbI4eDUGe9FpLmkZNfVZvVzAV0nL3SZX2EKuc2n9IrY8KXzfrelbxf6sdG5uPs1MTp2mhX1p1UZurgOqEJH4RAuvgbq8+ADsKPdUn4++UxwuW/FJ19jXo4wAlEeuDB/XYgYde94s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VI8SD32Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E03BBC2BBFC;
	Wed, 19 Jun 2024 20:41:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718829676;
	bh=hsAftkLN4fxN7Bc95o8vyB/YDSgQFr59/CdyR9siv4Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VI8SD32ZiFz4904GFvpC+tXK1cPzkucpL5JmbdLUes7BdH3JX1lgGFmcOFKwGw8mY
	 6I4txIMw4m981lYGDoMBkEgWBoVnqJZHNbAT4cO54AnTCcRcjTzPDH80ytr71xn6hs
	 JbSdNIyTnKSUaOp7A1wjuncql3f4TGEFbBX1zBDcctCtHRqM8pWbK3dZ6OBcxFA3KH
	 +HkQTEnWK+Dw+ZOghKzWk0o9VmCL0Lmkj1wSMAYKspptbt8G/2TcQ18LleXIntkyM5
	 A9eQJtha7Nprs1iphPWQLq8c/Vcv//SR9gMHK2JATRpKzB8VGI8n/nBty2LJ6lZ0Jt
	 7pF+Q8UPrwOdw==
Date: Wed, 19 Jun 2024 13:41:16 -0700
From: Kees Cook <kees@kernel.org>
To: Jeff Xu <jeffxu@chromium.org>
Cc: Adrian Ratiu <adrian.ratiu@collabora.com>,
	linux-fsdevel@vger.kernel.org,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org, linux-doc@vger.kernel.org,
	kernel@collabora.com, gbiv@google.com, ryanbeltran@google.com,
	inglorion@google.com, ajordanr@google.com, jorgelo@chromium.org,
	Guenter Roeck <groeck@chromium.org>,
	Doug Anderson <dianders@chromium.org>, Jann Horn <jannh@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Christian Brauner <brauner@kernel.org>, Jeff Xu <jeffxu@google.com>,
	Mike Frysinger <vapier@chromium.org>
Subject: Re: [PATCH v6 2/2] proc: restrict /proc/pid/mem
Message-ID: <202406191336.AC7F803123@keescook>
References: <20240613133937.2352724-1-adrian.ratiu@collabora.com>
 <20240613133937.2352724-2-adrian.ratiu@collabora.com>
 <CABi2SkXY20M24fcUgejAMuJpNZqsLxd0g1PZ-8RcvzxO6NO6cA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABi2SkXY20M24fcUgejAMuJpNZqsLxd0g1PZ-8RcvzxO6NO6cA@mail.gmail.com>

On Tue, Jun 18, 2024 at 03:39:44PM -0700, Jeff Xu wrote:
> Hi
> 
> Thanks for the patch !
> 
> On Thu, Jun 13, 2024 at 6:40 AM Adrian Ratiu <adrian.ratiu@collabora.com> wrote:
> >
> > Prior to v2.6.39 write access to /proc/<pid>/mem was restricted,
> > after which it got allowed in commit 198214a7ee50 ("proc: enable
> > writing to /proc/pid/mem"). Famous last words from that patch:
> > "no longer a security hazard". :)
> >
> > Afterwards exploits started causing drama like [1]. The exploits
> > using /proc/*/mem can be rather sophisticated like [2] which
> > installed an arbitrary payload from noexec storage into a running
> > process then exec'd it, which itself could include an ELF loader
> > to run arbitrary code off noexec storage.
> >
> > One of the well-known problems with /proc/*/mem writes is they
> > ignore page permissions via FOLL_FORCE, as opposed to writes via
> > process_vm_writev which respect page permissions. These writes can
> > also be used to bypass mode bits.
> >
> > To harden against these types of attacks, distrbutions might want
> > to restrict /proc/pid/mem accesses, either entirely or partially,
> > for eg. to restrict FOLL_FORCE usage.
> >
> > Known valid use-cases which still need these accesses are:
> >
> > * Debuggers which also have ptrace permissions, so they can access
> > memory anyway via PTRACE_POKEDATA & co. Some debuggers like GDB
> > are designed to write /proc/pid/mem for basic functionality.
> >
> > * Container supervisors using the seccomp notifier to intercept
> > syscalls and rewrite memory of calling processes by passing
> > around /proc/pid/mem file descriptors.
> >
> > There might be more, that's why these params default to disabled.
> >
> > Regarding other mechanisms which can block these accesses:
> >
> > * seccomp filters can be used to block mmap/mprotect calls with W|X
> > perms, but they often can't block open calls as daemons want to
> > read/write their runtime state and seccomp filters cannot check
> > file paths, so plain write calls can't be easily blocked.
> >
> > * Since the mem file is part of the dynamic /proc/<pid>/ space, we
> > can't run chmod once at boot to restrict it (and trying to react
> > to every process and run chmod doesn't scale, and the kernel no
> > longer allows chmod on any of these paths).
> >
> > * SELinux could be used with a rule to cover all /proc/*/mem files,
> > but even then having multiple ways to deny an attack is useful in
> > case one layer fails.
> >
> > Thus we introduce four kernel parameters to restrict /proc/*/mem
> > access: open-read, open-write, write and foll_force. All these can
> > be independently set to the following values:
> >
> > all     => restrict all access unconditionally.
> > ptracer => restrict all access except for ptracer processes.
> >
> > If left unset, the existing behaviour is preserved, i.e. access
> > is governed by basic file permissions.
> >
> > Examples which can be passed by bootloaders:
> >
> > proc_mem.restrict_foll_force=all
> > proc_mem.restrict_open_write=ptracer
> > proc_mem.restrict_open_read=ptracer
> > proc_mem.restrict_write=all
> >
> > These knobs can also be enabled via Kconfig like for eg:
> >
> > CONFIG_PROC_MEM_RESTRICT_WRITE_PTRACE_DEFAULT=y
> > CONFIG_PROC_MEM_RESTRICT_FOLL_FORCE_PTRACE_DEFAULT=y
> >
> > Each distribution needs to decide what restrictions to apply,
> > depending on its use-cases. Embedded systems might want to do
> > more, while general-purpouse distros might want a more relaxed
> > policy, because for e.g. foll_force=all and write=all both break
> > break GDB, so it might be a bit excessive.
> >
> > Based on an initial patch by Mike Frysinger <vapier@chromium.org>.
> >
> It is noteworthy that ChromeOS has benefited from blocking
> /proc/pid/mem write since 2017 [1], owing to the patch implemented by
> Mike Frysinger.
> 
> It is great that upstream can consider this patch, ChromeOS will use
> the solution once it is accepted.
> 
> > Link: https://lwn.net/Articles/476947/ [1]
> > Link: https://issues.chromium.org/issues/40089045 [2]
> > Cc: Guenter Roeck <groeck@chromium.org>
> > Cc: Doug Anderson <dianders@chromium.org>
> > Cc: Kees Cook <keescook@chromium.org>
> > Cc: Jann Horn <jannh@google.com>
> > Cc: Andrew Morton <akpm@linux-foundation.org>
> > Cc: Randy Dunlap <rdunlap@infradead.org>
> > Cc: Christian Brauner <brauner@kernel.org>
> > Cc: Jeff Xu <jeffxu@google.com>
> > Co-developed-by: Mike Frysinger <vapier@chromium.org>
> > Signed-off-by: Mike Frysinger <vapier@chromium.org>
> > Signed-off-by: Adrian Ratiu <adrian.ratiu@collabora.com>
> 
> Reviewed-by: Jeff Xu <jeffxu@chromium.org>
> Tested-by: Jeff Xu <jeffxu@chromium.org>
> [1] https://chromium-review.googlesource.com/c/chromiumos/third_party/kernel/+/764773

Thanks for the testing! What settings did you use? I think Chrome OS was
effectively doing this?

PROC_MEM_RESTRICT_OPEN_READ_OFF=y
CONFIG_PROC_MEM_RESTRICT_OPEN_WRITE_ALL=y
CONFIG_PROC_MEM_RESTRICT_WRITE_ALL=y
CONFIG_PROC_MEM_RESTRICT_FOLL_FORCE_ALL=y

Though I don't see the FOLL_FORCE changes in the linked Chrome OS patch,
but I suspect it's unreachable with
CONFIG_PROC_MEM_RESTRICT_OPEN_WRITE_ALL=y.

-Kees

-- 
Kees Cook

