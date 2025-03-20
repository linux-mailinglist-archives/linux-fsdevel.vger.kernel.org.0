Return-Path: <linux-fsdevel+bounces-44596-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D074DA6A8BC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Mar 2025 15:38:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 82560188AD2C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Mar 2025 14:31:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DC311CDFC1;
	Thu, 20 Mar 2025 14:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="hpptel6x"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62BAC155398;
	Thu, 20 Mar 2025 14:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742481075; cv=none; b=kKtvhXsqyAaHwocM/8OWM+5lAzynGdKC9R6ufeYSQLgpWBPORFFeNFyID2b6JZgAKZir4uv6z3YHCrtYSqp7aFN32WP0UJ7W5wts6nnyUGgYOafbtgx1ufnFYX3tXI+nR+dd1tVeMZX5PFYUJHJ4Ev0K0T255TG2rhylBMLTmfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742481075; c=relaxed/simple;
	bh=FFSIXT5DcGX7/dkepbl74FSQUrt+QKc/N+V3dVJVCKk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UtfZyIq48HUfzrKB417Pfb9mLggIMUR0Hn6U2W/pXI5At5blcCAN+ipbt3H+87u5s1xaBWBrtbyzc/wW5U7aRVlLuAcfQroIKLPp0Kd1ztXkgI1tIQJTtq6iX1MtPlxJZ08/WydAyrzsZUjZTg4AUI0ssLH15qP4MSFl7xvAWyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=hpptel6x; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=NJZJ1FkgbSm88M1HAHaut+9UWjO501+rWTX6iMm1JYs=; b=hpptel6xf9qMXLORgmovdqNhsc
	x/1Qb0Kfq49q3b9UnlTmYq6W8erzzsDExlykz63TG9LKnT2bJXWX2L3kB5tywslbUyur3+MK9WfWe
	3885xJ52ZM3P7Wspdlg0Mi/ahv5vBXr90doJLvQOONPhfQHVdpvxnh/x/rGn3NCJA2qfj2+KPWpGA
	wNQ812jt2LFC5N7+Sxb1KBZv5lJIVF9VAPsd/24oHrFoWAmIYrnNmBx8+9KscmD/NPbmftmbaAY8X
	M30c0nhdu9CxMt/7sAMeZqZ6zCuF55sx80DoF2xCtt2UAvoTB+gpIuNu5vnjLf+m703v1WCFwFE2c
	ek+FXj5Q==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tvGvL-0000000BzxE-2fcV;
	Thu, 20 Mar 2025 14:31:07 +0000
Date: Thu, 20 Mar 2025 14:31:07 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Daniel Gomez <da.gomez@kernel.org>
Cc: Luis Chamberlain <mcgrof@kernel.org>, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org, linux-block@vger.kernel.org,
	lsf-pc@lists.linux-foundation.org, david@fromorbit.com,
	leon@kernel.org, hch@lst.de, kbusch@kernel.org, sagi@grimberg.me,
	axboe@kernel.dk, joro@8bytes.org, brauner@kernel.org, hare@suse.de,
	djwong@kernel.org, john.g.garry@oracle.com, ritesh.list@gmail.com,
	p.raghav@samsung.com, gost.dev@samsung.com, da.gomez@samsung.com
Subject: Re: [LSF/MM/BPF TOPIC] breaking the 512 KiB IO boundary on x86_64
Message-ID: <Z9wmq0UH3V7-Y4OZ@casper.infradead.org>
References: <Z9v-1xjl7dD7Tr-H@bombadil.infradead.org>
 <Z9wGA9z_cVn6Mfa1@casper.infradead.org>
 <t5zqyoxwjkl2su6ypfo6p4toliwq6opktufhibd4wwhfrjs26r@k56hbgmr2hwz>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <t5zqyoxwjkl2su6ypfo6p4toliwq6opktufhibd4wwhfrjs26r@k56hbgmr2hwz>

On Thu, Mar 20, 2025 at 02:29:56PM +0100, Daniel Gomez wrote:
> On Thu, Mar 20, 2025 at 12:11:47PM +0100, Matthew Wilcox wrote:
> > On Thu, Mar 20, 2025 at 04:41:11AM -0700, Luis Chamberlain wrote:
> > > We've been constrained to a max single 512 KiB IO for a while now on x86_64.
> > ...
> > > It does beg a few questions:
> > > 
> > >  - How are we computing the new max single IO anyway? Are we really
> > >    bounded only by what devices support?
> > >  - Do we believe this is the step in the right direction?
> > >  - Is 2 MiB a sensible max block sector size limit for the next few years?
> > >  - What other considerations should we have?
> > >  - Do we want something more deterministic for large folios for direct IO?
> > 
> > Is the 512KiB limit one that real programs actually hit?  Would we
> > see any benefit from increasing it?  A high end NVMe device has a
> > bandwidth limit around 10GB/s, so that's reached around 20k IOPS,
> > which is almost laughably low.
> 
> Current devices do more than that. A quick search gives me 14GB/s and 2.5M IOPS
> for gen5 devices:
> 
> https://semiconductor.samsung.com/ssd/enterprise-ssd/pm1743/
> 
> An gen6 goes even further.

That kind of misses my point.  You don't need to exceed 512KiB I/Os to
be bandwidth limited.  So what's the ROI of all this work?  Who benefits?

