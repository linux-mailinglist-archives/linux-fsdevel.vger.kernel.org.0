Return-Path: <linux-fsdevel+bounces-76084-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wNXqKQLwgGkgDQMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76084-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 02 Feb 2026 19:42:10 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 154EAD03FD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 02 Feb 2026 19:42:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 90C9C303FBCB
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Feb 2026 18:42:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 644AE2F363C;
	Mon,  2 Feb 2026 18:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="hYC2BZfq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6F042F12C3;
	Mon,  2 Feb 2026 18:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770057726; cv=none; b=k4fBT5MrCoFLVHV8zSwnZfHl0ctmhinyxPU29CHr29OwBLFD05LmcDQqdlFliNzxKbnU9mkk5yak3y8B2JgKomelcNVyCNPH3MhZ85mTqEFawGbYqcpZIxcE/Ow7jEJv5JoyOs9R3BPm5WqjgahKo75fqxOpGuUXDqCtYv8SLyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770057726; c=relaxed/simple;
	bh=b3q+R080Kk9mxAUY5Y6/+1624jWwOV0an1lmKpTi2Ac=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uwFKaa/EFBcVZkJ6zGPSD6+5Z5AuYG9XowCT2Vz3TdRM3ZW5ijNW68zjImKje1GlibeaKDwghXArzbRrzD6iQkWi/3EMrvGTtIjcBAZH8wf85lnvvnPvgsDrkReBijixzzuWNmyTXsg1GY2rhMvH8S0Yh+bCN/eV71Dlowhn/0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=hYC2BZfq; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=uAtv739Fm81yOnDk6gg6D9jyBN9kXpflK4sUDsIicis=; b=hYC2BZfqAR1mxw6GyS+HzD/dL6
	Fu0X5tDfReMe7mTS0jzm6j8FijBdR+cBotrURA8yIHAs0aWloUFkhSWA35EiBG0vzSoPc4ErZFUtp
	rnKgZUh6Mr8htEMrq9x2JlQyoFJRmXkqdwqqXVy0943zDpg5UxCEeZX6FF5y/40t2F3re14nwkpCU
	EcWbOBLC1njTOB91nz38wKXQ8zLxYHAsICfK5+7AmhIOFYyZFfZ+6+Cp7BNYAf0R2WVHs16hGB3jA
	ZYzeBKc7S7N3ePoDG0c2WKgFSJZ+799RxLZ+Ns0TvfOaeh+Am3k2c8lsPiqgQQ81jop2Fykx3Leol
	cOjJ4mbA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1vmytw-0000000C1To-1T8e;
	Mon, 02 Feb 2026 18:43:56 +0000
Date: Mon, 2 Feb 2026 18:43:56 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Kiryl Shutsemau <kas@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Hugh Dickins <hughd@google.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>, linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Orphan filesystems after mount namespace destruction and tmpfs
 "leak"
Message-ID: <20260202184356.GD3183987@ZenIV>
References: <aYDjHJstnz2V-ZZg@thinkstation>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aYDjHJstnz2V-ZZg@thinkstation>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[zeniv.linux.org.uk,none];
	R_DKIM_ALLOW(-0.20)[linux.org.uk:s=zeniv-20220401];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-76084-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linux.org.uk:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[viro@zeniv.linux.org.uk,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linux.org.uk:dkim]
X-Rspamd-Queue-Id: 154EAD03FD
X-Rspamd-Action: no action

On Mon, Feb 02, 2026 at 05:50:30PM +0000, Kiryl Shutsemau wrote:

> In the Meta fleet, we saw a problem where destroying a container didn't
> lead to freeing the shmem memory attributed to a tmpfs mounted inside
> that container. It triggered an OOM when a new container attempted to
> start.
> 
> Investigation has shown that this happened because a process outside of
> the container kept a file from the tmpfs mapped. The mapped file is
> small (4k), but it holds all the contents of the tmpfs (~47GiB) from
> being freed.
> 
> When a tmpfs filesystem is mounted inside a mount namespace (e.g., a
> container), and a process outside that namespace holds an open file
> descriptor to a file on that tmpfs, the tmpfs superblock remains in
> kernel memory indefinitely after:
> 
> 1. All processes inside the mount namespace have exited.
> 2. The mount namespace has been destroyed.
> 3. The tmpfs is no longer visible in any mount namespace.

Yes?  That's precisely what should happen as long as something's opened
on a filesystem.

> The superblock persists with mnt_ns = NULL in its mount structures,
> keeping all tmpfs contents pinned in memory until the external file
> descriptor is closed.

Yes.

> The problem is not specific to tmpfs, but for filesystems with backing
> storage, the memory impact is not as severe since the page cache is
> reclaimable.
> 
> The obvious solution to the problem is "Don't do that": the file should
> be unmapped/closed upon container destruction.

Or remove the junk there from time to time, if you don't want it to stay
until the filesystem shutdown...

> But I wonder if the kernel can/should do better here? Currently, this
> scenario is hard to diagnose. It looks like a leak of shmem pages.
> 
> Also, I wonder if the current behavior can lead to data loss on a
> filesystem with backing storage:
>  - The mount namespace where my USB stick was mounted is gone.
>  - The USB stick is no longer mounted anywhere.
>  - I can pull the USB stick out.
>  - Oops, someone was writing there: corruption/data loss.
> 
> I am not sure what a possible solution would be here. I can only think
> of blocking exit(2) for the last process in the namespace until all
> filesystems are cleanly unmounted, but that is not very informative
> either.

That's insane - if nothing else, the process that holds the sucker
opened may very well be waiting for the one you've blocked.

You are getting exactly what you asked for - same as you would on
lazy umount, for that matter.

Filesystem may be active without being attached to any namespace;
it's an intentional behaviour.  What's more, it _is_ visible to
ustat(2), as well as lsof(1) and similar userland tools in case
of opened file keeping it busy.

