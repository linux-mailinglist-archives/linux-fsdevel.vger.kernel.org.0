Return-Path: <linux-fsdevel+bounces-73474-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DECCD1A5DD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jan 2026 17:43:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7DF8530101E6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jan 2026 16:43:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0559C32D0C6;
	Tue, 13 Jan 2026 16:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="qS3EqQrc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1E6A1C6FEC;
	Tue, 13 Jan 2026 16:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768322632; cv=none; b=r+2ihHUvNzrvGkvkXthCBt1AF4ssTyPT3GsYrXht4leyJx/xD4nlvfL4ZN2XaGYDWrqaKkCzPOcgQN2jfyhoq0tFM45LWMx7sebjDFJ3p5yrWZ3DnpJFlsN011/R+LzTTWMYJ8uYu1hZWHfcEhcNcXvhDXfHMWQwbjD1mJxVAWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768322632; c=relaxed/simple;
	bh=NMqxxlOAgk3XJh1EycDr3gEn8yn+72f/zrMKEi7l97I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ws5V5ZjuXYc7jS79fIyzBcIZU34zfDPs2Xs5HfrS5/AQWkeY9EPsQzSOS4YxseG4nJcGdrxhTs5jmOS7/+qNl1o1ykIGw/UIIOBad6ZZNzYE1uYDXPoKiW3LajmLKeGlNLwNSFlFOoxC48bQmPp+qlSLKnCRR6Kk4U4Q1Fa4eaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=qS3EqQrc; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=rrd23abrfF9IgVimRFIJcD0iQbZ50CTcPWqeJLMLmGI=; b=qS3EqQrcuXUylpQX+ZLhXwTXSK
	WEOeNVj+Q32YOxtSTZBnDS0h3bZVpD4hiX7fwsjv1wsyuna/6myAUxtOS5DmRHBc+fnQ4xtUOONwr
	Zx/721+QEa5UGBvSsWw7PiLUCG3aAwds4gtMHfBjxrqQZK3AycgrAPL5JS0Wdc1OW3xoG13sB+l06
	FzMvzaHw8U6g7pnJ27ZB8JENTz7dsMCZJrl/DdlMI/GWBzFxOQAhFLDxUoEARLhwy9kVSZDDofrnb
	n6Nhw4N0l+AWaVeqBGwHHpthg8jAe/3YtYHTZF86F15ATBohWTFbNqxd4W1dO44iKpj98qtE2rL4m
	lMtolrJw==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vfhUi-00000004yVv-2G6q;
	Tue, 13 Jan 2026 16:43:48 +0000
Date: Tue, 13 Jan 2026 16:43:48 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Christoph Hellwig <hch@lst.de>
Cc: "Darrick J. Wong" <djwong@kernel.org>,
	Andrey Albershteyn <aalbersh@redhat.com>, fsverity@lists.linux.dev,
	linux-xfs@vger.kernel.org, ebiggers@kernel.org,
	linux-fsdevel@vger.kernel.org, aalbersh@kernel.org,
	david@fromorbit.com
Subject: Re: [PATCH v2 4/22] iomap: allow iomap_file_buffered_write() take
 iocb without file
Message-ID: <aWZ2RL3oBQGUmLvF@casper.infradead.org>
References: <cover.1768229271.patch-series@thinky>
 <kibhid6bipmrndfn774tlbm6wcitya5qydhjws3n6tnjvbd4a3@bui63p535b3q>
 <20260112222215.GJ15551@frogsfrogsfrogs>
 <20260113081535.GC30809@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260113081535.GC30809@lst.de>

On Tue, Jan 13, 2026 at 09:15:35AM +0100, Christoph Hellwig wrote:
> On Mon, Jan 12, 2026 at 02:22:15PM -0800, Darrick J. Wong wrote:
> > > +		iter.inode = iocb->ki_filp->f_mapping->host;
> > > +	} else {
> > > +		iter.inode = (struct inode *)private;
> > 
> > @private is for the filesystem implementation to access, not the generic
> > iomap code.  If this is intended for fsverity, then shouldn't merkle
> > tree construction be the only time that fsverity writes to the file?
> > And shouldn't fsverity therefore have access to the struct file?
> 
> It's not passed down, but I think it could easily.

willy@deadly:~/kernel/linux$ git grep ki_filp |grep file_inode | wc
    109     575    7766
willy@deadly:~/kernel/linux$ git grep ki_filp |wc
    367    1920   23371

I think there's a pretty strong argument for adding ki_inode to
struct kiocb.  What do you think?

