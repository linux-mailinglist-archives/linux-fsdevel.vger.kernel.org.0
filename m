Return-Path: <linux-fsdevel+bounces-26142-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E652954FE7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Aug 2024 19:19:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE89E1C21D79
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Aug 2024 17:19:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 877641C0DF9;
	Fri, 16 Aug 2024 17:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="Y8DD8tX5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF90A1BF31C
	for <linux-fsdevel@vger.kernel.org>; Fri, 16 Aug 2024 17:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723828770; cv=none; b=IDbLTOxNlXOV3xXn5A6poh6CdH8OrEUXpEQzXDMetp+Gqbb+jqy1tP5t4MDBI/qshAyyXboTQ25RXz4ikcRISvaaTH+KxpaJ521gpZvdy9fC7ZCP+Zova/gnMqGYNJOQ+kij7RmUa/ZHDs4V/tpftxyIEp7b2270MDJWale8+Sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723828770; c=relaxed/simple;
	bh=MDivT0sIOhinXPdVBmTDW0CpZrXsh8PN8qyNoj5wd/o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tYYbCVLxfzXBrmJPyhsYBHtZNe65AQrAB1Bl1FahPVOmZjwiBkgEmyXOlaQr6Kp7QbHa03DaCG5TCnTYSHbLZaExt7OsNRL7Kyqs4uH9MgSiYBT/Ck2keSKUmJBwKxuQerZe/u/vpP4ygFG8llIvwacJ/u3UuE/b8g94nRpeYOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=Y8DD8tX5; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=OBKE+mfLr7KTDCikfzSdOwfLYh9wPg9Ll9jzWOGjcs0=; b=Y8DD8tX5UAol0h6ip+dbnhbhVo
	bF9asaVSHirNBlPCzDG7EqkxkErojzPuh5Qs6tavNST3XF2Dn6nwThASy7b+zNJ74M/9O+5cSjI5B
	ykGXVRYZWqXAMbZnHT1jRAurXNsuUZQvyfA8Z42PuQb2A7+YAwph8pTB7hQ2KAAUubvTH1TgPBxjH
	bI0ZkUtKC8wm1UqVp5Ro64C6kRO7zkA+tYXWQqvTiNt/sEELteSm3GZhLBotBEHticXsEYs63khUS
	uIE94zC1mYEbYraG78R1UF+poPPHRi8ff9QZrCYpdM8j6AzLMkqEqzAH15N94K7am7EjxGC1eFXEm
	kdW5ssNQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1sf0bl-00000002Mwm-3P9p;
	Fri, 16 Aug 2024 17:19:25 +0000
Date: Fri, 16 Aug 2024 18:19:25 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>
Subject: Re: [RFC] more close_range() fun
Message-ID: <20240816171925.GB504335@ZenIV>
References: <20240816030341.GW13701@ZenIV>
 <CAHk-=wh_K+qj=gmTjiUqr8R3x9Tco31FSBZ5qkikKN02bL4y7A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wh_K+qj=gmTjiUqr8R3x9Tco31FSBZ5qkikKN02bL4y7A@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Fri, Aug 16, 2024 at 09:26:45AM -0700, Linus Torvalds wrote:
> On Thu, 15 Aug 2024 at 20:03, Al Viro <viro@zeniv.linux.org.uk> wrote:
> >
> > It *can* actually happen - all it takes is close_range(2) decision
> > to trim the copied descriptor table made before the first dup2()
> > and actual copying done after both dup2() are done.
> 
> I think this is fine. It's one of those "if user threads have no
> serialization, they get what they get" situations.

As it is, unshare(CLOSE_FILES) gives you a state that might be possible
if you e.g. attached a debugger to the process and poked around in
descriptor table.  CLOSE_RANGE_UNSHARE is supposed to be a shortcut
for unshare + plain close_range(), so having it end up with weird
states looks wrong.

For descriptor tables we have something very close to TSO (and possibly
the full TSO - I'll need to get some coffee and go through the barriers
we've got on the lockless side of fd_install()); this, OTOH, is not
quite Alpha-level weirdness, but it's not far from that.  And unlike
Alpha we don't have excuses along the lines of "it's cheaper that way" -
it really isn't any cheaper.

The variant I'm testing right now seems to be doing fine (LTP and about
halfway through the xfstests, with no regressions and no slowdowns)
and it's at
 fs/file.c               | 63 +++++++++++++++++--------------------------------
 include/linux/fdtable.h |  6 ++---
 kernel/fork.c           | 11 ++++-----
 3 files changed, 28 insertions(+), 52 deletions(-)

Basically,
	* switch CLOSE_UNSHARE_RANGE from unshare_fd() to dup_fd()
	* instead of "trim down to that much" pass dup_fd() an
optional "we'll be punching a hole from <this> to <that>", which
gets passed to sane_fdtable_size() (NULL == no hole to be punched).
	* in sane_fdtable_size()
		find last occupied bit in ->open_fds[]
		if asked to punch a hole and if that last bit is within
the hole, find last occupied bit below the hole
		round up last occupied plus 1 to BITS_PER_LONG.
All it takes, and IMO it's simpler that way.

