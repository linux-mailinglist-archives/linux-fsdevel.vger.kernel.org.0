Return-Path: <linux-fsdevel+bounces-67003-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DAC8C32FE2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 04 Nov 2025 22:00:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EC5314EA90B
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Nov 2025 21:00:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18EC52F28FB;
	Tue,  4 Nov 2025 21:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VB3xdNpR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 502602E92D2;
	Tue,  4 Nov 2025 21:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762290033; cv=none; b=WTcivJ8lA/+5RVhd4WHPxf4sVPlMfuGVA1iNG7GRZuPRrSPAh+3lsts4M21K3T4/4XK+eiPlPNEDAQy0jZMGg7SGH9LC1Zn3JqwRfGprH0gkeDKt15l+v8BjNtEZ0nJEc6bJ/rn+0DSmx3iDolOHJJ8m/7F3fUtgmPZreeU1OUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762290033; c=relaxed/simple;
	bh=Y5BcpiF3e40fpsVJOeikg8ATyVYbjKb6pvpLH8HSWAE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g+Whp/Ad1JIBX0X54/JHhMTl0vVD0LHwog4peUhPvAF5MJdmC701pcj5qJ35+PCAmosq48ubF72REPYMUJb6I/IVDxWy5ELVclQ2uQXCcGvh7kRXI8M3NY5XBjj9IcOP6k4xI3i4hBOK7b0ramxQT3mX+wRejkr8MazSoQkV8+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VB3xdNpR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B2D3C4CEF8;
	Tue,  4 Nov 2025 21:00:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762290032;
	bh=Y5BcpiF3e40fpsVJOeikg8ATyVYbjKb6pvpLH8HSWAE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VB3xdNpRoB3PNGYJI6rkd3+bX7dj37SytSvpWJ2u2jCSbCFxRIojJcytdyv9Qf6Oy
	 YBDu5zFiCItmR7U0s+rq/hrc4i58L9ztphM7K/6LHESW4RTtgBwvEdEkBAmY9UXFQp
	 Tt6pGVtVvVnndYCOk5BZgTC75FLRHU4Jh55fjYGOOAsXgJ1Hqu+iXN0x4YfO0exdii
	 h3m9sPRnVINrmo3uY5+1Ax8tQddFVPAavkM0QH7H+vTgEo9h5aeXD8CjGrrisMvehJ
	 njpHuSNyb6lQOnhiIOESPQaLmkgHy7oV84xM2Jka/o/M5WxIgPuquwyXif4DdTDlG0
	 DaYor72e1ejAw==
Date: Tue, 4 Nov 2025 22:00:26 +0100
From: Christian Brauner <brauner@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, Amir Goldstein <amir73il@gmail.com>, 
	Aleksa Sarai <cyphar@cyphar.com>, Yu Watanabe <watanabe.yu+github@gmail.com>, 
	Josef Bacik <josef@toxicpanda.com>, Jeff Layton <jlayton@kernel.org>, Jann Horn <jannh@google.com>, 
	Luca Boccassi <luca.boccassi@gmail.com>, Alexander Mikhalitsyn <alexander@mihalicyn.com>, 
	linux-kernel@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Jan Kara <jack@suse.cz>, Lennart Poettering <lennart@poettering.net>, 
	Mike Yuan <me@yhndnzj.com>, Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>
Subject: Re: [PATCH 00/22] coredump: cleanups & pidfd extension
Message-ID: <20251104-akrobatisch-warnschilder-7bc99f7cfcda@brauner>
References: <20251028-work-coredump-signal-v1-0-ca449b7b7aa0@kernel.org>
 <20251102170353.GA3837@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251102170353.GA3837@redhat.com>

On Sun, Nov 02, 2025 at 06:03:54PM +0100, Oleg Nesterov wrote:
> On 10/28, Christian Brauner wrote:
> >
> > Christian Brauner (22):
> >       pidfs: use guard() for task_lock
> >       pidfs: fix PIDFD_INFO_COREDUMP handling
> >       pidfs: add missing PIDFD_INFO_SIZE_VER1
> >       pidfs: add missing BUILD_BUG_ON() assert on struct pidfd_info
> >       pidfd: add a new supported_mask field
> >       pidfs: prepare to drop exit_info pointer
> >       pidfs: drop struct pidfs_exit_info
> >       pidfs: expose coredump signal
> 
> I don't think these changes need my review... but FWIW, I see nothing

Hm? You're the most suited to review them for sure.
And you always find my nasty little bugs. ;)

> wrong in 1-8. For 1-8:
> 
> Reviewed-by: Oleg Nesterov <oleg@redhat.com>

Thanks!

