Return-Path: <linux-fsdevel+bounces-26695-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 719C395B133
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 11:10:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A3DE01C21F10
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 09:10:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07E8017084F;
	Thu, 22 Aug 2024 09:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QjxPmlQC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A66419470
	for <linux-fsdevel@vger.kernel.org>; Thu, 22 Aug 2024 09:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724317800; cv=none; b=XuT0ypspfNpy58MSg3r/Up2a+eVIdDx3tHDMgwx02nCQY6u6c5H0U3xGlkgw+R7YhXnDdX0L3mVKF/K544ahQ7NUPUVbBXry+5XgHP5ax7Xa2cKEPEePXD2SL1EaYJlfdeLgQ9uqP+L9j/sqq+5wD53rfGGPlJYi9fubJjHSEUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724317800; c=relaxed/simple;
	bh=tsy6eCpRKU9g9aZk/LywKrBSdPQUpsF/AQqQWlf9+TY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a82B5lhuNEEoZl9jrzk9nuAOzZQ6Ne9N0ZDvAcB2oIRzKvr9waW2ZTLYQkQm5ngVVHYurmrfZRavU4URFV+8YkLzPOCPom6obSxBVD3h+fwrnGZHy3u8XstEKNOHoo7YcdfoCxXWVlkPECGOf58rXh+PPJt0qMvv9REb5q33i4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QjxPmlQC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DA4DC4AF0B;
	Thu, 22 Aug 2024 09:09:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724317800;
	bh=tsy6eCpRKU9g9aZk/LywKrBSdPQUpsF/AQqQWlf9+TY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QjxPmlQCNR/ZFTR41kqsfhmt9uTmnGUAADTmp2uAK7+YJzWiqC+SX2qWLBxb5k2Iv
	 pXO/uElA43UGzHdF8ya9/1poEHEPuDAN4nJpKvtyuq+3VUgt3PYSKSJFWocGXLuNYc
	 5T1XONASu+VviHx2asvZJez3pH3e2/o5bbjwGEmVTpjxi0XjBz87mHzPpKk/WHsiPm
	 nMibElTl0NZF+DG8nWi/E6f3FfIUIxb+zTo2MM9B7aoLi0phHTmR1otLuvsyjwBqnW
	 +ev8Veo20KR9eLe1yHqVZsmk90PqDLOU8yrpj1ySXxEavgMvIbPk9nID3X04eSylnE
	 X5+f93lsNVLOQ==
Date: Thu, 22 Aug 2024 11:09:55 +0200
From: Christian Brauner <brauner@kernel.org>
To: Michal Hocko <mhocko@suse.com>
Cc: Christoph Hellwig <hch@infradead.org>, 
	Yafang Shao <laoar.shao@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, 
	viro@zeniv.linux.org.uk, jack@suse.cz, david@fromorbit.com, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org, Kent Overstreet <kent.overstreet@linux.dev>
Subject: Re: [PATCH] mm: document risk of PF_MEMALLOC_NORECLAIM
Message-ID: <20240822-unlustig-rauslassen-484a9d3af358@brauner>
References: <ZrymePQHzTHaUIch@tiehlicka>
 <CALOAHbDw5_hFGsQGYpmaW2KPXi8TxnxPQg4z7G3GCyuJWWywpQ@mail.gmail.com>
 <Zr2eiFOT--CV5YsR@tiehlicka>
 <CALOAHbCnWDPnErCDOWaPo6vc__G56wzmX-j=bGrwAx6J26DgJg@mail.gmail.com>
 <Zr2liCOFDqPiNk6_@tiehlicka>
 <Zr8LMv89fkfpmBlO@tiehlicka>
 <Zr8MTWiz6ULsZ-tD@infradead.org>
 <Zr8TzTJc-0lDOIWF@tiehlicka>
 <ZsXTA_dOKxmLcOev@infradead.org>
 <ZsXfjQTEel3GyjJc@tiehlicka>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZsXfjQTEel3GyjJc@tiehlicka>

On Wed, Aug 21, 2024 at 02:37:33PM GMT, Michal Hocko wrote:
> On Wed 21-08-24 04:44:03, Christoph Hellwig wrote:
> > On Fri, Aug 16, 2024 at 10:54:37AM +0200, Michal Hocko wrote:
> > > Yes, I think we should kill it before it spreads even more but I would
> > > not like to make the existing user just broken. I have zero visibility
> > > and understanding of the bcachefs code but from a quick look at __bch2_new_inode
> > > it shouldn't be really terribly hard to push GFP_NOWAIT flag there
> > > directly. >
> > 
> > I don't understand that sentence.  You're adding the gfp_t argument to
> > it, which to mean counts as pushing it there directly.
> 
> Sorry, what I meant to say is that pushing GFP_NOWAIT directly seem fine
> unless I have missed some hidden corners down the call path which would
> require a scope flag to override a hardcoded gfp flag.
>  
> > > It would require inode_init_always_gfp variant as well (to not
> > > touch all existing callers that do not have any locking requirements but
> > > I do not see any other nested allocations.
> > 
> > inode_init_always only has 4 callers, so I'd just add the gfp_t
> > argument.  Otherwise this looks good modulo the fix your posted:
> > 
> > Acked-by: Christoph Hellwig <hch@lst.de>
> 
> Thanks. I will wait for more review and post this as a real patch. I
> would really appreciate any help with actual testing.

Ugh, I really don't like that we have to add a flag argument especially
for an api that's broken but fine.

