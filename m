Return-Path: <linux-fsdevel+bounces-24231-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BA55D93BE0D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jul 2024 10:38:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D76A1F21FC8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jul 2024 08:38:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EA9B183091;
	Thu, 25 Jul 2024 08:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tJQaBSa+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC30317838C
	for <linux-fsdevel@vger.kernel.org>; Thu, 25 Jul 2024 08:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721896704; cv=none; b=a5JlxHUzHaJpafPnzwjXsGCarG1wop0gg3Q068IACgtc2t7b0v4Bvv2T1n70zJebufD9TQVzWOtXNATBHCpVY5bkyrZpqv4yWkwOdLoh9qrJ8CA7SUnHmx9uj9K1dV6jx8tBPnS9e1KEikm+Pko+lpeIIpPAVdFtOW9Yfc2LWnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721896704; c=relaxed/simple;
	bh=MEjzXTBa3OAQt5nntDBMXY+4IOgdpRZPq7aja33wcaU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pvi5v1BicHC4orTAzReF+zyDgJWiT6OfaTTc0+VKk6BNC/kL2eFrN4AVfqscW7IHnVOaxr6UU4vJoKLbhkPzGDCmiDV7/XuWIfJiYN3uDBb9yK3eFE+PPpID+4poz9wAa6Mx+w0hCZesnBv8cZbs5xkxHPdbUAS3+hfnkmj1O4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tJQaBSa+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABBEEC116B1;
	Thu, 25 Jul 2024 08:38:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721896704;
	bh=MEjzXTBa3OAQt5nntDBMXY+4IOgdpRZPq7aja33wcaU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tJQaBSa+/xHssFfgCJwUjtbMUqka7MXeknExoNOA+7lR2DSDW3dOekzr+I3V1bDrZ
	 fkS/T/Za065ukX2n9V1YhgdYvpPCONmCDP5AVQZbhpTT7Vqleg4PKhoJU2qrmhBDBe
	 BYxX4yKNDUMbc8PoYvL/IjAfj8QGHVCnrZh86QDi6CHXSV1rpB1pIA16P1NXprdlkH
	 ughRHRu3Y4evqN8NHhaf/fpDfY20vYHXhluJbylRMJytUmW2QSIfM+RpIruN2+PIwn
	 KgFLx/j7OMfEcYQLwVBp8SmoGymYJCkIUGGZv4LzZRQklnL2x8+Uuxtv2iPzyFHkYG
	 QP6qsRnBZOxpQ==
Date: Thu, 25 Jul 2024 10:38:19 +0200
From: Christian Brauner <brauner@kernel.org>
To: Jeff Layton <jlayton@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
	linux-fsdevel@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>, Jann Horn <jannh@google.com>, 
	Jan Kara <jack@suse.com>, Daan De Meyer <daan.j.demeyer@gmail.com>
Subject: Re: [PATCH RFC 1/2] fcntl: add F_CREATED
Message-ID: <20240725-mimik-herrichten-c51d721324bc@brauner>
References: <20240724-work-fcntl-v1-0-e8153a2f1991@kernel.org>
 <20240724-work-fcntl-v1-1-e8153a2f1991@kernel.org>
 <41f1e62a9b54b79688d15e66499eef02075aeb2e.camel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <41f1e62a9b54b79688d15e66499eef02075aeb2e.camel@kernel.org>

On Wed, Jul 24, 2024 at 09:56:09AM GMT, Jeff Layton wrote:
> On Wed, 2024-07-24 at 15:15 +0200, Christian Brauner wrote:
> > Systemd has a helper called openat_report_new() that returns whether a
> > file was created anew or it already existed before for cases where
> > O_CREAT has to be used without O_EXCL (cf. [1]). That apparently isn't
> > something that's specific to systemd but it's where I noticed it.
> > 
> > The current logic is that it first attempts to open the file without
> > O_CREAT | O_EXCL and if it gets ENOENT the helper tries again with both
> > flags. If that succeeds all is well. If it now reports EEXIST it
> > retries.
> > 
> > That works fairly well but some corner cases make this more involved. If
> > this operates on a dangling symlink the first openat() without O_CREAT |
> > O_EXCL will return ENOENT but the second openat() with O_CREAT | O_EXCL
> > will fail with EEXIST. The reason is that openat() without O_CREAT |
> > O_EXCL follows the symlink while O_CREAT | O_EXCL doesn't for security
> > reasons. So it's not something we can really change unless we add an
> > explicit opt-in via O_FOLLOW which seems really ugly.
> > 
> > The caller could try and use fanotify() to register to listen for
> > creation events in the directory before calling openat(). The caller
> > could then compare the returned tid to its own tid to ensure that even
> > in threaded environments it actually created the file. That might work
> > but is a lot of work for something that should be fairly simple and I'm
> > uncertain about it's reliability.
> > 
> > The caller could use a bpf lsm hook to hook into security_file_open() to
> > figure out whether they created the file. That also seems a bit wild.
> > 
> > So let's add F_CREATED which allows the caller to check whether they
> > actually did create the file. That has caveats of course but I don't
> > think they are problematic:
> > 
> > * In multi-threaded environments a thread can only be sure that it did
> >   create the file if it calls openat() with O_CREAT. In other words,
> >   it's obviously not enough to just go through it's fdtable and check
> >   these fds because another thread could've created the file.
> > 
> 
> Not exactly. FMODE_CREATED is set in the file description. In principle
> a userland program should know which thread actually did the the open()
> that results in each fd. This new interface tells us which fd's open
> actually resulted in the file being created (which is good).
> 
> In any case, I don't see this as a problem. The interface does what it
> says on the tin.
> 
> > * If there's any codepaths where an openat() with O_CREAT would yield
> >   the same struct file as that of another thread it would obviously
> >   cause wrong results. I'm not aware of any such codepaths from openat()
> >   itself. Imho, that would be a bug.
> > 
> 
> Definitely a bug. That said, this will have interesting interactions
> with dup that may need to be documented. IOW, if you dup a file with
> FMODE_CREATED, then the new fd will also report that F_CREATED is true.

Yes, but it's the behavior one expects. Dup'ing an fd implies fd1->file
== fd2->file and so it's correct behavior. IOW, someone must confuse
open() with dup() to be surprised by this.

