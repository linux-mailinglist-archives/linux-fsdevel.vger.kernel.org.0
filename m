Return-Path: <linux-fsdevel+bounces-71079-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 62D11CB40B1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Dec 2025 22:14:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BDB7730BE69D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Dec 2025 21:13:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88673326D77;
	Wed, 10 Dec 2025 21:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="JOaB+3iu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38A3823E334;
	Wed, 10 Dec 2025 21:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765401228; cv=none; b=J9CqMRazgrM8wQ6UIz7duOpP5wdy4PT5brH5bAfpSzeF870fTrf0bCbWfFCM+h7hP/7uGRYTfpjxsVNjggpSC3mfcWbLTdcLVH9Z90bdMBFItj0qahVabG5wAhSGwAkUEPU+CEYJyOlMAIJkZHejr3v1CfhrHFnuS1jlc7sxmkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765401228; c=relaxed/simple;
	bh=Pm6YHj3y9tABRvJHgRuNvcJpwqttQZcek7roqHHcqkw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cDLmdkH6eH9H/lgW0TIsp3TEZXbaJBYAhHQats0vRUBlMs8bRacBTfK4WT2cA22OQPLNHvdAYnNIm6PTTsXRSzS739jkhxwPEqZ6IhSrAEwBFCehLySXOts4uX3CDtWXARBh8p5h3Zm1tdbizHwl29a/GpJW2e1MvPenHk4Ratw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=JOaB+3iu; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=wkkt71913GBJkxSjWttCWLF+2kNWQUbuyGTQlXlureQ=; b=JOaB+3iuRxC9NwEYi0oRgC3RtH
	tfbE0qHiuWneTYX890nqEr5UPE+hJo1ZwdpdSGxvw9MttfEILQvL33S8f6XtjzLov0ipDKED+rnwu
	dQzZaepDN15nrKnuEMqwRAekaVISbBmlRgy5jaRANX2GK2A4z+71BflCZ2Brb4iMMyRpQlhbiRIhN
	VTkSYquK+lHqN8zB2w7xDZQ2X3HijNgn3QQN257hI9YwlhKANLVUsC+JNI0CtEg+3BZC/n3xJim/l
	Fr2fIptnXOEWTJ5gW2Q65TGW5yQH0wxZAYGEWn77rld/dZNVGuLZ23aTnaBMHTmUy3v7HNP9dhjRQ
	fgw9nlQQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99 #2 (Red Hat Linux))
	id 1vTRVc-00000007hrV-28ns;
	Wed, 10 Dec 2025 21:14:04 +0000
Date: Wed, 10 Dec 2025 21:14:04 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: Jan Kara <jack@suse.cz>,
	Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
	syzbot <syzbot+d222f4b7129379c3d5bc@syzkaller.appspotmail.com>,
	brauner@kernel.org, jlbec@evilplan.org, joseph.qi@linux.alibaba.com,
	linkinjeon@kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, mark@fasheh.com,
	ocfs2-devel@lists.linux.dev, sj1557.seo@samsung.com,
	syzkaller-bugs@googlegroups.com,
	Chuck Lever <chuck.lever@oracle.com>
Subject: Re: [PATCH for 6.19-rc1] fs: preserve file type in make_bad_inode()
 unless invalid
Message-ID: <20251210211404.GA1712166@ZenIV>
References: <6w4u7ysv6yxdqu3c5ug7pjbbwxlmczwgewukqyrap3ltpazp4s@ozir7zbfyvfj>
 <6930e200.a70a0220.d98e3.01bd.GAE@google.com>
 <CAGudoHE0Q-Loi_rsbk5rnzgtGfbvY+Fpo9g=NPJHqLP5G_AaUg@mail.gmail.com>
 <20251204082156.GK1712166@ZenIV>
 <CAGudoHGLFBq2Fg5ksJeVkn=S2pv6XzxenjVFrQYScA7QV9kwJw@mail.gmail.com>
 <7e2bd36e-3347-4781-a6fd-96a41b6c538d@I-love.SAKURA.ne.jp>
 <wqkxevwtev5p77czk2com5zvbbwcpxxeucrt7zbgjciqxjyivx@c7624klburuh>
 <CAGudoHE+WQBt4=Fb39qoYtwceHTWdgAamZDvDq1DAsAU9Qh=ng@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGudoHE+WQBt4=Fb39qoYtwceHTWdgAamZDvDq1DAsAU9Qh=ng@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Wed, Dec 10, 2025 at 11:24:40AM +0100, Mateusz Guzik wrote:

> I'm delighted to see the call is considered bogus.
> 
> As for being able to assert on it, I noted the current flag handling
> for lifecycle tracking is unhelpful.
> 
> Per your response, i_state == 0 is overloaded to mean the inode is
> fully sorted out *and* that it is brand new.
> 
> Instead clear-cut indicators are needed to track where the inode is in
> its lifecycle.
> 
> I proposed 2 ways: a dedicated enum or fucking around with flags.
> 
> Indeed the easiest stepping stone for the time being would be to push
> up I_NEW to alloc_inode and assert on it in places which set the flag.
> I'm going to cook it up.

You are misinterpreting what I_NEW is about - it is badly named, no
arguments here, but it's _not_ "inode is new".

It's "it's in inode hash, but if you find it on lookup, you'll need to wait -
it's not entirely set up".

A plenty of inodes never enter that state at all.  Hell, consider pipes.
Or sockets.  Or anything on procfs.  Or sysfs, or...

We never look those up by inumber and there'd be no sane way to do that
anyway.  They never get hashed, nor should they.

