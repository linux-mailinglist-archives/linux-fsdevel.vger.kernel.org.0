Return-Path: <linux-fsdevel+bounces-73486-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D54E7D1AC82
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jan 2026 19:04:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AED0B3076903
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jan 2026 18:02:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB5AD32277B;
	Tue, 13 Jan 2026 18:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="af8UeotW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D19A30DEAD;
	Tue, 13 Jan 2026 18:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768327334; cv=none; b=IFPm/iJ6SnawwYu3NMjU6Bm7FkQ43HU4r0mbSlywW+6UjSVfpe30zCiEnhEzONP2TkUBGvb5bWSfomtYoWewYcowP2NUMlSIhR5cwsha7xcOJhwKeWrNC7AylF65uyUANJ/QB06MmF4+ODpeupbUchdhBBB9CQHsx91TMiMoLHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768327334; c=relaxed/simple;
	bh=dhvdb6oBiQ4tx2P+Eb0AibKcqbZ2az1RMjL1oQCqmZ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rfWsxijxJTDY7GW4qvoIsowy1C2+dfPofzyhksjI8XKnOdCyejOFpd+rhTEfMYxT7AFAFo3cIttYufbNJLpqcIijKAhVx+XRC48cZmmofzKln/Wn86ybgrQLutuWDYq1ItTmLJh1x5pVjlWTuycl0sIEio2IODyUM+Oxuw0cLQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=af8UeotW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02742C116C6;
	Tue, 13 Jan 2026 18:02:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768327334;
	bh=dhvdb6oBiQ4tx2P+Eb0AibKcqbZ2az1RMjL1oQCqmZ4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=af8UeotWYGNUnOMWgOqYGs09J/ZuAYDEj9rS/7b0b7R4AlR35BiSfGGAOGn9lk5HR
	 38hI+kcVwACXNQK5FfPgYX7t2Tzh4g95FaQsOFJBhcCMr9C9GNxENZxmyDXEbO/Mpe
	 NaGzTlnlJ1RxwluuydEuME/LoIKahuAYMPG+OFyzzrAtr+f7DX5HKP9/N2H1byf2pR
	 3ElXLW1IgGuv9Sb82XfrP1c0inOelqB0Zo9aSaLWRNFNmVbEwXfS+/61cxnmtCYUpB
	 KKZGO7nDA2U0yYtA0OS3bhJ6oUgalZgUFvVJhVoof3L3s8/DHJ+LlyFyYWO9Nw5p7h
	 QaoFMFB4DlqOA==
Date: Tue, 13 Jan 2026 10:02:13 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Andrey Albershteyn <aalbersh@redhat.com>, fsverity@lists.linux.dev,
	linux-xfs@vger.kernel.org, ebiggers@kernel.org,
	linux-fsdevel@vger.kernel.org, aalbersh@kernel.org,
	david@fromorbit.com
Subject: Re: [PATCH v2 11/22] xfs: add verity info pointer to xfs inode
Message-ID: <20260113180213.GX15551@frogsfrogsfrogs>
References: <cover.1768229271.patch-series@thinky>
 <7s5yzeey3dmnqwz4wkdjp4dwz2bi33c75aiqjjglfdpeh6o656@i32x5x3xfilp>
 <20260112223938.GM15551@frogsfrogsfrogs>
 <20260113082158.GF30809@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260113082158.GF30809@lst.de>

On Tue, Jan 13, 2026 at 09:21:58AM +0100, Christoph Hellwig wrote:
> On Mon, Jan 12, 2026 at 02:39:38PM -0800, Darrick J. Wong wrote:
> > On Mon, Jan 12, 2026 at 03:51:10PM +0100, Andrey Albershteyn wrote:
> > > Add the fsverity_info pointer into the filesystem-specific part of the
> > > inode by adding the field xfs_inode->i_verity_info and configuring
> > > fsverity_operations::inode_info_offs accordingly.
> > > 
> > > Signed-off-by: Andrey Albershteyn <aalbersh@kernel.org>
> > 
> > I kinda don't like adding another pointer to struct xfs_inode
> 
> Me neither.
> 
> > but I can't see a better solution.
> 
> Well, I suggested just making the fsverity_info a standalone object,
> and looking it up using a rhastable based on the ino.  Eric didn't
> seem overly existed about that, but I think it would be really helpful
> to not bloat all the common inodes for fsverity.

Oh, right, now I remember you asking about using rhashtable to map an
xfs_inode to a fsverity_info.  I wonder how much of a performance
overhead that lookup (vs. the pointer deref that's used now) would have
for loading folios into the pagecache.

--D

