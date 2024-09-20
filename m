Return-Path: <linux-fsdevel+bounces-29758-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7170B97D72F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Sep 2024 16:58:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F25E8B215A4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Sep 2024 14:58:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF71B17C7BD;
	Fri, 20 Sep 2024 14:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="bNn7aERv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0D3379C0;
	Fri, 20 Sep 2024 14:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726844283; cv=none; b=ciKea8HcH9YC1ypHjcPgkMGwQJrluvgOLuIfHcjdY0SdtVs3e1kU/UAFaYEuOVD9PtuQ8cnFencFJGLL/8rVM98GoO0FwXIclME+Bcc1pL9oLhjJeqhaW9TAawupGKcvtgYcpxBfgtAK4O9f8jRJdyrFpcv2OvXB39Z0lO/TbTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726844283; c=relaxed/simple;
	bh=xLlPZDFOBSW3eGDp4aqkJYnYfkXMKpkjm/GIT13bbtY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b/LfUTKKQS20ovLvA1U9U6EtK6TlcsLTrXeQmncBHzlmD5WIByHIeo2+SxuaMdN0eF1jufDtycn6vr93CG2BxDiUh2B0fiuXcPFNtEYOv48itHl4un4CEpi/t0HZCgSVk0s//scG5ZgVEVRQFrqGu3aJWEKDMyY3dq+Rk89n3ZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=bNn7aERv; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=sM3xIsNGHfk6qJ40/HGhWZjWAtNDjNFmSVQjaIcGHWc=; b=bNn7aERvJUg4yJdWq5jEzgL0pQ
	Pxo1yECpjaHpEn8QiEONNI7ighCS9v+Mj7U2NmLnXMWmZPetQvBE5IHcW1YWgBBC2xP3/cE5bIso1
	QqOaqSM8Gp2TdVPZZgou9wpNlBDRzWKDvVLcyl9MCfGVL1d2pWx+2J8aMFl25UD+j3/FK6mXKmaTQ
	9qT1t9tsEm00V9Vmzktxn6WACStPjHm40PqPouuYE6/n/0I6yt07mCkDc1Z7f1z5PaXTFAMy0TAIo
	tMoJ1tbZF3P9YnUGivLeRBwboqipnSnpoq7s6kVXRFzqdkChZqbwxRDmqM7htZYMu30uZr+Q4E7Z6
	+Yv5B1Iw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1srf57-0000000CQhh-0C9Q;
	Fri, 20 Sep 2024 14:58:01 +0000
Date: Fri, 20 Sep 2024 07:58:01 -0700
From: Christoph Hellwig <hch@infradead.org>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>,
	Julian Sun <sunjunchao2870@gmail.com>,
	linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
	viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
	stable@vger.kernel.org
Subject: Re: [PATCH 3/3] vfs: return -EOVERFLOW in generic_remap_checks()
 when overflow check fails
Message-ID: <Zu2NeawWugiaWxKA@infradead.org>
References: <20240920123022.215863-1-sunjunchao2870@gmail.com>
 <Zu2EcEnlW1KJfzzR@infradead.org>
 <20240920143727.GB21853@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240920143727.GB21853@frogsfrogsfrogs>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Fri, Sep 20, 2024 at 07:37:27AM -0700, Darrick J. Wong wrote:
> On Fri, Sep 20, 2024 at 07:19:28AM -0700, Christoph Hellwig wrote:
> > On Fri, Sep 20, 2024 at 08:30:22PM +0800, Julian Sun wrote:
> > > Keep it consistent with the handling of the same check within
> > > generic_copy_file_checks().
> > > Also, returning -EOVERFLOW in this case is more appropriate.
> > 
> > Maybe:
> > 
> > Keep the errno value consistent with the equivalent check in
> > generic_copy_file_checks() that returns -EOVERFLOW, which feels like the
> > more appropriate value to return compared to the overly generic -EINVAL.
> 
> The manpage for clone/dedupe/exchange don't say anything about
> EOVERFLOW, but they do have this to say about EINVAL:
> 
> EINVAL
> The  filesystem  does  not  support  reflinking the ranges of the given
> files.

Which isn't exactly the integer overflow case described here :)

> Does this errno code change cause any regressions in fstests?

Given our rather sparse test coverage of it I doubt it, but it
would be great to have that confirmed by the submitter.

While we're talking about that - a simple exerciser for the overflow
condition for xfstests would be very useful to have.


