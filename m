Return-Path: <linux-fsdevel+bounces-57429-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29582B2169B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Aug 2025 22:38:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 838353ACEE2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Aug 2025 20:38:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B14A2DECA5;
	Mon, 11 Aug 2025 20:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="w24RHNVG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F32674EB38;
	Mon, 11 Aug 2025 20:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754944702; cv=none; b=dzsSQsNF9xBTY/Xq8hXjTEq50bWltv6PzB+eK5l3PZascOy4AL8/UfxoHLu5XwZ+SfIqONXQpJi+4jYAXpfYjV9vm2vOgEzGPeTQBmJoqT3zZ9LdqhEtAHglPUiPsg7Hm0XA6cRQhqRqgnqCvEpXCHGqhnf4o09h2OvJ6DOH/pk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754944702; c=relaxed/simple;
	bh=XjQqJAAEYwNtDohaBFmuwypceazNCgOcshmB6Ve2Xu4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kz4hu/jf5iCzRR4zBqF+RTfRTZ1k8eU81UcMiYKPDrpIqxIF5LGh4bKMwfY3y9hA6+hCeuM3CUHoEmhkMqFdtivFo0B6wkpM7at/sgXh1CdHTkxoRVVV4ILaqNxj1cog5hpISu51xR4YVikLUvVRsai4jLIT+nXboQuWjJ3EYZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=w24RHNVG; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=6ONcXmczJxlJ0uAio1fW+gJ65SFwtTUy5Ps1NCS49jI=; b=w24RHNVGWpKVJEfoHXqWh/TXd+
	rNJGeEB0lHYhh5BKGyD0ZZKytYcBYSa2Nl49kUZ2PiPt5r01+kJvK7ZKDby99a3D88AJPEgGCHs6I
	iO49hl/LK83dpetXqMX1N4wHBqGi/vtlSxSWWqBKKqwb7sekGi/n2neMOhn0lbl1L/n4a0FyVgOJ2
	CKG3VL4eHjsx73PMKTkb3LIVk+WMds0SZpIeWAW8b8Ib8BD1ZJxu5rFwTE1DZzqTbFdr14Gy3hBah
	QDunTmQWcpupsG20rrrGz0TBUKXvFDFYUhQJD4E671/9IuzMC7uZ8pbmuVNujXQGfsaG4Bvb9xaS0
	csLXCU4A==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ulZHb-000000051zK-2SMF;
	Mon, 11 Aug 2025 20:38:15 +0000
Date: Mon, 11 Aug 2025 21:38:15 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	linux-fsdevel <linux-fsdevel@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] vfs: show filesystem name at dump_inode()
Message-ID: <20250811203815.GS222315@ZenIV>
References: <ceaf4021-65cc-422e-9d0e-6afa18dd8276@I-love.SAKURA.ne.jp>
 <CAGudoHEowsc290kfSgCjDJfB+RKOv2gLYS6y4OxyjhjPW07vMQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGudoHEowsc290kfSgCjDJfB+RKOv2gLYS6y4OxyjhjPW07vMQ@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Mon, Aug 11, 2025 at 09:45:52PM +0200, Mateusz Guzik wrote:

> Better printing is a TODO in part because the routine must not trip
> over arbitrarily bogus state, in this case notably that's unset
> ->i_sb.

That... is a strange state.  It means having never been passed to
inode_init_always().  How do you get to it?  I mean, if the argument
is not pointing to a struct inode instance, sure, but then NULL is
not the only possibility - we are talking about the valur of
arbitrary word of memory that might contain anything whatsoever.

If, OTOH, it is a genuine struct inode, it must be in a very strange
point in the lifecycle - somewhere in the middle of alloc_inode(),
definitely before its address gets returned to the caller...

> See mm/debug.c:dump_vmg for an example.

Not quite relevant here...

>  void dump_inode(struct inode *inode, const char *reason)
>  {
> -       pr_warn("%s encountered for inode %px", reason, inode);
> +       struct super_block *sb = inode->i_sb; /* will be careful deref later */
> +
> +       pr_warn("%s encountered for inode %px [fs %s]", reason, inode,
> sb ? sb->s_type->name : "NOT SET");

That's really misleading - this "NOT SET" is not a valid state; ->i_sb is
an assign-once member that gets set by constructor before the object is
returned and it's never modified afterwards.  In particular, it is never
cleared.

There is a weird debugging in generic_shutdown_super() that goes through
the inodes of dying superblock that had survived the fs shutdown
("Busy inodes after unmount" thing) and poisons their ->i_sb, but that's
VFS_PTR_POINSON, not NULL.

We literally never store NULL there.  Not even with kmem_cache_zalloc()...

