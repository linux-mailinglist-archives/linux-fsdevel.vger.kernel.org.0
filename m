Return-Path: <linux-fsdevel+bounces-33560-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 323E49B9F5E
	for <lists+linux-fsdevel@lfdr.de>; Sat,  2 Nov 2024 12:36:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EBC6C2818DF
	for <lists+linux-fsdevel@lfdr.de>; Sat,  2 Nov 2024 11:36:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B300179972;
	Sat,  2 Nov 2024 11:36:44 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from kawka3.in.waw.pl (kawka3.in.waw.pl [68.183.222.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF6E4140E50;
	Sat,  2 Nov 2024 11:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.183.222.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730547403; cv=none; b=liDK1H5HDX7Ls5Z5cFprU20Azkw9/l8lD641o5gKnr57gmyBRfl/Zv3W769krdcU1nmyW6EzfwiQVLqywkaELp2Kk0UHe7tli0hygR0GtimfXrq8+jih+ndQBZdQHYRvgEFWO2AD95Ny1HTfAoQ5cgshkoC4vu4e/ma/lNQYpK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730547403; c=relaxed/simple;
	bh=pdAiiMvAw5Re8jxW9WtPoUOENTWlMR9q2CsiR4T+ZTw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H0BoirbwUvB5d2gIi9NyizH75j1J5/i3wSr+5WSlRyzyVfmTwzA3XztML7ZzZw+77AKojG5oXvkTmjs+t9TZaFhTw4GCbzKAjoTA91Nnh1otaQ2D+yA7uXaKNF7Y2LEXj0+N6m48jA9hLmoLQdpx6MwtVp5V906ekG8mrzS2w3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=in.waw.pl; spf=pass smtp.mailfrom=in.waw.pl; arc=none smtp.client-ip=68.183.222.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=in.waw.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=in.waw.pl
Received: by kawka3.in.waw.pl (Postfix, from userid 1000)
	id B80CB5826E1; Sat,  2 Nov 2024 11:29:55 +0000 (UTC)
Date: Sat, 2 Nov 2024 11:29:55 +0000
From: Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>
To: Tycho Andersen <tycho@tycho.pizza>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Eric Biederman <ebiederm@xmission.com>,
	Shuah Khan <skhan@linuxfoundation.org>, Kees Cook <kees@kernel.org>,
	Aleksa Sarai <cyphar@cyphar.com>, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Tycho Andersen <tandersen@netflix.com>
Subject: Re: [PATCH 1/2] exec: fix up /proc/pid/comm in the
 execveat(AT_EMPTY_PATH) case
Message-ID: <ZyYNM58N-Fp_1xB8@kawka3.in.waw.pl>
References: <20241030203732.248767-1-tycho@tycho.pizza>
 <173041263505.1781237.9706368369948860422.b4-ty@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <173041263505.1781237.9706368369948860422.b4-ty@kernel.org>

On Thu, Oct 31, 2024 at 03:10:37PM -0700, Kees Cook wrote:
> On Wed, 30 Oct 2024 14:37:31 -0600, Tycho Andersen wrote:
> > Zbigniew mentioned at Linux Plumber's that systemd is interested in
> > switching to execveat() for service execution, but can't, because the
> > contents of /proc/pid/comm are the file descriptor which was used,
> > instead of the path to the binary. This makes the output of tools like
> > top and ps useless, especially in a world where most fds are opened
> > CLOEXEC so the number is truly meaningless.
> > 
> > [...]
> 
> Applied to for-next/execve, thanks!
> 
> [1/2] exec: fix up /proc/pid/comm in the execveat(AT_EMPTY_PATH) case
>       https://git.kernel.org/kees/c/7bdc6fc85c9a
> [2/2] selftests/exec: add a test for execveat()'s comm
>       https://git.kernel.org/kees/c/bd104872311a

I tested this with systemd compiled with -Dfexece=true and it all
seems to work fine. Thanks!

Zbyszek

