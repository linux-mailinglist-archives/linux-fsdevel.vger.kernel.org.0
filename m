Return-Path: <linux-fsdevel+bounces-24748-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 58087944B93
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Aug 2024 14:42:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EDEB71F232FD
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Aug 2024 12:42:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B89EF1A071A;
	Thu,  1 Aug 2024 12:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="GdqDRy2H"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57CDD1A01DD;
	Thu,  1 Aug 2024 12:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722516146; cv=none; b=dkaisjdAgIbTCAeYB4N+uHAwDeO3Ju44al+K1dFYJkQuMOTld8/rxq4xbg6m7oqtnjDtlfAkUlcYKRxafjcYR/y3wbhm8inwk31jIs6u4Km896ZHd89PmQJjNLYwoofzcx6RZrDM6skGO4sMgAbDmS3xv8/+QYMeD5IZPlL6qG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722516146; c=relaxed/simple;
	bh=8gblgRnUR/JEShakrdy2+N4ynj2qYnnutQz6l5SNGxQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pVPHkBm3Wa6xRm1HDzSQ+azcI2lE/TrPIzFXnNpEDbCjYi9HPsoGV3t8nDqgpF5/g0x8A/3bx0RpEtb7airPVpXyfHyrrsf54RinrQHYsbnW8a8Un0/fiSSuquaBwyGUnAxoJ2B+eWhnm4uJRD/ATyljJtxsGOlCUr0mum2W+rM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=GdqDRy2H; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=pMQQzNfbi457Ibsk4dE+/1XaKuw031ErTABv/FKRRH0=; b=GdqDRy2H8MPUhP7jYr+yNflVXY
	pFZHh2PXPxTVaxS5UEbJx2gct0Fv/EOcEIkRNajq4wPjpcLSSM/RU8MYSxeEhrL3yYpMSlH4y0qxl
	oEU2scPJxckBOhUYB1AaBAoOOBKM2uyMs4w9HjjNuCtqyXFr0boDsmEQPdrlPeqnr1Iy6m+L3hh5a
	NRhSe9NXcLY8cfeEKki0B64NBwb3ommhtaxFXKqTfGrffK3exQiIgkn9GFuHmkTySA3RhLDTrJjjj
	+E228UYmqEAkONu/E8ceDs746n+A6DAYbC6RW0My4W8mEaBAmHQcfVVqvVxHADd1PGCxAWpkc0jpc
	rPjmCMvQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1sZV8O-00000000iaD-0pTX;
	Thu, 01 Aug 2024 12:42:20 +0000
Date: Thu, 1 Aug 2024 13:42:20 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Lizhi Xu <lizhi.xu@windriver.com>
Cc: brauner@kernel.org, jack@suse.cz, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, phillip@squashfs.org.uk,
	squashfs-devel@lists.sourceforge.net,
	syzbot+24ac24ff58dc5b0d26b9@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH] filemap: Init the newly allocated folio memory to 0 for
 the filemap
Message-ID: <20240801124220.GP5334@ZenIV>
References: <20240801071016.GN5334@ZenIV>
 <20240801081224.1252836-1-lizhi.xu@windriver.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240801081224.1252836-1-lizhi.xu@windriver.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Thu, Aug 01, 2024 at 04:12:24PM +0800, Lizhi Xu wrote:
> > 	* ->read_folio() had been called, claimed to have succeeded and
> > yet it had left something in range 0..inode->i_size-1 uninitialized.
> > Again, a bug, this time in ->read_folio() instance.
> read_folio, have you noticed that the file value was passed to read_folio is NULL? 
> fs/namei.c
> const char *page_get_link(struct dentry *dentry, struct inode *inode
> ...
> 5272  read_mapping_page(mapping, 0, NULL);
> 
> So, Therefore, no matter what, the value of folio will not be initialized by file
> in read_folio. 

What does struct file have to do with anything?  What it asks is the
first page of the address space of inode in question.

file argument of ->read_folio() is not how an instance determines which
filesystem object it's dealing with.  _That_ is determined by the
address space (mapping) the folio had been attached to.  For some
filesystems that is not enough - they need an information established
at open() time.  Those ->read_folio() instances can pick such stuff
from the file argument - and those obviously cannot be used with
page_get_link(), since for symlinks there's no opened files, etc.

Most of the instances do not use the 'file' argument.  In particular,
squashfs_symlink_read_folio() doesn't even look at it.

It would probably be less confusing if the arguments of ->read_folio()
went in the opposite order, but that's a separate story.  In any case,
"which filesystem object" is determined by folio->mapping, "which
offset in that filesystem object" comes from folio_pos(folio), not
that it realistically could be anything other than 0 in case of a symlink
(they can't be more than 4Kb long, so the first page will cover the
entire thing).

