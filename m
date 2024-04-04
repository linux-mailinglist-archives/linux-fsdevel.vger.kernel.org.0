Return-Path: <linux-fsdevel+bounces-16101-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 834D6898312
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Apr 2024 10:21:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D77D28A889
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Apr 2024 08:21:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 238E96BFCF;
	Thu,  4 Apr 2024 08:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="LKX6QRFc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E1D86BFCA;
	Thu,  4 Apr 2024 08:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712218877; cv=none; b=QkXkAFSM3xWBL/5uwyJtdQU/EfpTCQpBDb0Fj5pf6+ikuUMhIIi0Phyg8SWx8UKx5G7VcuQgaR0aYxVdIvj4nF6mVgZuZL8Sdqos2SVoKXVM/+gZoEYpqGpJX/Lr9PHmJp95+pkLdflMGI3IORnAOwZ16qgG0XDwGR7isL/InSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712218877; c=relaxed/simple;
	bh=Acyil7j8/P31cOKAJPpVlwtUr0va8+DJClK+VO0IqGg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=czfgzNF7FTwt3kwtQXTqAjG9kScrYYB7YrfCsmQck/KMefX8JDMAd3b0XxNTjuPcPRxVqQ2egLFMlHURLYClgdYUp6LlPk/nOTWh11MSdZYud00+i/lXJTtY1+0oxp4dH3IZu+4RDptcN7QmzNFpr+H7p6djLQOLDiP/Ho5tT6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=LKX6QRFc; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=yziZYBQv3fFAnW9aFpGuFJzKlMqpWT757MMOV+blJms=; b=LKX6QRFcPYNkiHJAL3m+TWQuDa
	ceU8jlDlq81xztSK7pGOL1tFnam3NCpR9vh9jjlle9Zv2FwyQOrza6Yur6dY4uRhTqJtC2RYew8qE
	11G6CXm2IqW5wo/hXzhHuPdYYxq/cCEV3gtkJhVAffbzPHkLT9MHFWYNQiVPQk0/hb+odFVRAaiRK
	ZEJVL3R5xN4SPP3jm/gisbOwGfke/376PO5wvNJywA5/UQn4cYCrrcjbZh6z/u4WAAdAjYSwmHzs8
	sT1qM60sIYQPptQRNJoXwdSSrXZBEi+Of8uhhcuGeZ1i4Bd6r5ag3nE71YM0x9rHFe9QSSvbcXtRy
	6cOzqjYQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1rsILO-005S0X-1R;
	Thu, 04 Apr 2024 08:21:10 +0000
Date: Thu, 4 Apr 2024 09:21:10 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Amir Goldstein <amir73il@gmail.com>
Cc: syzbot <syzbot+9a5b0ced8b1bfb238b56@syzkaller.appspotmail.com>,
	gregkh@linuxfoundation.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
	tj@kernel.org, valesini@yandex-team.ru,
	Christoph Hellwig <hch@lst.de>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Miklos Szeredi <miklos@szeredi.hu>
Subject: Re: [syzbot] [kernfs?] possible deadlock in kernfs_fop_llseek
Message-ID: <20240404082110.GR538574@ZenIV>
References: <00000000000098f75506153551a1@google.com>
 <0000000000002f2066061539e54b@google.com>
 <CAOQ4uxiS5X19OT2MTo_LnLAx2VL9oA1zBSpbuiWMNy_AyGLDrg@mail.gmail.com>
 <20240404081122.GQ538574@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240404081122.GQ538574@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Thu, Apr 04, 2024 at 09:11:22AM +0100, Al Viro wrote:
> On Thu, Apr 04, 2024 at 09:54:35AM +0300, Amir Goldstein wrote:
> > 
> > In the lockdep dependency chain, overlayfs inode lock is taken
> > before kernfs internal of->mutex, where kernfs (sysfs) is the lower
> > layer of overlayfs, which is sane.
> > 
> > With /sys/power/resume (and probably other files), sysfs also
> > behaves as a stacking filesystem, calling vfs helpers, such as
> > lookup_bdev() -> kern_path(), which is a behavior of a stacked
> > filesystem, without all the precautions that comes with behaving
> > as a stacked filesystem.
> 
> No.  This is far worse than anything stacked filesystems do - it's
> an arbitrary pathname resolution while holding a lock.
> It's not local.  Just about anything (including automounts, etc.)
> can be happening there and it pushes the lock in question outside
> of *ALL* pathwalk-related locks.  Pathname doesn't have to
> resolve to anything on overlayfs - it can just go through
> a symlink on it, or walk into it and traverse a bunch of ..
> afterwards, etc.
> 
> Don't confuse that with stacking - it's not even close.
> You can't use that anywhere near overlayfs layers.
> 
> Maybe isolate it into a separate filesystem, to be automounted
> on /sys/power.  And make anyone playing with overlayfs with
> sysfs as a layer mount the damn thing on top of power/ in your
> overlayfs.  But using that thing as a part of layer is
> a non-starter.

Incidentally, why do you need to lock overlayfs inode to call
vfs_llseek() on the underlying file?  It might (or might not)
need to lock the underlying file (for things like ->i_size,
etc.), but that will be done by ->llseek() instance and it
would deal with the inode in the layer, not overlayfs one.

Similar question applies to ovl_write_iter() - why do you
need to hold the overlayfs inode locked during the call of
backing_file_write_iter()?

