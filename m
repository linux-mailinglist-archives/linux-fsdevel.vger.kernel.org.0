Return-Path: <linux-fsdevel+bounces-46339-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B028A8778C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Apr 2025 07:51:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 84BFC16F3A6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Apr 2025 05:51:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 880B71A5B82;
	Mon, 14 Apr 2025 05:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="gg0FkyAZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7DC71A257D;
	Mon, 14 Apr 2025 05:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744609858; cv=none; b=GLly8mgaf1ck6e8O23JFPsTgZ514ATIyoLq76BxVpxRy4kl8ONdpQu6XZKoJeZu9QP8i/+m4O38y9sel+KMYQOdNp5P6QXpFMnfHqubAfFDraDcR0gpyiDRaWAWqyohZ0jsJQAeD8HXb6spq52idwliszNVrlTwMGkug+MH0r30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744609858; c=relaxed/simple;
	bh=tAfFbhVdV51oLBAZnxPt1aAziTS59NvE0HEf+q6B0pI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=co5VV4rKH5n/3Iw6tu+3x9nHDgOqFGKLqZMF2sbmN5KAkQdlh2XIodRZaMw+Uhp+aD8BoSTkYzvEFbTWx3doFltHOsHm0+9nRAbqwSoODG70zSH19wcz54BIcPsD6v0Lg5kCDXsa00AkrY7h+YVCpSiL5rK0AkyI0yY035zP2m0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=gg0FkyAZ; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Njm3oJYrhG1uPcbOAYVKxijpEhibJEuaYWjvMEvM1LU=; b=gg0FkyAZyQs8/2nMDvjoRAQUqt
	QNFyQ/VqqFqdkDk09Jz6ePqEWEkudKG5ow0M5iC9dffOWDOw9f/d7EHpA8fbeT9hQ4yAjiZ7ftXXf
	Ut/kGYo/sHI9/l6/106HayrXNd0QZR5/iKrpgAT9HW3vWQmOyE48F0bvVn8ok3/LUPd8WasZBlt38
	WeahIw0mqEcQ9fVWO16ZEb6bt53PYuIF+xrg+vOyhyLbL4VLgBrvJR5nNk9NBYXx+hIUvRlpz10wT
	OJCk72Vvyb3B7+PkwLT84WcnE/DE2eKLeghbuN3UX29na2nB79orWIkAEoFMbrIFN6dh8wVltHAzc
	9vSDM+xQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u4Cic-00000000jqH-3W6C;
	Mon, 14 Apr 2025 05:50:54 +0000
Date: Sun, 13 Apr 2025 22:50:54 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Lizhi Xu <lizhi.xu@windriver.com>
Cc: syzbot+e36cc3297bd3afd25e19@syzkaller.appspotmail.com,
	almaz.alexandrovich@paragon-software.com, brauner@kernel.org,
	jack@suse.cz, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, ntfs3@lists.linux.dev,
	syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Subject: Re: [PATCH] fs/ntfs3: Add missing direct_IO in ntfs_aops_cmpr
Message-ID: <Z_yiPk7AkwJo0c6n@infradead.org>
References: <67f818d3.050a0220.355867.000d.GAE@google.com>
 <20250411012428.3473333-1-lizhi.xu@windriver.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250411012428.3473333-1-lizhi.xu@windriver.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Fri, Apr 11, 2025 at 09:24:27AM +0800, Lizhi Xu wrote:
> The ntfs3 can use the page cache directly, so its address_space_operations
> need direct_IO.

I can't parse that sentence.  What are you trying to say with it?


