Return-Path: <linux-fsdevel+bounces-71078-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CEFBCB4001
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Dec 2025 21:55:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 612F4307D369
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Dec 2025 20:55:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFE1B328622;
	Wed, 10 Dec 2025 20:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="CLNE/Q4K"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED2892744F;
	Wed, 10 Dec 2025 20:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765400098; cv=none; b=lDveoZ/XmqfD0IgF0a1TfXFSl85weYEBbmpfA+RBAM5EjskEm/glc7JATHmzUiqd08E0gYROj/6FZ7YllZ3jmb1zGE8Fn72mV3VYjllxDKQHWLMBCtqzqpeX+DdwWiNphGK6VdsjLUgaVpGRyW3z3vdZufMkZA1MnoDre/C4z1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765400098; c=relaxed/simple;
	bh=LWM13NfVuTlMjnobS7DvwwLULP/CfmL9qLFIiGmnGOs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Au3cyfp6OTx+FB+MTT6157/cq00rpYLy1F6vknabu/Ep/xzBKD21vaO8+PdneA+7Rx0C9GtS1mhGVnSPeg9pTtWv2S3dkLUghIvrTzzchZO1oergFi+r/piGxihE7CwyKilyt+XrzVu3cn4XrIxkU70i4GhweKDe5nYSJYK9/2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=CLNE/Q4K; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description;
	bh=m4obo4yfpitJ/Pb1Zo1EIFVHOg7tlem0BJG+M8WDr/k=; b=CLNE/Q4KcbJ9LULHJzDGAMbqwZ
	DnkrU+3IryywBBu8SbGN7tfx2+mSO35pfSpkwbvgMe1PSO4J1KeYeLlJmgZ77vOi8OpEvp+x4l5Fj
	iHu0XoX1kOZ+cH58UR6qwQ1XNI7u+/vxArwyR/+HHW9DMJk0i1VHhLX5kKqEWR06nNe7V9hmIzMzn
	YMpgjHx8ijvBI3eFA1hZYsNJI2h4WDxZLZhdNpdhTX3PUJxSIUCbMFk9jgvl2h8+5MIxbI+uph3Mx
	n76WdCdZ0wlESAdd6OvqBznarJKQPcVT5gTxAWrs8/GtjmsavlbahoXeUF2qPUHYlGLGN4sHhKkEA
	y+hoyPfQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99 #2 (Red Hat Linux))
	id 1vTRDR-00000007XhJ-2mmN;
	Wed, 10 Dec 2025 20:55:17 +0000
Date: Wed, 10 Dec 2025 20:55:17 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
	syzbot <syzbot+d222f4b7129379c3d5bc@syzkaller.appspotmail.com>,
	brauner@kernel.org, jack@suse.cz, jlbec@evilplan.org,
	joseph.qi@linux.alibaba.com, linkinjeon@kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	mark@fasheh.com, ocfs2-devel@lists.linux.dev,
	sj1557.seo@samsung.com, syzkaller-bugs@googlegroups.com,
	Chuck Lever <chuck.lever@oracle.com>
Subject: Re: [PATCH for 6.19-rc1] fs: preserve file type in make_bad_inode()
 unless invalid
Message-ID: <20251210205517.GZ1712166@ZenIV>
References: <6w4u7ysv6yxdqu3c5ug7pjbbwxlmczwgewukqyrap3ltpazp4s@ozir7zbfyvfj>
 <6930e200.a70a0220.d98e3.01bd.GAE@google.com>
 <CAGudoHE0Q-Loi_rsbk5rnzgtGfbvY+Fpo9g=NPJHqLP5G_AaUg@mail.gmail.com>
 <20251204082156.GK1712166@ZenIV>
 <CAGudoHGLFBq2Fg5ksJeVkn=S2pv6XzxenjVFrQYScA7QV9kwJw@mail.gmail.com>
 <7e2bd36e-3347-4781-a6fd-96a41b6c538d@I-love.SAKURA.ne.jp>
 <CAGudoHF7jPw347kqcDW2mFLzcJcYqiFLsbFtd-ngYG=vWUz8xQ@mail.gmail.com>
 <20251210153531.GX1712166@ZenIV>
 <20251210204338.GY1712166@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251210204338.GY1712166@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Wed, Dec 10, 2025 at 08:43:38PM +0000, Al Viro wrote:
> On Wed, Dec 10, 2025 at 03:35:31PM +0000, Al Viro wrote:
> > On Wed, Dec 10, 2025 at 11:09:24AM +0100, Mateusz Guzik wrote:
> > > On Wed, Dec 10, 2025 at 10:45 AM Tetsuo Handa
> > > <penguin-kernel@i-love.sakura.ne.jp> wrote:
> > > >
> > > > syzbot is hitting VFS_BUG_ON_INODE(!S_ISDIR(inode->i_mode)) check
> > > > introduced by commit e631df89cd5d ("fs: speed up path lookup with cheaper
> > > > handling of MAY_EXEC"), for make_bad_inode() is blindly changing file type
> > > > to S_IFREG. Since make_bad_inode() might be called after an inode is fully
> > > > constructed, make_bad_inode() should not needlessly change file type.
> > > >
> > > 
> > > ouch
> > > 
> > > So let's say calls to make_bad_inode *after* d_instantiate are unavoidable.
> > 
> > ... and each one is a bug.
> 
> FWIW, I'm very tempted to fold make_bad_inode() into iget_failed().  Other
> callers tend to be either pointless (e.g. ext2_new_inode() after reaching
> fail: label - we only get there if inode has never reached inode hash
> table; make_bad_inode() in there should've been gone for a long time)
> or outright broken.
> 
> There's not a lot of callers, thankfully; I'm going through those at the
> moment, but so far the impression is that we should be able to simply bury
> the damn thing.

While we are at it, 73861970938a "minixfs: Verify inode mode when loading from
disk" that introduced one of those is seriously misguided - sanity check belongs
in V1_minix_iget/V2_minix_iget, and should be handled there the same way we
deal with zero i_nlink.

We really ought to take that function out - as it is, it's an attractive
nuisance...

