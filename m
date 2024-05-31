Return-Path: <linux-fsdevel+bounces-20637-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A4A338D64DB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 May 2024 16:51:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C80BA1C24CD4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 May 2024 14:51:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D76F361FC4;
	Fri, 31 May 2024 14:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b7ZHKBoq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40FDD59147
	for <linux-fsdevel@vger.kernel.org>; Fri, 31 May 2024 14:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717167022; cv=none; b=qhS0A323FCegdYKbAUI0Fb4MlbWlYmkjWffFdT9TA+bdyAJZRhAkZskqAmSGfzYwss2r2/egm7EGR9PwSEw/uqcbMbtPQ277XEwJiG6oPVW7UBpj5MYsQyezAY/2wPY6PZwbTkAzvpB7B/67FNqGUrjB0hiP2y3D7afSbe/25ck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717167022; c=relaxed/simple;
	bh=wCG0Kk12+8rPEl7wBJxrScV+Pl8bYtwHrLKLSj44qW0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hGnnpKn7zv4PcEZAsOHgrUvmzhDVbq3pvWNDIg1OZVWIVoHR5bI7bJTTRGLLKAepHb5ZmAgJxC2Q63fYJ4HCFcl396+xxXVMI+Rhus1VKEmzddkSnsCbAeX63KFqzdTC76qF7cjAbrAtkP/aNVhe5XSZwAgdzMrBiMvnvYr6ats=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b7ZHKBoq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 715FDC116B1;
	Fri, 31 May 2024 14:50:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717167021;
	bh=wCG0Kk12+8rPEl7wBJxrScV+Pl8bYtwHrLKLSj44qW0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=b7ZHKBoqoXXCQ8/i61s374ZLJResmIYk0Vw3FKsgmka5WXLmZ41+Ko3jZLd8Gpe1N
	 WAmC38n8vMEgxbLUPzIPreNsbbSsmPuc6gUqe83TFx3mshv4SfB5Qnf9GeO7WLU+nC
	 qOVTbdgfrPek2GsUKyBkz2C230Ab3qsUNGHFAA5a0tMz5dMfCsM5ltMMmls8zlymhK
	 EiOo0UvtWUKEl/8UYRndkzDTEGAFpa6Bm2BxGYUyx/oV+IqHVswjaK1eLevo6kbRY3
	 fPwol/Jf3JKdvSvMmWbqXthl+IX84fthgDUkRGOxnU1cOjYebwc6YTCjAssHMc2UG6
	 boymRQtWDCUow==
Date: Fri, 31 May 2024 16:50:16 +0200
From: Christian Brauner <brauner@kernel.org>
To: Amir Goldstein <amir73il@gmail.com>, 
	Linus Torvalds <torvalds@linux-foundation.org>
Cc: Josef Bacik <josef@toxicpanda.com>, linux-fsdevel@vger.kernel.org, 
	viro@zeniv.linux.org.uk, jack@suse.cz, david@fromorbit.com, hch@lst.de, 
	Mimi Zohar <zohar@linux.ibm.com>
Subject: Re: [PATCH][RFC] fs: add levels to inode write access
Message-ID: <20240531-weltoffen-drohnen-413f15b646cb@brauner>
References: <72fc22ebeaf50fabf9d14f90f6f694f88b5fc359.1717015144.git.josef@toxicpanda.com>
 <20240530-atheismus-festland-c11c1d3b7671@brauner>
 <CAHk-=wg_rw5jNAQ3HUH8FeMvRDFKRGGiyKJ-QCZF7d+EdNenfQ@mail.gmail.com>
 <20240531-ausdiskutiert-wortgefecht-f90dca685f8c@brauner>
 <20240531-beheben-panzerglas-5ba2472a3330@brauner>
 <CAOQ4uxhCkK4H32Y8KQTrg0W3y4wpiiDBAfOs4TPLkRprKgKK3A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxhCkK4H32Y8KQTrg0W3y4wpiiDBAfOs4TPLkRprKgKK3A@mail.gmail.com>

