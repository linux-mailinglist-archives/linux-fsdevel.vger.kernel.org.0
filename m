Return-Path: <linux-fsdevel+bounces-32292-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 81E589A3415
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Oct 2024 07:15:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 640501F24020
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Oct 2024 05:15:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7516517B4FC;
	Fri, 18 Oct 2024 05:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="z/x7GOEn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A9003BB24;
	Fri, 18 Oct 2024 05:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729228549; cv=none; b=kE4CdBt1TiUL8ucnfGFOpNYwEVfKhIPjlr5YuX8is5if2WbbIaw+4Tfd1vcf85hJgteed5KYl9uf9QTlH5ba1Gnlq+gGr4ldY3cL+/X1rtSuT+Pvm5W+sV/8kVfaCXqUxHPm5464OEOl3JQaOGB8oRmGYAHWNPX2abzPPquwz6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729228549; c=relaxed/simple;
	bh=osd+Afx7KZ986PJ9Yt3tyik2H2xn0VcmGztB3We7urE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iluWzqD0F92UU57BksjkIiY8pqnU78p0OtWT0OGe9XeNO1NTjE4X+CDv5MP8vLMkOYxl2+Qxw5iNyTm0MsAr8rLxemeG9bEK+7frCISAYKaAxbssPPtQBftScrs0g4W+uln4SHFDD5106jB6A8RZsPQFTD6YdL4kB2tWcyflBaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=z/x7GOEn; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=cny8j9MGeLy8h+jkGZlUWGSEbbVf30O3fi+EU6iRwhQ=; b=z/x7GOEnr7yw3kxAzfoJLMNa5k
	IL6FU8B2K6hoU03mRWfliedPompXVDs8XQYa2tDu0wC9yFVHxbQJKD13AoaZ219Z8yLYUtp3nQDvU
	kuOjL3bnKLyDzaujihKXe5u3kRL1w6LkoRelIuJ8L1Fx+73DKtx/5eD9711svAPybTJnoizGMt7tX
	FPhNgzj58xPH+Er6VmW2KFibBlFl4QCHUK/ui6x8ZOz0t+FoLaITw9vev06DgOSE5/GRk7yJ7Mtm2
	dvLtFgT0HDl0BU3kieH05pri7onhxBQ8DrL3aLQDOyJLyWNGDMszvaFdlHdrGV4utOA3217I/9FXv
	9+8VSDmQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1t1fKz-0000000Gwbz-05nQ;
	Fri, 18 Oct 2024 05:15:45 +0000
Date: Thu, 17 Oct 2024 22:15:44 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Jan Kara <jack@suse.cz>
Cc: Christoph Hellwig <hch@infradead.org>, Paul Moore <paul@paul-moore.com>,
	Trond Myklebust <trondmy@hammerspace.com>,
	"brauner@kernel.org" <brauner@kernel.org>,
	"mic@digikod.net" <mic@digikod.net>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"anna@kernel.org" <anna@kernel.org>,
	"linux-security-module@vger.kernel.org" <linux-security-module@vger.kernel.org>,
	"audit@vger.kernel.org" <audit@vger.kernel.org>,
	"linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
	"viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>
Subject: Re: [RFC PATCH v1 1/7] fs: Add inode_get_ino() and implement
 get_ino() for NFS
Message-ID: <ZxHvAN85R9gP0bml@infradead.org>
References: <20241010152649.849254-1-mic@digikod.net>
 <20241016-mitdenken-bankdaten-afb403982468@brauner>
 <CAHC9VhRd7cRXWYJ7+QpGsQkSyF9MtNGrwnnTMSNf67PQuqOC8A@mail.gmail.com>
 <5bbddc8ba332d81cbea3fce1ca7b0270093b5ee0.camel@hammerspace.com>
 <CAHC9VhQVBAJzOd19TeGtA0iAnmccrQ3-nq16FD7WofhRLgqVzw@mail.gmail.com>
 <ZxEmDbIClGM1F7e6@infradead.org>
 <CAHC9VhTtjTAXdt_mYEFXMRLz+4WN2ZR74ykDqknMFYWaeTNbww@mail.gmail.com>
 <ZxEsX9aAtqN2CbAj@infradead.org>
 <20241017164338.kzl7uotdyvhu5wv5@quack3>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241017164338.kzl7uotdyvhu5wv5@quack3>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Thu, Oct 17, 2024 at 06:43:38PM +0200, Jan Kara wrote:
> On Thu 17-10-24 08:25:19, Christoph Hellwig wrote:
> > On Thu, Oct 17, 2024 at 11:15:49AM -0400, Paul Moore wrote:
> > > Also good to know, thanks.  However, at this point the lack of a clear
> > > answer is making me wonder a bit more about inode numbers in the view
> > > of VFS developers; do you folks care about inode numbers?
> > 
> > The VFS itself does not care much about inode numbers.  The Posix API
> > does, although btrfs ignores that and seems to get away with that
> > (mostly because applications put in btrfs-specific hacks).
> 
> Well, btrfs plays tricks with *device* numbers, right? Exactly so that
> st_ino + st_dev actually stay unique for each file. Whether it matters for
> audit I don't dare to say :). Bcachefs does not care and returns non-unique
> inode numbers.

But st_ino + st_dev is the only thing Posix and thus historically Linux
has guaranteed to applications.  So if st_dev is unique, but you need
an unknown scope in which it is unique it might as well not be for
that purpose.  And I think for any kind of audit report that is true
as well.


