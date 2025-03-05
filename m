Return-Path: <linux-fsdevel+bounces-43280-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AA845A505EB
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Mar 2025 18:05:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD796188B248
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Mar 2025 17:05:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D30661A5B8B;
	Wed,  5 Mar 2025 17:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dkh+KxzZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D68419C542;
	Wed,  5 Mar 2025 17:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741194293; cv=none; b=CVSCuIxh44D7ewTXwUc/EeT4sNDxFyAbj35lEu18uU2m+8Buz4N48NnWJQCpMJcdcUEv7bUTA4XqlWqqshV6F7ah6fn67+t3j9NyJ3Hw5JvCFgR/erjL3vA53/3lPo9WClKDyz28WUMNWf5J8IltBN9Rjrf8vN5a3mGeRNILRbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741194293; c=relaxed/simple;
	bh=EL1Vu99K/ODV+OWIVt+0gXt+qPvS+NdYS8IAfh9nEB0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ond7gO3Pwd0V9lkejnCHMdrX8v0KmAmbkxrDiMGo+7Yprpj3w2i1m/7qkv9MmMnEyv4BmgLjD7ryEyM2t0w898wVr1lvZBwP1Gi5JM2AwFKXEfOR0X8vzyVVy8B/fY5+9xWEabUW+rvLX/56kPd9TR61ez1/VrigfwOJBLPpk30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dkh+KxzZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44D97C4CED1;
	Wed,  5 Mar 2025 17:04:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741194292;
	bh=EL1Vu99K/ODV+OWIVt+0gXt+qPvS+NdYS8IAfh9nEB0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Dkh+KxzZSxgm3l9QG6sFZdXrDb+9XLrhbLdT7vo39JLUjcmOwfsRxGEVwqnmMyiJ5
	 UHb6dmuDSeq+PxN2VluzBpzC9UPYpFaKvV+qBJEjx5E1IjYRCGa5toWDeJdW82QXIb
	 H31qTecQIvXIr7VRvfblPfoYOPnoN1pLJFyR2A/nMZgt4uVwIBP+H8o2VXv/36Kj95
	 WMBkVHnwKek3uwroWeWiSjRhVEeXh23qeaUC6vKemnKr9IySvx+wX5mgIBkBYIpSwb
	 PorETCSTyGSv/FXxiM4+cME3S8mfPOs8LDUX2P37aI19PoZ9e2jv3bsDdesIGZmcSo
	 2PTZ5XHx1Tu9w==
Date: Wed, 5 Mar 2025 09:04:50 -0800
From: Luis Chamberlain <mcgrof@kernel.org>
To: Matthew Wilcox <willy@infradead.org>
Cc: "Darrick J. Wong" <djwong@kernel.org>, brauner@kernel.org, hare@suse.de,
	david@fromorbit.com, kbusch@kernel.org, john.g.garry@oracle.com,
	hch@lst.de, ritesh.list@gmail.com, linux-fsdevel@vger.kernel.org,
	linux-block@vger.kernel.org, gost.dev@samsung.com,
	p.raghav@samsung.com, da.gomez@samsung.com, kernel@pankajraghav.com,
	Kent Overstreet <kent.overstreet@linux.dev>
Subject: Re: [PATCH] bdev: add back PAGE_SIZE block size validation for
 sb_set_blocksize()'
Message-ID: <Z8iEMv354ThMRr0b@bombadil.infradead.org>
References: <20250305015301.1610092-1-mcgrof@kernel.org>
 <Z8fpZWHNs8eI5g38@casper.infradead.org>
 <20250305063330.GA2803730@frogsfrogsfrogs>
 <Z8hck6aKEopiezug@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z8hck6aKEopiezug@casper.infradead.org>

On Wed, Mar 05, 2025 at 02:15:47PM +0000, Matthew Wilcox wrote:
> On Tue, Mar 04, 2025 at 10:33:30PM -0800, Darrick J. Wong wrote:
> > > So this is expedient because XFS happens to not call sb_set_blocksize()?
> > > What is the path forward for filesystems which call sb_set_blocksize()
> > > today and want to support LBS in future?
> > 
> > Well they /could/ set sb_blocksize/sb_blocksize_bits themselves, like
> > XFS does.
> 
> I'm kind of hoping that isn't the answer.

set_blocksize() can be used. The only extra steps the filesystem needs
to in addition is:

	sb->s_blocksize = size;
	sb->s_blocksize_bits = blksize_bits(size);

Which is what both XFS and bcachefs do.

We could modify sb to add an LBS flag but that alone would not suffice
either as the upper limit is still a filesystem specific limit. Additionally
it also does not suffice for filesystems that support a different device
for metadata writes, for instance XFS supports this and uses the sector
size for set_blocksize().

So I think that if ext4 for example wants to use LBS then simply it
would open code the above two lines and use set_blocksize(). Let me know
if you have any other recommendations.

  Luis

