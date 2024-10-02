Return-Path: <linux-fsdevel+bounces-30708-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DA4198DC69
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Oct 2024 16:41:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0FD2C1F26DD5
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Oct 2024 14:41:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 045D61D2202;
	Wed,  2 Oct 2024 14:34:47 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from kawka3.in.waw.pl (kawka3.in.waw.pl [68.183.222.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 143C91D0E0B;
	Wed,  2 Oct 2024 14:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.183.222.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727879686; cv=none; b=N+Sv2cWAxDXnMMU8mjFtX3+395R7mOHugkM38CKM5v72xQrPr4Uy+mh5bGkXbqutUiCmhF5NVCwLjJhd9kG9SgHFlETHpHjywfZXtTQs3Si6H/dkct+CsYAuB5v6vhEIHifJU/eIH/oIJXjniQc9duq3aTdMuUzSrQr8KqGk3o0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727879686; c=relaxed/simple;
	bh=ZxMR1giUq/l/tOnJ7G/X+j2Gz5nZGDwTDKjK/KYw0eo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j40n/E5qUVDQaNw2a6yDeBXidw9rfbAUcVERC76IYPqbTGz2bdHSM0ZaGSpMw/vzHWvUbRa1we3fUaTihYHDiynybbVgwy9z0niAP+LkwFNwBqH98bfcRkA0cK2FBgXh2Zw/uj03st2LlZGthl6T04MiW+nPvsQFoMfAZOHkSHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=in.waw.pl; spf=pass smtp.mailfrom=in.waw.pl; arc=none smtp.client-ip=68.183.222.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=in.waw.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=in.waw.pl
Received: by kawka3.in.waw.pl (Postfix, from userid 1000)
	id 1FF5E550DB2; Wed,  2 Oct 2024 14:34:43 +0000 (UTC)
Date: Wed, 2 Oct 2024 14:34:43 +0000
From: Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Tycho Andersen <tycho@tycho.pizza>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Kees Cook <kees@kernel.org>, Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Alexander Aring <alex.aring@gmail.com>,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Tycho Andersen <tandersen@netflix.com>,
	Aleksa Sarai <cyphar@cyphar.com>
Subject: Re: [RFC] exec: add a flag for "reasonable" execveat() comm
Message-ID: <Zv1aA4I6r4py-8yW@kawka3.in.waw.pl>
References: <20240924141001.116584-1-tycho@tycho.pizza>
 <87msjx9ciw.fsf@email.froward.int.ebiederm.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87msjx9ciw.fsf@email.froward.int.ebiederm.org>

On Tue, Sep 24, 2024 at 12:39:35PM -0500, Eric W. Biederman wrote:
> Tycho Andersen <tycho@tycho.pizza> writes:
> 
> > From: Tycho Andersen <tandersen@netflix.com>
> >
> > Zbigniew mentioned at Linux Plumber's that systemd is interested in
> > switching to execveat() for service execution, but can't, because the
> > contents of /proc/pid/comm are the file descriptor which was used,
> > instead of the path to the binary. This makes the output of tools like
> > top and ps useless, especially in a world where most fds are opened
> > CLOEXEC so the number is truly meaningless.
> >
> > This patch adds an AT_ flag to fix up /proc/pid/comm to instead be the
> > contents of argv[0], instead of the fdno.

I tried this version (with a local modification to drop the flag and
enable the new codepath if get_user_arg_ptr(argv, 0) returns nonnull
as suggested later in the thread), and it seems to work as expected.
In particular, 'pgrep' finds for the original name in case of
symlinks.

> All of that said I am not a fan of the implementation below as it has
> the side effect of replacing /dev/fd/N with a filename that is not
> usable by #! interpreters.  So I suggest an implementation that affects
> task->comm and not brpm->filename.

Hmm, I don't understand this. /dev/fd/ would not generally contain an
open fd for the original binary. It only would if the caller uses
fexecve with an fd opened without O_CLOEXEC, but then it'd be
something like /dev/fd/3 or /dev/fd/4 and the callee would be confused
by having an extra fd, so except for some specialed cases, the caller
should always use O_CLOEXEC.

With this patch:
$ sudo ln -sv /bin/sleep /usr/local/bin/sleep-link
$ sudo systemd-run sleep-link 10000

$ sudo strace -f -e execve,execveat -p 1
...
[pid  1200] execve("/proc/self/fd/9", ["/usr/lib/systemd/systemd-executo"..., "--deserialize", "150", "--log-level", "info", "--log-target", "journal-or-kmsg"], 0x7ffe97b98178 /* 3 vars */) = 0
[pid  1200] execveat(4, "", ["/usr/local/bin/sleep-link", "10000"], 0xd8edf70 /* 9 vars */, AT_EMPTY_PATH) = 0
^C

$ pgrep sleep-link
1200

$ sudo ls -l /proc/1200/fd
total 0
lr-x------ 1 root root 64 Oct  2 17:13 0 -> /dev/null
lrwx------ 1 root root 64 Oct  2 17:13 1 -> 'socket:[8585]'
lrwx------ 1 root root 64 Oct  2 17:13 2 -> 'socket:[8585]'

$ head -n1 /proc/1200/{comm,status,stat}
==> /proc/1200/comm <==
sleep-link
==> /proc/1200/status <==
Name:   sleep-link
==> /proc/1200/stat <==
1200 (sleep-link) ...

This all looks good.

Zbyszek

