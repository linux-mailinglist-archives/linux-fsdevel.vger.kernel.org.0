Return-Path: <linux-fsdevel+bounces-43251-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 371BBA4FE87
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Mar 2025 13:21:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 65E9A162F3E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Mar 2025 12:21:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4468D24418F;
	Wed,  5 Mar 2025 12:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cnf8wWW3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A768D1FCF4F
	for <linux-fsdevel@vger.kernel.org>; Wed,  5 Mar 2025 12:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741177260; cv=none; b=LYtE5vTuC6uFsdUBBE5dbhIXdVuA8wo/9JZoIdPyC1dnXG+8QlGkl1unTNk1IZC/kFOoni8nMhmV7xJNGcUgSrTPw7y0yQKSGKWza1EpJtlpyes2wpp3iESqmwG4LQccCbCUkxdvV9LgOhdt0fTfbXX0p2EPs5oRBo6b8E2yRHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741177260; c=relaxed/simple;
	bh=Ta8JXaZo2rHEMabttfRq6BG9mMKUWcPQD/wHxRfobe8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Cszs5slFStd0Yveti8wleKxh4YavTkcJ7g39FzxCnbTZjQURnWWLDkyZLLUyU609ZyGaDLGpv8D3ZyimY821gks9tfv+0y2zjIZY2ZiBN1Icgu9e+Z0Ik8e/w8URcNubogsqZOG6QuCJAfzQYiLGMFNv39tgTwrH0+imPuN71oI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cnf8wWW3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77DFEC4CEE2;
	Wed,  5 Mar 2025 12:20:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741177260;
	bh=Ta8JXaZo2rHEMabttfRq6BG9mMKUWcPQD/wHxRfobe8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cnf8wWW3Md/619f98HhL2pL3ZE8A6EcX/hLNneRsnjVrtiesJaU7XR9p96rZhAcos
	 HfTvXfAS1QZnht05/QNJxOfJR1dXx8ImtIQ8lMc3dFiaJYUoU83ZiyIAGWpzfMXJ5s
	 fDAabrWCw/36nB9nVJJynSXgVzc8t29P4/i4pYvzPHTpku/33GqCbzgY3S82j9Ora7
	 kgYyG2d7EGR5dX6TFDzjxpeUMNxm4dPrxAWNpNL20+h8N8nYLVUQGpUjvC6+xu90iL
	 V8ZKwSBG1vMoy6FU9IrUx0OsAadvI3dgOmuQJe3hfvfyDBI7gMzSzrSre6WTddCflD
	 XMzp9MNcC4Kig==
Date: Wed, 5 Mar 2025 13:20:56 +0100
From: Christian Brauner <brauner@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>, 
	Lennart Poettering <lennart@poettering.net>, Daan De Meyer <daan.j.demeyer@gmail.com>, 
	Mike Yuan <me@yhndnzj.com>
Subject: Re: [PATCH v3 00/16] pidfs: provide information after task has been
 reaped
Message-ID: <20250305-bekunden-fahrgast-5ed08f1a387b@brauner>
References: <20250305-work-pidfs-kill_on_last_close-v3-0-c8c3d8361705@kernel.org>
 <20250305120622.GA30741@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250305120622.GA30741@redhat.com>

On Wed, Mar 05, 2025 at 01:06:35PM +0100, Oleg Nesterov wrote:
> On 03/05, Christian Brauner wrote:
> >
> > Christian Brauner (16):
> >       pidfs: switch to copy_struct_to_user()
> >       pidfd: rely on automatic cleanup in __pidfd_prepare()
> >       pidfs: move setting flags into pidfs_alloc_file()
> >       pidfs: use private inode slab cache
> >       pidfs: record exit code and cgroupid at exit
> >       pidfs: allow to retrieve exit information
> >       selftests/pidfd: fix header inclusion
> >       pidfs/selftests: ensure correct headers for ioctl handling
> >       selftests/pidfd: expand common pidfd header
> >       selftests/pidfd: add first PIDFD_INFO_EXIT selftest
> >       selftests/pidfd: add second PIDFD_INFO_EXIT selftest
> >       selftests/pidfd: add third PIDFD_INFO_EXIT selftest
> >       selftests/pidfd: add fourth PIDFD_INFO_EXIT selftest
> >       selftests/pidfd: add fifth PIDFD_INFO_EXIT selftest
> >       selftests/pidfd: add sixth PIDFD_INFO_EXIT selftest
> >       selftests/pidfd: add seventh PIDFD_INFO_EXIT selftest
> 
> I see nothing wrong in V3. For 1-6

Fwiw, I'm quite happy with the tests since we now also have test for
multi-threaded exec behavior with pidfd polling.

> 
> Reviewed-by: Oleg Nesterov <oleg@redhat.com>

Thanks for all the help and the Ack!
There'll be more patches this or next cycle though. ;)

