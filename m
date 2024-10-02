Return-Path: <linux-fsdevel+bounces-30697-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6D4198D804
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Oct 2024 15:55:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 052771C22A98
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Oct 2024 13:55:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D502F1D094A;
	Wed,  2 Oct 2024 13:55:16 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from kawka3.in.waw.pl (kawka3.in.waw.pl [68.183.222.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 957BC1D049F;
	Wed,  2 Oct 2024 13:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.183.222.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727877316; cv=none; b=lnV1h9bgvFGuGcsub5rcuQ+MNhU93Jukai9iJbhNN/l39utDg727VrDBa4Wuk/ETWkYS3GclUoKK1JKGn+FF5DgIxUnJ8xEpt6WK8iyyyEn9Rugd8CO9EaiNv94KqHeUTMkYwJQRDea93TO3e35Xf24jMMARjG+Db4PbL1NEP5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727877316; c=relaxed/simple;
	bh=Qcbf2a1R4cpj0sQ2FxJOcM9Ze22LGOFl+wDEdPHLx4Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hDtVUYJJxDuyn5YPrSn+hJvgAkKCI4mdobe9uWLePmyHxis8lldYDFt9O0FWs+bP7ZXimqb3dO4f5RrYIswCGpgWaTENEwsu6o3g3B+Z6OzZIsroXMKdB1UblnGMbhas8ZGhZksE91HI/F2ClWfGdeO/v5hfV+bhpMv07gVG7Io=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=in.waw.pl; spf=pass smtp.mailfrom=in.waw.pl; arc=none smtp.client-ip=68.183.222.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=in.waw.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=in.waw.pl
Received: by kawka3.in.waw.pl (Postfix, from userid 1000)
	id 925A0550CEB; Wed,  2 Oct 2024 13:45:15 +0000 (UTC)
Date: Wed, 2 Oct 2024 13:45:15 +0000
From: Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>
To: Tycho Andersen <tycho@tycho.pizza>
Cc: Aleksa Sarai <cyphar@cyphar.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Eric Biederman <ebiederm@xmission.com>, Kees Cook <kees@kernel.org>,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	Tycho Andersen <tandersen@netflix.com>
Subject: Re: [PATCH v3 1/2] exec: fix up /proc/pid/comm in the
 execveat(AT_EMPTY_PATH) case
Message-ID: <Zv1OayMEmLP2kjhj@kawka3.in.waw.pl>
References: <20241001134945.798662-1-tycho@tycho.pizza>
 <20241001.175124-western.preview.meager.saws-pzvpWxOhfokt@cyphar.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241001.175124-western.preview.meager.saws-pzvpWxOhfokt@cyphar.com>

On Tue, Oct 01, 2024 at 08:42:56PM +0200, Aleksa Sarai wrote:
> On 2024-10-01, Tycho Andersen <tycho@tycho.pizza> wrote:
> > From: Tycho Andersen <tandersen@netflix.com>
> > 
> > Zbigniew mentioned at Linux Plumber's that systemd is interested in
> > switching to execveat() for service execution, but can't, because the
> > contents of /proc/pid/comm are the file descriptor which was used,
> > instead of the path to the binary. This makes the output of tools like
> > top and ps useless, especially in a world where most fds are opened
> > CLOEXEC so the number is truly meaningless.
> > 
> > Change exec path to fix up /proc/pid/comm in the case where we have
> > allocated one of these synthetic paths in bprm_init(). This way the actual
> > exec machinery is unchanged, but cosmetically the comm looks reasonable to
> > admins investigating things.
> 
> While I still think the argv[0] solution was semantically nicer, it
> seems this is enough to fix the systemd problem for most cases and so we
> can revisit the argv[0] discussion in another 10 years. :D

Hi Tycho and everyone else,

First, thank you so much for picking this up!
Second, sorry for being late with a reply…

Third, I tested the kernel with the patch and with systemd with the
fexecve option enabled, and it all works as expected.

Unfortunately, I don't think that the approach with
f_path.dentry->d_name.name can be used :(
As discussed previously, there are various places where symlinks
are used. Alternatives and busybox were raised. Some additional examples:
systemd (e.g. /usr/lib/systemd/systemd-udevd symlinks to /usr/bin/udevadm),
yum-builddep, yum-config-manager, yumdownloader, yum-groups-manager
all symlink to a multicall dnf-utils binary, and so on.

The question is whether "pgrep" and similar tools not getting the
expected name is a problem, and I think that the answer is,
unfortunately, "yes". Users will notice this. As a distro maintainer,
I would be _very_ wary of flipping this on in systemd, because there
certainly are scripts and other tools that use that logic to check if
things are running on the system. systemd uses cgroups and doesn't
care about COMM at all, and I expect that many other modern tools
won't either, but we have to take into account the long tail of local
admin scripts and older tools. To avoid regressions and complaints, we
really want an API that replaces the current execve invocations with
an fd-based approach but doesn't change how things otherwise look.
Arguably, the current patch would work great for 99% of cases, but
that's not enough.

(In particular, with rust being used more often for low level tools,
and the binaries being large because of the static linking, I expect
multicall binaries to become even more common. E.g. uutils-coreutils
that might become the default coreutils implementation in a few years.
It uses a multi-call binary and symlinks. Having 'coreutils' instead
of 'sleep' as COMM is not good.)

Please consider going back to the approach with argv[0].

Zbyszek

> > v2: * drop the flag, everyone :)
> >     * change the rendered value to f_path.dentry->d_name.name instead of
> >       argv[0], Eric

> > +		__set_task_comm(me, bprm->file->f_path.dentry->d_name.name, true);

