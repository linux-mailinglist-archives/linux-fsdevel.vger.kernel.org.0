Return-Path: <linux-fsdevel+bounces-31895-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CF7F99CDD9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Oct 2024 16:36:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 433FF1F23C27
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Oct 2024 14:36:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D05901AB528;
	Mon, 14 Oct 2024 14:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="qyWRKClG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51CCB4A24;
	Mon, 14 Oct 2024 14:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728916612; cv=none; b=RNW083L+qzbIbdHyNfVG2ZYeG18DbN8cT+qzl+WKTExzOZ8Q8yZ+LdCkvbPGHCta+s5sB7z6wMvoanG7+V4QHTWnOYySK3+zM7455qCFgREn/VUmth0jnjFr3hijyDrP7BkUqnbtKdfnqBVsAmbq1Mx3v7baqXffVZ8tIpUXulQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728916612; c=relaxed/simple;
	bh=a17wj1fpZ+H8mC1MF5Iaz/zlp1u6RUFIl7R6Wtx2vQ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DkOaW4637IXoOi1YyZZL32OJ7DzEsoSz3gNTr2cK8peJJg2L+PObGhph3qm6O64ayMV9dGvPWHCXPxxNSQOuk8w27dni4wJabE33WllBFybF/M1IEj3gavyocgvbSK+8rHyWD5/wWe+xvQynTkeY2tLqFgPcf8N0tJzjxdB2wU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=qyWRKClG; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Transfer-Encoding
	:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=5whK65xImY1XLJT9s0enelnU9ozp+FPhsm4k2nB1vp8=; b=qyWRKClGctdrj5A1w0BnCtmOZ6
	/D0ZR/YP4D3Jk4/flgBvfSJsD/kouNBE9puyVND+LtLyxg0vkb0nUNWuANFuiisRuKqEQwv3fRkyj
	tN6Ajlwu52e4nJeGu79sA0oYt40wC5+3mVz/h7JNqWq1gq5lN7D68Z+ShWGW1c4omcCMoYN6S3NHh
	heVabAsmjG2WzUUR7mbJ0oGyhiaMn0g40zBsf9gV1P2OeihmA7IGAP0j8zEEEDivlnuXcbVmIDzwa
	yQGdTGi+k/HZvZlUc+tmmSPW/1F97cZUumJjOX+HgoOosCyQjcDuby6KMII2KwRru3orCcyIXmQF8
	iMAY1AUg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1t0MBj-00000005Uwi-3aFm;
	Mon, 14 Oct 2024 14:36:47 +0000
Date: Mon, 14 Oct 2024 07:36:47 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Christian Brauner <brauner@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>,
	=?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
	Paul Moore <paul@paul-moore.com>, linux-fsdevel@vger.kernel.org,
	linux-nfs@vger.kernel.org, linux-security-module@vger.kernel.org,
	audit@vger.kernel.org, Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>
Subject: Re: [RFC PATCH v1 1/7] fs: Add inode_get_ino() and implement
 get_ino() for NFS
Message-ID: <Zw0sf6O5LKQHAqkZ@infradead.org>
References: <ZwkaVLOFElypvSDX@infradead.org>
 <20241011.ieghie3Aiye4@digikod.net>
 <ZwkgDd1JO2kZBobc@infradead.org>
 <20241011.yai6KiDa7ieg@digikod.net>
 <Zwkm5HADvc5743di@infradead.org>
 <20241011.aetou9haeCah@digikod.net>
 <Zwk4pYzkzydwLRV_@infradead.org>
 <20241011.uu1Bieghaiwu@digikod.net>
 <ZwlFi5EI08LlJPSw@infradead.org>
 <20241014-nostalgie-gasflasche-ccef8ea53bc8@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241014-nostalgie-gasflasche-ccef8ea53bc8@brauner>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Mon, Oct 14, 2024 at 04:35:24PM +0200, Christian Brauner wrote:
> On Fri, Oct 11, 2024 at 08:34:35AM -0700, Christoph Hellwig wrote:
> > On Fri, Oct 11, 2024 at 05:30:59PM +0200, Mickaël Salaün wrote:
> > > > It still is useless.  E.g. btrfs has duplicate inode numbers due to
> > > > subvolumes.
> > > 
> > > At least it reflects what users see.
> > 
> > Users generally don't see inode numbers.
> > 
> > > > If you want a better pretty but not useful value just work on making
> > > > i_ino 64-bits wide, which is long overdue.
> > > 
> > > That would require too much work for me, and this would be a pain to
> > > backport to all stable kernels.
> > 
> > Well, if doing the right thing is too hard we can easily do nothing.
> > 
> > In case it wan't clear, this thread has been a very explicit:
> > 
> > Reviewed-by: Christoph Hellwig <hch@lst.de>
> 
> This must be typo and you want a NAK here, right?

Yes :)

