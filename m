Return-Path: <linux-fsdevel+bounces-76205-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KOssAbUPgmm9OwMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76205-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Feb 2026 16:09:41 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 78541DB18C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Feb 2026 16:09:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4980830B3304
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Feb 2026 14:59:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F8003A784F;
	Tue,  3 Feb 2026 14:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MS1vH3Y2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0ABF3ACF1A;
	Tue,  3 Feb 2026 14:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770130737; cv=none; b=sitXhuKGxIj8O8cs2bBc64lnzNU1tSX5ObCuwPpgxGqrJctEoqAc6U3HcV0SSOTrQoK1HRRbsRyh9CjW2jgzNi5IIwWYivq8HQFF1guEFTVEjdI65CMkuh8tJmPuMDvAAojKOWzCVNIJ/LkKvZHUVPzY5m8hSS6bk8d4I6gBGvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770130737; c=relaxed/simple;
	bh=AB+11IgAHQ4Zv4sJxXwOskKIaf0y0aebH7UdqQsEi0o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M2jU/DaLae2It9Dk19gbQ0pIGJNnIv8tJ+G3EKvGLWNYHGC4mTwH5iijmUkAZEfL75buj5jwx+CwfK8HCFg+ubQg/lj/wgp35JXbQ486kg1FmNTQec7/iufhaPFh0npcrbCdStRE1D/aUaZigFvhu3AaM7nDcQzbKMbNsvvsJEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MS1vH3Y2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5148C116D0;
	Tue,  3 Feb 2026 14:58:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770130736;
	bh=AB+11IgAHQ4Zv4sJxXwOskKIaf0y0aebH7UdqQsEi0o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MS1vH3Y2DMgMyWcZy2ZZW+2ypjiCAnvnVbtcMm+3lbwH06ZJR2uDgYG0vS6Q1hafs
	 wl6Z5IfS7D1zRbjLReVr/J1NGgPe2YjLyfZQ8TwDargAkg9+aDGa9eS4VSKy+cwkKh
	 EvM9QNUX3IbOsIyuWyLbyZTnnf7KWd1C++cELzeDLGuZUvhwo56ghlUsHkiMPwsVY4
	 UgZvmtxvNrXXXEhOAmfySsizMhFwP9pZRVP6nVXus/IUltVsMOC5d8xJT19mPKfvOm
	 YNNqoQb6teNygNh7yFC8j7zj9dNdJS6uoNpCpdMkr2JHnmmmCbm5u745p60BxS/BEk
	 6SQWSp6bWV6EA==
Date: Tue, 3 Feb 2026 15:58:52 +0100
From: Christian Brauner <brauner@kernel.org>
To: Kiryl Shutsemau <kas@kernel.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	Hugh Dickins <hughd@google.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, linux-mm@kvack.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Orphan filesystems after mount namespace destruction and tmpfs
 "leak"
Message-ID: <20260203-bestanden-ballhaus-941e4c365701@brauner>
References: <aYDjHJstnz2V-ZZg@thinkstation>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aYDjHJstnz2V-ZZg@thinkstation>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-76205-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[brauner@kernel.org,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 78541DB18C
X-Rspamd-Action: no action

On Mon, Feb 02, 2026 at 05:50:30PM +0000, Kiryl Shutsemau wrote:
> Hi,
> 
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
> 
> The superblock persists with mnt_ns = NULL in its mount structures,
> keeping all tmpfs contents pinned in memory until the external file
> descriptor is closed.
> 
> The problem is not specific to tmpfs, but for filesystems with backing
> storage, the memory impact is not as severe since the page cache is
> reclaimable.
> 
> The obvious solution to the problem is "Don't do that": the file should
> be unmapped/closed upon container destruction.
> 
> But I wonder if the kernel can/should do better here? Currently, this
> scenario is hard to diagnose. It looks like a leak of shmem pages.
> 
> Also, I wonder if the current behavior can lead to data loss on a
> filesystem with backing storage:
>  - The mount namespace where my USB stick was mounted is gone.
>  - The USB stick is no longer mounted anywhere.
>  - I can pull the USB stick out.
>  - Oops, someone was writing there: corruption/data loss.

If the USB stick is yanked and the filesystem uses fs_holder_ops it will
be notified about sudden device removal and can decide to handle it as
it sees fit. That works for all devices; including log devices or rt
devices or what have you. Usually it will shut the filesystem down and
tell userspace to EIO. I've switched all major filesystems to this model
a few kernel releases ago.

> I am not sure what a possible solution would be here. I can only think

None from the kernel's perspective. It's intended semantics that
userspace relies upon (For example, if you have an fdstore then you very
much want that persistence.).

We could zap all files and make the fds cataonic. But that's just insane
from the start. It would be a drastic deviation from basic semantics
we've had since forever. It would also be extremly difficult to get
right and performant because you'd need algorithms to find all of them.
Keeping a global map for all files open on a filesystem instance is just
insane so is walking all processes and inspecting their fdtables.

I don't believe we need to do anything here unless you want some tmpfs
specific black magic where you can issue a shutdown ioctl on tmpfs that
magically frees memory. And I'd still expect that this would fsck
userspace over that doesn't expect this behavior.

> of blocking exit(2) for the last process in the namespace until all
> filesystems are cleanly unmounted, but that is not very informative
> either.

If you just wanted the ability to wait for a filesystem to have gone
away completely that's an easier thing to achieve. Inotify has support
for this via IN_UNMOUNT. But as you say I doubt that's actually helpful.

