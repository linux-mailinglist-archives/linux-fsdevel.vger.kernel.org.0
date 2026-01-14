Return-Path: <linux-fsdevel+bounces-73773-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 00741D200EB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jan 2026 17:06:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3050E301AB7D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jan 2026 16:05:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B4E43A1E8D;
	Wed, 14 Jan 2026 16:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hPdzQ/LW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BF053A1E6E;
	Wed, 14 Jan 2026 16:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768406709; cv=none; b=n7UWDNwWumyCUTvOjuJf8BJIQcWmL1zQNaR6RM3J4pMM1eA2l1hCdpyDf73+JCCauJ+8cytbFdXYXzRJfcuME7MICxvKRKcdewo2LoRaBcyYAnVz0aOdniVNmT0ucwoYILuj4v0nyF47y6x10M4+ge2r419MNBRQry1ipeXpBgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768406709; c=relaxed/simple;
	bh=r0qEvVhll+Z7Vsm5uFPR8sLFOZslnIET8GG40MyImzk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bnSgGzv3hIgBwqiDbAnTHYvqGSlrWyGksWAIWq7kyYFrzLg6CTKm6DGwEgzVUB6Ppu9liej1N/21oPCLyH76TCxjyX1y0sE8rSDenc5WeHUMhQAHzNMt+FmL10E20U4ZlXGq8ec16djMcq6vCHgDhVEKO8SYCbihpZurVy9FLhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hPdzQ/LW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 948AEC4CEF7;
	Wed, 14 Jan 2026 16:05:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768406709;
	bh=r0qEvVhll+Z7Vsm5uFPR8sLFOZslnIET8GG40MyImzk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hPdzQ/LWzz2+n9Erh9Z0Ic3Fl2bmJPF3os4vhJD9MZHNb0bhtAW+7h1RQNuCXYzWp
	 eDiqDTf03OfumiMigsUMkPfPmtWPJOcOK+YN2jGEebF4X0FtXYqkFK86632kyCMhaO
	 plwoLvEo//Wp5gatesrU1JnEXl50Mze4hy3ljqLIuam/eq2l1GQOnvdMfiwLaSd/Zf
	 YjI0WBy0yIqR0PIWg6AxYUPonAeWXFi/SeZr4/ZfixaSPG4Ddjlq1DA/0nzFrtNFVi
	 aupogg2hMWzBr0pkXEN1n4Q0jOOz2j/suyEdL7vMpZqeN8mEjaaHRyRdGevz105ULY
	 I7ijvhCZ6hoIg==
Date: Wed, 14 Jan 2026 17:05:04 +0100
From: Christian Brauner <brauner@kernel.org>
To: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
Cc: "penguin-kernel@I-love.SAKURA.ne.jp" <penguin-kernel@i-love.sakura.ne.jp>, 
	"jack@suse.cz" <jack@suse.cz>, "frank.li@vivo.com" <frank.li@vivo.com>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, "slava@dubeyko.com" <slava@dubeyko.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"syzbot+f98189ed18c1f5f32e00@syzkaller.appspotmail.com" <syzbot+f98189ed18c1f5f32e00@syzkaller.appspotmail.com>, 
	"syzkaller-bugs@googlegroups.com" <syzkaller-bugs@googlegroups.com>, "glaubitz@physik.fu-berlin.de" <glaubitz@physik.fu-berlin.de>, 
	"viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>, "kapoorarnav43@gmail.com" <kapoorarnav43@gmail.com>
Subject: Re: [PATCH v3] hfsplus: pretend special inodes as regular files
Message-ID: <20260114-kleben-blitzen-4b50f7bad660@brauner>
References: <da5dde25-e54e-42a4-8ce6-fa74973895c5@I-love.SAKURA.ne.jp>
 <20260113-lecken-belichtet-d10ec1dfccc3@brauner>
 <92748f200068dc1628f8e42c671e5a3a16c40734.camel@ibm.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <92748f200068dc1628f8e42c671e5a3a16c40734.camel@ibm.com>

On Tue, Jan 13, 2026 at 05:18:40PM +0000, Viacheslav Dubeyko wrote:
> On Tue, 2026-01-13 at 09:55 +0100, Christian Brauner wrote:
> > On Mon, 12 Jan 2026 18:39:23 +0900, Tetsuo Handa wrote:
> > > Since commit af153bb63a33 ("vfs: catch invalid modes in may_open()")
> > > requires any inode be one of S_IFDIR/S_IFLNK/S_IFREG/S_IFCHR/S_IFBLK/
> > > S_IFIFO/S_IFSOCK type, use S_IFREG for special inodes.
> > > 
> > > 
> > 
> > Applied to the vfs-7.0.misc branch of the vfs/vfs.git tree.
> > Patches in the vfs-7.0.misc branch should appear in linux-next soon.
> > 
> > Please report any outstanding bugs that were missed during review in a
> > new review to the original patch series allowing us to drop it.
> > 
> > It's encouraged to provide Acked-bys and Reviewed-bys even though the
> > patch has now been applied. If possible patch trailers will be updated.
> > 
> > Note that commit hashes shown below are subject to change due to rebase,
> > trailer updates or similar. If in doubt, please check the listed branch.
> > 
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git  
> > branch: vfs-7.0.misc
> > 
> > [1/1] hfsplus: pretend special inodes as regular files
> >       https://git.kernel.org/vfs/vfs/c/68186fa198f1  
> 
> I've already taken this patch into HFS/HFS+ tree. :) Should I remove it from the
> tree?

No, I'll drop it.

