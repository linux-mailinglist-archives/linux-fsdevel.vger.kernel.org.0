Return-Path: <linux-fsdevel+bounces-58209-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC7BCB2B224
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Aug 2025 22:14:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 834F53B231A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Aug 2025 20:14:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CA8A273D7B;
	Mon, 18 Aug 2025 20:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="vTV6n8y5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C2F69475;
	Mon, 18 Aug 2025 20:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755548073; cv=none; b=Xt5AyLhy+Rcg69958lRnHOGSJ8kYDReEz5VbLnd+fwryjAhuTa+nJe8hn8KB2libm1+DJFszDlSScuMJoed3xuWOj/Whf+ENzldsxFh9SfGzdZiG2yn/X3JLvxsXHA0TXlcstYIVlSXm9V1K/wR50D6kjT66JF+atmuTQyru6Ys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755548073; c=relaxed/simple;
	bh=nl/IWC/Nvzc8t2ULH6NtHlrLaRZWiMXPP9CMSUVcwvg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hIEJgY7kogXrRXx9muevpqjCEVOqWvTuYIpK9U25j83EOPv7hikZz6EFY4XPdrHtPoX+0OWrUf/bxmv9bBQ9DahTWlP1gL8Ulkzjjz9Rdq1auWcyhV8CSFjEVE5rDEoEMiKA+WHBlKLHChC6WXk59k9AfDBLo2uctFa/rN3ihBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=vTV6n8y5; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=PQ15qKsPUaZyRbSFVHZobmG/J+b1QS6GyW39N1u8Wiw=; b=vTV6n8y5enEba8WE6DA53X/k/t
	6mlfe2+he+LJBB/CRvd5hcnb1l8uzkjIiEHoJv9/g3V1XEtlwlbmEJQGAcKKsw58SFtH7jiJYhBOn
	2F+EULn1lUNJAsS4qEUyPRoaDM38E2euDHJAu9asB6AukQVh7TGsYc+6SVHPhNbXWRfn+pX5G0lwB
	JlTO5J/mFqDtuKQbe915qzP1l4djqBn5WIH1sg78t6UbzY7rMZQUWkuy87SrvXBLMaUZywvJoZohS
	I74/E8s1ud8ww4uYW6dUmkY21Aa31Y0DJBsHY3vmRWC9g04Bgi0nxY3v2rj+d8oI7NbcA+KLWvp+N
	nvi3cCHw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uo6FQ-000000083dD-2Kdv;
	Mon, 18 Aug 2025 20:14:28 +0000
Date: Mon, 18 Aug 2025 21:14:28 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Ryan Chung <seokwoo.chung130@gmail.com>
Cc: brauner@kernel.org, jack@suse.cz, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-kernel-mentees@lists.linux.dev,
	kernel test robot <lkp@intel.com>,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: [RFC] {do_,}lock_mount() behaviour wrt races and move_mount(2) with
 empty to_path (was Re: [PATCH] fs/namespace.c: fix mountpath handling in
 do_lock_mount())
Message-ID: <20250818201428.GC222315@ZenIV>
References: <20250818172235.178899-1-seokwoo.chung130@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250818172235.178899-1-seokwoo.chung130@gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Tue, Aug 19, 2025 at 02:22:35AM +0900, Ryan Chung wrote:
> Updates documentation for do_lock_mount() in fs/namespace.c
> to clarify its parameters and return description to fix
> warning reported by syzbot.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202506301911.uysRaP8b-lkp@intel.com/
> Signed-off-by: Ryan Chung <seokwoo.chung130@gmail.com>
> ---
>  fs/namespace.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/namespace.c b/fs/namespace.c
> index ddfd4457d338..577fdff9f1a8 100644
> --- a/fs/namespace.c
> +++ b/fs/namespace.c
> @@ -2741,6 +2741,7 @@ static int attach_recursive_mnt(struct mount *source_mnt,
>  /**
>   * do_lock_mount - lock mount and mountpoint
>   * @path:    target path
> + * @pinned: on success, holds a pin guarding the mountpoint

I'm not sure if 'pin' is suitable here and in any case, that's not the
only problem in that description - take a look at "Return:" part in there.

The underlying problem is the semantics of function itself.  lock_mount()
assumed that it was called on the result of pathname resolution; the
question is what to do if we race with somebody mounting something
on top of the same location while we had been grabbing namespace_sem?
"Follow through to the root of whatever's been mounted on top, same as
we'd done if pathname resolution happened slightly later" used to be a
reasonable answer, but these days we have move_mount(2), where we have
	* MOVE_MOUNT_T_EMPTY_PATH combined with empty pathname, which
will have us start with whatever the descriptor is pointing to, mounts
or no mounts.  Choosing to treat that as "follow mounts anyway" is not
a big deal.
	* MOVE_MOUNT_BENEATH - treated as "follow mounts and slip the
damn thing under the topmost one".  Again, OK for non-empty pathname,
but... for empty ones the rationale is weaker.

Alternative would be to treat these races as "act as if we'd won and
the other guy had overmounted ours", i.e. *NOT* follow mounts.  Again,
for old syscalls that's fine - if another thread has raced with us and
mounted something on top of the place we want to mount on, it could just
as easily have come *after* we'd completed mount(2) and mounted their
stuff on top of ours.  If userland is not fine with such outcome, it needs
to provide serialization between the callers.  For move_mount(2)... again,
the only real question is empty to_path case.

Comments?

Note, BTW, that attach_recursive_mnt() used to require dest_mnt/dest_mp
to be on the very top; since 6.16 it treats that as "slip it under
whatever's on top of that" - that's exactly what happens in 'beneath'
case.  So the second alternative is easily doable these days.  And
it would really simplify the lock_mount()/do_lock_mount()...

