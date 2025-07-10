Return-Path: <linux-fsdevel+bounces-54466-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8A44AFFFBB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Jul 2025 12:52:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C6ED585AE6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Jul 2025 10:52:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF6A02E11B3;
	Thu, 10 Jul 2025 10:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Dm3pPM7c"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 267D82D8768;
	Thu, 10 Jul 2025 10:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752144741; cv=none; b=W6OAxcbX9Ue9vu/4dJtdKh6FFQJaK6cdSmL01bLXdeJazUGxSV25K/qzk50c5/847GKCZ5b8kp1iKgt6IuXPbNiV9XQRO2B2XOutg7E4ZV49AXDlmqIdkQ2CKRA+LAiUhXVLQCnBxMicftNp8GJlN/2WzQXQ0tfGK6l82MSNWfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752144741; c=relaxed/simple;
	bh=OnzF6zERF2Wd7dzv2bE8bz5C/WLRizQMHeRtow+jIyY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mUMq6SYo/JctrGuX7UsllLgSoEA5/h/jOkjBid4BlYW2PrSJOLSPF+u0+29l08nNymYRurRXns0BvoSLHB+BSuivMa7BopAGwe+DMGb7jQgTY+kL7woTc2D9H0IAzx4E2+QQ/fFRli2F4cy3PfpXOtrN7DOrvf4DZtWrGfLqDIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Dm3pPM7c; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=u1eaudNPVeAZbSLRXaRe9plXy7/FDJiKHHZiSs3H4Xc=; b=Dm3pPM7cRSE+b6P/cXV9uhSjKt
	TMj5rh7HMRFJzT33tBZ192h5K7Y5D/Pf8ennSpCcvELyu/yLlIlrQjXiUAVN0IsYRI6XHTqITuZSJ
	JeskD+Nu9ypEbFKSU8CMoe6XoYfFDWWREYGwL5HyDasavaHZdiFpb0tuQSWILVLB8sx1wVYT8pcgi
	7dLtNOSTC0/7G8OlQX7XBTktia2te1ms+Ym7kmqgsqgybhVCiRE0WBHcyXEtw2TeSs5mSyw7raNpO
	26fL2mh8F7sJiYO35rHefsOwDKP7UzvczcJ0+eBwRmVRie5itjxAcxHuN3APM630A5CSxG2H6oN/K
	3VP0A+ig==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uZosy-0000000BXWp-1ouf;
	Thu, 10 Jul 2025 10:52:16 +0000
Date: Thu, 10 Jul 2025 03:52:16 -0700
From: Christoph Hellwig <hch@infradead.org>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Qu Wenruo <quwenruo.btrfs@gmx.com>, Dave Chinner <david@fromorbit.com>,
	Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk,
	brauner@kernel.org, jack@suse.cz, linux-ext4@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net, ntfs3@lists.linux.dev,
	linux-xfs@vger.kernel.org
Subject: Re: [PATCH v4 1/6] fs: enhance and rename shutdown() callback to
 remove_bdev()
Message-ID: <aG-bYCFix5lcPyqg@infradead.org>
References: <cover.1751589725.git.wqu@suse.com>
 <de25bbdb572c75df38b1002d3779bf19e3ad0ff6.1751589725.git.wqu@suse.com>
 <aGxSHKeyldrR1Q0T@dread.disaster.area>
 <dbd955f7-b9b4-402f-97bf-6b38f0c3237e@gmx.com>
 <20250708004532.GA2672018@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250708004532.GA2672018@frogsfrogsfrogs>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Mon, Jul 07, 2025 at 05:45:32PM -0700, Darrick J. Wong wrote:
> On second thought -- it's weird that you'd flush the filesystem and
> shrink the inode/dentry caches in a "your device went away" handler.
> Fancy filesystems like bcachefs and btrfs would likely just shift IO to
> a different bdev, right?  And there's no good reason to run shrinkers on
> either of those fses, right?

No nmeed for fancy file systems, this is weird no matter what.  But it
is what Linux has done for 30+ years, so I kept it when refactoring
this code to sit in a callback.

> > Yes, the naming is not perfect and mixing cause and action, but the end
> > result is still a more generic and less duplicated code base.
> 
> I think dchinner makes a good point that if your filesystem can do
> something clever on device removal, it should provide its own block
> device holder ops instead of using fs_holder_ops.  I don't understand
> why you need a "generic" solution for btrfs when it's not going to do
> what the others do anyway.

Why?  You're most likely to get the locking wrong, and so on.

What might make sense is to move the sync_filesystem, shrink_dcache_sb
and evict_inodes into the method.  That way file systems where we

> As an aside:
> 'twould be nice if we could lift the *FS_IOC_SHUTDOWN dispatch out of
> everyone's ioctl functions into the VFS, and then move the "I am dead"
> state into super_block so that you could actually shut down any
> filesystem, not just the seven that currently implement it.

Sure.  Someone just needs to do the work..


