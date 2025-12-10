Return-Path: <linux-fsdevel+bounces-71067-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C7072CB3555
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Dec 2025 16:39:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 733AC302652F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Dec 2025 15:35:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BFA9288C2B;
	Wed, 10 Dec 2025 15:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="kAxM+Tyu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF63313959D;
	Wed, 10 Dec 2025 15:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765380916; cv=none; b=nVJWJTQniEF2DqxgB9KrYLuhcXVVdQOTUoXQf/oQUeiTrKv1YWPEInmbXHqO+VWEXQjOAdITOGlJhCZ9b/+ap7p0x8ygWrboZ5R/Q9nzlxe25s4mAg5svXIe315x0iAF0HRktpTBZdTSlAGqzWO0ZCb2Wpvax8akjyPF6sy99ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765380916; c=relaxed/simple;
	bh=pQo3FFwc435SRzbAiXSrQr+k3PCIbdX/uw3cZPhM0Aw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ci+GbTaaQ+A473Wqq2vA7S+abi5Z/8NQQd+h0KjwZjIWhsRtJ22iadOfQeW2q0Asqao/Y1r1hFrrHYLm0qmagl4kG5lICbNvklfwxJfEZYWJ7vZ8hamXTIGB2R2EkIxNPAZygs2wGGDiKa0no4G12o/rR4pSJYePM1NlHETG1+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=kAxM+Tyu; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description;
	bh=XMUfKiLiKUE/eWtCHq/aAbZLEG6z8u2vawGPPocnPNo=; b=kAxM+TyuV1GCYcqxA9D6NwqvTc
	qhvplRo4xZ/poFYGfVRgLzQqIpi0qp0ll/vmZ4r+Y83dTtPXW5RgJmDSihwjlYwIHEXF8imNRsjXW
	pzsLG7955zdhF+YXrdNCmyPpyIyOXUtgkeMOO85UxC2ZL8rgJJvQQIo9BazXSKE8h6wDAdKrhMoqV
	hg40VBVqsUxL3pbYkTiMfAkXX9IQ0Z4G6dTJd3nmVnYQxGfh33kpoG4YPk99ukw61AH752Ku/6rix
	ROgh2DvGoGs9wkppcVRG78LiciZyYx+/1x0ygUjmU2r7zHzU8dpwBjBuCgJGbECM8VMvmKkXR/GOJ
	KABj7mPw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99 #2 (Red Hat Linux))
	id 1vTMDz-00000004Y0J-0K2y;
	Wed, 10 Dec 2025 15:35:31 +0000
Date: Wed, 10 Dec 2025 15:35:31 +0000
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
Message-ID: <20251210153531.GX1712166@ZenIV>
References: <6w4u7ysv6yxdqu3c5ug7pjbbwxlmczwgewukqyrap3ltpazp4s@ozir7zbfyvfj>
 <6930e200.a70a0220.d98e3.01bd.GAE@google.com>
 <CAGudoHE0Q-Loi_rsbk5rnzgtGfbvY+Fpo9g=NPJHqLP5G_AaUg@mail.gmail.com>
 <20251204082156.GK1712166@ZenIV>
 <CAGudoHGLFBq2Fg5ksJeVkn=S2pv6XzxenjVFrQYScA7QV9kwJw@mail.gmail.com>
 <7e2bd36e-3347-4781-a6fd-96a41b6c538d@I-love.SAKURA.ne.jp>
 <CAGudoHF7jPw347kqcDW2mFLzcJcYqiFLsbFtd-ngYG=vWUz8xQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGudoHF7jPw347kqcDW2mFLzcJcYqiFLsbFtd-ngYG=vWUz8xQ@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Wed, Dec 10, 2025 at 11:09:24AM +0100, Mateusz Guzik wrote:
> On Wed, Dec 10, 2025 at 10:45 AM Tetsuo Handa
> <penguin-kernel@i-love.sakura.ne.jp> wrote:
> >
> > syzbot is hitting VFS_BUG_ON_INODE(!S_ISDIR(inode->i_mode)) check
> > introduced by commit e631df89cd5d ("fs: speed up path lookup with cheaper
> > handling of MAY_EXEC"), for make_bad_inode() is blindly changing file type
> > to S_IFREG. Since make_bad_inode() might be called after an inode is fully
> > constructed, make_bad_inode() should not needlessly change file type.
> >
> 
> ouch
> 
> So let's say calls to make_bad_inode *after* d_instantiate are unavoidable.

... and each one is a bug.

