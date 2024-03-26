Return-Path: <linux-fsdevel+bounces-15296-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EAD0788BE78
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Mar 2024 10:54:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 51FDCB24FA0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Mar 2024 09:54:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4F4F5DF23;
	Tue, 26 Mar 2024 09:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b="SeKLaveT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8AAC5D734;
	Tue, 26 Mar 2024 09:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711446820; cv=none; b=QJjGw2VT9vUiasgI+FrDPn3XXVUfTJQL2lVIIQW3DELGXD4bZaLepdslqWfZDgT24ZDzdDCWCGsHPqRbA519NRWpaziMpVrdGjlRGfeNbrnPJIHn8qJsgUkWHlo6XYqluD9AUUJlLWdGy20HbgNv2OdjGtPLmQwNVRzUnAbn+Hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711446820; c=relaxed/simple;
	bh=s+wXuGTKSM02LS+A7um+eisRIfxf9plFtAzb8lv0d/A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qFwbQM6rRsWslgw99KRRIrY/Wdo6AcHp62YfL07HHYjleuyUH2jKbDocRcHMh2M6awNEEztIkCEBTK4RWszCA+TDfKOTiIOkC9Xz943oZnXzKHd/sRK/Bnm8c1pTsE1jlAdfIKHSkpAVkXWHtJV4KR3jglHu7GOO9ILzYoTNZIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com; spf=pass smtp.mailfrom=pankajraghav.com; dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b=SeKLaveT; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4V3lVj1mj0z9smj;
	Tue, 26 Mar 2024 10:53:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
	s=MBO0001; t=1711446813;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XvQvmg7eUJ6XUFSwCSiynxp4lLJbG0KYQHnlFS2Zq7Q=;
	b=SeKLaveTbGJlCa05UkQhGZe1nbeCvZzFhqOEbHEXZz2NGj7NOa8411XZe51acSHK+ptfUG
	Ih9TDcPM2ktVGG+ZUraPNDOykE0tAWTc5f/eZcc+2V+z647KlkEEpsEWPzcCQ0LfIXsatn
	0DwZf20pbBPRSomVcdai4NAIYV5WLuGG7IazYR5P5wGPQlPFLfWzKDUoxb3KV1MqWR0cdp
	uSeMoocb01Z5BxriVA6nEJyXeVwoKzWk1A0qY0VFzTZbWPVNvp7MnEzfY32hAX0J9/37Y7
	bb/LKm1W5PV4WYC8bBWlDaNsm8+rj4OgCSA4Qi6t7f4iCJ8+XucX3X5HEU+T0g==
Date: Tue, 26 Mar 2024 10:53:27 +0100
From: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
To: Matthew Wilcox <willy@infradead.org>
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	gost.dev@samsung.com, chandan.babu@oracle.com, hare@suse.de, mcgrof@kernel.org, 
	djwong@kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	david@fromorbit.com, akpm@linux-foundation.org, Pankaj Raghav <p.raghav@samsung.com>
Subject: Re: [PATCH v3 10/11] xfs: make the calculation generic in
 xfs_sb_validate_fsb_count()
Message-ID: <7djmiptum72jkug7kijmgy74olkkezeybicxiw2jpwj4yxjilp@2y2l2dyulczt>
References: <20240313170253.2324812-1-kernel@pankajraghav.com>
 <20240313170253.2324812-11-kernel@pankajraghav.com>
 <ZgHNb3Led05RXRd2@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZgHNb3Led05RXRd2@casper.infradead.org>
X-Rspamd-Queue-Id: 4V3lVj1mj0z9smj

On Mon, Mar 25, 2024 at 07:15:59PM +0000, Matthew Wilcox wrote:
> On Wed, Mar 13, 2024 at 06:02:52PM +0100, Pankaj Raghav (Samsung) wrote:
> > From: Pankaj Raghav <p.raghav@samsung.com>
> > 
> > Instead of assuming that PAGE_SHIFT is always higher than the blocklog,
> > make the calculation generic so that page cache count can be calculated
> > correctly for LBS.
> > 
> > Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
> > ---
> >  fs/xfs/xfs_mount.c | 9 ++++++++-
> >  1 file changed, 8 insertions(+), 1 deletion(-)
> > 
> > diff --git a/fs/xfs/xfs_mount.c b/fs/xfs/xfs_mount.c
> > index aabb25dc3efa..9cf800586da7 100644
> > --- a/fs/xfs/xfs_mount.c
> > +++ b/fs/xfs/xfs_mount.c
> > @@ -133,9 +133,16 @@ xfs_sb_validate_fsb_count(
> >  {
> >  	ASSERT(PAGE_SHIFT >= sbp->sb_blocklog);
> 
> but ... you're still asserting that PAGE_SHIFT is larger than blocklog.
> Shouldn't you delete that assertion?

I do that in the next patch when we enable LBS support in XFS by setting
min order. So we still need the check here that will be removed in the
next patch.
> 
> >  	ASSERT(sbp->sb_blocklog >= BBSHIFT);
> > +	uint64_t max_index;
> > +	uint64_t max_bytes;
> > +
> > +	if (check_shl_overflow(nblocks, sbp->sb_blocklog, &max_bytes))
> > +		return -EFBIG;
> >  
> >  	/* Limited by ULONG_MAX of page cache index */
> > -	if (nblocks >> (PAGE_SHIFT - sbp->sb_blocklog) > ULONG_MAX)
> > +	max_index = max_bytes >> PAGE_SHIFT;
> > +
> > +	if (max_index > ULONG_MAX)
> >  		return -EFBIG;
> 
> This kind of depends on the implementation details of the page cache.
> We have MAX_LFS_FILESIZE to abstract that; maybe that should be used
> here?

Makes sense. I will use it instead of using ULONG_MAX.

