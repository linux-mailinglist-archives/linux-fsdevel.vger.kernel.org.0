Return-Path: <linux-fsdevel+bounces-20405-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CB018D2D5C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 May 2024 08:34:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF1D81F25A13
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 May 2024 06:34:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8593915FA9E;
	Wed, 29 May 2024 06:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="uENoG1Zn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC73515B14D;
	Wed, 29 May 2024 06:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716964474; cv=none; b=kWqjYfVIX1IUenJ9BmdGgDZjUppJAuqTafgMSMRWwbiGfsHi5s7FJAmimFrZhJ5Rjwv0nl0Tyw+gLGmw/6MoBRiafP4FkIzwemhfkCMVlvw6C+MCZ4bdI15fusUjU6KbJJdNFrPVK/6QVQnO7REfAT33GmiZMkKK//AeaBSlYH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716964474; c=relaxed/simple;
	bh=UJG3C7EBMDjny9IFJF1bwm2VemwEnL8DukEB9yRxuiY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i9cM2oNh7ngOB+I1a8PwEoKXhmKvFlEQ+YIslRxy4pE+lI1l2qHQ0e+jAo5Kcx/ULXhT4m2Eao+c8x+bmpz7qR1xXpk1JAByYhjJFo9H95y2Tl9E6gPgu+hSS+tXW0QteYfagNdZlhRWMiwLIPXsCamtS8fJRlsBbmUQ85qH1oY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=uENoG1Zn; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Rx87dGz3DyMKaLnAETMLgQ1KIZQ/AQu9Pno6waQB1SQ=; b=uENoG1ZnzwGU2je4euK44xlcX/
	s+rFRqQvb2EDF5T3605za7qYSwhyhGWSqfkrjPFtQwI9hRAl+4EVg1WdlzAMtUg0d2UUbW60qFKRw
	dsP0DZ5ORvaE80Xt/luLVDa0V6bu55dGz+bkwubLx4CAqYT9kKoCtaxk0Z4npO93Oy+zUT0zUmrlq
	T2J+5dFzyuvZq+73+t2kWscrX6qyNFjCVLnJrn4ANxdhmbaxSewKl4vQDI1jCdp/J01NUFdMOd+D4
	QPrKyT8hWL74Ee4SInYYEdYlPimc+djRE4aQdUT4xS3iSEzaMTunAcpE2AVp+DUcJqX/+EKG9qrqd
	fveMldCg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sCCtI-000000031cF-3Anh;
	Wed, 29 May 2024 06:34:28 +0000
Date: Tue, 28 May 2024 23:34:28 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Christoph Hellwig <hch@infradead.org>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Aleksa Sarai <cyphar@cyphar.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	Amir Goldstein <amir73il@gmail.com>,
	Alexander Aring <alex.aring@gmail.com>,
	linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-api@vger.kernel.org
Subject: Re: [PATCH RFC v2] fhandle: expose u64 mount id to
 name_to_handle_at(2)
Message-ID: <ZlbMdNiwLsLF-gp0@infradead.org>
References: <ZlRy7EBaV04F2UaI@infradead.org>
 <20240527133430.ifjo2kksoehtuwrn@quack3>
 <ZlSzotIrVPGrC6vt@infradead.org>
 <20240528-wachdienst-weitreichend-42f8121bf764@brauner>
 <ZlWVkJwwJ0-B-Zyl@infradead.org>
 <20240528-gesell-evakuieren-899c08cbfa06@brauner>
 <ZlW4IWMYxtwbeI7I@infradead.org>
 <20240528-gipfel-dilemma-948a590a36fd@brauner>
 <ZlXaj9Qv0bm9PAjX@infradead.org>
 <CAJfpegvznUGTYxxTzB5QQHWtNrCfSkWvGscacfZ67Gn+6XoD8w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJfpegvznUGTYxxTzB5QQHWtNrCfSkWvGscacfZ67Gn+6XoD8w@mail.gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Tue, May 28, 2024 at 03:28:18PM +0200, Miklos Szeredi wrote:
> > open_by_handle_at looks up the superblock based on that identifier.
> 
> The open file needs a specific mount, holding the superblock is not
> sufficient.

A strut file needs a vfsmount, yes.  And it better be reachable by
the calling process.  And maybe an optional restriction to a specific
mount by the caller might be useful, but I can't see how it is
required.


