Return-Path: <linux-fsdevel+bounces-61124-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B6E91B55694
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Sep 2025 20:55:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 743C21D622E2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Sep 2025 18:56:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5E7C334702;
	Fri, 12 Sep 2025 18:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="i1X700ar"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F27703009F0
	for <linux-fsdevel@vger.kernel.org>; Fri, 12 Sep 2025 18:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757703335; cv=none; b=SiTYjZJD+n/Mld7zqEkcr9GWBqqfp2NMvtXCMR1h6ZtyshRA4QTmR9AE6kX7f9vqNepCcCY2Air7OetUT4BbLyf3UTzPJpRZwcLK7Bz9R6f7Rky+PsaD4PCa2fZu2g6nCvOLdlWWw20u07HfdDziiW9OB/hwMUIuWDrYHa3RwDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757703335; c=relaxed/simple;
	bh=ZXM2VOXVrvpeHqI5zxkdIfLPIeK3d3p2IggeAiRyEzk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ljV5sPVlU4NeMT2kaGSG1hJQQX6xY1kBVpUFHAD7MFjMn8RMcFmgw+I62vDUOSkPtx5DrzpC90I+zdQQs8BfvCzBorJKARTSoTrheKmM/HwGzCf5OPXOMbgWHaPuS3Fz815uKIILRP/njrZINPHjgQlXowza17ZLJxHP32I2dkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=i1X700ar; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=SdaIq14h3itz3IyHneGoAnZ5DhTO5ccTrePhL8RCSlE=; b=i1X700arE3NXwC7Wkk71x1LOUo
	APzficc2rRxwes8WmEC4VafrsY0iJFh/p5ygcG6sC+1sv06pnawV/GpOc3t/hmb1oXgkbDvRUiGhX
	C0LFRS/i20ePd+Sq10wEJG4kzOQercvp8TTvPJ14oonQgBvLT3WLVk338lZfM8odakrkls6yYw7P4
	FnNHx1A3p9zqEi+nzuQoRdFCUFwpRWQaxG39XrOtJDuvF1tko2gkHFhReGu+HJU/f5ixLlDjuceY2
	LAuPPbkZkX1AABLaSqLgtREdfnW/moahNpxfK2OtM+JNrUIQoUOYGAPvYDdSjw6yP3v5D/A4Y44tg
	cUoSbgTA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ux8vi-00000001dmz-38B6;
	Fri, 12 Sep 2025 18:55:30 +0000
Date: Fri, 12 Sep 2025 19:55:30 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: NeilBrown <neil@brown.name>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org, Jan Kara <jack@suse.cz>,
	Miklos Szeredi <miklos@szeredi.hu>
Subject: Re: ->atomic_open() fun (was Re: [RFC] a possible way of reducing
 the PITA of ->d_name audits)
Message-ID: <20250912185530.GZ39973@ZenIV>
References: <>
 <20250908090557.GJ31600@ZenIV>
 <175747234137.2850467.15661817300242450115@noble.neil.brown.name>
 <20250910072423.GR31600@ZenIV>
 <20250912054907.GA2537338@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250912054907.GA2537338@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Fri, Sep 12, 2025 at 06:49:07AM +0100, Al Viro wrote:
> On Wed, Sep 10, 2025 at 08:24:23AM +0100, Al Viro wrote:
> 
> > Note that these unwrap_dentry() are very likely to move into helpers - if some
> > function is always called with unwrapped_dentry(something) as an argument,
> > great, that's probably a candidate for struct stable_dentry.
> > 
> > I'll hold onto the current variant for now...
> 
> BTW, fun fallout from that experiment once I've got to ->atomic_open() - things
> get nicer if we teach finish_no_open() to accept ERR_PTR() for dentry:

See git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git #work.finish_no_open
Patches in followups.

Shortlog:
      allow finish_no_open(file, ERR_PTR(-E...))
      9p: simplify v9fs_vfs_atomic_open()
      9p: simplify v9fs_vfs_atomic_open_dotl()
      simplify cifs_atomic_open()
      simplify vboxsf_dir_atomic_open()
      simplify nfs_atomic_open_v23()
      simplify fuse_atomic_open()
      simplify gfs2_atomic_open()
      slightly simplify nfs_atomic_open()
Diffstat:
 fs/9p/vfs_inode.c      | 34 ++++++++++++----------------------
 fs/9p/vfs_inode_dotl.c | 15 +++++----------
 fs/fuse/dir.c          | 21 +++++++--------------
 fs/gfs2/inode.c        | 26 +++++++++-----------------
 fs/nfs/dir.c           | 18 +++++-------------
 fs/open.c              | 10 ++++++----
 fs/smb/client/dir.c    |  8 +-------
 fs/vboxsf/dir.c        | 25 +++++++++----------------
 8 files changed, 54 insertions(+), 103 deletions(-)

