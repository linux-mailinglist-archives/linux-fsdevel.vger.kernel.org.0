Return-Path: <linux-fsdevel+bounces-72358-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F621CF0B9D
	for <lists+linux-fsdevel@lfdr.de>; Sun, 04 Jan 2026 08:40:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9AB0C3016985
	for <lists+linux-fsdevel@lfdr.de>; Sun,  4 Jan 2026 07:40:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF0F82F6181;
	Sun,  4 Jan 2026 07:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="BCvNxspR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E000F2F6562
	for <linux-fsdevel@vger.kernel.org>; Sun,  4 Jan 2026 07:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767512440; cv=none; b=TdLjGYh7/bFqIn4cfpHDRIJ501291Az+RWJSfE6wlEC0PdmWEqkDew7HuhmyX2JHwKm9n7AKJOYuyzi7AVrlg7qEUWdxP39ztGs9yJ48sDlwxmU7SOQemF8+OFJM/+qU3aMQ2HlKESH+5/7iU2tIKJIeI8lqJkRLmOdLxy4VWuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767512440; c=relaxed/simple;
	bh=NnVbZEuuf8hO5AW3rnr/wuAA6KiRkXMBzDkB/HM01RE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F/M2TXXkLMgs2EzDnrCqBNJX6SAWIqPyL5GYPSC7QBdzfdm5JtP0VoqOrdsqHMJdKntBCYZg978XC6TDV0J36zNZjmbvEfYa97ZUl9OTUM7xyGD/XEC/B5iPhvShxToxuK6wprg57oAVCesU+5vsMJPB3FD7VrZe72JSgu8RI1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=BCvNxspR; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=fGcDkVpKeFeVQZH8cINYDXBgZkNvfKnaiAYQryYaFBE=; b=BCvNxspR4yfHoNONaKGHIgwfhr
	hwpUTtKEzYxoMg7O7dPzC0r84c7jESXnDL2RfnqisE7p7phSRhi3ZkD15corRCMyFkIYrnP000PIe
	ZncrZy0RFf+/Azd0hu9c0hvTjC2viVl69hyW0h0M3T/uYVccs3s73Snh8F7nn+wMA7xJhePP5ez10
	ouyprr0NL9GeJ3LVm8d1QNEft8h61Xm9dSgEYToUDL8m/G1pMGDffUe/N2AKOo1Vd9L1dAhmEhAOL
	R3G3UeDtRuzsPDs70atTq1fkz6YFot/LxaiDoO/A8lkc70ee3NrkR+2C3+RWxTRxoPCf0pr40cMZ6
	3ml49R/g==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99 #2 (Red Hat Linux))
	id 1vcIkD-0000000D0F3-3RbC;
	Sun, 04 Jan 2026 07:41:45 +0000
Date: Sun, 4 Jan 2026 07:41:45 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Jan Kara <jack@suse.cz>,
	Jeff Layton <jlayton@kernel.org>,
	Amir Goldstein <amir73il@gmail.com>,
	Lennart Poettering <lennart@poettering.net>,
	Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>,
	Josef Bacik <josef@toxicpanda.com>
Subject: Re: [PATCH 3/3] fs: add immutable rootfs
Message-ID: <20260104074145.GJ1712166@ZenIV>
References: <20260102-work-immutable-rootfs-v1-0-f2073b2d1602@kernel.org>
 <20260102-work-immutable-rootfs-v1-3-f2073b2d1602@kernel.org>
 <20260104072743.GI1712166@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260104072743.GI1712166@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Sun, Jan 04, 2026 at 07:27:43AM +0000, Al Viro wrote:
> On Fri, Jan 02, 2026 at 03:36:24PM +0100, Christian Brauner wrote:
> 
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/* Copyright (c) 2026 Christian Brauner <brauner@kernel.org> */
> > +#include <linux/fs/super_types.h>
> > +#include <linux/fs_context.h>
> > +#include <linux/magic.h>
> 
> [snip]
> 
> What does it give you compared to an empty ramfs?  Or tmpfs, for that
> matter...
> 
> Why bother with a separate fs type?

Make that "empty ramfs" and as soon as you've got the mount have
	mnt->mnt_root->d_inode->i_flags |= S_IMMUTABLE;
done.  No concurrent accesses at that point, no way to clear that
flag for ramfs inodes afterwards and ramfs is always built in...

What am I missing here?

