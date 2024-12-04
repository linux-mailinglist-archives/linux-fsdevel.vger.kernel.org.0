Return-Path: <linux-fsdevel+bounces-36417-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C4859E3938
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Dec 2024 12:50:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 52DFBB2A32B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Dec 2024 11:30:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0FD51B0F36;
	Wed,  4 Dec 2024 11:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RQ13B4qk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26A2F192D68
	for <linux-fsdevel@vger.kernel.org>; Wed,  4 Dec 2024 11:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733311837; cv=none; b=Cy87QRvJnpYTp76UN0BJmRsLsg6NnH197dqOe0uf1Z7xmm9VwdM5W+61GJb/oDZX3ZY1ujaos2VHHEbqZpPDYRqKYGG3lXUjAlbmVhrg0zfaA0Bw/fnC4/Zpnq10E1zUpUJawZEIr6GPOFyLLWRbzPxivhTe/PkpdGcbfAlQdgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733311837; c=relaxed/simple;
	bh=hMU65eT+U3d6Q26/b1HYVkFssMysZ0U8IdnF8HhXGjA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qp15vVofgRlLmrOcKlTnqeMUAst+cPIAKDxF0dE/5d4G9pAlgby6oXoQoRgL0Hp0rUFeH6Rw7oqWd97OK9u/Kv9b7iknlPiLS6NgXNgW0iVfvoyG96LTP1MK4hTZ2jc0QYDDMiMnQebsnAftpwVNrz18KLF4abo0HBxedNKH02w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RQ13B4qk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 910E2C4CED1;
	Wed,  4 Dec 2024 11:30:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733311836;
	bh=hMU65eT+U3d6Q26/b1HYVkFssMysZ0U8IdnF8HhXGjA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RQ13B4qkIrULSyQ3pONk83q2brCPqhS17Zu9hQvLifIqjVMCWi6eFSbqJrXn3i5B4
	 J0KASVce8yrJZoFV84mt8zG/ej9p0ptG4BUUAVVpNTlzxHegipkeReL8XvDL1doSEV
	 Pg7G60S4+Phky1RMf+KUmSf7Ja8URX6CzUIZDz3px9eV9zTmkmB0xbG12lfz4Wbjt9
	 zhTR/gU1yO7uw9RhghHevpgAXTu4Fsaak8GiuQCbbXnQaYMDCoGUd76KIW1VOukHbw
	 LFqgZmEre/CObRK3qm+oUBcvgwzqB3MLYF1zqKU3eJnPZMeeqhET6nWyoAyggGPmrS
	 nCVSDDHiruEAg==
Date: Wed, 4 Dec 2024 12:30:31 +0100
From: Christian Brauner <brauner@kernel.org>
To: Jan Kara <jack@suse.cz>
Cc: Amir Goldstein <amir73il@gmail.com>, Karel Zak <kzak@redhat.com>, 
	Miklos Szeredi <mszeredi@redhat.com>, linux-fsdevel@vger.kernel.org, 
	Lennart Poettering <lennart@poettering.net>, Ian Kent <raven@themaw.net>, 
	Alexander Viro <viro@zeniv.linux.org.uk>
Subject: Re: [RFC PATCH] fanotify: notify on mount attach and detach
Message-ID: <20241204-neudefinition-zitat-57bb2e9baa13@brauner>
References: <20241128144002.42121-1-mszeredi@redhat.com>
 <dqeiphslkdqyxevprnv7rb6l5baj32euh3v3drdq4db56cpgu3@oalgjntkdgol>
 <CAOQ4uxh0QevMgHur1MOOL2uXjivGEneyW2UfD+QOWj1Ozz5B1g@mail.gmail.com>
 <20241203164204.nfscpnxbfwvfpmts@quack3>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241203164204.nfscpnxbfwvfpmts@quack3>

On Tue, Dec 03, 2024 at 05:42:04PM +0100, Jan Kara wrote:
> On Tue 03-12-24 14:03:24, Amir Goldstein wrote:
> > On Tue, Dec 3, 2024 at 12:40 PM Karel Zak <kzak@redhat.com> wrote:
> > > Thank you for working on this.
> > >
> > > On Thu, Nov 28, 2024 at 03:39:59PM GMT, Miklos Szeredi wrote:
> > > > To monitor an entire mount namespace with this new interface, watches need
> > > > to be added to all existing mounts.  This can be done by performing
> > > > listmount()/statmount() recursively at startup and when a new mount is
> > > > added.
> > >
> > > It seems that maintaining a complete tree of nodes on large systems
> > > with thousands of mountpoints is quite costly for userspace. It also
> > > appears to be fragile, as any missed new node (due to a race or other
> > > reason) would result in the loss of the ability to monitor that part
> > > of the hierarchy. Let's imagine that there are new mount nodes added
> > > between the listmount() and fanotify_mark() calls. These nodes
> > > will be invisible.
> > 
> > That should not happen if the monitor does:
> > 1. set fanotify_mark() on parent mount to get notified on new child mounts
> > 2. listmount() on parent mount to list existing children mounts
> 
> Right, that works in principle. But it will have all those headaches as
> trying to do recursive subtree watching with inotify directory watches
> (mounts can also be moved, added, removed, etc. while we are trying to
> capture them). It is possible to do but properly handling all the possible
> races was challenging to say the least. That's why I have my doubts whether
> this is really the interface we want to offer to userspace...
> 
> > > It would be beneficial to have a "recursive" flag that would allow for
> > > opening only one mount node and receiving notifications for the entire
> > > hierarchy. (I have no knowledge about fanotify, so it is possible that
> > > this may not be feasible due to the internal design of fanotify.)
> > 
> > This can be challenging, but if it is acceptable to hold the namespace
> > mutex while setting all the marks (?) then maybe.
> 
> So for mounts, given the relative rarity of mount / umount events and depth
> of a mount tree (compared to the situation with ordinary inodes and
> standard fanotify events), I think it might be even acceptable to walk up
> the mount tree and notify everybody along that path.

Mount trees can get pretty massive due to containers and mount
propagation. That's why propagate_umount() is so ugly because it's
optimized to deal with such cases.

But, I think that recursive watches have to be restricted to mount
namespaces anyway. Such that you can get notifications about all mount
and umounts in a specific mount namespace. That reigns in the problem
quite a bit.

> 
> > What should be possible is to set a mark on the mount namespace
> > to get all the mount attach/detach events in the mount namespace
> > and let userspace filter out the events that are not relevant to the
> > subtree of interest.

Yes, that's what I've been arguing for at LSFMM.

