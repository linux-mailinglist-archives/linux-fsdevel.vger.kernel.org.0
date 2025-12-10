Return-Path: <linux-fsdevel+bounces-71080-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3899FCB4117
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Dec 2025 22:33:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 121D430F5ADC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Dec 2025 21:32:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09575308F05;
	Wed, 10 Dec 2025 21:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="OijvUVMU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7AC0223DFB;
	Wed, 10 Dec 2025 21:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765402364; cv=none; b=cyw1Zys6gH8sQ5asgHwvyKwM6yR6tD3zKUN5ZV7Rr+UYogSmAnbxfCFovKjJZXOkh8dUf1v0NlzDk5Yj+sWtEZ85JzClZptzwM2tOQ7zGGzc21+jQAZgoqfdByW2o/9uV9pn/1UceqnfFzhdlHVabS85WfGPhrkbFm+jJZd2dc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765402364; c=relaxed/simple;
	bh=XZu6u6ngjvlOROX6GawkvchI0qYfFJdcz7oDy9MI64c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N1X+zMuAoEbrsL/TwzXBQCYXr/VrK7IKpINCsRAPsvOvttzKxomoJ9MZRM47RRzFWn+lfR/XTjqsmEmm4G2aZ7YmSCuUOWQHQePNMrMoI5bcJIc0dOet/3LTqo05N76Yuc4v4KkFJBvH3i8DOK4eKmHarJKUL6ir+LU5eZwvcMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=OijvUVMU; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description;
	bh=xMi26RM1JTbyV8dPQyqL1hcn9sFl2wv+LsDUh9lxDQg=; b=OijvUVMUeLtkQ/gqitC37kIllr
	GD1KMDRjKRXHlQ7bnJwQ8h4iTYSk+PfJ8fLsK5DciNkXUYyeMc6gKE8aOld3AaOlxqAOIGetc5WmL
	fhdnE2/bIOVxYyxBtWl8oBVOGAjEm0O5QmwVMrn2C3thLdwEFyXcsLuApKItRfs9FU6jZyugtdpkf
	sm2CgWrYBzWFBj7evpv1GsCuUiSBe+u322cAhfkzX16lON3eimiD+scUMu92KWkGGSViAZr9gH2+R
	uU8EmFlOqTV/sIfjSCB/zViADa15I12mvDeRb+3XtHN1x2fLtXTqG44Od+JF1PN0d7LHk8uDwqlah
	XiWselTQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99 #2 (Red Hat Linux))
	id 1vTRnz-00000007uL3-1RY4;
	Wed, 10 Dec 2025 21:33:03 +0000
Date: Wed, 10 Dec 2025 21:33:03 +0000
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
Message-ID: <20251210213303.GB1712166@ZenIV>
References: <6w4u7ysv6yxdqu3c5ug7pjbbwxlmczwgewukqyrap3ltpazp4s@ozir7zbfyvfj>
 <6930e200.a70a0220.d98e3.01bd.GAE@google.com>
 <CAGudoHE0Q-Loi_rsbk5rnzgtGfbvY+Fpo9g=NPJHqLP5G_AaUg@mail.gmail.com>
 <20251204082156.GK1712166@ZenIV>
 <CAGudoHGLFBq2Fg5ksJeVkn=S2pv6XzxenjVFrQYScA7QV9kwJw@mail.gmail.com>
 <7e2bd36e-3347-4781-a6fd-96a41b6c538d@I-love.SAKURA.ne.jp>
 <CAGudoHF7jPw347kqcDW2mFLzcJcYqiFLsbFtd-ngYG=vWUz8xQ@mail.gmail.com>
 <20251210153531.GX1712166@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251210153531.GX1712166@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Wed, Dec 10, 2025 at 03:35:31PM +0000, Al Viro wrote:
> On Wed, Dec 10, 2025 at 11:09:24AM +0100, Mateusz Guzik wrote:
> > On Wed, Dec 10, 2025 at 10:45 AM Tetsuo Handa
> > <penguin-kernel@i-love.sakura.ne.jp> wrote:
> > >
> > > syzbot is hitting VFS_BUG_ON_INODE(!S_ISDIR(inode->i_mode)) check
> > > introduced by commit e631df89cd5d ("fs: speed up path lookup with cheaper
> > > handling of MAY_EXEC"), for make_bad_inode() is blindly changing file type
> > > to S_IFREG. Since make_bad_inode() might be called after an inode is fully
> > > constructed, make_bad_inode() should not needlessly change file type.
> > >
> > 
> > ouch
> > 
> > So let's say calls to make_bad_inode *after* d_instantiate are unavoidable.
> 
> ... and each one is a bug.

In this case I strongly suspect that it had been introduced in

commit 58b6fcd2ab34399258dc509f701d0986a8e0bcaa
Author: Ahmet Eray Karadag <eraykrdg1@gmail.com>
Date:   Tue Nov 18 03:18:34 2025 +0300
 
     ocfs2: mark inode bad upon validation failure during read

Folks, make_bad_inode() is *NOT* magic and having it anywhere in "hardening"
patch is a major red flag.  Please, don't do it, and I would recommend
reverting that commit, possibly along with the rest of the series.

