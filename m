Return-Path: <linux-fsdevel+bounces-14698-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7202687E2DC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Mar 2024 05:56:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 279AA281A20
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Mar 2024 04:56:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 826C420B0E;
	Mon, 18 Mar 2024 04:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZW2EvT0c"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF5FF182B5;
	Mon, 18 Mar 2024 04:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710737786; cv=none; b=EMe29VHvMZRnlYMlrmNUQWJ7yV/IGAf5//OWUPFPAxaYLT39XW1JkTdiq+EWkaWSVB1AH7KLJtzBs8WLKOA/kaBYtX4KUwKLRoM6ybHSYzoIhmp6vKrZ+XO1C5lZR7duevITO/u5OD2FLqe9UwER+KqR6zjgmm235Iu2sU2GCTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710737786; c=relaxed/simple;
	bh=maA8upvfPtabforh3GuZbcxoqaBvGK2Af7/5G2JQh5U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E0YRpPTQfqEoJgzAYOCIE/GjllLbg8v83VMKh1D8lATnd6xFf7EWY0Oc2On4tkXh2xvgzRgXEknTDpiVEduYEGBb3vFD4m/tj1updUlEznlxhHSrry8ATLDg5C1HVGa/Rhmcl2PxMe97juwTQaTGZmjG4IduLdvqKHcccDNKdIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZW2EvT0c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 603BDC433F1;
	Mon, 18 Mar 2024 04:56:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710737786;
	bh=maA8upvfPtabforh3GuZbcxoqaBvGK2Af7/5G2JQh5U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZW2EvT0coB30OIL0sSbbYwIrF366NpUBI03ApD7WtGTyCzhvJI5chD74ysSQ8SVBC
	 BvgdzR71M82c5qlScAmxYGVALO2XJpmXsePsfBi5uqoNgUAJV0Zfl4caxs3yKt/45E
	 8+Ijz3PMvCvV+cR/TR2toUYi1H0amiI+efSOfjGw0xQ4ff4lMi4KnjcwngFYgrP5L+
	 N+GnlV3wA5T/uUszEhC+vTuUvTdsc7FBKzq0AcbjjnfhgrRnI9rsDD5WnbZl4H8zuj
	 nZlQ2iTzPtvLHq5dzoPcXAO0wUSgyW0E0PWsNiGuouK1EFi18yEfeSxgg1bz0lnrby
	 9Um+MsR/r9cBg==
Date: Sun, 17 Mar 2024 21:56:25 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: ebiggers@kernel.org, aalbersh@redhat.com, linux-fsdevel@vger.kernel.org,
	fsverity@lists.linux.dev, linux-xfs@vger.kernel.org
Subject: Re: [PATCH 26/40] xfs: add fs-verity support
Message-ID: <20240318045625.GS6184@frogsfrogsfrogs>
References: <171069245829.2684506.10682056181611490828.stgit@frogsfrogsfrogs>
 <171069246327.2684506.14573441099126414062.stgit@frogsfrogsfrogs>
 <ZfecSzBoVDW5328l@infradead.org>
 <20240318043436.GH1927156@frogsfrogsfrogs>
 <ZffFZfWP-jSScAQN@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZffFZfWP-jSScAQN@infradead.org>

On Sun, Mar 17, 2024 at 09:39:01PM -0700, Christoph Hellwig wrote:
> On Sun, Mar 17, 2024 at 09:34:36PM -0700, Darrick J. Wong wrote:
> > > select few file systems doesn't seem very efficient.  Given that we
> > > very rarely update it and thus concurrency on the write side doesn't
> > > matter much, is there any way we could get a away with a fs-wide
> > > lookup data structure and avoid this?
> > 
> > Only if you can hand a 128-bit key to an xarray. ;)
> 
> That's why I said lookup data structure and not xarray.  It would
> probably work with an rthashtable.

Heh.  Well willy gave me the idea to use an xarray so I'd then know how
to use an xarray. :)

> > But in all seriousness, we could have a per-AG xarray that maps
> > xfs_agino_t to this xarray of merkle blocks.  That would be nice in that
> > we don't have to touch xfs_icache.c for the shrinker at all.
> 
> I have to admit I haven't read the code enough to even know from
> what to what it maps.  I'll try to get a bit deeper into the code,
> time permitting.

fsverity flattens the blocks of the merkle tree into a linear u64
byte-address space.  The accesses are in those same units, which is why
I end up shifting so that the xarray entries for adjacent blocks are
contiguous.  Kind of like what the address_space does.

--D

