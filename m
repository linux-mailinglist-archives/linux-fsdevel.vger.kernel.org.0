Return-Path: <linux-fsdevel+bounces-31731-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 46E4599A7DD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Oct 2024 17:34:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E91A81F251A5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Oct 2024 15:34:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEED5195B37;
	Fri, 11 Oct 2024 15:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="lLgYVWvw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 646995381E;
	Fri, 11 Oct 2024 15:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728660879; cv=none; b=JQPwObNRVNokL3VuvEd6a5EgnpNljFVCJoPktsYOz9cMj280VMS+bIrfwOvrdnouoForXpIz/eyM+np3PGvEF8TfjtMUYp0cbWcYPof7dyRqQXUGQwCvZ+Sz+fSzvQ3K4j6s/CRToCL2IH3oryCtlYDk+paXJ+TsqruA0z9BXNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728660879; c=relaxed/simple;
	bh=dtcs1yN4pz+Zbu8KHjgOTEMBUEC8VG9TJOw5rXp6cgg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ri+hM9AXqYevIV5mWZGvDG3U77vdhDxOpX6AnwzBvkJ/fmPeJDiqHAcSkwQa7IYL8rIZPyfFuYF+7asMIIZazF7iRvZnFtQQHBYUrt55bG5W7oZp4dkkHHcikL6tSfpkh44vhzi3UPkD1aF+6+7HNfR7iAkIEQYsa7VCLW3SjL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=lLgYVWvw; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Transfer-Encoding
	:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=V5IK78oxLAcUke4+8ve0ylm+nCiIdwlDSu6wnFwD3fQ=; b=lLgYVWvwIbQuKavphrC2s+Zo+a
	yp6uiYGdPJKOvLMrF5lWNo1w3tIe8Tk1cy0z9jURe4qUe6LYYqYMqiIu/8bq6IdvqxXYSYC/5daPe
	xdiYL44Y1hUfz2NRhrYeI0xR7J9mNvDd7hQFfdbJf03e/7xBay/CEwa1JgRysSJ2W/jnWYVzVDMSF
	ptG2V3fl9oUNjfEn0piSuHpqk6j3821IdiKpc7xp71S+PQrkS6pzP6Ial1cHTLiT+ypVd1Fr7ksxh
	Nk4hYnt3IanT0tE4DMGGkvynCqFwc37lQPI2sgfyZ51VciibVmrGbbGl57qrDup+/u0oCk78P31Jd
	mvyCLsHg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1szHf1-0000000Goqs-2W9z;
	Fri, 11 Oct 2024 15:34:35 +0000
Date: Fri, 11 Oct 2024 08:34:35 -0700
From: Christoph Hellwig <hch@infradead.org>
To: =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
Cc: Christoph Hellwig <hch@infradead.org>,
	Christian Brauner <brauner@kernel.org>,
	Paul Moore <paul@paul-moore.com>, linux-fsdevel@vger.kernel.org,
	linux-nfs@vger.kernel.org, linux-security-module@vger.kernel.org,
	audit@vger.kernel.org, Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>
Subject: Re: [RFC PATCH v1 1/7] fs: Add inode_get_ino() and implement
 get_ino() for NFS
Message-ID: <ZwlFi5EI08LlJPSw@infradead.org>
References: <20241010152649.849254-1-mic@digikod.net>
 <ZwkaVLOFElypvSDX@infradead.org>
 <20241011.ieghie3Aiye4@digikod.net>
 <ZwkgDd1JO2kZBobc@infradead.org>
 <20241011.yai6KiDa7ieg@digikod.net>
 <Zwkm5HADvc5743di@infradead.org>
 <20241011.aetou9haeCah@digikod.net>
 <Zwk4pYzkzydwLRV_@infradead.org>
 <20241011.uu1Bieghaiwu@digikod.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241011.uu1Bieghaiwu@digikod.net>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Fri, Oct 11, 2024 at 05:30:59PM +0200, Mickaël Salaün wrote:
> > It still is useless.  E.g. btrfs has duplicate inode numbers due to
> > subvolumes.
> 
> At least it reflects what users see.

Users generally don't see inode numbers.

> > If you want a better pretty but not useful value just work on making
> > i_ino 64-bits wide, which is long overdue.
> 
> That would require too much work for me, and this would be a pain to
> backport to all stable kernels.

Well, if doing the right thing is too hard we can easily do nothing.

In case it wan't clear, this thread has been a very explicit:

Reviewed-by: Christoph Hellwig <hch@lst.de>



