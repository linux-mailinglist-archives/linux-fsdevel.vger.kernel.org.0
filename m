Return-Path: <linux-fsdevel+bounces-31145-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 52861992465
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Oct 2024 08:28:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F222A1F229D9
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Oct 2024 06:28:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20AB71474D3;
	Mon,  7 Oct 2024 06:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZFBDLC/o"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C7A242077;
	Mon,  7 Oct 2024 06:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728282522; cv=none; b=na+iLagGh9z/E7a28+jvSK15ULXqiFF2cXyA1OKfALF9YoQhp4TqKm79V+TjPEyGsE1Z00cAZ0V+Rgs5j4U6KtpQ8ft7pExAtSwN3HRfKmMMS5ZeMsRN1tO89KmLpw45auDeIBv5jKUJQFCC4tbJDyZ9RYHIaydLjPfxdlRiLfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728282522; c=relaxed/simple;
	bh=phS/Fzp54b05V4hjNB8UmovsSEQCm96hKFPTECSNJwU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e2oi+yDUiGzht+83OWWzbwxPkFe8I8IjcorVxFTREXUBFe/VH92/D2HnnBQIfK/r7ZPytzBejBifwgbXJMJO5udvDqRAhvg2eCjuSqeAP30HcGilXXPE+QBRojixnt7PkukK74ppBdWcIvY98XePY07fmCTJE1oDLnEq9fx4lOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZFBDLC/o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 003FCC4CEC6;
	Mon,  7 Oct 2024 06:28:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728282522;
	bh=phS/Fzp54b05V4hjNB8UmovsSEQCm96hKFPTECSNJwU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZFBDLC/oEX6bu8Ygwa5yLb2ndomNMqmgBgF/bDtWVVBms2qbird6cJG5eUMF21yNZ
	 fTKySWVKIeKeh7vo/aD3EUOdGyNvNhM6q3smt/MoPfoHK43tWO4Elja9CPb72wecjS
	 8AgBmykDh9eHbxMjICerhJQw4JQw31xuwS2A3PdQWNIdd4b4gZHYrtGjW8d+ebvc93
	 hQPenjW00lJaCYAAUlMZX0QNIasaSv7uafQKoq6uLQEFZSP2f/noVJKJCwaBvxhZiu
	 RWIVUzq3FFut3fHY/oN+RkhDCqs3efBmgfAE+nM2M5VV3cd9RGBFPtWfFrNxR6yBn7
	 BuKvUpjsobddQ==
Date: Sun, 6 Oct 2024 23:28:41 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Chandan Babu R <chandan.babu@oracle.com>,
	Carlos Maiolino <cem@kernel.org>,
	Christian Brauner <brauner@kernel.org>, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: fix stale delalloc punching for COW I/O v4
Message-ID: <20241007062841.GP21877@frogsfrogsfrogs>
References: <20240924074115.1797231-1-hch@lst.de>
 <20241005155312.GM21853@frogsfrogsfrogs>
 <20241007054101.GA32670@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241007054101.GA32670@lst.de>

On Mon, Oct 07, 2024 at 07:41:01AM +0200, Christoph Hellwig wrote:
> On Sat, Oct 05, 2024 at 08:53:12AM -0700, Darrick J. Wong wrote:
> > Hmmm so I tried applying this series, but now I get this splat:
> > 
> > [  217.170122] run fstests xfs/574 at 2024-10-04 16:36:30
> 
> I don't.  What xfstests tree is this with?

Hum.  My latest djwong-wtf xfstests tree.  You might have to have the
new funshare patch I sent for fsstress, though iirc that's already in my
-wtf branch.

> > I think this series needs to assert that the invalidatelock is held
> > (instead of taking it) for the IOMAP_UNSHARE case too, since UNSHARE is
> > called from fallocate, which has already taken the MMAPLOCK.
> 
> Yes.  I'll look into fixing it, but so far I haven't managed to
> reproduce the actual splat.

<nod>

--D

