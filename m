Return-Path: <linux-fsdevel+bounces-55211-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57506B08754
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Jul 2025 09:49:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B161565027
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Jul 2025 07:49:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B1BE253934;
	Thu, 17 Jul 2025 07:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZBu/VenD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DB5A2AD14
	for <linux-fsdevel@vger.kernel.org>; Thu, 17 Jul 2025 07:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752738534; cv=none; b=NUZgoSosLoAat3TTFkckET5UeCcvtQc+Zn/2EcymAhpNlNm69Q7G5kQf2OiLjqemA3/nINMHp92gzx4OKNqR9jW4WmxUe8rDclLi2/jkuOhqFzWxJ/rS4yS9kFlbTd7qaWVgRypasotUkNgs4twKq5hfT0+E2LXOHsKS2KFgEYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752738534; c=relaxed/simple;
	bh=DDdG0yv4ZtNFIRI5FkA8ic3x2EJjFAz1Efb9FIjSdPE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iSRDDvlgCZgLcQA4v9BiyLR71wpZnJN94/Dc2TA6/NZUrSvK2i/OsxlM0XhDRLK35/oyw7OSD8IhU3P8AKvj8LnNZFe6uPjXldFABaKx46927ZviGwV4+EekYl96SaT/W9Ary6MFBvBTZ2/raKpmgHXYYwAs3Npr+wYnIQsOG7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZBu/VenD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C280C4CEE3;
	Thu, 17 Jul 2025 07:48:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752738534;
	bh=DDdG0yv4ZtNFIRI5FkA8ic3x2EJjFAz1Efb9FIjSdPE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZBu/VenD4XJmU9Vfwt9b2T/CUmW8uFtBW6DAinogDZWDzKBy1y9/X9PF42LRCrrBI
	 Oxbd/7X5TGdbDbC5NJxT1UCk4hlYr1rVClooaOzpc72iWPR56j7a5nMjkdFfIEfRjW
	 rLECAqyT0b2yuCNcJzrVNYG22G1Umpw1CE8IxtpikrsIyMjUbHjOOmzpcWEfYPBnpa
	 bZaAtIIS+4kSxKJ/vNtg/oYc05kMbZrc/Dbi4RjcqqFBW+nwdd0wYPMD7iuseiNnTI
	 bhe3aboetZbU88DtA9XnrNkPk+F+3aJV/WcRUbC+MWEu5E8BFICP8PC3HRPs8Jn08V
	 z3+kZS/qg83LQ==
Date: Thu, 17 Jul 2025 09:48:49 +0200
From: Christian Brauner <brauner@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Matthew Wilcox <willy@infradead.org>, Jeff Layton <jlayton@kernel.org>, 
	Jan Kara <jack@suse.com>, Jens Axboe <axboe@kernel.dk>, Josef Bacik <josef@toxicpanda.com>, 
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH RFC DRAFT DOESNOTBUILD] inode: free up more space
Message-ID: <20250717-studien-tomaten-d9d1d7b5e6e8@brauner>
References: <20250715-work-inode-fscrypt-v1-1-aa3ef6f44b6b@kernel.org>
 <aHZ9H_3FPnPzPZrg@casper.infradead.org>
 <20250716130200.GA5553@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250716130200.GA5553@lst.de>

On Wed, Jul 16, 2025 at 03:02:00PM +0200, Christoph Hellwig wrote:
> On Tue, Jul 15, 2025 at 05:09:03PM +0100, Matthew Wilcox wrote:
> > will be harder, we have to get to 604 bytes.  Although for my system if
> > we could get xfs_inode down from 1024 bytes to 992, that'd save me much
> > more memory ;-)
> 
> There's some relatively low hanging fruit there.
> 
> One would be to make the VFS inode i_ino a u64 finally so that XFS
> and other modern files systems an stop having their own duplicate of

That's already on my TODO since we discussed this with Jeff last year.

