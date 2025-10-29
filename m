Return-Path: <linux-fsdevel+bounces-66385-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DD10C1DB04
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Oct 2025 00:31:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 992A434C109
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 23:31:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC33A2F7AAF;
	Wed, 29 Oct 2025 23:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AZcfr205"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 199FA3BB48;
	Wed, 29 Oct 2025 23:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761780662; cv=none; b=nttYP8zrRZUUhDi/ET+0jKwAnDK6UldiI/Wbns4tPfCcataxGqF1tk4FXWtynQVqGGjTTrUlNM35jfJwwyP12tBmquimLoPl5GhpAtFNPzWUjeq147Rz5P7sJHXg2oc5ob9tSQymfhzJOkmDF1CDc7d3sA3ozO32UewyzHBg5n8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761780662; c=relaxed/simple;
	bh=FFcXZ2cb/XjMuGnx91GbjCOjmPAcuSjcJLN/pfLNp1Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OOQicuJhxNl9fLR6ZyyOKpU7E70t8pT84KM9th9YBYLNO/rEdLeNNSanQo6c1wEd6VTfYx1QR5ZW1sRlVeSlMKUa1/vNB76LK3kMBcFo3PWBoxfbfXxdzENdiNOhWvCOEmjTsKpzoE3lzUi9Wz+yb9kcpA98dTQqEqTXbWNqUhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AZcfr205; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC16FC4CEF7;
	Wed, 29 Oct 2025 23:30:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761780661;
	bh=FFcXZ2cb/XjMuGnx91GbjCOjmPAcuSjcJLN/pfLNp1Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AZcfr205L0UopF7u7tnrCsH6qJK59fEUrwAVJwAFt7u14UVWD23sZ1C8cj7yut8TE
	 oUS5cS8Gdh6VeW2UnkYglEqFIIkRNzifcZqpOWwecMkvx15IiosmvQQtlvI2yDmIo4
	 mbV+BSE7zepHXvlEWjWhUbXQlaeet9a5JXG8pZd4qLrMaS3d1OH5FqIVY6C/GWoa8i
	 4RgUICCZJr7OxQE/G9laSTIB3J419IN+AH0CcoJkHm93v4UJotSbmCiUzcE6iWdHSk
	 xJbRMTmsvLuZlZd2RfT9561yGc4K9ZDoFMFd2OpMca6UyhmSt5UdW7nuoajlJcZGbj
	 jFD6+tAHBbEcw==
Date: Wed, 29 Oct 2025 16:30:57 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Christian Brauner <brauner@kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-kbuild@vger.kernel.org, David Sterba <dsterba@suse.com>
Subject: Re: [PATCH] fs/pipe: stop duplicating union pipe_index declaration
Message-ID: <20251029233057.GA3441561@ax162>
References: <20251023082142.2104456-1-linux@rasmusvillemoes.dk>
 <20251029-redezeit-reitz-1fa3f3b4e171@brauner>
 <20251029173828.GA1669504@ax162>
 <20251029-wobei-rezept-bd53e76bb05b@brauner>
 <CAHk-=wjGcos7LACF0J40x-Dwf4beOYj+mhptD+xcLte1RG91Ug@mail.gmail.com>
 <20251030-zuruf-linken-d20795719609@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251030-zuruf-linken-d20795719609@brauner>

On Thu, Oct 30, 2025 at 12:13:11AM +0100, Christian Brauner wrote:
> I'm fine either way. @Nathan, if you just want to give Linus the patch
> if it's small enough or just want to give me a stable branch I can pull
> I'll be content. Thanks!

I do not care either way but I created a shared branch/tag since it was
easy enough to do. If Linus wants to take these directly for -rc4, I am
fine with that as well.

Cheers,
Nathan

The following changes since commit 3a8660878839faadb4f1a6dd72c3179c1df56787:

  Linux 6.18-rc1 (2025-10-12 13:42:36 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kbuild/linux.git tags/kbuild-ms-extensions-6.19

for you to fetch changes up to c4781dc3d1cf0e017e1f290607ddc56cfe187afc:

  Kbuild: enable -fms-extensions (2025-10-29 16:23:47 -0700)

----------------------------------------------------------------
Shared branch between Kbuild and other trees for enabling '-fms-extensions' for 6.19

Signed-off-by: Nathan Chancellor <nathan@kernel.org>

----------------------------------------------------------------
Nathan Chancellor (1):
      jfs: Rename _inline to avoid conflict with clang's '-fms-extensions'

Rasmus Villemoes (1):
      Kbuild: enable -fms-extensions

 Makefile                   | 3 +++
 fs/jfs/jfs_incore.h        | 6 +++---
 scripts/Makefile.extrawarn | 4 +++-
 3 files changed, 9 insertions(+), 4 deletions(-)

