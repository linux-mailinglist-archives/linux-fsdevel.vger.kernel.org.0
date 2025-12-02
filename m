Return-Path: <linux-fsdevel+bounces-70431-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 25994C9A1DC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 02 Dec 2025 06:45:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C3A5F3463BB
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Dec 2025 05:45:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 285692FCC01;
	Tue,  2 Dec 2025 05:45:33 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF0BA2FC00D;
	Tue,  2 Dec 2025 05:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764654332; cv=none; b=Y3EiJiKhgAdLtgYPuEQ+H2nhHagN8YARrHGG6Fw710pX583w7D2T91R32S8i2veqPxZorWulN9fS2of79d1Iw2O3jZii2NVov1cXcQm4ggr2NCe36DOFRWOHfSLEEIkcYjnhOa18+ZhJgt2UdIF5zO48J42mSwXThM1Wc5tWtak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764654332; c=relaxed/simple;
	bh=+SbCOUyDBS9oScmHG8r5Ug1Ijsaw30yLFTBn3TXaVPI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Da7CzQ0Zu0QL6XfTmgyxPZsDWGEplz1nAowqqsnbbqOkPTsvzNKiRT4ZHl83tRH+5kzQ7kuHhZhmyIxUKFNnGVmu/JCpY6SlZUOFq4UkCAZAHc2EOCGtCnMPqN+EHlJ+53QKwhSO4iNJw/3IfzWm1MXQmi7taHWUA/sjXzgmsuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 89BC868AA6; Tue,  2 Dec 2025 06:45:24 +0100 (CET)
Date: Tue, 2 Dec 2025 06:45:24 +0100
From: Christoph Hellwig <hch@lst.de>
To: Namjae Jeon <linkinjeon@kernel.org>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, tytso@mit.edu,
	willy@infradead.org, jack@suse.cz, djwong@kernel.org,
	josef@toxicpanda.com, sandeen@sandeen.net, rgoldwyn@suse.com,
	xiang@kernel.org, dsterba@suse.com, pali@kernel.org,
	ebiggers@kernel.org, neil@brown.name, amir73il@gmail.com,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	iamjoonsoo.kim@lge.com, cheol.lee@lge.com, jay.sim@lge.com,
	gunho.lee@lge.com, Hyunchul Lee <hyc.lee@gmail.com>
Subject: Re: [PATCH v2 06/11] ntfsplus: add iomap and address space
 operations
Message-ID: <20251202054524.GB15524@lst.de>
References: <20251127045944.26009-1-linkinjeon@kernel.org> <20251127045944.26009-7-linkinjeon@kernel.org> <aS1FVIfE0Ntgbr5I@infradead.org> <CAKYAXd9YW_UL2uA8anoVCw+a818y5dwtn3xAJJQc=_p32GA=Zw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKYAXd9YW_UL2uA8anoVCw+a818y5dwtn3xAJJQc=_p32GA=Zw@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Dec 02, 2025 at 09:47:17AM +0900, Namjae Jeon wrote:
> Nothing special reason, It was to use existing ones instead of new,
> complex implementations. NTFS metadata is treated as a file, and
> handling it via the folio(page) API allows the driver to easily gain
> performance benefits, such as readahead.

On the one hand it does, on the other hand at least our experience
is that the user data file algorithm for things like readahead and
cache eviction policies worked pretty poorly for metadata in XFS.
Of course I don't actually know if the same applies to ntfs.

> > From code in other patches is looks like ntfs never switches between
> > compressed and non-compressed for live inodes?  In that case the
> > separate aops should be fine, as switching between them at runtime
> > would involve races.  Is the compression policy per-directory?
> Non-compressed files can actually be switched to compressed files and
> vice versa via setxattr at runtime. I will check the race handling
> around aop switching again. And the compression policy is per-file,
> not per-directory.

In that case you probably want to use the same set of address space
(and other operations) and do runtime switching inside the method.

> >
> > Again curious why we need special zeroing code in the file system.
> To prevent reading garbage data after a new cluster allocation, we
> must zero out the cluster. The cluster size can be up to 2MB, I will
> check if that's possible through iomap.

Ouch, that's a lot of zeroing.  But yeah, now that you mention it
XFS actually has the same issue with large RT extents.  Although we
create them as unwritten extents, i.e. disk allocations that always
return zeroes.  I guess ntfs doesn't have that.  For DAX access
there actually is zeroing in the allocator, which is probably
similar to what is done here, just always using the iomap-based
code (check for xfs_zero_range and callers).


