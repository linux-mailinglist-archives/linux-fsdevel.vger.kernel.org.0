Return-Path: <linux-fsdevel+bounces-19186-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 063D88C1179
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 May 2024 16:46:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF4BF1F22EC7
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 May 2024 14:45:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6A1C15CD7D;
	Thu,  9 May 2024 14:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W1VEh47e"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4839E1A291;
	Thu,  9 May 2024 14:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715265943; cv=none; b=QijXVNSDG/f9tNtv/Rv9d/lYFo5YGj49IRBzpRp6uL5QiD2K4mMP0CRMSbxLz4RGtMkOrLwQjdYWngdqrnkXLm6a29oc1kqR2feO7fkFr1PSkuTYLm25bb1ab38EAbqJRfxdi8iT1mI4Strj7RClrIpSzeXOzpX87zwoM2GYH2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715265943; c=relaxed/simple;
	bh=5DAd3egjLUB5DhTkJFPxOSvu9VRu9lndvlj9IQrlv4A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RE0h2KrvPIhJ82m7mtyeteGuflia4i0oT0zGx5lr+JAoKgUdzPcwrpfB1futoSuamuvvblByqXwnP1FnuQuzeKVkEuhLbRPWQxyai1+hVLnwo7DeCFotYQTtC0769y+XD60oIBBnb8fhdzIht+3pGiiFZwoFoXcRQkqCoucumtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W1VEh47e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCB83C116B1;
	Thu,  9 May 2024 14:45:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715265942;
	bh=5DAd3egjLUB5DhTkJFPxOSvu9VRu9lndvlj9IQrlv4A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=W1VEh47e/zLe7EUtYA/+dUybkppzZd6E6rnydfYP7HpBvDmMSrshUds2Ps+RUeY4N
	 YL3e0V8UAJl+vHgvped+guKrIHSc0CfV8Rp5+pqDV/DoeVkaWi/j3PWT0diafJdgo0
	 TLogzGC0H9KmoGdRqj4SI66HiTEwCcp8+5snKa2c/4b5/6c6+7nc7Cfo4fEBGqjWU4
	 LECzSvs8Fd5CEAxw7jP8aJYYvopWLPqEL6f5RJbGxSiHzC5qi4+BsmZxvexYD8w+1B
	 VafQbkkBbHnRqjOfD1YsAdzTXUY8WSTtOD8Jia3eEXJGtHQtx1fGLl+pQ/z1mtIuUz
	 xm1fNoRgUYR2A==
Date: Thu, 9 May 2024 07:45:42 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: Eric Biggers <ebiggers@kernel.org>, aalbersh@redhat.com,
	linux-xfs@vger.kernel.org, alexl@redhat.com, walters@verbum.org,
	fsverity@lists.linux.dev, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 25/26] xfs: make it possible to disable fsverity
Message-ID: <20240509144542.GJ360919@frogsfrogsfrogs>
References: <171444680291.957659.15782417454902691461.stgit@frogsfrogsfrogs>
 <171444680792.957659.14055056649560052839.stgit@frogsfrogsfrogs>
 <ZjHlventem1xkuuS@infradead.org>
 <20240501225007.GM360919@frogsfrogsfrogs>
 <20240502001501.GB1853833@google.com>
 <20240508203148.GE360919@frogsfrogsfrogs>
 <ZjxZRShZLTb7SS3d@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZjxZRShZLTb7SS3d@infradead.org>

On Wed, May 08, 2024 at 10:04:05PM -0700, Christoph Hellwig wrote:
> On Wed, May 08, 2024 at 01:31:48PM -0700, Darrick J. Wong wrote:
> > Hmm.  What if did something like what fsdax does to update the file
> > access methods?  We could clear the ondisk iflag but not the incore one;
> > set DONTCACHE on the dentry and the inode so that it will get reclaimed
> > ASAP instead of being put on the lru; and then tell userspace they have
> > to wait until the inode gets reclaimed and reloaded?
> 
> Yikes.  That's a completely mess I'd rather get rid of than add more of
> it.
> 
> What is the use case of disabling fsverity to start with vs just
> removing a fsverity enabled file after copying the content out?

How do you salvage the content of a fsverity file if the merkle tree
hashes don't match the data?  I'm thinking about the backup disk usecase
where you enable fsverity to detect bitrot in your video files but
they'd otherwise be mostly playable if it weren't for the EIO.

I guess you could always ddrescue the file, right?

--D

