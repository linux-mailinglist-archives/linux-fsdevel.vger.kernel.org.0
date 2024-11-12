Return-Path: <linux-fsdevel+bounces-34419-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE1869C5241
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Nov 2024 10:42:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69D582826F6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Nov 2024 09:42:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDB4F20E026;
	Tue, 12 Nov 2024 09:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OlxQ5vyn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54DC020D4F4;
	Tue, 12 Nov 2024 09:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731404528; cv=none; b=ekYq6uRPoOT366rJvfGutfk+vcIAw27Nf+b2GUAWYu9YH9bof6NHAXLZDXGBailRe3yxyJWqgoHp+HtA5jfpWQcQzhKLsVgczXhYkpgQIZG7CslqjOfkvfI0YJkaZSEwBmMUNeIfLlimKgfs/+FStj1hal0Yz1d0JK22+b1DydU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731404528; c=relaxed/simple;
	bh=Zdm0ZFsz1QDD9ewH8lNkrlGMRhqE2Mfq+pNsouDTEMs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nSOcUQqP3A68NNr7kU/SsCEy7J3ZJ0XYuzrXNa6DGVXRdbIcG1wk3Aon9eRLVoB6Tjaio9hEEZ1bbFrZ5vBD8Apiqz9Liypc7hW6e7nrPE1jL2avCUeSYeKxcEdobc6/pUb1Ct66W/suUPX20S34811Fg9bGVezL5JuoonZCNq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OlxQ5vyn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58354C4CECD;
	Tue, 12 Nov 2024 09:42:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731404527;
	bh=Zdm0ZFsz1QDD9ewH8lNkrlGMRhqE2Mfq+pNsouDTEMs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OlxQ5vyn15uxfFSBHSFYs1sD0zKcvDQCPBjaT6ee4NRWmYiCCxbKW2S8PZ/I815dq
	 NbmzS1F+hNdJlh6X2fDZRd+Hb0dm2++tn6Kfsw3QDWKJK4u2wWqZRpkHneKPw9urxQ
	 s2WILodJ4v8bIFVPC6ZQQUcEh2PUMJzkfTraNCDA0iKG4bq25/dCnMolB9OSwNc/33
	 BRGMQDEC8mnoewBOF/mip5vLyxDv0XTEavgdbwkEKWmgOOYHeQb1L9DGHRRHEvvxai
	 F5qRT+mk7gpS6EG26DvepGQFzNeAmEiWRjcBfOouWSGgRK0vpowrYr+tUpK+3AOioD
	 TK8wo7QaUogAA==
Date: Tue, 12 Nov 2024 10:42:02 +0100
From: Christian Brauner <brauner@kernel.org>
To: Jeff Layton <jlayton@kernel.org>
Cc: Karel Zak <kzak@redhat.com>, Miklos Szeredi <miklos@szeredi.hu>, 
	Ian Kent <raven@themaw.net>, Josef Bacik <josef@toxicpanda.com>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>
Subject: Re: [PATCH v3 0/2] fs: allow statmount to fetch the subtype and
 devname
Message-ID: <20241112-vielzahl-grasen-51280e378f23@brauner>
References: <20241107-statmount-v3-0-da5b9744c121@kernel.org>
 <20241111-ruhezeit-renovieren-d78a10af973f@brauner>
 <5418c22b64ac0d8d469d8f9725f1b7685e8daa1b.camel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5418c22b64ac0d8d469d8f9725f1b7685e8daa1b.camel@kernel.org>

On Mon, Nov 11, 2024 at 08:42:26AM -0500, Jeff Layton wrote:
> On Mon, 2024-11-11 at 10:17 +0100, Christian Brauner wrote:
> > On Thu, 07 Nov 2024 16:00:05 -0500, Jeff Layton wrote:
> > > Meta has some internal logging that scrapes /proc/self/mountinfo today.
> > > I'd like to convert it to use listmount()/statmount(), so we can do a
> > > better job of monitoring with containers. We're missing some fields
> > > though. This patchset adds them.
> > > 
> > > 
> > 
> > I know Karel has been wanting this for libmount as well. Thanks for
> > doing this! It would be nice if you could also add some selftests!
> > 
> 
> (cc'ing Karel)
> 
> Thanks. We may need to tweak this a bit, based on Miklos' comments
> about how empty strings are handled now, but it shouldn't be too big a
> change.
> 
> I actually have a related question about libmount: glibc doesn't
> currently provide syscall wrappers for statmount() and listmount().

I think it'll be a bit until glibc exposes those system calls because I
think they are special-purpose in a lot of ways. But also because glibc
usually takes a while to add new system call wrappers.

> Would it make sense to have libmount provide those? We could copy the

I think libmount may not necessarily provide direct syscall wrappers but
will expose new api functionality. This is at least what I gather from
all the discussions on util-linux.

> wrappers in tools/testing/selftests/filesystems/statmount/statmount.h
> to libmount.h.
> 
> It's error-prone and a pain to roll these yourself, and that would make

As with most system calls.

> things simpler until someone is ready to do something for glibc.
> 
> Another idea might be to start a new userland header file that is just
> a collection of static inline wrappers for syscalls that aren't
> packaged in glibc.e.g.  pidfd_open also doesn't have glibc bindings, so
> we could add that there too.

Oh? What glibc version are you on? pidfd_open() et al should all have
glibc wrappers afaik. It just always takes a while:

        > cat /usr/include/x86_64-linux-gnu/sys/pidfd.h | grep pidfd
        extern int pidfd_open (__pid_t __pid, unsigned int __flags) __THROW;
        extern int pidfd_getfd (int __pidfd, int __targetfd,
        extern int pidfd_send_signal (int __pidfd, int __sig, siginfo_t *__info,
        extern pid_t pidfd_getpid (int __fd) __THROW;

