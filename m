Return-Path: <linux-fsdevel+bounces-16969-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C4DA8A5C59
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Apr 2024 22:45:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B6263B22367
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Apr 2024 20:45:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF09D156966;
	Mon, 15 Apr 2024 20:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="X5ErFfmS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30FCD6CDC2;
	Mon, 15 Apr 2024 20:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713213925; cv=none; b=HkkyxzGPfFX3UZDSVb87qKmrHkDzmcbHEOlzwH3IjNOm0ZCtJBnFgyhXxPON/b6EGCA2wtRf+vvrPK977k/Nj81u43uvzESBCKlL1jY0F37HjU4mXuTBcOrm0BxM6JCcC5m08ivN1tMlkHIl/lGgCYgXaMZhReWBX33x+nu6Cwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713213925; c=relaxed/simple;
	bh=zVZp6vV7iQarSGoxwWMF+Iaa2BswLI9de6pNtK3Ixtk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kc4Q8VDErFmee/Dww1gDErwfJRaILbjpjwBeClGml42Z8xyJKhXgwQsK1IGG3BOaUCwWyZOCKqF5uRwroJinp9KSbht3grnINMurlDZumB6J7gFaGA9miFJ8/6aLpRW98rrdaEi9j2AF40SOU++rd91GTknr2qWmSArmyGoitCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=X5ErFfmS; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=qhdJuTIMAv8tli03fOWPDDM7g+DFTCaWSXY5Y+FZsP8=; b=X5ErFfmSpkzJ7UA45H2dP/dOeC
	PP2i9Tiz2G2gNVcttlPIHZ+NhKFMAnmIIwz69mvFCUKEr4kTzoPNRettrA02TifXGWw0UzR6gp+Ks
	Evm11FF93pWgruOBSJTVBdyDtGxBGkIpoOwyNjHhGB8MijF0jeeXJ+5QOKuDF1Uce6edUSD8WRpsY
	10ZHbmjNljgb84syT25dr+LtMBCqGS7Lbc5MpB5Po+LesU6z6z0gTySKp1Mn+ETmNH+yumy960T2g
	vP8hWx44MLLhE0gZ8nEpVNLtqSbRsIYLIS5Za9UoEdHCDxYWXNY8Y3URi5SDor4Hy3IL/L7fxU0xV
	9TtiOdPQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1rwTCR-00D0Su-2p;
	Mon, 15 Apr 2024 20:45:11 +0000
Date: Mon, 15 Apr 2024 21:45:11 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>, Yu Kuai <yukuai1@huaweicloud.com>, hch@lst.de,
	axboe@kernel.dk, linux-fsdevel@vger.kernel.org,
	linux-block@vger.kernel.org, yi.zhang@huawei.com,
	yangerkun@huawei.com, "yukuai (C)" <yukuai3@huawei.com>
Subject: Re: [PATCH vfs.all 22/26] block: stash a bdev_file to read/write raw
 blcok_device
Message-ID: <20240415204511.GV2118490@ZenIV>
References: <8f414bc5-44c6-fe71-4d04-6aef3de8c5e3@huaweicloud.com>
 <20240409042643.GP538574@ZenIV>
 <49f99e7b-3983-8074-bb09-4b093c1269d1@huaweicloud.com>
 <20240410105911.hfxz4qh3n5ekrpqg@quack3>
 <20240410223443.GG2118490@ZenIV>
 <20240411-logik-besorgen-b7d590d6c1e9@brauner>
 <20240411140409.GH2118490@ZenIV>
 <20240412-egalisieren-fernreise-71b1f21f8e64@brauner>
 <20240412112919.GN2118490@ZenIV>
 <20240413-hievt-zweig-2e40ac6443aa@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240413-hievt-zweig-2e40ac6443aa@brauner>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Sat, Apr 13, 2024 at 05:25:01PM +0200, Christian Brauner wrote:

> > It also simplifies the hell out of the patch series - it's one obviously
> > safe automatic change in a single commit.
> 
> It's trivial to fold the simple file_mapping() conversion into a single
> patch as well.

... after a bunch of patches that propagate struct file to places where
it has no business being.  Compared to a variant that doesn't need those
patches at all.

> It's a pure artifact of splitting the patches per
> subsystem/driver.

No, it is not.  ->bd_mapping conversion can be done without any
preliminaries.  Note that it doesn't need messing with bdev_read_folio(),
it doesn't need this journal->j_fs_dev_file thing, etc.

One thing I believe is completely wrong in this series is bdev_inode()
existence.  It (and equivalent use of file_inode() on struct file is
even worse) is papering over the real interface deficiencies.  And
extra file_inode() uses are just about impossible to catch ;-/

IMO we should *never* use file_inode() on opened block devices.
At all.  It's brittle, it's asking for trouble as soon as somebody
passes a normally opened struct file to one of the functions using it
and it papers over the missing primitives.

As for the space concerns...  With struct device embedded into those
things, it's not even funny.  Space within the first cacheline - sure,
but we can have a pointer in there just fine.