On Fri, May 31, 2024 at 04:09:17PM +0300, Amir Goldstein wrote:
> On Fri, May 31, 2024 at 3:32 PM Christian Brauner <brauner@kernel.org> wrote:
> >
> > On Fri, May 31, 2024 at 12:02:16PM +0200, Christian Brauner wrote:
> > > On Thu, May 30, 2024 at 08:49:12AM -0700, Linus Torvalds wrote:
> > > > On Thu, 30 May 2024 at 03:32, Christian Brauner <brauner@kernel.org> wrote:
> > > > >
> > > > > Ofc depends on whether Linus still agrees that removing this might be
> > > > > something we could try.
> > > >
> > > > I _definitely_ do not want to see any more complex deny_write_access().
> > > >
> > > > So yes, if people have good reasons to override the inode write
> > > > access, I'd rather remove it entirely than make it some eldritch
> > > > horror that is even worse than what we have now.
> > > >
> > > > It would obviously have to be tested in case some odd case actually
> > > > depends on the ETXTBSY semantics, since we *have* supported it for a
> > > > long time.  But iirc nobody even noticed when we removed it from
> > > > shared libraries, so...
> > > >
> > > > That said, verity seems to depend on it as a way to do the
> > > > "enable_verity()" atomically with no concurrent writes, and I see some
> > > > i_writecount noise in the integrity code too.
> 
> This one is a bit more challenging.
> The IMA ima_bprm_check() LSM hook (called from exec_binprm() context)
> may read the file (in ima_collect_measurement()) and record the signature
> of the file to be executed, assuming that it cannot be modified.
> Not sure how to deal with this expectation.

This is very annoying. And it probably doesn't work for dynamic
binaries. 90% of the code will be in libraries to which one can happily
write. Plus there's various attacks to break this:
https://svs.informatik.uni-hamburg.de/publications/2020/2020-08-27-Bohling-IMA.pdf

Anyway, I really really don't want to add more complex
deny_write_access() either. It's hard to understand, it's hard to
document and it punches holes into this anyway. The freezing levels are
annoying enough already.

So then I propose we just make the deny write stuff during exec
conditional on IMA being active. At the end it's small- vs chicken pox.

(I figure it won't be enough for IMA to read the executable after it has
been mapped MS_PRIVATE?)

> Only thing I could think of is that IMA would be allowed to
> deny_write_access() and set FMODE_EXEC_DENY_WRITE
> as a hint for do_close_execat() to allow_write_access(), but
> it's pretty ugly, I admit.
> 
> > > >
> > > > But maybe that's just a belt-and-suspenders thing?
> > > >
> > > > Because if execve() no longer does it, I think we should just remove
> > > > that i_writecount thing entirely.
> > >
> > > deny_write_access() is being used from kernel_read_file() which has a
> > > few wrappers around it and they are used in various places:
> > >
> > > (1) kernel_read_file() based helpers:
> > >   (1.1) kernel_read_file_from_path()
> > >   (1.2) kernel_read_file_from_path_initns()
> > >   (1.3) kernel_read_file_from_fd()
> > >
> > > (2) kernel_read_file() users:
> > >     (2.1) kernel/module/main.c:init_module_from_file()
> > >     (2.2) security/loadpin/loadpin.c:read_trusted_verity_root_digests()
> > >
> > > (3) kernel_read_file_from_path() users:
> > >     (3.1) security/integrity/digsig.c:integrity_load_x509()
> > >     (3.2) security/integrity/ima/ima_fs.c:ima_read_busy()
> > >
> > > (4) kernel_read_file_from_path_initns() users:
> > >     (4.1) drivers/base/firmware_loader/main.c:fw_get_filesystem_firmware()
> > >
> > > (5) kernel_read_file_from_fd() users:
> > >     (5.1) kernel/kexec_file.c:kimage_file_prepare_segments()
> > >
> > > In order to remove i_writecount completely we would need to do this in
> >
> > Sorry, typo s/i_write_count/deny_write_access()/g
> > (I don't think we can remove i_writecount itself as it's used for file
> > leases and locks.)
> 
> Indeed, i_writecount (as does i_readcount) is used by fs/locks.c:
> check_conflicting_open(), but not as a synchronization primitive.
> 
> >
> > > multiple steps as some of that stuff seems potentially sensitive.
> > >
> > > The exec deny write mechanism can be removed because we have a decent
> > > understanding of the implications and there's decent justification for
> > > removing it.
> > >
> > > So I propose that I do various testing (LTP) etc. now, send the patch
> > > and then put this into -next to see if anything breaks?
> 
> Wouldn't hurt to see what else we are missing.
> 
> Thanks,
> Amir.

