Return-Path: <linux-fsdevel+bounces-17986-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D22E58B48EE
	for <lists+linux-fsdevel@lfdr.de>; Sun, 28 Apr 2024 01:46:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 738231F2171C
	for <lists+linux-fsdevel@lfdr.de>; Sat, 27 Apr 2024 23:46:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 947F81487D3;
	Sat, 27 Apr 2024 23:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="IlrHyZvo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F44C4A3D;
	Sat, 27 Apr 2024 23:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714261590; cv=none; b=Lg+MWxhfo9EcdYJTApG/6XNLs+f0/igIkS8P6gBtrx87o9YcecZXLoamV3cHD662eDRNRhP5aLutVuxQRB1/RzEzX8AaalhBXxpAPHnIqNU/Qm76ieab6RaEMdgQ+RPnmWQpoxqCX66aQ3alwLQBww9MDSOawEfEqPhumMyDEHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714261590; c=relaxed/simple;
	bh=gJwg9xG8VlL/41boVI9dbukbsm9h734IFRS3g0vDnV0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X1/gKabLAl7VGFkV3QGsgadHoetRAfKN2qwConfqzqnffT28+DrZydx50nmbB535v4F48b9k8vrfRm18tgfntnZsx3izzaG+Mg7aOBHwsJ3DjB7EC2T6mbPesuf4mmDYBGhQpy9J/ALVQBGUQ3ZQdapHgVx1BL7C1HLLsNMk3t8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=IlrHyZvo; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=GYaIaWc5ozD1igWj/dlah909E8eLQGhxWKN9amtdGrY=; b=IlrHyZvo4caZIVYM3oj/LRaAR9
	1BzkCio9PHBE7cxaqhG0bieVtoZehI/dmYHvggdzInJTK6GAieUL1ly0ityJmSVSwMOlP0KiyPAHu
	qv96v4U3LyWtR2ZSnBiC25kJcHKdm93YmhGdUVk8x+Cj0K0bz6LKNiueAIRkPdqBtZCK/2yULeoVy
	+3NYgTr74TV4nB869rvgfTJWqWFPrYLV07LnzUybdY5+PaLfeDmPKv+H6M7Zpql8HM3R4PNjho5M+
	4tS9E67clJgHRkbvl7CqRdpBzztly2sBLk9uT++4FI6CXXcZRsMys9pLE1jNyU7PkqtJ7FfxZWfkG
	s8XsL3Cw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1s0rkN-006M7p-1f;
	Sat, 27 Apr 2024 23:46:23 +0000
Date: Sun, 28 Apr 2024 00:46:23 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>,
	Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>, linux-btrfs@vger.kernel.org,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 4/7] swapon(2): open swap with O_EXCL
Message-ID: <20240427234623.GS2118490@ZenIV>
References: <20240427210920.GR2118490@ZenIV>
 <20240427211128.GD1495312@ZenIV>
 <CAHk-=wiag-Dn=7v0tX2UazhMTBzG7P42FkgLSsVc=rfN8_NC2A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wiag-Dn=7v0tX2UazhMTBzG7P42FkgLSsVc=rfN8_NC2A@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Sat, Apr 27, 2024 at 02:40:22PM -0700, Linus Torvalds wrote:
> On Sat, 27 Apr 2024 at 14:11, Al Viro <viro@zeniv.linux.org.uk> wrote:
> >
> > ... eliminating the need to reopen block devices so they could be
> > exclusively held.
> 
> This looks like a good change, but it raises the question of why we
> did it this odd way to begin with?
> 
> Is it just because O_EXCL without O_CREAT is kind of odd, and only has
> meaning for block devices?
> 
> Or is it just that before we used fiel pointers for block devices, the
> old model made more sense?
> 
> Anyway, I like it, it just makes me go "why didn't we do it that way
> originally?"

Exclusion for swap partitions:

commit 75e9c9e1bffbe4a1767172855296b94ccba28f71
Author: Alexander Viro <viro@math.psu.edu>
Date:   Mon Mar 4 22:56:47 2002 -0800

    [PATCH] death of is_mounted() and aother fixes


O_EXCL for block devices:

commit c366082d9ed0a0d3c46441d1b3fdf895d8e55ca9
Author: Andrew Morton <akpm@osdl.org>
Date:   Wed Aug 20 10:26:57 2003 -0700

    [PATCH] Allow O_EXCL on a block device to claim exclusive use.

IOW, O_EXCL hadn't been available at the time - it had been implemented
on top of bd_claim()/bd_release() introduced in the same earlier commit.

Switching swap exclusion to O_EXCL could've been done back in 2003 or
at any later point; it's just that swapon(2)/swapoff(2) is something that
rarely gets a look...

