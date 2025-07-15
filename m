Return-Path: <linux-fsdevel+bounces-54953-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91EDDB05A58
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Jul 2025 14:35:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 940FF3B1C84
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Jul 2025 12:35:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31F402E0403;
	Tue, 15 Jul 2025 12:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gEWd+Nq7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B84BF2DFA2B
	for <linux-fsdevel@vger.kernel.org>; Tue, 15 Jul 2025 12:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752582928; cv=none; b=svZTp9xhMkGDixdQ3osmqgww8/7deX/ZhoHjnCp8FRB4CuodFH0QfmleRyRPY5cPW83JfAL1YXurmfcm70NvwAgOxqeWCj+CMGWWfhsunnTed0KEyKguBEFuh72A6EVXIQ2AU1NZ8B1se88V1A6Bn1KntCSWL4QkhzBkml2JlwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752582928; c=relaxed/simple;
	bh=Qtdak9JNN7BaWa4bDojpMglgNmQkIlOTttetk6g27OQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PdoCXUNoED2D5viHW6Ny1RwX69Q+KYewLxH3cwN9eeGW9eTTw3e9nhr2doQZNINu6t0xer8UKiQoWWgEdaTc4j1QJA3kTKn13YguF5uYPGk4RRVugDkLD3rGbIAObl+ke0I7TGO5u0aa0a8Q37dd3/numJ8Q5KwfqqHvgClNWGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gEWd+Nq7; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752582925;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xCgiUZcwT6C9cPLH2UufX6wt62EgnsmD7bHGYbxxqSQ=;
	b=gEWd+Nq7ggvY762aJ7dy6rf4qHNVtZYFuzB0V6jeru28x5qIQHRjQPSNuIwqLtoMNcMd7d
	QPWdSKIYi1c/2uvbeXz71tdIoZUSeDd2ygEFn++82hg5UuwgFPh8kW/BMsiDtEo8hcL9Xt
	yifITOH2xcEMTG9zZsDBkRgpIjDBGNM=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-76-WhJq1xnwNICfvmFowoSl_A-1; Tue,
 15 Jul 2025 08:35:24 -0400
X-MC-Unique: WhJq1xnwNICfvmFowoSl_A-1
X-Mimecast-MFC-AGG-ID: WhJq1xnwNICfvmFowoSl_A_1752582923
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 16F7519560BA;
	Tue, 15 Jul 2025 12:35:23 +0000 (UTC)
Received: from bfoster (unknown [10.22.64.43])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A98B7180045B;
	Tue, 15 Jul 2025 12:35:21 +0000 (UTC)
Date: Tue, 15 Jul 2025 08:39:03 -0400
From: Brian Foster <bfoster@redhat.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
	linux-mm@kvack.org, hch@infradead.org, willy@infradead.org
Subject: Re: [PATCH v3 7/7] xfs: error tag to force zeroing on debug kernels
Message-ID: <aHZL55AcNnAD-uAn@bfoster>
References: <20250714204122.349582-1-bfoster@redhat.com>
 <20250714204122.349582-8-bfoster@redhat.com>
 <20250715052444.GP2672049@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250715052444.GP2672049@frogsfrogsfrogs>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On Mon, Jul 14, 2025 at 10:24:44PM -0700, Darrick J. Wong wrote:
> On Mon, Jul 14, 2025 at 04:41:22PM -0400, Brian Foster wrote:
> > iomap_zero_range() has to cover various corner cases that are
> > difficult to test on production kernels because it is used in fairly
> > limited use cases. For example, it is currently only used by XFS and
> > mostly only in partial block zeroing cases.
> > 
> > While it's possible to test most of these functional cases, we can
> > provide more robust test coverage by co-opting fallocate zero range
> > to invoke zeroing of the entire range instead of the more efficient
> > block punch/allocate sequence. Add an errortag to occasionally
> > invoke forced zeroing.
> > 
> > Signed-off-by: Brian Foster <bfoster@redhat.com>
> > Reviewed-by: Christoph Hellwig <hch@lst.de>
> > ---
> >  fs/xfs/libxfs/xfs_errortag.h |  4 +++-
> >  fs/xfs/xfs_error.c           |  3 +++
> >  fs/xfs/xfs_file.c            | 26 ++++++++++++++++++++------
> >  3 files changed, 26 insertions(+), 7 deletions(-)
> > 
...
> > diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
> > index 0b41b18debf3..c865f9555b77 100644
> > --- a/fs/xfs/xfs_file.c
> > +++ b/fs/xfs/xfs_file.c
> > @@ -27,6 +27,8 @@
> >  #include "xfs_file.h"
> >  #include "xfs_aops.h"
> >  #include "xfs_zone_alloc.h"
> > +#include "xfs_error.h"
> > +#include "xfs_errortag.h"
> >  
> >  #include <linux/dax.h>
> >  #include <linux/falloc.h>
> > @@ -1269,13 +1271,25 @@ xfs_falloc_zero_range(
> >  	if (error)
> >  		return error;
> >  
> > -	error = xfs_free_file_space(XFS_I(inode), offset, len, ac);
> > -	if (error)
> > -		return error;
> > +	/*
> > +	 * Zero range implements a full zeroing mechanism but is only used in
> > +	 * limited situations. It is more efficient to allocate unwritten
> > +	 * extents than to perform zeroing here, so use an errortag to randomly
> > +	 * force zeroing on DEBUG kernels for added test coverage.
> > +	 */
> > +	if (XFS_TEST_ERROR(false, XFS_I(inode)->i_mount,
> > +			   XFS_ERRTAG_FORCE_ZERO_RANGE)) {
> > +		error = xfs_zero_range(XFS_I(inode), offset, len, ac, NULL);
> 
> Isn't this basically the ultra slow version fallback version of
> FALLOC_FL_WRITE_ZEROES ?
> 

~/linux$ git grep FALLOC_FL_WRITE_ZEROES
~/linux$ 

IIRC write zeroes is intended to expose fast hardware (physical) zeroing
(i.e. zeroed written extents)..? If so, I suppose you could consider
this a fallback of sorts. I'm not sure what write zeroes is expected to
do in the unwritten extent case, whereas iomap zero range is happy to
skip those mappings unless they're already dirty in pagecache.

Regardless, the purpose of this patch is not to add support for physical
zeroing, but rather to increase test coverage for the additional code on
debug kernels because the production use case tends to be more limited.
This could easily be moved/applied to write zeroes if it makes sense in
the future and test infra grows support for it.

Brian

> --D
> 
> > +	} else {
> > +		error = xfs_free_file_space(XFS_I(inode), offset, len, ac);
> > +		if (error)
> > +			return error;
> >  
> > -	len = round_up(offset + len, blksize) - round_down(offset, blksize);
> > -	offset = round_down(offset, blksize);
> > -	error = xfs_alloc_file_space(XFS_I(inode), offset, len);
> > +		len = round_up(offset + len, blksize) -
> > +			round_down(offset, blksize);
> > +		offset = round_down(offset, blksize);
> > +		error = xfs_alloc_file_space(XFS_I(inode), offset, len);
> > +	}
> >  	if (error)
> >  		return error;
> >  	return xfs_falloc_setsize(file, new_size);
> > -- 
> > 2.50.0
> > 
> > 
> 


